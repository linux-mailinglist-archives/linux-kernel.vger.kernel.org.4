Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7C770047D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 11:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240687AbjELJ7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 05:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240658AbjELJ6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 05:58:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A1411249D;
        Fri, 12 May 2023 02:58:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C9D1168F;
        Fri, 12 May 2023 02:59:00 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.22.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E05573F5A1;
        Fri, 12 May 2023 02:58:12 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, Pierre.Gondois@arm.com,
        ionela.voinescu@arm.com, rostedt@goodmis.org, mhiramat@kernel.org
Subject: [PATCH v2 06/17] PM: EM: Add update_power() callback for runtime modifications
Date:   Fri, 12 May 2023 10:57:32 +0100
Message-Id: <20230512095743.3393563-7-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230512095743.3393563-1-lukasz.luba@arm.com>
References: <20230512095743.3393563-1-lukasz.luba@arm.com>
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

The Energy Model (EM) is going to support runtime modifications. This
new callback would be used in the upcoming EM changes. The drivers
or frameworks which want to modify the EM have to implement the
update_power() callback and provide it via EM API
em_dev_update_perf_domain(). The callback is then used by the EM
framework to get new power values for each frequency in existing EM.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 include/linux/energy_model.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 8069f526c9d8..cc2bf607191e 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -158,6 +158,26 @@ struct em_data_callback {
 	 */
 	int (*get_cost)(struct device *dev, unsigned long freq,
 			unsigned long *cost);
+
+	/**
+	 * update_power() - Provide new power at the given performance state of
+	 *		a device
+	 * @dev		: Device for which we do this operation (can be a CPU)
+	 * @freq	: Frequency at the performance state in kHz
+	 * @power	: New power value at the performance state
+	 *		(modified)
+	 * @priv	: Pointer to private data useful for tracking context
+	 *		during run-time modifications of EM.
+	 *
+	 * The update_power() is used by run-time modifiable EM. It aims to
+	 * provide updated power value for a given frequency, which is stored
+	 * in the performance state. The power value provided by this callback
+	 * should fit in the [0, EM_MAX_POWER] range.
+	 *
+	 * Return 0 on success, or appropriate error value in case of failure.
+	 */
+	int (*update_power)(struct device *dev, unsigned long freq,
+			    unsigned long *power, void *priv);
 };
 #define EM_SET_ACTIVE_POWER_CB(em_cb, cb) ((em_cb).active_power = cb)
 #define EM_ADV_DATA_CB(_active_power_cb, _cost_cb)	\
@@ -165,6 +185,7 @@ struct em_data_callback {
 	  .get_cost = _cost_cb }
 #define EM_DATA_CB(_active_power_cb)			\
 		EM_ADV_DATA_CB(_active_power_cb, NULL)
+#define EM_UPDATE_CB(_update_power_cb) { .update_power = &_update_power_cb }
 
 struct em_perf_domain *em_cpu_get(int cpu);
 struct em_perf_domain *em_pd_get(struct device *dev);
-- 
2.25.1

