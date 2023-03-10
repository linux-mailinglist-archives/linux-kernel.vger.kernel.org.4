Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90366B3E91
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 13:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjCJMBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 07:01:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjCJMB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 07:01:29 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2415B9C95
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 04:01:27 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id l13so5342056qtv.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 04:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678449687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+M6lRCbmrYVP1gh6D5uqx/6F49PKyrQU5AeobR2iPlc=;
        b=tyd2JbpZ1ozjYqn2KGkMtnvlik2iD7XK49rK/Y8hq+f46VRxOs5FJlKXQ9EeIXqqDe
         h2d4RAA7dDVjj3ScMyAK2lcvtuJoN3LCSQ8Exvuq78ezXmeuskgTfgafEGtWnwm1zjQz
         Z2+v4f1sAQYmx4kRPL29m3+Nn1XbsugKZvLsHppRT4o/LOrshbLnHdVr9jcve8Mpmdui
         IUlkKXMWogZXV+wkRu1ADMwdrnYL/09BFKLHgdoXxdbr/ZroesG0Gw8Ob6gxqb9DV7pM
         kFwlqJl3KVJXudte24FZLCbaO70X26gZGhKHpwjc1UC0X1NJzQHyCZosElfe5nRohs1G
         Wvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678449687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+M6lRCbmrYVP1gh6D5uqx/6F49PKyrQU5AeobR2iPlc=;
        b=zEz27zd1cRnGFO4rOBS2s5L8+z5Zo6kKGzOpPqhF8qcF1BPQOLTlDoZP3TGZt0YdxS
         rlQwsShajUjBhwXDJtYf+FgSMjEh6gnOM69uXmTkWJPqNGsN4pV/1SKHh5i3hfwrJOq9
         rkc6R5rU9OyCMvNbBvF8x/2zEQFCn/Wd6Acv834E7JgdVCp3/O/LBbagxKLX2gEaI2AU
         lZiftAyGdaB97oR/NLVt6l4tztnA1bp7B+APJEXCZGuAuh+YLlRn1IQUy451vIP11OE7
         Loetl6jktblSKs0ZXrmFGXAWCnzANTse2UFvMsCOqZz0kkpQRPvDvAcC0RzYLcao957H
         lpjQ==
X-Gm-Message-State: AO0yUKWYzLjg/hZpB/WoImN5bY1vGpLNw1r0ROvssjZg/mA+ztSrQo4C
        u6z7subYs+nsuPk2QaIk6/kRyg==
X-Google-Smtp-Source: AK7set9+lMbGEsxRTqC4YM9HMcTT4AmoC4toTeCzxQbEVJHu8ZuFVTa9R1FOZDNvGVH83ICOh4n/Kw==
X-Received: by 2002:ac8:5e08:0:b0:3bf:c83d:5d4c with SMTP id h8-20020ac85e08000000b003bfc83d5d4cmr37742949qtx.64.1678449686971;
        Fri, 10 Mar 2023 04:01:26 -0800 (PST)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id t21-20020ac85315000000b003b34650039bsm1216162qtn.76.2023.03.10.04.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 04:01:26 -0800 (PST)
Date:   Fri, 10 Mar 2023 07:01:23 -0500
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     broonie@kernel.org, linus.walleij@linaro.org,
        andriy.shevchenko@linux.intel.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] regmap-irq: Add no_status support
Message-ID: <ZAscE+AQVgikm74J@fedora>
References: <cover.1677515341.git.william.gray@linaro.org>
 <bd501b4b5ff88da24d467f75e8c71b4e0e6f21e2.1677515341.git.william.gray@linaro.org>
 <CAMRc=MdkkO4DpdLJA4SkEbAFFrdDtfZBOtLFPmkTBnSMDz=gCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QOsQSVvg4l9X3RSV"
Content-Disposition: inline
In-Reply-To: <CAMRc=MdkkO4DpdLJA4SkEbAFFrdDtfZBOtLFPmkTBnSMDz=gCQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QOsQSVvg4l9X3RSV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 06, 2023 at 11:11:26AM +0100, Bartosz Golaszewski wrote:
> On Mon, Feb 27, 2023 at 5:54=E2=80=AFPM William Breathitt Gray
> <william.gray@linaro.org> wrote:
> >
> > Some devices lack status registers, yet expect to handle interrupts.
> > Introduce a no_status flag to indicate such a configuration, where
> > rather than read a status register to verify, all interrupts received
> > are assumed to be active.
> >
> > Cc: Mark Brown <broonie@kernel.org>
> > Signed-off-by: William Breathitt Gray <william.gray@linaro.org>

[...]

> Mark,
>=20
> If this looks good to you, could you Ack it so that I can take it
> through the GPIO tree?
>=20
> Bart

Bart,

There's a change to the regmap-irq handle_mask_sync() callback I
submitted that will affect these patches [0]. If you haven't already
picked up this series, I suggest waiting until the handle_mask_sync()
change is resolved, after which I can rebase this series on top of it
and we'll end up with a cleaner git history.

[0] https://lore.kernel.org/all/20230309232009.2938-1-william.gray@linaro.o=
rg/

William Breathitt Gray

--QOsQSVvg4l9X3RSV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZAscEwAKCRC1SFbKvhIj
K46/AQDAXrIURWz/WQaeH1a4LfNpDLKlYHNfZzDo9dJdsZej7AD/U9urckXZD23X
2V8lnh2ZuGpnbmB4SUpuOHj3P9O0Ewk=
=XeWK
-----END PGP SIGNATURE-----

--QOsQSVvg4l9X3RSV--
