Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5565974B525
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 18:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbjGGQi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 12:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbjGGQiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 12:38:24 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 038B92117
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 09:38:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8BC51515;
        Fri,  7 Jul 2023 09:39:03 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B1BE73F740;
        Fri,  7 Jul 2023 09:38:20 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     will@kernel.org
Cc:     mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ilkka@os.amperecomputing.com,
        blakgeof@amazon.com
Subject: [PATCH 2/3] perf/arm-cmn: Refactor HN-F event selector macros
Date:   Fri,  7 Jul 2023 17:38:12 +0100
Message-Id: <0f05327941e06c665dbfd47e03fad29276b9e63c.1688746690.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1688746690.git.robin.murphy@arm.com>
References: <cover.1688746690.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor the macros for defining HN-F events with additional selectors,
so they can be shared with another upcoming similar-but-distinct HN
type. No functional change intended.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm-cmn.c | 49 +++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 20 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index a007648dbf1c..1efe9b72c0e6 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -742,8 +742,8 @@ static umode_t arm_cmn_event_attr_is_visible(struct kobject *kobj,
 	_CMN_EVENT_ATTR(_model, dn_##_name, CMN_TYPE_DVM, _event, _occup, _fsel)
 #define CMN_EVENT_DTC(_name)					\
 	CMN_EVENT_ATTR(CMN_ANY, dtc_##_name, CMN_TYPE_DTC, 0)
-#define _CMN_EVENT_HNF(_model, _name, _event, _occup, _fsel)		\
-	_CMN_EVENT_ATTR(_model, hnf_##_name, CMN_TYPE_HNF, _event, _occup, _fsel)
+#define CMN_EVENT_HNF(_model, _name, _event)			\
+	CMN_EVENT_ATTR(_model, hnf_##_name, CMN_TYPE_HNF, _event)
 #define CMN_EVENT_HNI(_name, _event)				\
 	CMN_EVENT_ATTR(CMN_ANY, hni_##_name, CMN_TYPE_HNI, _event)
 #define CMN_EVENT_HNP(_name, _event)				\
@@ -775,21 +775,34 @@ static umode_t arm_cmn_event_attr_is_visible(struct kobject *kobj,
 	_CMN_EVENT_DVM(_model, _name##_all, _event, 0, SEL_OCCUP1ID),	\
 	_CMN_EVENT_DVM(_model, _name##_dvmop, _event, 1, SEL_OCCUP1ID),	\
 	_CMN_EVENT_DVM(_model, _name##_dvmsync, _event, 2, SEL_OCCUP1ID)
-#define CMN_EVENT_HNF(_model, _name, _event)			\
-	_CMN_EVENT_HNF(_model, _name, _event, 0, SEL_NONE)
+
+#define CMN_EVENT_HN_OCC(_model, _name, _type, _event)		\
+	_CMN_EVENT_ATTR(_model, _name##_all, _type, _event, 0, SEL_OCCUP1ID), \
+	_CMN_EVENT_ATTR(_model, _name##_read, _type, _event, 1, SEL_OCCUP1ID), \
+	_CMN_EVENT_ATTR(_model, _name##_write, _type, _event, 2, SEL_OCCUP1ID), \
+	_CMN_EVENT_ATTR(_model, _name##_atomic, _type, _event, 3, SEL_OCCUP1ID), \
+	_CMN_EVENT_ATTR(_model, _name##_stash, _type, _event, 4, SEL_OCCUP1ID)
+#define CMN_EVENT_HN_CLS(_model, _name, _type, _event)			\
+	_CMN_EVENT_ATTR(_model, _name##_class0, _type, _event, 0, SEL_CLASS_OCCUP_ID), \
+	_CMN_EVENT_ATTR(_model, _name##_class1, _type, _event, 1, SEL_CLASS_OCCUP_ID), \
+	_CMN_EVENT_ATTR(_model, _name##_class2, _type, _event, 2, SEL_CLASS_OCCUP_ID), \
+	_CMN_EVENT_ATTR(_model, _name##_class3, _type, _event, 3, SEL_CLASS_OCCUP_ID)
+#define CMN_EVENT_HN_SNT(_model, _name, _type, _event)			\
+	_CMN_EVENT_ATTR(_model, _name##_all, _type, _event, 0, SEL_CBUSY_SNTHROTTLE_SEL), \
+	_CMN_EVENT_ATTR(_model, _name##_group0_read, _type, _event, 1, SEL_CBUSY_SNTHROTTLE_SEL), \
+	_CMN_EVENT_ATTR(_model, _name##_group0_write, _type, _event, 2, SEL_CBUSY_SNTHROTTLE_SEL), \
+	_CMN_EVENT_ATTR(_model, _name##_group1_read, _type, _event, 3, SEL_CBUSY_SNTHROTTLE_SEL), \
+	_CMN_EVENT_ATTR(_model, _name##_group1_write, _type, _event, 4, SEL_CBUSY_SNTHROTTLE_SEL), \
+	_CMN_EVENT_ATTR(_model, _name##_read, _type, _event, 5, SEL_CBUSY_SNTHROTTLE_SEL), \
+	_CMN_EVENT_ATTR(_model, _name##_write, _type, _event, 6, SEL_CBUSY_SNTHROTTLE_SEL)
+
+#define CMN_EVENT_HNF_OCC(_model, _name, _event)			\
+	CMN_EVENT_HN_OCC(_model, hnf_##_name, CMN_TYPE_HNF, _event)
 #define CMN_EVENT_HNF_CLS(_model, _name, _event)			\
-	_CMN_EVENT_HNF(_model, _name##_class0, _event, 0, SEL_CLASS_OCCUP_ID), \
-	_CMN_EVENT_HNF(_model, _name##_class1, _event, 1, SEL_CLASS_OCCUP_ID), \
-	_CMN_EVENT_HNF(_model, _name##_class2, _event, 2, SEL_CLASS_OCCUP_ID), \
-	_CMN_EVENT_HNF(_model, _name##_class3, _event, 3, SEL_CLASS_OCCUP_ID)
+	CMN_EVENT_HN_CLS(_model, hnf_##_name, CMN_TYPE_HNS, _event)
 #define CMN_EVENT_HNF_SNT(_model, _name, _event)			\
-	_CMN_EVENT_HNF(_model, _name##_all, _event, 0, SEL_CBUSY_SNTHROTTLE_SEL), \
-	_CMN_EVENT_HNF(_model, _name##_group0_read, _event, 1, SEL_CBUSY_SNTHROTTLE_SEL), \
-	_CMN_EVENT_HNF(_model, _name##_group0_write, _event, 2, SEL_CBUSY_SNTHROTTLE_SEL), \
-	_CMN_EVENT_HNF(_model, _name##_group1_read, _event, 3, SEL_CBUSY_SNTHROTTLE_SEL), \
-	_CMN_EVENT_HNF(_model, _name##_group1_write, _event, 4, SEL_CBUSY_SNTHROTTLE_SEL), \
-	_CMN_EVENT_HNF(_model, _name##_read, _event, 5, SEL_CBUSY_SNTHROTTLE_SEL), \
-	_CMN_EVENT_HNF(_model, _name##_write, _event, 6, SEL_CBUSY_SNTHROTTLE_SEL)
+	CMN_EVENT_HN_SNT(_model, hnf_##_name, CMN_TYPE_HNF, _event)
+
 
 #define _CMN_EVENT_XP_MESH(_name, _event)			\
 	__CMN_EVENT_XP(e_##_name, (_event) | (0 << 2)),		\
@@ -872,11 +885,7 @@ static struct attribute *arm_cmn_event_attrs[] = {
 	CMN_EVENT_HNF(CMN_ANY, mc_retries,		0x0c),
 	CMN_EVENT_HNF(CMN_ANY, mc_reqs,			0x0d),
 	CMN_EVENT_HNF(CMN_ANY, qos_hh_retry,		0x0e),
-	_CMN_EVENT_HNF(CMN_ANY, qos_pocq_occupancy_all,	0x0f, 0, SEL_OCCUP1ID),
-	_CMN_EVENT_HNF(CMN_ANY, qos_pocq_occupancy_read, 0x0f, 1, SEL_OCCUP1ID),
-	_CMN_EVENT_HNF(CMN_ANY, qos_pocq_occupancy_write, 0x0f, 2, SEL_OCCUP1ID),
-	_CMN_EVENT_HNF(CMN_ANY, qos_pocq_occupancy_atomic, 0x0f, 3, SEL_OCCUP1ID),
-	_CMN_EVENT_HNF(CMN_ANY, qos_pocq_occupancy_stash, 0x0f, 4, SEL_OCCUP1ID),
+	CMN_EVENT_HNF_OCC(CMN_ANY, qos_pocq_occupancy,	0x0f),
 	CMN_EVENT_HNF(CMN_ANY, pocq_addrhaz,		0x10),
 	CMN_EVENT_HNF(CMN_ANY, pocq_atomic_addrhaz,	0x11),
 	CMN_EVENT_HNF(CMN_ANY, ld_st_swp_adq_full,	0x12),
-- 
2.39.2.101.g768bb238c484.dirty

