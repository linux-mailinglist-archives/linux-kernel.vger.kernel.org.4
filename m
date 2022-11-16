Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039B162BC04
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbiKPLdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbiKPLdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:33:09 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93A64FF8C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:23:01 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id r127-20020a1c4485000000b003cfdd569507so348539wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=deWWLgeMCQoKDaS5hv4W5na/Wiux01L+zworhjyK4u4=;
        b=vsxrpOPk+XiN1na4OeDcRayOvu6qrYWgBUniKawA2JAO09iJ1UWKNafuCbiQNPL3+4
         3Jcmu7/9aMRQjifSRz1Vj+DOGUf2O2/Sz++g3W44OCnZn2E8D+GzuKs4jlgSzn37lyPk
         9/Mj+/r1rMg7K7e7FAt1t/4dT1CmzH+sHj852jswx7aj2j9YgdIBgTZFMUE+3EESl0GE
         oY8u9zHS3Mwc6mgLNfPPTenkr/JQSwVlVDIV1RctSEFZg10x49k2o9vTe/56mgplBh2l
         XUYUIWjFwGKumbl7q8eHM0+2EOGm1KToc3Dj16jLJSSFtmh5tAB2hJcuzUU2hNdd1flw
         KMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=deWWLgeMCQoKDaS5hv4W5na/Wiux01L+zworhjyK4u4=;
        b=eZ4PbDoSEqhuUYhlJ2QRkW+KEajn0KcM1AQ8adi5Koul1A/jtW/XzvNV+Gb4qOySmL
         OKqdCfANQ1HGFuePnxM1ZHQnfPnnkTaLHxO2wcLQsdtn7z6mamGxzfQIqdxh97jvaSz8
         GtZJkg+Z0dKHgFAWzmzgMO0eBqRTg2eaOQ2tMzBjEt1kyQtP8sEOBk0xpCsXOqla7+Hf
         n9X6M3aydgA3kXibqDv0rjwWEjyxmaU8dhRoO5kNLnwZNYPDAMFUpWr3EVtLrLISRPEV
         1l9VA/dXAjxZHx+P/SgIgHuGIvCez0f+I4gKBKOZWOVoF6M/5Vzrp4wX5wvX/l1vZbRH
         AQuA==
X-Gm-Message-State: ANoB5plq05sNt4o9VkaW75kbbDN6ls60kkfQWCW0qEkBFIVapbYYj+nL
        N18RQSmnRAZEbAN6ITf+/rq55QUkY5yT/w==
X-Google-Smtp-Source: AA0mqf5uU2QNn8WJ8LWiwzO+RxWTCkuVbDcnphjCpOZACF8oJO9R86AYicF6Ce+2oEjncu9s0UxNFw==
X-Received: by 2002:a05:600c:41ca:b0:3cf:9a6a:c72a with SMTP id t10-20020a05600c41ca00b003cf9a6ac72amr1818295wmh.168.1668597780321;
        Wed, 16 Nov 2022 03:23:00 -0800 (PST)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id ay6-20020a05600c1e0600b003cfd42821dasm1972894wmb.3.2022.11.16.03.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 03:22:59 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH 2/2] soc: qcom: rpmh-rsc: Avoid unnecessary checks on irq-done response
Date:   Wed, 16 Nov 2022 13:22:46 +0200
Message-Id: <20221116112246.2640648-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221116112246.2640648-1-abel.vesa@linaro.org>
References: <20221116112246.2640648-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RSC interrupt is issued only after the request is complete. For
fire-n-forget requests, the irq-done interrupt is sent after issuing the
RPMH request and for response-required request, the interrupt is
triggered only after all the requests are complete.

These unnecessary checks in the interrupt handler issues AHB reads from
a critical path. Lets remove them and clean up error handling in
rpmh_request data structures.

Co-developed-by: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/soc/qcom/rpmh-internal.h |  4 +---
 drivers/soc/qcom/rpmh-rsc.c      | 22 +++-------------------
 drivers/soc/qcom/rpmh.c          | 10 ++--------
 drivers/soc/qcom/trace-rpmh.h    | 11 ++++-------
 4 files changed, 10 insertions(+), 37 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
