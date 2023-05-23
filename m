Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D772A70DACE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 12:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236534AbjEWKrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 06:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236493AbjEWKrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 06:47:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042EF120
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 03:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684838773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mHOWHKjqyu8zM7VyoQmN1VEsqEjzLmFlnvh8RE24jpU=;
        b=AJt304kFrlxmaa4DVU/fbg0dsV9XSkohWR4h5qOqRxqU1xDtRJam1gauqUW1SZrA6x0xRv
        uyFjWBmIm/7aUOOoPrA3JPJLu5koCgWON7qPBnLGwtXIJugVPeeLN9p4Qa64sIUGVwyjI5
        1JDtNYLyjhBYb4fzs3SaImcoO7jexxo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-Txk_8DrhMIOl5J93khxamQ-1; Tue, 23 May 2023 06:46:09 -0400
X-MC-Unique: Txk_8DrhMIOl5J93khxamQ-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-513e9618214so810306a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 03:46:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684838768; x=1687430768;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mHOWHKjqyu8zM7VyoQmN1VEsqEjzLmFlnvh8RE24jpU=;
        b=ENOS0S+3NkxZO9txrwJw+9W5jTicjmLXiswvQaTXVPQ7F5yPlzpYFzsseY2x7EJAjB
         6Dky8qpWr46gIxff7h3kml4kqj4XFke7sA1SknJ8qlYUTvZnxkNdLoaugWRmCmklik6H
         /12Qp31aR+ZezVpWaVhAawDWLxuNcZ7al6GhViljvdg+0VrdZ2NXULUMmGK8JPqOCXTb
         MmsfF7vTIBUDwOU1enl3zUGTV3zUVHgVADPSx7OVdxcggnaQT0OpeWzf1yG2JRWTFNCz
         0FqIlAbym2TzkPNJ7lBB3CHyGcYQUbVymfiTfaxaowou9Vm5UAA+skTHqs9OOjGFppwb
         2nPQ==
X-Gm-Message-State: AC+VfDz0XaR1iV2Wwu7kAyGb17+8G2fB4o/tzufMMOIm793zMW1B6S0F
        U7tPeNZNx45DHXRiyAooVxSkwKh2ibnLC1IC4msXMemwxGmzJ5BouFOElSdBWVcsAJYfuHuSyer
        u/PkyMaOm6WAfnITkRr9LSODz
X-Received: by 2002:a50:ee8f:0:b0:50b:d495:106c with SMTP id f15-20020a50ee8f000000b0050bd495106cmr12468470edr.8.1684838768811;
        Tue, 23 May 2023 03:46:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4YtOe1MYd+n7E7C2t0Qc5nS/36P4GsrLsL8PAtrfA2Tg9JH8dvQyQqC7d0aMMeAHPQG6kYLg==
X-Received: by 2002:a50:ee8f:0:b0:50b:d495:106c with SMTP id f15-20020a50ee8f000000b0050bd495106cmr12468454edr.8.1684838768494;
        Tue, 23 May 2023 03:46:08 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id d18-20020aa7d5d2000000b0050bc9ffed66sm3987790eds.53.2023.05.23.03.46.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 03:46:07 -0700 (PDT)
Message-ID: <b79fa66c-b8bc-125c-ccfa-9dae727022e9@redhat.com>
Date:   Tue, 23 May 2023 12:46:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/4] platform/x86: think-lmi: Enable opcode support on
 BIOS settings
Content-Language: en-US, nl
To:     Mark Pearson <mpearson-lenovo@squebb.ca>
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <mpearson-lenovo@squebb.ca>
 <20230517181945.3725-1-mpearson-lenovo@squebb.ca>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230517181945.3725-1-mpearson-lenovo@squebb.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 5/17/23 20:19, Mark Pearson wrote:
> Whilst reviewing some documentation from the FW team on using WMI on
> Lenovo system I noticed that we weren't using Opcode support when
> changing BIOS settings in the thinkLMI driver.
> 
> We should be doing this to ensure we're future proof as the old
> non-opcode mechanism has been deprecated.
> 
> Tested on X1 Carbon G10 and G11.
> 
> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> ---
>  drivers/platform/x86/think-lmi.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
> index 1138f770149d..d9341305eba9 100644
> --- a/drivers/platform/x86/think-lmi.c
> +++ b/drivers/platform/x86/think-lmi.c
> @@ -1001,7 +1001,28 @@ static ssize_t current_value_store(struct kobject *kobj,
>  				tlmi_priv.pwd_admin->save_signature);
>  		if (ret)
>  			goto out;

> -	} else { /* Non certiifcate based authentication */
> +	} else if (tlmi_priv.opcode_support) {
> +		/* If opcode support is present use that interface */
> +		set_str = kasprintf(GFP_KERNEL, "%s,%s;", setting->display_name,
> +					new_setting);
> +		if (!set_str) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +
> +		ret = tlmi_simple_call(LENOVO_SET_BIOS_SETTINGS_GUID, set_str);
> +		if (ret)
> +			goto out;
> +
> +		if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
> +			ret = tlmi_opcode_setting("WmiOpcodePasswordAdmin",
> +					tlmi_priv.pwd_admin->password);
> +			if (ret)
> +				goto out;
> +		}
> +
> +		ret = tlmi_save_bios_settings("");

I'm a bit confused about how this works. You are calling the same
LENOVO_SET_BIOS_SETTINGS_GUID as the old non opcode based authentication method
without any auth string.

And then afterwards you are calling LENOVO_OPCODE_IF_GUID with
"WmiOpcodePasswordAdmin:<passwd>"

Won't the initial LENOVO_SET_BIOS_SETTINGS_GUID get rejected since
it does not include an auth-string and you have not authenticated
yet using the opcode mechanism either. IOW shouldn't the opcode
auth call go first ?

And how does this work timing wise, vs races with userspace doing
multiple sysfs writes at once.

If the authentication done afterwards really acks the last
LENOVO_SET_BIOS_SETTINGS_GUID call then a userspace based
attacker could try to race and overwrite the last
LENOVO_SET_BIOS_SETTINGS_GUID call before the ack happens... ?

If this code really is correct I think we need to introduce
a mutex to avoid this race.

And this also needs some comments to explain what is going on.

Regards,

Hans





> +	} else { /* old non opcode based authentication method (deprecated)*/
>  		if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
>  			auth_str = kasprintf(GFP_KERNEL, "%s,%s,%s;",
>  					tlmi_priv.pwd_admin->password,

