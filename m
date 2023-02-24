Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7156A202B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 18:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjBXRBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 12:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjBXRBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 12:01:38 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A4212848;
        Fri, 24 Feb 2023 09:01:37 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id t14so12115106ljd.5;
        Fri, 24 Feb 2023 09:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NlO6qujDPB77Y31VWYo7tRPTlLf3mHauKGskp4pl9/0=;
        b=eHpoOggr/bZZgurpr3FogiReOZGIkbhEdP5fZDvrY1D+Qx6AIOB6cDGj00ApCsbjCp
         M8MyMAy5VqfU9btKkE7/jjhtLTVX0LYDhNWFvuVPT4Cdcwe3bRcGdPbk7SOFpws1+6LL
         wztkRAn1s+p2FSPqPnPKtOQYjnBdpuUvITYfHVd1OaTiUEl6n8vldFqrFE2beGyc+ujo
         xqYKserc7fLSnMaXVUfbP1kE8gkL4qpWfd+dnJ0IyiDZJCRtcWaZIpuQOJ1wCz5Mg6FJ
         grON8VYxkxNo1jFPCbPgfB4EckHmUPK15OTI3uOF2x3Jrmwk6v9Tee57KgLv9zzvK/C1
         ovqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NlO6qujDPB77Y31VWYo7tRPTlLf3mHauKGskp4pl9/0=;
        b=Fdz0zoB9W8qgXuCzeVm+VTIuInL2u81i9zfpg0V6dpfKjAceOPsvSUHP7Y2v0MOui1
         A1sZ+biiZkd5of2jwVx8eO/ZFdUJ2YYOSBJ/L6jfnRCi/+ARAajO6ui+fsnct2cYCjzr
         AodEnqngILbUJgCl3tOgvFFmjE/Nlpv4d+uGW19MYXkHPJ8RcCLdm8tfpuDxrGeeBX8D
         bGXIXS5a6k1aCCiPZYdELhPTEhZ1s50y9UcSq4MRgw86+/epLGz+ocm+fk412el4gPZO
         WTn0/5U5x3qi1BiGtOMtOXLaifG6w6/N+jHqdQ+XRPwziWT/7Ym8YAkW7rI98Ej/6ZDQ
         EHLw==
X-Gm-Message-State: AO0yUKXQRh/wsHIvKFTYCvAyXXNOFF5L4PAFvwk7KKRTsQImo/ucqpcT
        qHSc4QHFi1aN52e6qk7JSzgvbxfRnSQ=
X-Google-Smtp-Source: AK7set+cYAr6oqGTZTnGan7xrGHaAkumIy5yUb8MrPSY6P6ElKmBJvBh0FD1AXceygKfU6HORPAQMg==
X-Received: by 2002:a2e:9d48:0:b0:294:6fc5:a3e9 with SMTP id y8-20020a2e9d48000000b002946fc5a3e9mr5454982ljj.6.1677258095112;
        Fri, 24 Feb 2023 09:01:35 -0800 (PST)
Received: from [192.168.1.103] ([178.176.72.18])
        by smtp.gmail.com with ESMTPSA id b17-20020a2eb911000000b00295a5fb6d9fsm239811ljb.23.2023.02.24.09.01.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 09:01:34 -0800 (PST)
Subject: Re: [PATCH v2] usb: gadget: udc: replace kzalloc with devm_kzalloc in
 mv_udc_probe and add a check for this allocation.
To:     void0red <void0red@gmail.com>, mudongliangabcd@gmail.com
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <CAD-N9QVTxUSiCnprnXw=i4NVWbKFg2dZrkB0rqV2E4jzPeXAeA@mail.gmail.com>
 <20230224141101.73-1-void0red@gmail.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <17383b82-5e1c-837c-d05f-67a3a024cace@gmail.com>
Date:   Fri, 24 Feb 2023 20:01:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20230224141101.73-1-void0red@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 2/24/23 5:11 PM, void0red wrote:

> From: Kang Chen <void0red@gmail.com>
> 
> This driver uses the unified memory management api, so replace
> kzalloc with devm_kzalloc to avoid a memory leak and add a check
> for this allocation.

   IMHO these are 2 different problems and deserve its own patch
fixing it...

> Reported-by: eriri <1527030098@qq.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217081
> 
> Signed-off-by: Kang Chen <void0red@gmail.com>
> ---
>  drivers/usb/gadget/udc/mv_udc_core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/udc/mv_udc_core.c b/drivers/usb/gadget/udc/mv_udc_core.c
> index b397f3a84..08474c08d 100644
> --- a/drivers/usb/gadget/udc/mv_udc_core.c
> +++ b/drivers/usb/gadget/udc/mv_udc_core.c
> @@ -2229,7 +2229,11 @@ static int mv_udc_probe(struct platform_device *pdev)
>  	INIT_LIST_HEAD(&udc->status_req->queue);
>  
>  	/* allocate a small amount of memory to get valid address */
> -	udc->status_req->req.buf = kzalloc(8, GFP_KERNEL);
> +	udc->status_req->req.buf = devm_kzalloc(&pdev->dev, 8, GFP_KERNEL);
> +	if (!udc->status_req->req.buf) {
> +		retval = -ENOMEM;
> +		goto err_destroy_dma;
> +	}
>  	udc->status_req->req.dma = DMA_ADDR_INVALID;
>  
>  	udc->resume_state = USB_STATE_NOTATTACHED;

MBR, Sergey
