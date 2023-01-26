Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F4C67D0F9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 17:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbjAZQKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 11:10:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjAZQKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 11:10:39 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C8415561
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 08:10:38 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id d132so2563178ybb.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 08:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZillkAQcPkfKcuR5z2FouZl025AEUWnaCf8P3oZ7OXA=;
        b=dnxwXMBLep5R+FehvqPgRhUAguuUtvmXE3Ig6NgptPHYVWIRfyKSvsp5vzKcOhhin8
         Y8Xtmu+WwcdZSDk6wkPgW7Fvaeq2vIQEHqJcRKjz3HMN0WxNn5YkqCtyW+tukJBK/H6B
         2a95hltksedzFqojZM11HXR5tDWNzKtsfI34jfOPOy3rYuwkMiq/4uLqkh02F9NnXaON
         LIzRMI4TVIAYMq5JVOiYS/9h1FSjJ+kkcjInPnFxFs5N3qv5B0l8RSyBNdfLEOEvS+H5
         zvs/hmgowHhxsRrzAOlo0dJxHNc/nC7Fo/Vb1sNUS2zO713oOq7Jv9SDri/HSNsmK9jD
         7y3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZillkAQcPkfKcuR5z2FouZl025AEUWnaCf8P3oZ7OXA=;
        b=k5RX7LQ9Chx/8/Ivn9o0amtFwFIELBU4LyakwimYmgkvu7hz9Mvkq52fIGnIE3gwXb
         hS/aZwofs90zjNSxbkh0GDqNbuTmVjHlJldYqXVcZbbLwv+l/rLfY5+egfQNpfq7u5zP
         GxKAKmEjSTKN/l2mpIEqqvF7rLFk1JAvNOpHNFh1BWXUTeA5aZ4k9qIexqU8IbU/r1AE
         TR9aZZ0CMoQNW9j3RLOQAe4oH1IVUTEG34rQnGmuHsQ4nbBHNAw5VhhhHlKryp31t5xA
         Qs/FHpO/KWktGi2yaqDcDVHW6UgOHFyffpdqTnvLV/kDTcysLRHAPueYiUntt2yhcVg6
         d6jg==
X-Gm-Message-State: AO0yUKWXMfBLxtAbEgT7zCHoy4+fBgHfC62BEi/TKkd8KtK304TCrENp
        PsfK0xfyCrCcI1rMtkjiDzpQxMM01L2WIbmTRClxWQ==
X-Google-Smtp-Source: AK7set9O1l93hGrWLunCpG3rRqj7icW6f5ntPr5CkFep+bB1YJY+4Iq5pDRLfxFVN6CNNogAmMZ46djgKR1gZe+HLYY=
X-Received: by 2002:a25:5209:0:b0:80b:5988:2045 with SMTP id
 g9-20020a255209000000b0080b59882045mr1087115ybb.59.1674749437114; Thu, 26 Jan
 2023 08:10:37 -0800 (PST)
MIME-Version: 1.0
References: <20230125233554.153109-1-surenb@google.com> <20230125233554.153109-5-surenb@google.com>
 <20230126151015.ru2m26jkhwib6x6u@techsingularity.net>
In-Reply-To: <20230126151015.ru2m26jkhwib6x6u@techsingularity.net>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 26 Jan 2023 08:10:26 -0800
Message-ID: <CAJuCfpEzAbpy9rZ5KeZXQsqFTPOGYv6CZQfP9SHqcqFi0s7neg@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] mm: replace vma->vm_flags direct modifications
 with modifier calls
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, dave@stgolabs.net, willy@infradead.org,
        liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        jannh@google.com, shakeelb@google.com, tatashin@google.com,
        edumazet@google.com, gthelen@google.com, gurua@google.com,
        arjunroy@google.com, soheil@google.com, hughlynch@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 7:10 AM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Wed, Jan 25, 2023 at 03:35:51PM -0800, Suren Baghdasaryan wrote:
> > Replace direct modifications to vma->vm_flags with calls to modifier
> > functions to be able to track flag changes and to keep vma locking
> > correctness.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Acked-by: Michal Hocko <mhocko@suse.com>
>
> Acked-by: Mel Gorman <mgorman@techsingularity.net>
>
> Minor comments that are safe to ignore.
>
> I think a better name for mod_vm_flags is set_clear_vm_flags to hint that
> the first flags are to be set and the second flags are to be cleared.
> For this patch, it doesn't matter, but it might avoid accidental swapping
> in the future.
>
> reset_vm_flags might also be better named as reinit_vma_flags (or
> vma_flags_reinit). Maybe also encourage the use of [set|clear_mod]_vm_flags
> where possible in the comment to track exactly what is changing and
> why. Some cases like userfaultfd just want to clear __VM_UFFD_FLAGS but
> altering the flow in this patch is inappropriate and error prone. Others
> such as the infiniband changes and madvise are a lot more complex.

That's a good point, but I don't want people to use mod_vm_flags() for
the cases when the order of set/clear really matters. In such cases
set_vm_flags() and clear_vm_flags() should be explicitly used. Maybe
to make that clear I should add a comment and rewrite the functions
as:

void mod_vm_flags(vma, set, clear) {
    vma.vm_flags = vma.vm_flags | set & clear;
}

In this patchset it's not that obvious but mod_vm_flags() was really
introduced in the original per-VMA lock patchset for efficiency to
avoid taking extra per-VMA locks. A combo of
set_vm_flags()+clear_vm_flags() would try to retake the same per-VMA
lock in the second call while mod_vm_flags() takes the lock only once
and does both operations. Not a huge overhead because we check if the
lock is already taken and bail out early but still...
So, would the above modification to mod_vm_flags() address your concern?

>
> --
> Mel Gorman
> SUSE Labs
