Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDEC573452D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 08:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjFRG52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 02:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjFRG5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 02:57:25 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D3DE77
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 23:57:24 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-565a33c35b1so32155147b3.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 23:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687071444; x=1689663444;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=myYEJQ4cXoxihGQz14f2NgKY1m5nccoqkiKaHRCGLnA=;
        b=f8hZG5EV1v8ur0Uofbbm4KrkwSDeIuesyp1vSzziXgT41RJNgW7DnUeNXNS4qH2atl
         I1UDna+07xwVf6Drz61wbRkC4OLnbYypo8GOdxdYQ2Lltrp+/ubLWkOdxAlLpaPnx0XK
         OnBtKJXwjNtbvMz7a4xeAzeCbfZGpawFhJjfWKNbr+iKy2S8LrQJCqhHLw8pIbZrn3lI
         HCQaHctYUwL2cnhuule9c5VbVqClwrtziyAi1OYAcqH7md99Qjvpipq4fPTdcehGbfF/
         TiZ6ruO+/dS5pL9VmyaTRN3fonOjPmJHMzh6mwNAU/xR9LLzxDNdxBlnlinQJGc9RZhP
         ALzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687071444; x=1689663444;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=myYEJQ4cXoxihGQz14f2NgKY1m5nccoqkiKaHRCGLnA=;
        b=e9sZgcxIEfHXMUCBjT9aWIuNvjnxgWQbhNH33cacEMZMK21nIcCq0YMrgYT8QJ8tQ5
         3pW1U2O/cOQMh2DB07ZT9mAhJ/BbPW26B+bKfJcZ5faCmjUboy++5o8S11sy94zwRE9p
         OqsIqA9Iq4+fUxFFJNjhvZRMFXeWq/hsy5SV/hjegiWdUPxYUaIZQ7ZLwqW+uLLl3XQ2
         rB/JfNQaTA0BXxHI6OBH2CSkfQJN3OAt6K2c6S3InxcM1PoKFQOogy8IFA9xA8RJRpaU
         Rd7EsGQqBTK7YCVOxuhv22ebveiw8YElXT3C75D12sFIjmHc9etAIWaDNQ+n94PSAgJ4
         wmuQ==
X-Gm-Message-State: AC+VfDxWZOOxvXEpkeqi4Ya293ujbgGMNKxcxP+29SOgM7MjbkEaanbz
        7KR1dHPT9eWU+Kb9JLDxmNhwwAy63XOEgTS9
X-Google-Smtp-Source: ACHHUZ58bBzWyWP210cPGPFNgbxSxsLYVqUXiVVtq+n6XV4dr+17yNK31Laxw3pjV5T0hOoBcXTORg7IVJ2Q5Cv6
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a81:ae0d:0:b0:573:285a:c2a3 with SMTP
 id m13-20020a81ae0d000000b00573285ac2a3mr699145ywh.1.1687071443846; Sat, 17
 Jun 2023 23:57:23 -0700 (PDT)
Date:   Sun, 18 Jun 2023 06:57:19 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230618065719.1363271-1-yosryahmed@google.com>
Subject: [RFC PATCH 0/5] mm/mlock: new mlock_count tracking scheme
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Yu Zhao <yuzhao@google.com>,
        "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>,
        Steven Barrett <steven@liquorix.net>,
        Brian Geffon <bgeffon@google.com>,
        "T.J. Alumbaugh" <talumbau@google.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        David Howells <dhowells@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Greg Thelen <gthelen@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series attempts to rework the mlock_count tracking scheme to avoid
overlaying page->lru. The main goal is to revive the unevictable LRU,
which would be useful for upcoming work for offline memcgs recharging
[1]. For that work, we need to be able to find all the pages charged to
a memcg, and iterating the LRUS is the most efficient way to do it.
With the current mlock_count scheme, the unevictable LRU is imaginary,
as page->mlock_count overlays page->lru.

The proposed scheme overloads page->_mapcount to track mlock_count for
order-0 pages, slightly similar to how page->_refcount is overloaded
for pincount. More details in patch 1.

Another advantage of this series is that we do not have to reset the
mlock_count everytime we isolate an mlocked page from the LRU. This
means we can more reliably track the mlock_count -- we are less likely
to prematurely munlock() a page. We also do not need to re-initialize
the mlock_count every time we add an mlocked page to the LRUs, or every
time we found that it was reset during mlock/munlock. The lack of
re-initialization slightly simplifies the mlock_count logic. The
complexity is also more contained within mm/mlock.c.

This series is based on v6.4-rc6, and has been tested with the mlock
selftests (though I had to rebase to v6.2 to get those selftests
working).

The series is broken up as follows:
- Patch 1 is the actual rework of the mlock_count scheme.
- Patch 2 handles the case where a page might be mistaknely stranded as
  mlocked indefinetly if it was mapped a very large number of times.
- Patch 3 adds a WARN_ON() in case a very large number of mappings can
  be mistakenly interpreted as an mlock_count.
- Patch 4 revives the unevictable LRU.
- Patch 5 reverts a patch that was part of the original mlock_count
  series [2] that is no longer needed now.

[1]https://lore.kernel.org/linux-mm/CAJD7tkb56gR0X5v3VHfmk3az3bOz=wF2jhEi+7Eek0J8XXBeWQ@mail.gmail.com/
[2]https://lore.kernel.org/linux-mm/55a49083-37f9-3766-1de9-9feea7428ac@google.com/

Yosry Ahmed (5):
  mm/mlock: rework mlock_count to use _mapcount for order-0 folios
  mm/mlock: fixup mlock_count during unmap
  mm/mlock: WARN_ON() if mapcount overflows into mlock_count
  mm/vmscan: revive the unevictable LRU
  Revert "mm/migrate: __unmap_and_move() push good newpage to LRU"

 include/linux/mm.h        |  31 ++++++--
 include/linux/mm_inline.h |  11 +--
 include/linux/mm_types.h  |  24 +-----
 mm/huge_memory.c          |   5 +-
 mm/migrate.c              |  24 +++---
 mm/mlock.c                | 150 +++++++++++++++++++++++++++++++++-----
 mm/mmzone.c               |   8 --
 mm/rmap.c                 |   3 +
 mm/swap.c                 |   8 --
 9 files changed, 174 insertions(+), 90 deletions(-)

-- 
2.41.0.162.gfafddb0af9-goog

