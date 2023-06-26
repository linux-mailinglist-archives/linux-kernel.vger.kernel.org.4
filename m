Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E15873D9F7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 10:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjFZIjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 04:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjFZIjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 04:39:07 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477221A4;
        Mon, 26 Jun 2023 01:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687768746; x=1719304746;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G+bzOM4xppYQ3XDthN1Saehe84ye48XnjIYxuz/qNiA=;
  b=EqBVUeaeQekb2UfK6rpltBGAkCX6vwEwpqg7szRVXEHZRMTcv/VD5+3D
   zxBNUf6V6FrhkYUnRl2Ce4QfuY0BbwO1+P36tj1mqHiD/Z1T45dG+qFPo
   eqNOqlmMmG2McZjO9joxls9c0LC2Hi2HrMX6s5S0xZR96nWTmbGXGwG93
   Qdeb3w9c219nLg9orWowqHphJ6xPYJkCNJ53t0O7egKrAVMnAv78pKyua
   gxhHK1xOEsrJuUnhRmPozXij+hxG0FOVStWjW1tEsALpnFXp8J929OTLE
   f58Y9EzkxpytT1nkx7x5KbcEMzQrijlewnIehnE9ooafk4YOWGDyzMwrm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="447596759"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="447596759"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 01:39:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="860607441"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="860607441"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 26 Jun 2023 01:39:01 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 26 Jun 2023 11:39:01 +0300
Date:   Mon, 26 Jun 2023 11:39:01 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Frank Wang <frank.wang@rock-chips.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org,
        sebastian.reichel@collabora.com, heiko@sntech.de,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, huangtao@rock-chips.com,
        william.wu@rock-chips.com, jianwei.zheng@rock-chips.com,
        yubing.zhang@rock-chips.com, wmc@rock-chips.com
Subject: Re: [v4,2/2] usb: typec: tcpm: add get max power support
Message-ID: <ZJlOpQtxNiSvmlR/@kuha.fi.intel.com>
References: <20230616075241.27690-1-frank.wang@rock-chips.com>
 <20230616075241.27690-2-frank.wang@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616075241.27690-2-frank.wang@rock-chips.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 03:52:41PM +0800, Frank Wang wrote:
> Traverse fixed pdos to calculate the maximum power that the charger
> can provide, and it can be get by POWER_SUPPLY_PROP_INPUT_POWER_LIMIT
> property.
> 
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changelog:
> v4:
>  - No change
> 
> v3:
>  - Use Microwatts instead of Milliwatts to follow the ABI, commented by Sebastian Reichel.
> 
> v2:
>  - No change
> 
> v1:
>  - https://patchwork.kernel.org/project/linux-usb/patch/20230313025843.17162-4-frank.wang@rock-chips.com/
> 
>  drivers/usb/typec/tcpm/tcpm.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 9f6aaa3e70ca8..829d75ebab422 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -6340,6 +6340,27 @@ static int tcpm_psy_get_current_now(struct tcpm_port *port,
>  	return 0;
>  }
>  
> +static int tcpm_psy_get_input_power_limit(struct tcpm_port *port,
> +					  union power_supply_propval *val)
> +{
> +	unsigned int src_mv, src_ma, max_src_uw = 0;
> +	unsigned int i, tmp;
> +
> +	for (i = 0; i < port->nr_source_caps; i++) {
> +		u32 pdo = port->source_caps[i];
> +
> +		if (pdo_type(pdo) == PDO_TYPE_FIXED) {
> +			src_mv = pdo_fixed_voltage(pdo);
> +			src_ma = pdo_max_current(pdo);
> +			tmp = src_mv * src_ma;
> +			max_src_uw = tmp > max_src_uw ? tmp : max_src_uw;
> +		}
> +	}
> +
> +	val->intval = max_src_uw;
> +	return 0;
> +}
> +
>  static int tcpm_psy_get_prop(struct power_supply *psy,
>  			     enum power_supply_property psp,
>  			     union power_supply_propval *val)
> @@ -6369,6 +6390,9 @@ static int tcpm_psy_get_prop(struct power_supply *psy,
>  	case POWER_SUPPLY_PROP_CURRENT_NOW:
>  		ret = tcpm_psy_get_current_now(port, val);
>  		break;
> +	case POWER_SUPPLY_PROP_INPUT_POWER_LIMIT:
> +		tcpm_psy_get_input_power_limit(port, val);
> +		break;
>  	default:
>  		ret = -EINVAL;
>  		break;
> -- 
> 2.17.1

-- 
heikki
