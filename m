Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832205B41AC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 23:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbiIIVsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 17:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiIIVsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 17:48:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0B4F5C68
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 14:48:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E8A4620F0
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 21:48:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A54BC433D7;
        Fri,  9 Sep 2022 21:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1662760094;
        bh=hEOXKaPCCMlJFfFySrWldLHHm+rdG6JT30zpxCwnHkI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SNMenwMrzt4arH8ZWHYQ2CdAa6x8g5prdgww0FWZWKygDMZsdNQrRSbCsxJr0k4O3
         mht3Y3y1oLK6l9HgeBtdMAJeuS8bvmoOrAa17iAOaXN5BFFim29KMKJiGc+FUJI3Dj
         PSWJmv8XWPFXldKGgpbKrE0Y6xly5owTgwx7AlDg=
Date:   Fri, 9 Sep 2022 14:48:13 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     wuchi <wuchi.zero@gmail.com>
Cc:     hch@lst.de, axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] relay: use kvcalloc to alloc page array in
 relay_alloc_page_array
Message-Id: <20220909144813.bb6d71b9de0206cf7fb62d22@linux-foundation.org>
In-Reply-To: <20220909101025.82955-1-wuchi.zero@gmail.com>
References: <20220909101025.82955-1-wuchi.zero@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  9 Sep 2022 18:10:25 +0800 wuchi <wuchi.zero@gmail.com> wrote:

> The kvcalloc is safer because it will check the integer overflows,
> and using it will simple the logic of allocation size.
> 
> ...
>
> --- a/kernel/relay.c
> +++ b/kernel/relay.c
> @@ -60,10 +60,7 @@ static const struct vm_operations_struct relay_file_mmap_ops = {
>   */
>  static struct page **relay_alloc_page_array(unsigned int n_pages)
>  {
> -	const size_t pa_size = n_pages * sizeof(struct page *);
> -	if (pa_size > PAGE_SIZE)
> -		return vzalloc(pa_size);
> -	return kzalloc(pa_size, GFP_KERNEL);
> +	return kvcalloc(n_pages, sizeof(struct page *), GFP_KERNEL);
>  }

It isn't really equivalent because kvcalloc() may attempt a large
kmalloc() request, whereas the current relay_alloc_page_array()
implementation avoids this by choosing vmalloc() instead.

But I doubt if it matters - kvcalloc()->kvmalloc_node() does take some
care to prevent that large kmalloc() request from being too disruptive.

