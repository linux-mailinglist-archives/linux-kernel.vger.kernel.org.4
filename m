Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F223E6D556F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 02:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbjDDAOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 20:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjDDAN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 20:13:59 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9B0170D
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 17:13:57 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5419fb7d6c7so306006707b3.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 17:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680567236;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pu8NQW7PT3CX2ydDP6OKHn9xreaGc+GffyitQGTf/Sw=;
        b=NgFr+mt861ia/9ME3yYfnG6illl0smj1XxKWxv7RX7bCn30eK75+r3/mN045hxmTht
         XxXZE+TkL0kCi/mO3+BUA3w6mg7VHDQOKN2NVafTJLvv3QixFUE3R5iFK5w8ka0UMBGX
         cO3RgMHlOCZrZXeoyQngycjIG2W4nzC2svYLg3vadywoa9p2dHEu3QJDakNcoqZZYF0P
         gTi2ChtgNFu+gpwhTSXKUpPNbjfBCbDD3Ma4xYqGJ61C+BwiJAQfvfUnBTGy6XRnN+ue
         2PE4ea3ZPsx5EJKDnp8qLdqYsi4/l4Nu9R12YsH4N7a6gS981iO1lmOd8TnhBeuT7CX0
         zS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680567236;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pu8NQW7PT3CX2ydDP6OKHn9xreaGc+GffyitQGTf/Sw=;
        b=6JLOhu6a53u5+qb9a+qzauQok4mI9SIA8U6Yx++SYQ+CnXxmI671462PFMvJIaAWO8
         N62MKRihXGv9Cdo7TVr/8xkpQPx850jZy45KQMBqcUGc/JPiRmJPJ+33nFWcP9mnIX8r
         CBgfuXJx6ZfxaiEVEuKJ9wo1sYBQXPqmf8iCibPRWZwrQJ/JXLR39rJ8FXTj6lbEYqhv
         nZLV1DzxO0BE8TPsyLZy3f4N1mX2F9y8WLeaEjJt3YvAVKDdO4JQrd/52n4x9rGiBmpA
         hCgYmJHfSxeh90z3YtdSpRLFgOqTD8cgxs/kaBvL6rR9Ugfp8AaqI3XnsSrhWjgMhTEU
         dwiQ==
X-Gm-Message-State: AAQBX9eEx1RVDc1ZPdSKCbKXWElcSScnIt2fNX4mRl7PoeSumjJGK3uc
        U+De9/VTAlqyKHr4EkSajxiYMULp4f2Nc2q8
X-Google-Smtp-Source: AKy350bEZyh+kGC7zJpP2Eo/NB8JCiirULe8DAdhizlHAyh9HLDpxbXiafQS5oeVJeCFuCzpF+wkw4a2/+eTtkR9
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a81:ac65:0:b0:545:bade:c590 with SMTP
 id z37-20020a81ac65000000b00545badec590mr463245ywj.1.1680567236548; Mon, 03
 Apr 2023 17:13:56 -0700 (PDT)
Date:   Tue,  4 Apr 2023 00:13:50 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230404001353.468224-1-yosryahmed@google.com>
Subject: [PATCH v4 0/3] Ignore non-LRU-based reclaim in memcg reclaim
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

Patches 1-2 are just refactoring, they add helpers that wrap some
operations on current->reclaim_state, and rename
reclaim_state->reclaimed_slab to reclaim_state->reclaimed.

Patch 3 ignores pages reclaimed outside of LRU reclaim in memcg reclaim.
The pages are uncharged anyway, so even if we end up under-reporting
reclaimed pages we will still succeed in making progress during
charging.

Do not let the diff stat deceive you, the core of this series is patch 3,
which has one line of code change. All the rest is refactoring and one
huge comment.

v3 -> v4:
- Used global_reclaim() instead of !cgroup_reclaim() in patch 3 to
  include non-LRU reclaimed pages when writing to memory.reclaim for
  root (Yu Zhao).
- Moved the definition of mm_account_reclaimed_pages() to a static
  inline in the header file (Dave Chinner).

v2 -> v3:
- Fixed a compilation problem in patch 2 reported by the bot.
- Rebased on top of v6.3-rc2.

v1 -> v2:
- Renamed report_freed_pages() to mm_account_reclaimed_pages(), as
  suggested by Dave Chinner. There were discussions about leaving
  updating current->reclaim_state open-coded as it's not worth hiding
  the current dereferencing to remove one line, but I'd rather have the
  logic contained with mm/vmscan.c so that the next person that changes
  this logic doesn't have to change 7 different files.
- Renamed add_non_vmscan_reclaimed() to flush_reclaim_state() (Johannes
  Weiner).
- Added more context about how this problem was found in the cover
  letter (Johannes Weiner).
- Added a patch to move set_task_reclaim_state() below the definition of
  cgroup_reclaim(), and added additional helpers in the same position.
  This way all the helpers for reclaim_state live together, and there is
  no need to declare cgroup_reclaim() early or move its definition
  around to call it from flush_reclaim_state(). This should also fix the
  build error reported by the bot in !CONFIG_MEMCG.

RFC -> v1:
- Exported report_freed_pages() in case XFS is built as a module (Matthew
  Wilcox).
- Renamed reclaimed_slab to reclaim in previously missed MGLRU code.
- Refactored using reclaim_state to update sc->nr_reclaimed into a
  helper and added an XL comment explaining why we ignore
  reclaim_state->reclaimed in memcg reclaim (Johannes Weiner).

Yosry Ahmed (3):
  mm: vmscan: move set_task_reclaim_state() after global_reclaim()
  mm: vmscan: refactor updating reclaimed pages in reclaim_state
  mm: vmscan: ignore non-LRU-based reclaim in memcg reclaim

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

