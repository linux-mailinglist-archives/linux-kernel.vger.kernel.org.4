Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD0F5B9599
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 09:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiIOHmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 03:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbiIOHmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 03:42:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB69923FD
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 00:42:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EE2985CED5;
        Thu, 15 Sep 2022 07:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663227749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=46CZPwTI4AhhpjyH8QcwMuqcADSvBwoVR5QSnvV/X54=;
        b=WhHYNKGLv5zBKW5a9rH8TaIAsmmFi68O6H6iuMB2t4oCQ6BNZNXqykbqAtET2Q97c7rCxq
        pJlIlgJmBIxh05WmafILs8NxqbDtKPKMzzBdqrsk12LhyICjubo2leko6ECXP1MwkM+bu4
        R8uBTgeVsFADu9I44MTxs9V58cNXRZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663227749;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=46CZPwTI4AhhpjyH8QcwMuqcADSvBwoVR5QSnvV/X54=;
        b=x0M9qQuX3ZB1GiEZ28bHTJzea0tXYA13/IxboTQn91tmOmHil0IKangfxRD5/j5WlmGI1t
        THMcxPTvvJGzp6CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 98CDF133A7;
        Thu, 15 Sep 2022 07:42:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1xiCImXXImPuZwAAMHmgww
        (envelope-from <osalvador@suse.de>); Thu, 15 Sep 2022 07:42:29 +0000
Date:   Thu, 15 Sep 2022 09:42:28 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/16] mm/page_alloc: init local variable buddy_pfn
Message-ID: <YyLXZDc2PrjITRe6@localhost.localdomain>
References: <20220909092451.24883-1-linmiaohe@huawei.com>
 <20220909092451.24883-14-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909092451.24883-14-linmiaohe@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 05:24:48PM +0800, Miaohe Lin wrote:
> The local variable buddy_pfn could be passed to buddy_merge_likely()
> without initialization if the passed in order is MAX_ORDER - 1. This
> looks buggy but buddy_pfn won't be used in this case as there's a
> order >= MAX_ORDER - 2 check. Init buddy_pfn to 0 anyway to avoid
> possible future misuse.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  mm/page_alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index e1c7f98cff96..63ad25e86010 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1113,7 +1113,7 @@ static inline void __free_one_page(struct page *page,
>  		int migratetype, fpi_t fpi_flags)
>  {
>  	struct capture_control *capc = task_capc(zone);
> -	unsigned long buddy_pfn;
> +	unsigned long buddy_pfn = 0;
>  	unsigned long combined_pfn;
>  	struct page *buddy;
>  	bool to_tail;
> -- 
> 2.23.0
> 

-- 
Oscar Salvador
SUSE Labs
