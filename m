Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B37625939
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 12:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbiKKLT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 06:19:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233188AbiKKLT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 06:19:57 -0500
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C2C68C5E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 03:19:55 -0800 (PST)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id tS4bobtVag7y2tS4coV3mq; Fri, 11 Nov 2022 12:19:53 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 11 Nov 2022 12:19:53 +0100
X-ME-IP: 86.243.100.34
Message-ID: <786d9e96-211d-2357-4f5a-38e580d817f8@wanadoo.fr>
Date:   Fri, 11 Nov 2022 12:19:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v10 1/2] thermal: loongson-2: add thermal management
 support
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     amitk@kernel.org, christophe.jaillet@wanadoo.fr,
        daniel.lezcano@linaro.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, liupeibao@loongson.cn, rafael@kernel.org,
        robh+dt@kernel.org, rui.zhang@intel.com, zhanghongchen@loongson.cn
References: <20221103083407.4039-1-zhuyinbo@loongson.cn>
 <d634c8db-3036-08eb-24d2-568771b0e104@loongson.cn>
 <d975ae16-58b8-a844-7ffd-7fa06159311c@wanadoo.fr>
 <ef7a6f77-9f18-e68d-a6a7-61186346c768@loongson.cn>
Content-Language: fr, en-GB
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <ef7a6f77-9f18-e68d-a6a7-61186346c768@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 11/11/2022 à 11:05, Yinbo Zhu a écrit :
> 
> 
> 在 2022/11/10 下午2:01, Christophe JAILLET 写道:
>> Le 09/11/2022 à 09:09, Yinbo Zhu a écrit :
>>> Hi Rafael J.Wysocki,
>>>
>>> I just have a verified on your tree about my patch again, it is okay,
>>> if no other proplems, please help merge it to your tree and sync it 
>>> to linux mainline tree.
>>>
>>> Thanks,
>>> Yinbo.
>>>
>>
>> Hi,
>>
>> I've sent a few nits on v10, that you are obviously free to take into 
>> account or not.
>>
>> However, one of these comments is about thermal_add_hwmon_sysfs() vs 
>> devm_thermal_add_hwmon_sysfs() in loongson2_thermal_probe().
>>
>> IMHO, if I'm correct, at least this comment should be fixed.
> Hi Christophe JAILLET,
> 
> Thanks your addvice, I had send v11 that following your advice,
> but some it is different. e.g.  devm_request_threaded_irq return value 
> is integer and use IS_ERR(integer) that isn't appropriate.

Hi,
thanks for taking my comments into consideration.


My point was something like:

	ret = devm_request_threaded_irq(dev, data->irq,
			loongson2_thermal_alarm_irq, loongson2_thermal_irq_thread,
			IRQF_ONESHOT, "loongson2_thermal", data);
	if (ret < 0)
		return dev_err_probe(dev, ret, "failed to request alarm irq\n");

But that  mostly a matter of taste. I don't think it worth a re-spin 
only for that.


However, I'll send another comment about the use of min() and max() in 
v11. I think it is not correct.

CJ

> 
> Tks,
> Yinbo
>>
>> CJ
> 
> 

