Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D825EC390
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 15:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbiI0NFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 09:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbiI0NE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 09:04:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2B59F19E
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 06:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664283894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kquHkI2w4A5K9/c91glk5Z1gSYykco9F3dyKF8GU0Q0=;
        b=KY9OLQjMR02zIElLzEGk+iWbYoPtLiQWV92kVigvypd1hJD3F44Q1Sfvh8D9DvO/aue7+b
        Fpyrd/rmcJGoULup421b1JSRsou1NwcoOQYwGO/3bKtK68bqZCDduzHY6cnjiZk3MInpY+
        JVR5vbILAwsSHLaxjlXgkoWzma9VEhY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-320-_C-4XqxEMNeD2No2J0OmpQ-1; Tue, 27 Sep 2022 09:04:53 -0400
X-MC-Unique: _C-4XqxEMNeD2No2J0OmpQ-1
Received: by mail-ed1-f72.google.com with SMTP id x5-20020a05640226c500b00451ec193793so7778683edd.16
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 06:04:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=kquHkI2w4A5K9/c91glk5Z1gSYykco9F3dyKF8GU0Q0=;
        b=Rcqxbsyb3zPdr9pwvpFQnPEv8B+UoPJ3+N9yHPx4RwA6FK5tkaFigCN++KClkouNPg
         wQG5O3pxyzWeZjdVjndaYL/VDvkvhyCXTKrFY2QByc5HoCtOplGhy9BCAzsdrJS+cS/W
         Y/Lzhc2HX3i9PXxOsCbtjC0UCiUFeiJjetNkqMzdPG0oLMRFArSdBhj3QZCy8WTI51Hm
         U8jsUSRaCD20Oa3p2KgEAxuL2TG3fx5dHCSZ7ArNHjvR8WjpzFfy/fq82EJJ3Y3p6wpr
         YGlDO6eDXA8Qk9Zf3yIbaPBVgJ8kyoJ+65smljxKO8HgYX+06uu8bAMJAZqiW/1kLwuq
         Xrlg==
X-Gm-Message-State: ACrzQf0L3AX5PP/g1avC0S7mpNNLg3+yvi3jtUd/JXBlJ+flUcIFJJ59
        kznRqFodr9jXmByEwb3IFev5boFKWElnoRMrCs/Y76+WznUU3G9ALbp1fmpP/jCXBu2EARy2R61
        aYGBgwyxhgRgGC+pMTLLnf03l
X-Received: by 2002:a17:906:cc58:b0:76f:c119:acb5 with SMTP id mm24-20020a170906cc5800b0076fc119acb5mr22144461ejb.651.1664283892468;
        Tue, 27 Sep 2022 06:04:52 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7gVV4Z2M+oNSaOA06trCpTieD7J2Evmuo2kvhBG2O7xpvkb8P1hXDUP9I+ha6Rjvky5yNbMw==
X-Received: by 2002:a17:906:cc58:b0:76f:c119:acb5 with SMTP id mm24-20020a170906cc5800b0076fc119acb5mr22144415ejb.651.1664283891899;
        Tue, 27 Sep 2022 06:04:51 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id rl24-20020a170907217800b00782539a02absm747977ejb.194.2022.09.27.06.04.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 06:04:41 -0700 (PDT)
Message-ID: <525218fc-d70e-1de5-2495-13fe3e942a9a@redhat.com>
Date:   Tue, 27 Sep 2022 15:04:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH linux-next] platform/x86: use sysfs_emit() and add the
 '\n'
Content-Language: en-US
To:     cgel.zte@gmail.com
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>
References: <20220923063233.239091-1-ye.xingchen@zte.com.cn>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220923063233.239091-1-ye.xingchen@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/23/22 08:32, cgel.zte@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Replace the open-code with sysfs_emit() to simplify the code.
> And also add '\n' because it need a new line.
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Thanks, I have merged this minus the addition of the '\n',
this is exposed to userspace and some userspace apps may rely
on the current behavior where the '\n' is omitted.

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans




> ---
>  drivers/platform/x86/dell/dell-smbios-base.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell/dell-smbios-base.c b/drivers/platform/x86/dell/dell-smbios-base.c
> index fc086b66f70b..e5b61ecdae8c 100644
> --- a/drivers/platform/x86/dell/dell-smbios-base.c
> +++ b/drivers/platform/x86/dell/dell-smbios-base.c
> @@ -441,7 +441,7 @@ static ssize_t location_show(struct device *dev,
>  
>  	i = match_attribute(dev, attr);
>  	if (i > 0)
> -		return scnprintf(buf, PAGE_SIZE, "%08x", da_tokens[i].location);
> +		return sysfs_emit(buf, "%08x\n", da_tokens[i].location);
>  	return 0;
>  }
>  
> @@ -455,7 +455,7 @@ static ssize_t value_show(struct device *dev,
>  
>  	i = match_attribute(dev, attr);
>  	if (i > 0)
> -		return scnprintf(buf, PAGE_SIZE, "%08x", da_tokens[i].value);
> +		return sysfs_emit(buf, "%08x\n", da_tokens[i].value);
>  	return 0;
>  }
>  

