Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19656BF1EA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 20:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjCQTus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 15:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCQTul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 15:50:41 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453EF3A87E
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 12:50:37 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536a5a0b6e3so57147197b3.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 12:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679082636;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JYKiiAW36kav58TD+ohegNsaYsBLR1puAj7BDGv215E=;
        b=azJlh6q/CZypaKJMzQxBPQmoW9WIehYs+o6Ff+B0vG6V2vKR7zbKsl/W4XHfc2UofZ
         xNlS05rahceyUr5+oNVH2fpAZdbH73aIRqHZ+1v7+R8KO+Kq3TxBhZ4xV6H/DT6gZjdb
         883pZHpR7dX4YDUGbqSQ8dcpprtCGUXd9/0NBNQ1eMes2CWjLtsRwbsqGL02Vbdz9INn
         OLzCLe6a1xKcr1nQy1ntGabXhkh59upGTgLXvEQ5D2ck639CaolmustNDN7qn5ZgLjhN
         1kNmD3+XYlNHetUA3zGRlWJY4Axou+H/lCR0tdoHmH0nIDdaX8cDODyfvjlaqkstmHVe
         5Ilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679082636;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JYKiiAW36kav58TD+ohegNsaYsBLR1puAj7BDGv215E=;
        b=GTRsFvt9mvkbwNhchoMeyjErFQO8yEXKtgwvxqs/2xq3dL9ymFr5uWR63zGLWvq1M8
         g9Dulfy04Peb/b97bfjz4FDc+mUaJi7elaO8mGbqjsbGucjoLFCelkl9LO98sa0xxl2t
         uKO+9xgp2ud8fLINK8RtouXajULFLMPUFaMfz1WZSw9Ur8DQk8dCAu9lHrBC3tDvx6x/
         Ps8nkPfwMEYAx3hJozoGkUuWVUdClnbov1v8oJKeyclmO7396SF0KTCaNDiImuHq3+kQ
         YIizj7fmvKQ1AL9JQ4S/bSgTEkXOBl7AZVznf06Ms64+oIDgOJqbq2IH5wtwXsNWWGv9
         V7Kg==
X-Gm-Message-State: AO0yUKXw+3S3O5d37nl8Njt/9r+XYIocsLiCc2rfLYGCplRqWHXNJGek
        t83MPvfTM8CdoUCCdDTmrmREqjIdeyNeEy4=
X-Google-Smtp-Source: AK7set+6ybvyHiom5mLcXOUaMjhvIAnqDRV2LHjlz/38lIDMH8G7D+3Jupc0521W7F/pBOEt2kzQTd+X13njxco=
X-Received: from zaidcloud.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5325])
 (user=zalbassam job=sendgmr) by 2002:a05:6902:4cc:b0:98e:6280:74ca with SMTP
 id v12-20020a05690204cc00b0098e628074camr532177ybs.1.1679082636385; Fri, 17
 Mar 2023 12:50:36 -0700 (PDT)
Date:   Fri, 17 Mar 2023 15:50:20 -0400
In-Reply-To: <20230317195027.3746949-1-zalbassam@google.com>
Mime-Version: 1.0
References: <20230317195027.3746949-1-zalbassam@google.com>
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
Message-ID: <20230317195027.3746949-2-zalbassam@google.com>
Subject: [PATCH v4 1/8] arm64: perf: Move PMUv3 driver to drivers/perf
From:   Zaid Al-Bassam <zalbassam@google.com>
To:     Jesus Sanchez-Palencia <jesussanp@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, f.fainelli@gmail.com
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Zaid Al-Bassam <zalbassam@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_IN_DEF_DKIM_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Zyngier <marc.zyngier@arm.com>

Having the ARM PMUv3 driver sitting in arch/arm64/kernel is getting
in the way of being able to use perf on ARMv8 cores running a 32bit
kernel, such as 32bit KVM guests.

This patch moves it into drivers/perf/arm_pmuv3.c, with an include
file in include/linux/perf/arm_pmuv3.h. The only thing left in
arch/arm64 is some mundane perf stuff.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Zaid Al-Bassam <zalbassam@google.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/perf_event.h           | 249 -----------------
 arch/arm64/kernel/Makefile                    |   1 -
 drivers/perf/Kconfig                          |  11 +
 drivers/perf/Makefile                         |   1 +
 .../perf_event.c => drivers/perf/arm_pmuv3.c  |   1 +
 include/kvm/arm_pmu.h                         |   2 +-
 include/linux/perf/arm_pmuv3.h                | 258 ++++++++++++++++++
 7 files changed, 272 insertions(+), 251 deletions(-)
 rename arch/arm64/kernel/perf_event.c => drivers/perf/arm_pmuv3.c (99%)
 create mode 100644 include/linux/perf/arm_pmuv3.h

diff --git a/arch/arm64/include/asm/perf_event.h b/arch/arm64/include/asm/perf_event.h
index 3eaf462f5752..eb7071c9eb34 100644
--- a/arch/arm64/include/asm/perf_event.h
+++ b/arch/arm64/include/asm/perf_event.h
@@ -9,255 +9,6 @@
 #include <asm/stack_pointer.h>
 #include <asm/ptrace.h>
 
