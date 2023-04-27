Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C426F009C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 08:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242777AbjD0GB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 02:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242818AbjD0GBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 02:01:25 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3602A2D41;
        Wed, 26 Apr 2023 23:01:24 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-751319e0dbfso126107185a.0;
        Wed, 26 Apr 2023 23:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682575283; x=1685167283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4X5dFumnuHTw1olZC5sCQAZYfvwwEiFQPwRXUqoQ6Jc=;
        b=piONlzZPG/OEbmOBUlucGOmODP2uxxVnXCyKxE1qKvmZY1KZ4yvotlI+7FypmkCoLZ
         YrOjl80i0yuGDocKNxNpwijfljTgF5kGOC54g2AlkzvICzpbBcqm90jqGhAR7N2S853Z
         pFUw/hVchW1LNng4cg4VaJSOfx2hVwT0PgnW8XOY+EyBJkzL1gq/ZafNeHGCgw1+0m0i
         GdWC3zESCG9BUXx8jCruUGanpNrWkLvFXdrsRbDM1FUaCh85GjgAyMy/Y98iN12tBZYi
         6AHs6EdrEtGxxGh4xzXGCpaXihQKaRnpVQMjlPdNBRA0kJRerLyYv4Q+ZHAns2vCqTVa
         vSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682575283; x=1685167283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4X5dFumnuHTw1olZC5sCQAZYfvwwEiFQPwRXUqoQ6Jc=;
        b=aSB6Z145zYU4jh6yH73qzOOuXe/oS1pjBVfNeXiMzB0yy08D78J0Id5w9W+a+wWlLo
         Q19IFpXNuqU5BuAbhdN4qsXhf1esPRdDUDBxNJoUrEYG/elP41PXaPircOFHZOeOKyWu
         c8QOv1DW+EB57DABfGp60dUi1Qw5CvU1vCmdWoEMgqyp0W9bSySVEeh3zIUgCnrn0//0
         74jd5tPxzdjJdIrfzWVHSICF9WQn00b2CcKuDo06dNnAopGpBONdAhtcWyuuthlkdXyv
         s/PI4v2EBzY61B/1tfrUWgDycGXZY6LRLpKQjuebMurMLjL44T2RlcL+XB6uGk7Q6XAa
         1Zkg==
X-Gm-Message-State: AC+VfDw2kIvL50f306CMoV2SNY8rkCRX4PQIBpUz7jDzvyQ/42n/WR5b
        YtZZoWZzwxX8cNSrnNddjqzGF4Dz45LnPtruC9o2Anal66mXOA==
X-Google-Smtp-Source: ACHHUZ4LBBYzZ9sg2uZXCO/J7jDVIlGlO57X5E45GfPQk/3xk2EwGACGktK3GZz506pw6+mBSAFg6dxi+Yy/UcVdoJU=
X-Received: by 2002:a05:6214:300a:b0:5e5:c0c2:c64e with SMTP id
 ke10-20020a056214300a00b005e5c0c2c64emr7831928qvb.3.1682575283232; Wed, 26
 Apr 2023 23:01:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230426220338.430638-1-andreas@kemnade.info> <f6b261ad-3267-db70-c173-154a12c42bea@csgroup.eu>
In-Reply-To: <f6b261ad-3267-db70-c173-154a12c42bea@csgroup.eu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 27 Apr 2023 09:00:47 +0300
Message-ID: <CAHp75Vep8VSirY7mvGGCubNi-O4jS_inTALS3Ei9mQu98RV+7Q@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: fix allocation of mixed dynamic/static GPIOs
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Andreas Kemnade <andreas@kemnade.info>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        ": Tony Lindgren" <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 8:40=E2=80=AFAM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 27/04/2023 =C3=A0 00:03, Andreas Kemnade a =C3=A9crit :
> > [Vous ne recevez pas souvent de courriers de andreas@kemnade.info. D=C3=
=A9couvrez pourquoi ceci est important =C3=A0 https://aka.ms/LearnAboutSend=
erIdentification ]
> >
> > If static allocation and dynamic allocation GPIOs are present,
> > dynamic allocation pollutes the numberspace for static allocation,
> > causing static allocation to fail.
> > Enfore dynamic allocation above GPIO_DYNAMIC_BASE.
>
> Hum ....
>
> Commit 7b61212f2a07 ("gpiolib: Get rid of ARCH_NR_GPIOS") was supposed
> to enforce dynamic allocation above GPIO_DYNAMIC_BASE already.
>
> Can you describe what is going wrong exactly with the above commit ?

Above commit only works to the first dynamic allocation, if you need
more than one with static ones present it mistakenly will give you a
base _below_ DYNAMIC_BASE.

However, this change is just PoC I proposed, the conditional and
action should be slightly different to cover a corner case, when
statically allocated chip overlaps the DYNAMIC_BASE, i.e. gdev->base <
DYNAMIC_BASE, while gdev->base + gdev->ngpio >=3D DYNAMIC_BASE.


--=20
With Best Regards,
Andy Shevchenko
