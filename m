Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D53B700ABA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 16:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241437AbjELOy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 10:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241510AbjELOyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 10:54:24 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A6410CC;
        Fri, 12 May 2023 07:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683903263; x=1715439263;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uGW19VCfL7GXY1Mq1+j9cRUyiM2wju2JbHUARR1lJbw=;
  b=OeDQ3lXyICa0IZUfp3HISW1EQRo2dZmkNj9dtn2twHC6szLd8E1WWJhE
   vD6jpwnhP0PG7TAvuJZz+XmAkIbb/lM6BtC70lmPbeppY7stSWj7pWJ1G
   a4bJAjAHuCwErdD4HzYtauS8a1hmXTAATO1R1FtEKmdacbUDdIHRBErTq
   wiHN0eYOOl8o9/bAwEm3PjlzLrcB+6mUAC77gow0tuMNz0Vl+vop/xi7q
   JJP/L/JuCcPpyD5AgUF+Iff7J/MA2zaJaEnNhkfzjcpmiXd1RILZYI45m
   pgU0uFGLmlGNb7Iv3Iq19fJSCsNVOLkLMBQ3Z2vQyTeTBLjdw+u4SYAm9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="437140412"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="437140412"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 07:54:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="844441294"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="844441294"
Received: from winkelru-mobl.amr.corp.intel.com (HELO [10.212.144.249]) ([10.212.144.249])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 07:54:22 -0700
Message-ID: <138e5c73-c33b-806a-b64e-5c93aaefb140@linux.intel.com>
Date:   Fri, 12 May 2023 08:48:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH 03/10] ASoC: ak4118: Update to use new component control
 notify helper
Content-Language: en-US
To:     Charles Keepax <ckeepax@opensource.cirrus.com>, broonie@kernel.org,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, linus.walleij@linaro.org,
        vkoul@kernel.org
Cc:     lgirdwood@gmail.com, yung-chuan.liao@linux.intel.com,
        sanyog.r.kale@intel.com, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230512122838.243002-1-ckeepax@opensource.cirrus.com>
 <20230512122838.243002-4-ckeepax@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230512122838.243002-4-ckeepax@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/12/23 07:28, Charles Keepax wrote:
> Update the driver to use the new ASoC core control notify helper.
> This also fixes a bug where the control would not be found if the
> CODEC was given a name prefix.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  sound/soc/codecs/ak4118.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/sound/soc/codecs/ak4118.c b/sound/soc/codecs/ak4118.c

should patches 2, 3, 4 be part of a separate series, they really have
nothing to do with the Cirrus CS32L43?

> index b6d9a10bdccdc..74ccfb0d921d6 100644
> --- a/sound/soc/codecs/ak4118.c
> +++ b/sound/soc/codecs/ak4118.c
> @@ -264,8 +264,6 @@ static irqreturn_t ak4118_irq_handler(int irq, void *data)
>  	struct ak4118_priv *ak4118 = data;
>  	struct snd_soc_component *component = ak4118->component;
>  	struct snd_kcontrol_new *kctl_new;
> -	struct snd_kcontrol *kctl;
> -	struct snd_ctl_elem_id *id;
>  	unsigned int i;
>  
>  	if (!component)
> @@ -273,13 +271,8 @@ static irqreturn_t ak4118_irq_handler(int irq, void *data)
>  
>  	for (i = 0; i < ARRAY_SIZE(ak4118_iec958_controls); i++) {
>  		kctl_new = &ak4118_iec958_controls[i];
> -		kctl = snd_soc_card_get_kcontrol(component->card,
> -						 kctl_new->name);
> -		if (!kctl)
> -			continue;
> -		id = &kctl->id;
> -		snd_ctl_notify(component->card->snd_card,
> -			       SNDRV_CTL_EVENT_MASK_VALUE, id);
> +
> +		snd_soc_component_notify_control(component, kctl_new->name);
>  	}
>  
>  	return IRQ_HANDLED;
