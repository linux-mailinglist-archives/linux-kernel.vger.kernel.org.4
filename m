Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B285E63EC9F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 10:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiLAJiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 04:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiLAJiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 04:38:16 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9378527B1B;
        Thu,  1 Dec 2022 01:38:15 -0800 (PST)
Received: from [192.168.0.192] (unknown [194.146.248.75])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: andrzej.p)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1092966025DF;
        Thu,  1 Dec 2022 09:38:14 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669887494;
        bh=lRVFj8y7/3qwG7xPZn/qzQNq+VLvvEurqAoJ8cB2Ans=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RrNhisTgtqv5meVQ5yhJs4NsLxRnZ1R9V6Oy+XTOySEufKylaThlPfXIfogc2/mRO
         5mr5pN2yYJQCRVjj6taHE9bq70vQAKw7x+yLTKRrX03aLv2tZct/Q38OHlkgqT4k1t
         IgEcRzsINzWpkkgjn3b9Rp+RZomnLkF8xPO8zyjfNIHEipXyo1HXux3AQe9HIFl9NE
         Qmq+x9StJZCTIlOAKwXfCmWSWeMfVkY5VQ6rw4XTyeaXcF3xtCNJk91qYXMsT5+Ew3
         hi6P9o/AR8WQSAMUYOtbufywXtZ57tHYBGFUhYarwR6j9ZvUHhuyrp9MYSl9TF0JYH
         IO4dAhoE5PbyQ==
Message-ID: <c21591d1-7462-974e-3171-e23a0fbd7ddb@collabora.com>
Date:   Thu, 1 Dec 2022 10:38:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] usb: fotg210-udc: fix potential memory leak in
 fotg210_udc_probe()
To:     Yi Yang <yiyang13@huawei.com>, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221130101251.245399-1-yiyang13@huawei.com>
Content-Language: en-US
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <20221130101251.245399-1-yiyang13@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yi Yang,

You can make your patch also simplify the code.

Earlier, there's

	ret = -ENOMEM;

	/* initialize udc */
	fotg210 = kzalloc(sizeof(struct fotg210_udc), GFP_KERNEL);
	if (fotg210 == NULL)
		goto err;

and the code at the "err" label before your changes merely returns "ret".
Instead of "goto err" return -ENOMEM can be used. This, in turn,
eliminates the ret = -ENOMEM assignment. Furthermore, after applying your
patch as-is, the said "goto err;" will result with kfree(NULL) which is safe,
but unnecessary.

If you include the above changes you can add my

Reviewed-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>

W dniu 30.11.2022 o 11:12, Yi Yang pisze:
> In fotg210_udc_probe(), if devm_clk_get() or clk_prepare_enable()
> fails, 'fotg210' will not be freed, which will lead to a memory leak.
> Fix it by moving kfree() to a proper location.
> 
> Fixes: 718a38d092ec ("fotg210-udc: Handle PCLK")
> Signed-off-by: Yi Yang <yiyang13@huawei.com>
> ---
>   drivers/usb/fotg210/fotg210-udc.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/fotg210/fotg210-udc.c b/drivers/usb/fotg210/fotg210-udc.c
> index b9ea6c6d931c..a366d69c1818 100644
> --- a/drivers/usb/fotg210/fotg210-udc.c
> +++ b/drivers/usb/fotg210/fotg210-udc.c
> @@ -1178,7 +1178,7 @@ int fotg210_udc_probe(struct platform_device *pdev)
>   		ret = clk_prepare_enable(fotg210->pclk);
>   		if (ret) {
>   			dev_err(dev, "failed to enable PCLK\n");
> -			return ret;
> +			goto err;
>   		}
>   	} else if (PTR_ERR(fotg210->pclk) == -EPROBE_DEFER) {
>   		/*
> @@ -1302,8 +1302,7 @@ int fotg210_udc_probe(struct platform_device *pdev)
>   	if (!IS_ERR(fotg210->pclk))
>   		clk_disable_unprepare(fotg210->pclk);
>   
> -	kfree(fotg210);
> -
>   err:
> +	kfree(fotg210);
>   	return ret;
>   }

