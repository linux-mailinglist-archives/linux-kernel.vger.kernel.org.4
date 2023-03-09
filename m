Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373EE6B2655
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 15:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjCIOJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 09:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbjCIOJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:09:07 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61168570B0;
        Thu,  9 Mar 2023 06:07:51 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68D3AFEC;
        Thu,  9 Mar 2023 06:08:34 -0800 (PST)
Received: from e120937-lin.. (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E84BF3F5A1;
        Thu,  9 Mar 2023 06:07:48 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        vincent.guittot@linaro.org, tarek.el-sherbiny@arm.com,
        nicola.mazzucato@arm.com, souvik.chakravarty@arm.com,
        wleavitt@marvell.com, wbartczak@marvell.com,
        Cristian Marussi <cristian.marussi@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v2 3/3] powercap: arm_scmi: Add support for disabling powercaps on a zone
Date:   Thu,  9 Mar 2023 14:07:24 +0000
Message-Id: <20230309140724.2152712-4-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230309140724.2152712-1-cristian.marussi@arm.com>
References: <20230309140724.2152712-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to disable/enable powercapping on a zone.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/powercap/arm_scmi_powercap.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/powercap/arm_scmi_powercap.c b/drivers/powercap/arm_scmi_powercap.c
index 05d0e516176a..5231f6d52ae3 100644
--- a/drivers/powercap/arm_scmi_powercap.c
+++ b/drivers/powercap/arm_scmi_powercap.c
@@ -70,10 +70,26 @@ static int scmi_powercap_get_power_uw(struct powercap_zone *pz,
 	return 0;
 }
 
+static int scmi_powercap_zone_enable_set(struct powercap_zone *pz, bool mode)
+{
+	struct scmi_powercap_zone *spz = to_scmi_powercap_zone(pz);
+
+	return powercap_ops->cap_enable_set(spz->ph, spz->info->id, mode);
+}
+
+static int scmi_powercap_zone_enable_get(struct powercap_zone *pz, bool *mode)
+{
+	struct scmi_powercap_zone *spz = to_scmi_powercap_zone(pz);
+
+	return powercap_ops->cap_enable_get(spz->ph, spz->info->id, mode);
+}
+
 static const struct powercap_zone_ops zone_ops = {
 	.get_max_power_range_uw = scmi_powercap_get_max_power_range_uw,
 	.get_power_uw = scmi_powercap_get_power_uw,
 	.release = scmi_powercap_zone_release,
+	.set_enable = scmi_powercap_zone_enable_set,
+	.get_enable = scmi_powercap_zone_enable_get,
 };
 
 static void scmi_powercap_normalize_cap(const struct scmi_powercap_zone *spz,
-- 
2.34.1

