Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA78609DAD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 11:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbiJXJPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 05:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbiJXJPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 05:15:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F120C32ED7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 02:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666602875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8lWODoWZnRqtC12d+wZFs3iIp9P89f0r1Un2s48tNuM=;
        b=KDdgIHHvMPtKtd6xwmSDoCtwUh7rharSLdcE+t6D/Grbhg2veyaJeXvuBC03SqdJeAGyz3
        GN+z6UN3h4rGvRJAdfnENoCOGqU/hs0HqraHvLRnzUOwiWzTUDk0Jsx6hBMaunpuHnx4YM
        wzd1AUdR0jUibgcf+KEx2Igc/V1sm7A=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-625-Uk6pF5IpM1W8TfbmIbUE5Q-1; Mon, 24 Oct 2022 05:14:32 -0400
X-MC-Unique: Uk6pF5IpM1W8TfbmIbUE5Q-1
Received: by mail-ed1-f69.google.com with SMTP id s8-20020a056402520800b0045cab560d5eso8960669edd.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 02:14:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8lWODoWZnRqtC12d+wZFs3iIp9P89f0r1Un2s48tNuM=;
        b=Vb8SRK1kO8BAlrwpcpVwW5CZsflqq4ss093miUyQxvl7k8681gUZOMfNhbXJrldSG4
         zAiQMXVsgEWVVYBSrl4ninHGP8IEAYGs7NcI6H1xGwYaMQ5EyPi8/49xJAX0soO3bH8N
         Eq/hb4zJDydBvANFDnpJ9ZsP+2IIwfdCIZOfrMe2ItyBl7onA46SM/QbVGVlNbq/p8eb
         EIkGkPq0QxVw64Nr4zPs8gobF8jBMQyCO6uWLgFkMKpajYZr4tH+OAT0Vikl/VaywDR5
         IofA+/VfJVQscAXXoscSNlC2jXCfqpO9t5OldnXszIrSTgiU+csy9pRqt26J5bgZLo1g
         jolA==
X-Gm-Message-State: ACrzQf21Vy7eqVY1stnphSAscOlP8cr/uInL/JcityXjQ40thz2ho+2a
        UU7kvKWXJbx+tpQdLrp1mpbZFJs3CpakT9wrlh1wwRrZQJgksTz8iIsI76haODPTpsWqy1CJYqz
        NsK20HF2IeXVfjLQDcv2HeZva
X-Received: by 2002:a05:6402:370c:b0:453:9fab:1b53 with SMTP id ek12-20020a056402370c00b004539fab1b53mr30618944edb.28.1666602870637;
        Mon, 24 Oct 2022 02:14:30 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7NanSWOe2AXX1Vi9rAcrbIXDV0Q9DpnrBssdF9VlIra3Ry/KQhotHLoadCZtQi1xoEhqq1IA==
X-Received: by 2002:a17:906:fe45:b0:791:9624:9ea4 with SMTP id wz5-20020a170906fe4500b0079196249ea4mr26873373ejb.147.1666602860112;
        Mon, 24 Oct 2022 02:14:20 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id y11-20020a1709060a8b00b00788c622fa2csm15299822ejf.135.2022.10.24.02.14.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 02:14:19 -0700 (PDT)
Message-ID: <ada4b32a-97c6-b15d-e3f8-85c64ddba7d1@redhat.com>
Date:   Mon, 24 Oct 2022 11:14:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] platform/x86: asus-wmi: Add support for ROG X16 tablet
 mode
Content-Language: en-US
To:     "Luke D. Jones" <luke@ljones.dev>, linux-kernel@vger.kernel.org
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org
References: <20221010063009.32293-1-luke@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221010063009.32293-1-luke@ljones.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/10/22 08:30, Luke D. Jones wrote:
> Add quirk for ASUS ROG X16 Flow 2-in-1 to enable tablet mode with
> lid flip (all screen rotations).
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>

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
>  drivers/platform/x86/asus-nb-wmi.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
> index 613c45c9fbe3..c685a705b73d 100644
> --- a/drivers/platform/x86/asus-nb-wmi.c
> +++ b/drivers/platform/x86/asus-nb-wmi.c
> @@ -464,6 +464,15 @@ static const struct dmi_system_id asus_quirks[] = {
>  		},
>  		.driver_data = &quirk_asus_tablet_mode,
>  	},
> +	{
> +		.callback = dmi_matched,
> +		.ident = "ASUS ROG FLOW X16",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "GV601R"),
> +		},
> +		.driver_data = &quirk_asus_tablet_mode,
> +	},
>  	{},
>  };
>  

