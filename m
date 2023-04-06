Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7CF36D93AF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 12:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234842AbjDFKI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 06:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjDFKI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 06:08:26 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B013BB9;
        Thu,  6 Apr 2023 03:08:24 -0700 (PDT)
Received: from [192.168.1.90] (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7719666031BE;
        Thu,  6 Apr 2023 11:08:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680775703;
        bh=g3ow6okIbLEFfIRa8MD8H06mNxGwz2WA2++bkJi+oYc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZTyt5DfGNwoHbcDqbsuFrCKQxX6XstxybOJ+oMRd1Pgj0bSUQPAUHI18p+aGt1bFA
         wYdtlJJNAmWW4LKYjBSD5iYsRnAojfnBkgDWjw8l3fwpez9rrdII3aprf+mG5cxy8P
         /3wFMfjWn40vwxGFiSi9E3t8Pxzxs1gOd1MzKNkUO5p/071rc0Zy+uS9svQwNFgbZh
         8L4invf19Au6LpsuQ5d4Ry5E3frdTEL7XR/1mj6Tako99UbJ1ZkTP4FPRj+yWHa701
         vFliThSCHq7SEgui9zVhGbQ1INOAoZ9EfY6VBfgVXCq9FZKGPemno0ZImtyl3LFw9o
         /tFgcNEQ9+fwQ==
Message-ID: <53c803ce-2607-6fd1-485e-e19eb961fd08@collabora.com>
Date:   Thu, 6 Apr 2023 13:08:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 8/8] regulator: fan53555: Add support for RK860X
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Joseph Chen <chenjh@rock-chips.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@collabora.com
References: <20230405194721.821536-1-cristian.ciocaltea@collabora.com>
 <20230405194721.821536-9-cristian.ciocaltea@collabora.com>
 <4115e47e-b64b-391a-493c-701c8de0565b@linaro.org>
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <4115e47e-b64b-391a-493c-701c8de0565b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/23 11:25, Krzysztof Kozlowski wrote:
> On 05/04/2023 21:47, Cristian Ciocaltea wrote:
>> Extend the existing fan53555 driver to support the Rockchip RK860X
>> regulators.
>>
>> RK8600/RK8601 are fully compatible with FAN53555 regulators.
>>
> 
>> @@ -531,6 +634,18 @@ static const struct of_device_id __maybe_unused fan53555_dt_ids[] = {
>>  	}, {
>>  		.compatible = "fcs,fan53555",
>>  		.data = (void *)FAN53555_VENDOR_FAIRCHILD
>> +	}, {
>> +		.compatible = "rockchip,rk8600",
>> +		.data = (void *)FAN53555_VENDOR_ROCKCHIP
>> +	}, {
>> +		.compatible = "rockchip,rk8601",
>> +		.data = (void *)FAN53555_VENDOR_ROCKCHIP
>> +	}, {
>> +		.compatible = "rockchip,rk8602",
>> +		.data = (void *)RK8602_VENDOR_ROCKCHIP
>> +	}, {
>> +		.compatible = "rockchip,rk8603",
>> +		.data = (void *)RK8602_VENDOR_ROCKCHIP
>>  	}, {
>>  		.compatible = "silergy,syr827",
>>  		.data = (void *)FAN53555_VENDOR_SILERGY,
>> @@ -637,6 +752,18 @@ static const struct i2c_device_id fan53555_id[] = {
>>  	}, {
>>  		.name = "fan53555",
>>  		.driver_data = FAN53555_VENDOR_FAIRCHILD
>> +	}, {
>> +		.name = "rk8600",
>> +		.driver_data = FAN53555_VENDOR_ROCKCHIP
>> +	}, {
>> +		.name = "rk8601",
>> +		.driver_data = FAN53555_VENDOR_ROCKCHIP
> 
> Why do you need this entry match data if it is the same as rk8600?
> 
>> +	}, {
>> +		.name = "rk8602",
>> +		.driver_data = RK8602_VENDOR_ROCKCHIP
>> +	}, {
>> +		.name = "rk8603",
>> +		.driver_data = RK8602_VENDOR_ROCKCHIP
> 
> Why do you need this entry match data if it is the same as rk8602?

This is consistent with the handling of syr827 and syr828:

		.name = "syr827",
		.driver_data = FAN53555_VENDOR_SILERGY
	}, {
		.name = "syr828",
		.driver_data = FAN53555_VENDOR_SILERGY

Thanks,
Cristian
