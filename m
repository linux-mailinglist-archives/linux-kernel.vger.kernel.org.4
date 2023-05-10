Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B50F6FDD4D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 13:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236410AbjEJL7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 07:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbjEJL7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 07:59:19 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F053430FB;
        Wed, 10 May 2023 04:59:16 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9659443fb56so1104085366b.2;
        Wed, 10 May 2023 04:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683719955; x=1686311955;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wBh03BIVJ6bBsfdWgoiwpXPJcFGoTrOV/vp+iVHTloM=;
        b=D1EKLsRZ9GZ3EE2mrLEAHlZJdZsZuTA5tn+mox4JeoT6BFLOEdfVySNpyIG2TT5+pN
         +l+MrnHviHrT8NJWLa6csqo604JNo/arjFPSSIy4oXN4IB4xo+pjko2n/I1jFkL9r5uL
         lKXAnnrH2aBlit0xNM9EuTAeaMsKWxkDs68D2ePXajr1Eriy2JGnrr0lkKpzHQTrDJNp
         V0bodjFUJlaIIvRwIZuMW9fvVV8beKheRDmc8bQ8C2OwOEyaiEIWBoysq0A6SIvzl8kD
         IKw13w74WWTRUXH6hrUiKgtU2yARMMfY4avsnfic91aSwgXaq4gz9JUZZhRscmi6onSh
         2zBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683719955; x=1686311955;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wBh03BIVJ6bBsfdWgoiwpXPJcFGoTrOV/vp+iVHTloM=;
        b=QSkt07eLUd1+S2UWJevo+sBonv3JB/yXJhOkPo01RP5Bjp5FTyPf13G/LtR2jc4btc
         E2Vjn9/0fTGA+iraSy/ai75tYT5EgVEgTtOEDjTgDJQHXTH+ui1UXnbVR2/Jv0JMPVKZ
         f5nVscpdw++mZKYV2cPDkBfQrS7OHm5MUUhOZl8rNubxH4ALuzwRT1g8/Vgg7ptZHvZi
         4dm1SCVlHETLyuupF/sEMZotOeEhJjKE7Y7U7ZmH+rFsTpm3UO7cdsu8TNM1l7rwK/T5
         sjaRKU5qmAfCx/vBydtvv8TEnpe89HqMJQIwt2jkr0hugjQR7cHt0Sv0C+O7ESXJF2T9
         45wQ==
X-Gm-Message-State: AC+VfDz2MwBBXr+St34O3slcLMYnreF3A8vyce5+jt1fyqdpz7ABmqbJ
        sWRwiLveAd+PuTRxRPWqr0Q=
X-Google-Smtp-Source: ACHHUZ5qqw5cgGI6/qLkFeV1i5mxPFvZkUe/ofZQm3xfr4w4TXbnYwlTpXRQ3Oliz8VjGH7gNSPPUQ==
X-Received: by 2002:a17:907:3606:b0:961:800b:3f57 with SMTP id bk6-20020a170907360600b00961800b3f57mr14857074ejc.77.1683719955031;
        Wed, 10 May 2023 04:59:15 -0700 (PDT)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id m24-20020a1709062b9800b009686a7dc71csm2617945ejg.30.2023.05.10.04.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 04:59:12 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
        id 1D2B1BE2DE0; Wed, 10 May 2023 13:59:12 +0200 (CEST)
Date:   Wed, 10 May 2023 13:59:12 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Eugene Huang <eugene.huang99@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        =?iso-8859-1?Q?P=E9ter?= Ujfalusi 
        <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, cezary.rojewski@intel.com,
        liam.r.girdwood@linux.intel.com, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com, perex@perex.cz, tiwai@suse.com,
        gongjun.song@intel.com, shumingf@realtek.com, yong.zhi@intel.com,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH AUTOSEL 5.10 1/3] ASOC: Intel: sof_sdw: add quirk for
 Intel 'Rooks County' NUC M15
Message-ID: <ZFuHEML1r5Xd6S7g@eldamar.lan>
References: <20230420110326.506279-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230420110326.506279-1-sashal@kernel.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sasha,

On Thu, Apr 20, 2023 at 07:03:22AM -0400, Sasha Levin wrote:
> From: Eugene Huang <eugene.huang99@gmail.com>
> 
> [ Upstream commit 3c728b1bc5b99c5275ac5c7788ef814c0e51ef54 ]
> 
> Same quirks as the 'Bishop County' NUC M15, except the rt711 is in the
> 'JD2 100K' jack detection mode.
> 
> Link: https://github.com/thesofproject/linux/issues/4088
> Signed-off-by: Eugene Huang <eugene.huang99@gmail.com>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> Link: https://lore.kernel.org/r/20230314090553.498664-2-yung-chuan.liao@linux.intel.com
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  sound/soc/intel/boards/sof_sdw.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
> index f5d8f7951cfc3..eb713e9c2bd22 100644
> --- a/sound/soc/intel/boards/sof_sdw.c
> +++ b/sound/soc/intel/boards/sof_sdw.c
> @@ -175,6 +175,17 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
>  					SOF_SDW_PCH_DMIC |
>  					SOF_RT711_JD_SRC_JD2),
>  	},
> +	{
> +		/* NUC15 'Rooks County' LAPRC510 and LAPRC710 skews */
> +		.callback = sof_sdw_quirk_cb,
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Intel(R) Client Systems"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "LAPRC"),
> +		},
> +		.driver_data = (void *)(SOF_SDW_TGL_HDMI |
> +					SOF_SDW_PCH_DMIC |
> +					RT711_JD2_100K),
> +	},
>  	/* TigerLake-SDCA devices */
>  	{
>  		.callback = sof_sdw_quirk_cb,
> -- 
> 2.39.2

Is this correct that this can be picked for 5.10.y? I did (by mistake)
AFAICS this is in 5.10.180-rc1, and building leads to:

sound/soc/intel/boards/sof_sdw.c:187:6: error: ‘RT711_JD2_100K’ undeclared here (not in a function)
  187 |      RT711_JD2_100K),
      |      ^~~~~~~~~~~~~~
make[7]: *** [scripts/Makefile.build:286: sound/soc/intel/boards/sof_sdw.o] Error 1
make[6]: *** [scripts/Makefile.build:503: sound/soc/intel/boards] Error 2
make[5]: *** [scripts/Makefile.build:503: sound/soc/intel] Error 2
make[4]: *** [scripts/Makefile.build:503: sound/soc] Error 2

Regards,
Salvatore
