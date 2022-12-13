Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B869F64B8FF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 16:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236208AbiLMPzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 10:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235622AbiLMPzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 10:55:01 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0618563B7;
        Tue, 13 Dec 2022 07:54:59 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDC6Dkq026377;
        Tue, 13 Dec 2022 09:54:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=H9bD4vEGhPnw3EnUsCGAUmQGYOk16+ZEqAiPgLivwFI=;
 b=H2Y6St4cDt4F+GA/ZneeEQrS6FWzrum+Dss3jegqVV2UvHIKrFiiWncspHMZt7rttqM+
 DTd4RPbUyPr5nTaRPWhDo8IfMNkEWDq/HdrUr8JyJA8xfPm0+yMWiK46pY8gzOTaQfx5
 1hY9YIsXwZrtIKPOQp7/KJ+lt8lRfmeLnFDUyDrQ6jB61Q8+T5m0cFJ18emnj+bg+WZr
 ltPl5yVja+ZZWOgFmawjD5E3+iMgcUku+IJl/Xt0/0K7d6kOmYF4IZK1w7AqMxopHFPF
 DdlNaxjGWgxGHjf/VOVH/5brU++wFNKD9bZXUThFiOOE9y19xz3qNf/6E3tqOGv0QM/L ww== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3mcrd63f2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 09:54:51 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Tue, 13 Dec
 2022 09:54:48 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.20 via Frontend Transport; Tue, 13 Dec 2022 09:54:48 -0600
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.111])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id DA528B10;
        Tue, 13 Dec 2022 15:54:48 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <rafael@kernel.org>, <len.brown@intel.com>, <pavel@ucw.cz>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] PM: runtime: Document that force_suspend() is incompatible with SMART_SUSPEND
Date:   Tue, 13 Dec 2022 15:54:48 +0000
Message-ID: <20221213155448.385167-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: M77udDUM_cpgyAKQhTe-BiCX7ukNhgJ1
X-Proofpoint-ORIG-GUID: M77udDUM_cpgyAKQhTe-BiCX7ukNhgJ1
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pm_runtime_force_suspend() cannot be used with DPM_FLAG_SMART_SUSPEND, so
note this in the kerneldoc.

If DPM_FLAG_SMART_SUSPEND is set and the PM core cannot skip system resume
it will call pm_runtime_active() on the driver. This can lead to an
inconsistent state where:

  pm_runtime_force_suspend() called ->runtime_suspend

but

  device_resume_noirq() called pm_runtime_set_active()

This leaves the driver actually suspended but marked as active.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/base/power/runtime.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 50e726b6c2cf..b29be7d4d7d0 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1864,6 +1864,10 @@ static bool pm_runtime_need_not_resume(struct device *dev)
  * sure the device is put into low power state and it should only be used during
  * system-wide PM transitions to sleep states.  It assumes that the analogous
  * pm_runtime_force_resume() will be used to resume the device.
+ *
+ * Do not use with DPM_FLAG_SMART_SUSPEND as this can lead to an inconsistent
+ * state where this function has called the ->runtime_suspend callback but the
+ * PM core marks the driver as runtime active.
  */
 int pm_runtime_force_suspend(struct device *dev)
 {
-- 
2.30.2

