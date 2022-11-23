Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F306355B8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 10:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237518AbiKWJWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 04:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237595AbiKWJV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 04:21:56 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5F02189F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 01:21:38 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id f132-20020a636a8a000000b00473d0b600ebso9816723pgc.14
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 01:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N8aMTHwZ5WhdNd/taFqhW6oCnMv7Hs8LkFgvgW835eE=;
        b=nPBStnU0nNvPiCaL5LqZMwaE6rg463N1CT1Nycb/gGZ7X4HbwZ5+sBxndYSF/DhErA
         Ql1RpffgRhRRHlA0BT/yYdJXGlK1BgLhYaaCw/bZQv4FN5QeYF1wV50muFqo6rfcVQ9t
         uSHkGFqG+uIQlPXyCQai8gVHrHOUS3wzj+DMkq5zFKrerN7BIizijLnDxa8Pnzpy2baS
         29mlSeIqmA07gEXsbUx33rLahVyrc2JcK5EfZzuG9tuvpOSh+pv2P85O+CYa/rfYXW7H
         Q7nKw5cPTzEZ+EHB9bsc3HkK5GY5oL9QcljnXJRr1c60FM5DnniRIfQiQPtagGEMzmsy
         5w5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N8aMTHwZ5WhdNd/taFqhW6oCnMv7Hs8LkFgvgW835eE=;
        b=bOKT+vRRDnWij8d0Qnc9tCMjkxvN+PK+mt66BFvE9QprO4NqLvTZrh+BH+RLPgUhXq
         iAQrw1uhr6624HwohpA59sHoSxU30drhKLXhFuqbTlfdMtk7KCbUeIsWoTEyxrs4/lwg
         R3yBqPJ7Mzq+TfCvv2ROpbz29J5BtAEzL+Fo0EtBtXwZn9nzFkSdis7VZnr3uiJKzRDe
         g1dDhA51+9SQORUygkOa7ka07T0IzWispMxfhjRNNZKKs7y4SwT1Cyn7AMSmilOTCJGw
         6wA0qYWYB8M6No8o5qARdqkURGV9VEvpB9HAFBrZvcHOEw09H6SNbayqx5/7mLfxsVKv
         gQcA==
X-Gm-Message-State: ANoB5plCb5hzMSI4RPpbUaSvx8wMsaMqeiQZxslzPCx/0WYXywAXJz2y
        2lAI2yWu3Z0EVuDpGqKlTw63OhEANZAKakVz
X-Google-Smtp-Source: AA0mqf6eA/SswF6GKB6vAvjx1nUPJ9m0no7zaMHd1/I+pSCtTiat8jOinykDmpe7ezdAH0s9bdjOaYlwOEh5C2Ji
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:902:680e:b0:188:d552:fb02 with SMTP
 id h14-20020a170902680e00b00188d552fb02mr8216533plk.76.1669195297553; Wed, 23
 Nov 2022 01:21:37 -0800 (PST)
Date:   Wed, 23 Nov 2022 09:21:29 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221123092132.2521764-1-yosryahmed@google.com>
Subject: [PATCH v2 0/3] mm: memcg: fix protection of reclaim target memcg
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

This series fixes a bug in calculating the protection of the reclaim
target memcg where we end up using stale effective protection values from
the last reclaim operation, instead of completely ignoring the
protection of the reclaim target as intended. More detailed explanation
and examples in patch 1, which includes the fix.
Patches 2 & 3 introduce a selftest case that catches the bug.

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

 include/linux/memcontrol.h                    | 31 ++++--
 mm/vmscan.c                                   | 11 ++-
 .../selftests/cgroup/test_memcontrol.c        | 96 ++++++++++++-------
 3 files changed, 87 insertions(+), 51 deletions(-)

-- 
2.38.1.584.g0f3c55d4c2-goog

