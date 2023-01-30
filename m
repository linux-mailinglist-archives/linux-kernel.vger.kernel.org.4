Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6E0681BB1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 21:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjA3Uni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 15:43:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjA3Unf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 15:43:35 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A2BA26849
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 12:43:31 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 5164992009C; Mon, 30 Jan 2023 21:43:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 4A95792009B;
        Mon, 30 Jan 2023 20:43:28 +0000 (GMT)
Date:   Mon, 30 Jan 2023 20:43:28 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     "H. Peter Anvin" <hpa@zytor.com>
cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86: Disable kernel stack offset randomization for
 !TSC
In-Reply-To: <B71587C5-21E8-4F7C-94FB-92E2AA9F840A@zytor.com>
Message-ID: <alpine.DEB.2.21.2301121100120.65308@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2301082113350.65308@angie.orcam.me.uk> <Y72CByxvewQv78YH@zx2c4.com> <alpine.DEB.2.21.2301120129020.65308@angie.orcam.me.uk> <B71587C5-21E8-4F7C-94FB-92E2AA9F840A@zytor.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jan 2023, H. Peter Anvin wrote:

> RDTSC isn't a super fast instruction either,

 As someone recently mostly involved with RISC architectures I find it 
interesting indeed, given that the TSC is just some kind of an integer 
register (or data latch).

 E.g. with the MIPS $c0_count register, which is a free-running counter 
similar to the TSC, the "MFC0 reg, $c0_count" instruction executes just 
about as any ordinary ALU operation, such as say ADD (there is no plain 
GPR move instruction in the MIPS ISA to compare this special register move 
to).  Yes, the latency may be two clocks rather than one, but that's still 
pretty damn fast and the extra latency can be dealt with even on scalar 
microarchitectures by reordering the data consumer farther away from the 
producer.

> but what is *way* more 
> significant is that this use of RDTSC is NOT safe: in certain power 
> states it may very well be that stone number of lower bits of TSC 
> contain no entropy at all.

 I wasn't aware of this limitation; certainly at its introduction TSC was 
just a free-running counter with no special states.

 I went after Jason's suggestion to use `get_random_u8' then, which is 
both portable and the single place to make sure proper entropy is 
maintained in.  Thank you for your input.

  Maciej
