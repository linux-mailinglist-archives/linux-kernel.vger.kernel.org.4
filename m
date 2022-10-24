Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5688660B636
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbiJXSu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbiJXSui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:50:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2A920882B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666632618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=61ONWJblhKykTdnnWFJPLzFrI2GgQTtZLaYgVl5PSEo=;
        b=I6aBRlScGPM8UqT5DEMYmDK2PSNwD35AKP25GfU+H+zSew1zdWOcFpw6pohGEF9j6byyji
        FeVFB8sgYLZPnD4NvMjoPVyy8+meJ457CNx6n0p/DdSfHfrDjOwNfb3EBh5lrIk0MFdPRV
        xfEz8CVZBCHZEG+cek1sjLdLv9cY/oo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-595-v7GTVUkUPBq6Ec7QhQIVVw-1; Mon, 24 Oct 2022 10:06:50 -0400
X-MC-Unique: v7GTVUkUPBq6Ec7QhQIVVw-1
Received: by mail-ed1-f72.google.com with SMTP id s8-20020a056402520800b0045cab560d5eso9798650edd.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 07:06:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=61ONWJblhKykTdnnWFJPLzFrI2GgQTtZLaYgVl5PSEo=;
        b=QFcVLBar2PGr3CAK3W0hwuZkdRt853AYKnegConcwlH7z6xE2xBSLHe7UP/6vYQxBg
         CimAemp9CK++PlogTjXg3GPu++oo23hnoIiOk45BgADwz3rd8T+0a+gaGlVW9lQFuaGS
         84CHq0FtzM/dvWeSOW2yg7Liq93RrGPtP234DO7b2SnqLWd3OcH0H8VhbbA7AezH0142
         1T3edJvlWm8SZWg2frkg9z7XUjZshC19aGHPnfAOPc7jvXYsR34zvqFnaYdAqO97u1+8
         xXfsLhG/mlct5amtY2tzWl3ziU9vDdJkTQRLLLL9CkUOZpq8bTZ2wsOTuNdqJ2NxyIBf
         yBYQ==
X-Gm-Message-State: ACrzQf3KQY8rDr9YiDTuclivgEe+q/8bnV/4m6p9xOA5jZcoWWuefnWX
        wlW6bhFXMWraA0jt5+u5ZhRp1rxyZesSszktzkGfsCFlP8Pq68A0aYQKRYTawLDP8VkA9NTO8kY
        uJ+ZE4aJu43FY8iXifB/RqOGU
X-Received: by 2002:a17:906:9b83:b0:730:b3ae:343 with SMTP id dd3-20020a1709069b8300b00730b3ae0343mr28814887ejc.670.1666620408960;
        Mon, 24 Oct 2022 07:06:48 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4F6Ovxer5z8nqFLbjl91mu9iIhrga9lNSTAEq2gyu682xI+X6JZNjFoK1Q7oLcdoko/lhY6A==
X-Received: by 2002:a17:906:9b83:b0:730:b3ae:343 with SMTP id dd3-20020a1709069b8300b00730b3ae0343mr28814872ejc.670.1666620408733;
        Mon, 24 Oct 2022 07:06:48 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id dn2-20020a05640222e200b00459cf672a65sm18655822edb.71.2022.10.24.07.06.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 07:06:48 -0700 (PDT)
Message-ID: <f98a33a7-08d6-e1fa-f00c-05b7fa96a919@redhat.com>
Date:   Mon, 24 Oct 2022 16:06:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] acerhdf: remove unneeded semicolon
Content-Language: en-US
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, peter@piie.net
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20221008070411.51859-1-jiapeng.chong@linux.alibaba.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221008070411.51859-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/8/22 09:04, Jiapeng Chong wrote:
> ./drivers/platform/x86/acerhdf.c:344:2-3: Unneeded semicolon.
> 
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2271
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

This patch does not apply:

[hans@x1 platform-drivers-x86]$ git am -s ~/1.eml
Applying: acerhdf: remove unneeded semicolon
error: patch failed: drivers/platform/x86/acerhdf.c:341
error: drivers/platform/x86/acerhdf.c: patch does not apply
Patch failed at 0001 acerhdf: remove unneeded semicolon
hint: Use 'git am --show-current-patch=diff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

Please make sure that you base this on the latest version of
the acerhdf code from:

https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=for-next

Regards,

Hans



> ---
>  drivers/platform/x86/acerhdf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
> index 1956469c3457..6cf7f2a8a074 100644
> --- a/drivers/platform/x86/acerhdf.c
> +++ b/drivers/platform/x86/acerhdf.c
> @@ -341,7 +341,7 @@ static void acerhdf_check_param(struct thermal_zone_device *thermal)
>  		pr_err("fanoff temperature (%d) is above fanon temperature (%d), clamping to %d\n",
>  		       fanoff, fanon, fanon);
>  		fanoff = fanon;
> -	};
> +	}
>  
>  	trips[0].temperature = fanon;
>  	trips[0].hysteresis  = fanon - fanoff;

