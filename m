Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46715E71EB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 04:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbiIWCdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 22:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiIWCdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 22:33:18 -0400
X-Greylist: delayed 2080 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 22 Sep 2022 19:33:16 PDT
Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601EAEF08B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 19:33:16 -0700 (PDT)
Received: from c-24-17-218-140.hsd1.wa.comcast.net ([24.17.218.140] helo=srivatsab-a02.vmware.com)
        by outgoing2021.csail.mit.edu with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <srivatsa@csail.mit.edu>)
        id 1obXwy-006TNS-9J;
        Thu, 22 Sep 2022 21:57:56 -0400
To:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        ganb@vmware.com, sturlapati@vmware.com, bordoloih@vmware.com,
        ankitja@vmware.com, keerthanak@vmware.com, namit@vmware.com,
        srivatsab@vmware.com
References: <165843627080.142207.12667479241667142176.stgit@csail.mit.edu>
From:   "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: Re: [PATCH] smp/hotplug, x86/vmware: Put offline vCPUs in halt
 instead of mwait
Message-ID: <1d53fca8-5c6b-2130-2645-95330bbcf899@csail.mit.edu>
Date:   Thu, 22 Sep 2022 18:57:52 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <165843627080.142207.12667479241667142176.stgit@csail.mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Boris, Thomas, Peter,

On 7/21/22 1:44 PM, Srivatsa S. Bhat wrote:
> From: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
> 
> VMware ESXi allows enabling a passthru mwait CPU-idle state in the
> guest using the following VMX option:
> 
> monitor_control.mwait_in_guest = "TRUE"
> 
> This lets a vCPU in mwait to remain in guest context (instead of
> yielding to the hypervisor via a VMEXIT), which helps speed up
> wakeups from idle.
> 
> However, this runs into problems with CPU hotplug, because the Linux
> CPU offline path prefers to put the vCPU-to-be-offlined in mwait
> state, whenever mwait is available. As a result, since a vCPU in mwait
> remains in guest context and does not yield to the hypervisor, an
> offline vCPU *appears* to be 100% busy as viewed from ESXi, which
> prevents the hypervisor from running other vCPUs or workloads on the
> corresponding pCPU (particularly when vCPU - pCPU mappings are
> statically defined by the user). [ Note that such a vCPU is not
> actually busy spinning though; it remains in mwait idle state in the
> guest ].
> 
> Fix this by overriding the CPU offline play_dead() callback for VMware
> hypervisor, by putting the CPU in halt state (which actually yields to
> the hypervisor), even if mwait support is available.
> 
> Signed-off-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Alexey Makhalov <amakhalov@vmware.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: x86@kernel.org
> Cc: VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
> ---

Could you share your thoughts on this patch when you get a chance,
please? I verified that this patch still applies cleanly on current
mainline (6.0-rc6). I'm happy to resend the patch though, if it helps.

Thank you!

Regards,
Srivatsa

> 
>  arch/x86/kernel/cpu/vmware.c |   17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
> index c04b933f48d3..420e359ed9bb 100644
> --- a/arch/x86/kernel/cpu/vmware.c
> +++ b/arch/x86/kernel/cpu/vmware.c
> @@ -27,6 +27,7 @@
>  #include <linux/clocksource.h>
>  #include <linux/cpu.h>
>  #include <linux/reboot.h>
> +#include <linux/tboot.h>
>  #include <linux/static_call.h>
>  #include <asm/div64.h>
>  #include <asm/x86_init.h>
> @@ -312,6 +313,21 @@ static int vmware_cpu_down_prepare(unsigned int cpu)
>  	local_irq_enable();
>  	return 0;
>  }
> +
> +static void vmware_play_dead(void)
> +{
> +	play_dead_common();
> +	tboot_shutdown(TB_SHUTDOWN_WFS);
> +
> +	/*
> +	 * Put the vCPU going offline in halt instead of mwait (even
> +	 * if mwait support is available), to make sure that the
> +	 * offline vCPU yields to the hypervisor (which may not happen
> +	 * with mwait, for example, if the guest's VMX is configured
> +	 * to retain the vCPU in guest context upon mwait).
> +	 */
> +	hlt_play_dead();
> +}
>  #endif
>  
>  static __init int activate_jump_labels(void)
> @@ -349,6 +365,7 @@ static void __init vmware_paravirt_ops_setup(void)
>  #ifdef CONFIG_SMP
>  		smp_ops.smp_prepare_boot_cpu =
>  			vmware_smp_prepare_boot_cpu;
> +		smp_ops.play_dead = vmware_play_dead;
>  		if (cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
>  					      "x86/vmware:online",
>  					      vmware_cpu_online,
> 
> 
