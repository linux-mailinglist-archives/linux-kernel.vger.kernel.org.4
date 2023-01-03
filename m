Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B523B65BB90
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 09:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236944AbjACIDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 03:03:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236729AbjACIDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 03:03:39 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D105D1D8
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 00:03:36 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B99C234367;
        Tue,  3 Jan 2023 08:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1672733014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/Ulj1KdXgOhz3mFb7YsOBfrLohsk+mOcfQTC8VIBIyY=;
        b=A6ezqKSaMS5FkyAjD92Oqzp58vLYYNOst800s7iKTLxeX/W4EsZZj7Nh/qSNHuIdbQw+8v
        UVQ+ITlICX/hTuNaWhltgnIb9FvIy7AYAYqlXIAYs3WxNcImmf0lJnQEjkd2urmE5lfUG/
        PyH7UWhKQGzTcA2wqg0h0mFWznyD8LE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 99742139F1;
        Tue,  3 Jan 2023 08:03:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id a1ktI1bhs2O0eQAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 03 Jan 2023 08:03:34 +0000
Date:   Tue, 3 Jan 2023 09:03:33 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Jaewon Kim <jaewon31.kim@samsung.com>
Cc:     riel@redhat.com, redkoi@virtuozzo.com, akpm@linux-foundation.org,
        hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jaewon31.kim@gmail.com
Subject: Re: [PATCH] page_alloc: avoid the negative free for meminfo available
Message-ID: <Y7PhVaqhIzs8e8mU@dhcp22.suse.cz>
References: <CGME20230103072834epcas1p3441ef50a6cc26ac48d184f1244b76a0e@epcas1p3.samsung.com>
 <20230103072807.19578-1-jaewon31.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103072807.19578-1-jaewon31.kim@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 03-01-23 16:28:07, Jaewon Kim wrote:
> The totalreserve_pages could be higher than the free because of
> watermark high or watermark boost. Handle this situation and fix it to 0
> free size.

What is the actual problem you are trying to address by this change?

> Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
> ---
>  mm/page_alloc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 218b28ee49ed..e510ae83d5f3 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5948,6 +5948,8 @@ long si_mem_available(void)
>  	 * without causing swapping or OOM.
>  	 */
>  	available = global_zone_page_state(NR_FREE_PAGES) - totalreserve_pages;
> +	if (available < 0)
> +		available = 0;
>  
>  	/*
>  	 * Not all the page cache can be freed, otherwise the system will
> -- 
> 2.17.1

-- 
Michal Hocko
SUSE Labs
