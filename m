Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E13D68F219
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 16:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjBHPgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 10:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbjBHPgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 10:36:02 -0500
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA3C402F3;
        Wed,  8 Feb 2023 07:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
        s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Uh03leLsKgN2MDpFdcAW1yHdKgXLcqsQSRml3Fthvko=; b=AQ+4/DNw5QH5YEywk5DN7WMC70
        Z+/rFYmcpAdxcVcP9vuK/7yW5CeaUOKWN6nMzjKijXyze6u5XRx/FwV8lzE74n3JH3pSG9Vgt9RtK
        BldvnI8+uABeY5W9+bMYXb3azZjt+5iZhJBTA8GKuj3xveKpK7T0Qe3TH/0G0tD6etxzvnQE+nhdb
        tz3OlVSmQhzTgtKrlRcOwuNQdC0f5fQtVgMqwNcCyb/0QreF9wwqJayzAmdo7d5wbltN1/V0f7mQB
        qk2oH22Yx+yDD2Gseh2APhJbzfV64K0F51C9F39tZcFYDqkbdpxsNkIuaTbEfYwiGZo5U5iOL5M1b
        P7C271tw==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=[192.168.1.10])
        by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <cyndis@kapsi.fi>)
        id 1pPmU9-007ztn-4r; Wed, 08 Feb 2023 17:35:49 +0200
Message-ID: <706b3e2d-7097-356b-b96e-dd917ce048ea@kapsi.fi>
Date:   Wed, 8 Feb 2023 17:35:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/2] thermal: tegra-bpmp: Handle offline zones
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Srikar Srimath Tirumala <srikars@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Timo Alho <talho@nvidia.com>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230207135610.3100865-1-cyndis@kapsi.fi>
 <Y+N5+w8ePTVaZiIB@orome>
From:   Mikko Perttunen <cyndis@kapsi.fi>
In-Reply-To: <Y+N5+w8ePTVaZiIB@orome>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/23 12:31, Thierry Reding wrote:
> On Tue, Feb 07, 2023 at 03:56:08PM +0200, Mikko Perttunen wrote:
>> From: Mikko Perttunen <mperttunen@nvidia.com>
>>
>> Thermal zones located in power domains may not be accessible when
>> the domain is powergated. In this situation, reading the temperature
>> will return -BPMP_EFAULT and the temperature is considered to be
>> -256C for calculating trips.
> 
> Where's that -256C being set? I only see THERMAL_TEMP_INVALID being set
> as the default for a zone, but that's not -274C, not -256C. If that's
> the temperature that you're referring to, it might be better to state
> that we rely on the default temperature rather than any specific number.
> 
> Thierry

It is based on BPMP's internal behavior.

Mikko

> 
>>
>> For smooth operation, for offline zones, return -EAGAIN when reading
>> the temperature and allow registration of zones even if they are
>> offline during probe.
>>
>> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
>> ---
>>   drivers/thermal/tegra/tegra-bpmp-thermal.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/thermal/tegra/tegra-bpmp-thermal.c b/drivers/thermal/tegra/tegra-bpmp-thermal.c
>> index c76e1ea62c8a..628b18818ae9 100644
>> --- a/drivers/thermal/tegra/tegra-bpmp-thermal.c
>> +++ b/drivers/thermal/tegra/tegra-bpmp-thermal.c
>> @@ -52,6 +52,8 @@ static int __tegra_bpmp_thermal_get_temp(struct tegra_bpmp_thermal_zone *zone,
>>   	err = tegra_bpmp_transfer(zone->tegra->bpmp, &msg);
>>   	if (err)
>>   		return err;
>> +	if (msg.rx.ret == -BPMP_EFAULT)
>> +		return -EAGAIN;
>>   	if (msg.rx.ret)
>>   		return -EINVAL;
>>   
>> @@ -257,7 +259,12 @@ static int tegra_bpmp_thermal_probe(struct platform_device *pdev)
>>   		zone->tegra = tegra;
>>   
>>   		err = __tegra_bpmp_thermal_get_temp(zone, &temp);
>> -		if (err < 0) {
>> +
>> +		/*
>> +		 * Sensors in powergated domains may temporarily fail to be read
>> +		 * (-EAGAIN), but will become accessible when the domain is powered on.
>> +		 */
>> +		if (err < 0 && err != -EAGAIN) {
>>   			devm_kfree(&pdev->dev, zone);
>>   			continue;
>>   		}
>> -- 
>> 2.39.0
>>

