Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE54269731A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 02:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbjBOBH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 20:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbjBOBHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 20:07:24 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A632596A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 17:07:22 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-52ec2c6b694so165542267b3.19
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 17:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kyOB/hRwU/hB4ybFMwafI+d7DhJ3aCkjc4J9NusFIBA=;
        b=sjAq/MM37phS2hg2uKqcHlFo35MnerAFSLVt+k96bgZkcdvjEUYyIZD1X2sR4mOHv7
         Q1zBdAiWCcpj7UaWLJlfQ5Ul+5e3B2pl8TwPORgxMLd0NYhNGrwWUkjaN/8bNXsiXPUl
         6vy514GwJTNuExb/CENAZ12PXQ/+6DR51kZvpT8W15IFK5+fj+a1Cri1UC/tXyJgDaWz
         myva6dmIdGjTaxjo3ZmAOQTkti5qDQGuIPuxmdJKXewVObLK5RRrLGSIl3XSPx9+jOEg
         7nVcMAHxfuSAQKyjHF0AWE+XAKpp7zQbe2XMbfx2rUJkyl7cy7Q4d3UZczxNwPosAAMi
         e2Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kyOB/hRwU/hB4ybFMwafI+d7DhJ3aCkjc4J9NusFIBA=;
        b=0o7JITHUDp1nmzrpknhkliHLa9oHcvCmMManlOkxAwszIe4GNDzPdPZB6aEA9mew8N
         GO0Rs4eV8m984n/mdMb/ZKd0434joPeFslTAODBo5l/A5DhB631nmPOUgMPb51h+QwcR
         O4GemvO8qXOuwS2iKDtJ+KwjDXx5+ESL61cpOfn49nxx4ocVSJsyBZRE77wTwjH6Q+yR
         eIbc+HW0b1pRWazlkFcYMgPantCltFeTgelwrniYHNk86B+xbcU0P3ciSVfmO13vFCox
         jIMPTl2N2cT+cGBidygEhtKXA34TCv5ooD5nB46XR0vvbhv/u9hNMR5dzedAHWdmz4ss
         RHrw==
X-Gm-Message-State: AO0yUKWhFNVWBOa+Fppgsv5laoPhgHtgl6Wrhll1id/9Kg8jWUAxqq6Z
        vO9hI2rQuNpXSIuX1xsgcKd94TmOY/d5
X-Google-Smtp-Source: AK7set9ai+nhOh9s2abJDVKiQljmEsSRj0VvoW0fetnLXKQF7+fFcaE6hWMYGqBqPThtWrzfrEo8hAagPKN1
X-Received: from rananta-linux.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:22b5])
 (user=rananta job=sendgmr) by 2002:a25:e311:0:b0:8ef:90e1:b2f8 with SMTP id
 z17-20020a25e311000000b008ef90e1b2f8mr0ybd.2.1676423241585; Tue, 14 Feb 2023
 17:07:21 -0800 (PST)
Date:   Wed, 15 Feb 2023 01:07:02 +0000
In-Reply-To: <20230215010717.3612794-1-rananta@google.com>
Mime-Version: 1.0
References: <20230215010717.3612794-1-rananta@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230215010717.3612794-2-rananta@google.com>
Subject: [REPOST PATCH 01/16] tools: arm64: Import perf_event.h
From:   Raghavendra Rao Ananta <rananta@google.com>
To:     Oliver Upton <oupton@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Ricardo Koller <ricarkol@google.com>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jing Zhang <jingzhangos@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        Raghavendra Rao Anata <rananta@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
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

From: Reiji Watanabe <reijiw@google.com>

Copy perf_event.h from the kernel's arch/arm64/include/asm/perf_event.h.
The following patches will use macros defined in this header.

Signed-off-by: Reiji Watanabe <reijiw@google.com>
Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 tools/arch/arm64/include/asm/perf_event.h | 258 ++++++++++++++++++++++
 1 file changed, 258 insertions(+)
 create mode 100644 tools/arch/arm64/include/asm/perf_event.h

