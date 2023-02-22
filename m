Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABD169EC50
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 02:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjBVBUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 20:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjBVBUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 20:20:16 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234792FCDC
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 17:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677028815; x=1708564815;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gMtvgDJqTKY1rgD16x42zeAvH2xkbkbhSRqrpC7R/60=;
  b=iJKhac61GXgqUZ4FAVJD59tbfE5LErJTVGgLt3EveBTHXLgdhmURVkCz
   c6+YhBQuknt5Nryzku0B45jhPISyfFteOKLE8s3MwJ//VKAXY5NOLFRXj
   uuwFnFlDoQwo2Qreqv4mOuXBhwRRXgSGfikSfS+hhked4ss7EMifYyoYc
   0R8AcjsyKO8FOsjR0VTMKkl/jxOWXq32qWsQ+Sj/Ol7+MyCa61iWcxbKj
   hcEhqnytyGEd7+2BGCCzxHsmzXmX8ahNmKwDXX1t3RcIhR9dazTh+q6ye
   HGBcp/LC0p6bW/OfS2VbZMp3SsobzeVDikpt2xvrhuBwyAw283+8EtQD+
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="332806631"
X-IronPort-AV: E=Sophos;i="5.97,317,1669104000"; 
   d="scan'208";a="332806631"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 17:20:14 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="704276858"
X-IronPort-AV: E=Sophos;i="5.97,317,1669104000"; 
   d="scan'208";a="704276858"
Received: from erodrig5-mobl2.amr.corp.intel.com (HELO desk) ([10.212.242.195])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 17:20:12 -0800
Date:   Tue, 21 Feb 2023 17:20:09 -0800
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, KP Singh <kpsingh@kernel.org>,
        linux-kernel@vger.kernel.org, pjt@google.com, evn@google.com,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, peterz@infradead.org,
        kim.phillips@amd.com, alexandre.chartre@oracle.com,
        daniel.sneddon@linux.intel.com,
        =?utf-8?B?Sm9zw6k=?= Oliveira <joseloliveira11@gmail.com>,
        Rodrigo Branco <rodrigo@kernelhacking.com>,
        Alexandra Sandulescu <aesa@google.com>,
        Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH] x86/bugs: Allow STIBP with IBRS
Message-ID: <20230222012009.bilnxhbm4lqyhhuy@desk>
References: <20230220121350.aidsipw3kd4rsyss@treble>
 <CACYkzJ5L9MLuE5Jz+z5-NJCCrUqTbgKQkXSqnQnCfTD_WNA7_Q@mail.gmail.com>
 <CACYkzJ6n=-tobhX0ONQhjHSgmnNjWnNe_dZnEOGtD8Y6S3RHbA@mail.gmail.com>
 <20230220163442.7fmaeef3oqci4ee3@treble>
 <Y/Ox3MJZF1Yb7b6y@zn.tnic>
 <20230220175929.2laflfb2met6y3kc@treble>
 <CACYkzJ71xqzY6-wL+YShcL+d6ugzcdFHr6tbYWWE_ep52+RBZQ@mail.gmail.com>
 <20230220182717.uzrym2gtavlbjbxo@treble>
 <Y/O9U4KFtXE8Yoyt@zn.tnic>
 <20230220190908.gfd2c4tuzeb7cft6@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230220190908.gfd2c4tuzeb7cft6@treble>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 11:09:08AM -0800, Josh Poimboeuf wrote:
> On Mon, Feb 20, 2023 at 07:34:59PM +0100, Borislav Petkov wrote:
> > Drop stable@ again.
> > 
> > On Mon, Feb 20, 2023 at 10:27:17AM -0800, Josh Poimboeuf wrote:
> > > IBRS is only enabled in kernel space.  Since it's not enabled in user
> > > space, user space isn't protected from indirect branch prediction
> > > attacks from a sibling CPU thread.
> > > 
> > > Allow STIBP to be enabled to protect against such attacks.
> > > 
> > > Fixes: 7c693f54c873 ("x86/speculation: Add spectre_v2=ibrs option to support Kernel IBRS")
> > 
> > Yah, look at that one:
> > 
> > commit 7c693f54c873691a4b7da05c7e0f74e67745d144
> > Author: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > Date:   Tue Jun 14 23:15:55 2022 +0200
> > 
> >     x86/speculation: Add spectre_v2=ibrs option to support Kernel IBRS
> > 
> >     Extend spectre_v2= boot option with Kernel IBRS.
> > 
> >     [jpoimboe: no STIBP with IBRS]
> >     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > 
> > I'm assuming this was supposed to mean no STIBP in *kernel mode* when
> > IBRS is selected?
> 
> No it was supposed to be "no STIBP with *eIBRS*".

Maybe not, "no STIBP with eIBRS" was the state before the said patch.

In an offlist discussion during Retbleed embargo(copied below), it
appears to mean "no STIBP *in kernel* with IBRS". But anyways, we missed
to consider userspace.

(BTW replying late because yesterday was a holiday in my geo).

