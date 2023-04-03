Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602C16D4106
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbjDCJpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbjDCJpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:45:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405F95266
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 02:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680514977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wbgfORNhHrhwM8eHcoJrwIWuSveaLiQVkMK0P8wkdCs=;
        b=cOxQdrUyApY9Ir481cDIorVu+7C3sn9LktdfIVc0BUiYVd/d218qSYVkOLEedS/IROko/m
        PwABpAFEt09EA/hTMdGPyaT59RWAVLgbjtjH0akVxDs9B+8D0id2tz7EwvOr5Z+7yODRF7
        aJVrOF8NjaR5tIGJBfxyon19SJhSZc8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-aI_81BCjMkq-Ms-iONh17w-1; Mon, 03 Apr 2023 05:42:56 -0400
X-MC-Unique: aI_81BCjMkq-Ms-iONh17w-1
Received: by mail-ed1-f70.google.com with SMTP id r19-20020a50aad3000000b005002e950cd3so40827437edc.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 02:42:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680514975;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wbgfORNhHrhwM8eHcoJrwIWuSveaLiQVkMK0P8wkdCs=;
        b=6p3oVf/eqDV/xQ4UmFJCxkO5ofZBQ+AnvCerPrhfK6CtzRjBDlI3O70eDVq5rQKAL5
         x7xNJVbKqsEi8kr2+M875Ni7lZNdc8xXQ1oXm9jAYxpEPuJtmlqmh+1Ope0L736w5yyQ
         4Xb0vnlbuG0mGgGIUoOPWD4Hx5K8tr+3/n3l55KKV5Qfkn8mnD+OYbd6ku43fQF8dEOc
         bz11ylose+A7BeCeBNIMhTF2q/PL23isWCpbTuQwryE6qA7jYuwdvIofiEZPsIqikYCA
         Q6w8SlYavlN2hDXzm8v69j6wfAm88pY5G6fcROYjP0FxzfProj+Gm3aD4ZrAl7lYFotL
         4bAQ==
X-Gm-Message-State: AAQBX9dXJibGu4f6dTIRZDj0HKBMN3v1zougfI5DoiBiMHjyhB94LvgK
        iaSXCXxWlRmND8Pn132ee0JcIwpweRSFPrjuKpJ/dOjvx0pxNM33V6SA44Yf3cri5E1svIUx68e
        TbHyK5hKN49KwwNfCasYv9wDT
X-Received: by 2002:a17:906:184d:b0:8b1:e791:faef with SMTP id w13-20020a170906184d00b008b1e791faefmr33434949eje.67.1680514975102;
        Mon, 03 Apr 2023 02:42:55 -0700 (PDT)
X-Google-Smtp-Source: AKy350YiB+CyE2+PTiiwWDlEnWL0Ll3R5B0+Pm3CPW7Z9fTj+Cyu2Ukiug94IlhF6BNFJuyVrXr/Zg==
X-Received: by 2002:a17:906:184d:b0:8b1:e791:faef with SMTP id w13-20020a170906184d00b008b1e791faefmr33434939eje.67.1680514974863;
        Mon, 03 Apr 2023 02:42:54 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id bv20-20020a170906b1d400b009447277c2aasm4301001ejb.39.2023.04.03.02.42.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 02:42:54 -0700 (PDT)
Message-ID: <bb977bc7-70bc-9e21-a376-76f1b863d866@redhat.com>
Date:   Mon, 3 Apr 2023 11:42:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3] platform/x86: think-lmi: Fix memory leak when showing
 current settings
Content-Language: en-US, nl
To:     Armin Wolf <W_Armin@gmx.de>, markpearson@lenovo.com,
        mirsad.todorovac@alu.unizg.hr
Cc:     markgross@kernel.org, thomas@t-8ch.de, gregkh@linuxfoundation.org,
        rafael@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230331213319.41040-1-W_Armin@gmx.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230331213319.41040-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/31/23 23:33, Armin Wolf wrote:
> When retriving a item string with tlmi_setting(), the result has to be
> freed using kfree(). In current_value_show() however, malformed
> item strings are not freed, causing a memory leak.
> Fix this by eliminating the early return responsible for this.
> 
> Reported-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
> Link: https://lore.kernel.org/platform-driver-x86/01e920bc-5882-ba0c-dd15-868bf0eca0b8@alu.unizg.hr/T/#t
> Tested-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
> Fixes: 0fdf10e5fc96 ("platform/x86: think-lmi: Split current_value to reflect only the value")
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Thank you for your patch, I've applied this patch to my fixes
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=fixes

Note it will show up in my fixes branch once I've pushed my
local branch there, which might take a while.

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans



> ---
> Changes in v3:
> - Fix Fixes: tag
> - Add Tested-by: tag
> Changes in v2:
> - Add Reported-by: and Link: tags
> ---
>  drivers/platform/x86/think-lmi.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
> index cc66f7cbccf2..8cafb9d4016c 100644
> --- a/drivers/platform/x86/think-lmi.c
> +++ b/drivers/platform/x86/think-lmi.c
> @@ -930,10 +930,12 @@ static ssize_t current_value_show(struct kobject *kobj, struct kobj_attribute *a
>  	/* validate and split from `item,value` -> `value` */
>  	value = strpbrk(item, ",");
>  	if (!value || value == item || !strlen(value + 1))
> -		return -EINVAL;
> +		ret = -EINVAL;
> +	else
> +		ret = sysfs_emit(buf, "%s\n", value + 1);
> 
> -	ret = sysfs_emit(buf, "%s\n", value + 1);
>  	kfree(item);
> +
>  	return ret;
>  }
> 
> --
> 2.30.2
> 

