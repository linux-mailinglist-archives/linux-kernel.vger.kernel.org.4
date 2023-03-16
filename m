Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B2C6BD226
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 15:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjCPOQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 10:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjCPOPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 10:15:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AB9AA70B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 07:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678976009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fbqE5KY3NTaFUqscsQfqSTyYYkfQdK2rrGafPi/d+zA=;
        b=gmclHA3aEqMg6zzTjV2slCr3ujukm9iFq8xq/s9w2Wg8zp7VS8s3X5eDVazP8JHCqc3Zas
        QWRlv4w67D7q0K/QJzlCJWY/mdLko5x5yjkIF3hx+bipnVGVU5NbA7OYG56z4dZQLFz76o
        PpZFE0qAyJ1NAc3mqbogSSNnlF+nfGs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-_Ed7ZOIFPCiSZ0ihKJnJOg-1; Thu, 16 Mar 2023 10:13:28 -0400
X-MC-Unique: _Ed7ZOIFPCiSZ0ihKJnJOg-1
Received: by mail-ed1-f69.google.com with SMTP id e18-20020a056402191200b004fa702d64b3so3271316edz.23
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 07:13:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678976007;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fbqE5KY3NTaFUqscsQfqSTyYYkfQdK2rrGafPi/d+zA=;
        b=WRvVprarEVnK8jfTzoZpySZkk+DdV82nSh6Q8+FYm7K7sqkjNqO/wU7TqKH8xj55Ss
         IRG7bpfZciFaphp7POD1RMG334UDNCk/aFSzEEdn1oA2yaYJ7BEAe3K9r67a/Rs2WiyC
         kyUGJM+ZVYgCBD6S1t/e03Kk8FBW+IV2/wT9r82qG1EuINjGUrm8Q2Ou01Q4PnfFBfRz
         nrdz47MKH0N1+dt6rWL4w7380Wjf1G5kgxBWP9ttx66JzlpjAlvLYzAkXcsqJua4d31X
         Khxxj2TKvxJbVsNfiKVEI0kyQbcol+PfFRkqk26hmb2Kd+X+3ZWWpI04LB+2r9KuS1c9
         /UHg==
X-Gm-Message-State: AO0yUKXqmRIlNrQ6Q8PePopjfETLkR1U9JjC0OxXp5tlJXJAgcH26GsF
        Hq61sOvldl9lQFQ8H+auxBhKYrI9lVhuC1gjKYoaBKE93FyMkaMTYVLxYUVREiEZ5LxTcKWOJiL
        qcNnYuNgb11GWMcaMPh7m53n9
X-Received: by 2002:aa7:c40b:0:b0:4be:d5b8:c007 with SMTP id j11-20020aa7c40b000000b004bed5b8c007mr6526861edq.25.1678976007541;
        Thu, 16 Mar 2023 07:13:27 -0700 (PDT)
X-Google-Smtp-Source: AK7set/Jhyuck1Y2bIdK80eAHYb5oxFy6Uq1Ks4M4+XDl4IYAQwY/lG7MZkK5fLDJwcbLhf8ehk6tQ==
X-Received: by 2002:aa7:c40b:0:b0:4be:d5b8:c007 with SMTP id j11-20020aa7c40b000000b004bed5b8c007mr6526848edq.25.1678976007297;
        Thu, 16 Mar 2023 07:13:27 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id r23-20020a50aad7000000b004f9e6495f94sm3936325edc.50.2023.03.16.07.13.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 07:13:26 -0700 (PDT)
Message-ID: <51d9b1de-5f22-2085-1d3e-6c29afb44120@redhat.com>
Date:   Thu, 16 Mar 2023 15:13:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/3] platform: olpc: mark SPI related data as maybe unused
Content-Language: en-US, nl
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Gross <markgross@kernel.org>,
        Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>,
        Daniel Oliveira Nascimento <don@syst.com.br>,
        Mattia Dongili <malattia@linux.it>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>
References: <20230312132624.352703-1-krzysztof.kozlowski@linaro.org>
 <63814b1b-1297-da4d-79fe-8f2e58e30482@redhat.com>
 <f9408067-ee3c-9f5b-d1b3-7017113c8026@linaro.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <f9408067-ee3c-9f5b-d1b3-7017113c8026@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/16/23 15:07, Krzysztof Kozlowski wrote:
> On 16/03/2023 13:50, Hans de Goede wrote:
>> Hi Krzysztof,
>>
>> On 3/12/23 14:26, Krzysztof Kozlowski wrote:
>>> The driver can be compile tested as built-in making certain data unused:
>>>
>>>   drivers/platform/olpc/olpc-xo175-ec.c:737:35: error: ‘olpc_xo175_ec_id_table’ defined but not used [-Werror=unused-const-variable=]
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>>  drivers/platform/olpc/olpc-xo175-ec.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/platform/olpc/olpc-xo175-ec.c b/drivers/platform/olpc/olpc-xo175-ec.c
>>> index 4823bd2819f6..04573495ef5a 100644
>>> --- a/drivers/platform/olpc/olpc-xo175-ec.c
>>> +++ b/drivers/platform/olpc/olpc-xo175-ec.c
>>> @@ -734,7 +734,7 @@ static const struct of_device_id olpc_xo175_ec_of_match[] = {
>>>  };
>>>  MODULE_DEVICE_TABLE(of, olpc_xo175_ec_of_match);
>>>  
>>> -static const struct spi_device_id olpc_xo175_ec_id_table[] = {
>>> +static const struct spi_device_id olpc_xo175_ec_id_table[] __maybe_unused = {
>>>  	{ "xo1.75-ec", 0 },
>>>  	{}
>>>  };
>>>  MODULE_DEVICE_TABLE(spi, olpc_xo175_ec_id_table);
>>
>> The whole presence of the olpc_xo175_ec_id_table[] seems to make little sense.
>>
>> This should be referenced by:
>>
>> static struct spi_driver olpc_xo175_ec_spi_driver = {
>>
>> Like this:
>>
>>         .probe          = olpc_xo175_ec_probe,
>>         .remove         = olpc_xo175_ec_remove,
>> +       .id_table       = olpc_xo175_ec_id_table,
> 
> Yes, it should.
> 
>>
>> Otherwise those ids cannot be used to load the driver the non DT/of way. Since the driver assumingly does actually bind already this means that it is only used the DT/of way and it seems to me that the whole olpc_xo175_ec_id_table[] can be removed entirely.
>>
>> Exposing modaliases for a non supported way of binding the driver does not really seem useful ?
> 
> However binding the device and module loading (uevent) uses sometimes
> different pieces. Maybe something changed in kernel, but sometime ago
> certain buses where sending uevent for module loading with one ID (e.g.
> platform or spi bus) but device matching would be according to OF. Thus
> if you did not have entries in spi_device_id, the module would not autoload.
> 
> It was exactly the case for example here:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c46ed2281bbe4b84e6f3d4bdfb0e4e9ab813fa9d&context=30&ignorews=0&dt=0
> 
> You needed spi_device_id for proper module autoloading.
> 
> Unless something change in between in the kernel?

Looks like your right, the spi_uevent() code always emits "spi:xxxxxxx" style modalias even for dt/of enumerated devices:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/spi/spi.c#n398

So the table needs to stay.

Can you do a v2 (of just this patch) adding an id_table entry to olpc_xo175_ec_spi_driver rather then using __maybe_unused ?

Regards,

Hans


