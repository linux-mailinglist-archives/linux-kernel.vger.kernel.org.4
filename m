Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BE26E6DF4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 23:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbjDRVS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 17:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjDRVSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 17:18:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651DB40C7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 14:18:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 017B662CDC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 21:18:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 386F0C433D2;
        Tue, 18 Apr 2023 21:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1681852733;
        bh=ZHLorItxEGVfcY4Q/q4ok59ZeKbJLntqIuzGqWM4Oz8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZJrxSsXnTHQnjbHNk2yl/WgKDDGRDFLxcfVRgtiByjNC7xDO1v8qYMnVfOxxpJRP3
         wuodcAfVx0XI2XLHxp1xTZC98IQfMW0lLEy/j3GmEHQ3nuM7TuUidWfAeQCVu27G0p
         H7h/mRHFd4XMxzmSjglYoxgDpXj6J0li/x7ECAHk=
Date:   Tue, 18 Apr 2023 14:18:52 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Waiman Long <longman@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Joe Mario <jmario@redhat.com>,
        Barry Marson <bmarson@redhat.com>,
        Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH] mm/mmap: Map MAP_STACK to VM_STACK
Message-Id: <20230418141852.75e551e57e97f4b522957c5c@linux-foundation.org>
In-Reply-To: <20230418210230.3495922-1-longman@redhat.com>
References: <20230418210230.3495922-1-longman@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Apr 2023 17:02:30 -0400 Waiman Long <longman@redhat.com> wrote:

> One of the flags of mmap(2) is MAP_STACK to request a memory segment
> suitable for a process or thread stack. The kernel currently ignores
> this flags. Glibc uses MAP_STACK when mmapping a thread stack. However,
> selinux has an execstack check in selinux_file_mprotect() which disallows
> a stack VMA to be made executable.
> 
> Since MAP_STACK is a noop, it is possible for a stack VMA to be merged
> with an adjacent anonymous VMA. With that merging, using mprotect(2)
> to change a part of the merged anonymous VMA to make it executable may
> fail. This can lead to sporadic failure of applications that need to
> make those changes.

"Sporadic failure of applications" sounds quite serious.  Can you
provide more details?

Did you consider a -stable backport?  I'm unable to judge, because the
description of the userspace effects is so thin,

> One possible fix is to make sure that a stack VMA will not be merged
> with a non-stack anonymous VMA. That requires a vm flag that can be
> used to distinguish a stack VMA from a regular anonymous VMA. One
> can add a new dummy vm flag for that purpose. However, there is only
> 1 bit left in the lower 32 bits of vm_flags. Another alternative is
> to use an existing vm flag. VM_STACK (= VM_GROWSDOWN for most arches)
> can certainly be used for this purpose. The downside is that it is a
> slight change in existing behavior.
> 
> Making a stack VMA growable by default certainly fits the need of a
> process or thread stack. This patch now maps MAP_STACK to VM_STACK to
> prevent unwanted merging with adjacent non-stack VMAs and make the VMA
> more suitable for being used as a stack.
> 
> ...
>
> --- a/include/linux/mman.h
> +++ b/include/linux/mman.h
> @@ -152,6 +152,7 @@ calc_vm_flag_bits(unsigned long flags)
>  	return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN ) |
>  	       _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    ) |
>  	       _calc_vm_trans(flags, MAP_SYNC,	     VM_SYNC      ) |
> +	       _calc_vm_trans(flags, MAP_STACK,	     VM_STACK     ) |
>  	       arch_calc_vm_flag_bits(flags);
>  }

The mmap(2) manpage says

  This flag is currently a no-op on Linux.  However, by employing
  this flag, applications can ensure that they transparently ob- tain
  support if the flag is implemented in the future.  Thus, it is used
  in the glibc threading implementation to allow for the fact that some
  architectures may (later) require special treat- ment for stack
  allocations.  A further reason to employ this flag is portability:
  MAP_STACK exists (and has an effect) on some other systems (e.g.,
  some of the BSDs).

so please propose an update for this?
