Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F5F667798
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 15:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240000AbjALOpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 09:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239846AbjALOpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 09:45:03 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DD559F82
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 06:33:14 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id u19so45159513ejm.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 06:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=tTUS5Ib5L4vpCmqPKce5u4nmNslWgk62O1T35Ktv4Co=;
        b=PcQrWdVV9jbtU2P5vhKn26v+5DFZ1ZjRgz6BtKtbkAKA7+SjcTlmgX8P84Vx+TjiQM
         P4odc4FDE5LQHJTLu4fo8gW9cKC+PQb4+v/LdIsdXAEtSyLCQvu/vxg8FUiI/JxjXU72
         8mB1oINvBtKA1OvRdVLSvfR0Ie/k7BFcbWZ+ztUwEZYpE93lJ++OJAVEj2XU3HYNWtsh
         +lJgE1Kug8FK4QWv4i2zGhpuKKQxVYOJXuaS3qptiQCxRRn3sgJtz3F6XcohmKXt8VbB
         4qdj+cscpOjV/3H9A5xjY8IXcJ1ZjLjQIsz1fuvA2zd6CDPA1pPtebrNjKBtrlUUArzv
         nOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tTUS5Ib5L4vpCmqPKce5u4nmNslWgk62O1T35Ktv4Co=;
        b=A2cgeLLVKEYdnh4nypwzdGLB+a8ED5EbZhFw7e1B5Uj/cOtwl11yCWPUXppErlrrOD
         BxpEv78OKcxtAqKBAwd1auj4H2/hym4HOg9Ae1M99I7G6muFn5MhuE/aFCL2Ye4aMkgg
         a9jF4iacQInRHh3U2O3naoFeSZx6rn+T5yOAovA9u7IaDQN5vlLFAHap6Pa86rTeQ00Y
         Da7vpIPFBI0qfe9ZYGpdvIIeOlpgbRUtCK9DA0YfAF7k5tZ4uibOncO7G/IWhK46Oa5h
         6TJ3NY/Zf639H747u9ABYwThijPuWesBgkapmWhOTCOLvQzaUWPSO+rpqc7DmVx12D6+
         ZsnQ==
X-Gm-Message-State: AFqh2kps9MDs7NrI+kV8pBBxuiuH+l7Hodtjd8upzgGkqsEDYIphP0r9
        IwY0NRP+tulYLkmvB6dw1bM=
X-Google-Smtp-Source: AMrXdXv3pTvoqvc3jsQd9a+1nvBcDLErUd/RJMOk8kg13nzGTOJl010vgieHqCM8u4PrV3TvnqvADA==
X-Received: by 2002:a17:907:3e26:b0:7ad:c8d7:4fd9 with SMTP id hp38-20020a1709073e2600b007adc8d74fd9mr86724322ejc.36.1673533992588;
        Thu, 12 Jan 2023 06:33:12 -0800 (PST)
Received: from gmail.com (1F2EF2EB.nat.pool.telekom.hu. [31.46.242.235])
        by smtp.gmail.com with ESMTPSA id y20-20020a170906559400b0084d44bff4a2sm5417518ejp.39.2023.01.12.06.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 06:33:12 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 12 Jan 2023 15:33:10 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [RFC GIT PULL] perf events HW enablement fixes
Message-ID: <Y8AaJiSbVI99WlPm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2023-01-12

   # HEAD: 5268a2842066c227e6ccd94bac562f1e1000244f perf/x86/intel/uncore: Add Emerald Rapids

- More hardware-enablement for Intel Meteor Lake & Emerald Rapid systems:
  pure model ID enumeration additions that do not affect other systems.

NOTE: Sending this as an RFC as it's trivial hardware-enablement. Feel free to
      skip this & we'll merge it into the -next stream of perf commits. No
      other fixes are mixed into this tree.

 Thanks,

	Ingo

------------------>
Kan Liang (4):
      perf/x86/cstate: Add Meteor Lake support
      perf/x86/msr: Add Meteor Lake support
      perf/x86/msr: Add Emerald Rapids
      perf/x86/intel/uncore: Add Emerald Rapids


 arch/x86/events/intel/cstate.c | 21 ++++++++++++---------
 arch/x86/events/intel/uncore.c |  1 +
 arch/x86/events/msr.c          |  3 +++
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index a2834bc93149..3019fb1926e3 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -41,6 +41,7 @@
  *	MSR_CORE_C1_RES: CORE C1 Residency Counter
  *			 perf code: 0x00
  *			 Available model: SLM,AMT,GLM,CNL,ICX,TNT,ADL,RPL
