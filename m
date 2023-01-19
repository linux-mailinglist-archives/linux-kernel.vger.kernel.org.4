Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6365667430D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 20:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjASTry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 14:47:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjASTrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 14:47:51 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D1E63E36
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 11:47:48 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 203so3936751yby.10
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 11:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P2j6lHak2WNm7vGtRzqgYAFuvxH6JX58ZqrhL7ZQFfg=;
        b=tRwk9+zuhnApnMpCZGGlzVwa+yZTlhQpdZ6D/DvhQoFQpUTQCeM6lA4awAgkKlc6pA
         569vcWotwshb2MJ3asbawGKsmiAf/09j93YtvGPhv8aIXeEodHvuQSIQ5ljSUAkeCXzO
         IqeRDxz6EbgbHh8k87h+XcI+Gi5IBdHJFL4tHPiahQxfVXpu36hpl3PHH/mKcKNvwhOv
         UCU76RUWF05xBZwsRriVr7hQXTTtQJ2FG3IoMxW3Mwj2/MvvT/4EBXFgCKYYlhd3hGTR
         1qkSNLLzjXoHMCy86p9goHtqYEOQIkIXGOFAkld/l51jc9hZeYZmW078//u/yo9FNWkJ
         t4Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P2j6lHak2WNm7vGtRzqgYAFuvxH6JX58ZqrhL7ZQFfg=;
        b=fNh/32eET9gfVLpz7hC2+fBdcZMbFVP67eq/gNl9IxiAQjVCZi1dXbDPIoPgLlbsqf
         VcAh/cgSB1XOUp26Mgeula/S9BftpkddiolOmQzUvf4sIis6sirhRe91FL5LlgzqnqiP
         1GAOJIkmDW8AUR13edk47QWTRZNxTM1Njb3M0pgC0sJaK91xoC2JZab0OEivIV4LLz1S
         UsQQjT9mZV2URx+B0oOofPfiA05QT9bqQmnvTjevM6729nzsRWTMYs5QYnYT9CDBqlgM
         CwVK4Z9Q8BwRmzrRljy3Mf7l2rqaGMv8tjy5BHvH1emO0r2aGvT3yvRCUjmyNQ9iG7C2
         Mx6g==
X-Gm-Message-State: AFqh2kqGBpKZEs3ojqJBrSDWRJzgMRnIi5nEj9F+D4ckJpavUsnBkUxo
        3FJQannGfbtckuiAbboApmxzIz4i2wPr/aB88nQJAA==
X-Google-Smtp-Source: AMrXdXtVjG1suljuq7kTbxad3urbLbwnBS0I2yo5AivnT5FA4XZ5/ePVWQvbEfh73NgWws2sOxQOIRQCI7QYYkEgZCg=
X-Received: by 2002:a25:ceca:0:b0:7e4:115c:9cf6 with SMTP id
 x193-20020a25ceca000000b007e4115c9cf6mr1417330ybe.316.1674157667650; Thu, 19
 Jan 2023 11:47:47 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-40-surenb@google.com>
 <Y8k+syJu7elWAjRj@dhcp22.suse.cz> <CAJuCfpEAL9y70KJ_a=Z_kJpJnNC-ge1aN2ofTupeQ5-FaKh84g@mail.gmail.com>
 <20230119192002.GX2948950@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20230119192002.GX2948950@paulmck-ThinkPad-P17-Gen-1>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 19 Jan 2023 11:47:36 -0800
Message-ID: <CAJuCfpEoGCs6JgjiWL1ACS8S8TmwM1x5EF7x8D=M9zqnkyqxBA@mail.gmail.com>
Subject: Re: [PATCH 39/41] kernel/fork: throttle call_rcu() calls in vm_area_free
To:     paulmck@kernel.org
Cc:     Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org,
        michel@lespinasse.org, jglisse@google.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
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

On Thu, Jan 19, 2023 at 11:20 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Thu, Jan 19, 2023 at 10:52:03AM -0800, Suren Baghdasaryan wrote:
> > On Thu, Jan 19, 2023 at 4:59 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Mon 09-01-23 12:53:34, Suren Baghdasaryan wrote:
> > > > call_rcu() can take a long time when callback offloading is enabled.
> > > > Its use in the vm_area_free can cause regressions in the exit path when
> > > > multiple VMAs are being freed. To minimize that impact, place VMAs into
> > > > a list and free them in groups using one call_rcu() call per group.
> > >
> > > After some more clarification I can understand how call_rcu might not be
> > > super happy about thousands of callbacks to be invoked and I do agree
> > > that this is not really optimal.
> > >
> > > On the other hand I do not like this solution much either.
> > > VM_AREA_FREE_LIST_MAX is arbitrary and it won't really help all that
> > > much with processes with a huge number of vmas either. It would still be
> > > in housands of callbacks to be scheduled without a good reason.
> > >
> > > Instead, are there any other cases than remove_vma that need this
> > > batching? We could easily just link all the vmas into linked list and
> > > use a single call_rcu instead, no? This would both simplify the
> > > implementation, remove the scaling issue as well and we do not have to
> > > argue whether VM_AREA_FREE_LIST_MAX should be epsilon or epsilon + 1.
> >
> > Yes, I agree the solution is not stellar. I wanted something simple
> > but this is probably too simple. OTOH keeping all dead vm_area_structs
> > on the list without hooking up a shrinker (additional complexity) does
> > not sound too appealing either. WDYT about time domain throttling to
> > limit draining the list to say once per second like this:
> >
> > void vm_area_free(struct vm_area_struct *vma)
> > {
> >        struct mm_struct *mm = vma->vm_mm;
> >        bool drain;
> >
> >        free_anon_vma_name(vma);
> >
> >        spin_lock(&mm->vma_free_list.lock);
> >        list_add(&vma->vm_free_list, &mm->vma_free_list.head);
> >        mm->vma_free_list.size++;
> > -       drain = mm->vma_free_list.size > VM_AREA_FREE_LIST_MAX;
> > +       drain = jiffies > mm->last_drain_tm + HZ;
> >
> >        spin_unlock(&mm->vma_free_list.lock);
> >
> > -       if (drain)
> > +       if (drain) {
> >               drain_free_vmas(mm);
> > +             mm->last_drain_tm = jiffies;
> > +       }
> > }
> >
> > Ultimately we want to prevent very frequent call_rcu() calls, so
> > throttling in the time domain seems appropriate. That's the simplest
> > way I can think of to address your concern about a quick spike in VMA
> > freeing. It does not place any restriction on the list size and we
> > might have excessive dead vm_area_structs if after a large spike there
> > are no vm_area_free() calls but I don't know if that's a real problem,
> > so not sure we should be addressing it at this time. WDYT?
>
> Just to double-check, we really did try the very frequent call_rcu()
> invocations and we really did see a problem, correct?

Correct. More specifically with CONFIG_RCU_NOCB_CPU=y we saw
regressions when a process exits and all its VMAs get destroyed,
causing a flood of call_rcu()'s.

>
> Although it is not perfect, call_rcu() is designed to take a fair amount
> of abuse.  So if we didn't see a real problem, the frequent call_rcu()
> invocations might be a bit simpler.
>
>                                                         Thanx, Paul
