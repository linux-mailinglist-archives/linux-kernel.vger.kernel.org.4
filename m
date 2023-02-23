Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C716A001C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 01:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbjBWAdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 19:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbjBWAdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 19:33:39 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76877BDC0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 16:33:33 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id o8so1687221ilt.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 16:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qiIzKPUUv1iOBvt89lezv2ZkxW0me3bA2w+4a4Beaic=;
        b=GWyY4rZFZfGpPzhK85+Z+BwjVqx0BpQlR+0EWmWrNvYWB8wBv2bbTCIS0hGnMZddnK
         iYoMAChm4bOGN4vrjGzZOjRlmncGITBJYIYHqanYnwSXTCkaQaTscCbs3fBUDlYxDXZy
         Zvck5NfCqSZA823aFXCvFrsza9T31uScMlyeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qiIzKPUUv1iOBvt89lezv2ZkxW0me3bA2w+4a4Beaic=;
        b=K0GlOEeIKu/yxcCItBzOgp1kJM/zYIeln6qs1B1ssj64+E4MUreT/6bCfwruzxXydZ
         CGKnuYnnI4lVvVvN8MYixY7uhhZ60DoUEe38HpdmkDsxy71qSytGUBVpbJKb1EiawT2f
         8cPWaVz9PdHtPCpaQnZuEk9Ap5gkOHS8q2aRbR7pyYaMBn0coTyRv/h4Qgq1sIbTW+G6
         SvdvFpUygEQ5ujncDoUvRrwGU/dAOOnZZw5+xiBGswxiaTZxNVVCQrcSvj/+B923V2rJ
         V+Jx13LjNbVNEdL9p8BpgI8kTf50wdH58ws5/9zY0fyNlBLqQHwGiGzPieGQPhZYO6CH
         iuhA==
X-Gm-Message-State: AO0yUKXlk5rNI6MUwLLb94BHspgqJ5V5t5c0OQkH7Lb5rJdC9Se72qRM
        3Go9doUoZS22ZGt/CJHcWplsiA==
X-Google-Smtp-Source: AK7set/rmH/TlXj8qh9JFNfXaNQWInM2+f4FvMLa/adCywpEj3qZrR3M4gGYv5Nj6JRYXZzzxDnYiw==
X-Received: by 2002:a05:6e02:16ce:b0:315:4f52:213e with SMTP id 14-20020a056e0216ce00b003154f52213emr11753440ilx.12.1677112412865;
        Wed, 22 Feb 2023 16:33:32 -0800 (PST)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id z25-20020a02ceb9000000b003c5170ddcedsm1152044jaq.110.2023.02.22.16.33.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 16:33:32 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>, stable@vger.kernel.org
Subject: [PATCH v2] regulator: core: Use ktime_get_boottime() to determine how long a regulator was off
Date:   Thu, 23 Feb 2023 00:33:30 +0000
Message-Id: <20230223003301.v2.1.I9719661b8eb0a73b8c416f9c26cf5bd8c0563f99@changeid>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,TVD_PH_BODY_ACCOUNTS_PRE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For regulators with 'off-on-delay-us' the regulator framework currently
uses ktime_get() to determine how long the regulator has been off
before re-enabling it (after a delay if needed). A problem with using
ktime_get() is that it doesn't account for the time the system is
suspended. As a result a regulator with a longer 'off-on-delay' (e.g.
500ms) that was switched off during suspend might still incurr in a
delay on resume before it is re-enabled, even though the regulator
might have been off for hours. ktime_get_boottime() accounts for
suspend time, use it instead of ktime_get().

Fixes: a8ce7bd89689 ("regulator: core: Fix off_on_delay handling")
Cc: stable@vger.kernel.org    # 5.13+
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
The issue already existed before the commit in the 'Fixes' tag, but
it's probably not worth backporting this to older kernels that
use jiffies instead of ktime.

Changes in v2:
- added 'Fixes' and Cc: stable tags
- added 'Reviewed-by' tag from Stephen

 drivers/regulator/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index ae69e493913d..4fcd36055b02 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1584,7 +1584,7 @@ static int set_machine_constraints(struct regulator_dev *rdev)
 	}
 
 	if (rdev->desc->off_on_delay)
-		rdev->last_off = ktime_get();
+		rdev->last_off = ktime_get_boottime();
 
 	/* If the constraints say the regulator should be on at this point
 	 * and we have control then make sure it is enabled.
@@ -2673,7 +2673,7 @@ static int _regulator_do_enable(struct regulator_dev *rdev)
 		 * this regulator was disabled.
 		 */
 		ktime_t end = ktime_add_us(rdev->last_off, rdev->desc->off_on_delay);
-		s64 remaining = ktime_us_delta(end, ktime_get());
+		s64 remaining = ktime_us_delta(end, ktime_get_boottime());
 
 		if (remaining > 0)
 			_regulator_delay_helper(remaining);
@@ -2912,7 +2912,7 @@ static int _regulator_do_disable(struct regulator_dev *rdev)
 	}
 
 	if (rdev->desc->off_on_delay)
-		rdev->last_off = ktime_get();
+		rdev->last_off = ktime_get_boottime();
 
 	trace_regulator_disable_complete(rdev_get_name(rdev));
 
-- 
2.39.2.722.g9855ee24e9-goog

