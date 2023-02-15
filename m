Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEF2697AAC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 12:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbjBOL1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 06:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbjBOL1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 06:27:18 -0500
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2B328D05
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 03:27:16 -0800 (PST)
Received: from robin.home.jannau.net (p579ad32f.dip0.t-ipconnect.de [87.154.211.47])
        by soltyk.jannau.net (Postfix) with ESMTPSA id 4C26F26F796;
        Wed, 15 Feb 2023 12:27:15 +0100 (CET)
From:   Janne Grunau <j@jannau.net>
Date:   Wed, 15 Feb 2023 12:27:13 +0100
Subject: [PATCH] arm_pmu: Invert fallback armpmu_filter() return value
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230215-arm_pmu_m1_regression-v1-1-f5a266577c8d@jannau.net>
X-B4-Tracking: v=1; b=H4sIAJDB7GMC/x3NywqDMBCF4VeRWTeQpNrbq0gJuUx1Fkllpi0F8
 d1NXP4cPs4Kgkwo8OhWYPyR0LvUMKcO4uzLhIpSbbDanrU1g/Kc3ZK/LhvHODFKEypcUupvScf
 r3UK1wQuqwL7EuekGAgnGTxsXxhf9j9PxuW07HJ1SuYQAAAA=
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1082; i=j@jannau.net;
 h=from:subject:message-id; bh=JAaqPNVj1rOTX2sPjdkjx+amiK3yR1ZY8NpvvuGXXbk=;
 b=owGbwMvMwCG2UNrmdq9+ahrjabUkhuQ3Byf94zM79M53DWufsvFqrxO+Bxof1e/bKsfPvvWKc
 eOOvyGtHaUsDGIcDLJiiixJ2i87GFbXKMbUPgiDmcPKBDKEgYtTACbyNp6R4YN/Q+t+gde79vt/
 NWlxqN1m7mmempir/eXgnHVJ4iLmYowMSxe5M6Te0dt7ouju+e0nIjLPXGxYZ3pbNvZvyYXHuju
 LOQA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes a regression in "perf: Rewrite core context handling" for arm_pmu
based drivers without a filter function pointer as the Apple M1 PMU.
The event is ignored if filter() returns 'true' opposite to
filter_match(). The refactoring failed to invert the return value if
arm_pmu has no filter() function pointer of its own.

Fixes: bd2756811766 ("perf: Rewrite core context handling")
Signed-off-by: Janne Grunau <j@jannau.net>
---
 drivers/perf/arm_pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 9b593f985805..9cb22f36cf66 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -556,7 +556,7 @@ static bool armpmu_filter(struct pmu *pmu, int cpu)
 	if (ret && armpmu->filter)
 		return armpmu->filter(pmu, cpu);
 
-	return ret;
+	return !ret;
 }
 
 static ssize_t cpus_show(struct device *dev,

---
base-commit: ceaa837f96adb69c0df0397937cd74991d5d821a
change-id: 20230215-arm_pmu_m1_regression-b6dd48d0c792

Best regards,
-- 
Janne Grunau <j@jannau.net>

