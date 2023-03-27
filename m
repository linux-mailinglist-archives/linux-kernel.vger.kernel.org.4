Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27CA86CA988
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 17:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbjC0Psb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 11:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbjC0PsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 11:48:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5BA30E5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 08:48:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A8FA421EF9;
        Mon, 27 Mar 2023 15:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679932094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GRhKwRTX6Br7lKsyTC0a3fYnqFY/Qaz1J4XbdIrXyxc=;
        b=nIR/RjOjQ15MdxYK4KMGD7aUg93RsvPjDYDXvbGHGatfHYBkfDOXKEZePS0J2rF+c8w456
        ukAfN9Q3s7biHlku4fDuOBjAM0XiwUBdqm3615a6Vf4Cz43upivJZVUMHaSd5S+j+tVsMp
        OqpOjvfbQwQnknaWhx04AvGSBUQfGGw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679932094;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GRhKwRTX6Br7lKsyTC0a3fYnqFY/Qaz1J4XbdIrXyxc=;
        b=c361i71DRHrg8ilWM8B48sD3B1sR8CQZ1BIgaCd7tHfO63uSQDbzFQFzsfBmL2pq/D8eTZ
        m0vVBM6Rw/68IoDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9018D13329;
        Mon, 27 Mar 2023 15:48:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /rVbIr66IWSdQgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 27 Mar 2023 15:48:14 +0000
Message-ID: <babd6fcb-0062-0450-99b3-df5a74c2f683@suse.cz>
Date:   Mon, 27 Mar 2023 17:48:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: What size anonymous folios should we allocate?
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <Y/U8bQd15aUO97vS@casper.infradead.org>
 <CAHbLzkrkZmbVMkh-Y-bDxgy0T0ZRRd+T+o5y5-wKmjKmhN0NmA@mail.gmail.com>
 <Y/WRlX+MkmxelNbg@casper.infradead.org>
 <022e1c15-7988-9975-acbc-e661e989ca4a@suse.cz>
 <d347c5b0-0c0f-ae50-9613-2cf962d8676e@arm.com>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <d347c5b0-0c0f-ae50-9613-2cf962d8676e@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/27/23 17:30, Ryan Roberts wrote:
> On 27/03/2023 13:41, Vlastimil Babka wrote:
>> On 2/22/23 04:52, Matthew Wilcox wrote:
>>> On Tue, Feb 21, 2023 at 03:05:33PM -0800, Yang Shi wrote:
>>>
>>>>> C. We add a new wrinkle to the LRU handling code.  When our scan of the
>>>>>    active list examines a folio, we look to see how many of the PTEs
>>>>>    mapping the folio have been accessed.  If it is fewer than half, and
>>>>>    those half are all in either the first or last half of the folio, we
>>>>>    split it.  The active half stays on the active list and the inactive
>>>>>    half is moved to the inactive list.
>>>>
>>>> With contiguous PTE, every PTE still maintains its own access bit (but
>>>> it is implementation defined, some implementations may just set access
>>>> bit once for one PTE in the contiguous region per arm arm IIUC). But
>>>> anyway this is definitely feasible.
>>>
>>> If a CPU doesn't have separate access bits for PTEs, then we should just
>>> not use the contiguous bits.  Knowing which parts of the folio are
>>> unused is more important than using the larger TLB entries.
>> 
>> Hm but AFAIK the AMD aggregation is transparent, there are no bits. And IIUC
>> the "Hardware Page Aggregation (HPA)" Ryan was talking about elsewhere in
>> the thread, that sounds similar. So I IIUC there will be a larger TLB entry
>> transparently, and then I don't expect the CPU to update individual bits as
>> that would defeat the purpose. So I'd expect it will either set them all to
>> active when forming the larger TLB entry, or set them on a single subpage
>> and leave the rest at whatever state they were. Hm I wonder if the exact
>> behavior is defined anywhere.
> 
> For arm64, at least, there are 2 separate mechanisms:
> 
> "The Contiguous Bit" (D8.6.1 in the Arm ARM) is a bit in the translation table
> descriptor that SW can set to indicate that a set of adjacent entries are
> contiguous and have same attributes and permissions etc. It is architectural.
> The order of the contiguous range is fixed and depends on the base page size
> that is in use. When in use, HW access and dirty reporting is only done at the
> granularity of the contiguous block.
> 
> "HPA" is a micro-architectural feature on some Arm CPUs, which aims to do a
> similar thing, but is transparent to SW. In this case, the dirty and access bits
> remain per-page. But when they differ, this affects the performance of the feature.
> 
> Typically HPA can coalesce up to 4 adjacent entries, whereas for a 4KB base page
> at least, the contiguous bit applies to 16 adjacent entries.

Hm if it's 4 entries on arm64 and presumably 8 on AMD, maybe we can only
care about how actively accessed are the individual "subpages" above that
size, to avoid dealing with this uncertainty whether HW tracks them. At such
smallish sizes we shouldn't induce massive overhead?

> I'm hearing that there are workloads where being able to use the contiguous bit
> really does make a difference, so I would like to explore solutions that can
> work when we only have access/dirty at the folio level.

And on the higher orders where we have explicit control via bits, we could
split the explicitly contiguous mappings once in a while to determine if the
sub-folios are still accessed? Although maybe with 16x4kB pages limit it may
still be not worth the trouble?

> Thanks,
> Ryan

