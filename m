Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B439E74F66A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 19:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjGKRFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 13:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjGKRFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 13:05:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0E195;
        Tue, 11 Jul 2023 10:05:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89CB26158F;
        Tue, 11 Jul 2023 17:05:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19DDC433CC;
        Tue, 11 Jul 2023 17:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689095138;
        bh=ffeJIapA2i8KtpkaQDaRRzVDC4qeHx8KurMrQFWzP7g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=la3HOtHvy0XM/f2Y4iTCps1/Ti4qRFo+7rh5KcklI3mtDVdSM3SrCeQr+ZvTu3Hbo
         zSpeSXhIIAT3AlrPPkw2+oymssLz8lCmLikDCttV1Y+1D7GUySlfUq57J23rzSbfnk
         r8IFpBqbGZ6Hntuxk246q4e9H9/UFZnpCNMeUTwbuxZoZu1yhSSPhfHhMmdBHCQPio
         nj8efEDaWTf3FdFrVe4NvM3l8UfrCZaWB3FjuaiPOr9X/IEiGybno2x9bRKyeKn/53
         2IsxxjksJxxQQfldC3UBRzTw/NbQZKNBAeUssPxK1UQYYeuNJwWupQKWgnaj0Balk/
         EMiFfAMwnCb2Q==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2b6f0508f54so93227331fa.3;
        Tue, 11 Jul 2023 10:05:38 -0700 (PDT)
X-Gm-Message-State: ABy/qLZBI+Amd07+7/rcuo08UHcwjx9qGu50FpPK52ipk9zwy3d7tyLm
        PPZs8m38Iik54YlQaYDEGQ+scYtRleo42iKLqA==
X-Google-Smtp-Source: APBJJlHoS1FcFxGwFPJ/ewPGABck5kWIkACfr8013AsyHvluCY8e0O92fpKWd7fFdLAfImxRrLkI27/ePXUc6RRhShw=
X-Received: by 2002:a2e:9d9a:0:b0:2b6:c4cf:76a8 with SMTP id
 c26-20020a2e9d9a000000b002b6c4cf76a8mr13182327ljj.10.1689095136927; Tue, 11
 Jul 2023 10:05:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230710174007.2291013-1-robh@kernel.org> <a0aa122d-38a1-d4be-edc1-a49b4e5e9b6b@suse.de>
 <4de35c35-c00d-d21a-bcd1-dc878137eb94@gmx.de>
In-Reply-To: <4de35c35-c00d-d21a-bcd1-dc878137eb94@gmx.de>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 11 Jul 2023 11:05:24 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJmQ+70CkqPDT3vhs0bYJ_e6fuQrSOkNwCj7i0JQA4-EA@mail.gmail.com>
Message-ID: <CAL_JsqJmQ+70CkqPDT3vhs0bYJ_e6fuQrSOkNwCj7i0JQA4-EA@mail.gmail.com>
Subject: Re: [PATCH] of: Preserve "of-display" device name for compatibility
To:     Helge Deller <deller@gmx.de>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Michal Suchanek <msuchanek@suse.de>,
        devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Cyril Brulebois <cyril@debamax.com>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 9:46=E2=80=AFAM Helge Deller <deller@gmx.de> wrote:
>
> On 7/11/23 08:00, Thomas Zimmermann wrote:
> >
> >
> > Am 10.07.23 um 19:40 schrieb Rob Herring:
> >> Since commit 241d2fb56a18 ("of: Make OF framebuffer device names uniqu=
e"),
> >> as spotted by Fr=C3=A9d=C3=A9ric Bonnard, the historical "of-display" =
device is
> >> gone: the updated logic creates "of-display.0" instead, then as many
> >> "of-display.N" as required.
> >>
> >> This means that offb no longer finds the expected device, which preven=
ts
> >> the Debian Installer from setting up its interface, at least on ppc64e=
l.
> >>
> >> Fix this by keeping "of-display" for the first device and "of-display.=
N"
> >> for subsequent devices.
> >>
> >> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217328
> >> Link: https://bugs.debian.org/1033058
> >> Fixes: 241d2fb56a18 ("of: Make OF framebuffer device names unique")
> >> Cc: stable@vger.kernel.org
> >> Cc: Cyril Brulebois <cyril@debamax.com>
> >> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> >> Cc: Helge Deller <deller@gmx.de>
> >> Signed-off-by: Rob Herring <robh@kernel.org>
> >
> > Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
>
> Acked-by: Helge Deller <deller@gmx.de>
>
> Who will pick up that patch?
> Shall I take it via fbdev git tree?

I'll take it. I've got other fixes queued up already.

Rob
