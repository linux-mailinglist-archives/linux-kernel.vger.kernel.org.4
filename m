Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C02731429
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343497AbjFOJhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343538AbjFOJgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:36:48 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF252D56;
        Thu, 15 Jun 2023 02:35:52 -0700 (PDT)
X-GND-Sasl: herve.codina@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686821716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tdk5EMEjl4leBhCxd1dmifb+WUt3kNNJIw7zVJ9fvlo=;
        b=U5+zUg/GID9mrvw0SW2BWCeDcaoAOEp/x/CgseFY3XWUmPL01J0zoSq/8Va6ysMEa+X2Du
        hsEvgRUCZUQwpF1yVxAhgaTTUMR+d9IcLt1jL21WeuTm9jf4tWTyH7eYHu/FLMvFKbPPKS
        fniYUoDybjmi7sgME9oGudRDePLP9gewe837b+SdOxHNRdeorTL0Znk08Te/cM+54u0K/d
        KFsV1CNJkzDYqMAN1ADrLGFOKKKRCjCrHXaipr0XgxonwmxTEqP6Gv7S1cMFePSxtOSpmb
        XxpB4l2oL31c1jr60EZKbJpLknHS2918mQYjyMjVrVbJiQcvBF6OViTlV43w4A==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0EC9EE0007;
        Thu, 15 Jun 2023 09:35:13 +0000 (UTC)
Date:   Thu, 15 Jun 2023 11:35:12 +0200
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
Message-ID: <20230615113512.07967677@bootlin.com>
In-Reply-To: <CAHp75VfFyDzr4qHNssXZ8RLy0gxMWdjBgac4JLd7grRLEG-vyw@mail.gmail.com>
References: <20230614074904.29085-1-herve.codina@bootlin.com>
        <20230614074904.29085-8-herve.codina@bootlin.com>
        <CAHp75Vcur=H_2mBm5Ztuvd7Jnvmr6+tvCbEkFtmaVLsEjXr8NQ@mail.gmail.com>
        <20230614114214.1371485e@bootlin.com>
        <CAHp75VcmW2StPqb_LtKFyNyJ2+jz3c19zNRDiSuGs06Bseq04w@mail.gmail.com>
        <20230614223418.0d7e355d@bootlin.com>
        <CAHp75VfFyDzr4qHNssXZ8RLy0gxMWdjBgac4JLd7grRLEG-vyw@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,
