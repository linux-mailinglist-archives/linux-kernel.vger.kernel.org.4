Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E0C722DBD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 19:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235427AbjFERgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 13:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjFERgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 13:36:49 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC678F;
        Mon,  5 Jun 2023 10:36:41 -0700 (PDT)
X-GND-Sasl: herve.codina@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685986599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yjxc+85Bq54GZEvP6akAc9UZPm7vVtcD2MajvGxNqiY=;
        b=fi5uoXdANbPmsJUCGLlp8YkQvRea5sm2llsgEt0TFFbN/DiK/ijhu1QIs5Lb2SHJSBwlTa
        xdRattLNG7l9JpgH7Z2IWlWWnCWosU1xEqePGqf0QzTm5HkuErSI72aB0EIN6+4amnT0Ga
        8P+eqvTkLDpUBP2q2wVkWdPbKHMPlb/UrWbta2UWHEFpzfSkXWd8qOJMTia0XbM4I72MNo
        htz4tOzOJNwc7ZqbKvRPvV4SamC6GjcYV5Yf3fFGzU1Qozhdsb7h7PJ7F8Vnc6JSTYkcZc
        ETtauzV/LnDHBQc6O1Sj8LPo50Bx0osDRQ1RHgVz9XCDZ+P/SY/4l7DojYpbKA==
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
X-GND-Sasl: herve.codina@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A2C4E20004;
        Mon,  5 Jun 2023 17:36:37 +0000 (UTC)
Date:   Mon, 5 Jun 2023 19:36:36 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Kuninori Morimoto" <kuninori.morimoto.gx@renesas.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 5/9] iio: inkern: Add a helper to query an available
 minimum raw value
Message-ID: <20230605193636.5239a271@bootlin.com>
In-Reply-To: <20230605180547.0000528b@Huawei.com>
References: <20230523151223.109551-1-herve.codina@bootlin.com>
        <20230523151223.109551-6-herve.codina@bootlin.com>
        <ZHtIdTZbULl6t4RT@surfacebook>
        <20230605094637.7615b689@bootlin.com>
        <CAHp75Vec3fXT6phqvLGSn0c09USCXXF6ZoE+X1VNJGM6jyf=aQ@mail.gmail.com>
        <20230605180547.0000528b@Huawei.com>
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

Hi Jonathan, Andy,

On Mon, 5 Jun 2023 18:05:47 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Mon, 5 Jun 2023 12:45:24 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> 
...
> > > > > +           default:
> > > > > +                   /* FIXME: learn about min for other iio values */    
> > > >
> > > > I believe in a final version this comment won't be here.    
> > >
> > > We have the same FIXME comment in the iio_channel_read_max() function I
> > > copied to create this iio_channel_read_min() and, to be honest, I
> > > don't really know how to handle these other cases.
> > >
> > > In this series, I would prefer to keep this FIXME.    
> > 
> > I see, Jonathan needs to be involved here then.  
> 
> It's really more of a TODO when someone needs it than a FIXME.
> I'm not particularly keen to see a bunch of code supporting cases
> that no one uses, but it's useful to call out where the code would
> go if other cases were to be supported.
> 
> Perhaps soften it to a note that doesn't have the work FIXME in it.
> 
> Jonathan
> 

Right, I will change to /* TODO: learn about max for other iio values */
in the next iteration (both iio_channel_read_max() and iio_channel_read_min())

Regards,
Hervé

> 
> >   
> > > > > +                   return -EINVAL;    
> >   
> 
