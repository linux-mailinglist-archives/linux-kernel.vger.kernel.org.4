Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FB4675799
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 15:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjATOlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 09:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbjATOl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 09:41:27 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25BBCDA8EA;
        Fri, 20 Jan 2023 06:41:04 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB1B61688;
        Fri, 20 Jan 2023 06:39:09 -0800 (PST)
Received: from e126815.warwick.arm.com (e126815.arm.com [10.32.32.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6180D3F67D;
        Fri, 20 Jan 2023 06:38:25 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, tanmay@marvell.com,
        leo.yan@linaro.org, mike.leach@linaro.org
Cc:     sgoutham@marvell.com, gcherian@marvell.com, lcherian@marvell.com,
        bbhushan2@marvell.com, James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 8/8] perf: cs-etm: Ensure that Coresight timestamps don't go backwards
Date:   Fri, 20 Jan 2023 14:37:01 +0000
Message-Id: <20230120143702.4035046-9-james.clark@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230120143702.4035046-1-james.clark@arm.com>
References: <20230120143702.4035046-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some edge cases around estimated timestamps that can result
in them going backwards.

One is that after a discontinuity, the last used timestamp is set to 0.
The duration of the next range is then subtracted which could result in
an earlier timestamp than the last instruction. Fix this by not
resetting the last timestamp used on a discontinuity, and make sure that
new estimated timestamps are clamped to be later than that.

Another case is that estimated timestamps could compound over time to
end up being more than the next real timestamp in the trace. Fix this by
clamping the estimates in cs_etm_decoder__do_soft_timestamp() to be no
later than it.

cs_etm_decoder__do_soft_timestamp() also updated next_cs_timestamp,
which meant that the next real timestamp was lost and not stored
anywhere. Fix that by only updating cs_timestamp for estimates and keep
next_cs_timestamp untouched.

Finally, use next_cs_timestamp to signify if a timestamp has been
received previously. Because cs_timestamp has the first range
subtracted, it could technically go to 0 which would break the logic.

Testing
=======

It can be verified that timestamps don't go backwards when tracing on a
single core with the following commands. Across multiple cores it's
expected that timestamps are interleaved:

 $ perf record -e cs_etm/@tmc_etr0/k -C 4 taskset -c 4 sleep 1
 $ perf script --itrace=i1ns --ns -Fcomm,tid,pid,time,cpu,event,ip,sym,addr,symoff,flags,callindent > itrace
 $ sed 's/://g' itrace | awk -F ' ' ' { print $4 } ' | awk '{ if ($1 < prev) { print "line:" NR " " $0 } {prev=$1}}'

Reported-by: Tanmay Jagdale <tanmay@marvell.com>
Signed-off-by: James Clark <james.clark@arm.com>
---
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 29 ++++++++++++-------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 440fe844ed17..63afa2d05b46 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -283,15 +283,17 @@ cs_etm_decoder__do_soft_timestamp(struct cs_etm_queue *etmq,
 				  struct cs_etm_packet_queue *packet_queue,
 				  const uint8_t trace_chan_id)
 {
+	u64 estimated_ts;
+
 	/* No timestamp packet has been received, nothing to do */
-	if (!packet_queue->cs_timestamp)
+	if (!packet_queue->next_cs_timestamp)
 		return OCSD_RESP_CONT;
 
-	packet_queue->cs_timestamp = packet_queue->next_cs_timestamp;
+	estimated_ts = packet_queue->cs_timestamp +
+			cs_etm_decoder__dec_instr_count_to_ns(&packet_queue->instr_count);
 
-	/* Estimate the timestamp for the next range packet */
-	packet_queue->next_cs_timestamp +=
-		cs_etm_decoder__dec_instr_count_to_ns(&packet_queue->instr_count);
+	/* Estimated TS can never be higher than the next real one in the trace */
+	packet_queue->cs_timestamp = min(packet_queue->next_cs_timestamp, estimated_ts);
 
 	/* Tell the front end which traceid_queue needs attention */
 	cs_etm__etmq_set_traceid_queue_timestamp(etmq, trace_chan_id);
@@ -307,6 +309,7 @@ cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
 {
 	struct cs_etm_packet_queue *packet_queue;
 	u64 converted_timestamp;
+	u64 estimated_first_ts;
 
 	/* First get the packet queue for this traceID */
 	packet_queue = cs_etm__etmq_get_packet_queue(etmq, trace_chan_id);
@@ -325,7 +328,12 @@ cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
 	 * Function do_soft_timestamp() will report the value to the front end,
 	 * hence asking the decoder to keep decoding rather than stopping.
 	 */
-	if (packet_queue->cs_timestamp) {
+	if (packet_queue->next_cs_timestamp) {
+		/*
+		 * What was next is now where new ranges start from, overwriting
+		 * any previous estimate in cs_timestamp
+		 */
+		packet_queue->cs_timestamp = packet_queue->next_cs_timestamp;
 		packet_queue->next_cs_timestamp = converted_timestamp;
 		return OCSD_RESP_CONT;
 	}
@@ -355,10 +363,12 @@ cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
 		 * or a discontinuity.  Since timestamps packets are generated *after*
 		 * range packets have been generated, we need to estimate the time at
 		 * which instructions started by subtracting the number of instructions
-		 * executed to the timestamp.
+		 * executed to the timestamp. Don't estimate earlier than the last used
+		 * timestamp though.
 		 */
-		packet_queue->cs_timestamp = converted_timestamp -
-						(packet_queue->instr_count / INSTR_PER_NS);
+		estimated_first_ts = converted_timestamp -
+					(packet_queue->instr_count / INSTR_PER_NS);
+		packet_queue->cs_timestamp = max(packet_queue->cs_timestamp, estimated_first_ts);
 	}
 	packet_queue->next_cs_timestamp = converted_timestamp;
 	packet_queue->instr_count = 0;
@@ -373,7 +383,6 @@ cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
 static void
 cs_etm_decoder__reset_timestamp(struct cs_etm_packet_queue *packet_queue)
 {
-	packet_queue->cs_timestamp = 0;
 	packet_queue->next_cs_timestamp = 0;
 	packet_queue->instr_count = 0;
 }
-- 
2.25.1

