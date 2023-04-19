Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56C46E70DB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 03:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjDSByK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 21:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjDSByI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 21:54:08 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DB882658C;
        Tue, 18 Apr 2023 18:53:58 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8AxUU+1ST9kB7MeAA--.36155S3;
        Wed, 19 Apr 2023 09:53:57 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx_760ST9kxxUuAA--.24487S3;
        Wed, 19 Apr 2023 09:53:56 +0800 (CST)
Subject: Re: [PATCH v7 0/2] spi: loongson: add bus driver for the loongson spi
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn
References: <20230412045152.4694-1-zhuyinbo@loongson.cn>
 <bafedfaf-9ffe-b0ad-d51d-d4b820da3a80@linaro.org>
 <81229100-a546-74b3-d626-09d042688746@loongson.cn>
 <87e1294f-405f-9be2-9b47-52cd29f7fd1a@linaro.org>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <af895a0b-d956-9263-4f52-7110802f465b@loongson.cn>
Date:   Wed, 19 Apr 2023 09:53:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87e1294f-405f-9be2-9b47-52cd29f7fd1a@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cx_760ST9kxxUuAA--.24487S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7KrWDuFyUWFWUCw4fZFW5KFg_yoW8Gr48pw
        45GFn0krW5JFW0qw1kK3y7uayvqw15tFs8Wa1rG3ykXFs8u34aqF48tF4Du3s0vrZ09w42
        qF4kt3y5CaykXa7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bx8Fc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l
        57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
        r2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCF04k20xvE74
        AGY7Cv6cx26rWl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
        0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMI
        IF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF
        0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87
        Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07Uio7NUUUUU=
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/4/18 下午3:06, Krzysztof Kozlowski 写道:
> On 18/04/2023 04:53, zhuyinbo wrote:
>>
>>
>> 在 2023/4/15 上午4:43, Krzysztof Kozlowski 写道:
>>> On 12/04/2023 06:51, Yinbo Zhu wrote:
>>>> Loongson platform support spi hardware controller and this series patch
>>>> was to add spi driver and binding support.
>>>>
>>>> Change in v2:
>>>> 		1. This [PATCH v2 1/2] dt-bindings patch need depend on clk patch:
>>>> 	 	   https://
>>>
>>> Can you stop Ccing fake address "loongson-kernel@lists.loongnix.cn"? It
>>> does not exist. Remove it from all submissions.Recently, There was some issue with the company's email server, causing
>> this mail list "loongson-kernel@lists.loongnix.cn" to only accept
>> internal emails and not accpet external emails. The company's IT is
>> working to fix this issue. and Ccing this mail list is an internal
>> requirement.  I will not send emails to this mail list until this email
>> sever issue is resolved.
> 
> You can always Bcc it, if you have such requirement. However your
> internal requirements should not cause my removing all the time multiple
> bounces...

The company' IT had fix that mail list server issue and ccing that mail
list "loongson-kernel@lists.loongnix.cn" that will not cause your
removing all the time multiple bounces.

Thanks.
> 
> Best regards,
> Krzysztof
> 