---
> > Subject: [PATCH v5 26/30] x86/speculation: Add spectre_v2=ibrs option to support Kernel IBRS
> > 
> > From: Peter Zijlstra <peterz@infradead.org>
> > 
> > From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > 
> > The "spectre_v2=" boot option is extended to enable Kernel IBRS.
> > 
> > Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt |    1 
> >  arch/x86/include/asm/nospec-branch.h            |    1 
> >  arch/x86/kernel/cpu/bugs.c                      |   29 ++++++++++++++++++++++--
> >  3 files changed, 29 insertions(+), 2 deletions(-)
> > 
> > @@ -1163,6 +1182,10 @@ static void __init spectre_v2_select_mit
> >  	case SPECTRE_V2_EIBRS:
> >  		break;
> >  
> > +	case SPECTRE_V2_IBRS:
> > +		setup_force_cpu_cap(X86_FEATURE_KERNEL_IBRS);
> > +		break;
> 
> Don't we also need to set SPEC_CTRL_IBRS in x86_spec_ctrl_base?

Also, STIBP isn't needed with IBRS.  Suggested changes:

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 344ab7c9a4e2..498cb36587a3 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -897,11 +897,13 @@ spectre_v2_parse_user_cmdline(enum spectre_v2_mitigation_cmd v2_cmd)
 	return SPECTRE_V2_USER_CMD_AUTO;
 }
 
-static inline bool spectre_v2_in_eibrs_mode(enum spectre_v2_mitigation mode)
+static inline bool spectre_v2_in_ibrs_mode(enum spectre_v2_mitigation mode)
 {
-	return (mode == SPECTRE_V2_EIBRS ||
-		mode == SPECTRE_V2_EIBRS_RETPOLINE ||
-		mode == SPECTRE_V2_EIBRS_LFENCE);
+
+	return spectre_v2_mode == SPECTRE_V2_IBRS
+	       spectre_v2_mode == SPECTRE_V2_EIBRS ||
+	       spectre_v2_mode == SPECTRE_V2_EIBRS_RETPOLINE ||
+	       spectre_v2_mode == SPECTRE_V2_EIBRS_LFENCE;
 }
 
 static void __init
@@ -966,12 +968,12 @@ spectre_v2_user_select_mitigation(enum spectre_v2_mitigation_cmd v2_cmd)
 	}
 
 	/*
-	 * If no STIBP, enhanced IBRS is enabled or SMT impossible, STIBP is not
-	 * required.
+	 * If no STIBP, IBRS or enhanced IBRS is enabled, or SMT impossible,
+	 * STIBP is not required.
 	 */
 	if (!boot_cpu_has(X86_FEATURE_STIBP) ||
 	    !smt_possible ||
-	    spectre_v2_in_eibrs_mode(spectre_v2_enabled))
+	    spectre_v2_in_ibrs_mode(spectre_v2_enabled))
 		return;
 
 	/*
@@ -1171,7 +1173,7 @@ static void __init spectre_v2_select_mitigation(void)
 	if (mode == SPECTRE_V2_EIBRS && unprivileged_ebpf_enabled())
 		pr_err(SPECTRE_V2_EIBRS_EBPF_MSG);
 
-	if (spectre_v2_in_eibrs_mode(mode)) {
+	if (spectre_v2_in_ibrs_mode(mode)) {
 		/* Force it so VMEXIT will restore correctly */
 		x86_spec_ctrl_base |= SPEC_CTRL_IBRS;
 		wr_spec_ctrl(x86_spec_ctrl_base, true);
@@ -1212,19 +1214,17 @@ static void __init spectre_v2_select_mitigation(void)
 	pr_info("Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch\n");
 
 	/*
-	 * Retpoline means the kernel is safe because it has no indirect
-	 * branches. Enhanced IBRS protects firmware too, so, enable restricted
-	 * speculation around firmware calls only when Enhanced IBRS isn't
-	 * supported or kernel IBRS isn't enabled.
+	 * Retpoline protects the kernel, but doesn't protect firmware.  IBRS
+	 * and Enhanced IBRS protect firmware too, so enable IBRS around
+	 * firmware calls only when IBRS / Enhanced IBRS aren't otherwise
+	 * enabled.
 	 *
 	 * Use "mode" to check Enhanced IBRS instead of boot_cpu_has(), because
 	 * the user might select retpoline on the kernel command line and if
 	 * the CPU supports Enhanced IBRS, kernel might un-intentionally not
 	 * enable IBRS around firmware calls.
 	 */
-	if (boot_cpu_has(X86_FEATURE_IBRS) &&
-	    !boot_cpu_has(X86_FEATURE_KERNEL_IBRS) &&
-	    !spectre_v2_in_eibrs_mode(mode)) {
+	if (boot_cpu_has(X86_FEATURE_IBRS) && !spectre_v2_in_ibrs_mode(mode)) {
 		setup_force_cpu_cap(X86_FEATURE_USE_IBRS_FW);
 		pr_info("Enabling Restricted Speculation for firmware calls\n");
 	}
@@ -1937,7 +1937,7 @@ static ssize_t tsx_async_abort_show_state(char *buf)
 
 static char *stibp_state(void)
 {
-	if (spectre_v2_in_eibrs_mode(spectre_v2_enabled))
+	if (spectre_v2_in_ibrs_mode(spectre_v2_enabled))
 		return "";
 
 	switch (spectre_v2_user_stibp) {
