Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF57658A1F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 08:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbiL2Hzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 02:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233097AbiL2HzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 02:55:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DDBF58F
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 23:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672300470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QN4lRYdOBq98VsTNftJwMlcLq/DxQV6xqfwGwYL5iZ0=;
        b=gTVErcnGunw1sW+DFdTh2wx5JfAmMItLQUR9Tmlabw1mn2aG7E/o8tbsyskdBXs8EOTeB/
        ddQmB5hysvXW9LUrVmIg3z+rRJSrOI3cJOwi9z0dSUi9+em91UxJgVqBWAj0/2fcpbECfL
        P5uYxOFNP9o4au7o7QKxDPASsKsuUpc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-361-z4IPGljKOei_SFFomHipjw-1; Thu, 29 Dec 2022 02:54:27 -0500
X-MC-Unique: z4IPGljKOei_SFFomHipjw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2583885C069;
        Thu, 29 Dec 2022 07:54:27 +0000 (UTC)
Received: from localhost (ovpn-12-77.pek2.redhat.com [10.72.12.77])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 661AC2026D4B;
        Thu, 29 Dec 2022 07:54:26 +0000 (UTC)
Date:   Thu, 29 Dec 2022 15:54:22 +0800
From:   Baoquan He <bhe@redhat.com>
To:     lvqian@nfschina.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc.c: Remove function return value
Message-ID: <Y61Hrl43nmg8eclK@MiWiFi-R3L-srv>
References: <20221229071730.174444-1-lvqian@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221229071730.174444-1-lvqian@nfschina.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/29/22 at 03:17pm, lvqian@nfschina.com wrote:
> From: lvqian <lvqian@nfschina.com>
> 
> The return value of this function has no meaning,
> so the original int type is replaced with a void type,
> which reduces the execution time of one return.
> 
> Signed-off-by: lvqian <lvqian@nfschina.com>
> ---
>  mm/page_alloc.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 0745aedebb37..fffe16d854a9 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -828,17 +828,16 @@ static int __init early_debug_pagealloc(char *buf)
>  }
>  early_param("debug_pagealloc", early_debug_pagealloc);
>  
> -static int __init debug_guardpage_minorder_setup(char *buf)
> +static void __init debug_guardpage_minorder_setup(char *buf)
>  {
>  	unsigned long res;
>  
>  	if (kstrtoul(buf, 10, &res) < 0 ||  res > MAX_ORDER / 2) {
>  		pr_err("Bad debug_guardpage_minorder value\n");
> -		return 0;

This could be not right. Please see parse_args(), the returned value is
needed, otherwise you might get stuff you don't want in the switch case
handling.

parse_early_param()
  -->parse_early_options()
     -->parse_args()

> +	} else {
> +		_debug_guardpage_minorder = res;
> +		pr_info("Setting debug_guardpage_minorder to %lu\n", res);
>  	}
> -	_debug_guardpage_minorder = res;
> -	pr_info("Setting debug_guardpage_minorder to %lu\n", res);
> -	return 0;
>  }
>  early_param("debug_guardpage_minorder", debug_guardpage_minorder_setup);
>  
> -- 
> 2.34.1
> 

