Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A39873305F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 13:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244058AbjFPLtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 07:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343703AbjFPLsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 07:48:50 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B79191;
        Fri, 16 Jun 2023 04:48:49 -0700 (PDT)
X-GND-Sasl: herve.codina@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686916128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oLKhvPrptWFoCmJpHArFvlKc/yEEcCk45NeiCg0/3Yg=;
        b=LL2WMmiQsuIm4g/hjHsD81IzOy08yCDudlals5vYRPZBYhTAwXCnSUWZD8hxJ1ixAlMj+V
        JYx7e7oVG7MoU4swUjUs2j3hAl6PBV8k7c7E5Z7FNSQjf1MGesJQQ9L4BsP3a4lkHTruFS
        BK1MVffkb7DWP+kNcYd4mIHG8qYIeHpOKVlSFUfAFgzubUkRbgV9EtXs2U2uTjAypYYwH9
        X0BbwTXxmZ4PXGtrmlSI8s15MuoaOxM/rZ9NXiLu2AhOzPTH1rrRD1xPYHWoxQr4VO4lCA
        Z+JVCActDH1jkX1Xa+2xdSqlAOUVJwvSZ1BHYnfBUFMZlRIxDPGj4GXVSs0pQg==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id A2CD0C0002;
        Fri, 16 Jun 2023 11:48:45 +0000 (UTC)
Date:   Fri, 16 Jun 2023 13:48:44 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Kuninori Morimoto" <kuninori.morimoto.gx@renesas.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 07/13] minmax: Introduce {min,max}_array()
Message-ID: <20230616134844.09e7fda3@bootlin.com>
In-Reply-To: <6c7fe34f7b65421ab618d33ba907ae09@AcuMS.aculab.com>
References: <20230614074904.29085-1-herve.codina@bootlin.com>
        <20230614074904.29085-8-herve.codina@bootlin.com>
        <CAHp75Vcur=H_2mBm5Ztuvd7Jnvmr6+tvCbEkFtmaVLsEjXr8NQ@mail.gmail.com>
        <20230614114214.1371485e@bootlin.com>
        <CAHp75VcmW2StPqb_LtKFyNyJ2+jz3c19zNRDiSuGs06Bseq04w@mail.gmail.com>
        <20230614223418.0d7e355d@bootlin.com>
        <CAHp75VfFyDzr4qHNssXZ8RLy0gxMWdjBgac4JLd7grRLEG-vyw@mail.gmail.com>
        <20230615113512.07967677@bootlin.com>
        <6c7fe34f7b65421ab618d33ba907ae09@AcuMS.aculab.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Fri, 16 Jun 2023 09:08:22 +0000
David Laight <David.Laight@ACULAB.COM> wrote:

...

> 
> Just define two variables typeof(__array[0] + 0) one for an element
> and one for the limit.
> The just test (eg):
> 	if (limit > item) limit = item;
> finally cast the limit back to the original type.
> The promotions of char/short to signed int won't matter.
> There is no need for all the type-checking in min/max.
> 
> Indeed, if min_t(type, a, b) is in anyway sane it should
> expand to:
> 	type _a = a, _b = b;
> 	_a < _b ? _a : _b
> without any of the checks that min() does.

I finally move to use _Generic() in order to "unconstify" and avoid the
integer promotion. With this done, no extra cast is needed and min()/max()
are usable.

The patch is available in the v5 series.
  https://lore.kernel.org/linux-kernel/20230615152631.224529-8-herve.codina@bootlin.com/

Do you think the code present in the v5 series should be changed ?
If so, can you give me your feedback on the v5 series ?

Thanks for your review,
Hervé
