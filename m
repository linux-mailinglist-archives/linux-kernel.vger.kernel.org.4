Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499D05B5CF8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 17:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiILPMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 11:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiILPMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 11:12:45 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445882408C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 08:12:45 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id t3so8905678ply.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 08:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=J2EfS61ET44TCc+3QSfNlPKs8G07uWPFuZhCKqF9mNg=;
        b=lvadD5K3rHg41vyguPIZs3SAs0qNEImqL8auN87u0WS8Do2g67gHhkQT80c2u4gJxA
         RGJOtB8EtMOgz2k4rYvmUvKTGV/3ZnNJse0pcxuUIzu/N0bjKvNPvvyQrk8r6lBIM/Vc
         /BYK8ItrmRLwSa0fnHA5ys3gKpncm5G+gS1pLgs3lBe6c/qMWSFhc9HHeTqDt5crXB58
         dMCmFTlzaspQrnhNv34zGiay22wWatvIt5YpeYR7QmL1bM9UD08RGB/0P0ZxQhU0SQB9
         ht62eIr0wA4e+6jHqXf2Iz80usBeX4hXAurB18Zq4qrO8te4W6M3cFsXgDuoywwHSDvN
         h2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=J2EfS61ET44TCc+3QSfNlPKs8G07uWPFuZhCKqF9mNg=;
        b=KdhT2tZdbWAt1NM2tBxWkcFBgWnSfiGEhryFCbLUGGNqeiq1gXhkd/Uj1Y5rq7L2XN
         hhxhN6gN6nK/47+SmGLjsmi0RNHsMN18H2VTN31I/Dtbk4Z//IHu2KaJoddynA9y7g6i
         GU7UNtXQxaGDkrlWteGWv+PZlyWKb4BBBvODTvoRVEgQYp3xa1dWzVgB9w3KrZHP3brF
         S3Hf5m70XcQm/gx3ZIlDzKD8Bxv73EZlCO6+4HSjF8+S2fWpLP1d0XeNb92+MSB9Xd4V
         +ouUUtHZBUFJk+929GPKVR4l7DqqR/erxMaBUVnUxhnXZWx136CzsmoLjmiUSqaDiBtd
         19dA==
X-Gm-Message-State: ACgBeo2t91u0Y64wB5so5kpqsrNYfl+M3WyKMIyIKKhEVrRR+3USmdWZ
        RyfyoGd/sB/MXhKBOZ7BoA==
X-Google-Smtp-Source: AA6agR6mScOPPWtchxpH7T2XGJUOb+bGqVrhg7PQocFGMCm7j1FNyLGp4fCFo47zYN9F8iYQZqsj5A==
X-Received: by 2002:a17:902:e14c:b0:177:e7be:2ab6 with SMTP id d12-20020a170902e14c00b00177e7be2ab6mr23975827pla.25.1662995564687;
        Mon, 12 Sep 2022 08:12:44 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.3])
        by smtp.gmail.com with ESMTPSA id u16-20020a17090a0c5000b00200b2894648sm5311046pje.52.2022.09.12.08.12.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Sep 2022 08:12:43 -0700 (PDT)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     sj@kernel.org, akpm@linux-foundation.org
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH] mm/damon/sysfs: use the wrapper directly to check if the kdamond is running
Date:   Mon, 12 Sep 2022 23:11:53 +0800
Message-Id: <1662995513-24489-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

We can use the 'damon_sysfs_kdamond_running()' wrapper directly to
check if the kdamond is running in 'damon_sysfs_turn_damon_on()'.

Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 mm/damon/sysfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 7488e27c87c3..84861c4085a5 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2455,8 +2455,7 @@ static int damon_sysfs_turn_damon_on(struct damon_sysfs_kdamond *kdamond)
 	struct damon_ctx *ctx;
 	int err;
 
-	if (kdamond->damon_ctx &&
-			damon_sysfs_ctx_running(kdamond->damon_ctx))
+	if (damon_sysfs_kdamond_running(kdamond))
 		return -EBUSY;
 	if (damon_sysfs_cmd_request.kdamond == kdamond)
 		return -EBUSY;
-- 
2.27.0

