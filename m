Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E585667780B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 10:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjAWJ7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 04:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjAWJ7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 04:59:42 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D55583EA
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 01:59:20 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BBD49220BE;
        Mon, 23 Jan 2023 09:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674467955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RPUgUWLYFyzDTJWxeUhyD8C/Rk27j6KTINncM5ul7B8=;
        b=j6fAAr3MXQF3Ag61iljXv6JHlPeeziIdplAnwUZmokoMW/gVtX233B/+80pEJK01C5GlkJ
        EPzsRhAPlyG+3HBY8AjSiPzwO3AjfsTiqVjoPnDjgoPLncHoHzPgtbHjrCu+oUdXF8LEnw
        3tP7uTNe6KPkoGsvMwkZiOP+TEPQb3k=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7FFFC134F5;
        Mon, 23 Jan 2023 09:59:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 09ywHnNazmOiCwAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 23 Jan 2023 09:59:15 +0000
Date:   Mon, 23 Jan 2023 10:59:14 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, vbabka@suse.cz, hannes@cmpxchg.org,
        mgorman@techsingularity.net, dave@stgolabs.net,
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
Subject: Re: [PATCH 39/41] kernel/fork: throttle call_rcu() calls in
 vm_area_free
Message-ID: <Y85acuBFkGr03Qd7@dhcp22.suse.cz>
References: <20230109205336.3665937-1-surenb@google.com>
 <20230109205336.3665937-40-surenb@google.com>
 <Y8k+syJu7elWAjRj@dhcp22.suse.cz>
 <CAJuCfpEAL9y70KJ_a=Z_kJpJnNC-ge1aN2ofTupeQ5-FaKh84g@mail.gmail.com>
 <Y8pWW9Am3mDP53qJ@dhcp22.suse.cz>
 <CAJuCfpHeuckG8YuNTgdDcNHNzJ3sQExD_f1hwXG_xmS7Z-925g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpHeuckG8YuNTgdDcNHNzJ3sQExD_f1hwXG_xmS7Z-925g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 20-01-23 08:20:43, Suren Baghdasaryan wrote:
> On Fri, Jan 20, 2023 at 12:52 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Thu 19-01-23 10:52:03, Suren Baghdasaryan wrote:
> > > On Thu, Jan 19, 2023 at 4:59 AM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Mon 09-01-23 12:53:34, Suren Baghdasaryan wrote:
> > > > > call_rcu() can take a long time when callback offloading is enabled.
> > > > > Its use in the vm_area_free can cause regressions in the exit path when
> > > > > multiple VMAs are being freed. To minimize that impact, place VMAs into
> > > > > a list and free them in groups using one call_rcu() call per group.
> > > >
> > > > After some more clarification I can understand how call_rcu might not be
> > > > super happy about thousands of callbacks to be invoked and I do agree
> > > > that this is not really optimal.
> > > >
> > > > On the other hand I do not like this solution much either.
> > > > VM_AREA_FREE_LIST_MAX is arbitrary and it won't really help all that
> > > > much with processes with a huge number of vmas either. It would still be
> > > > in housands of callbacks to be scheduled without a good reason.
> > > >
> > > > Instead, are there any other cases than remove_vma that need this
> > > > batching? We could easily just link all the vmas into linked list and
> > > > use a single call_rcu instead, no? This would both simplify the
> > > > implementation, remove the scaling issue as well and we do not have to
> > > > argue whether VM_AREA_FREE_LIST_MAX should be epsilon or epsilon + 1.
> > >
> > > Yes, I agree the solution is not stellar. I wanted something simple
> > > but this is probably too simple. OTOH keeping all dead vm_area_structs
> > > on the list without hooking up a shrinker (additional complexity) does
> > > not sound too appealing either.
> >
> > I suspect you have missed my idea. I do not really want to keep the list
> > around or any shrinker. It is dead simple. Collect all vmas in
> > remove_vma and then call_rcu the whole list at once after the whole list
> > (be it from exit_mmap or remove_mt). See?
> 
> Yes, I understood your idea but keeping dead objects until the process
> exits even when the system is low on memory (no shrinkers attached)
> seems too wasteful. If we do this I would advocate for attaching a
> shrinker.

I am still not sure we are on the same page here. No, vmas shouldn't lay
around un ntil the process exit. I am really suggesting queuing only for
remove_vma paths. You can have a different rcu callback than the one
used for trivial single vma removal paths.

-- 
Michal Hocko
SUSE Labs
