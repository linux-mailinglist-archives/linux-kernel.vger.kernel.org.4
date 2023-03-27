Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549236CB1D2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 00:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjC0Wbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 18:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjC0Wbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 18:31:31 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1EB3AAB
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 15:31:18 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id cm7-20020a056830650700b006a11f365d13so4103286otb.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 15:31:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679956277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q6sWdgKPnlynXN7gaVy9ScKNaaCRkPnaDWuj0f2wDv8=;
        b=gS07p3Pfmtg8W9zeVqlWMjy93lffHWadZrM6CrT/H1QzoiM0SlcUgNrXmh+Xhtug+p
         IBvkvLpR1XYLQpL+qnELmtDnxBksndTjOgY49SW0C1LdLGEMTlD77XrZWKrKw64IKAvX
         l8THv1gceb+03fIYDZ1vxJj7jDcHut/MQW0mAlgmhcyUAX9fl5dQWWdmecEtBV/9zqGp
         ccyu9ZYCzshBgtANPEkYG5J5qYgtkWe+54zdgKBHdvbdV8/0HbwfFd0qTr1BcihP8sDm
         esfWhfi2oAGC1177oH5Cp7t3Ne/4Cgn+I1mCrHh4j39if69kXBfDsfVloItBK8wLIStb
         g2rw==
X-Gm-Message-State: AO0yUKV9F3pMG79D2vQhbmHkCpzTkgBS9pDi8WLMeX3Kd7zJgcXPNDUi
        C777AHL/4kJz0R48dZYdlYES3BelhQ==
X-Google-Smtp-Source: AK7set/BJI9Gqu3ZDBey3gtjqeUt7xNRV0EjKAp+aGF1HEr3KHutABypNwUVuzbQaGDE8j6u8uu9gA==
X-Received: by 2002:a9d:7d14:0:b0:688:4670:e964 with SMTP id v20-20020a9d7d14000000b006884670e964mr6595361otn.27.1679956277420;
        Mon, 27 Mar 2023 15:31:17 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id dp7-20020a0568300e8700b0069d602841e7sm12160245otb.72.2023.03.27.15.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 15:31:16 -0700 (PDT)
Received: (nullmailer pid 820514 invoked by uid 1000);
        Mon, 27 Mar 2023 22:31:15 -0000
From:   Rob Herring <robh@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: usbgecko: Use of_iomap()
Date:   Mon, 27 Mar 2023 17:31:09 -0500
Message-Id: <20230327223109.820381-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace of_get_property()+of_translate_address()+ioremap() with a call
to of_iomap() which does all those steps.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../platforms/embedded6xx/usbgecko_udbg.c     | 20 +------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c b/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c
index e02bdabf358c..221577f32b01 100644
--- a/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c
+++ b/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c
@@ -192,24 +192,6 @@ static int ug_udbg_getc_poll(void)
 	return ug_getc();
 }
 
-/*
- * Retrieves and prepares the virtual address needed to access the hardware.
- */
-static void __iomem *__init ug_udbg_setup_exi_io_base(struct device_node *np)
-{
-	void __iomem *exi_io_base = NULL;
-	phys_addr_t paddr;
-	const unsigned int *reg;
-
-	reg = of_get_property(np, "reg", NULL);
-	if (reg) {
-		paddr = of_translate_address(np, reg);
-		if (paddr)
-			exi_io_base = ioremap(paddr, reg[1]);
-	}
-	return exi_io_base;
-}
-
 /*
  * Checks if a USB Gecko adapter is inserted in any memory card slot.
  */
@@ -246,7 +228,7 @@ void __init ug_udbg_init(void)
 		goto out;
 	}
 
-	exi_io_base = ug_udbg_setup_exi_io_base(np);
+	exi_io_base = of_iomap(np, 0);
 	if (!exi_io_base) {
 		udbg_printf("%s: failed to setup EXI io base\n", __func__);
 		goto done;
-- 
2.39.2

