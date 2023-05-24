Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B08070F5FE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 14:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbjEXMO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 08:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjEXMOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 08:14:24 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DEA18B;
        Wed, 24 May 2023 05:14:17 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 11A0CFF814;
        Wed, 24 May 2023 12:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1684930455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WGhKGOeeQ5Auujw7usU7+enotiHVhoYjEj7//E+Utu0=;
        b=PD2zGS7Vle6F3VIeArgHoQYFFY32gQQSjXDofYUypw57c33BOV7vaP2lBWfdnJTZ55V+8X
        U7tOiQjse0fmxwNTbWXqNmZ7f2c9epmNUX85oXqL+EjUhQNjZe7YFNHKGfsheneSVnV9lc
        7IcFO7ZwDvFgwSrZTH6ymcoVIz9JB5L2Qa4xutbXMvyMwBlwbix5arl8bzu0hd6JCDVEnG
        iS95qVSSGUN6s+ETrne3A6gAPcnTc7T0olZS6/5Ae6t8ww2q1crog8irzWdWca5bc9q7wa
        opstLKM6IEp+kM6kK6Vt/oJYm0o8o/0PZDiUgeEtaQzkcS3Xp8Yrf9Xjc2HG1A==
Date:   Wed, 24 May 2023 14:14:11 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 9/9] ASoC: simple-card: Handle additional devices
Message-ID: <20230524141411.28765782@bootlin.com>
In-Reply-To: <87mt1u7fql.wl-kuninori.morimoto.gx@renesas.com>
References: <20230523151223.109551-1-herve.codina@bootlin.com>
        <20230523151223.109551-10-herve.codina@bootlin.com>
        <87mt1u7fql.wl-kuninori.morimoto.gx@renesas.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
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

Hi Kuninori,

On Wed, 24 May 2023 00:08:50 +0000
Kuninori Morimoto <kuninori.morimoto.gx@renesas.com> wrote:

> Hi
> 
> > An additional-devs subnode can be present in the simple-card top node.
> > This subnode is used to declared some "virtual" additional devices.
> > 
> > Create related devices from this subnode and avoid this subnode presence
> > to interfere with the already supported subnodes analysis.
> > 
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---  
> 
> simple-card is used in many boards, but is old.
> Adding new feature on audio-graph-card/audio-graph-card2 instead of simple-card
> is my ideal, but it is OK.
> 
> simple-card is possible to handle multiple DAI links by using
> "dai-link" node on 1 Sound Card. see
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/sound/simple-card.yaml?h=v6.4-rc3#n294
> 
> Is this "additional-devs" available only one per 1 Card ?
> If it is possible to use 1 additional-devs per 1 DAI link, I think this patch want to
> care "dai-link".
> Or adding temporally NOTE or FIXME message like /* NOTE: it doesn't support dai-link so far */
> is good idea.

As you said on your other mail 1 "additional-devs" per 1 Card.
And further more, I think that "additional-devs" has nothing to do with
DAI link.
These additional devices are really related to the the Card itself and
not DAI links.

simple_populate_aux() needs to be called once per Card.

> 
> >  static int asoc_simple_probe(struct platform_device *pdev)
> >  {
> >  	struct asoc_simple_priv *priv;
> > @@ -688,6 +731,11 @@ static int asoc_simple_probe(struct platform_device *pdev)
> >  		return ret;
> >  
> >  	if (np && of_device_is_available(np)) {
> > +		ret = simple_populate_aux(priv);
> > +		if (ret < 0) {
> > +			dev_err_probe(dev, ret, "populate aux error\n");
> > +			goto err;
> > +		}
> >  
> >  		ret = simple_parse_of(priv, li);
> >  		if (ret < 0) {
> > -- 
> > 2.40.1
> >   
> 
> Calling simple_populate_aux() before calling simple_parse_of() is possible,
> but looks strange for me.
> see below
> 
> > diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
> > index 5a5e4ecd0f61..4992ab433d6a 100644
> > --- a/sound/soc/generic/simple-card.c
> > +++ b/sound/soc/generic/simple-card.c  
> (snip)
> > @@ -359,6 +360,8 @@ static int __simple_for_each_link(struct asoc_simple_priv *priv,
> >  		is_top = 1;
> >  	}
> >  
> > +	add_devs = of_get_child_by_name(top, PREFIX "additional-devs");  
> 
> I think better position to call simple_populate_aux() is here.
> But __simple_for_each_link() will be called multiple times for CPU and for Codec.
> So maybe you want to calling it under CPU turn.
> 
> 	 /* NOTE: it doesn't support dai-link so far */
> 	add_devs = of_get_child_by_name(top, PREFIX "additional-devs");
> 	if (add_devs && li->cpu) {
> 		ret = simple_populate_aux(priv);
> 		...
> 	}

So, IMHO, calling simple_populate_aux() from __simple_for_each_link() is
not correct as it has nothing to do with DAI links and must be call once
per Card.

simple_populate_aux() could be called by simple_parse_of() itself or after
simple_parse_of() call.

I would prefer calling it before snd_soc_of_parse_aux_devs() because
this function parses aux-devs phandles and these phandles can refer an
auxiliary device present in the additional-devs node.

The current code has no issue with this but some evolution can lead to
EPROBE_DEFER if the device related to the phandle was not probed.
If simple_populate_aux() is called after snd_soc_of_parse_aux_devs(),
an EPROBE_DEFER related to the missing probe() call has no chance to
be resolved.

Tell be what you prefer:
  a) Call before simple_parse_of() (no changes)
or
  b) Call at the very beginning of simple_parse_of()
or
  c) Other suggestion ...


Thanks a lot for your review.
Best regards,
Hervé

> 
> Thank you for your help !!
> 
> Best regards
> ---
> Kuninori Morimoto
