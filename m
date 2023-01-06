Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE95660309
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 16:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjAFPXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 10:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbjAFPXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 10:23:43 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E650B45649
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 07:23:41 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8552812FC;
        Fri,  6 Jan 2023 07:24:23 -0800 (PST)
Received: from e126815.warwick.arm.com (e126815.arm.com [10.32.32.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 220673F71A;
        Fri,  6 Jan 2023 07:23:40 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org, quic_jinlmao@quicinc.com,
        suzuki.poulose@arm.com, mike.leach@linaro.org
Cc:     James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] coresight: cti: Prevent negative values of enable count
Date:   Fri,  6 Jan 2023 15:23:28 +0000
Message-Id: <20230106152331.1374973-2-james.clark@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230106152331.1374973-1-james.clark@arm.com>
References: <20230106152331.1374973-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Writing 0 to the enable control repeatedly results in a negative value
for enable_req_count. After this, writing 1 to the enable control
appears to not work until the count returns to positive.

Change it so that it's impossible for enable_req_count to be < 0.
Returning an error will also allow us to decide whether to call
runtime_pm_put() or not in the following commit.

Signed-off-by: James Clark <james.clark@arm.com>
---
 drivers/hwtracing/coresight/coresight-cti-core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-cti-core.c b/drivers/hwtracing/coresight/coresight-cti-core.c
index d2cf4f4848e1..838872f2484d 100644
--- a/drivers/hwtracing/coresight/coresight-cti-core.c
+++ b/drivers/hwtracing/coresight/coresight-cti-core.c
@@ -151,9 +151,16 @@ static int cti_disable_hw(struct cti_drvdata *drvdata)
 {
 	struct cti_config *config = &drvdata->config;
 	struct coresight_device *csdev = drvdata->csdev;
+	int ret = 0;
 
 	spin_lock(&drvdata->spinlock);
 
+	/* don't allow negative refcounts, return an error */
+	if (!atomic_read(&drvdata->config.enable_req_count)) {
+		ret = -EINVAL;
+		goto cti_not_disabled;
+	}
+
 	/* check refcount - disable on 0 */
 	if (atomic_dec_return(&drvdata->config.enable_req_count) > 0)
 		goto cti_not_disabled;
@@ -171,12 +178,12 @@ static int cti_disable_hw(struct cti_drvdata *drvdata)
 	coresight_disclaim_device_unlocked(csdev);
 	CS_LOCK(drvdata->base);
 	spin_unlock(&drvdata->spinlock);
-	return 0;
+	return ret;
 
 	/* not disabled this call */
 cti_not_disabled:
 	spin_unlock(&drvdata->spinlock);
-	return 0;
+	return ret;
 }
 
 void cti_write_single_reg(struct cti_drvdata *drvdata, int offset, u32 value)
-- 
2.25.1

