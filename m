Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874276CB6DA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 08:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbjC1GRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 02:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbjC1GRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 02:17:04 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CDF3A87
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 23:16:47 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id m12-20020a6562cc000000b0050bdfabc8e2so2931954pgv.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 23:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679984207;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wILXj9LqWwom+6PQC1+rRSpOfUrkR+GzdkCDGSSBhGY=;
        b=sq4WxgrXs35T1kNaqttQxLQHBBfHPzw9iKcGHtZRmWn7KoDZlSxKdNufMOgLyKUFr+
         TMiE/wqtjNlMTixUEQeY/Vrw6MeR14OOP90t7VeDCccykNrGNGWLRshNs7Tr5dzPpQxM
         EqNAZipGy1I27uXZW4pV5ZH3WWGxC9s0suXWrK0/Qi+Fx4TfEA0shsUjup5r4I0T4jcO
         otnYwmVT7RvIIuwqMJTULG/AsEi9P5/3lltCZIuxMi9242jZnrgGHko3vAN7pXgBxOSv
         6bmFPpVjK2j81kXxaYSwcWty18LJNFnzIpVeFZG9+e6GZQd6MIhYJNlu+ckzRRvaCz8L
         Rlqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679984207;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wILXj9LqWwom+6PQC1+rRSpOfUrkR+GzdkCDGSSBhGY=;
        b=I6vG682qT13m3sU9ngFFJrgMtnr0BOK/QOSPrxMY737/6dupNDH9MpOdxHyVGoUu3n
         7hFTfumFGFHLw33WtT2FZ3FN3ivFzN0XZ/zxdAH6WS82LN2jUV6zoCYQAmbPrxtbgwO6
         dwqkKcKSJnNMVIXrUqWCS49YrCqSSJb3+YhqrJvLrhGceDM4e9VMtl32vFt6np7kfaOP
         BL0tA+qp2rLrP6HdMriqJB+z87Y8/YF5whpYAy301M45bc99CaMjNn3AfJk1CURtv5Le
         Z31LvTcCvbSLlII7gdl4r0z+xMujhVzB8iL1lTqBazZwVEvUpKNxfEIZ2LwGJNQy+hYZ
         VV9Q==
X-Gm-Message-State: AO0yUKUJXsbsIvULgpRXDd3o7Jdb/Gec+hnuJt0TyaPkhYa5pvi4GAxf
        h7Vey/cYtYY8BoPYG3bDD6w9L5qmNfhP0455
X-Google-Smtp-Source: AK7set/NXJ9x9Sdrim9yKl61I9Pd5pvCD8XFm/ZA+2N5HaWD82pwRjDqKXOdg8RZFiQsg1c0bhIGvLI1ByyxVbFu
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a05:6a00:4510:b0:626:1710:9b7d with
 SMTP id cw16-20020a056a00451000b0062617109b7dmr8924786pfb.0.1679984207461;
 Mon, 27 Mar 2023 23:16:47 -0700 (PDT)
Date:   Tue, 28 Mar 2023 06:16:32 +0000
In-Reply-To: <20230328061638.203420-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230328061638.203420-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230328061638.203420-4-yosryahmed@google.com>
Subject: [PATCH v1 3/9] memcg: do not flush stats in irq context
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

Currently, the only context in which we can invoke an rstat flush from
irq context is through mem_cgroup_usage() on the root memcg when called
from memcg_check_events(). An rstat flush is an expensive operation that
should not be done in irq context, so do not flush stats and use the
stale stats in this case.

Arguably, usage threshold events are not reliable on the root memcg
anyway since its usage is ill-defined.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Suggested-by: Shakeel Butt <shakeelb@google.com>
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/memcontrol.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c3b6aae78901..ff39f78f962e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3669,7 +3669,21 @@ static unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap)
 	unsigned long val;
 
 	if (mem_cgroup_is_root(memcg)) {
-		mem_cgroup_flush_stats();
+		/*
+		 * We can reach here from irq context through:
+		 * uncharge_batch()
+		 * |--memcg_check_events()
+		 *    |--mem_cgroup_threshold()
+		 *       |--__mem_cgroup_threshold()
+		 *          |--mem_cgroup_usage
+		 *
+		 * rstat flushing is an expensive operation that should not be
+		 * done from irq context; use stale stats in this case.
+		 * Arguably, usage threshold events are not reliable on the root
+		 * memcg anyway since its usage is ill-defined.
+		 */
+		if (in_task())
+			mem_cgroup_flush_stats();
 		val = memcg_page_state(memcg, NR_FILE_PAGES) +
 			memcg_page_state(memcg, NR_ANON_MAPPED);
 		if (swap)
-- 
2.40.0.348.gf938b09366-goog