index 0160c1669583..e3cf1beff803 100644
--- a/drivers/soc/qcom/rpmh-internal.h
+++ b/drivers/soc/qcom/rpmh-internal.h
@@ -59,7 +59,6 @@ struct tcs_group {
  * @cmd: the payload that will be part of the @msg
  * @completion: triggered when request is done
  * @dev: the device making the request
- * @err: err return from the controller
  * @needs_free: check to free dynamically allocated request object
  */
 struct rpmh_request {
@@ -67,7 +66,6 @@ struct rpmh_request {
 	struct tcs_cmd cmd[MAX_RPMH_PAYLOAD];
 	struct completion *completion;
 	const struct device *dev;
-	int err;
 	bool needs_free;
 };
 
@@ -144,7 +142,7 @@ int rpmh_rsc_write_ctrl_data(struct rsc_drv *drv,
 void rpmh_rsc_invalidate(struct rsc_drv *drv);
 void rpmh_rsc_write_next_wakeup(struct rsc_drv *drv);
 
-void rpmh_tx_done(const struct tcs_request *msg, int r);
+void rpmh_tx_done(const struct tcs_request *msg);
 int rpmh_flush(struct rpmh_ctrlr *ctrlr);
 
 #endif /* __RPM_INTERNAL_H__ */
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index cc24874d0a95..0f8b2249f889 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -439,10 +439,9 @@ static void enable_tcs_irq(struct rsc_drv *drv, int tcs_id, bool enable)
 static irqreturn_t tcs_tx_done(int irq, void *p)
 {
 	struct rsc_drv *drv = p;
-	int i, j, err = 0;
+	int i;
 	unsigned long irq_status;
 	const struct tcs_request *req;
-	struct tcs_cmd *cmd;
 
 	irq_status = readl_relaxed(drv->tcs_base + drv->regs[RSC_DRV_IRQ_STATUS]);
 
@@ -451,22 +450,7 @@ static irqreturn_t tcs_tx_done(int irq, void *p)
 		if (WARN_ON(!req))
 			goto skip;
 
-		err = 0;
-		for (j = 0; j < req->num_cmds; j++) {
-			u32 sts;
-
-			cmd = &req->cmds[j];
-			sts = read_tcs_cmd(drv, drv->regs[RSC_DRV_CMD_STATUS], i, j);
-			if (!(sts & CMD_STATUS_ISSUED) ||
-			   ((req->wait_for_compl || cmd->wait) &&
-			   !(sts & CMD_STATUS_COMPL))) {
-				pr_err("Incomplete request: %s: addr=%#x data=%#x",
-				       drv->name, cmd->addr, cmd->data);
-				err = -EIO;
-			}
-		}
-
-		trace_rpmh_tx_done(drv, i, req, err);
+		trace_rpmh_tx_done(drv, i, req);
 
 		/*
 		 * If wake tcs was re-purposed for sending active
@@ -491,7 +475,7 @@ static irqreturn_t tcs_tx_done(int irq, void *p)
 		spin_unlock(&drv->lock);
 		wake_up(&drv->tcs_wait);
 		if (req)
-			rpmh_tx_done(req, err);
+			rpmh_tx_done(req);
 	}
 
 	return IRQ_HANDLED;
diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index 3a53ed99d03c..08e09642d7f5 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -76,19 +76,13 @@ static struct rpmh_ctrlr *get_rpmh_ctrlr(const struct device *dev)
 	return &drv->client;
 }
 
-void rpmh_tx_done(const struct tcs_request *msg, int r)
+void rpmh_tx_done(const struct tcs_request *msg)
 {
 	struct rpmh_request *rpm_msg = container_of(msg, struct rpmh_request,
 						    msg);
 	struct completion *compl = rpm_msg->completion;
 	bool free = rpm_msg->needs_free;
 
-	rpm_msg->err = r;
-
-	if (r)
-		dev_err(rpm_msg->dev, "RPMH TX fail in msg addr=%#x, err=%d\n",
-			rpm_msg->msg.cmds[0].addr, r);
-
 	if (!compl)
 		goto exit;
 
@@ -194,7 +188,7 @@ static int __rpmh_write(const struct device *dev, enum rpmh_state state,
 	} else {
 		/* Clean up our call by spoofing tx_done */
 		ret = 0;
-		rpmh_tx_done(&rpm_msg->msg, ret);
+		rpmh_tx_done(&rpm_msg->msg);
 	}
 
 	return ret;
diff --git a/drivers/soc/qcom/trace-rpmh.h b/drivers/soc/qcom/trace-rpmh.h
index feb0cb455e37..12b676b20cb2 100644
--- a/drivers/soc/qcom/trace-rpmh.h
+++ b/drivers/soc/qcom/trace-rpmh.h
@@ -14,16 +14,15 @@
 
 TRACE_EVENT(rpmh_tx_done,
 
-	TP_PROTO(struct rsc_drv *d, int m, const struct tcs_request *r, int e),
+	TP_PROTO(struct rsc_drv *d, int m, const struct tcs_request *r),
 
-	TP_ARGS(d, m, r, e),
+	TP_ARGS(d, m, r),
 
 	TP_STRUCT__entry(
 			 __string(name, d->name)
 			 __field(int, m)
 			 __field(u32, addr)
 			 __field(u32, data)
-			 __field(int, err)
 	),
 
 	TP_fast_assign(
@@ -31,12 +30,10 @@ TRACE_EVENT(rpmh_tx_done,
 		       __entry->m = m;
 		       __entry->addr = r->cmds[0].addr;
 		       __entry->data = r->cmds[0].data;
-		       __entry->err = e;
 	),
 
-	TP_printk("%s: ack: tcs-m: %d addr: %#x data: %#x errno: %d",
-		  __get_str(name), __entry->m, __entry->addr, __entry->data,
-		  __entry->err)
+	TP_printk("%s: ack: tcs-m: %d addr: %#x data: %#x",
+		  __get_str(name), __entry->m, __entry->addr, __entry->data)
 );
 
 TRACE_EVENT(rpmh_send_msg,
-- 
2.34.1

