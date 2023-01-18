Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E571671907
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 11:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjARKgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 05:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjARKfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 05:35:00 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300D28385F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 01:40:13 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D418521066;
        Wed, 18 Jan 2023 09:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674034811; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qkSsxdGDhi7OFnoEmmEI+/6UTMsWfEo5f5xKht27nUU=;
        b=XXI0e3SJYUfmbTv7Egu/VOj5qe2veVpfQOCo54bZ/6FeH0dQKnz5D55LikQtuGQQuUNqfI
        Gn7IKTKaqjbGrtd1XZzr4g/KpxDTk79Mv+uc0zAiZxKfI8Y788ts0MzsC3fxrwN4O4u8pN
        Wa2w/A2JXRQ13PjgVrmAhrdegohLoFI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A9B3F139D2;
        Wed, 18 Jan 2023 09:40:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GwnzKHu+x2MPPgAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 18 Jan 2023 09:40:11 +0000
Date:   Wed, 18 Jan 2023 10:40:09 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Jann Horn <jannh@google.com>
Cc:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        michel@lespinasse.org, jglisse@google.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        paulmck@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        shakeelb@google.com, tatashin@google.com, edumazet@google.com,
        gthelen@google.com, gurua@google.com, arjunroy@google.com,
        soheil@google.com, hughlynch@google.com, leewalsh@google.com,
        posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 18/41] mm/khugepaged: write-lock VMA while collapsing a
 huge page
Message-ID: <Y8e+efbJ4rw9goF0@dhcp22.suse.cz>
References: <20230109205336.3665937-1-surenb@google.com>
 <20230109205336.3665937-19-surenb@google.com>
 <Y8a9+ywh65fmuKvv@dhcp22.suse.cz>
 <CAG48ez2Adwqs8Vvm3YUKwpx8qzV1wWtnUdWVo1UphjzADjMZQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez2Adwqs8Vvm3YUKwpx8qzV1wWtnUdWVo1UphjzADjMZQQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 17-01-23 21:28:06, Jann Horn wrote:
> On Tue, Jan 17, 2023 at 4:25 PM Michal Hocko <mhocko@suse.com> wrote:
> > On Mon 09-01-23 12:53:13, Suren Baghdasaryan wrote:
> > > Protect VMA from concurrent page fault handler while collapsing a huge
> > > page. Page fault handler needs a stable PMD to use PTL and relies on
> > > per-VMA lock to prevent concurrent PMD changes. pmdp_collapse_flush(),
> > > set_huge_pmd() and collapse_and_free_pmd() can modify a PMD, which will
> > > not be detected by a page fault handler without proper locking.
> >
> > I am struggling with this changelog. Maybe because my recollection of
> > the THP collapsing subtleties is weak. But aren't you just trying to say
> > that the current #PF handling and THP collapsing need to be mutually
> > exclusive currently so in order to keep that assumption you have mark
> > the vma write locked?
> >
> > Also it is not really clear to me how that handles other vmas which can
> > share the same thp?
> 
> It's not about the hugepage itself, it's about how the THP collapse
> operation frees page tables.
> 
> Before this series, page tables can be walked under any one of the
> mmap lock, the mapping lock, and the anon_vma lock; so when khugepaged
> unlinks and frees page tables, it must ensure that all of those either
> are locked or don't exist. This series adds a fourth lock under which
> page tables can be traversed, and so khugepaged must also lock out that one.
> 
> There is a codepath in khugepaged that iterates through all mappings
> of a file to zap page tables (retract_page_tables()), which locks each
> visited mm with mmap_write_trylock() and now also does
> vma_write_lock().

OK, I see. This would be a great addendum to the changelog.
 
> I think one aspect of this patch that might cause trouble later on, if
> support for non-anonymous VMAs is added, is that retract_page_tables()
> now does vma_write_lock() while holding the mapping lock; the page
> fault handling path would probably take the locks the other way
> around, leading to a deadlock? So the vma_write_lock() in
> retract_page_tables() might have to become a trylock later on.

This, right?
#PF			retract_page_tables
vma_read_lock
			i_mmap_lock_write
i_mmap_lock_read
			vma_write_lock


I might be missing something but I have only found huge_pmd_share to be
called from the #PF path. That one should be safe as it cannot be a
target for THP. Not that it would matter much because such a dependency
chain would be really subtle.
-- 
Michal Hocko
SUSE Labs
