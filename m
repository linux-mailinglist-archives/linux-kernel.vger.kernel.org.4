Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C47675586
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 14:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjATNTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 08:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjATNSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 08:18:35 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72E5C41E7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 05:14:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 82AE1CE285B
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 13:14:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F275C433B3;
        Fri, 20 Jan 2023 13:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674220490;
        bh=l377cVSCj6UHp5jGDRUigM1l/sWippbUo+6Sc1sWSvM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LQHKiHy5wsM0n5EUwROjHeL+qz8bSnTdd8qdv0H+zwJLOOKk75i1BJvpzVyP8/lcx
         BEo1NCP7pIu55J3FNR67skt6txWVcokT/NmCgXAU7yl2hM4SluLRuH0AVWj0k+pTf0
         0XYNSjv/CJ0FK5HvCkECFfCS/cXxKzQieKVkjhJs=
Date:   Fri, 20 Jan 2023 14:14:48 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gavin Shan <gshan@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, david@redhat.com,
        osalvador@suse.de, rafael@kernel.org, shan.gavin@gmail.com
Subject: Re: [PATCH 2/2] drivers/base/memory: Use array to show memory block
 state
Message-ID: <Y8qTyEgc8ih6M+DW@kroah.com>
References: <20230120055727.355483-1-gshan@redhat.com>
 <20230120055727.355483-3-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120055727.355483-3-gshan@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 01:57:27PM +0800, Gavin Shan wrote:
> Use an array to show memory block state from '/sys/devices/system/
> memory/memoryX/state', to simplify the code.
> 
> No functional change intended.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  drivers/base/memory.c | 25 ++++++-------------------
>  1 file changed, 6 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index b456ac213610..9474f25c452c 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -141,28 +141,15 @@ static ssize_t state_show(struct device *dev, struct device_attribute *attr,
>  			  char *buf)
>  {
>  	struct memory_block *mem = to_memory_block(dev);
> -	const char *output;
> +	static const char *const mem_state_str[] = {
> +		NULL, "online", "going-offline", NULL, "offline",
> +	};
>  
> -	/*
> -	 * We can probably put these states in a nice little array
> -	 * so that they're not open-coded
> -	 */
> -	switch (mem->state) {
> -	case MEM_ONLINE:
> -		output = "online";
> -		break;
> -	case MEM_OFFLINE:
> -		output = "offline";
> -		break;
> -	case MEM_GOING_OFFLINE:
> -		output = "going-offline";
> -		break;
> -	default:
> -		WARN_ON(1);
> +	if (WARN_ON(mem->state >= ARRAY_SIZE(mem_state_str) ||
> +		    !mem_state_str[mem->state]))

Ick, the whole WARN_ON() should just be removed please.  We don't want
to reboot any systems if this changed incorrectly.

Please fix this up to properly handle this and keep going on, don't mess
with WARN_ON() anymore in code that can recover properly.

thanks,

greg k-h
