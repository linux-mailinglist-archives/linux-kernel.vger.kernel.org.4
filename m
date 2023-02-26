Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505146A314C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 15:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjBZO4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 09:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjBZOyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 09:54:04 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292599763
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 06:50:04 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id n6so2822311plf.5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 06:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1677422925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6cuoJEo92PScDqgnKjc0MgPFLiMUUPUvBDJj7SgxHo=;
        b=lIKiq8ErtDRmfz+i/ano83moR805w7pQEVFBs5DWz8iogOWtMgCKlWMtTjjG4CUYGf
         qZUEa/ayLAYcSmEePRMBNnD4UMS+HxFoUzmlroe0ZVHuqZ3z2bv2HGbh7Yq0wKCvHk4k
         QE8yyj88IWGiNyUTVZhSPdvEoYldgr4C6pMLd3y42cOtg65TmytTMhFeDnjLzWUSuqD4
         9aNiX3gjRzbrv4MYxQIZGaPfntfaShxVFiNdV3/73U+gNlaqjtHmoW98ZiAC2kGLB21U
         7G4hnPw+a24oAWIJ7kfT7KLIQYmuet0PscCXlnmSZhQ2rIyHh9ik/cyvUbqhLd+kEnv8
         Uwjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677422925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c6cuoJEo92PScDqgnKjc0MgPFLiMUUPUvBDJj7SgxHo=;
        b=NnSkB4euJawKue+gYwn7w1aVgBcrOOIx/1LFZJAunt6QHlVTAT0NtzZk0MFa7TeSS1
         3rpDbrWfSSpMLjz9LrxAoST4Yi7jUqBdYKJFuRIc0evIMxX1yfcxSun60ChsPNlH+2bH
         HYWyfCgbHTPZDaoO4HEK3n2sh8vX4usCIUyoB2YeJG/anMyAHo85h1ITLR+Q9tLrGyBv
         Ta79JOyTic+v61QNC3lpILuELVYQYQmEJ2xuSpJvJHSTD96O2BTs8KI11sTGxT9kJbxz
         mvUFAl+GefHyWwDWNUu1k+5yzrYqbnNkApy4c8+IRMWZhtz+Civ+d1QH6GiKG8qUufpt
         psNw==
X-Gm-Message-State: AO0yUKV3yP3Sxn1qxSxtx/cm6t09wfVUG3NfhZTUypGer4ylaePsl1KX
        Q95oTmmGkKbVeLt9FQhH+m7XwQ==
X-Google-Smtp-Source: AK7set+XvuciT55+1IMf9hAHsturuZDzsZyl61PmuY/3HoeWXaqHrVSGXMTK34S3WOCoi78lnQD8RA==
X-Received: by 2002:a17:902:bb0f:b0:197:8e8e:f15 with SMTP id im15-20020a170902bb0f00b001978e8e0f15mr23385229plb.6.1677422925086;
        Sun, 26 Feb 2023 06:48:45 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id y20-20020a170902ed5400b0019c2cf12d15sm2755589plb.116.2023.02.26.06.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 06:48:44 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tkhai@ya.ru, hannes@cmpxchg.org,
        shakeelb@google.com, mhocko@kernel.org, roman.gushchin@linux.dev,
        muchun.song@linux.dev, david@redhat.com, shy828301@gmail.com
Cc:     sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3 6/8] mm: vmscan: hold write lock to reparent shrinker nr_deferred
Date:   Sun, 26 Feb 2023 22:46:53 +0800
Message-Id: <20230226144655.79778-7-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230226144655.79778-1-zhengqi.arch@bytedance.com>
References: <20230226144655.79778-1-zhengqi.arch@bytedance.com>
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
index 99e852c0ab9e..16ff64813175 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -451,7 +451,7 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
 		parent = root_mem_cgroup;
 
 	/* Prevent from concurrent shrinker_info expand */
-	down_read(&shrinker_rwsem);
+	down_write(&shrinker_rwsem);
 	for_each_node(nid) {
 		child_info = shrinker_info_protected(memcg, nid);
 		parent_info = shrinker_info_protected(parent, nid);
@@ -460,7 +460,7 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
 			atomic_long_add(nr, &parent_info->nr_deferred[i]);
 		}
 	}
-	up_read(&shrinker_rwsem);
+	up_write(&shrinker_rwsem);
 }
 
 static bool cgroup_reclaim(struct scan_control *sc)
-- 
2.20.1

