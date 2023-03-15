Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A396BA7D1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 07:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjCOGbZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 15 Mar 2023 02:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjCOGbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 02:31:23 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CED61A88
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 23:31:21 -0700 (PDT)
Received: from ip4d1634a9.dynamic.kabel-deutschland.de ([77.22.52.169] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pcKfD-0006gF-TQ; Wed, 15 Mar 2023 07:31:07 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-riscv@lists.infradead.org, samuel@sholland.org,
        guoren@kernel.org, christoph.muellner@vrull.eu,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] RISC-V: T-Head vector handling
Date:   Wed, 15 Mar 2023 07:31:05 +0100
Message-ID: <3344603.e9J7NaK4W3@phil>
In-Reply-To: <mhng-6d6a325c-4adb-4d9a-98a0-012c75b4562e@palmer-ri-x1c9a>
References: <mhng-6d6a325c-4adb-4d9a-98a0-012c75b4562e@palmer-ri-x1c9a>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer,

Am Mittwoch, 15. März 2023, 06:29:41 CET schrieb Palmer Dabbelt:
> On Tue, 28 Feb 2023 13:54:33 PST (-0800), heiko@sntech.de wrote:
> > From: Heiko Stuebner <heiko.stuebner@vrull.eu>
> >
> > As is widely known the T-Head C9xx cores used for example in the
> > Allwinner D1 implement an older non-ratified variant of the vector spec.
> >
> > While userspace will probably have a lot more problems implementing
> > support for both, on the kernel side the needed changes are actually
> > somewhat small'ish and can be handled via alternatives somewhat nicely.
> >
> > With this patchset I could run the same userspace program (picked from
> > some riscv-vector-test repository) that does some vector additions on
> > both qemu and a d1-nezha board. On both platforms it ran sucessfully and
> > even produced the same results.
> >
> >
> > As can be seen in the todo list, there are 2 places where the changed
> > SR_VS location still needs to be handled in the next revision
> > (assembly + ALTERNATIVES + constants + probably stringify resulted in
> >  some grey hair so far already)
> >
> >
> > ToDo:
> > - follow along with the base vector patchset
> > - handle SR_VS access in _save_context and _secondary_start_sbi
> >
> >
> > Heiko Stuebner (2):
> >   RISC-V: define the elements of the VCSR vector CSR
> >   RISC-V: add T-Head vector errata handling
> >
> >  arch/riscv/Kconfig.erratas           |  13 +++
> >  arch/riscv/errata/thead/errata.c     |  32 ++++++
> >  arch/riscv/include/asm/csr.h         |  31 +++++-
> >  arch/riscv/include/asm/errata_list.h |  62 +++++++++++-
> >  arch/riscv/include/asm/vector.h      | 139 +++++++++++++++++++++++++--
> >  5 files changed, 261 insertions(+), 16 deletions(-)
> 
> I have no opposition to calling the T-Head vector stuff an errata 
> against V, the RISC-V folks have already made it quite apparent that 
> anything goes here.  I would like to get the standard V uABI sorted out 
> first, though, as there's still a lot of moving pieces there.

yeah, that's the reason the series is an RFC and is based on the main
vector series and I fully expect the main support to land first :-) .


> It's kind 
> of hard here as T-Head got thrown under the bus, but I'm not sure what 
> else to do about it.

Thankfully on the kernel-side the differences to implemeent both "at the
same time" are not that huge - userspace of course will need to figure
out their own solution.


Heiko


