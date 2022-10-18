Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195E3602623
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 09:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiJRHsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 03:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbiJRHsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 03:48:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20376BD7B
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 00:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666079301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DsW6AFUCvdQWxKPmdrQSUF2jRKznY19HdIKCRi3R3wI=;
        b=cC8IOBxAWqVcrc69mdX8M35ZeAVkfvw8C40Pbo8gbmI1HTaowWQG/OJSaD3s38j2NzIgAl
        yIsPnTVKG3o33tjPWHXGazWKilFCG+uwXmsMFvkCTIwT/hN3KmsPBtjXVQFqXNzoFxZ3k9
        gEMATNXEINfVgUSJpDylkmyQe00rNdU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-658-dp5AvHoAMEWWmErcz7S-5w-1; Tue, 18 Oct 2022 03:48:20 -0400
X-MC-Unique: dp5AvHoAMEWWmErcz7S-5w-1
Received: by mail-ej1-f72.google.com with SMTP id xh12-20020a170906da8c00b007413144e87fso5884780ejb.14
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 00:48:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DsW6AFUCvdQWxKPmdrQSUF2jRKznY19HdIKCRi3R3wI=;
        b=eIbGmO5ARps1Ezh4q2o8P3mkQ9et3Hgsaoj6lk6ZUiK8Y/J31Nno8qa1vQpU2jrYtm
         l5WcV1PnfZ+7spj2iVESN6QqX0raI84p5kndmGijSKghQGdN9uQ8nui4Xf34zW2yR+Qs
         oLxH0y+Fe8KYa/mjPLeH0jz91B2NdRG94s4yVmu8kU3j0j6vFhzNV90O8ZdCrpppYkQo
         jSpf2xBysyJDQFVm64V8dDE9kZPD52RkE0pyvIv7WXvuw1z08+Hw/S9bRZXBm5UooPy9
         jxXvWmxCufMQAIFfkyDvclwRzsf3qi1hsYV3vlzKgpqe8Cbr2fxxQgiyw8ap3/CA+SIs
         vmmg==
X-Gm-Message-State: ACrzQf2q3VjN7YNjZAtzLrbYuQQOsI1wg4w9SQWVgxrQcwN1kumq3A+z
        rLYOYmrBMLeSiCawJSjmsT+P1iwz3xWXeafC/cZ5k3lG3E474+601r3EbCkpZkD3YgZDRn+2mxN
        +oQgDEF/mRcZwts0V9NwiF11P
X-Received: by 2002:a17:907:e88:b0:78d:fb98:6f5d with SMTP id ho8-20020a1709070e8800b0078dfb986f5dmr1343144ejc.5.1666079299297;
        Tue, 18 Oct 2022 00:48:19 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7TZTpxCEixsinQYF9o1yYhc2T6vMAUXsWMlVpZfKMDdIquBSv6+mfNFb5bnILyY/x3KH+DOQ==
X-Received: by 2002:a17:907:e88:b0:78d:fb98:6f5d with SMTP id ho8-20020a1709070e8800b0078dfb986f5dmr1343128ejc.5.1666079299084;
        Tue, 18 Oct 2022 00:48:19 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id a13-20020aa7cf0d000000b00454546561cfsm8477482edy.82.2022.10.18.00.48.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 00:48:18 -0700 (PDT)
Message-ID: <bade32f9-594c-3efd-d6da-ea6a4a433948@redhat.com>
Date:   Tue, 18 Oct 2022 09:48:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] platform/x86: ideapad-laptop: Disable touchpad_switch
To:     Manyi Li <limanyi@uniontech.com>, ike.pan@canonical.com,
        markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221018061457.26937-1-limanyi@uniontech.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221018061457.26937-1-limanyi@uniontech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/18/22 08:14, Manyi Li wrote:
> Ideapads for "Lenovo Yoga 3 Pro 1370" and "ZhaoYang K4e-IML" do not
> use EC to switch touchpad.
> 
> Reading VPCCMD_R_TOUCHPAD will return zero thus touchpad may be blocked
> unexpectedly.
> 
> Signed-off-by: Manyi Li <limanyi@uniontech.com>
> ---
>  drivers/platform/x86/ideapad-laptop.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
> index abd0c81d62c4..20b8a94934b4 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -1533,6 +1533,24 @@ static const struct dmi_system_id hw_rfkill_list[] = {
>  	{}
>  };
>  
> +static const struct dmi_system_id no_touchpad_switch_list[] = {
> +	{
> +	.ident = "Lenovo Yoga 3 Pro 1370",
> +	.matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +		DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo YOGA 3"),
> +		},
> +	},
> +	{
> +	.ident = "ZhaoYang K4e-IML",
> +	.matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +		DMI_MATCH(DMI_PRODUCT_VERSION, "ZhaoYang K4e-IML"),
> +		},
> +	},
> +	{}
> +};
> +
>  static void ideapad_check_features(struct ideapad_private *priv)
>  {
>  	acpi_handle handle = priv->adev->handle;
> @@ -1542,6 +1560,7 @@ static void ideapad_check_features(struct ideapad_private *priv)
>  
>  	/* Most ideapads with ELAN0634 touchpad don't use EC touchpad switch */
>  	priv->features.touchpad_ctrl_via_ec = !acpi_dev_present("ELAN0634", NULL, -1);
> +	priv->features.touchpad_ctrl_via_ec = !dmi_check_system(no_touchpad_switch_list);

This needs to be:

	priv->features.touchpad_ctrl_via_ec =
		!acpi_dev_present("ELAN0634", NULL, -1) &&
		!dmi_check_system(no_touchpad_switch_list);

Otherwise you over overriding the results of the ELAN0634 check. Also I wonder if there
is not a better way to check for this (for both cases) ?

Is the touchpad on these devices perhaps connected over I2C ? Maybe we need to figure
out a way to check for that.

Regards,

Hans



>  
>  	if (!read_ec_data(handle, VPCCMD_R_FAN, &val))
>  		priv->features.fan_mode = true;

