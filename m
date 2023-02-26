Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87266A32E8
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 17:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjBZQrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 11:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjBZQrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 11:47:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D46F962
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 08:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677429983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jXLwVOOJoGY+zkLl0eqln2qfNOxwPfkhKTYmBdbFnNw=;
        b=cgb/DqWVdKB4E1uJwgw0y+xtM4SUPhFci2iathEwlXDE9NG+8ni5JWwGBiUPsXRS5DA5YW
        y9mV2a5eVCJ718mShpSJB6HpaTdHI3Z8BeVgd2hiNuBWY/mKwAqQxjv/ZsFERVBMUVnr23
        /SUOmYZK6j6q+SaThy22zKIaErL9i9w=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-468-2V4gdyuVPcWSwqnP61HS5w-1; Sun, 26 Feb 2023 11:46:22 -0500
X-MC-Unique: 2V4gdyuVPcWSwqnP61HS5w-1
Received: by mail-qk1-f199.google.com with SMTP id z23-20020a05620a101700b0073b328e7d17so2684538qkj.9
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 08:46:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jXLwVOOJoGY+zkLl0eqln2qfNOxwPfkhKTYmBdbFnNw=;
        b=v2oXOmidKIAj38j51mu6XQSVEwkE18tukqyIZuwyibfRiOxGkHI7TkJNZcyU6Ta/pJ
         OUctD19SK/KX7IHoGhrNBRIWv6cpEraVRwh08o2p9uGE8LYuw/VkEKABHECZkWIcN5Eq
         hG/09ghLWvp3MnEPK+hYoDkI59VCGzbln3JTNzmhC6+emMLsCpe/BkMLcscYCsjMqjDb
         gAYznqJMYz2AIUN6qWeV3kUJp6xj5Jd6CX/wevfZjQhMTPel8t0TFDtLeTTNsTKbBCeJ
         esainbOK8/8gwu2/qbH7bMSKgrEFEHr1I5SspBdt6HV/MP4JEfwqMq3ULmc8cJxdA9PT
         jTVg==
X-Gm-Message-State: AO0yUKUErAxemgeXj08REQBXt7H2ld74KGpiZPHCXIDH4DLTsftxR3MX
        kUzIPY5O3OslldFXltgo6xeD5RJijb7rWwr1cEnpwrbnBKlS1+IhkyjaehyjkfKBGa5EQ2n0/74
        8mG/PuUPZ+c0lFxcyfz/nYTVXNB9bFg==
X-Received: by 2002:a05:622a:188f:b0:3bf:c5a3:6143 with SMTP id v15-20020a05622a188f00b003bfc5a36143mr10305879qtc.27.1677429981671;
        Sun, 26 Feb 2023 08:46:21 -0800 (PST)
X-Google-Smtp-Source: AK7set+J5Y1FNkmeB9QKkGZZsIj5CJdqN6/C2lt1gadB8832cQWDxWWsqmqnYZQYvw1blhThgAO+1Q==
X-Received: by 2002:a05:622a:188f:b0:3bf:c5a3:6143 with SMTP id v15-20020a05622a188f00b003bfc5a36143mr10305863qtc.27.1677429981419;
        Sun, 26 Feb 2023 08:46:21 -0800 (PST)
Received: from [192.168.1.19] (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id 186-20020a370ac3000000b0073b878e3f30sm3281701qkk.59.2023.02.26.08.46.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Feb 2023 08:46:20 -0800 (PST)
Subject: Re: [PATCH v2] tty: serial: fsl_lpuart: select SERIAL_FSL_LPUART for
 SERIAL_FSL_LPUART_CONSOLE
To:     Randy Dunlap <rdunlap@infradead.org>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jindong Yue <jindong.yue@nxp.com>,
        Sherry Sun <sherry.sun@nxp.com>
References: <20230226145441.3150640-1-trix@redhat.com>
 <89b8e519-7e93-6367-6cd1-efe6c0dced57@infradead.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <6ad940b4-13c1-dcbb-daad-9ae4e0856434@redhat.com>
Date:   Sun, 26 Feb 2023 08:46:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <89b8e519-7e93-6367-6cd1-efe6c0dced57@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/26/23 7:44 AM, Randy Dunlap wrote:
> Hi Tom,
>
> [adding the recent commit signers]
>
> On 2/26/23 06:54, Tom Rix wrote:
>> A rand config causes this link error
>> ld: drivers/tty/serial/earlycon.o: in function `parse_options':
>> drivers/tty/serial/earlycon.c:99: undefined reference to `uart_parse_earlycon'
>>
>> The rand config has
>> CONFIG_SERIAL_CORE=m
>> CONFIG_SERIAL_EARLYCON=y
>> CONFIG_SERIAL_FSL_LPUART=m
>> CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
>>
>> SERIAL_FSL_LPUART should have been selected instead of depends on-ed.
>>
>> After applying the configs are
>> CONFIG_SERIAL_CORE=y
>> CONFIG_SERIAL_EARLYCON=y
>> CONFIG_SERIAL_FSL_LPUART=y
>> CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
> This works, but I thought that the point of the recent patch was to make the driver modular.
>
> You said:
> "commit 5779a072c248db7a40cfd0f5ea958097fd1d9a30 removed the =y. so it could be built as a module."
>
> That's not the same as what is happening here.

As you pointed out SERIAL_FSL_LPUART is not tristate so the it likely 
never worked to be modular.

Let me fiddle a bit with this and see, if it doesn't work, I'll submit 
the revert.

Tom

>
> I think it would be better to revert the commit mentioned above.
>
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>> v2: Add how the configs changed to commit log
>> ---
>>   drivers/tty/serial/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
>> index 625358f44419..b24d74d389fc 100644
>> --- a/drivers/tty/serial/Kconfig
>> +++ b/drivers/tty/serial/Kconfig
>> @@ -1313,7 +1313,7 @@ config SERIAL_FSL_LPUART
>>   
>>   config SERIAL_FSL_LPUART_CONSOLE
>>   	bool "Console on Freescale lpuart serial port"
>> -	depends on SERIAL_FSL_LPUART
>> +	select SERIAL_FSL_LPUART
>>   	select SERIAL_CORE_CONSOLE
>>   	select SERIAL_EARLYCON
>>   	help

