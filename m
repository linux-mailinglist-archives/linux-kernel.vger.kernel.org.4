Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F49873142A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343518AbjFOJhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343502AbjFOJhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:37:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9BC35B5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 02:36:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3384B21A9A;
        Thu, 15 Jun 2023 09:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686821739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d39ZQ9SlNHEIcbFBtB4BFJzLZO0sDtDQiB2wLC4guso=;
        b=Tb1o1o3WzqXIn8H3JgDLPA64csrHcqDrGlZvuMhBscIz8cM/Vm3dSlsN51nkm+Vkw3gG1z
        9K7KWiB8tSHrL/bo3camWIqnhUS8uzlAcSsI+gyehBOh69ev4ycxfEzqoYa1VpR3vtTuHw
        svpjLLUrX5iNcrcDccoocJggOKyRPWA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2637513A47;
        Thu, 15 Jun 2023 09:35:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FkdMCWvbimTMVQAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 15 Jun 2023 09:35:39 +0000
Date:   Thu, 15 Jun 2023 11:35:38 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc:     minchan@kernel.org, senozhatsky@chromium.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] zram: charge the compressed RAM to the page's
 memcgroup
Message-ID: <ZIrbar9yQ6EZ217t@dhcp22.suse.cz>
References: <20230615034830.1361853-1-hezhongkun.hzk@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615034830.1361853-1-hezhongkun.hzk@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 15-06-23 11:48:30, Zhongkun He wrote:
[...]
> @@ -1419,6 +1420,10 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
>  	struct zcomp_strm *zstrm;
>  	unsigned long element = 0;
>  	enum zram_pageflags flags = 0;
> +	struct mem_cgroup *memcg, *old_memcg;
> +
> +	memcg = page_memcg(page);
> +	old_memcg = set_active_memcg(memcg);
>  
>  	mem = kmap_atomic(page);
>  	if (page_same_filled(mem, &element)) {
[...]
> @@ -1470,8 +1475,10 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
>  		handle = zs_malloc(zram->mem_pool, comp_len,
>  				GFP_NOIO | __GFP_HIGHMEM |
>  				__GFP_MOVABLE);
> -		if (IS_ERR_VALUE(handle))
> -			return PTR_ERR((void *)handle);
> +		if (IS_ERR_VALUE(handle)) {
> +			ret = PTR_ERR((void *)handle);
> +			goto out;
> +		}
>  
>  		if (comp_len != PAGE_SIZE)
>  			goto compress_again;

I am not really deeply familiar with zram implementation nor usage but
how is the above allocation going to be charged without __GFP_ACCOUNT in
the gfp mask?

Also what exactly is going to happen for the swap backed by the zram
device? Your memcg might be hitting the hard limit and therefore
swapping out. Wouldn't zs_malloc fail very likely under that condition
making the swap effectively unusable?
-- 
Michal Hocko
SUSE Labs