+ *					  MTL
  *			 Scope: Core (each processor core has a MSR)
  *	MSR_CORE_C3_RESIDENCY: CORE C3 Residency Counter
  *			       perf code: 0x01
@@ -51,50 +52,50 @@
  *			       perf code: 0x02
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
  *						SKL,KNL,GLM,CNL,KBL,CML,ICL,ICX,
- *						TGL,TNT,RKL,ADL,RPL,SPR
+ *						TGL,TNT,RKL,ADL,RPL,SPR,MTL
  *			       Scope: Core
  *	MSR_CORE_C7_RESIDENCY: CORE C7 Residency Counter
  *			       perf code: 0x03
  *			       Available model: SNB,IVB,HSW,BDW,SKL,CNL,KBL,CML,
- *						ICL,TGL,RKL,ADL,RPL
+ *						ICL,TGL,RKL,ADL,RPL,MTL
  *			       Scope: Core
  *	MSR_PKG_C2_RESIDENCY:  Package C2 Residency Counter.
  *			       perf code: 0x00
  *			       Available model: SNB,IVB,HSW,BDW,SKL,KNL,GLM,CNL,
  *						KBL,CML,ICL,ICX,TGL,TNT,RKL,ADL,
- *						RPL,SPR
+ *						RPL,SPR,MTL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C3_RESIDENCY:  Package C3 Residency Counter.
  *			       perf code: 0x01
  *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,KNL,
  *						GLM,CNL,KBL,CML,ICL,TGL,TNT,RKL,
- *						ADL,RPL
+ *						ADL,RPL,MTL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C6_RESIDENCY:  Package C6 Residency Counter.
  *			       perf code: 0x02
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
  *						SKL,KNL,GLM,CNL,KBL,CML,ICL,ICX,
- *						TGL,TNT,RKL,ADL,RPL,SPR
+ *						TGL,TNT,RKL,ADL,RPL,SPR,MTL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C7_RESIDENCY:  Package C7 Residency Counter.
  *			       perf code: 0x03
  *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,CNL,
- *						KBL,CML,ICL,TGL,RKL,ADL,RPL
+ *						KBL,CML,ICL,TGL,RKL,ADL,RPL,MTL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C8_RESIDENCY:  Package C8 Residency Counter.
  *			       perf code: 0x04
  *			       Available model: HSW ULT,KBL,CNL,CML,ICL,TGL,RKL,
- *						ADL,RPL
+ *						ADL,RPL,MTL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C9_RESIDENCY:  Package C9 Residency Counter.
  *			       perf code: 0x05
  *			       Available model: HSW ULT,KBL,CNL,CML,ICL,TGL,RKL,
- *						ADL,RPL
+ *						ADL,RPL,MTL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C10_RESIDENCY: Package C10 Residency Counter.
  *			       perf code: 0x06
  *			       Available model: HSW ULT,KBL,GLM,CNL,CML,ICL,TGL,
- *						TNT,RKL,ADL,RPL
+ *						TNT,RKL,ADL,RPL,MTL
  *			       Scope: Package (physical package)
  *
  */
@@ -686,6 +687,8 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		&adl_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,	&adl_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,	&adl_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE,		&adl_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L,	&adl_cstates),
 	{ },
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_cstates_match);
diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 6f1ccc57a692..459b1aafd4d4 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1833,6 +1833,7 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,	&adl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,	&adl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&spr_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X,	&spr_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	&snr_uncore_init),
 	{},
 };
diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index ecced3a52668..c65d8906cbcf 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -69,6 +69,7 @@ static bool test_intel(int idx, void *data)
 	case INTEL_FAM6_BROADWELL_G:
 	case INTEL_FAM6_BROADWELL_X:
 	case INTEL_FAM6_SAPPHIRERAPIDS_X:
+	case INTEL_FAM6_EMERALDRAPIDS_X:
 
 	case INTEL_FAM6_ATOM_SILVERMONT:
 	case INTEL_FAM6_ATOM_SILVERMONT_D:
@@ -107,6 +108,8 @@ static bool test_intel(int idx, void *data)
 	case INTEL_FAM6_RAPTORLAKE:
 	case INTEL_FAM6_RAPTORLAKE_P:
 	case INTEL_FAM6_RAPTORLAKE_S:
+	case INTEL_FAM6_METEORLAKE:
+	case INTEL_FAM6_METEORLAKE_L:
 		if (idx == PERF_MSR_SMI || idx == PERF_MSR_PPERF)
 			return true;
 		break;
