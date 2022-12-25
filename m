Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C144B655DD5
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 17:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbiLYQrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 11:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiLYQrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 11:47:14 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1507F10ED
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 08:47:12 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id l26so4930160wme.5
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 08:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bJSRHwGgSQsIgnd1ziT5DVB7secN8//21s4cglbkjsI=;
        b=OwYNmML6Qi1WxRgnDi95+Q6UGEOFHsX0RzzURE1yyZ1VPvRebZxXn1yOAMERCq23cV
         Qvd/8FPjAtm5qkvNlgpzPewQSsUVbBQYiiKu9/bBmYUYYjFPPhGXwciXRqpTaCXppOjg
         P0ekRQWHncfmm+WVyTA8fOU4LanckORvwC57AbsBjkC0h5vq7XeULjmx5csbCPZlrBF8
         RDjFVz9H4k66mru2ZWUXlNE52wuRuyviaI6vEVaswdhV2TZQhoJZFuRlsWbEur+M/K2a
         WEaLlP/wmsHd3mje0gHE9Zb7lN2L/zh7ZgC730yudztHp0zR/EwQKJp+ZimIFXvA+RpX
         FDUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bJSRHwGgSQsIgnd1ziT5DVB7secN8//21s4cglbkjsI=;
        b=Nd6CDcCPa0CoTRUW1IYgxs/F8HK6YNc0mtDfnzb4mU8//I4MsWyncFG+HopWtLsbYH
         mGolBbCbjPEeW9IRAjSRQQQf/SIGThUYY/18pRaEVsqDZnJ1AqHoNEmzt1o//G0H6Pkp
         mIQviwoz1JMd+ZqTWuYRVm1Vh53RSzcMfNVXJy4PQpkQfyTFGCW5PvyGX2u3HiJuPxdD
         /b2LSlDxH7C7TUMkNmi0arwS3ZBgEMsVy8gYvLEMu4tyP4QWVqZTqDKNsFMTiQo4PHra
         RJTZvzJYXIDPYDvw+/4YHgBLFDH632v6L498EIebRRQ0iAVf3LwusGqsX4H8t3dXOjra
         MKkQ==
X-Gm-Message-State: AFqh2kpr3V13eNPTN8D1T1Z6w/xFLgc9eydj56yZULt6cZuhiBqkUTqd
        E6XlQzAtHaKIXIABQNSVNCrZRw==
X-Google-Smtp-Source: AMrXdXtVexBf8lzbMFmlaHdKrIcnaqWySkpsYWR2qMQfpHVq1jFB4O1fHaaAyCXzTghTiDuaAdJpVw==
X-Received: by 2002:a05:600c:21c1:b0:3d3:45c6:b641 with SMTP id x1-20020a05600c21c100b003d345c6b641mr11547895wmj.22.1671986830532;
        Sun, 25 Dec 2022 08:47:10 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id d9-20020a05600c3ac900b003d973d4fb28sm5507545wms.4.2022.12.25.08.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 08:47:10 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 1/2] clk: Add generic sync_state callback for disabling unused clocks
Date:   Sun, 25 Dec 2022 18:47:04 +0200
Message-Id: <20221225164705.437944-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are unused clocks that need to remain untouched by clk_disable_unused,
and most likely could be disabled later on sync_state. So provide a generic
sync_state callback for the clock providers that register such clocks.
Then, use the same mechanism as clk_disable_unused from that generic
callback, but pass the device to make sure only the clocks belonging to
the current clock provider get disabled, if unused. Also, during the
default clk_disable_unused, if the driver that registered the clock has
the generic clk_sync_state_disable_unused callback set for sync_state,
skip disabling its clocks.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

Changes since v1:
 * Dropped the 0 returned by __clk_disable_unused when clk_ignore_unused
   is set.
 * Dropped __initdata for clk_ignore_unused

 drivers/clk/clk.c            | 59 +++++++++++++++++++++++++++++-------
 include/linux/clk-provider.h |  1 +
 2 files changed, 49 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index e62552a75f08..5185b857fc65 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1302,14 +1302,27 @@ static void clk_core_disable_unprepare(struct clk_core *core)
 	clk_core_unprepare_lock(core);
 }
 
