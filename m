Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD395BA747
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 09:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiIPHMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 03:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIPHMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 03:12:43 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C8E36849;
        Fri, 16 Sep 2022 00:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1663312362; x=1694848362;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=5L6dIif8ingzv+vHB+hMzVyWir1OfL0FJ4UuSGWbKbQ=;
  b=w2+w+hnP0SKo0we31kB3zqM6R4RL7LmZtdWMYPZVxAbp1H8YuBF8acC/
   O5gV1Jy/L9SIjNJl8EdmmmWygSoRSmSGQJll7ecxXuGXBTLyXOCpUpUuL
   /Kauu7rsCYAngQxN1tZoaYKtXqe47+Uk/tqHfv5CDm61XZdnKVkadLtRD
   Y=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 16 Sep 2022 00:12:40 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 00:12:40 -0700
Received: from ecbld-sh026-lnx.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 16 Sep 2022 00:12:38 -0700
From:   Maria Yu <quic_aiquny@quicinc.com>
To:     <mathieu.poirier@linaro.org>
CC:     Maria Yu <quic_aiquny@quicinc.com>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_clew@quicinc.com>
Subject: [PATCH v4] remoteproc: core: do pm relax when in RPROC_OFFLINE
Date:   Fri, 16 Sep 2022 15:12:31 +0800
Message-ID: <1663312351-28476-1-git-send-email-quic_aiquny@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <128dc161-8949-1146-bf8b-310aa33c06a8@quicinc.com>
References: <128dc161-8949-1146-bf8b-310aa33c06a8@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RPROC_OFFLINE state indicate there is no recovery process
is in progress and no chance to do the pm_relax.
Because when recovering from crash, rproc->lock is held and
state is RPROC_CRASHED -> RPROC_OFFLINE -> RPROC_RUNNING,
and then unlock rproc->lock.
When the state is in RPROC_OFFLINE it means separate request
of rproc_stop was done and no need to hold the wakeup source
in crash handler to recover any more.

Signed-off-by: Maria Yu <quic_aiquny@quicinc.com>
---
 drivers/remoteproc/remoteproc_core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index e5279ed9a8d7..6bc7b8b7d01e 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1956,6 +1956,17 @@ static void rproc_crash_handler_work(struct work_struct *work)
 	if (rproc->state == RPROC_CRASHED || rproc->state == RPROC_OFFLINE) {
 		/* handle only the first crash detected */
 		mutex_unlock(&rproc->lock);
+		/*
+		 * RPROC_OFFLINE state indicate there is no recovery process
+		 * is in progress and no chance to have pm_relax in place.
+		 * Because when recovering from crash, rproc->lock is held and
+		 * state is RPROC_CRASHED -> RPROC_OFFLINE -> RPROC_RUNNING,
+		 * and then unlock rproc->lock.
+		 * RPROC_OFFLINE is only an intermediate state in recovery
+		 * process.
+		 */
+		if (rproc->state == RPROC_OFFLINE)
+			pm_relax(rproc->dev.parent);
 		return;
 	}
 
-- 
2.7.4

