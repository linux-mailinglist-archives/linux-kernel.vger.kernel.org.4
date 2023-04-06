Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261436D9B26
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 16:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238963AbjDFOu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 10:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238925AbjDFOuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 10:50:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E5DFA258
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 07:49:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C57BC106F;
        Thu,  6 Apr 2023 07:50:15 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B18EE3F762;
        Thu,  6 Apr 2023 07:49:30 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     will@kernel.org
Cc:     mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ilkka@os.amperecomputing.com,
        Geoff Blake <blakgeof@amazon.com>
Subject: [PATCH] perf/arm-cmn: Fix DTC reset
Date:   Thu,  6 Apr 2023 15:49:15 +0100
Message-Id: <f0b61513276ee2c448ae02a6840135571039cea7.1680792373.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out that my naive DTC reset logic fails to work as intended,
since clearing PMCR.PMU_EN appears to result in writes to PMOVSR_CLR
being ignored, while some hard-to-characterise combination of conditions
(differently between DTC0 and secondary DTCs) also appears to result in
PMOVSR reading as zero even when an overflow remains asserted. Thus
rather than resetting the PMU to a nice clean state, we can currently
end up with screaming spurious interrupts from secondary DTCs which we
can neither see nor clear. This behaviour is of course not documented.

Resetting PMCR to disable the interrupt output but enable the PMU itself
seems to at least make the PMOVSR_CLR write work as expected on DTC0
(although it looks like writing to PMCR twice has actually been having
some hidden side-effect of clearing any pending overflows there).
Unfortunately this still does not seem to help secondary DTCs, but going
beyond PMU scope and additionally resetting DTC_CTL does seems to make
everything work out, and superficially looks sensible. Therefore pile
that onto the house of empirical cards too, until I can check with the
hardware team whether there's actually any proper recommended way of
recovering from an arbitrary PMU state after an oops/kexec/whatever.

Fixes: 0ba64770a2f2 ("perf: Add Arm CMN-600 PMU driver")
Reported-by: Geoff Blake <blakgeof@amazon.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
This supersedes the previous shutdown/IRQ patches, now that I've
finally managed to make *some* sense of what's really going on. If
anyone's interested, this is the contrivance I used for testing:

https://gitlab.arm.com/linux-arm/linux-rm/-/commit/d8f1035c5bc510516d6e4f0b7bf0b875a749daf7
---
 drivers/perf/arm-cmn.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 144cc08d9e04..81fe01171e33 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -1899,7 +1899,10 @@ static int arm_cmn_init_dtc(struct arm_cmn *cmn, struct arm_cmn_node *dn, int id
 	if (dtc->irq < 0)
 		return dtc->irq;
 
-	writel_relaxed(0, dtc->base + CMN_DT_PMCR);
+	if (idx == 0)
+		writel_relaxed(0, dtc->base + CMN_DT_DTC_CTL);
+
+	writel_relaxed(CMN_DT_PMCR_PMU_EN, dtc->base + CMN_DT_PMCR);
 	writel_relaxed(0x1ff, dtc->base + CMN_DT_PMOVSR_CLR);
 	writel_relaxed(CMN_DT_PMCR_OVFL_INTR_EN, dtc->base + CMN_DT_PMCR);
 
-- 
2.39.2.101.g768bb238c484.dirty

