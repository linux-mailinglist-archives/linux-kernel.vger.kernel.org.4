Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7BC66EA15C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 04:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbjDUCAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 22:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjDUCAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 22:00:50 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 86F41183;
        Thu, 20 Apr 2023 19:00:47 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8AxEk5O7kFkF84fAA--.38221S3;
        Fri, 21 Apr 2023 10:00:46 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxXbNN7kFkqEoyAA--.2723S3;
        Fri, 21 Apr 2023 10:00:45 +0800 (CST)
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
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <070bd997-b70b-ede1-fe71-dcf410aa3c1a@loongson.cn>
Date:   Fri, 21 Apr 2023 10:00:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1af930f6-51ae-c986-3eeb-556b2fa34047@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxXbNN7kFkqEoyAA--.2723S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7Zw1fAF17Wr4DAr4UGFyxuFg_yoW8JFW5p3
        y2ka98KF4qgr1v9a13K34fWF98ua93Xr4DAwn5Ww4kC3y5W34fKrnrtFyY93WkCw4SgrWU
        CF4Dt34kGa1DAFJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bDxFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE
        52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I
        80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
        c4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI
        0_JF0_Jw1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VWrMxC20s026xCaFVCj
        c4AY6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
        Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
        6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6x
        AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU2-txDUUUU
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/4/20 下午11:54, Krzysztof Kozlowski 写道:
> On 21/02/2023 10:53, Yinbo Zhu wrote:
>> This patch adds the support for Loongson-2 thermal sensor controller,
>> which can support maximum 4 sensors, each sensor contains a sampling
>> register and a control register. The sampling register is used to obtain
>> the temperature in real time, the control register GATE field is used to
>> set the threshold of high or low temperature, when the input temperature
>> is higher than the high temperature threshold or lower than the low
>> temperature threshold, an interrupt will occur.
>>
>> Signed-off-by: zhanghongchen <zhanghongchen@loongson.cn>
>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>> ---
>> Change in v13:
>> 		1. Add a description about that how works the sensor.
>> 		2. Drop the COMPILE_TEST.
> 
> Why? We want to compile test. We really, really want.
> 

I noted a commit "8df4ef3eaa62b" that accoring to Daniel's reminder.

That commit "8df4ef3eaa62b" patch said "Since commit 0166dc11be91 ("of:
make CONFIG_OF user selectable"), it is possible to test-build any
driver which depends on OF on any architecture by explicitly
selecting OF. Therefore depending on COMPILE_TEST as an alternative is
no longer needed."

Thanks.

> Best regards,
> Krzysztof
> 

