Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5402B72DDE0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237754AbjFMJhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241430AbjFMJhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:37:20 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715841BD8;
        Tue, 13 Jun 2023 02:37:11 -0700 (PDT)
X-GND-Sasl: herve.codina@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686649030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eEwfBJFCHzxYRQZi7kEFO2bxAicvTJZZs7UatO3IpJY=;
        b=cI4E+0KOLchkY75M01qJZk03RB9OYLGMIknmHlekjZAFP9rMQm4qdF0plxkJvW4o0wQb3V
        aeOKu0+VWSa+XUy0hxzF17L3AyuurA1xLK/8403rCjD34EdOaVFxFBuQvaoGKhfT+sU63P
        8VpipIM3aay0z2B77mUXpat210sCtstH5/ByVej4cne+lLryxekrqE9YtnGoHCkfJT++U4
        j32ezAkUWMdd4ILDfcxzg+8fI0CcCMTB5bVwNzI2mAYfMyHvynBFzTYu6avs8GGNEzTdtz
        UXB3+Crd46nY2Qsey6k71iqGnlTyj5iGRVCQH/sTtqBREr1QCPP6SeOKDt9EZw==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id 76FB11C0005;
        Tue, 13 Jun 2023 09:37:08 +0000 (UTC)
Date:   Tue, 13 Jun 2023 11:37:07 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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
Subject: Re: [PATCH v3 11/12] ASoC: codecs: Add support for the generic IIO
 auxiliary devices
Message-ID: <20230613113707.0b5d9648@bootlin.com>
In-Reply-To: <CAHp75Vfz+vSJ7rQ4sxb0R+zRbrjipXUX3VpaHyvOWWePdPxejQ@mail.gmail.com>
References: <20230612122926.107333-1-herve.codina@bootlin.com>
        <20230612122926.107333-12-herve.codina@bootlin.com>
        <CAHp75Vfz+vSJ7rQ4sxb0R+zRbrjipXUX3VpaHyvOWWePdPxejQ@mail.gmail.com>
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

On Mon, 12 Jun 2023 17:37:00 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> ...
> 
> > +       struct snd_kcontrol_new control = {0};  
> 
> 0 is not needed.

Not for this one.

The variable is in stack.
Some of the structure members will be set in the code but we need to ensure
that all others are set to 0.

The full context:
--- 8< ---
static int audio_iio_aux_add_controls(struct snd_soc_component *component,
				      struct audio_iio_aux_chan *chan)
{
	struct snd_kcontrol_new control = {0};

	control.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
	control.name = chan->name;
	control.info = audio_iio_aux_info_volsw;
	control.get = audio_iio_aux_get_volsw;
	control.put = audio_iio_aux_put_volsw;
	control.private_value = (unsigned long)chan;

	return snd_soc_add_component_controls(component, &control, 1);
}
--- 8< ---

Thanks for the review,
Hervé
