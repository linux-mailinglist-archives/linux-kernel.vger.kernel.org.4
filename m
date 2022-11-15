Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E5162A2CA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 21:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbiKOU0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 15:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKOU0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 15:26:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2932F29377
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 12:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668543905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w+jTwO2YUQPdNXbClE8d8DPM1GRLBF6qiVx04CuY2M0=;
        b=UjPza62ruXGAJOVAtorm/aoD/BscWuG6ALTRFU4tiRFtT2GlQdK6sMNXCXjKrFoKAF9cVM
        uA1icyEHKSMS/ssJ3RHLIjy2k66UZAZn6ENaMfKgNdQOqyuXiefcP7hoNOmSMBSeDQCRUc
        yJeeyzuNyg0gKoO8svtw7P+Cdb2Z94k=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-290-QDOWa4EaMTaIS1RkTKGGAw-1; Tue, 15 Nov 2022 15:25:03 -0500
X-MC-Unique: QDOWa4EaMTaIS1RkTKGGAw-1
Received: by mail-ed1-f69.google.com with SMTP id x18-20020a05640226d200b00461e027f704so10701305edd.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 12:25:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w+jTwO2YUQPdNXbClE8d8DPM1GRLBF6qiVx04CuY2M0=;
        b=lBCds4c4nX9+O/BYbVronxLri9Tvvr1jePXoQcdcarrfXc8Q2GufIdfZSCE3xZgiar
         ffp7qUiwJN0zYpPIhtikcAMeN7twtVj21a18xs6sv1xSrmuLRWbXd7vBJsW5mC1M/U3r
         AZ8jC+EbbEpMjWkweWhrGRyb3NzY+pR8u3MAOiFsfMMTIoVLXIULtgDq1tVQLd5Xjjy/
         6T/0RYNJfVcgTWlI+1Vkt1COp1ThCDKIKhfmI46nZDFBegBFaoIcwAZHJq/oqviQTMYr
         IqfXKQksJU8FamTteCVsQixdAnF39Q/KndWg88XDeeLK3XQLGjsN70YkWnXAlxZ73hdv
         FLvg==
X-Gm-Message-State: ANoB5plznR/6/c78BmT6WWPx/g5ax/Fh4hysNdLH6vqXVOsS3GIopopY
        cTPVaEz7XXNKuJG691n47t4d049eBordcmKoA+5m33sMpezRqSeNeFhILlA6Jodjl3owEn8jVrz
        UYGkq9SafjziuU0xjavemhTiG
X-Received: by 2002:a17:906:3582:b0:7af:206:9327 with SMTP id o2-20020a170906358200b007af02069327mr8219105ejb.154.1668543902443;
        Tue, 15 Nov 2022 12:25:02 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4gp4N3e2dFr2+urUWGuCnhw7jccoeBirXDd/e1OZzKpGM1yYuqTTyfiq2uvTQ//OOTdRSDOw==
X-Received: by 2002:a17:906:3582:b0:7af:206:9327 with SMTP id o2-20020a170906358200b007af02069327mr8219089ejb.154.1668543902163;
        Tue, 15 Nov 2022 12:25:02 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id b19-20020a056402139300b004637489cf08sm6573124edv.88.2022.11.15.12.25.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 12:25:01 -0800 (PST)
Message-ID: <98fdf126-7cfd-7c9b-2edc-d49f5143c75c@redhat.com>
Date:   Tue, 15 Nov 2022 21:25:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 1/7] Revert "platform/x86: ideapad-laptop: check for
 touchpad support in _CFG"
Content-Language: en-US, nl
To:     =?UTF-8?Q?Eray_Or=c3=a7unus?= <erayorcunus@gmail.com>,
        platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        ike.pan@canonical.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, dmitry.torokhov@gmail.com,
        mgross@linux.intel.com, pobrn@protonmail.com
References: <20221029120311.11152-1-erayorcunus@gmail.com>
 <20221029120311.11152-2-erayorcunus@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221029120311.11152-2-erayorcunus@gmail.com>
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
> Last 8 bit of _CFG started being used in later IdeaPads, thus 30th bit
> doesn't always show whether device supports touchpad or touchpad switch.
> Remove checking bit 30 of _CFG, so older IdeaPads like S10-3 can switch
> touchpad again via touchpad attribute.
> 
> This reverts commit b3ed1b7fe3786c8fe795c16ca07cf3bda67b652f.
> 
> Signed-off-by: Eray Orçunus <erayorcunus@gmail.com>

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
>  drivers/platform/x86/ideapad-laptop.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
> index e7a1299e3776..b67bac457a7a 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -46,11 +46,10 @@ static const char *const ideapad_wmi_fnesc_events[] = {
>  #endif
>  
>  enum {
> -	CFG_CAP_BT_BIT       = 16,
> -	CFG_CAP_3G_BIT       = 17,
> -	CFG_CAP_WIFI_BIT     = 18,
> -	CFG_CAP_CAM_BIT      = 19,
> -	CFG_CAP_TOUCHPAD_BIT = 30,
> +	CFG_CAP_BT_BIT   = 16,
> +	CFG_CAP_3G_BIT   = 17,
> +	CFG_CAP_WIFI_BIT = 18,
> +	CFG_CAP_CAM_BIT  = 19,
>  };
>  
>  enum {
> @@ -367,8 +366,6 @@ static int debugfs_cfg_show(struct seq_file *s, void *data)
>  		seq_puts(s, " wifi");
>  	if (test_bit(CFG_CAP_CAM_BIT, &priv->cfg))
>  		seq_puts(s, " camera");
> -	if (test_bit(CFG_CAP_TOUCHPAD_BIT, &priv->cfg))
> -		seq_puts(s, " touchpad");
>  	seq_puts(s, "\n");
>  
>  	seq_puts(s, "Graphics: ");
> @@ -661,8 +658,7 @@ static umode_t ideapad_is_visible(struct kobject *kobj,
>  	else if (attr == &dev_attr_fn_lock.attr)
>  		supported = priv->features.fn_lock;
>  	else if (attr == &dev_attr_touchpad.attr)
> -		supported = priv->features.touchpad_ctrl_via_ec &&
> -			    test_bit(CFG_CAP_TOUCHPAD_BIT, &priv->cfg);
> +		supported = priv->features.touchpad_ctrl_via_ec;
>  	else if (attr == &dev_attr_usb_charging.attr)
>  		supported = priv->features.usb_charging;
>  

