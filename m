Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196E27492ED
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 03:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbjGFBOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 21:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjGFBOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 21:14:05 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019221700
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 18:14:05 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bb0d11a56abso104525276.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 18:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688606044; x=1691198044;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/ZvjsLzR90/Ihxg7W2cQFYrdAaC3RTmM6cS2FPW4Hig=;
        b=M5IX75oaI5+U+XxwObu9YSuPnYLffE9WfpI1afLQJyuZ8ZdqQzSucCDlj3g5M5PuYZ
         GsZp07pN00tTE+vWh7rvzdQ2h/PvSjrslMecjY9k8CxrDbycHpXPsX/eJlCQoGUrIPpz
         5DjkcITZwm9WsevSIjZ5YrQVBsdE/akRWew0G7xNfaEdgcd2aG2WvNO2LOgCnmYUfkUx
         RZ7L0soWGM73GloOpd8UJJCcY4U+Nkb2yrVBeQGyNKQAVhdwZPP7lEjQzjA0VM9wmdPP
         hrLCj2TQXAmiBvtocX3y+KheOs+hqyBVAJUjvTR+A5I1O3diUYY/iVRtZGt06Dx+fZrK
         qc3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688606044; x=1691198044;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/ZvjsLzR90/Ihxg7W2cQFYrdAaC3RTmM6cS2FPW4Hig=;
        b=B3AHDrPQDqddfveSTe8lGdL9ch0MmihjPMwOPNfhroOdgE1T833x/f+hc4ud03NFpe
         cMR8gPhmFBv5GwiDX/DmMhkXTbU+Brk9fJax30phzB5ELbxUQeKp20fzPJeYH+WWBWyl
         rkzHa00jrWFM+YkBDvhnXYmmuzOKvRl/qDTJc8gjTIaNMqK4gJkrWUkfBoxHAHgOOQfl
         Gfx/oACNnd+J6+KXMdNGouGa2e8GnyhJv9Jcw7A42BeHpI4c9OSxdHUkqEG0PiVAyv45
         TrNWoeRhTIY3lOINHHbusOa00v/es7wcSv9F8IGOpZtOj9OOD2IHJKxwyHA1+Dq8Y56J
         vr2g==
X-Gm-Message-State: ABy/qLa2OXMdQ+KfcIzvRaZ8bR59M8gGrtekv7REbKIVAVyxqHt9Qq0p
        2NP3uy2lfOPZ14lV+njp6qMoR8ThGQE=
X-Google-Smtp-Source: APBJJlEt8HfzqWqwQiw75adRHvjlP3xBCgQKrxmzHqhU1j9EJbyqaYHCgGKMeEKDjFzgklMWWacm6BoOT+0=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:946c:be30:90d9:9093])
 (user=surenb job=sendgmr) by 2002:a05:6902:30b:b0:c67:ebc5:de5d with SMTP id
 b11-20020a056902030b00b00c67ebc5de5dmr2439ybs.4.1688606044026; Wed, 05 Jul
 2023 18:14:04 -0700 (PDT)
Date:   Wed,  5 Jul 2023 18:13:58 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230706011400.2949242-1-surenb@google.com>
Subject: [PATCH v4 0/2] Avoid memory corruption caused by per-VMA locks
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
        autolearn=ham autolearn_force=no version=3.4.6
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
shows ~7% regression. If such fork time regression is unacceptable,
disabling CONFIG_PER_VMA_LOCK should restore its performance. Further
optimizations are possible if this regression proves to be problematic.

Patch 2/2 disables per-VMA locks until the fix is tested and verified.

Both patches apply cleanly over Linus' ToT and stable 6.4.y branch.

Changes from v3 posted at [3]:
- Replace vma_iter_init with vma_iter_set, per Liam R. Howlett
- Update the regression number caused by additional VMA tree walk

[1] https://bugzilla.kernel.org/show_bug.cgi?id=217624
[2] https://lore.kernel.org/all/20230227173632.3292573-30-surenb@google.com
[3] https://lore.kernel.org/all/20230705171213.2843068-1-surenb@google.com

Suren Baghdasaryan (2):
  fork: lock VMAs of the parent process when forking
  mm: disable CONFIG_PER_VMA_LOCK until its fixed

 kernel/fork.c | 6 ++++++
 mm/Kconfig    | 3 ++-
 2 files changed, 8 insertions(+), 1 deletion(-)

-- 
2.41.0.255.g8b1d071c50-goog

