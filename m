Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63A662A3AB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 22:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiKOVCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 16:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238576AbiKOVB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 16:01:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CEB31357
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 13:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668546052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qayv+b0uuecedAlRVGTipngS65XMONYqcoB5EKtgL3g=;
        b=ffSyyO/Oo4ela01UDuJqgrIIBJ24LJZdeyrdgUIoZZTfP5djVylSyBmyRyvUsO31yhl5zI
        9SESzBgWoXDCSY/SnL89Plkpvv7lQdRFX2ojrW/Hd/CEHPdmRFDZcpXciXR071vo7nA2a3
        gfUfGtSP5HnJqzdN84eN8oZamvRc8mU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-633-BeW2ak9FNVi_UP25xKnRIw-1; Tue, 15 Nov 2022 16:00:50 -0500
X-MC-Unique: BeW2ak9FNVi_UP25xKnRIw-1
Received: by mail-ed1-f71.google.com with SMTP id v18-20020a056402349200b004622e273bbbso10771260edc.14
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 13:00:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qayv+b0uuecedAlRVGTipngS65XMONYqcoB5EKtgL3g=;
        b=aUiNZpwTCvvFQZNtgLBzPK2VAOG/HMyqy/dmSS4+qVJpDZ9tDQSNVpKCY44Jvnh472
         wwUh1xvxFHYwvDacCoqnMLOShgIc65WqQLG1Oy5e/K6tmSLFZBzgrkHy81EOiQgK9J2f
         tWskTMDX5/Yv/+Pon/hizpZaL+a9jUgWTQwUJ5rNz6jwQKMjy9YbjRksFiqfQuZGWuWn
         ZFkA/N/CjGvXCJXGclpYaUX1tTMCWD74xC1jXfWk5CY4AZr+lr9pokXggOb1a7K7NyKK
         JiyDSXl6weVnn1vzx+AVVbxOvjnU7R7jGCfRKlBI01DCWyMOqDKeVLZcyPRuSEUIfd9U
         hBzA==
X-Gm-Message-State: ANoB5pndB2IAXAqZR2uRd15pizIziR2TW8ok81nLQf+7cgcOawS566fp
        puSTOulwudGULwE1b7E9nrvq3qv48V1AxCiNh1iexX7nqxRHh65VI2mmiL7bekcWOerbosLGdNn
        CMvP9mvmNHmH4dM97kv1zxNFJ
X-Received: by 2002:aa7:d759:0:b0:463:fec2:dfb1 with SMTP id a25-20020aa7d759000000b00463fec2dfb1mr16939548eds.303.1668546049697;
        Tue, 15 Nov 2022 13:00:49 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7W8nUz5KKt4LOr3lxVyJlBMdv9+vKykTmiEnQsfFkRK8ms8y/lnAwUUPx3SXV5KTT3Bn+Oig==
X-Received: by 2002:aa7:d759:0:b0:463:fec2:dfb1 with SMTP id a25-20020aa7d759000000b00463fec2dfb1mr16939536eds.303.1668546049505;
        Tue, 15 Nov 2022 13:00:49 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id h7-20020a17090619c700b0078d4c72e2cesm5956786ejd.44.2022.11.15.13.00.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 13:00:49 -0800 (PST)
Message-ID: <bb58d54a-446b-5f4e-4bca-aaddfad29927@redhat.com>
Date:   Tue, 15 Nov 2022 22:00:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 7/7] platform/x86: ideapad-laptop: Don't expose
 touchpad attr on IdeaPads with SYNA2B33
Content-Language: en-US, nl
To:     =?UTF-8?Q?Eray_Or=c3=a7unus?= <erayorcunus@gmail.com>,
        platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        ike.pan@canonical.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, dmitry.torokhov@gmail.com,
        mgross@linux.intel.com, pobrn@protonmail.com
References: <20221029120311.11152-1-erayorcunus@gmail.com>
 <20221029120311.11152-8-erayorcunus@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221029120311.11152-8-erayorcunus@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/29/22 14:03, Eray Orçunus wrote:
> My 520-15IKB (2017) with SYNA2B33 doesn't have working VPCCMD_W_TOUCHPAD command -
> it's the touchpad program switches the touchpad instead on Windows. Considering
> all IdeaPads with SYNA2B33 touchpad produced in 2017/2018, it's very likely that
> none of the IdeaPads with SYNA2B33 support touchpad switching via EC. So let's
> add SYNA2B33 to the touchpads not switchable via EC.
> 
> Signed-off-by: Eray Orçunus <erayorcunus@gmail.com>

As already discussed in the other thread I'm not sure this is the best way to
go about this, lets continue discussing this in the other thread.

Regards,

Hans


> ---
>  drivers/platform/x86/ideapad-laptop.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
> index b34fbc4d741c..937126c62a14 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -1621,8 +1621,12 @@ static void ideapad_check_features(struct ideapad_private *priv)
>  				"Could not find PCI* node in the namespace\n");
>  	}
>  
> -	/* Most ideapads with ELAN0634 touchpad don't use EC touchpad switch */
> -	priv->features.touchpad_ctrl_via_ec = !acpi_dev_present("ELAN0634", NULL, -1);
> +	/*
> +	 * Most ideapads with ELAN0634 and SYNA2B33 touchpads don't use
> +	 * EC touchpad switch
> +	 */
> +	priv->features.touchpad_ctrl_via_ec = !acpi_dev_present("ELAN0634", NULL, -1) &&
> +					      !acpi_dev_present("SYNA2B33", NULL, -1);
>  
>  	if (!read_ec_data(handle, VPCCMD_R_FAN, &val))
>  		priv->features.fan_mode = true;

