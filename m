Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4840F6C7F25
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 14:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbjCXNwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 09:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjCXNwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 09:52:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052131ACD0;
        Fri, 24 Mar 2023 06:52:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D1A362AEA;
        Fri, 24 Mar 2023 13:52:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6672C433EF;
        Fri, 24 Mar 2023 13:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679665923;
        bh=VFWAIb8kkILCZjlK61SwCOvFMSQhSfMr3UVPM0P/zus=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SXopr78XpZY1/cIa89tHN8Gw5yH20HpN0aGPkqKIPiD5moPjVY7lsN+q6BQMSKv3p
         f8leXa+g9xPRdFusTlbRkvwcpWw/l5SO59+Irknegn5INhKKP9cHpbfrZgVomd0lp5
         EuAIGxPDoIjTGC1iZkqgxL7XJwpHbtiJeqIMDuxVenqMjVCYWMm3inZ+7t4LHHki26
         c8JhMhXxXeoLxq4VuHThegvMz4ZhQkRmKAusm6TeUThGpO1ARrsjnad5zKQ5pYcKUv
         ty5+R6fd1wtKGF9kiU861dN59wUDWRUrlSxuP6pRCtXAlhE+C6eN6fnyGfiYYDlr9S
         iFQsZr8SIpq5w==
Date:   Fri, 24 Mar 2023 06:55:12 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-gpio@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/14] pinctrl: qcom: Support OUTPUT_ENABLE; deprecate
 INPUT_ENABLE
Message-ID: <20230324135512.afplb6cbugwr63ej@ripper>
References: <20230323173019.3706069-1-dianders@chromium.org>
 <20230323102605.8.Id740ae6a993f9313b58add6b10f6a92795d510d4@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323102605.8.Id740ae6a993f9313b58add6b10f6a92795d510d4@changeid>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 10:30:12AM -0700, Douglas Anderson wrote:
> The Qualcomm pinctrl driver has been violating the documented meaning
> of PIN_CONFIG_INPUT_ENABLE. That documentation says:
> 
>   Note that this does not affect the pin's ability to drive output.
> 
> ...yet the Qualcomm driver's sole action when asked to "enable input"
> on a pin is to disable its output.
> 

Seemed like a good idea at the time...

> The Qualcomm driver's implementation stems from the fact that
> "output-disable" is a "new" property from 2017. It was introduced in
> commit 425562429d4f ("pinctrl: generic: Add output-enable
> property"). The "input-enable" handling in Qualcomm drivers is from
> 2015 introduced in commit 407f5e392f9c ("pinctrl: qcom: handle
> input-enable pinconf property").
> 
> Let's change the Qualcomm driver to move us in the right direction. As
> part of this:
> 1. We'll now support PIN_CONFIG_OUTPUT_ENABLE
> 2. We'll still support using PIN_CONFIG_INPUT_ENABLE to disable a
>    pin's output (in violation of the docs) with a big comment in the
>    code. This is needed because old device trees have "input-enable"
>    in them and, in some cases, people might need the old
>    behavior. While we could programmatically change all old device
>    trees, it doesn't really hurt to keep supporting the old behavior
>    and we're _supposed_ to try to be compatible with old device trees
>    anyway.
> 
> It can also be noted that the PIN_CONFIG_INPUT_ENABLE handling code
> seems to have purposefully ignored its argument. That means that old
> boards that had _either_ "input-disable" or "input-enable" in them
> would have had the effect of disabling a pin's output. While we could
> change this behavior, since we're only leaving the
> PIN_CONFIG_INPUT_ENABLE there for backward compatibility we might as
> well be fully backward compatible.
> 

It made total sense to to spell input-disable as output-{high,low} back
then, but we're wiser now. Thanks for fixing it.

> NOTE: despite the fact that we'll still support
> PIN_CONFIG_INPUT_ENABLE for _setting_ config, we take it away from
> msm_config_group_get(). This appears to be only used for populating
> debugfs and fixing debugfs to "output enabled" where relevant instead
> of "input enabled" makes more sense and has more truthiness.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> ---
> 
>  drivers/pinctrl/qcom/pinctrl-msm.c | 36 +++++++++++++++++++++++++-----
>  1 file changed, 31 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> index daeb79a9a602..4515f375c5e8 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> @@ -323,6 +323,7 @@ static int msm_config_reg(struct msm_pinctrl *pctrl,
>  		break;
>  	case PIN_CONFIG_OUTPUT:
>  	case PIN_CONFIG_INPUT_ENABLE:
> +	case PIN_CONFIG_OUTPUT_ENABLE:
>  		*bit = g->oe_bit;
>  		*mask = 1;
>  		break;
> @@ -414,11 +415,9 @@ static int msm_config_group_get(struct pinctrl_dev *pctldev,
>  		val = msm_readl_io(pctrl, g);
>  		arg = !!(val & BIT(g->in_bit));
>  		break;
> -	case PIN_CONFIG_INPUT_ENABLE:
> -		/* Pin is output */
> -		if (arg)
> +	case PIN_CONFIG_OUTPUT_ENABLE:
> +		if (!arg)
>  			return -EINVAL;
> -		arg = 1;
>  		break;
>  	default:
>  		return -ENOTSUPP;
> @@ -502,9 +501,36 @@ static int msm_config_group_set(struct pinctrl_dev *pctldev,
>  			arg = 1;
>  			break;
>  		case PIN_CONFIG_INPUT_ENABLE:
> -			/* disable output */
> +			/*
> +			 * According to pinctrl documentation this should
> +			 * actually be a no-op.
> +			 *
> +			 * The docs are explicit that "this does not affect
> +			 * the pin's ability to drive output" but what we do
> +			 * here is to modify the output enable bit. Thus, to
> +			 * follow the docs we should remove that.
> +			 *
> +			 * The docs say that we should enable any relevant
> +			 * input buffer, but TLMM there is no input buffer that
> +			 * can be enabled/disabled. It's always on.
> +			 *
> +			 * The points above, explain why this _should_ be a
> +			 * no-op. However, for historical reasons and to
> +			 * support old device trees, we'll violate the docs
> +			 * still affect the output.
> +			 *
> +			 * It should further be noted that this old historical
> +			 * behavior actually overrides arg to 0. That means
> +			 * that "input-enable" and "input-disable" in a device
> +			 * tree would _both_ disable the output. We'll
> +			 * continue to preserve this behavior as well since
> +			 * we have no other use for this attribute.
> +			 */
>  			arg = 0;
>  			break;
> +		case PIN_CONFIG_OUTPUT_ENABLE:
> +			arg = !!arg;
> +			break;
>  		default:
>  			dev_err(pctrl->dev, "Unsupported config parameter: %x\n",
>  				param);
> -- 
> 2.40.0.348.gf938b09366-goog
> 
