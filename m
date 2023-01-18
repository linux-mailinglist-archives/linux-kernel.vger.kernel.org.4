Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B536727E0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 20:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjARTJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 14:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjARTJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 14:09:53 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EFF5143A;
        Wed, 18 Jan 2023 11:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674068992; x=1705604992;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4ZvVKyuc/15y4uwM2vM5DwHTEG1jR38Bd4ONK3Npz5Y=;
  b=nhpjAblNZMqAvOr3mjXyn4NKB5QETpjn446T9LpTJ41weg33KedolgKJ
   PXx4i054BXuoxx1Pti3uYvunSz8F9mV2BZ8BHvWes5FiM8qBheKinP6I9
   mu7GL3guQKx5hovPrPar9+qFc+sOpulm3WTvwXTSG2wQR0XDjDHKQ3f2X
   S05MyE21lDAs0myMxjL5ZbnXn7aa04PEy0sm7V9YYT8GL3BjasdtiZmTG
   2x+7KZQF0dQWuAHC1boPHZ8Kq6nUIMUT6rWvNhQapIYTdJeCTv3ZkqiI4
   WXSATCy9YvfHmKgO81JlpERLRjbo2wyIhOOrgI6bqrQRxsmjpEpLgGtq3
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="411313056"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="411313056"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 11:09:52 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="653065942"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="653065942"
Received: from yzeleke-mobl1.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.209.16.158])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 11:09:51 -0800
Message-ID: <e7ab0321e8c655836960295987f69c18d940ae52.camel@linux.intel.com>
Subject: Re: [PATCH 2/3] thermal/drivers/intel: Use generic trip points for
 processor_thermal_device_pci
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rui.zhang@intel.com, Amit Kucheria <amitk@kernel.org>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        Shang XiaoJing <shangxiaojing@huawei.com>
Date:   Wed, 18 Jan 2023 11:09:51 -0800
In-Reply-To: <20230118181622.33335-2-daniel.lezcano@linaro.org>
References: <20230118181622.33335-1-daniel.lezcano@linaro.org>
         <20230118181622.33335-2-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-01-18 at 19:16 +0100, Daniel Lezcano wrote:
> The thermal framework gives the possibility to register the trip
> points with the thermal zone. When that is done, no get_trip_* ops
> are
> needed and they can be removed.
> 
> Convert ops content logic into generic trip points and register them
> with the
> thermal zone.
> 
In this scheme is the assumption is that trip point temperature never
changes? If firmware updated the trip temperature, what needs to be
done?

Thanks,
Srinivas


> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  .../processor_thermal_device_pci.c            | 53 ++++++++---------
> --
>  1 file changed, 22 insertions(+), 31 deletions(-)
> 
> diff --git
> a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.
> c
> b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.
> c
> index bf1b1cdfade4..c7d50862bf56 100644
> ---
> a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.
> c
> +++
> b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.
> c
> @@ -144,34 +144,6 @@ static int sys_get_curr_temp(struct
> thermal_zone_device *tzd, int *temp)
>         return 0;
>  }
>  
> -static int sys_get_trip_temp(struct thermal_zone_device *tzd,
> -                            int trip, int *temp)
> -{
> -       struct proc_thermal_pci *pci_info = tzd->devdata;
> -       u32 _temp;
> -
> -       proc_thermal_mmio_read(pci_info, PROC_THERMAL_MMIO_THRES_0,
> &_temp);
> -       if (!_temp) {
> -               *temp = THERMAL_TEMP_INVALID;
> -       } else {
> -               int tjmax;
> -
> -               proc_thermal_mmio_read(pci_info,
> PROC_THERMAL_MMIO_TJMAX, &tjmax);
> -               _temp = tjmax - _temp;
> -               *temp = (unsigned long)_temp * 1000;
> -       }
> -
> -       return 0;
> -}
> -
> -static int sys_get_trip_type(struct thermal_zone_device *tzd, int
> trip,
> -                             enum thermal_trip_type *type)
> -{
> -       *type = THERMAL_TRIP_PASSIVE;
> -
> -       return 0;
> -}
> -
>  static int sys_set_trip_temp(struct thermal_zone_device *tzd, int
> trip, int temp)
>  {
>         struct proc_thermal_pci *pci_info = tzd->devdata;
> @@ -200,10 +172,26 @@ static int sys_set_trip_temp(struct
> thermal_zone_device *tzd, int trip, int temp
>         return 0;
>  }
>  
> +static int get_trip_temp(struct proc_thermal_pci *pci_info)
> +{
> +       int temp, tjmax;
> +
> +       proc_thermal_mmio_read(pci_info, PROC_THERMAL_MMIO_THRES_0,
> &temp);
> +       if (!temp)
> +               return THERMAL_TEMP_INVALID;
> +
> +       proc_thermal_mmio_read(pci_info, PROC_THERMAL_MMIO_TJMAX,
> &tjmax);
> +       temp = (tjmax - temp) * 1000;
> +
> +       return temp;
> +}
> +
> +static struct thermal_trip psv_trip = {
> +       .type = THERMAL_TRIP_PASSIVE,
> +};
> +
>  static struct thermal_zone_device_ops tzone_ops = {
>         .get_temp = sys_get_curr_temp,
> -       .get_trip_temp = sys_get_trip_temp,
> -       .get_trip_type = sys_get_trip_type,
>         .set_trip_temp  = sys_set_trip_temp,
>  };
>  
> @@ -251,7 +239,10 @@ static int proc_thermal_pci_probe(struct pci_dev
> *pdev, const struct pci_device_
>         if (ret)
>                 goto err_ret_thermal;
>  
> -       pci_info->tzone = thermal_zone_device_register("TCPU_PCI", 1,
> 1, pci_info,
> +       psv_trip.temperature = get_trip_temp(pci_info);
> +       
> +       pci_info->tzone =
> thermal_zone_device_register_with_trips("TCPU_PCI", &psv_trip,
> +                                                       1, 1,
> pci_info,
>                                                         &tzone_ops,
>                                                         &tzone_params
> , 0, 0);
>         if (IS_ERR(pci_info->tzone)) {

