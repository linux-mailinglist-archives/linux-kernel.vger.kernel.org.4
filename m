Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C391367C26E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 02:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235810AbjAZBez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 20:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjAZBex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 20:34:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D492128D3D
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 17:34:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70B75616EA
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 01:34:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 496BCC433D2;
        Thu, 26 Jan 2023 01:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1674696891;
        bh=LpGTjcYf1DlUk7PNdNctpyCzducpqUJJbAKNiV2Q0RE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Tr9UkL55WPFPewbf2dotzPIKAx3TUEKfjFLxWUGCD+S5BxsFHlxSuYjj7eTneEzDy
         hjItC983VD+8pWeiiEPpB/3tf8qK72AtPNlJOEAoyJ4PFNQKgIFIHrCqjg9SCXe9/M
         V9Pk+Y+an8xv+9CG3ZO/wLQU0kLqEOBYfboAzw4o=
Date:   Wed, 25 Jan 2023 17:34:49 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com, paulmck@kernel.org,
        mingo@redhat.com, will@kernel.org, luto@kernel.org,
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
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v3 1/7] kernel/fork: convert vma assignment to a memcpy
Message-Id: <20230125173449.5472cffc989dfab4b83c491d@linux-foundation.org>
In-Reply-To: <CAJuCfpG5HyMP3RM1jTJxCnN4WUz4APAcxbkOT48ZtJDXcb3z3w@mail.gmail.com>
References: <20230125233554.153109-1-surenb@google.com>
        <20230125233554.153109-2-surenb@google.com>
        <20230125162159.a66e5ef05fecb405e85ffec9@linux-foundation.org>
        <CAJuCfpG5HyMP3RM1jTJxCnN4WUz4APAcxbkOT48ZtJDXcb3z3w@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jan 2023 16:50:01 -0800 Suren Baghdasaryan <surenb@google.com> wrote:

> On Wed, Jan 25, 2023 at 4:22 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Wed, 25 Jan 2023 15:35:48 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > > Convert vma assignment in vm_area_dup() to a memcpy() to prevent compiler
> > > errors when we add a const modifier to vma->vm_flags.
> > >
> > > ...
> > >
> > > --- a/kernel/fork.c
> > > +++ b/kernel/fork.c
> > > @@ -482,7 +482,7 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
> > >                * orig->shared.rb may be modified concurrently, but the clone
> > >                * will be reinitialized.
> > >                */
> > > -             *new = data_race(*orig);
> > > +             memcpy(new, orig, sizeof(*new));
> >
> > The data_race() removal is unchangelogged?
> 
> True. I'll add a note in the changelog about that. Ideally I would
> like to preserve it but I could not find a way to do that.
> 

Perhaps Paul can comment?

I wonder if KCSAN knows how to detect this race, given that it's now in
a memcpy.  I assume so.
