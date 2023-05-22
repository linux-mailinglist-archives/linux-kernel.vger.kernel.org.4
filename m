Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C3170B909
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 11:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjEVJfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 05:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjEVJfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 05:35:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0B09D
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 02:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684748100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s0HWbIz79jqstRiiPOG36SG7ZPFhmVB7Gw9iEKt9R5M=;
        b=SI0FeC/89tt2U8MBMkNvkWscFgy1j/BPMVZOJPTH0zD3QBjjFGcpsG0rbABT0FeCC2e8H5
        sSUvKkhbJyyFHjdpZiKsVfWWB7MeeKPIbEoADkbpVBJXjOHw/0BBYncpTQkCYvDIj77M+V
        oUHUZMUtyBc4n6g55jZIWc/pfgK2wbk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-qdr_BcGbPXKBjNpNGtBtFQ-1; Mon, 22 May 2023 05:34:58 -0400
X-MC-Unique: qdr_BcGbPXKBjNpNGtBtFQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-94a35b0d4ceso570983566b.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 02:34:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684748097; x=1687340097;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s0HWbIz79jqstRiiPOG36SG7ZPFhmVB7Gw9iEKt9R5M=;
        b=HZZaY7hE79hZTf4SbClCQOLkZN8yVcZsbTOMAI7HJjWEWDJmgeSxR5byCt1hVY5u7h
         G8ZFAMfL3ezyKWWpk3Nl7u0js9SvnT2csRmY5NN9A8BEjbcUoIwgX7FSzgDbgj0wFmhL
         73d4T90Z48z9FnrB6Ao5dkoYCZ0UxGVRPw4Nc5dJq+veLXJcuCxr9guQMNjzLlhXySe0
         lNlJfyxr6WVpL+sc8TWdJ+HR3KzI9Ymp2Kc9oMBWXmZrgx6YY+YCtCf6se4KHti0xkBq
         5pPlx8uFO4mX6THVoDurNLlK+QuVoEhw7OTTDcmDb+KvE7faXwxAZNmjZci/MGssAKHS
         n+IQ==
X-Gm-Message-State: AC+VfDw+VWUWdOufaXRrdTT3nUJ5Bfg5iFnVxX13M0PYCL04fBpS4ASw
        nYt7EMPTtI5CFS06ciyjUygDUI7sKB/OQ7usrDImfRQ/4iPpPkovmF6SeQ/6YzK2/xTURioA5Bq
        /9qlRRhg3PXcKCymlsxznjT0c
X-Received: by 2002:a17:907:7d91:b0:960:c5fe:a36a with SMTP id oz17-20020a1709077d9100b00960c5fea36amr9989516ejc.61.1684748097142;
        Mon, 22 May 2023 02:34:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7G4Aabt20UoUt7U2d6KfSkBhUKt1mY2DF39rXsEP+ph95Qg6sN5V8w3ZfmrgnR/H/Dk6NszA==
X-Received: by 2002:a17:907:7d91:b0:960:c5fe:a36a with SMTP id oz17-20020a1709077d9100b00960c5fea36amr9989503ejc.61.1684748096739;
        Mon, 22 May 2023 02:34:56 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id j27-20020a170906535b00b0096f4c9ce526sm2950604ejo.225.2023.05.22.02.34.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 02:34:56 -0700 (PDT)
Message-ID: <e7d682f3-c1a3-6ddb-5854-8e814dd66333@redhat.com>
Date:   Mon, 22 May 2023 11:34:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] mtd: spi-nor: Fix divide by zero for spi-nor-generic
 flashes
Content-Language: en-US
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     richard@nod.at, todd.e.brandt@intel.com, vigneshr@ti.com,
        pratyush@kernel.org, michael@walle.cc,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        regressions@leemhuis.info, bagasdotme@gmail.com,
        regressions@lists.linux.dev, joneslee@google.com,
        Todd Brandt <todd.e.brandt@linux.intel.com>
References: <20230518085440.2363676-1-tudor.ambarus@linaro.org>
 <20230522102953.2fdf2b02@xps-13>
 <0c8a54ae-7f32-2614-9717-a00fe561513e@linaro.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <0c8a54ae-7f32-2614-9717-a00fe561513e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/22/23 11:22, Tudor Ambarus wrote:
