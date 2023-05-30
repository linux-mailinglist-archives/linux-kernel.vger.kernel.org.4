Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739EB715812
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 10:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjE3ILh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 04:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjE3ILe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 04:11:34 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C80A0;
        Tue, 30 May 2023 01:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685434293; x=1716970293;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=rsstpHsgYbStkOeZbmzXwO97zaVxwB2tjA0G51vJYI0=;
  b=jKqdFM2r0QhHX43go8+5OcCfOTKdk6Y763tKEzIj63YFXuwSNJoTMZRK
   /rjWPvlzoKp9JmwXlH939mFk2BSjZn2obT9Xg6qAlKrxXX1u0EDpIbJ+b
   gNV006CtUHM1LuDBd+NP72Fb1JLVXIajOf1qfjpdisEQL6A5+xFiv95LQ
   3LvhTu6yKq10QHdjYED+H2aHTXx2zW2xC63Szj75Hy49Bzmb7b0juDJxZ
   1vLfLtF9TSKoeENziOU75F6OlkWiaI8zChJcTrKagUQBf0WpSiznmc/Nu
   yOV8Xn0KmYO+LsRX+37/CBuBFbhjHvn2dVu88BdFwbNEQd/o+nyaZvvDM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="352348827"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="352348827"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 01:11:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="830640548"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="830640548"
Received: from schndiet-mobl.ger.corp.intel.com ([10.251.208.132])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 01:11:31 -0700
Date:   Tue, 30 May 2023 11:11:23 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     SungHwan Jung <onenowy@gmail.com>
cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: hp-wmi: Add thermal profile for Victus
 16-d1xxx
In-Reply-To: <20230529053959.4876-1-onenowy@gmail.com>
Message-ID: <3b5feff0-1d59-37cb-9a5d-22186271a6a4@linux.intel.com>
References: <20230529053959.4876-1-onenowy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2023, SungHwan Jung wrote:

