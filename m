Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E06461FD38
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbiKGSSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbiKGSSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:18:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD73252AD;
        Mon,  7 Nov 2022 10:17:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0ECCBB815E8;
        Mon,  7 Nov 2022 18:17:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B856CC4347C;
        Mon,  7 Nov 2022 18:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667845034;
        bh=xe7fMo4Kua9n3JiLpB5ttddzY6yu64WGLoSwGcPiCaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vLd3QwnadAoxekjEhecUkcubKyn+7O5Rt7XZQia/an8wm6y9aAtiYEQj0UyUFWl2e
         fApn5rCpI1+Ha7mg3o8TJIyngLDhzU5/H4qZ32MkidfILXPZviAskPnndZvb+jnLvu
         haXFY+DBmHkUi4/Jx1QoW+GXiTOz6NnGuUE9c3W7/SpDiThcV4dYNtp8nFSEmyLhFC
         5C08PbeMoe0R4rxoKr2f1hsPyU4K2W3fjTQaph8ZDKadq8VuQuXUYGTjq91g8qSPxI
         gQ4f0ip6B4ELkYf0GhcfGBTvebMvTSfVL96ITPTfFM9EDTPU7Yj/5NSuKzJK1ebHTO
         LlvI8pC8M+Tbw==
Date:   Mon, 7 Nov 2022 18:17:08 +0000
From:   Conor Dooley <conor@kernel.org>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        geert+renesas@glider.be
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>, Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@rivosinc.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v5 0/7] Add support for Renesas RZ/Five SoC
Message-ID: <Y2lLpCRpTQL+0dsR@spud>
References: <20221028165921.94487-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Y17BWPuEcmY7Bba3@spud>
 <CA+V-a8uKQ8QvYi5qLC9O=QAQN5CxNB7cOTmw4vk+ndB2R8d3nQ@mail.gmail.com>
 <Y17+pHAg/SBJAEXq@spud>
 <CA+V-a8t-niCHSWo_CSRSkPS4ND12DAkiwxWxOM1vNn=oBKKd_w@mail.gmail.com>
 <CA+V-a8utoDSKcZFdtJ0BKwvPfcvf0WVH2Va-Fv_-pKC1FOOVsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+V-a8utoDSKcZFdtJ0BKwvPfcvf0WVH2Va-Fv_-pKC1FOOVsQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 06:03:41PM +0000, Lad, Prabhakar wrote:
> Hi Conor,
> 
> On Sun, Oct 30, 2022 at 11:01 PM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> >
> > Hi Conor,
> >
> > On Sun, Oct 30, 2022 at 10:46 PM Conor Dooley <conor@kernel.org> wrote:
> > >
> > > On Sun, Oct 30, 2022 at 10:37:01PM +0000, Lad, Prabhakar wrote:
> > > > Hi Conor,
> > > >
> > > > On Sun, Oct 30, 2022 at 6:24 PM Conor Dooley <conor@kernel.org> wrote:
> > > > >
> > > > > On Fri, Oct 28, 2022 at 05:59:14PM +0100, Prabhakar wrote:
> > > > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > > >
> > > > > > Hi All,
> > > > > >
> > > > > > The RZ/Five microprocessor includes a RISC-V CPU Core (AX45MP Single)
> > > > > > 1.0 GHz, 16-bit DDR3L/DDR4 interface. And it also has many interfaces such
> > > > > > as Gbit-Ether, CAN, and USB 2.0, making it ideal for applications such as
> > > > > > entry-class social infrastructure gateway control and industrial gateway
> > > > > > control.
> > > > > >
> > > > > > This patch series adds initial SoC DTSi support for Renesas RZ/Five
> > > > > > (R9A07G043) SoC. Below is the list of IP blocks enabled in the initial
> > > > > > board DTS which can be used to boot via initramfs on RZ/Five SMARC EVK:
> > > > > > - AX45MP CPU
> > > > > > - CPG
> > > > > > - PINCTRL
> > > > >
> > > > > Hey,
> > > > > Looks like you've got a pair of warnings here from dtbs_check. I tested
> > > > > this on top of 20221028's next, with the three branches below merged in,
> > > > > hopefully my merges aren't the source of them:
> > > > >
> > > > > linux/arch/riscv/boot/dts/renesas/r9a07g043f01-smarc.dtb: pinctrl@11030000: 'interrupt-controller' is a required property
> > > > >         From schema: Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
> > > > > linux/arch/riscv/boot/dts/renesas/r9a07g043f01-smarc.dtb: pinctrl@11030000: '#interrupt-cells' is a required property
> > > > >         From schema: linux/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
> > > > >
> > > > Thanks for the review and test. The warnings above are coming from [0]
> > > > as support for IRQC is missing, once that is added the warnings should
> > > > go away.
> > >
> > > Right. I merged in the stuff in Geert's trees & I don't think I saw any
> > > pending patches in the cover that I missed. Is there something else that
> > > adds the support that's not going to make v6.2? I got rid of all the
> > > dtbs_check warnings for v6.1 and I'd really like to keep things that
> > > way!
> > >
> > Sorry that pacth wasn't posted yet so I hadn't mentioned it in the
> > cover letter. I'll make sure I get it posted asap and merged for v6.2.
> >
> I have got the patches out [0] which will fix the warnings seen above.

Cool, thanks :)

> 
> BTW on the riscv patchwork I see status as fail "Patch does not apply
> to for-next" does that mean I need to resend re-basing on your tree?

Nah, I though that Geert would be applying this patchset, no?
If that's the case, it only needs to apply to his tree.

Geert, are you waiting for an ack from Palmer?

> [0] https://patchwork.kernel.org/project/linux-renesas-soc/cover/20221107175305.63975-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> 
> Cheers,
> Prabhakar
