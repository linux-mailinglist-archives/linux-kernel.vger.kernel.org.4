Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A6C68DEC3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 18:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbjBGRR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 12:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbjBGRRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 12:17:03 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C913E0BF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 09:16:24 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id h3so6427814wrp.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 09:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z7B14u7hbB/VXiWZvddsL6aIZYt39FVX4bLARrPtAv0=;
        b=Y9FmfEJaPUKP01BpBrAbyUYKx/RChLT6yUXZss4TzkZZpnxSibWVx6Ft9DTOKNZSlf
         bbzELRho2ZJluKmjB595UuxnvHVIBSwm694bjmmrYm+OuT1ALInGSP3Qp1NZvBrRXrgB
         lGn6Ds34sf3a038gEV1tz052BldGx7hPZAYSAvCkpHt5Yfw/AadKxqOqu19QdZ1sWaO6
         amTDGpYaHu9W423M6iD5H1vqa+EweqMvK7pUi5qqpAUQmnIUjj/fg3Qh4aoNZaEzpeRO
         JP0tMINwibFX5Il2vdPlZN2ptjO9vYxmwRp7I5p6XZn9gmRoXWpuWbMK/zHk6Xy5MtX/
         nh4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z7B14u7hbB/VXiWZvddsL6aIZYt39FVX4bLARrPtAv0=;
        b=FGLQ53B52SoU5HAju8TbU+QE2giWUi5ZxbTEJoxXtIE7kLS9y4VFXvHPsXxb2CLsbB
         LyoTGTRjL8+PDb+u3D5Yl6w5rld7/ECOyggOEvNfPf+0fFVLW9VMMJeHWV/oXfbF1tn0
         k/+G6uL6t5Zu9caQrY6wiA5qwHlZopodwMV9EJGm2u9nf9NnxntBjlVqgyghcA9WpDe+
         okXan8o2e1HfK+d5pAKpDKdTT/gADyNR+SqTCRzZTlzTfp7XwunQnpGibVrQekLPVTi3
         HvHRwBfS/zFyvxSaRlZmYyGZiXCdV+1giTwgz4bjBRgpxKSjGQWciGxuf9rH71vJ+5q4
         nevA==
X-Gm-Message-State: AO0yUKV/eUdkKLOxnEGuUnH1CJvsSXHyKjhv/kPaUfieaLdV0AO5AVWS
        RemtogQ0hXS7do8Yn5BOoEBH6w==
X-Google-Smtp-Source: AK7set/eY6l3j0tIm+E4Ulj8uu+N4HWCIJbO8QgFYfPq9KRYPC10pX+4fMH8NtYMAoGaEz1vRgHJQw==
X-Received: by 2002:adf:f44b:0:b0:2bf:e4b2:64a8 with SMTP id f11-20020adff44b000000b002bfe4b264a8mr3630125wrp.42.1675790177410;
        Tue, 07 Feb 2023 09:16:17 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:9c:201:57f3:e3b1:e247:9c58])
        by smtp.gmail.com with ESMTPSA id s16-20020adff810000000b002c3dc4131f5sm9414897wrp.18.2023.02.07.09.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 09:16:16 -0800 (PST)
Date:   Tue, 7 Feb 2023 18:16:09 +0100
From:   Marco Elver <elver@google.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, mingo@redhat.com, will@kernel.org,
        luto@kernel.org, songliubraving@fb.com, peterx@redhat.com,
        david@redhat.com, dhowells@redhat.com, hughd@google.com,
        bigeasy@linutronix.de, kent.overstreet@linux.dev,
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
Subject: Re: [PATCH v3 1/7] kernel/fork: convert vma assignment to a memcpy
Message-ID: <Y+KHWcpxd09prihv@elver.google.com>
References: <20230125233554.153109-1-surenb@google.com>
 <20230125233554.153109-2-surenb@google.com>
 <20230125162159.a66e5ef05fecb405e85ffec9@linux-foundation.org>
 <CAJuCfpG5HyMP3RM1jTJxCnN4WUz4APAcxbkOT48ZtJDXcb3z3w@mail.gmail.com>
 <20230125173449.5472cffc989dfab4b83c491d@linux-foundation.org>
 <20230126172726.GA682281@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126172726.GA682281@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/2.2.9 (2022-11-12)
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

On Thu, Jan 26, 2023 at 09:27AM -0800, Paul E. McKenney wrote:
> On Wed, Jan 25, 2023 at 05:34:49PM -0800, Andrew Morton wrote:
> > On Wed, 25 Jan 2023 16:50:01 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
> > 
> > > On Wed, Jan 25, 2023 at 4:22 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > > >
> > > > On Wed, 25 Jan 2023 15:35:48 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
> > > >
> > > > > Convert vma assignment in vm_area_dup() to a memcpy() to prevent compiler
> > > > > errors when we add a const modifier to vma->vm_flags.
> > > > >
> > > > > ...
> > > > >
> > > > > --- a/kernel/fork.c
> > > > > +++ b/kernel/fork.c
> > > > > @@ -482,7 +482,7 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
> > > > >                * orig->shared.rb may be modified concurrently, but the clone
> > > > >                * will be reinitialized.
> > > > >                */
> > > > > -             *new = data_race(*orig);
> > > > > +             memcpy(new, orig, sizeof(*new));
> > > >
> > > > The data_race() removal is unchangelogged?
> > > 
> > > True. I'll add a note in the changelog about that. Ideally I would
> > > like to preserve it but I could not find a way to do that.
> > 
> > Perhaps Paul can comment?
> > 
> > I wonder if KCSAN knows how to detect this race, given that it's now in
> > a memcpy.  I assume so.
> 
> I ran an experiment memcpy()ing between a static array and an onstack
> array, and KCSAN did not complain.  But maybe I was setting it up wrong.
> 
> This is what I did:
> 
> 	long myid = (long)arg; /* different value for each task */
> 	static unsigned long z1[10] = { 0 };
> 	unsigned long z2[10];
> 
> 	...
> 
> 	memcpy(z1, z2, ARRAY_SIZE(z1) * sizeof(z1[0]));
> 	for (zi = 0; zi < ARRAY_SIZE(z1); zi++)
> 		z2[zi] += myid;
> 	memcpy(z2, z1, ARRAY_SIZE(z1) * sizeof(z1[0]));
> 
> Adding Marco on CC for his thoughts.

( Sorry for not seeing it earlier - just saw this by chance. )

memcpy() data races will be detected as of (given a relatively recent
Clang compiler):

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7c201739beef

Also beware that the compiler is free to "optimize" things by either
inlining memcpy() (turning an explicit memcpy() into just a bunch of
loads/stores), or outline plain assignments into memcpy() calls. So the
only way to be sure what ends up there is to look at the disassembled
code.

The data_race() was introduced by:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cda099b37d716

It says:
 "vm_area_dup() blindly copies all fields of original VMA to the new one.
  This includes coping vm_area_struct::shared.rb which is normally
  protected by i_mmap_lock. But this is fine because the read value will
  be overwritten on the following __vma_link_file() under proper
  protection. Thus, mark it as an intentional data race and insert a few
  assertions for the fields that should not be modified concurrently."

And as far as I can tell this hasn't changed.

Thanks,
-- Marco
