Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664D26D6D60
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 21:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236176AbjDDToC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 15:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235905AbjDDTn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 15:43:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD8E4EE9
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 12:43:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5569D63062
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 19:43:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0228C433EF;
        Tue,  4 Apr 2023 19:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1680637436;
        bh=1Pj9wervIvuhxnbud9M7uEnumbv+qewHT7HtKpfIDE0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=u3JeDRjED8NfLSy7JgtnzRWXs8mnHtoxwLXgKI8TrOSi/KA99r+V3s3xMiq5k29wc
         mM2t1mpsctRZyI25Rxtg1sRpN6GavOMHoh071IbNwPezCuQS7D8+tQi8YKcwGiKHMy
         3Z27iTHQOYUlsTYsSxers71SWSjBt2yrcMul/pNo=
Date:   Tue, 4 Apr 2023 12:43:55 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] prctl: Add PR_GET_AUXV to copy auxv to userspace
Message-Id: <20230404124355.3efa7a201d2aa9896dc6353e@linux-foundation.org>
In-Reply-To: <d81864a7f7f43bca6afa2a09fc2e850e4050ab42.1680611394.git.josh@joshtriplett.org>
References: <d81864a7f7f43bca6afa2a09fc2e850e4050ab42.1680611394.git.josh@joshtriplett.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Apr 2023 21:31:48 +0900 Josh Triplett <josh@joshtriplett.org> wrote:

> If a library wants to get information from auxv (for instance,
> AT_HWCAP/AT_HWCAP2), it has a few options, none of them perfectly
> reliable or ideal:
> 
> - Be main or the pre-main startup code, and grub through the stack above
>   main. Doesn't work for a library.
> - Call libc getauxval. Not ideal for libraries that are trying to be
>   libc-independent and/or don't otherwise require anything from other
>   libraries.
> - Open and read /proc/self/auxv. Doesn't work for libraries that may run
>   in arbitrarily constrained environments that may not have /proc
>   mounted (e.g. libraries that might be used by an init program or a
>   container setup tool).
> - Assume you're on the main thread and still on the original stack, and
>   try to walk the stack upwards, hoping to find auxv. Extremely bad
>   idea.
> - Ask the caller to pass auxv in for you. Not ideal for a user-friendly
>   library, and then your caller may have the same problem.

How does glibc's getauxval() do its thing?  Why can't glibc-independent
code do the same thing?

> Add a prctl that copies current->mm->saved_auxv to a userspace buffer.
> 
> ...
>
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -290,4 +290,6 @@ struct prctl_mm_map {
>  #define PR_SET_VMA		0x53564d41
>  # define PR_SET_VMA_ANON_NAME		0
>  
> +#define PR_GET_AUXV		0x41555856

How was this constant arrived at?

> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2377,6 +2377,16 @@ static inline int prctl_get_mdwe(unsigned long arg2, unsigned long arg3,
>  		PR_MDWE_REFUSE_EXEC_GAIN : 0;
>  }
>  
> +static int prctl_get_auxv(void __user *addr, unsigned long len)
> +{
> +	struct mm_struct *mm = current->mm;
> +	unsigned long size = min_t(unsigned long, sizeof(mm->saved_auxv), len);
> +
> +	if (size && copy_to_user(addr, mm->saved_auxv, size))
> +		return -EFAULT;
> +	return sizeof(mm->saved_auxv);
> +}

The type choices are unpleasing.  Maybe make `len' a size_t and make
the function return a size_t?  That way prctl_get_auxv() will be much
nicer, but the caller less so.

>  SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>  		unsigned long, arg4, unsigned long, arg5)
>  {
> @@ -2661,6 +2671,11 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>  	case PR_SET_VMA:
>  		error = prctl_set_vma(arg2, arg3, arg4, arg5);
>  		break;
> +	case PR_GET_AUXV:
> +		if (arg4 || arg5)
> +			return -EINVAL;
> +		error = prctl_get_auxv((void __user *)arg2, arg3);
> +		break;
>  	default:
>  		error = -EINVAL;
>  		break;

