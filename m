Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B736774B524
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 18:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbjGGQiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 12:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbjGGQiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 12:38:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B956A210C
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 09:38:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 927EA1063;
        Fri,  7 Jul 2023 09:39:02 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9B1043F740;
        Fri,  7 Jul 2023 09:38:19 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     will@kernel.org
Cc:     mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ilkka@os.amperecomputing.com,
        blakgeof@amazon.com
Subject: [PATCH 1/3] perf/arm-cmn: Remove spurious event aliases
Date:   Fri,  7 Jul 2023 17:38:11 +0100
Message-Id: <b01a58e3ff05c322547fbfd015f6dbfedf555ed3.1688746690.git.robin.murphy@arm.com>
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

As the name suggests, the "partial DAT flit" event is only counted for
the DAT channel, and furthermore is only applicable to device ports, not
mesh links (strictly it's only device ports with CHI-A requesters
connected, but detecting that degree of detail is more bother than it's
worth). Stop generating spurious event aliases for other combinations
which aren't meaningful.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm-cmn.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index b8c15878bc86..a007648dbf1c 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -791,16 +791,22 @@ static umode_t arm_cmn_event_attr_is_visible(struct kobject *kobj,
 	_CMN_EVENT_HNF(_model, _name##_read, _event, 5, SEL_CBUSY_SNTHROTTLE_SEL), \
 	_CMN_EVENT_HNF(_model, _name##_write, _event, 6, SEL_CBUSY_SNTHROTTLE_SEL)
 
-#define _CMN_EVENT_XP(_name, _event)				\
+#define _CMN_EVENT_XP_MESH(_name, _event)			\
 	__CMN_EVENT_XP(e_##_name, (_event) | (0 << 2)),		\
 	__CMN_EVENT_XP(w_##_name, (_event) | (1 << 2)),		\
 	__CMN_EVENT_XP(n_##_name, (_event) | (2 << 2)),		\
-	__CMN_EVENT_XP(s_##_name, (_event) | (3 << 2)),		\
+	__CMN_EVENT_XP(s_##_name, (_event) | (3 << 2))
+
+#define _CMN_EVENT_XP_PORT(_name, _event)			\
 	__CMN_EVENT_XP(p0_##_name, (_event) | (4 << 2)),	\
 	__CMN_EVENT_XP(p1_##_name, (_event) | (5 << 2)),	\
 	__CMN_EVENT_XP(p2_##_name, (_event) | (6 << 2)),	\
 	__CMN_EVENT_XP(p3_##_name, (_event) | (7 << 2))
 
+#define _CMN_EVENT_XP(_name, _event)				\
+	_CMN_EVENT_XP_MESH(_name, _event),			\
+	_CMN_EVENT_XP_PORT(_name, _event)
+
 /* Good thing there are only 3 fundamental XP events... */
 #define CMN_EVENT_XP(_name, _event)				\
 	_CMN_EVENT_XP(req_##_name, (_event) | (0 << 5)),	\
@@ -813,6 +819,10 @@ static umode_t arm_cmn_event_attr_is_visible(struct kobject *kobj,
 	_CMN_EVENT_XP(snp2_##_name, (_event) | (7 << 5)),	\
 	_CMN_EVENT_XP(req2_##_name, (_event) | (8 << 5))
 
+#define CMN_EVENT_XP_DAT(_name, _event)				\
+	_CMN_EVENT_XP_PORT(dat_##_name, (_event) | (3 << 5)),	\
+	_CMN_EVENT_XP_PORT(dat2_##_name, (_event) | (6 << 5))
+
 
 static struct attribute *arm_cmn_event_attrs[] = {
 	CMN_EVENT_DTC(cycles),
@@ -943,7 +953,7 @@ static struct attribute *arm_cmn_event_attrs[] = {
 
 	CMN_EVENT_XP(txflit_valid,			0x01),
 	CMN_EVENT_XP(txflit_stall,			0x02),
-	CMN_EVENT_XP(partial_dat_flit,			0x03),
+	CMN_EVENT_XP_DAT(partial_dat_flit,		0x03),
 	/* We treat watchpoints as a special made-up class of XP events */
 	CMN_EVENT_ATTR(CMN_ANY, watchpoint_up, CMN_TYPE_WP, CMN_WP_UP),
 	CMN_EVENT_ATTR(CMN_ANY, watchpoint_down, CMN_TYPE_WP, CMN_WP_DOWN),
-- 
2.39.2.101.g768bb238c484.dirty

