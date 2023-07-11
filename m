Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D7A74F882
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 21:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbjGKTqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 15:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGKTqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 15:46:03 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DEBB19B;
        Tue, 11 Jul 2023 12:46:02 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5774335bb2aso67664197b3.0;
        Tue, 11 Jul 2023 12:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689104762; x=1691696762;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Vbgm71YcKlV+YwM9EntZJb3Xj8SWJ9W9vOrlGUOSBzc=;
        b=A6qtKSvB/9gZX9OW2mjIz4SJhhtmErMvXPNYWQwDrtRLwW+lNP+W7vVdrgX+FfAv5d
         iKNIb1UC6oWO5dxM5vLnPmE5dzPjR43cOJOBKFyNWY7AlF6eLUJWp0hDqMuR9/cCZei7
         4q+tdVDauiBjXl9N9G6IwCechUfmG6atpiJMl7kIcRQ20Azf3Dzye1gdaEAD/aY3xyYw
         PqpRQCN4zYeCk8OrgrY2d+rfaq65uIFZY1z8Q1XnB9hqBVu2Yh+MJaYu7GiX98hY8smI
         i6c3MdO6OR9kcCxzMyHvXZQYp0nnaj4IcQZpkBTFW4m5kCQdqqFf+Xo2oZT+H7nfi3jo
         6SHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689104762; x=1691696762;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vbgm71YcKlV+YwM9EntZJb3Xj8SWJ9W9vOrlGUOSBzc=;
        b=R+FNazE/2mkqTHu54iI8xj7d9JaiJEMSOiretu7fRjDX82b2tFgI3dnUQg8NM5CdbX
         89H1mQbUU+EyFSqZAUHSsNlkYDsImSy+0I3GUSeMJpOJENws9J9UmLfePwKBVPhySxGH
         tX+1YYg67lMuN0x6Sk8lCHtlr3YtCqsxfaj+60cVi9p92RqsKFe6jNPNK4UtAYvfhLup
         j2QaOTwm+qYEt84ZIx4TD9CNu3MX6cywRgTur3GGaCpuF6mUEv/uc5D2pvLhF0Xq/xKL
         J6umrP+xR4BpMjEu/HjBrSKFUtGBr2YKbXLBN23KyZ7oiuuTsUjwMLFGjwi5QJJg0vmC
         HY1g==
X-Gm-Message-State: ABy/qLaKvdzRRoIEJYyEc1t/12TjyS1RIJXDN+DL8bNPRNEwEg5miPKo
        9w5lrpBq4txKwSB8wvrhORciUyLCayU=
X-Google-Smtp-Source: APBJJlFWE1ggzUUM93UXB866EFOMNtcYY422yc1ghyjfHPxS+R2NG4Spv2ULbXsNOWRfYCDb4knbMQ==
X-Received: by 2002:a0d:de06:0:b0:56d:de2:94d1 with SMTP id h6-20020a0dde06000000b0056d0de294d1mr16935452ywe.24.1689104761836;
        Tue, 11 Jul 2023 12:46:01 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m67-20020a0dfc46000000b00579e8c7e478sm750195ywf.43.2023.07.11.12.46.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 12:46:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <36752432-52e7-22e1-a2de-332749aa15a1@roeck-us.net>
Date:   Tue, 11 Jul 2023 12:45:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/3] peci: Add Intel Sapphire Rapids support
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        iwona.winiarska@intel.com, jdelvare@suse.com
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        openbmc@lists.ozlabs.org
References: <20230711160452.818914-1-Naresh.Solanki@9elements.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230711160452.818914-1-Naresh.Solanki@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/23 09:04, Naresh Solanki wrote:
> Add support for detection of Intel Sapphire Rapids processor based on
> CPU family & model.
> 
> Sapphire Rapids Xeon processors with the family set to 6 and the
> model set to INTEL_FAM6_SAPPHIRERAPIDS_X. The data field for this entry
> is "spr".
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>

Please version your patches and provide change logs.

Guenter

> ---
>   drivers/peci/cpu.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/peci/cpu.c b/drivers/peci/cpu.c
> index de4a7b3e5966..3668a908d259 100644
> --- a/drivers/peci/cpu.c
> +++ b/drivers/peci/cpu.c
> @@ -318,6 +318,11 @@ static const struct peci_device_id peci_cpu_device_ids[] = {
>   		.model	= INTEL_FAM6_ICELAKE_X,
>   		.data	= "icx",
>   	},
> +	{ /* Sapphire Rapids Xeon */
> +		.family	= 6,
> +		.model	= INTEL_FAM6_SAPPHIRERAPIDS_X,
> +		.data	= "spr",
> +	},
>   	{ /* Icelake Xeon D */
>   		.family	= 6,
>   		.model	= INTEL_FAM6_ICELAKE_D,
> 
> base-commit: 4dbbaf8fbdbd13adc80731b2452257857e4c2d8b

