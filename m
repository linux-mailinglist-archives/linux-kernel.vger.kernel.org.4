Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCDC6AE4BD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 16:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjCGPbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 10:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbjCGPbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 10:31:10 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922081BB;
        Tue,  7 Mar 2023 07:30:59 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 327FUqEN074727;
        Tue, 7 Mar 2023 09:30:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678203052;
        bh=PuWg1KrKq8dl0F/f6mEpT2obJODTES6ox27OnS5IhC8=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Wx4BMvIj6RXFBMeU0jhLXNBhI8sl0kRu8UYNISk+0Nyd1M/2XHeKg0BG8xhGSPLJi
         OumPvdQDCAq2wJ2L60JZgVRAPjIC9hOtNZMjpb2B8Go7mtdmMys+Etnyg93al9Koby
         f4j6kjgrcApt6JXkOWgDH4PHBQ+1BHqQ2VnQVZ7A=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 327FUq9d003961
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Mar 2023 09:30:52 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 7
 Mar 2023 09:30:51 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 7 Mar 2023 09:30:52 -0600
Received: from [10.250.175.93] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 327FUmqG020149;
        Tue, 7 Mar 2023 09:30:49 -0600
Message-ID: <0e7dabfc-8350-2225-36ee-92aca36e069d@ti.com>
Date:   Tue, 7 Mar 2023 21:00:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 06/11] thermal/drivers/ti: Use fixed update interval
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, <rafael@kernel.org>
CC:     <rui.zhang@intel.com>, <amitk@kernel.org>,
        Keerthy <j-keerthy@ti.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        "open list:TI BANDGAP AND THERMAL DRIVER" <linux-pm@vger.kernel.org>,
        "open list:TI BANDGAP AND THERMAL DRIVER" 
        <linux-omap@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230307133735.90772-1-daniel.lezcano@linaro.org>
 <20230307133735.90772-7-daniel.lezcano@linaro.org>
Content-Language: en-US
From:   "Gole, Dhruva" <d-gole@ti.com>
Organization: Texas Instruments Incorporated
In-Reply-To: <20230307133735.90772-7-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/7/2023 7:07 PM, Daniel Lezcano wrote:
> Currently the TI thermal driver sets the sensor update interval based
> on the polling of the thermal zone. In order to get the polling rate,
> the code inspects the thermal zone device strcuture internals, thus
> breaking the self-encapsulation of the thermal framework core
> framework.
>
> On the other side, we see the common polling rates set in the device
> tree for the platforms using this driver are 500 or 1000 ms.
>
> Setting the polling rate to 250 ms would be far enough to cover the
> combination we found in the device tree.
>
> Instead of accessing the thermal zone device structure polling rate,
> let's use a common update interval of 250 ms for the driver.
>
> Cc: Keerthy <j-keerthy@ti.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> index 0c8914017c18..430c4b43151f 100644
> --- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> +++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> @@ -23,6 +23,8 @@
>  #include "ti-bandgap.h"
>  #include "../thermal_hwmon.h"
>  
> +#define TI_BANDGAP_UPDATE_INTERVAL_MS 250
> +
>  /* common data structures */
>  struct ti_thermal_data {
>  	struct cpufreq_policy *policy;
> @@ -159,7 +161,6 @@ int ti_thermal_expose_sensor(struct ti_bandgap *bgp, int id,
>  			     char *domain)
>  {
>  	struct ti_thermal_data *data;
> -	int interval;
>  
>  	data = ti_bandgap_get_sensor_data(bgp, id);
>  
> @@ -177,10 +178,9 @@ int ti_thermal_expose_sensor(struct ti_bandgap *bgp, int id,
>  		return PTR_ERR(data->ti_thermal);
>  	}
>  
> -	interval = jiffies_to_msecs(data->ti_thermal->polling_delay_jiffies);
> -
>  	ti_bandgap_set_sensor_data(bgp, id, data);
> -	ti_bandgap_write_update_interval(bgp, data->sensor_id, interval);
> +	ti_bandgap_write_update_interval(bgp, data->sensor_id,
> +					 TI_BANDGAP_UPDATE_INTERVAL_MS);
Reviewed-by: Dhruva Gole <d-gole@ti.com>
>  
>  	if (devm_thermal_add_hwmon_sysfs(bgp->dev, data->ti_thermal))
>  		dev_warn(bgp->dev, "failed to add hwmon sysfs attributes\n");

-- 
Regards,
Dhruva Gole <d-gole@ti.com>

