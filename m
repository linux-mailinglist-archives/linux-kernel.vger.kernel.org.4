Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098C45B4D0A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 11:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiIKJfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 05:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIKJfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 05:35:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C2D24BED
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 02:35:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A7F7521E99;
        Sun, 11 Sep 2022 09:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662888938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Lc3vR3minJtB/44lBRTyQejWooVRYylPWrQ2JvEp1c=;
        b=MaJLVWPQsh71YKDB3HnJgYZcoRFq3u90TGLqyadSycRXOfbpdLNOhF7jYJ7wCymnlaOQfy
        tQ9Y98dwJx0BjGNKItq1K2MZZWqZ7VjFqT/UMwLPtJBlcJA4fTEPB3DeUWXQySouftTEmC
        Ky8YnNCvqPf8JLLUmYNl5CYA/YY/50M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662888938;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Lc3vR3minJtB/44lBRTyQejWooVRYylPWrQ2JvEp1c=;
        b=8akfSuHi78TNqxzhhYCqjW2GfEzFez7f2C0WbZ30IncNuZEB6firo2r44VOcgN+jYzwA67
        5vTZ6qN3UH8IbODA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 41DC6133E6;
        Sun, 11 Sep 2022 09:35:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Jd4fD+qrHWN3VwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Sun, 11 Sep 2022 09:35:38 +0000
Message-ID: <b5db3353-8aae-22d8-9598-eaa5eeb77cfc@suse.cz>
Date:   Sun, 11 Sep 2022 11:35:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [RFC PATCH RESEND 00/28] per-VMA locks proposal
Content-Language: en-US
To:     Suren Baghdasaryan <surenb@google.com>,
        Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michel Lespinasse <michel@lespinasse.org>,
        Jerome Glisse <jglisse@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Laurent Dufour <laurent.dufour@fr.ibm.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Song Liu <songliubraving@fb.com>, Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>, dhowells@redhat.com,
        Hugh Dickins <hughd@google.com>, bigeasy@linutronix.de,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Minchan Kim <minchan@google.com>,
        kernel-team <kernel-team@android.com>,
        linux-mm <linux-mm@kvack.org>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20220901173516.702122-1-surenb@google.com>
 <20220901205819.emxnnschszqv4ahy@moria.home.lan>
 <CAJuCfpGNcZovncozo+Uxfhjwqh3BtGXsws+4QeT6Zy1mcQRJbQ@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAJuCfpGNcZovncozo+Uxfhjwqh3BtGXsws+4QeT6Zy1mcQRJbQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/22 01:26, Suren Baghdasaryan wrote:
> On Thu, Sep 1, 2022 at 1:58 PM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
>>
>> On Thu, Sep 01, 2022 at 10:34:48AM -0700, Suren Baghdasaryan wrote:
>> > Resending to fix the issue with the In-Reply-To tag in the original
>> > submission at [4].
>> >
>> > This is a proof of concept for per-vma locks idea that was discussed
>> > during SPF [1] discussion at LSF/MM this year [2], which concluded with
>> > suggestion that “a reader/writer semaphore could be put into the VMA
>> > itself; that would have the effect of using the VMA as a sort of range
>> > lock. There would still be contention at the VMA level, but it would be an
>> > improvement.” This patchset implements this suggested approach.
>> >
>> > When handling page faults we lookup the VMA that contains the faulting
>> > page under RCU protection and try to acquire its lock. If that fails we
>> > fall back to using mmap_lock, similar to how SPF handled this situation.
>> >
>> > One notable way the implementation deviates from the proposal is the way
>> > VMAs are marked as locked. Because during some of mm updates multiple
>> > VMAs need to be locked until the end of the update (e.g. vma_merge,
>> > split_vma, etc). Tracking all the locked VMAs, avoiding recursive locks
>> > and other complications would make the code more complex. Therefore we
>> > provide a way to "mark" VMAs as locked and then unmark all locked VMAs
>> > all at once. This is done using two sequence numbers - one in the
>> > vm_area_struct and one in the mm_struct. VMA is considered locked when
>> > these sequence numbers are equal. To mark a VMA as locked we set the
>> > sequence number in vm_area_struct to be equal to the sequence number
>> > in mm_struct. To unlock all VMAs we increment mm_struct's seq number.
>> > This allows for an efficient way to track locked VMAs and to drop the
>> > locks on all VMAs at the end of the update.
>>
>> I like it - the sequence numbers are a stroke of genuius. For what it's doing
>> the patchset seems almost small.
> 
> Thanks for reviewing it!
> 
>>
>> Two complaints so far:
>>  - I don't like the vma_mark_locked() name. To me it says that the caller
>>    already took or is taking the lock and this function is just marking that
>>    we're holding the lock, but it's really taking a different type of lock. But
>>    this function can block, it really is taking a lock, so it should say that.
>>
>>    This is AFAIK a new concept, not sure I'm going to have anything good either,
>>    but perhaps vma_lock_multiple()?
> 
> I'm open to name suggestions but vma_lock_multiple() is a bit
> confusing to me. Will wait for more suggestions.

Well, it does act like a vma_write_lock(), no? So why not that name. The
checking function for it is even called vma_assert_write_locked().

We just don't provide a single vma_write_unlock(), but a
vma_mark_unlocked_all(), that could be instead named e.g.
vma_write_unlock_all().
But it's called on a mm, so maybe e.g. mm_vma_write_unlock_all()?


