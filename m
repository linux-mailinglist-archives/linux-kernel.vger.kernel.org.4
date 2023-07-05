Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B7C747D2B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 08:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjGEGhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 02:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjGEGhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 02:37:18 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED6D10F5
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 23:37:16 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c5f4d445190so915173276.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 23:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688539036; x=1691131036;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BNM3ckJTzrs+Qtx0MSH2wUDuLpemGF9U/qRKd6gB/0I=;
        b=FPI02RPBavB0s2cOgTMxsTxDjK6HcxF+4CxMdPNIOU5edN7324DqWyNUhgPsYbc8iD
         Oz07Xt/SplMXjghqlmDcDhX7jDUWE0edxqRq8WziM5kDw4pKQ18+Vt4Gjtx7xPjOqJen
         t4kuN8wrWsDc765HgsNYZwPkRSEC8ltu12Zml2Og9TmUucW2d3xfubJUH8p6kTlF9rVa
         78l5LWoKZP3H9juX4G+FAAl+toCPQDfh9tc8EWKoIHfzgH4fb33s+b04N3BWHobppLwp
         wauezKrvSmhSRDbgoa6BuSX1kLYOwVdQe1UMLzfcGnpF5B5TVpbSiSFXR6YigjhfQdAY
         44Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688539036; x=1691131036;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BNM3ckJTzrs+Qtx0MSH2wUDuLpemGF9U/qRKd6gB/0I=;
        b=HTjdocXf4s29wn8khN8UqHrBu1n4tuw0hwMFOfqzLKguSGvccWkngXjMlg78kjJ4ac
         7I86UH/VGA9/bTrKV8MroA878TPLNjWU6xqATsDv+DIXzofcmDPstynsbhvxwmMDl/K3
         S56rBtEILcrs6zODUjWahPj6zxHQzjdSZh2S3xg9Arjz/jODmrVsDS89zSjS3+D222aZ
         CCnV92K+N8bQVFTmhKeNhaPeqB/fmTVxllSZxugsuNofsr1L8fm/9v1Te5kVWEnsIWV0
         0JwwBJYMc0gpXR8JW5/4vym30pSWs50Pi6vwPPrHLHCSHnH1s+otXV0hBG3JMlrYUwzL
         kcKQ==
X-Gm-Message-State: ABy/qLYw2UYfx8NGt/nfDRtyHQiXMKt2XrXeXcGV2qh6QMRqbu0y9a+z
        A4BXzXUK4ulPIPXeLdeMdEXD5y9APDs=
X-Google-Smtp-Source: APBJJlHtdVKStwWSSVESkwAGyliTYU+oGdhDx8vuo7xuQ+VgKf9L1ueNUYqm52uIFme0+sqSxVO66bl65Q0=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:9164:ef9f:8918:e2b6])
 (user=surenb job=sendgmr) by 2002:a25:a404:0:b0:bc8:c749:eede with SMTP id
 f4-20020a25a404000000b00bc8c749eedemr82399ybi.7.1688539035748; Tue, 04 Jul
 2023 23:37:15 -0700 (PDT)
Date:   Tue,  4 Jul 2023 23:37:09 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230705063711.2670599-1-surenb@google.com>
Subject: [PATCH v2 0/2] Avoid memory corruption caused by per-VMA locks
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
shows ~5% regression. If such fork time regression is unacceptable,
disabling CONFIG_PER_VMA_LOCK should restore its performance. Further
optimizations are possible if this regression proves to be problematic.

Patch 2/2 disabled per-VMA locks until the fix is tested and verified.

Both patches apply cleanly over Linus' ToT and stable 6.4.y branch.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=217624
[2] https://lore.kernel.org/all/20230227173632.3292573-30-surenb@google.com

Suren Baghdasaryan (2):
  fork: lock VMAs of the parent process when forking
  mm: disable CONFIG_PER_VMA_LOCK until its fixed

 kernel/fork.c | 1 +
 mm/Kconfig    | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

-- 
2.41.0.255.g8b1d071c50-goog

