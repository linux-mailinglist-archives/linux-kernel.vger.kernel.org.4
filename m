Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D7D628A0D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 21:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236559AbiKNUDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 15:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235591AbiKNUDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 15:03:14 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3763AC;
        Mon, 14 Nov 2022 12:03:13 -0800 (PST)
Received: from falcon9.localnet (mtl.collabora.ca [66.171.169.34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: detlev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 312D36602995;
        Mon, 14 Nov 2022 20:03:11 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668456191;
        bh=Tkp7ehIKGRuqX0jDN9TZfE/Yp51dOxCKo9eY01jcmpk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ebYEkhh0l9uin9YobUDe616Ui1uJWyuBXxE2xG7+dQz4LPYONsjqh+0NKaeHTMiAc
         Uwsg+CGOvB/vEQj6V3Y0kh+kRvQfWleuTf0+9gj9/jp59AUV5htZPB1u/Om565Hh2Z
         wBqpHXXo3aZCub44V9pH0ohgYMKfk7OLqi4LelYwRqdXNr3NymHZ8hulaVRY0co+y3
         86MwZ3zKB8MbDuFkCAfiVb+kwJCyt/281t0gO9fACJaC/T1JunBb0IJ42sP58OD9Cy
         CK2/aET5ZRFUR/FqE73uROcgxBEFM1WHu+ldmJUPT0tjvPUg20Hqcap3fBdg52U/PT
         I0HE1sJvQmcHw==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list:ARM/RENESAS ARCHITECTURE" 
        <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: renesas: r8a77951: Add reserved memory region
Date:   Mon, 14 Nov 2022 15:03:07 -0500
Message-ID: <12113751.O9o76ZdvQC@falcon9>
In-Reply-To: <CAMuHMdW9dAxJwzD=W1xLN2e_T_BNFk5MfbWh24Btur-o+-n4sg@mail.gmail.com>
References: <20221114194846.108814-1-detlev.casanova@collabora.com> <CAMuHMdW9dAxJwzD=W1xLN2e_T_BNFk5MfbWh24Btur-o+-n4sg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, November 14, 2022 2:57:21 P.M. EST Geert Uytterhoeven wrote:
> Hi Detlev,
> 
> On Mon, Nov 14, 2022 at 8:48 PM Detlev Casanova
> 
> <detlev.casanova@collabora.com> wrote:
> > The 0x3000000 bytes memory region starting at 0x54000000 is
> > reserved for the lossy_decompression hardware that will try to
> > decompress any data written in the region.
> > 
> > Mark the region as no-map to prevent linux from using it as RAM.
> > 
> > Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> 
> Thanks for your patch!
> 
> > --- a/arch/arm64/boot/dts/renesas/r8a77951.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/r8a77951.dtsi
> > @@ -290,6 +290,18 @@ CPU_SLEEP_1: cpu-sleep-1 {
> > 
> >                 };
> >         
> >         };
> > 
> > +       reserved-memory {
> > +               #address-cells = <2>;
> > +               #size-cells = <2>;
> > +               ranges;
> > +
> > +               /* device specific region for Lossy Decompression */
> > +               lossy_decompress: memory-region@54000000 {
> > +                       no-map;
> > +                       reg = <0x00000000 0x54000000 0x0 0x03000000>;
> > +               };
> > +       };
> 
> This depends on the firmware/boot loader stack.  If it configures a
> Lossy Decompression region, it should make sure to pass this
> info through the various boot loader components to Linux,
> just like is already done with the memory regions, RPC-IF state,
> and OpTee configuration.

Thanks for your fast answer ! I didn't realise ATF was doing that, I probably 
have a configuration issue in ATF then, I'll rebuild and start from there.

Thanks !

> Gr{oetje,eeting}s,
> 
>                         Geert



