Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B70696C8F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 19:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbjBNSOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 13:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232930AbjBNSOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 13:14:35 -0500
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB903A93;
        Tue, 14 Feb 2023 10:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
        s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=7UiTt2U5U+keNr7GSs36T48tk7MVL1FoJS8R8CnMXGM=; b=C00pkt563Z3KjI9vz41S1iMCTD
        N4RfsdniXaJeA88YxA2Ww5QMTGddIyPlHXEdYSiQ+LfOXLEQMpQZcy2eV0Id+f0WtPCUiY9qn8FQz
        U8us3U9MiV4b4sljhHsfvy2RWR3kEuFOv9mxg6P/L/XPgloVhYhItjrjSkJ61y0lwxdHUYb277jyi
        szUNEprxBeeQ3/n44i1XSnytn2XV3ZZIOtDiU5P9X1tOhRcm4FuVidJ+XWJ7XBnwFrvOo23/YvZsn
        vUkYSmU2a40597F9G0XYmlaHDKBg9hBtsXuVWV70KN6jqKUBWghCRkhPsNAsvrvvTMlEEhkzCb1MA
        ticvzzig==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <lars@metafoo.de>)
        id 1pRzp2-000BdF-7q; Tue, 14 Feb 2023 19:14:32 +0100
Received: from [2604:5500:c0e5:eb00:da5e:d3ff:feff:933b]
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1pRzp1-000KQi-N8; Tue, 14 Feb 2023 19:14:31 +0100
Message-ID: <b065e2bb-1f11-067a-b085-45d47626927e@metafoo.de>
Date:   Tue, 14 Feb 2023 10:14:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/3] ASoC: soc-generic-dmaengine-pcm: add option to start
 DMA after DAI
Content-Language: en-US
To:     Claudiu Beznea <claudiu.beznea@microchip.com>, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, perex@perex.cz, tiwai@suse.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230214161435.1088246-1-claudiu.beznea@microchip.com>
 <20230214161435.1088246-2-claudiu.beznea@microchip.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <20230214161435.1088246-2-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.7/26812/Tue Feb 14 09:53:27 2023)
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/23 08:14, Claudiu Beznea wrote:
> diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
> index 3b99f619e37e..264e87af6b58 100644
> --- a/sound/soc/soc-generic-dmaengine-pcm.c
> +++ b/sound/soc/soc-generic-dmaengine-pcm.c
> @@ -318,7 +318,7 @@ static int dmaengine_copy_user(struct snd_soc_component *component,
>   	return 0;
>   }
>   
> -static const struct snd_soc_component_driver dmaengine_pcm_component = {
> +static struct snd_soc_component_driver dmaengine_pcm_component = {
>   	.name		= SND_DMAENGINE_PCM_DRV_NAME,
>   	.probe_order	= SND_SOC_COMP_ORDER_LATE,
>   	.open		= dmaengine_pcm_open,
> @@ -329,7 +329,7 @@ static const struct snd_soc_component_driver dmaengine_pcm_component = {
>   	.pcm_construct	= dmaengine_pcm_new,
>   };
>   
> -static const struct snd_soc_component_driver dmaengine_pcm_component_process = {
> +static struct snd_soc_component_driver dmaengine_pcm_component_process = {
>   	.name		= SND_DMAENGINE_PCM_DRV_NAME,
>   	.probe_order	= SND_SOC_COMP_ORDER_LATE,
>   	.open		= dmaengine_pcm_open,
> @@ -425,7 +425,7 @@ static const struct snd_dmaengine_pcm_config snd_dmaengine_pcm_default_config =
>   int snd_dmaengine_pcm_register(struct device *dev,
>   	const struct snd_dmaengine_pcm_config *config, unsigned int flags)
>   {
> -	const struct snd_soc_component_driver *driver;
> +	struct snd_soc_component_driver *driver;
>   	struct dmaengine_pcm *pcm;
>   	int ret;
>   
> @@ -450,6 +450,8 @@ int snd_dmaengine_pcm_register(struct device *dev,
>   	else
>   		driver = &dmaengine_pcm_component;
>   
> +	driver->start_dma_last = config->start_dma_last;

This will break if you have multiple sound cards in the system. 
dmaengine_pcm_component must stay const.

