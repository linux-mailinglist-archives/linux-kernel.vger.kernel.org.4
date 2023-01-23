Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D186780C9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 17:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbjAWQEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 11:04:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbjAWQE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 11:04:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81337A5EB
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 08:04:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3233BB80DF5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 16:04:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CABFEC433D2;
        Mon, 23 Jan 2023 16:04:22 +0000 (UTC)
Date:   Mon, 23 Jan 2023 16:04:19 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Joey Gouly <joey.gouly@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lennart Poettering <lennart@poettering.net>,
        Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Topi Miettinen <toiwoton@gmail.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-abi-devel@lists.sourceforge.net, nd@arm.com, shuah@kernel.org
Subject: Re: [PATCH v2 1/2] mm: Implement memory-deny-write-execute as a prctl
Message-ID: <Y86wA0s/HRVtqLru@arm.com>
References: <20230119160344.54358-1-joey.gouly@arm.com>
 <20230119160344.54358-2-joey.gouly@arm.com>
 <4a1faf67-178e-c9ba-0db1-cf90408b0d7d@redhat.com>
 <Y857Uoq7fjO0lZ12@arm.com>
 <8b4e31cf-de20-703c-4b53-ad86d4282a37@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b4e31cf-de20-703c-4b53-ad86d4282a37@redhat.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 01:53:46PM +0100, David Hildenbrand wrote:
> On 23.01.23 13:19, Catalin Marinas wrote:
> > On Mon, Jan 23, 2023 at 12:45:50PM +0100, David Hildenbrand wrote:
> > > On 19.01.23 17:03, Joey Gouly wrote:
> > > > diff --git a/include/linux/mman.h b/include/linux/mman.h
> > > > index 58b3abd457a3..cee1e4b566d8 100644
> > > > --- a/include/linux/mman.h
> > > > +++ b/include/linux/mman.h
> > > > @@ -156,4 +156,38 @@ calc_vm_flag_bits(unsigned long flags)
> > > >    }
> > > >    unsigned long vm_commit_limit(void);
> > > > +
> > > > +/*
> > > > + * Denies creating a writable executable mapping or gaining executable permissions.
> > > > + *
> > > > + * This denies the following:
> > > > + *
> > > > + * 	a)	mmap(PROT_WRITE | PROT_EXEC)
> > > > + *
> > > > + *	b)	mmap(PROT_WRITE)
> > > > + *		mprotect(PROT_EXEC)
> > > > + *
> > > > + *	c)	mmap(PROT_WRITE)
> > > > + *		mprotect(PROT_READ)
> > > > + *		mprotect(PROT_EXEC)
> > > > + *
> > > > + * But allows the following:
> > > > + *
> > > > + *	d)	mmap(PROT_READ | PROT_EXEC)
> > > > + *		mmap(PROT_READ | PROT_EXEC | PROT_BTI)
> > > > + */
> > > 
> > > Shouldn't we clear VM_MAYEXEC at mmap() time such that we cannot set VM_EXEC
> > > anymore? In an ideal world, there would be no further mprotect changes
> > > required.
> > 
> > I don't think it works for this scenario. We don't want to disable
> > PROT_EXEC entirely, only disallow it if the mapping is not already
> > executable. The below should be allowed:
> > 
> > 	addr = mmap(0, size, PROT_READ | PROT_EXEC, flags, 0, 0);
> > 	mprotect(addr, size, PROT_READ | PROT_EXEC | PROT_BTI);
> > 
> > but IIUC what you meant, it fails if we cleared VM_MAYEXEC at mmap()
> > time.
> 
> Yeah, if you allow write access at mmap time, clear VM_MAYEXEC (and disallow
> VM_EXEC of course).

This should work but it doesn't fully mimic systemd's MDWE behaviour
(e.g. disallow mprotect(PROT_EXEC) even if the mmap was PROT_READ only).
Topi wanted to stay close to that at least in the first incarnation of
this control (can be extended later).

> But I guess we'd have to go one step further: if we allow exec access
> at mmap time, clear VM_MAYWRITE (and disallow VM_WRITE of course).

Yes, both this and the VM_MAYEXEC clearing if VM_WRITE would be useful
but as additional controls a process can enable.

> That at least would be then similar to how we handle mmaped files: if the
> file is not executable, we clear VM_MAYEXEC. If the file is not writable, we
> clear VM_MAYWRITE.

We still allow VM_MAYWRITE for private mappings, though we do clear
VM_MAYEXEC if not executable.

It would be nice to use VM_MAY* flags for this logic but we can only
emulate MDWE if we change the semantics of 'MAY': only check the 'MAY'
flags for permissions being changed (e.g. allow PROT_EXEC if the vma is
already VM_EXEC even if !VM_MAYEXEC). Another issue is that we end up
with some weird combinations like having VM_EXEC without VM_MAYEXEC
(maybe that's fine).

> Clearing VM_MAYWRITE would imply that also writes via /proc/self/mem to such
> memory would be forbidden, which might also be what we are trying to
> achieve, or is that expected to still work?

I think currently with systemd's MDWE it still works (I haven't tried
though), unless there's something else forcing that file read-only.

> But clearing VM_MAYWRITE would mean that is_cow_mapping() would no
> longer fire for some VMAs, and we'd have to check if that's fine in
> all cases.

This will break __access_remote_vm() AFAICT since it can't do a CoW on
read-only private mapping.

> Having that said, this patch handles the case when the prctl is applied to a
> process after already having created some writable or executable mappings,
> to at least forbid if afterwards on these mappings. What is expected to
> happen if the process already has writable mappings that are executable at
> the time we enable the prctl?

They are expected to continue to work. The prctl() is meant to be
invoked by something like systemd so that any subsequent exec() will
inherit the property.

> Clarifying what the expected semantics with /proc/self/mem are would be
> nice.

Yeah, this series doesn't handle this. Topi, do you know if systemd does
anything about /proc/self/mem? To me this option is more about catching
inadvertent write|exec mappings rather than blocking programs that
insist on doing this (they can always map a memfd file twice with
separate write and exec attributes for example).

-- 
Catalin
