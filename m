Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA2B637F98
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 20:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiKXTSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 14:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiKXTSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 14:18:31 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB9A623B5;
        Thu, 24 Nov 2022 11:18:29 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id vp12so4671202ejc.8;
        Thu, 24 Nov 2022 11:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kWoRrNDgHDvAiElkaM9ey/BkEhFNRR4kcdpp5ftZc90=;
        b=G6I0pdiG9+FJ7AxQvCRN/NCC8/HyD532a5M1tG0c8SFT1MMsNlNonirbr35ya3fR3r
         iLSMHGD9O6zi6qyr7i52EQSIUFiCNdRI8IEDO38DEu9lI7EQ/gUlC1SAmbfWV69Q59Gj
         3fSriUJ0BIPNLg6zDRx5PFXqzZekfhMX8hYdMoR3mVXpe6HBFBbOGFizMVwAdwqQ5Yl0
         Wd63uFtzx7e1A7Hb1bCKue9IybJXneMGgvlDbGBDzbzVIzYYowCZ47pCvtFmrjOJXbJo
         Xwqd8OQEkiB+25DrGT6GycGV/WF/HqgGXqXEX+7VnF/GNai1+R51464iBbVlLnem2Juh
         ASHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kWoRrNDgHDvAiElkaM9ey/BkEhFNRR4kcdpp5ftZc90=;
        b=PFVms1/wJH3wZKjM+edKyIvstxZIzbu5OD3w+sz7dQUcUkhskiZq1TZmtNKd0P5gqY
         cTv2k8yMPoTCkkOCJNyKM6+280tJBtERfoViKecnGAVeLWU04zK3gTzE0OIHg9ueYukT
         K+xj7m7J2jPm+27lDK/4l4bqxdKz4CvODR1Ix/wZj3sm+iOYItfWag57ZG2x3ojWereb
         NsBFAmG0IgK2aS6bm7suxbHZfJO1wYH+T41XLbaP7s34PH6sDicMEMfZe4FkK6jqwqeQ
         d6EhOlP2UVsHgvhT7hh3gX8XnyPFGhOV+zi81P+aLR+ZsBtsERoIiO9iyN7Ia+A1ZNCg
         nW2w==
X-Gm-Message-State: ANoB5pnseS8j1iDoR7ZU0pUdz6QDAmrLURDshZIiAEpq32mCdIBtbHF0
        1MYW2V0cRNrToKHw8aJJ7h64BTJI7ONruOvHA4E=
X-Google-Smtp-Source: AA0mqf4WrZ/GykWiZqfe3oroUEIfEHqNDi9z0Lnip9PJsnUGxVHzil2Hb+kFxbeVynw2bI+m/BgujuTA2L1DS5ybuk8=
X-Received: by 2002:a17:906:560c:b0:7ae:5884:81b1 with SMTP id
 f12-20020a170906560c00b007ae588481b1mr14232995ejq.155.1669317508056; Thu, 24
 Nov 2022 11:18:28 -0800 (PST)
MIME-Version: 1.0
References: <20221124172207.153718-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221124172207.153718-6-prabhakar.mahadev-lad.rj@bp.renesas.com> <3689906.Lt9SDvczpP@diego>
In-Reply-To: <3689906.Lt9SDvczpP@diego>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 24 Nov 2022 19:18:01 +0000
Message-ID: <CA+V-a8uQh=q8ksTe8ttHkJThcoYtggSU-AXUqPGYnam0CiqZWw@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] riscv: mm: dma-noncoherent: Pass direction and
 operation to ALT_CMO_OP()
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

Thank you for the review.

On Thu, Nov 24, 2022 at 6:29 PM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Am Donnerstag, 24. November 2022, 18:22:05 CET schrieb Prabhakar:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Pass direction and operation to ALT_CMO_OP() macro.
> >
> > This is in preparation for adding errata for the Andes CPU core.
>
> can you provide more explanation why that is necessary please?
> I guess you want to use different cache operations for some cases?
>
Yes basically to call different cache operations based on the dir and
operations (and also this allows to export just one function to handle
the errata). I'll update the commit message in the next version.

Cheers,
Prabhakar
