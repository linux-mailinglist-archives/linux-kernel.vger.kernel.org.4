Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5132C74B0B9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 14:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbjGGM11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 08:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbjGGM10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 08:27:26 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E243B19BD
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 05:27:24 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b890e2b9b7so9761045ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 05:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688732844; x=1691324844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NZ8JSt047fABCf/ocyk/dBCgET4YP8jMebMJ8/IUJmo=;
        b=YD3CkmbM2zj4toDN3vLlUM9Ndf4dprd27VqOEVwc/i1C31rz8qKfl5vWFRXl0Nf4Fb
         pW1aBpAmxtfFpWf1sQyD7sdH/TgFHyT/5urdJIvv8Pj5ygUmLAnmZXq1/qHN7iCWkhQg
         So2PWAdkJNKadcI4lS5Vc7KLvW/cDvEoxsrB7UeooiOfImoxAcMf4ObNPuyYOAJ/ScaQ
         z5vqKc067UzyST7UNmuJNk0VnlM6edmFLCKTeRJaxoATkIn3pUVVHZ1kBevW6g+L9Rfo
         F51A1yohZjnuRxurnmOe4PeFlwKU8dHaXJMrGTfHQq8byxUldpyOlwDoHx0b7bvAfAh1
         YCxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688732844; x=1691324844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NZ8JSt047fABCf/ocyk/dBCgET4YP8jMebMJ8/IUJmo=;
        b=R491KwWyeU2NHJ8Y209vXnx9kONBT7z/J79ZbMH2srT+HaQ5cjiAI0lyaGy22sSmtx
         /r56FiC2YsC2mdZpzABz/0KL+rKkvV3nYOued+tDorbrLbjJOtKtsGDDAvmIh7gDRa4M
         i1ErNNLwx+3UCczSd4Y+W5NCoVVuK66FMKqoBBH2AxyHzSNLujFhViQlQPddl2Ks7d1f
         LqGnuzZviWE74iv/xxzh3kBWL29A7fQDBYXh7z38FaVYa07Wnn8gasfM9sFgdKtTElAR
         AqgBDC/pJeWE0aP9JfjkpNZsdz4Oq0y2AhMHkAKw+CMmFA1rMiW/R/nFTxlVgRh95N4m
         dlow==
X-Gm-Message-State: ABy/qLY4QQ2oFVzgjKSdiQ3zOw+032qH+6RnZDRyHOHZV8qY2+zq/U7k
        +Zx/KtsHFVnQkwJnG5mlnbU7
X-Google-Smtp-Source: APBJJlENIIpeVTgL/DM7JL5TDsVfBcU0N6G5sjkUNneJZr+86lpJjH1tQ4POc0M/GKAA+unbTlw7UA==
X-Received: by 2002:a17:902:db11:b0:1b8:9ec5:79e2 with SMTP id m17-20020a170902db1100b001b89ec579e2mr4692812plx.1.1688732844320;
        Fri, 07 Jul 2023 05:27:24 -0700 (PDT)
Received: from localhost.localdomain ([117.216.120.82])
        by smtp.gmail.com with ESMTPSA id v5-20020a1709029a0500b001b8b0ac2258sm3144140plp.174.2023.07.07.05.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 05:27:23 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] soc: qcom: rpmh: Include resource name in the trace event
Date:   Fri,  7 Jul 2023 17:57:13 +0530
Message-Id: <20230707122713.37487-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The client drivers of RPMh like rpmhpd and bcm-voter has the name of the
resource they are dealing with along with the address. So let's include
the resource name in the RPMh trace event as it avoids doing a post
processing of the trace event to resolve the resource name its address.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

This patch depends on:
https://lore.kernel.org/all/20230620230058.428833-1-quic_bjorande@quicinc.com/

 drivers/interconnect/qcom/bcm-voter.c |  5 +++--
 drivers/soc/qcom/rpmh.c               |  9 ++++++---
 drivers/soc/qcom/rpmhpd.c             |  1 +
 drivers/soc/qcom/trace-rpmh.h         | 12 ++++++++----
 include/soc/qcom/tcs.h                |  2 ++
 5 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/interconnect/qcom/bcm-voter.c b/drivers/interconnect/qcom/bcm-voter.c
