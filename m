Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2AC9644223
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 12:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234765AbiLFL27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 06:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiLFL2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 06:28:48 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845DC2657E;
        Tue,  6 Dec 2022 03:28:44 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id bg10so10953120wmb.1;
        Tue, 06 Dec 2022 03:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DwgICqEjspI+0KzLhLans4aMJMPB5tn74bm77d2r0Zw=;
        b=BQgI0h/Cgqvg1gJa++/Bkeu3SovbyG/eDrD/TSJ6SbTJiV4Nekf/oKdd95skxyLyc5
         /Q2WL67dx+GE4P1FeCXDV8OpxTOa6TxIkLvgAK8hdtnIBF227/VXrg46JwotPhxUY6iv
         TihXGIb/FZyDbK4oOq8jnrSOdbbZF21B2jQYv8sAk4zf5+iVnGjDWa6WFDckSmjSXYor
         TpVG1VOfqxQTDpWczt4Eftoeb9tecx99roIJtd2wYXPcPL2yChX3a0d4kIbzmcVyAMy1
         Zi/9upj9te1mnOFLPgY4rMpVG3ZGQs2Z+ZdoqiJ4TmZiqo89tUG8bg44ntjJPozGVeOr
         WoWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DwgICqEjspI+0KzLhLans4aMJMPB5tn74bm77d2r0Zw=;
        b=OuR/3MjIn6QZ1blZb/TBnQK6a9gDoJ2ez/+ckBp2J7uDqMqOkiz6ffh+xXUS0l0XOb
         Mnpt6gfVhJ5ubVMsMMgXt6ZsKV94luHJmJov2YTMDRiwD6Ah8xTJ4oG5YnIiEL+Qqivk
         j51E5ebosrTFRD83Ze8XFUY77DykaRkLcHxPX6oEgPy8WLVAtTlIVVeMz+41+uq+Witt
         tVI6iQtWY6WV2Q+J/8ZYDNlq+/E1PY/2nc95Vbe3VF/FrMt3uHQSmr/pOVkbQ/upPPGI
         SnjEZKYK64FoiIHZ6ofqeFroi5m4Mbpd0mIHBnJpb2FrQkUUKqxA3nCKG8THDGerNm2I
         7lcg==
X-Gm-Message-State: ANoB5pkSzi3pJGdfehuA9vc4O8inE8U2zPZLV1kBvRbQYaQH6Nt1PxhT
        czTHliEX0zP8Vq8gYUeWTig=
X-Google-Smtp-Source: AA0mqf7vy7z30TgB3r8RZWzNrtqv0HXaM5/5wfnJwVNzcEloiye8HV3m/v3w2eV8jTPwDZaTCM8+8Q==
X-Received: by 2002:a05:600c:430b:b0:3d1:ce2d:8eed with SMTP id p11-20020a05600c430b00b003d1ce2d8eedmr5881818wme.119.1670326122565;
        Tue, 06 Dec 2022 03:28:42 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.13.177])
        by smtp.gmail.com with ESMTPSA id m126-20020a1c2684000000b003d1d5a83b2esm4913686wmm.35.2022.12.06.03.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 03:28:42 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Cosmin Tanislav <demonsingur@gmail.com>
Subject: [RFC PATCH 1/1] clk: core: use 64-bit integers
Date:   Tue,  6 Dec 2022 13:28:27 +0200
Message-Id: <20221206112827.115674-2-demonsingur@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221206112827.115674-1-demonsingur@gmail.com>
References: <20221206112827.115674-1-demonsingur@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are quite a few chips that provide or consume frequencies
upwards of the limit imposed by long integers on 32-bit systems.

The whole clocking subsystem is using long integers for storing
frequency rates, which limits the usage of these chips on 32-bit
systems.

To address this, change the internal integer type to u64, wrap
the new u64 API to provide compatibility with the old API (both
for providers, and consumers) all while checking for 64-bit
consumers passing frequencies past the long limit to long
providers, and 64-bit providers returning frequencies past the
long limit to long consumers.

Signed-off-by: Cosmin Tanislav <demonsingur@gmail.com>
---
 drivers/clk/clk.c            | 564 +++++++++++++++++++++++++++--------
 include/linux/clk-provider.h |  90 ++++++
 include/linux/clk.h          |  44 +++
 3 files changed, 578 insertions(+), 120 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 57b83665e5c3..8b3333c9b0f1 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -24,6 +24,9 @@
 
 #include "clk.h"
 
+#define CLK_MAX_ABS_RATE		ULONG_MAX
+#define CLK_MAX_ABS_RATE_64		U64_MAX
+
 static DEFINE_SPINLOCK(enable_lock);
 static DEFINE_MUTEX(prepare_lock);
 
