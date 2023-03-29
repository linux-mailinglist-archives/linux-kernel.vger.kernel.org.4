Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3386CD351
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 09:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjC2HfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 03:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjC2HeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 03:34:21 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2309C618C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 00:31:52 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 99F6320008;
        Wed, 29 Mar 2023 07:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1680075110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y5Tz+W9L5sIsVCnWkSfJ3WHW6H3+KUzYvv4GXzZD7MA=;
        b=AqBaobXJksPG1S257DuMCuggbk3BSsTl842Ld5g4y3m4Qx3qZVsb4EwOdr0NHIioQwW4lk
        lrQWv35/JL7ihJLLf6xXaVbdunE3un7PGWueSNJ1zpd2HcqtQQlK+0MWlcbOVU7aCh8fv2
        DeCL+/b13ZV3O79ygOjLUr0hJI0nMqwTC52mJbBypIS6Q30CV5LKWbL+o0SjfwOA44SrFP
        ZamVMaCVq0gMaGXfmPLSuxQ79n1gK1ChR3NkpzrjLVaeP/k7tY9AjJRgWVKoiUSK4qmFYW
        LGmSnbovVrimfYUCheZggtBxKHD+F2KEiSpBAKAIMQw9RlU0bqoZQ9o2CUgYFA==
Date:   Wed, 29 Mar 2023 09:31:45 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arseniy Krasnov <avkrasnov@sberdevices.ru>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@sberdevices.ru>,
        <oxffffaa@gmail.com>
Subject: Re: [PATCH v1] mtd: rawnand: meson: fix bitmask for length in
 command word
Message-ID: <20230329093145.52790647@xps-13>
In-Reply-To: <2fed42ad-11cb-6199-6adb-d9272209f5e2@sberdevices.ru>
References: <d4338bd5-125c-a9e7-cb46-6f5e1da05cfa@sberdevices.ru>
        <CAFBinCB3yuyNJD=7UJ7jzf45Masms_PD4sm42YNjO8M4cr+4wg@mail.gmail.com>
        <fe2ed378-cdac-dbb3-acd2-ff542bd7e887@sberdevices.ru>
        <81632eee-533e-5e44-1520-5321a06c6797@sberdevices.ru>
        <20230328185001.5661132b@xps-13>
        <e8edcbc8-5c72-b29e-21d7-6f4438391924@sberdevices.ru>
        <CAFBinCCCNYJV4RBbM78r3yGPnY4oNKySEFRkzBgUD3xYJGkJmw@mail.gmail.com>
        <2fed42ad-11cb-6199-6adb-d9272209f5e2@sberdevices.ru>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

avkrasnov@sberdevices.ru wrote on Wed, 29 Mar 2023 10:12:10 +0300:

> On 28.03.2023 23:25, Martin Blumenstingl wrote:
> > Hi Arseniy,
> >=20
> > On Tue, Mar 28, 2023 at 8:39=E2=80=AFPM Arseniy Krasnov
> > <avkrasnov@sberdevices.ru> wrote:
> > [...] =20
> >>>
> >>> By the way any reason not to have Cc'ed stable? =20
> >>
> >> Sorry, what do You mean? I've included linux-mtd mailing lists, there =
is
> >> one more list for mtd reviews? I will appreciate if You can point me =
=20
> > "stable" typically refers to the stable tree where fixes for already
> > released kernel versions are maintained.
> > When Miquel applies the patch it will either land in the next -rc of
> > the current development cycle (typically applies to fixes - currently
> > 6.3-rc5) or -rc1 of the next kernel version (typically applies to new
> > features, cleanups, etc. - currently 6.4-rc1).
> >=20
> > Let's say you are fixing a bug now but want the fix to be included in
> > 6.1 LTS (long term stable) or other stable release.
> > In this case it's recommended to Cc the maintainers of the stable
> > trees as part of your patch, see [0].
> > That way once the commit with your fix hits Linus Torvalds linux tree
> > it will be backported by the stable team within a few days (assuming
> > of course that the patch applies cleanly to older versions, if not
> > they're notifying you).
> > Note: even without Cc'ing the stable maintainers your commit may be
> > backported (semi-automatically) if it has a Fixes tag and the stable
> > maintainers find your commit. But my understanding is that it's
> > easiest for them if they're explicitly Cc'ed on the patch.
> >=20
> > I hope this makes sense. If not: don't hesitate to ask. =20

That is an excellent summary, I should copy/paste it sometimes :)

>=20
> Hello! Thanks for this detailed explanation, that really helps!

So IOW, I am asking you to send a v2 with an additional line in the
commit, right next "Fixes":

Cc: stable@vger.kernel.org

Thanks,
Miqu=C3=A8l
