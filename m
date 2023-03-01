Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECAE86A6EA8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 15:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjCAOoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 09:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCAOoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 09:44:14 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E4F234CB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 06:44:13 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id ay29-20020a05600c1e1d00b003e9f4c2b623so12011208wmb.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 06:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677681852;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yl6C2iVlPZ96bPfCVmgZY7PP7SMNEem8KqVjYArVzQ8=;
        b=cIjJqg9FJrBtRpUBk16LBmHsmWd0ev7K/7/JiiDt8o2hJnkTBtgTFEyT8wHJItK5O/
         c1Xwp5eXTa+VP3Mxh8ACyn0xZN57XKs4PFdCYZhTexf53+6kxWO5E/iDa4Ttz6rZL/1l
         oF8jPIQBE4LKsnCNIhWnWRyOw4XkUTZclUYv0vjUr73FbGA8TFY+lsB+vGMG9oX34Aa7
         Gk7vQa4NijjgYs45pP1gGyKmMX7D5ahWEb1Sbh+pg9sghK4R2Y1Q1bU1T6gB1LNhCV8T
         MwW7dT6M+qIKB+hSQK5D2YCZsjahy75Z/17Hzv6i2yLkVAdsn64jHHRz/MYwWdxaFdqb
         l/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677681852;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yl6C2iVlPZ96bPfCVmgZY7PP7SMNEem8KqVjYArVzQ8=;
        b=r6At6rHh6r5LPDLWs1P7FDOOfB12ULHHkrBw1LIqg9QfZzVbum5Hyozh/iJuRvKY/4
         hxLUYhBc0ez7F6XVc8SteUb8H7PD9cac+2ouHMKgtTtMPutR4RVE5YufdL74u39b8C4s
         dphrE79EfnLdNb+7SdkSzXuUFv5/IEK+ZFJ4v2yvvdWCcunJZ8nxH/oOysXA2wUjM/W7
         77fNdeiwkysPhJk7EVHJNiTfQ+u5/810rDck2xCJEDkqhxU5Q4MBjzvMFo8+5+i6Kv/T
         QlVqMnQmDmmmojqZMtKCPxdXMmczo6dfuMmyu/jIgeikw9W7h4nwiK8ncIpC/sesRX1B
         4DmA==
X-Gm-Message-State: AO0yUKXQkqFtVuUlQoWIMMiqGMRco98e9AQJcmdsv95Xz7pnjHVD8NjM
        4UoyZwK2qGE+xJA0oR8zgzK19w==
X-Google-Smtp-Source: AK7set8ZaMDTtplAM9a+ZyNMSwBq+nmbYRXDCAHNxgiHyZcDqX2ggQxMAUflaJ2Cj9Ba3mrq0LT0gw==
X-Received: by 2002:a05:600c:3544:b0:3eb:3fea:a2ac with SMTP id i4-20020a05600c354400b003eb3feaa2acmr5288143wmq.22.1677681851899;
        Wed, 01 Mar 2023 06:44:11 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:6ffe:ce4f:bd31:1e6d? ([2a05:6e02:1041:c10:6ffe:ce4f:bd31:1e6d])
        by smtp.googlemail.com with ESMTPSA id m33-20020a05600c3b2100b003eaee9e0d22sm17455606wms.33.2023.03.01.06.44.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 06:44:11 -0800 (PST)
Message-ID: <0ef0efeb-dc0b-ed37-6572-384d2fa93591@linaro.org>
Date:   Wed, 1 Mar 2023 15:44:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 17/19] thermal/tegra: Do not enable the thermal zone,
 it is already enabled
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>
References: <20230228112238.2312273-1-daniel.lezcano@linaro.org>
 <20230228112238.2312273-18-daniel.lezcano@linaro.org>
 <Y/9hZFfRWLNHMbxe@orome>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <Y/9hZFfRWLNHMbxe@orome>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/2023 15:29, Thierry Reding wrote:
> On Tue, Feb 28, 2023 at 12:22:36PM +0100, Daniel Lezcano wrote:
>> The code enables the thermal zone after setting it up. But the thermal
>> zone is already enabled by thermal_of_zone_register() function.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>   drivers/thermal/tegra/tegra30-tsensor.c | 8 +-------
>>   1 file changed, 1 insertion(+), 7 deletions(-)
>>
>> diff --git a/drivers/thermal/tegra/tegra30-tsensor.c b/drivers/thermal/tegra/tegra30-tsensor.c
>> index 3506c3f3c474..e38902abf207 100644
>> --- a/drivers/thermal/tegra/tegra30-tsensor.c
>> +++ b/drivers/thermal/tegra/tegra30-tsensor.c
>> @@ -346,7 +346,7 @@ static int tegra_tsensor_enable_hw_channel(const struct tegra_tsensor *ts,
>>   {
>>   	const struct tegra_tsensor_channel *tsc = &ts->ch[id];
>>   	struct thermal_zone_device *tzd = tsc->tzd;
>> -	int err, hot_trip = 0, crit_trip = 0;
>> +	int hot_trip = 0, crit_trip = 0;
>>   	u32 val;
>>   
>>   	if (!tzd) {
>> @@ -401,12 +401,6 @@ static int tegra_tsensor_enable_hw_channel(const struct tegra_tsensor *ts,
>>   	val |= FIELD_PREP(TSENSOR_SENSOR0_CONFIG0_INTR_THERMAL_RST_EN, 1);
>>   	writel_relaxed(val, tsc->regs + TSENSOR_SENSOR0_CONFIG0);
>>   
>> -	err = thermal_zone_device_enable(tzd);
>> -	if (err) {
>> -		dev_err(ts->dev, "ch%u: failed to enable zone: %d\n", id, err);
>> -		return err;
>> -	}
>> -
>>   	return 0;
>>   }
> 
> This function is called in tegra_tsensor_resume() and balances out the
> tegra_tsensor_hw_channel() calls from tegra_tsensor_suspend(). If we
> remove the call from here, we'll likely end up with the zones disabled
> after a resume.
> 
> This ends up calling thermal_zone_device_set_mode(), which is a no-op,
> basically, if the mode is unchanged, so this seems harmless.
> 
> If you need this to change anyway, I suppose we could move the calls to
> thermal_zone_device_enable() and move them into suspend/resume instead.
> That's a bit tricky to undo in the error recovery paths, but should be
> doable.

No it is fine, I will just drop this patch from the series.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

