Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6186F2788
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 05:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjD3Dyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 23:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjD3Dyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 23:54:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889D319B1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 20:54:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11C1D6122B
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 03:54:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C717FC433EF;
        Sun, 30 Apr 2023 03:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682826882;
        bh=r2VeuPYQfJ2iw/CTmN4Mv5+QlWJm/piaDa5NQvc+/80=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YmJKu9H/edgwAmVovRl9eyvNkNBBgp54e2eBqOtKK++XX3qs8tIrC2U7C+SKY7kKv
         bawzN/Tm5I5/jIdC0N7Py6MlS3MuDqt2Qcd96QuHYLH6vfapo0eUiqgAAuziIW+LJc
         0FqsKExI4SAcqR26ZdetxIG2ruUDX5f8m+5WfO3dXWh3Ql0nGVcu35xCRNF9li9tNl
         1e4FXVTMHqrrZj/GC2/wiU0gP6SxEf6ib5X3z1MaS+h0BsPuol5x30ladhc0RY4DG3
         +VoKMtck6tT5g5FbD8jTo7BtwFO07U7dljVFkvn/d8vNoZwtR2tdHbietJz28ZcCqI
         mu/I2PJxy7feA==
Date:   Sun, 30 Apr 2023 06:54:29 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Justin Forbes <jforbes@fedoraproject.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jmforbes@linuxtx.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Revert arm64: drop ranges in definition of
 ARCH_FORCE_MAX_ORDER
Message-ID: <ZE3mdYajdFnvl1by@kernel.org>
References: <20230428153646.823736-1-jforbes@fedoraproject.org>
 <ZEv76qfIiJcUvdql@arm.com>
 <ZE1pcwi95nPdlKzN@kernel.org>
 <CAFbkSA3SzjWZ_Q8XC6-_Kzc+jmUN6sG7vzbSD5X1bRvPUaJg3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFbkSA3SzjWZ_Q8XC6-_Kzc+jmUN6sG7vzbSD5X1bRvPUaJg3Q@mail.gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 29, 2023 at 05:42:11PM -0500, Justin Forbes wrote:
> On Sat, Apr 29, 2023 at 2:01 PM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Fri, Apr 28, 2023 at 06:01:30PM +0100, Catalin Marinas wrote:
> > > + Mike and Andrew
> > >
> > > On Fri, Apr 28, 2023 at 10:36:45AM -0500, Justin M. Forbes wrote:
> > > > While the ARCH_FORCE_MAX_ORDER changes clarified the descriptions quite
> > > > a bit, the aarch64 specific change moved this config to sit behind
> > > > CONFIG_EXPERT. This becomes problematic when distros are setting this to
> > > > a non default value already. Pushing it behind EXPERT where it was not
> > > > before will silently change the configuration for users building with
> > > > oldconfig.  If distros patch out if EXPERT downstream, it still creates
> > > > problems for users testing out upstream patches, or trying to bisect to
> > > > find the root of problem, as the configuration will change unexpectedly,
> > > > possibly leading to different behavior and false results.
> > > >
> > > > Whem I asked about reverting the EXPERT, dependency, I was asked to add
> >
> > Nit: When
> >
> > > > the ranges back.
> > > >
> > > > This essentially reverts commit 34affcd7577a232803f729d1870ba475f294e4ea
> > > >
> > > > Signed-off-by: Justin M. Forbes <jforbes@fedoraproject.org>
> > > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > > ---
> > > >  arch/arm64/Kconfig | 4 +++-
> > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > > index b1201d25a8a4..dae18ac01e94 100644
> > > > --- a/arch/arm64/Kconfig
> > > > +++ b/arch/arm64/Kconfig
> > > > @@ -1516,9 +1516,11 @@ config XEN
> > > >  # 16K |       27          |      14      |       13        |         11         |
> > > >  # 64K |       29          |      16      |       13        |         13         |
> > > >  config ARCH_FORCE_MAX_ORDER
> > > > -   int "Order of maximal physically contiguous allocations" if EXPERT && (ARM64_4K_PAGES || ARM64_16K_PAGES)
> > > > +   int "Order of maximal physically contiguous allocations" if ARM64_4K_PAGES || ARM64_16K_PAGES
> > > >     default "13" if ARM64_64K_PAGES
> > > > +   range 11 13 if ARM64_16K_PAGES
> > > >     default "11" if ARM64_16K_PAGES
> > > > +   range 10 15 if ARM64_4K_PAGES
> > > >     default "10"
> > > >     help
> > > >       The kernel page allocator limits the size of maximal physically
> > >
> > > The revert looks fine to me:
> > >
> > > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> > >
> > > For the record, the original discussion:
> > >
> > > Link: https://lore.kernel.org/r/CAFxkdAr5C7ggZ+WdvDbsfmwuXujT_z_x3qcUnhnCn-WrAurvgA@mail.gmail.com
> >
> > I'm not really happy about this revert because MAX_ORDER is not something
> > that should be changed easily.
> > But since hiding it behind EXPERT would silently change lots of existing
> > builds, I won't object.
> >
> > Still, I never got the answer _why_ Fedora/RHEL configs use non-default
> > value. Quite possible something else needs to be fixed rather than having
> > overgrown MAX_ORDER.
> 
> I get that, but I also looked at the rest of the patch set. Nowhere
> else was "if EXPERT" added.  Why wasn't it added to other
> architectures? Not that I am complaining, but aarch64 in particular is
> the one arch where, as a distro, we are trying to accommodate both
> Raspberry Pi, and server class machines.

The patch was about dropping the ranges, not about adding EXPERT. So on
arm64 it was added because Catalin requested it, other arch maintainers
didn't.

> It is the practicality of building a single kernel image that works
> along a large number of machines. The defaults are fine for smaller
> boards, and honestly the majority of aarch64 hardware in circulation.
> They are not acceptable for server class machines running those types
> of workloads.

Why the default MAX_ORDER was not acceptable on arm64 server machines but
it is fine on, say, x86 and s390? 
I'm not asking how you made it possible in Fedora and RHEL, I'm asking why
did you switch from the default order at all.

> Justin
> 
> > --
> > Sincerely yours,
> > Mike.
> >

-- 
Sincerely yours,
Mike.
