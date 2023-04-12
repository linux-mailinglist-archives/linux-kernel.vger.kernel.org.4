Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179B56DF1EE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 12:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjDLK3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 06:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjDLK3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 06:29:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 63DC41726
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 03:29:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D143D75;
        Wed, 12 Apr 2023 03:30:31 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3FC383F587;
        Wed, 12 Apr 2023 03:29:46 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     will@kernel.org
Cc:     mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ilkka@os.amperecomputing.com,
        Jing Zhang <renyu.zj@linux.alibaba.com>
Subject: [PATCH v2] perf/arm-cmn: Fix port detection for CMN-700
Date:   Wed, 12 Apr 2023 11:29:40 +0100
Message-Id: <71d129241d4d7923cde72a0e5b4c8d2f6084525f.1681295193.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the "extra device ports" configuration was first added, the
additional mxp_device_port_connect_info registers were added around the
existing mxp_mesh_port_connect_info registers. What I missed about
CMN-700 is that it shuffled them around to remove this discontinuity.
As such, tweak the definitions and factor out a helper for reading these
registers so we can deal with this discrepancy easily, which does at
least allow nicely tidying up the callsites. With this we can then also
do the nice thing and skip accesses completely rather than relying on
RES0 behaviour where we know the extra registers aren't defined.

Fixes: 23760a014417 ("perf/arm-cmn: Add CMN-700 support")
Reported-by: Jing Zhang <renyu.zj@linux.alibaba.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: Get the CI-700 offset value right

 drivers/perf/arm-cmn.c | 55 ++++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 26 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index c9689861be3f..28cf5cabbb86 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -57,14 +57,12 @@
 #define CMN_INFO_REQ_VC_NUM		GENMASK_ULL(1, 0)
 
 /* XPs also have some local topology info which has uses too */
-#define CMN_MXP__CONNECT_INFO_P0	0x0008
-#define CMN_MXP__CONNECT_INFO_P1	0x0010
-#define CMN_MXP__CONNECT_INFO_P2	0x0028
-#define CMN_MXP__CONNECT_INFO_P3	0x0030
-#define CMN_MXP__CONNECT_INFO_P4	0x0038
-#define CMN_MXP__CONNECT_INFO_P5	0x0040
+#define CMN_MXP__CONNECT_INFO(p)	(0x0008 + 8 * (p))
 #define CMN__CONNECT_INFO_DEVICE_TYPE	GENMASK_ULL(4, 0)
 
+#define CMN_MAX_PORTS			6
+#define CI700_CONNECT_INFO_P2_5_OFFSET	0x10
+
 /* PMU registers occupy the 3rd 4KB page of each node's region */
 #define CMN_PMU_OFFSET			0x2000
 
@@ -396,6 +394,25 @@ static struct arm_cmn_node *arm_cmn_node(const struct arm_cmn *cmn,
 	return NULL;
 }
 
+static u32 arm_cmn_device_connect_info(const struct arm_cmn *cmn,
+				       const struct arm_cmn_node *xp, int port)
+{
+	int offset = CMN_MXP__CONNECT_INFO(port);
+
+	if (port >= 2) {
+		if (cmn->model & (CMN600 | CMN650))
+			return 0;
+		/*
+		 * CI-700 may have extra ports, but still has the
+		 * mesh_port_connect_info registers in the way.
+		 */
+		if (cmn->model == CI700)
+			offset += CI700_CONNECT_INFO_P2_5_OFFSET;
+	}
+
+	return readl_relaxed(xp->pmu_base - CMN_PMU_OFFSET + offset);
+}
+
 static struct dentry *arm_cmn_debugfs;
 
 #ifdef CONFIG_DEBUG_FS
@@ -469,7 +486,7 @@ static int arm_cmn_map_show(struct seq_file *s, void *data)
 	y = cmn->mesh_y;
 	while (y--) {
 		int xp_base = cmn->mesh_x * y;
-		u8 port[6][CMN_MAX_DIMENSION];
+		u8 port[CMN_MAX_PORTS][CMN_MAX_DIMENSION];
 
 		for (x = 0; x < cmn->mesh_x; x++)
 			seq_puts(s, "--------+");
@@ -477,14 +494,9 @@ static int arm_cmn_map_show(struct seq_file *s, void *data)
 		seq_printf(s, "\n%d    |", y);
 		for (x = 0; x < cmn->mesh_x; x++) {
 			struct arm_cmn_node *xp = cmn->xps + xp_base + x;
-			void __iomem *base = xp->pmu_base - CMN_PMU_OFFSET;
 
-			port[0][x] = readl_relaxed(base + CMN_MXP__CONNECT_INFO_P0);
-			port[1][x] = readl_relaxed(base + CMN_MXP__CONNECT_INFO_P1);
-			port[2][x] = readl_relaxed(base + CMN_MXP__CONNECT_INFO_P2);
-			port[3][x] = readl_relaxed(base + CMN_MXP__CONNECT_INFO_P3);
-			port[4][x] = readl_relaxed(base + CMN_MXP__CONNECT_INFO_P4);
-			port[5][x] = readl_relaxed(base + CMN_MXP__CONNECT_INFO_P5);
+			for (p = 0; p < CMN_MAX_PORTS; p++)
+				port[p][x] = arm_cmn_device_connect_info(cmn, xp, p);
 			seq_printf(s, " XP #%-2d |", xp_base + x);
 		}
 
@@ -2083,18 +2095,9 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
 		 * from this, since in that case we will see at least one XP
 		 * with port 2 connected, for the HN-D.
 		 */
-		if (readq_relaxed(xp_region + CMN_MXP__CONNECT_INFO_P0))
-			xp_ports |= BIT(0);
-		if (readq_relaxed(xp_region + CMN_MXP__CONNECT_INFO_P1))
-			xp_ports |= BIT(1);
-		if (readq_relaxed(xp_region + CMN_MXP__CONNECT_INFO_P2))
-			xp_ports |= BIT(2);
-		if (readq_relaxed(xp_region + CMN_MXP__CONNECT_INFO_P3))
-			xp_ports |= BIT(3);
-		if (readq_relaxed(xp_region + CMN_MXP__CONNECT_INFO_P4))
-			xp_ports |= BIT(4);
-		if (readq_relaxed(xp_region + CMN_MXP__CONNECT_INFO_P5))
-			xp_ports |= BIT(5);
+		for (int p = 0; p < CMN_MAX_PORTS; p++)
+			if (arm_cmn_device_connect_info(cmn, xp, p))
+				xp_ports |= BIT(p);
 
 		if (cmn->multi_dtm && (xp_ports & 0xc))
 			arm_cmn_init_dtm(dtm++, xp, 1);
-- 
2.39.2.101.g768bb238c484.dirty

