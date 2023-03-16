Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898496BD813
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 19:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjCPSUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 14:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjCPSTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 14:19:54 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BF8E20EF
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 11:19:23 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id s7so1467296ilv.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 11:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1678990759; x=1681582759;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WbL1jXcAAzjaooJaT7ULn7Y2lyg1tFqQl4SmSGqfzD0=;
        b=hRLNEClznBSDehOZH75x/kVOAqJbqIuB2OlBoEloOOCkj9/RKVDtYkOH+enCgy40lL
         +X307Fyyy9S9fRt02mZ0ZBSd09VxUICFtV/kXiU9jl67FNRtC+Ox0Xr8MAhy6KDX87u6
         OI9sndoXLbRbaRASVVoWJRtH8+N+4HTKh8c5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678990759; x=1681582759;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WbL1jXcAAzjaooJaT7ULn7Y2lyg1tFqQl4SmSGqfzD0=;
        b=fs0UABMOW1RZr7vaJ0oR/M9v1OMBG/aEBCV0hUYsJZk+o+lCJv4323Oaz2V9OsH2Ug
         rRJNa/mHIR7n//w36plrvdYyHE8cCO0OJNfm1fKbuuY+AX5a516FZqerkvuNh01yh7Jf
         Cp/Asy9BpWQht8W7P5f05J+6DHcN0bsSU74qf3cVt/EQ7q53BZjplFbKsgNpMnh/6SJI
         I9HGRZHDRRyRr4+linVq+U7CgQOI66UzHgpZ/nzcrd0pO4fj9fzgPwWkUReeU+QU9Xl2
         89+6aSbb8ZMZ2FmGRMzflEa9PoLAoUMdPQDZ7DOayl4+tNE0jb5sEA/ClER5I7LK+M9R
         QXEA==
X-Gm-Message-State: AO0yUKVVE+93HyIbxa5apbe1BMtEWL8OKS9hNOTarmqYP4R6dFheOzyC
        2SVE903yo7WfaPnOU7EZsaRukw==
X-Google-Smtp-Source: AK7set8nXB0G5d00N+QxR3UMxgSIuG9FPDgpWgQFF0bSsczlgwroMRvOo/iSlzh3KT1V37QPyrPqWw==
X-Received: by 2002:a92:d64f:0:b0:323:10c5:899e with SMTP id x15-20020a92d64f000000b0032310c5899emr4508137ilp.1.1678990759303;
        Thu, 16 Mar 2023 11:19:19 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id v5-20020a056e020f8500b00317b8e2c2b4sm15128ilo.39.2023.03.16.11.18.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 11:18:52 -0700 (PDT)
Message-ID: <a83b2f5f-732c-6d71-3e0c-1dce76076817@linuxfoundation.org>
Date:   Thu, 16 Mar 2023 12:18:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] usbip: vudc: Fix use after free bug in vudc_remove due
 to race condition
Content-Language: en-US
To:     Zheng Wang <zyytlz.wz@163.com>, valentina.manea.m@gmail.com
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, hackerzheng666@gmail.com,
        1395428693sheep@gmail.com, alex000young@gmail.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230316180940.1601515-1-zyytlz.wz@163.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230316180940.1601515-1-zyytlz.wz@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/23 12:09, Zheng Wang wrote:
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
> This bug was found by static analysis.

Tell me which static analysis tool did you use to find this and
the output from the tool.

> 
> Fixes: b6a0ca111867 ("usbip: vudc: Add UDC specific ops")
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> ---
> v2:
> - add more details about how the bug was found suggested by Shuah
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
