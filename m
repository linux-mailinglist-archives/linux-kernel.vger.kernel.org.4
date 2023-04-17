Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44656E4D17
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 17:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjDQP1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 11:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjDQP1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 11:27:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDEA9C15E
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 08:27:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1E59A1F86C;
        Mon, 17 Apr 2023 15:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681745202; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kP1FEdt3fgTtl/pEyrGYUKu6csEc5th69ovw9D0Lbks=;
        b=PNaUDVjplalz7kjNZ5oPia5ylWVPvIVnD5RHI2g/dROObQCGPVZJfqPBmVBtqWDUCNx+H9
        vm0rLbaPVj4o4gSRA4PG6cQEpOO7IIiWS72VKgxzn1NAZ/5LVTqFRbMIAJ/yrleZM4jlus
        f+PDu2KVzduScztiHjQ8p+FRI4NOb0U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681745202;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kP1FEdt3fgTtl/pEyrGYUKu6csEc5th69ovw9D0Lbks=;
        b=sC8bwZv0H+RTsIAkd8CFhA/cNu1fwTFyn+uIQ4d2KcpLxTExXfo6e2jKYFnBVORh1Eg8kr
        xIbGOTHX91Man1BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EF2951390E;
        Mon, 17 Apr 2023 15:26:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id q1fUOTFlPWSXNAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 17 Apr 2023 15:26:41 +0000
Message-ID: <20e3bfd8-851e-1e2a-76b5-7c705e4d1c3d@suse.cz>
Date:   Mon, 17 Apr 2023 17:26:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 0/3] Replace invocations of prandom_u32() with
 get_random_u32() and siphash
Content-Language: en-US
To:     david.keisarschm@mail.huji.ac.il, linux-kernel@vger.kernel.org
Cc:     Jason@zx2c4.com, linux-mm@kvack.org, akpm@linux-foundation.org,
        42.hyeyoo@gmail.com, mingo@redhat.com, hpa@zytor.com,
        keescook@chromium.org, ilay.bahat1@gmail.com, aksecurity@gmail.com
References: <20230416172158.13133-1-david.keisarschm@mail.huji.ac.il>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230416172158.13133-1-david.keisarschm@mail.huji.ac.il>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/16/23 19:21, david.keisarschm@mail.huji.ac.il wrote:
> From: David Keisar Schmidt <david.keisarschm@mail.huji.ac.il>

Hi,

btw, the threading of v5 and v6 seems broken, v4 was fine.

I've added the patches 1+2 to slab tree for 6.5 (too late for 6.4 now):

https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/log/?h=slab/for-6.5/prandom

Thanks,
Vlastimil

> Hi,
> 
> The security improvements for prandom_u32 done in commits c51f8f88d705
> from October 2020 and d4150779e60f from May 2022 didn't handle the cases
> when prandom_bytes_state() and prandom_u32_state() are used.
> 
> Specifically, this weak randomization takes place in three cases:
>     1.	mm/slab.c
>     2.	mm/slab_common.c
>     3.	arch/x86/mm/kaslr.c
> 
> The first two invocations (mm/slab.c, mm/slab_common.c) are used to create
> randomization in the slab allocator freelists.
> This is done to make sure attackers can’t obtain information on the heap state.
> 
> The last invocation, inside arch/x86/mm/kaslr.c,
> randomizes the virtual address space of kernel memory regions.
> Hence, we have added the necessary changes to make those randomizations stronger,
> switching  prandom_u32 instance to siphash.
> 
> Changes since v5:
> * Fixed coding style issues in mm/slab and mm/slab_common.
> * Deleted irrelevant changes which were appended accidentally in
>   arch/x86/mm/kaslr.
> 
> Changes since v4:
> * Changed only the arch/x86/mm/kaslr patch.
>   In particular, we replaced the use of prandom_bytes_state and
>   prandom_seed_state with siphash inside arch/x86/mm/kaslr.c.
> 
> Changes since v3:
> * edited commit messages
> 
> Changes since v2:
> * edited commit message.
> * replaced instances of get_random_u32 with get_random_u32_below
>       in mm/slab.c, mm/slab_common.c
> 
> Regards,
> 
> 
> David Keisar Schmidt (3):
>   mm/slab: Replace invocation of weak PRNG
>   mm/slab_common: Replace invocation of weak PRNG
>   arch/x86/mm/kaslr: use siphash instead of prandom_bytes_state
> 
>  arch/x86/mm/kaslr.c | 21 +++++++++++++++------
>  mm/slab.c           | 29 +++++++++--------------------
>  mm/slab_common.c    | 11 +++--------
>  3 files changed, 27 insertions(+), 34 deletions(-)
> 

