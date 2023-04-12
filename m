Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F796DFCB1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 19:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjDLR1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 13:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDLR1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 13:27:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78D440FB;
        Wed, 12 Apr 2023 10:27:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 829B0634C9;
        Wed, 12 Apr 2023 17:27:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA85C433EF;
        Wed, 12 Apr 2023 17:27:11 +0000 (UTC)
Date:   Wed, 12 Apr 2023 18:27:08 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Justin Forbes <jforbes@fedoraproject.org>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
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
Message-ID: <ZDbp7LAHES3YFo30@arm.com>
References: <20230325060828.2662773-1-rppt@kernel.org>
 <20230325060828.2662773-3-rppt@kernel.org>
 <CAFxkdAr5C7ggZ+WdvDbsfmwuXujT_z_x3qcUnhnCn-WrAurvgA@mail.gmail.com>
 <ZCvQGJzdED+An8an@kernel.org>
 <CAFbkSA38eTA_iJ3ttBvQ8G4Rjj8qB12GxY7Z=qmZ8wm+0tZieA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFbkSA38eTA_iJ3ttBvQ8G4Rjj8qB12GxY7Z=qmZ8wm+0tZieA@mail.gmail.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 06:50:01AM -0500, Justin Forbes wrote:
> On Tue, Apr 4, 2023 at 2:22 AM Mike Rapoport <rppt@kernel.org> wrote:
> > On Wed, Mar 29, 2023 at 10:55:37AM -0500, Justin Forbes wrote:
> > > On Sat, Mar 25, 2023 at 1:09 AM Mike Rapoport <rppt@kernel.org> wrote:
> > > >
> > > > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> > > >
> > > > It is not a good idea to change fundamental parameters of core memory
> > > > management. Having predefined ranges suggests that the values within
> > > > those ranges are sensible, but one has to *really* understand
> > > > implications of changing MAX_ORDER before actually amending it and
> > > > ranges don't help here.
> > > >
> > > > Drop ranges in definition of ARCH_FORCE_MAX_ORDER and make its prompt
> > > > visible only if EXPERT=y
> > >
> > > I do not like suddenly hiding this behind EXPERT for a couple of
> > > reasons.  Most importantly, it will silently change the config for
> > > users building with an old kernel config.  If a user has for instance
> > > "13" set and building with 4K pages, as is the current configuration
> > > for Fedora and RHEL aarch64 builds, an oldconfig build will now set it
> > > to 10 with no indication that it is doing so.  And while I think that
> > > 10 is a fine default for many aarch64 users, there are valid reasons
> > > for choosing other values. Putting this behind expert makes it much
> > > less obvious that this is an option.
> >
> > That's the idea of EXPERT, no?
> >
> > This option was intended to allow allocation of huge pages for
> > architectures that had PMD_ORDER > MAX_ORDER and not to allow user to
> > select size of maximal physically contiguous allocation.
> >
> > Changes to MAX_ORDER fundamentally change the behaviour of core mm and
> > unless users *really* know what they are doing there is no reason to choose
> > non-default values so hiding this option behind EXPERT seems totally
> > appropriate to me.
> 
> It sounds nice in theory. In practice. EXPERT hides too much. When you
> flip expert, you expose over a 175ish new config options which are
> hidden behind EXPERT.  You don't have to know what you are doing just
> with the MAX_ORDER, but a whole bunch more as well.  If everyone were
> already running 10, this might be less of a problem. At least Fedora
> and RHEL are running 13 for 4K pages on aarch64. This was not some
> accidental choice, we had to carry a patch to even allow it for a
> while.  If this does go in as is, we will likely just carry a patch to
> remove the "if EXPERT", but that is a bit of a disservice to users who
> might be trying to debug something else upstream, bisecting upstream
> kernels or testing a patch.  In those cases, people tend to use
> pristine upstream sources without distro patches to verify, and they
> tend to use their existing configs. With this change, their MAX_ORDER
> will drop to 10 from 13 silently.   That can look like a different
> issue enough to ruin a bisect or have them give bad feedback on a
> patch because it introduces a "regression" which is not a regression
> at all, but a config change they couldn't see.

If we remove EXPERT (as prior to this patch), I'd rather keep the ranges
and avoid having to explain to people why some random MAX_ORDER doesn't
build (keeping the range would also make sense for randconfig, not sure
we got to any conclusion there).

-- 
Catalin
