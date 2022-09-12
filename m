Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E76D5B61FF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 22:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiILUEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 16:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiILUET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 16:04:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5074F481ED
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 13:04:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4BCF61272
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 20:04:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4065C433D6;
        Mon, 12 Sep 2022 20:04:14 +0000 (UTC)
Date:   Mon, 12 Sep 2022 21:04:10 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Peter Collingbourne <pcc@google.com>
Cc:     Evgenii Stepanov <eugenis@google.com>,
        Kenny Root <kroot@google.com>, Marc Zyngier <maz@kernel.org>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v4] arm64: mte: move register initialization to C
Message-ID: <Yx+QutrpakTEyRjW@arm.com>
References: <20220907003630.1115439-1-eugenis@google.com>
 <CAMn1gO4X93khAqOOvCJjWmm410rv8S5847GfsPckJwqtLSzc-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMn1gO4X93khAqOOvCJjWmm410rv8S5847GfsPckJwqtLSzc-Q@mail.gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 05:54:13PM -0700, Peter Collingbourne wrote:
> On Tue, Sep 6, 2022 at 5:36 PM Evgenii Stepanov <eugenis@google.com> wrote:
> > If FEAT_MTE2 is disabled via the arm64.nomte command line argument on a
> > CPU that claims to support FEAT_MTE2, the kernel will use Tagged Normal
> > in the MAIR. If we interpret arm64.nomte to mean that the CPU does not
> > in fact implement FEAT_MTE2, setting the system register like this may
> > lead to UNSPECIFIED behavior. Fix it by arranging for MAIR to be set
> > in the C function cpu_enable_mte which is called based on the sanitized
> > version of the system register.
> >
> > There is no need for the rest of the MTE-related system register
> > initialization to happen from assembly, with the exception of TCR_EL1,
> > which must be set to include at least TBI1 because the secondary CPUs
> > access KASan-allocated data structures early. Therefore, make the TCR_EL1
> > initialization unconditional and move the rest of the initialization to
> > cpu_enable_mte so that we no longer have a dependency on the unsanitized
> > ID register value.
> 
> Moving the register initialization to C also fixes a bug where the
> kernel's zeroing of TFSR_EL1 has no practical effect when the kernel
> is started in VHE mode because the register is currently being zeroed
> prior to the kernel enabling the redirect of TFSR_EL2 to TFSR_EL1 when
> it enables VHE. As a result, without this patch it is possible to get
> a spurious KASAN error report if TFSR_EL2 is non-zero out of reset.

Oh, I think this is a side-effect of the nVHE patches. We added MTE in
5.10 and __cpu_setup() was called at EL2 if the kernel was entered at
EL2 - 3b714d24ef17 ("arm64: mte: CPU feature detection and initial
sysreg configuration"). When nVHE turned up in 5.12, this was changed to
to run __cpu_setup at EL1 and this only initialises TFSR_EL1.
__finalise_el2 should have transferred TFSR_EL12.

I don't think there other registers we missed in __cpu_setup() but I
haven't looked in detail.

So for this, we either move the reg initialisation to C or we fix
__finalise_el2. I'm tempted to go with the former as long as the kernel
doesn't read that register up to that point and complain of a spurious
asynchronous fault.

-- 
Catalin
