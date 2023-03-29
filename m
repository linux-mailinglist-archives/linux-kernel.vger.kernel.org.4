Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDCD6CCCF6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 00:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjC1WRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 18:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjC1WRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 18:17:13 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B402D7F
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 15:16:56 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id l14-20020a170902f68e00b001a1a9a1d326so8323806plg.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 15:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680041816;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/WDDqk1nTT7D9mKcEzqzCjbueo/E6L9K7q/9wjNO8LY=;
        b=TcS0DaK7zSX/dgbsp92dhBvU1YXIfJw7DU8Bxymw385Iypv0i9ByV9836BmH3XGIri
         GA3G9Ah6/ynKVVXAJLor7BukC88mhb5FcK9F0N2UppuVbKofnYFrmwIOVN2419Sgn/T3
         Leo2J62N2CQ7p4vQ5tLG3l0ISmiaqnyiPoXjgBX2M4RYA1wXrmenFymFmJXjeUJkODde
         IPUO/XjdrDDGWWgE3vWyhfVxnLq+1UNPnYiIQva9A9S4iya4Iw/wc2ln/EZk6xTcIXjg
         k22ctJfIxPj6HJVEsaVfFSF1/WN3feXNcAQlYcNsdD7yhK296UbpIQqZDQ1X1PAq/IZq
         ToQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680041816;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/WDDqk1nTT7D9mKcEzqzCjbueo/E6L9K7q/9wjNO8LY=;
        b=GZhCkAq5djncSpFUcoi6VM3nDLh1et0HjqI6cV0FOgsIkHl6Djzyp4ONLUIEBysniV
         DMTa+bh+Je+0gT3/x7XqqZmLV+79hiKdDdBjPJgKtF+X8/h8t8wQ2c8PUv9pYarGod3D
         Gv611tm4JLVbr912nNc9sMurjBX6fAsGzacBlu6HDR79rLxoIVuUaAaJNg7/EJi6thgN
         CgaH48RED8LK41kEpZEx6b1m3+iVG4hS1FP/zv1VfBltYhzlk7/cYxDIDw0McDzkr1Gk
         JIezJ6nDnyGk5JxJMmnDwyqwdrlZmmciq19HvUyzmCPu9Y04ql7fd33KRpF+e64HhY+N
         3AQQ==
X-Gm-Message-State: AAQBX9dO091AxMloc76a5aAQUx+OWwGXQ4lHbd9xw9dElvJ2d/ir1K3S
        uQPuRuWRnUbKTjZ7IfUWWyvz482xM1DOMuBe
X-Google-Smtp-Source: AKy350axjsRVVcKhkqlJ581QnQNXv5GyXPvAYEbbNcmbDp26pUkQK7hJHNgyYA5XT7+ktiHVuLWG9T6jy5rcV85F
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a63:455:0:b0:50b:e523:3cd2 with SMTP id
 82-20020a630455000000b0050be5233cd2mr4608055pge.11.1680041816312; Tue, 28 Mar
 2023 15:16:56 -0700 (PDT)
Date:   Tue, 28 Mar 2023 22:16:38 +0000
In-Reply-To: <20230328221644.803272-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230328221644.803272-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230328221644.803272-4-yosryahmed@google.com>
Subject: [PATCH v2 3/9] memcg: do not flush stats in irq context
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
Acked-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
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

