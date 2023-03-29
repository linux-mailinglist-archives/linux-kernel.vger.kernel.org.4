Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63AB66CD4ED
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjC2ImB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjC2Il6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:41:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CDD1BB
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:41:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CAC831FDF3;
        Wed, 29 Mar 2023 08:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680079312; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FXNeQEeNkO9Z+oDPQiH/Ygm1gn1aQwVSYkquaLAzwlA=;
        b=LUVj+4KeuB2yvYNm15M0kJNlEkkTHl61wObJ0NeETKr2EQ8596eyWXIxI0wWssy36Q+LwV
        FRcYMZVTghWFqYMql9w+AXL4wZZ9guThsu4rznrzpyhXSs/rUXyQ9iGYQUF+QT6N5CSk9F
        iJyQzPwcSTv99ZZY0QB+ZMvvfysZXis=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680079312;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FXNeQEeNkO9Z+oDPQiH/Ygm1gn1aQwVSYkquaLAzwlA=;
        b=b8+5k1cjnJfonOpuSjz3VtwXV2d48GqUcCFYzjm/8FadUQaKJktk8tbfJ4nlPyFi14BOGR
        gngJBpU/t+aqd0Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9293E139D3;
        Wed, 29 Mar 2023 08:41:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KV4GItD5I2RjagAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 29 Mar 2023 08:41:52 +0000
Message-ID: <4f1096f0-cb6e-7cd2-5f41-c5e4b53fa407@suse.cz>
Date:   Wed, 29 Mar 2023 10:41:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] mm/slub: Reduce memory consumption in extreme scenarios
Content-Language: en-US
To:     "chenjun (AM)" <chenjun102@huawei.com>,
        Mike Rapoport <rppt@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cl@linux.com" <cl@linux.com>,
        "penberg@kernel.org" <penberg@kernel.org>,
        "rientjes@google.com" <rientjes@google.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "xuqiang (M)" <xuqiang36@huawei.com>,
        "Wangkefeng (OS Kernel Lab)" <wangkefeng.wang@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
References: <20230314123403.100158-1-chenjun102@huawei.com>
 <0cad1ff3-8339-a3eb-fc36-c8bda1392451@suse.cz>
 <344c7521d72e4107b451c19b329e9864@huawei.com>
 <8c700468-245d-72e9-99e7-b99d4547e6d8@suse.cz>
 <aeb2bd3990004b9eb4f151aa833ddcf2@huawei.com>
 <015855b3-ced3-8d84-e21d-cc6ce112b556@suse.cz> <ZBgjZn7WOqO5ruws@kernel.org>
 <c3a2280eff5c419ea14b6cad34474e08@huawei.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <c3a2280eff5c419ea14b6cad34474e08@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/23 10:30, chenjun (AM) wrote:
> 在 2023/3/20 17:12, Mike Rapoport 写道:
>>>>
>>>> If we ignore __GFP_ZERO passed by kzalloc， kzalloc will not work.
>>>> Could we just unmask __GFP_RECLAIMABLE | __GFP_RECLAIM?
>>>>
>>>> pc.flags &= ~(__GFP_RECLAIMABLE | __GFP_RECLAIM)
>>>> pc.flags |= __GFP_THISNODE
>>>
>>> __GFP_RECLAIMABLE would be wrong, but also ignored as new_slab() does:
>>> 	flags & (GFP_RECLAIM_MASK | GFP_CONSTRAINT_MASK)
>>>
>>> which would filter out __GFP_ZERO as well. That's not a problem as kzalloc()
>>> will zero out the individual allocated objects, so it doesn't matter if we
>>> don't zero out the whole slab page.
>>>
>>> But I wonder, if we're not past due time for a helper e.g.
>>> gfp_opportunistic(flags) that would turn any allocation flags to a
>>> GFP_NOWAIT while keeping the rest of relevant flags intact, and thus there
>>> would be one canonical way to do it - I'm sure there's a number of places
>>> with their own variants now?
>>> With such helper we'd just add __GFP_THISNODE to the result here as that's
>>> specific to this particular opportunistic allocation.
>> 
>> I like the idea, but maybe gfp_no_reclaim() would be clearer?
>> 
> 
> #define gfp_no_reclaim(gfpflag) (gfpflag & ~__GFP_DIRECT_RECLAIM)

I hoped for more feedback on the idea, but it's probably best proposed
outside of this slub-specific thread, so we could go for an open-coded
solution in slub for now.

Also just masking out __GFP_DIRECT_RECLAIM wouldn't be sufficient in any
case for the general solution/

> And here,
> 
> pc.flags = gfp_no_reclaim(gfpflags) | __GFP_THISNODE.

I'd still suggest as earlier:

pc.flags = GFP_NOWAIT | __GFP_NOWARN |__GFP_THISNODE;

> Do I get it right？

