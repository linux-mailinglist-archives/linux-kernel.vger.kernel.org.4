Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C83663FEA8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 04:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbiLBDPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 22:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbiLBDPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 22:15:30 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7618AD49E3
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 19:15:28 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id f132-20020a636a8a000000b00473d0b600ebso3459750pgc.14
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 19:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lkiKsrGghY1+tqWu87j/dNVPvsb88bb2RpuXGbm+/VA=;
        b=LXzuBlaIaDeExqyOu2SdEI33qKVHVaAEa6EBq1XyrSfE3rPSCPGLQMVSyRpXtUvgsv
         rag+Aod0HZ1ICNfmgPf0FXBTk9sXmj6APzu29c5Vcz/J9gOfjBAozJ2PH+2isG/LYyXc
         Yp85TmDwppCvYZoGFOjIx9LLQ9Z1QqdaG7UpMW3tN2jUFxqisPg6npmhYNF1MmkXUms8
         VsjDCaKCzaKQYHmNTmXZEzIBmo5staiT+/m4ihPkR3p5IMQh9R8gVZYyC4MT4eFJbuxg
         /6pZ6r3d1p1eOsOqeXVposFeHPyNUHmmdD900WgzrlQPSiIyIeFhwYx+u6N5VNukvH0r
         udoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lkiKsrGghY1+tqWu87j/dNVPvsb88bb2RpuXGbm+/VA=;
        b=yWrb/ng+Th2mgExk3OHC2xMTf7w7AJv70JZMCM3QuCdUc06t3T4NMJJa74oojBKOuo
         ASSSOeOvP4V6InykO0Omwn3i1IYpDW5MrmxlSU0IDfaVZ2S04Jajuo+b6fPxsttGK+aS
         QayukWDSPolS618jZruXqKT0/SvB0bv9KoWVSAcrcCgKgCPeRPqxVC64jRaClyEst9To
         Lfqxsrmx6dG2r/tDHzB6QeUtfKJ0mzSQYMYgdB5KoyAYIfoHoRwrrC2f1rXcilIgR9xU
         AmFONY7JZMXAACr/YW//XJoNBCtqiBHPMcQwOMzUBugN6S11xujk+EsqEhHm3RFwOEYV
         FtKw==
X-Gm-Message-State: ANoB5pkZvpw4qXaPuEXMlRPoNRAsK81r817762HGInW1yqx5Fl8YfsNC
        3nzmRDIAq32uOnlKKVZM03INd6KEW6BNaxhk
X-Google-Smtp-Source: AA0mqf7sgZzjDn7jKp2ODvcu3ShzFfUsM1djBmRCVU3r2snOVzfDWgcrvIwd9xVn8DEDpQZEn4ZfRfl8r43qIpwd
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:aa7:96d2:0:b0:574:2447:947d with SMTP
 id h18-20020aa796d2000000b005742447947dmr47086688pfq.32.1669950927931; Thu,
 01 Dec 2022 19:15:27 -0800 (PST)
Date:   Fri,  2 Dec 2022 03:15:09 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221202031512.1365483-1-yosryahmed@google.com>
Subject: [PATCH v3 0/3] mm: memcg: fix protection of reclaim target memcg
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>, Yu Zhao <yuzhao@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Tejun Heo <tj@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vasily Averin <vasily.averin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Chris Down <chris@chrisdown.name>,
        David Rientjes <rientjes@google.com>, cgroups@vger.kernel.org,
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

This series fixes a bug in calculating the protection of the reclaim
target memcg where we end up using stale effective protection values from
the last reclaim operation, instead of completely ignoring the
protection of the reclaim target as intended. More detailed explanation
and examples in patch 1, which includes the fix.
Patches 2 & 3 introduce a selftest case that catches the bug.

v2 -> v3:
- Refactoring selftest helper reclaim_until (suggested by Roman).
- Collected review tags on patch 1 & 3 from Roman (Thanks!).

v1 -> v2:
- Instead of adding a new helper, extended
  mem_cgroup_supports_protection() to check if the current memcg is the
  target memcg, renamed to mem_cgroup_unprotected() which is much easier
  to reason about (suggested by Roman).
- Add a selftest case to catch the bug (suggested by Roman).

Yosry Ahmed (3):
  mm: memcg: fix stale protection of reclaim target memcg
  selftests: cgroup: refactor proactive reclaim code to reclaim_until()
  selftests: cgroup: make sure reclaim target memcg is unprotected

 include/linux/memcontrol.h                    | 31 +++++--
 mm/vmscan.c                                   | 11 ++-
 .../selftests/cgroup/test_memcontrol.c        | 91 +++++++++++--------
 3 files changed, 82 insertions(+), 51 deletions(-)

-- 
2.39.0.rc0.267.gcb52ba06e7-goog

