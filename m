Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F679633271
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 02:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbiKVB4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 20:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiKVB4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 20:56:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBC2643C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 17:56:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F10C6152D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 01:56:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CDDDC433D6;
        Tue, 22 Nov 2022 01:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1669082180;
        bh=JGk0ZxCYS42fSPPpUoBTd3yoEazg4HSkfZ8gjdsUELw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=suWLKTl+EwRj/3rirO4twtMpjXhSrKSOovRtn/X9D4P2KQYm2HqFS6FPdHrSVAy3M
         oBnzNHYoYWO/5h2yVzfsUL61mQ2uEM1nrTgy17XghzfOZbpDpUklxl4+XaPMRiFm0G
         +O5DCgC2zqudAl4TsFQnO10jvW8R6CDL8EMLSdhs=
Date:   Mon, 21 Nov 2022 17:56:19 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Nhat Pham <nphamcs@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zswap: do not allocate from atomic pool
Message-Id: <20221121175619.f38259bac177de86bd9eb558@linux-foundation.org>
In-Reply-To: <20221122013338.3696079-1-senozhatsky@chromium.org>
References: <20221122013338.3696079-1-senozhatsky@chromium.org>
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

On Tue, 22 Nov 2022 10:33:38 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:

> zswap_frontswap_load() should be called from preemptible
> context (we even call mutex_lock() there) and it does not
> look like we need to do GFP_ATOMIC allocaion for temp
> buffer there. Use GFP_KERNEL instead.
> 
> ...
>
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1314,7 +1314,7 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
>  	}
>  
>  	if (!zpool_can_sleep_mapped(entry->pool->zpool)) {
> -		tmp = kmalloc(entry->length, GFP_ATOMIC);
> +		tmp = kmalloc(entry->length, GFP_KERNEL);
>  		if (!tmp) {
>  			ret = -ENOMEM;
>  			goto freeentry;

It seems strange to do

	if (! can sleep)
		do something which can sleep

or am I misreading the intent of zpool_driver.sleep_mapped?  If so,
perhaps some explanatory code comments will help.

