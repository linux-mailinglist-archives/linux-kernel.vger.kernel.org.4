Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC97700010
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 07:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239958AbjELF4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 01:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239923AbjELF4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 01:56:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87BC4ED7
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 22:56:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E76164D2C
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 05:56:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE6BFC4339B;
        Fri, 12 May 2023 05:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683870963;
        bh=zFLjxJcoqygPEa3FU3vOWPjgI0sHhm93uxHO43ygYeo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AZAvrCPitPX7thRA60FDRBXcj0NX4oJG3KZPQwQKlwhu1nwYHP3lix77osMKiaXXj
         h8EsKY3Emo4ahgnHmhqhEj20EZLKcP9qy7HASmMbPYaRHQYb/aru4zixXyKvgKD3QH
         CRek2j1FBMxtWyDeKBrciauu7wmteeM4or6KDUMr6isLXt1z3N+D/HdYuaWi41ZwkS
         031eqbI4S9tdczzdpFfK/mgpuMvjFmIzeSfNUGfVdi21kk+MxSylIQJCZ/iC0TBYZM
         /xbmKHCR9ftWQlsPX/et5mqus0Qslq9BMvOcs9N97ujuAw2fwSaLFdjr4WC6HgoeMU
         C59MxF+s9AwzQ==
Date:   Thu, 11 May 2023 22:56:01 -0700
From:   Mike Rapoport <rppt@kernel.org>
To:     Rick Wertenbroek <rick.wertenbroek@gmail.com>
Cc:     rick.wertenbroek@heig-vd.ch, David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memory_hotplug: Fix format string in warnings
Message-ID: <20230512055601.GG4135@kernel.org>
References: <20230510090758.3537242-1-rick.wertenbroek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510090758.3537242-1-rick.wertenbroek@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 11:07:57AM +0200, Rick Wertenbroek wrote:
> The format string in __add_pages and __remove_pages has a typo
> and prints e.g., "Misaligned __add_pages start: 0xfc605 end: #fc609"
> instead of "Misaligned __add_pages start: 0xfc605 end: 0xfc609"
> Fix "#%lx" => "%#lx"
> 
> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  mm/memory_hotplug.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 8e0fa209d533..9061ac69b1b6 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -325,7 +325,7 @@ int __ref __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
>  	}
>  
>  	if (check_pfn_span(pfn, nr_pages)) {
> -		WARN(1, "Misaligned %s start: %#lx end: #%lx\n", __func__, pfn, pfn + nr_pages - 1);
> +		WARN(1, "Misaligned %s start: %#lx end: %#lx\n", __func__, pfn, pfn + nr_pages - 1);
>  		return -EINVAL;
>  	}
>  
> @@ -525,7 +525,7 @@ void __remove_pages(unsigned long pfn, unsigned long nr_pages,
>  	map_offset = vmem_altmap_offset(altmap);
>  
>  	if (check_pfn_span(pfn, nr_pages)) {
> -		WARN(1, "Misaligned %s start: %#lx end: #%lx\n", __func__, pfn, pfn + nr_pages - 1);
> +		WARN(1, "Misaligned %s start: %#lx end: %#lx\n", __func__, pfn, pfn + nr_pages - 1);
>  		return;
>  	}
>  
> -- 
> 2.25.1
> 
> 

-- 
Sincerely yours,
Mike.
