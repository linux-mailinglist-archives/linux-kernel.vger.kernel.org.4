Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00EA1635C9D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 13:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbiKWMTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 07:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236921AbiKWMTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 07:19:44 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8703F3FBA4;
        Wed, 23 Nov 2022 04:19:40 -0800 (PST)
Received: from [192.168.0.192] (unknown [194.146.248.75])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: andrzej.p)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6D2606602939;
        Wed, 23 Nov 2022 12:19:38 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669205978;
        bh=mrGhW5OIb3wNDjsqgtt3UhHf3lyuEyBc7ZlUZoa0V/E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hOGs0judkTiQNgmSIP/tKBIX65+2KtWJz97LVEOHGE8FSYvQHu0FmmzLA1PL/0Ayb
         LOSFGWG5XTtskBH3uvvDMuhgoJ+W5sCCrOKlnVVhRVmQr3Fngnwa/RTZOrYGYUhcxA
         jsS06jCGM53wrBUj/Dwyxh8oXZOsDgXmmxGxyDP2qJpkYu2aZF0d5p0UNbqbQ0EbD3
         W4xivFtsG7t4v313HS9mqOXGGMtVggoQ/G2A1qQTouLZye9S3hVtonIEgiO9RZDLUQ
         2HcSKxQgE3es+AYnHLwuIZNxpSt4aNgDflUmr+XorTqQfzcAuD6ukreLh4TrMVc+AP
         Vwlj3iojEUegA==
Message-ID: <aa34a68e-454d-a146-31db-848385960b84@collabora.com>
Date:   Wed, 23 Nov 2022 13:19:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 3/3] usb: gadget: f_hid: tidy error handling in hidg_alloc
Content-Language: en-US
To:     John Keeping <john@metanate.com>, linux-usb@vger.kernel.org
Cc:     Fabien Chouteau <fabien.chouteau@barco.com>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        Felipe Balbi <balbi@ti.com>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>
References: <20221122123523.3068034-1-john@metanate.com>
 <20221122123523.3068034-4-john@metanate.com>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <20221122123523.3068034-4-john@metanate.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W dniu 22.11.2022 o 13:35, John Keeping pisze:
> Unify error handling at the end of the function, reducing the risk of
> missing something on one of the error paths.
> 
> Moving the increment of opts->refcnt later means there is no need to
> decrement it on the error path and is safe as this is guarded by
> opts->lock which is held for this entire section.
> 
> Signed-off-by: John Keeping <john@metanate.com>

Reviewed-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
> ---
>   drivers/usb/gadget/function/f_hid.c | 21 +++++++++++----------
>   1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
> index 6be6009f911e..a8da3b4a2855 100644
> --- a/drivers/usb/gadget/function/f_hid.c
> +++ b/drivers/usb/gadget/function/f_hid.c
> @@ -1269,18 +1269,14 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
>   	opts = container_of(fi, struct f_hid_opts, func_inst);
>   
>   	mutex_lock(&opts->lock);
> -	++opts->refcnt;
>   
>   	device_initialize(&hidg->dev);
>   	hidg->dev.release = hidg_release;
>   	hidg->dev.class = hidg_class;
>   	hidg->dev.devt = MKDEV(major, opts->minor);
>   	ret = dev_set_name(&hidg->dev, "hidg%d", opts->minor);
> -	if (ret) {
> -		--opts->refcnt;
> -		mutex_unlock(&opts->lock);
> -		return ERR_PTR(ret);
> -	}
> +	if (ret)
> +		goto err_unlock;
>   
>   	hidg->bInterfaceSubClass = opts->subclass;
>   	hidg->bInterfaceProtocol = opts->protocol;
> @@ -1291,14 +1287,13 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
>   						 opts->report_desc_length,
>   						 GFP_KERNEL);
>   		if (!hidg->report_desc) {
> -			put_device(&hidg->dev);
> -			--opts->refcnt;
> -			mutex_unlock(&opts->lock);
> -			return ERR_PTR(-ENOMEM);
> +			ret = -ENOMEM;
> +			goto err_put_device;
>   		}
>   	}
>   	hidg->use_out_ep = !opts->no_out_endpoint;
>   
> +	++opts->refcnt;
>   	mutex_unlock(&opts->lock);
>   
>   	hidg->func.name    = "hid";
> @@ -1313,6 +1308,12 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
>   	hidg->qlen	   = 4;
>   
>   	return &hidg->func;
> +
> +err_put_device:
> +	put_device(&hidg->dev);
> +err_unlock:
> +	mutex_unlock(&opts->lock);
> +	return ERR_PTR(ret);
>   }
>   
>   DECLARE_USB_FUNCTION_INIT(hid, hidg_alloc_inst, hidg_alloc);

