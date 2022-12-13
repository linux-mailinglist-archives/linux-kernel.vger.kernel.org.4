Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69BF64BF1A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 23:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236282AbiLMWH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 17:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236827AbiLMWHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 17:07:49 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC8D12ADB;
        Tue, 13 Dec 2022 14:07:47 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id ay8-20020a05600c1e0800b003d0808d2826so1638599wmb.1;
        Tue, 13 Dec 2022 14:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6cV2hqKLSWarZJIq6Mj0CxmhjtF4ppjv7Uck61tyaog=;
        b=fGOUZnlCnBB1WheeZsjkR7M24Trny3cJ8RbulvsEWFHzdKiXhNEJpF9ENuPjtp0e5S
         D8zf8a4hBMiyQkSNnJaUwprRsf3D0ojX4l91CDxhGpNcKTpovrAmKz/yyIobOxOMIGlS
         J7ep9NlXxHyqWuvRj8o+AASFMti3+EG8XbuzYr6+Z20tj1HdS6BvsiWRflgPhnGBPuGK
         3cyeI/CygSnK98Lj1Xdf82chaI7q2Hi97f7q+oGIBMhh+R54SqyDBySDrgcupxTh9To5
         fuOqjwVrZbUXaRsMyZJb6hWjS2lfKrBapu84xgIx8AHqqjGKfKyuA/r7r9zMJPMrQJCj
         uehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6cV2hqKLSWarZJIq6Mj0CxmhjtF4ppjv7Uck61tyaog=;
        b=njPewDvCPZOEBB+yBKYyyy136AQrmpWxod3wBZvQ8ZHJihwp7ZKHPf5NNmSFsS5Z3y
         c134bB2aqSV+wClku7fErcPOpZoWxFWx1WBXvqgNkHRI35rKd34rlhHc+hBQeDSpASQK
         +xUlPeRFqizzBXRpcjS5kJ+zkJ1TEoIurx1dK8vVIg8M4gnMaZZw9ZDylyL7v6JJaMD7
         MpGunOsrkvu5nzqoyFIR0xxijKkNWgVOQsToqb80A4983DZNzrFiWBMaAMXH23soMeJt
         j1eyXmSDEFfWR94yu71DI/TIKP8L1VK/s3+8kwtdh7B4kVkITrHr7pG1QsFnxe3ccB6o
         zR3g==
X-Gm-Message-State: ANoB5pkahNCfeZKWUvEelGltCMvnkJZ09VF3MKvHDFhaYggDn+jBypL5
        UW1aM8lj/rnB1uqJiqlpcWE=
X-Google-Smtp-Source: AA0mqf5VSkNBy0K9e9QCoOk+XM8BF2QQcdfL4aecWKcMqZmhYCMQv6KG3ZosaXujedvoJHBrhAJbow==
X-Received: by 2002:a1c:cc1a:0:b0:3cf:5e42:de64 with SMTP id h26-20020a1ccc1a000000b003cf5e42de64mr17072221wmb.39.1670969266277;
        Tue, 13 Dec 2022 14:07:46 -0800 (PST)
Received: from giga-mm.home ([2a02:1210:8629:800:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id z11-20020a1c4c0b000000b003c21ba7d7d6sm37243wmf.44.2022.12.13.14.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 14:07:45 -0800 (PST)
Message-ID: <6a288c4f54aa501e265a4f4847f2d2e53c597c34.camel@gmail.com>
Subject: Re: [PATCH] of: fdt: Honor CONFIG_CMDLINE* even without /chosen node
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     Rob Herring <robh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Lukasz Majewski <lukma@denx.de>,
        Linus Walleij <linusw@kernel.org>
Date:   Tue, 13 Dec 2022 23:07:44 +0100
In-Reply-To: <20221213152920.GA1025576-robh@kernel.org>
References: <11af73e05bad75e4ef49067515e3214f6d944b3d.camel@gmail.com>
         <CACRpkdaXxPE3XhPnprhJ7GGjn9X_GMsCJ3mn26P90GcHzhsQDg@mail.gmail.com>
         <20221213152920.GA1025576-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob,

On Tue, 2022-12-13 at 09:29 -0600, Rob Herring wrote:
> On Tue, Dec 13, 2022 at 09:51:33AM +0100, Linus Walleij wrote:
> > On Mon, Dec 12, 2022 at 7:01 AM Alexander Sverdlin
> > <alexander.sverdlin@gmail.com> wrote:
> >=20
> > > I do not read a strict requirement on /chosen node in either ePAPR or=
 in
> > > Documentation/devicetree. Help text for CONFIG_CMDLINE and
> > > CONFIG_CMDLINE_EXTEND doesn't make their behavior explicitly dependen=
t on
> > > the presence of /chosen or the presense of /chosen/bootargs.
> > >=20
> > > However the early check for /chosen and bailing out in
> > > early_init_dt_scan_chosen() skips CONFIG_CMDLINE handling which is no=
t
> > > really related to /chosen node or the particular method of passing cm=
dline
> > > from bootloader.
> > >=20
> > > This leads to counterintuitive combinations (assuming
> > > CONFIG_CMDLINE_EXTEND=3Dy):
> > >=20
> > > a) bootargs=3D"foo", CONFIG_CMDLINE=3D"bar" =3D> cmdline=3D=3D"foo ba=
r"
> > > b) /chosen missing, CONFIG_CMDLINE=3D"bar" =3D> cmdline=3D=3D""
> > > c) bootargs=3D"", CONFIG_CMDLINE=3D"bar" =3D> cmdline=3D=3D" bar"
> > >=20
> > > Move CONFIG_CMDLINE handling outside of early_init_dt_scan_chosen() s=
o that
> > > cases b and c above result in the same cmdline.
> > >=20
> > > Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> >=20
> > Excellent debugging Alexander!
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> >=20
> > I also think this should go to stable.
>=20
> We have to be careful there. This could change behavior on a working=20
> system. A system taking the cmdline entirely from a built kernel and=20
> no initrd is going to be pretty customized already, I think they can=20
> carry a patch. What platform is this anyways?

I've stumbled upon this testing first DT conversion patches for EP93xx (ARM=
).

> This has actually been known for some time[1][2]. My concern in the past=
=20
> (besides wanting all the cmdline manipulation being common) was MIPS.=20

This "change of behavior" actually changes one exact corner case:
no /chosen node + CONFIG_CMDLINE!=3D"" + CONFIG_CMDLINE_EXTEND=3Dy

If someone was intentionally hiding something in the config file
under CONFIG_CMDLINE but didn't want it to appear on the kernel command
line in the past, he could just reconfigure new kernel version after
the change and remove the above configs.

> MIPS in particular has lots of sources for cmdline and ways to combine=
=20
> it. However, MIPS has since stopped using this code and does their own=
=20
> parsing (not great either IMO).

I agree, this code screams to be common.

--=20
Alexander Sverdlin.