> This patch includes Platform Profile support (performance, balanced, quiet)
> for Victus 16-d1xxx (8A25).
> 
> Signed-off-by: SungHwan Jung <onenowy@gmail.com>
> ---
>  drivers/platform/x86/hp/hp-wmi.c | 104 +++++++++++++++++++++++++++++--
>  1 file changed, 99 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
> index 6364ae262705..6259b907ce63 100644
> --- a/drivers/platform/x86/hp/hp-wmi.c
> +++ b/drivers/platform/x86/hp/hp-wmi.c
> @@ -66,6 +66,11 @@ static const char *const omen_thermal_profile_force_v0_boards[] = {
>  	"8607", "8746", "8747", "8749", "874A", "8748"
>  };
>  
> +/* DMI Board names of Victus laptops */
> +static const char * const victus_thermal_profile_boards[] = {
> +	"8A25"
> +};
> +
>  enum hp_wmi_radio {
>  	HPWMI_WIFI	= 0x0,
>  	HPWMI_BLUETOOTH	= 0x1,
> @@ -176,6 +181,12 @@ enum hp_thermal_profile_omen_v1 {
>  	HP_OMEN_V1_THERMAL_PROFILE_COOL		= 0x50,
>  };
>  
> +enum hp_thermal_profile_victus {
> +	HP_VICTUS_THERMAL_PROFILE_DEFAULT		= 0x00,
> +	HP_VICTUS_THERMAL_PROFILE_PERFORMANCE	= 0x01,
> +	HP_VICTUS_THERMAL_PROFILE_QUIET			= 0x03,

These should be aligned.

> +};
> +
>  enum hp_thermal_profile {
>  	HP_THERMAL_PROFILE_PERFORMANCE	= 0x00,
>  	HP_THERMAL_PROFILE_DEFAULT		= 0x01,
> @@ -1246,6 +1257,70 @@ static int hp_wmi_platform_profile_set(struct platform_profile_handler *pprof,
>  	return 0;
>  }
>  
> +static bool is_victus_thermal_profile(void)
> +{
> +	const char *board_name = dmi_get_system_info(DMI_BOARD_NAME);
> +
> +	if (!board_name)
> +		return false;
> +
> +	return match_string(victus_thermal_profile_boards,
> +			    ARRAY_SIZE(victus_thermal_profile_boards),
> +			    board_name) >= 0;
> +}
> +
> +static int platform_profile_victus_get(struct platform_profile_handler *pprof,
> +				     enum platform_profile_option *profile)
> +{
> +	int tp;
> +
> +	tp = omen_thermal_profile_get();
> +	if (tp < 0)
> +		return tp;
> +
> +	switch (tp) {
> +	case HP_VICTUS_THERMAL_PROFILE_PERFORMANCE:
> +		*profile =  PLATFORM_PROFILE_PERFORMANCE;
> +		break;
> +	case HP_VICTUS_THERMAL_PROFILE_DEFAULT:
> +		*profile =  PLATFORM_PROFILE_BALANCED;
> +		break;
> +	case HP_VICTUS_THERMAL_PROFILE_QUIET:
> +		*profile =  PLATFORM_PROFILE_QUIET;

Remove the extra space in all three assingments here.

> +		break;
> +	default:
> +		return -EINVAL;

It seems wrong to return -EINVAL when there's nothing wrong done by the 
caller (arguments were not invalid). Maybe use -ENOENT or -ENXIO instead.

> +	}
> +
> +	return 0;
> +}
> +
> +static int platform_profile_victus_set(struct platform_profile_handler *pprof,
> +				     enum platform_profile_option profile)
> +{
> +	int err, tp;
> +
> +	switch (profile) {
> +	case PLATFORM_PROFILE_PERFORMANCE:
> +		tp =  HP_VICTUS_THERMAL_PROFILE_PERFORMANCE;
> +		break;
> +	case PLATFORM_PROFILE_BALANCED:
> +		tp =  HP_VICTUS_THERMAL_PROFILE_DEFAULT;
> +		break;
> +	case PLATFORM_PROFILE_QUIET:
> +		tp =  HP_VICTUS_THERMAL_PROFILE_QUIET;

Again, remove extra spaces.

> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	err = omen_thermal_profile_set(tp);
> +	if (err < 0)
> +		return err;
> +
> +	return 0;
> +}
> +
>  static int thermal_profile_setup(void)
>  {
>  	int err, tp;
> @@ -1266,6 +1341,25 @@ static int thermal_profile_setup(void)
>  
>  		platform_profile_handler.profile_get = platform_profile_omen_get;
>  		platform_profile_handler.profile_set = platform_profile_omen_set;
> +
> +		set_bit(PLATFORM_PROFILE_COOL, platform_profile_handler.choices);
> +	} else if (is_victus_thermal_profile()) {
> +		tp = omen_thermal_profile_get();
> +		if (tp < 0)
> +			return tp;
> +
> +		/*
> +		 * call thermal profile write command to ensure that the
> +		 * firmware correctly sets the OEM variables
> +		 */
> +		err = omen_thermal_profile_set(tp);
> +		if (err < 0)
> +			return err;
> +
> +		platform_profile_handler.profile_get = platform_profile_victus_get;
> +		platform_profile_handler.profile_set = platform_profile_victus_set;
> +
> +		set_bit(PLATFORM_PROFILE_QUIET, platform_profile_handler.choices);
>  	} else {
>  		tp = thermal_profile_get();
>  
> @@ -1273,20 +1367,20 @@ static int thermal_profile_setup(void)
>  			return tp;
>  
>  		/*
> -		 * call thermal profile write command to ensure that the
> -		 * firmware correctly sets the OEM variables for the DPTF
> -		 */
> +		 * call thermal profile write command to ensure that the
> +		 * firmware correctly sets the OEM variables for the DPTF
> +		 */

A stray change?

>  		err = thermal_profile_set(tp);
>  		if (err)
>  			return err;
>  
>  		platform_profile_handler.profile_get = hp_wmi_platform_profile_get;
>  		platform_profile_handler.profile_set = hp_wmi_platform_profile_set;
> -
> +

A stray change?

>  		set_bit(PLATFORM_PROFILE_QUIET, platform_profile_handler.choices);
> +		set_bit(PLATFORM_PROFILE_COOL, platform_profile_handler.choices);
>  	}
>  
> -	set_bit(PLATFORM_PROFILE_COOL, platform_profile_handler.choices);
>  	set_bit(PLATFORM_PROFILE_BALANCED, platform_profile_handler.choices);
>  	set_bit(PLATFORM_PROFILE_PERFORMANCE, platform_profile_handler.choices);

Besides the minor things noted above, the change looks good.

-- 
 i.

