Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A7C635B5D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 12:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236244AbiKWLPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 06:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236819AbiKWLP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 06:15:27 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BD191524
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 03:12:58 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-3938dc90ab0so152105457b3.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 03:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xEj58q2eO7vFOnlWALybZTH24NiFJBBV4+qTgBe8NxU=;
        b=lBIQlCQEscjzHYG7eO7dPCsHShtn+vCJGRWApSbPmPYJWi9RKXpilGJyuJ4LSzExsK
         9uqeNNv4RuwdP5N0MZSQJMGPLgyDLVcEmGL4IKFLl9HSjATb46qP5ZGjnVcvy0RWw7mQ
         QfG6PQCObEKZeXisM7ap07RInqNKsH8gRzfb9VdZLtKA0GftPNwj9r32zu0tp1qREx/2
         38/sOn8yv6F6JonoagzvgQ+aZyCw+sCQFrtuBZrJ1lMBcd6SzL8kdOhGalSAalioRfv/
         MBwekUs3DepVEV2BirP75hj53VVtmcrASsAoT0sk9AXN+e4hFhWflPP09zGoTyyW4F7j
         MH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xEj58q2eO7vFOnlWALybZTH24NiFJBBV4+qTgBe8NxU=;
        b=Kcbdw0pPFuEKtG/L88WGubY/nGoV29MUCE5Ms0g4zC1VAd0G6ylvlrw3z6r7zNjcMO
         2KmCLO3ZC7UcUihsU6pww5tn3FNFKgUKVevQ0whLNnr6FXnT8iHiEc6FaVjH4Tfog8f9
         FhBkXnOM0EibTwyRgiSPnfwR9zV0PPYjcsUvBdDHiBqFmpQdzaNNhgH/CaRXDAVp5eVu
         SbiPakqLFbY3rrCnpUwJ9z9uEjAk3CMn1IhDp9LjWc8omLrvBf+R5znatiCa9c0wyzQC
         Uszr0qR+YGuGYNAGgSRak3IaZjC4C7tL3KK0piQEV/5o0EF9N95h/Ml1uhtY3a0MMtE3
         1eig==
X-Gm-Message-State: ANoB5pnm2mXdwRWqNwLnX05ksb6YEphc7RHJ+L7pGt9iFPPuHUruCAt4
        9buAZdJoN/mibYPsunUu8OXCEmzB3EXnWfmHlf/Hbw==
X-Google-Smtp-Source: AA0mqf7Edn5fNIsQSrqZGE/T9IW7JfGoWJjQI2lCBD26CgDAaWHbIZl+Jwr68LmRKHDBFw8yHBMktrtOKgL44PZWvgE=
X-Received: by 2002:a05:690c:884:b0:37b:4a21:f86a with SMTP id
 cd4-20020a05690c088400b0037b4a21f86amr12102039ywb.465.1669201977261; Wed, 23
 Nov 2022 03:12:57 -0800 (PST)
MIME-Version: 1.0
References: <000000000000e7513905ebf4346f@google.com> <20221027030304.3017-1-hdanton@sina.com>
In-Reply-To: <20221027030304.3017-1-hdanton@sina.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 23 Nov 2022 12:12:20 +0100
Message-ID: <CANpmjNM-FNsMn4FR2murHHKt6jsVUDCO=ETmNQe-f+jrQ+4nHg@mail.gmail.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in task_work_run (2)
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+9228d6098455bb209ec8@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Peter Zijlstra <peterz@infradead.org>
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

On Thu, 27 Oct 2022 at 05:03, Hillf Danton <hdanton@sina.com> wrote:
>
> On 26 Oct 2022 11:29:35 -0700
> > syzbot has found a reproducer for the following issue on:
> >
> > HEAD commit:    88619e77b33d net: stmmac: rk3588: Allow multiple gmac cont..
> > git tree:       bpf
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1646d6f2880000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=a66c6c673fb555e8
> > dashboard link: https://syzkaller.appspot.com/bug?extid=9228d6098455bb209ec8
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12bc425e880000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1126516e880000
>
> Grab another hold on event upon adding task work in bid to fix uaf.
>
> #syz test https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git  88619e77b33d
>
> --- x/kernel/events/core.c
> +++ c/kernel/events/core.c
> @@ -2291,6 +2291,7 @@ event_sched_out(struct perf_event *event
>                     !event->pending_work) {
>                         event->pending_work = 1;
>                         dec = false;
> +                       atomic_long_inc(&event->refcount);
>                         task_work_add(current, &event->pending_task, TWA_RESUME);
>                 }
>                 if (dec)
> @@ -6561,6 +6562,8 @@ static void perf_pending_task(struct cal
>         struct perf_event *event = container_of(head, struct perf_event, pending_task);
>         int rctx;
>
> +       if (event->state == PERF_EVENT_STATE_DEAD)
> +               goto out;
>         /*
>          * If we 'fail' here, that's OK, it means recursion is already disabled
>          * and we won't recurse 'further'.
> @@ -6577,6 +6580,8 @@ static void perf_pending_task(struct cal
>         if (rctx >= 0)
>                 perf_swevent_put_recursion_context(rctx);
>         preempt_enable_notrace();
> +out:
> +       put_event(event);
>  }
>
>  #ifdef CONFIG_GUEST_PERF_EVENTS

I'm not convinced this is what we want - while we could prolong the
lifetime of an event, but if we're concurrently killing the event
somewhere, we might as well cancel the task work (and potentially just
skip a pending SIGTRAP). Your change most likely results in similar
behaviour due to the DEAD check, although it prolongs the event's
lifetime unnecessarily.
