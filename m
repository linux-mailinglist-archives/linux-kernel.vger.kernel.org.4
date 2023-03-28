Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B666CB6EF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 08:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbjC1GSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 02:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232640AbjC1GRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 02:17:39 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3C53ABF
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 23:16:58 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id q1-20020a656841000000b0050be5e5bb24so2927769pgt.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 23:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679984218;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vy8wz9BoJKucmcMBXvIGPOuITeThi///HtllaZbgtCo=;
        b=G3C3U8FV5xO4vsplclhU9+4PkBH686vIIIrQFFquICu8//oGn5xL/Tmt4VNVE1HnMt
         hORJK4mB81itHhGs1+plTWPpHn6PXb4UvAXp2In5M38sRtIYXUydb86gW9UCcwU8NUMK
         AKSJULzbSmJ/Zh8xR8z20CA4EuuFhupmK6yUb7XM0dWX+orGZyC4roBLz+bFSVl/SrGz
         jDFcau8INkey+e5jkuXnym7vXagjhy1slym0NeO+iUEtBeJGIjBlnt29eYQhaZCdCsb9
         TItPIolnMlslNIl39r9v4yrb91hLywelng+1GUeMlXmGbk+u0V1YHrp34uG87/cMCuf4
         DKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679984218;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vy8wz9BoJKucmcMBXvIGPOuITeThi///HtllaZbgtCo=;
        b=f7YKdNJK+YRWbccPTYakD+plaVJW9U5hZNqzTwzXNUMy9E4A/8oQnSiw0QX2yx5IfO
         9P1Y7VhNBTinivdyVh34FcPLdLj8hoYDDVZgh6K0PCE8/4la5b6X1jKzqHuVCKxEkTAY
         mijmbAxQdqCPHKCubQmppEnxiOBB936ThxeaDn5Cl2+6gXYhPHn2nqpg74F6CU9cOuhD
         Xlgyb2UaUYod6wn+ncGf+9UJzFsvTkGbDBo5Gxaf36JHpoceBZAIl7vltH7ERx/+tFi8
         1SWRkaWSKZ8/6CdILzQnZcGR6ccBWt6OWWMuRHfsK6gWd7tUhZo4sj/OyXHvgS1jH0CL
         Kpyw==
X-Gm-Message-State: AAQBX9c+eJCKx3k4JGEQiZRBZfbVJODep410pQ53qpAtC24l7UlggXj3
        XhVMcXo0uW82dANDO1iUL5dTKEwBYux2BFwi
X-Google-Smtp-Source: AKy350aVn7i51pwbUpBHdDCfopSzB0y7+YNrEoZI1+8jV5mnjDSATrQRcelVSU3ikfIyno7DP54WO5q/0DmrmRgv
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a05:6a00:1781:b0:593:fcfb:208b with
 SMTP id s1-20020a056a00178100b00593fcfb208bmr7364360pfg.3.1679984218020; Mon,
 27 Mar 2023 23:16:58 -0700 (PDT)
Date:   Tue, 28 Mar 2023 06:16:38 +0000
In-Reply-To: <20230328061638.203420-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230328061638.203420-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230328061638.203420-10-yosryahmed@google.com>
Subject: [PATCH v1 9/9] memcg: do not modify rstat tree for zero updates
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

In some situations, we may end up calling memcg_rstat_updated() with a
value of 0, which means the stat was not actually updated. An example is
if we fail to reclaim any pages in shrink_folio_list().

Do not add the cgroup to the rstat updated tree in this case, to avoid
unnecessarily flushing it.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/memcontrol.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 0c0e74188e90..828e670e721a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -618,6 +618,9 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
 {
 	unsigned int x;
 
+	if (!val)
+		return;
+
 	cgroup_rstat_updated(memcg->css.cgroup, smp_processor_id());
 
 	x = __this_cpu_add_return(stats_updates, abs(val));
-- 
2.40.0.348.gf938b09366-goog

