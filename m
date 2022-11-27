Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B86E639E28
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 00:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiK0XLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 18:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiK0XLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 18:11:16 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809F0FD22
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 15:11:15 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1895721B95;
        Sun, 27 Nov 2022 23:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669590673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lq+hxk2jZLq7sWjpYaRCMKOHOLgy8Wwlbt7cndUUYuU=;
        b=bFAgYyVJLutsJ3njue2hOhs/rgjP0WZ7Yn/10rMyL+wzjqDh6NmrqcxZ5/w0KB0XCRVTa7
        Bg6HQYJjNftkG+lbHhejipO34cFgk0uNm1NW3OKRFoH1ZpQIhaApc3XUWYku5+1SmCb4JJ
        B4/8FHifmitpaa6K/IaI/r6cu9yW690=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669590673;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lq+hxk2jZLq7sWjpYaRCMKOHOLgy8Wwlbt7cndUUYuU=;
        b=+yiqcfcmf0/ChHbECZGhFGNJysdm68XNY/oawDfGWE817SRlLy8gFDcQPnaBWLgAu5lBLq
        f4RfxAOZpPcGQlAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D9846134CE;
        Sun, 27 Nov 2022 23:11:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AIhhNJDug2PZAwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Sun, 27 Nov 2022 23:11:12 +0000
Message-ID: <e57e25d5-14a0-0271-e3d7-f79cfaa0a049@suse.cz>
Date:   Mon, 28 Nov 2022 00:11:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 07/12] mm, slab: ignore SLAB_RECLAIM_ACCOUNT with
 CONFIG_SLUB_TINY
Content-Language: en-US
To:     Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, patches@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20221121171202.22080-1-vbabka@suse.cz>
 <20221121171202.22080-8-vbabka@suse.cz>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20221121171202.22080-8-vbabka@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/22 18:11, Vlastimil Babka wrote:
> SLAB_RECLAIM_ACCOUNT caches allocate their slab pages with
> __GFP_RECLAIMABLE and can help against fragmentation by grouping pages
> by mobility, but on tiny systems mobility grouping is likely disabled
> anyway and ignoring SLAB_RECLAIM_ACCOUNT might instead lead to merging
> of caches that are made incompatible just by the flag.
> 
> Thus with CONFIG_SLUB_TINY, make SLAB_RECLAIM_ACCOUNT ineffective.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  include/linux/slab.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 3ce9474c90ab..1cbbda03ad06 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -129,7 +129,11 @@
>  
>  /* The following flags affect the page allocator grouping pages by mobility */
>  /* Objects are reclaimable */
> +#ifndef CONFIG_SLUB_TINY
>  #define SLAB_RECLAIM_ACCOUNT	((slab_flags_t __force)0x00020000U)
> +#else
> +#define SLAB_RECLAIM_ACCOUNT	0

Updating the last line above to:
#define SLAB_RECLAIM_ACCOUNT      ((slab_flags_t __force)0)

In response to:
https://lore.kernel.org/all/202211280441.yCEecX9z-lkp@intel.com/

Yeah it probably means that the other pre-existing flag variants that
#define to 0 should be also adjusted to avoid these issues, but not as part
of this series.

> +#endif
>  #define SLAB_TEMPORARY		SLAB_RECLAIM_ACCOUNT	/* Objects are short-lived */
>  
>  /*

