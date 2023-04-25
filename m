Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433466EE6EA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 19:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbjDYRha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 13:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbjDYRh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 13:37:28 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3C283DD;
        Tue, 25 Apr 2023 10:37:27 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1a682eee3baso47041425ad.0;
        Tue, 25 Apr 2023 10:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682444247; x=1685036247;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=sQZUCTV1bqj16FZRqMQAA8ihwGjYbD4+orDlxw0PK4Y=;
        b=VH4Gj5f75R17u/+c6nr2Et/lXHwed/pElsiPKWm7CfTvOBHMN8NGSBfMGR/xRkTpzg
         wqmfDkHpBDSuejIXNTU7yqHnOKmD4G6p3fWY6qizuRPRuJmGUqGn8I7hDHBET5XBHrX5
         kl9+CzSjYm6nQyWiHXZEZG1kMYQ+46sXz7Zt/FOTItr6G8axM6HGzCkiMG8KQq/YW3M8
         ZNxosJOf2P6M5qIWsAFApazRPX2X+ZxUx6mtx1SQOzhtUJuaRtosqo42W9+tr82yp8/d
         0OsU/FNJVusbuQ4QnQrn+MMmwFYqgepSt60t2ifEYoRC2h+mZDX0wbRKj0PP0hxKMznV
         qkuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682444247; x=1685036247;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sQZUCTV1bqj16FZRqMQAA8ihwGjYbD4+orDlxw0PK4Y=;
        b=KLHVDkqEUggOHxssOGIBmm0Fl6F7FGfHyarGC9dFvw/1bYnM8g6tIgXQ9+zVGUm/4Y
         Br/Jr46aKlg02MpG3/q9J0XB50MUDkO4jL+CXeSh+Y4GRR/4kCbtzivJatwktE+fsIa5
         Z/roota3UHB32W7E+E0mua2uJ2cMJWM/Jy0Rjza3xrGy1OsjcM5v+95G8BV5J7NVTl0X
         bkixSKK7Fgm+m3d18wFcUVeVwFHyRPrQeH52YVtDlXZTnQb870V75I7ZZOmiBzR8n4C3
         qBfTpTuhxeQTU4Uzzjz+yPaJotdNV7a5LzdRFixGjEn6dsETa3Gg8VUiPU+HMBIYawyD
         DxGA==
X-Gm-Message-State: AC+VfDzty5hJWnYwfXxxMpKEVVrQ2zzVpEu12Gsuq5mUiW/wEgx1Ke53
        fKR6+EHgB9StmxFTLyYF7Yc=
X-Google-Smtp-Source: ACHHUZ65kgxaVuAyyTocC0mIyIPcGyFreWVSSoPUwwGjmgqhnWXn0TukyTlplZfKWjqTgBNlp3DnLA==
X-Received: by 2002:a17:90a:1088:b0:24b:d883:906c with SMTP id c8-20020a17090a108800b0024bd883906cmr3644208pja.8.1682444246982;
        Tue, 25 Apr 2023 10:37:26 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v14-20020a17090a6b0e00b0024752ff8061sm8258985pjj.12.2023.04.25.10.37.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 10:37:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ed33a2ee-9c94-818f-b4c0-bc0257207a2f@roeck-us.net>
Date:   Tue, 25 Apr 2023 10:37:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] spi: bcm63xx: remove PM_SLEEP based conditional
 compilation
Content-Language: en-US
To:     "Gole, Dhruva" <d-gole@ti.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Vaishnav Achath <vaishnav.a@ti.com>, Vignesh <vigneshr@ti.com>,
        Apurva Nandan <a-nandan@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Grant Likely <grant.likely@secretlab.ca>,
        Tanguy Bouzeloc <tanguy.bouzeloc@efixo.com>
References: <20230420121615.967487-1-d-gole@ti.com>
 <8edb48ee-55a3-4cc2-9c81-514ec867b35c@roeck-us.net>
 <602392dc-de1f-90bf-3deb-cb5cee81e41c@ti.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <602392dc-de1f-90bf-3deb-cb5cee81e41c@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/23 10:18, Gole, Dhruva wrote:
> Hi,
> 
> On 4/25/2023 8:38 PM, Guenter Roeck wrote:
>> On Thu, Apr 20, 2023 at 05:46:15PM +0530, Dhruva Gole wrote:
>>> Get rid of conditional compilation based on CONFIG_PM_SLEEP because
>>> it may introduce build issues with certain configs where it maybe disabled
>>> This is because if above config is not enabled the suspend-resume
>>> functions are never part of the code but the bcm63xx_spi_pm_ops struct
>>> still inits them to non-existent suspend-resume functions.
>>>
>>> Fixes: b42dfed83d95 ("spi: add Broadcom BCM63xx SPI controller driver")
>>>
>>> Signed-off-by: Dhruva Gole <d-gole@ti.com>
>> This patch results in:
>>
>> drivers/spi/spi-bcm63xx.c:632:12: error: 'bcm63xx_spi_resume' defined but not used [-Werror=unused-function]
>>    632 | static int bcm63xx_spi_resume(struct device *dev)
>>        |            ^~~~~~~~~~~~~~~~~~
>> drivers/spi/spi-bcm63xx.c:620:12: error: 'bcm63xx_spi_suspend' defined but not used [-Werror=unused-function]
>>    620 | static int bcm63xx_spi_suspend(struct device *dev)
>>
>> on architectures with no PM support (alpha, csky, m68k, openrisc, parisc,
>> riscv, s390).
> 
> Thanks for pointing this out.
> 
> I could send a patch to address this as pointed here [0]
> 
> by adding a __maybe_unused.
> 
> However, do you think my other patch [1] could address this issue without the need for above?
> 

Personally I would go for [0] as the least invasive solution, but I really
have no idea, sorry. I just hope that your (broken) patch doesn't make it
as-is into the upstream kernel.

Guenter

> I think it would because DEFINE_SIMPLE_DEV_PM_OPS doesn't seem to be under any conditional CONFIG_PM.
> 
> However, I may have missed something, please do let me know what's the best way to fix.
> 
> [0] https://lore.kernel.org/all/24ec3728-9720-ae6a-9ff5-3e2e13a96f76@gmail.com/
> 
> [1] https://lore.kernel.org/all/20230424102546.1604484-1-d-gole@ti.com/
> 
>>
>> Guenter
> 

