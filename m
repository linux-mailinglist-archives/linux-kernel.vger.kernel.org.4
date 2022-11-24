Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079EB6374CF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 10:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiKXJJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 04:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiKXJJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 04:09:07 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D0E9734F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 01:09:06 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 364C1218E6;
        Thu, 24 Nov 2022 09:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669280944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FclYwF7mD6zlQIZIpdVB8v8DFuE768K+j4RqjDVV1Z4=;
        b=kEOX+wB6OF6hz8EP3HGfyVC4B/lC6PiVIhtAYVxDG4OMYQ4ztcDfl4ilXlWVDbdIEeiMUO
        WMDEfdioXUZ+E7lo0orv9i4D6w3ETgDA74t9Y4MSNX2bOvT+7rWMDLvYaOFm/8AOzEUz7K
        n/qkOdjBW4q036Y+T1XmEJ66cw8X8To=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669280944;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FclYwF7mD6zlQIZIpdVB8v8DFuE768K+j4RqjDVV1Z4=;
        b=NEHVony4RogAIHQYKpjGONKexPxGDMrMJ5UiEjLrzU53yMnOA63UrZssDjr7V+PnhxQDgS
        EwEwBwNGxVYVMfDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0EE9013B4F;
        Thu, 24 Nov 2022 09:09:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MQIBA7A0f2NyFwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 24 Nov 2022 09:09:04 +0000
Message-ID: <23028c8a-7e53-6993-e076-6df8a6939313@suse.cz>
Date:   Thu, 24 Nov 2022 10:09:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 07/12] mm, slab: ignore SLAB_RECLAIM_ACCOUNT with
 CONFIG_SLUB_TINY
Content-Language: en-US
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, patches@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20221121171202.22080-1-vbabka@suse.cz>
 <20221121171202.22080-8-vbabka@suse.cz>
 <Y37GxICuaRbwK+tj@P9FQF9L96D.corp.robot.car>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Y37GxICuaRbwK+tj@P9FQF9L96D.corp.robot.car>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/24/22 02:20, Roman Gushchin wrote:
> On Mon, Nov 21, 2022 at 06:11:57PM +0100, Vlastimil Babka wrote:
>> SLAB_RECLAIM_ACCOUNT caches allocate their slab pages with
>> __GFP_RECLAIMABLE and can help against fragmentation by grouping pages
>> by mobility, but on tiny systems mobility grouping is likely disabled
>> anyway and ignoring SLAB_RECLAIM_ACCOUNT might instead lead to merging
>> of caches that are made incompatible just by the flag.
>> 
>> Thus with CONFIG_SLUB_TINY, make SLAB_RECLAIM_ACCOUNT ineffective.
> 
> Hm, do you see disabling all kernel memory accounting functionality
> with COFNIG_SLUB_TINY? I'd say yes. But in this case need to be consistent
> and disable it alltogether.

SLAB_RECLAIM_ACCOUNT is kinda misnomer these days, as the only thing it does
is to add __GFP_RECLAIMABLE to cache's gfp flags for the page allocator's
mobility grouping. I guess the "ACCOUNT" part comes from being counted
towards SReclaimable (vs SUnreclaim) in /proc/meminfo.

So currently SLUB_TINY has no effect on MEMCG_KMEM (which you probably
meant). Using those two together has little sense and had I stumbled while
making this series upon a code that would become complicated, I would have
made SLUB_TINY disable MEMCG_KMEM, but that didn't happen so I left as is
for now.

> Thanks!

