Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD784655B3B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 22:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbiLXVQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 16:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiLXVQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 16:16:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683DCA447
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 13:16:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 18A77B8016A
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 21:16:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5E7C433F0;
        Sat, 24 Dec 2022 21:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671916595;
        bh=ySpGEUFcvdEqE4LGPb4c2lY8Vn2te6xLgnS8OF0nmEM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IHEA5/atfot9gZy3MSrVLjUZNV1u4eLIfyMJ4VTqUwwR6L0CCX58gPQKK01m7lMKG
         McfzfAATsX64wt37mCLGjeJrFzNnPC74XU+cTM1VYvLdcvbYy5huyzgo+KHYfwMyE+
         1w8/DYuDLYZLeGWulVkzqV/hAey/Ru0ICKka7uQ5dsqeo+eN1VNpgSWHo7LHO63x+6
         aT5HwidY+o6KZ/75N+q+uf2ZgVJaeOKx5lbLev9JODTwK1VKmP6W4S87ob9r4urd0a
         vT86eYmdykyDQIz2v/K2QC3MrZxsbFnDED0+JMLd+n4aTBfKW30P4MPgBO5hK0ZjLP
         WoTunWbWsXDmQ==
Received: by pali.im (Postfix)
        id 26112720; Sat, 24 Dec 2022 22:16:35 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Scott Wood <oss@buserror.net>, Sinan Akman <sinan@writeme.com>,
        Martin Kennedy <hurricos@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/8] powerpc/85xx: p2020: Move i8259 code into own function
Date:   Sat, 24 Dec 2022 22:14:21 +0100
Message-Id: <20221224211425.14983-5-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221224211425.14983-1-pali@kernel.org>
References: <20221224211425.14983-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Splits mpic and i8259 initialization codes into separate functions.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/powerpc/platforms/85xx/p2020.c | 37 ++++++++++++++++-------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/p2020.c b/arch/powerpc/platforms/85xx/p2020.c
index d65d4c88ac47..b8584bf307b0 100644
--- a/arch/powerpc/platforms/85xx/p2020.c
+++ b/arch/powerpc/platforms/85xx/p2020.c
@@ -45,6 +45,7 @@
 #ifdef CONFIG_MPC85xx_DS
 
 #ifdef CONFIG_PPC_I8259
+
 static void mpc85xx_8259_cascade(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
@@ -55,27 +56,13 @@ static void mpc85xx_8259_cascade(struct irq_desc *desc)
 	}
 	chip->irq_eoi(&desc->irq_data);
 }
-#endif	/* CONFIG_PPC_I8259 */
 
-static void __init mpc85xx_ds_pic_init(void)
+static void __init mpc85xx_8259_init(void)
 {
-	struct mpic *mpic;
-#ifdef CONFIG_PPC_I8259
 	struct device_node *np;
 	struct device_node *cascade_node = NULL;
 	int cascade_irq;
-#endif
-
-	mpic = mpic_alloc(NULL, 0,
-		  MPIC_BIG_ENDIAN |
-		  MPIC_SINGLE_DEST_CPU,
-		0, 256, " OpenPIC  ");
-
-	BUG_ON(mpic == NULL);
-	mpic_init(mpic);
 
-#ifdef CONFIG_PPC_I8259
-	/* Initialize the i8259 controller */
 	for_each_node_by_type(np, "interrupt-controller")
 	    if (of_device_is_compatible(np, "chrp,iic")) {
 		cascade_node = np;
@@ -93,13 +80,31 @@ static void __init mpc85xx_ds_pic_init(void)
 		return;
 	}
 
-	DBG("mpc85xxds: cascade mapped to irq %d\n", cascade_irq);
+	DBG("i8259: cascade mapped to irq %d\n", cascade_irq);
 
 	i8259_init(cascade_node, 0);
 	of_node_put(cascade_node);
 
 	irq_set_chained_handler(cascade_irq, mpc85xx_8259_cascade);
+}
+
 #endif	/* CONFIG_PPC_I8259 */
+
+static void __init mpc85xx_ds_pic_init(void)
+{
+	struct mpic *mpic;
+
+	mpic = mpic_alloc(NULL, 0,
+		  MPIC_BIG_ENDIAN |
+		  MPIC_SINGLE_DEST_CPU,
+		0, 256, " OpenPIC  ");
+
+	BUG_ON(mpic == NULL);
+	mpic_init(mpic);
+
+#ifdef CONFIG_PPC_I8259
+	mpc85xx_8259_init();
+#endif
 }
 
 #ifdef CONFIG_PCI
-- 
2.20.1

