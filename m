Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4C86960F0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 11:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbjBNKiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 05:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbjBNKiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 05:38:07 -0500
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611E7244B5;
        Tue, 14 Feb 2023 02:38:06 -0800 (PST)
Received: from robin.home.jannau.net (p579ad32f.dip0.t-ipconnect.de [87.154.211.47])
        by soltyk.jannau.net (Postfix) with ESMTPSA id 0042726F78F;
        Tue, 14 Feb 2023 11:38:04 +0100 (CET)
From:   Janne Grunau <j@jannau.net>
Date:   Tue, 14 Feb 2023 11:38:02 +0100
Subject: [PATCH 2/2] drivers/perf: apple_m1: Add Apple M2 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230214-apple_m2_pmu-v1-2-9c9213ab9b63@jannau.net>
References: <20230214-apple_m2_pmu-v1-0-9c9213ab9b63@jannau.net>
In-Reply-To: <20230214-apple_m2_pmu-v1-0-9c9213ab9b63@jannau.net>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1281; i=j@jannau.net;
 h=from:subject:message-id; bh=UMxgpqVWtk29npa6KJJnZpE9eIozX2KpguZSAOm57YE=;
 b=owGbwMvMwCG2UNrmdq9+ahrjabUkhuTXKd0V6YlpMx5ZS1za/J2TybBv8/IZ/xO8yu+qKthMO
 5/z47NzRykLgxgHg6yYIkuS9ssOhtU1ijG1D8Jg5rAygQxh4OIUgImcO87wT1v91wGnWYb/d9X0
 qDeWGJ62mNSfZ5hqGqujuqg5/t22Rwz/tL5vz/9UH3tqX/Uv6V1iB3f9e1zmYfH35T2r+mJ+0ba
 LrAA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PMU itself is compatible with the one found on M1. We still know
next to nothing about the counters so keep using CPU uarch specific
compatibles/PMU names.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 drivers/perf/apple_m1_cpu_pmu.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index 979a7c2b4f56..83b74c7fe63f 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -559,7 +559,21 @@ static int m1_pmu_fire_init(struct arm_pmu *cpu_pmu)
 	return m1_pmu_init(cpu_pmu);
 }
 
+static int m2_pmu_avalanche_init(struct arm_pmu *cpu_pmu)
+{
+	cpu_pmu->name = "apple_avalanche_pmu";
+	return m1_pmu_init(cpu_pmu);
+}
+
+static int m2_pmu_blizzard_init(struct arm_pmu *cpu_pmu)
+{
+	cpu_pmu->name = "apple_blizzard_pmu";
+	return m1_pmu_init(cpu_pmu);
+}
+
 static const struct of_device_id m1_pmu_of_device_ids[] = {
+	{ .compatible = "apple,avalanche-pmu",	.data = m2_pmu_avalanche_init, },
+	{ .compatible = "apple,blizzard-pmu",	.data = m2_pmu_blizzard_init, },
 	{ .compatible = "apple,icestorm-pmu",	.data = m1_pmu_ice_init, },
 	{ .compatible = "apple,firestorm-pmu",	.data = m1_pmu_fire_init, },
 	{ },

-- 
2.39.1

