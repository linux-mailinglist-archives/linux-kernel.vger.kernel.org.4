Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93ED6EA4F6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 09:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjDUHhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 03:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjDUHho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 03:37:44 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA5A39020;
        Fri, 21 Apr 2023 00:37:29 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8AxJPw3PUJkB+ofAA--.49641S3;
        Fri, 21 Apr 2023 15:37:27 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxAeU0PUJkg7YyAA--.32348S3;
        Fri, 21 Apr 2023 15:37:26 +0800 (CST)
Subject: Re: [PATCH v13 1/2] thermal: loongson-2: add thermal management
 support
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>, wanghongliang@loongson.cn,
        zhanghongchen <zhanghongchen@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn
References: <20230221095355.9799-1-zhuyinbo@loongson.cn>
 <1af930f6-51ae-c986-3eeb-556b2fa34047@linaro.org>
 <070bd997-b70b-ede1-fe71-dcf410aa3c1a@loongson.cn>
 <9ce1e719-9bfe-cba3-ed8d-fe9dcd1abc8a@linaro.org>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <eb39d031-0a1b-acab-11c2-97b60a65c48b@loongson.cn>
Date:   Fri, 21 Apr 2023 15:37:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <9ce1e719-9bfe-cba3-ed8d-fe9dcd1abc8a@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxAeU0PUJkg7YyAA--.32348S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7tFy7Kr4xur17urWDWrW5GFg_yoW8JFW8pr
        WUCayDKFWjgrsa9a17K3s3Wrs0va9xJr4DXws5Gw4kAr98t34ftFZrJ3WY9F1kJr4Iqr4U
        tr4Ut397Xa1DZFJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bDAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY
        6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14
        v26r126r1DMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_WwCFx2IqxVCFs4IE
        7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I
        0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAI
        cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcV
        CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j0HqcUUUUU=
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/4/21 下午3:17, Krzysztof Kozlowski 写道:
> On 21/04/2023 04:00, zhuyinbo wrote:
>>
>>
>> 在 2023/4/20 下午11:54, Krzysztof Kozlowski 写道:
>>> On 21/02/2023 10:53, Yinbo Zhu wrote:
>>>> This patch adds the support for Loongson-2 thermal sensor controller,
>>>> which can support maximum 4 sensors, each sensor contains a sampling
>>>> register and a control register. The sampling register is used to obtain
>>>> the temperature in real time, the control register GATE field is used to
>>>> set the threshold of high or low temperature, when the input temperature
>>>> is higher than the high temperature threshold or lower than the low
>>>> temperature threshold, an interrupt will occur.
>>>>
>>>> Signed-off-by: zhanghongchen <zhanghongchen@loongson.cn>
>>>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>>>> ---
>>>> Change in v13:
>>>> 		1. Add a description about that how works the sensor.
>>>> 		2. Drop the COMPILE_TEST.
>>>
>>> Why? We want to compile test. We really, really want.
>>>
>>
>> I noted a commit "8df4ef3eaa62b" that accoring to Daniel's reminder.
> 
> The commit is for OF! That's not the case here. Your driver is limited
> to chosen ARCH.
> 

okay, I got it.  I will add back depends on COMPILE_TEST.

Thanks.
> Best regards,
> Krzysztof
> 

