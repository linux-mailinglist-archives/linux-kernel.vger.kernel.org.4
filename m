Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D187072E9ED
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 19:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236202AbjFMRfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 13:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbjFMRfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 13:35:09 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9B41FE5;
        Tue, 13 Jun 2023 10:34:44 -0700 (PDT)
X-GND-Sasl: herve.codina@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686677683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=86rh1f0HBKfOE+lzuTwLJdkE+7pPjEWV2pIeiL0qQXk=;
        b=pF/oK2cwuHCGuxVOM6DoseXfu83gnXuDTUpUvA9KEn0otsbNNzAA4pJPLVlJc5JrD3dGbr
        V0NpyMNa0sSRNqbb3yOvL0S10jM9O8IGKL+jAbnAuDQZB9SQpm9XrkvoIKG3brJIIhGRRM
        EcNFZEmvFvUb5QYmp9+Wd5Pnrf2Y8tv7aXv/Y/3hALFfIF356bK6jdj3nthmcCefNokuhy
        Hb+vEuC8h9JBolygcQDRKCAAo5m2LFYvNdRcu0hbzUjh9vP3fRhNAs2jKaGxdoL6X7iBMm
        pvVGec+DO94oFRPp6mXKfp+Og4FmeHRt4ldea3l3CoU9Q1/zxbN5bzyXeUX3Jg==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3B8E8E0003;
        Tue, 13 Jun 2023 17:34:41 +0000 (UTC)
Date:   Tue, 13 Jun 2023 19:34:40 +0200
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
Message-ID: <20230613193440.1940c3a7@bootlin.com>
In-Reply-To: <CAHp75Vcr5Owjn0HK-+D0mpPJAkAxG7F8bEO=sqvhT8w=_xnF7w@mail.gmail.com>
References: <20230612122926.107333-1-herve.codina@bootlin.com>
        <20230612122926.107333-7-herve.codina@bootlin.com>
        <CAHp75Vf2dmAS9VD-pgyZwVopVCFy8yFjhPWEj8sym=pfE7uxSA@mail.gmail.com>
        <20230613100000.6bd9e690@bootlin.com>
        <CAHp75Vcr5Owjn0HK-+D0mpPJAkAxG7F8bEO=sqvhT8w=_xnF7w@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2023 20:08:08 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Jun 13, 2023 at 11:00 AM Herve Codina <herve.codina@bootlin.com> wrote:
> > On Mon, 12 Jun 2023 17:10:40 +0300
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:  
> > > On Mon, Jun 12, 2023 at 3:30 PM Herve Codina <herve.codina@bootlin.com> wrote:  
> > > >
> > > > Introduce min_array() (resp max_array()) in order to get the
> > > > minimal (resp maximum) of values present in an array.  
> > >
> > > Some comments below, after addressing them,
> > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>  
> 
> ...
> 
> > > > +       typeof(array) __array = (array);                        \  
> > >
> > > We have __must_be_array()  
> >
> > Using __must_be_array() will lead to some failure.
> > Indeed, we can have:
> >   --- 8< ---
> >   int *buff
> >   ...
> >   min = min_array(buff, nb_item);
> >   --- 8< ---
> >
> > In this case, __must_be_array() will report that buff is not an array.  
> 
> Oh, I missed that.
> 
> > To avoid any confusion, what do you think if I renamed {min,max}_array()
> > to {min,max}_buffer() and replace __array by __buff and use *(__buff + xxx)
> > instead of array[xxx] in the macro.  
> 
> But functionally it's still against an array.
> 
> I would stick with "array" in the name, but add a comment why
> __must_be_array() is not used. If we need a stricter variant, we may
> add a new wrapper with that check. That said, I think we can use
> __array[0] and similar indexed accesses.
> 

Right, I will provide an updated version on the next iteration.

Thanks for your feedback.
Hervé
