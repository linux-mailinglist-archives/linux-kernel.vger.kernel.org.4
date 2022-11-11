Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8EBC62579B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 11:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbiKKKFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 05:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbiKKKFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 05:05:41 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9CD67D133;
        Fri, 11 Nov 2022 02:05:38 -0800 (PST)
Received: from loongson.cn (unknown [10.180.13.64])
        by gateway (Coremail) with SMTP id _____8BxbbZwHm5j2BcGAA--.7373S3;
        Fri, 11 Nov 2022 18:05:36 +0800 (CST)
Received: from [10.180.13.64] (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxBlduHm5j1tYQAA--.27998S2;
        Fri, 11 Nov 2022 18:05:36 +0800 (CST)
Subject: Re: [PATCH v10 1/2] thermal: loongson-2: add thermal management
 support
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     zhanghongchen <zhanghongchen@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>, zhuyinbo@loongson.cn
References: <20221103083407.4039-1-zhuyinbo@loongson.cn>
 <d634c8db-3036-08eb-24d2-568771b0e104@loongson.cn>
 <d975ae16-58b8-a844-7ffd-7fa06159311c@wanadoo.fr>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <ef7a6f77-9f18-e68d-a6a7-61186346c768@loongson.cn>
Date:   Fri, 11 Nov 2022 18:05:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d975ae16-58b8-a844-7ffd-7fa06159311c@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxBlduHm5j1tYQAA--.27998S2
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvdXoW7GF1kKw4fXFy7Ar4xCw45KFg_yoWfGrgE93
        yjkrZrGw48JFWxZrW2yr4rX3s7Jayvq34xAr40qa17KryUKa10v397ArnxXw1xC3y8Gr43
        uryDZ34fZ34qgjkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrn0
        xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUO
        17CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2
        IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84AC
        jcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84
        ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8I
        j28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2
        WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxV
        WUAVWUtwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26rWl4I8I3I0E4IkC6x0Y
        z7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY
        1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8YsjUUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/11/10 下午2:01, Christophe JAILLET 写道:
> Le 09/11/2022 à 09:09, Yinbo Zhu a écrit :
>> Hi Rafael J.Wysocki,
>>
>> I just have a verified on your tree about my patch again, it is okay,
>> if no other proplems, please help merge it to your tree and sync it to 
>> linux mainline tree.
>>
>> Thanks,
>> Yinbo.
>>
> 
> Hi,
> 
> I've sent a few nits on v10, that you are obviously free to take into 
> account or not.
> 
> However, one of these comments is about thermal_add_hwmon_sysfs() vs 
> devm_thermal_add_hwmon_sysfs() in loongson2_thermal_probe().
> 
> IMHO, if I'm correct, at least this comment should be fixed.
Hi Christophe JAILLET,

Thanks your addvice, I had send v11 that following your advice,
but some it is different. e.g.  devm_request_threaded_irq return value 
is integer and use IS_ERR(integer) that isn't appropriate.

Tks,
Yinbo
> 
> CJ

