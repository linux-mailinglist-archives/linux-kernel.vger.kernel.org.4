Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0A36310DE
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 21:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbiKSUkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 15:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbiKSUja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 15:39:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773DB12D1D;
        Sat, 19 Nov 2022 12:39:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E03D060BBA;
        Sat, 19 Nov 2022 20:39:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00685C433C1;
        Sat, 19 Nov 2022 20:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668890368;
        bh=+YFG65zK+ig5GsbiwocxVDqflXqp3NTQLYHgrK//RV8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uI4+VOv5qj+YubiO/jBt2kpkGPiwzDuZXWyX1lVzq5T2ysdrmunWaK02PLLSWIgRG
         M47WLr0UdxMFYuXmyDwngVF+Phrm/0ZdX3dg41OetTY7MItuKSsQtPmm6Cz9IWE8oT
         MoiUrwYCfmAID9ZDP0Th8pSfbDLelCTy3o3Da8H8xut8FadG0eSgNIx4W7EjnkOZNv
         Gnev27yrn4U/QBmY5ZkFHBHVT5xHFjL0fJD0sFY9662vC4VJT6x6dr0rIc1l1filVK
         1oTat6Hu/bG4ifVPxw+MUsZrQZGiKxXLXty1xoC8cKql0V22PnrqKaCyvdkM2H7asG
         CAcUrFa/7TvQA==
Date:   Sat, 19 Nov 2022 12:39:26 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>
Subject: Re: [PATCH v5 1/3] random: add vgetrandom_alloc() syscall
Message-ID: <Y3k+/hSL5rIIkBhK@sol.localdomain>
References: <20221119120929.2963813-1-Jason@zx2c4.com>
 <20221119120929.2963813-2-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221119120929.2963813-2-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 19, 2022 at 01:09:27PM +0100, Jason A. Donenfeld wrote:
> +SYSCALL_DEFINE3(vgetrandom_alloc, unsigned long __user *, num,
> +		unsigned long __user *, size_per_each, unsigned int, flags)
> +{
> +	unsigned long alloc_size;
> +	unsigned long num_states;
> +	unsigned long pages_addr;
> +	int ret;
> +
> +	if (flags)
> +		return -EINVAL;
> +
> +	if (get_user(num_states, num))
> +		return -EFAULT;
> +
> +	alloc_size = size_mul(num_states, sizeof(struct vgetrandom_state));
> +	if (alloc_size == SIZE_MAX)
> +		return -EOVERFLOW;
> +	alloc_size = roundup(alloc_size, PAGE_SIZE);

Small detail: the roundup to PAGE_SIZE can make alloc_size overflow to 0.

Also, 'roundup(alloc_size, PAGE_SIZE)' could be 'PAGE_ALIGN(alloc_size)'.

> +	pages_addr = vm_mmap(NULL, 0, alloc_size, PROT_READ | PROT_WRITE,
> +			     MAP_PRIVATE | MAP_ANONYMOUS | MAP_LOCKED, 0);
> +	if (IS_ERR_VALUE(pages_addr))
> +		return pages_addr;

This will only succeed if the userspace process has permission to mlock pages,
i.e. if there is space available in RLIMIT_MEMLOCK or if process has
CAP_IPC_LOCK.  I suppose this is working as intended, as this syscall can be
used to try to allocate and mlock arbitrary amounts of memory.

I wonder if this permission check will cause problems.  Maybe there could be a
way to relax it for just one page per task?  I don't know how that would work,
though, especially when the planned usage involves userspace allocating a single
pool of these contexts per process that get handed out to threads.

- Eric