-static void __init clk_unprepare_unused_subtree(struct clk_core *core)
+static void clk_unprepare_unused_subtree(struct clk_core *core,
+						struct device *dev)
 {
+	bool from_sync_state = !!dev;
 	struct clk_core *child;
 
 	lockdep_assert_held(&prepare_lock);
 
 	hlist_for_each_entry(child, &core->children, child_node)
-		clk_unprepare_unused_subtree(child);
+		clk_unprepare_unused_subtree(child, dev);
+
+	if (from_sync_state && core->dev != dev)
+		return;
+
+	/*
+	 * clock will be unprepared on sync_state,
+	 * so leave as is for now
+	 */
+	if (!from_sync_state && dev_has_sync_state(core->dev) &&
+		core->dev->driver->sync_state == clk_sync_state_disable_unused)
+		return;
 
 	if (core->prepare_count)
 		return;
@@ -1332,15 +1345,28 @@ static void __init clk_unprepare_unused_subtree(struct clk_core *core)
 	clk_pm_runtime_put(core);
 }
 
-static void __init clk_disable_unused_subtree(struct clk_core *core)
+static void clk_disable_unused_subtree(struct clk_core *core,
+					struct device *dev)
 {
+	bool from_sync_state = !!dev;
 	struct clk_core *child;
 	unsigned long flags;
 
 	lockdep_assert_held(&prepare_lock);
 
 	hlist_for_each_entry(child, &core->children, child_node)
-		clk_disable_unused_subtree(child);
+		clk_disable_unused_subtree(child, dev);
+
+	if (from_sync_state && core->dev != dev)
+		return;
+
+	/*
+	 * clock will be disabled on sync_state,
+	 * so leave as is for now
+	 */
+	if (!from_sync_state &&
+		core->dev->driver->sync_state == clk_sync_state_disable_unused)
+		return;
 
 	if (core->flags & CLK_OPS_PARENT_ENABLE)
 		clk_core_prepare_enable(core->parent);
@@ -1378,7 +1404,7 @@ static void __init clk_disable_unused_subtree(struct clk_core *core)
 		clk_core_disable_unprepare(core->parent);
 }
 
-static bool clk_ignore_unused __initdata;
+static bool clk_ignore_unused;
 static int __init clk_ignore_unused_setup(char *__unused)
 {
 	clk_ignore_unused = true;
@@ -1386,35 +1412,46 @@ static int __init clk_ignore_unused_setup(char *__unused)
 }
 __setup("clk_ignore_unused", clk_ignore_unused_setup);
 
-static int __init clk_disable_unused(void)
+static void __clk_disable_unused(struct device *dev)
 {
 	struct clk_core *core;
 
 	if (clk_ignore_unused) {
 		pr_warn("clk: Not disabling unused clocks\n");
-		return 0;
+		return;
 	}
 
 	clk_prepare_lock();
 
 	hlist_for_each_entry(core, &clk_root_list, child_node)
-		clk_disable_unused_subtree(core);
+		clk_disable_unused_subtree(core, dev);
 
 	hlist_for_each_entry(core, &clk_orphan_list, child_node)
-		clk_disable_unused_subtree(core);
+		clk_disable_unused_subtree(core, dev);
 
 	hlist_for_each_entry(core, &clk_root_list, child_node)
-		clk_unprepare_unused_subtree(core);
+		clk_unprepare_unused_subtree(core, dev);
 
 	hlist_for_each_entry(core, &clk_orphan_list, child_node)
-		clk_unprepare_unused_subtree(core);
+		clk_unprepare_unused_subtree(core, dev);
 
 	clk_prepare_unlock();
+}
+
+static int __init clk_disable_unused(void)
+{
+	__clk_disable_unused(NULL);
 
 	return 0;
 }
 late_initcall_sync(clk_disable_unused);
 
+void clk_sync_state_disable_unused(struct device *dev)
+{
+	__clk_disable_unused(dev);
+}
+EXPORT_SYMBOL_GPL(clk_sync_state_disable_unused);
+
 static int clk_core_determine_round_nolock(struct clk_core *core,
 					   struct clk_rate_request *req)
 {
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 842e72a5348f..cf1adfeaf257 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -720,6 +720,7 @@ struct clk *clk_register_divider_table(struct device *dev, const char *name,
 		void __iomem *reg, u8 shift, u8 width,
 		u8 clk_divider_flags, const struct clk_div_table *table,
 		spinlock_t *lock);
+void clk_sync_state_disable_unused(struct device *dev);
 /**
  * clk_register_divider - register a divider clock with the clock framework
  * @dev: device registering this clock
-- 
2.34.1

