Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5C47377B9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 01:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjFTXBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 19:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjFTXBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 19:01:13 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0431410FB;
        Tue, 20 Jun 2023 16:01:11 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35KMxXsO002713;
        Tue, 20 Jun 2023 23:01:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=WntkWWpMasix+E68+x766YVXS0w9CX5RJAN37zBOVf0=;
 b=dnUc3GHOz6PgmB4PKjRKiHjABpqQEM+oEhIK3mPWzoUvrPqMDasXIJ2kvz4Mz++xQH/M
 RhcHfgOsPwSpULL+CuhzvYfIu4LVdHzCO3LveyujzyuGxfIeFAHlJDlXMIazxlQM4hw/
 Q+74rOJZPAiUyKpmKaPjy9uA7lyWex6hBZa8N1fkjpVgL84c/oUzVaOcgbu9Q61nWZDf
 pBDAZ7DzIxk/7Nt3rL4OvQakKTEfJIYT2eOjynjoUP0IP/fPFmFG2K7gWBFJImyJmbLL
 g9jIWh1J1tlHAk40IgM2BLXlxKZoc1UOj/J7hb0cnfJyCMTKOmz+t6+/gGfvClQmxP9Y tw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rb543tbrg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jun 2023 23:01:06 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35KN14xx029882
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jun 2023 23:01:05 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 20 Jun 2023 16:01:03 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Maulik Shah <quic_mkshah@quicinc.com>
CC:     Douglas Anderson <dianders@chromium.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] soc: qcom: rpmh-rsc: Include state in trace event
Date:   Tue, 20 Jun 2023 16:00:58 -0700
Message-ID: <20230620230058.428833-1-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gU-gD5v3_4Opj0sGk5rkzTj2Rue1hrWn
X-Proofpoint-ORIG-GUID: gU-gD5v3_4Opj0sGk5rkzTj2Rue1hrWn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_16,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 impostorscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306200208
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When tracing messages written to the RSC it's very useful to know the
type of TCS being targeted, in particular if/when the code borrows a
WAKE TCS for ACTIVE votes.

Add the "state" of the message to the traced information.

While at it, drop the "send-msg:" substring, as this is already captured
by the trace event itself.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/soc/qcom/rpmh-rsc.c   |  2 +-
 drivers/soc/qcom/trace-rpmh.h | 16 ++++++++++++----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 0dd4363ebac8..a021dc71807b 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -516,7 +516,7 @@ static void __tcs_buffer_write(struct rsc_drv *drv, int tcs_id, int cmd_id,
 		write_tcs_cmd(drv, drv->regs[RSC_DRV_CMD_MSGID], tcs_id, j, msgid);
 		write_tcs_cmd(drv, drv->regs[RSC_DRV_CMD_ADDR], tcs_id, j, cmd->addr);
 		write_tcs_cmd(drv, drv->regs[RSC_DRV_CMD_DATA], tcs_id, j, cmd->data);
-		trace_rpmh_send_msg(drv, tcs_id, j, msgid, cmd);
+		trace_rpmh_send_msg(drv, tcs_id, msg->state, j, msgid, cmd);
 	}
 
 	cmd_enable |= read_tcs_reg(drv, drv->regs[RSC_DRV_CMD_ENABLE], tcs_id);
diff --git a/drivers/soc/qcom/trace-rpmh.h b/drivers/soc/qcom/trace-rpmh.h
index 12b676b20cb2..be6b42ecc1f8 100644
--- a/drivers/soc/qcom/trace-rpmh.h
+++ b/drivers/soc/qcom/trace-rpmh.h
@@ -38,14 +38,15 @@ TRACE_EVENT(rpmh_tx_done,
 
 TRACE_EVENT(rpmh_send_msg,
 
-	TP_PROTO(struct rsc_drv *d, int m, int n, u32 h,
+	TP_PROTO(struct rsc_drv *d, int m, enum rpmh_state state, int n, u32 h,
 		 const struct tcs_cmd *c),
 
-	TP_ARGS(d, m, n, h, c),
+	TP_ARGS(d, m, state, n, h, c),
 
 	TP_STRUCT__entry(
 			 __string(name, d->name)
 			 __field(int, m)
+			 __field(u32, state)
 			 __field(int, n)
 			 __field(u32, hdr)
 			 __field(u32, addr)
@@ -56,6 +57,7 @@ TRACE_EVENT(rpmh_send_msg,
 	TP_fast_assign(
 		       __assign_str(name, d->name);
 		       __entry->m = m;
+		       __entry->state = state;
 		       __entry->n = n;
 		       __entry->hdr = h;
 		       __entry->addr = c->addr;
@@ -63,8 +65,14 @@ TRACE_EVENT(rpmh_send_msg,
 		       __entry->wait = c->wait;
 	),
 
-	TP_printk("%s: send-msg: tcs(m): %d cmd(n): %d msgid: %#x addr: %#x data: %#x complete: %d",
-		  __get_str(name), __entry->m, __entry->n, __entry->hdr,
+	TP_printk("%s: tcs(m): %d [%s] cmd(n): %d msgid: %#x addr: %#x data: %#x complete: %d",
+		  __get_str(name), __entry->m,
+		  __print_symbolic(__entry->state,
+				   { RPMH_SLEEP_STATE, "sleep" },
+				   { RPMH_WAKE_ONLY_STATE, "wake" },
+				   { RPMH_ACTIVE_ONLY_STATE, "active" }),
+		  __entry->n,
+		  __entry->hdr,
 		  __entry->addr, __entry->data, __entry->wait)
 );
 
-- 
2.25.1