index 8f385f9c2dd3..8cf65ef4e1fb 100644
--- a/drivers/interconnect/qcom/bcm-voter.c
+++ b/drivers/interconnect/qcom/bcm-voter.c
@@ -95,7 +95,7 @@ static void bcm_aggregate(struct qcom_icc_bcm *bcm)
 }
 
 static inline void tcs_cmd_gen(struct tcs_cmd *cmd, u64 vote_x, u64 vote_y,
-			       u32 addr, bool commit, bool wait)
+			       const char *name, u32 addr, bool commit, bool wait)
 {
 	bool valid = true;
 
@@ -113,6 +113,7 @@ static inline void tcs_cmd_gen(struct tcs_cmd *cmd, u64 vote_x, u64 vote_y,
 	if (vote_y > BCM_TCS_CMD_VOTE_MASK)
 		vote_y = BCM_TCS_CMD_VOTE_MASK;
 
+	cmd->name = name;
 	cmd->addr = addr;
 	cmd->data = BCM_TCS_CMD(commit, valid, vote_x, vote_y);
 
@@ -146,7 +147,7 @@ static void tcs_list_gen(struct bcm_voter *voter, int bucket,
 		wait = commit && (voter->tcs_wait & BIT(bucket));
 
 		tcs_cmd_gen(&tcs_list[idx], bcm->vote_x[bucket],
-			    bcm->vote_y[bucket], bcm->addr, commit, wait);
+			    bcm->vote_y[bucket], bcm->name, bcm->addr, commit, wait);
 		idx++;
 		n[batch]++;
 		/*
diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index 08e09642d7f5..dfb849f134cd 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -49,6 +49,7 @@
  * @list: linked list obj
  */
 struct cache_req {
+	const char *name;
 	u32 addr;
 	u32 sleep_val;
 	u32 wake_val;
@@ -127,6 +128,7 @@ static struct cache_req *cache_rpm_request(struct rpmh_ctrlr *ctrlr,
 		goto unlock;
 	}
 
+	req->name = cmd->name;
 	req->addr = cmd->addr;
 	req->sleep_val = req->wake_val = UINT_MAX;
 	list_add_tail(&req->list, &ctrlr->cache);
@@ -405,12 +407,13 @@ static int is_req_valid(struct cache_req *req)
 }
 
 static int send_single(struct rpmh_ctrlr *ctrlr, enum rpmh_state state,
-		       u32 addr, u32 data)
+		       const char *name, u32 addr, u32 data)
 {
 	DEFINE_RPMH_MSG_ONSTACK(NULL, state, NULL, rpm_msg);
 
 	/* Wake sets are always complete and sleep sets are not */
 	rpm_msg.msg.wait_for_compl = (state == RPMH_WAKE_ONLY_STATE);
+	rpm_msg.cmd[0].name = name;
 	rpm_msg.cmd[0].addr = addr;
 	rpm_msg.cmd[0].data = data;
 	rpm_msg.msg.num_cmds = 1;
@@ -461,11 +464,11 @@ int rpmh_flush(struct rpmh_ctrlr *ctrlr)
 				 __func__, p->addr, p->sleep_val, p->wake_val);
 			continue;
 		}
