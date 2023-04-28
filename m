Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6186F1703
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 13:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345383AbjD1LtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 07:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjD1Ls6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 07:48:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E59672713
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 04:48:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8361EC14;
        Fri, 28 Apr 2023 04:49:39 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.21.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C2113F5A1;
        Fri, 28 Apr 2023 04:48:53 -0700 (PDT)
Date:   Fri, 28 Apr 2023 12:48:47 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v3 01/60] arm64: kernel: Disable latent_entropy GCC
 plugin in early C runtime
Message-ID: <ZEuyn+5ppbSkFiWV@FVFF77S0Q05N>
References: <20230307140522.2311461-1-ardb@kernel.org>
 <20230307140522.2311461-2-ardb@kernel.org>
 <ZEuh/V6luuvCjd55@FVFF77S0Q05N>
 <CAMj1kXEueDPt9TJVh4NmFtJG-nJFgrHNsqykzQNQZPrGwRz8pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEueDPt9TJVh4NmFtJG-nJFgrHNsqykzQNQZPrGwRz8pg@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 11:54:16AM +0100, Ard Biesheuvel wrote:
> On Fri, 28 Apr 2023 at 11:38, Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Tue, Mar 07, 2023 at 03:04:23PM +0100, Ard Biesheuvel wrote:
> > > Avoid build issues in the early C code related to the latent_entropy GCC
> > > plugin, by incorporating the C flags fragment that disables it.
> > >
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >
> > Just to check, are you seeing issues today? IIUC the plugin only instruments
> > functions which are explicitly marked with __latent_entropy, and if we're
> > seeing that happen unexpectedly (or due to that being applying to __meminit /
> > __init), we might need to do likewise for other noinstr code.
> >
> 
> I don't quite remember, tbh, but it is unlikely that I would have
> written or included this patch without having run into some actual
> issue.

Sure.

Looking at the series, from patch 15 onwards you mark portions of the PI code
as __init. As __init currently implies __latent_entropy (which I think is a bit
crazy as of itself...), that's why this'll start to fail.

It would be nice if we could mention that in the commit message, e.g.

| In subsequent patches we'll mark portions of the early C code as __init.
| Unfortunarely, __init implies __latent_entropy, and this would result in the
| early C code being instrumented in an unsafe manner.
|
| Disable the latent entropy plugin for the early C code.

... though my ack stands regardless of whether we add such wording.

Mark.

> > Regardless, for this patch:
> >
> > Acked-by: Mark Rutland <mark.rutland@arm.com>
> >
> 
> Thanks,
