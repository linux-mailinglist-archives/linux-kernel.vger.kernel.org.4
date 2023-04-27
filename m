Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8FF6F0449
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 12:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243583AbjD0Khx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 06:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243320AbjD0Kht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 06:37:49 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA92AFF;
        Thu, 27 Apr 2023 03:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kMB0XRCHsuAI2geKD5SmnuVr5s6qo5dyKc/cVU06Qig=; b=7WMB1Oele0kgZL8h5FamuK5WvD
        +52PLwUQuRJanhXYRsv8J8Od/nFA7vRHGld6Jhdq0107Ri2t227KCxnDTU2Y3XuJBpPXKHQWWk2p8
        56ajOd5D4aufPWJzcnRnqtDdiiRAquYvmWVvB0rMGNoxhj5QEi87BIZy5bfeGwXwrbrLYhPY3prCh
        wCKaoqLSOuYUX15ofOI4X30NlHScRDi0UI/TDTAKYNkwirjHQ2NUhvQ+rf7IFa1OL48knQKQ+1CzH
        dzrAvgx3ElhRR1D9xJuaNEmXMG6UsNBI2U/Dmn8BjVtH+SYtIRNbaaBeVaNAiWm7U2k1rsaCRPjqk
        LVchktyw==;
Received: from p200300ccff1672001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff16:7200:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1prz0I-00010G-Na; Thu, 27 Apr 2023 12:37:34 +0200
Date:   Thu, 27 Apr 2023 12:37:33 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        ": Tony Lindgren" <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Subject: Re: [PATCH] gpiolib: fix allocation of mixed dynamic/static GPIOs
Message-ID: <20230427123733.15ad4aa3@aktux>
In-Reply-To: <52453352-74bd-979f-03b6-322489800538@csgroup.eu>
References: <20230426220338.430638-1-andreas@kemnade.info>
        <f6b261ad-3267-db70-c173-154a12c42bea@csgroup.eu>
        <CAHp75Vep8VSirY7mvGGCubNi-O4jS_inTALS3Ei9mQu98RV+7Q@mail.gmail.com>
        <52453352-74bd-979f-03b6-322489800538@csgroup.eu>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.24; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Apr 2023 06:20:34 +0000
Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> Le 27/04/2023 =C3=A0 08:00, Andy Shevchenko a =C3=A9crit=C2=A0:
> > On Thu, Apr 27, 2023 at 8:40=E2=80=AFAM Christophe Leroy
> > <christophe.leroy@csgroup.eu> wrote: =20
> >>
> >>
> >>
> >> Le 27/04/2023 =C3=A0 00:03, Andreas Kemnade a =C3=A9crit : =20
> >>> [Vous ne recevez pas souvent de courriers de andreas@kemnade.info. D=
=C3=A9couvrez pourquoi ceci est important =C3=A0 https://aka.ms/LearnAboutS=
enderIdentification ]
> >>>
> >>> If static allocation and dynamic allocation GPIOs are present,
> >>> dynamic allocation pollutes the numberspace for static allocation,
> >>> causing static allocation to fail.
> >>> Enfore dynamic allocation above GPIO_DYNAMIC_BASE. =20
> >>
> >> Hum ....
> >>
> >> Commit 7b61212f2a07 ("gpiolib: Get rid of ARCH_NR_GPIOS") was supposed
> >> to enforce dynamic allocation above GPIO_DYNAMIC_BASE already.
> >>
> >> Can you describe what is going wrong exactly with the above commit ? =
=20
> >=20
> > Above commit only works to the first dynamic allocation, if you need
> > more than one with static ones present it mistakenly will give you a
> > base _below_ DYNAMIC_BASE. =20
>=20
> Ah right, that needs to be fixed.
>=20
> >=20
> > However, this change is just PoC I proposed, the conditional and
> > action should be slightly different to cover a corner case, when
> > statically allocated chip overlaps the DYNAMIC_BASE, i.e. gdev->base <
> > DYNAMIC_BASE, while gdev->base + gdev->ngpio >=3D DYNAMIC_BASE.
> >  =20
>=20
> Yes you are right, that's gdev->base + gdev->ngpio that should be checked.
>=20
and that not with simple continue or base might simply stay at DYNAMIC_BASE.

I will send a v2 of this patch with refined logic.

Regards,
Andreas
