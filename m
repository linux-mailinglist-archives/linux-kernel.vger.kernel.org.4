Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B022F63CB93
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 00:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237100AbiK2XIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 18:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236885AbiK2XIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 18:08:40 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD41F6DFDF;
        Tue, 29 Nov 2022 15:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669763319; x=1701299319;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fLd+RbKdEt5N7t1sQuFBcbp2DIuuw03BqlrwDN3LPTY=;
  b=FdmIIWf/cCk5cLAVJzF+Giou1iwhxHoIwUTrzJjQEjdYijFnAgOMw2Vb
   d2LH+M5FTs0DaLy0P8osGCvfaKhKAK2/I8vKtRxzS+jJMo36GfgFN9XgY
   H0DsED30pNrImxMUiDB4JwUzZldSMYNMFG73BaNb/Awr/gt3lT6lTzmDk
   401u+7fxdFaA801hwHRybGDK9b4Gvq3qCDL/RORunIQKtlSPC62DAOZdq
   d0e3px89mP5lYHqyE62tSTTB9Pcoo1sz3guxGcvZFlGkMlAxs6w1K5O3P
   1ZEwWFWbZrZ++xl7iC87fBOwYcEyFHAeSYCd/xPD5FktDDoAzManpHBvb
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="342173498"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="342173498"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 15:08:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="707416267"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="707416267"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga008.fm.intel.com with ESMTP; 29 Nov 2022 15:08:38 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] powercap: idle_inject: Fix warnings with make W=1
Date:   Tue, 29 Nov 2022 15:08:21 -0800
Message-Id: <20221129230821.4021932-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following warning at three places:

Function parameter or member 'ii_dev' not described.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/powercap/idle_inject.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
index 999e218d7793..fe86a09e3b67 100644
--- a/drivers/powercap/idle_inject.c
+++ b/drivers/powercap/idle_inject.c
@@ -147,6 +147,7 @@ static void idle_inject_fn(unsigned int cpu)
 
 /**
  * idle_inject_set_duration - idle and run duration update helper
+ * @ii_dev: idle injection control device structure
  * @run_duration_us: CPU run time to allow in microseconds
  * @idle_duration_us: CPU idle time to inject in microseconds
  */
@@ -162,6 +163,7 @@ void idle_inject_set_duration(struct idle_inject_device *ii_dev,
 
 /**
  * idle_inject_get_duration - idle and run duration retrieval helper
+ * @ii_dev: idle injection control device structure
  * @run_duration_us: memory location to store the current CPU run time
  * @idle_duration_us: memory location to store the current CPU idle time
  */
@@ -175,6 +177,7 @@ void idle_inject_get_duration(struct idle_inject_device *ii_dev,
 
 /**
  * idle_inject_set_latency - set the maximum latency allowed
+ * @ii_dev: idle injection control device structure
  * @latency_us: set the latency requirement for the idle state
  */
 void idle_inject_set_latency(struct idle_inject_device *ii_dev,
-- 
2.31.1

