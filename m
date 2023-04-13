Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7233D6E16AA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 23:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjDMVsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 17:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjDMVsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 17:48:36 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02867AAD
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 14:48:34 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-328cb023b1dso424705ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 14:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681422514; x=1684014514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RD2fRmal2NjTDY5yJT0tGTgYK55XlqNgudqG7PmgPvQ=;
        b=68rX+T6hv2ZKS7obJi2VtlEac6GKlnjH2mU+yC37pc2f6wVbIBjopiIenRNC0cpine
         7TuIEaG7xNwXxKDXpSCWXY3A+s5Pq2bxLJIq8gWm5QJs6lycBwKbzs6ekrJfbrn0ZS6U
         l4ikf/6tDgKeG0ObJvVl9s6r7QwmkB7cbys9xTxbwiGUlPo9Dn3+rwrkyRk86MgL01jw
         cvGQsOG5bJv9nPUdfB5AWTE+r6WelTfK5F2fB97yzvXWAl+gz28f5MZRnrYzrk9O1QrT
         +K0n8u0Pra+IkR8kzES273HAtjkGKJtsYaQrcpqPtcZJLAsTuXeGsYh5ou7eZ81Yi+me
         QL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681422514; x=1684014514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RD2fRmal2NjTDY5yJT0tGTgYK55XlqNgudqG7PmgPvQ=;
        b=D40ko/3g7t4z+/owLckCJF+tISJD8/HagsfYgOJygouQOarf3sxtbQQ60C3xOeHn2W
         UYolqqAmd0hXQ6Kbdw2ao7gGN74LS2UzyJhnm/N5y/sJ26WWE2c0mRz5OU4q3bHrO0tE
         JtcP2w8K1XHBdaelL/wjjT76t5dKcvxrIa87vVIrbNcc74QYZ6HZHFAb+nKUYh/wS8tk
         dAJbDb9SacEkco8nZCTxjcTWwc7OZo4QSWjlBYtMQix7RnREDuE+g++NJY39Nk9DD84w
         PzFJVZT+SAVoPGaPDM0VsvZ7+iRDq5QpesdPzWedQNRbj4uJ8E34Ib8ZCLK7dmpkXOx3
         hOwQ==
X-Gm-Message-State: AAQBX9fD7kVIgDQQM1OD/GB9eWockRg5DMZuG13JVCerDD4LcwfgdihJ
        nMF0/0eWcyevoi8PCQdhpEJRRdHcceN9vCgSIMVrSA==
X-Google-Smtp-Source: AKy350ZfPDkuvUkUubYdknjmNsu52dhASA7KBEjK6x0SS9igH4uQICMYy/StRSyrmNOjXHGurvUlPU1dbZo3Td2Dj5E=
X-Received: by 2002:a05:6e02:1b86:b0:328:a484:3409 with SMTP id
 h6-20020a056e021b8600b00328a4843409mr28891ili.7.1681422512776; Thu, 13 Apr
 2023 14:48:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230413214326.2147568-1-kaleshsingh@google.com>
In-Reply-To: <20230413214326.2147568-1-kaleshsingh@google.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 13 Apr 2023 15:47:56 -0600
Message-ID: <CAOUHufYjLf2RD2Y7wcebjvvDRHDT9cCG6sPbQ2JaTyyB306JOw@mail.gmail.com>
Subject: Re: [PATCH] mm: Multi-gen LRU: remove wait_event_killable()
To:     Kalesh Singh <kaleshsingh@google.com>, akpm@linux-foundation.org
Cc:     minchan@google.com, surenb@google.com, wvw@google.com,
        android-mm@google.com, kernel-team@android.com,
        Minchan Kim <minchan@kernel.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>,
        Suleiman Souhlal <suleiman@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 3:43=E2=80=AFPM Kalesh Singh <kaleshsingh@google.co=
m> wrote:
>
> Android 14 and later default to MGLRU [1] and field telemetry showed
> occasional long tail latency (>100ms) in the reclaim path.
>
> Tracing revealed priority inversion in the reclaim path. In
> try_to_inc_max_seq(), when high priority tasks were blocked on
> wait_event_killable(), the preemption of the low priority task to call
> wake_up_all() caused those high priority tasks to wait longer than
> necessary. In general, this problem is not different from others of
> its kind, e.g., one caused by mutex_lock(). However, it is specific to
> MGLRU because it introduced the new wait queue lruvec->mm_state.wait.
>
> The purpose of this new wait queue is to avoid the thundering herd
> problem. If many direct reclaimers rush into try_to_inc_max_seq(),
> only one can succeed, i.e., the one to wake up the rest, and the rest
> who failed might cause premature OOM kills if they do not wait. So far
> there is no evidence supporting this scenario, based on how often the
> wait has been hit. And this begs the question how useful the wait
> queue is in practice.
>
> Based on Minchan's recommendation, which is in line with his commit
> 6d4675e60135 ("mm: don't be stuck to rmap lock on reclaim path") and
> the rest of the MGLRU code which also uses trylock when possible,
> remove the wait queue.
>
> [1] https://android-review.googlesource.com/q/I7ed7fbfd6ef9ce100533475281=
25dd98c39e50bf
>
> Fixes: bd74fdaea146 ("mm: multi-gen LRU: support page table walks")
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Reported-by: Wei Wang <wvw@google.com>
> Suggested-by: Minchan Kim <minchan@kernel.org>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>

Acked-by: Yu Zhao <yuzhao@google.com>
