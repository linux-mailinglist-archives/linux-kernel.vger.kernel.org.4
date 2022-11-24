Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2EF1637FF9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 20:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiKXT7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 14:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiKXT7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 14:59:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E4160F1;
        Thu, 24 Nov 2022 11:59:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5EA26223C;
        Thu, 24 Nov 2022 19:59:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFFBFC433D6;
        Thu, 24 Nov 2022 19:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669319955;
        bh=bFLQXR8VH88R8kmhqGLzNuOD6udDTK9anm5yIMqU7K0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ciuuASn+jApzGYUVqVuWHFW0ijSsRop/fx9htFcDBI1fHoxPYyvwhoFf3lOQEutwE
         CIIjNVRswXuRM903adij7HNVDNrafVLc5btC8Tel1u5kdDCV4vsqE9hT7wx9tPimxb
         zlUX6eh0fepFH/A/dC7Qhj+27sjcSwUbXFDVotDHr2iOKxpaXnu0W7gMjqLWisJzzg
         fI8CWIVxerdn2oscsw+o8/dQL4+crnBK5TNlXJhHcPdjY0aKs4etonWZeKmZfjMKaf
         f1gkaNrFD/LXK78XTdVk9SUK+NaRVQrSFZ+hY7Ln9cpVyPF2xN9MuQ3icEihVbkqsE
         u5LV2rTzsKaDQ==
Date:   Thu, 24 Nov 2022 19:59:04 +0000
From:   Conor Dooley <conor@kernel.org>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
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
Subject: Re: [PATCH v4 0/7] AX45MP: Add support to non-coherent DMA
Message-ID: <Y3/NCKqNoN/yIsDw@spud>
References: <20221124172207.153718-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Y3/I4KzHnzyPo1Fe@spud>
 <CA+V-a8viAfvLnScDKADpKMRqNEaMdhf5kA1GqAdgaGAEo+XpBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+V-a8viAfvLnScDKADpKMRqNEaMdhf5kA1GqAdgaGAEo+XpBQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 07:52:28PM +0000, Lad, Prabhakar wrote:

> Hmm that looks interesting! I'll give that a shot with the latest tool-chain.
> 
> BTW is there a link to get the latest toolchain?

Uhh, I just build mine from https://github.com/riscv-collab/riscv-gnu-toolchain
Arnd puts toolchains here: https://mirrors.edge.kernel.org/pub/tools/crosstool/
I've never used one though!

> Oops I missed to mention the dependency here we need patches from [0]
> . Just patches 1-5 should be sufficient for this build (as including
> patch 6/7 gave me a build issue).
> 
> [0] https://patchwork.kernel.org/project/linux-riscv/cover/20221110164924.529386-1-heiko@sntech.de/

Ah right. I kinda figured that with the "don't review this" patch that
you'd pulled all of the deps into it.

