Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A619D665B7D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 13:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbjAKMhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 07:37:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbjAKMhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 07:37:17 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532B228A;
        Wed, 11 Jan 2023 04:37:16 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id c6so16650209pls.4;
        Wed, 11 Jan 2023 04:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/SfV/BmxfgdOOg5a6VYc2jWBCaoBDxbExawT4jBtqtI=;
        b=O7/jUWap8/638xgc1Ns5tmKeXTVrPsNk54AfACcQGv9yvWZk1ra/GkWfNnS+mKj4Wz
         uYE2up5XVY8j/4rdhu83e72UpnNlYVsBe1v0buspaQyq1wEsBhFqs4LLRORvzxsYeeZo
         SfjYGP2FKujTTmrvyXe4kyTcSFhyvQn5E6ENkvnH2LFlwL5Vk9PlullK5Ia5qshMHw1U
         qC1ceLtVOEZdMIRlBkEl5NCi+yWjrzz8oa586FzZw6lS0dU0lRBURInquiitvcIkVz8L
         suciE74D914UNRjFY7wgVQR8BtaedeT4U2onJu2NwiHlhv43ZZHGWz9suqr14hR6Qpy+
         6q9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/SfV/BmxfgdOOg5a6VYc2jWBCaoBDxbExawT4jBtqtI=;
        b=fcQSEaaDa+8tiiiLwuedQOqY0VxlRvzAJwFIJE8K8aygEzB3Crp+kJNgU2pAOxyu6D
         Wi9xOrhQY1pr73SRbMLBoR+fZ7wcAz7laWW4mn12yWaB9oFt4lLjlGwEiXDxUNFsll7e
         6uzIvmQ1KjJExKxX2OkU1pnrndduoWjLH5Rf6IsxbHHaWF01NHISSSNuUdu/nk/9q13f
         r/UCoY3DZVVED65e0TmFKC0RHhBxuIV9FiNbDp/iuA6miBTqwoOZvb/MkRwrpJ49mQLu
         kjraR2mug4XIXw5DLMZyB6RsWrO9b0B3nZGHBa6m0U82gYeOP3NiNe/bDCbp031KmKFY
         KtDg==
X-Gm-Message-State: AFqh2kqHyzrUSIXFVm4lIuqjJOIqPoMFsUMAlZH1VYQ/h1/L9efDS3BD
        QlGFV6dkmN6e1/wW9EQlA+8xazdLe1FwLg==
X-Google-Smtp-Source: AMrXdXshuF+kzSTsj2dXwUwbKvAbPV58EeKK2WngYR6E++wbYodX3z6ukImfAX8/oqLycqEDaVDLWw==
X-Received: by 2002:a17:902:f791:b0:192:5ec4:6656 with SMTP id q17-20020a170902f79100b001925ec46656mr74448750pln.3.1673440635738;
        Wed, 11 Jan 2023 04:37:15 -0800 (PST)
Received: from localhost.localdomain ([43.132.141.3])
        by smtp.gmail.com with ESMTPSA id im22-20020a170902bb1600b00186748fe6ccsm10015648plb.214.2023.01.11.04.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 04:37:15 -0800 (PST)
From:   korantwork@gmail.com
To:     hverkuil-cisco@xs4all.nl, mchehab@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Xinghui Li <korantli@tencent.com>, loydlv <loydlv@tencent.com>
Subject: [PATCH] media:cec:fix double free and uaf issue when cancel data during noblocking
Date:   Wed, 11 Jan 2023 20:37:12 +0800
Message-Id: <20230111123712.160882-1-korantwork@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xinghui Li <korantli@tencent.com>

data could be free when it is not completed during transmit if
the opt is nonblocking.In this case,the regular free could lead
to double-free.So, add the return value '-EPERM' to mark the
above case.

Reported-by: loydlv <loydlv@tencent.com>
Signed-off-by: Xinghui Li <korantli@tencent.com>
---
 drivers/media/cec/core/cec-adap.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/media/cec/core/cec-adap.c b/drivers/media/cec/core/cec-adap.c
index 4f5ab3cae8a7..c2ba8d1173c1 100644
--- a/drivers/media/cec/core/cec-adap.c
+++ b/drivers/media/cec/core/cec-adap.c
@@ -311,7 +311,7 @@ static void cec_post_state_event(struct cec_adapter *adap)
  *
  * This function is called with adap->lock held.
  */
-static void cec_data_completed(struct cec_data *data)
+static int cec_data_completed(struct cec_data *data)
 {
 	/*
 	 * Delete this transmit from the filehandle's xfer_list since
@@ -339,7 +339,9 @@ static void cec_data_completed(struct cec_data *data)
 		if (data->fh)
 			cec_queue_msg_fh(data->fh, &data->msg);
 		kfree(data);
+		return -EPERM;
 	}
+	return 0;
 }
 
 /*
@@ -349,7 +351,7 @@ static void cec_data_completed(struct cec_data *data)
  *
  * This function is called with adap->lock held.
  */
-static void cec_data_cancel(struct cec_data *data, u8 tx_status, u8 rx_status)
+static int cec_data_cancel(struct cec_data *data, u8 tx_status, u8 rx_status)
 {
 	struct cec_adapter *adap = data->adap;
 
@@ -388,7 +390,7 @@ static void cec_data_cancel(struct cec_data *data, u8 tx_status, u8 rx_status)
 		/* Allow drivers to process the message first */
 		call_op(adap, received, &data->msg);
 
-	cec_data_completed(data);
+	return cec_data_completed(data);
 }
 
 /*
@@ -744,6 +746,7 @@ int cec_transmit_msg_fh(struct cec_adapter *adap, struct cec_msg *msg,
 {
 	struct cec_data *data;
 	bool is_raw = msg_is_raw(msg);
+	int ret = 0;
 
 	if (adap->devnode.unregistered)
 		return -ENODEV;
@@ -916,18 +919,20 @@ int cec_transmit_msg_fh(struct cec_adapter *adap, struct cec_msg *msg,
 	/* Cancel the transmit if it was interrupted */
 	if (!data->completed) {
 		if (data->msg.tx_status & CEC_TX_STATUS_OK)
-			cec_data_cancel(data, CEC_TX_STATUS_OK, CEC_RX_STATUS_ABORTED);
+			ret = cec_data_cancel(data, CEC_TX_STATUS_OK, CEC_RX_STATUS_ABORTED);
 		else
-			cec_data_cancel(data, CEC_TX_STATUS_ABORTED, 0);
+			ret = cec_data_cancel(data, CEC_TX_STATUS_ABORTED, 0);
 	}
 
 	/* The transmit completed (possibly with an error) */
-	*msg = data->msg;
-	if (WARN_ON(!list_empty(&data->list)))
-		list_del(&data->list);
-	if (WARN_ON(!list_empty(&data->xfer_list)))
-		list_del(&data->xfer_list);
-	kfree(data);
+	if (!ret) {
+		*msg = data->msg;
+		if (WARN_ON(!list_empty(&data->list)))
+			list_del(&data->list);
+		if (WARN_ON(!list_empty(&data->xfer_list)))
+			list_del(&data->xfer_list);
+		kfree(data);
+	}
 	return 0;
 }
 
-- 
2.34.1


