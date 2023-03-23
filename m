Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2FE6C5DBE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 05:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjCWEB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 00:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjCWEA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 00:00:57 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32501F91E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 21:00:54 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 205-20020a2503d6000000b00b7411408308so2175654ybd.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 21:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679544054;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GbeROioJTSRzpGZIx65CHc5YHmhlz1VRWOdmKxovUco=;
        b=Hsck6MLI0adIPASRaTY3d/eUkBNtZFq5fHTozHNB8yOtl2ZkHkJQQ4GNrxQh4iSoWz
         JkY9CbdFxu+ujh+Pyx1oKlS53Vj0EANz1HJ/mNRwoFFcZsbYiHuLCMd4Lx5axIZ0gB5l
         yaad/tHsVvn1tHU57blkHy/+dS8g9HHclDAV/QT3pdal8fCNCqCcJD9lMmCv5J074fQc
         TEWaFK69tR0mz3hWUAlm/mUgTwQep/HE638zK7huhLNEr0Yv6vPjLeQWwk4UQCFbwI31
         KRefecpL1tiBaS/Y5Rnpmz8ntCNmT0BogLXtNGk9m7i1zmm8BH4noVNiIwwFJbgEqIWE
         ZH9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679544054;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GbeROioJTSRzpGZIx65CHc5YHmhlz1VRWOdmKxovUco=;
        b=JukNIAJswgiQyw+3ObOE3Ykw+fTArfXh+rvf5H3xIIxGctQaIzhpbqizm4xLiXUr6F
         KecpNHxN3GleQt6T25DtsFw+n9igJwCoqq+a7KbGX6OmUnUFxOZ6wOmRc1sFD1Hp3SOA
         L/zZOUzcgRpnv4bua1zDN3qeuR48+Qq2BQLs6PvVPsiuT1CnH6A86mH0o1ZjEto5krLQ
         rtnyobGcpXuCirfl39UEVC6i0x7fXlE7MJZ7yDsvYHH2PEgT/qfnDqIIO1lss8EiwQDw
         6MqAnqPFa4Lz5c8FpPRnsjRT3doQJR9DnHYua0eK1FHLsCvKDynbqO8bazALr7AVADZF
         pG7w==
X-Gm-Message-State: AAQBX9ffCJk14nBlzOZf0MBz9jdT2Q7Z5U0QzmJKcE8e1EgMO5sAxckl
        kh52pqayu6KwYWiA4I1Oc8mGbMA0VNbZH6tX
X-Google-Smtp-Source: AKy350aHC0fJxZVNDyOM4vrsmksnjt2c5UEEiO2IoOQY1+2DycjUjKQKdK6RunG6Yd33ZztPbzyijCwEZgPQmgPG
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:1549:b0:b73:4a25:fd36 with
 SMTP id r9-20020a056902154900b00b734a25fd36mr1286158ybu.2.1679544053971; Wed,
 22 Mar 2023 21:00:53 -0700 (PDT)
Date:   Thu, 23 Mar 2023 04:00:37 +0000
In-Reply-To: <20230323040037.2389095-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230323040037.2389095-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230323040037.2389095-8-yosryahmed@google.com>
Subject: [RFC PATCH 7/7] memcg: do not modify rstat tree for zero updates
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>
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
index 39a9c7a978ae..7afd29399409 100644
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
2.40.0.rc1.284.g88254d51c5-goog

