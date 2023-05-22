Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E5270CAF3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 22:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjEVU16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 16:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjEVU1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 16:27:41 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97699B6
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 13:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Zh3bYVOZOPUlrTfXXZ/bsZ3x6YiftJS2QmsY9wi74fQ=; b=dXcUsvzI0SN0+FUW095bojxrcq
        j3moMPN/SZCFl8M4OcCIcG18t6tQ7db8Hg+s6g5xcpb0gtTKm5MeotymxCoV41YVQ8QI767b3F1fe
        dQSORh4TqJd0geGec4tMsaFFN/ikekxUcIFc3V7m3WBfvjx5NCKag7BQmgudmxDytdNnDJt3p/cWB
        +pmrMHxTsLQuhF8zxW6kJGZO4FWwwxNXASn//wuPr4KFR7uctOnnNUV7sLNEhnVt6DOqxoxcyvsSB
        AaqXa4ORxl/SeyAQOsnzdpklUAdMVDwjX6sORPGivT0uLSe8tRgNO5ndryLS9oIULseKo4hmWj0yg
        FUCZqoug==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1C7Q-0028W2-1I;
        Mon, 22 May 2023 20:27:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 860813002C5;
        Mon, 22 May 2023 22:26:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 486A52416EAFC; Mon, 22 May 2023 22:26:59 +0200 (CEST)
Date:   Mon, 22 May 2023 22:26:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com,
        tony.luck@intel.com
Subject: Re: [PATCH V2 1/6] perf/x86/intel: Add Grand Ridge and Sierra Forest
Message-ID: <20230522202659.GC3334667@hirez.programming.kicks-ass.net>
References: <20230522113040.2329924-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522113040.2329924-1-kan.liang@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 04:30:35AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The Grand Ridge and Sierra Forest are successors to Snow Ridge. They
> both have Crestmont core. From the core PMU's perspective, they are
> similar to the e-core of MTL. The only difference is the LBR event
> logging feature, which will be implemented in the following patches.
> 
> Create a non-hybrid PMU setup for Grand Ridge and Sierra Forest.

Moo... Tony, did you sneak product names instead of uarch names in the
intel-family thing again?

That is; I'm thinking we want the below, no?

---

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index b3af2d45bbbb..0e804d189e63 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -116,16 +116,16 @@
 #define INTEL_FAM6_ALDERLAKE_L		0x9A	/* Golden Cove / Gracemont */
 #define INTEL_FAM6_ALDERLAKE_N		0xBE
 
-#define INTEL_FAM6_RAPTORLAKE		0xB7
+#define INTEL_FAM6_RAPTORLAKE		0xB7	/* Raptor Cove / Enhanced Gracemont */
 #define INTEL_FAM6_RAPTORLAKE_P		0xBA
 #define INTEL_FAM6_RAPTORLAKE_S		0xBF
 
-#define INTEL_FAM6_METEORLAKE		0xAC
+#define INTEL_FAM6_METEORLAKE		0xAC	/* Redwood Cove / Crestmont */
 #define INTEL_FAM6_METEORLAKE_L		0xAA
 
-#define INTEL_FAM6_LUNARLAKE_M		0xBD
+#define INTEL_FAM6_ARROWLAKE		0xC6	/* Lion Cove / Skymont */
 
-#define INTEL_FAM6_ARROWLAKE		0xC6
+#define INTEL_FAM6_LUNARLAKE_M		0xBD
 
 /* "Small Core" Processors (Atom/E-Core) */
 
@@ -154,9 +154,8 @@
 #define INTEL_FAM6_ATOM_TREMONT		0x96 /* Elkhart Lake */
 #define INTEL_FAM6_ATOM_TREMONT_L	0x9C /* Jasper Lake */
 
-#define INTEL_FAM6_SIERRAFOREST_X	0xAF
-
-#define INTEL_FAM6_GRANDRIDGE		0xB6
+#define INTEL_FAM6_ATOM_CRESTMONT_X	0xAF /* Sierra Forest */
+#define INTEL_FAM6_ATOM_CRESTMONT	0xB6 /* Grand Ridge */
 
 /* Xeon Phi */
 
