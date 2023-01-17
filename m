Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675ED670B1C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 23:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjAQWDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 17:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjAQWB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 17:01:29 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E28436086
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 12:31:55 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3052820134;
        Tue, 17 Jan 2023 20:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673987514; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=joReDe9zN9w1YbYxniPhXt3I9ej9se2S9PgCXccJZHs=;
        b=ZnVDnkua6Rig0sjcQadxKq0ryHwmSAL+lKO2BmXT1OTYGtdMUGkXDMDN6J+YG9zfjL89u3
        rCuLgOCpx9WwTGjuibJuxPjmq8QFr2ZqlYetoHt7qEV7RfZRKGoPz3LIShyUKReHOUX0uo
        4Fubk0RUBcIux8DmR6q/Jzb84/zr7Ak=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 061B313357;
        Tue, 17 Jan 2023 20:31:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1ygGAboFx2OEYQAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 17 Jan 2023 20:31:54 +0000
Date:   Tue, 17 Jan 2023 21:31:51 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
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
Subject: Re: [PATCH 41/41] mm: replace rw_semaphore with atomic_t in vma_lock
Message-ID: <Y8cFt7GVLTOT5Cdl@dhcp22.suse.cz>
References: <20230109205336.3665937-1-surenb@google.com>
 <20230109205336.3665937-42-surenb@google.com>
 <Y8UxnqPCTLbbD+2F@localhost>
 <Y8YgomKF189vmgLz@casper.infradead.org>
 <CAJuCfpECJhUu3fvWbBzmAkEA3+1LTkKqJOVadQB_-_mEHME=xg@mail.gmail.com>
 <Y8Y2JErbNQOhL8ee@casper.infradead.org>
 <CAJuCfpEx6FJpm0Js=cvcHw6mY3izPfoskxseSMyxFAxLX97X_w@mail.gmail.com>
 <Y8bnpqw134CHenz/@casper.infradead.org>
 <CAJuCfpGKRLshk1oWf1Nz4jhDrMGnkWs7qtWYaj=j_iQwPq0THQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpGKRLshk1oWf1Nz4jhDrMGnkWs7qtWYaj=j_iQwPq0THQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 17-01-23 10:28:40, Suren Baghdasaryan wrote:
[...]
> > Then yes, that's a starvable lock.  Preventing starvation on the mmap
> > sem was the original motivation for making rwsems non-starvable, so
> > changing that behaviour now seems like a bad idea.  For efficiency, I'd
> > suggest that a waiting writer set the top bit of the counter.  That way,
> > all new readers will back off without needing to check a second variable
> > and old readers will know that they *may* need to do the wakeup when
> > atomic_sub_return_release() is negative.
> >
> > (rwsem.c has a more complex bitfield, but I don't think we need to go
> > that far; the important point is that the waiting writer indicates its
> > presence in the count field so that readers can modify their behaviour)
> 
> Got it. Ok, I think we can figure something out to check if there are
> waiting write-lockers and prevent new readers from taking the lock.

Reinventing locking primitives is a ticket to weird bugs. I would stick
with the rwsem and deal with performance fallouts after it is clear that
the core idea is generally acceptable and based on actual real life
numbers. This whole thing is quite big enough that we do not have to go
through "is this new synchronization primitive correct and behaving
reasonably" exercise.

-- 
Michal Hocko
SUSE Labs
