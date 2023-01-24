Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58772679889
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 13:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbjAXMvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 07:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjAXMvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 07:51:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4866182
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 04:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674564515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mKlGGN/Cv/e/LCDkUt1uykWKamvG2Ui1ifnCT6XaOdM=;
        b=jO1FbBraUjza6PFxu53p6dZgo6PdL4ggeAeYVH7RuPEuXV0cHB8Hmz8EnkV31aeBJqSxiI
        TvAfsZouLo7KDwxtpX4kMcjRBjg86Kb5k1OhoQ3B/CBti+2YENmr3DdqM4cWHIJOlaRvHT
        3nWOlwFLjmilenJ0cBTvDmX2hy4Vw2c=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-641-3cNk3hH2O5qtnyApOK1X-A-1; Tue, 24 Jan 2023 07:48:34 -0500
X-MC-Unique: 3cNk3hH2O5qtnyApOK1X-A-1
Received: by mail-ej1-f70.google.com with SMTP id gb18-20020a170907961200b008715e951f02so9817369ejc.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 04:48:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mKlGGN/Cv/e/LCDkUt1uykWKamvG2Ui1ifnCT6XaOdM=;
        b=QAYpvUy7LJhdttlX9i1+/CWRKi6/sfFRchbSbMQBC8qP8tWdx7jxgWkQN+NZ37Pbtd
         bzUmW2dXthYUfD7mmxk/TQoDbx/cn6G1ii9omqcd5kF9sgM9sriuBdEaJlc4KdA2DqKL
         b1dpk0ad5dOP3eyYA9JRxshrFqOcY1wxp09bAkJsxIaJ3synQFFEfh2L6Maz1oaWCdsU
         bWX6cUP3B8r0uImBoYgj/QFxTrSKVQJDUMzk9k/CBMAUQ5RcLbhX6vhHb+Ady6fvh5ll
         9VZ6+oyL1smc6fvTF6Cr5KCsM8DqNacrZ4Z/3AoqBP7wyGuMQsErhj8zTayEsDA8+nRU
         c0AQ==
X-Gm-Message-State: AFqh2kq2BgSri0Iyrh8MCXZMashPMnsProWwNCrTCfjWSP7LZVgW8eGr
        PCYFVmh8ugJ0F4pBs3Asp9Z5ol3+2TpyP4J/FO90OBMQpFStlduCBtMD/RDtisFFkoZEdcxvkHw
        L+Wx3NNjO/zEPiFyPvzOYhRUh
X-Received: by 2002:a17:906:4557:b0:84d:3a95:cdf5 with SMTP id s23-20020a170906455700b0084d3a95cdf5mr27820475ejq.10.1674564513148;
        Tue, 24 Jan 2023 04:48:33 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuwf/QaQ7ssTfZKYy6xP8WjtnjSROX4nzzKhPAhI8xZEqFVaTmzVbtai61Rp493mGogj1b/Iw==
X-Received: by 2002:a17:906:4557:b0:84d:3a95:cdf5 with SMTP id s23-20020a170906455700b0084d3a95cdf5mr27820466ejq.10.1674564512969;
        Tue, 24 Jan 2023 04:48:32 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id m23-20020a1709060d9700b007aef930360asm861276eji.59.2023.01.24.04.48.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 04:48:32 -0800 (PST)
Message-ID: <73853dc1-e925-de93-aefa-aebc1a23ccc2@redhat.com>
Date:   Tue, 24 Jan 2023 13:48:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] platform/x86: hp-wmi: Ignore Win-Lock key events
Content-Language: en-US, nl
To:     Rishit Bansal <rishitbansal0@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230123214150.62597-1-rishitbansal0@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230123214150.62597-1-rishitbansal0@gmail.com>
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

On 1/23/23 22:41, Rishit Bansal wrote:
> Follow up from https://lore.kernel.org/all/20230120221214.24426-1-rishitbansal0@gmail.com/
> 
> There is a "Win-Lock" key on HP Omen Laptops which supports
> enabling and disabling the Windows key, which trigger commands 0x21a4
> and 0x121a4 respectively. Currently the hp-wmi driver throws warnings
> for this event. These can be ignored using KE_IGNORE as the
> functionality is handled by the keyboard firmware itself.
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
>  drivers/platform/x86/hp/hp-wmi.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
> index 0a99058be813..009cf0bda756 100644
> --- a/drivers/platform/x86/hp/hp-wmi.c
> +++ b/drivers/platform/x86/hp/hp-wmi.c
> @@ -216,6 +216,8 @@ static const struct key_entry hp_wmi_keymap[] = {
>  	{ KE_KEY, 0x213b,  { KEY_INFO } },
>  	{ KE_KEY, 0x2169,  { KEY_ROTATE_DISPLAY } },
>  	{ KE_KEY, 0x216a,  { KEY_SETUP } },
> +	{ KE_IGNORE, 0x21a4, }, /* Win Lock On */
> +	{ KE_IGNORE, 0x121a4, }, /* Win Lock Off */
>  	{ KE_KEY, 0x21a9,  { KEY_TOUCHPAD_OFF } },
>  	{ KE_KEY, 0x121a9, { KEY_TOUCHPAD_ON } },
>  	{ KE_KEY, 0x231b,  { KEY_HELP } },

