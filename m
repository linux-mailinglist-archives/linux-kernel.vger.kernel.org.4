Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F286272612C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 15:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239785AbjFGNXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 09:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235770AbjFGNXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 09:23:15 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6503995;
        Wed,  7 Jun 2023 06:23:13 -0700 (PDT)
X-GND-Sasl: herve.codina@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686144191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=upXsJBaOapv3HfJgv1RgsURS5W6Qd+6TPxSPKkAE5j8=;
        b=jyfk1DMy8T+5r8MYSOQUudfcbk5sSXz5MeduU4Kee3pdk9FYRkqe9M7/Z7PZvEH0IpOZVG
        dZFuCOQskx1e/WzL0LIjkwDW2kG2L13bG0KMLcYUb3y5VOjjs0k18C17jfGkGJap7wuDHm
        F0qwd/wZyVlfhOHnZDqB51cFWB1Nz0y46LfhPiUacRrQxPYi19zNIfnC2a2lXo/dLsQK/k
        C7UiW/tl3AWH55f6nX1gHlGy792zZA6c1obgpiR9NYYuhiVpkxJEo3q6Cj2SDtQk07SXMV
        QcCtdd7gDT9P6zErA+YK7QicVFwQraPa6P9bli7/8OPC39m7MZWw0j2Wq1AcCQ==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8F55940017;
        Wed,  7 Jun 2023 13:23:09 +0000 (UTC)
Date:   Wed, 7 Jun 2023 15:23:08 +0200
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
Subject: Re: [PATCH v2 7/9] ASoC: codecs: Add support for the generic IIO
 auxiliary devices
Message-ID: <20230607152308.02b404e1@bootlin.com>
In-Reply-To: <20230606155404.28ada064@bootlin.com>
References: <20230523151223.109551-1-herve.codina@bootlin.com>
        <20230523151223.109551-8-herve.codina@bootlin.com>
        <ZHuFywIrTnEFpX6e@surfacebook>
        <20230606155404.28ada064@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Tue, 6 Jun 2023 15:54:04 +0200
Herve Codina <herve.codina@bootlin.com> wrote:

...
> >   
> > > +	platform_set_drvdata(pdev, iio_aux);    
> > 
> > Which callback is using this driver data?  
> 
> None -> I will remove platform_set_drvdata().
> 

My previous answer was not correct.
The platform_set_drvdata() call is needed.

In fact, the driver uses snd_soc_component_get_drvdata() 
  https://elixir.bootlin.com/linux/v6.4-rc5/source/include/sound/soc-component.h#L425
and this snd_soc_component_get_drvdata() get the driver data set by the
platform_set_drvdata() call.

I cannot use snd_soc_component_set_drvdata() to set the driver data because
I haven't got the struct snd_soc_component instance when I need to set the
driver data.

So, I will not remove the platform_set_drvdata() call.

The sequence is:
  --- 8< ---
  static int audio_iio_aux_probe(struct platform_device *pdev)
  {
	struct audio_iio_aux *iio_aux;

	iio_aux = devm_kzalloc(&pdev->dev, sizeof(*iio_aux), GFP_KERNEL);
	if (!iio_aux)
		return -ENOMEM;

	...

	platform_set_drvdata(pdev, iio_aux);

	return devm_snd_soc_register_component(iio_aux->dev,
					       &audio_iio_aux_component_driver,
					       NULL, 0);
  }
  --- 8< ---

The struct snd_soc_component instance will be create during the 
devm_snd_soc_register_component() call.

Regards,
Hervé

-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
