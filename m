Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70CD6663F0B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 12:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237634AbjAJLKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 06:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238364AbjAJLIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 06:08:53 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 446A832E8C
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 03:08:12 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 143E04B3;
        Tue, 10 Jan 2023 03:08:54 -0800 (PST)
Received: from e126815.warwick.arm.com (e126815.arm.com [10.32.32.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 789A53F587;
        Tue, 10 Jan 2023 03:08:10 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org, quic_jinlmao@quicinc.com,
        suzuki.poulose@arm.com, mike.leach@linaro.org
Cc:     James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] coresight: cti: Add PM runtime call in enable_store
Date:   Tue, 10 Jan 2023 11:07:35 +0000
Message-Id: <20230110110736.2709917-3-james.clark@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230110110736.2709917-1-james.clark@arm.com>
References: <20230110110736.2709917-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mao Jinlong <quic_jinlmao@quicinc.com>

In commit 6746eae4bbad ("coresight: cti: Fix hang in cti_disable_hw()")
PM runtime calls are removed from cti_enable_hw/cti_disable_hw. When
enabling CTI by writing enable sysfs node, clock for accessing CTI
register won't be enabled. Device will crash due to register access
issue. Add PM runtime call in enable_store to fix this issue.

Fixes: 6746eae4bbad ("coresight: cti: Fix hang in cti_disable_hw()")
Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
[Change to only call pm_runtime_put if a disable happened]
Tested-by: Jinlong Mao <quic_jinlmao@quicinc.com>
Signed-off-by: James Clark <james.clark@arm.com>
---
 drivers/hwtracing/coresight/coresight-cti-sysfs.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-cti-sysfs.c b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
index 6d59c815ecf5..71e7a8266bb3 100644
--- a/drivers/hwtracing/coresight/coresight-cti-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
@@ -108,10 +108,19 @@ static ssize_t enable_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	if (val)
+	if (val) {
+		ret = pm_runtime_resume_and_get(dev->parent);
+		if (ret)
+			return ret;
 		ret = cti_enable(drvdata->csdev);
-	else
+		if (ret)
+			pm_runtime_put(dev->parent);
+	} else {
 		ret = cti_disable(drvdata->csdev);
+		if (!ret)
+			pm_runtime_put(dev->parent);
+	}
+
 	if (ret)
 		return ret;
 	return size;
-- 
2.25.1

