Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229A060BE97
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 01:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiJXXbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 19:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiJXXaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 19:30:55 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC676147D03;
        Mon, 24 Oct 2022 14:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1666644742; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vr7lNDSbGtSjiNdf7yERkT0vvFH6fFGxF2sxGNjzC/g=;
        b=B2abmIY22GUeSjPRTWzhdM/9vbX7QdDB9z6ewKCRCOvLaLS1P/CDnidjVpsxGAFWB9KLs7
        JPgBNcc5ZPDngtVnNwFl8YpWba+3xfg8Dz3jVqpmCK2cv1bSPBhPG8z3kixHrN2vdJ4vc9
        jZ+a11nSsRwYNTUVc3yMBQxX/K2NLcQ=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     od@opendingux.net, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 4/5] pwm: jz4740: Depend on MACH_INGENIC instead of MIPS
Date:   Mon, 24 Oct 2022 21:52:12 +0100
Message-Id: <20221024205213.327001-5-paul@crapouillou.net>
In-Reply-To: <20221024205213.327001-1-paul@crapouillou.net>
References: <20221024205213.327001-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MACH_INGENIC Kconfig option will be selected when building a kernel
targeting Ingenic SoCs, but also when compiling a generic MIPS kernel
that happens to support Ingenic SoCs.

Therefore, if MACH_INGENIC is not set, we know that we're not even
trying to build a generic kernel that supports these SoCs, and we can
hide the options to compile the SoC-specific drivers.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/pwm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 1fe420a45f91..cb623d0702f6 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -282,7 +282,7 @@ config PWM_IQS620A
 
 config PWM_JZ4740
 	tristate "Ingenic JZ47xx PWM support"
-	depends on MIPS || COMPILE_TEST
+	depends on MACH_INGENIC || COMPILE_TEST
 	depends on COMMON_CLK && OF
 	select MFD_SYSCON
 	help
-- 
2.35.1