diff --git a/tools/arch/arm64/include/asm/perf_event.h b/tools/arch/arm64/include/asm/perf_event.h
new file mode 100644
index 0000000000000..97e49a4d4969f
--- /dev/null
+++ b/tools/arch/arm64/include/asm/perf_event.h
@@ -0,0 +1,258 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2012 ARM Ltd.
+ */
+
+#ifndef __ASM_PERF_EVENT_H
+#define __ASM_PERF_EVENT_H
+
+#define	ARMV8_PMU_MAX_COUNTERS	32
+#define	ARMV8_PMU_COUNTER_MASK	(ARMV8_PMU_MAX_COUNTERS - 1)
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
+#define	ARMV8_SPE_PERFCTR_SAMPLE_POP				0x4000
+#define	ARMV8_SPE_PERFCTR_SAMPLE_FEED				0x4001
+#define	ARMV8_SPE_PERFCTR_SAMPLE_FILTRATE			0x4002
+#define	ARMV8_SPE_PERFCTR_SAMPLE_COLLISION			0x4003
+
+/* AMUv1 architecture events */
+#define	ARMV8_AMU_PERFCTR_CNT_CYCLES				0x4004
+#define	ARMV8_AMU_PERFCTR_STALL_BACKEND_MEM			0x4005
+
+/* long-latency read miss events */
+#define	ARMV8_PMUV3_PERFCTR_L1I_CACHE_LMISS			0x4006
+#define	ARMV8_PMUV3_PERFCTR_L2D_CACHE_LMISS_RD			0x4009
+#define	ARMV8_PMUV3_PERFCTR_L2I_CACHE_LMISS			0x400A
+#define	ARMV8_PMUV3_PERFCTR_L3D_CACHE_LMISS_RD			0x400B
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
+#define	ARMV8_PMUV3_PERFCTR_LDST_ALIGN_LAT			0x4020
+#define	ARMV8_PMUV3_PERFCTR_LD_ALIGN_LAT			0x4021
+#define	ARMV8_PMUV3_PERFCTR_ST_ALIGN_LAT			0x4022
+
+/* Armv8.5 Memory Tagging Extension events */
+#define	ARMV8_MTE_PERFCTR_MEM_ACCESS_CHECKED			0x4024
+#define	ARMV8_MTE_PERFCTR_MEM_ACCESS_CHECKED_RD			0x4025
+#define	ARMV8_MTE_PERFCTR_MEM_ACCESS_CHECKED_WR			0x4026
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
+#define	ARMV8_PMU_PMCR_N_SHIFT	11	 /* Number of counters supported */
+#define	ARMV8_PMU_PMCR_N	(0x1f << ARMV8_PMU_PMCR_N_SHIFT)
+#define	ARMV8_PMU_PMCR_MASK	0xff	 /* Mask for writable bits */
+
+/*
+ * PMOVSR: counters overflow flag status reg
+ */
+#define	ARMV8_PMU_OVSR_MASK		0xffffffff	/* Mask for writable bits */
+#define	ARMV8_PMU_OVERFLOWED_MASK	ARMV8_PMU_OVSR_MASK
+
+/*
+ * PMXEVTYPER: Event selection reg
+ */
+#define	ARMV8_PMU_EVTYPE_MASK	0xc800ffff	/* Mask for writable bits */
+#define	ARMV8_PMU_EVTYPE_EVENT	0xffff		/* Mask for EVENT bits */
+
+/*
+ * Event filters for PMUv3
+ */
+#define	ARMV8_PMU_EXCLUDE_EL1	(1U << 31)
+#define	ARMV8_PMU_EXCLUDE_EL0	(1U << 30)
+#define	ARMV8_PMU_INCLUDE_EL2	(1U << 27)
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
+#endif /* __ASM_PERF_EVENT_H */
-- 
2.39.1.581.gbfd45094c4-goog

