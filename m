Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647F05BA087
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 19:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiIORwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 13:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiIORwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 13:52:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595A0804A1;
        Thu, 15 Sep 2022 10:52:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E413D625B2;
        Thu, 15 Sep 2022 17:52:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4EFBC433C1;
        Thu, 15 Sep 2022 17:52:11 +0000 (UTC)
Date:   Thu, 15 Sep 2022 18:52:03 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Eric Biggers <ebiggers@kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Adam Langley <agl@google.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: Should Linux set the new constant-time mode CPU flags?
Message-ID: <YyNmQ2bPvf3B3Xvo@arm.com>
References: <YwgCrqutxmX0W72r@gmail.com>
 <Ywzr2d52ixYXUDWR@zx2c4.com>
 <6ec9cdab-db5b-ab28-c92d-79c3812dd369@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ec9cdab-db5b-ab28-c92d-79c3812dd369@intel.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 07:25:29AM -0700, Dave Hansen wrote:
> On 8/29/22 09:39, Jason A. Donenfeld wrote:
> > On Thu, Aug 25, 2022 at 11:15:58PM +0000, Eric Biggers wrote:
> >> I'm wondering if people are aware of this issue, and whether anyone has any
> >> thoughts on whether/where the kernel should be setting these new CPU flags.
> >> There don't appear to have been any prior discussions about this.  (Thanks to
> > Maybe it should be set unconditionally now, until we figure out how to
> > make it more granular.
> 
> Personally, I'm in this camp as well.  Let's be safe and set it by
> default.  There's also this tidbit in the Intel docs (and chopping out a
> bunch of the noise):
> 
> 	(On) processors based on microarchitectures before Ice Lake ...
> 	the instructions listed here operate as if DOITM is enabled.
> 
> IOW, setting DOITM=0 isn't going back to the stone age.  At worst, I'd
> guess that you're giving up some optimization that only shows up in very
> recent CPUs in the first place.
> 
> If folks want DOITM=1 on their snazzy new CPUs, then they came come with
> performance data to demonstrate the gain they'll get from adding kernel
> code to get DOITM=1.  There are a range of ways we could handle it, all
> the way from adding a command-line parameter to per-task management.
> 
> Anybody disagree?

It's not my preferred option for arm64 but I admit the same reasoning
could equally apply to us. If some existing crypto libraries relied on
data independent timing for current CPUs but newer ones (with the DIT
feature) come up with more aggressive, data-dependent optimisations,
they may be caught off-guard. That said the ARM architecture spec never
promised any timing, that's a micro-architecture detail and not all
implementations are done by ARM Ltd. So I can't really tell what's out
there.

So I guess knobs for finer grained control would do, at least a sysctl
(or cmdline) to turn it on/off globally and maybe a prctl() for user. We
don't necessarily need this on arm64 but if x86 adds one, we might as
well wire it up.

-- 
Catalin
