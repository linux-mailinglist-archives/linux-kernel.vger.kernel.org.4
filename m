Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56456623A22
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 04:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbiKJDBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 22:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiKJDBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 22:01:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9114BB1F4
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 19:01:50 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668049308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l3dWBPDoB0ZUfUc2NPMRUPMvZHbfPQx8atm9DV2mCp4=;
        b=UOJct0+vpWArP3xgfjcbihjiIqvQrxLzJ7PANf4CWcRwLU86Pw1XvlCPcAgXNr4RZ+yXWE
        gw8Mxxx9O9dxNXz8tsiPlJX5Re/wvgRsV1E3um0mrHecn2sMBGb2XTU/vAH5SCp78UnQf9
        A0oXuL1awutGXlPxaX9Ls8vGtnL8HqubjUZoqs7AI/PugmpOZlmej4tX+h6N+UlNOfRDG8
        weGOs5hmHOwzLZUxE0Z658g5rp4bFU4+pxJsj8v4zQNfKU0woOT3hAwSAWgdUCrPXNOsVX
        k5jreqeknpXKUAK5Pz/y8XcC2kkoBWCKLC6OQnD6CUUeD0YvoW1KfI++JKd1Bg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668049308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l3dWBPDoB0ZUfUc2NPMRUPMvZHbfPQx8atm9DV2mCp4=;
        b=Vad1AOb44F6L7Xpe2nnoNhtCD7SFBNucd2C2g8Gqxb/cRy7ZxXWbvvFMfgEWKY+NFEoF9S
        F5KeO+esaXjbn4AQ==
To:     Chen Lifu <chenlifu@huawei.com>, linux-kernel@vger.kernel.org
Cc:     chenlifu@huawei.com
Subject: Re: [PATCH -next] genirq: Add SPARSE_NR_IRQS Kconfig option
In-Reply-To: <20220930085839.315461-1-chenlifu@huawei.com>
References: <20220930085839.315461-1-chenlifu@huawei.com>
Date:   Thu, 10 Nov 2022 04:01:47 +0100
Message-ID: <87iljn8qck.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30 2022 at 16:58, Chen Lifu wrote:
> On a large-scale multi-core and NUMA platform, more than 1024 cores and
> 16 NUMA nodes for example, even if SPASE_IRQ is selected to increase the
> number of interrupt numbers by 8196 base on NR_IRQS, the interrupt numbers
> requirement cannot be met. Therefore, make the number of sparse interrupt
> numbers configurable.

Why?

Let me walk you through:

# git grep '#define\sNR_IRQS' arch/x86
arch/x86/include/asm/irq_vectors.h:#define NR_IRQS_LEGACY			16
arch/x86/include/asm/irq_vectors.h:#define NR_IRQS						\
arch/x86/include/asm/irq_vectors.h:#define	NR_IRQS				(NR_VECTORS + IO_APIC_VECTOR_LIMIT)
arch/x86/include/asm/irq_vectors.h:#define NR_IRQS				(NR_VECTORS + CPU_VECTOR_LIMIT)
arch/x86/include/asm/irq_vectors.h:#define NR_IRQS				NR_IRQS_LEGACY

Versus:

# git grep '#define\sNR_IRQS' arch/arm64

Empty. Oooops. Where does it get the define from on which the define you
try to influence with your config knob depends on, i.e.

    # define IRQ_BITMAP_BITS	(NR_IRQS + 8196)

Good question, right?

But not rocket science to answer. If there is no architecture specific
definition then there is a close to 100% probability that there is a
generic fallback define in include/asm-generic/. And indeed

# git grep '#define\sNR_IRQS' include/

include/asm-generic/irq.h:#define NR_IRQS 64

So let's do the math:

   (64 + 8196) / 1024 ~= 8

Unsurprisingly enough this does barely cope for the per CPU requirements
of an ARM64 system. Of course if you add a proper amount of periphery
then you surely run out of interrupt numbers....

Now let me go back to the grep I did on x86. That matches on some lines
w/o context, but let me show you the full context of the relevant
configuration of a enterprisy machine with all bells and whistels here
for illustration:

#define NR_VECTORS			256
#define MAX_IO_APICS			128
#define CPU_VECTOR_LIMIT		(64 * NR_CPUS)
#define IO_APIC_VECTOR_LIMIT		(32 * MAX_IO_APICS)

So in the case of a NR_CPUS=1024 configuration this evaluates to:

CPU_VECTOR_LIMIT	64*1024 = 65536
IO_APIC_VECTOR_LIMIT    32*128	=  4096

and then the relevant NR_IRQS define:

#define NR_IRQS						\
	(CPU_VECTOR_LIMIT > IO_APIC_VECTOR_LIMIT ?	\
		(NR_VECTORS + CPU_VECTOR_LIMIT)  :	\
		(NR_VECTORS + IO_APIC_VECTOR_LIMIT))

evaluates to:

 (65536 > 4096) ? (256 * 65536) : (256 * 4096) = 256 * 65536 = ....
        
While the resulting number is silly large, you should be able to figure
out the fundamental difference of the approach to limit the number of
interrupts between the x86 and the arm64 case, right?

There is no good reason to copy the insanely large numbers of x86 but
you surely can figure out how the key component in that calculation
which takes NR_CPUs into account avoids another random uncomprehensible
configuration knob:

    # define IRQ_BITMAP_BITS	(NR_IRQS + 8196)

No?

Thanks,

        tglx


