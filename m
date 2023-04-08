Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10EA6DBB5D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 16:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjDHOCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 10:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjDHOCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 10:02:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDC8EF92
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 07:02:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C00886158D
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 14:02:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F25CC4339B;
        Sat,  8 Apr 2023 14:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680962548;
        bh=j6cuKCL8daQ4YjtlzqbN7C113FAR+BvOj+ptz+yrr+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BX/RaH8wjzhP+zDsQEIBv8GZ4xZ7X4mioXuKhKe09FxtjmZw1MbKvEe+4cJX11164
         zT8nNldgw3qrmW2ILjuldN3n4yIg1Q3BqREGSUOziM2poySlU/asXG2dRboejZY7Xb
         ItUV3ybPI4TzXgMucWgjWKwgCCegPlgbxmoT4JeqqI2NvjQQ4Q7oO3YHYi9v3PTRkd
         uV4Cfn8CnygHmlr+ElnS6fD8+addmvf5qzPVHzE82H9BDNRNvhPplCbdZ/lBWbb6ZU
         LH1fKgYzYnbmiEKcwl1N7xXVLrzKkQ+/SRTJ8m52a0cGCptW4L8rG8STOscdKXd90t
         tNDwrcynHh5WA==
Received: by pali.im (Postfix)
        id A90771BE4; Sat,  8 Apr 2023 16:02:25 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 01/13] powerpc/85xx: Remove DBG() macro
Date:   Sat,  8 Apr 2023 16:01:10 +0200
Message-Id: <20230408140122.25293-2-pali@kernel.org>
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

DBG() macro is defined at three places while used only
one time at one place.

Replace its only use by a pr_debug() and remove the macro.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/powerpc/platforms/85xx/mpc85xx_ds.c  | 10 +---------
 arch/powerpc/platforms/85xx/mpc85xx_mds.c |  7 -------
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c |  9 ---------
 3 files changed, 1 insertion(+), 25 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index c474da3eeea8..25edfe1b8ae1 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -34,14 +34,6 @@
 
 #include "mpc85xx.h"
 
-#undef DEBUG
-
-#ifdef DEBUG
-#define DBG(fmt, args...) printk(KERN_ERR "%s: " fmt, __func__, ## args)
-#else
-#define DBG(fmt, args...)
-#endif
-
 #ifdef CONFIG_PPC_I8259
 static void mpc85xx_8259_cascade(struct irq_desc *desc)
 {
@@ -98,7 +90,7 @@ void __init mpc85xx_ds_pic_init(void)
 		return;
 	}
 
-	DBG("mpc85xxds: cascade mapped to irq %d\n", cascade_irq);
+	pr_debug("mpc85xxds: cascade mapped to irq %d\n", cascade_irq);
 
 	i8259_init(cascade_node, 0);
 	of_node_put(cascade_node);
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index 28a04928250f..0546f19416c2 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -49,13 +49,6 @@
 
 #include "mpc85xx.h"
 
-#undef DEBUG
-#ifdef DEBUG
-#define DBG(fmt...) udbg_printf(fmt)
-#else
-#define DBG(fmt...)
-#endif
-
 #if IS_BUILTIN(CONFIG_PHYLIB)
 
 #define MV88E1111_SCR	0x10
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
index aa24793ad25c..acc4145adcf7 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -29,15 +29,6 @@
 
 #include "mpc85xx.h"
 
-#undef DEBUG
-
-#ifdef DEBUG
-#define DBG(fmt, args...) printk(KERN_ERR "%s: " fmt, __func__, ## args)
-#else
-#define DBG(fmt, args...)
-#endif
-
-
 void __init mpc85xx_rdb_pic_init(void)
 {
 	struct mpic *mpic;
-- 
2.20.1

