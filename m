Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D9E5BEDED
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 21:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbiITTiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 15:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiITTiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 15:38:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8705776450;
        Tue, 20 Sep 2022 12:38:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 229EF61726;
        Tue, 20 Sep 2022 19:38:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D102CC433D6;
        Tue, 20 Sep 2022 19:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663702684;
        bh=/9VjVxNPbgZ64WNFIuwFPPUYvGwnqRTbDbRVQI10Yw8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OZrmOUuSS8sNPVz7/Y+8G/MvWPOwGM/X56t3qbH18Ka9HpWaCzGZNQCAm2lndXvWJ
         ZG6rSowN5Qjqfi6U4h+FUqUcf4ka43xjmMsBs9+rMasvE2SOkwwrzr66hDfgnDeecl
         GX16T++1ajOHK2vQcD/P4BGq0pQ8JL7Pbfa/PjhiR2zo8ddBz7v/dVKwGJh3vbYOG9
         tnD9G3rQO5psWX82xDq2qagKzWzSCll1B+hs5vDUUgQYIjIAVdQk+cQtFqKWgEKEpc
         dFxIgUhHoHOvpf5ciHQc48NRArq7KVGml2ivTlYiSpFtZlKT8vsQP/IWk/1PyAIZGm
         xOKVF9legaZ9Q==
Date:   Tue, 20 Sep 2022 20:37:57 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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
Subject: Re: [PATCH v4 00/10] Add support for Renesas RZ/Five SoC
Message-ID: <YyoWlSQPWVnkaU+T@spud>
References: <20220920184904.90495-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <YyoSgGlkIB8GMog8@spud>
 <CAMuHMdXfkX-AOusfOn-6fmaJavWWoD1mW8QNqUCUdkHuz=3FsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXfkX-AOusfOn-6fmaJavWWoD1mW8QNqUCUdkHuz=3FsA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 09:24:05PM +0200, Geert Uytterhoeven wrote:
> Hi Conor,
> 
> On Tue, Sep 20, 2022 at 9:20 PM Conor Dooley <conor@kernel.org> wrote:
> > On Tue, Sep 20, 2022 at 07:48:54PM +0100, Prabhakar wrote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > The RZ/Five microprocessor includes a RISC-V CPU Core (AX45MP Single)
> > > 1.0 GHz, 16-bit DDR3L/DDR4 interface. And it also has many interfaces such
> > > as Gbit-Ether, CAN, and USB 2.0, making it ideal for applications such as
> > > entry-class social infrastructure gateway control and industrial gateway
> > > control.
> > >
> > > This patch series adds initial SoC DTSi support for Renesas RZ/Five
> > > (R9A07G043) SoC and updates the bindings for the same. Below is the list
> > > of IP blocks added in the initial SoC DTSI which can be used to boot via
> > > initramfs on RZ/Five SMARC EVK:
> > > - AX45MP CPU
> > > - CPG
> > > - PINCTRL
> > > - PLIC
> > > - SCIF0
> > > - SYSC
> >
> > Ran into one complaint from dtbs_check:
> > arch/riscv/boot/dts/renesas/r9a07g043f01-smarc.dtb: usb-phy@11c50200: '#phy-cells' is a required property
> >         From schema: /home/conor/.local/lib/python3.10/site-packages/dtschema/schemas/phy/phy-provider.yaml
> > arch/riscv/boot/dts/renesas/r9a07g043f01-smarc.dtb: usb-phy@11c70200: '#phy-cells' is a required property
> >         From schema: /home/conor/.local/lib/python3.10/site-packages/dtschema/schemas/phy/phy-provider.yaml
> >
> > Other than that which should be a trivial fix the whole lot looks good
> > to me...
> 
> That's due to the placeholders...

Right, but #phy-cells will be added into the usb-phys once you (plural)
figure out how to integrate with the existing CMO stuff?

> Currently it is not yet a requirement that "make dtbs_check" is warning-free.

I was really hoping that it could be a requirement for 6.1 onwards. I've
managed to clear all of the other ones from arch/riscv.

> I'm wondering how we have to handle new SoCs with existing boards in
> the future. Probably just more properties in the placeholders...

New SoCs to existing boards is less of a problem then new CPUs to
existing SoCs from what I can see...
I know we just discussed it earlier today, but is it possible to make
these particular placeholders more complete so that dtbs_check shuts up
about them?

Thanks,
Conor.

