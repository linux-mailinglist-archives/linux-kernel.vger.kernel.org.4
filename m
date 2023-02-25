Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9570D6A2B2B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 18:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjBYRw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 12:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBYRwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 12:52:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6981E18B3B
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 09:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677347496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZfVA+6E0piJ9TsCzaJQSVioT3VsJtuol4xTkuWpyLRc=;
        b=SrO0ytFxnxLfJshIC6R/QOxnJUmo2pXF5O6kuS4l9K1jlaOnfVBrdq70C6y9RlhbgBJVJ2
        d4onrvk0Aw09PGEzjizSGB1IBjhc4zXQ3YU19A/xg8YeMyJ6tWnRInLPQXIHB9+iG/u4es
        T/1yx4z9H1oTTTh0xLXVn/dK6MSfceE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-375-SzLKPOmUMPeSuvmlwIQWlA-1; Sat, 25 Feb 2023 12:51:35 -0500
X-MC-Unique: SzLKPOmUMPeSuvmlwIQWlA-1
Received: by mail-qk1-f197.google.com with SMTP id z23-20020a05620a101700b0073b328e7d17so1419330qkj.9
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 09:51:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZfVA+6E0piJ9TsCzaJQSVioT3VsJtuol4xTkuWpyLRc=;
        b=RmO0WYi8NYiuiDclO2DY0JqKHL1aizpGBWfsmJBSRfrxJ5DXYlC4r42q1REwIRJeCH
         ArENJlFOGtR1HPm8BvbHgiQBC9AYsaOfobV/0glAqNC3OACMAZbwXO06iIImcf44Dee+
         aqdX+tY/qSiR2cJEBtZFviHlefBooIgZG1vn979Jyeep1bMfEwrBO4UxXwaBS7se5ihI
         JIQUHSSvSz+TKl7nyB0SuWkTIsvomtjKUmbReIO0K8rUUfxTAZMPWUI2QV2yp7hkENyA
         QaUcLGKLKp9G+7ZcvgJ0Ags4iR+2Yv0DkyCPO9yM/vpoemQgENUfQwIR8NGOFufc7Ymz
         aEdQ==
X-Gm-Message-State: AO0yUKV7HGwGKKMPxQ4XDoNpFKk34enE3PknrkTmDlog9NVhC34vXb/w
        Khpdqw7g1YBfX8hmJl5gsFgoJJaKmnpvGWvBHGgq2Qo1NPSwlqEfQXVGy3tbhPaeHApxRe9YNRU
        yivjHhqulygy2QzMBjydqrqU7oWlG0f/yv+pjmDwfpugi7nR2nDBSlHOtoMK9IcD7+vUT5swUPZ
        no
X-Received: by 2002:a05:622a:1742:b0:3b1:80ab:38e with SMTP id l2-20020a05622a174200b003b180ab038emr20877218qtk.0.1677347494425;
        Sat, 25 Feb 2023 09:51:34 -0800 (PST)
X-Google-Smtp-Source: AK7set+JQCZVRSS/enJBur9zp7QKou+WPTT363tZdGgTCF+Ql5Z1/szT76071uTjVXXy8ypLn+aQsQ==
X-Received: by 2002:a05:622a:1742:b0:3b1:80ab:38e with SMTP id l2-20020a05622a174200b003b180ab038emr20877196qtk.0.1677347494108;
        Sat, 25 Feb 2023 09:51:34 -0800 (PST)
Received: from [192.168.1.19] (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id g3-20020ac84803000000b003be56bdd3b1sm1582499qtq.92.2023.02.25.09.51.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Feb 2023 09:51:32 -0800 (PST)
Subject: Re: [PATCH] tty: serial: fsl_lpuart: select SERIAL_FSL_LPUART for
 SERIAL_FSL_LPUART_CONSOLE
To:     Randy Dunlap <rdunlap@infradead.org>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230225173949.651311-1-trix@redhat.com>
 <0f8a8857-5e18-e49a-0361-197b4bc892ab@infradead.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <026ee207-3b90-c7ae-a7fd-66a34cd3ee90@redhat.com>
Date:   Sat, 25 Feb 2023 09:51:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <0f8a8857-5e18-e49a-0361-197b4bc892ab@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/25/23 9:46 AM, Randy Dunlap wrote:
> Hi--
>
> On 2/25/23 09:39, Tom Rix wrote:
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
>> Signed-off-by: Tom Rix <trix@redhat.com>
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
> Most other _CONSOLE Kconfig have:
>
> 	depends on SERIAL_FSL_LPUART=y

commit 5779a072c248db7a40cfd0f5ea958097fd1d9a30 removed the =y. so it 
could be built as a module.

Tom

>
> e.g.
>
> but I noticed a few others with a similar problem.
>
>>   	select SERIAL_CORE_CONSOLE
>>   	select SERIAL_EARLYCON
>>   	help

