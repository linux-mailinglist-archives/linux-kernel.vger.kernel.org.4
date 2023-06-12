Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C28772CA87
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239564AbjFLPoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235037AbjFLPoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:44:17 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB8A10CB
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:44:13 -0700 (PDT)
Received: from i53875b22.versanet.de ([83.135.91.34] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1q8ji9-0003ee-29; Mon, 12 Jun 2023 17:44:05 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     guoren@kernel.org, Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-riscv@lists.infradead.org, samuel@sholland.org,
        christoph.muellner@vrull.eu,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] RISC-V: T-Head vector handling
Date:   Mon, 12 Jun 2023 17:44:04 +0200
Message-ID: <2408420.NG923GbCHz@diego>
In-Reply-To: <mhng-ca852a2c-a1c7-4b14-a9a2-f2bd4541d6b7@palmer-ri-x1c9>
References: <mhng-ca852a2c-a1c7-4b14-a9a2-f2bd4541d6b7@palmer-ri-x1c9>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Montag, 12. Juni 2023, 17:29:49 CEST schrieb Palmer Dabbelt:
> On Tue, 14 Mar 2023 22:29:41 PDT (-0700), Palmer Dabbelt wrote:
> > On Tue, 28 Feb 2023 13:54:33 PST (-0800), heiko@sntech.de wrote:
> >> From: Heiko Stuebner <heiko.stuebner@vrull.eu>
> >>
> >> As is widely known the T-Head C9xx cores used for example in the
> >> Allwinner D1 implement an older non-ratified variant of the vector spec.
> >>
> >> While userspace will probably have a lot more problems implementing
> >> support for both, on the kernel side the needed changes are actually
> >> somewhat small'ish and can be handled via alternatives somewhat nicely.
> >>
> >> With this patchset I could run the same userspace program (picked from
> >> some riscv-vector-test repository) that does some vector additions on
> >> both qemu and a d1-nezha board. On both platforms it ran sucessfully and
> >> even produced the same results.
> >>
> >>
> >> As can be seen in the todo list, there are 2 places where the changed
> >> SR_VS location still needs to be handled in the next revision
> >> (assembly + ALTERNATIVES + constants + probably stringify resulted in
> >>  some grey hair so far already)
> >>
> >>
> >> ToDo:
> >> - follow along with the base vector patchset
> >> - handle SR_VS access in _save_context and _secondary_start_sbi
> >>
> >>
> >> Heiko Stuebner (2):
> >>   RISC-V: define the elements of the VCSR vector CSR
> >>   RISC-V: add T-Head vector errata handling
> >>
> >>  arch/riscv/Kconfig.erratas           |  13 +++
> >>  arch/riscv/errata/thead/errata.c     |  32 ++++++
> >>  arch/riscv/include/asm/csr.h         |  31 +++++-
> >>  arch/riscv/include/asm/errata_list.h |  62 +++++++++++-
> >>  arch/riscv/include/asm/vector.h      | 139 +++++++++++++++++++++++++--
> >>  5 files changed, 261 insertions(+), 16 deletions(-)
> >
> > I have no opposition to calling the T-Head vector stuff an errata
> > against V, the RISC-V folks have already made it quite apparent that
> > anything goes here.  I would like to get the standard V uABI sorted out
> > first, though, as there's still a lot of moving pieces there.  It's kind
> > of hard here as T-Head got thrown under the bus, but I'm not sure what
> > else to do about it.
> 
> The V-1.0 support has been merged, so I think we're good to go.  Does 
> someone mind re-spinning this against for-next so it lines up with all 
> the new user interfaces?

glad to hear that. I found the merge message now as well.
Somehow I was only Cc'ed on individual patches but not on the
cover-letter, so didn't realize the merge till now.

I'll try to re-spin and adapt to the changes since the initial submission.

Heiko


 I'll try to re-spin and adapt to the changes that
happened since the original submission.



