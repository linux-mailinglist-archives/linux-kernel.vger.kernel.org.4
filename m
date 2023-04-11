Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73986DD59F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 10:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjDKIcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 04:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjDKIce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 04:32:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9758C30F6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 01:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681201901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ItkPu5HmRlc4/iz29tmuZg74rTfbukbWjoDL5l0uPyo=;
        b=DXo/3GFl7iEUpwTdYlnqFNB5yAw1rh5czm4yU0cpMJ2UIVVyy7yagyasB8FtnqhkwuyLOF
        HaAHl0QjQG9Kyt19SvhghNvQqR2z3HdPajO279e9v4wnhEdj38+VTJk3YtP72FAJTI4Dod
        +AsUdAASo6uQqRItdJ3gaRKTqNz2kAY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-D3S98Zt9OpGtG-98tLU4_g-1; Tue, 11 Apr 2023 04:31:40 -0400
X-MC-Unique: D3S98Zt9OpGtG-98tLU4_g-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-94a34a0f35fso110605366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 01:31:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681201899; x=1683793899;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ItkPu5HmRlc4/iz29tmuZg74rTfbukbWjoDL5l0uPyo=;
        b=Yo4NVrx/ZE6dnZT7PkVFh+11VhW77z8j//FUs6/gKMtvQTIyGPMtP1ocUfOx0m7w12
         J/0PT/Nui+Vv+utclYkHPI8l6RaIhIWvnbWR7rPqkxsd6Fw4XbBNJIf2BZlH+J6B0+6u
         2hTA3Zg/YRSwyfnn5KebHvQOXdjQjHPJbHjSUSKGQGbq4LxbGkWjszWyHnHCkM4sc4LP
         Pl6BuJLLDUHne6lq97UXGHdlcGR71ieLkCoEYcJK7euHU6zec8hryIq7BtbjoNJ+HBlu
         7qbM4hRPxKoJh46ZrTMJcXRCEo0+9X8IN/NODnFYmo5s28Fou+GFHXZv9aeVzemMr5r0
         PT+Q==
X-Gm-Message-State: AAQBX9eLIA502nkfXkvCvpQkAlEpCxXMVlzyHguwj1ZTq0944QSCddHu
        Lkk0PDHQ4aiUD0f7XmXDHKIqv0avzSaloiIC0joOUux42hkgFu3+wYz6AWaLvnFmXHdrmViV2ug
        5kWQjZJksWEe30IOLUiYD5KXS
X-Received: by 2002:aa7:da0f:0:b0:502:20f0:3ee1 with SMTP id r15-20020aa7da0f000000b0050220f03ee1mr9345960eds.31.1681201899284;
        Tue, 11 Apr 2023 01:31:39 -0700 (PDT)
X-Google-Smtp-Source: AKy350YBcpOjnV1i0OhFJebiJlY+OH5eD74YU+5nOjlWnsizOEuKAkrdkzbfC6p7fOWf7QKbAHEk2Q==
X-Received: by 2002:aa7:da0f:0:b0:502:20f0:3ee1 with SMTP id r15-20020aa7da0f000000b0050220f03ee1mr9345940eds.31.1681201899042;
        Tue, 11 Apr 2023 01:31:39 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id x63-20020a50bac5000000b005024aff3bb5sm4422641ede.80.2023.04.11.01.31.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 01:31:38 -0700 (PDT)
Message-ID: <4f609a98-6376-5993-45aa-bb5c6a213a49@redhat.com>
Date:   Tue, 11 Apr 2023 10:31:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/4] platform/x86: gigabyte: constify pointers to
 hwmon_channel_info
Content-Language: en-US, nl
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas@weissschuh.net>,
        Mark Gross <markgross@kernel.org>,
        Jeremy Soller <jeremy@system76.com>,
        System76 Product Development <productdev@system76.com>,
        Azael Avalos <coproscefalo@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
References: <20230407150339.80218-1-krzysztof.kozlowski@linaro.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230407150339.80218-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/7/23 17:03, Krzysztof Kozlowski wrote:
> Statically allocated array of pointed to hwmon_channel_info can be made
> const for safety.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> This depends on hwmon core patch:
> https://lore.kernel.org/all/20230406203103.3011503-2-krzysztof.kozlowski@linaro.org/
> 
> Therefore I propose this should also go via hwmon tree.

Ok, taking all 4 these patches upstream through the hwmon tree
is fine by me, here is my Ack for that:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


p.s.

I'm going to drop these from my patch queue now. If for some
reason merging these through the hwmon tree does not work out,
please resend them after 6.4-rc1 is out (assuming that will
have the pre-requisite patch) and then I'll apply them directly.





> 
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-hwmon@vger.kernel.org
> ---
>  drivers/platform/x86/gigabyte-wmi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/gigabyte-wmi.c b/drivers/platform/x86/gigabyte-wmi.c
> index 5e5b17c50eb6..7cc969fb1beb 100644
> --- a/drivers/platform/x86/gigabyte-wmi.c
> +++ b/drivers/platform/x86/gigabyte-wmi.c
> @@ -99,7 +99,7 @@ static umode_t gigabyte_wmi_hwmon_is_visible(const void *data, enum hwmon_sensor
>  	return usable_sensors_mask & BIT(channel) ? 0444  : 0;
>  }
>  
> -static const struct hwmon_channel_info *gigabyte_wmi_hwmon_info[] = {
> +static const struct hwmon_channel_info * const gigabyte_wmi_hwmon_info[] = {
>  	HWMON_CHANNEL_INFO(temp,
>  			   HWMON_T_INPUT,
>  			   HWMON_T_INPUT,

