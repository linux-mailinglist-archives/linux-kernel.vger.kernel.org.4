Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88B85FF1F6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 18:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbiJNQCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 12:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiJNQCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 12:02:44 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051E7170DCE;
        Fri, 14 Oct 2022 09:02:41 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id r18so4648119pgr.12;
        Fri, 14 Oct 2022 09:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H8fJfHvYAQbBybgPIV/n4kd8GOI783ZQEyi/eOMq5GY=;
        b=Zcz9IhwCnYwdA+qIaz0MjYOe34M7oylCuv6vnSYNBVxtbBGxGlLV1Mjs6OdmulZS3S
         pcXlxBzedaLWaKCYX7W3xXTRvya26NxPKm6SWlQa7pgvZjOVoSKymdDXLqJSlTKCOLry
         1BF7u7TOymECGb0YNNNavAjNZU8+iQkk95Vn9rj1WXVql7MMv4QEBprGB//0wJP3CzuF
         BghP2X41ss1rzMHb6yXiveaTXSMBFyjO799dWJeZE3lmGuWd+T2H/ujf/BVuRMV3Oox6
         bNEqTGaG1xlqtOg3qI7pxn1/QkzY1JmSjxIdWfcfJld+0jjo8lTW0hY8qUzvQ6zRP+EC
         zDQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H8fJfHvYAQbBybgPIV/n4kd8GOI783ZQEyi/eOMq5GY=;
        b=NKCOL3A4i075S3N6un37XBuDoElD31MGsrnuhqUbTqXiAlVzRG6KtR2x1E1OaF6AA+
         5Xe2r1a61gitlLPsMyrj8ikd0HwSDcytrFFfYLKdiClCBVPIyGhiw0Y8BF2p+N/W+Z9t
         aHlhqcIAgagUfpZ70etlIsP5Hlsv3mzHTt2Xu/IqdfBFEIGKhm31RlVJ1aWzhBjPSapv
         QAC3YO2f1ChFlg+at7PfaJPs2KdHTkILtaYu/R/BvOUb0mmYA+jPSheIZG1SGxl6MM3o
         D+hzrGBPzUH5VvP1ZN0ijhDJphk/3wEKS59X/OZ3C4UEyinNtm6GigjEhdkJyQey0NgT
         JQpQ==
X-Gm-Message-State: ACrzQf0wtamY3j5lsJxrKfMB+0BIYVDDLLZcjCHYvZHX7RN01FhHlWJH
        ZxAnj6hJt7u72tgBeH3MoOHGSWLs594oZY5kcmE=
X-Google-Smtp-Source: AMsMyM6GxPJci+3+9F2G4UktwQP7QTs/gJ3JC952aTk4ahQO5QYiBctRN2VjqtoUAUaGCPiAc4V99g==
X-Received: by 2002:a05:6a00:80e:b0:563:4ad2:9d39 with SMTP id m14-20020a056a00080e00b005634ad29d39mr5870781pfk.66.1665763360653;
        Fri, 14 Oct 2022 09:02:40 -0700 (PDT)
Received: from 192.168.0.102 ([2400:9ce0:1267:8cd7:7f1f:f80c:3b70:1976])
        by smtp.gmail.com with ESMTPSA id y68-20020a626447000000b005624b4bd738sm1886144pfb.156.2022.10.14.09.02.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Oct 2022 09:02:40 -0700 (PDT)
Subject: Re: [PATCH v2] mmc: sdio: fix kernel panic when remove non-standard
 SDIO card
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Weizhao Ouyang <ouyangweizhao@zeku.com>
Cc:     Matthew Ma <mahongwei@zeku.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        John Wang <wangdayu@zeku.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Grazvydas Ignotas <notasas@gmail.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221014034951.2300386-1-ouyangweizhao@zeku.com>
 <CAPDyKFrpCGzOcRpHANt4cjJuELn2EVStQM15a2=ofYus=Jn_oA@mail.gmail.com>
From:   Weizhao Ouyang <o451686892@gmail.com>
Message-ID: <1bdf5762-4761-7441-0145-8179bb917781@gmail.com>
Date:   Sat, 15 Oct 2022 00:02:35 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrpCGzOcRpHANt4cjJuELn2EVStQM15a2=ofYus=Jn_oA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/14/22 22:07, Ulf Hansson wrote:
> On Fri, 14 Oct 2022 at 05:50, Weizhao Ouyang <ouyangweizhao@zeku.com> wrote:
>> From: Weizhao Ouyang <o451686892@gmail.com>
>>
>> From: Matthew Ma <mahongwei@zeku.com>
>>
>> SDIO tuple is only allocated for standard SDIO card, especially it
>> causes memory corruption issues when the non-standard SDIO card has
>> removed since the card device's reference counter does not increase for
>> it at sdio_init_func(), but all SDIO card device reference counter has
>> decreased at sdio_release_func().
>>
>> Fixes: 6f51be3d37df ("sdio: allow non-standard SDIO cards")
>> Signed-off-by: Matthew Ma <mahongwei@zeku.com>
>> Reviewed-by: Weizhao Ouyang <ouyangweizhao@zeku.com>
>> Reviewed-by: John Wang <wangdayu@zeku.com>
> If I understand correctly, Matthew Ma <mahongwei@zeku.com> should be
> the author of the patch?
>
> Assuming I am correct, I have amended the patch and changed that,
> please tell me if I should change that.

Yeah you are correct, thanks for the reply!

> So, I applied this for fixes and by adding a stable tag, thanks!
>
> Kind regards
> Uffe
>
>
>> ---
>> Changes in v2:
>> -- update Fixes tag
>>
>>  drivers/mmc/core/sdio_bus.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
>> index c6268c38c69e..babf21a0adeb 100644
>> --- a/drivers/mmc/core/sdio_bus.c
>> +++ b/drivers/mmc/core/sdio_bus.c
>> @@ -291,7 +291,8 @@ static void sdio_release_func(struct device *dev)
>>  {
>>         struct sdio_func *func = dev_to_sdio_func(dev);
>>
>> -       sdio_free_func_cis(func);
>> +       if (!(func->card->quirks & MMC_QUIRK_NONSTD_SDIO))
>> +               sdio_free_func_cis(func);
>>
>>         kfree(func->info);
>>         kfree(func->tmpbuf);
>> --
>> 2.25.1
>>
