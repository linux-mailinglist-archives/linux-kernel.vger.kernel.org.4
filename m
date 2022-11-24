Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAAA06378A9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 13:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiKXMMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 07:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiKXMMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 07:12:15 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED98274AA5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 04:12:14 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9E01D218E9;
        Thu, 24 Nov 2022 12:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669291933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DJVmOWQbiMAmWnWW4hlsAe4eeK/zWKppLW8xti306l8=;
        b=C3UPthb+tD9RGQ86R6MIG3nJNUfLpmtD8GzpC0MULOIMRvXck3rGJ7N8WvDuWRchFXatXT
        ULasH5JgLkCdzxDxk7Q5GrEK+ruHD5YYxSCXQPdfYmOaxzpn1XrbxwejNNSaqUtxu1aqxw
        3Flj/3W9ATaZ45Pv+U2mpPNmzTPwuqQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669291933;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DJVmOWQbiMAmWnWW4hlsAe4eeK/zWKppLW8xti306l8=;
        b=9XLkuKC8yJHZDxVcaB5ZpfD0f920D7i+Gcssv1hh335LdEK2mc/ILRj0MWGsQCS2OSo8lk
        72c75DcYoI8hErCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 66CEE13488;
        Thu, 24 Nov 2022 12:12:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EFQ4GJ1ff2M7egAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 24 Nov 2022 12:12:13 +0000
Message-ID: <4fb214a4-0535-2d4a-fcde-bc2ab71329e3@suse.cz>
Date:   Thu, 24 Nov 2022 13:12:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 06/12] mm, slub: don't create kmalloc-rcl caches with
 CONFIG_SLUB_TINY
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, patches@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20221121171202.22080-1-vbabka@suse.cz>
 <20221121171202.22080-7-vbabka@suse.cz>
 <d77498f8-b15f-9dae-1803-2d2bbb99da50@suse.cz> <Y39eLaW0mDNrHI6i@hyeyoo>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Y39eLaW0mDNrHI6i@hyeyoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/24/22 13:06, Hyeonggon Yoo wrote:
> On Wed, Nov 23, 2022 at 02:53:43PM +0100, Vlastimil Babka wrote:
>> On 11/21/22 18:11, Vlastimil Babka wrote:
>> > Distinguishing kmalloc(__GFP_RECLAIMABLE) can help against fragmentation
>> > by grouping pages by mobility, but on tiny systems the extra memory
>> > overhead of separate set of kmalloc-rcl caches will probably be worse,
>> > and mobility grouping likely disabled anyway.
>> > 
>> > Thus with CONFIG_SLUB_TINY, don't create kmalloc-rcl caches and use the
>> > regular ones.
>> > 
>> > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> 
>> Fixed up in response to lkp report for a MEMCG_KMEM+SLUB_TINY combo:
>> ---8<---
>> From c1ec0b924850a2863d061f316615d596176f15bb Mon Sep 17 00:00:00 2001
>> From: Vlastimil Babka <vbabka@suse.cz>
>> Date: Tue, 15 Nov 2022 18:19:28 +0100
>> Subject: [PATCH 06/12] mm, slub: don't create kmalloc-rcl caches with
>>  CONFIG_SLUB_TINY
>> 
>> Distinguishing kmalloc(__GFP_RECLAIMABLE) can help against fragmentation
>> by grouping pages by mobility, but on tiny systems the extra memory
>> overhead of separate set of kmalloc-rcl caches will probably be worse,
>> and mobility grouping likely disabled anyway.
>> 
>> Thus with CONFIG_SLUB_TINY, don't create kmalloc-rcl caches and use the
>> regular ones.
>> 
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> ---
>>  include/linux/slab.h |  9 +++++++--
>>  mm/slab_common.c     | 10 ++++++++--
>>  2 files changed, 15 insertions(+), 4 deletions(-)
>> 
>> diff --git a/include/linux/slab.h b/include/linux/slab.h
>> index 45efc6c553b8..ae2d19ec8467 100644
>> --- a/include/linux/slab.h
>> +++ b/include/linux/slab.h
>> @@ -336,12 +336,17 @@ enum kmalloc_cache_type {
>>  #endif
>>  #ifndef CONFIG_MEMCG_KMEM
>>  	KMALLOC_CGROUP = KMALLOC_NORMAL,
>> -#else
>> -	KMALLOC_CGROUP,
>>  #endif
>> +#ifdef CONFIG_SLUB_TINY
>> +	KMALLOC_RECLAIM = KMALLOC_NORMAL,
>> +#else
>>  	KMALLOC_RECLAIM,
>> +#endif
>>  #ifdef CONFIG_ZONE_DMA
>>  	KMALLOC_DMA,
>> +#endif
>> +#ifdef CONFIG_MEMCG_KMEM
>> +	KMALLOC_CGROUP,
>>  #endif
>>  	NR_KMALLOC_TYPES
>>  };
> 
> Can you please elaborate what the lkp report was about
> and how you fixed it? I'm not getting what the problem of previous
> version is.

Report here:
https://lore.kernel.org/all/202211231949.nIyAWKam-lkp@intel.com/

Problem is that if the preprocessing results in e.g.
KMALLOC_NORMAL = 0,
KMALLOC_DMA = KMALLOC_NORMAL
KMALLOC_CGROUP,
KMALLOC_RECLAIM = KMALLOC_NORMAL,
NR_KMALLOC_TYPES

then NR_KMALLOC_TYPES is not 2, but 1, because the enum's internal counter
got reset to 0 by KMALLOC_RECLAIM = KMALLOC_NORMAL. A common gotcha :/

