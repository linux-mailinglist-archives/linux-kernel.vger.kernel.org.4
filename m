Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1C87199E5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbjFAKf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbjFAKfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:35:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D1C198
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 03:35:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 863DA6431B
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 10:35:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C73EDC433D2;
        Thu,  1 Jun 2023 10:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685615717;
        bh=l5bD7Dw9Fc8OpUoTHLgbC9kihcsJkzcjiGlkKrzTFMY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h8srvUvZQUPkHk6E9WokZrW+MKD3+lnuiqrI3fTl/exy9DaKlr5093CjLq6coNWy9
         8dnNrmE8lxyFIpSqtLphg39FsOa6YcDWe9/vsW1f+E5LUpe8EZjabFym8Sk5FbTPEC
         4YVN6WT1UbJ0yfXraTC+3NgAOWbIo+vkjvW+AvBwCPm3psZCMDF8ZFgft5LYfIemIH
         yJLL5y/24hy/1BNfN7bb309RTpinf4yaq6G6oVyMjUh5ZPCO2eG2AYtA9rXETx8Uyr
         0pvbADvSgDVcegVaEsA7mapeXITNpdZQAfJ8rd6G0Za8oG3v4+pxMMnAQgFPLmCXSl
         Z8lZQKSSkzqEg==
Date:   Thu, 1 Jun 2023 13:34:50 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     mhocko@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/mm_init.c: move set_pageblock_order() to
 free_area_init()
Message-ID: <20230601103450.GD395338@kernel.org>
References: <20230601063536.26882-1-haifeng.xu@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601063536.26882-1-haifeng.xu@shopee.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 06:35:35AM +0000, Haifeng Xu wrote:
> pageblock_order only needs to be set once, there is no need to
> initialize it in every zone/node.
> 
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  mm/mm_init.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 93821824271a..232efac9a929 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1583,7 +1583,6 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
>  		if (!size)
>  			continue;
>  
> -		set_pageblock_order();
>  		setup_usemap(zone);
>  		init_currently_empty_zone(zone, zone->zone_start_pfn, size);
>  	}
> @@ -1850,6 +1849,8 @@ void __init free_area_init(unsigned long *max_zone_pfn)
>  	/* Initialise every node */
>  	mminit_verify_pageflags_layout();
>  	setup_nr_node_ids();
> +	set_pageblock_order();
> +
>  	for_each_node(nid) {
>  		pg_data_t *pgdat;
>  
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.
