Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231087171CF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbjE3XjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjE3XjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:39:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F07CAA
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=1Dw3EGfLZhFfy3+wVtWlL1NBwMICEGnt2pRJcPI4ppc=; b=fvcRwGGOaprOoxX4TJWrFse6e1
        eoOnh5Rd2CCbsl8XoPZzPp99q95sd/oH8XyWBxgUoaZw3ca/YmpXf7A4NUCAsICkiVq9d8DWNElHw
        hfGh5noP4xw7VhxbYtmPCZCjj58qK5PmbmS5Yn2EZoM3VUcFqYrA+gKrMMIby6G7m88gnAG3zIw+h
        LyI/ybyTq2BuQM1VqaRDT6YXKE2oDGvtVjWZhmJzdbXkBha6mcRJm2V3P/zf9SYtT/vIWmbUcE6tF
        ebHpJ+B+eGhOVyonYQBokmQZd/ABlFNyG2DlzrYTUTFR9FPOk1hCeaA2eldGt1RQOm9S8aycKQlel
        6aIUMNog==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q48vX-00FUrv-08;
        Tue, 30 May 2023 23:38:55 +0000
Message-ID: <71922379-ee3d-9d6d-33dd-edcf8ef7508e@infradead.org>
Date:   Tue, 30 May 2023 16:38:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 RESEND] ASoC: fsl MPC52xx drivers require PPC_BESTCOMM
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     Grant Likely <grant.likely@secretlab.ca>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
References: <20230521225702.1608-1-rdunlap@infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230521225702.1608-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello maintainers,

I am still seeing these build errors on linux-next-20230530.

Is there a problem with the patch?
Thanks.

On 5/21/23 15:57, Randy Dunlap wrote:
> Both SND_MPC52xx_SOC_PCM030 and SND_MPC52xx_SOC_EFIKA select
> SND_SOC_MPC5200_AC97. The latter symbol depends on PPC_BESTCOMM,
> so the 2 former symbols should also depend on PPC_BESTCOMM since
> "select" does not follow any dependency chains.
> 
> This prevents a kconfig warning and build errors:
> 
> WARNING: unmet direct dependencies detected for SND_SOC_MPC5200_AC97
>   Depends on [n]: SOUND [=y] && !UML && SND [=m] && SND_SOC [=m] && SND_POWERPC_SOC [=m] && PPC_MPC52xx [=y] && PPC_BESTCOMM [=n]
>   Selected by [m]:
>   - SND_MPC52xx_SOC_PCM030 [=m] && SOUND [=y] && !UML && SND [=m] && SND_SOC [=m] && SND_POWERPC_SOC [=m] && PPC_MPC5200_SIMPLE [=y]
>   - SND_MPC52xx_SOC_EFIKA [=m] && SOUND [=y] && !UML && SND [=m] && SND_SOC [=m] && SND_POWERPC_SOC [=m] && PPC_EFIKA [=y]
> 
> ERROR: modpost: "mpc5200_audio_dma_destroy" [sound/soc/fsl/mpc5200_psc_ac97.ko] undefined!
> ERROR: modpost: "mpc5200_audio_dma_create" [sound/soc/fsl/mpc5200_psc_ac97.ko] undefined!
> 
> Fixes: 40d9ec14e7e1 ("ASoC: remove BROKEN from Efika and pcm030 fabric drivers")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Shengjiu Wang <shengjiu.wang@gmail.com>
> Cc: Xiubo Li <Xiubo.Lee@gmail.com>
> Cc: alsa-devel@alsa-project.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> ---
> v2: use correct email address for Mark Brown.
> 
>  sound/soc/fsl/Kconfig |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff -- a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
> --- a/sound/soc/fsl/Kconfig
> +++ b/sound/soc/fsl/Kconfig
> @@ -243,7 +243,7 @@ config SND_SOC_MPC5200_AC97
>  
>  config SND_MPC52xx_SOC_PCM030
>  	tristate "SoC AC97 Audio support for Phytec pcm030 and WM9712"
> -	depends on PPC_MPC5200_SIMPLE
> +	depends on PPC_MPC5200_SIMPLE && PPC_BESTCOMM
>  	select SND_SOC_MPC5200_AC97
>  	select SND_SOC_WM9712
>  	help
> @@ -252,7 +252,7 @@ config SND_MPC52xx_SOC_PCM030
>  
>  config SND_MPC52xx_SOC_EFIKA
>  	tristate "SoC AC97 Audio support for bbplan Efika and STAC9766"
> -	depends on PPC_EFIKA
> +	depends on PPC_EFIKA && PPC_BESTCOMM
>  	select SND_SOC_MPC5200_AC97
>  	select SND_SOC_STAC9766
>  	help

-- 
~Randy
