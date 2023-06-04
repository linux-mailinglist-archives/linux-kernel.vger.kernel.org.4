Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC6F721604
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 12:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjFDKYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 06:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjFDKYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 06:24:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99B9A3;
        Sun,  4 Jun 2023 03:24:33 -0700 (PDT)
Received: from [IPV6:2405:201:0:21ea:e49:10dd:40c0:e842] (unknown [IPv6:2405:201:0:21ea:e49:10dd:40c0:e842])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 513C56603050;
        Sun,  4 Jun 2023 11:24:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685874272;
        bh=G8Vk4YtafBa+Pb7sMLpiLgNRNeR4Wa7C+A6DNmqd86o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HrYJlw7MM2qYuiRvq+qE41QzDb7R6Nd4mJqho1ydq3uRjdUluf6wEkCz7LX8JAy1b
         5a3638jRUzq37UenKgYnEHcGBe7DNv2iVZMLuRsEyfgCu8MdNbi0NZnpkBUgVnt2BA
         /CtSkQ3Op89NP6eXIY9txFw+PHoZ+ED/4HVINlHXP+q5RIt1qfN4mJju9F2FUBulxY
         0xrf4MGr4AcgDrTNrS6KHWG4b+UVvjgfwWyTVwSku4POZcRmTqEdNVuV+jZbGUvV71
         MzLYebvmx+yo1rJY0BdywLnOAAYwfnCH0i9Md/I1l/0TGnE7huA9nk3sgdWQiLS9qA
         idZRsjfelVuJA==
Message-ID: <d9b1e05a-6b32-3033-cbc4-c87bda711e4d@collabora.com>
Date:   Sun, 4 Jun 2023 15:54:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 2/8] iio: adc: rockchip_saradc: Add support for RK3588
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     lars@metafoo.de, heiko@sntech.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sebastian.reichel@collabora.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        gustavo.padovan@collabora.com, kernel@collabora.com,
        serge.broslavsky@collabora.com, Simon Xue <xxm@rock-chips.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        andy.shevchenko@gmail.com
References: <20230603185340.13838-1-shreeya.patel@collabora.com>
 <20230603185340.13838-3-shreeya.patel@collabora.com>
 <ZHunAIbK7-tIvsm1@surfacebook> <20230604112043.43b1ada0@jic23-huawei>
From:   Shreeya Patel <shreeya.patel@collabora.com>
In-Reply-To: <20230604112043.43b1ada0@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/06/23 15:50, Jonathan Cameron wrote:
> On Sat, 3 Jun 2023 23:48:00 +0300
> andy.shevchenko@gmail.com wrote:
>
>> Sun, Jun 04, 2023 at 12:23:34AM +0530, Shreeya Patel kirjoitti:
>>> From: Simon Xue <xxm@rock-chips.com>
>>>
>>> Add new start and read functions to support rk3588 device.
>>> Also, add a device compatible string for the same.
>> ...
>>
>>> +/* v2 registers */
>>> +#define SARADC2_CONV_CON		0x0
>>> +#define SARADC_T_PD_SOC			0x4
>>> +#define SARADC_T_DAS_SOC		0xc
>> Can you use fixed-width values for all registers?
>>
>> 	0x000
>> 	0x004
>> 	0x00c
>>
>>> +#define SARADC2_END_INT_EN		0x104
>>> +#define SARADC2_ST_CON			0x108
>>> +#define SARADC2_STATUS			0x10c
>>> +#define SARADC2_END_INT_ST		0x110
>>> +#define SARADC2_DATA_BASE		0x120
> I tidied this up whilst applying.

  Ah, I was just about to send a v4 with the change. Thank you for 
making the changes.


Regards,
Shreeya Patel


> Jonathan
