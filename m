Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41945B9A0C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 13:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbiIOLpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 07:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiIOLmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 07:42:04 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82A0923F3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 04:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=GdUExkZCCimaetm5TM7oIFdVp9RGBizt5Yv4RZaDQ/c=; b=Y0Idn5mEqy6L07DtVDCiAgUEyu
        xvdY6tVXmw84SoSeFF7vRCja5Lfu3zsGtCgR+IzaQjsvaYOSz9UH0pPb4r4JF6HO52foytg2YH15c
        p4x79Qp1h+B+tlF2TN+t6OWPsLzJ3LjI1eHsWMdfNkcuuuzBcev0FsW0LsrcaZ0VSNEwWI0jb1Gld
        //J9N3YLveTDVINBIN43HyTjwZ2qrOQhO8bsiScTUZPcBkxBFgTAOFUt253Fy9D+ibBflOZeTKBZ7
        bdIi0gonRvbxAWQ8869Ji6wKObNaujO3redlAZ2hloRsK/19+uf8C803KH6z4uVWSLdt6n/+YIpRm
        jG+7OSfw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oYnDu-00Cacn-4s; Thu, 15 Sep 2022 11:40:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7FD31302EF3;
        Thu, 15 Sep 2022 13:39:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6A3E729AADBE4; Thu, 15 Sep 2022 13:39:40 +0200 (CEST)
Message-ID: <20220915111149.029587352@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 15 Sep 2022 13:11:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH v3 59/59] x86/retbleed: Add call depth tracking mitigation
References: <20220915111039.092790446@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The fully secure mitigation for RSB underflow on Intel SKL CPUs is IBRS,
which inflicts up to 30% penalty for pathological syscall heavy work loads.

Software based call depth tracking and RSB refill is not perfect, but
reduces the attack surface massively. The penalty for the pathological case
is about 8% which is still annoying but definitely more palatable than IBRS.

Add a retbleed=stuff command line option to enable the call depth tracking
and software refill of the RSB.

This gives admins a choice. IBeeRS are safe and cause headaches, call depth
tracking is considered to be s(t)ufficiently safe.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/cpu/bugs.c |   32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -787,6 +787,7 @@ enum retbleed_mitigation {
 	RETBLEED_MITIGATION_IBPB,
 	RETBLEED_MITIGATION_IBRS,
 	RETBLEED_MITIGATION_EIBRS,
+	RETBLEED_MITIGATION_STUFF,
 };
 
 enum retbleed_mitigation_cmd {
@@ -794,6 +795,7 @@ enum retbleed_mitigation_cmd {
 	RETBLEED_CMD_AUTO,
 	RETBLEED_CMD_UNRET,
 	RETBLEED_CMD_IBPB,
+	RETBLEED_CMD_STUFF,
 };
 
 static const char * const retbleed_strings[] = {
@@ -802,6 +804,7 @@ static const char * const retbleed_strin
 	[RETBLEED_MITIGATION_IBPB]	= "Mitigation: IBPB",
 	[RETBLEED_MITIGATION_IBRS]	= "Mitigation: IBRS",
 	[RETBLEED_MITIGATION_EIBRS]	= "Mitigation: Enhanced IBRS",
+	[RETBLEED_MITIGATION_STUFF]	= "Mitigation: Stuffing",
 };
 
 static enum retbleed_mitigation retbleed_mitigation __ro_after_init =
@@ -831,6 +834,8 @@ static int __init retbleed_parse_cmdline
 			retbleed_cmd = RETBLEED_CMD_UNRET;
 		} else if (!strcmp(str, "ibpb")) {
 			retbleed_cmd = RETBLEED_CMD_IBPB;
+		} else if (!strcmp(str, "stuff")) {
+			retbleed_cmd = RETBLEED_CMD_STUFF;
 		} else if (!strcmp(str, "nosmt")) {
 			retbleed_nosmt = true;
 		} else {
@@ -879,6 +884,21 @@ static void __init retbleed_select_mitig
 		}
 		break;
 
+	case RETBLEED_CMD_STUFF:
+		if (IS_ENABLED(CONFIG_CALL_DEPTH_TRACKING) &&
+		    spectre_v2_enabled == SPECTRE_V2_RETPOLINE) {
+			retbleed_mitigation = RETBLEED_MITIGATION_STUFF;
+
+		} else {
+			if (IS_ENABLED(CONFIG_CALL_DEPTH_TRACKING))
+				pr_err("WARNING: retbleed=stuff depends on spectre_v2=retpoline\n");
+			else
+				pr_err("WARNING: kernel not compiled with CALL_DEPTH_TRACKING.\n");
+
+			goto do_cmd_auto;
+		}
+		break;
+
 do_cmd_auto:
 	case RETBLEED_CMD_AUTO:
 	default:
@@ -916,6 +936,12 @@ static void __init retbleed_select_mitig
 		mitigate_smt = true;
 		break;
 
+	case RETBLEED_MITIGATION_STUFF:
+		setup_force_cpu_cap(X86_FEATURE_RETHUNK);
+		setup_force_cpu_cap(X86_FEATURE_CALL_DEPTH);
+		x86_set_skl_return_thunk();
+		break;
+
 	default:
 		break;
 	}
@@ -926,7 +952,7 @@ static void __init retbleed_select_mitig
 
 	/*
 	 * Let IBRS trump all on Intel without affecting the effects of the
-	 * retbleed= cmdline option.
+	 * retbleed= cmdline option except for call depth based stuffing
 	 */
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) {
 		switch (spectre_v2_enabled) {
@@ -939,7 +965,8 @@ static void __init retbleed_select_mitig
 			retbleed_mitigation = RETBLEED_MITIGATION_EIBRS;
 			break;
 		default:
-			pr_err(RETBLEED_INTEL_MSG);
+			if (retbleed_mitigation != RETBLEED_MITIGATION_STUFF)
+				pr_err(RETBLEED_INTEL_MSG);
 		}
 	}
 
@@ -1413,6 +1440,7 @@ static void __init spectre_v2_select_mit
 		if (IS_ENABLED(CONFIG_CPU_IBRS_ENTRY) &&
 		    boot_cpu_has_bug(X86_BUG_RETBLEED) &&
 		    retbleed_cmd != RETBLEED_CMD_OFF &&
+		    retbleed_cmd != RETBLEED_CMD_STUFF &&
 		    boot_cpu_has(X86_FEATURE_IBRS) &&
 		    boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) {
 			mode = SPECTRE_V2_IBRS;


