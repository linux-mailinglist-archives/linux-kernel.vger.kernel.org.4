Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B029E5FFBC8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 21:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiJOTjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 15:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiJOTjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 15:39:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262CD4B0C8
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 12:39:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 835771F901;
        Sat, 15 Oct 2022 19:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665862748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RWHL/TS5G60M76tkslckcdwur+VAUEIWMUn5i09Zkeo=;
        b=F17mSP5b2ostAA6Kml1dyr2cc2uX0Om8HiSu6Jm3QKguza4Wlj53NJ/Lx2rWIRQsdffCo+
        gevsAz/orBXaRekat2TQ9+TslD+TOBEhH6G3FpGXsrmG5ldzSIZqoDjc+VakOcouN/g0Jw
        ADXOD3pcB9rui2yObvvMkkym05ASun8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665862748;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RWHL/TS5G60M76tkslckcdwur+VAUEIWMUn5i09Zkeo=;
        b=6z7A5tozl7xC+kJb6M0h1Nls701VT7Wrob7P3PUZLAINV+f277HtrxJKx9R30EQa1UpNO9
        nXxcgTgl+xlIx7Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 57B5B132C4;
        Sat, 15 Oct 2022 19:39:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xVy2FFwMS2ODGgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Sat, 15 Oct 2022 19:39:08 +0000
Message-ID: <7ad9081b-9082-2cbb-5732-f87366dca801@suse.cz>
Date:   Sat, 15 Oct 2022 21:39:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v4 10/17] mm/slab: kmalloc: pass requests larger than
 order-1 page to page allocator
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220817101826.236819-1-42.hyeyoo@gmail.com>
 <20220817101826.236819-11-42.hyeyoo@gmail.com>
 <20221014205818.GA1428667@roeck-us.net> <Y0n1WxxwbgSOmMwJ@hyeyoo>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Y0n1WxxwbgSOmMwJ@hyeyoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/22 01:48, Hyeonggon Yoo wrote:
> On Fri, Oct 14, 2022 at 01:58:18PM -0700, Guenter Roeck wrote:
>> Hi,
>> 
>> On Wed, Aug 17, 2022 at 07:18:19PM +0900, Hyeonggon Yoo wrote:
>> > There is not much benefit for serving large objects in kmalloc().
>> > Let's pass large requests to page allocator like SLUB for better
>> > maintenance of common code.
>> > 
>> > Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
>> > Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>> > ---
>> 
>> This patch results in a WARNING backtrace in all mips and sparc64
>> emulations.
>> 
>> ------------[ cut here ]------------
>> WARNING: CPU: 0 PID: 0 at mm/slab_common.c:729 kmalloc_slab+0xc0/0xdc
>> Modules linked in:
>> CPU: 0 PID: 0 Comm: swapper Not tainted 6.0.0-11990-g9c9155a3509a #1
>> Stack : ffffffff 801b2a18 80dd0000 00000004 00000000 00000000 81023cd4 00000000
>>         81040000 811a9930 81040000 8104a628 81101833 00000001 81023c78 00000000
>>         00000000 00000000 80f5d858 81023b98 00000001 00000023 00000000 ffffffff
>>         00000000 00000064 00000002 81040000 81040000 00000001 80f5d858 000002d9
>>         00000000 00000000 80000000 80002000 00000000 00000000 00000000 00000000
>>         ...
>> Call Trace:
>> [<8010a2bc>] show_stack+0x38/0x118
>> [<80cf5f7c>] dump_stack_lvl+0xac/0x104
>> [<80130d7c>] __warn+0xe0/0x224
>> [<80cdba5c>] warn_slowpath_fmt+0x64/0xb8
>> [<8028c058>] kmalloc_slab+0xc0/0xdc
>> 
>> irq event stamp: 0
>> hardirqs last  enabled at (0): [<00000000>] 0x0
>> hardirqs last disabled at (0): [<00000000>] 0x0
>> softirqs last  enabled at (0): [<00000000>] 0x0
>> softirqs last disabled at (0): [<00000000>] 0x0
>> ---[ end trace 0000000000000000 ]---
>> 
>> Guenter
> 
> Hi.
> 
> Thank you so much for this report!
> 
> Hmm so SLAB tries to find kmalloc cache for freelist index array using
> kmalloc_slab() directly, and it becomes problematic when size of the
> array is larger than PAGE_SIZE * 2.

Hmm interesting, did you find out how exactly that can happen in practice,
or what's special about mips and sparc64 here? Because normally
calculate_slab_order() will only go up to slab_max_order, which AFAICS can
only go up to SLAB_MAX_ORDER_HI, thus 1, unless there's a boot command line
override.

And if we have two pages for objects, surely even with small objects they
can't be smaller than freelist_idx_t, so if the number of objects fits into
two pages (order 1), then the freelist array should also fit in two pages?

Thanks,
Vlastimil

> Will send a fix soon.
> 

