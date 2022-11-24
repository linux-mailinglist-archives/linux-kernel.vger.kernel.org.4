Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F703637496
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 09:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiKXI4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 03:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiKXI4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 03:56:32 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D4510B43C;
        Thu, 24 Nov 2022 00:56:28 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 13E0D1F74B;
        Thu, 24 Nov 2022 08:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669280187; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IRbHSZAvcm7DCxkQoBDuZJ7WJhgALmpmeJtEPf69/Bo=;
        b=0VgTZw87n5eYs+AlhiH/sJlhw8t690c1+FE91eAPX+Cak+PLYnYU3yEqj+iD2M3yhgC1MK
        z9Ekh5rYganp5LtIoSQ6NfXvHogaiQq12//vqhSzWYCjjWMQ7mHZMqwNgPV+kn6II5fpAP
        BMFnt1ktlRJa4Mmadk3/HKoR9PB4Ze0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669280187;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IRbHSZAvcm7DCxkQoBDuZJ7WJhgALmpmeJtEPf69/Bo=;
        b=c99MB6SRIxmYiYPwWUEWsFx0LLEJGUEAkVBR9QiiPOReB//3vfyiKc7OJ4N+JDEqmzw2YI
        NgJ1sHxVn6nHrgCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 00D2513B4F;
        Thu, 24 Nov 2022 08:56:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wbHHOroxf2P5DwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 24 Nov 2022 08:56:26 +0000
Message-ID: <4696fdad-5ba5-452c-518a-025d3ed796d0@suse.cz>
Date:   Thu, 24 Nov 2022 09:56:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: linux-next: build failure after merge of the slab tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20221124153923.58a1a9f4@canb.auug.org.au>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20221124153923.58a1a9f4@canb.auug.org.au>
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

On 11/24/22 05:39, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the slab tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:

Oops, thanks, looks like I had !CONFIG_PRINTK when testing that... Will be
fixed in the next slab-next.

> mm/slab_common.c: In function 'kmem_dump_obj':
> mm/slab_common.c:603:49: error: 'struct kmem_cache' has no member named 'usersize'
>   603 |         if (kp.kp_slab_cache && kp.kp_slab_cache->usersize)
>       |                                                 ^~
> In file included from include/asm-generic/bug.h:22,
>                  from arch/powerpc/include/asm/bug.h:159,
>                  from include/linux/bug.h:5,
>                  from include/linux/thread_info.h:13,
>                  from include/asm-generic/preempt.h:5,
>                  from ./arch/powerpc/include/generated/asm/preempt.h:1,
>                  from include/linux/preempt.h:78,
>                  from include/linux/spinlock.h:56,
>                  from include/linux/mmzone.h:8,
>                  from include/linux/gfp.h:7,
>                  from include/linux/slab.h:15,
>                  from mm/slab_common.c:7:
> mm/slab_common.c:604:53: error: 'struct kmem_cache' has no member named 'usersize'
>   604 |                 pr_cont(" size %u", kp.kp_slab_cache->usersize);
>       |                                                     ^~
> include/linux/printk.h:429:33: note: in definition of macro 'printk_index_wrap'
>   429 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
>       |                                 ^~~~~~~~~~~
> include/linux/printk.h:542:9: note: in expansion of macro 'printk'
>   542 |         printk(KERN_CONT fmt, ##__VA_ARGS__)
>       |         ^~~~~~
> mm/slab_common.c:604:17: note: in expansion of macro 'pr_cont'
>   604 |                 pr_cont(" size %u", kp.kp_slab_cache->usersize);
>       |                 ^~~~~~~
> 
> Caused by commit
> 
>   3cdb7b6ad16a ("mm, slab: ignore hardened usercopy parameters when disabled")
> 
> I have used the slab tree from next-20221123 for today.
> 

