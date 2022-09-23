Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF925E7C5E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 15:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbiIWNzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 09:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiIWNzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 09:55:04 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0244C8421;
        Fri, 23 Sep 2022 06:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663941303; x=1695477303;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V1fz6/vC2sj2jrgIWsxGg8EggzrRY1LkDCnTvuxjcm8=;
  b=avL6sR5FjUsIMZg3fUJtJ5WU88+GvyC3MQsCIv3NpzyoGKRqfsUGp13+
   EwUQ3y9Pfch2Id6Nh2x+BvlM07oAI+F5bv0X4WvAoPaTYdwH9tNoQxY46
   5aH2pMFKmtJJh9Bf7OD7UtWfgBOx1b1DSUeMRGOIc+a74uT+rzYfLBxjB
   Vcw+tYMXvMQfzHG6CWQMQOSk6va+9yiuRKgQoH0/STfZBVSrzVemPOKFD
   0bzHEmxIc7kM7ZwSZ9jDEZPyOoEvTTXeN3DuTtn0d6mhcsKbFm3ZyqiPu
   bSzNN29xy/K1Z342CX3jjjn0CisOKMTfo0+Iri3U+695aYaWl0jdhH+bI
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="280317634"
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="280317634"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 06:54:50 -0700
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="597873609"
Received: from weiyeeta-mobl.gar.corp.intel.com ([10.213.40.75])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 06:54:47 -0700
Message-ID: <0559b5420b0d2019ff47ad408ed35a6b2c0c1907.camel@intel.com>
Subject: Re: [PATCH v4 01/30] thermal/core: Add a generic
 thermal_zone_get_trip() function
From:   Zhang Rui <rui.zhang@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>
Date:   Fri, 23 Sep 2022 21:54:43 +0800
In-Reply-To: <20220921094244.606948-2-daniel.lezcano@linaro.org>
References: <20220921094244.606948-1-daniel.lezcano@linaro.org>
         <20220921094244.606948-2-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -1142,6 +1138,52 @@ static void thermal_set_delay_jiffies(unsigned
> long *delay_jiffies, int delay_ms
>  		*delay_jiffies = round_jiffies(*delay_jiffies);
>  }
>  
> +int thermal_zone_get_num_trips(struct thermal_zone_device *tz)
> +{
> +	return tz->num_trips;
> +}
> +EXPORT_SYMBOL_GPL(thermal_zone_get_num_trips);
> +
> +static int __thermal_zone_get_trip(struct thermal_zone_device *tz,
> int trip_id,
> +				   struct thermal_trip *trip)
> +{
> +	int ret;
> +
> +	if (!tz || trip_id < 0 || trip_id >= tz->num_trips || !trip)
> +		return -EINVAL;
> +
> +	if (tz->trips) {
> +		*trip = tz->trips[trip_id];
> +		return 0;
> +	}
> +
> +	if (tz->ops->get_trip_hyst) {
> +		ret = tz->ops->get_trip_hyst(tz, trip_id, &trip-
> >hysteresis);
> +		if (ret)
> +			return ret;
> +	} else trip->hysteresis = 0;

a separate line?

Other than that,
Reviewed-by: Zhang Rui <rui.zhang@intel.com>

thanks,
rui

