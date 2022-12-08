Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78F0647460
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 17:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiLHQdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 11:33:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiLHQdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 11:33:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B196561
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 08:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670517155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gwyXN9AyJCfUq7SYZ9lwVdPug8mXVxtE2Rq8B8I5K5Y=;
        b=Cb7pVsCnt3yUtG1RjD1HxNHz8zZPXvadGZV1HtR+0gANlauFSb4jRtdFWCmQRBt8mv6GmB
        Aho1U1xVXclzYwvi194zBBVWJp3fI23zAseHIhF1GwHIz9KzE8IWa8po0lA3rqZeLzXytq
        yulRBlOLSffcKyMHRsl00NThRfAIFdw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-484-ObYsnVhYMeabbg7gLlXyxA-1; Thu, 08 Dec 2022 11:32:34 -0500
X-MC-Unique: ObYsnVhYMeabbg7gLlXyxA-1
Received: by mail-ed1-f72.google.com with SMTP id s13-20020a056402520d00b0046c78433b54so1219065edd.16
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 08:32:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gwyXN9AyJCfUq7SYZ9lwVdPug8mXVxtE2Rq8B8I5K5Y=;
        b=7S6ZpErha7WxW6Fx3j9GELcry1JUeJDMckmZADVY+gmTB0vDss92aZ7MffQGRd748K
         t5UDVJ3My6odO6yW9SQ2e3Ptwe3cfPgi5i+gkiQRk8rr5PVPSqdjbxdVjnjWEXxS9kjo
         TnqdkeNLP9h4xvw+LPEtnN4CPLoiW0G3peBkwXHw1lHGUeD8vkzy4q2in68n3QdZXGzI
         cLhWihJ4YT6qdGjCTUihjhRP3SAoIdZ5pzAzwEE4uQc96JB0aNYJY+VvvvDeKlUvnMf/
         2assN168ajwyh4MHt+/l2tmZkvb1FvDOhXFunyqdDHFHv/NWxBPRmzKnWQJnZjlDHdUT
         Iu2g==
X-Gm-Message-State: ANoB5pnyaBDHcyw2gym9puGoF8/ui+Q5AvdBIU+De4DbBiB7LRCaUfJh
        j2+FrWiBZ5VVYajjFQ4URyFPoDO7eY88K2QFB0t6VlvyUyucPyEDxVx3FrsWeDsf8h0TA5gZLgx
        VKrFbSvRnni6zn4Drabc82Xax
X-Received: by 2002:a05:6402:248e:b0:464:1b51:f85c with SMTP id q14-20020a056402248e00b004641b51f85cmr958728eda.25.1670517150283;
        Thu, 08 Dec 2022 08:32:30 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5QNK02SqRex45/L+1I16WeAAGRh2xDOaOPYOH3Kpz3x+lfBBShXrLuusgwwrfpnclomxsz8g==
X-Received: by 2002:a05:6402:248e:b0:464:1b51:f85c with SMTP id q14-20020a056402248e00b004641b51f85cmr958715eda.25.1670517150131;
        Thu, 08 Dec 2022 08:32:30 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id u14-20020a056402110e00b0046af63521a2sm3548747edv.29.2022.12.08.08.32.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 08:32:29 -0800 (PST)
Message-ID: <27423188-10ed-be55-3080-570a476b2899@redhat.com>
Date:   Thu, 8 Dec 2022 17:32:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] platform/x86: sony-laptop: Convert to use sysfs_emit_at()
 API
Content-Language: en-US, nl
To:     ye.xingchen@zte.com.cn
Cc:     malattia@linux.it, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <202212081545178689771@zte.com.cn>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <202212081545178689771@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/8/22 08:45, ye.xingchen@zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Follow the advice of the Documentation/filesystems/sysfs.rst and show()
> should only use sysfs_emit() or sysfs_emit_at() when formatting the
> value to be returned to user space.
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

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
>  drivers/platform/x86/sony-laptop.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
> index a19aac70252f..7156ae2ad196 100644
> --- a/drivers/platform/x86/sony-laptop.c
> +++ b/drivers/platform/x86/sony-laptop.c
> @@ -820,10 +820,9 @@ static ssize_t sony_nc_handles_show(struct device *dev,
>  	int i;
> 
>  	for (i = 0; i < ARRAY_SIZE(handles->cap); i++) {
> -		len += scnprintf(buffer + len, PAGE_SIZE - len, "0x%.4x ",
> -				handles->cap[i]);
> +		len += sysfs_emit_at(buffer, len, "0x%.4x ", handles->cap[i]);
>  	}
> -	len += scnprintf(buffer + len, PAGE_SIZE - len, "\n");
> +	len += sysfs_emit_at(buffer, len, "\n");
> 
>  	return len;
>  }
> @@ -2173,10 +2172,9 @@ static ssize_t sony_nc_thermal_profiles_show(struct device *dev,
> 
>  	for (cnt = 0; cnt < THM_PROFILE_MAX; cnt++) {
>  		if (!cnt || (th_handle->profiles & cnt))
> -			idx += scnprintf(buffer + idx, PAGE_SIZE - idx, "%s ",
> -					snc_thermal_profiles[cnt]);
> +			idx += sysfs_emit_at(buffer, idx, "%s ", snc_thermal_profiles[cnt]);
>  	}
> -	idx += scnprintf(buffer + idx, PAGE_SIZE - idx, "\n");
> +	idx += sysfs_emit_at(buffer, idx, "\n");
> 
>  	return idx;
>  }

