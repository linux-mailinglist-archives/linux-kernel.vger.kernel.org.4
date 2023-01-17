Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F82166E1C7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 16:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbjAQPMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 10:12:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbjAQPMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 10:12:45 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425CF10F6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 07:12:44 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EA6466891D;
        Tue, 17 Jan 2023 15:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673968362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5NTI5PSLTfCDe6gQVpoy+iwpEywbgMbai5Jcy4OtFUQ=;
        b=vKJK0oUhU26xmRrTy9EJrTe/vSwWuUEHbdOXYccjfeTnTiR5NwQ2XMngZr63M/b1WVe2AX
        juTB2Dy3SsizgKPcu0nnUM13rX04ilIO9rd02mk5W48x9S7RhqDjCVVmrzVsQbp6PCDA5l
        o7gyTFLzV7Fd2V2UwjRPwAw3AmeEGos=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BE7761390C;
        Tue, 17 Jan 2023 15:12:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HSTwLeq6xmOPQwAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 17 Jan 2023 15:12:42 +0000
Date:   Tue, 17 Jan 2023 16:12:42 +0100
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
Subject: Re: [PATCH 12/41] mm: add per-VMA lock and helper functions to
 control it
Message-ID: <Y8a66gshQkkhC1cT@dhcp22.suse.cz>
References: <20230109205336.3665937-1-surenb@google.com>
 <20230109205336.3665937-13-surenb@google.com>
 <Y8a4+bV1dYNAiUkD@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8a4+bV1dYNAiUkD@dhcp22.suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 17-01-23 16:04:26, Michal Hocko wrote:
> On Mon 09-01-23 12:53:07, Suren Baghdasaryan wrote:
> > Introduce a per-VMA rw_semaphore to be used during page fault handling
> > instead of mmap_lock. Because there are cases when multiple VMAs need
> > to be exclusively locked during VMA tree modifications, instead of the
> > usual lock/unlock patter we mark a VMA as locked by taking per-VMA lock
> > exclusively and setting vma->lock_seq to the current mm->lock_seq. When
> > mmap_write_lock holder is done with all modifications and drops mmap_lock,
> > it will increment mm->lock_seq, effectively unlocking all VMAs marked as
> > locked.
> 
> I have to say I was struggling a bit with the above and only understood
> what you mean by reading the patch several times. I would phrase it like
> this (feel free to use if you consider this to be an improvement).
> 
> Introduce a per-VMA rw_semaphore. The lock implementation relies on a
> per-vma and per-mm sequence counters to note exclusive locking:
>         - read lock - (implemented by vma_read_trylock) requires the the
>           vma (vm_lock_seq) and mm (mm_lock_seq) sequence counters to
>           differ. If they match then there must be a vma exclusive lock
>           held somewhere.
>         - read unlock - (implemented by vma_read_unlock) is a trivial
>           vma->lock unlock.
>         - write lock - (vma_write_lock) requires the mmap_lock to be
>           held exclusively and the current mm counter is noted to the vma
>           side. This will allow multiple vmas to be locked under a single
>           mmap_lock write lock (e.g. during vma merging). The vma counter
>           is modified under exclusive vma lock.

Didn't realize one more thing.
	    Unlike standard write lock this implementation allows to be
	    called multiple times under a single mmap_lock. In a sense
	    it is more of mark_vma_potentially_modified than a lock.

>         - write unlock - (vma_write_unlock_mm) is a batch release of all
>           vma locks held. It doesn't pair with a specific
>           vma_write_lock! It is done before exclusive mmap_lock is
>           released by incrementing mm sequence counter (mm_lock_seq).
> 	- write downgrade - if the mmap_lock is downgraded to the read
> 	  lock all vma write locks are released as well (effectivelly
> 	  same as write unlock).
-- 
Michal Hocko
SUSE Labs
