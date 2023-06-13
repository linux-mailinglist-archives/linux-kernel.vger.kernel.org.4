Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0481472DBE5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240898AbjFMIBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240843AbjFMIAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:00:51 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DEA1BD0;
        Tue, 13 Jun 2023 01:00:09 -0700 (PDT)
X-GND-Sasl: herve.codina@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686643208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rd/XsfPHYPjYWaY07hPncGtbRCyEuLUp22IAn5v29r4=;
        b=oGdpKjgpNu08N2uUAgpCGHd8N5hAGIMRJCwlpnSNDv0ljGSyOFGfEqivtG8W6LNnRYFmgB
        O2lz/a+CDqHon+Vx+iu2vZyhBOqJRp22Vo7sjM3NVqfFDCjriQW2M0D8tV1wP5ibo6fqmT
        8MxpRpBFvoJg+Nld2DCPm/mHEdYQjwymrgoKqgMUuVLLL5/7ZDyCbjJvy/mPrJWl4Voecg
        8lLV+50gZAslzG68s4CpPEnj8My0R1zOmb9IpazpXumoJbUK1pB12MDb/WZ/5tolCKiWcm
        FDZQ+TKiVBfDhhX6z6H6+vHZKuAx2+814/BZ63VuvsJHcUwAscSMeEfdhKfZFg==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id A7C961C0006;
        Tue, 13 Jun 2023 08:00:01 +0000 (UTC)
Date:   Tue, 13 Jun 2023 10:00:00 +0200
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
Subject: Re: [PATCH v3 06/12] minmax: Introduce {min,max}_array()
Message-ID: <20230613100000.6bd9e690@bootlin.com>
In-Reply-To: <CAHp75Vf2dmAS9VD-pgyZwVopVCFy8yFjhPWEj8sym=pfE7uxSA@mail.gmail.com>
References: <20230612122926.107333-1-herve.codina@bootlin.com>
        <20230612122926.107333-7-herve.codina@bootlin.com>
        <CAHp75Vf2dmAS9VD-pgyZwVopVCFy8yFjhPWEj8sym=pfE7uxSA@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Mon, 12 Jun 2023 17:10:40 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Mon, Jun 12, 2023 at 3:30 PM Herve Codina <herve.codina@bootlin.com> wrote:
> >
> > Introduce min_array() (resp max_array()) in order to get the
> > minimal (resp maximum) of values present in an array.  
> 
> Some comments below, after addressing them,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> >  include/linux/minmax.h | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >
> > diff --git a/include/linux/minmax.h b/include/linux/minmax.h
> > index 396df1121bff..37a211f22404 100644
> > --- a/include/linux/minmax.h
> > +++ b/include/linux/minmax.h
> > @@ -133,6 +133,32 @@
> >   */
> >  #define max_t(type, x, y)      __careful_cmp((type)(x), (type)(y), >)
> >
> > +#define __minmax_array(op, array, len) ({                      \  
> 
> Maybe it's my MUA, maybe the code contains spaces, can you switch to
> TABs if it's the case?
> 
> > +       typeof(array) __array = (array);                        \  
> 
> We have __must_be_array()

Using __must_be_array() will lead to some failure.
Indeed, we can have:
  --- 8< ---
  int *buff
  ...
  min = min_array(buff, nb_item);
  --- 8< ---

In this case, __must_be_array() will report that buff is not an array.

To avoid any confusion, what do you think if I renamed {min,max}_array()
to {min,max}_buffer() and replace __array by __buff and use *(__buff + xxx)
instead of array[xxx] in the macro.

This will lead to:
--- 8< ---
#define __minmax_buffer(op, buff, len) ({			\
	typeof(buff) __buff = (buff);			\
	typeof(len) __len = (len);				\
	typeof(*buff + 0) __element = *(__buff + --__len);	\
	while (__len--)						\
		__element = op(__element, *(__buff + __len]));	\
	__element; })

#define min_buffer(buffer, len) __minmax_array(min, buffer, len)
#define max_buffer(buffer, len) __minmax_array(max, buffer, len)
--- 8< ---

Regards,
Hervé

> 
> You will need to fix the inclusions in minmax.h at the same time, it needs
> linux/build_bug.h (which includes compiler.h needed for __UNIQUE_ID()
> and for the above mentioned one).
> 
> > +       typeof(len) __len = (len);                              \
> > +       typeof(*__array + 0) __element = __array[--__len];      \  
> 
> After above, this can be written as __array[0].
> 
> > +       while (__len--)                                         \
> > +               __element = op(__element, __array[__len]);      \
> > +       __element; })
> > +
> > +/**
> > + * min_array - return minimum of values present in an array
> > + * @array: array
> > + * @len: array length
> > + *
> > + * Note that @len must not be zero (empty array).
> > + */
> > +#define min_array(array, len) __minmax_array(min, array, len)
> > +
> > +/**
> > + * max_array - return maximum of values present in an array
> > + * @array: array
> > + * @len: array length
> > + *
> > + * Note that @len must not be zero (empty array).
> > + */
> > +#define max_array(array, len) __minmax_array(max, array, len)
> > +
> >  /**
> >   * clamp_t - return a value clamped to a given range using a given type
> >   * @type: the type of variable to use  
> 