> 
> 
> On 5/22/23 09:29, Miquel Raynal wrote:
>> Hi Tudor,
> 
> Hi, Miquel,
> 
>>
>> tudor.ambarus@linaro.org wrote on Thu, 18 May 2023 08:54:40 +0000:
>>
>>> We failed to initialize n_banks for spi-nor-generic flashes, which
>>> caused a devide by zero when computing the bank_size.
>>>
>>> By default we consider that all chips have a single bank. Initialize
>>> the default number of banks for spi-nor-generic flashes. Even if the
>>> bug is fixed with this simple initialization, check the n_banks value
>>> before dividing so that we make sure this kind of bug won't occur again
>>> if some other struct instance is created uninitialized.
>>>
>>> Suggested-by: Todd Brandt <todd.e.brandt@linux.intel.com>
>>> Reported-by: Todd Brandt <todd.e.brandt@linux.intel.com>
>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217448
>>> Fixes: 9d6c5d64f028 ("mtd: spi-nor: Introduce the concept of bank")
>>> Link: https://lore.kernel.org/all/20230516225108.29194-1-todd.e.brandt@intel.com/
>>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>>> ---
>>>  drivers/mtd/spi-nor/core.c | 5 ++++-
>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
>>> index 0bb0ad14a2fc..5f29fac8669a 100644
>>> --- a/drivers/mtd/spi-nor/core.c
>>> +++ b/drivers/mtd/spi-nor/core.c
>>> @@ -2018,6 +2018,7 @@ static const struct spi_nor_manufacturer *manufacturers[] = {
>>>  
>>>  static const struct flash_info spi_nor_generic_flash = {
>>>  	.name = "spi-nor-generic",
>>> +	.n_banks = 1,
>>
>> I definitely missed that structure.
>>
>>>  	/*
>>>  	 * JESD216 rev A doesn't specify the page size, therefore we need a
>>>  	 * sane default.
>>> @@ -2921,7 +2922,8 @@ static void spi_nor_late_init_params(struct spi_nor *nor)
>>>  	if (nor->flags & SNOR_F_HAS_LOCK && !nor->params->locking_ops)
>>>  		spi_nor_init_default_locking_ops(nor);
>>>  
>>> -	nor->params->bank_size = div64_u64(nor->params->size, nor->info->n_banks);
>>> +	if (nor->info->n_banks > 1)
>>> +		params->bank_size = div64_u64(params->size, nor->info->n_banks);
>>
>> I'm fine with the check as it is written because it also look like an
>> optimization, but bank_size should never be 0 otherwise it's a real bug
> 
> bank_size was introduced just for chips featuring several banks, but we
> made this field mandatory for all flashes, regardless of their type. I
> find this restriction unnecessary, because we can differentiate the RWW
> flashes by checking the SNOR_F_RWW flag. So the alternative to this
> patch is to remove the n_banks restriction and set it just for the RWW
> flashes. I think I prefer this, but keep in mind that I never read a RWW
> flash's datasheet, not publicly available, so the decision is in your
> court. Happy to make a patch.

Since this is causing a serious regression causing people's laptops to hang
on suspend I believe it would be best to queue up the simplest fix for
this (which seems to be this patch as is) for 6.4 asap.

Any more involved changes to fix this in a better way can then be added
on top for the 6.5 cycle.

Regards,

Hans



> 
>> that must be catch and fixed. We do not want uninitialized bank_size's.>
>>>  }
>>>  
>>>  /**
>>> @@ -2987,6 +2989,7 @@ static void spi_nor_init_default_params(struct spi_nor *nor)
>>>  	/* Set SPI NOR sizes. */
>>>  	params->writesize = 1;
>>>  	params->size = (u64)info->sector_size * info->n_sectors;
>>> +	params->bank_size = params->size;
>>>  	params->page_size = info->page_size;
>>
>> We actually discarded that line in a previous discussion:
>> https://lore.kernel.org/linux-mtd/20230331194620.839899-1-miquel.raynal@bootlin.com/T/#mcb4f90f7ca48ffe3d9838b2ac6f74e44460c51bd
>>
>> I'm fine to re-add it though, it does not hurt.
> 
> we would get rid of this init as well with my suggestion.
> 
> Keep in mind that the bug was introduced in 6.4, so we'll have to fix
> this fast, let's come to an agreement.
> 
> Cheers,
> ta
>>
>>>  
>>>  	if (!(info->flags & SPI_NOR_NO_FR)) {
>>
>> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
>>
>> Thanks,
>> Miquèl
> 

