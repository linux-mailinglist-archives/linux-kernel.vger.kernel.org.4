Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429246ED401
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 19:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbjDXR6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 13:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjDXR6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 13:58:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E48E6A42;
        Mon, 24 Apr 2023 10:58:40 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682359118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/B8ViPkT84zF77YJVg/Vg+DuX3x6sDAhKrSrx63B0t8=;
        b=zNVUbHm89L6WRj2i94+vPyVn3/KO1LB2C60TWY+kKf2/e8X9/9XtdKbM639oCyDfzo+kF6
        y7T/sJmhL5ytO4DUh414kpf+vt4CvUe/YodEpDD02hfzlBINbTEIvI3SsdLqezsCo+5tFW
        AvbLWyv3qGi42txG7eIeRdoNoCDf86KN/QgJXAPPGmhTl1TqeCcHqSPF7eM9+ujvoD5z/m
        AjrKuWx0mKwm8kHTyjPIB1SSadCZzqxSWvKRYA61NK+fA/i4N78zaZprmbihpUvGoCep3s
        2RQE5w5ABRrYdGBrSZjZPmPvtUXxeogAae/i/g9/9f8KekX5LyUd6mtLrTj6qw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682359118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/B8ViPkT84zF77YJVg/Vg+DuX3x6sDAhKrSrx63B0t8=;
        b=ZaMRZ/Y/wVrPL6Kd1U5Zo8HZlUCLMRTrTHQ/7Xvf+abFcSRFeSo9Dw3jXKeMeUtXfr3+up
        aT9nxD885g2bqnAA==
To:     Brian Gerst <brgerst@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        David Woodhouse <dwmw@infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul McKenney <paulmck@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Piotr Gorski <lucjan.lucjanov@gmail.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Usama Arif <usama.arif@bytedance.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Sabin Rapan <sabrapan@amazon.com>
Subject: Re: [patch 35/37] x86/smpboot: Support parallel startup of
 secondary CPUs
In-Reply-To: <87mt38yhwh.ffs@tglx>
References: <20230414225551.858160935@linutronix.de>
 <20230414232311.379210081@linutronix.de>
 <CAMzpN2hUbYpYrqDL1ViXUWGKGa7mDEG6iHtWEZg9GvrAoRgvKQ@mail.gmail.com>
 <87mt38yhwh.ffs@tglx>
Date:   Mon, 24 Apr 2023 19:58:36 +0200
Message-ID: <878reh17sj.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 15 2023 at 23:06, Thomas Gleixner wrote:

> On Sat, Apr 15 2023 at 09:22, Brian Gerst wrote:
>> On Fri, Apr 14, 2023 at 7:45=E2=80=AFPM Thomas Gleixner <tglx@linutronix=
.de> wrote:
>>> @@ -248,10 +311,20 @@ SYM_INNER_LABEL(secondary_startup_64_no_
>>>          *
>>>          * RDX contains the per-cpu offset
>>>          */
>>> -       movq    pcpu_hot + X86_current_task(%rdx), %rax
>>> -       movq    TASK_threadsp(%rax), %rsp
>>> +       movq    pcpu_hot + X86_top_of_stack(%rdx), %rsp
>>
>> Switching to using pcpu_hot.top_of_stack is ok, but it's not
>> completely equivalent.  top_of_stack points to the end of the pt_regs
>> structure, while the kernel stack starts below pt_regs even for kernel
>> threads.  So you need to subtract PTREGS_SIZE from the stack pointer
>> after this.
>>
>> This change should also be a separate patch.
>
> You're right on both counts.

Actually no. We can't do that as this breaks suspend/resume (again).

/me drops it.
