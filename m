Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C2060E458
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 17:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234524AbiJZPSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 11:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234514AbiJZPSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 11:18:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C860E12A36A
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 08:18:22 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oniAZ-0004pf-Vl; Wed, 26 Oct 2022 17:18:16 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oniAa-000X4i-1W; Wed, 26 Oct 2022 17:18:15 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oniAY-00Aq9z-4i; Wed, 26 Oct 2022 17:18:14 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-doc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v3] clk: expand clk_ignore_unused mechanism to keep only a few clks on
Date:   Wed, 26 Oct 2022 17:18:12 +0200
Message-Id: <20221026151812.1042052-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow to pass an integer n that results in only keeping n unused clocks
enabled.

This helps to debug the problem if you only know that clk_ignore_unused
helps but you have no clue yet which clock is the culprit.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

compared to v2 sent in August 2021 this is a trivial rebase on top of
v6.1-rc1. I pinged that one repeatedly, I'm now trying with resending
and calling the rebased patch v3 to maybe get some feedback. :-\

Best regards
Uwe

 Documentation/driver-api/clk.rst |  4 +++-
 drivers/clk/clk.c                | 33 ++++++++++++++++++++++++--------
 2 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/Documentation/driver-api/clk.rst b/Documentation/driver-api/clk.rst
index 3cad45d14187..65ae7c3e2b33 100644
--- a/Documentation/driver-api/clk.rst
+++ b/Documentation/driver-api/clk.rst
@@ -259,7 +259,9 @@ the disabling means that the driver will remain functional while the issues
 are sorted out.
 
 To bypass this disabling, include "clk_ignore_unused" in the bootargs to the
-kernel.
+kernel. If you pass "clk_ignore_unused=n" (where n is an integer) the first n
+found clocks are not disabled which can be useful for bisecting over the unused
+clks if you don't know yet which of them is reponsible for your problem.
 
 Locking
 =======
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index c3c3f8c07258..356119a7e5fe 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1322,6 +1322,8 @@ static void __init clk_unprepare_unused_subtree(struct clk_core *core)
 	clk_pm_runtime_put(core);
 }
 
+static unsigned clk_unused_keep_on __initdata;
+
 static void __init clk_disable_unused_subtree(struct clk_core *core)
 {
 	struct clk_core *child;
@@ -1352,12 +1354,17 @@ static void __init clk_disable_unused_subtree(struct clk_core *core)
 	 * back to .disable
 	 */
 	if (clk_core_is_enabled(core)) {
-		trace_clk_disable(core);
-		if (core->ops->disable_unused)
-			core->ops->disable_unused(core->hw);
-		else if (core->ops->disable)
-			core->ops->disable(core->hw);
-		trace_clk_disable_complete(core);
+		if (clk_unused_keep_on) {
+			pr_warn("Keep unused clk \"%s\" on\n", core->name);
+			clk_unused_keep_on -= 1;
+		} else {
+			trace_clk_disable(core);
+			if (core->ops->disable_unused)
+				core->ops->disable_unused(core->hw);
+			else if (core->ops->disable)
+				core->ops->disable(core->hw);
+			trace_clk_disable_complete(core);
+		}
 	}
 
 unlock_out:
@@ -1369,9 +1376,17 @@ static void __init clk_disable_unused_subtree(struct clk_core *core)
 }
 
 static bool clk_ignore_unused __initdata;
-static int __init clk_ignore_unused_setup(char *__unused)
+static int __init clk_ignore_unused_setup(char *keep)
 {
-	clk_ignore_unused = true;
+	if (*keep == '=') {
+		int ret;
+
+		ret = kstrtouint(keep + 1, 0, &clk_unused_keep_on);
+		if (ret < 0)
+			pr_err("Warning: failed to parse clk_ignore_unused parameter, ignoring");
+	} else {
+		clk_ignore_unused = true;
+	}
 	return 1;
 }
 __setup("clk_ignore_unused", clk_ignore_unused_setup);
@@ -1383,6 +1398,8 @@ static int __init clk_disable_unused(void)
 	if (clk_ignore_unused) {
 		pr_warn("clk: Not disabling unused clocks\n");
 		return 0;
+	} else if (clk_unused_keep_on) {
+		pr_warn("clk: Not disabling %u unused clocks\n", clk_unused_keep_on);
 	}
 
 	clk_prepare_lock();
-- 
2.37.2

