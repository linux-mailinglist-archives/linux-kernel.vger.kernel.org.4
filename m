Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B046874904F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 23:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbjGEVy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 17:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjGEVyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 17:54:54 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27350198E
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 14:54:53 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-bff27026cb0so8041380276.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 14:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688594092; x=1691186092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/lEjeaJKV9LlXi1k1z02f2PJIzF7WHFogLjflvF0PeI=;
        b=OzVmM+rgHvkIoKrmM08c+GV2eEikQ6FIM7iy2jKO8PH7pcVoImd0XlY3faSJLXojFv
         iLS42b4kIjjLm2BU4F8gXCdpuYbmEPsLARtnsClM0Ep0lluoP02lpL2S+tO+eQlScEiP
         aBldBZGbyQrqWks0bkIDM/rjVaTYCOKPc7iVv0wjNC5wXYTL7yFMNHA1j6y+pvxEEmBS
         Cle4mtGoUBYfERWdq12DdKYKDpCGNTf8UBOag8XAvH+NFJVJ4+wfWd4fIV9/GaONBliv
         WkjP4MoRX4XsFFDDejMNuSccEbFON/xdjyWoNzvSNSJWWMhLYWJBCViYRaI90qN/KZ4A
         ZMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688594092; x=1691186092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/lEjeaJKV9LlXi1k1z02f2PJIzF7WHFogLjflvF0PeI=;
        b=HMiR2EMeJwcea4UXk8Y83lGdhSvXsgy7pAekG4FEoP9X1Hw9Qcj8AWPfVDlmrPAT5A
         jmSyRnnuRVOd9CyMWialCnmOKImzX03GlhygisZiUALoZzFmKooTMyX/G/Yql4nzXcER
         A89MPAr+wDFH0e+8Ab/bjcxXzdjdgs/pezGiGcGx9Qm8n62yhIlwZWSWwVJ951jBRrtn
         a8iVyLtAU7m1jYVJNNZX22Jl2Nx32kecm7lN3fWiG26Zy69GUn3a3XwRDYEPzGICSQkP
         jCe82qwJONqhcL/QsJeol7TxFmIdU3Urbxad64toOr6Nhc5LeV+U3SJNQDP/J8WG6nps
         THDQ==
X-Gm-Message-State: ABy/qLYeWr10mO57N9jeoPuAPy+WNHM5Ga4/oL6AOrVMHNguXk7q77rF
        zESeEFPZW0mqT/OKodzJvWrcRosMYKGU1gVjpZM7zA==
X-Google-Smtp-Source: APBJJlG3pO/OUr9ZM4kywYL83J7aI9+LAADDvCgM6kcDjGtYf7/JKrgsRE+xlLjjN76P0+cP01PZykYcWRl09YUhZ84=
X-Received: by 2002:a25:ea43:0:b0:c5d:c5c2:b46d with SMTP id
 o3-20020a25ea43000000b00c5dc5c2b46dmr123430ybe.55.1688594090753; Wed, 05 Jul
 2023 14:54:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230705171213.2843068-1-surenb@google.com> <20230705171213.2843068-3-surenb@google.com>
 <3cdaa7d4-1293-3806-05ce-6b7fc4382458@redhat.com> <CAJuCfpGTNF9BWBxZoqYKSDrtq=iJoN1n8oTc=Yu0pPzW8cs8rQ@mail.gmail.com>
 <ZKXRsQC8ufiebDGu@x1n> <ZKXgXFfrBzUjfkDN@casper.infradead.org>
In-Reply-To: <ZKXgXFfrBzUjfkDN@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 5 Jul 2023 14:54:39 -0700
Message-ID: <CAJuCfpEYMQFhGv5OPWkFS5a3xhia2OkpjOu15s-Aq2_P8CCJUw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mm: disable CONFIG_PER_VMA_LOCK until its fixed
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        akpm@linux-foundation.org, jirislaby@kernel.org,
        jacobly.alt@gmail.com, holger@applied-asynchrony.com,
        hdegoede@redhat.com, michel@lespinasse.org, jglisse@google.com,
        mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org,
        mgorman@techsingularity.net, dave@stgolabs.net,
        liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
        chriscli@google.com, axelrasmussen@google.com, joelaf@google.com,
        minchan@google.com, rppt@kernel.org, jannh@google.com,
        shakeelb@google.com, tatashin@google.com, edumazet@google.com,
        gthelen@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 5, 2023 at 2:28=E2=80=AFPM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Wed, Jul 05, 2023 at 04:25:21PM -0400, Peter Xu wrote:
> > There'll still try to be a final fix, am I right?  As IIRC allowing pag=
e
> > faults during fork() is one of the major goals of vma lock.
>
> Good grief, no.  Why would we want to optimise something that happens
> so rarely?  The goal is, as usual, more performance.  Satisfying page
> faults while mmap()/munmap()/mprotect() are happening is worthwhile.
> Those happen a lot more than fork().
>
> In this case though, there's also a priority-inversion problem that
> we're trying to solve where process A (high priority) calls mmap() while
> process B (low priority) is reading /proc/$pid/smaps and now (because
> rwsems are fair), none of process A's other threads can satisy any page
> faults until process B is scheduled.
>
> Where on earth did you get the idea that we cared even a little bit
> about the performance of page fault during fork()?

I think the original reasoning for Android to improve app launch time
could have made that impression. However the speed up there comes not
from allowing page faults into the parent process (Zygote) while it
forks a child but rather from the child being able to fault pages and
establish its mappings concurrently.
