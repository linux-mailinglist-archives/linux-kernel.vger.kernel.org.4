Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF106FC5F2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 14:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235623AbjEIMKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 08:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235692AbjEIMJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 08:09:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64493C05;
        Tue,  9 May 2023 05:09:45 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683634184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JdyszAQFsS8NQ584CZnckJnpEhoUaXW9tnBOiTa+9+E=;
        b=ka9gkcGHPU/F0K+ngaz5jaCDeTzITcmJantNFEH1Q/42sdZ4zT1IqtMce7W/ZjZD1bK1+j
        /LNwDssKYbtn14emuSZbyff8IjECHOj44E32PB3y66ONqTaivar6HFMvTYpEn79bGOVSI8
        sOjrIz9MvrC0jruLu+aWlOCPHHLUW+sovMocfUIwQQzie8Jw2EWX+LtwgcvbMB/fb++PT7
        3V5LLpihTVTj/4ipngAecsP92q7WSv1hEdEi47Ocn0+UqB1lNCmcxgzxFfcOzQz6hdRbtH
        MZzhHOOgMIT3YAtQVGXh4XejswO34svSG9XWtwbNWw47oZdXADP7zBo3uAbL7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683634184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JdyszAQFsS8NQ584CZnckJnpEhoUaXW9tnBOiTa+9+E=;
        b=GXVTcObOnQaoFBT3flZUDZ+yT6E9sycBY79vdaY5U1FPyYZPuFxqBXtxFTxmCYvrEjr620
        6gR4tFX9TtdUtDAw==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul McKenney <paulmck@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Piotr Gorski <lucjan.lucjanov@gmail.com>,
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
        Sabin Rapan <sabrapan@amazon.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Subject: Re: [patch v3 13/36] x86/smpboot: Remove cpu_callin_mask
In-Reply-To: <20230509104915.GX83892@hirez.programming.kicks-ass.net>
References: <20230508181633.089804905@linutronix.de>
 <20230508185217.956149661@linutronix.de>
 <20230509104915.GX83892@hirez.programming.kicks-ass.net>
Date:   Tue, 09 May 2023 14:09:44 +0200
Message-ID: <87h6sl1zav.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09 2023 at 12:49, Peter Zijlstra wrote:
> On Mon, May 08, 2023 at 09:43:47PM +0200, Thomas Gleixner wrote:
>> -	/*
>> -	 * Sync point with wait_cpu_callin(). The AP doesn't wait here
>> -	 * but just sets the bit to let the controlling CPU (BSP) know that
>> -	 * it's got this far.
>> -	 */
>>  	smp_callin();
>>  
>>  	/* Otherwise gcc will move up smp_processor_id() before cpu_init() */
>
> Good riddance to that mask; however is smp_callin() still an appropriate
> name for that function?
>
> Would smp_starting() -- seeing how this kicks of CPU_STARTING not be a
> better name?

Something like that, yes.
