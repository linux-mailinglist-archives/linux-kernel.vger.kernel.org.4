Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D1D625B4C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 14:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbiKKNb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 08:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbiKKNbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 08:31:55 -0500
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D399F60367
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 05:31:49 -0800 (PST)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id tU8GonQCiJvOZtU8GoRdhX; Fri, 11 Nov 2022 14:31:47 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 11 Nov 2022 14:31:47 +0100
X-ME-IP: 86.243.100.34
Message-ID: <9a21c0ae-1f6b-fafb-6054-616f85edfba0@wanadoo.fr>
Date:   Fri, 11 Nov 2022 14:31:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v11 1/2] thermal: loongson-2: add thermal management
 support
Content-Language: fr
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     amitk@kernel.org, daniel.lezcano@linaro.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        liupeibao@loongson.cn, rafael@kernel.org, robh+dt@kernel.org,
        rui.zhang@intel.com, zhanghongchen@loongson.cn
References: <20221111095824.26898-1-zhuyinbo@loongson.cn>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20221111095824.26898-1-zhuyinbo@loongson.cn>
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

Le 11/11/2022 à 10:58, Yinbo Zhu a écrit :
> This patch adds the support for Loongson-2 thermal sensor controller,
> which can support maximum 4 sensors.
> 
> It's based on thermal of framework:
>   - Trip points defined in device tree.
>   - Cpufreq as cooling device registered in Loongson-2 cpufreq driver.
>   - Pwm fan as cooling device registered in hwmon pwm-fan driver.
> 
> Signed-off-by: zhanghongchen <zhanghongchen-cXZgJK919ebM1kAEIRd3EQ@public.gmane.org>
> Signed-off-by: Yinbo Zhu <zhuyinbo-cXZgJK919ebM1kAEIRd3EQ@public.gmane.org>
> ---

[...]

> +static int loongson2_thermal_set(struct loongson2_thermal_data *data,
> +					int low, int high, bool enable)
> +{
> +	u64 reg_ctrl = 0;
> +	int reg_off = data->id * 2;
> +
> +	if (low > high)
> +		return -EINVAL;
> +
> +	low = min(low, -100);

Should be max()?

> +	high = max(high, 155);

Should be min()?

CJ

> +
> +	low += 100;
> +	high += 100;
> +
> +	reg_ctrl |= low;
> +	reg_ctrl |= enable ? 0x100 : 0;
> +	writew(reg_ctrl, data->regs + LOONGSON2_TSENSOR_CTRL_LO + reg_off);
> +
> +	reg_ctrl = 0;
> +	reg_ctrl |= high;
> +	reg_ctrl |= enable ? 0x100 : 0;
> +	writew(reg_ctrl, data->regs + LOONGSON2_TSENSOR_CTRL_HI + reg_off);
> +
> +	return 0;
> +}

[...]

