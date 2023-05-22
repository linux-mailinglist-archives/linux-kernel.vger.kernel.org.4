Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3346370BBB2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbjEVLZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 07:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbjEVLY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:24:29 -0400
Received: from mail-il1-x149.google.com (mail-il1-x149.google.com [IPv6:2607:f8b0:4864:20::149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7390D1FE5
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:21:17 -0700 (PDT)
Received: by mail-il1-x149.google.com with SMTP id e9e14a558f8ab-3379306f979so44383325ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684754473; x=1687346473;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o+eiSCYBIOLnXleM2cPLS0kmVbYB4sF65U+Csvbg0Lg=;
        b=C9EG5Wbh8NAca3HjpjmAkkfiJOSWePs85XQ0SpLIeqp8Y36SY1afe0SjxeJrOVPo6f
         rSTwoLESGNR9S18BZs0XrVxCYBqlhtSsvsgR2iojCBGnj54TMjYktW5nrViLzni0xpfL
         tpHduilcVggl7fPEhrjrec8kFcN7FgXLx/UQvnavGFY3ToTtVRLe8AuaepJNGO46Xg3W
         PKmykBBAg2AmrTeW/xVoMYteYDYOJK3FGm+N6bAky/KArU7NP7tyEyOOlhPbM/CDmkkw
         LJm5ghP/vmQqL+HKiYE2ccHd75NzsmQ8g1/MPJePiH2Y7A0qOXy9H2rvvWXwRBzzaq6i
         gJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684754473; x=1687346473;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o+eiSCYBIOLnXleM2cPLS0kmVbYB4sF65U+Csvbg0Lg=;
        b=i8sUGI+VroEHn3LYDDeCykR9G2yPZ9ZGkUUrUlb+8Nl8pD2EEufeVeGXBgTw4ArlTn
         lRCNRFKz7FxOL5z5gr6CUAWqenBlfjCjW1EgFWK7n1tHOUjOVawUdASsQwaaQnWO1rRb
         Ex14fkVTFmnEcJzlt6sHRfCgpaNEY48ZAUGqUoL8C4aIJpZ9+vZWCgafzeSESlZ7GRlM
         38RZy9nY0iW5d0jmnVtnO2eO13YDElUOitlWSPK5SQpuL3OWu3tLNDLSRSA4KYDBVKNh
         PvIpQW6VHauBuEUky1aDbm+NOa9ypoXS33sxM2RHu2qfuMpahptOQSJtjUEWJCQrQOnw
         MtSw==
X-Gm-Message-State: AC+VfDxS6ENp2V1QKJFKI4P+Uy2RrIoDOM9lGpWCXl47VFKWqtPzdNoQ
        wFHz8V9T5L+B/IuQrFuOXs/26+ko6EHU6Q==
X-Google-Smtp-Source: ACHHUZ4vJ1lQN67iIZEPDxHAxhJZkjHqPcnLJHh8uV4pyRQYGhMr5+pfTS+wcM2amtB0h9nui5VMYlPWy5TTRw==
X-Received: from talumbau.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:90d])
 (user=talumbau job=sendgmr) by 2002:a92:de0c:0:b0:335:de72:23c7 with SMTP id
 x12-20020a92de0c000000b00335de7223c7mr5716366ilm.5.1684754473156; Mon, 22 May
 2023 04:21:13 -0700 (PDT)
Date:   Mon, 22 May 2023 11:20:56 +0000
In-Reply-To: <20230522112058.2965866-1-talumbau@google.com>
Mime-Version: 1.0
References: <20230522112058.2965866-1-talumbau@google.com>
Message-ID: <20230522112058.2965866-2-talumbau@google.com>
Subject: [PATCH mm-unstable 2/4] mm: multi-gen LRU: cleanup lru_gen_soft_reclaim()
From:   "T.J. Alumbaugh" <talumbau@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Yuanchu Xie <yuanchu@google.com>, Yu Zhao <yuzhao@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-mm@google.com, "T.J. Alumbaugh" <talumbau@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lru_gen_soft_reclaim() gets the lruvec from the memcg and node ID to keep a
cleaner interface on the caller side.

Signed-off-by: T.J. Alumbaugh <talumbau@google.com>
---
 include/linux/mmzone.h | 4 ++--
 mm/memcontrol.c        | 2 +-
 mm/vmscan.c            | 4 +++-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 3a68326c9989..5a7ada0413da 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -534,7 +534,7 @@ void lru_gen_exit_memcg(struct mem_cgroup *memcg);
 void lru_gen_online_memcg(struct mem_cgroup *memcg);
 void lru_gen_offline_memcg(struct mem_cgroup *memcg);
 void lru_gen_release_memcg(struct mem_cgroup *memcg);
-void lru_gen_soft_reclaim(struct lruvec *lruvec);
+void lru_gen_soft_reclaim(struct mem_cgroup *memcg, int nid);
 
 #else /* !CONFIG_MEMCG */
 
@@ -585,7 +585,7 @@ static inline void lru_gen_release_memcg(struct mem_cgroup *memcg)
 {
 }
 
-static inline void lru_gen_soft_reclaim(struct lruvec *lruvec)
+static inline void lru_gen_soft_reclaim(struct mem_cgroup *memcg, int nid)
 {
 }
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d31fb1e2cb33..738ba18f3a0c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -485,7 +485,7 @@ static void mem_cgroup_update_tree(struct mem_cgroup *memcg, int nid)
 
 	if (lru_gen_enabled()) {
 		if (soft_limit_excess(memcg))
-			lru_gen_soft_reclaim(&memcg->nodeinfo[nid]->lruvec);
+			lru_gen_soft_reclaim(memcg, nid);
 		return;
 	}
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index cf18873a36b9..e088db138f5f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4846,8 +4846,10 @@ void lru_gen_release_memcg(struct mem_cgroup *memcg)
 	}
 }
 
-void lru_gen_soft_reclaim(struct lruvec *lruvec)
+void lru_gen_soft_reclaim(struct mem_cgroup *memcg, int nid)
 {
+	struct lruvec *lruvec = get_lruvec(memcg, nid);
+
 	/* see the comment on MEMCG_NR_GENS */
 	if (lru_gen_memcg_seg(lruvec) != MEMCG_LRU_HEAD)
 		lru_gen_rotate_memcg(lruvec, MEMCG_LRU_HEAD);
-- 
2.40.1.698.g37aff9b760-goog

