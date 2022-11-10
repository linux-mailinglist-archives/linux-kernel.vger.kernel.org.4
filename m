Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4AD623CAA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 08:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbiKJHbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 02:31:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbiKJHbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 02:31:34 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7CC32062
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 23:31:33 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B7A581F855;
        Thu, 10 Nov 2022 07:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668065491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lZ7h6ZsPjDv/SQN5pyK7W6yQucG8Skr2V4pDpGg5OeI=;
        b=GKIgxrOTRzrzncAUSltnll45CcyEjNPIK706coENS/bd9uHnYcT4tlHCoqcDaIOgZOB7uF
        HZ7SAbVp6KnQrLg5kktGF4/rguovTK39ySs57X7/wQnCJb2v/3tEkGOqH1Vp9730yj39SJ
        +pDmKvz7K/ZyEq5DI67QkgJYgP5HtDE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668065491;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lZ7h6ZsPjDv/SQN5pyK7W6yQucG8Skr2V4pDpGg5OeI=;
        b=IZ/QxcPBzgo2uTJvKY9e4xYF7cquRr1zleCzlNu9N19UAN3Xe6izKDyktN/POBC8JyAE0g
        qE9eoTEVsC2A95CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6BD631346E;
        Thu, 10 Nov 2022 07:31:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zcl1GdOobGMlIgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 10 Nov 2022 07:31:31 +0000
Message-ID: <e610b6fa-aa71-d612-0eb2-03ba6c4a6b46@suse.cz>
Date:   Thu, 10 Nov 2022 08:31:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: Deprecating and removing SLOB
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>, Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Paul Cercueil <paul@crapouillou.net>, 42.hyeyoo@gmail.com,
        akpm@linux-foundation.org, catalin.marinas@arm.com, cl@linux.com,
        iamjoonsoo.kim@lge.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, penberg@kernel.org, rientjes@google.com,
        rkovhaev@gmail.com, roman.gushchin@linux.dev, willy@infradead.org,
        Feng Tang <feng.tang@intel.com>
References: <K5M3LR.3O50LSSSY5L3@crapouillou.net>
 <CAHk-=wjBqwJk9RgfoBuM00T49M7uQiLnOvLST7L6v5rhS7fkDA@mail.gmail.com>
 <20221109234832.GE307514@darkstar.musicnaut.iki.fi>
 <Y2yArTbOpKd6ASkd@mit.edu>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Y2yArTbOpKd6ASkd@mit.edu>
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

On 11/10/22 05:40, Theodore Ts'o wrote:
> On Thu, Nov 10, 2022 at 01:48:32AM +0200, Aaro Koskinen wrote:
>> 
>> Some of the reported SLOB issues have been actually real driver bugs,
>> that go unnoticed when SLUB/SLAB are used (unless perhaps debug stuff
>> is enabled). I'm not saying kernel should keep SLOB, but it's good at
>> failing early when there is a bug. See e.g. commit 120ee599b5bf ("staging:
>> octeon-usb: prevent memory corruption")
> 
> Out of curiosity, are these bugs that would have been found using
> KASAN or some of the other kernel sanitizers and/or other debugging
> tools we have at our disposal?

Hopefully slub_debug redzoning would be able to trigger the bug described in
commit 120ee599b5bf above, which is:

>     octeon-hcd will crash the kernel when SLOB is used. This usually happens
>     after the 18-byte control transfer when a device descriptor is read.
>     The DMA engine is always transfering full 32-bit words and if the
>     transfer is shorter, some random garbage appears after the buffer.
>     The problem is not visible with SLUB since it rounds up the allocations
>     to word boundary, and the extra bytes will go undetected.

Ah, actually it wouldn't *now* as SLUB would make the allocation fall into
kmalloc-32 cache and only add redzone beyond 32 bytes. But with upcoming
changes by Feng Tang, this should work.

slub_debug would also have a chance of catching buffer overflows by kernel
code itself, not DMA, and tell you about it more sooner and gracefully than
crashing. KASAN also, even with a higher chance and precision, if it's
available for your arch and your device constraints can tolerate its larger
overhead.

>        		      	    	      	    	 - Ted
> 
> 						 

