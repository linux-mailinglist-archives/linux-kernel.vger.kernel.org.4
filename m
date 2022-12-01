Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7AEB63EBAD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 09:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiLAI5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 03:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiLAI5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 03:57:41 -0500
X-Greylist: delayed 1716 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 01 Dec 2022 00:57:32 PST
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F00E7;
        Thu,  1 Dec 2022 00:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
        s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=INyxVWTl5V40Q4m8iuk6nyPL6/SVXAaVTfMABtgODPU=; b=rtDaLkzT4z+MKduPKz0zQkPZRM
        HOkXBiv54Lmek4TrfuSnFPduUbrMCNuJNwDJ8/7X7LU+wOJPdb7E0HO7aZLxVidAol4uUyRmShkdP
        SwkR6K6VlwZ5ycDUR/4GyXuTFoE5tV6wICR67XkwHzvIhziWbmFxavkSE0NwGl/cXmPAeDGIHqtSY
        JcinySJ3nzMlxkD1Z2GY/S5bTNxIfF47mPMFivIdDn2VCPtfbHd8faQb8hGO1uozAvPYaYd1FgFnk
        R+m5se88hCaAEWpt5S2JalLCq7gkPom9hti4YVk27Mt99bpGk3ceHxXUk9jb6EF3BTdJeOZ9JP25q
        iEKRznkQ==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=[192.168.1.10])
        by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <cyndis@kapsi.fi>)
        id 1p0eIv-0044k7-K5; Thu, 01 Dec 2022 09:48:21 +0200
Message-ID: <e46598e5-d680-5ae3-3e4a-ec6e5be5090b@kapsi.fi>
Date:   Thu, 1 Dec 2022 09:48:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] gpu: host1x: Remove redundant null checks before kfree
Content-Language: en-US
To:     zys.zljxml@gmail.com, thierry.reding@gmail.com, airlied@gmail.com,
        daniel@ffwll.ch, sumit.semwal@linaro.org, christian.koenig@amd.com
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org,
        Yushan Zhou <katrinzhou@tencent.com>
References: <20221201015522.38163-1-zys.zljxml@gmail.com>
From:   Mikko Perttunen <cyndis@kapsi.fi>
In-Reply-To: <20221201015522.38163-1-zys.zljxml@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/22 03:55, zys.zljxml@gmail.com wrote:
> From: Yushan Zhou <katrinzhou@tencent.com>
> 
> Fix the following coccicheck warning:
> ./drivers/gpu/host1x/fence.c:97:2-7: WARNING:
> NULL check before some freeing functions is not needed.
> 
> Signed-off-by: Yushan Zhou <katrinzhou@tencent.com>
> ---
>   drivers/gpu/host1x/fence.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/host1x/fence.c b/drivers/gpu/host1x/fence.c
> index ecab72882192..05b36bfc8b74 100644
> --- a/drivers/gpu/host1x/fence.c
> +++ b/drivers/gpu/host1x/fence.c
> @@ -93,8 +93,7 @@ static void host1x_syncpt_fence_release(struct dma_fence *f)
>   {
>   	struct host1x_syncpt_fence *sf = to_host1x_fence(f);
>   
> -	if (sf->waiter)
> -		kfree(sf->waiter);
> +	kfree(sf->waiter);
>   
>   	dma_fence_free(f);
>   }

I disagree with this coccinelle rule; I think it obfuscates from the 
reader the fact that the pointer could be NULL.

Mikko
