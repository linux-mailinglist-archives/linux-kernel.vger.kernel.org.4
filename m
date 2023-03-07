Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1636AD7DE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 07:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbjCGG6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 01:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbjCGG6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 01:58:08 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCEC88EF7
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 22:57:08 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id b20so7405966pfo.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 22:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1678172226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6RpTkxvvrfdHRVC7O4Q9cB0zRrVMaNNv+4vslhRNXIw=;
        b=W4VHauOiBpt34sXN0NGeRnCvFFOrK6bGxqZvOkEMVUkrE3vG6k1a/43ATXBWF9oL4D
         HYBUo7vHZe/W31enhNJ7CVLqdmu5Y02HPFFflxIozl0b/QDd6RN4k6EwvF+awGPNHWe4
         Rx/0HE2KR+Qq7m9hXa35Ea3oyuplOTrjAbd44mvSt3lLuSOT9OuJKMHLt7IsuNAw2GaM
         bzcYuW9uMvkR+Z6LM4ysopbsVwXnebzGgDNnTsrwb/NRdLlO7ExqCFm1QRYlGeJTOVKA
         QV50Vul9k2ren/2UFSJ3/jtJDhKNqxK+2HgjtMnrdUW17iEio32nEMoMmRRjN2BUDePl
         lK1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678172226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6RpTkxvvrfdHRVC7O4Q9cB0zRrVMaNNv+4vslhRNXIw=;
        b=GnLWipTVEHy3FRJf67IT4TYp9UdVo0ZWfhZLTXmC123DAC/d8xXZ3EROT9rl9nD1HP
         c9N50gSC1RW8Nug15UNtiJdTSNDpb/QX7PAp54zX1fZJQux1HWr6EXyyy03nuTSzjgbL
         WNb31kztTSxb7xb2Hdur92yGb/oMDI5asX0OpPbEnEMJzooUp5I9owT9xmOKSaMz0Lmu
         boGEGjw2Yx9yjjrg8N14ZwQcFWX9fynrhssuTSCl65Y314JvSOeNTwbwT6xODz52gy0G
         kD5HVzfUGFOJ/vdGiAUxHX1Q0bGlhjrMNj7rys/p8nMg0LDDgAQIBwoHpS17duNYUevM
         Unyw==
X-Gm-Message-State: AO0yUKXdvkGiEhaYXwnsvD+PFNomGoUxCUIqeO0HwRelejZGypK4TN+E
        MB4B/WahfaHvwmchtK8DVpBTIw==
X-Google-Smtp-Source: AK7set+ub7UgmiK7qg8lpFjlj2RQzhmm/aIy9dWEY6nXtBdGfq78UWJjhko94G0h2+ASvBEfmacZXA==
X-Received: by 2002:aa7:8892:0:b0:5d1:bbd2:7604 with SMTP id z18-20020aa78892000000b005d1bbd27604mr12474224pfe.2.1678172226558;
        Mon, 06 Mar 2023 22:57:06 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id e5-20020a62ee05000000b00608dae58695sm7230854pfi.209.2023.03.06.22.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 22:57:06 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tkhai@ya.ru, hannes@cmpxchg.org,
        shakeelb@google.com, mhocko@kernel.org, roman.gushchin@linux.dev,
        muchun.song@linux.dev, david@redhat.com, shy828301@gmail.com,
        rppt@kernel.org
Cc:     sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v4 6/8] mm: vmscan: hold write lock to reparent shrinker nr_deferred
Date:   Tue,  7 Mar 2023 14:56:03 +0800
Message-Id: <20230307065605.58209-7-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230307065605.58209-1-zhengqi.arch@bytedance.com>
References: <20230307065605.58209-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
index 9a5a3da5c8b5..7aaf6f94ac1b 100644
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

