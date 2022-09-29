Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304F35EF2DE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 11:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235143AbiI2J6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 05:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235189AbiI2J6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:58:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD716132FE4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 02:58:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 001751F45B;
        Thu, 29 Sep 2022 09:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1664445489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9f7cRjM2G9fSplORaUyU85h21fLhqLa19ttKpHZljBA=;
        b=mmhlLYanipKdJK37y8n7gxBBX8Ev7O8kEm9yBWKqCJMP0p1iDTjq14SxvkTIqKFWJwQMhd
        qmGG/ERxzWiWUMjgEVcfUazRcwKlTdMpwffI9ItygAMOzFtBCiqfA2KnyIqrQttlXYHC+K
        kuLJK9pweTiSYfF4AkJMZ7XL+aIgDqE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1664445489;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9f7cRjM2G9fSplORaUyU85h21fLhqLa19ttKpHZljBA=;
        b=PrAvghFtiIRRp29Ib5L7ZAieDYJ2gaBr3HIpJTi0F30bKDlZC5iWXpSr416P0mI/9RHMAr
        DN2trIz8U/9e4UBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D234413A71;
        Thu, 29 Sep 2022 09:58:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id V8OcMjBsNWPnRAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 29 Sep 2022 09:58:08 +0000
Message-ID: <de71b83a-c82c-4785-ef5a-3db4f17bbc8d@suse.cz>
Date:   Thu, 29 Sep 2022 11:58:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: amusing SLUB compaction bug when CC_OPTIMIZE_FOR_SIZE
Content-Language: en-US
To:     Hugh Dickins <hughd@google.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <ea96c78c-e1dc-1364-e91-51909f82388b@google.com>
 <YzPgTtFzpKEfwPbK@hyeyoo> <YzRQvoVsnJzsauwb@google.com>
 <35502bdd-1a78-dea1-6ac3-6ff1bcc073fa@suse.cz>
 <ff905c1e-5eb3-eaf8-46de-38f189c0b7a5@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <ff905c1e-5eb3-eaf8-46de-38f189c0b7a5@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/22 19:50, Hugh Dickins wrote:
> On Wed, 28 Sep 2022, Vlastimil Babka wrote:
>> On 9/28/22 15:48, Joel Fernandes wrote:
>> > On Wed, Sep 28, 2022 at 02:49:02PM +0900, Hyeonggon Yoo wrote:
>> >> On Tue, Sep 27, 2022 at 10:16:35PM -0700, Hugh Dickins wrote:
>> >>> It's a bug in linux-next, but taking me too long to identify which
>> >>> commit is "to blame", so let me throw it over to you without more
>> >>> delay: I think __PageMovable() now needs to check !PageSlab().
>> 
>> When I tried that, the result wasn't really nice:
>> 
>> https://lore.kernel.org/all/aec59f53-0e53-1736-5932-25407125d4d4@suse.cz/
>> 
>> And what if there's another conflicting page "type" later. Or the debugging
>> variant of rcu_head in struct page itself. The __PageMovable() is just too
>> fragile.
> 
> I don't disagree (and don't really know all the things you're thinking
> of in there).  But if it's important to rescue this feature for 6.1, a
> different approach may be the very simple patch below (I met a similar
> issue with OPTIMIZE_FOR_SIZE in i915 a year ago, and just remembered).
> 
> But you be the judge of it: (a) I do not know whether rcu_free_slab
> is the only risky address ever stuffed into that field; and (b) I'm
> clueless when it comes to those architectures (powerpc etc) where the
> the address of a function is something different from the address of
> the function (have I conveyed my cluelessness adequately?).

Thanks a lot Hugh! That's a sufficiently small fix (compared to the other
options) that I'm probably give it one last try.

> Hugh
> 
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1953,7 +1953,12 @@ static void __free_slab(struct kmem_cach
>  	__free_pages(folio_page(folio, 0), order);
>  }
>  
> -static void rcu_free_slab(struct rcu_head *h)
> +/*
> + * rcu_free_slab() must be __aligned(4) because its address is saved
> + * in the rcu_head field, which coincides with page->mapping, which
> + * causes trouble if compaction mistakes it for PAGE_MAPPING_MOVABLE.
> + */
> +__aligned(4) static void rcu_free_slab(struct rcu_head *h)
>  {
>  	struct slab *slab = container_of(h, struct slab, rcu_head);
>  

