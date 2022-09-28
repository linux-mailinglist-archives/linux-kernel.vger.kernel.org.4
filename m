Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446BE5EE1B9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 18:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234412AbiI1QWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 12:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234508AbiI1QV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 12:21:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C96E11FA
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 09:21:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 82CD21F937;
        Wed, 28 Sep 2022 16:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1664382110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=43X+KK3JJPqkxR+LhduWBK5VY3wiG0HooZmEudcIgj4=;
        b=qPU89nQdXX3oafDIBnk8awWx9vjQ/A3F9pXlioAcH/WyBkIy8S9YiP8pSoEoh5fyZUZNPj
        /r/OV4+EVluZIrSEthhDBOE+E0E+vm8kVyJTDKMR7TM/Knw/szcvPlifyUer7/5CZC+GZE
        u5+o5oMXeLHxpUIZQM88fJ0mei3OOvo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1664382110;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=43X+KK3JJPqkxR+LhduWBK5VY3wiG0HooZmEudcIgj4=;
        b=+tiijjSt5OXUnWz/QMo4mnNcRi8i3lCOwaebCFIkfu5DHYYsjEJXjX5nSQGQ2HK01Z3HlZ
        KfQ2AGFyvUUY53DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4404A13677;
        Wed, 28 Sep 2022 16:21:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oiXUD550NGMyJwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 28 Sep 2022 16:21:50 +0000
Message-ID: <35502bdd-1a78-dea1-6ac3-6ff1bcc073fa@suse.cz>
Date:   Wed, 28 Sep 2022 18:20:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: amusing SLUB compaction bug when CC_OPTIMIZE_FOR_SIZE
To:     Joel Fernandes <joel@joelfernandes.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <ea96c78c-e1dc-1364-e91-51909f82388b@google.com>
 <YzPgTtFzpKEfwPbK@hyeyoo> <YzRQvoVsnJzsauwb@google.com>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <YzRQvoVsnJzsauwb@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/22 15:48, Joel Fernandes wrote:
> On Wed, Sep 28, 2022 at 02:49:02PM +0900, Hyeonggon Yoo wrote:
>> On Tue, Sep 27, 2022 at 10:16:35PM -0700, Hugh Dickins wrote:
>>> It's a bug in linux-next, but taking me too long to identify which
>>> commit is "to blame", so let me throw it over to you without more
>>> delay: I think __PageMovable() now needs to check !PageSlab().

When I tried that, the result wasn't really nice:

https://lore.kernel.org/all/aec59f53-0e53-1736-5932-25407125d4d4@suse.cz/

And what if there's another conflicting page "type" later. Or the 
debugging variant of rcu_head in struct page itself. The __PageMovable() 
is just too fragile.

>>> I had made a small experimental change somewhere, rebuilt and rebooted,
>>> was not surprised to crash once swapping and compaction came in,
>>> but was surprised to find the crash in isolate_movable_page(),
>>> called by compaction's isolate_migratepages_block().
>>>
>>> page->mapping was ffffffff811303aa, which qualifies as __PageMovable(),
>>> which expects struct movable_operations at page->mapping minus low bits.
>>> But ffffffff811303aa was the address of SLUB's rcu_free_slab(): I have
>>> CONFIG_CC_OPTIMIZE_FOR_SIZE=y, so function addresses may have low bits set.
>>>
>>> Over to you! Thanks,
>>> Hugh
>>
>> Wow, didn't expect this.
>> Thank you for report!
>>
>> That should be due to commit 65505d1f2338e7
>> ("mm/sl[au]b: rearrange struct slab fields to allow larger rcu_head")
>> as now rcu_head can use some bits that shares with mapping.
>>
>> Hmm IMO we have two choices...
>>
>> 1. simply drop the commit as it's only for debugging (RCU folks may not like [1])
> 
> Yeah definitely don't like this option as patches are out that depend on
> this (not yet merged though). :-)

But we'll have to do that for now and postpone to 6.2 I'm afraid as 
merge window for 6.1 is too close to have confidence in any solution 
that we came up this moment.

>> 2. make __PageMovable() to use true page flag, with approach [2])
> 
> What are the drawbacks of making it a true flag?

Even if we free PageSlab, I'm sure there will be better uses of a free 
page flag than __PageMovable.

3. With frozen page allocation
https://lore.kernel.org/all/20220809171854.3725722-1-willy@infradead.org/

slab pages will have refcount 0 and compaction will skip them for that 
reason. But it had other unresolved issues with page isolation code IIRC.

> thanks,
> 
>   - Joel
> 
> 
> 
> 
>> [1] https://lore.kernel.org/all/85afd876-d8bb-0804-b2c5-48ed3055e702@joelfernandes.org/
>> [2] https://lore.kernel.org/linux-mm/20220919125708.276864-1-42.hyeyoo@gmail.com/
>>
>> Thanks!
>>
>> -- 
>> Thanks,
>> Hyeonggon

