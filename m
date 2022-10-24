Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C9260BB30
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 22:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234898AbiJXUtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 16:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235233AbiJXUtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 16:49:04 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90DA250282;
        Mon, 24 Oct 2022 11:56:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9095DCE11C4;
        Mon, 24 Oct 2022 15:38:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FBC5C43470;
        Mon, 24 Oct 2022 15:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666625913;
        bh=L8c5GKayylADfUAdeL37/p0TLa+9ODsAQQCP/0C+a3Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I4swKEqdMKks6DlQ3eZsx+gxQvCUyIlLLYQoSdM129IBmuRlJ8/6nQ5ewds45lv7C
         CS5yiQ3wSv/cwFd8l2pp3RdxITgaYhESS1mobuFPvSF6gRzewB48TD7gpIFHSokb3L
         zd4eLbWZcc1yXcyYbUL0iYVOgJcGcKMGKrjR3fJP9+k6xKp7yg2ldVJwN5634n/+BM
         OVxNSE5gWKtUJLz+9n8Cvyna0P4vDCrnNgEs3GpMIl1c8AdexxxHkI/EUUhyjfmao9
         zUAsqHsbBHF3Qw4wWJpujZzYV0w971fFEnR1IfAxfQgwWYCs9rWSXZTMaBMiO1lTH+
         vNSNf9R+6Ha7w==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 05/10] ARM: omap2: remove APLL control
Date:   Mon, 24 Oct 2022 17:38:09 +0200
Message-Id: <20221024153814.254652-6-arnd@kernel.org>
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

These functions have no callers and can just be removed.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-omap2/cm2xxx.c      | 97 -------------------------------
 arch/arm/mach-omap2/cm2xxx.h      |  5 --
 arch/arm/mach-omap2/cm2xxx_3xxx.h |  5 --
 3 files changed, 107 deletions(-)

diff --git a/arch/arm/mach-omap2/cm2xxx.c b/arch/arm/mach-omap2/cm2xxx.c
index 0827acb60584..17833e0f22f8 100644
--- a/arch/arm/mach-omap2/cm2xxx.c
+++ b/arch/arm/mach-omap2/cm2xxx.c
@@ -95,103 +95,6 @@ void omap2xxx_cm_set_dpll_auto_low_power_stop(void)
 	_omap2xxx_set_dpll_autoidle(DPLL_AUTOIDLE_DISABLE);
 }
 
