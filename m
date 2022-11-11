Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE899626098
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 18:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbiKKRlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 12:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233739AbiKKRlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 12:41:10 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E215BD7E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 09:41:08 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id j15so7392791wrq.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 09:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mQc+U+ReOM3592berIYh4DDWOlLrLRncNp+/Rgp1ZZs=;
        b=qD0B09wf7UHL9mhONRodDsVbaRoUAjow92r3KBk/2/qCJg1msjT98Mn9Yv2QQ36rFD
         yxArxqutuRDKyyhlLqPxTcPvcTyGX2qtJrcu7Q453WuzG+SpOjGKElJxp3iSsMcUXuNi
         AYZV3ev54k1iS/hqXeqLX3xqXjGO9I6Zdp899hBgLK4BySunsXz0EiIC/lmHeKoXoygz
         584TbIISjqH1fONWSqhrCyF9bF9bu0ps7sEI5Etcuxu98BBGU5p123488oJwzgtmo4Q8
         bemMzewYgLKcsHGdS4OfnaSSBIkbVB+hjr/Y4chW08q8tf4q4fA++IXyPsLKvzWN2Hvf
         DRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mQc+U+ReOM3592berIYh4DDWOlLrLRncNp+/Rgp1ZZs=;
        b=4M0khkVzFQ3+A+S4Z84RqdRiH7WTAPmXDh3rYKr47zuBtcLi5LwJf/QEUGB7tpLgs0
         grJbZdh8rCH6wkrFD8rqo0llMcykkkMiMwOO2lse6qE0Xt2QqldKj/BYCKKnR3isr8sT
         /pzDE4DQon0+h8sfto09H9cX8E5m++Rx37Ts5Iz0plgyRb8YiI5ESejwSu8CGQ+W/RG0
         aq9NTB59uvTpHlPDXwXJngvgYYg358Iq1/sZS2d0cmLOtvlK/Ux0Ukz///dHt5CrkFL4
         v2qFeaJjix8PK1Ve0SN3lACAOoKuU6iXrj8u42eaxmb9sk757e5MrTnrRRgtkKoOHxtj
         oHbQ==
X-Gm-Message-State: ANoB5pncdorLMKt2OlAWK3mQIGAF4k7dVCyZvi5QMri3VMJuOczNX8se
        ht3tNmhjb0GJ6IJCC3GrrbsXu49cu24bvw==
X-Google-Smtp-Source: AA0mqf6QO76za2P4oaMRZoftFq7eyzPIZDvRx6LunCq/U3sq1PQ7aD6AzATfW75e8cMvraWxdO7MQg==
X-Received: by 2002:adf:dbcc:0:b0:22e:4481:4a4 with SMTP id e12-20020adfdbcc000000b0022e448104a4mr1987440wrj.450.1668188466845;
        Fri, 11 Nov 2022 09:41:06 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id m16-20020a05600c3b1000b003a3170a7af9sm3968642wms.4.2022.11.11.09.41.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 09:41:06 -0800 (PST)
Message-ID: <57f10c5d-2a71-7f8d-e2ab-6e868d8ba79b@linaro.org>
Date:   Fri, 11 Nov 2022 17:41:05 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] nvmem: u-boot-env: align endianness of crc32 values
Content-Language: en-US
To:     INAGAKI Hiroshi <musashino.open@gmail.com>, rafal@milecki.pl
Cc:     linux-kernel@vger.kernel.org
References: <20221012155133.287-1-musashino.open@gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20221012155133.287-1-musashino.open@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/10/2022 16:51, INAGAKI Hiroshi wrote:
> This patch fixes crc32 error on Big-Endianness system by conversion of
> calculated crc32 value.
> 
> Little-Endianness system:
> 
>    obtained crc32: Little
> calculated crc32: Little
> 
> Big-Endianness system:
> 
>    obtained crc32: Little
> calculated crc32: Big
> 
> log (APRESIA ApresiaLightGS120GT-SS, RTL8382M, Big-Endianness):
> 
> [    8.570000] u_boot_env 18001200.spi:flash@0:partitions:partition@c0000: Invalid calculated CRC32: 0x88cd6f09 (expected: 0x096fcd88)
> [    8.580000] u_boot_env: probe of 18001200.spi:flash@0:partitions:partition@c0000 failed with error -22
> 
> Fixes: f955dc1445069 ("nvmem: add driver handling U-Boot environment variables")
> 
> Signed-off-by: INAGAKI Hiroshi <musashino.open@gmail.com>
> ---

Applied thanks,

--srini
> v1 -> v2
> 
> - add missing cast to __le32 for calculated crc32
>    (reported by kernel test robot <lkp@intel.com>)
> 
> - add missing "Fixes:" tag
> 
>   drivers/nvmem/u-boot-env.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
> index 8e72d1bbd649..b5aacf805fc6 100644
> --- a/drivers/nvmem/u-boot-env.c
> +++ b/drivers/nvmem/u-boot-env.c
> @@ -143,7 +143,7 @@ static int u_boot_env_parse(struct u_boot_env *priv)
>   	crc32_data_len = priv->mtd->size - crc32_data_offset;
>   	data_len = priv->mtd->size - data_offset;
>   
> -	calc = crc32(~0, buf + crc32_data_offset, crc32_data_len) ^ ~0L;
> +	calc = le32_to_cpu((__le32)crc32(~0, buf + crc32_data_offset, crc32_data_len) ^ ~0L);
>   	if (calc != crc32) {
>   		dev_err(dev, "Invalid calculated CRC32: 0x%08x (expected: 0x%08x)\n", calc, crc32);
>   		err = -EINVAL;
> 
> base-commit: 60bbaad38109684b156e21112322e0a922f92cde
