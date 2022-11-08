Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA67621D03
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 20:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiKHT3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 14:29:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKHT3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 14:29:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EAF62E9;
        Tue,  8 Nov 2022 11:29:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 214EF6175D;
        Tue,  8 Nov 2022 19:29:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54715C433D6;
        Tue,  8 Nov 2022 19:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667935751;
        bh=nG53Ngx8dZxQ0QPTeQv9gyI7E0KrRpZ8mTEGFAPa2Bc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CQG4SOZWhO7Jaszq6PVDU7ix/7bZ7v8dy1GPwsNtoN/+u2l4CRoEO9BoBVBxntrT5
         5LH6IZjVnaxhnJLlILQn8+aMX7U1+RSlyWYzBWQ94BuDZWwgEyPgCdtGgngP6HcnzA
         yRbEvaZR+F97w5exFjB7jiNUcPHXUHZRBlPuzwSOOGBYFFB79JydSERhKWJYPHsymt
         mNt0s5CtcsNKVDhuqZs+0LG2LRTjfDKwh/81rUNhjs4lYJQD1Qlmai/w0NZ7wLVFdI
         OqU+mM8pliwA9ehKOS1qQAw4nNmKiBGuzDMTOMeca1MK06ZSXfydY7I/PiZsYadz0F
         hg6qZF/XhPo2g==
Date:   Tue, 8 Nov 2022 19:29:04 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
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
Message-ID: <Y2quAB1zSGAvOFzD@spud>
References: <20221028165921.94487-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Y17BWPuEcmY7Bba3@spud>
 <CA+V-a8uKQ8QvYi5qLC9O=QAQN5CxNB7cOTmw4vk+ndB2R8d3nQ@mail.gmail.com>
 <Y17+pHAg/SBJAEXq@spud>
 <CA+V-a8t-niCHSWo_CSRSkPS4ND12DAkiwxWxOM1vNn=oBKKd_w@mail.gmail.com>
 <CA+V-a8utoDSKcZFdtJ0BKwvPfcvf0WVH2Va-Fv_-pKC1FOOVsQ@mail.gmail.com>
 <Y2lLpCRpTQL+0dsR@spud>
 <CAMuHMdXjZGTNM7pUqxwXd08bjuPEFUuUwKFGx01FVCqOGnc6hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXjZGTNM7pUqxwXd08bjuPEFUuUwKFGx01FVCqOGnc6hQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 05:02:57PM +0100, Geert Uytterhoeven wrote:
> Hi Conor,
> On Mon, Nov 7, 2022 at 7:17 PM Conor Dooley <conor@kernel.org> wrote:
> > Geert, are you waiting for an ack from Palmer?
> 
> I can take:
>   - [PATCH v5 4/7] riscv: dts: renesas: Add initial devicetree for
> Renesas RZ/Five SoC
>   - [PATCH v5 5/7] riscv: dts: renesas: Add minimal DTS for Renesas
> RZ/Five SMARC EVK
>   - [PATCH v5 6/7] MAINTAINERS: Add entry for Renesas RISC-V
> (4/7 and 5/7 depend on my renesas-arm-dt-for-v6.2 branch) and funnel
> them to the SoC-people.
> 
> I can take
>   - [PATCH v5 3/7] riscv: Kconfig.socs: Add ARCH_RENESAS kconfig option
>   - [PATCH v5 7/7] riscv: configs: defconfig: Enable Renesas RZ/Five SoC
> with an ack from Palmer.
> 
> The rest
>   - [PATCH v5 1/7] dt-bindings: riscv: Sort the CPU core list alphabetically
>   - [PATCH v5 2/7] dt-bindings: riscv: Add Andes AX45MP core to the list
> should probably go through the riscv tree, to avoid merge conflicts
> when support for other SoCs is added?

Or depending on the outcome of [0], maybe I take the dt-binding stuff?

Either way, looks like an ack from Palmer is needed for 3 & 7. I can do
the video call version of a ping on that tomorrow at the pw sync thing.

[0] - https://lore.kernel.org/linux-riscv/Y2puchRvbo6+YJSy@wendy/T/#me49f1e779dee210d3ab6fc4bc308dbaed036e1a8
