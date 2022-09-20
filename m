Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD685BED99
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 21:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbiITTYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 15:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiITTYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 15:24:22 -0400
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D08027FE6;
        Tue, 20 Sep 2022 12:24:19 -0700 (PDT)
Received: by mail-qv1-f45.google.com with SMTP id y9so2782289qvo.4;
        Tue, 20 Sep 2022 12:24:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=yysm/muSvmUqRZUlhuFzQOUXKN32lBic33bRnAUB65A=;
        b=TZaReT3idjc95k14UNpI7XrpdRriIprYwK814rCNUKrn9+61GdakSoRrv+r8ZpxOt7
         N7+YL7OBJq+LsX04yy8CBuULEvmWpIDihsXu4T2fdJbJ0oLtQUVBFJvebhAzY+ea4wXv
         2oJfwsxeZyJBk5LUVX0fp1xaHobmlKQKjCE/hXNa75p+6bqzguLbWeozkgO8S+1jzeET
         DAJH/bzaAcmhOtK7XmC6GyjfNL12futE05NN7nMoX0bRDYG4eHRuA1g8B7nFTgHVjQpX
         zmgMlJjfHdEj4IhnipnpUQ3D6S+X654y8cHNNsE80M9L3FIatZHnU+A7MuHVdoCeZuIL
         xuDg==
X-Gm-Message-State: ACrzQf37HBiATfSMxWWvg7Uj2wc9VUSGfRCbmWnhIFhZ+RdI7bjO6/Ej
        gUWPKfLKdYbYNilxF1acML0oNYtxmUURaA==
X-Google-Smtp-Source: AMsMyM5bWF08qQCCpwdUQs/NFmMSjEXtHGTRIcs0f8E9NJDFjaWjvGwgJQDjNGQv14SYbdzvnuc5TA==
X-Received: by 2002:ad4:5bcd:0:b0:4ad:2fc4:6571 with SMTP id t13-20020ad45bcd000000b004ad2fc46571mr12945010qvt.103.1663701858395;
        Tue, 20 Sep 2022 12:24:18 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id h22-20020a05622a171600b0035ba366cc90sm368019qtk.15.2022.09.20.12.24.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 12:24:17 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 125so4823836ybt.12;
        Tue, 20 Sep 2022 12:24:17 -0700 (PDT)
X-Received: by 2002:a25:8e84:0:b0:696:466c:baa with SMTP id
 q4-20020a258e84000000b00696466c0baamr19432910ybl.604.1663701857015; Tue, 20
 Sep 2022 12:24:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220920184904.90495-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <YyoSgGlkIB8GMog8@spud>
In-Reply-To: <YyoSgGlkIB8GMog8@spud>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 20 Sep 2022 21:24:05 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXfkX-AOusfOn-6fmaJavWWoD1mW8QNqUCUdkHuz=3FsA@mail.gmail.com>
Message-ID: <CAMuHMdXfkX-AOusfOn-6fmaJavWWoD1mW8QNqUCUdkHuz=3FsA@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] Add support for Renesas RZ/Five SoC
To:     Conor Dooley <conor@kernel.org>
Cc:     Prabhakar <prabhakar.csengg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Atish Patra <atishp@rivosinc.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On Tue, Sep 20, 2022 at 9:20 PM Conor Dooley <conor@kernel.org> wrote:
> On Tue, Sep 20, 2022 at 07:48:54PM +0100, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > The RZ/Five microprocessor includes a RISC-V CPU Core (AX45MP Single)
> > 1.0 GHz, 16-bit DDR3L/DDR4 interface. And it also has many interfaces such
> > as Gbit-Ether, CAN, and USB 2.0, making it ideal for applications such as
> > entry-class social infrastructure gateway control and industrial gateway
> > control.
> >
> > This patch series adds initial SoC DTSi support for Renesas RZ/Five
> > (R9A07G043) SoC and updates the bindings for the same. Below is the list
> > of IP blocks added in the initial SoC DTSI which can be used to boot via
> > initramfs on RZ/Five SMARC EVK:
> > - AX45MP CPU
> > - CPG
> > - PINCTRL
> > - PLIC
> > - SCIF0
> > - SYSC
>
> Ran into one complaint from dtbs_check:
> arch/riscv/boot/dts/renesas/r9a07g043f01-smarc.dtb: usb-phy@11c50200: '#phy-cells' is a required property
>         From schema: /home/conor/.local/lib/python3.10/site-packages/dtschema/schemas/phy/phy-provider.yaml
> arch/riscv/boot/dts/renesas/r9a07g043f01-smarc.dtb: usb-phy@11c70200: '#phy-cells' is a required property
>         From schema: /home/conor/.local/lib/python3.10/site-packages/dtschema/schemas/phy/phy-provider.yaml
>
> Other than that which should be a trivial fix the whole lot looks good
> to me...

That's due to the placeholders...

Currently it is not yet a requirement that "make dtbs_check" is warning-free.
I'm wondering how we have to handle new SoCs with existing boards in
the future. Probably just more properties in the placeholders...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
