Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713C9729274
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240085AbjFIIQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240079AbjFIIQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:16:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FBE1FEC;
        Fri,  9 Jun 2023 01:16:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E83561300;
        Fri,  9 Jun 2023 08:16:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 032BBC433D2;
        Fri,  9 Jun 2023 08:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686298566;
        bh=fhq7UqggYiVg/1COUBVntIvsMJLXIEfwBDhAv2lnM2Y=;
        h=From:To:Cc:Subject:Date:From;
        b=G28YEgrgn2lu1p5R3l5ckjxag/p3SQF3AL/dQ4H0P6yHYvymEjeqjKHwgbwZFshiN
         +DXRcLNePGWkV2wjJrnBHW0MM2SjvfQviBwCjzKym9TF3W1fFrDGOlsAIZf0oxG0X2
         JduFSfbl4efpACPpq+1j3w3mxIgKZSwNXjF0npmmIhimGZ0oHhqqgwU0SUIuc6aqUY
         RpTDqVcnOHAALa+eJ96oS6nDhDofPv2I180Bg2Cgcr3lOvUH2USV88C7EKjrE1mQbF
         ZxENFHAnMcnAEwFfUFxp90ulbJWi+u/dGJqYWdRIYk8M4PBWi/UKr2msYHnMTexwws
         EfQr+wvYaOZzQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: samsung: add CONFIG_OF dependency
Date:   Fri,  9 Jun 2023 10:15:49 +0200
Message-Id: <20230609081559.915867-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When CONFIG_OF is disabled, build testing on x86 runs into a couple of
objtool warnings from functions that unconditionally call panic() but
have no __noreturn annotation:

vmlinux.o: warning: objtool: exynos3250_cmu_isp_probe+0x17: samsung_cmu_register_one() is missing a __noreturn annotation
vmlinux.o: warning: objtool: exynos7885_cmu_probe+0x16: exynos_arm64_register_cmu() is missing a __noreturn annotation
vmlinux.o: warning: objtool: exynos850_cmu_probe+0x16: exynos_arm64_register_cmu() is missing a __noreturn annotation
vmlinux.o: warning: objtool: exynosautov9_cmu_probe+0x16: exynos_arm64_register_cmu() is missing a __noreturn annotation

The objtool analysis is correct, and this could be addressed by just
returning success whenever CONFIG_OF is disabled to let all that code
be eliminated, but since the driver is no use without CONFIG_OF,
just add that as a dependency. It will still get compile tested on
all architectures since CONFIG_OF is enabled in allmodconfig and most
randconfig builds.

Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/clk/samsung/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/samsung/Kconfig b/drivers/clk/samsung/Kconfig
index c07bb50513bfe..76a494e95027a 100644
--- a/drivers/clk/samsung/Kconfig
+++ b/drivers/clk/samsung/Kconfig
@@ -2,6 +2,7 @@
 # Recent Exynos platforms should just select COMMON_CLK_SAMSUNG:
 config COMMON_CLK_SAMSUNG
 	bool "Samsung Exynos clock controller support" if COMPILE_TEST
+	depends on OF
 	select S3C64XX_COMMON_CLK if ARM && ARCH_S3C64XX
 	select S5PV210_COMMON_CLK if ARM && ARCH_S5PV210
 	select EXYNOS_3250_COMMON_CLK if ARM && SOC_EXYNOS3250
-- 
2.39.2

