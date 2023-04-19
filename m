Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C75D6E7806
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 13:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbjDSLFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 07:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbjDSLFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 07:05:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6A24C19;
        Wed, 19 Apr 2023 04:05:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C896963D4C;
        Wed, 19 Apr 2023 11:05:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58FEC433EF;
        Wed, 19 Apr 2023 11:05:31 +0000 (UTC)
Date:   Wed, 19 Apr 2023 12:05:28 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Justin Forbes <jforbes@fedoraproject.org>,
        Mike Rapoport <rppt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guo Ren <guoren@kernel.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Zi Yan <ziy@nvidia.com>, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mm@kvack.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH v3 02/14] arm64: drop ranges in definition of
 ARCH_FORCE_MAX_ORDER
Message-ID: <ZD/K+Mof/Dx5yzjQ@arm.com>
References: <20230325060828.2662773-1-rppt@kernel.org>
 <20230325060828.2662773-3-rppt@kernel.org>
 <CAFxkdAr5C7ggZ+WdvDbsfmwuXujT_z_x3qcUnhnCn-WrAurvgA@mail.gmail.com>
 <ZCvQGJzdED+An8an@kernel.org>
 <CAFbkSA38eTA_iJ3ttBvQ8G4Rjj8qB12GxY7Z=qmZ8wm+0tZieA@mail.gmail.com>
 <ZDbp7LAHES3YFo30@arm.com>
 <20230418150557.ea8c87c96ec64c899c88ab08@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418150557.ea8c87c96ec64c899c88ab08@linux-foundation.org>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 03:05:57PM -0700, Andrew Morton wrote:
> On Wed, 12 Apr 2023 18:27:08 +0100 Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > It sounds nice in theory. In practice. EXPERT hides too much. When you
> > > flip expert, you expose over a 175ish new config options which are
> > > hidden behind EXPERT.  You don't have to know what you are doing just
> > > with the MAX_ORDER, but a whole bunch more as well.  If everyone were
> > > already running 10, this might be less of a problem. At least Fedora
> > > and RHEL are running 13 for 4K pages on aarch64. This was not some
> > > accidental choice, we had to carry a patch to even allow it for a
> > > while.  If this does go in as is, we will likely just carry a patch to
> > > remove the "if EXPERT", but that is a bit of a disservice to users who
> > > might be trying to debug something else upstream, bisecting upstream
> > > kernels or testing a patch.  In those cases, people tend to use
> > > pristine upstream sources without distro patches to verify, and they
> > > tend to use their existing configs. With this change, their MAX_ORDER
> > > will drop to 10 from 13 silently.   That can look like a different
> > > issue enough to ruin a bisect or have them give bad feedback on a
> > > patch because it introduces a "regression" which is not a regression
> > > at all, but a config change they couldn't see.
> > 
> > If we remove EXPERT (as prior to this patch), I'd rather keep the ranges
> > and avoid having to explain to people why some random MAX_ORDER doesn't
> > build (keeping the range would also make sense for randconfig, not sure
> > we got to any conclusion there).
> 
> Well this doesn't seem to have got anywhere.  I think I'll send the
> patchset into Linus for the next merge window as-is.  Please let's take
> a look at this Kconfig presentation issue during the following -rc
> cycle.

That's fine by me. I have a slight preference to drop EXPERT and keep
the ranges in, especially if it affects current distro kernels. Debian
seems to enable EXPERT already in their arm64 kernel config but I'm not
sure about the Fedora or other distro kernels. If they don't, we can
fix/revert this Kconfig entry once the merging window is closed.

-- 
Catalin
