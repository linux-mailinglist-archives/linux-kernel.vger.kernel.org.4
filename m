Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC356101FF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 21:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236702AbiJ0Txe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 15:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236692AbiJ0Txc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 15:53:32 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810D886802
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 12:53:29 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oo8wL-0002tI-AN; Thu, 27 Oct 2022 21:53:21 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     atishp@atishpatra.org, anup@brainfault.org,
        Will Deacon <will@kernel.org>, mark.rutland@arm.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Conor.Dooley@microchip.com,
        samuel@sholland.org
Subject: Re: [PATCH v6 0/2] riscv_pmu_sbi: add support for PMU variant on T-Head C9xx cores
Date:   Thu, 27 Oct 2022 21:53:20 +0200
Message-ID: <3621249.aeNJFYEL58@diego>
In-Reply-To: <mhng-0bf8c154-76ce-4cd3-bfdb-ffd8a4670600@palmer-ri-x1c9>
References: <mhng-0bf8c154-76ce-4cd3-bfdb-ffd8a4670600@palmer-ri-x1c9>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 27. Oktober 2022, 07:02:59 CEST schrieb Palmer Dabbelt:
> On Tue, 11 Oct 2022 16:18:39 PDT (-0700), heiko@sntech.de wrote:
> > The PMU on T-Head C9xx cores is quite similar to the SSCOFPMF extension
> > but not completely identical, so this series
> 
> The rest of that sentance got dropped, so I put in
> 
>     The PMU on T-Head C9xx cores is quite similar to the SSCOFPMF extension
>     but not completely identical, so this series adds a T-Head PMU errata
>     that handlen the differences.
> 
> but LMK if you had a better version, it's still early so I don't mind 
> swapping it around.

sounds just fine and sorry for not finishing that sentence on my own.


> b4 also got kind of confused here so I had to merge suff manually.

do you still know what b4 complained about?

My patch workflow is pretty basic (git format-patch + separate
git send-email) so I guess it might be interesting what it was
stumbling on.

Thanks
Heiko


> > changes in v6:
> > - follow Anup's suggestion and hook into the (pending) cpuinfo patch [2]
> >   instead of modifying the core sbi_get_* functions
> >
> > changes in v5:
> > - add received Reviews
> > - fix sbi caching wrt. negative values (Drew)
> > - add comment about specific c9xx arch- and imp-ids (Conor)
> >
> > changes in v4:
> > - add new patch to cache sbi mvendor, march and mimp-ids (Atish)
> > - errata dependencies in one line (Conor)
> > - make driver detection conditional on CONFIG_ERRATA_THEAD_PMU too (Atish)
> >
> > changes in v3:
> > - improve commit message (Atish, Conor)
> > - IS_ENABLED and BIT() in errata probe (Conor)
> >
> > The change depends on my cpufeature/t-head errata probe cleanup series [1].
> >
> >
> > changes in v2:
> > - use alternatives for the CSR access
> > - make the irq num selection a bit nicer
> >
> > There is of course a matching opensbi-part whose most recent implementation
> > can be found on [0].
> >
> >
> > [0] https://patchwork.ozlabs.org/project/opensbi/cover/20221004164227.1381825-1-heiko@sntech.de
> > [1] https://lore.kernel.org/all/20220905111027.2463297-1-heiko@sntech.de/
> > [2] https://lore.kernel.org/r/20220727043829.151794-1-apatel@ventanamicro.com
> >
> > Heiko Stuebner (2):
> >   RISC-V: Cache SBI vendor values
> >   drivers/perf: riscv_pmu_sbi: add support for PMU variant on T-Head
> >     C9xx cores
> >
> >  arch/riscv/Kconfig.erratas           | 13 +++++++++++
> >  arch/riscv/errata/thead/errata.c     | 19 ++++++++++++++++
> >  arch/riscv/include/asm/errata_list.h | 16 ++++++++++++-
> >  arch/riscv/include/asm/sbi.h         |  5 ++++
> >  arch/riscv/kernel/cpu.c              | 30 +++++++++++++++++++++---
> >  drivers/perf/riscv_pmu_sbi.c         | 34 ++++++++++++++++++++--------
> >  6 files changed, 103 insertions(+), 14 deletions(-)
> 




