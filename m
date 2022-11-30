Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D3263D993
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 16:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiK3PhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 10:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiK3Pgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 10:36:50 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 52C5A1C43D
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 07:36:49 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B43A91042;
        Wed, 30 Nov 2022 07:36:55 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 56EB63F67D;
        Wed, 30 Nov 2022 07:36:48 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     will@kernel.org, mark.rutland@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geoff Blake <blakgeof@amazon.com>
Subject: [PATCH 2/2] perf/arm-cmn: Implement shutdown method
Date:   Wed, 30 Nov 2022 15:36:39 +0000
Message-Id: <43fb90e6428d0a667deedd3726f462c3c71a8e94.1669822447.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
In-Reply-To: <bc8183fcd7f6ca07b0d56aa8061d816485b84341.1669822447.git.robin.murphy@arm.com>
References: <bc8183fcd7f6ca07b0d56aa8061d816485b84341.1669822447.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apparently a kexec-induced shutdown does not manage to close perf events
that processes still had open, and thus can leave the PMU running such
that the next kernel may find an overflow interrupt already asserted.
Although the next kernel should ideally be robust aganst that anyway,
let's be polite and disable the PMU to match what we do on remove.

Suggested-by: Geoff Blake <blakgeof@amazon.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm-cmn.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 9e8be5586423..0b2df72cee9f 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -2309,11 +2309,18 @@ static int arm_cmn_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int arm_cmn_remove(struct platform_device *pdev)
+static void arm_cmn_shutdown(struct platform_device *pdev)
 {
 	struct arm_cmn *cmn = platform_get_drvdata(pdev);
 
 	writel_relaxed(0, cmn->dtc[0].base + CMN_DT_DTC_CTL);
+}
+
+static int arm_cmn_remove(struct platform_device *pdev)
+{
+	struct arm_cmn *cmn = platform_get_drvdata(pdev);
+
+	arm_cmn_shutdown(pdev);
 
 	perf_pmu_unregister(&cmn->pmu);
 	cpuhp_state_remove_instance_nocalls(arm_cmn_hp_state, &cmn->cpuhp_node);
@@ -2350,6 +2357,7 @@ static struct platform_driver arm_cmn_driver = {
 	},
 	.probe = arm_cmn_probe,
 	.remove = arm_cmn_remove,
+	.shutdown = arm_cmn_shutdown,
 };
 
 static int __init arm_cmn_init(void)
-- 
2.36.1.dirty

