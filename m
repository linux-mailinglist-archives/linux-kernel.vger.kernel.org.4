Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEFF60B464
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbiJXRky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233702AbiJXRjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:39:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D24F28713;
        Mon, 24 Oct 2022 09:15:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E8376148F;
        Mon, 24 Oct 2022 15:38:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51AEBC433C1;
        Mon, 24 Oct 2022 15:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666625915;
        bh=wux6EqMXii7mN6a3wT+F/1I+JfEHefiaJO7AH5NkY4o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kVBWFdKYvN82MUPfnNFWwU4y2CUonUB5+PGsLCJGV+LRA8z8UDgMhnOfdwVmEbGIE
         Rj7NQcn2O2byo+LXfPVki8qMjR1iVOOkeXNmjFEXN5mxgRRrjRE2Vde1EvgS3CoJvX
         nEOppM3E0R5JwYAK+QX6Lv8XpRoMJo8eN6hF0KS6y6YrpFLVN5YE2EbMTzMcCBMZEy
         fEmm2H7ocfQLY+E4MNletALqwJ12g91n3wU+GLOnyT2FtHU/Vmfhp30U52o8Qqu8uS
         BMTkr3aFOUT4yoIVVu9k6iZhdwHQ450aiU0NANWTHk+9obIxOG0JYDWQrOR1/lAT7Z
         UvcsCoMm9sStw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 06/10] ARM: omap2: smartreflex: remove on_init control
Date:   Mon, 24 Oct 2022 17:38:10 +0200
Message-Id: <20221024153814.254652-7-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221024153814.254652-1-arnd@kernel.org>
References: <20221024153814.254652-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Nothing calls omap_enable_smartreflex_on_init() any more, so it
does not need to be tracked either.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-omap2/pm.h          |  3 ---
 arch/arm/mach-omap2/sr_device.c   | 13 -------------
 drivers/soc/ti/smartreflex.c      |  4 ----
 include/linux/power/smartreflex.h |  3 ---
 4 files changed, 23 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 80e84ae66aee..f523ca03161f 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -110,14 +110,11 @@ extern u16 pm44xx_errata;
 
 #ifdef CONFIG_POWER_AVS_OMAP
 extern int omap_devinit_smartreflex(void);
-extern void omap_enable_smartreflex_on_init(void);
 #else
 static inline int omap_devinit_smartreflex(void)
 {
 	return -EINVAL;
 }
-
-static inline void omap_enable_smartreflex_on_init(void) {}
 #endif
 
 #ifdef CONFIG_TWL4030_CORE
diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
index db672cf19a51..d2133423b0c9 100644
--- a/arch/arm/mach-omap2/sr_device.c
+++ b/arch/arm/mach-omap2/sr_device.c
@@ -26,8 +26,6 @@
 #include "control.h"
 #include "pm.h"
 
-static bool sr_enable_on_init;
-
 /* Read EFUSE values from control registers for OMAP3430 */
 static void __init sr_set_nvalues(struct omap_volt_data *volt_data,
 				struct omap_sr_data *sr_data)
@@ -144,8 +142,6 @@ static int __init sr_init_by_name(const char *name, const char *voltdm)
 
 	sr_set_nvalues(volt_data, sr_data);
 
-	sr_data->enable_on_init = sr_enable_on_init;
-
 exit:
 	i++;
 
@@ -173,15 +169,6 @@ static int __init sr_dev_init(struct omap_hwmod *oh, void *user)
 }
 #endif
 
-/*
- * API to be called from board files to enable smartreflex
- * autocompensation at init.
- */
-void __init omap_enable_smartreflex_on_init(void)
-{
-	sr_enable_on_init = true;
-}
-
 static const char * const omap4_sr_instances[] = {
 	"mpu",
 	"iva",
diff --git a/drivers/soc/ti/smartreflex.c b/drivers/soc/ti/smartreflex.c
index ad2bb72e640c..2108232d6fa4 100644
--- a/drivers/soc/ti/smartreflex.c
+++ b/drivers/soc/ti/smartreflex.c
@@ -198,7 +198,6 @@ static void sr_stop_vddautocomp(struct omap_sr *sr)
  */
 static int sr_late_init(struct omap_sr *sr_info)
 {
-	struct omap_sr_data *pdata = sr_info->pdev->dev.platform_data;
 	int ret = 0;
 
 	if (sr_class->notify && sr_class->notify_flags && sr_info->irq) {
@@ -209,9 +208,6 @@ static int sr_late_init(struct omap_sr *sr_info)
 		disable_irq(sr_info->irq);
 	}
 
-	if (pdata && pdata->enable_on_init)
-		sr_start_vddautocomp(sr_info);
-
 	return ret;
 
 error:
diff --git a/include/linux/power/smartreflex.h b/include/linux/power/smartreflex.h
index 167b9b040091..3a2c79dfc1ff 100644
--- a/include/linux/power/smartreflex.h
+++ b/include/linux/power/smartreflex.h
@@ -273,8 +273,6 @@ struct omap_sr_nvalue_table {
  * @senn_avgweight	SENNAVGWEIGHT value of the sr AVGWEIGHT register
  * @senp_avgweight	SENPAVGWEIGHT value of the sr AVGWEIGHT register
  * @nvalue_count:	Number of distinct nvalues in the nvalue table
- * @enable_on_init:	whether this sr module needs to enabled at
- *			boot up or not.
  * @nvalue_table:	table containing the  efuse offsets and nvalues
  *			corresponding to them.
  * @voltdm:		Pointer to the voltage domain associated with the SR
@@ -290,7 +288,6 @@ struct omap_sr_data {
 	u32				senn_avgweight;
 	u32				senp_avgweight;
 	int				nvalue_count;
-	bool				enable_on_init;
 	struct omap_sr_nvalue_table	*nvalue_table;
 	struct voltagedomain		*voltdm;
 };
-- 
2.29.2

