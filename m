Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858A7682FD5
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 15:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbjAaOyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 09:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbjAaOyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 09:54:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329774EC7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 06:54:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C277461549
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 14:54:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD19C433D2;
        Tue, 31 Jan 2023 14:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675176875;
        bh=LkTpjPaCa+ALHaNDDa63BHYDcfbV54QQXWyMOfgVUK8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CJz47aPty2hMzTN8JvtOJOpOwVkwUGF4Me2UKY8wa0UIcbrwQIACmBSupaWHC2lAU
         2tBqRRcVzblq0Wy4c1TyQ6bA838hHnemR/vdsOJ0legWxJUQawfZiYdA3cDB7v1HWb
         bOdtK8MMg2diZYZT7PhbOQGqW3RWmwK6KFq53cjo=
Date:   Tue, 31 Jan 2023 15:54:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gavin Shan <gshan@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, david@redhat.com,
        osalvador@suse.de, rafael@kernel.org, shan.gavin@gmail.com
Subject: Re: [PATCH v2] drivers/base/memory: Use array to show memory block
 state
Message-ID: <Y9krqMeponUIy/3l@kroah.com>
References: <20230120233814.368803-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120233814.368803-1-gshan@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 21, 2023 at 07:38:14AM +0800, Gavin Shan wrote:
> Use an array to show memory block state from '/sys/devices/system/
> memory/memoryX/state', to simplify the code.

But does it really?

Now you have an implicit binding between the order of this specific
string array and an enumerated type that is defined in some other
location.

This makes any future changes really really hard to determine that you
got this correct.

Besides, WARN_ON()
> is removed since the warning can be caught by the return value,
> which is "ERROR-UNKNOWN-%ld\n". A system reboot caused by WARN_ON()
> is definitely unexpected as Greg mentioned.
> 
> No functional change intended.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
> v2: Drop WARN_ON()					(Greg)
> ---
>  drivers/base/memory.c | 25 ++++++-------------------
>  1 file changed, 6 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index b456ac213610..0fdacdc79806 100644
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
> +	if (mem->state >= ARRAY_SIZE(mem_state_str) ||
> +	    !mem_state_str[mem->state])
>  		return sysfs_emit(buf, "ERROR-UNKNOWN-%ld\n", mem->state);
> -	}
>  
> -	return sysfs_emit(buf, "%s\n", output);
> +	return sysfs_emit(buf, "%s\n", mem_state_str[mem->state]);

Overall, the current code is simpler and easier to maintain and
understand over time.  You don't have to mess with an array length, or
anything else like that.

I'm all for removing the WARN_ON() if you want to do that, but I think
this is a regression in the ability to maintain this code for the next
40+ years, sorry.

greg k-h
