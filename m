Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB4E725B5D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 12:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238841AbjFGKQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 06:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238843AbjFGKQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 06:16:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C419C1BD0
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 03:16:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4BC0B1FDAE;
        Wed,  7 Jun 2023 10:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686132967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OtOZgD95z/IBl7SqKk0BG6TOYMfHhxxJyQnJ1HGyzbM=;
        b=UldiIttJJHN/rLQo5Q+nk5SR9MQ1ebiuV5HR+bfplwSBDy3eEkESROO/aI426UWBykaMW/
        77G9jOiMKjIxVIVc+EDuXjrq943SMpFUMjQxMceAkyrN8eO6EF6LWVwLEZiF8S01JoAOmS
        iHaCxXxZb3oyxZW/4XDnafFP+JdFIqM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3C99713776;
        Wed,  7 Jun 2023 10:16:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +uohDudYgGTTeQAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 07 Jun 2023 10:16:07 +0000
Date:   Wed, 7 Jun 2023 12:16:06 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     rppt@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mm_init.c: add debug messsge for dma zone
Message-ID: <ZIBY5niJ/7vvwdHC@dhcp22.suse.cz>
References: <20230607090734.1259-1-haifeng.xu@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607090734.1259-1-haifeng.xu@shopee.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 07-06-23 09:07:34, Haifeng Xu wrote:
> If freesize is less than dma_reserve, print warning message to report
> this case.

Why?

> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> ---
>  mm/mm_init.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 232efac9a929..9a9d6a52471c 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1561,9 +1561,14 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
>  		}
>  
>  		/* Account for reserved pages */
> -		if (j == 0 && freesize > dma_reserve) {
> -			freesize -= dma_reserve;
> -			pr_debug("  %s zone: %lu pages reserved\n", zone_names[0], dma_reserve);
> +		if (j == 0) {
> +			if (freesize >= dma_reserve) {
> +				freesize -= dma_reserve;
> +				pr_debug("  %s zone: %lu pages reserved\n",
> +					 zone_names[0], dma_reserve);
> +			} else
> +				pr_warn("  %s zone: %lu reserved pages exceeds freesize %lu\n",
> +					zone_names[0], dma_reserve, freesize);
>  		}
>  
>  		if (!is_highmem_idx(j))
> -- 
> 2.25.1

-- 
Michal Hocko
SUSE Labs
