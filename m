Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B6F5F9EF3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 14:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbiJJMzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 08:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbiJJMzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 08:55:17 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE07A39BB8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 05:55:11 -0700 (PDT)
Received: from p5b1274fa.dip0.t-ipconnect.de ([91.18.116.250] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1ohsJ1-0001uf-PC; Mon, 10 Oct 2022 14:54:51 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     atishp@atishpatra.org, anup@brainfault.org, will@kernel.org,
        mark.rutland@arm.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Conor.Dooley@microchip.com,
        ajones@ventanamicro.com
Subject: Re: [PATCH v5 1/2] RISC-V: Cache SBI vendor values
Date:   Mon, 10 Oct 2022 14:54:50 +0200
Message-ID: <7864901.lvqk35OSZv@phil>
In-Reply-To: <CAK9=C2VHPBgL208ZHb78Nab1dQjfF6tZuKTRRT5V=vnvfODEGw@mail.gmail.com>
References: <20221010122726.2405153-1-heiko@sntech.de> <20221010122726.2405153-2-heiko@sntech.de> <CAK9=C2VHPBgL208ZHb78Nab1dQjfF6tZuKTRRT5V=vnvfODEGw@mail.gmail.com>
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

Am Montag, 10. Oktober 2022, 14:45:45 CEST schrieb Anup Patel:
> On Mon, Oct 10, 2022 at 5:57 PM Heiko Stuebner <heiko@sntech.de> wrote:
> >
> > sbi_get_mvendorid(), sbi_get_marchid() and sbi_get_mimpid() might get
> > called multiple times, though the values of these CSRs should not change
> > during the runtime of a specific machine.
> >
> > So cache the values in the functions and prevent multiple ecalls
> > to read these values.
> >
> > As Andrew Jones noted, at least marchid and mimpid may be negative
> > values when viewed as a long, so we use a separate static bool to
> > indiciate the cached status.
> >
> > Suggested-by: Atish Patra <atishp@atishpatra.org>
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> >  arch/riscv/kernel/sbi.c | 30 +++++++++++++++++++++++++++---
> >  1 file changed, 27 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> > index 775d3322b422..cc618aaa9d11 100644
> > --- a/arch/riscv/kernel/sbi.c
> > +++ b/arch/riscv/kernel/sbi.c
> > @@ -625,17 +625,41 @@ static inline long sbi_get_firmware_version(void)
> >
> >  long sbi_get_mvendorid(void)
> >  {
> > -       return __sbi_base_ecall(SBI_EXT_BASE_GET_MVENDORID);
> > +       static long id;
> > +       static bool cached;
> > +
> > +       if (!cached) {
> > +               id = __sbi_base_ecall(SBI_EXT_BASE_GET_MVENDORID);
> > +               cached = true;
> > +       }
> > +
> > +       return id;
> >  }
> >
> >  long sbi_get_marchid(void)
> >  {
> > -       return __sbi_base_ecall(SBI_EXT_BASE_GET_MARCHID);
> > +       static long id;
> > +       static bool cached;
> 
> This breaks for heterogeneous SMP systems (similar to big.LITTLE)
> where HARTs will have different marchid even though they belong to
> same CPU Vendor.
> 
> Due to the above rationale, the patch adding marchid, mvendorid, and
> mimpid in /proc/cpuinfo caches these values on a per-CPU basis.

For people reading along, I think you mean
https://lore.kernel.org/r/20220727043829.151794-1-apatel@ventanamicro.com

For my understanding, was there a reason in the past for doing the caching
only for cpuinfo and not for every invocation of the ecalls?


Thanks
Heiko


