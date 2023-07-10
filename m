Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25D874CF28
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 09:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbjGJHyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 03:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbjGJHxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:53:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7F2E75
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 00:53:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B6C660E9E
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 07:53:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2380C433C9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 07:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688975616;
        bh=Qmnrxtp2tVTiIKeDr6PzWwhoq+AXMYmOqhQmbX2jJEA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=me5X+1vMmbkCFoCblOI/6sz+FZwvBOq4e/BYklHzHPC7pwS+qVuFmXBpgx8JrIa0r
         V7KTIKh+Rf597EnmBiZTTmH1JX0HJsImSgY3iimRTVpPHrBVnkeaojDt+gPt61T4gW
         RshlctRNBefMm4u2EiUGZQ1mxejx8DTWSLZQbbyMIsUqzg9YyFInm2+c0cNGCm1Kxd
         DCApn7BLIf6hIgfWTKdEZ4LUydtYcX/Ou6G8SjnEpI8o/I4D4uDULgRv3DlNPg72+f
         WKsBPDc/0VFBNUzsC2mW8wlwHoWs4Y8Eb0vL/F724lcDCAWwk4EJe7EB/VO3Cj8vlN
         inlniG9oCh0aA==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-4fb73ba3b5dso6415859e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 00:53:36 -0700 (PDT)
X-Gm-Message-State: ABy/qLZhlCpqOj1B4zf60wYzGpOMCLv9/P/Vs7UykLJkGPRS+j6AT4oq
        oSWEBXyhkGR4RhFJYzxO2rZS7Yuj9clGFA3MQ5o=
X-Google-Smtp-Source: APBJJlGrklgwHO1qTgGjnKuzcyOdT3q0J8ogI9MWBIiWxlqTGfnoiRQZ9grmnfmcQOLwKf0YrCEcsSSO40htVXcdsY0=
X-Received: by 2002:ac2:4e07:0:b0:4f9:5a0c:85b8 with SMTP id
 e7-20020ac24e07000000b004f95a0c85b8mr10308007lfr.36.1688975614593; Mon, 10
 Jul 2023 00:53:34 -0700 (PDT)
MIME-Version: 1.0
References: <MEYP282MB2597CD6E861D659E3218148DD933A@MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM>
 <CAAhV-H5P_NgJ5kTQ1iO-eL577D=-COjEZ6u9_OgvrHpWJLqsXw@mail.gmail.com> <62e81ce06e69d549b12d1145429730f8b27ad156.camel@hotmail.com>
In-Reply-To: <62e81ce06e69d549b12d1145429730f8b27ad156.camel@hotmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 10 Jul 2023 15:53:22 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7ihMnYD3LZi4kfJ1SQHxpX=j8D39Riinbvbb0AMo2oDg@mail.gmail.com>
Message-ID: <CAAhV-H7ihMnYD3LZi4kfJ1SQHxpX=j8D39Riinbvbb0AMo2oDg@mail.gmail.com>
Subject: Re: [PATCH] loongarch: Make CONFIG_CMDLINE work with
 CONFIG_CMDLINE_EXTEND and CONFIG_CMDLINE_BOOTLOADER
To:     donmor <donmor3000@hotmail.com>
Cc:     "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "kernel@xen0n.name" <kernel@xen0n.name>,
        "yangtiezhu@loongson.cn" <yangtiezhu@loongson.cn>,
        "zhoubinbin@loongson.cn" <zhoubinbin@loongson.cn>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "tangyouling@loongson.cn" <tangyouling@loongson.cn>
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

On Mon, Jul 10, 2023 at 1:35=E2=80=AFAM =E2=80=8E donmor <donmor3000@hotmai=
l.com> wrote:
>
> =E5=9C=A8 2023-07-09=E6=98=9F=E6=9C=9F=E6=97=A5=E7=9A=84 23:30 +0800=EF=
=BC=8CHuacai Chen=E5=86=99=E9=81=93=EF=BC=9A
> > How to reproduce? If you use UEFI firmware, this is handled in
> > drivers/firmware/efi/libstub/efi-stub.c; if you use non-UEFI firmware,
> > this is handled in drivers/of/fdt.c.
>
> In fact it 's not command line retrieved from efi or fdt, but the built-i=
n
> command line to be concerned. CONFIG_CMDLINE was never been touched durin=
g
> boot on loongarch, unless CONFIG_CMDLINE_FORCE is set because there is co=
de
> handling this. There should be code handling CONFIG_CMDLINE_FORCE and
> CONFIG_CMDLINE_EXTEND as well but is absent by now.

I mean the code in drivers/of/fdt.c already handles
CONFIG_CMDLINE_EXTEND and CONFIG_CMDLINE_FORCE, understand?

On the other hand, I found that for non-FDT system
CONFIG_CMDLINE_FORCE indeed doesn't work, but
CONFIG_CMDLINE_BOOTLOADER works, so you needn't fix
CONFIG_CMDLINE_BOOTLOADER, and you need add "goto out" in the "if
(initial_boot_params)" condition.

Huacai
