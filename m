Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69653675C02
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 18:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjATRu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 12:50:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjATRuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:50:25 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CB928D0F
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:50:13 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-4c24993965eso82770507b3.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aVyoBoXVncV7XEl3t2voVw28ML7SaYV5Dgtuf6b40FA=;
        b=ANRlWfvxGTpJVPhZIEDmerA7RYCecNGYC3i5Nr9zZ8q28FPyljMpMTIhlgQZfHFTVP
         Ee92UzH2d4DuxfxktT1DA3smDF0ji/BkS3gfkTDonTSF7HQup1SefrYmZjTyJW0Bg9tK
         BJRGr+0GxhGYoL1k3OnQbi/pfLLvgxCoDu8z4/kaWzhjUtNPMmPTcuBjMAYHCLMuH4mY
         fgKJAXrZ5MsNM0RpCYDGi6IbNIrrwup5btcvBTsiaC5aEA9EihfFW59n9S+gxvYQms2F
         NRJL4C6RLSnaLwLC/V6yhn1nTzQyRvm8lUqVp3AclCOntYxy8GEUOjQZqRDLkC2dw8ZE
         UNeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aVyoBoXVncV7XEl3t2voVw28ML7SaYV5Dgtuf6b40FA=;
        b=5tbah2DTA0rPmsilJLiLQ+3bXY5/opD/ArtQstqrHTWDN2XwVP0CCLfDBgFo38oxDO
         dmUnzBkXgb67eAV8J46VUvu2Ou9KFc3N9uMu32fvamOpPQxsRrLYCdgl2eBpPsCqLEFr
         qO7X3Ref0K7wOAuG+ALIKIe0rTlaweihZvT3XXgbFO470pbtJJ9TTt6yM+5zKAXX5/JI
         3i34a8gyrCcQtkGQV5QIHbhpEkzy6sk19b3pEDp7fn8bq/JZ07holvCEXZuHrzSPIQsc
         vgt66GtvCtsxrPYVaj59cQoAP6629ttuBluxRPWDs7wrQjamIq5xF4iVNIVnav/z2meR
         CMkA==
X-Gm-Message-State: AFqh2koeJKR4lH3KmQY876JDISmJt96nP5v4vMe+ZG/6rx+mVXt/fr9Z
        hUGr2foJUdGBKbBtQyuOJZbdESDvEIIirWCP5kA0sQ==
X-Google-Smtp-Source: AMrXdXvMiPI/AGYcURx7BpXFo8CgDd1daSskgeMlewm7uoKhNJ8L/DxZm49IfvACqDRKjvLcYNle2ICQOI0LbOIpu2s=
X-Received: by 2002:a81:6d8d:0:b0:490:89c3:21b0 with SMTP id
 i135-20020a816d8d000000b0049089c321b0mr2028934ywc.132.1674237012869; Fri, 20
 Jan 2023 09:50:12 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-40-surenb@google.com>
 <Y8k+syJu7elWAjRj@dhcp22.suse.cz> <CAJuCfpEAL9y70KJ_a=Z_kJpJnNC-ge1aN2ofTupeQ5-FaKh84g@mail.gmail.com>
 <Y8pWW9Am3mDP53qJ@dhcp22.suse.cz> <CAJuCfpHeuckG8YuNTgdDcNHNzJ3sQExD_f1hwXG_xmS7Z-925g@mail.gmail.com>
 <CAJuCfpF20nuP6Meib9h7NVrJv+wybYS==vZFQXxUW6n-ir9bvQ@mail.gmail.com>
 <Y8rGJq8LvX2C+Cr7@casper.infradead.org> <20230120170815.yuylbs27r6xcjpq5@revolver>
 <CAJuCfpH4o-iCmzdUcYD9bKieJ6-k-MZYLuHFhH+bN9yE07sibw@mail.gmail.com> <Y8rQNj5dVyuxRBOf@casper.infradead.org>
In-Reply-To: <Y8rQNj5dVyuxRBOf@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 20 Jan 2023 09:50:01 -0800
Message-ID: <CAJuCfpG3YaExGkzsSSm0tXjMiSoM6rVf0JQgfrWu4UY5gsw=-w@mail.gmail.com>
Subject: Re: [PATCH 39/41] kernel/fork: throttle call_rcu() calls in vm_area_free
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org,
        michel@lespinasse.org, jglisse@google.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        peterz@infradead.org, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, luto@kernel.org,
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

