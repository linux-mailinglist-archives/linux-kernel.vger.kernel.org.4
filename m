Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF13172F990
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 11:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244148AbjFNJoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 05:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235980AbjFNJoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:44:16 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11E349C8;
        Wed, 14 Jun 2023 02:42:19 -0700 (PDT)
X-GND-Sasl: herve.codina@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686735738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+REmpcLHUL4BTOxA1dlLHsmBL+e+FBYJaTaqB02G6NY=;
        b=d+AXI1g8Y06cHn5FQ9HHfYpUkbPNIKBON81J0yuXI5c9++a6TK2xsCzbdQ8XJXKjFG0Ks2
        IlS6uGDcORffGChF4976ahuklePO8PU76h62Q9MZtlVuydhY/lUSXXJIrMvanEK0VvcCIS
        K7bdwjIGwjy/ZcYCKTMQSyJLmycpDiEgwWvrzcoPoEtqVH0QyxVrTlSD0rpZ2JL8KtuiqD
        wqEZQiJlji6q9zYJBnNnorhUyaGiJcnkwZA375KbgVR26OSg2D0hrHNBQUHCzhd55ZePmM
        OTYg0eqK2ss1oCOt/DkCC2gsZZALpLj+rNIViYo2eFFQrNDSZtshDR9MMEM/EA==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6813C60004;
        Wed, 14 Jun 2023 09:42:15 +0000 (UTC)
Date:   Wed, 14 Jun 2023 11:42:14 +0200
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
Subject: Re: [PATCH v4 07/13] minmax: Introduce {min,max}_array()
Message-ID: <20230614114214.1371485e@bootlin.com>
In-Reply-To: <CAHp75Vcur=H_2mBm5Ztuvd7Jnvmr6+tvCbEkFtmaVLsEjXr8NQ@mail.gmail.com>
References: <20230614074904.29085-1-herve.codina@bootlin.com>
        <20230614074904.29085-8-herve.codina@bootlin.com>
        <CAHp75Vcur=H_2mBm5Ztuvd7Jnvmr6+tvCbEkFtmaVLsEjXr8NQ@mail.gmail.com>
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

On Wed, 14 Jun 2023 12:02:57 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Wed, Jun 14, 2023 at 10:49 AM Herve Codina <herve.codina@bootlin.com> wrote:
> >
> > Introduce min_array() (resp max_array()) in order to get the
> > minimal (resp maximum) of values present in an array.  
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> See a remark below.
> 
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> >  include/linux/minmax.h | 36 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> >
> > diff --git a/include/linux/minmax.h b/include/linux/minmax.h
> > index 396df1121bff..2cd0d34ce921 100644
> > --- a/include/linux/minmax.h
> > +++ b/include/linux/minmax.h
> > @@ -133,6 +133,42 @@
> >   */
> >  #define max_t(type, x, y)      __careful_cmp((type)(x), (type)(y), >)
> >
> > +/*
> > + * Do not check the array parameter using __must_be_array().
> > + * In the following legit use-case where the "array" passed is a simple pointer,
> > + * __must_be_array() will return a failure.
> > + * --- 8< ---
> > + * int *buff
> > + * ...
> > + * min = min_array(buff, nb_items);
> > + * --- 8< ---
> > + */
> > +#define __minmax_array(op, array, len) ({                      \
> > +       typeof(array) __array = (array);                        \
> > +       typeof(len) __len = (len);                              \
> > +       typeof(__array[0] + 0) __element = __array[--__len];    \  
> 
> Do we need the ' + 0' part?

Yes.

__array can be an array of const items and it is legitimate to get the
minimum value from const items.

typeof(__array[0]) keeps the const qualifier but we need to assign __element
in the loop.
One way to drop the const qualifier is to get the type from a rvalue computed
from __array[0]. This rvalue has to have the exact same type with only the const
dropped.
'__array[0] + 0' was a perfect canditate.

Regards,
Hervé

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
> > --
> > 2.40.1
> >  
> 
> 
