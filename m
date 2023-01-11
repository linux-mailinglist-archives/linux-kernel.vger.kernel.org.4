Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90A4665E03
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 15:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238831AbjAKOdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 09:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238543AbjAKOcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:32:05 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB3B19C1B
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 06:30:20 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 421351EC06C1;
        Wed, 11 Jan 2023 15:30:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1673447419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=NA7mwk/Ho8iSsKJyfJlHX4iE/hrNeawT1dy1bhzSM7A=;
        b=F9KN9T/+5lKvqdSQTZ1Ns7N0wweGvK/IWkC6oOj5tgDc5h3b23py0t5QUDeIQFTLrINAzN
        PpwKHMv6ItAFMzQlRqmuZMHNl3V8EXQHMJTPZKHa9T+8hy8lKEuyZdBVMboly8MrhATBGO
        pkj+wvSCD6zkMegEy77RDhHgU7Qxuv8=
Date:   Wed, 11 Jan 2023 15:30:18 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Xin Li <xin3.li@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
        peterz@infradead.org, brgerst@gmail.com, chang.seok.bae@intel.com,
        jgross@suse.com
Subject: Re: [PATCH v5 5/5] x86/gsseg: use the LKGS instruction if available
 for load_gs_index()
Message-ID: <Y77H+rThnJixLEQC@zn.tnic>
References: <20221128164028.4570-1-xin3.li@intel.com>
 <20221128164028.4570-6-xin3.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221128164028.4570-6-xin3.li@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 08:40:28AM -0800, Xin Li wrote:
> From: "H. Peter Anvin (Intel)" <hpa@zytor.com>
> 
> The LKGS instruction atomically loads a segment descriptor into the
> %gs descriptor registers, *except* that %gs.base is unchanged, and the
> base is instead loaded into MSR_IA32_KERNEL_GS_BASE, which is exactly
> what we want this function to do.
> 
> Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Brian Gerst <brgerst@gmail.com>
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Signed-off-by: Xin Li <xin3.li@intel.com>

I'm reading this SOB chain as

hpa wrote it -> then it went to Peter -> then to Brian -> then to Juergen -> and
you're sending it.

I'm pretty sure that cannot be right.

> ---
> 
> Changes since v4:
> * Clear the LKGS feature from Xen PV guests (Juergen Gross).
> 
> Changes since v3:
> * We want less ASM not more, thus keep local_irq_save/restore() inside
>   native_load_gs_index() (Thomas Gleixner).
> * For paravirt enabled kernels, initialize pv_ops.cpu.load_gs_index to
>   native_lkgs (Thomas Gleixner).
> 
> Changes since v2:
> * Mark DI as input and output (+D) as in V1, since the exception handler
>   modifies it (Brian Gerst).
> 
> Changes since v1:
> * Use EX_TYPE_ZERO_REG instead of fixup code in the obsolete .fixup code
>   section (Peter Zijlstra).
> * Add a comment that states the LKGS_DI macro will be repalced with "lkgs %di"
>   once the binutils support the LKGS instruction (Peter Zijlstra).

I guess that explains what the SOB chain is supposed to mean - you've gotten
review feedback. But that doesn't need such a SOB chain. Sounds like you need to
refresh on

Documentation/process/submitting-patches.rst

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
