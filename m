Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED29D72C9F5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236868AbjFLP0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236807AbjFLP0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:26:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0653E57
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:26:30 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686583589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+bqt2DJTBIwNA4YUB3UD0Uqa0lFwB4F8gQo7oR65+qI=;
        b=HXFkb3ca0s8WRAW4B4wWT7d9QsMnyQUm4g6c5YBISjuzcQjFOuh4QMidTE3rBlvLECtns+
        nSXXTrbxmVuSeq/buyJSg1+Hnz/gwDiPEWMYuy2i7ZoF6k9bJsEHzncgA8GwWYQgY3jd4/
        gwBg+CqYnRmFuIhBQXh8Ke26rwmO8oEck1PW2Dr5JQtZXItl+tKlZdRs16JfHyzJ5Y0KB1
        hV3LVHb1wLlqb6DfAgG8G2P4HxndBf8Vh9LqOU1kzEv7h56UYZ6m0ilIkgqvc3PSbc7G7O
        nDdcnDarVIjVCgJsv5w9agrTexR5QWxCmrjXNyODIdmhFxHwpOhg3SmdXV8tKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686583589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+bqt2DJTBIwNA4YUB3UD0Uqa0lFwB4F8gQo7oR65+qI=;
        b=XUtHFu71MVEZaLAgGqPVrPHfWJDjNf7aRiIJgH4Cg1xZcLWc03Z6IHm1zhNQa1b3qbsMrQ
        Jc9VKMXU17VMaIBg==
To:     Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] x86/microcode: Add a "microcode=" command line option
In-Reply-To: <20230605141332.25948-2-bp@alien8.de>
References: <20230605141332.25948-1-bp@alien8.de>
 <20230605141332.25948-2-bp@alien8.de>
Date:   Mon, 12 Jun 2023 17:26:28 +0200
Message-ID: <87ilbs7lcr.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05 2023 at 16:13, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
>
> It will be used to control microcode loader behavior. Add the first
> chicken bit: to control whether the AMD side should load microcode late
> on all logical SMT threads.

This has a distinct void of information here.

Why is it suddenly required to prevent late loading on SMT threads?

That's the exact opposite of what e7ad18d1169c ("x86/microcode/AMD:
Apply the patch early on every logical thread") is doing.

I'm seriously confused.
>  
> +	microcode=	[X86] Control the behavior of the microcode
> +			loader. Available options:
> +
> +			no_late_all - do not load on all SMT threads on
> +			AMD. Loading on all logical threads is enabled by
> +			default.

no_late_all is a horrible option name.

Also the explanation is not mentioning that this is only relevant for
late loading.

Aside of that why is this a kernel side chicken bit and not communicated
by the microcode header?

How should an administrator know which microcode versions need this
treatment and which do not? How is that supposed to work on a fleet?

> --- a/arch/x86/kernel/cpu/microcode/core.c
> +++ b/arch/x86/kernel/cpu/microcode/core.c
> @@ -40,11 +40,15 @@
>  #include <asm/cmdline.h>
>  #include <asm/setup.h>
>  
> +#include "internal.h"
> +
>  #define DRIVER_VERSION	"2.2"
>  
>  static struct microcode_ops	*microcode_ops;
>  static bool dis_ucode_ldr = true;
>  
> +unsigned long control = LATE_ALL_THREADS;

global variable name without a proper prefix. Moo.

> +static ssize_t control_show(struct device *dev,
> +			     struct device_attribute *attr, char *buf)
> +{
> +	return sprintf(buf, "0x%lx\n", control);
> +}
> +
> +static ssize_t control_store(struct device *dev,
> +			     struct device_attribute *attr,
> +			     const char *buf, size_t count)
> +{
> +	unsigned long val;
> +
> +	if (kstrtoul(buf, 0, &val) < 0)
> +		return -ERANGE;
> +
> +	if (val & CONTROL_FLAGS_MASK)
> +		return -EINVAL;
> +
> +	control = val;
> +
> +	return count;
> +}

Where is the documentation which tells me what I'm supposed to write
into this file? Also this is a generic file, right? So what's the
meaning for non AMD? I can write this bit into it successfully and
nothing happens, right?
> +++ b/arch/x86/kernel/cpu/microcode/internal.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __X86_MICROCODE_INTERNAL_H__
> +#define __X86_MICROCODE_INTERNAL_H__
> +
> +extern unsigned long control;
> +
> +/* Loader control flags. */
> +enum control_flags {
> +	__LATE_ALL_THREADS = 0,
> +	__CONTROL_FLAGS_NUM,
> +};
> +
> +#define LATE_ALL_THREADS	BIT_ULL(__LATE_ALL_THREADS)
> +#define CONTROL_FLAGS_MASK	~(BIT_ULL(__CONTROL_FLAGS_NUM) - 1)

Why ULL bits for a unsigned long variable?

Thanks,

        tglx
