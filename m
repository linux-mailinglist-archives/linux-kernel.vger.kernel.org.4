Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD8D68FB27
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 00:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjBHX1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 18:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjBHX06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 18:26:58 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEB2BBA5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 15:26:53 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pPtpy-0003au-UI; Thu, 09 Feb 2023 00:26:50 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     palmer@rivosinc.com, Conor Dooley <conor@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        christoph.muellner@vrull.eu, ajones@ventanamicro.com
Subject: Re: [PATCH 1/2] RISC-V: fix ordering of Zbb extension
Date:   Thu, 09 Feb 2023 00:26:50 +0100
Message-ID: <2135493.irdbgypaU6@diego>
In-Reply-To: <C32D5495-F772-4887-9CAD-66206ECCFC3F@kernel.org>
References: <20230208225328.1636017-1-heiko@sntech.de>
 <20230208225328.1636017-2-heiko@sntech.de>
 <C32D5495-F772-4887-9CAD-66206ECCFC3F@kernel.org>
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

Am Donnerstag, 9. Februar 2023, 00:20:10 CET schrieb Conor Dooley:
> Hey Heiko,
> 
> On 8 February 2023 22:53:27 GMT, Heiko Stuebner <heiko@sntech.de> wrote:
> >From: Heiko Stuebner <heiko.stuebner@vrull.eu>
> >
> >As Andrew reported,
> >    Zb* comes after Zi* according 27.11 "Subset Naming Convention"
> >so fix the ordering accordingly.
> >
> >Reported-by: Andrew Jones <ajones@ventanamicro.com>
> >Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> 
> The whole "getting it wrong immediately after fixing it up" ;)
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

I'm still hopefully that I'll learn at some point that "b" comes after "i",
at least with riscv extensions. Decades of sorting the other way around are
hard to break :-D .

> >---
> > arch/riscv/kernel/cpu.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> >index 420228e219f7..8400f0cc9704 100644
> >--- a/arch/riscv/kernel/cpu.c
> >+++ b/arch/riscv/kernel/cpu.c
> >@@ -185,9 +185,9 @@ arch_initcall(riscv_cpuinfo_init);
> >  * New entries to this struct should follow the ordering rules described above.
> >  */
> > static struct riscv_isa_ext_data isa_ext_arr[] = {
> >-	__RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
> > 	__RISCV_ISA_EXT_DATA(zicbom, RISCV_ISA_EXT_ZICBOM),
> > 	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
> >+	__RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
> > 	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
> > 	__RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
> > 	__RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
> 




