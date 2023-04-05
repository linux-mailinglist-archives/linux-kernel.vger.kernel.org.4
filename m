Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57106D8654
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 20:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234355AbjDESyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 14:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbjDESyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 14:54:32 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AECB558E
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 11:54:30 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id o4-20020a056a00214400b00627ddde00f4so16497119pfk.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 11:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680720870;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=74VbkkX1JNgTJppCDrpyUBhSlzGYrPPYVv0NXjoYgyc=;
        b=DvoZtrowqtchOBo3Knj2bdyh+0reXXG6EgqqogY/mAyo+TSHhWSb9U2cJKuwxd7h2w
         o2RX0e8+Zwu1WADDOlnnpGNdNztCU7WB8Qje6IiAB/MfTzkr62n9cE3NrDiwNbW0sDjH
         VkmeCcgNPVtOFmHHi+9HgWbW0Z24Zu6e6XFf+Qci0FBgIegloiaEWYx/NseVj73FQU7q
         Q51X91yYhlKkYuSLDOnFpKRH7l1zCwbwiEAGW0rXRqhGF9SRBlbwebErhD2Q+IgzmaDJ
         ZIZh4OMxhCZbxyMwD9Ftdx6AM+OvFYs2mi3lYMsNUVLkpHDU34ZfxGINsWiKNbF9ytdL
         jp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680720870;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=74VbkkX1JNgTJppCDrpyUBhSlzGYrPPYVv0NXjoYgyc=;
        b=HOa2dtA45/Otd4/dj2kNeY91k2aM67XEbA06gs1PJLrNYl26iV9PCVDzVgLez8/DDz
         un2fbHecQ0hXazVDzG+kpEBzC37sfwSbwi6f+eZgeph92E+xQFOd9CL9DQmMPq5OR7xm
         cy70LR6xYEmFSUZ7PUFxbsEH1x1u3moVKBaMNY2l/lMyxP1DfJMoUTA5RXaE8DoAICaa
         jQWUiBQtXQvwxky7WQ3LvK06bTX5CKXGYTiheb207dMW0zWhUEf4SzuYkTuU9le/0zjD
         xCmfKviRThQBGjjLNNysV2R2lHNpYSBZrz54gR7VZwsWLDFFtj2wAA+3o4Lv/jvh05ko
         QgZA==
X-Gm-Message-State: AAQBX9cAe1NxCDLRovDNsq2aMHVnuU5oUOI990aAQzPH8KX7Q1+zXgAP
        N0YIE0sXJFGqP1CTS2oYFXk6cyGv7tYV63Je
X-Google-Smtp-Source: AKy350YH2iSQX6gNnTj2zSUoqJgUjpVMBh1a0kuQQW4A3Qs4h6unL0l7+ARu30/SrGo0X9cSZkV5qMEnH3NanZCo
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:90a:6c65:b0:23f:a26e:daa3 with SMTP
 id x92-20020a17090a6c6500b0023fa26edaa3mr2624714pjj.9.1680720869909; Wed, 05
 Apr 2023 11:54:29 -0700 (PDT)
Date:   Wed,  5 Apr 2023 18:54:25 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230405185427.1246289-1-yosryahmed@google.com>
Subject: [PATCH v5 0/2] Ignore non-LRU-based reclaim in memcg reclaim
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Xu <peterx@redhat.com>, NeilBrown <neilb@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
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

Upon running some proactive reclaim tests using memory.reclaim, we
noticed some tests flaking where writing to memory.reclaim would be
successful even though we did not reclaim the requested amount fully.
Looking further into it, I discovered that *sometimes* we over-report
the number of reclaimed pages in memcg reclaim.

Reclaimed pages through other means than LRU-based reclaim are tracked
through reclaim_state in struct scan_control, which is stashed in
current task_struct. These pages are added to the number of reclaimed
pages through LRUs. For memcg reclaim, these pages generally cannot be
linked to the memcg under reclaim and can cause an overestimated count
of reclaimed pages. This short series tries to address that.

Patch 1 ignores pages reclaimed outside of LRU reclaim in memcg reclaim.
The pages are uncharged anyway, so even if we end up under-reporting
reclaimed pages we will still succeed in making progress during
charging.

Patch 2 is just refactoring, it adds helpers that wrap some
operations on current->reclaim_state, and rename
reclaim_state->reclaimed_slab to reclaim_state->reclaimed. It also adds
a huge comment explaining why we ignore pages reclaimed outside of LRU
reclaim in memcg reclaim.

The patches are divided as such so that patch 1 can be easily backported
without all the refactoring noise.

v4 -> v5:
- Separate the functional fix into its own patch, and squash all the
  refactoring into a single second patch for ease of backporting (Andrew
  Morton).

v4: https://lore.kernel.org/lkml/20230404001353.468224-1-yosryahmed@google.com/

Yosry Ahmed (2):
  mm: vmscan: ignore non-LRU-based reclaim in memcg reclaim
  mm: vmscan: refactor reclaim_state helpers

 fs/inode.c           |  3 +-
 fs/xfs/xfs_buf.c     |  3 +-
 include/linux/swap.h | 17 ++++++++++-
 mm/slab.c            |  3 +-
 mm/slob.c            |  6 ++--
 mm/slub.c            |  5 ++-
 mm/vmscan.c          | 73 +++++++++++++++++++++++++++++++++-----------
 7 files changed, 78 insertions(+), 32 deletions(-)

-- 
2.40.0.348.gf938b09366-goog

