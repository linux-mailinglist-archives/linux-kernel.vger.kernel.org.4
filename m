Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241DA622653
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 10:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbiKIJKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 04:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbiKIJJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 04:09:51 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE416566
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 01:09:44 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 130EE21EEA;
        Wed,  9 Nov 2022 09:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667984983; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4rvDAE7ynxS4SjgRq0+PnY4oQgJkKPVoUhifdSQ0G1U=;
        b=whCkYGYSHp8sgZjH9YqktwAltZO443vH+z259yTeU7m8iS//oeQzr7TDv+/WSAbd00jT48
        cnXkzYDrzg5BKnm9BwJo/y52Tcysccd4bRJgdDp1sUaxoxGVHDbWlHdRnu4VsBhasCB21/
        NIdWXlfyA6Md1lvtGbCxhqDrzp3hdmI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667984983;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4rvDAE7ynxS4SjgRq0+PnY4oQgJkKPVoUhifdSQ0G1U=;
        b=Fck9nHcqZ3rxPvaT0Al6ILtulSRwDpOlOPrcv08aV3PNYDXlHD6maHkGJUFvjoRd6OGHJo
        X+H7/cRV4t+lXXDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CBB9D1331F;
        Wed,  9 Nov 2022 09:09:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gLsHMVZua2PuaQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 09 Nov 2022 09:09:42 +0000
Message-ID: <1823fa9f-f67d-9581-0e6f-55f0c050fcc6@suse.cz>
Date:   Wed, 9 Nov 2022 10:09:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: Deprecating and removing SLOB
Content-Language: en-US
To:     Yosry Ahmed <yosryahmed@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Greg Thelen <gthelen@google.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Rustam Kovhaev <rkovhaev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <b35c3f82-f67b-2103-7d82-7a7ba7521439@suse.cz>
 <Y2qkIrk+a9v7tAQZ@P9FQF9L96D.lan>
 <CAJD7tkaqrz8sGqgbyfQHU_NM3O=a_0bqSHB0gGYRB7Kj+w_05w@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAJD7tkaqrz8sGqgbyfQHU_NM3O=a_0bqSHB0gGYRB7Kj+w_05w@mail.gmail.com>
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

On 11/8/22 21:13, Yosry Ahmed wrote:
> On Tue, Nov 8, 2022 at 10:47 AM Roman Gushchin <roman.gushchin@linux.dev> wrote:
>>
>> On Tue, Nov 08, 2022 at 04:55:29PM +0100, Vlastimil Babka wrote:
>> > Hi,
>> >
>> > as we all know, we currently have three slab allocators. As we discussed at
>> > LPC [1], it is my hope that one of these allocators has a future, and two of
>> > them do not.
>> >
>> > The unsurprising reasons include code maintenance burden, other features
>> > compatible with only a subset of allocators (or more effort spent on the
>> > features), blocking API improvements (more on that below), and my inability
>> > to pronounce SLAB and SLUB in a properly distinguishable way, without
>> > resorting to spelling out the letters.
>> >
>> > I think (but may be proven wrong) that SLOB is the easier target of the two
>> > to be removed, so I'd like to focus on it first.
>>
>> Great!
>>
>> SLOB is not supported by the kernel memory accounting code, so if we'll
>> deprecate SLOB, we can remove all those annoying ifndefs.
>>
>> But I wonder if we can deprecate SLAB too? Or at least use the moment to
>> ask every non-SLUB user on why they can't/don't want to use SLUB.
>> Are there any known advantages of SLAB over SLUB?

Yeah it was my plan to inquire about SLAB next, once SLOB's fate is settled,
as I did expect greater resistance there. My hope is that if there are still
workloads that benefit from SLAB's percpu arrays, we could e.g. add
(per-cache opt-in) percpu arrays to SLUB, as that would be still better than
having two different complete implementations.

> We use SLAB at Google, but I am not the right person to answer the
> question of why we can't/don't use SLUB. Adding Greg here who recently
> looked into this and might have answers. I see David is already
> tagged, he might have a good answer as well.

Yeah, Google folks were indeed against removing SLAB due to such workloads
in the past discussions.

>>
>> Also, for memory-constrained users we might want to add some guide on how
>> to configure SLUB to minimize the memory footprint.
>>
>> Thank you!
>>
>> Roman
>>

