Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F80D705E98
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 06:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbjEQEN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 00:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjEQENy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 00:13:54 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972E7A0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 21:13:53 -0700 (PDT)
Received: from [192.168.1.106] (unknown [103.86.18.166])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6165C4A9;
        Wed, 17 May 2023 06:13:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1684296818;
        bh=lyeq9xynt3Pmu7ryH7FI2XE8pDgGlxYkbKBvNQwzJOo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TMpI/uGHr2RyPS32+DR1zOzffsRBHj+IZoAkuO4+uvMNGPAORrNmvct5wbWJXvlJh
         1w+yBRuOxPrBcjGKmvav5L354ocURBAn6F6NFYaSlI4dJGNuTMqFK4Tnu3R9Aa6gWN
         fw4S4WlnrKvQrYuqnJrolhfbMNo/ehkaUFZzPyJY=
Message-ID: <d73903db-2ab0-2093-d34e-11a5e7c579f6@ideasonboard.com>
Date:   Wed, 17 May 2023 09:43:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] staging: vchiq_arm: mark vchiq_platform_init() static
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Adrien Thierry <athierry@redhat.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Peter Zijlstra <peterz@infradead.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230516202603.560554-1-arnd@kernel.org>
From:   Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <20230516202603.560554-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 5/17/23 1:55 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> This function has no callers from other files, and the declaration
> was removed a while ago, causing a W=1 warning:
>
> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:465:5: error: no previous prototype for 'vchiq_platform_init'
>
> Marking it static solves this problem but introduces a new warning
> since gcc determines that 'g_fragments_base' is never initialized
> in some kernel configurations:
>
> In file included from include/linux/string.h:254,
>                   from include/linux/bitmap.h:11,
>                   from include/linux/cpumask.h:12,
>                   from include/linux/mm_types_task.h:14,
>                   from include/linux/mm_types.h:5,
>                   from include/linux/buildid.h:5,
>                   from include/linux/module.h:14,
>                   from drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:8:
> In function 'memcpy_to_page',
>      inlined from 'free_pagelist' at drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:433:4:
> include/linux/fortify-string.h:57:33: error: argument 2 null where non-null expected [-Werror=nonnull]
> include/linux/highmem.h:427:9: note: in expansion of macro 'memcpy'
>    427 |         memcpy(to + offset, from, len);
>        |         ^~~~~~
>
> Add a NULL pointer check for this in addition to the static annotation
> to avoid both.
>
> Fixes: 89cc4218f640 ("staging: vchiq_arm: drop unnecessary declarations")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Umang Jain <umang.jain@ideasonboard.com>

> ---
>   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> index 90a3958d1f29..aa2313f3bcab 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> @@ -415,7 +415,7 @@ free_pagelist(struct vchiq_instance *instance, struct vchiq_pagelist_info *pagel
>   	pagelistinfo->scatterlist_mapped = 0;
>   
>   	/* Deal with any partial cache lines (fragments) */
> -	if (pagelist->type >= PAGELIST_READ_WITH_FRAGMENTS) {
> +	if (pagelist->type >= PAGELIST_READ_WITH_FRAGMENTS && g_fragments_base) {
>   		char *fragments = g_fragments_base +
>   			(pagelist->type - PAGELIST_READ_WITH_FRAGMENTS) *
>   			g_fragments_size;
> @@ -462,7 +462,7 @@ free_pagelist(struct vchiq_instance *instance, struct vchiq_pagelist_info *pagel
>   	cleanup_pagelistinfo(instance, pagelistinfo);
>   }
>   
> -int vchiq_platform_init(struct platform_device *pdev, struct vchiq_state *state)
> +static int vchiq_platform_init(struct platform_device *pdev, struct vchiq_state *state)
>   {
>   	struct device *dev = &pdev->dev;
>   	struct vchiq_drvdata *drvdata = platform_get_drvdata(pdev);

