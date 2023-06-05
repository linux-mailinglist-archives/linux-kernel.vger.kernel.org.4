Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B49722177
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 10:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjFEIyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 04:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjFEIyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 04:54:13 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7836CDB;
        Mon,  5 Jun 2023 01:54:11 -0700 (PDT)
X-GND-Sasl: herve.codina@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685955249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dNvkGsaRNjcLUAaRAQc2wTZtlEs619LxRWDYK7s9IYw=;
        b=WDaiNeGp/8dW6v+ebqBLy0MPRo35NcuuRkxke6vf8dj8iHnv5Nl6xKEKMBGvu3VvsREio8
        sDRcdg9puN/CvYQJb68brM5++QqwFvsZsz71TJrspS9Cmj2Z3785dOBfNEcjaW/nNYIZUx
        DR4nw6QbTBQmnaF8CnzvwCAlu9yIWWblgKAkQru2+p183k8RpBWbfjuHpHwLAvtdmDOcHP
        UVgnW/riry09OBZ7IviYz6ag1wV9o3fs1lij42CwZ8vQpC52/iEAlAGi60WDAGCvV2CcbB
        289lKtWAcOcXHzS3SOO9YwRZHw2q6YOftNf9Zn+MqlmPFyr666NuUf9vSlA0lw==
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5089E1C0005;
        Mon,  5 Jun 2023 08:54:06 +0000 (UTC)
Date:   Mon, 5 Jun 2023 10:54:05 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     andy.shevchenko@gmail.com
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 6/9] ASoC: soc-dapm.h: Add a helper to build a DAPM
 widget dynamically
Message-ID: <20230605105405.39bcebef@bootlin.com>
In-Reply-To: <ZHtJLxNReoc4Yjqj@surfacebook>
References: <20230523151223.109551-1-herve.codina@bootlin.com>
        <20230523151223.109551-7-herve.codina@bootlin.com>
        <ZHtJLxNReoc4Yjqj@surfacebook>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Jun 2023 17:07:43 +0300
andy.shevchenko@gmail.com wrote:

> Tue, May 23, 2023 at 05:12:20PM +0200, Herve Codina kirjoitti:
> > The SND_SOC_DAPM_* helpers family are used to build widgets array in a
> > static way.
> > 
> > Introduce SND_SOC_DAPM_WIDGET() in order to use the SND_SOC_DAPM_*
> > helpers family in a dynamic way. The different SND_SOC_DAPM_* parameters
> > can be computed by the code and the widget can be built based on this
> > parameter computation.
> > For instance:
> >   static int create_widget(char *input_name)
> >   {
> > 	struct snd_soc_dapm_widget widget;
> > 	char name*;
> > 	...
> > 	name = input_name;
> > 	if (!name)
> > 		name = "default";
> > 
> > 	widget = SND_SOC_DAPM_WIDGET(SND_SOC_DAPM_INPUT(name));
> > 	...
> >   }  
> 
> Maybe instead of adding a helper, simply convert those macros to provide
> a compaund literal? (See, for example,
> https://elixir.bootlin.com/linux/v6.4-rc4/source/include/linux/pinctrl/pinctrl.h#L42)
> 

Indeed, I will convert macros and remove the helper in the next iteration.

Thanks for the review,
Hervé
