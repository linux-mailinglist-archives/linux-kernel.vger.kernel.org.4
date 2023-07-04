Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FAE747552
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 17:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbjGDPaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 11:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjGDPaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 11:30:02 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AD01B6
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 08:30:00 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fbc54cab6fso50227915e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 08:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688484599; x=1691076599;
        h=content-transfer-encoding:in-reply-to:subject:organization
         :references:cc:to:content-language:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ynbcJpeU+uOp5aDWGQw4MCSYV+ykdJvVEaL7KRlmDM=;
        b=okbEAiMobw70dEQ9YQUu8p7gIEwn+TS+8HiC5hvDjABEOp3K3pLC/rzFH1fxYizw6r
         4L14Aolw+kBjUG0Hlp/MsbCu7QDBJQFZ7Q/f3pBMyRn+oaP/YEpWfUx12dW/CS2OmdVw
         xKi71X9aF+17koXZvn4djzuiHJLimBIysjCj3vSgDwXJ/758YVuhFI16zrdCesJDypGt
         BS88ByzU7K6dMC9Ge8ZxuA5Qq22Ha4BAWC3W77/zzSss+nEiritxJDONwwftnBXrA2Xf
         f/wgdZjMQCrlANcL9qxofg2z7fqF8VSNrIKXF7Nui9q33hfHR59pVOwx7B4t2qbcHEJ+
         BJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688484599; x=1691076599;
        h=content-transfer-encoding:in-reply-to:subject:organization
         :references:cc:to:content-language:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8ynbcJpeU+uOp5aDWGQw4MCSYV+ykdJvVEaL7KRlmDM=;
        b=KoQP/2COscPox+1+8zzKIu5IYLn3uBj/1IS4IDMsaXst7riG1iXLo4rc647yXvlcSW
         1cgrT0ttSTJGoLzm9ixtchCiyOvoqchmm26VmL6tGIXpNSVnV5wKmJiIN8alXL17sQ1C
         M/wQRb+VF6vghGeOc8/1KN3qZ2akMSmeCutJAoGS/KpQFaY6bDusldxNdEjl3DIwhhqU
         k7bGHU6CzIj3RRi4E232HP/HxmkK7MeJ0+V1i4fvgZwhcSv2nFPPMfHzPy/VY4WTd/DV
         uPQq0+qYDMx6arTHAF72NC+BEaCfHiZY3gNppV2F5ImhRxgWY6Xas0O1UPjWaK2Hr5zz
         GGzA==
X-Gm-Message-State: AC+VfDyWAh/q5bFIUJKqF3OiLUoSx63jviMyEgWtco3D/dwdrtsBz4Iv
        ruwPnjc6yqXtE7jiGk6+BqI0KA==
X-Google-Smtp-Source: ACHHUZ7CV2i82Fmv/g2TNPHCLm7tSs1nu0guu4BlXrgefmCPTT88vaGI/sJHbu2V0IMyvtTbtFRx/w==
X-Received: by 2002:a05:600c:b54:b0:3f5:ffe3:46a7 with SMTP id k20-20020a05600c0b5400b003f5ffe346a7mr10718494wmr.9.1688484599064;
        Tue, 04 Jul 2023 08:29:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:106:cd85:84ae:7b? ([2a01:e0a:982:cbb0:106:cd85:84ae:7b])
        by smtp.gmail.com with ESMTPSA id d1-20020a5d6dc1000000b00304adbeeabbsm28635375wrz.99.2023.07.04.08.29.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 08:29:58 -0700 (PDT)
Message-ID: <9fde3632-2419-d36b-9c54-337155bb482e@linaro.org>
Date:   Tue, 4 Jul 2023 17:29:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Content-Language: en-US
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jbrunet@baylibre.com, jirislaby@kernel.org, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com, kelvin.zhang@amlogic.com,
        xianwei.zhao@amlogic.com, kernel@sberdevices.ru,
        rockosov@gmail.com, linux-amlogic@lists.infradead.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230704135936.14697-1-ddrokosov@sberdevices.ru>
 <20230704135936.14697-4-ddrokosov@sberdevices.ru>
 <eb0dab5b-2fc7-728c-c6e0-43d2db422ed5@linaro.org>
 <20230704145933.y3o3fhjj6q7df44d@CAB-WSD-L081021>
Organization: Linaro Developer Services
Subject: Re: [PATCH v1 3/5] tty: serial: meson: apply ttyS devname instead of
 ttyAML for new SoCs
