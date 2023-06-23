Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2052273BE59
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 20:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbjFWSYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 14:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbjFWSYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 14:24:31 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CD02724;
        Fri, 23 Jun 2023 11:24:26 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35NHWJIV005753;
        Fri, 23 Jun 2023 11:24:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=C+8iNnRd9R1P9pZPr3gdmOM33uf0tje+koUUR4wUYsM=;
 b=fHFEkx0KHGIMErnzR58luqEnRFq2+djJRkXcAqjB6hMK/tF2mEHxe+Lr7ytLzDvm6+/r
 lT4h4wUZBF8Gt62nq77gZ2g56RKt/UuRPGy4aFlBIJGZcWClaFci5qYRTohqnPB8KBLp
 MrDI952hBzS8Th23xnWqTyWF2aG7e2iNkeZ7QEZZogNVnW9GcDmu06tj2SAijXOTu9Xj
 CzPWt6XMUJvM7m0wdpKJQnfgM35JFsoHA6qbf+j+Ui7O0HRe6J97m46w76PyZ/WYYtoB
 jR44ZrRQNTv271w4CN0hJCVkaJiLEVD44rfYZ/ckszGIdwykcIJVjOIEavOG1kLIJA/m 7A== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3rcuqvbc0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 11:24:02 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 23 Jun
 2023 11:24:00 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Fri, 23 Jun 2023 11:24:00 -0700
Received: from TJ-POWEREDGE.marvell.com (TJ-POWEREDGE.marvell.com [10.28.8.3])
        by maili.marvell.com (Postfix) with ESMTP id 1F39E3F7045;
        Fri, 23 Jun 2023 11:23:54 -0700 (PDT)
From:   Tanmay Jagdale <tanmay@marvell.com>
To:     <john.g.garry@oracle.com>, <will@kernel.org>,
        <mike.leach@linaro.org>, <suzuki.poulose@arm.com>,
        <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <irogers@google.com>,
        <adrian.hunter@intel.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gcherian@marvell.com>,
        <lcherian@marvell.com>, <areddy3@marvell.com>,
        Tanmay Jagdale <tanmay@marvell.com>
Subject: [PATCH 1/1] perf: cs-etm: Fixes in instruction sample synthesis
Date:   Fri, 23 Jun 2023 23:52:04 +0530
Message-ID: <20230623182204.25199-2-tanmay@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623182204.25199-1-tanmay@marvell.com>
References: <20230623182204.25199-1-tanmay@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: lRf39lGJPR6WXVfwyGbxk36MSepJ_T2X
X-Proofpoint-GUID: lRf39lGJPR6WXVfwyGbxk36MSepJ_T2X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_10,2023-06-22_02,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing method of synthesizing instruction samples has the
following issues:
1. Non-branch instructions have mnemonics of branch instructions.
2. Branch target address is missing.

Set the sample flags only when we reach the last instruction in
the tidq (which would be a branch instruction) to solve issue 1).

To fix issue 2), start synthesizing the instructions from the
previous packet (tidq->prev_packet) instead of current packet
(tidq->packet). This way, it is easy to figure out the target
address of the branch instruction in tidq->prev_packet which
is the current packet's (tidq->packet) first executed instruction.

After the switch to processing the previous packet first, we no
longer need to swap the packets during cs_etm__flush().

Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
---
 tools/perf/util/cs-etm.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 91299cc56bf7..446e00d98fd5 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1418,10 +1418,26 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
 	sample.stream_id = etmq->etm->instructions_id;
 	sample.period = period;
 	sample.cpu = tidq->packet->cpu;
-	sample.flags = tidq->prev_packet->flags;
 	sample.cpumode = event->sample.header.misc;
 
-	cs_etm__copy_insn(etmq, tidq->trace_chan_id, tidq->packet, &sample);
+	cs_etm__copy_insn(etmq, tidq->trace_chan_id, tidq->prev_packet, &sample);
+
+	/* Populate branch target information only when we encounter
+	 * branch instruction, which is at the end of tidq->prev_packet.
+	 */
+	if (addr == (tidq->prev_packet->end_addr - 4)) {
+		/* Update the perf_sample flags using the prev_packet
+		 * since that is the queue we are synthesizing.
+		 */
+		sample.flags = tidq->prev_packet->flags;
+
+		/* The last instruction of the previous queue would be a
+		 * branch operation. Get the target of that branch by looking
+		 * into the first executed instruction of the current packet
+		 * queue.
+		 */
+		sample.addr = cs_etm__first_executed_instr(tidq->packet);
+	}
 
 	if (etm->synth_opts.last_branch)
 		sample.branch_stack = tidq->last_branch;
@@ -1641,7 +1657,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
 	/* Get instructions remainder from previous packet */
 	instrs_prev = tidq->period_instructions;
 
-	tidq->period_instructions += tidq->packet->instr_count;
+	tidq->period_instructions += tidq->prev_packet->instr_count;
 
 	/*
 	 * Record a branch when the last instruction in
@@ -1721,8 +1737,11 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
 			 * been executed, but PC has not advanced to next
 			 * instruction)
 			 */
+			/* Get address from prev_packet since we are synthesizing
+			 * that in cs_etm__synth_instruction_sample()
+			 */
 			addr = cs_etm__instr_addr(etmq, trace_chan_id,
-						  tidq->packet, offset - 1);
+						  tidq->prev_packet, offset - 1);
 			ret = cs_etm__synth_instruction_sample(
 				etmq, tidq, addr,
 				etm->instructions_sample_period);
@@ -1786,7 +1805,7 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
 
 	/* Handle start tracing packet */
 	if (tidq->prev_packet->sample_type == CS_ETM_EMPTY)
-		goto swap_packet;
+		goto reset_last_br;
 
 	if (etmq->etm->synth_opts.last_branch &&
 	    etmq->etm->synth_opts.instructions &&
@@ -1822,8 +1841,7 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
 			return err;
 	}
 
-swap_packet:
-	cs_etm__packet_swap(etm, tidq);
+reset_last_br:
 
 	/* Reset last branches after flush the trace */
 	if (etm->synth_opts.last_branch)
-- 
2.34.1