-#define	ARMV8_PMU_MAX_COUNTERS	32
-#define	ARMV8_PMU_COUNTER_MASK	(ARMV8_PMU_MAX_COUNTERS - 1)
-
-/*
- * Common architectural and microarchitectural event numbers.
- */
-#define ARMV8_PMUV3_PERFCTR_SW_INCR				0x0000
-#define ARMV8_PMUV3_PERFCTR_L1I_CACHE_REFILL			0x0001
-#define ARMV8_PMUV3_PERFCTR_L1I_TLB_REFILL			0x0002
-#define ARMV8_PMUV3_PERFCTR_L1D_CACHE_REFILL			0x0003
-#define ARMV8_PMUV3_PERFCTR_L1D_CACHE				0x0004
-#define ARMV8_PMUV3_PERFCTR_L1D_TLB_REFILL			0x0005
-#define ARMV8_PMUV3_PERFCTR_LD_RETIRED				0x0006
-#define ARMV8_PMUV3_PERFCTR_ST_RETIRED				0x0007
-#define ARMV8_PMUV3_PERFCTR_INST_RETIRED			0x0008
-#define ARMV8_PMUV3_PERFCTR_EXC_TAKEN				0x0009
-#define ARMV8_PMUV3_PERFCTR_EXC_RETURN				0x000A
-#define ARMV8_PMUV3_PERFCTR_CID_WRITE_RETIRED			0x000B
-#define ARMV8_PMUV3_PERFCTR_PC_WRITE_RETIRED			0x000C
-#define ARMV8_PMUV3_PERFCTR_BR_IMMED_RETIRED			0x000D
-#define ARMV8_PMUV3_PERFCTR_BR_RETURN_RETIRED			0x000E
-#define ARMV8_PMUV3_PERFCTR_UNALIGNED_LDST_RETIRED		0x000F
-#define ARMV8_PMUV3_PERFCTR_BR_MIS_PRED				0x0010
-#define ARMV8_PMUV3_PERFCTR_CPU_CYCLES				0x0011
-#define ARMV8_PMUV3_PERFCTR_BR_PRED				0x0012
-#define ARMV8_PMUV3_PERFCTR_MEM_ACCESS				0x0013
-#define ARMV8_PMUV3_PERFCTR_L1I_CACHE				0x0014
-#define ARMV8_PMUV3_PERFCTR_L1D_CACHE_WB			0x0015
-#define ARMV8_PMUV3_PERFCTR_L2D_CACHE				0x0016
-#define ARMV8_PMUV3_PERFCTR_L2D_CACHE_REFILL			0x0017
-#define ARMV8_PMUV3_PERFCTR_L2D_CACHE_WB			0x0018
-#define ARMV8_PMUV3_PERFCTR_BUS_ACCESS				0x0019
-#define ARMV8_PMUV3_PERFCTR_MEMORY_ERROR			0x001A
-#define ARMV8_PMUV3_PERFCTR_INST_SPEC				0x001B
-#define ARMV8_PMUV3_PERFCTR_TTBR_WRITE_RETIRED			0x001C
-#define ARMV8_PMUV3_PERFCTR_BUS_CYCLES				0x001D
-#define ARMV8_PMUV3_PERFCTR_CHAIN				0x001E
-#define ARMV8_PMUV3_PERFCTR_L1D_CACHE_ALLOCATE			0x001F
-#define ARMV8_PMUV3_PERFCTR_L2D_CACHE_ALLOCATE			0x0020
-#define ARMV8_PMUV3_PERFCTR_BR_RETIRED				0x0021
-#define ARMV8_PMUV3_PERFCTR_BR_MIS_PRED_RETIRED			0x0022
-#define ARMV8_PMUV3_PERFCTR_STALL_FRONTEND			0x0023
-#define ARMV8_PMUV3_PERFCTR_STALL_BACKEND			0x0024
-#define ARMV8_PMUV3_PERFCTR_L1D_TLB				0x0025
-#define ARMV8_PMUV3_PERFCTR_L1I_TLB				0x0026
-#define ARMV8_PMUV3_PERFCTR_L2I_CACHE				0x0027
-#define ARMV8_PMUV3_PERFCTR_L2I_CACHE_REFILL			0x0028
-#define ARMV8_PMUV3_PERFCTR_L3D_CACHE_ALLOCATE			0x0029
-#define ARMV8_PMUV3_PERFCTR_L3D_CACHE_REFILL			0x002A
-#define ARMV8_PMUV3_PERFCTR_L3D_CACHE				0x002B
-#define ARMV8_PMUV3_PERFCTR_L3D_CACHE_WB			0x002C
-#define ARMV8_PMUV3_PERFCTR_L2D_TLB_REFILL			0x002D
-#define ARMV8_PMUV3_PERFCTR_L2I_TLB_REFILL			0x002E
-#define ARMV8_PMUV3_PERFCTR_L2D_TLB				0x002F
-#define ARMV8_PMUV3_PERFCTR_L2I_TLB				0x0030
-#define ARMV8_PMUV3_PERFCTR_REMOTE_ACCESS			0x0031
-#define ARMV8_PMUV3_PERFCTR_LL_CACHE				0x0032
-#define ARMV8_PMUV3_PERFCTR_LL_CACHE_MISS			0x0033
-#define ARMV8_PMUV3_PERFCTR_DTLB_WALK				0x0034
-#define ARMV8_PMUV3_PERFCTR_ITLB_WALK				0x0035
-#define ARMV8_PMUV3_PERFCTR_LL_CACHE_RD				0x0036
-#define ARMV8_PMUV3_PERFCTR_LL_CACHE_MISS_RD			0x0037
-#define ARMV8_PMUV3_PERFCTR_REMOTE_ACCESS_RD			0x0038
-#define ARMV8_PMUV3_PERFCTR_L1D_CACHE_LMISS_RD			0x0039
-#define ARMV8_PMUV3_PERFCTR_OP_RETIRED				0x003A
-#define ARMV8_PMUV3_PERFCTR_OP_SPEC				0x003B
-#define ARMV8_PMUV3_PERFCTR_STALL				0x003C
-#define ARMV8_PMUV3_PERFCTR_STALL_SLOT_BACKEND			0x003D
-#define ARMV8_PMUV3_PERFCTR_STALL_SLOT_FRONTEND			0x003E
-#define ARMV8_PMUV3_PERFCTR_STALL_SLOT				0x003F
-
-/* Statistical profiling extension microarchitectural events */
-#define	ARMV8_SPE_PERFCTR_SAMPLE_POP				0x4000
-#define	ARMV8_SPE_PERFCTR_SAMPLE_FEED				0x4001
-#define	ARMV8_SPE_PERFCTR_SAMPLE_FILTRATE			0x4002
-#define	ARMV8_SPE_PERFCTR_SAMPLE_COLLISION			0x4003
-
-/* AMUv1 architecture events */
-#define	ARMV8_AMU_PERFCTR_CNT_CYCLES				0x4004
-#define	ARMV8_AMU_PERFCTR_STALL_BACKEND_MEM			0x4005
-
-/* long-latency read miss events */
-#define	ARMV8_PMUV3_PERFCTR_L1I_CACHE_LMISS			0x4006
-#define	ARMV8_PMUV3_PERFCTR_L2D_CACHE_LMISS_RD			0x4009
-#define	ARMV8_PMUV3_PERFCTR_L2I_CACHE_LMISS			0x400A
-#define	ARMV8_PMUV3_PERFCTR_L3D_CACHE_LMISS_RD			0x400B
-
-/* Trace buffer events */
-#define ARMV8_PMUV3_PERFCTR_TRB_WRAP				0x400C
-#define ARMV8_PMUV3_PERFCTR_TRB_TRIG				0x400E
-
-/* Trace unit events */
-#define ARMV8_PMUV3_PERFCTR_TRCEXTOUT0				0x4010
-#define ARMV8_PMUV3_PERFCTR_TRCEXTOUT1				0x4011
-#define ARMV8_PMUV3_PERFCTR_TRCEXTOUT2				0x4012
-#define ARMV8_PMUV3_PERFCTR_TRCEXTOUT3				0x4013
-#define ARMV8_PMUV3_PERFCTR_CTI_TRIGOUT4			0x4018
-#define ARMV8_PMUV3_PERFCTR_CTI_TRIGOUT5			0x4019
-#define ARMV8_PMUV3_PERFCTR_CTI_TRIGOUT6			0x401A
-#define ARMV8_PMUV3_PERFCTR_CTI_TRIGOUT7			0x401B
-
-/* additional latency from alignment events */
-#define	ARMV8_PMUV3_PERFCTR_LDST_ALIGN_LAT			0x4020
-#define	ARMV8_PMUV3_PERFCTR_LD_ALIGN_LAT			0x4021
-#define	ARMV8_PMUV3_PERFCTR_ST_ALIGN_LAT			0x4022
-
-/* Armv8.5 Memory Tagging Extension events */
-#define	ARMV8_MTE_PERFCTR_MEM_ACCESS_CHECKED			0x4024
-#define	ARMV8_MTE_PERFCTR_MEM_ACCESS_CHECKED_RD			0x4025
-#define	ARMV8_MTE_PERFCTR_MEM_ACCESS_CHECKED_WR			0x4026
-
-/* ARMv8 recommended implementation defined event types */
-#define ARMV8_IMPDEF_PERFCTR_L1D_CACHE_RD			0x0040
-#define ARMV8_IMPDEF_PERFCTR_L1D_CACHE_WR			0x0041
-#define ARMV8_IMPDEF_PERFCTR_L1D_CACHE_REFILL_RD		0x0042
-#define ARMV8_IMPDEF_PERFCTR_L1D_CACHE_REFILL_WR		0x0043
-#define ARMV8_IMPDEF_PERFCTR_L1D_CACHE_REFILL_INNER		0x0044
-#define ARMV8_IMPDEF_PERFCTR_L1D_CACHE_REFILL_OUTER		0x0045
-#define ARMV8_IMPDEF_PERFCTR_L1D_CACHE_WB_VICTIM		0x0046
-#define ARMV8_IMPDEF_PERFCTR_L1D_CACHE_WB_CLEAN			0x0047
-#define ARMV8_IMPDEF_PERFCTR_L1D_CACHE_INVAL			0x0048
-
-#define ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_RD			0x004C
-#define ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_WR			0x004D
-#define ARMV8_IMPDEF_PERFCTR_L1D_TLB_RD				0x004E
-#define ARMV8_IMPDEF_PERFCTR_L1D_TLB_WR				0x004F
-#define ARMV8_IMPDEF_PERFCTR_L2D_CACHE_RD			0x0050
-#define ARMV8_IMPDEF_PERFCTR_L2D_CACHE_WR			0x0051
-#define ARMV8_IMPDEF_PERFCTR_L2D_CACHE_REFILL_RD		0x0052
-#define ARMV8_IMPDEF_PERFCTR_L2D_CACHE_REFILL_WR		0x0053
-
-#define ARMV8_IMPDEF_PERFCTR_L2D_CACHE_WB_VICTIM		0x0056
-#define ARMV8_IMPDEF_PERFCTR_L2D_CACHE_WB_CLEAN			0x0057
-#define ARMV8_IMPDEF_PERFCTR_L2D_CACHE_INVAL			0x0058
-
-#define ARMV8_IMPDEF_PERFCTR_L2D_TLB_REFILL_RD			0x005C
-#define ARMV8_IMPDEF_PERFCTR_L2D_TLB_REFILL_WR			0x005D
-#define ARMV8_IMPDEF_PERFCTR_L2D_TLB_RD				0x005E
-#define ARMV8_IMPDEF_PERFCTR_L2D_TLB_WR				0x005F
-#define ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_RD			0x0060
-#define ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_WR			0x0061
-#define ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_SHARED			0x0062
-#define ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_NOT_SHARED		0x0063
-#define ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_NORMAL			0x0064
-#define ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_PERIPH			0x0065
-#define ARMV8_IMPDEF_PERFCTR_MEM_ACCESS_RD			0x0066
-#define ARMV8_IMPDEF_PERFCTR_MEM_ACCESS_WR			0x0067
-#define ARMV8_IMPDEF_PERFCTR_UNALIGNED_LD_SPEC			0x0068
-#define ARMV8_IMPDEF_PERFCTR_UNALIGNED_ST_SPEC			0x0069
-#define ARMV8_IMPDEF_PERFCTR_UNALIGNED_LDST_SPEC		0x006A
-
-#define ARMV8_IMPDEF_PERFCTR_LDREX_SPEC				0x006C
-#define ARMV8_IMPDEF_PERFCTR_STREX_PASS_SPEC			0x006D
-#define ARMV8_IMPDEF_PERFCTR_STREX_FAIL_SPEC			0x006E
-#define ARMV8_IMPDEF_PERFCTR_STREX_SPEC				0x006F
-#define ARMV8_IMPDEF_PERFCTR_LD_SPEC				0x0070
-#define ARMV8_IMPDEF_PERFCTR_ST_SPEC				0x0071
-#define ARMV8_IMPDEF_PERFCTR_LDST_SPEC				0x0072
-#define ARMV8_IMPDEF_PERFCTR_DP_SPEC				0x0073
-#define ARMV8_IMPDEF_PERFCTR_ASE_SPEC				0x0074
-#define ARMV8_IMPDEF_PERFCTR_VFP_SPEC				0x0075
-#define ARMV8_IMPDEF_PERFCTR_PC_WRITE_SPEC			0x0076
-#define ARMV8_IMPDEF_PERFCTR_CRYPTO_SPEC			0x0077
-#define ARMV8_IMPDEF_PERFCTR_BR_IMMED_SPEC			0x0078
-#define ARMV8_IMPDEF_PERFCTR_BR_RETURN_SPEC			0x0079
-#define ARMV8_IMPDEF_PERFCTR_BR_INDIRECT_SPEC			0x007A
-
-#define ARMV8_IMPDEF_PERFCTR_ISB_SPEC				0x007C
-#define ARMV8_IMPDEF_PERFCTR_DSB_SPEC				0x007D
-#define ARMV8_IMPDEF_PERFCTR_DMB_SPEC				0x007E
-
-#define ARMV8_IMPDEF_PERFCTR_EXC_UNDEF				0x0081
-#define ARMV8_IMPDEF_PERFCTR_EXC_SVC				0x0082
-#define ARMV8_IMPDEF_PERFCTR_EXC_PABORT				0x0083
-#define ARMV8_IMPDEF_PERFCTR_EXC_DABORT				0x0084
-
-#define ARMV8_IMPDEF_PERFCTR_EXC_IRQ				0x0086
-#define ARMV8_IMPDEF_PERFCTR_EXC_FIQ				0x0087
-#define ARMV8_IMPDEF_PERFCTR_EXC_SMC				0x0088
-
-#define ARMV8_IMPDEF_PERFCTR_EXC_HVC				0x008A
-#define ARMV8_IMPDEF_PERFCTR_EXC_TRAP_PABORT			0x008B
-#define ARMV8_IMPDEF_PERFCTR_EXC_TRAP_DABORT			0x008C
-#define ARMV8_IMPDEF_PERFCTR_EXC_TRAP_OTHER			0x008D
-#define ARMV8_IMPDEF_PERFCTR_EXC_TRAP_IRQ			0x008E
-#define ARMV8_IMPDEF_PERFCTR_EXC_TRAP_FIQ			0x008F
-#define ARMV8_IMPDEF_PERFCTR_RC_LD_SPEC				0x0090
-#define ARMV8_IMPDEF_PERFCTR_RC_ST_SPEC				0x0091
-
-#define ARMV8_IMPDEF_PERFCTR_L3D_CACHE_RD			0x00A0
-#define ARMV8_IMPDEF_PERFCTR_L3D_CACHE_WR			0x00A1
-#define ARMV8_IMPDEF_PERFCTR_L3D_CACHE_REFILL_RD		0x00A2
-#define ARMV8_IMPDEF_PERFCTR_L3D_CACHE_REFILL_WR		0x00A3
-
-#define ARMV8_IMPDEF_PERFCTR_L3D_CACHE_WB_VICTIM		0x00A6
-#define ARMV8_IMPDEF_PERFCTR_L3D_CACHE_WB_CLEAN			0x00A7
-#define ARMV8_IMPDEF_PERFCTR_L3D_CACHE_INVAL			0x00A8
-
-/*
- * Per-CPU PMCR: config reg
- */
-#define ARMV8_PMU_PMCR_E	(1 << 0) /* Enable all counters */
-#define ARMV8_PMU_PMCR_P	(1 << 1) /* Reset all counters */
-#define ARMV8_PMU_PMCR_C	(1 << 2) /* Cycle counter reset */
-#define ARMV8_PMU_PMCR_D	(1 << 3) /* CCNT counts every 64th cpu cycle */
-#define ARMV8_PMU_PMCR_X	(1 << 4) /* Export to ETM */
-#define ARMV8_PMU_PMCR_DP	(1 << 5) /* Disable CCNT if non-invasive debug*/
-#define ARMV8_PMU_PMCR_LC	(1 << 6) /* Overflow on 64 bit cycle counter */
-#define ARMV8_PMU_PMCR_LP	(1 << 7) /* Long event counter enable */
-#define	ARMV8_PMU_PMCR_N_SHIFT	11	 /* Number of counters supported */
-#define	ARMV8_PMU_PMCR_N_MASK	0x1f
-#define	ARMV8_PMU_PMCR_MASK	0xff	 /* Mask for writable bits */
-
-/*
- * PMOVSR: counters overflow flag status reg
- */
-#define	ARMV8_PMU_OVSR_MASK		0xffffffff	/* Mask for writable bits */
-#define	ARMV8_PMU_OVERFLOWED_MASK	ARMV8_PMU_OVSR_MASK
-
-/*
- * PMXEVTYPER: Event selection reg
- */
-#define	ARMV8_PMU_EVTYPE_MASK	0xc800ffff	/* Mask for writable bits */
-#define	ARMV8_PMU_EVTYPE_EVENT	0xffff		/* Mask for EVENT bits */
-
-/*
- * Event filters for PMUv3
- */
-#define	ARMV8_PMU_EXCLUDE_EL1	(1U << 31)
-#define	ARMV8_PMU_EXCLUDE_EL0	(1U << 30)
-#define	ARMV8_PMU_INCLUDE_EL2	(1U << 27)
-
-/*
- * PMUSERENR: user enable reg
- */
-#define ARMV8_PMU_USERENR_MASK	0xf		/* Mask for writable bits */
-#define ARMV8_PMU_USERENR_EN	(1 << 0) /* PMU regs can be accessed at EL0 */
-#define ARMV8_PMU_USERENR_SW	(1 << 1) /* PMSWINC can be written at EL0 */
-#define ARMV8_PMU_USERENR_CR	(1 << 2) /* Cycle counter can be read at EL0 */
-#define ARMV8_PMU_USERENR_ER	(1 << 3) /* Event counter can be read at EL0 */
-
-/* PMMIR_EL1.SLOTS mask */
-#define ARMV8_PMU_SLOTS_MASK	0xff
-
-#define ARMV8_PMU_BUS_SLOTS_SHIFT 8
-#define ARMV8_PMU_BUS_SLOTS_MASK 0xff
-#define ARMV8_PMU_BUS_WIDTH_SHIFT 16
-#define ARMV8_PMU_BUS_WIDTH_MASK 0xf
-
 #ifdef CONFIG_PERF_EVENTS
 struct pt_regs;
 extern unsigned long perf_instruction_pointer(struct pt_regs *regs);
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index ceba6792f5b3..7c2bb4e72476 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -45,7 +45,6 @@ obj-$(CONFIG_FUNCTION_TRACER)		+= ftrace.o entry-ftrace.o
 obj-$(CONFIG_MODULES)			+= module.o
 obj-$(CONFIG_ARM64_MODULE_PLTS)		+= module-plts.o
 obj-$(CONFIG_PERF_EVENTS)		+= perf_regs.o perf_callchain.o
