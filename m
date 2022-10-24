Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20AF660B71D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbiJXTTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbiJXTTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:19:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EB8659F6;
        Mon, 24 Oct 2022 10:55:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 939E521E78;
        Mon, 24 Oct 2022 15:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666625100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NM/KgVrKralP4JTRInKOEYReTClkj2ojL2ILbxVa1Do=;
        b=IR0GqbZQTIi+J8BL97b72o11n4G64RRaPTm6Qqg5lsRAG3svoifzLSY7rpPnh8hP00/oN5
        UMiIGcQHIHQkYILcwblnXB3127/vw3mSJsg8m6MjtcBJjc3gGSpfzmmv0oZW7AIsPwVEw2
        vS6E418MOVXClJL3OLwxOyDIMqEQF8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666625100;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NM/KgVrKralP4JTRInKOEYReTClkj2ojL2ILbxVa1Do=;
        b=6f0QZsVzdtd+WGWoFywA7cc1yelqaD6Coa885+eE0n6EXTcyTOOmrrPfgDT3LCjJUK2OGV
        aZ9RSKgeX2HHT0AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 74BD113357;
        Mon, 24 Oct 2022 15:25:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fefMG0yuVmOpQwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 24 Oct 2022 15:25:00 +0000
Message-ID: <bb593a4d-bd4d-cf4a-8542-6f2c60053f45@suse.cz>
Date:   Mon, 24 Oct 2022 17:24:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: amusing SLUB compaction bug when CC_OPTIMIZE_FOR_SIZE
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        David Laight <David.Laight@aculab.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rcu@vger.kernel.org
References: <ea96c78c-e1dc-1364-e91-51909f82388b@google.com>
 <YzPgTtFzpKEfwPbK@hyeyoo> <YzRQvoVsnJzsauwb@google.com>
 <35502bdd-1a78-dea1-6ac3-6ff1bcc073fa@suse.cz>
 <ff905c1e-5eb3-eaf8-46de-38f189c0b7a5@google.com>
 <de71b83a-c82c-4785-ef5a-3db4f17bbc8d@suse.cz>
 <bcecece-f7ce-221d-1674-da3d5ab3fef@google.com> <YzkmErHFyYW3awRn@hyeyoo>
 <YzsVM8eToHUeTP75@casper.infradead.org>
 <7dddca4c-bc36-2cf0-de1c-a770bef9e1b7@suse.cz>
 <Y1ap9YAcZKFuIt/I@casper.infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Y1ap9YAcZKFuIt/I@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/22 17:06, Matthew Wilcox wrote:
> On Mon, Oct 24, 2022 at 04:35:04PM +0200, Vlastimil Babka wrote:
>> I would like to have a working safe version in -next, even if we are able
>> simplify it later thanks to frozen refcounts. I've made a formal patch of
>> yours, but I'm still convinced the slab check needs to be more paranoid so
>> it can't observe a false positive __folio_test_movable() while missing the
>> folio_test_slab(), hence I added the barriers as in my previous attempt [1].
>> Does that work for you and can I add your S-o-b?
> 
> Thanks for picking this back up.
> 
>> +++ b/mm/slab.c
>> @@ -1370,6 +1370,8 @@ static struct slab *kmem_getpages(struct kmem_cache *cachep, gfp_t flags,
>>  
>>  	account_slab(slab, cachep->gfporder, cachep, flags);
>>  	__folio_set_slab(folio);
>> +	/* Make the flag visible before any changes to folio->mapping */
>> +	smp_wmb();
> 
> So what's the point of using __folio_set_slab() only to call smp_wmb()
> afterwards?  If we call folio_set_slab() instead, don't all the other
> barriers go away?  (This is a genuine question; I am bad at this kind
> of reasoning).  Obviously it would still need a comment.

AFAIU (which doesn't mean much, TBH :)) folio_set_slab() makes the setting
of the flag protected against other flags set operations so our setting is
not lost in a non-atomic RMW. But as we are the only one who can be setting
any page/folio flag here (isolate_movable_page() for sure doesn't), we don't
need it for that kind of atomicity for page/folio flags field.

And, simply changing it to folio_set_slab() would not add the sufficient
smp_wmb() semantics to order the flags write visibility against a later
write to the struct slab field that overlaps page->mapping. Only some atomic
operations have that implicit barrier, (per
Documentation/memory-barriers.txt and Documentation/atomic_bitops.txt) and
set_bit() is not one of those. So we'd still need a smp_mb__after_atomic()
AFAIU and at that point, doing the above seems less obscure to me.

(Of course if we had the reason to use folio_set_slab() for its own atomic
guarantee, then smp_mb__after_atomic() instead of smp_wmb() would be better
as on some architectures it would make the barrier no-op).
