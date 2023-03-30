Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492BC6D00A5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 12:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjC3KG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 06:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjC3KG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:06:27 -0400
X-Greylist: delayed 1009 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Mar 2023 03:06:26 PDT
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6495110DD;
        Thu, 30 Mar 2023 03:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
        s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6FbbQ2ARgg8AsSn+bHuiJ5XTJvM+84zfBTQ14KGT7uk=; b=x3pPtY5rtNGer+M7TdN8dXoPQV
        +kUlAL2SpciFvZArogkDfRLz3bepXG26F6HaEdLwTaR0NxsslLOWTvX43HLG7757HcSeXNzHhYZ0y
        CBGwmLV99sqQ0bYRXh5wNtfYy33ai+0sz7XPDtcqhRPivrXG/BQC/LVtl1u/iMQQS17rQPoc2+4j/
        6/gw3aFthMu2UibfE21zY8r8/F7RAyT+o4uTG7fM6CPiSK1q1A4yJsZqi2JhrPcc1yG5+gt1ilhgF
        lVn/g68TltXJlPgx23LhH+cY/XrDrhW4NjJYXx/t2F5BDP/qTRVBstMgyjkQS9q2OxmgiV5jYRaZn
        EhRL4aKw==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=[192.168.1.10])
        by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <cyndis@kapsi.fi>)
        id 1phpAW-000Bjr-Kj; Thu, 30 Mar 2023 13:06:08 +0300
Message-ID: <204e0435-c544-8727-e892-9fc69b8d691d@kapsi.fi>
Date:   Thu, 30 Mar 2023 13:06:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] thermal: tegra-bpmp: Handle offline zones
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230330094904.2589428-1-cyndis@kapsi.fi>
 <a09d8edf-9db1-0037-15a4-7ce329b82bf2@linaro.org>
From:   Mikko Perttunen <cyndis@kapsi.fi>
In-Reply-To: <a09d8edf-9db1-0037-15a4-7ce329b82bf2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/23 13:03, Daniel Lezcano wrote:
> On 30/03/2023 11:49, Mikko Perttunen wrote:
>> From: Mikko Perttunen <mperttunen@nvidia.com>
>>
>> Thermal zones located in power domains may not be accessible when
>> the domain is powergated. In this situation, reading the temperature
>> will return -BPMP_EFAULT. When evaluating trips, BPMP will internally
>> use -256C as the temperature for offline zones.
> 
>> For smooth operation, for offline zones, return -EAGAIN when reading
>> the temperature and allow registration of zones even if they are
>> offline during probe.
> 
> I think it makes more sense to check if the power domain associated with 
> the device is powered up and if not return -EPROBE_DEFER.

The power domains in question are related to computer vision engines 
that only get powered on when in use, possibly never if the user doesn't 
run a computer vision workload on the system. We still want other 
thermal zones to be available.

Mikko

> 
> 
>> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
>> ---
>> v2:
>> * Adjusted commit message.
>> * Patch 2/2 dropped for now since it is more controversial,
>>    and this patch is more critical.
>>
>>   drivers/thermal/tegra/tegra-bpmp-thermal.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/thermal/tegra/tegra-bpmp-thermal.c 
>> b/drivers/thermal/tegra/tegra-bpmp-thermal.c
>> index f5fd4018f72f..4ffc3bb3bf35 100644
>> --- a/drivers/thermal/tegra/tegra-bpmp-thermal.c
>> +++ b/drivers/thermal/tegra/tegra-bpmp-thermal.c
>> @@ -52,6 +52,8 @@ static int __tegra_bpmp_thermal_get_temp(struct 
>> tegra_bpmp_thermal_zone *zone,
>>       err = tegra_bpmp_transfer(zone->tegra->bpmp, &msg);
>>       if (err)
>>           return err;
>> +    if (msg.rx.ret == -BPMP_EFAULT)
>> +        return -EAGAIN;
>>       if (msg.rx.ret)
>>           return -EINVAL;
>> @@ -259,7 +261,12 @@ static int tegra_bpmp_thermal_probe(struct 
>> platform_device *pdev)
>>           zone->tegra = tegra;
>>           err = __tegra_bpmp_thermal_get_temp(zone, &temp);
>> -        if (err < 0) {
>> +
>> +        /*
>> +         * Sensors in powergated domains may temporarily fail to be read
>> +         * (-EAGAIN), but will become accessible when the domain is 
>> powered on.
>> +         */
>> +        if (err < 0 && err != -EAGAIN) {
>>               devm_kfree(&pdev->dev, zone);
>>               continue;
>>           }
> 

