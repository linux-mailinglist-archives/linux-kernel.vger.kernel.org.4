Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9074B6E77D8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 12:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbjDSK5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 06:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbjDSK5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 06:57:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D1A13C01
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 03:56:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 773BA21999;
        Wed, 19 Apr 2023 10:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681901765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6B/lPJ1FBZk3kfElh3DpXSFKFglBHclgptoEbB06na0=;
        b=sUouYFszcFkz2N+1Y9AQWVxB/q0vo5nu5KlLAKrBsqHYjup5mbNrtllgpcPKGZD7XHrj8D
        W5W8qB0pWXASuKnuaFqcFjWw12dBwYqvYGkxdbwlaBlNjANlWC+Xf1DCjS5IsnJozqVw/X
        faBHxf4gUKKZrtT3WUIFMqs0V2ZT/uE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681901765;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6B/lPJ1FBZk3kfElh3DpXSFKFglBHclgptoEbB06na0=;
        b=ELBnT8OHYgr2gAdFMKJbswBA6YxJjfruq1jYUvdpLZwyhktmpAp4XdQs+pRNDYPtdeJsgC
        unMBDt7iT7esjrBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5162A1390E;
        Wed, 19 Apr 2023 10:56:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id V7GiEsXIP2QgPQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 19 Apr 2023 10:56:05 +0000
Message-ID: <7a52f404-175b-5f64-10ec-4b757b1cc3ed@suse.cz>
Date:   Wed, 19 Apr 2023 12:56:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH 00/26] mm: reliable huge page allocator
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-mm@kvack.org, Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Mel Gorman <mgorman@techsingularity.net>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
References: <20230418191313.268131-1-hannes@cmpxchg.org>
 <20230418235402.lq7mxrrre2kl6vsf@box.shutemov.name>
 <20230419020814.GA272256@cmpxchg.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230419020814.GA272256@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/23 04:08, Johannes Weiner wrote:
> Hi Kirill, thanks for taking a look so quickly.
> 
> On Wed, Apr 19, 2023 at 02:54:02AM +0300, Kirill A. Shutemov wrote:
>> On Tue, Apr 18, 2023 at 03:12:47PM -0400, Johannes Weiner wrote:
>> > This series proposes to make THP allocations reliable by enforcing
>> > pageblock hygiene, and aligning the allocator, reclaim and compaction
>> > on the pageblock as the base unit for managing free memory. All orders
>> > up to and including the pageblock are made first-class requests that
>> > (outside of OOM situations) are expected to succeed without
>> > exceptional investment by the allocating thread.
>> > 
>> > A neutral pageblock type is introduced, MIGRATE_FREE. The first
>> > allocation to be placed into such a block claims it exclusively for
>> > the allocation's migratetype. Fallbacks from a different type are no
>> > longer allowed, and the block is "kept open" for more allocations of
>> > the same type to ensure tight grouping. A pageblock becomes neutral
>> > again only once all its pages have been freed.
>> 
>> Sounds like this will cause earlier OOM, no?
>> 
>> I guess with 2M pageblock on 64G server it shouldn't matter much. But how
>> about smaller machines?
> 
> Yes, it's a tradeoff.
> 
> It's not really possible to reduce external fragmentation and increase
> contiguity, without also increasing the risk of internal fragmentation
> to some extent. The tradeoff is slighly less but overall faster memory.
> 
> A 2M block size *seems* reasonable for most current setups. It's
> actually still somewhat on the lower side, if you consider that we had
> 4k blocks when memory was a few megabytes. (4k pages for 4M RAM is the
> same ratio as 2M pages for 2G RAM. My phone has 8G and my desktop 32G.
> 64G is unusually small for a datacenter server.)
> 
> I wouldn't be opposed to sticking this behind a separate config option
> if there are setups that WOULD want to keep the current best-effort
> compaction without the block hygiene. But obviously, from a
> maintenance POV life would be much easier if we didn't have to.

As much as tunables are frowned upon in general, this could make sense to me
 even as a runtime tunable (maybe with defaults based on how large the
system is), because a datacenter server and a phone is after all not the
same thing. But of course it would be preferrable to find out it works
reasonably well even for the smaller systems. For example we already do
completely disable mobility grouping if there's too little RAM for it to
make sense, which is somewhat similar (but not completely identical) decision.

> FWIF, I have been doing tests in an environment constrained to 2G and
> haven't had any issues with premature OOMs. But I'm happy to test
> other situations and workloads that might be of interest to people.
> 
>> > Reclaim and compaction are changed from partial block reclaim to
>> > producing whole neutral page blocks.
>> 
>> How does it affect allocation latencies? I see direct compact stall grew
>> substantially. Hm?
> 
> Good question.
> 
> There are 260 more compact stalls but also 1,734 more successful THP
> allocations. And 1,433 fewer allocation stalls. There seems to be much
> less direct work performed per successful allocation.

Yeah if there's a workload that uses THP madvise to indicate it prefers the
compaction stalls to base page fallbacks, and compaction is more sucessful,
it won't defer further attempts so as a result there will be more stalls.
What we should watch out for are rather latencies of allocations that don't
prefer the stalls, but might now be forced to clean up new MIGRATE_FREE
pageblocks for their order-0 allocation that would previously just fallback,
etc.

> But of course, that's not the whole story. Let me trace the actual
> latencies.
> 
> Thanks for your thoughts!
> Johannes

