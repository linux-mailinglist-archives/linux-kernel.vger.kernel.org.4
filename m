Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE9C6CB4CD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 05:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjC1DZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 23:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbjC1DZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 23:25:27 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D8752139;
        Mon, 27 Mar 2023 20:25:23 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8BxMMwhXiJkEt0SAA--.28861S3;
        Tue, 28 Mar 2023 11:25:21 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxAeUcXiJkD+0OAA--.46439S3;
        Tue, 28 Mar 2023 11:25:19 +0800 (CST)
Subject: Re: [PATCH v3 2/2] spi: loongson: add bus driver for the loongson spi
 controller
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn
References: <20230324063317.14664-1-zhuyinbo@loongson.cn>
 <20230324063317.14664-3-zhuyinbo@loongson.cn>
 <0fff1e01-678b-a26a-084b-9aa30a0deea5@linaro.org>
 <2a24cce4-3211-3440-cc42-55499ded275e@loongson.cn>
 <0c43019f-01b6-c466-c7d4-c2b91116b7db@linaro.org>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <96c4b0e8-2b3b-1eb9-a922-807894fbc06d@loongson.cn>
Date:   Tue, 28 Mar 2023 11:25:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <0c43019f-01b6-c466-c7d4-c2b91116b7db@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxAeUcXiJkD+0OAA--.46439S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7KryUAF4UZF4UGFW5Ar4rAFb_yoW8Xr45pa
        18CF4YkFWUJr1Ikr1Sqas8CFyYvayfGrZ8G3srKw1rXr9Yv34ayF1UtFy5CrZxXF18WFyI
        qF4jgr97Ga15XFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bxxFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487
        Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l42xK82IY6x
        8ErcxFaVAv8VWrMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
        x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrw
        CI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI
        42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
        80aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzgAwDUUUU
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/3/27 下午4:53, Krzysztof Kozlowski 写道:
> On 27/03/2023 10:42, zhuyinbo wrote:
>>
>>
>> 在 2023/3/24 下午7:31, Krzysztof Kozlowski 写道:
>>> On 24/03/2023 07:33, Yinbo Zhu wrote:
>>>> This bus driver supports the Loongson spi hardware controller in the
>>>> Loongson platforms and supports to use DTS and PCI framework to
>>>> register spi device resources.
>>>>
>>>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>>>> ---
>>>>    MAINTAINERS                     |   4 +
>>>>    drivers/spi/Kconfig             |  31 ++++
>>>>    drivers/spi/Makefile            |   3 +
>>>>    drivers/spi/spi-loongson-core.c | 302 ++++++++++++++++++++++++++++++++
>>>>    drivers/spi/spi-loongson-pci.c  |  89 ++++++++++
>>>>    drivers/spi/spi-loongson-plat.c |  66 +++++++
>>>>    drivers/spi/spi-loongson.h      |  41 +++++
>>>>    7 files changed, 536 insertions(+)
>>>>    create mode 100644 drivers/spi/spi-loongson-core.c
>>>>    create mode 100644 drivers/spi/spi-loongson-pci.c
>>>>    create mode 100644 drivers/spi/spi-loongson-plat.c
>>>>    create mode 100644 drivers/spi/spi-loongson.h
>>>
>>> Your patches still have build warnings. Are these false postives or you
>>> forgot to build it? Anyway, please respond to the report.
>>>
>>> Best regards,
>>> Krzysztof
>> thanks your reminder, I have already provided feedback about compile issue.
> 
> Then please test your patches before sending...
That's for sure, I tested it on LoongArch platform.
> 
> Best regards,
> Krzysztof
> 

