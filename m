Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB6E63B304
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 21:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbiK1UZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 15:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233956AbiK1UY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 15:24:58 -0500
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9941A385;
        Mon, 28 Nov 2022 12:24:56 -0800 (PST)
Received: by mail-oi1-f182.google.com with SMTP id v82so12910081oib.4;
        Mon, 28 Nov 2022 12:24:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4pTJFoDZB1wvweEpaxwGsowfmcCurICeVU/vO+CpfSo=;
        b=OhFC01nC9sICvP3N4wxLeshlZ4sFfi6NBX1uOIkI56Meid1vtyDyR3xHFOv8gZrzcW
         GVa12MdHuWkJ8pGXQT5ojslMNdNJbQDBdFxK1JUwj3cmHCZ9hGPsBs1ayEh2z/lCt7hk
         89VYcRgXNCz+d1CbARCdcfFpDZ3ZtEKc+vY9hM5OVLxtiiIADrAMWoIf6zu2STuHp/SA
         VABmFNZgXBRaBbXWrU7WBzxJffglCjTAxM07diDVboBkKge8WpisGdBUeGi8G2NzW+94
         rZxqiWlpF05F6DfYOfvAV4PqV5n8SA5GDIuzqr2qAWaY4Z40AqBOwWdFdZ8Wv7Xdo2V0
         hd/Q==
X-Gm-Message-State: ANoB5pmKax7iYSJlBawTujbzb0uN1T3FT5lghTOXQzpZruUcsPBVgga+
        ZTYyLcPDy4fi0Z6IlMPQf9E5cY3USQ==
X-Google-Smtp-Source: AA0mqf7RvZ1c16uUZ1Pip/PBJJw4yUY+Vb0UeqhO/9630UT5XDlH7IF+bCU95XKKDMRAX4hOXmapfQ==
X-Received: by 2002:a54:4415:0:b0:35a:83c5:392e with SMTP id k21-20020a544415000000b0035a83c5392emr15573196oiw.146.1669667095760;
        Mon, 28 Nov 2022 12:24:55 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i38-20020a056870892600b00142fa439ee5sm6345380oao.39.2022.11.28.12.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 12:24:55 -0800 (PST)
Received: (nullmailer pid 1412312 invoked by uid 1000);
        Mon, 28 Nov 2022 20:24:54 -0000
From:   Rob Herring <robh@kernel.org>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Peter Maydell <peter.maydell@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] of/kexec: Fix reading 32-bit "linux,initrd-{start,end}" values
Date:   Mon, 28 Nov 2022 14:24:39 -0600
Message-Id: <20221128202440.1411895-1-robh@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"linux,initrd-start" and "linux,initrd-end" can be 32-bit values even on
a 64-bit platform. Ideally, the size should be based on
'#address-cells', but that has never been enforced in the kernel's FDT
boot parsing code (early_init_dt_check_for_initrd()). Bootloader
behavior is known to vary. For example, kexec always writes these as
64-bit.

Use of_read_number() to mirror the early_init_dt_check_for_initrd()
code.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/kexec.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index e6c01db393f9..f26d2ba8a371 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -281,7 +281,7 @@ void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
 				   const char *cmdline, size_t extra_fdt_size)
 {
 	void *fdt;
-	int ret, chosen_node;
+	int ret, chosen_node, len;
 	const void *prop;
 	size_t fdt_size;
 
@@ -324,19 +324,19 @@ void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
 		goto out;
 
 	/* Did we boot using an initrd? */
-	prop = fdt_getprop(fdt, chosen_node, "linux,initrd-start", NULL);
+	prop = fdt_getprop(fdt, chosen_node, "linux,initrd-start", &len);
 	if (prop) {
 		u64 tmp_start, tmp_end, tmp_size;
 
-		tmp_start = fdt64_to_cpu(*((const fdt64_t *) prop));
+		tmp_start = of_read_number(prop, len / 4);
 
-		prop = fdt_getprop(fdt, chosen_node, "linux,initrd-end", NULL);
+		prop = fdt_getprop(fdt, chosen_node, "linux,initrd-end", &len);
 		if (!prop) {
 			ret = -EINVAL;
 			goto out;
 		}
 
-		tmp_end = fdt64_to_cpu(*((const fdt64_t *) prop));
+		tmp_end = of_read_number(prop, len / 4);
 
 		/*
 		 * kexec reserves exact initrd size, while firmware may
-- 
2.35.1

