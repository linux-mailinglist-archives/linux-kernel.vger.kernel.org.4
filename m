Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3950722879
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234466AbjFEONJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234335AbjFEOMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:12:52 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106DAE79;
        Mon,  5 Jun 2023 07:11:57 -0700 (PDT)
X-GND-Sasl: herve.codina@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685974292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uHfp+IyYPxqhLvbm8OYS3Lo9uaz8M1hK/LpKpngruro=;
        b=I2dvsEv0zE3yipuHlMDg7UA6Ckx9wEa+H7t4VCmIJcET1px6TWlt7rNFPhb/SO9IEr87xN
        wBDLyJFUk2WuVLIjnpLpNczEg7ezgRrWzNXcHfM72l4s1aK3/1FBXifJpSNNg7ovgpqdnU
        sEbgtIJ38z5zNlZtLiHlgEiq1hUq9FBgXbrBSv7ldAgs719ePTGOKJszV3E6vSlhEkmwO6
        3Y8BW+LvafTVtnj1GhZ43dI/oLHQTUVjlzbkrqkGemXrN7lKXZWEQbi28a5jY0iiatAb96
        D7cll8e4nHqA9hc6bkHvRmCcrDjnK9xkByDt3YyE/qSkEUNvWMff9ZOfwZSYKw==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id 32278C0003;
        Mon,  5 Jun 2023 14:11:30 +0000 (UTC)
Date:   Mon, 5 Jun 2023 16:11:29 +0200
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
Subject: Re: [PATCH v2 5/9] iio: inkern: Add a helper to query an available
 minimum raw value
Message-ID: <20230605161129.4ac3231b@bootlin.com>
In-Reply-To: <CAHp75Vec3fXT6phqvLGSn0c09USCXXF6ZoE+X1VNJGM6jyf=aQ@mail.gmail.com>
References: <20230523151223.109551-1-herve.codina@bootlin.com>
        <20230523151223.109551-6-herve.codina@bootlin.com>
        <ZHtIdTZbULl6t4RT@surfacebook>
        <20230605094637.7615b689@bootlin.com>
        <CAHp75Vec3fXT6phqvLGSn0c09USCXXF6ZoE+X1VNJGM6jyf=aQ@mail.gmail.com>
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

Hi Andy,

On Mon, 5 Jun 2023 12:45:24 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Mon, Jun 5, 2023 at 10:46 AM Herve Codina <herve.codina@bootlin.com> wrote:
> > On Sat, 3 Jun 2023 17:04:37 +0300
> > andy.shevchenko@gmail.com wrote:  
> > > Tue, May 23, 2023 at 05:12:19PM +0200, Herve Codina kirjoitti:  
> 
> ...
> 
> > > > +           case IIO_VAL_INT:
> > > > +                   *val = vals[--length];  
> > >  
> > > > +                   while (length) {  
> > >
> > >                       while (length--) {
> > >
> > > will do the job and at the same time...
> > >  
> > > > +                           if (vals[--length] < *val)
> > > > +                                   *val = vals[length];  
> > >
> > > ...this construction becomes less confusing (easier to parse).  
> >
> > Indeed, I will change in the next iteration.  
> 
> And looking into above line, this whole construction I would prefer to
> have a macro in minmax.h like
> 
> #define min_array(array, len) \
> {( \
>   typeof(len) __len = (len); \
>   typeof(*(array)) __element = (array)[--__len]; \
>   while (__len--) \
>     __element = min(__element, (array)[__len]); \
>   __element; \
> )}
> 
> (it might need more work, but you got the idea)

I will also introduce max_array() and update both iio_channel_read_max()
and iio_channel_read_min() to use these macros.

Will be available in the next series iteration.

Thanks,
Hervé

> 
> > > > +                   }
> > > > +                   break;  
> 
> ...
> 
> > > > +           default:
> > > > +                   /* FIXME: learn about min for other iio values */  
> > >
> > > I believe in a final version this comment won't be here.  
> >
> > We have the same FIXME comment in the iio_channel_read_max() function I
> > copied to create this iio_channel_read_min() and, to be honest, I
> > don't really know how to handle these other cases.
> >
> > In this series, I would prefer to keep this FIXME.  
> 
> I see, Jonathan needs to be involved here then.
> 
> > > > +                   return -EINVAL;  
> 