-obj-$(CONFIG_HW_PERF_EVENTS)		+= perf_event.o
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
 obj-$(CONFIG_CPU_PM)			+= sleep.o suspend.o
 obj-$(CONFIG_CPU_IDLE)			+= cpuidle.o
diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 66c259000a44..defe6b47854b 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -100,6 +100,17 @@ config ARM_SMMU_V3_PMU
 	   through the SMMU and allow the resulting information to be filtered
 	   based on the Stream ID of the corresponding master.
 
+config ARM_PMUV3
+	depends on HW_PERF_EVENTS && ARM64
+	bool "ARM PMUv3 support" if !ARM64
+	default y
+	  help
+	  Say y if you want to use the ARM performance monitor unit (PMU)
+	  version 3. The PMUv3 is the CPU performance monitors on ARMv8
+	  (aarch32 and aarch64) systems that implement the PMUv3
+	  architecture.
+	  Currently, PMUv3 is only supported on aarch64 (arm64)
+
 config ARM_DSU_PMU
 	tristate "ARM DynamIQ Shared Unit (DSU) PMU"
 	depends on ARM64
diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index 13e45da61100..dabc859540ce 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_ARM_CMN) += arm-cmn.o
 obj-$(CONFIG_ARM_DSU_PMU) += arm_dsu_pmu.o
 obj-$(CONFIG_ARM_PMU) += arm_pmu.o arm_pmu_platform.o
 obj-$(CONFIG_ARM_PMU_ACPI) += arm_pmu_acpi.o
