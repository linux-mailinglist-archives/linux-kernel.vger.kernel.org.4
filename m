Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765EB69E8E3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 21:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjBUUJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 15:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjBUUJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 15:09:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8242885A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 12:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677010115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=09M2IhNewYa0ZD87pwGV1iriHd9wzWyMm+sZhc4KVgY=;
        b=XBHD4yrj9OzIvGO+VeOK9ayoBtWS4c4Np/Hi2zkJFBB4c/6tGyW+vjPAz3H6X1PwlPcqUX
        /fCpyQkXgi9MrIiW1SgI32tl1waDo8aWgiiyEgvbu+A5Xars6cSkC1b2NEwqCGfL065z2g
        hTNQP9W/Fpckv5HkvbfjNOE62l7DYWE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-556-nBBWx5tgPVacJ_wslnsZYA-1; Tue, 21 Feb 2023 15:08:08 -0500
X-MC-Unique: nBBWx5tgPVacJ_wslnsZYA-1
Received: by mail-ed1-f70.google.com with SMTP id q13-20020a5085cd000000b004af50de0bcfso4936194edh.15
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 12:08:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=09M2IhNewYa0ZD87pwGV1iriHd9wzWyMm+sZhc4KVgY=;
        b=ZXfIRvrgcgNvAifQWT13C4VB4rkkPe/jF8poNdnBM8UVkL08H+1XeN+NSVW4DyoHbv
         Ol2oX07G0muNoWKqSwZPaYDwaF+5tfcVPafBdmTvUVu4vXzuRXrxT5bcViWUaQnOUfYa
         zYLmAhqotxSJ/5zKlDGHsWnR+Tb/pUiDkPShIRPB+QW9b3EGooiMzx5/Aw7MyL0fMFel
         140C2LAyZvrQEkQV9SlJ/hWksxcWXWXWkFbkD4tpvGCj45fECaroPWMlVNQJcl5HNanO
         bUhdZCw4mouupCBkdMR6c0zG8XI6o9RkKylTpyRHMsx4hu9lgHwfWx9Tg1YjvTFnTQs1
         4IvQ==
X-Gm-Message-State: AO0yUKX6Gyp56idd76hXqlmj4GoWx/r8grJt9Q2i6sqteyi9jnfq5ADd
        KOifnxZ5qWWY4cr7X35ceaDy2v2wo/M4TW6UJXeEWUGWZ2CEqUJ/t4KnTtQISdmQn2hZheiMD3Y
        DaHgbVB0OL4ShqXRprK+VyQp7
X-Received: by 2002:a50:ee1a:0:b0:4ad:7c6c:5386 with SMTP id g26-20020a50ee1a000000b004ad7c6c5386mr4666715eds.30.1677010077401;
        Tue, 21 Feb 2023 12:07:57 -0800 (PST)
X-Google-Smtp-Source: AK7set8BGn8xDOhDuov3MkZqm4u3X6uxPdXm6C3Wov/p2iyeV432KODzpfLNtWuyc+AJ4tr0hCdZqg==
X-Received: by 2002:a50:ee1a:0:b0:4ad:7c6c:5386 with SMTP id g26-20020a50ee1a000000b004ad7c6c5386mr4666702eds.30.1677010077206;
        Tue, 21 Feb 2023 12:07:57 -0800 (PST)
Received: from ?IPV6:2001:1c00:2a07:3a01:67e5:daf9:cec0:df6? (2001-1c00-2a07-3a01-67e5-daf9-cec0-0df6.cable.dynamic.v6.ziggo.nl. [2001:1c00:2a07:3a01:67e5:daf9:cec0:df6])
        by smtp.gmail.com with ESMTPSA id e17-20020a50a691000000b004accf3a63cbsm1751767edc.68.2023.02.21.12.07.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 12:07:56 -0800 (PST)
Message-ID: <e2193efe-c001-a56b-8fd4-4485de6b185d@redhat.com>
Date:   Tue, 21 Feb 2023 21:07:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 15/16] thermal/drivers/acerhdf: Remove pointless
 governor test
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Kaestle <peter@piie.net>,
        Mark Gross <markgross@kernel.org>,
        "open list:ACER ASPIRE ONE TEMPERATURE AND FAN DRIVER" 
        <platform-driver-x86@vger.kernel.org>
References: <20230221180710.2781027-1-daniel.lezcano@linaro.org>
 <20230221180710.2781027-16-daniel.lezcano@linaro.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230221180710.2781027-16-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/21/23 19:07, Daniel Lezcano wrote:
> The thermal zone parameter specifies the bang-bang governor.
> 
> The Kconfig selects the bang-bang governor. So it is pointless to test
> if the governor was set for the thermal zone assuming it may not have
> been compiled-in.
> 
> Remove the test and prevent another access into the thermal internals.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Acked-by: Peter Kaestle <peter@piie.net>

Thanks, looks good to me, here is my ack for merging this through
the thermal tree.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/platform/x86/acerhdf.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
> index 61f1c3090867..71b9c1f922d9 100644
> --- a/drivers/platform/x86/acerhdf.c
> +++ b/drivers/platform/x86/acerhdf.c
> @@ -697,13 +697,6 @@ static int __init acerhdf_register_thermal(void)
>  	if (ret)
>  		return ret;
>  
> -	if (strcmp(thz_dev->governor->name,
> -				acerhdf_zone_params.governor_name)) {
> -		pr_err("Didn't get thermal governor %s, perhaps not compiled into thermal subsystem.\n",
> -				acerhdf_zone_params.governor_name);
> -		return -EINVAL;
> -	}
> -
>  	return 0;
>  }
>  

