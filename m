Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86986DBB61
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 16:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjDHOCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 10:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjDHOCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 10:02:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE582EF96
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 07:02:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5656861596
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 14:02:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92FCCC433A1;
        Sat,  8 Apr 2023 14:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680962548;
        bh=Rp++EnLZvDWAyB3q+nRICzltKHVA/IpPx8P+WV9axbQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d63wSgO8NZTCjjxPXd+AmDEIQe+gyDYiMgcKB8PSi4WpJqpieDf5zMXaM0MXknU3H
         hNvoseYGoWP+XqUj9z05uG/IRYTB6bjtf++dRdJ0QWv9zcxbCiE3PIFrYxmI8pHKAK
         xEQt3+R4OuIta+Dtbh2cSfbrfRQTdau7nhXXoFCFrqRFh3FDBb0fZbH/jTvWF6Sn6u
         po2epwl+rSDUnJ62BpssBUkJ+s4DGZ3YbeQ8q+xOtkBkhs8PWLuXVyAmRNtfcXsh9N
         rAVMWtCNFp8jq7mZDr7D2FLJoAuhLu/djyHxdS/+tFCP03/vCA4rlxOH3xf93knNFp
         dLxyieFTLfNYw==
Received: by pali.im (Postfix)
        id 66F7D20A8; Sat,  8 Apr 2023 16:02:26 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 05/13] powerpc/85xx: Remove #ifdefs CONFIG_PPC_I8259 in mpc85xx_ds
Date:   Sat,  8 Apr 2023 16:01:14 +0200
Message-Id: <20230408140122.25293-6-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230408140122.25293-1-pali@kernel.org>
References: <20230408140122.25293-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@csgroup.eu>

All necessary items are declared all the time, no need to use
a #ifdef CONFIG_PPC_I8259.

Refactor CONFIG_PPC_I8259 actions into a dedicated init function.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/powerpc/platforms/85xx/mpc85xx_ds.c | 37 +++++++++++++-----------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index d8d13438e18f..4ae300e76c2d 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -34,7 +34,6 @@
 
 #include "mpc85xx.h"
 
-#ifdef CONFIG_PPC_I8259
 static void mpc85xx_8259_cascade(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
@@ -45,29 +44,16 @@ static void mpc85xx_8259_cascade(struct irq_desc *desc)
 	}
 	chip->irq_eoi(&desc->irq_data);
 }
-#endif	/* CONFIG_PPC_I8259 */
 
-void __init mpc85xx_ds_pic_init(void)
+static void __init mpc85xx_8259_init(void)
 {
-	struct mpic *mpic;
-	int flags = MPIC_BIG_ENDIAN | MPIC_SINGLE_DEST_CPU;
-#ifdef CONFIG_PPC_I8259
 	struct device_node *np;
 	struct device_node *cascade_node = NULL;
 	int cascade_irq;
-#endif
 
-	if (of_machine_is_compatible("fsl,MPC8572DS-CAMP"))
-		flags |= MPIC_NO_RESET;
-
-	mpic = mpic_alloc(NULL, 0, flags, 0, 256, " OpenPIC  ");
-
-	if (WARN_ON(!mpic))
+	if (!IS_ENABLED(CONFIG_PPC_I8259))
 		return;
 
-	mpic_init(mpic);
-
-#ifdef CONFIG_PPC_I8259
 	/* Initialize the i8259 controller */
 	for_each_node_by_type(np, "interrupt-controller")
 	    if (of_device_is_compatible(np, "chrp,iic")) {
@@ -92,7 +78,24 @@ void __init mpc85xx_ds_pic_init(void)
 	of_node_put(cascade_node);
 
 	irq_set_chained_handler(cascade_irq, mpc85xx_8259_cascade);
-#endif	/* CONFIG_PPC_I8259 */
+}
+
+void __init mpc85xx_ds_pic_init(void)
+{
+	struct mpic *mpic;
+	int flags = MPIC_BIG_ENDIAN | MPIC_SINGLE_DEST_CPU;
+
+	if (of_machine_is_compatible("fsl,MPC8572DS-CAMP"))
+		flags |= MPIC_NO_RESET;
+
+	mpic = mpic_alloc(NULL, 0, flags, 0, 256, " OpenPIC  ");
+
+	if (WARN_ON(!mpic))
+		return;
+
+	mpic_init(mpic);
+
+	mpc85xx_8259_init();
 }
 
 /*
-- 
2.20.1

