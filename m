Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C27671ECA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjARODv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjARODb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:03:31 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9933C3C2A
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 05:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674049149; x=1705585149;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9XYJBHKq4LlgEmfq3ocSfg4oZS+yzpsSfaET3bbVq4w=;
  b=JpeO87Jlnnz/Ewk5hb5P23O7rCs/vV/VE6s23MA12gwmOp4iBdrMq2fn
   RKD3XqkLPGRUKK3I2ODMOwmVpuldOi5U25Op6ZjTIsmLyz+v/436JIxpa
   1NVIrG3KZslhxSfHBmD0eehn+kLHnMx0QkWvcCry+nX7mb/1M0Df5Y+ZQ
   tk3e4k7nzhewPT+qKQkDq4VfNKkYhSSVpbf6IP+WHZrRpQJpqXwdE5R/C
   xv0Gkn2AF+6eLNDq79nORy9CyfeYFaqoguTCKDoIYwZsEoD+PAJ9hkj5h
   9xPUzRP57pXDnQ+sab3Ma4798Qd9mNd/U45ZIuITX44x2lWojIOPVYQnX
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="312861371"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="312861371"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 05:39:09 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="652941817"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="652941817"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.16.144]) ([10.99.16.144])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 05:39:06 -0800
Message-ID: <e08f5a83-5a7e-9095-92f2-d78601c7a0bd@linux.intel.com>
Date:   Wed, 18 Jan 2023 14:39:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 2/4] ASoC: simple-card-utils: create jack inputs for
 aux_devs
Content-Language: en-US
To:     Astrid Rost <astrid.rost@axis.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, kernel@axis.com,
        linux-kernel@vger.kernel.org
References: <20230118125226.333214-1-astrid.rost@axis.com>
 <20230118125226.333214-3-astrid.rost@axis.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20230118125226.333214-3-astrid.rost@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/2023 1:52 PM, Astrid Rost wrote:
