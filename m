Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EACDC730938
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 22:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236729AbjFNUee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 16:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236739AbjFNUe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 16:34:29 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724C02684;
        Wed, 14 Jun 2023 13:34:23 -0700 (PDT)
X-GND-Sasl: herve.codina@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686774861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yZm6YcC6DcFVvhOCrWE7tXXzeBzGgryfSQmR/S4llfA=;
        b=nQ7IcnTL8O0E6kwDyNu6kT3yKmiODt5kIbcs4yQzM21QJqc0CQKBJIc3UrH/URxks21i4Q
        9JDF6iwAmNyudNKKRcD0kHBCsZ3QewttgXr+j9xOz+MIl9aAXdhVsdLtpuij47spr3wHhP
        oiFNRk5+jJKlfQrXTBEqUn2ZGP6BHOFo5zPXwmIznrIvw5LV4kJRgivyTBcLIKcP2G1I4C
        g6EaUm43GYdJ7VH+I5IkZJw/S6qTZq51RC8aJ0SDC8Iwzr16gbEqI2w17H8ooobPKogxQ8
        eXkxHWcDGFL7R9vQx9kUmhtAykgtUQX3buafDqQ0A5OKsiSwUBLg0djxY9Hn3g==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9A02040005;
        Wed, 14 Jun 2023 20:34:19 +0000 (UTC)
Date:   Wed, 14 Jun 2023 22:34:18 +0200
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
Message-ID: <20230614223418.0d7e355d@bootlin.com>
In-Reply-To: <CAHp75VcmW2StPqb_LtKFyNyJ2+jz3c19zNRDiSuGs06Bseq04w@mail.gmail.com>
References: <20230614074904.29085-1-herve.codina@bootlin.com>
        <20230614074904.29085-8-herve.codina@bootlin.com>
        <CAHp75Vcur=H_2mBm5Ztuvd7Jnvmr6+tvCbEkFtmaVLsEjXr8NQ@mail.gmail.com>
        <20230614114214.1371485e@bootlin.com>
        <CAHp75VcmW2StPqb_LtKFyNyJ2+jz3c19zNRDiSuGs06Bseq04w@mail.gmail.com>
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

Hi Andy,

On Wed, 14 Jun 2023 14:51:43 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Wed, Jun 14, 2023 at 12:42 PM Herve Codina <herve.codina@bootlin.com> wrote:
> > On Wed, 14 Jun 2023 12:02:57 +0300
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:  
> > > On Wed, Jun 14, 2023 at 10:49 AM Herve Codina <herve.codina@bootlin.com> wrote:  
> 
> ...
> 
> > > > +       typeof(__array[0] + 0) __element = __array[--__len];    \  
> > >
> > > Do we need the ' + 0' part?  
> >
> > Yes.
> >
> > __array can be an array of const items and it is legitimate to get the
> > minimum value from const items.
> >
> > typeof(__array[0]) keeps the const qualifier but we need to assign __element
> > in the loop.
> > One way to drop the const qualifier is to get the type from a rvalue computed
> > from __array[0]. This rvalue has to have the exact same type with only the const
> > dropped.
> > '__array[0] + 0' was a perfect canditate.  
> 
> Seems like this also deserves a comment. But if the series is accepted
> as is, it may be done as a follow up.
> 

Finally not so simple ...
I did some deeper tests and the macros need to be fixed.

I hope this one (with comments added) is correct:
--- 8 ---
/*
 * Do not check the array parameter using __must_be_array().
 * In the following legit use-case where the "array" passed is a simple pointer,
 * __must_be_array() will return a failure.
 * --- 8< ---
 * int *buff
 * ...
 * min = min_array(buff, nb_items);
 * --- 8< ---
 *
 * The first typeof(&(array)[0]) is needed in order to support arrays of both
 * 'int *buff' and 'int buf[N]' types.
 *
 * typeof(__array[0] + 0) used for __element is needed as the array can be an
 * array of const items.
 * In order to discard the const qualifier use an arithmetic operation (rvalue).
 * This arithmetic operation discard the const but also can lead to an integer
 * promotion. For instance, a const s8 __array[0] lead to an int __element due
 * to the promotion.
 * In this case, simple min() or max() operation fails (type mismatch).
 * Use min_t() or max_t() (op_t parameter) enforcing the type in order to avoid
 * the min() or max() failure.
 */
#define __minmax_array(op_t, array, len) ({			\
	typeof(&(array)[0]) __array = (array);			\
	typeof(len) __len = (len);				\
	typeof(__array[0] + 0) __element = __array[--__len];	\
	while (__len--)						\
		__element = op_t(typeof(__array[0]), __element, __array[__len]); \
	__element; })

/**
 * min_array - return minimum of values present in an array
 * @array: array
 * @len: array length
 *
 * Note that @len must not be zero (empty array).
 */
#define min_array(array, len) __minmax_array(min_t, array, len)

/**
 * max_array - return maximum of values present in an array
 * @array: array
 * @len: array length
 *
 * Note that @len must not be zero (empty array).
 */
#define max_array(array, len) __minmax_array(max_t, array, len)

--- 8< ---

Tested ok from user-space on my x86_64 using the following types for *buff
and buff[N]:
- signed/unsigned char
- signed/unsigned short
- signed/unsigned int
- signed/unsigned long
- signed/unsigned long long
- float, double, long double (even if not used in the kernel)

Can you give me your feedback on this last version ?

If you are ok, it will be present in the next iteration of the series.
Otherwise, as a last ressort, I will drop the {min,max}_array() and switch
back to the specific min/max computation in IIO inkern.c

Sorry for this back and forth and this last minute detected bug.

Best regards,
Hervé

-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
