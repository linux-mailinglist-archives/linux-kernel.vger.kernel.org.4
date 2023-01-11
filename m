Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C6A66658E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 22:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235211AbjAKVYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 16:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235157AbjAKVXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 16:23:48 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3DD3F454
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 13:23:48 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-4a2f8ad29d5so212520937b3.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 13:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SxCfhGNrfWy89W/U+pPUVQaJLaBqtZaaZxJq5wlMRbw=;
        b=AlFLNWR2lfiXPfEMGFqHZytcNNrUL9Uj9qeAqkeKRYgTrO2dCdhF9YPB5VkmKVyv2h
         kfDuyeZ0c2W077izhhNcCx4PzDF+gJ2VLHARsWGsxazXli8H8VYDDOjK5W34rgwB62i6
         iPyeCKiIhFaM471RKJFtueTSOvbG31VbMye+Z/zVohNQSHKqqi14CnP8+P7P3kEL3S5S
         nSBSCMQRiDK55LzhXVB3FSialBZ5FiyQBR4BCpnLtN7Eq2tXD30YcBcPHELpFHw7JPAU
         DceYtiB1wobFLb7CkOWU6Yuw9oTRkFdP/RRU8Wc5gMEB/DeAD4cvlXv4ZOBaAO+du5We
         xOFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SxCfhGNrfWy89W/U+pPUVQaJLaBqtZaaZxJq5wlMRbw=;
        b=BNq9K4fdV7bzYYsowAn88cIxiW4/TcUs1YzoIluLRQ9s0korjoHhzZrRZxBXlVVb7x
         J+oM4VQ/BQ0fI4APTsKF6S+uokE9L6JjVHAzeqUjkITr6yQxpeSUdO3B0MH26+MqmSCM
         +0tvGXqcFU9d93tHThYwbll73vqNma+YMLKyghqre9+DY44CP/M0ld5gdD1ZymxYIIzo
         XC8PAB3XGg113zAFZIlwbUfVhf+9cmi7dcrb9O9PvEL9yTvbvbIUyGggjNsmk88Efp82
         8t3pF0gcrF52arO9EGrqXxqf7CYr3bUt5dH2SGop96rOtjiZGloajN6hidtv+YkWrFEz
         XTuA==
X-Gm-Message-State: AFqh2koPROTVD3/AF9idaOQW5FPnwpswGtINWMmc7C4jT6NaqJSw0C/W
        tHlEFFiLGUhilcYJLTVeHbVqvw37wVa9c843a2Mj3g==
X-Google-Smtp-Source: AMrXdXvkk9wMrdla5WxSOI7zrH4TdD8mYzSa58gnz4fRSmPZ7cdc+yy1/593wOoB6SdGGhG6a9NhgrILr9krFbI1xEA=
X-Received: by 2002:a81:c56:0:b0:490:89c3:21b0 with SMTP id
 83-20020a810c56000000b0049089c321b0mr6779232ywm.132.1673472227332; Wed, 11
 Jan 2023 13:23:47 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-14-surenb@google.com>
 <20230111154726.stadwtzicabwh5u5@offworld> <CAJuCfpFmO310qoFJr2EKHRavLx87k6tVkHO3-JCE0s4q5g+TCw@mail.gmail.com>
 <20230111195250.cj27sg4yoslbdjdp@offworld>
In-Reply-To: <20230111195250.cj27sg4yoslbdjdp@offworld>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 11 Jan 2023 13:23:35 -0800
Message-ID: <CAJuCfpEnJVcNXLrsu93b-Z5DkhgWfqgPxB1BNDoA1ohVV8hy5Q@mail.gmail.com>
Subject: Re: [PATCH 13/41] mm: introduce vma->vm_flags modifier functions
To:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
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

On Wed, Jan 11, 2023 at 12:19 PM Davidlohr Bueso <dave@stgolabs.net> wrote:
>
> On Wed, 11 Jan 2023, Suren Baghdasaryan wrote:
>
> >On Wed, Jan 11, 2023 at 8:13 AM Davidlohr Bueso <dave@stgolabs.net> wrote:
> >>
> >> On Mon, 09 Jan 2023, Suren Baghdasaryan wrote:
> >>
> >> >To keep vma locking correctness when vm_flags are modified, add modifier
> >> >functions to be used whenever flags are updated.
> >>
> >> How about moving this patch and the ones that follow out of this series,
> >> into a preliminary patchset? It would reduce the amount of noise in the
> >> per-vma lock changes, which would then only be adding the needed
> >> vma_write_lock()ing.
> >
> >How about moving those prerequisite patches to the beginning of the
> >patchset (before maple_tree RCU changes)? I feel like they do belong
> >in the patchset because as a standalone patchset it would be unclear
> >why I'm adding all these accessor functions and introducing this
> >churn. Would that be acceptable?
>
> imo the abstraction of vm_flags handling is worth being standalone and is
> easier to be picked up before a more complex locking scheme change. But
> either way, it's up to you.

I see your point. Ok, if you think it makes sense as a stand-alone
patch I can post it separately in the next version.
Thanks,
Suren.

>
> Thanks,
> Davidlohr
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
