Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9B96402FC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 10:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbiLBJMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 04:12:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbiLBJMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 04:12:39 -0500
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04CEC1F;
        Fri,  2 Dec 2022 01:12:36 -0800 (PST)
Received: from SHSend.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id 2B29BagW034842
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO);
        Fri, 2 Dec 2022 17:11:36 +0800 (CST)
        (envelope-from Di.Shen@unisoc.com)
Received: from bj10906pcu1.spreadtrum.com (10.0.74.51) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 2 Dec 2022 17:11:33 +0800
From:   Di Shen <di.shen@unisoc.com>
To:     <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <amitk@kernel.org>, <rui.zhang@intel.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <xuewen.yan@unisoc.com>, <di.shen@unisoc.com>
Subject: [PATCH V2] thermal/of: Allow users to set governor for a thermal zone in DT
Date:   Fri, 2 Dec 2022 17:11:11 +0800
Message-ID: <20221202091111.1682-1-di.shen@unisoc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <202212020239.CufwkKiR-lkp@intel.com>
References: <202212020239.CufwkKiR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.74.51]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 2B29BagW034842
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The governor of all thermal zones can be initialized in
thermal_zone_device_register_with_trips(), but it is always the
def_governor, this means the governor of all thermal zones are
the same.

Allow users to set governor for a specific thermal zone in DT, in
this way, users can use different policies for thermal management.

Signed-off-by: Di Shen <di.shen@unisoc.com>
---
 drivers/thermal/thermal_of.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index d4b6335ace15..4a29ac3be2ac 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -355,6 +355,7 @@ static struct thermal_zone_params *thermal_of_parameters_init(struct device_node
 	int coef[2];
 	int ncoef = ARRAY_SIZE(coef);
 	int prop, ret;
+	const char *governor_name;
 
 	tzp = kzalloc(sizeof(*tzp), GFP_KERNEL);
 	if (!tzp)
@@ -365,6 +366,11 @@ static struct thermal_zone_params *thermal_of_parameters_init(struct device_node
 	if (!of_property_read_u32(np, "sustainable-power", &prop))
 		tzp->sustainable_power = prop;
 
+	if (!of_property_read_string(np, "policy", &governor_name)) {
+		strncpy(tzp->governor_name, governor_name, THERMAL_NAME_LENGTH - 1);
+		tzp->governor_name[THERMAL_NAME_LENGTH - 1] = '\0';
+	}
+
 	/*
 	 * For now, the thermal framework supports only one sensor per
 	 * thermal zone. Thus, we are considering only the first two
-- 
2.17.1

