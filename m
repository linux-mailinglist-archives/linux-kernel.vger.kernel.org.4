Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68CD6355AE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 10:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237581AbiKWJWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 04:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237639AbiKWJWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 04:22:03 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9A91095BF
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 01:21:48 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-38f92b4b3f2so161804367b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 01:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wv2KXXYxhgmiwiwKTV3Llr06CSap+0UqOMvMPP82Z+U=;
        b=d/rtyAMOztdMTDBjXLhp+iK6iUvN4N9zc37scM2toboxh4tk1p4sCS10UBQdR4N3qD
         5ze2ZpOfEEFYscj7wiB8Ugseb4cQQM/uJ4nqiUFppNlb+jUaaH7Ra4gBBobPGJ+MtlrL
         l4OSPfSUX70myNYZ0QWyiCku2BlYtAWqMjxZA4mnibWQ6/pknMLv+6ygUQfQtkEWgxAC
         JAtp93YrJbt0CZrdzKM7ss1ntR+8fufAN6h8qscMZMKMP/1LgkHNnxCz5O2YMMIMAv9O
         YiGzeYNmP7lLNDM3YplOWbNjmb/9MZlcx+TEI26B5TV0+3OFk1q8lSVhVH5VJN7YtJEI
         e6iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wv2KXXYxhgmiwiwKTV3Llr06CSap+0UqOMvMPP82Z+U=;
        b=epK85SEOCS9LxPqD366CrrzetCI2OvMnY9Jj8aICqhlpa2qAakNRor4sjiL+x5SmhR
         tV+m+WF09UsCX88YrIu9/X4/LC8PzrfLm0jTxGE9WZf2rMJgzDRWrL+HN2aIBwjek6Gk
         3o1EF4YQ5rEA+joP70SUMtnppISwBcGqy980wCtG+qs4rXp95qj6+0MkipUgcRuLWeuc
         sgrbzBrKx6Ut81vKVd/DAwbaZmq6EuGmj8r0cxx5+4dnydqkEtSDeuetQBfQb2VG99Q6
         FToPSFe5iY03LC1BDmG8Xfa3SZdfSGlCiNL8lE6flEDyh93GwgXptkszKuroRIr75fqL
         Lvyw==
X-Gm-Message-State: ANoB5plz5pufGSsDAQYpQI4XOP63HkejfYyZbW1TkjRSUiq20pzQIGwa
        vx0t4X7al8elDFdi/jGm707mDd5Nz7FFjtJa
X-Google-Smtp-Source: AA0mqf6sGopFfR1Aoda1Zdzt1YJ6XFFAb/E4mCK0N9ulMBl/Uu/0CQNXAGVehsabcRRiBRWhaT2ftO3U35pybhbT
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a0d:e507:0:b0:390:3cd1:cb16 with SMTP
 id o7-20020a0de507000000b003903cd1cb16mr10405812ywe.307.1669195307300; Wed,
 23 Nov 2022 01:21:47 -0800 (PST)
Date:   Wed, 23 Nov 2022 09:21:32 +0000
In-Reply-To: <20221123092132.2521764-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20221123092132.2521764-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221123092132.2521764-4-yosryahmed@google.com>
Subject: [PATCH v2 3/3] selftests: cgroup: make sure reclaim target memcg is unprotected
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>, Yu Zhao <yuzhao@google.com>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vasily Averin <vasily.averin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Chris Down <chris@chrisdown.name>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure that we ignore protection of a memcg that is the target of
memcg reclaim.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 tools/testing/selftests/cgroup/test_memcontrol.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index d4182e94945e..bac3b91f1579 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -238,6 +238,8 @@ static int cg_test_proc_killed(const char *cgroup)
 	return -1;
 }
 
+static bool reclaim_until(const char *memcg, long goal_usage);
+
 /*
  * First, this test creates the following hierarchy:
  * A       memory.min = 0,    memory.max = 200M
@@ -266,6 +268,12 @@ static int cg_test_proc_killed(const char *cgroup)
  * unprotected memory in A available, and checks that:
  * a) memory.min protects pagecache even in this case,
  * b) memory.low allows reclaiming page cache with low events.
+ *
+ * Then we try to reclaim from A/B/C using memory.reclaim until its
+ * usage reaches 10M.
+ * This makes sure that:
+ * (a) We ignore the protection of the reclaim target memcg.
+ * (b) The previously calculated emin value (~29M) should be dismissed.
  */
 static int test_memcg_protection(const char *root, bool min)
 {
@@ -385,6 +393,9 @@ static int test_memcg_protection(const char *root, bool min)
 	if (!values_close(cg_read_long(parent[1], "memory.current"), MB(50), 3))
 		goto cleanup;
 
+	if (!reclaim_until(children[0], MB(10)))
+		goto cleanup;
+
 	if (min) {
 		ret = KSFT_PASS;
 		goto cleanup;
-- 
2.38.1.584.g0f3c55d4c2-goog