On Thu, 15 Jun 2023 01:05:40 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Wed, Jun 14, 2023 at 11:34 PM Herve Codina <herve.codina@bootlin.com> wrote:
> > On Wed, 14 Jun 2023 14:51:43 +0300
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:  
> > > On Wed, Jun 14, 2023 at 12:42 PM Herve Codina <herve.codina@bootlin.com> wrote:  
> > > > On Wed, 14 Jun 2023 12:02:57 +0300
> > > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:  
> > > > > On Wed, Jun 14, 2023 at 10:49 AM Herve Codina <herve.codina@bootlin.com> wrote:  
> 
> ...
> 
> > > > > > +       typeof(__array[0] + 0) __element = __array[--__len];    \  
> > > > >
> > > > > Do we need the ' + 0' part?  
> > > >
> > > > Yes.
> > > >
> > > > __array can be an array of const items and it is legitimate to get the
> > > > minimum value from const items.
> > > >
> > > > typeof(__array[0]) keeps the const qualifier but we need to assign __element
> > > > in the loop.
> > > > One way to drop the const qualifier is to get the type from a rvalue computed
> > > > from __array[0]. This rvalue has to have the exact same type with only the const
> > > > dropped.
> > > > '__array[0] + 0' was a perfect canditate.  
> > >
> > > Seems like this also deserves a comment. But if the series is accepted
> > > as is, it may be done as a follow up.
> > >  
> >
> > Finally not so simple ...
> > I did some deeper tests and the macros need to be fixed.
> >
> > I hope this one (with comments added) is correct:
> > --- 8 ---
> > /*
> >  * Do not check the array parameter using __must_be_array().
> >  * In the following legit use-case where the "array" passed is a simple pointer,
> >  * __must_be_array() will return a failure.
> >  * --- 8< ---
> >  * int *buff
> >  * ...
> >  * min = min_array(buff, nb_items);
> >  * --- 8< ---
> >  *
> >  * The first typeof(&(array)[0]) is needed in order to support arrays of both
> >  * 'int *buff' and 'int buf[N]' types.
> >  *
> >  * typeof(__array[0] + 0) used for __element is needed as the array can be an
> >  * array of const items.
> >  * In order to discard the const qualifier use an arithmetic operation (rvalue).  
> 
> 
> >  * This arithmetic operation discard the const but also can lead to an integer  
> 
> discards
> 
> >  * promotion. For instance, a const s8 __array[0] lead to an int __element due  
> 
> leads
> 
> >  * to the promotion.
> >  * In this case, simple min() or max() operation fails (type mismatch).
> >  * Use min_t() or max_t() (op_t parameter) enforcing the type in order to avoid
> >  * the min() or max() failure.  
> 
> This part perhaps can be avoided. See below.
> 
> >  */
> > #define __minmax_array(op_t, array, len) ({                     \
> >         typeof(&(array)[0]) __array = (array);                  \
> >         typeof(len) __len = (len);                              \
> >         typeof(__array[0] + 0) __element = __array[--__len];    \
> >         while (__len--)                                         \
> >                 __element = op_t(typeof(__array[0]), __element, __array[__len]); \  
> 
> But can't we instead have typeof(+(array[0])) in the definition of __element?
> There are also other possible solutions: a) _Generic() with listed
> const types to move them to non-const, and b) __auto_type (which is
> supported by GCC 4.9 and clang, but not in the C11 standard).

typeof(+(array[0])) keeps the promotion.

__auto_type works with my gcc-12 but not with a gcc-5.5. Depending on the
compiler version, it discards or keeps the const qualifier. For this reason
I would prefer to not use it.

Did the job using _Generic().

This lead to:
--- 8< ---
/*
 * Remove a const qualifier
 * _Generic(foo, type-name: association, ..., default: association) performs a
 * comparison against the foo type (not the qualified type).
 * Do not use the const keyword in the type-name as it will not match the
 * unqualified type of foo.
 */
#define __unconst_type_cases(type)		\
	unsigned type:  (unsigned type)0,	\
	signed type:    (signed type)0


#define __unconst_typeof(x) typeof(			\
	_Generic((x),					\
		char: (char)0,				\
		__unconst_type_cases(char),		\
		__unconst_type_cases(short),		\
		__unconst_type_cases(int),		\
		__unconst_type_cases(long),		\
		__unconst_type_cases(long long),	\
		default: (x)))

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
 * The array can be an array of const items.
 * typeof() keeps the const qualifier. Use __unconst_typeof() in order to
 * discard the const qualifier for the __element variable.
 */
#define __minmax_array(op, array, len) ({				\
	typeof(&(array)[0]) __array = (array);				\
	typeof(len) __len = (len);					\
	__unconst_typeof(__array[0]) __element = __array[--__len];	\
	while (__len--)							\
		__element = op(__element, __array[__len]);		\
	__element; })

/**
 * min_array - return minimum of values present in an array
 * @array: array
 * @len: array length
 *
 * Note that @len must not be zero (empty array).
 */
#define min_array(array, len) __minmax_array(min, array, len)

/**
 * max_array - return maximum of values present in an array
 * @array: array
 * @len: array length
 *
 * Note that @len must not be zero (empty array).
 */
#define max_array(array, len) __minmax_array(max, array, len)
--- 8< ---

Do you think it looks good ?

For, the KUnit tests, I agree, it would be nice to have something.
I need some more substantial work to implement and run the test in KUnit
and the first task will be learning the KUnit test system. 
I will do that but out of this series.

Thanks for your feedback and pointers,
Hervé