+obj-$(CONFIG_ARM_PMUV3) += arm_pmuv3.o
 obj-$(CONFIG_ARM_SMMU_V3_PMU) += arm_smmuv3_pmu.o
 obj-$(CONFIG_FSL_IMX8_DDR_PMU) += fsl_imx8_ddr_perf.o
 obj-$(CONFIG_HISI_PMU) += hisilicon/
diff --git a/arch/arm64/kernel/perf_event.c b/drivers/perf/arm_pmuv3.c
similarity index 99%
rename from arch/arm64/kernel/perf_event.c
rename to drivers/perf/arm_pmuv3.c
index dde06c0f97f3..c25203f8b940 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -20,6 +20,7 @@
 #include <linux/kvm_host.h>
 #include <linux/of.h>
 #include <linux/perf/arm_pmu.h>
+#include <linux/perf/arm_pmuv3.h>
 #include <linux/platform_device.h>
 #include <linux/sched_clock.h>
 #include <linux/smp.h>
diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
index 628775334d5e..1a6a695ca67a 100644
--- a/include/kvm/arm_pmu.h
+++ b/include/kvm/arm_pmu.h
@@ -8,7 +8,7 @@
 #define __ASM_ARM_KVM_PMU_H
 
 #include <linux/perf_event.h>
