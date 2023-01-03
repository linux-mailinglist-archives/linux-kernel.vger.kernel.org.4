Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9430665BD16
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 10:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237021AbjACJYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 04:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237217AbjACJXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 04:23:37 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7495E117A
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 01:23:36 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id o31-20020a17090a0a2200b00223fedffb30so30514668pjo.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 01:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AaEgQoi2wV88iETdzvSp20U7Cda3EBi9Iq1BYplBC3U=;
        b=fRKiuLLPQXtm+PoLAnEO0C/uRszb5OZg3YHcvW2RCgSXdgYSqmUNIVOR6Yw5IkkkHr
         +QjxZ3RVzCBOcOirYxxHt0r1WoqCp6tPnX+mb/UoZ6kAIx7Lm+E/ou+rSr9EZ2qoQeD6
         bIpAN5WyNbnUdEwIzQE/O3pT9ZYGzuzsfHPQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AaEgQoi2wV88iETdzvSp20U7Cda3EBi9Iq1BYplBC3U=;
        b=19qMB9joEmmZ2AW96rWeew+nbSMU55Kmf2zjt+GNO72oyZSO4YVNmupy2MasoLLBzq
         Gdq9mMNKkSeigm6iZaMYi3BK+tvgGWib3+JVK7UGPLCTJB6xHG1nIf0yw+21z7z5UHhp
         l5tdZ7h3kFR282+oLYPyM3nk0956lpT2bWzF94Ri74Hzl4dsfs3bHgxcsM6ieqAkv9zC
         eKgoPh82sncbD1ceJT6gkUeMMwwm/gsPm5/5t+esKMXWEQkJD+tBFQLlKNT+Z8Mdvel3
         R6kKCrLwErh28kZyi/kLSB/64JJSaqo0QcUXY9RZcIRBYM3Mp71CvTnEH5r13tkgwuEM
         itsw==
X-Gm-Message-State: AFqh2kqYGFanhC8FN8NakE+aqp6u5mHuZGOPF4Hmi+XHeT506FFiAlXV
        CdP8+V1prrqh5h+PtBXjG+Pxxw==
X-Google-Smtp-Source: AMrXdXscvLpHbGWlFWU5ZkobIrKEQnk7OF5Eruk64rC/Zl69xEwyZqBgAT2SpMsWhcqVpsg57yVxIg==
X-Received: by 2002:a17:902:f112:b0:189:9ee0:cc8e with SMTP id e18-20020a170902f11200b001899ee0cc8emr40941085plb.57.1672737815982;
        Tue, 03 Jan 2023 01:23:35 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:96d9:31a:590:4d72])
        by smtp.gmail.com with ESMTPSA id y126-20020a636484000000b0049f5da82b12sm6868632pgb.93.2023.01.03.01.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 01:23:35 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] clk: core: Honor CLK_OPS_PARENT_ENABLE in clk_core_is_enabled
Date:   Tue,  3 Jan 2023 17:23:30 +0800
Message-Id: <20230103092330.494102-1-wenst@chromium.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the previous commits that added CLK_OPS_PARENT_ENABLE, support for
this flag was only added to rate change operations (rate setting and
reparent) and disabling unused subtree. It was not added to the
clock gate related operations. Any hardware driver that needs it for
these operations will either see bogus results, or worse, hang.

This has been seen on MT8192 and MT8195, where the imp_ii2_* clk
drivers set this, but dumping debugfs clk_summary would cause it
to hang.

Prepare parent on prepare and enable parent on enable dependencies are
already handled automatically by the core as part of its sequencing.
Whether the case for "enable parent on prepare" should be supported by
this flag or not is not clear, and thus ignored for now.

This change solely fixes the handling of clk_core_is_enabled, i.e.
enabling the parent clock when reading the hardware state. Unfortunately
clk_core_is_enabled is called in a variety of places, sometimes with
the enable clock already held. To avoid deadlocking, the core will
ignore readouts and just return false if CLK_OPS_PARENT_ENABLE is set
but the parent isn't currently enabled.

Fixes: fc8726a2c021 ("clk: core: support clocks which requires parents enable (part 2)")
Fixes: a4b3518d146f ("clk: core: support clocks which requires parents enable (part 1)")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
This is a less invasive version of "clk: core: Honor CLK_OPS_PARENT_ENABLE
for clk gate ops" [1] which caused regressions on i.MX platforms.

My guess is that the i.MX clock driver uses clk_hw_is_enabled() in it's
set_rate callback, in which the new code causes a deadlock.

v3 drops the enable parent on prepare/unprepare bits, as it's unclear
who benefits from it, and the locking is hard to get right. The part in
clk_core_is_enabled() is changed into a bypass path, as described in the
commit message. This fixes the issue I'm seeing, and hopefully doesn't
change the behavior on other platforms.

[1] https://lore.kernel.org/linux-clk/20220822081424.1310926-2-wenst@chromium.org/

 drivers/clk/clk.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index e62552a75f08..496b86e2753c 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -244,6 +244,17 @@ static bool clk_core_is_enabled(struct clk_core *core)
 		}
 	}
 
+	/*
+	 * This could be called with the enable lock held, or from atomic
+	 * context. If the parent isn't enabled already, we can't do
+	 * anything here. We can also assume this clock isn't enabled.
+	 */
+	if ((core->flags & CLK_OPS_PARENT_ENABLE) && core->parent)
+		if (!clk_core_is_enabled(core->parent)) {
+			ret = false;
+			goto done;
+		}
+
 	ret = core->ops->is_enabled(core->hw);
 done:
 	if (core->rpm_enabled)
-- 
2.39.0.314.g84b9a713c41-goog

