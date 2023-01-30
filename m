Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18D1681419
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 16:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237867AbjA3PHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 10:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237784AbjA3PHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 10:07:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6B027D6A
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 07:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675091181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5CVJu2EH78w77h5RT2FTQTyWVRR8gsDPBHuNXqm811E=;
        b=SW3UVH6pmxU5qh4wZx4Dz1XiJRYF8yIqAPQx8UsXj1Vvu3Ju/RU6jzI8oPtMAmymoUuZqm
        lL7iaWMW8R2oI47ORVv8Th+ZzllEs1gqHnXDh+nXkkWH+sHmkp7ozERdBiwTgSm6twFm/4
        uwm44o2j2PCONetrMNKNK7GEtDVo3Yg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-542-nSzGxRcsM3i_T3zJCPAStA-1; Mon, 30 Jan 2023 10:06:20 -0500
X-MC-Unique: nSzGxRcsM3i_T3zJCPAStA-1
Received: by mail-ed1-f72.google.com with SMTP id b6-20020aa7c906000000b004a25542075eso1352893edt.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 07:06:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5CVJu2EH78w77h5RT2FTQTyWVRR8gsDPBHuNXqm811E=;
        b=vQbLNk7AizmtvHWHE9Xzi962uIcDClQh+ZIJLK3j9S4gdTLrHJcfLWh/F8yMIGYjPq
         Z0J5Z/l4tDtkoTXrXkl6VyFswR73XLH1oPgpm1gsA4Mr3F3IItPpr0UJ4Ypq0TY54FOj
         S9AlCwgAiige76URL4QvGTt6AvGe3/FnnHRpqZ1E+8umY/dyhndbSgKTK5PGj37tcVW6
         r+SUcMP5UlCu6h0g0xConMbjymaJjkAQlMBoUpcuI4hBCLPOX9dbMAI85c2hQwkxqm1a
         SLLvczeCulPnbCCPYWaxBePhztpGUL14B7kh9Or6IkG+LuPPoBVv+NublL3Cs4tV3J9g
         Vm7w==
X-Gm-Message-State: AO0yUKXoLq0y75sX3C81uCd93vg7zc+PwWE90TN5sOZkyRBk+oJen0f4
        9R1AP8RxlSo6h1Hffe1MouRMRkSZr8FldcexNc/9brjAMIaav3mVTdAMIArERGPU4ptZqMtd3l7
        YV5W/fZqEbfqVzEm1UxwQokPp
X-Received: by 2002:a17:906:1651:b0:878:45e9:6f96 with SMTP id n17-20020a170906165100b0087845e96f96mr19038791ejd.49.1675091179021;
        Mon, 30 Jan 2023 07:06:19 -0800 (PST)
X-Google-Smtp-Source: AK7set/pWbyTVsCwUzmoscsNJcBsnhDO03WOS2srLwGgUlMlRx89m0LKnN0ZDK8pNpbPFojbf8zgHg==
X-Received: by 2002:a17:906:1651:b0:878:45e9:6f96 with SMTP id n17-20020a170906165100b0087845e96f96mr19038773ejd.49.1675091178843;
        Mon, 30 Jan 2023 07:06:18 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id ov9-20020a170906fc0900b0087bdae9a1ebsm5425686ejb.94.2023.01.30.07.06.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 07:06:18 -0800 (PST)
Message-ID: <c425d613-80d7-221c-20de-f03191cb1b59@redhat.com>
Date:   Mon, 30 Jan 2023 16:06:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 3/5] platform/x86: dell-ddv: Replace EIO with ENOMSG
Content-Language: en-US
To:     Armin Wolf <W_Armin@gmx.de>, markgross@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net,
        platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230126194021.381092-1-W_Armin@gmx.de>
 <20230126194021.381092-4-W_Armin@gmx.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230126194021.381092-4-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/26/23 20:40, Armin Wolf wrote:
> When the ACPI WMI interface returns a valid ACPI object
> which has the wrong type, then ENOMSG instead of EIO
> should be returned, since the WMI method was still
> successfully evaluated.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

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
>  drivers/platform/x86/dell/dell-wmi-ddv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c b/drivers/platform/x86/dell/dell-wmi-ddv.c
> index f99c4cb686fd..58fadb74e86a 100644
> --- a/drivers/platform/x86/dell/dell-wmi-ddv.c
> +++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
> @@ -87,7 +87,7 @@ static int dell_wmi_ddv_query_type(struct wmi_device *wdev, enum dell_ddv_method
> 
>  	if (obj->type != type) {
>  		kfree(obj);
> -		return -EIO;
> +		return -ENOMSG;
>  	}
> 
>  	*result = obj;
> --
> 2.30.2
> 

