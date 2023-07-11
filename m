Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C3A74F7EB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 20:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbjGKSTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 14:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbjGKSTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 14:19:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB12E0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 11:19:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 548FB615A5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 18:19:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0BB5C433C7;
        Tue, 11 Jul 2023 18:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689099574;
        bh=c6CJn4wg4GYJHZ50FiH/PbN3lJ3s+Z+GdzWo9pTlDx8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n36mkgn0OeHFlLMol5tC9PRLk/C5T6N2niyhSN+dd2iTX1aXrVkks/bVZ8PEOadak
         uD+7JcShcLfXbjb8bUhRGZh2rKDSM3plZMh4FS+UXIXkdoJjjuGpdUp0aNhy2FFkt5
         ry1poKJTTz0eSo90uDE7p4VT3mG4S//TAlCPKnAX0my/Iah3fhiKK5hL58JSTqawKF
         67/9LUASchfzRWhyT5q6D36h+7b6TW4Rwf83tMuIBl69b7390RSOz4qEtIzpbj0pSD
         0nvwUpE8iryzBANK8ZoA/QGAk4zb+na6epCXcOsHEC3odwyNZIjun4bmkuPa7ml9Ap
         GwzrRi0mb31WA==
Date:   Tue, 11 Jul 2023 21:19:24 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Haifeng Xu <haifeng.xu@shopee.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mm_init.c: mark check_for_memory() as __init
Message-ID: <20230711181924.GB1901145@kernel.org>
References: <20230710093750.1294-1-haifeng.xu@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710093750.1294-1-haifeng.xu@shopee.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 09:37:50AM +0000, Haifeng Xu wrote:
> The only caller of check_for_memory() is free_area_init(), which
> is annotated with __init, so it should be safe to also mark the
> former as __init.
> 
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  mm/mm_init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index a1963c3322af..a313d1828a6c 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1737,7 +1737,7 @@ static void __init free_area_init_node(int nid)
>  }
>  
>  /* Any regular or high memory on that node ? */
> -static void check_for_memory(pg_data_t *pgdat)
> +static void __init check_for_memory(pg_data_t *pgdat)
>  {
>  	enum zone_type zone_type;
>  
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.
