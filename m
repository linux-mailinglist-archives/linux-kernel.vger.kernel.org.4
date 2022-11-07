Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3005061EFD0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 10:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbiKGJ7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 04:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbiKGJ7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 04:59:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08266445
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 01:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667815121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ocB3/JaESlGnFWu+4KXgzVI0kjGODb11tWi+uTz3xMM=;
        b=VyaWwl6ClwhZlMLg1F8X6Kwz85fbHvLz8zMNhw9qhBVjvFdq4KcEuJ7Ch+N3V9M+4xc7Af
        ZC9ddoZB/0o/XAspZiUx9NyDFV+9n+yfFw2morjUl7Qc3mEDKezKzX5ai4hcCTovKgvZWL
        nTJcVblkxna+WqhUimNputqeb6QlQUE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-224-28QD9CCfPtS_g2a6WzVNAg-1; Mon, 07 Nov 2022 04:58:39 -0500
X-MC-Unique: 28QD9CCfPtS_g2a6WzVNAg-1
Received: by mail-ej1-f70.google.com with SMTP id jg27-20020a170907971b00b007ad9892f5f6so5986049ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 01:58:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ocB3/JaESlGnFWu+4KXgzVI0kjGODb11tWi+uTz3xMM=;
        b=go1/Rs4t5YJXi/+nSePAEY/ZLFC1a4RgYe540dD9gRphDneAK9EuzCCnkG8bcXgfBx
         4Orbo8ymhfq+m8sHMi+lrlhFUf6A+KIZpGqggNAr+qXPba/+36cpXI7mqQ2bh2wf1Rqf
         TKcCLjYpqq1JppRhLrJk1RMD0aH1sMvs1IHRhji9u3o9bAuTiRNkXLlgEjIyJOkn7fLS
         eOL2WjLRVUyf6uYeLSFA0isucJx5v55sKtxKparnw733kpSr4sp8WloWu43V6AloJMBA
         X8Po7qN3eeB6GPdVIbfDfC+Jso1RtwVyend2UmMm/jQxMZpOVL15MjtZfrstIivEbIVp
         /Ffg==
X-Gm-Message-State: ACrzQf2WSvlfqSgor80xxLwcDiW3+z2ywaOB60JoGyNW+zYteIeC8c9+
        hdOfBjbREEvMKpyrHbgJJoipA6xcJIg49sv4Pg5rdRrYmGfzjQQ6rWSwx3PdxHOxeMIy4JxeUNn
        WRQRX2/xPu4Hjja0dMHYCqApB
X-Received: by 2002:aa7:c302:0:b0:461:85d7:b82 with SMTP id l2-20020aa7c302000000b0046185d70b82mr49582187edq.354.1667815118643;
        Mon, 07 Nov 2022 01:58:38 -0800 (PST)
X-Google-Smtp-Source: AMsMyM602h15ZNCEMTfUkdk0bbgLPAo5SG5zAExOoaqri5L1Ay4y1Heq8qYkpi8O12u1tC0bfgS7nA==
X-Received: by 2002:aa7:c302:0:b0:461:85d7:b82 with SMTP id l2-20020aa7c302000000b0046185d70b82mr49582167edq.354.1667815118405;
        Mon, 07 Nov 2022 01:58:38 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id h20-20020aa7c954000000b00462e4de6891sm3942660edt.35.2022.11.07.01.58.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 01:58:37 -0800 (PST)
Message-ID: <fdceb6d2-c38c-e8ff-4c19-b01521ca46c0@redhat.com>
Date:   Mon, 7 Nov 2022 10:58:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2] platform/x86: ideapad-laptop: Disable touchpad_switch
Content-Language: en-US
To:     Manyi Li <limanyi@uniontech.com>
Cc:     ike.pan@canonical.com, linux-kernel@vger.kernel.org,
        markgross@kernel.org, platform-driver-x86@vger.kernel.org
References: <bade32f9-594c-3efd-d6da-ea6a4a433948@redhat.com>
 <20221018095323.14591-1-limanyi@uniontech.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221018095323.14591-1-limanyi@uniontech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manyi,

On 10/18/22 11:53, Manyi Li wrote:
> Ideapads for "Lenovo Yoga 3 Pro 1370" and "ZhaoYang K4e-IML" do not
> use EC to switch touchpad.
> 
> Reading VPCCMD_R_TOUCHPAD will return zero thus touchpad may be blocked
> unexpectedly.
> 
> Signed-off-by: Manyi Li <limanyi@uniontech.com>

I have applied this patch for now, since it should be safe to do so
as the exceptions added are DMI string based.

But I would really like to see a better fix for this, by for example
checking if the touchpad is connected over I2C. Can you run
"acpidump -o acpidump.txt" and then send me a private email with the
generated acpidump.txt ?   Please do this for both models if possible.

Also I don't entirely understand why this patch is necessary in
the first place. You say that the touchpad is connected over I2C;
and when priv->features.touchpad_ctrl_via_ec = 1 the following
2 commands are possibly run by the driver:

i8042_command(&param, value ? I8042_CMD_AUX_ENABLE : I8042_CMD_AUX_DISABLE);

        if (!priv->features.touchpad_ctrl_via_ec)
                write_ec_cmd(priv->adev->handle, VPCCMD_W_TOUCHPAD, 1);

Note the second command actually gets enabled by this patch setting
priv->features.touchpad_ctrl_via_ec = 0.

What (undesirable) behavior are you seeing without this patch ?

And can you try a kernel without this patch and then comment
out the i8042_command() command and see if that helps ?

If that does not help, can you try removing the "if" part of:

        if (!priv->features.touchpad_ctrl_via_ec)
                write_ec_cmd(priv->adev->handle, VPCCMD_W_TOUCHPAD, 1);

So that the write_ec_cmd() happens unconditionally and see if that
helps ?

Regards,

Hans


> ---
>  drivers/platform/x86/ideapad-laptop.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
> index abd0c81d62c4..33b3dfdd1b08 100644
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
> @@ -1541,7 +1559,12 @@ static void ideapad_check_features(struct ideapad_private *priv)
>  	priv->features.hw_rfkill_switch = dmi_check_system(hw_rfkill_list);
>  
>  	/* Most ideapads with ELAN0634 touchpad don't use EC touchpad switch */
> -	priv->features.touchpad_ctrl_via_ec = !acpi_dev_present("ELAN0634", NULL, -1);
> +	if (acpi_dev_present("ELAN0634", NULL, -1))
> +		priv->features.touchpad_ctrl_via_ec = 0;
> +	else if (dmi_check_system(no_touchpad_switch_list))
> +		priv->features.touchpad_ctrl_via_ec = 0;
> +	else
> +		priv->features.touchpad_ctrl_via_ec = 1;
>  
>  	if (!read_ec_data(handle, VPCCMD_R_FAN, &val))
>  		priv->features.fan_mode = true;

