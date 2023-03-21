Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752156C2E1D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 10:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjCUJmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 05:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjCUJmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 05:42:04 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FA03FB8D;
        Tue, 21 Mar 2023 02:42:00 -0700 (PDT)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 2AC7D61CC40F9;
        Tue, 21 Mar 2023 10:41:57 +0100 (CET)
Message-ID: <f2fe16cf-3838-df89-958f-c39d1bae81a1@molgen.mpg.de>
Date:   Tue, 21 Mar 2023 10:41:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] hwmon: (peci/cputemp) Fix miscalculated DTS for SKX
Content-Language: en-US
To:     Iwona Winiarska <iwona.winiarska@intel.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, Paul Fertser <fercerpav@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20230321090410.866766-1-iwona.winiarska@intel.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230321090410.866766-1-iwona.winiarska@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Iwona,


Am 21.03.23 um 10:04 schrieb Iwona Winiarska:
> For Skylake, DTS temperature of the CPU is reported in S10.6 format
> instead of S8.8.
> 
> Reported-by: Paul Fertser <fercerpav@gmail.com>
> Link: https://lore.kernel.org/lkml/ZBhHS7v+98NK56is@home.paul.comp/
> Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
> ---
>   drivers/hwmon/peci/cputemp.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/peci/cputemp.c b/drivers/hwmon/peci/cputemp.c
> index 30850a479f61..87d56f0fc888 100644
> --- a/drivers/hwmon/peci/cputemp.c
> +++ b/drivers/hwmon/peci/cputemp.c
> @@ -537,6 +537,12 @@ static const struct cpu_info cpu_hsx = {
>   	.thermal_margin_to_millidegree = &dts_eight_dot_eight_to_millidegree,
>   };
>   
> +static const struct cpu_info cpu_skx = {
> +	.reg		= &resolved_cores_reg_hsx,

This is not aligned. Why not only use one space before the equal sign?

> +	.min_peci_revision = 0x33,
> +	.thermal_margin_to_millidegree = &dts_ten_dot_six_to_millidegree,
> +};
> +
>   static const struct cpu_info cpu_icx = {
>   	.reg		= &resolved_cores_reg_icx,
>   	.min_peci_revision = 0x40,
> @@ -558,7 +564,7 @@ static const struct auxiliary_device_id peci_cputemp_ids[] = {
>   	},
>   	{
>   		.name = "peci_cpu.cputemp.skx",
> -		.driver_data = (kernel_ulong_t)&cpu_hsx,
> +		.driver_data = (kernel_ulong_t)&cpu_skx,
>   	},
>   	{
>   		.name = "peci_cpu.cputemp.icx",


Kind regards,

Paul