In-Reply-To: <20230704145933.y3o3fhjj6q7df44d@CAB-WSD-L081021>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On 04/07/2023 16:59, Dmitry Rokosov wrote:
> Hello Neil,
> 
> Thank you for quick feedback!
> 
> On Tue, Jul 04, 2023 at 04:42:39PM +0200, neil.armstrong@linaro.org wrote:
>> On 04/07/2023 15:59, Dmitry Rokosov wrote:
>>> It is worth noting that the devname ttyS is a widely recognized tty name
>>> and is commonly used by many uart device drivers. Given the established
>>> usage and compatibility concerns, it may not be feasible to change the
>>> devname for older SoCs. However, for new definitions, it is acceptable
>>> and even recommended to use a new devname to help ensure clarity and
>>> avoid any potential conflicts on lower or upper software levels. In
>>> addition, modify the meson_uart_dt match data for g12a, a1, and s4 to
>>> their appropriate values to ensure proper devname values and
>>> functionality.
>>
>> I'm not confident about modifying a global struct from a probe,
>> I think you should add a separate meson_uart_driver/meson_serial_console couple
>> with ttyS instead of ttyAML, refer to the right uart_driver in meson_uart_data
>> and in probe() register it and pass it to uart_add_one_port().
> 
> Could you provide some insight into why you believe this solution may
> not be acceptable? It appears that the meson_uart_driver and
> meson_serial_console are not labeled with __init, which means it stay in
> memory forever.
Yes but nothing forbids registering a g12a and an a1 uart on the same system,
but you modify the meson_uart_driver/meson_serial_console struct.
This could cause some issues.

In practice this will never happen, but since we don't control the DT passed
to the system we must make sure we take in account any scenario.

> 
> To clarify, are you suggesting a solution that involves segregating the
> meson_uart_driver and meson_serial_console objects for each scenario and
> subsequently declaring pointers to both objects within the
> meson_uart_data? I want to make sure that I have accurately grasped the
> essence of your proposed approach.

Not both, only the appropriate one.

So either we make sure ttyAML and ttyS at exclusive at runtime, in this case we can
modify the global meson_uart_driver/meson_serial_console, or you add
a second set of uart_driver/console structs to handle this improbable case.

Neil
> 
>>>
>>> For more information please refer to IRC discussion at [1].
>>>
>>> Links:
>>>       [1]: https://libera.irclog.whitequark.org/linux-amlogic/2023-07-03
>>>
>>> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
>>> ---
>>>    drivers/tty/serial/meson_uart.c | 33 +++++++++++++++++++++++++++++++--
>>>    1 file changed, 31 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
>>> index 87c0eb5f2dba..361f9326b527 100644
>>> --- a/drivers/tty/serial/meson_uart.c
>>> +++ b/drivers/tty/serial/meson_uart.c
>>> @@ -82,6 +82,7 @@ static struct uart_driver meson_uart_driver;
>>>    static struct uart_port *meson_ports[AML_UART_PORT_NUM];
>>>    struct meson_uart_data {
>>> +	const char *dev_name;
>>>    	bool has_xtal_div2;
>>>    };
>>> @@ -683,6 +684,7 @@ static int meson_uart_probe_clocks(struct platform_device *pdev,
>>>    static int meson_uart_probe(struct platform_device *pdev)
>>>    {
>>> +	const struct meson_uart_data *priv_data;
>>>    	struct resource *res_mem;
>>>    	struct uart_port *port;
>>>    	u32 fifosize = 64; /* Default is 64, 128 for EE UART_0 */
>>> @@ -729,6 +731,18 @@ static int meson_uart_probe(struct platform_device *pdev)
>>>    	if (ret)
>>>    		return ret;
>>> +	priv_data = device_get_match_data(&pdev->dev);
>>> +
>>> +	if (priv_data) {
>>> +		struct console *cons = meson_uart_driver.cons;
>>> +
>>> +		meson_uart_driver.dev_name = priv_data->dev_name;
>>> +
>>> +		if (cons)
>>> +			strscpy(cons->name, priv_data->dev_name,
>>> +				sizeof(cons->name));
>>> +	}
>>> +
>>>    	if (!meson_uart_driver.state) {
>>>    		ret = uart_register_driver(&meson_uart_driver);
>>>    		if (ret)
>>> @@ -748,7 +762,7 @@ static int meson_uart_probe(struct platform_device *pdev)
>>>    	port->x_char = 0;
>>>    	port->ops = &meson_uart_ops;
>>>    	port->fifosize = fifosize;
>>> -	port->private_data = (void *)device_get_match_data(&pdev->dev);
>>> +	port->private_data = (void *)priv_data;
>>>    	meson_ports[pdev->id] = port;
>>>    	platform_set_drvdata(pdev, port);
>>> @@ -780,6 +794,17 @@ static int meson_uart_remove(struct platform_device *pdev)
>>>    }
>>>    static struct meson_uart_data meson_g12a_uart_data = {
>>> +	.dev_name = "ttyAML",
>>> +	.has_xtal_div2 = true,
>>> +};
>>> +
>>> +static struct meson_uart_data meson_a1_uart_data = {
>>> +	.dev_name = "ttyS",
>>> +	.has_xtal_div2 = false,
>>> +};
>>> +
>>> +static struct meson_uart_data meson_s4_uart_data = {
>>> +	.dev_name = "ttyS",
>>>    	.has_xtal_div2 = true,
>>>    };
>>> @@ -794,7 +819,11 @@ static const struct of_device_id meson_uart_dt_match[] = {
>>>    	},
>>>    	{
>>>    		.compatible = "amlogic,meson-s4-uart",
>>> -		.data = (void *)&meson_g12a_uart_data,
>>> +		.data = (void *)&meson_s4_uart_data,
>>> +	},
>>> +	{
>>> +		.compatible = "amlogic,meson-a1-uart",
>>> +		.data = (void *)&meson_a1_uart_data,
>>>    	},
>>>    	{ /* sentinel */ },
>>>    };
>>
> 