> Add a generic way to create jack inputs for auxiliary jack detection
> drivers (e.g. via i2c, spi), which are not part of any real codec.
> The simple-card can be used as combining card driver to add the jacks,
> no new one is required.
> 
> Create a jack (for input-events) for jack devices in the auxiliary
> device list (aux_devs). A device which has the functions set_jack and
> get_jack_supported_type counts as jack device.
> 
> Add a devicetree entry, in case not all input types are required.
>   simple-card,aux-jack-types:
> Array of snd_jack_type to create jack-input-event for jack devices in
> aux-devs. If the setting is 0, the supported type of the device is used.
> 
> Signed-off-by: Astrid Rost <astrid.rost@axis.com>
> ---
>   include/sound/simple_card_utils.h     |  3 ++
>   sound/soc/generic/simple-card-utils.c | 63 +++++++++++++++++++++++++++
>   sound/soc/generic/simple-card.c       |  4 ++
>   3 files changed, 70 insertions(+)
> 
> diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
> index 38590f1ae9ee..a3f3f3aa9e6e 100644
> --- a/include/sound/simple_card_utils.h
> +++ b/include/sound/simple_card_utils.h
> @@ -69,6 +69,7 @@ struct asoc_simple_priv {
>   	} *dai_props;
>   	struct asoc_simple_jack hp_jack;
>   	struct asoc_simple_jack mic_jack;
> +	struct snd_soc_jack *aux_jacks;
>   	struct snd_soc_dai_link *dai_link;
>   	struct asoc_simple_dai *dais;
>   	struct snd_soc_dai_link_component *dlcs;
> @@ -187,6 +188,8 @@ int asoc_simple_parse_pin_switches(struct snd_soc_card *card,
>   int asoc_simple_init_jack(struct snd_soc_card *card,
>   			       struct asoc_simple_jack *sjack,
>   			       int is_hp, char *prefix, char *pin);
> +int asoc_simple_init_aux_jacks(struct asoc_simple_priv *priv,
> +				char *prefix);
>   int asoc_simple_init_priv(struct asoc_simple_priv *priv,
>   			       struct link_info *li);
>   int asoc_simple_remove(struct platform_device *pdev);
> diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
> index e35becce9635..668123549fbf 100644
> --- a/sound/soc/generic/simple-card-utils.c
> +++ b/sound/soc/generic/simple-card-utils.c
> @@ -786,6 +786,69 @@ int asoc_simple_init_jack(struct snd_soc_card *card,
>   }
>   EXPORT_SYMBOL_GPL(asoc_simple_init_jack);
>   
> +int asoc_simple_init_aux_jacks(struct asoc_simple_priv *priv, char *prefix)
> +{
> +	struct snd_soc_card *card = simple_priv_to_card(priv);
> +	struct device *dev = card->dev;
> +	struct snd_soc_component *component;
> +	char prop[128];
> +	int found_jack_index = 0;
> +	int num = 0;
> +	int ret;
> +
> +	if (priv->aux_jacks)
> +		return 0;
> +
> +	snprintf(prop, sizeof(prop), "%saux-jack-types", prefix);
> +	num = of_property_count_u32_elems(dev->of_node, prop);
> +	if (num < 1)
> +		return 0;
> +
> +	priv->aux_jacks = devm_kcalloc(card->dev, num,
> +				       sizeof(struct snd_soc_jack), GFP_KERNEL);
> +	if (!priv->aux_jacks)
> +		return -ENOMEM;
> +
> +	for_each_card_auxs(card, component) {
> +		if (found_jack_index >= num)
> +			break;
> +
> +		if (component->driver->set_jack &&
> +		    component->driver->get_jack_supported_type) {

This check is really weird, you are checking if callbacks exist at all, 
which should be unnecessary as it duplicates the work oh 
snd_soc_component_ functions. I would just try to call 
snd_soc_component_get_jack_supported_type() directly and if it returns 
-ENOTSUPP, just go to next iteration.
I guess your main problem is snd_soc_component_set_jack(), but you can 
just call it with NULL jack to check if it returns -ENOTSUPP, but I 
guess the overall asumption would be that if someone implements 
.get_jack_supported_type, they also implemented .set_jack, so maybe it 
is just unnecessary?

> +			char id[128];
> +			int type = 0;
> +			struct snd_soc_jack *jack =
> +				&(priv->aux_jacks[found_jack_index]);
> +			int type_supp_mask =
> +				snd_soc_component_get_jack_supported_type(
> +					component);
> +
> +			ret = of_property_read_u32_index(
> +				dev->of_node, prop, found_jack_index++, &type);
> +			if (ret)
> +				continue;
> +
> +			if (type)
> +				type &= type_supp_mask; /* use only supported types */
> +			else
> +				type = type_supp_mask; /* use all supported types */
> +
> +			if (!type)
> +				continue;
> +
> +			/* create jack */
> +			snprintf(id, sizeof(id), "%s-jack", component->name);
> +			ret = snd_soc_card_jack_new(card, id, type, jack);
> +			if (ret)
> +				continue;
> +
> +			(void)snd_soc_component_set_jack(component, jack, NULL);
> +		}
> +	}
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(asoc_simple_init_aux_jacks);
> +
>   int asoc_simple_init_priv(struct asoc_simple_priv *priv,
>   			  struct link_info *li)
>   {
> diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
> index feb55b66239b..e98932c16754 100644
> --- a/sound/soc/generic/simple-card.c
> +++ b/sound/soc/generic/simple-card.c
> @@ -623,6 +623,10 @@ static int simple_soc_probe(struct snd_soc_card *card)
>   	if (ret < 0)
>   		return ret;
>   
> +	ret = asoc_simple_init_aux_jacks(priv, PREFIX);
> +	if (ret < 0)
> +		return ret;
> +
>   	return 0;
>   }
>   

