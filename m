Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E800073D9C0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 10:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjFZIar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 04:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjFZIap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 04:30:45 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32686DA;
        Mon, 26 Jun 2023 01:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687768244; x=1719304244;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x93XfnvLnKgassfdHp4RMwW0WBwmDsnuND8yittK6Wo=;
  b=UFgObavuvw7kIEzkbQUAY8l2HI6AkCUVA0393IffMH2A6c3nL/DXBvos
   fXmnGtM3WgIqRNywVplGLS9KKlMjHadSd142JS9kNefTd/65mysDCI6rz
   6fyHpfGKbprIeU2wl14gFRyY9h2sdMsxLKzxV0rrDDwm8M3R1vBFZuwvy
   4wYn1ca5CDNKuebv4aTPFxSoEvsqTCbSXn28qSY+vhR7iV9uFbXWG84ae
   HC2p2fKRnRzLYJXkjeCwiRrSxiXe/vga129jFKctpw4xU95WKE/qVteDY
   RMBD/02Nm2lSunSzJ/H0C8h+nU6I0lTlfLSwBfAVr7B1eYSR9PGtjVNyi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="447594942"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="447594942"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 01:30:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="860604967"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="860604967"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 26 Jun 2023 01:30:40 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 26 Jun 2023 11:30:39 +0300
Date:   Mon, 26 Jun 2023 11:30:39 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/3] usb: typec: fsa4480: rework mux & switch setup to
 handle more states
Message-ID: <ZJlMr6vad6kPor1k@kuha.fi.intel.com>
References: <20230614-topic-sm8550-upstream-type-c-audio-v1-0-15a92565146b@linaro.org>
 <20230614-topic-sm8550-upstream-type-c-audio-v1-2-15a92565146b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614-topic-sm8550-upstream-type-c-audio-v1-2-15a92565146b@linaro.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 03:10:40PM +0200, Neil Armstrong wrote:
