Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21E07489EA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 19:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjGERMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 13:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjGERMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 13:12:18 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB12B173F
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 10:12:17 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-579dd7e77f5so49510817b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 10:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688577137; x=1691169137;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ov6LRlh9LCdAcznRqf58Iol/cEMbf+u2BMkn78BN9Oo=;
        b=T+mg0OFmgyXoHB2xUaxm9bI4N2paEqU77xhwnCoD437rE/Z/Llg19AEluRmHAbVMx0
         I0BZQ7u/eO4Ij5I/NThKezUth0qUGDXM5G+daFzn7MOrQjk4F0RzI+viZxO0comk49pn
         Y8IuBNJSr0aaErcvx0gMtv3EX9xM1HqGpGhFReOjMEKGI1+xcg+q8uxvzpQxG5K/ZDUS
         /ErPZNZ2957JqkKSfPiD0t/UasiQeM30ZPI9PleSoysvKxLx9H1bTrVkISH23PoumPBp
         TUPT7I81Wc8WU3NpCs5K54aliI8UAg7s5K6AsmFIOL1ld3FjOwld7HxD1hbhbc+sMUOH
         s2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688577137; x=1691169137;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ov6LRlh9LCdAcznRqf58Iol/cEMbf+u2BMkn78BN9Oo=;
        b=Qy+V8TcGtkRaG5tG4xmBNGaD2Pr4lxthgMNRDj/MvSuDvgKueffk2xUUdhjdwIl4XM
         graa/BkpNBPKFGkcSCLgSB3OttdbthZdHuDKDjd1C1+5IAe8UrVJrdrX4ydc6204rNnz
         hxoVxZG4y9T6WCzVFZttuJWGneU2QpCiyrnT0OM1HA4kfFsDMRvqfuzGR2Aca24W+HEy
         /+HLAkyzKmPeQ7wFU6qb/ezuLK3lBxHmwMAjRWpVeU4s/INTolS0n+akcsjs+KkdGxDo
         JZIBsfA0hgm4AAVoubeWTREOzb3xzdX71YqsINVSubUGJzZFksZbx1ot58VGeEliLdTK
         pLMw==
X-Gm-Message-State: ABy/qLbbrQd58wQZqXyaKumMDq1SychKdZQQFg7fO3iZ6hrqKZ9JyFzH
        CS6XfT6VQbaKyuygD5K4LG5V0l4z5mI=
X-Google-Smtp-Source: APBJJlFqC2MtdmTPgc1v7+QBlSCtCP4tG5yIre7Jg4XHgPH/Ze+FST6lwDib3ryjRXTWbz8lERZ1X7bsWMU=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:946c:be30:90d9:9093])
 (user=surenb job=sendgmr) by 2002:a81:ca0d:0:b0:576:fc37:e6c3 with SMTP id
 p13-20020a81ca0d000000b00576fc37e6c3mr109707ywi.9.1688577136832; Wed, 05 Jul
 2023 10:12:16 -0700 (PDT)
Date:   Wed,  5 Jul 2023 10:12:10 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230705171213.2843068-1-surenb@google.com>
Subject: [PATCH v3 0/2] Avoid memory corruption caused by per-VMA locks
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     jirislaby@kernel.org, jacobly.alt@gmail.com,
        holger@applied-asynchrony.com, hdegoede@redhat.com,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com, paulmck@kernel.org,
        mingo@redhat.com, will@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
        chriscli@google.com, axelrasmussen@google.com, joelaf@google.com,
        minchan@google.com, rppt@kernel.org, jannh@google.com,
        shakeelb@google.com, tatashin@google.com, edumazet@google.com,
        gthelen@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A memory corruption was reported in [1] with bisection pointing to the
patch [2] enabling per-VMA locks for x86. Based on the reproducer
provided in [1] we suspect this is caused by the lack of VMA locking
while forking a child process.

Patch 1/2 in the series implements proper VMA locking during fork.
I tested the fix locally using the reproducer and was unable to reproduce
the memory corruption problem.
This fix can potentially regress some fork-heavy workloads. Kernel build
time did not show noticeable regression on a 56-core machine while a
stress test mapping 10000 VMAs and forking 5000 times in a tight loop
shows ~5% regression. If such fork time regression is unacceptable,
disabling CONFIG_PER_VMA_LOCK should restore its performance. Further
optimizations are possible if this regression proves to be problematic.

Patch 2/2 disabled per-VMA locks until the fix is tested and verified.

Both patches apply cleanly over Linus' ToT and stable 6.4.y branch.

Changes from v2 posted at [3]:
- Move VMA locking before flush_cache_dup_mm, per David Hildenbrand

[1] https://bugzilla.kernel.org/show_bug.cgi?id=217624
[2] https://lore.kernel.org/all/20230227173632.3292573-30-surenb@google.com
[3] https://lore.kernel.org/all/20230705063711.2670599-1-surenb@google.com/

Suren Baghdasaryan (2):
  fork: lock VMAs of the parent process when forking
  mm: disable CONFIG_PER_VMA_LOCK until its fixed

 kernel/fork.c | 6 ++++++
 mm/Kconfig    | 3 ++-
 2 files changed, 8 insertions(+), 1 deletion(-)

-- 
2.41.0.255.g8b1d071c50-goog

