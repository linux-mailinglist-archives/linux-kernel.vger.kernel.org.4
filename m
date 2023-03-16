Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838506BD7AA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 18:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjCPR71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 13:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjCPR7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 13:59:23 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC91226C13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 10:59:19 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id h11so1430760ild.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 10:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1678989559; x=1681581559;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kTWTEay1oNqa1NL3FtznR9uLIk7JecmAx4+1EDsbfbw=;
        b=SFD1+I7EALeTtwmdMTIYBtmsyrKi/5S9qK1c2QqwiMZg3uvRuqAg7TOjsqFpudcDMt
         2OI+Kb2Hd+tHhKaa5CAjeedvCLcK7bPGJiCdC66oRxfoawUjxKMiT57fV2k1rMVRI5IP
         cS/Vhx79ow+XX64LQfy64p4FogHzdsc2iyEeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678989559; x=1681581559;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kTWTEay1oNqa1NL3FtznR9uLIk7JecmAx4+1EDsbfbw=;
        b=T7r+zMkHBELaLWi1ly3nYyzDOkFiHv5ejlbQscQSG9jpkyVFsoi8R6Qr10vF6upMRj
         Laqp6EQNEf575POvaEyCE96A88a29mjG6gipRGmaR8o2JMhK8NUATsFN1xIgLtnrKoQC
         Z+vKrpWW7rNKH+i6aDx/lmKni+9lSczFrQtwcYK8GjHhqEwb6SMHF1ultItS3hyeU3CN
         ktt0OcLL/u/5YVpP60Q6fIv0A6QxNh1R6+GEqhe4vbT7dDldiBqAForvhlPkhZ0kuYVY
         Crq0JrAkHb2z2sIQHP4UKr8ZOegBKsmzIL0Vpju/nugvCS3AThLwxBYXnMdzLao9pnqC
         FKtw==
X-Gm-Message-State: AO0yUKWse4ctZinwaQNYKFI4fK2nmmj495F9zvBLORi82K5fAP5r6gql
        IxfuEMGN22yUpgchwGAx9I8TBA==
X-Google-Smtp-Source: AK7set8X4reR+82vgykilK8aHB+XRKgPcD/AxV28/6UBa3CALDS2MM38mA0PEFA08pso97HNguCN9A==
X-Received: by 2002:a05:6e02:dd3:b0:317:2f8d:528f with SMTP id l19-20020a056e020dd300b003172f8d528fmr1982563ilj.2.1678989559048;
        Thu, 16 Mar 2023 10:59:19 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id z13-20020a02cead000000b003a53692d6dbsm2686039jaq.124.2023.03.16.10.59.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 10:59:18 -0700 (PDT)
Message-ID: <a1ad3c9e-ee3d-7d30-fe8e-bca2eed77872@linuxfoundation.org>
Date:   Thu, 16 Mar 2023 11:59:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH RESEND] usbip: vudc: Fix use after free bug in vudc_remove
 due to race condition
Content-Language: en-US
To:     Zheng Wang <zyytlz.wz@163.com>, valentina.manea.m@gmail.com
Cc:     shuah@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        hackerzheng666@gmail.com, 1395428693sheep@gmail.com,
        alex000young@gmail.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20230316174818.1593588-1-zyytlz.wz@163.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230316174818.1593588-1-zyytlz.wz@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/23 11:48, Zheng Wang wrote:
> In vudc_probe, it calls init_vudc_hw, which bound &udc->timer with v_timer.
> 
> When it calls usbip_sockfd_store, it will call v_start_timer to start the
> timer work.
> 
> When we call vudc_remove to remove the driver, theremay be a sequence as
> follows:
> 
> Fix it by shutdown the timer work before cleanup in vudc_remove.
> 

Send me v2 for this patch with adding details on how you found this problem
to this commit log.
  
> Note that removing a driver is a root-only operation, and should never
> happen.
> 
> CPU0                  CPU1
> 
>                       |v_timer
> vudc_remove          |
> kfree(udc);          |
> //free shost         |
>                       |udc->gadget
>                       |//use
> 
> Fixes: b6a0ca111867 ("usbip: vudc: Add UDC specific ops")
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> ---
>   drivers/usb/usbip/vudc_dev.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/usbip/vudc_dev.c b/drivers/usb/usbip/vudc_dev.c
> index 2bc428f2e261..33d0991755bb 100644
> --- a/drivers/usb/usbip/vudc_dev.c
> +++ b/drivers/usb/usbip/vudc_dev.c
> @@ -633,6 +633,7 @@ int vudc_remove(struct platform_device *pdev)
>   {
>   	struct vudc *udc = platform_get_drvdata(pdev);
>   
> +	timer_shutdown_sync(&udc->timer);
>   	usb_del_gadget_udc(&udc->gadget);
>   	cleanup_vudc_hw(udc);
>   	kfree(udc);

thanks,
-- Shuah
