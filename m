Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12CDD713500
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 15:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbjE0N3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 09:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbjE0N3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 09:29:39 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D55125
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 06:29:18 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-bacfcc7d1b2so2647509276.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 06:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ossystems-com-br.20221208.gappssmtp.com; s=20221208; t=1685194158; x=1687786158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :references:mime-version:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bk/35MSXwnwDqOa61NfULS56WT2D8JtdWj0kdSLNcj0=;
        b=tCoC/u1XjYnbyj3DD2ZDjaIJ7Q9zi1avxPjobFhr++5lJf7O9qPOpPlVFWD+XBJZ1l
         2oerB6h5IPdRGhUrdqpCVmh/uU+ReNoU4Jthpp32hneetjE7Ny7bOr/KL6QWwLjpli1W
         reWvHGF0zdPuMsmvwfysI6vuq+PUlSZ5jRlhBKAsjZAOKSBIg/82denruqUtVFuNOd/Z
         yLlDcAn+5/kbm/HPkQjmn6wz9t/+sLYRWwcGH77E6Upo9c19TwSpHaLej14IcYWqGiAS
         DAojz8pzrF30xUgNMYdDIk5/2Nw4QtjJKDqv+FnTPNXaJBsQAeKdEcUG2ebSzTc2aMj8
         95gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685194158; x=1687786158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :references:mime-version:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Bk/35MSXwnwDqOa61NfULS56WT2D8JtdWj0kdSLNcj0=;
        b=aexYLzvJXmMBvPW5EyIg/s7sqsz1s7AqwEJt6Pd86AyQUH2/b6BqdVM4dIC1sgLniN
         6mrYzNQynrF1c77ZPptkI1zB7/nrfKIZ+ZPC9KV/GBmjJnq3/UMaoQRQ6HHx/ZoOGVMf
         aeITGDlRNtuS6kjKfkzIPG8fxC7L5VI34Oby42JRTnpTOTyXy1hrsHJ+BufyI4pplZhc
         8BimmtKu99ai8MBgv8gU8EKmNYXFr+DsrtPHDrRfuJ7swpCQEGYD59CmZ/aUm0I8Xtrr
         MBQlEIYegLkPRElcMuPKEy34YHAj1e5Ho0eC/R91+A0J6WZurnw9P8JjmQ5uGt4OrRC5
         hG5g==
X-Gm-Message-State: AC+VfDwfPVr1VSchBxHqnlcR3hv9SPo7otZo5UyJsa7ehttEmhy96Zd7
        uyQ1bzYmdDAklEOT0qdp8X5HgKhn9kxCGbtCDcZvgw==
X-Google-Smtp-Source: ACHHUZ5Hqu2IXSDby1TPtJ4gAWC3nK14XziSss84tKRoy+cspAnFKVbFa8uPgg6XJoshFObCdVHSIA==
X-Received: by 2002:a25:2484:0:b0:b92:32aa:be46 with SMTP id k126-20020a252484000000b00b9232aabe46mr5131518ybk.22.1685194157915;
        Sat, 27 May 2023 06:29:17 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id 5-20020a251605000000b00ba83a9755f1sm1634238ybw.43.2023.05.27.06.29.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 May 2023 06:29:16 -0700 (PDT)
From:   Otavio Salvador <otavio.salvador@ossystems.com.br>
X-Google-Original-From: Otavio Salvador <otavio@ossystems.com.br>
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-565cdb77b01so7897597b3.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 06:29:16 -0700 (PDT)
X-Received: by 2002:a81:4986:0:b0:565:7025:610a with SMTP id
 w128-20020a814986000000b005657025610amr5240750ywa.27.1685194156049; Sat, 27
 May 2023 06:29:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230523212829.2539417-1-otavio@ossystems.com.br>
 <b8166ed7-2d3b-4bdd-b597-f0aeddb7ecdc@app.fastmail.com> <20230527124428.GT528183@dragon>
In-Reply-To: <20230527124428.GT528183@dragon>
Date:   Sat, 27 May 2023 10:29:04 -0300
X-Gmail-Original-Message-ID: <CAP9ODKociRAi9WP-R_-JoKmMWtSN2JwJJ+7n-cn4u-G-vktS3A@mail.gmail.com>
Message-ID: <CAP9ODKociRAi9WP-R_-JoKmMWtSN2JwJJ+7n-cn4u-G-vktS3A@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx_v6_v7_defconfig: Remove KERNEL_LZO config
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Otavio Salvador <otavio@ossystems.com.br>,
        linux-arm-kernel@lists.infradead.org,
        Alistair Francis <alistair@alistair23.me>,
        Fabio Estevam <festevam@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Stefan Hansson <newbie13xd@gmail.com>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Shawn,

Em s=C3=A1b., 27 de mai. de 2023 =C3=A0s 09:44, Shawn Guo <shawnguo@kernel.=
org> escreveu:
>
> On Wed, May 24, 2023 at 08:48:26AM +0200, Arnd Bergmann wrote:
> > On Tue, May 23, 2023, at 23:28, Otavio Salvador wrote:
> > > The KERNEL_GZIP is used in most config and is the default, there is n=
o
> > > clear reason to diverge so let default be used.
> > >
> > > Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
> >
> > I don't mind that change, but it seems odd to single this one out, as
> > there are many other options in that particular defconfig that
> > stick out more, picking LZO seems like a reasonable choice for slightly
> > faster booting, though ZSTD would be the more modern choice.
> >
> > If you are looking into cleaning up this file, maybe see if we can
> > kill off these options:
> >
> > CONFIG_EXPERT=3Dy
> > CONFIG_ARCH_FORCE_MAX_ORDER=3D13
> > CONFIG_CMDLINE=3D"noinitrd console=3Dttymxc0,115200"
> > CONFIG_CS89x0_PLATFORM=3Dy # none of these four are in dts files
> > CONFIG_SMC91X=3Dy
> > CONFIG_SMC911X=3Dy
> > CONFIG_SMSC911X=3Dy
> > CONFIG_STAGING=3Dy
> > CONFIG_STAGING_MEDIA=3Dy
> > CONFIG_VIDEO_IMX_MEDIA=3Dy # not graduated from staging after 6 years
> > CONFIG_EXT2_FS=3Dy
> > CONFIG_EXT3_FS=3Dy # select EXT4 instead
> > CONFIG_ISO9660_FS=3Dm
> >
> > I have not investigated why any of them were added originally,
> > so it's likely that some are actually needed.
>
> Would you investigate the suggested options and see if we can clean up
> more than just KERNEL_LZO?

Sure. I'll view them. I'll prepare more patches for it.

--=20
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://code.ossystems.com.br
Mobile: +55 (53) 9 9981-7854          Mobile: +1 (347) 903-9750