-		ret = send_single(ctrlr, RPMH_SLEEP_STATE, p->addr,
+		ret = send_single(ctrlr, RPMH_SLEEP_STATE, p->name, p->addr,
 				  p->sleep_val);
 		if (ret)
 			goto exit;
-		ret = send_single(ctrlr, RPMH_WAKE_ONLY_STATE, p->addr,
+		ret = send_single(ctrlr, RPMH_WAKE_ONLY_STATE, p->name, p->addr,
 				  p->wake_val);
 		if (ret)
 			goto exit;
diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
index f20e2a49a669..770a998c159e 100644
--- a/drivers/soc/qcom/rpmhpd.c
+++ b/drivers/soc/qcom/rpmhpd.c
@@ -543,6 +543,7 @@ static int rpmhpd_send_corner(struct rpmhpd *pd, int state,
 			      unsigned int corner, bool sync)
 {
 	struct tcs_cmd cmd = {
+		.name = pd->res_name,
 		.addr = pd->addr,
 		.data = corner,
 	};
diff --git a/drivers/soc/qcom/trace-rpmh.h b/drivers/soc/qcom/trace-rpmh.h
index be6b42ecc1f8..20a920d2202c 100644
--- a/drivers/soc/qcom/trace-rpmh.h
+++ b/drivers/soc/qcom/trace-rpmh.h
@@ -21,6 +21,7 @@ TRACE_EVENT(rpmh_tx_done,
 	TP_STRUCT__entry(
 			 __string(name, d->name)
 			 __field(int, m)
+			 __string(tcs_name, r->cmds[0].name)
 			 __field(u32, addr)
 			 __field(u32, data)
 	),
@@ -28,12 +29,13 @@ TRACE_EVENT(rpmh_tx_done,
 	TP_fast_assign(
 		       __assign_str(name, d->name);
 		       __entry->m = m;
+		       __assign_str(tcs_name, r->cmds[0].name);
 		       __entry->addr = r->cmds[0].addr;
 		       __entry->data = r->cmds[0].data;
 	),
 
-	TP_printk("%s: ack: tcs-m: %d addr: %#x data: %#x",
-		  __get_str(name), __entry->m, __entry->addr, __entry->data)
+	TP_printk("%s: ack: tcs-m: %d name: %s addr: %#x data: %#x",
+		  __get_str(name), __entry->m, __get_str(tcs_name), __entry->addr, __entry->data)
 );
 
 TRACE_EVENT(rpmh_send_msg,
@@ -49,6 +51,7 @@ TRACE_EVENT(rpmh_send_msg,
 			 __field(u32, state)
 			 __field(int, n)
 			 __field(u32, hdr)
+			 __string(tcs_name, c->name)
 			 __field(u32, addr)
 			 __field(u32, data)
 			 __field(bool, wait)
@@ -60,12 +63,13 @@ TRACE_EVENT(rpmh_send_msg,
 		       __entry->state = state;
 		       __entry->n = n;
 		       __entry->hdr = h;
+		       __assign_str(tcs_name, c->name);
 		       __entry->addr = c->addr;
 		       __entry->data = c->data;
 		       __entry->wait = c->wait;
 	),
 
-	TP_printk("%s: tcs(m): %d [%s] cmd(n): %d msgid: %#x addr: %#x data: %#x complete: %d",
+	TP_printk("%s: tcs(m): %d [%s] cmd(n): %d msgid: %#x name: %s addr: %#x data: %#x complete: %d",
 		  __get_str(name), __entry->m,
 		  __print_symbolic(__entry->state,
 				   { RPMH_SLEEP_STATE, "sleep" },
@@ -73,7 +77,7 @@ TRACE_EVENT(rpmh_send_msg,
 				   { RPMH_ACTIVE_ONLY_STATE, "active" }),
 		  __entry->n,
 		  __entry->hdr,
-		  __entry->addr, __entry->data, __entry->wait)
+		  __get_str(tcs_name), __entry->addr, __entry->data, __entry->wait)
 );
 
 #endif /* _TRACE_RPMH_H */
diff --git a/include/soc/qcom/tcs.h b/include/soc/qcom/tcs.h
index 3acca067c72b..65779c4156a1 100644
--- a/include/soc/qcom/tcs.h
+++ b/include/soc/qcom/tcs.h
@@ -28,6 +28,7 @@ enum rpmh_state {
 /**
  * struct tcs_cmd: an individual request to RPMH.
  *
+ * @name: the name of the resource
  * @addr: the address of the resource slv_id:18:16 | offset:0:15
  * @data: the resource state request
  * @wait: ensure that this command is complete before returning.
@@ -39,6 +40,7 @@ enum rpmh_state {
  *                       (There's no request completion callback)
  */
 struct tcs_cmd {
+	const char *name;
 	u32 addr;
 	u32 data;
 	u32 wait;
-- 
2.25.1

