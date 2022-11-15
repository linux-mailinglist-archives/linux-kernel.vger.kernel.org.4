Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4556D629DA9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 16:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238263AbiKOPgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 10:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbiKOPf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 10:35:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D222E033
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 07:35:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A4AD61884
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 15:35:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC18C433D6;
        Tue, 15 Nov 2022 15:35:53 +0000 (UTC)
Date:   Tue, 15 Nov 2022 15:35:49 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     Joey Gouly <joey.gouly@arm.com>, Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lennart Poettering <lennart@poettering.net>,
        Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-abi-devel@lists.sourceforge.net, nd@arm.com, shuah@kernel.org
Subject: Re: [PATCH v1 1/2] mm: Implement memory-deny-write-execute as a prctl
Message-ID: <Y3Ox1QxAzdouCGUr@arm.com>
References: <20221026150457.36957-1-joey.gouly@arm.com>
 <20221026150457.36957-2-joey.gouly@arm.com>
 <202210281053.904BE2F@keescook>
 <20221110112714.GA1201@e124191.cambridge.arm.com>
 <Y2zojDe0Oj4OSbIc@arm.com>
 <45419a7d-04dd-2749-2534-6ba3bbd5d060@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45419a7d-04dd-2749-2534-6ba3bbd5d060@gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2022 at 08:11:24AM +0200, Topi Miettinen wrote:
> On 10.11.2022 14.03, Catalin Marinas wrote:
> > On Thu, Nov 10, 2022 at 11:27:14AM +0000, Joey Gouly wrote:
> > > On Fri, Oct 28, 2022 at 11:51:00AM -0700, Kees Cook wrote:
> > > > On Wed, Oct 26, 2022 at 04:04:56PM +0100, Joey Gouly wrote:
> > > > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > > > index 099468aee4d8..42eaf6683216 100644
> > > > > --- a/mm/mmap.c
> > > > > +++ b/mm/mmap.c
> > > > > @@ -1409,6 +1409,9 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
> > > > >   			vm_flags |= VM_NORESERVE;
> > > > >   	}
> > > > > +	if (map_deny_write_exec(NULL, vm_flags))
> > > > > +		return -EACCES;
> > > > > +
> > > > 
> > > > This seems like the wrong place to do the check -- that the vma argument
> > > > is a hard-coded "NULL" is evidence that something is wrong. Shouldn't
> > > > it live in mmap_region()? What happens with MAP_FIXED, when there is
> > > > an underlying vma? i.e. an MAP_FIXED will, I think, bypass the intended
> > > > check. For example, we had "c" above:
> > > > 
> > > >       c)	mmap(PROT_READ);
> > > > 	mprotect(PROT_READ|PROT_EXEC);		// fails
> > > > 
> > > > But this would allow another case:
> > > > 
> > > >       e)	addr = mmap(..., PROT_READ, ...);
> > > > 	mmap(addr, ..., PROT_READ | PROT_EXEC, MAP_FIXED, ...);	// passes
> > > 
> > > I can move the check into mmap_region() but it won't fix the MAP_FIXED
> > > example that you showed here.
> > > 
> > > mmap_region() calls do_mas_munmap(..) which will unmap overlapping regions.
> > > However the `vma` for the 'old' region is not kept around, and a new vma will
> > > be allocated later on "vma = vm_area_alloc(mm);", and the vm_flags are just set
> > > to what is passed into mmap_region(), so map_deny_write_exec(vma, vm_flags)
> > > will just be as good as passing NULL.
> > > 
> > > It's possible to save the vm_flags from the region that is unmapped, but Catalin
> > > suggested it might be better if that is part of a later extension, what do you
> > > think?
> > 
> > I thought initially we should keep the behaviour close to what systemd
> > achieves via SECCOMP while only relaxing an mprotect(PROT_EXEC) if the
> > vma is already executable (i.e. check actual permission change not just
> > the PROT_* flags).
> > 
> > We could pass the old vm_flags for that region (and maybe drop the vma
> > pointer entirely, just check old and new vm_flags). But this feels like
> > tightening slightly systemd's MDWE approach. If user-space doesn't get
> > confused by this, I'm fine to go with it. Otherwise we can add a new
> > flag later for this behaviour
> > 
> > I guess that's more of a question for Topi on whether point tightening
> > point (e) is feasible/desirable.
> 
> I think we want 1:1 compatibility with seccomp() for the basic version, so
> MAP_FIXED shouldn't change the verdict. Later we can introduce more versions
> (perhaps even less strict, too) when it's requested by configuration, like
> MemoryDenyWriteExecute=[relaxed | strict].

Are you ok with allowing mprotect(PROT_EXEC|PROT_BTI) if the mapping is
already PROT_EXEC? Or you'd rather reject that as well?

-- 
Catalin
