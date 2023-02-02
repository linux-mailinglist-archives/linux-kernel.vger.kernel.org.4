Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278D768772D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 09:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjBBIUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 03:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjBBIUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 03:20:45 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4198349A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 00:20:45 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id e10-20020a17090a630a00b0022bedd66e6dso4851958pjj.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 00:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DIcuUiiD/SBGnIgaWh9h7tdpch/KAXjOE7i0nNR5sBg=;
        b=bavLq+RrC+kxjPPcdrbN+TxKPZ/oy996YNrl+gPTSl6aIelDmWWiK0ZbnTy9P5lVRf
         TR9VXV1ywAjmK5xeA6iau58arLHAdcP/4ubbpDPnj8RyIUEsCWVaGT9dF1Papgp6rQig
         ZeMLiWJNzKwOL2QfJPiwee0zLKmjomIIWm8QlU6mdQcWS/MA4DO9br58WxkoNrNg1h9v
         yyw18cifRidBJ8uDKXnCvwdHfMtjyVHjVoFRy0JQKAZ1e14Kuij2wSlLyaxflNute/mb
         I4ughYaQEffqcPOATrx6wWXX1roQB9e51llMaB/nIMKZsTc/TVRekFbWDp9hlP3j06e1
         Wpmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIcuUiiD/SBGnIgaWh9h7tdpch/KAXjOE7i0nNR5sBg=;
        b=BjUeSf+pIMsinvDdIAJchrR9kKIULzzqfrIFHSb+nDnefWoxlJGpu24EJGDow1YGH1
         FJr0uhOdms4cKSgBX98xfLyso+z5O0kWipNNOc54oD/MoaW611AgBijBPYfndvyoHBgB
         +fUudRzllm1Tmp1v8tBu7y0HqWxz1uvIYUESeqs2IDPTHfI0sd/28rv/m0kUM7M82B32
         HC4KrlwERW6uWrzywi2hvvpycUbDRcTyi6Ol/tdVySI8ZCIGBUezek7HvFTfMdMYZZPa
         FlSm50VWqPZVe8PcfzT7T5GhNoGWaR+K8+z936SKP8vDy6V38XZFn0R26GVRQ0WUPJ2N
         eTMQ==
X-Gm-Message-State: AO0yUKVVdZJ83kmYzGRLEg0l5r24fD2zqehgk1EJVz0BNZ9PnfcZ+0rX
        bMVJ0k8AWlhSr18RwFv68lvSbZVzgHJKGZ6i
X-Google-Smtp-Source: AK7set9h/+kDyAmkJhJAUwYxodSQR95dRZRvKb1M0umFvwFLRRIcZIkStEhQCdTLV3UVW0WnmsUqtw==
X-Received: by 2002:a17:90a:bf04:b0:22c:90bd:18a4 with SMTP id c4-20020a17090abf0400b0022c90bd18a4mr5658032pjs.22.1675326044732;
        Thu, 02 Feb 2023 00:20:44 -0800 (PST)
Received: from mi-HP-ProDesk-680-G4-MT.mioffice.cn ([43.224.245.237])
        by smtp.gmail.com with ESMTPSA id j5-20020a17090a694500b0022c2e29cadbsm2578563pjm.45.2023.02.02.00.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 00:20:44 -0800 (PST)
From:   qixiaoyu1 <qxy65535@gmail.com>
X-Google-Original-From: qixiaoyu1 <qixiaoyu1@xiaomi.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Ping Xiong <xiongping1@xiaomi.com>,
        Xiaoyu Qi <qixiaoyu1@xiaomi.com>
Subject: [PATCH 1/2 v3] f2fs: fix wrong calculation of block age
Date:   Thu,  2 Feb 2023 16:20:27 +0800
Message-Id: <20230202082028.9013-1-qixiaoyu1@xiaomi.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <938a8e61-4e47-1acc-938c-c90d213d2c86@kernel.org>
References: <938a8e61-4e47-1acc-938c-c90d213d2c86@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we wrongly calculate the new block age to
old * LAST_AGE_WEIGHT / 100.

Fix it to new * (100 - LAST_AGE_WEIGHT) / 100
                + old * LAST_AGE_WEIGHT / 100.

Signed-off-by: qixiaoyu1 <qixiaoyu1@xiaomi.com>
Signed-off-by: xiongping1 <xiongping1@xiaomi.com>
---
Change log v1 -> v2:
 - fix udiv
Change log v2 -> v3:
 - keep the accuracy with div_u64_rem

 fs/f2fs/extent_cache.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 342af24b2f8c..d9f12f404beb 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -874,11 +874,18 @@ void f2fs_update_read_extent_tree_range_compressed(struct inode *inode,
 static unsigned long long __calculate_block_age(unsigned long long new,
 						unsigned long long old)
 {
-	unsigned long long diff;
+	unsigned int rem_old, rem_new;
+	unsigned long long res;
 
-	diff = (new >= old) ? new - (new - old) : new + (old - new);
+	res = div_u64_rem(new, 100, &rem_new) * (100 - LAST_AGE_WEIGHT)
+		+ div_u64_rem(old, 100, &rem_old) * LAST_AGE_WEIGHT;
 
-	return div_u64(diff * LAST_AGE_WEIGHT, 100);
+	if (rem_new)
+		res += rem_new * (100 - LAST_AGE_WEIGHT) / 100;
+	if (rem_old)
+		res += rem_old * LAST_AGE_WEIGHT / 100;
+
+	return res;
 }
 
 /* This returns a new age and allocated blocks in ei */
-- 
2.39.0

