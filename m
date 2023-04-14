Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625E36E1910
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 02:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjDNAeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 20:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDNAeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 20:34:46 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD11383
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 17:34:44 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id o2so16821305plg.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 17:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681432484; x=1684024484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dK9hVUz2orffoZSnLQ0uN85JKx6BIiwXe++QYrjelFs=;
        b=gCnHcFqqp79fTpuPHK1wuBk7ErKVY2ZIcBq1b/iopBXE9PysQONktZDCg7Cu49sUaO
         fqBoqlZLKd7e3NIlFtDvk5GBmAGZRJmhqGfl0PWjuTD4afgiD3HjfqdGZRfGhI2LcjBf
         LOO6LIpZa2B76parOtem+TsLevXVi/SDvJCXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681432484; x=1684024484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dK9hVUz2orffoZSnLQ0uN85JKx6BIiwXe++QYrjelFs=;
        b=fF8G13Rvt8LdKXtOj10IkdbkZyxz78gfnfi5w/Wc4KduWy8Q4SiJTyQ6OtbEr4/UVD
         5P2a9s81ZW5piSzWn7J+zzqctLb3pOQTYAMAEnF6W4mORrEa98wTciQAdCwEs+OLo3mm
         ZUO9ZIC0P4cr2ERLrbEfOn0NGhQwf/+AiO+SWGngDec8L64ou5s74U8iR+wzZ97tXJ7e
         8AEq9NoIDLuGIDt4g3nyJLqErkiLbzOPIhthKmLP5s2RG2NqHKoUkagHnKVCoVKw0Wtd
         oG/76qyc7Y3brvRlNETOoCXqDv3NOSA/hrPIdZFP0p4VPaxR8PU0RkebwfzTreQsTUWo
         wDNQ==
X-Gm-Message-State: AAQBX9e71rlL0btvLbG+xMTl+pCSbk27XZNCl8OikfzqGUaK9rGqSSoE
        X1Kwkv25q3z7TO7BB+XZbWqLFw==
X-Google-Smtp-Source: AKy350YdtrS06a4KBpbxbNlJiemjt1P2RNhUGLmkm5jwlZzjN7Ce5eBRPNqJONMadr/kNmxP8sITNw==
X-Received: by 2002:a17:90b:788:b0:246:896a:408d with SMTP id l8-20020a17090b078800b00246896a408dmr3842408pjz.14.1681432484191;
        Thu, 13 Apr 2023 17:34:44 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:d555:e8ef:b29c:bd37])
        by smtp.gmail.com with ESMTPSA id u2-20020a17090adb4200b00246cfdb570asm3798151pjx.27.2023.04.13.17.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 17:34:43 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: core: Make regulator_lock_two() logic easier to follow
Date:   Thu, 13 Apr 2023 17:34:17 -0700
Message-ID: <20230413173359.1.I1ae92b25689bd6579952e6d458b79f5f8054a0c9@changeid>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regulator_lock_two() function could be made clearer in the case of
lock contention by having a local variable for each of the held and
contended locks. Let's do that. At the same time, let's use the swap()
function instead of open coding it.

This change is expected to be a no-op and simply improves code
clarity.

Suggested-by: Stephen Boyd <swboyd@chromium.org>
Link: https://lore.kernel.org/r/CAE-0n53Eb1BeDPmjBycXUaQAF4ppiAM6UDWje_jiB9GAmR8MMw@mail.gmail.com
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/regulator/core.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 08726bc0da9d..dc741ac156c3 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -219,7 +219,7 @@ static void regulator_lock_two(struct regulator_dev *rdev1,
 			       struct regulator_dev *rdev2,
 			       struct ww_acquire_ctx *ww_ctx)
 {
-	struct regulator_dev *tmp;
+	struct regulator_dev *held, *contended;
 	int ret;
 
 	ww_acquire_init(ww_ctx, &regulator_ww_class);
@@ -233,25 +233,18 @@ static void regulator_lock_two(struct regulator_dev *rdev1,
 		goto exit;
 	}
 
+	held = rdev1;
+	contended = rdev2;
 	while (true) {
-		/*
-		 * Start of loop: rdev1 was locked and rdev2 was contended.
-		 * Need to unlock rdev1, slowly lock rdev2, then try rdev1
-		 * again.
-		 */
-		regulator_unlock(rdev1);
-
-		ww_mutex_lock_slow(&rdev2->mutex, ww_ctx);
-		rdev2->ref_cnt++;
-		rdev2->mutex_owner = current;
-		ret = regulator_lock_nested(rdev1, ww_ctx);
-
-		if (ret == -EDEADLOCK) {
-			/* More contention; swap which needs to be slow */
-			tmp = rdev1;
-			rdev1 = rdev2;
-			rdev2 = tmp;
-		} else {
+		regulator_unlock(held);
+
+		ww_mutex_lock_slow(&contended->mutex, ww_ctx);
+		contended->ref_cnt++;
+		contended->mutex_owner = current;
+		swap(held, contended);
+		ret = regulator_lock_nested(contended, ww_ctx);
+
+		if (ret != -EDEADLOCK) {
 			WARN_ON(ret);
 			break;
 		}
-- 
2.40.0.634.g4ca3ef3211-goog