-/*
- * APLL control
- */
-
-static void _omap2xxx_set_apll_autoidle(u8 m, u32 mask)
-{
-	u32 v;
-
-	v = omap2_cm_read_mod_reg(PLL_MOD, CM_AUTOIDLE);
-	v &= ~mask;
-	v |= m << __ffs(mask);
-	omap2_cm_write_mod_reg(v, PLL_MOD, CM_AUTOIDLE);
-}
-
-void omap2xxx_cm_set_apll54_disable_autoidle(void)
-{
-	_omap2xxx_set_apll_autoidle(OMAP2XXX_APLL_AUTOIDLE_LOW_POWER_STOP,
-				    OMAP24XX_AUTO_54M_MASK);
-}
-
-void omap2xxx_cm_set_apll54_auto_low_power_stop(void)
-{
-	_omap2xxx_set_apll_autoidle(OMAP2XXX_APLL_AUTOIDLE_DISABLE,
-				    OMAP24XX_AUTO_54M_MASK);
-}
-
-void omap2xxx_cm_set_apll96_disable_autoidle(void)
-{
-	_omap2xxx_set_apll_autoidle(OMAP2XXX_APLL_AUTOIDLE_LOW_POWER_STOP,
-				    OMAP24XX_AUTO_96M_MASK);
-}
-
-void omap2xxx_cm_set_apll96_auto_low_power_stop(void)
-{
-	_omap2xxx_set_apll_autoidle(OMAP2XXX_APLL_AUTOIDLE_DISABLE,
-				    OMAP24XX_AUTO_96M_MASK);
-}
-
-/* Enable an APLL if off */
-static int _omap2xxx_apll_enable(u8 enable_bit, u8 status_bit)
-{
-	u32 v, m;
-
-	m = EN_APLL_LOCKED << enable_bit;
-
-	v = omap2_cm_read_mod_reg(PLL_MOD, CM_CLKEN);
-	if (v & m)
-		return 0;   /* apll already enabled */
-
-	v |= m;
-	omap2_cm_write_mod_reg(v, PLL_MOD, CM_CLKEN);
-
-	omap2xxx_cm_wait_module_ready(0, PLL_MOD, 1, status_bit);
-
-	/*
-	 * REVISIT: Should we return an error code if
-	 * omap2xxx_cm_wait_module_ready() fails?
-	 */
-	return 0;
-}
-
-/* Stop APLL */
-static void _omap2xxx_apll_disable(u8 enable_bit)
-{
-	u32 v;
-
-	v = omap2_cm_read_mod_reg(PLL_MOD, CM_CLKEN);
-	v &= ~(EN_APLL_LOCKED << enable_bit);
-	omap2_cm_write_mod_reg(v, PLL_MOD, CM_CLKEN);
-}
-
-/* Enable an APLL if off */
-int omap2xxx_cm_apll54_enable(void)
-{
-	return _omap2xxx_apll_enable(OMAP24XX_EN_54M_PLL_SHIFT,
-				     OMAP24XX_ST_54M_APLL_SHIFT);
-}
-
-/* Enable an APLL if off */
-int omap2xxx_cm_apll96_enable(void)
-{
-	return _omap2xxx_apll_enable(OMAP24XX_EN_96M_PLL_SHIFT,
-				     OMAP24XX_ST_96M_APLL_SHIFT);
-}
-
-/* Stop APLL */
-void omap2xxx_cm_apll54_disable(void)
-{
-	_omap2xxx_apll_disable(OMAP24XX_EN_54M_PLL_SHIFT);
-}
-
-/* Stop APLL */
-void omap2xxx_cm_apll96_disable(void)
-{
-	_omap2xxx_apll_disable(OMAP24XX_EN_96M_PLL_SHIFT);
-}
-
 /**
  * omap2xxx_cm_split_idlest_reg - split CM_IDLEST reg addr into its components
  * @idlest_reg: CM_IDLEST* virtual address
diff --git a/arch/arm/mach-omap2/cm2xxx.h b/arch/arm/mach-omap2/cm2xxx.h
index 004016d7459e..ee0cb40691b2 100644
--- a/arch/arm/mach-omap2/cm2xxx.h
+++ b/arch/arm/mach-omap2/cm2xxx.h
@@ -46,11 +46,6 @@
 extern void omap2xxx_cm_set_dpll_disable_autoidle(void);
 extern void omap2xxx_cm_set_dpll_auto_low_power_stop(void);
 
-extern void omap2xxx_cm_set_apll54_disable_autoidle(void);
-extern void omap2xxx_cm_set_apll54_auto_low_power_stop(void);
-extern void omap2xxx_cm_set_apll96_disable_autoidle(void);
-extern void omap2xxx_cm_set_apll96_auto_low_power_stop(void);
-
 int omap2xxx_cm_wait_module_ready(u8 part, s16 prcm_mod, u16 idlest_id,
 				  u8 idlest_shift);
 extern int omap2xxx_cm_fclks_active(void);
diff --git a/arch/arm/mach-omap2/cm2xxx_3xxx.h b/arch/arm/mach-omap2/cm2xxx_3xxx.h
index 70944b94cc09..6dfc09383160 100644
--- a/arch/arm/mach-omap2/cm2xxx_3xxx.h
+++ b/arch/arm/mach-omap2/cm2xxx_3xxx.h
@@ -93,11 +93,6 @@ static inline u32 omap2_cm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx)
 	return omap2_cm_rmw_mod_reg_bits(bits, 0x0, module, idx);
 }
 
-extern int omap2xxx_cm_apll54_enable(void);
-extern void omap2xxx_cm_apll54_disable(void);
-extern int omap2xxx_cm_apll96_enable(void);
-extern void omap2xxx_cm_apll96_disable(void);
-
 #endif
 
 /* CM register bits shared between 24XX and 3430 */
-- 
2.29.2