> In order to handle the Audio Accessory mode, refactor the mux
> and switch setup in a single function.
> 
> The refactor will help add new states and make the process
> simpler to understand.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/mux/fsa4480.c | 111 +++++++++++++++++++++++++++-------------
>  1 file changed, 75 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/usb/typec/mux/fsa4480.c b/drivers/usb/typec/mux/fsa4480.c
> index d6495e533e58..b2913594a58f 100644
> --- a/drivers/usb/typec/mux/fsa4480.c
> +++ b/drivers/usb/typec/mux/fsa4480.c
> @@ -46,8 +46,11 @@ struct fsa4480 {
>  
>  	struct regmap *regmap;
>  
> +	enum typec_orientation orientation;
> +	unsigned long mode;
> +	unsigned int svid;
> +
>  	u8 cur_enable;
> -	u8 cur_select;
>  };
>  
>  static const struct regmap_config fsa4480_regmap_config = {
> @@ -58,19 +61,42 @@ static const struct regmap_config fsa4480_regmap_config = {
>  	.disable_locking = true,
>  };
>  
> -static int fsa4480_switch_set(struct typec_switch_dev *sw,
> -			      enum typec_orientation orientation)
> +static int fsa4480_set(struct fsa4480 *fsa)
>  {
> -	struct fsa4480 *fsa = typec_switch_get_drvdata(sw);
> -	u8 new_sel;
> -
> -	mutex_lock(&fsa->lock);
> -	new_sel = FSA4480_SEL_USB;
> -	if (orientation == TYPEC_ORIENTATION_REVERSE)
> -		new_sel |= FSA4480_SEL_SBU_REVERSE;
> -
> -	if (new_sel == fsa->cur_select)
> -		goto out_unlock;
> +	bool reverse = (fsa->orientation == TYPEC_ORIENTATION_REVERSE);
> +	u8 enable = FSA4480_ENABLE_DEVICE;
> +	u8 sel = 0;
> +
> +	/* USB Mode */
> +	if (fsa->mode < TYPEC_STATE_MODAL ||
> +	    (!fsa->svid && (fsa->mode == TYPEC_MODE_USB2 ||
> +			    fsa->mode == TYPEC_MODE_USB3))) {
> +		enable |= FSA4480_ENABLE_USB;
> +		sel = FSA4480_SEL_USB;
> +	} else if (fsa->svid) {
> +		switch (fsa->mode) {
> +		/* DP Only */
> +		case TYPEC_DP_STATE_C:
> +		case TYPEC_DP_STATE_E:
> +			enable |= FSA4480_ENABLE_SBU;
> +			if (reverse)
> +				sel = FSA4480_SEL_SBU_REVERSE;
> +			break;
> +
> +		/* DP + USB */
> +		case TYPEC_DP_STATE_D:
> +		case TYPEC_DP_STATE_F:
> +			enable |= FSA4480_ENABLE_USB | FSA4480_ENABLE_SBU;
> +			sel = FSA4480_SEL_USB;
> +			if (reverse)
> +				sel |= FSA4480_SEL_SBU_REVERSE;
> +			break;
> +
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +	} else
> +		return -EOPNOTSUPP;
>  
>  	if (fsa->cur_enable & FSA4480_ENABLE_SBU) {
>  		/* Disable SBU output while re-configuring the switch */
> @@ -81,48 +107,59 @@ static int fsa4480_switch_set(struct typec_switch_dev *sw,
>  		usleep_range(35, 1000);
>  	}
>  
> -	regmap_write(fsa->regmap, FSA4480_SWITCH_SELECT, new_sel);
> -	fsa->cur_select = new_sel;
> -
> -	if (fsa->cur_enable & FSA4480_ENABLE_SBU) {
> -		regmap_write(fsa->regmap, FSA4480_SWITCH_ENABLE, fsa->cur_enable);
> +	regmap_write(fsa->regmap, FSA4480_SWITCH_SELECT, sel);
> +	regmap_write(fsa->regmap, FSA4480_SWITCH_ENABLE, enable);
>  
> +	if (enable & FSA4480_ENABLE_SBU) {
>  		/* 15us to allow the SBU switch to turn on again */
>  		usleep_range(15, 1000);
>  	}
>  
> -out_unlock:
> -	mutex_unlock(&fsa->lock);
> +	fsa->cur_enable = enable;
>  
>  	return 0;
>  }
>  
> +static int fsa4480_switch_set(struct typec_switch_dev *sw,
> +			      enum typec_orientation orientation)
> +{
> +	struct fsa4480 *fsa = typec_switch_get_drvdata(sw);
> +	int ret = 0;
> +
> +	mutex_lock(&fsa->lock);
> +
> +	if (fsa->orientation != orientation) {
> +		fsa->orientation = orientation;
> +
> +		ret = fsa4480_set(fsa);
> +	}
> +
> +	mutex_unlock(&fsa->lock);
> +
> +	return ret;
> +}
> +
>  static int fsa4480_mux_set(struct typec_mux_dev *mux, struct typec_mux_state *state)
>  {
>  	struct fsa4480 *fsa = typec_mux_get_drvdata(mux);
> -	u8 new_enable;
> +	int ret = 0;
>  
>  	mutex_lock(&fsa->lock);
>  
> -	new_enable = FSA4480_ENABLE_DEVICE | FSA4480_ENABLE_USB;
> -	if (state->mode >= TYPEC_DP_STATE_A)
> -		new_enable |= FSA4480_ENABLE_SBU;
> +	if (fsa->mode != state->mode) {
> +		fsa->mode = state->mode;
>  
> -	if (new_enable == fsa->cur_enable)
> -		goto out_unlock;
> +		if (state->alt)
> +			fsa->svid = state->alt->svid;
> +		else
> +			fsa->svid = 0; // No SVID
>  
> -	regmap_write(fsa->regmap, FSA4480_SWITCH_ENABLE, new_enable);
> -	fsa->cur_enable = new_enable;
> -
> -	if (new_enable & FSA4480_ENABLE_SBU) {
> -		/* 15us to allow the SBU switch to turn off */
> -		usleep_range(15, 1000);
> +		ret = fsa4480_set(fsa);
>  	}
>  
> -out_unlock:
>  	mutex_unlock(&fsa->lock);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static int fsa4480_probe(struct i2c_client *client)
> @@ -143,8 +180,10 @@ static int fsa4480_probe(struct i2c_client *client)
>  	if (IS_ERR(fsa->regmap))
>  		return dev_err_probe(dev, PTR_ERR(fsa->regmap), "failed to initialize regmap\n");
>  
> +	/* Safe mode */
>  	fsa->cur_enable = FSA4480_ENABLE_DEVICE | FSA4480_ENABLE_USB;
> -	fsa->cur_select = FSA4480_SEL_USB;
> +	fsa->mode = TYPEC_STATE_SAFE;
> +	fsa->orientation = TYPEC_ORIENTATION_NONE;
>  
>  	/* set default settings */
>  	regmap_write(fsa->regmap, FSA4480_SLOW_L, 0x00);
> @@ -156,7 +195,7 @@ static int fsa4480_probe(struct i2c_client *client)
>  	regmap_write(fsa->regmap, FSA4480_DELAY_L_MIC, 0x00);
>  	regmap_write(fsa->regmap, FSA4480_DELAY_L_SENSE, 0x00);
>  	regmap_write(fsa->regmap, FSA4480_DELAY_L_AGND, 0x09);
> -	regmap_write(fsa->regmap, FSA4480_SWITCH_SELECT, fsa->cur_select);
> +	regmap_write(fsa->regmap, FSA4480_SWITCH_SELECT, FSA4480_SEL_USB);
>  	regmap_write(fsa->regmap, FSA4480_SWITCH_ENABLE, fsa->cur_enable);
>  
>  	sw_desc.drvdata = fsa;
> 
> -- 
> 2.34.1

-- 
heikki
