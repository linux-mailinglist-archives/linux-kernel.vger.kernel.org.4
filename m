Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9817215A1
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 10:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjFDIi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 04:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjFDIiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 04:38:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E526DA
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 01:38:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF8D860ADE
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 08:38:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12DB9C433AC
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 08:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685867902;
        bh=KnudFN4jNcEutuFxf6DNoM8rGgneiw4Lp3ZjTygxhr8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Jk1iDIy0AZGsHq3dxk3q2oDmG16NwRs5ys11ZUg7tkxZNROZOXoUuq0VsTqcMZm6V
         YCbPG7GkVbBBsB0FHun7uKhoD74dasItwdpbhFfagSlLDv8twFRhkMN5qvSPQ1vnAE
         bZ/KyWN7MzT51MByrCVeh6PRcjEAwDaOOHc1WPE3oaex9HnQKwsgj3FOoPbaxnoIaT
         iyMKe461BKSsGM5zYiumtRtrq3fkADzQKw5R6nkBoInt+b9DUBtxJYTMsmFVecI6Zp
         ppgECVckS+20TxdGsEN4q6tGhHl2jGBjxRVJIoplwBWSYVfTZboVUJTETOU/3/p32y
         beJ6yIP5wjpxg==
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-bb1f7c5495dso3646380276.3
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jun 2023 01:38:22 -0700 (PDT)
X-Gm-Message-State: AC+VfDwLoZwp8VE4ijE8JqtnHt1R+oE0r5p8f2J8xNuAhVMYqsUrDIkA
        MQM6+lPMRwLXHAHFoUlSSctqsmS4yR3uad+aW+M=
X-Google-Smtp-Source: ACHHUZ4JPFHwUpGaNVEQxuGlSXgjpG5Bx6zVuVp9ongH9xrFwkFWDOGNXQ+eva+U1KI6qIraorqXGvm/Bu5D7fIk6XM=
X-Received: by 2002:a25:8108:0:b0:bac:26d2:53dd with SMTP id
 o8-20020a258108000000b00bac26d253ddmr8410051ybk.43.1685867901040; Sun, 04 Jun
 2023 01:38:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230603170747.1753842-1-masahiroy@kernel.org> <20230604045202.GA29881@pendragon.ideasonboard.com>
In-Reply-To: <20230604045202.GA29881@pendragon.ideasonboard.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 4 Jun 2023 17:37:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQFc_jEOTyKC429Ee5_F+QnhS88TYudebQ7LH82SbJ+Eg@mail.gmail.com>
Message-ID: <CAK7LNAQFc_jEOTyKC429Ee5_F+QnhS88TYudebQ7LH82SbJ+Eg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/bridge: imx: fix mixed module-builtin object
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Liu Ying <victor.liu@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Nick Terrell <terrelln@fb.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 4, 2023 at 1:52=E2=80=AFPM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Yamada-san,
>
> Thank you for the patch.
>
> On Sun, Jun 04, 2023 at 02:07:46AM +0900, Masahiro Yamada wrote:
> > With CONFIG_DRM_IMX8QM_LDB=3Dm and CONFIG_DRM_IMX8QXP_LDB=3Dy (or vice
> > versa), imx-ldb-helper.o is linked to a module and also to vmlinux
> > even though the expected CFLAGS are different between builtins and
> > modules.
> >
> > This is the same situation as fixed by commit 637a642f5ca5 ("zstd:
> > Fixing mixed module-builtin objects").
> >
> > Turn helpers in imx-ldb-helper.c into inline functions.
>
> Wouldn't it be better to turn it into a module ? It could then be
> built-in for the above configuration, are compiled as a module when all
> its users are module as well.


Yes, two ways to fix it.
inline line functions vs a separate module

I do not have a strong opinion.


I sent v2.
https://lore.kernel.org/lkml/20230604075713.1027261-1-masahiroy@kernel.org/=
T/#t

Please pick a preferred one.








--
Best Regards

Masahiro Yamada
