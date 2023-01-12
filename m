Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828F56685A1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 22:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjALVi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 16:38:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240555AbjALVhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 16:37:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024522039
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 13:30:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D80FB8202F
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 21:29:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B63BC433D2;
        Thu, 12 Jan 2023 21:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1673558998;
        bh=SVWWSvjsAAyEzqQR/A/gO5W9iuwYkJ4nSovwV47+0uk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HYXfx1SQhw0AmoHz5uP6xzwI0wXN7BZnMxVu7zuJRoTIbYkejxwH9Xs1ISqr19wpx
         X3fiNsirE6Q1n6BwF58x0f47S5o2kQS3fOGxfR2z4zI64PDMM7sB89khmwEPQy6iqu
         OIe9a8ZyzyDY1d3zxK59+Kk9b/cKSzTCavw9ClEs=
Date:   Thu, 12 Jan 2023 13:29:57 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     mhocko@suse.com, vbabka@suse.cz, david@redhat.com,
        quic_charante@quicinc.com, lizhe.67@bytedance.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] mm/page_ext: Do not allocate space for
 page_ext->flags if not needed
Message-Id: <20230112132957.6cb97c2afad17cdeb06fcd10@linux-foundation.org>
In-Reply-To: <20230112153348.3202173-1-pasha.tatashin@soleen.com>
References: <20230112153348.3202173-1-pasha.tatashin@soleen.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jan 2023 15:33:48 +0000 Pasha Tatashin <pasha.tatashin@soleen.com> wrote:

> There is 8 byte page_ext->flags field allocated per page whenever
> CONFIG_PAGE_EXTENSION is enabled. However, not every user of page_ext
> uses flags. Therefore, check whether flags is needed at least by one
> user and if so allocate space for it.
> 
> For example when page_table_check is enabled, on a machine with 128G
> of memory before the fix:
> 
> [    2.244288] allocated 536870912 bytes of page_ext
> after the fix:
> [    2.160154] allocated 268435456 bytes of page_ext
> 

Looks nice.

Does it work correctly with early_page_ext=1?

> --- a/include/linux/page_ext.h
> +++ b/include/linux/page_ext.h
> @@ -12,10 +12,14 @@ struct page_ext_operations {
>  	size_t size;
>  	bool (*need)(void);
>  	void (*init)(void);
> +	bool using_shared_ext_flags;
>  };

Seems overly complicated.  Can we change the three early-init
functions such as setup_early_page_ext() to simply set some global bool
flag?

>  #endif
>  };
>  
> -unsigned long page_ext_size = sizeof(struct page_ext);
> +unsigned long page_ext_size;
>  
>  static unsigned long total_usage;
>  static struct page_ext *lookup_page_ext(const struct page *page);
> @@ -105,6 +106,15 @@ static bool __init invoke_need_callbacks(void)
>  	int entries = ARRAY_SIZE(page_ext_ops);
>  	bool need = false;
>  
> +	for (i = 0; i < entries; i++) {
> +		if (page_ext_ops[i]->need && page_ext_ops[i]->need()) {

I don't think this (or the below) need to check for ->need==NULL?

> +			if (page_ext_ops[i]->using_shared_ext_flags) {
> +				page_ext_size = sizeof(struct page_ext);
> +				break;
> +			}
> +		}
> +	}
> +
>  	for (i = 0; i < entries; i++) {
>  		if (page_ext_ops[i]->need && page_ext_ops[i]->need()) {
>  			page_ext_ops[i]->offset = page_ext_size;

