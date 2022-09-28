Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B585EDD11
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 14:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233887AbiI1Mmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 08:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbiI1Mmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 08:42:49 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1507A520
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 05:42:47 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id e18so17123128edj.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 05:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=+hjCG5UL8I6/ympH09ZsxGiHso7S25Rf/BVVg15oSkU=;
        b=bYPruSwGmECkZuxS1nGmryAJEGsb1OPELVmL5cNoFOcLHOY5jGAr3JCMMpKy4xWbI5
         EmKzsaZlS7/OxuRcJnP624lwy7Mgua220PRA8yoY4c5Xsa84NlibXFBZa8aTKB67YnA9
         CJhLPZtl8eN49+t8zm3CtVg10KCGAgnRURVxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+hjCG5UL8I6/ympH09ZsxGiHso7S25Rf/BVVg15oSkU=;
        b=h3+s638Tmpk9xq9XLENMr/tqApWA52MnS1DKeGU7pLjZDl8jxGiwEK5cN5jV9Ek5GT
         pvXFJUZOwAFaMQ54qb41FyPctHMMIRWmvGTKOLimm4N0vAEzon/IAJeoxupgXZYXdSB5
         Htz2DpaBltHfuw38Ap0oiXM+fxqiegzcNGKtNSGojc2HWHpfkQYDFdMk6cVtLhJXZKx2
         MK8C4fFN3KSxAhjKyx1/daXG/P1Qj7/y97eiKM9GQS//FwoYlO55VfydveQ49H4n3ThW
         yViYfx/Yv+IcbBJn9BwEEhX6v/yPSrkvE+peAfxhMzpBtI4RdkLHqPd/qb/4iR/3GVHY
         oWIw==
X-Gm-Message-State: ACrzQf3EBM8Y7leYWXMOXdG/ruaJuiKOhye5VW4j3ISmYtimEawIvHI8
        8iqteoRGwFjeZ/C7HWx1kRc1/QPdIbatcGKTWNEEpQ==
X-Google-Smtp-Source: AMsMyM4L09hga+4vZZ+SsULLjP5VCQkFWMN77LetF1he+ktd1029o2uzUEeK6LjBCtBjRvzUcnljgtyBLAiiOCJXfF4=
X-Received: by 2002:a05:6402:42c5:b0:44e:b640:16fb with SMTP id
 i5-20020a05640242c500b0044eb64016fbmr33974635edc.29.1664368965904; Wed, 28
 Sep 2022 05:42:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220907131241.31941-1-romain.perier@gmail.com>
 <20220907131241.31941-3-romain.perier@gmail.com> <20220927163314.rzfld7sqchsdfvfg@pengutronix.de>
In-Reply-To: <20220927163314.rzfld7sqchsdfvfg@pengutronix.de>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Wed, 28 Sep 2022 21:47:12 +0900
Message-ID: <CAFr9PXmWGTQoNxxY99MT_ptHMDTmai1eOrZteuP7A0TyPwVidw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] pwm: Add support for the MSTAR MSC313 PWM
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Romain Perier <romain.perier@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uwe,

On Wed, 28 Sept 2022 at 01:33, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello Romain, hello Daniel,

Romain is doing the fixes to this so I'll let him answer the other
bits but on all of the "what does the hardware do?" questions I'll
have to test that on the hardware and follow up. The only
documentation we have is very rough listings of registers and bits and
not much else.

>
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_DESCRIPTION("Mstar MSC313e PWM driver");
> > +MODULE_AUTHOR("Daniel Palmer <daniel@thingy.jp>");
>
> That address doesn't match the author of this patch. Is this on purpose?

My intention is to put all of the stuff for this MStar (Now Sigmastar)
platform under this domain including the kernel, u-boot and PCB files
so that at some point I can handover the whole thing to someone else
or maybe a community that want to take over by giving them the domain.
I should really set my email address in git for these commits to match
but keep forgetting.

Cheers,

Daniel
