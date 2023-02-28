Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1C56A54BE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 09:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjB1IuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 03:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjB1IuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 03:50:14 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36C9EC57
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 00:50:06 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id i11-20020a056a00224b00b005d44149eb06so4808298pfu.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 00:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677574206;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xdSAVrwCtkhEWC8GgYYqKMfIX8yBwrpfZDbmqtRyDyA=;
        b=SOVV++5ZdqitZ36JKIv2fFMUIZWr2mRvM+1SYrMDqxcU64YKMcyXiXS7/JBzrMzVGR
         a6lwTwArMZ5cvyX8urVSHUrUuVQOSfF42XGvNomA8Tvnp0LV06/wsJWl0LMz4W76Db5h
         y3jUa5jifEAMLoWLF0Zr9sO3rNX27weBBlTgPK6tlMagy9lhu6URapPi6JL/AiWDq+/O
         xpiOl8e/9NHV1lIOw2MgMwgF5M6/In9pOSbo61IAhJJdv/IGVjLeA7M8iH+2ekiFYHMp
         H9Jqpmo7RoeMES/COvqdvDIkncurMcMLwWiPU0V57IM51nNJ+lMIpEBY3rU7HFrTSgtB
         lU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677574206;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xdSAVrwCtkhEWC8GgYYqKMfIX8yBwrpfZDbmqtRyDyA=;
        b=bd2vVjnnolo8vCezWag9JqdUXYKvv24fWtc6WOJIRO6Tu812Jbmo1j22Ol7bG8+ReV
         cJplR51b7NbGtTqWuRfhwq/6KSiTMQgSkyGYGgV50RBFVR3pRHB0WvhGIY9Swh9BBzK4
         OzT0CEWEcXEBHzNMRbPGl0y40UYcX6L8ljj+0rrqDjgm3CUozCmBrGwyLWa4OqugVvVA
         07OlA1671RCk8hov3itcoMZZBlx4IKR4GgXly7wH4assXaseDpngoRKlngGpjL6lT37K
         vNegHA+/htNBPK7Tbppay6FGOGLmL7J+tO7FwYT9VuocAoz4ofc8NNL+Vd95R0h40OxL
         tnxg==
X-Gm-Message-State: AO0yUKXzuoETbP73c6iSxJIUQv5kAv0u65ZqyjTHw6nK8DN+zvp4vvU/
        5CfDaF8V1WjJTJgCqzWlANw+r1M3WWRFFDc4
X-Google-Smtp-Source: AK7set9xyaSEGINDP0JdrxfWpmvgvG2OFkld3cb1qL57vscSNy7S0nejYo/cjvFVY+VnsY2ooCNyScP6qk2951NZ
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:902:6bc5:b0:19c:fc1b:e600 with SMTP
 id m5-20020a1709026bc500b0019cfc1be600mr684030plt.5.1677574206196; Tue, 28
 Feb 2023 00:50:06 -0800 (PST)
Date:   Tue, 28 Feb 2023 08:50:00 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230228085002.2592473-1-yosryahmed@google.com>
Subject: [PATCH v1 0/2] Ignore non-LRU-based reclaim in memcg reclaim
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
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
        Michal Hocko <mhocko@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
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

Reclaimed pages through other means than LRU-based reclaim are tracked
through reclaim_state in struct scan_control, which is stashed in
current task_struct. These pages are added to the number of reclaimed
pages through LRUs. For memcg reclaim, these pages generally cannot be
linked to the memcg under reclaim and can cause an overestimated count
of reclaimed pages. This short series tries to address that.

Patch 1 is just refactoring updating reclaim_state into a helper
function, and renames reclaimed_slab to just reclaimed, with a comment
describing its true purpose.

Patch 2 ignores pages reclaimed outside of LRU reclaim in memcg reclaim.
The pages are uncharged anyway, so even if we end up under-reporting
reclaimed pages we will still succeed in making progress during
charging.

Do not let the diff stat trick you, patch 2 is a one-line change. All
the rest is moving a couple of functions around and a huge comment :)

RFC -> v1:
- Exported report_freed_pages in case XFS is built as a module (Matthew
  Wilcox).
- Renamed reclaimed_slab to reclaim in previously missed MGLRU code.
- Refactored using reclaim_state to update sc->nr_reclaimed into a
  helper and added an XL comment explaining why we ignore
  reclaim_state->reclaimed in memcg reclaim (Johannes Weiner).

Yosry Ahmed (2):
  mm: vmscan: refactor updating reclaimed pages in reclaim_state
  mm: vmscan: ignore non-LRU-based reclaim in memcg reclaim

 fs/inode.c           |  3 +-
 fs/xfs/xfs_buf.c     |  3 +-
 include/linux/swap.h |  5 ++-
 mm/slab.c            |  3 +-
 mm/slob.c            |  6 ++--
 mm/slub.c            |  5 ++-
 mm/vmscan.c          | 79 +++++++++++++++++++++++++++++++++++---------
 7 files changed, 74 insertions(+), 30 deletions(-)

-- 
2.39.2.722.g9855ee24e9-goog