On Fri, Jan 20, 2023 at 9:32 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Jan 20, 2023 at 09:17:46AM -0800, Suren Baghdasaryan wrote:
> > On Fri, Jan 20, 2023 at 9:08 AM Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
> > >
> > > * Matthew Wilcox <willy@infradead.org> [230120 11:50]:
> > > > On Fri, Jan 20, 2023 at 08:45:21AM -0800, Suren Baghdasaryan wrote:
> > > > > On Fri, Jan 20, 2023 at 8:20 AM Suren Baghdasaryan <surenb@google.com> wrote:
> > > > > >
> > > > > > On Fri, Jan 20, 2023 at 12:52 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > > > >
> > > > > > > On Thu 19-01-23 10:52:03, Suren Baghdasaryan wrote:
> > > > > > > > On Thu, Jan 19, 2023 at 4:59 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > > > > > >
> > > > > > > > > On Mon 09-01-23 12:53:34, Suren Baghdasaryan wrote:
> > > > > > > > > > call_rcu() can take a long time when callback offloading is enabled.
> > > > > > > > > > Its use in the vm_area_free can cause regressions in the exit path when
> > > > > > > > > > multiple VMAs are being freed. To minimize that impact, place VMAs into
> > > > > > > > > > a list and free them in groups using one call_rcu() call per group.
> > > > > > > > >
> > > > > > > > > After some more clarification I can understand how call_rcu might not be
> > > > > > > > > super happy about thousands of callbacks to be invoked and I do agree
> > > > > > > > > that this is not really optimal.
> > > > > > > > >
> > > > > > > > > On the other hand I do not like this solution much either.
> > > > > > > > > VM_AREA_FREE_LIST_MAX is arbitrary and it won't really help all that
> > > > > > > > > much with processes with a huge number of vmas either. It would still be
> > > > > > > > > in housands of callbacks to be scheduled without a good reason.
> > > > > > > > >
> > > > > > > > > Instead, are there any other cases than remove_vma that need this
> > > > > > > > > batching? We could easily just link all the vmas into linked list and
> > > > > > > > > use a single call_rcu instead, no? This would both simplify the
> > > > > > > > > implementation, remove the scaling issue as well and we do not have to
> > > > > > > > > argue whether VM_AREA_FREE_LIST_MAX should be epsilon or epsilon + 1.
> > > > > > > >
> > > > > > > > Yes, I agree the solution is not stellar. I wanted something simple
> > > > > > > > but this is probably too simple. OTOH keeping all dead vm_area_structs
> > > > > > > > on the list without hooking up a shrinker (additional complexity) does
> > > > > > > > not sound too appealing either.
> > > > > > >
> > > > > > > I suspect you have missed my idea. I do not really want to keep the list
> > > > > > > around or any shrinker. It is dead simple. Collect all vmas in
> > > > > > > remove_vma and then call_rcu the whole list at once after the whole list
> > > > > > > (be it from exit_mmap or remove_mt). See?
> > > > > >
> > > > > > Yes, I understood your idea but keeping dead objects until the process
> > > > > > exits even when the system is low on memory (no shrinkers attached)
> > > > > > seems too wasteful. If we do this I would advocate for attaching a
> > > > > > shrinker.
> > > > >
> > > > > Maybe even simpler, since we are hit with this VMA freeing flood
> > > > > during exit_mmap (when all VMAs are destroyed), we pass a hint to
> > > > > vm_area_free to batch the destruction and all other cases call
> > > > > call_rcu()? I don't think there will be other cases of VMA destruction
> > > > > floods.
> > > >
> > > > ... or have two different call_rcu functions; one for munmap() and
> > > > one for exit.  It'd be nice to use kmem_cache_free_bulk().
> > >
> > > Do we even need a call_rcu on exit?  At the point of freeing the VMAs we
> > > have set the MMF_OOM_SKIP bit and unmapped the vmas under the read lock.
> > > Once we have obtained the write lock again, I think it's safe to say we
> > > can just go ahead and free the VMAs directly.
> >
> > I think that would be still racy if the page fault handler found that
> > VMA under read-RCU protection but did not lock it yet (no locks are
> > held yet). If it's preempted, the VMA can be freed and destroyed from
> > under it without RCU grace period.
>
> The page fault handler (or whatever other reader -- ptrace, proc, etc)
> should have a refcount on the mm_struct, so we can't be in this path
> trying to free VMAs.  Right?

Hmm. That sounds right. I checked process_mrelease() as well, which
operated on mm with only mmgrab()+mmap_read_lock() but it only unmaps
VMAs without freeing them, so we are still good. Michal, do you agree
this is ok?

lock_vma_under_rcu() receives mm as a parameter, so I guess it's
implied that the caller should either mmget() it or operate on
current->mm, so no need to document this requirement?
