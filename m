Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F75671834
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 10:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjARJwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 04:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjARJvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 04:51:43 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A2E8CE53;
        Wed, 18 Jan 2023 01:02:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 301CCCE1BB0;
        Wed, 18 Jan 2023 09:02:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2CD9C433D2;
        Wed, 18 Jan 2023 09:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674032549;
        bh=EuAgTB/iPW4vJ/ZRJE/nY3/BVUH2eT5SYitsWMD6MXk=;
        h=From:To:Cc:Subject:Date:From;
        b=KjM6elgrcBl+tAIy6K9MSWdfuHOUYGcdsn8MmZRkX8t86g5RRK1AFOIfidSqqG9+c
         12E26EhK9+ax/HMr2aFqjgbfSs65XfcbBtagFTZyyoV8K9NV63cTveHFvfXW8p81+Z
         feeB66PxqeptnbKJX6Cyd7ImBXCXYLS0ZCN92bQbRJ2GpRSwdDLhkOnXd5V02IJkjl
         qDirtVG2ogDjcOOCq64NNGLzkz0iZHoh3YlQ9vkJiaNzZMxEBaUMnL9MZWt6fM3ND/
         mLWnXfrgOVx+V0AWDSiGLLn8F9PEaCGE8xgaNqMKfAbPuPFkEKI76mviiP81NsEmND
         xOBJ1Nbr8+pUA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: s3c: fix s3c64xx_set_timer_source prototype
Date:   Wed, 18 Jan 2023 10:02:12 +0100
Message-Id: <20230118090224.2162863-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The prototype does not match the definition, as gcc-13 points
out:

arch/arm/mach-s3c/s3c64xx.c:169:13: error: conflicting types for 's3c64xx_set_timer_source' due to enum/integer mismatch; have 'void(unsigned int,  unsigned int)' [-Werror=enum-int-mismatch]
  169 | void __init s3c64xx_set_timer_source(unsigned int event, unsigned int source)
      |             ^~~~~~~~~~~~~~~~~~~~~~~~
In file included from arch/arm/mach-s3c/s3c64xx.c:50:
arch/arm/mach-s3c/s3c64xx.h:62:20: note: previous declaration of 's3c64xx_set_timer_source' with type 'void(enum s3c64xx_timer_mode,  enum s3c64xx_timer_mode)'
   62 | extern void __init s3c64xx_set_timer_source(enum s3c64xx_timer_mode event,
      |                    ^~~~~~~~~~~~~~~~~~~~~~~~

Fixes: 4280506ac9bb ("ARM: SAMSUNG: Move all platforms to new clocksource driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-s3c/s3c64xx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-s3c/s3c64xx.c b/arch/arm/mach-s3c/s3c64xx.c
index 32b1bc82d700..c5aa4d8ed8bd 100644
--- a/arch/arm/mach-s3c/s3c64xx.c
+++ b/arch/arm/mach-s3c/s3c64xx.c
@@ -166,7 +166,8 @@ static struct samsung_pwm_platform_data s3c64xx_pwm_variant = {
 	.tclk_mask	= (1 << 7) | (1 << 6) | (1 << 5),
 };
 
-void __init s3c64xx_set_timer_source(unsigned int event, unsigned int source)
+void __init s3c64xx_set_timer_source(enum s3c64xx_timer_mode event,
+				     enum s3c64xx_timer_mode source)
 {
 	s3c64xx_pwm_variant.output_mask = BIT(SAMSUNG_PWM_NUM) - 1;
 	s3c64xx_pwm_variant.output_mask &= ~(BIT(event) | BIT(source));
-- 
2.39.0

