Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13C75BC9D8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 12:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiISKtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 06:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiISKtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 06:49:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9315826AE0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 03:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663584130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JSVojkQBpDH2ShcQLnYMDETdr3XUdR9J9jflqCVySAY=;
        b=N8O8jYUSHOavVWjyUNP9wcDpJhquX8o88xX3moP1y5UGsMck8zT7/ybL2twfQi1oiOrGOW
        btHZUMoZ8t+iva6IFPvULMuzurftrcOB0orulyVLCwZ2G2ZXc7/PELQ6orui9qWTICIotM
        aZeI/ODLy9Xe3Ep48kDYPZ9gnMjKtWs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-359-ynZEQw_hN-Gw-JHrpt1D7w-1; Mon, 19 Sep 2022 06:42:09 -0400
X-MC-Unique: ynZEQw_hN-Gw-JHrpt1D7w-1
Received: by mail-ej1-f70.google.com with SMTP id qa33-20020a17090786a100b0077a69976d24so9628709ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 03:42:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=JSVojkQBpDH2ShcQLnYMDETdr3XUdR9J9jflqCVySAY=;
        b=c17oAj21sutkCdEnKWvsHvKQZ8sd8tm6wpAIfdH4yG9KvVwDemQYpGgjEwDdV5FCMh
         GCp8hBRmZcRt5SEV2MUB+g1r+mHXbIjpSINyIRImBEi73L1OBw79JuErnfcY4yXhzJtl
         rMnyWhLzTxiCW7q09pSiXDHzpBYEc6n1V5eCjyu/JmR5mq1ujihAckhtP1MiToNgyos3
         lyJywFilXvMkrRACZxep/9cj/HvizFLNRctt+iGqSQJ9dknF1PI13EdJJloxt6Vr9VrC
         3/J4HwV8QZPcDwO9DDitCftTTpUTnbYL/vnuStJkgGUbvV58zMwc8Z4xDTKlHh7QG9kt
         Qh1Q==
X-Gm-Message-State: ACrzQf3YaBfCzkv6EMLFInngSP3HeswZWve6+7n6XO1ZMChq1mNdPZ7I
        I6CiAz/kans2SKORQEXfFWg4kD+0HaZlrBmmSeq9sSZeZOe9mT7K1y3qoIHnf0+2K5xbDG/Ja6R
        Pq2Vv80eYDi4Vkhcr1gPX2z1G
X-Received: by 2002:a17:906:9b87:b0:733:1795:2855 with SMTP id dd7-20020a1709069b8700b0073317952855mr12730726ejc.156.1663584128566;
        Mon, 19 Sep 2022 03:42:08 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5E9hdTB/zsLiGdHYHGyIfVoWOwYCxo8G7tzx2zblspy+LiFeQDC3v4aeLe3BLK8FnDMRB/wA==
X-Received: by 2002:a17:906:9b87:b0:733:1795:2855 with SMTP id dd7-20020a1709069b8700b0073317952855mr12730715ejc.156.1663584128354;
        Mon, 19 Sep 2022 03:42:08 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id bs11-20020a170906d1cb00b00738467f743dsm9924874ejb.5.2022.09.19.03.42.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 03:42:07 -0700 (PDT)
Message-ID: <f8fa6d10-6eb1-7fa7-80eb-ea190d29ba4a@redhat.com>
Date:   Mon, 19 Sep 2022 11:42:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH 1/5] ACPI: battery: Do not unload battery hooks on single
 error
Content-Language: en-US
To:     Armin Wolf <W_Armin@gmx.de>, markgross@kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, hmh@hmh.eng.br,
        matan@svgalib.org, corentin.chary@gmail.com, jeremy@system76.com,
        productdev@system76.com, platform-driver-x86@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220912125342.7395-1-W_Armin@gmx.de>
 <20220912125342.7395-2-W_Armin@gmx.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220912125342.7395-2-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/12/22 13:53, Armin Wolf wrote:
> Currently, battery hooks are being unloaded if they return
> an error when adding a single battery.
> This however also causes the removal of successfully added
> hooks if they return -ENODEV for a single unsupported
> battery.
> 
> Do not unload battery hooks in such cases since the hook
> handles any cleanup actions.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Maybe instead of removing all error checking, allow -ENODEV
and behave as before when the error is not -ENODEV ?

Otherwise we should probably make the add / remove callbacks
void to indicate that any errors are ignored.

Rafael, do you have any opinion on this?

Regards,

Hans

> ---
>  drivers/acpi/battery.c | 24 +++---------------------
>  1 file changed, 3 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 306513fec1e1..e59c261c7c59 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -724,20 +724,10 @@ void battery_hook_register(struct acpi_battery_hook *hook)
>  	 * its attributes.
>  	 */
>  	list_for_each_entry(battery, &acpi_battery_list, list) {
> -		if (hook->add_battery(battery->bat)) {
> -			/*
> -			 * If a add-battery returns non-zero,
> -			 * the registration of the extension has failed,
> -			 * and we will not add it to the list of loaded
> -			 * hooks.
> -			 */
> -			pr_err("extension failed to load: %s", hook->name);
> -			__battery_hook_unregister(hook, 0);
> -			goto end;
> -		}
> +		hook->add_battery(battery->bat);
>  	}
>  	pr_info("new extension: %s\n", hook->name);
> -end:
> +
>  	mutex_unlock(&hook_mutex);
>  }
>  EXPORT_SYMBOL_GPL(battery_hook_register);
> @@ -762,15 +752,7 @@ static void battery_hook_add_battery(struct acpi_battery *battery)
>  	 * during the battery module initialization.
>  	 */
>  	list_for_each_entry_safe(hook_node, tmp, &battery_hook_list, list) {
> -		if (hook_node->add_battery(battery->bat)) {
> -			/*
> -			 * The notification of the extensions has failed, to
> -			 * prevent further errors we will unload the extension.
> -			 */
> -			pr_err("error in extension, unloading: %s",
> -					hook_node->name);
> -			__battery_hook_unregister(hook_node, 0);
> -		}
> +		hook_node->add_battery(battery->bat);
>  	}
>  	mutex_unlock(&hook_mutex);
>  }
> --
> 2.30.2
> 

