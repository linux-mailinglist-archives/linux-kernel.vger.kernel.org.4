Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326BC6B0745
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 13:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjCHMhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 07:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjCHMhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 07:37:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1C6BCB8C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 04:37:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 779D56174D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 12:37:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E71C433D2;
        Wed,  8 Mar 2023 12:37:02 +0000 (UTC)
Date:   Wed, 8 Mar 2023 12:36:59 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Alexey Izbyshev <izbyshev@ispras.ru>
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
Message-ID: <ZAiBazZQ0Yrwqpqw@arm.com>
References: <20230119160344.54358-2-joey.gouly@arm.com>
 <8408d8901e9d7ee6b78db4c6cba04b78@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8408d8901e9d7ee6b78db4c6cba04b78@ispras.ru>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 04:01:56PM +0300, Alexey Izbyshev wrote:
> On 2023-01-19 19:03, Joey Gouly wrote:
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 87d929316d57..99a4d9e2b0d8 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -2665,6 +2665,16 @@ unsigned long mmap_region(struct file *file,
> > unsigned long addr,
> >  		vma_set_anonymous(vma);
> >  	}
> > 
> > +	if (map_deny_write_exec(vma, vma->vm_flags)) {
> > +		error = -EACCES;
> > +		if (file)
> > +			goto close_and_free_vma;
> > +		else if (vma->vm_file)
> > +			goto unmap_and_free_vma;
> > +		else
> > +			goto free_vma;
> > +	}
> > +
> 
> Why is the cleanup dispatch logic duplicated here, instead of simply doing
> "goto close_and_free_vma" (where basically the same dispatch is done)?

Yes, though that's only possible after commit cc8d1b097de7 ("mmap: clean
up mmap_region() unrolling") in 6.3-rc1. It's worth adding a separate
patch to simplify this before final 6.3.

> > diff --git a/mm/mprotect.c b/mm/mprotect.c
> > index 908df12caa26..bc0587df042f 100644
> > --- a/mm/mprotect.c
> > +++ b/mm/mprotect.c
> > @@ -762,6 +762,11 @@ static int do_mprotect_pkey(unsigned long start,
> > size_t len,
> >  			break;
> >  		}
> > 
> > +		if (map_deny_write_exec(vma, newflags)) {
> > +			error = -EACCES;
> > +			goto out;
> > +		}
> > +
> 
> Why does this check use "goto out", thereby skipping post-loop cleanup,
> instead of "break" like all other checks? This looks like a bug to me.

Ah, good point, thanks. I think that's a left-over from my early attempt
at this series. The loop was changed in 5.19 with commit 4a18419f71cd
("mm/mprotect: use mmu_gather") but the patch not updated.

So yeah, it needs fixing. Joey, could you please send fixes for both
issues above?

Thanks.

-- 
Catalin
