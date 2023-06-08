Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F163E727FA7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 14:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236545AbjFHMKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 08:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236056AbjFHMKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 08:10:43 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DEE7E210E;
        Thu,  8 Jun 2023 05:10:40 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8DxDes_xYFkloQAAA--.1930S3;
        Thu, 08 Jun 2023 20:10:39 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxReQ+xYFkq4QHAA--.24090S3;
        Thu, 08 Jun 2023 20:10:38 +0800 (CST)
Subject: Re: [PATCH v12 1/2] spi: add loongson spi bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn
References: <20230608072819.25930-1-zhuyinbo@loongson.cn>
 <20230608072819.25930-2-zhuyinbo@loongson.cn>
 <6ebed84c-2b42-c981-7b3f-e71cc88e4c2c@linaro.org>
 <4bf747c4-b767-b20c-e00f-724b50f44edb@loongson.cn>
 <6bfc2a22-6901-0858-7b90-bc4c52c66810@linaro.org>
 <bd2d7830-3ab6-0906-b06a-83d3e0a96749@loongson.cn>
 <11ca2b90-544d-18c2-fb15-7909ca60507f@linaro.org>
 <f6d4ecb5-e9df-346e-4aab-772fd01689c8@loongson.cn>
 <a9952e76-1204-5bc7-7856-0c7f8a411d76@linaro.org>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <9c94397d-1e31-02fa-bdbe-af888c72eac4@loongson.cn>
Date:   Thu, 8 Jun 2023 20:10:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <a9952e76-1204-5bc7-7856-0c7f8a411d76@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxReQ+xYFkq4QHAA--.24090S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
        nUUI43ZEXa7xR_UUUUUUUUU==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/6/8 下午7:45, Krzysztof Kozlowski 写道:
> On 08/06/2023 13:42, zhuyinbo wrote:
>> --- a/Documentation/devicetree/bindings/spi/loongson,ls2k-spi.yaml
>> +++ b/Documentation/devicetree/bindings/spi/loongson,ls2k-spi.yaml
>> @@ -16,6 +16,7 @@ properties:
>>      compatible:
>>        enum:
>>          - loongson,ls2k1000-spi
>> +      - loongson,ls2k0500-spi
> 
> Aren't they compatible?
> 


Are you saying that the spi driver is compatible with 2k0500 ?
Yes.  and the 2k1000 spi hardware was same with 2k0500 common type spi
hardware.

but afterwards, it may be necessary to implement a clock drvier for
2k0500, because the spi driver was use "devm_clk_get_optional()" to
get clock and not use "of_property_read_u32(np, "clock-frequency",
&clk)",  But this seems to have nothing to do with bindings.


Thanks,
Yinbo

