Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E74D6B426E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbjCJODZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjCJODB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:03:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF2B11662;
        Fri, 10 Mar 2023 06:02:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90F8560D29;
        Fri, 10 Mar 2023 14:02:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC3FC433D2;
        Fri, 10 Mar 2023 14:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678456977;
        bh=WjooVdQedLpfOgQ4iFgnnbV+ow3gmPYiNVq5gRK7Yro=;
        h=From:To:Cc:Subject:Date:From;
        b=YmAxEQiF4Pg54qMNwsu3AdcvJDybkkhW/B1p8+EUuKUWaHLbDHDOUR8IZjTwetYaz
         ahvKpxeE0zBFYNwBRR0X3OeH+YREh5Bzn4foV6HI8GvyfKzW4gGyqMPiPMhdZaRcLG
         TMY1KNNHrl+y5etDnoroP8SfQJ6Eol0xFko91DIxR+K3ynW020TH8Bm8OdXhcoJNrs
         6WhuXsenjtOCAjRwqi0HTFhSv/SMGqdwScaC0C8zYBdhLZUqRqnHc+ZG6rNl0yPmVq
         4OLyQCPQHIg11mcHNNxyx5AOQAYGxLC1kqXmxtdUsyeNHH2dJctu20eSlFlEa12wrR
         pgt74f7fOQ3iA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Chester Lin <clin@suse.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Phu Luu An <phu.luuan@nxp.com>,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>,
        Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, NXP S32 Linux Team <s32@nxp.com>,
        Matthew Nunez <matthew.nunez@nxp.com>,
        Radu Pirea <radu-nicolae.pirea@nxp.com>,
        Larisa Grigore <larisa.grigore@nxp.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: s32cc: fix !CONFIG_PM_SLEEP build error
Date:   Fri, 10 Mar 2023 15:02:35 +0100
Message-Id: <20230310140250.359147-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The declaration of s32_pinctrl_suspend/s32_pinctrl_resume is hidden
in an #ifdef, causing a compilation failure when CONFIG_PM_SLEEP is
disabled:

drivers/pinctrl/nxp/pinctrl-s32g2.c:754:38: error: 's32_pinctrl_suspend' undeclared here (not in a function); did you mean 's32_pinctrl_probe'?
drivers/pinctrl/nxp/pinctrl-s32g2.c:754:9: note: in expansion of macro 'SET_LATE_SYSTEM_SLEEP_PM_OPS'
  754 |         SET_LATE_SYSTEM_SLEEP_PM_OPS(s32_pinctrl_suspend,
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~

Remove the bogus #ifdef and __maybe_unused annation on the global
functions, and instead use the proper LATE_SYSTEM_SLEEP_PM_OPS()
macro to pick set the function pointer.

As the function definition is still in the #ifdef block, this leads
to the correct code in all configurations.

Fixes: fd84aaa8173d ("pinctrl: add NXP S32 SoC family support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pinctrl/nxp/pinctrl-s32.h   | 6 ++----
 drivers/pinctrl/nxp/pinctrl-s32cc.c | 4 ++--
 drivers/pinctrl/nxp/pinctrl-s32g2.c | 3 +--
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/nxp/pinctrl-s32.h b/drivers/pinctrl/nxp/pinctrl-s32.h
index b6d530a62051..545bf16b988d 100644
--- a/drivers/pinctrl/nxp/pinctrl-s32.h
+++ b/drivers/pinctrl/nxp/pinctrl-s32.h
@@ -68,8 +68,6 @@ struct s32_pinctrl_soc_info {
 
 int s32_pinctrl_probe(struct platform_device *pdev,
 			struct s32_pinctrl_soc_info *info);
-#ifdef CONFIG_PM_SLEEP
-int __maybe_unused s32_pinctrl_resume(struct device *dev);
-int __maybe_unused s32_pinctrl_suspend(struct device *dev);
-#endif
+int s32_pinctrl_resume(struct device *dev);
+int s32_pinctrl_suspend(struct device *dev);
 #endif /* __DRIVERS_PINCTRL_S32_H */
diff --git a/drivers/pinctrl/nxp/pinctrl-s32cc.c b/drivers/pinctrl/nxp/pinctrl-s32cc.c
index 2c945523af80..e1da332433a3 100644
--- a/drivers/pinctrl/nxp/pinctrl-s32cc.c
+++ b/drivers/pinctrl/nxp/pinctrl-s32cc.c
@@ -658,7 +658,7 @@ static bool s32_pinctrl_should_save(struct s32_pinctrl *ipctl,
 	return false;
 }
 
-int __maybe_unused s32_pinctrl_suspend(struct device *dev)
+int s32_pinctrl_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct s32_pinctrl *ipctl = platform_get_drvdata(pdev);
@@ -685,7 +685,7 @@ int __maybe_unused s32_pinctrl_suspend(struct device *dev)
 	return 0;
 }
 
-int __maybe_unused s32_pinctrl_resume(struct device *dev)
+int s32_pinctrl_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct s32_pinctrl *ipctl = platform_get_drvdata(pdev);
diff --git a/drivers/pinctrl/nxp/pinctrl-s32g2.c b/drivers/pinctrl/nxp/pinctrl-s32g2.c
index 7dd0b4f8904d..5028f4adc389 100644
--- a/drivers/pinctrl/nxp/pinctrl-s32g2.c
+++ b/drivers/pinctrl/nxp/pinctrl-s32g2.c
@@ -751,8 +751,7 @@ static int s32g_pinctrl_probe(struct platform_device *pdev)
 }
 
 static const struct dev_pm_ops s32g_pinctrl_pm_ops = {
-	SET_LATE_SYSTEM_SLEEP_PM_OPS(s32_pinctrl_suspend,
-				     s32_pinctrl_resume)
+	LATE_SYSTEM_SLEEP_PM_OPS(s32_pinctrl_suspend, s32_pinctrl_resume)
 };
 
 static struct platform_driver s32g_pinctrl_driver = {
-- 
2.39.2

