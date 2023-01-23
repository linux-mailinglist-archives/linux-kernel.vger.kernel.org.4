Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F2E677C90
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 14:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjAWNdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 08:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjAWNdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 08:33:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F2D40FC
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 05:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674480762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4eVcLiMRTNGc9RZrnMABtj5RnG9xY1jbpv8mppSmEp0=;
        b=faiTziSNB8sYnhSUdjeT0Tf3QGn7tzyftN5VsvJPDiLez0NtqmpQ7lZzLYNNryryspLvgv
        Y8h/Z2WPUnOBfMA68oT7ryn9I5XI/QGuio4LRuZdnO0GIl2TVWype+Npe8A+nXkSiESfxI
        YKkYEhdH/xFU5RJQacOvnWWFSLXJL0Y=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-77-33SGcBJcPCuRN8M5okAppA-1; Mon, 23 Jan 2023 08:32:41 -0500
X-MC-Unique: 33SGcBJcPCuRN8M5okAppA-1
Received: by mail-ej1-f71.google.com with SMTP id wz4-20020a170906fe4400b0084c7e7eb6d0so7710493ejb.19
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 05:32:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4eVcLiMRTNGc9RZrnMABtj5RnG9xY1jbpv8mppSmEp0=;
        b=jixa8vdVoIYMsj+X+eXr1rnA2XhUorPYG8BHnOOh2b0JcvXn3CbD7pwhwceJK3j0yA
         uVSsz2UQuNuWG7TOJbowqwIlrAs6lT1ViaCeWQ2AlaIhglBghPWiGrTnSRjkztWK/CWD
         irgc9q9YQ/7JU3piLDbOVJHbfiJmS/tEkJQf7wT4pAySGm3/EuIeeL31XnXW+L9D5Zh6
         BDMwHP2W6jZgxjN6AgQgOurSqmvI93Qw9nyK5oWFvFY82Du00Wk2V7t5oVMkt4OsyAMA
         Y+pCr886Nmo1241ubs3m4a/Ep+lQhmLYlWX5EYq0jy/tZnyzcJsVgDI6irGHYC6ANLNw
         s6og==
X-Gm-Message-State: AFqh2kpUS/yY9pBzNnyMHcnIYhw1LNpjOzzMY0ZHFGhxEQhJg6px8h+X
        9+s9Gl9YfHEVLhDFrIC8Tx1bt6f87HGq9gTnV48nLkQsCmz7ykHhWOyh+uJTipuZPiSsm6smUFn
        ZPBIXOkUAJKkUQx1tokWJ9XFx
X-Received: by 2002:a17:906:4d89:b0:86f:57d3:e3a7 with SMTP id s9-20020a1709064d8900b0086f57d3e3a7mr24278228eju.48.1674480759704;
        Mon, 23 Jan 2023 05:32:39 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvC81R9tZpJ65aMGdZeENwiF1nbY/W2/d3f2eyACNqxIKpMZHfiN5hh5bwE8Q7La81dShIf8g==
X-Received: by 2002:a17:906:4d89:b0:86f:57d3:e3a7 with SMTP id s9-20020a1709064d8900b0086f57d3e3a7mr24278218eju.48.1674480759466;
        Mon, 23 Jan 2023 05:32:39 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id hq15-20020a1709073f0f00b0084c4b87a69csm22111132ejc.153.2023.01.23.05.32.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 05:32:38 -0800 (PST)
Message-ID: <919e1992-e1ca-cc7f-fcc1-23a01993b4b8@redhat.com>
Date:   Mon, 23 Jan 2023 14:32:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] platform/x86: hp-wmi: Handle Omen Key event
Content-Language: en-US
To:     Rishit Bansal <rishitbansal0@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Y8cjgu1ql+5+/NST@rishit-OMEN-Laptop-15-en0xxx>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Y8cjgu1ql+5+/NST@rishit-OMEN-Laptop-15-en0xxx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/17/23 23:38, Rishit Bansal wrote:
> Add support to map the "HP Omen Key" to KEY_PROG2. Laptops in the HP
> Omen Series open the HP Omen Command Center application on windows. But,
> on linux it fails with the following message from the hp-wmi driver:
> 
> [ 5143.415714] hp_wmi: Unknown event_id - 29 - 0x21a5
> 
> Signed-off-by: Rishit Bansal <rishitbansal0@gmail.com>

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
>  drivers/platform/x86/hp/hp-wmi.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
> index 0a99058be813..d8ba3c483901 100644
> --- a/drivers/platform/x86/hp/hp-wmi.c
> +++ b/drivers/platform/x86/hp/hp-wmi.c
> @@ -91,6 +91,7 @@ enum hp_wmi_event_ids {
>  	HPWMI_BATTERY_CHARGE_PERIOD	= 0x10,
>  	HPWMI_SANITIZATION_MODE		= 0x17,
>  	HPWMI_SMART_EXPERIENCE_APP	= 0x21,
> +	HPWMI_OMEN_KEY				= 0x1D,
>  };
>  
>  /*
> @@ -219,6 +220,7 @@ static const struct key_entry hp_wmi_keymap[] = {
>  	{ KE_KEY, 0x21a9,  { KEY_TOUCHPAD_OFF } },
>  	{ KE_KEY, 0x121a9, { KEY_TOUCHPAD_ON } },
>  	{ KE_KEY, 0x231b,  { KEY_HELP } },
> +	{ KE_KEY, 0x21a5,  { KEY_PROG2 }}, /* HP Omen Key */
>  	{ KE_END, 0 }
>  };
>  
> @@ -810,6 +812,7 @@ static void hp_wmi_notify(u32 value, void *context)
>  	case HPWMI_SMART_ADAPTER:
>  		break;
>  	case HPWMI_BEZEL_BUTTON:
> +	case HPWMI_OMEN_KEY:
>  		key_code = hp_wmi_read_int(HPWMI_HOTKEY_QUERY);
>  		if (key_code < 0)
>  			break;

