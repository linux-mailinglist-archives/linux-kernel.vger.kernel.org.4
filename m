Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F42670D08
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 00:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjAQXP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 18:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjAQXNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 18:13:45 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F0023D91
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 13:00:31 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-4b6255ce5baso439909617b3.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 13:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YHXAUt3ny3FCa4wu6g+W377gbUsNdU3WemYAKDbc46U=;
        b=g/lmjevrSe6/UrgH/yDr3jnG/kI4TrUFxc0eorY+CpDT2ykEH+lJRFAz/cWBd/zEdj
         MVdr/Ofoa6aR32CWHTpBkD8bDur2CQiRIheG7w7pM2NI6BvMQxXWQsrg5n0GwUhoL08J
         LdPT7k+/1CqROg1uiCmQdkoqciMYhUqAlsZBX28L2uX9bktKWGFWNUgc85DPZdW+WP11
         Dkf6Qke8sjXQDbRvg/nVqX5qUNT+3VmFFIOLdIi6kJ+r7CbIcHOYMmbdHH3XgDg1gWBk
         ZM2hyaluuxbAIhpC67CkTkctrYeIFXRpdPjxKqPk4hdSGNqOxe0hx+oxT7VE5OnllhSR
         20iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YHXAUt3ny3FCa4wu6g+W377gbUsNdU3WemYAKDbc46U=;
        b=SEU+ArMJJvug2BMtAOs55RgwJBj5x3gSWT5+OKo0lqaYYqsYFE4+Qumfm/UgNfZjVM
         AIN7xsu+yz+8ShcLgiuxW5lQwQ400OweFKuW6+MSjXa9xQBQYbARz8ejsQG4d0PZ4/F5
         kjhfPs9hhWAsDKCeS41RRBBv9U3vQUiQsTDQfn2c8xk+HC9rljKds1fLQW7Iqp/GkXhk
         IIPhKzonOK6PkeIgkzgeenVJmBXQ9Rux2ckgJzfNqkSYtY9QFMGP6S9ttcyFEn+pQGYl
         p9mS/EBPkiid51iVUzO6c79yoc2tWH9hOxW+WtEfLMRVqT5VnHVrd1RJecTHauFxBENg
         AGOA==
X-Gm-Message-State: AFqh2krw0RYEEVR37bio6yRoDU2kodE7fnhUCU1bXvKxfn3mmJwpjoK8
        eRYxM+lFZnc5XMGDmL2TkGyEnDI/Go7Fo2r40Shsbw==
X-Google-Smtp-Source: AMrXdXtFBxrPIQwrnVbDPkv8eWbIPzbx4cIqKk4Gu4mHweZyTIBkyAUJF5bv5Cr4H2Zct//6eMLnSU/VFnEJZM2Oblg=
X-Received: by 2002:a81:784c:0:b0:4e1:5013:6da1 with SMTP id
 t73-20020a81784c000000b004e150136da1mr666982ywc.218.1673989230419; Tue, 17
 Jan 2023 13:00:30 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-42-surenb@google.com>
 <Y8UxnqPCTLbbD+2F@localhost> <Y8YgomKF189vmgLz@casper.infradead.org>
 <CAJuCfpECJhUu3fvWbBzmAkEA3+1LTkKqJOVadQB_-_mEHME=xg@mail.gmail.com>
 <Y8Y2JErbNQOhL8ee@casper.infradead.org> <CAJuCfpEx6FJpm0Js=cvcHw6mY3izPfoskxseSMyxFAxLX97X_w@mail.gmail.com>
 <Y8bnpqw134CHenz/@casper.infradead.org> <CAJuCfpGKRLshk1oWf1Nz4jhDrMGnkWs7qtWYaj=j_iQwPq0THQ@mail.gmail.com>
 <Y8cFt7GVLTOT5Cdl@dhcp22.suse.cz>
In-Reply-To: <Y8cFt7GVLTOT5Cdl@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 17 Jan 2023 13:00:19 -0800
Message-ID: <CAJuCfpHwmfauZihbexnSq9mEe3Yz0DxT=KwgBX7ATCr2QJp_pA@mail.gmail.com>
Subject: Re: [PATCH 41/41] mm: replace rw_semaphore with atomic_t in vma_lock
To:     Michal Hocko <mhocko@suse.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, akpm@linux-foundation.org,
        michel@lespinasse.org, jglisse@google.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        paulmck@kernel.org, luto@kernel.org, songliubraving@fb.com,
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

On Tue, Jan 17, 2023 at 12:31 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 17-01-23 10:28:40, Suren Baghdasaryan wrote:
> [...]
> > > Then yes, that's a starvable lock.  Preventing starvation on the mmap
> > > sem was the original motivation for making rwsems non-starvable, so
> > > changing that behaviour now seems like a bad idea.  For efficiency, I'd
> > > suggest that a waiting writer set the top bit of the counter.  That way,
> > > all new readers will back off without needing to check a second variable
> > > and old readers will know that they *may* need to do the wakeup when
> > > atomic_sub_return_release() is negative.
> > >
> > > (rwsem.c has a more complex bitfield, but I don't think we need to go
> > > that far; the important point is that the waiting writer indicates its
> > > presence in the count field so that readers can modify their behaviour)
> >
> > Got it. Ok, I think we can figure something out to check if there are
> > waiting write-lockers and prevent new readers from taking the lock.
>
> Reinventing locking primitives is a ticket to weird bugs. I would stick
> with the rwsem and deal with performance fallouts after it is clear that
> the core idea is generally acceptable and based on actual real life
> numbers. This whole thing is quite big enough that we do not have to go
> through "is this new synchronization primitive correct and behaving
> reasonably" exercise.

Point taken. That's one of the reasons I kept this patch separate.
I'll drop this last patch from the series for now. One correction
though, this will not be a performance fallout but memory consumption
fallout.

>
> --
> Michal Hocko
> SUSE Labs
