Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D46641152
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 00:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbiLBXGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 18:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234457AbiLBXF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 18:05:59 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21090F2314;
        Fri,  2 Dec 2022 15:05:59 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id b21so5950577plc.9;
        Fri, 02 Dec 2022 15:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2YFuCwIlw0b5okxJ2mEKW4RttLYygMDqsm34g7nURCo=;
        b=HtLVTMXIoRPWCsiKh96L+qwOfJo0GDvkOvoTAS74lm8TqvPq8c65lv8HPwhgO/GIy1
         vOjUvgUHbCKVvw5pSkz1wMKJb2p2J4seBtPUz2RQKUHaUU0xSW/e5ZkiwRbCqCWgKej+
         smea1GelQOfZz/ojZLxrM2yqny7YFjmFX1qcl5lME4Pez95up0mYRflVGkrJbQAIMRTn
         uXELLAVZhoEF7j4Gn0Hkk9Bu1+xf/N6EHmtWv6zeBgFmygLFRIjNUymElrZoLlPq/10e
         k73soIM/GnbbRBgrLd9l5EAkyuT72D1m2Ne8Gv/rF+YFcrOjWrnl8/LkMkyOJqIdsUPf
         DP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2YFuCwIlw0b5okxJ2mEKW4RttLYygMDqsm34g7nURCo=;
        b=PcWV0ueMYmeHzukDC2V9duq3tRBXv4ayXSzyTpdDaWXSYX6OJKXOw4GJNaIoHbLzHy
         tdQEMJ795x3w/0tfmqU79LLVerrdABXptWZds6P2XbhUs52vUa25ZXL/d03cR3cNHLna
         zcIjETGLjVIj6EoxmZGXVeZKtodRihjiuX5M2GQwlWFhXEC4H9tVi8JiEOpnSRqaVZv7
         OHnomMGj0GQ1xGQWW/TzczVnwMHGQd5q+QRzLGUl0XkcvMc6RG9qFbXEVs1ZWP9EXu1C
         QGr71H5zOj2gUMiW9afXs+/C1mX0SLI9sk1ghX4h7lmL43NHs7ZFV4SAmL+3Kc/ir1oM
         nqSg==
X-Gm-Message-State: ANoB5pn++RK/8c9zCaGzPRiaU2lhXRkU/IVKP9ZwGlXwOSvvId2MKEMP
        EiL9HKprp53BsHSMJcidCF3CCsy2nW2lwQ==
X-Google-Smtp-Source: AA0mqf7YlJVKridhyQaYG2+KsYrOzTdd14JbhT14eHkcZEVq3pLI1Xng1cRmLdORJA+5FWrKfmkx9Q==
X-Received: by 2002:a17:90a:d18b:b0:219:6be1:7ff2 with SMTP id fu11-20020a17090ad18b00b002196be17ff2mr14496896pjb.79.1670022358555;
        Fri, 02 Dec 2022 15:05:58 -0800 (PST)
Received: from [172.30.1.1] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id f88-20020a17090a28e100b001f94d25bfabsm7063029pjd.28.2022.12.02.15.05.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 15:05:55 -0800 (PST)
Message-ID: <be501519-8ff6-6777-3dec-6abe6648fadc@gmail.com>
Date:   Sat, 3 Dec 2022 08:05:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] PM / devfreq: event: Use device_match_of_node()
Content-Language: en-US
To:     ye.xingchen@zte.com.cn, cw00.choi@samsung.com
Cc:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <202211251510047017670@zte.com.cn>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <202211251510047017670@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 11. 25. 16:10, ye.xingchen@zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Replace the open-code with device_match_of_node().
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/devfreq/devfreq-event.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-event.c
> index 6765c03334bc..f041edccd107 100644
> --- a/drivers/devfreq/devfreq-event.c
> +++ b/drivers/devfreq/devfreq-event.c
> @@ -233,7 +233,7 @@ struct devfreq_event_dev *devfreq_event_get_edev_by_phandle(struct device *dev,
> 
>  	mutex_lock(&devfreq_event_list_lock);
>  	list_for_each_entry(edev, &devfreq_event_list, node) {
> -		if (edev->dev.parent && edev->dev.parent->of_node == node)
> +		if (edev->dev.parent && device_match_of_node(edev->dev.parent, node))
>  			goto out;
>  	}
> 

Applied it.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

