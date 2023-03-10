Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8536B4950
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 16:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbjCJPLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 10:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233950AbjCJPKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 10:10:38 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9985256;
        Fri, 10 Mar 2023 07:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678460581; x=1709996581;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FdWrrEiVvcGV5We2oP4cFNJrwxSOXnTFkXSWK6R+KRo=;
  b=Swaa2Gn66VmQ98H0uc0g81vbOUzfQtWVrvlTeLWwuH00tj3alj/fYl+I
   p0u4l0Mg9oINryaL1l69yp1mLvaaPHV1C0YFXg4Z/YVlIhj56t8AxYdgN
   WohAkWZuwPWA0/PhBsN0qd64FPP6lS8UbfandFr5ou97aamzmgMP5XNB9
   Lcilswtd8bfKL9P6OAEDLyfH0A94gj3ihpnsLnDKWZp/Op3cT3BNe+wy8
   rgzYTq9xjf7eaR7m+68dAm+/iJCmE+aI3rCQcF4xi5Gej64anVyMjom/5
   7gdnQG0oqKDLY5H9wC8ntAR/PRDeaCLuWDxWltQmaaQtPfXMOqjnZJWqG
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="336764006"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="336764006"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 07:01:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="788037593"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="788037593"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.16.144]) ([10.99.16.144])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 07:01:47 -0800
Message-ID: <a23852d7-c70c-a03c-99fb-b453bdc750a1@linux.intel.com>
Date:   Fri, 10 Mar 2023 16:01:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] ASoC: Use of_property_present() for testing DT property
 presence
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org
References: <20230310144732.1546328-1-robh@kernel.org>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20230310144732.1546328-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/2023 3:47 PM, Rob Herring wrote:
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties. As
> part of this, convert of_get_property/of_find_property calls to the
> recently added of_property_present() helper when we just want to test
> for presence of a property and nothing more.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>   sound/soc/codecs/lpass-macro-common.c | 2 +-
>   sound/soc/generic/audio-graph-card.c  | 2 +-
>   sound/soc/generic/audio-graph-card2.c | 2 +-
>   sound/soc/mxs/mxs-sgtl5000.c          | 2 +-
>   sound/soc/samsung/i2s.c               | 2 +-
>   sound/soc/sh/fsi.c                    | 2 +-
>   sound/soc/stm/stm32_i2s.c             | 2 +-
>   sound/soc/stm/stm32_sai_sub.c         | 4 ++--
>   sound/soc/tegra/tegra_asoc_machine.c  | 2 +-
>   9 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/sound/soc/codecs/lpass-macro-common.c b/sound/soc/codecs/lpass-macro-common.c
> index 1b9082d237c1..f54baaad54d4 100644
> --- a/sound/soc/codecs/lpass-macro-common.c
> +++ b/sound/soc/codecs/lpass-macro-common.c
> @@ -16,7 +16,7 @@ struct lpass_macro *lpass_macro_pds_init(struct device *dev)
>   	struct lpass_macro *l_pds;
>   	int ret;
>   
> -	if (!of_find_property(dev->of_node, "power-domains", NULL))
> +	if (!of_property_present(dev->of_node, "power-domains"))
>   		return NULL;
>   
>   	l_pds = devm_kzalloc(dev, sizeof(*l_pds), GFP_KERNEL);
> diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
> index 5daa824a4ffc..d788f5f23a8a 100644
> --- a/sound/soc/generic/audio-graph-card.c
> +++ b/sound/soc/generic/audio-graph-card.c
> @@ -78,7 +78,7 @@ static int graph_get_dai_id(struct device_node *ep)
>   		 * only of_graph_parse_endpoint().
>   		 * We need to check "reg" property
>   		 */
> -		if (of_get_property(ep,   "reg", NULL))
> +		if (of_property_present(ep,   "reg"))

Bit of nit picking, but any reason, why there are multiple spaces, 
before "reg" here?

>   			return info.id;
>   
>   		node = of_get_parent(ep);
> diff --git a/sound/soc/generic/audio-graph-card2.c b/sound/soc/generic/audio-graph-card2.c
> index 06609a526b78..259544f64df9 100644
> --- a/sound/soc/generic/audio-graph-card2.c
> +++ b/sound/soc/generic/audio-graph-card2.c
> @@ -376,7 +376,7 @@ static int graph_get_dai_id(struct device_node *ep)
>   		 * only of_graph_parse_endpoint().
>   		 * We need to check "reg" property
>   		 */
> -		if (of_get_property(ep,   "reg", NULL))
> +		if (of_property_present(ep,   "reg"))

And here?


