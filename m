Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248116E918F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 13:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235296AbjDTLEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 07:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235280AbjDTLEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 07:04:04 -0400
X-Greylist: delayed 1475 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 20 Apr 2023 04:02:49 PDT
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77ED335B1;
        Thu, 20 Apr 2023 04:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:Message-Id:Date:
        Subject:Cc:To:From:Content-Type:Reply-To:Content-ID:Content-Description:
        In-Reply-To:References; bh=f3UZPluLStuZn++V5HsxPtEJ327KiqrtZm7CqUYIcGI=; b=Ir
        A52JQyq7SrUqPhPMQxOvB9eU9UdZLdYIi8574ktHEupTlj4wl8yT/LWcqQwozOFOo8l5O7dWG/acm
        CBylwQO2QT0Q1KPUIMSd4a8zELnL0a5qwm4HQGDH8/yqa1BAoFIddsSXKmLrB+D7jutFP/w38creU
        M1ucEAWwt/kirzuUCu1rtQNI+L2KIcmPObvro3EVdMwgPyHhDopGCgwrZQ0qdWqVvcEpXRsO7+oid
        e5U0fg8QZ5b+pJzuHvTH2rViIDm34hsgMi6A3baYPJqsgpiDDixuOpdnixm2lRgu7ZOb315uM2WZD
        AF6EWCPKBu09iyaGA08OwJu8POoUteSg==;
Received: from [81.174.171.191] (helo=donbot.metanate.com)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <john@metanate.com>)
        id 1ppRg1-0006ol-CI;
        Thu, 20 Apr 2023 11:38:10 +0100
From:   John Keeping <john@metanate.com>
To:     linux-clk@vger.kernel.org
Cc:     John Keeping <john@metanate.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: Allow phase adjustment from debugfs
Date:   Thu, 20 Apr 2023 11:38:04 +0100
Message-Id: <20230420103805.125246-1-john@metanate.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated: YES
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For testing it may be useful to manually adjust a clock's phase.  Add
support for writing to the existing clk_phase debugfs file, with the
written value clamped to [0, 360) to match the behaviour of the
clk_set_phase() function.

This is a dangerous feature, so use the existing define
CLOCK_ALLOW_WRITE_DEBUGFS to allow it only if the source is modified.

Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/clk/clk.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 27c30a533759..2d3b6869f3f6 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3297,6 +3297,21 @@ static int clk_rate_set(void *data, u64 val)
 
 #define clk_rate_mode	0644
 
+static int clk_phase_set(void *data, u64 val)
+{
+	struct clk_core *core = data;
+	int degrees = do_div(val, 360);
+	int ret;
+
+	clk_prepare_lock();
+	ret = clk_core_set_phase_nolock(core, degrees);
+	clk_prepare_unlock();
+
+	return ret;
+}
+
+#define clk_phase_mode	0644
+
 static int clk_prepare_enable_set(void *data, u64 val)
 {
 	struct clk_core *core = data;
@@ -3324,6 +3339,9 @@ DEFINE_DEBUGFS_ATTRIBUTE(clk_prepare_enable_fops, clk_prepare_enable_get,
 #else
 #define clk_rate_set	NULL
 #define clk_rate_mode	0444
+
+#define clk_phase_set	NULL
+#define clk_phase_mode	0644
 #endif
 
 static int clk_rate_get(void *data, u64 *val)
@@ -3339,6 +3357,16 @@ static int clk_rate_get(void *data, u64 *val)
 
 DEFINE_DEBUGFS_ATTRIBUTE(clk_rate_fops, clk_rate_get, clk_rate_set, "%llu\n");
 
+static int clk_phase_get(void *data, u64 *val)
+{
+	struct clk_core *core = data;
+
+	*val = core->phase;
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(clk_phase_fops, clk_phase_get, clk_phase_set, "%llu\n");
+
 static const struct {
 	unsigned long flag;
 	const char *name;
@@ -3529,7 +3557,8 @@ static void clk_debug_create_one(struct clk_core *core, struct dentry *pdentry)
 	debugfs_create_file("clk_min_rate", 0444, root, core, &clk_min_rate_fops);
 	debugfs_create_file("clk_max_rate", 0444, root, core, &clk_max_rate_fops);
 	debugfs_create_ulong("clk_accuracy", 0444, root, &core->accuracy);
-	debugfs_create_u32("clk_phase", 0444, root, &core->phase);
+	debugfs_create_file("clk_phase", clk_phase_mode, root, core,
+			    &clk_phase_fops);
 	debugfs_create_file("clk_flags", 0444, root, core, &clk_flags_fops);
 	debugfs_create_u32("clk_prepare_count", 0444, root, &core->prepare_count);
 	debugfs_create_u32("clk_enable_count", 0444, root, &core->enable_count);
-- 
2.40.0

