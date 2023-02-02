Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0F268786D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 10:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbjBBJKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 04:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbjBBJJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 04:09:59 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2887C73A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 01:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tnkWpw83pHyhopF+Eh9g6wj1gGqqjXj0A521d21vmBA=; b=M7DwTQf8PzNfNNtNaQ3xD2Qxza
        2P6vPTsALdZ6+2kWxcOBUFgzjITVHY7EFYDzuRk1fkJgpezTQ+bI/JhdSBniMAsEPGsBHBNpjCRkF
        0eAeDjEHzSK3Evr3dg0v5cutazmrt4Fpoh6wNCQsZGt+vTufZ7Ltnbs8RF08zxcYQBsmP9NCO3hPo
        5/1b2t/a4SJgzu/glUDzS6iQyIdapTGgzhimnksIYaCLL4UEkDd5/8IqkNoT4s0FVkAnSG60TK5Mj
        4DvytJMS4OIe9GK6uODMfX9z45sE7PG4tvF9U7QuZIyoKpn496u2oVudFZEfkogFjBMWU5ztFvTqu
        yIvYA+9g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pNVaw-00DFZ4-7Z; Thu, 02 Feb 2023 09:09:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6185C3001E5;
        Thu,  2 Feb 2023 10:09:22 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4D7F523F2C5B0; Thu,  2 Feb 2023 10:09:22 +0100 (CET)
Date:   Thu, 2 Feb 2023 10:09:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Zeng Heng <zengheng4@huawei.com>
Cc:     mingo@redhat.com, bp@alien8.de, jroedel@suse.de, vbabka@suse.cz,
        hpa@zytor.com, tglx@linutronix.de, eric.devolder@oracle.com,
        bhe@redhat.com, tiwai@suse.de, keescook@chromium.org,
        dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
        x86@kernel.org, liwei391@huawei.com, xiexiuqi@huawei.com
Subject: Re: [PATCH v3] x86/kdump: Handle blocked NMIs interrupt to avoid
 kdump crashes
Message-ID: <Y9t9wvQ0HRwCs1Xh@hirez.programming.kicks-ass.net>
References: <20230202014053.3604176-1-zengheng4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202014053.3604176-1-zengheng4@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 09:40:53AM +0800, Zeng Heng wrote:
> If the cpu panics within the NMI interrupt context,
> there could be unhandled NMI interrupts in the
> background which are blocked by processor until
> next IRET instruction executes. Since that, it
> prevents nested execution of the NMI handler.
> 
> In case of IRET execution during kdump reboot and
> no proper NMIs handler registered at that point
> (such as during EFI loader), we need to handle these
> blocked NMI interrupts in advance to avoid kdump
> crashes.
> 
> Because asm_exc_nmi() has the ability to handle
> nested NMIs, here call iret_to_self() and execute
> IRET instruction in order to trigger and handle the
> possible blocked NMIs interrupts in advance before
> the IDT set invalidate.
> 
> Provide one of test case to reproduce the concerned
> issue, and here is the steps:
>   1. # cat uncorrected
>      CPU 1 BANK 4
>      STATUS uncorrected 0xc0
>      MCGSTATUS  EIPV MCIP
>      ADDR 0x1234
>      RIP 0xdeadbabe
>      RAISINGCPU 0
>      MCGCAP SER CMCI TES 0x6
>   2. # modprobe mce_inject
>   3. # mce-inject uncorrected
> 
> Mce-inject would trigger kernel panic under NMI
> interrupt context. In addition, we need another NMI
> interrupt raise (such as from watchdog) during panic
> process. Set proper watchdog threshold value and/or
> add an artificial delay to make sure watchdog interrupt
> raise during the panic procedure and the involved
> issue would occur.
> 
> Fixes: ca0e22d4f011 ("x86/boot/compressed/64: Always switch to own page table")
> Signed-off-by: Zeng Heng <zengheng4@huawei.com>
> Suggested-by: Borislav Petkov <bp@alien8.de>
> ---
>   v1: add dummy NMI interrupt handler in EFI loader
>   v2: tidy up changelog, add comments (by Ingo Molnar)
>   v3: add iret_to_self() to deal with blocked NMIs in advance
> 
>  arch/x86/kernel/crash.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index 305514431f26..3aaca680a639 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -41,6 +41,7 @@
>  #include <asm/intel_pt.h>
>  #include <asm/crash.h>
>  #include <asm/cmdline.h>
> +#include <asm/sync_core.h>
> 
>  /* Used while preparing memory map entries for second kernel */
>  struct crash_memmap_data {
> @@ -143,6 +144,19 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
> 
>  	crash_smp_send_stop();
> 
> +	/*
> +	 * If the cpu panics within the NMI interrupt context,
> +	 * there may be unhandled NMI interrupts which are
> +	 * blocked by processor until next IRET instruction
> +	 * executes.
> +	 *
> +	 * In case of IRET execution during kdump reboot and
> +	 * no proper NMIs handler registered at that point,
> +	 * we trigger and handle blocked NMIs in advance to
> +	 * avoid kdump crashes.
> +	 */
> +	iret_to_self();
> +
>  	/*
>  	 * VMCLEAR VMCSs loaded on this cpu if needed.
>  	 */

I never remember the shutdown paths -- do we force wipe the PMU
registers somewhere before this?
