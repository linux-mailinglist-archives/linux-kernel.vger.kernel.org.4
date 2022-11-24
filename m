Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D02637B65
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 15:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiKXOZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 09:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiKXOZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 09:25:50 -0500
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E83DE916E;
        Thu, 24 Nov 2022 06:25:49 -0800 (PST)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-142faa7a207so2093789fac.13;
        Thu, 24 Nov 2022 06:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=G0seaWCJr0rZft9EeeuiEnWPhmbWkWE4CXIZfPXM7JE=;
        b=E3kLvXGg7O0J0NaUJEu/KRv8ngt85hS/uECUOAIk47ks/cTXyFztdp3U+61Jt2TUu1
         zZFXY1Xz6tfxvL8b/7MPwkWfEqkH12yKYqQxGFSS2gcvjB03FJAMB5m5HQIniZX3kscR
         OHJ8/tz5MBwRCk3PNGmJAz1qkivxZYGiTlsGVX4pVfhNFTiCiWlQYFLDT4YEbmoWgQCN
         E8VGnHO3Ti7+HeiBjqnAy/UD4/vqoXIq5mDdP6G/UI+bd6/MQxf1822E20/6C4XYYVGD
         1gVC2vbt/f1qZIc26ThVmtLzaRTZdFRh1azPyW856xWD/Ze9pgjMOCI7AxGFFFGE1C76
         yFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G0seaWCJr0rZft9EeeuiEnWPhmbWkWE4CXIZfPXM7JE=;
        b=3TOG2yffZ/ZqT9mecHklGLQZGYH3VLEQFjKlVf/mHE+N0DDlVBKnRowu2f3CkrpP+i
         jEQOcqAoosDOzwXzUSut8tENIo9lFrUg56/v4ptacNmBcYJ5jfRSRgtEz8r5MPhLdj5m
         IfI+vQjClLD7L1RtnJVuj5+W/64ldcLX659/wwpRnkpDhYSsqId+mF4qxQ6Rtz2ZH05E
         GRlQ/cR2sC1s+wap0609Jf5eHjjP2/gzz1jbctQOnjjUWzNLG1MkzhX/K/YIQ83urba+
         xFqmgqfDEoq8u27b6/wrdM+fbPgtCVggB5ts2dhRwQZwKC1hvgOeZaBCuUxsRKwxlf53
         kYeQ==
X-Gm-Message-State: ANoB5pk/yBqffJjP+ys/rQ10tBMOvrfjfYsm66WlZR7FDTN3wpJwsbEY
        DuymZvK2u4s0XfI6TJujA333QzeUUAU=
X-Google-Smtp-Source: AA0mqf62c4t6IW8419fFzYaadU99XdDou5UmXmKwTos7NykJdpWzP8bnvfXnTERbaV/Suk8I0w/vcQ==
X-Received: by 2002:a05:6870:ed44:b0:142:e804:b2b with SMTP id ex4-20020a056870ed4400b00142e8040b2bmr10997061oab.122.1669299948510;
        Thu, 24 Nov 2022 06:25:48 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r2-20020a9d5cc2000000b00661948e6119sm432949oti.47.2022.11.24.06.25.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 06:25:48 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c5fbff9f-6fad-fb1d-17a1-9d7da7761c4f@roeck-us.net>
Date:   Thu, 24 Nov 2022 06:25:46 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH V2 1/3] Modify to support Phytium FT2000/4 CPU for acpi
Content-Language: en-US
To:     Wang Honghui <honghui.wang@ucas.com.cn>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <9CAB43B4193E4C62+Y37kSTHfZuJeOvI8@TP-P15V.lan>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <9CAB43B4193E4C62+Y37kSTHfZuJeOvI8@TP-P15V.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/22 19:26, Wang Honghui wrote:
> Modify to support Phytium FT2000/4 CPU for acpi
> 
> Signed-off-by: Wang Honghui <honghui.wang@ucas.com.cn>
> ---
>   drivers/hwmon/scpi-hwmon.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hwmon/scpi-hwmon.c b/drivers/hwmon/scpi-hwmon.c
> index 6021ae00b334..a6ee9806e47e 100644
> --- a/drivers/hwmon/scpi-hwmon.c
> +++ b/drivers/hwmon/scpi-hwmon.c
> @@ -316,6 +316,7 @@ static struct platform_driver scpi_hwmon_platdrv = {
>   	.driver = {
>   		.name	= "scpi-hwmon",
>   		.of_match_table = scpi_of_match,
> +		.acpi_match_table = scpi_sensors_acpi_match,
>   	},
>   	.probe		= scpi_hwmon_probe,
>   };


This patch on its own doesn't make sense. It seems to be a fix of v1, not
a new version of v1. Your subject lines are off. Modify what ?
The subject should be something like "hwmon: (scpi) Add ACPI support for...".

Guenter

