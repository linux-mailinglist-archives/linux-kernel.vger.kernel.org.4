Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B642E6BCAA1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 10:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjCPJT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 05:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjCPJTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 05:19:54 -0400
Received: from mail.nfschina.com (unknown [42.101.60.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3D024BC8;
        Thu, 16 Mar 2023 02:19:52 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 6253D1A00ADE;
        Thu, 16 Mar 2023 17:19:51 +0800 (CST)
X-Virus-Scanned: amavisd-new at nfschina.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (localhost.localdomain [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id y7H5Ln4bIa7g; Thu, 16 Mar 2023 17:19:50 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: yuzhe@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id E79771A00AD7;
        Thu, 16 Mar 2023 17:19:49 +0800 (CST)
From:   Yu Zhe <yuzhe@nfschina.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mathieu.poirier@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        liqiong@nfschina.com, Yu Zhe <yuzhe@nfschina.com>
Subject: [PATCH] remoteproc: qcom_q6v5_mss: remove unnecessary (void*) conversions
Date:   Thu, 16 Mar 2023 17:19:02 +0800
Message-Id: <20230316091902.20765-1-yuzhe@nfschina.com>
X-Mailer: git-send-email 2.11.0
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,RCVD_IN_VALIDITY_RPBL,
        RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointer variables of void * type do not require type cast.

Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
---
 drivers/remoteproc/qcom_q6v5_mss.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index ab053084f7a2..e7a67c8c16a0 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -1562,7 +1562,7 @@ static void qcom_q6v5_dump_segment(struct rproc *rproc,
 
 static int q6v5_start(struct rproc *rproc)
 {
-	struct q6v5 *qproc = (struct q6v5 *)rproc->priv;
+	struct q6v5 *qproc = rproc->priv;
 	int xfermemop_ret;
 	int ret;
 
@@ -1604,7 +1604,7 @@ static int q6v5_start(struct rproc *rproc)
 
 static int q6v5_stop(struct rproc *rproc)
 {
-	struct q6v5 *qproc = (struct q6v5 *)rproc->priv;
+	struct q6v5 *qproc = rproc->priv;
 	int ret;
 
 	ret = qcom_q6v5_request_stop(&qproc->q6v5, qproc->sysmon);
@@ -1662,7 +1662,7 @@ static int qcom_q6v5_register_dump_segments(struct rproc *rproc,
 
 static unsigned long q6v5_panic(struct rproc *rproc)
 {
-	struct q6v5 *qproc = (struct q6v5 *)rproc->priv;
+	struct q6v5 *qproc = rproc->priv;
 
 	return qcom_q6v5_panic(&qproc->q6v5);
 }
@@ -1977,7 +1977,7 @@ static int q6v5_probe(struct platform_device *pdev)
 	rproc->auto_boot = false;
 	rproc_coredump_set_elf_info(rproc, ELFCLASS32, EM_NONE);
 
-	qproc = (struct q6v5 *)rproc->priv;
+	qproc = rproc->priv;
 	qproc->dev = &pdev->dev;
 	qproc->rproc = rproc;
 	qproc->hexagon_mdt_image = "modem.mdt";
-- 
2.11.0

