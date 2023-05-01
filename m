Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414B46F351E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 19:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbjEARkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 13:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjEARkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 13:40:40 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EDDCD
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 10:40:39 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-50bc4d96e14so10999910a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 10:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682962837; x=1685554837;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N5guYJ9V8FoqdBbDXh+L8J8YREorhILjnzHudkpQOjY=;
        b=Uh+ExWPnML+Tzx7Ty0+Gh4irC/5M0G6GRRlc+OiWtuiQ56p3DzBJqqhJw2UDfuYdPO
         MCCgJBQY0hsHvR50ldb0j3pKXzXUH1dWTTvjtz4QrTuS+eig+eFopuaIopJM9m7P/ItZ
         bjFxW7Ob+6CB2vjxrTZeff0GAElpAuNJrgb1WUIIKzfXtgT8eZcAtJkL3bZvwqV2gryR
         DI+W2fIKssHV1eoodl0I8FOSY3s1WPq+D8y8arZzT/pZPMhbt0vYR9zkWxS9td/0Ahc2
         4BVs8EULdVoyniArJrDlVClvqpJ7LUTwnhGaFu/mUhVr5EPpIbe+k6hf7U/hlHmOl1zd
         1gww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682962837; x=1685554837;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N5guYJ9V8FoqdBbDXh+L8J8YREorhILjnzHudkpQOjY=;
        b=evph6N4QmTexG0NOJDv+WbyL9pjQFgTyMLb4FZv9jACb8y30DMrVN85tG9f+RWfh9/
         TZjM2udoEzUeB9jGE0/QCA8i1fsq5L3FINkqaRsEA6RxOz0D2wcJIQkCi4/lXlAW+mKD
         lGVNl65Esj2OQb7kKa6EsQ+EnFGaGZ0zULEBkwgVmKP0gZ5XejiespQtI7tHudadoJO9
         q3hA5AXXlnxPt5YwHKa9rKaibtEqVDQjSNaeRuCHnfAjY0HzGqN6lSNRBJG92hFtRkA+
         WQuoEQIyiXwJTaag4hOKi8uL6PzwpAG2flav5SbpL2LSSbC6fhOxq99FAAZVmS58IaLq
         UWzA==
X-Gm-Message-State: AC+VfDwdkqUU2MVVbA8bEJ2L4c/gJwRVCcaJNhgHgcxSRbkxnaQPdbmO
        L01PEcxz1STSjjYL8u4prNUjNJKwvK+AwWWZ/qMrkg==
X-Google-Smtp-Source: ACHHUZ6AwKA99EC75sY7DXCyomJ6B6FEboDxDXbGY9DMS0eXmO98dYfCbAuYA4fB1HBCx2jdsAI8eQ==
X-Received: by 2002:a05:6402:510d:b0:506:bd27:a2f0 with SMTP id m13-20020a056402510d00b00506bd27a2f0mr6763229edd.15.1682962837543;
        Mon, 01 May 2023 10:40:37 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:637a:fd0c:58fd:9f00? ([2a02:810d:15c0:828:637a:fd0c:58fd:9f00])
        by smtp.gmail.com with ESMTPSA id v5-20020a056402184500b0050687f06aacsm12223129edy.12.2023.05.01.10.40.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 10:40:36 -0700 (PDT)
Message-ID: <da606e4b-9fe9-ca47-2c9b-1b32ae2ce498@linaro.org>
Date:   Mon, 1 May 2023 19:40:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/2] gnss: ubx: customize serial device open to set U-Blox
 Zed-F9P baud
Content-Language: en-US
To:     alison@she-devel.com, johan@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        achaiken@aurora.tech
References: <20230501170124.1218603-1-alison@she-devel.com>
 <20230501170124.1218603-2-alison@she-devel.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230501170124.1218603-2-alison@she-devel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/05/2023 19:01, alison@she-devel.com wrote:
> From: Alison Chaiken <achaiken@aurora.tech>
> 
> Add support for setting the baud rate of U-Blox Zed-F9P GNSS devices.
> Provide functions that support writing of arbitrary configuration
> messages to the device plus one that specifically configures the baud
> rate.  Override the default gnss_serial_open() with a new method that
> writes the configuration message to the GNSS if the devicetree declares
> it to be a Zed F9P and requests a non-default baud.  Add a boolean flag
> to the ubx_data private data of the GNSS driver in order to track
> whether the configuration message has already been written.  Set the Zed
> F9P to its default port speed if the devicetree does not specify a
> value.
> 
> Signed-off-by: Alison Chaiken <achaiken@aurora.tech>
> ---
>  drivers/gnss/ubx.c | 195 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 195 insertions(+)
> 

Thank you for your patch. There is something to discuss/improve.

> +/* Configure the Zed F9P baud rate via the UBX-CFG-VALSET message. */
> +static int set_zedf9p_baud(struct gnss_device *gdev,
> +					struct serdev_device *serdev, const speed_t speed)
> +{
> +	size_t count = 0U;
> +	int ret;
> +
> +	if (speed == ZED_F9P_DEFAULT_BAUD)
> +		return 0;
> +
> +	ret = prepare_zedf9p_config_msg(speed, &gdev->dev, ZED_F9P_BAUD_CONFIG_REGISTER);
> +	if (ret)
> +		return ret;
> +	/* Initially set the UART to the default speed to match the GNSS' power-on value. */
> +	serdev_device_set_baudrate(serdev, ZED_F9P_DEFAULT_BAUD);
> +	/* Now set the new baud rate. */
> +	count = gdev->ops->write_raw(gdev, ZED_F9P_CFG_VALSET_MSG, CFG_MSG_TOTAL_LEN);
> +	if (count != CFG_MSG_TOTAL_LEN)
> +		return count;
> +
> +	return 0;
> +}
> +
> +static int ubx_serial_open(struct gnss_device *gdev)
> +{
> +	struct gnss_serial *gserial = gnss_get_drvdata(gdev);
> +	struct serdev_device *serdev = gserial->serdev;
> +	struct ubx_data *data = gnss_serial_get_drvdata(gserial);
> +	struct device_node *np;
> +	int ret;
> +
> +	ret = serdev_device_open(serdev);
> +	if (ret)
> +		return ret;
> +
> +	serdev_device_set_flow_control(serdev, false);
> +
> +	np = serdev->dev.of_node;
> +	if ((of_device_is_compatible(np, "u-blox,zed-f9p")) && (!data->is_configured)) {

Use driver data/match data for such customizations. compatibles
sprinkled over the driver code do not scale, make code unreadable. They
also obfuscate a but compatibility - based on your of_device_id I would
claim devices are compatible and you can remove all the entries except one.

...

> @@ -133,6 +327,7 @@ static const struct of_device_id ubx_of_match[] = {
>  	{ .compatible = "u-blox,neo-6m" },
>  	{ .compatible = "u-blox,neo-8" },
>  	{ .compatible = "u-blox,neo-m8" },
> +	{ .compatible = "u-blox,zed-f9p" },

Looks compatible with previous, right?

>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, ubx_of_match);

Best regards,
Krzysztof

