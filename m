Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A48E74D3E7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjGJKwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjGJKwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:52:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F016518C
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 03:52:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 734531FEBB;
        Mon, 10 Jul 2023 10:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1688986338; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BgqfV8AxMrOa+ZUfGi45FJ2mmGbR/B2qt4snvYgTU68=;
        b=dI2+m/Eif/cqR9elAlggzi63z+6kpGiYIJnpcn8uGHobiw5kkab5A/h/gqdIzfMZqxwDTX
        ySzUG2zcLd7x/DUn2Mt/ma3GKrjr1KMKGx38ZYK+nbHkFw6T1ER2tg6KO8i4Ay+A1H8lgQ
        DsWXeeNDO18QNWYrw7Yi5vMpRZzIl6o=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 51ABD1361C;
        Mon, 10 Jul 2023 10:52:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YsyLEeLiq2RYUAAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 10 Jul 2023 10:52:18 +0000
Date:   Mon, 10 Jul 2023 12:52:17 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc:     minchan@kernel.org, senozhatsky@chromium.org, david@redhat.com,
        yosryahmed@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] zram: charge the compressed RAM to the page's
 memcgroup
Message-ID: <ZKvi4ZvhQaIFtSvg@dhcp22.suse.cz>
References: <20230707044707.1169285-1-hezhongkun.hzk@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707044707.1169285-1-hezhongkun.hzk@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 07-07-23 12:47:07, Zhongkun He wrote:
[...]
> @@ -1692,11 +1725,21 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
>  
>  	zs_unmap_object(zram->mem_pool, handle_new);
>  
> +	/*
> +	 * Recompress will reclaim some memory, so we set the reclaim
> +	 * flag in order to charge comp_len_new successfully.
> +	 */
> +	noreclaim_flag = memalloc_noreclaim_save();
> +	objcg  = zram_get_obj_cgroup(zram, index);
> +	obj_cgroup_get(objcg);
>  	zram_free_page(zram, index);
> +	obj_cgroup_charge_zram(objcg, GFP_KERNEL, comp_len_new);

AFAICS your obj_cgroup_charge_zram doesn't have gfp argument.

Anyway, memalloc_noreclaim_save is an abuse IMHO (the primary purpose of
the flag is to prevent recursion into the memory reclaim). Do you really
can not perform any memory recalim to trigger to free up some memory if
the memcg is at the hard limit boundary?

> +	zram_set_obj_cgroup(zram, index, objcg);
>  	zram_set_handle(zram, index, handle_new);
>  	zram_set_obj_size(zram, index, comp_len_new);
>  	zram_set_priority(zram, index, prio);
>  
> +	memalloc_noreclaim_restore(noreclaim_flag);
>  	atomic64_add(comp_len_new, &zram->stats.compr_data_size);
>  	atomic64_inc(&zram->stats.pages_stored);
>  
-- 
Michal Hocko
SUSE Labs
