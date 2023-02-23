Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2006A0A82
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 14:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234566AbjBWN2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 08:28:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbjBWN2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 08:28:24 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F246456786
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 05:28:20 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id z10so5621816pgr.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 05:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1677158900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8oNy9C+Y/zmSEnFHZueuiP36FW/sue7PAxuyUaJKNA=;
        b=P9pp+ZyMjawowl2CXNZ8AfWA4FDgA5DbRRV8Xgup0TXSnw3gGKc4YOluAUAPyTi+8N
         Eowu4hN9SdqhC2D6NScYL5anKi0WPpJZ/kDZVTjDQu+/GSTSXQemisE6KgdRU/vueJCH
         m5Z2d5bsrBDjNoX+11dfufhV13nj8waePZO9KexhDHGlwIWF2Eic+82YX2EcOzsUP/aF
         sdp2wkR1m8GXzkKkL1ndWZsnYALrWwQQa3JIsN3tgm5LwRWjlG9XLi3n5hjONfp4f/gx
         actRJ9hq1VYMZLcfQYjdow3np6b8hCQxlhtnE9rDWirXh8AxOKVOLv1vhYi0fp0ratLL
         LzNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677158900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B8oNy9C+Y/zmSEnFHZueuiP36FW/sue7PAxuyUaJKNA=;
        b=5fyNi3WQxSYT8wAa44gvho+9UWGId/lurvmJ5HLQcO+5h+0jTQ/LXBZaJGQ5ssmw9P
         wpOGSR5lJla6nMRKW0ktDCQhm8QkLUm4rNDU9zee8f0rAVOwAqj0Bva3Ngrp7hkHd6aM
         mcYPtWYnUj/xgnSU3QZFthxJ7ZxtmPdDBF1hWqDpBlkU262UzAOBTQjTEUrrcbXFRlnY
         uDF78BJewJiuG5XqbDqFUiAOCvpE1mAWwh6eKwlVFpGDp+eBJV84lO7rwqFS0t+jA4M+
         WlYEu5zvHoM2cJdGBwBdvlzwq+9SK2exSURwjMTwBxmziIK74Sbn/+NMnjCdyvRvlUDO
         totQ==
X-Gm-Message-State: AO0yUKXTs+gPEeZDfcgqj7hhDMGHoktlXNCvdwNEYbvovkdqmCib7vHB
        PUDQ4bagfSo+/0LjIvebcQevsA==
X-Google-Smtp-Source: AK7set/qxxKJpUWiKsq4lL0Upj2vUZx+VL5loQcaP10700XUcw0lQhPoWvn8hF2CG9W/WlEr4c7i8A==
X-Received: by 2002:a05:6a00:2e83:b0:5d9:bfc9:a4f with SMTP id fd3-20020a056a002e8300b005d9bfc90a4fmr3754231pfb.3.1677158900390;
        Thu, 23 Feb 2023 05:28:20 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id g18-20020aa78752000000b005a9bf65b591sm3848591pfo.135.2023.02.23.05.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 05:28:20 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tkhai@ya.ru, hannes@cmpxchg.org,
        shakeelb@google.com, mhocko@kernel.org, roman.gushchin@linux.dev,
        muchun.song@linux.dev, david@redhat.com, shy828301@gmail.com
Cc:     sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 5/7] mm: vmscan: hold write lock to reparent shrinker nr_deferred
Date:   Thu, 23 Feb 2023 21:27:23 +0800
Message-Id: <20230223132725.11685-6-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230223132725.11685-1-zhengqi.arch@bytedance.com>
References: <20230223132725.11685-1-zhengqi.arch@bytedance.com>
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

For now, reparent_shrinker_deferred() is the only holder
of read lock of shrinker_rwsem. And it already holds the
global cgroup_mutex, so it will not be called in parallel.

Therefore, in order to convert shrinker_rwsem to shrinker_mutex
later, here we change to hold the write lock of shrinker_rwsem
to reparent.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/vmscan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 25a4a660e45f..89602e97583a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -450,7 +450,7 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
 		parent = root_mem_cgroup;
 
 	/* Prevent from concurrent shrinker_info expand */
-	down_read(&shrinker_rwsem);
+	down_write(&shrinker_rwsem);
 	for_each_node(nid) {
 		child_info = shrinker_info_protected(memcg, nid);
 		parent_info = shrinker_info_protected(parent, nid);
@@ -459,7 +459,7 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
 			atomic_long_add(nr, &parent_info->nr_deferred[i]);
 		}
 	}
-	up_read(&shrinker_rwsem);
+	up_write(&shrinker_rwsem);
 }
 
 static bool cgroup_reclaim(struct scan_control *sc)
-- 
2.20.1

