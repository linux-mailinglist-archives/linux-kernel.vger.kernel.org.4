Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDC7677AAD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 13:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjAWMTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 07:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjAWMTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 07:19:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005C35599
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 04:19:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A459AB80D6E
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 12:19:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C76AC433D2;
        Mon, 23 Jan 2023 12:19:33 +0000 (UTC)
Date:   Mon, 23 Jan 2023 12:19:30 +0000
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
Message-ID: <Y857Uoq7fjO0lZ12@arm.com>
References: <20230119160344.54358-1-joey.gouly@arm.com>
 <20230119160344.54358-2-joey.gouly@arm.com>
 <4a1faf67-178e-c9ba-0db1-cf90408b0d7d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a1faf67-178e-c9ba-0db1-cf90408b0d7d@redhat.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 12:45:50PM +0100, David Hildenbrand wrote:
> On 19.01.23 17:03, Joey Gouly wrote:
> > The aim of such policy is to prevent a user task from creating an
> > executable mapping that is also writeable.
> > 
> > An example of mmap() returning -EACCESS if the policy is enabled:
> > 
> > 	mmap(0, size, PROT_READ | PROT_WRITE | PROT_EXEC, flags, 0, 0);
> > 
> > Similarly, mprotect() would return -EACCESS below:
> > 
> > 	addr = mmap(0, size, PROT_READ | PROT_EXEC, flags, 0, 0);
> > 	mprotect(addr, size, PROT_READ | PROT_WRITE | PROT_EXEC);
> > 
> > The BPF filter that systemd MDWE uses is stateless, and disallows
> > mprotect() with PROT_EXEC completely. This new prctl allows PROT_EXEC to
> > be enabled if it was already PROT_EXEC, which allows the following case:
> > 
> > 	addr = mmap(0, size, PROT_READ | PROT_EXEC, flags, 0, 0);
> > 	mprotect(addr, size, PROT_READ | PROT_EXEC | PROT_BTI);
> > 
> > where PROT_BTI enables branch tracking identification on arm64.
> > 
> > Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> > Co-developed-by: Catalin Marinas <catalin.marinas@arm.com>
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > ---
> >   include/linux/mman.h           | 34 ++++++++++++++++++++++++++++++++++
> >   include/linux/sched/coredump.h |  6 +++++-
> >   include/uapi/linux/prctl.h     |  6 ++++++
> >   kernel/sys.c                   | 33 +++++++++++++++++++++++++++++++++
> >   mm/mmap.c                      | 10 ++++++++++
> >   mm/mprotect.c                  |  5 +++++
> >   6 files changed, 93 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/mman.h b/include/linux/mman.h
> > index 58b3abd457a3..cee1e4b566d8 100644
> > --- a/include/linux/mman.h
> > +++ b/include/linux/mman.h
> > @@ -156,4 +156,38 @@ calc_vm_flag_bits(unsigned long flags)
> >   }
> >   unsigned long vm_commit_limit(void);
> > +
> > +/*
> > + * Denies creating a writable executable mapping or gaining executable permissions.
> > + *
> > + * This denies the following:
> > + *
> > + * 	a)	mmap(PROT_WRITE | PROT_EXEC)
> > + *
> > + *	b)	mmap(PROT_WRITE)
> > + *		mprotect(PROT_EXEC)
> > + *
> > + *	c)	mmap(PROT_WRITE)
> > + *		mprotect(PROT_READ)
> > + *		mprotect(PROT_EXEC)
> > + *
> > + * But allows the following:
> > + *
> > + *	d)	mmap(PROT_READ | PROT_EXEC)
> > + *		mmap(PROT_READ | PROT_EXEC | PROT_BTI)
> > + */
> 
> Shouldn't we clear VM_MAYEXEC at mmap() time such that we cannot set VM_EXEC
> anymore? In an ideal world, there would be no further mprotect changes
> required.

I don't think it works for this scenario. We don't want to disable
PROT_EXEC entirely, only disallow it if the mapping is not already
executable. The below should be allowed:

	addr = mmap(0, size, PROT_READ | PROT_EXEC, flags, 0, 0);
	mprotect(addr, size, PROT_READ | PROT_EXEC | PROT_BTI);

but IIUC what you meant, it fails if we cleared VM_MAYEXEC at mmap()
time.

We could clear VM_MAYEXEC if the mapping was made VM_WRITE (either by
mmap() or mprotect()) but IIRC we concluded that this should be an
additional prctl() flag. This series aims to be pretty much a drop-in
replacement for the systemd's MDWE SECCOMP feature (but allowing
PROT_BTI).

-- 
Catalin
