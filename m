Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1A66B47A6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbjCJOxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbjCJOw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:52:28 -0500
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2305710D329;
        Fri, 10 Mar 2023 06:48:58 -0800 (PST)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-176b48a9a05so6138966fac.0;
        Fri, 10 Mar 2023 06:48:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bIEHlVrmVBM0unFLHI/kdGTckBhGv/jeyiKkRJBBR3A=;
        b=r/z2uKK4xJMiKP2iaOIzxpPFuO2jP2C/vQACZV/v57KtClANY08lwprgexpWbLZ0i7
         e8AstJ52vf96ww94zoHQDWxSeDNAp8rxmc/LhL6N2ywqW4WhPR8ezYxeUs/Y48SAS6pR
         Upc1rVGcjQ2fry4LPjY07fSK2JCxn91OOd7nAYHOJCTcaB9Xs8P5skHQ9+Q3TqOAZaVx
         z7OB3E3oOei1Ts9S5t2mrCPuIs6Hu8eZmUZq2JlG9YFVANYpGC6xkVafU7SdRm2Q1lB4
         O0XzSDHrrwpefKaPMCQJXAPvyQmVZ2SX+MzwDv8M913CWg45qBilx3ZjF45jtXGsDPi5
         oV7g==
X-Gm-Message-State: AO0yUKUxHpDu23R0W2fAQBWUe53yUMelFrWC87WyABU7PwKLQZaa66cA
        RLrBW0kFtd/x0lV8+CoTPw==
X-Google-Smtp-Source: AK7set/IS9GrXFd4RG+NEpTXnaefImj6w5XAH+i8hNCc/bshcut01X/HlqJgPkreh+GDTRd2zLI4jQ==
X-Received: by 2002:a05:6870:7011:b0:172:21eb:1c2d with SMTP id u17-20020a056870701100b0017221eb1c2dmr17207431oae.31.1678459697083;
        Fri, 10 Mar 2023 06:48:17 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w19-20020a4ae093000000b00524f381f681sm847024oos.27.2023.03.10.06.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:48:16 -0800 (PST)
Received: (nullmailer pid 1545110 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:23 -0000
From:   Rob Herring <robh@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: fsl: Use of_property_present() for testing DT property presence
Date:   Fri, 10 Mar 2023 08:47:23 -0600
Message-Id: <20230310144723.1545069-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is preferred to use typed property access functions (i.e.
of_property_read_<type> functions) rather than low-level
of_get_property/of_find_property functions for reading properties. As
part of this, convert of_get_property/of_find_property calls to the
recently added of_property_present() helper when we just want to test
for presence of a property and nothing more.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/soc/fsl/qbman/dpaa_sys.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/fsl/qbman/dpaa_sys.c b/drivers/soc/fsl/qbman/dpaa_sys.c
index 9dd8bb571dbc..33751450047e 100644
--- a/drivers/soc/fsl/qbman/dpaa_sys.c
+++ b/drivers/soc/fsl/qbman/dpaa_sys.c
@@ -39,8 +39,7 @@ int qbman_init_private_mem(struct device *dev, int idx, dma_addr_t *addr,
 {
 	struct device_node *mem_node;
 	struct reserved_mem *rmem;
-	struct property *prop;
-	int len, err;
+	int err;
 	__be32 *res_array;
 
 	mem_node = of_parse_phandle(dev->of_node, "memory-region", idx);
@@ -63,8 +62,9 @@ int qbman_init_private_mem(struct device *dev, int idx, dma_addr_t *addr,
 	 * This is needed because QBMan HW does not allow the base address/
 	 * size to be modified once set.
 	 */
-	prop = of_find_property(mem_node, "reg", &len);
-	if (!prop) {
+	if (!of_property_present(mem_node, "reg")) {
+		struct property *prop;
+
 		prop = devm_kzalloc(dev, sizeof(*prop), GFP_KERNEL);
 		if (!prop)
 			return -ENOMEM;
-- 
2.39.2

