Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888575EACAB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 18:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiIZQhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 12:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiIZQgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 12:36:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201446D56B
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 08:24:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5EE2B21EF4;
        Mon, 26 Sep 2022 15:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664205816; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/QQNa5fjWpYSTINNZ8fkhajG7/HHXIdA5rA4AKSfwoc=;
        b=XHZoyzENCRIiGgTd/+ssg8u8SLzggAtIrjmeJmHRRhZnuW7nbag5ljev7ZALJKePOpt4JG
        ctbdLsvrk28VOBey7XZsYNI0eVyWmzlSah7hDNULEh6tffIGgLrdBkFJ1P7F6Ukol5flUB
        xECfGvDcjnLEnuVoYDbU/VbHMq4bjts=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4348C13486;
        Mon, 26 Sep 2022 15:23:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id m0CZDfjDMWPaIgAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 26 Sep 2022 15:23:36 +0000
Date:   Mon, 26 Sep 2022 17:23:35 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Florian Westphal <fw@strlen.de>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, vbabka@suse.cz,
        urezki@gmail.com, linux-kernel@vger.kernel.org,
        Martin Zaharinov <micron10@gmail.com>
Subject: Re: [PATCH v2 mm] mm: fix BUG splat with kvmalloc + GFP_ATOMIC
Message-ID: <YzHD93asRMvNCq9B@dhcp22.suse.cz>
References: <20220926151650.15293-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926151650.15293-1-fw@strlen.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 26-09-22 17:16:50, Florian Westphal wrote:
> Martin Zaharinov reports BUG with 5.19.10 kernel:
>  kernel BUG at mm/vmalloc.c:2437!
>  invalid opcode: 0000 [#1] SMP
>  CPU: 28 PID: 0 Comm: swapper/28 Tainted: G        W  O      5.19.9 #1
>  [..]
>  RIP: 0010:__get_vm_area_node+0x120/0x130
>   __vmalloc_node_range+0x96/0x1e0
>   kvmalloc_node+0x92/0xb0
>   bucket_table_alloc.isra.0+0x47/0x140
>   rhashtable_try_insert+0x3a4/0x440
>   rhashtable_insert_slow+0x1b/0x30
>  [..]
> 
> bucket_table_alloc uses kvzalloc(GPF_ATOMIC).  If kmalloc fails, this now
> falls through to vmalloc and hits code paths that assume GFP_KERNEL.
> 
> Reported-by: Martin Zaharinov <micron10@gmail.com>
> Fixes: a421ef303008 ("mm: allow !GFP_KERNEL allocations for kvmalloc")
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Link: https://lore.kernel.org/linux-mm/Yy3MS2uhSgjF47dy@pc636/T/#t
> Signed-off-by: Florian Westphal <fw@strlen.de>

Maybe we can extend this to GFP_NOWAIT capable vmalloc call but I am not
sure this exists or whether this is something vmalloc maintainers want
to commit to.

This is a clear and trivial fixup of the above commit. I would add this
to the stable tree as well.

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  mm/util.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/util.c b/mm/util.c
> index c9439c66d8cf..346e40177bc6 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -619,6 +619,10 @@ void *kvmalloc_node(size_t size, gfp_t flags, int node)
>  	if (ret || size <= PAGE_SIZE)
>  		return ret;
>  
> +	/* non-sleeping allocations are not supported by vmalloc */
> +	if (!gfpflags_allow_blocking(flags))
> +		return NULL;
> +
>  	/* Don't even allow crazy sizes */
>  	if (unlikely(size > INT_MAX)) {
>  		WARN_ON_ONCE(!(flags & __GFP_NOWARN));
> -- 
> 2.35.1

-- 
Michal Hocko
SUSE Labs