@@ -55,7 +58,8 @@ struct clk_parent_map {
 
 struct clk_core {
 	const char		*name;
-	const struct clk_ops	*ops;
+	const struct clk_ops_64	*ops;
+	const struct clk_ops	*ops_32;
 	struct clk_hw		*hw;
 	struct module		*owner;
 	struct device		*dev;
@@ -64,19 +68,20 @@ struct clk_core {
 	struct clk_parent_map	*parents;
 	u8			num_parents;
 	u8			new_parent_index;
-	unsigned long		rate;
-	unsigned long		req_rate;
-	unsigned long		new_rate;
+	u64			rate;
+	u64			req_rate;
+	u64			new_rate;
 	struct clk_core		*new_parent;
 	struct clk_core		*new_child;
 	unsigned long		flags;
 	bool			orphan;
 	bool			rpm_enabled;
+	bool			supports_64;
 	unsigned int		enable_count;
 	unsigned int		prepare_count;
 	unsigned int		protect_count;
-	unsigned long		min_rate;
-	unsigned long		max_rate;
+	u64			min_rate;
+	u64			max_rate;
 	unsigned long		accuracy;
 	int			phase;
 	struct clk_duty		duty;
@@ -99,8 +104,8 @@ struct clk {
 	struct device *dev;
 	const char *dev_id;
 	const char *con_id;
-	unsigned long min_rate;
-	unsigned long max_rate;
+	u64 min_rate;
+	u64 max_rate;
 	unsigned int exclusive_count;
 	struct hlist_node clks_node;
 };
@@ -191,6 +196,11 @@ static void clk_enable_unlock(unsigned long flags)
 	spin_unlock_irqrestore(&enable_lock, flags);
 }
 
+static bool clk_core_supports_rate(struct clk_core *core, u64 rate)
+{
+	return rate > CLK_MAX_ABS_RATE && core && core->supports_64;
+}
+
 static bool clk_core_rate_is_protected(struct clk_core *core)
 {
 	return core->protect_count;
@@ -464,7 +474,7 @@ unsigned int __clk_get_enable_count(struct clk *clk)
 	return !clk ? 0 : clk->core->enable_count;
 }
 
-static unsigned long clk_core_get_rate_nolock(struct clk_core *core)
+static u64 clk_core_get_rate_nolock(struct clk_core *core)
 {
 	if (!core)
 		return 0;
@@ -480,10 +490,21 @@ static unsigned long clk_core_get_rate_nolock(struct clk_core *core)
 	return 0;
 }
 
-unsigned long clk_hw_get_rate(const struct clk_hw *hw)
+u64 clk_hw_get_rate_64(const struct clk_hw *hw)
 {
 	return clk_core_get_rate_nolock(hw->core);
 }
+EXPORT_SYMBOL_GPL(clk_hw_get_rate_64);
+
+unsigned long clk_hw_get_rate(const struct clk_hw *hw)
+{
+	u64 rate = clk_hw_get_rate_64(hw);
+
+	if (rate > CLK_MAX_ABS_RATE)
+		rate = 0;
+
+	return rate;
+}
 EXPORT_SYMBOL_GPL(clk_hw_get_rate);
 
 static unsigned long clk_core_get_accuracy_no_lock(struct clk_core *core)
@@ -527,8 +548,7 @@ bool __clk_is_enabled(struct clk *clk)
 }
 EXPORT_SYMBOL_GPL(__clk_is_enabled);
 
-static bool mux_is_better_rate(unsigned long rate, unsigned long now,
-			   unsigned long best, unsigned long flags)
+static bool mux_is_better_rate(u64 rate, u64 now, u64 best, unsigned long flags)
 {
 	if (flags & CLK_MUX_ROUND_CLOSEST)
 		return abs(now - rate) < abs(best - rate);
@@ -537,11 +557,11 @@ static bool mux_is_better_rate(unsigned long rate, unsigned long now,
 }
 
 static void clk_core_init_rate_req(struct clk_core * const core,
-				   struct clk_rate_request *req,
-				   unsigned long rate);
+				   struct clk_rate_request_64 *req,
+				   u64 rate);
 
 static int clk_core_round_rate_nolock(struct clk_core *core,
-				      struct clk_rate_request *req);
+				      struct clk_rate_request_64 *req);
 
 static bool clk_core_has_parent(struct clk_core *core, const struct clk_core *parent)
 {
@@ -566,10 +586,10 @@ static bool clk_core_has_parent(struct clk_core *core, const struct clk_core *pa
 
 static void
 clk_core_forward_rate_req(struct clk_core *core,
-			  const struct clk_rate_request *old_req,
+			  const struct clk_rate_request_64 *old_req,
 			  struct clk_core *parent,
-			  struct clk_rate_request *req,
-			  unsigned long parent_rate)
+			  struct clk_rate_request_64 *req,
+			  u64 parent_rate)
 {
 	if (WARN_ON(!clk_core_has_parent(core, parent)))
 		return;
@@ -583,19 +603,19 @@ clk_core_forward_rate_req(struct clk_core *core,
 		req->max_rate = old_req->max_rate;
 }
 
-int clk_mux_determine_rate_flags(struct clk_hw *hw,
-				 struct clk_rate_request *req,
-				 unsigned long flags)
+int clk_mux_determine_rate_flags_64(struct clk_hw *hw,
+				    struct clk_rate_request_64 *req,
+				    unsigned long flags)
 {
 	struct clk_core *core = hw->core, *parent, *best_parent = NULL;
 	int i, num_parents, ret;
-	unsigned long best = 0;
+	u64 best = 0;
 
 	/* if NO_REPARENT flag set, pass through to current parent */
 	if (core->flags & CLK_SET_RATE_NO_REPARENT) {
 		parent = core->parent;
 		if (core->flags & CLK_SET_RATE_PARENT) {
-			struct clk_rate_request parent_req;
+			struct clk_rate_request_64 parent_req;
 
 			if (!parent) {
 				req->rate = 0;
@@ -620,14 +640,14 @@ int clk_mux_determine_rate_flags(struct clk_hw *hw,
 	/* find the parent that can provide the fastest rate <= rate */
 	num_parents = core->num_parents;
 	for (i = 0; i < num_parents; i++) {
-		unsigned long parent_rate;
+		u64 parent_rate;
 
 		parent = clk_core_get_parent_by_index(core, i);
 		if (!parent)
 			continue;
 
 		if (core->flags & CLK_SET_RATE_PARENT) {
-			struct clk_rate_request parent_req;
+			struct clk_rate_request_64 parent_req;
 
 			clk_core_forward_rate_req(core, req, parent, &parent_req, req->rate);
 			ret = clk_core_round_rate_nolock(parent, &parent_req);
@@ -657,6 +677,23 @@ int clk_mux_determine_rate_flags(struct clk_hw *hw,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(clk_mux_determine_rate_flags_64);
+
+int clk_mux_determine_rate_flags(struct clk_hw *hw,
+				 struct clk_rate_request *req,
+				 unsigned long flags)
+{
+	struct clk_rate_request_64 req_64;
+	int ret;
+
+	clk_rate_req_to_64(req, &req_64);
+
+	ret = clk_mux_determine_rate_flags_64(hw, &req_64, flags);
+
+	clk_rate_req_from_64(req, &req_64);
+
+	return ret;
+}
 EXPORT_SYMBOL_GPL(clk_mux_determine_rate_flags);
 
 struct clk *__clk_lookup(const char *name)
@@ -667,8 +704,7 @@ struct clk *__clk_lookup(const char *name)
 }
 
 static void clk_core_get_boundaries(struct clk_core *core,
-				    unsigned long *min_rate,
-				    unsigned long *max_rate)
+				    u64 *min_rate, u64 *max_rate)
 {
 	struct clk *clk_user;
 
@@ -693,16 +729,27 @@ static void clk_core_get_boundaries(struct clk_core *core,
  * Fills the @min_rate and @max_rate variables with the minimum and
  * maximum that clock can reach.
  */
+
+void clk_hw_get_rate_range_64(struct clk_hw *hw, u64 *min_rate, u64 *max_rate)
+{
+	clk_core_get_boundaries(hw->core, min_rate, max_rate);
+}
+EXPORT_SYMBOL_GPL(clk_hw_get_rate_range_64);
+
 void clk_hw_get_rate_range(struct clk_hw *hw, unsigned long *min_rate,
 			   unsigned long *max_rate)
 {
-	clk_core_get_boundaries(hw->core, min_rate, max_rate);
+	u64 min_rate_64, max_rate_64;
+
+	clk_hw_get_rate_range_64(hw, &min_rate_64, &max_rate_64);
+
+	*min_rate = min_rate_64;
+	*max_rate = max_rate_64;
 }
 EXPORT_SYMBOL_GPL(clk_hw_get_rate_range);
 
 static bool clk_core_check_boundaries(struct clk_core *core,
-				      unsigned long min_rate,
-				      unsigned long max_rate)
+				      u64 min_rate, u64 max_rate)
 {
 	struct clk *user;
 
@@ -718,12 +765,18 @@ static bool clk_core_check_boundaries(struct clk_core *core,
 	return true;
 }
 
-void clk_hw_set_rate_range(struct clk_hw *hw, unsigned long min_rate,
-			   unsigned long max_rate)
+void clk_hw_set_rate_range_64(struct clk_hw *hw, u64 min_rate, u64 max_rate)
 {
 	hw->core->min_rate = min_rate;
 	hw->core->max_rate = max_rate;
 }
+EXPORT_SYMBOL_GPL(clk_hw_set_rate_range_64);
+
+void clk_hw_set_rate_range(struct clk_hw *hw, unsigned long min_rate,
+			   unsigned long max_rate)
+{
+	clk_hw_set_rate_range_64(hw, min_rate, max_rate);
+}
 EXPORT_SYMBOL_GPL(clk_hw_set_rate_range);
 
 /*
@@ -737,17 +790,49 @@ EXPORT_SYMBOL_GPL(clk_hw_set_rate_range);
  *
  * Returns: 0 on success, -EERROR value on error
  */
+int __clk_mux_determine_rate_64(struct clk_hw *hw,
+				struct clk_rate_request_64 *req)
+{
+	return clk_mux_determine_rate_flags_64(hw, req, 0);
+}
+EXPORT_SYMBOL_GPL(__clk_mux_determine_rate_64);
+
 int __clk_mux_determine_rate(struct clk_hw *hw,
 			     struct clk_rate_request *req)
 {
-	return clk_mux_determine_rate_flags(hw, req, 0);
+	struct clk_rate_request_64 req_64;
+	int ret;
+
+	clk_rate_req_to_64(req, &req_64);
+
+	ret = __clk_mux_determine_rate_64(hw, &req_64);
+
+	clk_rate_req_from_64(req, &req_64);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(__clk_mux_determine_rate);
 
+int __clk_mux_determine_rate_closest_64(struct clk_hw *hw,
+					struct clk_rate_request_64 *req)
+{
+	return clk_mux_determine_rate_flags_64(hw, req, CLK_MUX_ROUND_CLOSEST);
+}
+EXPORT_SYMBOL_GPL(__clk_mux_determine_rate_closest_64);
+
 int __clk_mux_determine_rate_closest(struct clk_hw *hw,
 				     struct clk_rate_request *req)
 {
-	return clk_mux_determine_rate_flags(hw, req, CLK_MUX_ROUND_CLOSEST);
+	struct clk_rate_request_64 req_64;
+	int ret;
+
+	clk_rate_req_to_64(req, &req_64);
+
+	ret = __clk_mux_determine_rate_closest_64(hw, &req_64);
+
+	clk_rate_req_from_64(req, &req_64);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(__clk_mux_determine_rate_closest);
 
@@ -1406,7 +1491,7 @@ static int __init clk_disable_unused(void)
 late_initcall_sync(clk_disable_unused);
 
 static int clk_core_determine_round_nolock(struct clk_core *core,
-					   struct clk_rate_request *req)
+					   struct clk_rate_request_64 *req)
 {
 	long rate;
 
@@ -1454,8 +1539,8 @@ static int clk_core_determine_round_nolock(struct clk_core *core,
 }
 
 static void clk_core_init_rate_req(struct clk_core * const core,
-				   struct clk_rate_request *req,
-				   unsigned long rate)
+				   struct clk_rate_request_64 *req,
+				   u64 rate)
 {
 	struct clk_core *parent;
 
@@ -1463,7 +1548,7 @@ static void clk_core_init_rate_req(struct clk_core * const core,
 		return;
 
 	memset(req, 0, sizeof(*req));
-	req->max_rate = ULONG_MAX;
+	req->max_rate = CLK_MAX_ABS_RATE_64;
 
 	if (!core)
 		return;
@@ -1490,15 +1575,28 @@ static void clk_core_init_rate_req(struct clk_core * const core,
  * Initializes a clk_rate_request structure to submit to
  * __clk_determine_rate() or similar functions.
  */
-void clk_hw_init_rate_request(const struct clk_hw *hw,
-			      struct clk_rate_request *req,
-			      unsigned long rate)
+void clk_hw_init_rate_request_64(const struct clk_hw *hw,
+				 struct clk_rate_request_64 *req, u64 rate)
 {
 	if (WARN_ON(!hw || !req))
 		return;
 
 	clk_core_init_rate_req(hw->core, req, rate);
 }
+EXPORT_SYMBOL_GPL(clk_hw_init_rate_request_64);
+
+void clk_hw_init_rate_request(const struct clk_hw *hw,
+			      struct clk_rate_request *req,
+			      unsigned long rate)
+{
+	struct clk_rate_request_64 req_64;
+
+	clk_rate_req_to_64(req, &req_64);
+
+	clk_hw_init_rate_request_64(hw, &req_64, rate);
+
+	clk_rate_req_from_64(req, &req_64);
+}
 EXPORT_SYMBOL_GPL(clk_hw_init_rate_request);
 
 /**
@@ -1512,11 +1610,11 @@ EXPORT_SYMBOL_GPL(clk_hw_init_rate_request);
  * Initializes a clk_rate_request structure to submit to a clock parent
  * in __clk_determine_rate() or similar functions.
  */
-void clk_hw_forward_rate_request(const struct clk_hw *hw,
-				 const struct clk_rate_request *old_req,
-				 const struct clk_hw *parent,
-				 struct clk_rate_request *req,
-				 unsigned long parent_rate)
+void clk_hw_forward_rate_request_64(const struct clk_hw *hw,
+				    const struct clk_rate_request_64 *old_req,
+				    const struct clk_hw *parent,
+				    struct clk_rate_request_64 *req,
+				    u64 parent_rate)
 {
 	if (WARN_ON(!hw || !old_req || !parent || !req))
 		return;
@@ -1526,13 +1624,31 @@ void clk_hw_forward_rate_request(const struct clk_hw *hw,
 				  parent_rate);
 }
 
+void clk_hw_forward_rate_request(const struct clk_hw *hw,
+				 const struct clk_rate_request *old_req,
+				 const struct clk_hw *parent,
+				 struct clk_rate_request *req,
+				 unsigned long parent_rate)
+{
+	struct clk_rate_request_64 req_64, old_req_64;
+
+	clk_rate_req_to_64(req, &old_req_64);
+	clk_rate_req_to_64(req, &req_64);
+
+	clk_hw_forward_rate_request_64(hw, &old_req_64, parent,
+				       &req_64, parent_rate);
+
+	clk_rate_req_from_64(req, &req_64);
+	clk_rate_req_from_64(req, &old_req_64);
+}
+
 static bool clk_core_can_round(struct clk_core * const core)
 {
 	return core->ops->determine_rate || core->ops->round_rate;
 }
 
 static int clk_core_round_rate_nolock(struct clk_core *core,
-				      struct clk_rate_request *req)
+				      struct clk_rate_request_64 *req)
 {
 	int ret;
 
@@ -1547,7 +1663,7 @@ static int clk_core_round_rate_nolock(struct clk_core *core,
 		return clk_core_determine_round_nolock(core, req);
 
 	if (core->flags & CLK_SET_RATE_PARENT) {
-		struct clk_rate_request parent_req;
+		struct clk_rate_request_64 parent_req;
 
 		clk_core_forward_rate_req(core, req, core->parent, &parent_req, req->rate);
 		ret = clk_core_round_rate_nolock(core->parent, &parent_req);
@@ -1571,7 +1687,7 @@ static int clk_core_round_rate_nolock(struct clk_core *core,
  *
  * Useful for clk_ops such as .set_rate and .determine_rate.
  */
-int __clk_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
+int __clk_determine_rate_64(struct clk_hw *hw, struct clk_rate_request_64 *req)
 {
 	if (!hw) {
 		req->rate = 0;
@@ -1580,6 +1696,21 @@ int __clk_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
 
 	return clk_core_round_rate_nolock(hw->core, req);
 }
+EXPORT_SYMBOL_GPL(__clk_determine_rate_64);
+
+int __clk_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
+{
+	struct clk_rate_request_64 req_64;
+	int ret;
+
+	clk_rate_req_to_64(req, &req_64);
+
+	ret = __clk_determine_rate_64(hw, &req_64);
+
+	clk_rate_req_from_64(req, &req_64);
+
+	return ret;
+}
 EXPORT_SYMBOL_GPL(__clk_determine_rate);
 
 /**
@@ -1597,10 +1728,10 @@ EXPORT_SYMBOL_GPL(__clk_determine_rate);
  * Return: returns rounded rate of hw clk if clk supports round_rate operation
  *         else returns the parent rate.
  */
-unsigned long clk_hw_round_rate(struct clk_hw *hw, unsigned long rate)
+u64 clk_hw_round_rate_64(struct clk_hw *hw, u64 rate)
 {
 	int ret;
-	struct clk_rate_request req;
+	struct clk_rate_request_64 req;
 
 	clk_core_init_rate_req(hw->core, &req, rate);
 
@@ -1610,6 +1741,12 @@ unsigned long clk_hw_round_rate(struct clk_hw *hw, unsigned long rate)
 
 	return req.rate;
 }
+EXPORT_SYMBOL_GPL(clk_hw_round_rate_64);
+
+unsigned long clk_hw_round_rate(struct clk_hw *hw, unsigned long rate)
+{
+	return clk_hw_round_rate_64(hw, rate);
+}
 EXPORT_SYMBOL_GPL(clk_hw_round_rate);
 
 /**
@@ -1621,14 +1758,17 @@ EXPORT_SYMBOL_GPL(clk_hw_round_rate);
  * use which is then returned.  If clk doesn't support round_rate operation
  * then the parent rate is returned.
  */
-long clk_round_rate(struct clk *clk, unsigned long rate)
+s64 clk_round_rate_64(struct clk *clk, u64 rate)
 {
-	struct clk_rate_request req;
+	struct clk_rate_request_64 req;
 	int ret;
 
 	if (!clk)
 		return 0;
 
+	if (!clk_core_supports_rate(clk->core, rate))
+		return -EINVAL;
+
 	clk_prepare_lock();
 
 	if (clk->exclusive_count)
@@ -1648,6 +1788,17 @@ long clk_round_rate(struct clk *clk, unsigned long rate)
 
 	return req.rate;
 }
+EXPORT_SYMBOL_GPL(clk_round_rate_64);
+
+long clk_round_rate(struct clk *clk, unsigned long rate)
+{
+	s64 rate_64 = clk_round_rate_64(clk, rate);
+
+	if (rate_64 > CLK_MAX_ABS_RATE)
+		rate_64 = -EINVAL;
+
+	return rate_64;
+}
 EXPORT_SYMBOL_GPL(clk_round_rate);
 
 /**
@@ -1665,14 +1816,19 @@ EXPORT_SYMBOL_GPL(clk_round_rate);
  * a driver returns that.
  */
 static int __clk_notify(struct clk_core *core, unsigned long msg,
-		unsigned long old_rate, unsigned long new_rate)
+		u64 old_rate, u64 new_rate)
 {
 	struct clk_notifier *cn;
 	struct clk_notifier_data cnd;
 	int ret = NOTIFY_DONE;
 
-	cnd.old_rate = old_rate;
-	cnd.new_rate = new_rate;
+	if (old_rate <= CLK_MAX_ABS_RATE) {
+		cnd.old_rate = old_rate;
+		cnd.new_rate = new_rate;
+	}
+
+	cnd.old_rate_64 = old_rate;
+	cnd.new_rate_64 = new_rate;
 
 	list_for_each_entry(cn, &clk_notifier_list, node) {
 		if (cn->clk->core == core) {
@@ -1748,10 +1904,9 @@ long clk_get_accuracy(struct clk *clk)
 }
 EXPORT_SYMBOL_GPL(clk_get_accuracy);
 
-static unsigned long clk_recalc(struct clk_core *core,
-				unsigned long parent_rate)
+static u64 clk_recalc(struct clk_core *core, u64 parent_rate)
 {
-	unsigned long rate = parent_rate;
+	u64 rate = parent_rate;
 
 	if (core->ops->recalc_rate && !clk_pm_runtime_get(core)) {
 		rate = core->ops->recalc_rate(core->hw, parent_rate);
@@ -1773,11 +1928,10 @@ static unsigned long clk_recalc(struct clk_core *core,
  * clk_recalc_rates also propagates the POST_RATE_CHANGE notification,
  * if necessary.
  */
-static void __clk_recalc_rates(struct clk_core *core, bool update_req,
-			       unsigned long msg)
+static void __clk_recalc_rates(struct clk_core *core, bool update_req, u64 msg)
 {
-	unsigned long old_rate;
-	unsigned long parent_rate = 0;
+	u64 old_rate;
+	u64 parent_rate = 0;
 	struct clk_core *child;
 
 	lockdep_assert_held(&prepare_lock);
@@ -1802,7 +1956,7 @@ static void __clk_recalc_rates(struct clk_core *core, bool update_req,
 		__clk_recalc_rates(child, update_req, msg);
 }
 
-static unsigned long clk_core_get_rate_recalc(struct clk_core *core)
+static u64 clk_core_get_rate_recalc(struct clk_core *core)
 {
 	if (core && (core->flags & CLK_GET_RATE_NOCACHE))
 		__clk_recalc_rates(core, false, 0);
@@ -1819,9 +1973,9 @@ static unsigned long clk_core_get_rate_recalc(struct clk_core *core)
  * the clock enabledness. If clk is NULL, or if an error occurred, then returns
  * 0.
  */
-unsigned long clk_get_rate(struct clk *clk)
+u64 clk_get_rate_64(struct clk *clk)
 {
-	unsigned long rate;
+	u64 rate;
 
 	if (!clk)
 		return 0;
@@ -1832,6 +1986,17 @@ unsigned long clk_get_rate(struct clk *clk)
 
 	return rate;
 }
+EXPORT_SYMBOL_GPL(clk_get_rate_64);
+
+unsigned long clk_get_rate(struct clk *clk)
+{
+	u64 rate = clk_get_rate_64(clk);
+
+	if (rate > CLK_MAX_ABS_RATE)
+		rate = 0;
+
+	return rate;
+}
 EXPORT_SYMBOL_GPL(clk_get_rate);
 
 static int clk_fetch_parent_index(struct clk_core *core,
@@ -2046,11 +2211,10 @@ static int __clk_set_parent(struct clk_core *core, struct clk_core *parent,
  * implement the .recalc_rate callback then it is assumed that the clock will
  * take on the rate of its parent.
  */
-static int __clk_speculate_rates(struct clk_core *core,
-				 unsigned long parent_rate)
+static int __clk_speculate_rates(struct clk_core *core, u64 parent_rate)
 {
 	struct clk_core *child;
-	unsigned long new_rate;
+	u64 new_rate;
 	int ret = NOTIFY_DONE;
 
 	lockdep_assert_held(&prepare_lock);
@@ -2077,7 +2241,7 @@ static int __clk_speculate_rates(struct clk_core *core,
 	return ret;
 }
 
-static void clk_calc_subtree(struct clk_core *core, unsigned long new_rate,
+static void clk_calc_subtree(struct clk_core *core, u64 new_rate,
 			     struct clk_core *new_parent, u8 p_index)
 {
 	struct clk_core *child;
@@ -2101,14 +2265,14 @@ static void clk_calc_subtree(struct clk_core *core, unsigned long new_rate,
  * changed.
  */
 static struct clk_core *clk_calc_new_rates(struct clk_core *core,
-					   unsigned long rate)
+					   u64 rate)
 {
 	struct clk_core *top = core;
 	struct clk_core *old_parent, *parent;
-	unsigned long best_parent_rate = 0;
-	unsigned long new_rate;
-	unsigned long min_rate;
-	unsigned long max_rate;
+	u64 best_parent_rate = 0;
+	u64 new_rate;
+	u64 min_rate;
+	u64 max_rate;
 	int p_index = 0;
 	long ret;
 
@@ -2125,7 +2289,7 @@ static struct clk_core *clk_calc_new_rates(struct clk_core *core,
 
 	/* find the closest rate and parent clk/rate */
 	if (clk_core_can_round(core)) {
-		struct clk_rate_request req;
+		struct clk_rate_request_64 req;
 
 		clk_core_init_rate_req(core, &req, rate);
 
@@ -2184,7 +2348,7 @@ static struct clk_core *clk_calc_new_rates(struct clk_core *core,
  * abort the change.
  */
 static struct clk_core *clk_propagate_rate_change(struct clk_core *core,
-						  unsigned long event)
+						  u64 event)
 {
 	struct clk_core *child, *tmp_clk, *fail_clk = NULL;
 	int ret = NOTIFY_DONE;
@@ -2225,8 +2389,8 @@ static void clk_change_rate(struct clk_core *core)
 {
 	struct clk_core *child;
 	struct hlist_node *tmp;
-	unsigned long old_rate;
-	unsigned long best_parent_rate = 0;
+	u64 old_rate;
+	u64 best_parent_rate = 0;
 	bool skip_set_rate = false;
 	struct clk_core *old_parent;
 	struct clk_core *parent = NULL;
@@ -2310,11 +2474,10 @@ static void clk_change_rate(struct clk_core *core)
 	clk_pm_runtime_put(core);
 }
 
-static unsigned long clk_core_req_round_rate_nolock(struct clk_core *core,
-						     unsigned long req_rate)
+static u64 clk_core_req_round_rate_nolock(struct clk_core *core, u64 req_rate)
 {
 	int ret, cnt;
-	struct clk_rate_request req;
+	struct clk_rate_request_64 req;
 
 	lockdep_assert_held(&prepare_lock);
 
@@ -2336,11 +2499,10 @@ static unsigned long clk_core_req_round_rate_nolock(struct clk_core *core,
 	return ret ? 0 : req.rate;
 }
 
-static int clk_core_set_rate_nolock(struct clk_core *core,
-				    unsigned long req_rate)
+static int clk_core_set_rate_nolock(struct clk_core *core, u64 req_rate)
 {
 	struct clk_core *top, *fail_clk;
-	unsigned long rate;
+	u64 rate;
 	int ret;
 
 	if (!core)
@@ -2406,13 +2568,16 @@ static int clk_core_set_rate_nolock(struct clk_core *core,
  *
  * Returns 0 on success, -EERROR otherwise.
  */
-int clk_set_rate(struct clk *clk, unsigned long rate)
+int clk_set_rate_64(struct clk *clk, u64 rate)
 {
 	int ret;
 
 	if (!clk)
 		return 0;
 
+	if (!clk_core_supports_rate(clk->core, rate))
+		return -EINVAL;
+
 	/* prevent racing with updates to the clock topology */
 	clk_prepare_lock();
 
@@ -2428,6 +2593,12 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(clk_set_rate_64);
+
+int clk_set_rate(struct clk *clk, unsigned long rate)
+{
+	return clk_set_rate_64(clk, rate);
+}
 EXPORT_SYMBOL_GPL(clk_set_rate);
 
 /**
@@ -2449,13 +2620,16 @@ EXPORT_SYMBOL_GPL(clk_set_rate);
  *
  * Returns 0 on success, -EERROR otherwise.
  */
-int clk_set_rate_exclusive(struct clk *clk, unsigned long rate)
+int clk_set_rate_exclusive_64(struct clk *clk, u64 rate)
 {
 	int ret;
 
 	if (!clk)
 		return 0;
 
+	if (!clk_core_supports_rate(clk->core, rate))
+		return -EINVAL;
+
 	/* prevent racing with updates to the clock topology */
 	clk_prepare_lock();
 
@@ -2475,24 +2649,34 @@ int clk_set_rate_exclusive(struct clk *clk, unsigned long rate)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(clk_set_rate_exclusive_64);
+
+int clk_set_rate_exclusive(struct clk *clk, unsigned long rate)
+{
+	return clk_set_rate_exclusive_64(clk, rate);
+}
 EXPORT_SYMBOL_GPL(clk_set_rate_exclusive);
 
-static int clk_set_rate_range_nolock(struct clk *clk,
-				     unsigned long min,
-				     unsigned long max)
+static int clk_set_rate_range_nolock(struct clk *clk, u64 min, u64 max)
 {
 	int ret = 0;
-	unsigned long old_min, old_max, rate;
+	u64 old_min, old_max, rate;
 
 	lockdep_assert_held(&prepare_lock);
 
 	if (!clk)
 		return 0;
 
+	if (!clk_core_supports_rate(clk->core, min))
+		return -EINVAL;
+
+	if (!clk_core_supports_rate(clk->core, max))
+		return -EINVAL;
+
 	trace_clk_set_rate_range(clk->core, min, max);
 
 	if (min > max) {
-		pr_err("%s: clk %s dev %s con %s: invalid range [%lu, %lu]\n",
+		pr_err("%s: clk %s dev %s con %s: invalid range [%llu, %llu]\n",
 		       __func__, clk->core->name, clk->dev_id, clk->con_id,
 		       min, max);
 		return -EINVAL;
@@ -2556,7 +2740,7 @@ static int clk_set_rate_range_nolock(struct clk *clk,
  *
  * Return: 0 for success or negative errno on failure.
  */
-int clk_set_rate_range(struct clk *clk, unsigned long min, unsigned long max)
+int clk_set_rate_range_64(struct clk *clk, u64 min, u64 max)
 {
 	int ret;
 
@@ -2571,6 +2755,14 @@ int clk_set_rate_range(struct clk *clk, unsigned long min, unsigned long max)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(clk_set_rate_range_64);
+
+int clk_set_rate_range(struct clk *clk, unsigned long min, unsigned long max)
+{
+	u64 max_64 = max == CLK_MAX_ABS_RATE ? CLK_MAX_ABS_RATE_64 : max;
+
+	return clk_set_rate_range_64(clk, min, max_64);
+}
 EXPORT_SYMBOL_GPL(clk_set_rate_range);
 
 /**
@@ -2580,14 +2772,20 @@ EXPORT_SYMBOL_GPL(clk_set_rate_range);
  *
  * Returns success (0) or negative errno.
  */
-int clk_set_min_rate(struct clk *clk, unsigned long rate)
+int clk_set_min_rate_64(struct clk *clk, u64 rate)
 {
 	if (!clk)
 		return 0;
 
 	trace_clk_set_min_rate(clk->core, rate);
 
-	return clk_set_rate_range(clk, rate, clk->max_rate);
+	return clk_set_rate_range_64(clk, rate, clk->max_rate);
+}
+EXPORT_SYMBOL_GPL(clk_set_min_rate_64);
+
+int clk_set_min_rate(struct clk *clk, unsigned long rate)
+{
+	return clk_set_min_rate_64(clk, rate);
 }
 EXPORT_SYMBOL_GPL(clk_set_min_rate);
 
@@ -2598,14 +2796,22 @@ EXPORT_SYMBOL_GPL(clk_set_min_rate);
  *
  * Returns success (0) or negative errno.
  */
-int clk_set_max_rate(struct clk *clk, unsigned long rate)
+int clk_set_max_rate_64(struct clk *clk, u64 rate)
 {
 	if (!clk)
 		return 0;
 
 	trace_clk_set_max_rate(clk->core, rate);
 
-	return clk_set_rate_range(clk, clk->min_rate, rate);
+	return clk_set_rate_range_64(clk, clk->min_rate, rate);
+}
+EXPORT_SYMBOL_GPL(clk_set_max_rate_64);
+
+int clk_set_max_rate(struct clk *clk, unsigned long rate)
+{
+	u64 rate_64 = rate == CLK_MAX_ABS_RATE ? CLK_MAX_ABS_RATE_64 : rate;
+
+	return clk_set_max_rate_64(clk, rate_64);
 }
 EXPORT_SYMBOL_GPL(clk_set_max_rate);
 
@@ -2682,7 +2888,7 @@ static int clk_core_set_parent_nolock(struct clk_core *core,
 {
 	int ret = 0;
 	int p_index = 0;
-	unsigned long p_rate = 0;
+	u64 p_rate = 0;
 
 	lockdep_assert_held(&prepare_lock);
 
@@ -3112,7 +3318,7 @@ static void clk_summary_show_one(struct seq_file *s, struct clk_core *c,
 {
 	int phase;
 
-	seq_printf(s, "%*s%-*s %7d %8d %8d %11lu %10lu ",
+	seq_printf(s, "%*s%-*s %7d %8d %8d %11llu %10lu ",
 		   level * 3 + 1, "",
 		   30 - level * 3, c->name,
 		   c->enable_count, c->prepare_count, c->protect_count,
@@ -3172,7 +3378,7 @@ DEFINE_SHOW_ATTRIBUTE(clk_summary);
 static void clk_dump_one(struct seq_file *s, struct clk_core *c, int level)
 {
 	int phase;
-	unsigned long min_rate, max_rate;
+	u64 min_rate, max_rate;
 
 	clk_core_get_boundaries(c, &min_rate, &max_rate);
 
@@ -3181,9 +3387,9 @@ static void clk_dump_one(struct seq_file *s, struct clk_core *c, int level)
 	seq_printf(s, "\"enable_count\": %d,", c->enable_count);
 	seq_printf(s, "\"prepare_count\": %d,", c->prepare_count);
 	seq_printf(s, "\"protect_count\": %d,", c->protect_count);
-	seq_printf(s, "\"rate\": %lu,", clk_core_get_rate_recalc(c));
-	seq_printf(s, "\"min_rate\": %lu,", min_rate);
-	seq_printf(s, "\"max_rate\": %lu,", max_rate);
+	seq_printf(s, "\"rate\": %llu,", clk_core_get_rate_recalc(c));
+	seq_printf(s, "\"min_rate\": %llu,", min_rate);
+	seq_printf(s, "\"max_rate\": %llu,", max_rate);
 	seq_printf(s, "\"accuracy\": %lu,", clk_core_get_accuracy_recalc(c));
 	phase = clk_core_get_phase(c);
 	if (phase >= 0)
@@ -3444,12 +3650,12 @@ DEFINE_SHOW_ATTRIBUTE(clk_duty_cycle);
 static int clk_min_rate_show(struct seq_file *s, void *data)
 {
 	struct clk_core *core = s->private;
-	unsigned long min_rate, max_rate;
+	u64 min_rate, max_rate;
 
 	clk_prepare_lock();
 	clk_core_get_boundaries(core, &min_rate, &max_rate);
 	clk_prepare_unlock();
-	seq_printf(s, "%lu\n", min_rate);
+	seq_printf(s, "%llu\n", min_rate);
 
 	return 0;
 }
@@ -3458,12 +3664,12 @@ DEFINE_SHOW_ATTRIBUTE(clk_min_rate);
 static int clk_max_rate_show(struct seq_file *s, void *data)
 {
 	struct clk_core *core = s->private;
-	unsigned long min_rate, max_rate;
+	u64 min_rate, max_rate;
 
 	clk_prepare_lock();
 	clk_core_get_boundaries(core, &min_rate, &max_rate);
 	clk_prepare_unlock();
-	seq_printf(s, "%lu\n", max_rate);
+	seq_printf(s, "%llu\n", max_rate);
 
 	return 0;
 }
@@ -3658,7 +3864,7 @@ static int __clk_core_init(struct clk_core *core)
 {
 	int ret;
 	struct clk_core *parent;
-	unsigned long rate;
+	u64 rate;
 	int phase;
 
 	clk_prepare_lock();
@@ -3889,7 +4095,7 @@ static struct clk *alloc_clk(struct clk_core *core, const char *dev_id,
 	clk->core = core;
 	clk->dev_id = dev_id;
 	clk->con_id = kstrdup_const(con_id, GFP_KERNEL);
-	clk->max_rate = ULONG_MAX;
+	clk->max_rate = CLK_MAX_ABS_RATE_64;
 
 	return clk;
 }
@@ -3965,6 +4171,52 @@ struct clk *clk_hw_get_clk(struct clk_hw *hw, const char *con_id)
 }
 EXPORT_SYMBOL(clk_hw_get_clk);
 
+static u64 clk_no64_recalc_rate(struct clk_hw *hw, u64 parent_rate)
+{
+	return hw->core->ops_32->recalc_rate(hw, parent_rate);
+}
+
+static s64 clk_no64_round_rate(struct clk_hw *hw, u64 rate, u64 *parent_rate_64)
+{
+	long parent_rate;
+	long ret;
+
+	parent_rate = *parent_rate_64;
+
+	ret = hw->core->ops_32->round_rate(hw, rate, &parent_rate);
+
+	*parent_rate_64 = parent_rate;
+
+	return ret;
+}
+
+static int clk_no64_determine_rate(struct clk_hw *hw,
+				   struct clk_rate_request_64 *req_64)
+{
+	struct clk_rate_request req;
+	int ret;
+
+	clk_rate_req_from_64(&req, req_64);
+
+	ret = hw->core->ops_32->determine_rate(hw, &req);
+
+	clk_rate_req_to_64(&req, req_64);
+
+	return ret;
+}
+
+static int clk_no64_set_rate(struct clk_hw *hw, u64 rate, u64 parent_rate)
+{
+	return hw->core->ops_32->set_rate(hw, rate, parent_rate);
+}
+
+static int clk_no64_set_rate_and_parent(struct clk_hw *hw, u64 rate,
+					u64 parent_rate, u8 index)
+{
+	return hw->core->ops_32->set_rate_and_parent(hw, rate, parent_rate,
+						     index);
+}
+
 static int clk_cpy_name(const char **dst_p, const char *src, bool must_exist)
 {
 	const char *dst;
@@ -4059,6 +4311,79 @@ static void clk_core_free_parent_map(struct clk_core *core)
 	kfree(core->parents);
 }
 
+static int clk_core_init_ops(struct clk_core *core,
+			     const struct clk_init_data *init)
+{
+	struct clk_ops_64 *ops;
+
+	if (WARN_ON(!init->ops == !init->ops_64))
+		return -EINVAL;
+
+	core->ops_32 = init->ops;
+
+	if (init->ops_64) {
+		core->ops = init->ops_64;
+		core->supports_64 = true;
+		return 0;
+	}
+
+	ops = kzalloc(sizeof(*ops), GFP_KERNEL);
+	if (!ops)
+		return -ENOMEM;
+
+	core->ops = ops;
+
+#define clk_ops_from_32(member) \
+	do { \
+		if (core->ops_32->member) \
+			ops->member = core->ops_32->member; \
+	} while (0)
+
+#define clk_ops_from_32_compat(member) \
+	do { \
+		if (core->ops_32->member) \
+			ops->member = clk_no64_ ## member; \
+	} while (0)
+
+	clk_ops_from_32(prepare);
+	clk_ops_from_32(unprepare);
+	clk_ops_from_32(is_prepared);
+	clk_ops_from_32(unprepare_unused);
+	clk_ops_from_32(enable);
+	clk_ops_from_32(disable);
+	clk_ops_from_32(is_enabled);
+	clk_ops_from_32(disable_unused);
+	clk_ops_from_32(save_context);
+	clk_ops_from_32(restore_context);
+	clk_ops_from_32(get_parent);
+	clk_ops_from_32(set_parent);
+	clk_ops_from_32(recalc_accuracy);
+	clk_ops_from_32(get_phase);
+	clk_ops_from_32(set_phase);
+	clk_ops_from_32(get_duty_cycle);
+	clk_ops_from_32(set_duty_cycle);
+	clk_ops_from_32(init);
+	clk_ops_from_32(terminate);
+	clk_ops_from_32(debug_init);
+
+	clk_ops_from_32_compat(recalc_rate);
+	clk_ops_from_32_compat(round_rate);
+	clk_ops_from_32_compat(determine_rate);
+	clk_ops_from_32_compat(set_rate);
+	clk_ops_from_32_compat(set_rate_and_parent);
+
+#undef clk_ops_from_32
+#undef clk_ops_from_32_compat
+
+	return 0;
+}
+
+static void clk_core_free_ops(struct clk_core *core)
+{
+	if (!core->supports_64)
+		kfree(core->ops);
+}
+
 static struct clk *
 __clk_register(struct device *dev, struct device_node *np, struct clk_hw *hw)
 {
@@ -4085,11 +4410,9 @@ __clk_register(struct device *dev, struct device_node *np, struct clk_hw *hw)
 		goto fail_name;
 	}
 
-	if (WARN_ON(!init->ops)) {
-		ret = -EINVAL;
+	ret = clk_core_init_ops(core, init);
+	if (ret)
 		goto fail_ops;
-	}
-	core->ops = init->ops;
 
 	if (dev && pm_runtime_enabled(dev))
 		core->rpm_enabled = true;
@@ -4101,7 +4424,7 @@ __clk_register(struct device *dev, struct device_node *np, struct clk_hw *hw)
 	core->flags = init->flags;
 	core->num_parents = init->num_parents;
 	core->min_rate = 0;
-	core->max_rate = ULONG_MAX;
+	core->max_rate = CLK_MAX_ABS_RATE_64;
 
 	ret = clk_core_populate_parent_map(core, init);
 	if (ret)
@@ -4135,6 +4458,7 @@ __clk_register(struct device *dev, struct device_node *np, struct clk_hw *hw)
 fail_create_clk:
 	clk_core_free_parent_map(core);
 fail_parents:
+	clk_core_free_ops(core);
 fail_ops:
 	kfree_const(core->name);
 fail_name:
@@ -4226,6 +4550,7 @@ static void __clk_release(struct kref *ref)
 	lockdep_assert_held(&prepare_lock);
 
 	clk_core_free_parent_map(core);
+	clk_core_free_ops(core);
 	kfree_const(core->name);
 	kfree(core);
 }
@@ -4245,8 +4570,7 @@ static void clk_nodrv_disable_unprepare(struct clk_hw *hw)
 	WARN_ON_ONCE(1);
 }
 
-static int clk_nodrv_set_rate(struct clk_hw *hw, unsigned long rate,
-					unsigned long parent_rate)
+static int clk_nodrv_set_rate(struct clk_hw *hw, u64 rate, u64 parent_rate)
 {
 	return -ENXIO;
 }
@@ -4256,7 +4580,7 @@ static int clk_nodrv_set_parent(struct clk_hw *hw, u8 index)
 	return -ENXIO;
 }
 
-static const struct clk_ops clk_nodrv_ops = {
+static const struct clk_ops_64 clk_nodrv_ops = {
 	.enable		= clk_nodrv_prepare_enable,
 	.disable	= clk_nodrv_disable_unprepare,
 	.prepare	= clk_nodrv_prepare_enable,
@@ -4300,7 +4624,7 @@ static void clk_core_evict_parent_cache(struct clk_core *core)
 void clk_unregister(struct clk *clk)
 {
 	unsigned long flags;
-	const struct clk_ops *ops;
+	const struct clk_ops_64 *ops;
 
 	if (!clk || WARN_ON_ONCE(IS_ERR(clk)))
 		return;
@@ -4507,8 +4831,8 @@ void __clk_put(struct clk *clk)
 	hlist_del(&clk->clks_node);
 
 	/* If we had any boundaries on that clock, let's drop them. */
-	if (clk->min_rate > 0 || clk->max_rate < ULONG_MAX)
-		clk_set_rate_range_nolock(clk, 0, ULONG_MAX);
+	if (clk->min_rate > 0 || clk->max_rate < CLK_MAX_ABS_RATE_64)
+		clk_set_rate_range_nolock(clk, 0, CLK_MAX_ABS_RATE_64);
 
 	owner = clk->core->owner;
 	kref_put(&clk->core->ref, __clk_release);
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 267cd06b54a0..e2202076cb0a 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -62,14 +62,54 @@ struct clk_rate_request {
 	struct clk_hw *best_parent_hw;
 };
 
+struct clk_rate_request_64 {
+	u64 rate;
+	u64 min_rate;
+	u64 max_rate;
+	u64 best_parent_rate;
+	struct clk_hw *best_parent_hw;
+};
+
+static inline void clk_rate_req_to_64(const struct clk_rate_request *req,
+				      struct clk_rate_request_64 *req_64)
+{
+	if (WARN_ON(!req || !req_64))
+		return;
+
+	req_64->rate = req->rate;
+	req_64->min_rate = req->min_rate;
+	req_64->best_parent_rate = req->best_parent_rate;
+	req_64->best_parent_hw = req->best_parent_hw;
+}
+
+static inline void clk_rate_req_from_64(struct clk_rate_request *req,
+					const struct clk_rate_request_64 *req_64)
+{
+	if (WARN_ON(!req || !req_64))
+		return;
+
+	req->rate = req_64->rate;
+	req->min_rate = req_64->min_rate;
+	req->best_parent_rate = req_64->best_parent_rate;
+	req->best_parent_hw = req_64->best_parent_hw;
+}
+
 void clk_hw_init_rate_request(const struct clk_hw *hw,
 			      struct clk_rate_request *req,
 			      unsigned long rate);
+void clk_hw_init_rate_request_64(const struct clk_hw *hw,
+				 struct clk_rate_request_64 *req,
+				 u64 rate);
 void clk_hw_forward_rate_request(const struct clk_hw *core,
 				 const struct clk_rate_request *old_req,
 				 const struct clk_hw *parent,
 				 struct clk_rate_request *req,
 				 unsigned long parent_rate);
+void clk_hw_forward_rate_request_64(const struct clk_hw *core,
+				    const struct clk_rate_request_64 *old_req,
+				    const struct clk_hw *parent,
+				    struct clk_rate_request_64 *req,
+				    u64 parent_rate);
 
 /**
  * struct clk_duty - Struture encoding the duty cycle ratio of a clock
@@ -266,6 +306,42 @@ struct clk_ops {
 	void		(*debug_init)(struct clk_hw *hw, struct dentry *dentry);
 };
 
+struct clk_ops_64 {
+	int		(*prepare)(struct clk_hw *hw);
+	void		(*unprepare)(struct clk_hw *hw);
+	int		(*is_prepared)(struct clk_hw *hw);
+	void		(*unprepare_unused)(struct clk_hw *hw);
+	int		(*enable)(struct clk_hw *hw);
+	void		(*disable)(struct clk_hw *hw);
+	int		(*is_enabled)(struct clk_hw *hw);
+	void		(*disable_unused)(struct clk_hw *hw);
+	int		(*save_context)(struct clk_hw *hw);
+	void		(*restore_context)(struct clk_hw *hw);
+	u64		(*recalc_rate)(struct clk_hw *hw, u64 parent_rate);
+	s64		(*round_rate)(struct clk_hw *hw, u64 rate,
+				      u64 *parent_rate);
+	int		(*determine_rate)(struct clk_hw *hw,
+					  struct clk_rate_request_64 *req);
+	int		(*set_parent)(struct clk_hw *hw, u8 index);
+	u8		(*get_parent)(struct clk_hw *hw);
+	int		(*set_rate)(struct clk_hw *hw, u64 rate,
+				    u64 parent_rate);
+	int		(*set_rate_and_parent)(struct clk_hw *hw,
+					       u64 rate,
+					       u64 parent_rate, u8 index);
+	unsigned long	(*recalc_accuracy)(struct clk_hw *hw,
+					   unsigned long parent_accuracy);
+	int		(*get_phase)(struct clk_hw *hw);
+	int		(*set_phase)(struct clk_hw *hw, int degrees);
+	int		(*get_duty_cycle)(struct clk_hw *hw,
+					  struct clk_duty *duty);
+	int		(*set_duty_cycle)(struct clk_hw *hw,
+					  struct clk_duty *duty);
+	int		(*init)(struct clk_hw *hw);
+	void		(*terminate)(struct clk_hw *hw);
+	void		(*debug_init)(struct clk_hw *hw, struct dentry *dentry);
+};
+
 /**
  * struct clk_parent_data - clk parent information
  * @hw: parent clk_hw pointer (used for clk providers with internal clks)
@@ -297,6 +373,7 @@ struct clk_parent_data {
 struct clk_init_data {
 	const char		*name;
 	const struct clk_ops	*ops;
+	const struct clk_ops_64	*ops_64;
 	/* Only one of the following three should be assigned */
 	const char		* const *parent_names;
 	const struct clk_parent_data	*parent_data;
@@ -1297,6 +1374,7 @@ int clk_hw_get_parent_index(struct clk_hw *hw);
 int clk_hw_set_parent(struct clk_hw *hw, struct clk_hw *new_parent);
 unsigned int __clk_get_enable_count(struct clk *clk);
 unsigned long clk_hw_get_rate(const struct clk_hw *hw);
+u64 clk_hw_get_rate_64(const struct clk_hw *hw);
 unsigned long clk_hw_get_flags(const struct clk_hw *hw);
 #define clk_hw_can_set_rate_parent(hw) \
 	(clk_hw_get_flags((hw)) & CLK_SET_RATE_PARENT)
@@ -1308,17 +1386,28 @@ bool __clk_is_enabled(struct clk *clk);
 struct clk *__clk_lookup(const char *name);
 int __clk_mux_determine_rate(struct clk_hw *hw,
 			     struct clk_rate_request *req);
+int __clk_mux_determine_rate_64(struct clk_hw *hw,
+				struct clk_rate_request_64 *req);
 int __clk_determine_rate(struct clk_hw *core, struct clk_rate_request *req);
+int __clk_determine_rate_64(struct clk_hw *core,
+			    struct clk_rate_request_64 *req);
 int __clk_mux_determine_rate_closest(struct clk_hw *hw,
 				     struct clk_rate_request *req);
+int __clk_mux_determine_rate_closest_64(struct clk_hw *hw,
+					struct clk_rate_request_64 *req);
 int clk_mux_determine_rate_flags(struct clk_hw *hw,
 				 struct clk_rate_request *req,
 				 unsigned long flags);
+int clk_mux_determine_rate_flags_64(struct clk_hw *hw,
+				    struct clk_rate_request_64 *req,
+				    unsigned long flags);
 void clk_hw_reparent(struct clk_hw *hw, struct clk_hw *new_parent);
 void clk_hw_get_rate_range(struct clk_hw *hw, unsigned long *min_rate,
 			   unsigned long *max_rate);
+void clk_hw_get_rate_range_64(struct clk_hw *hw, u64 *min_rate, u64 *max_rate);
 void clk_hw_set_rate_range(struct clk_hw *hw, unsigned long min_rate,
 			   unsigned long max_rate);
+void clk_hw_set_rate_range_64(struct clk_hw *hw, u64 min_rate, u64 max_rate);
 
 static inline void __clk_hw_set_clk(struct clk_hw *dst, struct clk_hw *src)
 {
@@ -1350,6 +1439,7 @@ static inline long divider_ro_round_rate(struct clk_hw *hw, unsigned long rate,
  * FIXME clock api without lock protection
  */
 unsigned long clk_hw_round_rate(struct clk_hw *hw, unsigned long rate);
+u64 clk_hw_round_rate_64(struct clk_hw *hw, u64 rate);
 
 struct clk_onecell_data {
 	struct clk **clks;
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 1ef013324237..f9ebf826636f 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -72,6 +72,8 @@ struct clk_notifier_data {
 	struct clk		*clk;
 	unsigned long		old_rate;
 	unsigned long		new_rate;
+	u64			old_rate_64;
+	u64			new_rate_64;
 };
 
 /**
@@ -680,6 +682,7 @@ void clk_bulk_disable(int num_clks, const struct clk_bulk_data *clks);
  * @clk: clock source
  */
 unsigned long clk_get_rate(struct clk *clk);
+u64 clk_get_rate_64(struct clk *clk);
 
 /**
  * clk_put	- "free" the clock source
@@ -759,6 +762,7 @@ void devm_clk_put(struct device *dev, struct clk *clk);
  * Returns rounded clock rate in Hz, or negative errno.
  */
 long clk_round_rate(struct clk *clk, unsigned long rate);
+s64 clk_round_rate_64(struct clk *clk, u64 rate);
 
 /**
  * clk_set_rate - set the clock rate for a clock source
@@ -771,6 +775,7 @@ long clk_round_rate(struct clk *clk, unsigned long rate);
  * Returns success (0) or negative errno.
  */
 int clk_set_rate(struct clk *clk, unsigned long rate);
+int clk_set_rate_64(struct clk *clk, u64 rate);
 
 /**
  * clk_set_rate_exclusive- set the clock rate and claim exclusivity over
@@ -788,6 +793,7 @@ int clk_set_rate(struct clk *clk, unsigned long rate);
  * Returns success (0) or negative errno.
  */
 int clk_set_rate_exclusive(struct clk *clk, unsigned long rate);
+int clk_set_rate_exclusive_64(struct clk *clk, u64 rate);
 
 /**
  * clk_has_parent - check if a clock is a possible parent for another
@@ -810,6 +816,7 @@ bool clk_has_parent(const struct clk *clk, const struct clk *parent);
  * Returns success (0) or negative errno.
  */
 int clk_set_rate_range(struct clk *clk, unsigned long min, unsigned long max);
+int clk_set_rate_range_64(struct clk *clk, u64 min, u64 max);
 
 /**
  * clk_set_min_rate - set a minimum clock rate for a clock source
@@ -819,6 +826,7 @@ int clk_set_rate_range(struct clk *clk, unsigned long min, unsigned long max);
  * Returns success (0) or negative errno.
  */
 int clk_set_min_rate(struct clk *clk, unsigned long rate);
+int clk_set_min_rate_64(struct clk *clk, u64 rate);
 
 /**
  * clk_set_max_rate - set a maximum clock rate for a clock source
@@ -828,6 +836,7 @@ int clk_set_min_rate(struct clk *clk, unsigned long rate);
  * Returns success (0) or negative errno.
  */
 int clk_set_max_rate(struct clk *clk, unsigned long rate);
+int clk_set_max_rate_64(struct clk *clk, u64 rate);
 
 /**
  * clk_set_parent - set the parent clock source for this clock
@@ -1004,21 +1013,41 @@ static inline unsigned long clk_get_rate(struct clk *clk)
 	return 0;
 }
 
+u64 clk_get_rate_64(struct clk *clk)
+{
+	return 0;
+}
+
 static inline int clk_set_rate(struct clk *clk, unsigned long rate)
 {
 	return 0;
 }
 
+int clk_set_rate_64(struct clk *clk, u64 rate)
+{
+	return 0;
+}
+
 static inline int clk_set_rate_exclusive(struct clk *clk, unsigned long rate)
 {
 	return 0;
 }
 
+int clk_set_rate_exclusive_64(struct clk *clk, u64 rate)
+{
+	return 0;
+}
+
 static inline long clk_round_rate(struct clk *clk, unsigned long rate)
 {
 	return 0;
 }
 
+s64 clk_round_rate_64(struct clk *clk, u64 rate)
+{
+	return 0;
+}
+
 static inline bool clk_has_parent(struct clk *clk, struct clk *parent)
 {
 	return true;
@@ -1030,16 +1059,31 @@ static inline int clk_set_rate_range(struct clk *clk, unsigned long min,
 	return 0;
 }
 
+int clk_set_rate_range_64(struct clk *clk, u64 min, u64 max)
+{
+	return 0;
+}
+
 static inline int clk_set_min_rate(struct clk *clk, unsigned long rate)
 {
 	return 0;
 }
 
+int clk_set_min_rate_64(struct clk *clk, u64 rate)
+{
+	return 0;
+}
+
 static inline int clk_set_max_rate(struct clk *clk, unsigned long rate)
 {
 	return 0;
 }
 
+int clk_set_max_rate_64(struct clk *clk, u64 rate)
+{
+	return 0;
+}
+
 static inline int clk_set_parent(struct clk *clk, struct clk *parent)
 {
 	return 0;
-- 
2.38.1

