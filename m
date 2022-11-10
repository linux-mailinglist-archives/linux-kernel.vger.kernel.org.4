Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E6C6241E4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 13:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbiKJMDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 07:03:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiKJMDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 07:03:36 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E33C1788D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 04:03:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 50562CE2256
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 12:03:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD5DC433D6;
        Thu, 10 Nov 2022 12:03:27 +0000 (UTC)
Date:   Thu, 10 Nov 2022 12:03:24 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Joey Gouly <joey.gouly@arm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lennart Poettering <lennart@poettering.net>,
        Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Topi Miettinen <toiwoton@gmail.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-abi-devel@lists.sourceforge.net, nd@arm.com, shuah@kernel.org
Subject: Re: [PATCH v1 1/2] mm: Implement memory-deny-write-execute as a prctl
Message-ID: <Y2zojDe0Oj4OSbIc@arm.com>
References: <20221026150457.36957-1-joey.gouly@arm.com>
 <20221026150457.36957-2-joey.gouly@arm.com>
 <202210281053.904BE2F@keescook>
 <20221110112714.GA1201@e124191.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110112714.GA1201@e124191.cambridge.arm.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 11:27:14AM +0000, Joey Gouly wrote:
> On Fri, Oct 28, 2022 at 11:51:00AM -0700, Kees Cook wrote:
> > On Wed, Oct 26, 2022 at 04:04:56PM +0100, Joey Gouly wrote:
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index 099468aee4d8..42eaf6683216 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -1409,6 +1409,9 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
> > >  			vm_flags |= VM_NORESERVE;
> > >  	}
> > >  
> > > +	if (map_deny_write_exec(NULL, vm_flags))
> > > +		return -EACCES;
> > > +
> > 
> > This seems like the wrong place to do the check -- that the vma argument
> > is a hard-coded "NULL" is evidence that something is wrong. Shouldn't
> > it live in mmap_region()? What happens with MAP_FIXED, when there is
> > an underlying vma? i.e. an MAP_FIXED will, I think, bypass the intended
> > check. For example, we had "c" above:
> > 
> >      c)	mmap(PROT_READ);
> > 	mprotect(PROT_READ|PROT_EXEC);		// fails
> > 
> > But this would allow another case:
> > 
> >      e)	addr = mmap(..., PROT_READ, ...);
> > 	mmap(addr, ..., PROT_READ | PROT_EXEC, MAP_FIXED, ...);	// passes
> 
> I can move the check into mmap_region() but it won't fix the MAP_FIXED
> example that you showed here.
> 
> mmap_region() calls do_mas_munmap(..) which will unmap overlapping regions.
> However the `vma` for the 'old' region is not kept around, and a new vma will
> be allocated later on "vma = vm_area_alloc(mm);", and the vm_flags are just set
> to what is passed into mmap_region(), so map_deny_write_exec(vma, vm_flags)
> will just be as good as passing NULL.
> 
> It's possible to save the vm_flags from the region that is unmapped, but Catalin
> suggested it might be better if that is part of a later extension, what do you
> think? 

I thought initially we should keep the behaviour close to what systemd
achieves via SECCOMP while only relaxing an mprotect(PROT_EXEC) if the
vma is already executable (i.e. check actual permission change not just
the PROT_* flags).

We could pass the old vm_flags for that region (and maybe drop the vma
pointer entirely, just check old and new vm_flags). But this feels like
tightening slightly systemd's MDWE approach. If user-space doesn't get
confused by this, I'm fine to go with it. Otherwise we can add a new
flag later for this behaviour

I guess that's more of a question for Topi on whether point tightening
point (e) is feasible/desirable.

-- 
Catalin
