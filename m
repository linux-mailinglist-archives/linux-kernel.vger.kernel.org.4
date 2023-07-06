Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04A4749841
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 11:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjGFJY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 05:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjGFJYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 05:24:25 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C4D210A
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 02:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1688635435;
  x=1720171435;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=Sm5pjG2Fhn0ZlxTTnrxCCc7Kqk9wvYr1ZQV9QqoXibU=;
  b=T5cspn2eR0nJv5Yu0MlR832T/WJfxsbbzbs4j3DUX8qVw4XR3Hh/FdVP
   JUdp12vjIHw7IoCyCQ7fsprtuQ7P2OfhuX/uQfcwkPaZXGEscBMfwtIOR
   kIvvTgl+5W+HzOwwj1YC9OyUN647zeftFUah5uzoF0iS7VkZ9aaGSPlpq
   amY58J5YciO1dewZu1o0fdlD3P5AIMl1H9xgvLpo+7ISxm9KzTbyZVU8x
   2V1Qe23UTmFXKYLjPdus5mE9Cyrj+tuKNlJtCygj9vBtOXebkQ900/oPv
   zGT76wJuT2Mr9pNlDqHnU4ZmjkOv2SirgFztRr+waiirqzeyPhS2lpNGv
   w==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
Date:   Thu, 6 Jul 2023 11:23:05 +0200
Subject: [PATCH] perf/smmuv3: Remove build dependency on ACPI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230706-smmuv3-pmu-noacpi-v1-1-7083ef189158@axis.com>
X-B4-Tracking: v=1; b=H4sIAPiHpmQC/x2NywqDMBAAf0X23IXUra32V0oPSdzUPeRBFqUg/
 ntjjzMwzA7KVVjh2e1QeROVnBpcLx34xaYPo8yNoTc9mYe5o8a4boQlrpiy9UUw+JEGN5EdJ4L
 WOauMrtrkl7MMOd9OXSoH+f5Xr/dx/ADpHjJeegAAAA==
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
CC:     <jean-philippe@linaro.org>, <jkchen@linux.alibaba.com>,
        <robin.murphy@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver supports working without ACPI since commit 3f7be43561766
("perf/smmuv3: Add devicetree support"), so remove the build dependency.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/perf/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 711f824000864..4eef9ad3c1954 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -92,7 +92,7 @@ config ARM_PMU_ACPI
 
 config ARM_SMMU_V3_PMU
 	 tristate "ARM SMMUv3 Performance Monitors Extension"
-	 depends on (ARM64 && ACPI) || (COMPILE_TEST && 64BIT)
+	 depends on ARM64 || (COMPILE_TEST && 64BIT)
 	 depends on GENERIC_MSI_IRQ
 	   help
 	   Provides support for the ARM SMMUv3 Performance Monitor Counter

---
base-commit: 6995e2de6891c724bfeb2db33d7b87775f913ad1
change-id: 20230706-smmuv3-pmu-noacpi-fc835b93a893

Best regards,
-- 
Vincent Whitchurch <vincent.whitchurch@axis.com>

