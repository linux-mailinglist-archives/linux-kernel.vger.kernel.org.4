Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823276CB6EE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 08:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbjC1GSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 02:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbjC1GR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 02:17:26 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8B930D3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 23:16:56 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id j15-20020a17090a318f00b0023fe33f8825so2932533pjb.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 23:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679984216;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x7IFy8THM3GBUAgd4d/GEKRMIpmDkqCRA5AxR/3TFCM=;
        b=BGZjnL6U27C3nu3nfjJxe/VV851RC/VP1GsLD606AgPd6FshXe6WNQk0I659Owa2wU
         gVJoC9Crt60CfuYM+ql+MgbEx44waD/ankuLiQjCR+6oc5mr8Ex9gHFcY/MTbuN2MESv
         WG+o2vmHU2skqPZDZWhEEvumwbMUFH8XB/2P7lCWIxY9j69P+XyQb7YmlC5lJf3dl83N
         R/+G9MzJdyv2aInyc3KBZTsCKswAeBzT3OW0sicqNfQnZRl6LhPxfTDtAjqxejZWrmX4
         kekpZffHaXAsR+R6/xnXuXgj0ngR8GdA98eO9lk+Gv9Mx4rtmu3ZFp7UhRacTBWLo1ks
         cDtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679984216;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x7IFy8THM3GBUAgd4d/GEKRMIpmDkqCRA5AxR/3TFCM=;
        b=xj56OWwuWyrQgH2udRIFL0KVa9/Uisey3/s0qUL8UZflIPystXacHDXM+mYxSjAv4U
         xplF1onBAnHa6uSGV81RToIDlHJSa7X4qZD+TuEge/AXHknSJEdIN83JrDQVOlGA9GBw
         D2NeZKULvnG+IkC/vwjqbWWfN9nIMPNH85kNn6zAocLb9Or1vedIFkB10jrYaAA3GlJp
         LL2ADRVT04Jaehc2qYn3YXfpYC9HpRKdU4zPyCxMUomygDZ7YF9+vgAvsX72cUJcIHAO
         HEaTGB0ne4LDi2wpS/J/Sn8DFDtVlhLR/4882VYGctZzIXq4aRs6XT57/vTOpLLJRnqB
         y4Kw==
X-Gm-Message-State: AAQBX9f9vgrHABIuNHp3VhSKnZLnD1oGkp5DrFadz4TGgnBazMgH0mu+
        tZuuryxqLyQt3jQso/vgBGy5LufjI8p9rQ7T
X-Google-Smtp-Source: AKy350ZXKLWX99WV75Zn5bhPto8WUfX5S0Ha1cMIMK8Z1sFTdLjrJB9JMxzEwgWixGxokt8xM3tEMiwbJzx2bThN
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a63:c49:0:b0:502:fd71:d58c with SMTP id
 9-20020a630c49000000b00502fd71d58cmr3919025pgm.9.1679984216134; Mon, 27 Mar
 2023 23:16:56 -0700 (PDT)
Date:   Tue, 28 Mar 2023 06:16:37 +0000
In-Reply-To: <20230328061638.203420-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230328061638.203420-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230328061638.203420-9-yosryahmed@google.com>
Subject: [PATCH v1 8/9] vmscan: memcg: sleep when flushing stats during reclaim
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>
Cc:     Vasily Averin <vasily.averin@linux.dev>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, bpf@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory reclaim is a sleepable context. Allow sleeping when flushing
memcg stats to avoid unnecessarily performing a lot of work without
sleeping. This can slow down reclaim code if flushing stats is taking
too long, but there is already multiple cond_resched()'s in reclaim
code.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index a9511ccb936f..9c1c5e8b24b8 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2845,7 +2845,7 @@ static void prepare_scan_count(pg_data_t *pgdat, struct scan_control *sc)
 	 * Flush the memory cgroup stats, so that we read accurate per-memcg
 	 * lruvec stats for heuristics.
 	 */
-	mem_cgroup_flush_stats_atomic();
+	mem_cgroup_flush_stats();
 
 	/*
 	 * Determine the scan balance between anon and file LRUs.
-- 
2.40.0.348.gf938b09366-goog

