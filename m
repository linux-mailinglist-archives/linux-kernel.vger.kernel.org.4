Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8ED96B75FE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjCMLak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjCMLa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:30:27 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1129D5849B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:30:16 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id k2so4674684pll.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1678707015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H5UXC4Y8L+sYixm/ZiEHHormamWIB6IrtYM6DyQ3d6c=;
        b=ItJnDFmMsgazPNOaXu8i9CtcCnSzNN57aJj3idjpUOYKHDhuP27hoj7ePdkQNEOby+
         riTdnuWQLKyP3nQPylZlMs6mnXVeCSnfHP6Q7AeVCEJSYIy+l6HW9Tbx7RDnuCzBTX04
         lg/9ublTRynkmyfmxHDT8KqSD1ZrXcBSzOxYBDdTI0PM8nEOM7P/oyB09c6XGMeI9FY0
         ZynsjAfzuUGtByb52mixStZA+f5WzLTbVCttXhkplGLfpxGeI3fKJtOb5yyJciSuqDaa
         kNFAiFqnIfkQtLxoqnTuMDedbMN6EiT6dScRhSmKgSpp0QGmx1ct8f81dbBiredODvuA
         ZyxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678707015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H5UXC4Y8L+sYixm/ZiEHHormamWIB6IrtYM6DyQ3d6c=;
        b=pHAIhElgJXev6bGADw6nqK58a6+1bA8STqTctBzMzs+cnn9VQnoSNDEGbcQQauAXPl
         PungvdgrKJO4TAHT94ftp78DvHD8BEVqCSjDi5EGsEjY6tFapKyrEMTuL3VFFj9FCMYt
         igVMLTE/uNNm6d1uLK+CYbzX4zFR6Vf0Iims/6J3HdocX/NPJhJRObFBZj4S5y1fllY0
         C8Tt9UgAZ5rHrob4YML/8PATDWlOx3yP9jiHF9jUM1vj6CBJ84lW+daAiTDNDrTHi6KJ
         DcqcW2ppUtfGYfXoA3zTb9kXecYQO7rfZChNNO+gV6soZRqFqGhVquNJLOwkCRdROpYD
         A5Dw==
X-Gm-Message-State: AO0yUKVTmbq3+h14hpNj6GiJdbt2mTDp0b9J8KaUwHcfVaFFUGAxdDIA
        BJTqMkfIi7HYAKFnCk8fHqXNJg==
X-Google-Smtp-Source: AK7set+yBkkIFIpn/7Eo+7xlIbSqY5w2muehss8s+sQ+FSFjAoN1HxOMAwRaBpjTqB+jL1sgGBo1BA==
X-Received: by 2002:a05:6a20:440d:b0:cd:18a2:f6cc with SMTP id ce13-20020a056a20440d00b000cd18a2f6ccmr13960885pzb.3.1678707015460;
        Mon, 13 Mar 2023 04:30:15 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id n2-20020a654882000000b0050300a7c8c2sm4390827pgs.89.2023.03.13.04.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 04:30:15 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tkhai@ya.ru, vbabka@suse.cz,
        christian.koenig@amd.com, hannes@cmpxchg.org, shakeelb@google.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev,
        david@redhat.com, shy828301@gmail.com
Cc:     sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v5 6/8] mm: vmscan: hold write lock to reparent shrinker nr_deferred
Date:   Mon, 13 Mar 2023 19:28:17 +0800
Message-Id: <20230313112819.38938-7-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230313112819.38938-1-zhengqi.arch@bytedance.com>
References: <20230313112819.38938-1-zhengqi.arch@bytedance.com>
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
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Kirill Tkhai <tkhai@ya.ru>
---
 mm/vmscan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 5c2a22454320..8c1ae7ea8dea 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -445,7 +445,7 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
 		parent = root_mem_cgroup;
 
 	/* Prevent from concurrent shrinker_info expand */
-	down_read(&shrinker_rwsem);
+	down_write(&shrinker_rwsem);
 	for_each_node(nid) {
 		child_info = shrinker_info_protected(memcg, nid);
 		parent_info = shrinker_info_protected(parent, nid);
@@ -454,7 +454,7 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
 			atomic_long_add(nr, &parent_info->nr_deferred[i]);
 		}
 	}
-	up_read(&shrinker_rwsem);
+	up_write(&shrinker_rwsem);
 }
 
 static bool cgroup_reclaim(struct scan_control *sc)
-- 
2.20.1

