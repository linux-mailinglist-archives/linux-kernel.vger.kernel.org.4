Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DADF06806BE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 08:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235494AbjA3HyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 02:54:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbjA3HyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 02:54:21 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D4E279A5;
        Sun, 29 Jan 2023 23:54:20 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30U6N4Xt032450;
        Mon, 30 Jan 2023 07:54:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=5BrnDeWo0u0k41h6RgZkCj2smetzwX0sdng6kkeNxa8=;
 b=jySc+5nfpVSv2PUbbrkcvuoFa8NRRPseCsZKoBKEsm49I1bgtJpryRBnkunME0TRfm7Q
 0ulBXO6WhHGmJq+AtTtoX93Sb2uvx2Sr1fGHogLl9SeYcDghmitvsY7jhsUF21OerO5j
 CIGn4QtL9yYw5vahzYfR2pO0ryS7YbewoDJPKxHfgPLp7r2RdDekWhb5PwDUtRly5am7
 lnKtKMRXZbZdJYhQLQ8AI7w+m9LstnWBcbeqYd+fsl0Ei81SbcytG8sENndalZhjCsiQ
 V2PVJ+13Q/iOFt8PaCddZOly+u2I8tM8WfDr17v6WiwbeLg5JL7JIZBUoB5q2iL+mrIZ RQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ncvvu2wur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 07:54:16 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30U7sFjt016269
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 07:54:15 GMT
Received: from linyyuan-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Sun, 29 Jan 2023 23:54:14 -0800
From:   Linyu Yuan <quic_linyyuan@quicinc.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>,
        Linyu Yuan <quic_linyyuan@quicinc.com>
Subject: [PATCH v5] trace: acquire buffer from temparary trace sequence
Date:   Mon, 30 Jan 2023 15:54:09 +0800
Message-ID: <1675065249-23368-1-git-send-email-quic_linyyuan@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 11B5uTF2gPLNau23KLIlj-Nfpdw3n7if
X-Proofpoint-ORIG-GUID: 11B5uTF2gPLNau23KLIlj-Nfpdw3n7if
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_06,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0
 clxscore=1011 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301300074
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is one dwc3 trace event declare as below,
DECLARE_EVENT_CLASS(dwc3_log_event,
	TP_PROTO(u32 event, struct dwc3 *dwc),
	TP_ARGS(event, dwc),
	TP_STRUCT__entry(
		__field(u32, event)
		__field(u32, ep0state)
		__dynamic_array(char, str, DWC3_MSG_MAX)
	),
	TP_fast_assign(
		__entry->event = event;
		__entry->ep0state = dwc->ep0state;
	),
	TP_printk("event (%08x): %s", __entry->event,
			dwc3_decode_event(__get_str(str), DWC3_MSG_MAX,
				__entry->event, __entry->ep0state))
);
the problem is when trace function called, it will allocate up to
DWC3_MSG_MAX bytes from trace event buffer, but never fill the buffer
during fast assignment, it only fill the buffer when output function are
called, so this means if output function are not called, the buffer will
never used.

add __get_buf(len) which acquiree buffer from iter->tmp_seq when trace
output function called, it allow user write string to acquired buffer.

the mentioned dwc3 trace event will changed as below,
DECLARE_EVENT_CLASS(dwc3_log_event,
	TP_PROTO(u32 event, struct dwc3 *dwc),
	TP_ARGS(event, dwc),
	TP_STRUCT__entry(
		__field(u32, event)
		__field(u32, ep0state)
	),
	TP_fast_assign(
		__entry->event = event;
		__entry->ep0state = dwc->ep0state;
	),
	TP_printk("event (%08x): %s", __entry->event,
		dwc3_decode_event(__get_buf(DWC3_MSG_MAX), DWC3_MSG_MAX,
				__entry->event, __entry->ep0state))
);.

Signed-off-by: Linyu Yuan <quic_linyyuan@quicinc.com>
---

v5: move WARN_ON_ONCE into function
v4: no change
v3: fix comment from maintainer in v2

 include/linux/trace_seq.h                  |  5 +++++
 include/trace/stages/stage3_trace_output.h |  3 +++
 include/trace/stages/stage7_class_define.h |  1 +
 kernel/trace/trace_seq.c                   | 23 +++++++++++++++++++++++
 4 files changed, 32 insertions(+)

diff --git a/include/linux/trace_seq.h b/include/linux/trace_seq.h
index 0c4c758..6be92bf 100644
--- a/include/linux/trace_seq.h
+++ b/include/linux/trace_seq.h
@@ -95,6 +95,7 @@ extern void trace_seq_bitmask(struct trace_seq *s, const unsigned long *maskp,
 extern int trace_seq_hex_dump(struct trace_seq *s, const char *prefix_str,
 			      int prefix_type, int rowsize, int groupsize,
 			      const void *buf, size_t len, bool ascii);
+char *trace_seq_acquire(struct trace_seq *s, unsigned int len);
 
 #else /* CONFIG_TRACING */
 static inline __printf(2, 3)
@@ -139,6 +140,10 @@ static inline int trace_seq_path(struct trace_seq *s, const struct path *path)
 {
 	return 0;
 }
+static inline char *trace_seq_acquire(struct trace_seq *s, unsigned int len)
+{
+	return NULL;
+}
 #endif /* CONFIG_TRACING */
 
 #endif /* _LINUX_TRACE_SEQ_H */
diff --git a/include/trace/stages/stage3_trace_output.h b/include/trace/stages/stage3_trace_output.h
index 66374df..c1fb135 100644
--- a/include/trace/stages/stage3_trace_output.h
+++ b/include/trace/stages/stage3_trace_output.h
@@ -139,3 +139,6 @@
 		u64 ____val = (u64)(value);		\
 		(u32) do_div(____val, NSEC_PER_SEC);	\
 	})
+
+#undef __get_buf
+#define __get_buf(len)		trace_seq_acquire(p, (len))
diff --git a/include/trace/stages/stage7_class_define.h b/include/trace/stages/stage7_class_define.h
index 8795429..bcb960d 100644
--- a/include/trace/stages/stage7_class_define.h
+++ b/include/trace/stages/stage7_class_define.h
@@ -23,6 +23,7 @@
 #undef __get_rel_sockaddr
 #undef __print_array
 #undef __print_hex_dump
+#undef __get_buf
 
 /*
  * The below is not executed in the kernel. It is only what is
diff --git a/kernel/trace/trace_seq.c b/kernel/trace/trace_seq.c
index 9c90b3a..e5e2992 100644
--- a/kernel/trace/trace_seq.c
+++ b/kernel/trace/trace_seq.c
@@ -403,3 +403,26 @@ int trace_seq_hex_dump(struct trace_seq *s, const char *prefix_str,
 	return 1;
 }
 EXPORT_SYMBOL(trace_seq_hex_dump);
+
+/*
+ * trace_seq_acquire - acquire seq buffer with size len
+ * @s: trace sequence descriptor
+ * @len: size of buffer to be acquired
+ *
+ * acquire buffer with size of @len from trace_seq for output usage,
+ * user can fill string into that buffer.
+ *
+ * Returns start address of acquired buffer.
+ *
+ * it allow multiple usage in one trace output function call.
+ */
+char *trace_seq_acquire(struct trace_seq *s, unsigned int len)
+{
+	char *ret = trace_seq_buffer_ptr(s);
+
+	if (!WARN_ON_ONCE(seq_buf_buffer_left(&s->seq) < len))
+		seq_buf_commit(&s->seq, len);
+
+	return ret;
+}
+EXPORT_SYMBOL(trace_seq_acquire);
-- 
2.7.4