-#include <asm/perf_event.h>
+#include <linux/perf/arm_pmuv3.h>
 
 #define ARMV8_PMU_CYCLE_IDX		(ARMV8_PMU_MAX_COUNTERS - 1)
 
diff --git a/include/linux/perf/arm_pmuv3.h b/include/linux/perf/arm_pmuv3.h
new file mode 100644
index 000000000000..53173abfc022
--- /dev/null
+++ b/include/linux/perf/arm_pmuv3.h
@@ -0,0 +1,258 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2012 ARM Ltd.
+ */
+
+#ifndef __PERF_ARM_PMUV3_H
+#define __PERF_ARM_PMUV3_H
+
+#define ARMV8_PMU_MAX_COUNTERS	32
+#define ARMV8_PMU_COUNTER_MASK	(ARMV8_PMU_MAX_COUNTERS - 1)
+
+/*
+ * Common architectural and microarchitectural event numbers.
+ */
+#define ARMV8_PMUV3_PERFCTR_SW_INCR				0x0000
+#define ARMV8_PMUV3_PERFCTR_L1I_CACHE_REFILL			0x0001
+#define ARMV8_PMUV3_PERFCTR_L1I_TLB_REFILL			0x0002
+#define ARMV8_PMUV3_PERFCTR_L1D_CACHE_REFILL			0x0003
+#define ARMV8_PMUV3_PERFCTR_L1D_CACHE				0x0004
+#define ARMV8_PMUV3_PERFCTR_L1D_TLB_REFILL			0x0005
+#define ARMV8_PMUV3_PERFCTR_LD_RETIRED				0x0006
+#define ARMV8_PMUV3_PERFCTR_ST_RETIRED				0x0007
+#define ARMV8_PMUV3_PERFCTR_INST_RETIRED			0x0008
+#define ARMV8_PMUV3_PERFCTR_EXC_TAKEN				0x0009
+#define ARMV8_PMUV3_PERFCTR_EXC_RETURN				0x000A
+#define ARMV8_PMUV3_PERFCTR_CID_WRITE_RETIRED			0x000B
+#define ARMV8_PMUV3_PERFCTR_PC_WRITE_RETIRED			0x000C
+#define ARMV8_PMUV3_PERFCTR_BR_IMMED_RETIRED			0x000D
+#define ARMV8_PMUV3_PERFCTR_BR_RETURN_RETIRED			0x000E
+#define ARMV8_PMUV3_PERFCTR_UNALIGNED_LDST_RETIRED		0x000F
+#define ARMV8_PMUV3_PERFCTR_BR_MIS_PRED				0x0010
+#define ARMV8_PMUV3_PERFCTR_CPU_CYCLES				0x0011
+#define ARMV8_PMUV3_PERFCTR_BR_PRED				0x0012
+#define ARMV8_PMUV3_PERFCTR_MEM_ACCESS				0x0013
+#define ARMV8_PMUV3_PERFCTR_L1I_CACHE				0x0014
+#define ARMV8_PMUV3_PERFCTR_L1D_CACHE_WB			0x0015
+#define ARMV8_PMUV3_PERFCTR_L2D_CACHE				0x0016
+#define ARMV8_PMUV3_PERFCTR_L2D_CACHE_REFILL			0x0017
+#define ARMV8_PMUV3_PERFCTR_L2D_CACHE_WB			0x0018
+#define ARMV8_PMUV3_PERFCTR_BUS_ACCESS				0x0019
+#define ARMV8_PMUV3_PERFCTR_MEMORY_ERROR			0x001A
+#define ARMV8_PMUV3_PERFCTR_INST_SPEC				0x001B
+#define ARMV8_PMUV3_PERFCTR_TTBR_WRITE_RETIRED			0x001C
+#define ARMV8_PMUV3_PERFCTR_BUS_CYCLES				0x001D
+#define ARMV8_PMUV3_PERFCTR_CHAIN				0x001E
+#define ARMV8_PMUV3_PERFCTR_L1D_CACHE_ALLOCATE			0x001F
+#define ARMV8_PMUV3_PERFCTR_L2D_CACHE_ALLOCATE			0x0020
+#define ARMV8_PMUV3_PERFCTR_BR_RETIRED				0x0021
+#define ARMV8_PMUV3_PERFCTR_BR_MIS_PRED_RETIRED			0x0022
+#define ARMV8_PMUV3_PERFCTR_STALL_FRONTEND			0x0023
+#define ARMV8_PMUV3_PERFCTR_STALL_BACKEND			0x0024
+#define ARMV8_PMUV3_PERFCTR_L1D_TLB				0x0025
+#define ARMV8_PMUV3_PERFCTR_L1I_TLB				0x0026
+#define ARMV8_PMUV3_PERFCTR_L2I_CACHE				0x0027
+#define ARMV8_PMUV3_PERFCTR_L2I_CACHE_REFILL			0x0028
+#define ARMV8_PMUV3_PERFCTR_L3D_CACHE_ALLOCATE			0x0029
+#define ARMV8_PMUV3_PERFCTR_L3D_CACHE_REFILL			0x002A
+#define ARMV8_PMUV3_PERFCTR_L3D_CACHE				0x002B
+#define ARMV8_PMUV3_PERFCTR_L3D_CACHE_WB			0x002C
+#define ARMV8_PMUV3_PERFCTR_L2D_TLB_REFILL			0x002D
+#define ARMV8_PMUV3_PERFCTR_L2I_TLB_REFILL			0x002E
+#define ARMV8_PMUV3_PERFCTR_L2D_TLB				0x002F
+#define ARMV8_PMUV3_PERFCTR_L2I_TLB				0x0030
+#define ARMV8_PMUV3_PERFCTR_REMOTE_ACCESS			0x0031
+#define ARMV8_PMUV3_PERFCTR_LL_CACHE				0x0032
+#define ARMV8_PMUV3_PERFCTR_LL_CACHE_MISS			0x0033
+#define ARMV8_PMUV3_PERFCTR_DTLB_WALK				0x0034
+#define ARMV8_PMUV3_PERFCTR_ITLB_WALK				0x0035
+#define ARMV8_PMUV3_PERFCTR_LL_CACHE_RD				0x0036
+#define ARMV8_PMUV3_PERFCTR_LL_CACHE_MISS_RD			0x0037
+#define ARMV8_PMUV3_PERFCTR_REMOTE_ACCESS_RD			0x0038
+#define ARMV8_PMUV3_PERFCTR_L1D_CACHE_LMISS_RD			0x0039
+#define ARMV8_PMUV3_PERFCTR_OP_RETIRED				0x003A
+#define ARMV8_PMUV3_PERFCTR_OP_SPEC				0x003B
+#define ARMV8_PMUV3_PERFCTR_STALL				0x003C
+#define ARMV8_PMUV3_PERFCTR_STALL_SLOT_BACKEND			0x003D
+#define ARMV8_PMUV3_PERFCTR_STALL_SLOT_FRONTEND			0x003E
+#define ARMV8_PMUV3_PERFCTR_STALL_SLOT				0x003F
+
+/* Statistical profiling extension microarchitectural events */
+#define ARMV8_SPE_PERFCTR_SAMPLE_POP				0x4000
+#define ARMV8_SPE_PERFCTR_SAMPLE_FEED				0x4001
+#define ARMV8_SPE_PERFCTR_SAMPLE_FILTRATE			0x4002
+#define ARMV8_SPE_PERFCTR_SAMPLE_COLLISION			0x4003
+
+/* AMUv1 architecture events */
+#define ARMV8_AMU_PERFCTR_CNT_CYCLES				0x4004
+#define ARMV8_AMU_PERFCTR_STALL_BACKEND_MEM			0x4005
+
+/* long-latency read miss events */
+#define ARMV8_PMUV3_PERFCTR_L1I_CACHE_LMISS			0x4006
+#define ARMV8_PMUV3_PERFCTR_L2D_CACHE_LMISS_RD			0x4009
+#define ARMV8_PMUV3_PERFCTR_L2I_CACHE_LMISS			0x400A
+#define ARMV8_PMUV3_PERFCTR_L3D_CACHE_LMISS_RD			0x400B
+
+/* Trace buffer events */
+#define ARMV8_PMUV3_PERFCTR_TRB_WRAP				0x400C
+#define ARMV8_PMUV3_PERFCTR_TRB_TRIG				0x400E
+
+/* Trace unit events */
+#define ARMV8_PMUV3_PERFCTR_TRCEXTOUT0				0x4010
+#define ARMV8_PMUV3_PERFCTR_TRCEXTOUT1				0x4011
+#define ARMV8_PMUV3_PERFCTR_TRCEXTOUT2				0x4012
+#define ARMV8_PMUV3_PERFCTR_TRCEXTOUT3				0x4013
+#define ARMV8_PMUV3_PERFCTR_CTI_TRIGOUT4			0x4018
+#define ARMV8_PMUV3_PERFCTR_CTI_TRIGOUT5			0x4019
+#define ARMV8_PMUV3_PERFCTR_CTI_TRIGOUT6			0x401A
+#define ARMV8_PMUV3_PERFCTR_CTI_TRIGOUT7			0x401B
+
+/* additional latency from alignment events */
+#define ARMV8_PMUV3_PERFCTR_LDST_ALIGN_LAT			0x4020
+#define ARMV8_PMUV3_PERFCTR_LD_ALIGN_LAT			0x4021
+#define ARMV8_PMUV3_PERFCTR_ST_ALIGN_LAT			0x4022
+
+/* Armv8.5 Memory Tagging Extension events */
+#define ARMV8_MTE_PERFCTR_MEM_ACCESS_CHECKED			0x4024
+#define ARMV8_MTE_PERFCTR_MEM_ACCESS_CHECKED_RD			0x4025
+#define ARMV8_MTE_PERFCTR_MEM_ACCESS_CHECKED_WR			0x4026
+
+/* ARMv8 recommended implementation defined event types */
+#define ARMV8_IMPDEF_PERFCTR_L1D_CACHE_RD			0x0040
+#define ARMV8_IMPDEF_PERFCTR_L1D_CACHE_WR			0x0041
+#define ARMV8_IMPDEF_PERFCTR_L1D_CACHE_REFILL_RD		0x0042
+#define ARMV8_IMPDEF_PERFCTR_L1D_CACHE_REFILL_WR		0x0043
+#define ARMV8_IMPDEF_PERFCTR_L1D_CACHE_REFILL_INNER		0x0044
+#define ARMV8_IMPDEF_PERFCTR_L1D_CACHE_REFILL_OUTER		0x0045
+#define ARMV8_IMPDEF_PERFCTR_L1D_CACHE_WB_VICTIM		0x0046
+#define ARMV8_IMPDEF_PERFCTR_L1D_CACHE_WB_CLEAN			0x0047
+#define ARMV8_IMPDEF_PERFCTR_L1D_CACHE_INVAL			0x0048
+
+#define ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_RD			0x004C
+#define ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_WR			0x004D
+#define ARMV8_IMPDEF_PERFCTR_L1D_TLB_RD				0x004E
+#define ARMV8_IMPDEF_PERFCTR_L1D_TLB_WR				0x004F
+#define ARMV8_IMPDEF_PERFCTR_L2D_CACHE_RD			0x0050
+#define ARMV8_IMPDEF_PERFCTR_L2D_CACHE_WR			0x0051
+#define ARMV8_IMPDEF_PERFCTR_L2D_CACHE_REFILL_RD		0x0052
+#define ARMV8_IMPDEF_PERFCTR_L2D_CACHE_REFILL_WR		0x0053
+
+#define ARMV8_IMPDEF_PERFCTR_L2D_CACHE_WB_VICTIM		0x0056
+#define ARMV8_IMPDEF_PERFCTR_L2D_CACHE_WB_CLEAN			0x0057
+#define ARMV8_IMPDEF_PERFCTR_L2D_CACHE_INVAL			0x0058
+
+#define ARMV8_IMPDEF_PERFCTR_L2D_TLB_REFILL_RD			0x005C
+#define ARMV8_IMPDEF_PERFCTR_L2D_TLB_REFILL_WR			0x005D
+#define ARMV8_IMPDEF_PERFCTR_L2D_TLB_RD				0x005E
+#define ARMV8_IMPDEF_PERFCTR_L2D_TLB_WR				0x005F
+#define ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_RD			0x0060
+#define ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_WR			0x0061
+#define ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_SHARED			0x0062
+#define ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_NOT_SHARED		0x0063
+#define ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_NORMAL			0x0064
+#define ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_PERIPH			0x0065
+#define ARMV8_IMPDEF_PERFCTR_MEM_ACCESS_RD			0x0066
+#define ARMV8_IMPDEF_PERFCTR_MEM_ACCESS_WR			0x0067
+#define ARMV8_IMPDEF_PERFCTR_UNALIGNED_LD_SPEC			0x0068
+#define ARMV8_IMPDEF_PERFCTR_UNALIGNED_ST_SPEC			0x0069
+#define ARMV8_IMPDEF_PERFCTR_UNALIGNED_LDST_SPEC		0x006A
+
+#define ARMV8_IMPDEF_PERFCTR_LDREX_SPEC				0x006C
+#define ARMV8_IMPDEF_PERFCTR_STREX_PASS_SPEC			0x006D
+#define ARMV8_IMPDEF_PERFCTR_STREX_FAIL_SPEC			0x006E
+#define ARMV8_IMPDEF_PERFCTR_STREX_SPEC				0x006F
+#define ARMV8_IMPDEF_PERFCTR_LD_SPEC				0x0070
+#define ARMV8_IMPDEF_PERFCTR_ST_SPEC				0x0071
+#define ARMV8_IMPDEF_PERFCTR_LDST_SPEC				0x0072
+#define ARMV8_IMPDEF_PERFCTR_DP_SPEC				0x0073
+#define ARMV8_IMPDEF_PERFCTR_ASE_SPEC				0x0074
+#define ARMV8_IMPDEF_PERFCTR_VFP_SPEC				0x0075
+#define ARMV8_IMPDEF_PERFCTR_PC_WRITE_SPEC			0x0076
+#define ARMV8_IMPDEF_PERFCTR_CRYPTO_SPEC			0x0077
+#define ARMV8_IMPDEF_PERFCTR_BR_IMMED_SPEC			0x0078
+#define ARMV8_IMPDEF_PERFCTR_BR_RETURN_SPEC			0x0079
+#define ARMV8_IMPDEF_PERFCTR_BR_INDIRECT_SPEC			0x007A
+
+#define ARMV8_IMPDEF_PERFCTR_ISB_SPEC				0x007C
+#define ARMV8_IMPDEF_PERFCTR_DSB_SPEC				0x007D
+#define ARMV8_IMPDEF_PERFCTR_DMB_SPEC				0x007E
+
+#define ARMV8_IMPDEF_PERFCTR_EXC_UNDEF				0x0081
+#define ARMV8_IMPDEF_PERFCTR_EXC_SVC				0x0082
+#define ARMV8_IMPDEF_PERFCTR_EXC_PABORT				0x0083
+#define ARMV8_IMPDEF_PERFCTR_EXC_DABORT				0x0084
+
+#define ARMV8_IMPDEF_PERFCTR_EXC_IRQ				0x0086
+#define ARMV8_IMPDEF_PERFCTR_EXC_FIQ				0x0087
+#define ARMV8_IMPDEF_PERFCTR_EXC_SMC				0x0088
+
+#define ARMV8_IMPDEF_PERFCTR_EXC_HVC				0x008A
+#define ARMV8_IMPDEF_PERFCTR_EXC_TRAP_PABORT			0x008B
+#define ARMV8_IMPDEF_PERFCTR_EXC_TRAP_DABORT			0x008C
+#define ARMV8_IMPDEF_PERFCTR_EXC_TRAP_OTHER			0x008D
+#define ARMV8_IMPDEF_PERFCTR_EXC_TRAP_IRQ			0x008E
+#define ARMV8_IMPDEF_PERFCTR_EXC_TRAP_FIQ			0x008F
+#define ARMV8_IMPDEF_PERFCTR_RC_LD_SPEC				0x0090
+#define ARMV8_IMPDEF_PERFCTR_RC_ST_SPEC				0x0091
+
+#define ARMV8_IMPDEF_PERFCTR_L3D_CACHE_RD			0x00A0
+#define ARMV8_IMPDEF_PERFCTR_L3D_CACHE_WR			0x00A1
+#define ARMV8_IMPDEF_PERFCTR_L3D_CACHE_REFILL_RD		0x00A2
+#define ARMV8_IMPDEF_PERFCTR_L3D_CACHE_REFILL_WR		0x00A3
+
+#define ARMV8_IMPDEF_PERFCTR_L3D_CACHE_WB_VICTIM		0x00A6
+#define ARMV8_IMPDEF_PERFCTR_L3D_CACHE_WB_CLEAN			0x00A7
+#define ARMV8_IMPDEF_PERFCTR_L3D_CACHE_INVAL			0x00A8
+
+/*
+ * Per-CPU PMCR: config reg
+ */
+#define ARMV8_PMU_PMCR_E	(1 << 0) /* Enable all counters */
+#define ARMV8_PMU_PMCR_P	(1 << 1) /* Reset all counters */
+#define ARMV8_PMU_PMCR_C	(1 << 2) /* Cycle counter reset */
+#define ARMV8_PMU_PMCR_D	(1 << 3) /* CCNT counts every 64th cpu cycle */
+#define ARMV8_PMU_PMCR_X	(1 << 4) /* Export to ETM */
+#define ARMV8_PMU_PMCR_DP	(1 << 5) /* Disable CCNT if non-invasive debug*/
+#define ARMV8_PMU_PMCR_LC	(1 << 6) /* Overflow on 64 bit cycle counter */
+#define ARMV8_PMU_PMCR_LP	(1 << 7) /* Long event counter enable */
+#define ARMV8_PMU_PMCR_N_SHIFT	11  /* Number of counters supported */
+#define ARMV8_PMU_PMCR_N_MASK	0x1f
+#define ARMV8_PMU_PMCR_MASK	0xff    /* Mask for writable bits */
+
+/*
+ * PMOVSR: counters overflow flag status reg
+ */
+#define ARMV8_PMU_OVSR_MASK		0xffffffff	/* Mask for writable bits */
+#define ARMV8_PMU_OVERFLOWED_MASK	ARMV8_PMU_OVSR_MASK
+
+/*
+ * PMXEVTYPER: Event selection reg
+ */
+#define ARMV8_PMU_EVTYPE_MASK	0xc800ffff	/* Mask for writable bits */
+#define ARMV8_PMU_EVTYPE_EVENT	0xffff		/* Mask for EVENT bits */
+
+/*
+ * Event filters for PMUv3
+ */
+#define ARMV8_PMU_EXCLUDE_EL1	(1U << 31)
+#define ARMV8_PMU_EXCLUDE_EL0	(1U << 30)
+#define ARMV8_PMU_INCLUDE_EL2	(1U << 27)
+
+/*
+ * PMUSERENR: user enable reg
+ */
+#define ARMV8_PMU_USERENR_MASK	0xf		/* Mask for writable bits */
+#define ARMV8_PMU_USERENR_EN	(1 << 0) /* PMU regs can be accessed at EL0 */
+#define ARMV8_PMU_USERENR_SW	(1 << 1) /* PMSWINC can be written at EL0 */
+#define ARMV8_PMU_USERENR_CR	(1 << 2) /* Cycle counter can be read at EL0 */
+#define ARMV8_PMU_USERENR_ER	(1 << 3) /* Event counter can be read at EL0 */
+
+/* PMMIR_EL1.SLOTS mask */
+#define ARMV8_PMU_SLOTS_MASK	0xff
+
+#define ARMV8_PMU_BUS_SLOTS_SHIFT 8
+#define ARMV8_PMU_BUS_SLOTS_MASK 0xff
+#define ARMV8_PMU_BUS_WIDTH_SHIFT 16
+#define ARMV8_PMU_BUS_WIDTH_MASK 0xf
+
+#endif
-- 
2.40.0.rc2.332.ga46443480c-goog

