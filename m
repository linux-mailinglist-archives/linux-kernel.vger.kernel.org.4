Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D191D702E02
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 15:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242008AbjEONXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 09:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233122AbjEONXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 09:23:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092312D60
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 06:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684156955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NqLATVw0o7Eqj8rOIrKMl8B2vhKff2s7T97SXZOmILY=;
        b=TP9I2Ld8KFgAqTYnaktw4o0MA9pwMuQHDhk/1nH9GpQ//jpJCpWQ2H5aCIOt5tErZSmA7s
        4McG/9jXRizAl11zVT7cEJejs/mQ3bgeaeE9ODpS65Qj4Ir/CwLau7cJ8ufR1/6zIM2a9C
        CSnhTAX/49++naf6M3dIuJJi0nhsypk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-VHLL3KeVNRmDn0DQbqnJTw-1; Mon, 15 May 2023 09:22:34 -0400
X-MC-Unique: VHLL3KeVNRmDn0DQbqnJTw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-94a341efd9aso1590844766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 06:22:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684156953; x=1686748953;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NqLATVw0o7Eqj8rOIrKMl8B2vhKff2s7T97SXZOmILY=;
        b=QGql9INOBvtFp2Ej9Pm+kAepXPMVJN/h2a0z8PJDoVe9hgEDXbNWqfiemZ59QY3h1K
         T/OspXGibhl061R0ufBaeNEIOGJ9hQjwpgjM9k/hMGEdcFI8HgZpyEATEjbSbFzejBEH
         YBn1Jal2ynw8/TUYsPUOyhMZKha1XGwlTC+aOfrOulOOwK27A2/mo1FXQiRwxISohkMm
         Br6SdpEkYzAyw/JpwNc/2ePjiB13NbmAFeyPmmG2Y9Y8wYNAHaBuu9sxDIdkgWFuYZXL
         udop/GeVJke4f0jYtaZvmfFNAzbqw7QcASbnIvYbfqu54qFG/OwhF5M4ok0AiXc/rrIO
         10tQ==
X-Gm-Message-State: AC+VfDxT5pX3pUMfZOqKXRmtmYxPZODK+GeDzcdbSBNczdMDpnqb1qbT
        N+jmHkycLhwZk98lT/k6RK6H6rXxHplgWyWmoJqIMEHT4OJHDUZSf/S2eZwFL7A2rn5gkN5dQhg
        v2rrF0C0uo7cN7qNaS/sd93rG
X-Received: by 2002:a17:906:fe44:b0:969:faf3:7dba with SMTP id wz4-20020a170906fe4400b00969faf37dbamr19487512ejb.52.1684156952971;
        Mon, 15 May 2023 06:22:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7piCFoS8XM96vwGW13BfAIXTEyP4aeYkYu3SbfcduU2sTMSpUlzeoyjrnhd0nhytovo0kX/g==
X-Received: by 2002:a17:906:fe44:b0:969:faf3:7dba with SMTP id wz4-20020a170906fe4400b00969faf37dbamr19487485ejb.52.1684156952646;
        Mon, 15 May 2023 06:22:32 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id qo28-20020a170907213c00b00965ddf2e221sm9498777ejb.93.2023.05.15.06.22.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 06:22:32 -0700 (PDT)
Message-ID: <0f8e5fc7-2efb-ceac-ac83-fbc8e7b62d3e@redhat.com>
Date:   Mon, 15 May 2023 15:22:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RESEND PATCH 1/4] platform/x86: gigabyte: constify pointers to
 hwmon_channel_info
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas@weissschuh.net>,
        Mark Gross <markgross@kernel.org>,
        Jeremy Soller <jeremy@system76.com>,
        System76 Product Development <productdev@system76.com>,
        Azael Avalos <coproscefalo@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230511175627.282246-1-krzysztof.kozlowski@linaro.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230511175627.282246-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/11/23 19:56, Krzysztof Kozlowski wrote:
> Statically allocated array of pointers to hwmon_channel_info can be made
> const for safety.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans


> ---
>  drivers/platform/x86/gigabyte-wmi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/gigabyte-wmi.c b/drivers/platform/x86/gigabyte-wmi.c
> index 8aa665e866b8..f6ba88baee4d 100644
> --- a/drivers/platform/x86/gigabyte-wmi.c
> +++ b/drivers/platform/x86/gigabyte-wmi.c
> @@ -94,7 +94,7 @@ static umode_t gigabyte_wmi_hwmon_is_visible(const void *data, enum hwmon_sensor
>  	return usable_sensors_mask & BIT(channel) ? 0444  : 0;
>  }
>  
> -static const struct hwmon_channel_info *gigabyte_wmi_hwmon_info[] = {
> +static const struct hwmon_channel_info * const gigabyte_wmi_hwmon_info[] = {
>  	HWMON_CHANNEL_INFO(temp,
>  			   HWMON_T_INPUT,
>  			   HWMON_T_INPUT,

