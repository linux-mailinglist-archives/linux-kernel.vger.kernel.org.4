Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0622574F7D1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 20:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjGKSKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 14:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjGKSKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 14:10:22 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4118C10D2;
        Tue, 11 Jul 2023 11:10:21 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fbc656873eso74240035e9.1;
        Tue, 11 Jul 2023 11:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689099020; x=1691691020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DN7SKT5YDMsR3KLZsulL1k2cEGxGqiu83tf4hiEqzbU=;
        b=im/1f6USttl0PouwJHsl8oeTUnxojJWtSZG491nIXLs46KPt7ROCw91xJTOyHfWwU/
         Xclj03qDL2nnO631QYUGdOC+5GIfuOU1v6j2zYAwY9lNkR0htj0Y4Lo+Bt57c/w8uWOE
         GNARBXdLwJLhXUGgqwCHpFF+IYttDDQnh3gNX/8n9G1A/g1sfzEfTaupsnvTFUO/gnrs
         65JSUrxGcUCbjsehFA61GacHlNKz79Sdc9lpnUJDJF61O3+8d6wG3DqTU8M0Bq6Rs+z8
         Ue+3xNlzmqNoUg/2yeM26G8NwZExCqhmNl3Ei0hYkoBUGbthIYtCVdUH4i3K50vcpyw6
         oqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689099020; x=1691691020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DN7SKT5YDMsR3KLZsulL1k2cEGxGqiu83tf4hiEqzbU=;
        b=i9kUGAzzHQVugI1K18a+8v1GULJZ90r9CLW8D5eSlMSpgjqB23HkfgJtLzopW2qRmm
         2vZo1G8LwjP5fJx80hg7wFPdcdQzWicSndWEzGkHfoBVk/7OCr8RWwifNue+hyqhgjAE
         ndmvBACSE3jjSsYHaytsdkYBMHima3510W1X83paxoA98X8WCoeu+TMwqVWgn2yT6Bnv
         17l0SOYBhEltTFUvcAF7oyFt6YpizeBSQUFsIqSNF23mMLnP4IxNz41mMcZDdJlCC4sp
         I0erPVpvWelUMv3UrjfCaBD/FctU1qFCmLh1xeQKOSBR2k0R5GOdJjeAexHMXHY8LYgJ
         G/kw==
X-Gm-Message-State: ABy/qLZ9Wtq3PU3YuyOX5Dnaqwn0j3sxjTscf0zE5OXTYZ/cVgZmwPCv
        PmFn/LjaK9On2hhwHgMe/AY=
X-Google-Smtp-Source: APBJJlF2BZKCrWmEhTh/350w2TFfo/9EYgx+QZBOKTKsh9nhH1eoZObr6KPDzwISpk3jEX8ZvMVbGA==
X-Received: by 2002:a7b:ca47:0:b0:3fc:855:db42 with SMTP id m7-20020a7bca47000000b003fc0855db42mr12672343wml.34.1689099019465;
        Tue, 11 Jul 2023 11:10:19 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id o5-20020a1c7505000000b003fbd9e390e1sm13613422wmc.47.2023.07.11.11.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 11:10:18 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     privatesub2@gmail.com, linux-kernel@vger.kernel.org,
        thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        wens@csie.org, samuel@sholland.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, p.zabel@pengutronix.de,
        cristian.ciocaltea@collabora.com,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 0/3] Add support for Allwinner PWM on D1/T113s/R329 SoCs
Date:   Tue, 11 Jul 2023 20:10:16 +0200
Message-ID: <2287998.ElGaqSPkdT@jernej-laptop>
In-Reply-To: <20230706202057.k6rfwfhe3msfkrc4@pengutronix.de>
References: <20230627082334.1253020-1-privatesub2@gmail.com>
 <mhng-0cca3d46-6031-4e8a-8e8f-2c479a20b95d@palmer-ri-x1c9a>
 <20230706202057.k6rfwfhe3msfkrc4@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne =C4=8Detrtek, 06. julij 2023 ob 22:20:57 CEST je Uwe Kleine-K=C3=B6nig =
napisal(a):
> Hello,
>=20
> On Thu, Jul 06, 2023 at 10:08:47AM -0700, Palmer Dabbelt wrote:
> > On Tue, 27 Jun 2023 01:23:23 PDT (-0700), privatesub2@gmail.com wrote:
> > > Hi,
> > >=20
> > > This series adds support for PWM controller on new
> > > Allwinner's SoCs, such as D1, T113s and R329. The implemented driver
> > > provides basic functionality for control PWM channels.
> > >=20
> > > v2:
> > >  - fix dt-bindings
> > >  - fix a remark in the driver
> > >=20
> > > v3:
> > >  - fix dt-bindings
> > >  - fix sunxi-d1s-t113.dtsi
> > >=20
> > > Aleksandr Shubin (3):
> > >   dt-bindings: pwm: Add binding for Allwinner D1/T113-S3/R329 PWM
> > >  =20
> > >     controller
> > >  =20
> > >   pwm: Add Allwinner's D1/T113-S3/R329 SoCs PWM support
> > >   riscv: dts: allwinner: d1: Add pwm node
> > > =20
> > >  .../bindings/pwm/allwinner,sun20i-pwm.yaml    |  86 +++++
> > >  .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    |  11 +
> > >  drivers/pwm/Kconfig                           |  10 +
> > >  drivers/pwm/Makefile                          |   1 +
> > >  drivers/pwm/pwm-sun20i.c                      | 322 ++++++++++++++++=
++
> > >  5 files changed, 430 insertions(+)
> > >  create mode 100644
> > >  Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml crea=
te
> > >  mode 100644 drivers/pwm/pwm-sun20i.c
> >=20
> > Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> >=20
> > I'm not sure if this ended up somewhere, but I'm assuming it's not aimed
> > at
> > my tree.  LMK if you guys want me to pick it up, I'm dropping it from
> > patchwork.
>=20
> At least patch #2 should go via the pwm tree. It's on my list to review.

Rest will go through sunxi tree, although DT bindings patches are usually=20
picked together with driver patches. I'm fine either way.

Best regards,
Jernej




