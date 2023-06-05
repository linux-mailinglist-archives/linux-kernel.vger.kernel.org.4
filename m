Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD34722D45
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 19:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235235AbjFERGE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 5 Jun 2023 13:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbjFERF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 13:05:59 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C571109;
        Mon,  5 Jun 2023 10:05:52 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QZg1N2bmLz67ftX;
        Tue,  6 Jun 2023 01:03:52 +0800 (CST)
Received: from localhost (10.126.171.223) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 5 Jun
 2023 18:05:48 +0100
Date:   Mon, 5 Jun 2023 18:05:47 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Herve Codina <herve.codina@bootlin.com>,
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
Message-ID: <20230605180547.0000528b@Huawei.com>
In-Reply-To: <CAHp75Vec3fXT6phqvLGSn0c09USCXXF6ZoE+X1VNJGM6jyf=aQ@mail.gmail.com>
References: <20230523151223.109551-1-herve.codina@bootlin.com>
        <20230523151223.109551-6-herve.codina@bootlin.com>
        <ZHtIdTZbULl6t4RT@surfacebook>
        <20230605094637.7615b689@bootlin.com>
        <CAHp75Vec3fXT6phqvLGSn0c09USCXXF6ZoE+X1VNJGM6jyf=aQ@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.126.171.223]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

It's really more of a TODO when someone needs it than a FIXME.
I'm not particularly keen to see a bunch of code supporting cases
that no one uses, but it's useful to call out where the code would
go if other cases were to be supported.

Perhaps soften it to a note that doesn't have the work FIXME in it.

Jonathan


> 
> > > > +                   return -EINVAL;  
> 

