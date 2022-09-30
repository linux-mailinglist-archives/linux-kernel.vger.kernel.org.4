Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8475F05DF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 09:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbiI3HkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 03:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbiI3Hjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 03:39:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734C126483
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 00:39:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 164D61F460;
        Fri, 30 Sep 2022 07:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1664523588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VdrA4yqPrHCz2RiBS5dNiY3uDpMq1COfxzCZsf8wbPg=;
        b=HdCtZHuV/5hiApVAYBlsW1Nine9pPwtWO53QVbErTbVUZ0MloFIjMqI993kO3L4/MjDOW6
        baEVztJT+KMnPopWOKFqfZUbHMj+yzKroHCknMQIuTcUbaD91sFArQcFtL8BKLzlRYv1sO
        +vF3/w8mUfOGulf9c02Xg/Xn1m8UOcE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1664523588;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VdrA4yqPrHCz2RiBS5dNiY3uDpMq1COfxzCZsf8wbPg=;
        b=uZ1/CXvEP98D9+g9G9pqhGIFXMnka+k2mluJqDz6gIKMcKXWcoKy24RsVvhQq4cpe8lL3O
        5wZEuYGpKr5a+jDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E7BF313677;
        Fri, 30 Sep 2022 07:39:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HIpKN0OdNmP4LQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 30 Sep 2022 07:39:47 +0000
Message-ID: <c432330b-33f0-82d0-65f1-a548ce0658b1@suse.cz>
Date:   Fri, 30 Sep 2022 09:39:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: amusing SLUB compaction bug when CC_OPTIMIZE_FOR_SIZE
To:     Hugh Dickins <hughd@google.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <ea96c78c-e1dc-1364-e91-51909f82388b@google.com>
 <YzPgTtFzpKEfwPbK@hyeyoo> <YzRQvoVsnJzsauwb@google.com>
 <35502bdd-1a78-dea1-6ac3-6ff1bcc073fa@suse.cz>
 <ff905c1e-5eb3-eaf8-46de-38f189c0b7a5@google.com>
 <de71b83a-c82c-4785-ef5a-3db4f17bbc8d@suse.cz>
 <bcecece-f7ce-221d-1674-da3d5ab3fef@google.com>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <bcecece-f7ce-221d-1674-da3d5ab3fef@google.com>
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

On 9/29/22 23:54, Hugh Dickins wrote:
> On Thu, 29 Sep 2022, Vlastimil Babka wrote:
>> On 9/28/22 19:50, Hugh Dickins wrote:
>> > On Wed, 28 Sep 2022, Vlastimil Babka wrote:
>> >> On 9/28/22 15:48, Joel Fernandes wrote:
>> >> > On Wed, Sep 28, 2022 at 02:49:02PM +0900, Hyeonggon Yoo wrote:
>> >> >> On Tue, Sep 27, 2022 at 10:16:35PM -0700, Hugh Dickins wrote:
>> >> >>> It's a bug in linux-next, but taking me too long to identify which
>> >> >>> commit is "to blame", so let me throw it over to you without more
>> >> >>> delay: I think __PageMovable() now needs to check !PageSlab().
>> >> 
>> >> When I tried that, the result wasn't really nice:
>> >> 
>> >> https://lore.kernel.org/all/aec59f53-0e53-1736-5932-25407125d4d4@suse.cz/
>> >> 
>> >> And what if there's another conflicting page "type" later. Or the debugging
>> >> variant of rcu_head in struct page itself. The __PageMovable() is just too
>> >> fragile.
>> > 
>> > I don't disagree (and don't really know all the things you're thinking
>> > of in there).  But if it's important to rescue this feature for 6.1, a
>> > different approach may be the very simple patch below (I met a similar
>> > issue with OPTIMIZE_FOR_SIZE in i915 a year ago, and just remembered).
>> > 
>> > But you be the judge of it: (a) I do not know whether rcu_free_slab
>> > is the only risky address ever stuffed into that field; and (b) I'm
>> > clueless when it comes to those architectures (powerpc etc) where the
>> > the address of a function is something different from the address of
>> > the function (have I conveyed my cluelessness adequately?).
>> 
>> Thanks a lot Hugh! That's a sufficiently small fix (compared to the other
>> options) that I'm probably give it one last try.
> 
> I suddenly worried that you might be waiting on me for a Signed-off-by,
> which I couldn't give until I researched my reservations (a) and (b):
> but I'm pleased to see from your kernel.org tree that you've gone ahead
> and folded it in - thanks.

Yeah could have been more explicit about that, sorry. But made the whole
thing a very last merge so I can still drop it before the pull request.

> Regarding (a): great, you've found it too, mm/slab.c's kmem_rcu_free()
> looks like it needs the same __aligned(4) as mm/slub.c's rcu_free_slabi().

Right.

> Regarding (b): I booted the PowerMac G5 to take a look, and dredged up
> the relevant phrase "function descriptor" from depths of my memory: I
> was right to consider that case, but it's not a worry - the first field
> of a function descriptor structure (on all the architectures I found it)
> is the function address, so the function descriptor address would be
> aligned 4 or 8 anyway.

Thanks. I admit I wasn't that thorough, just consulted somebody internally :)

> Regarding "conflicting" alignment requests: yes, I agree with you,
> it would have to be a toolchain bug if when asked to align 2 and to
> align 4, it chose not to align 4.

Yeah. But I still would be less worried if another __aligned(X) function
existed in the tree already. Found only data. I assume the i915 thing wasn't
fixed like this in the tree? So if there are buggy toolchains or anything,
it will be us to discover them.

So I think we still should defuse the __PageMovable() mine somehow.

> So, no worries at my end now.
> Hugh

