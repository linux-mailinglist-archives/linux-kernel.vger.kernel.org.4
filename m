Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728695B8D15
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 18:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiINQbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 12:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiINQbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 12:31:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D07FB20BFE;
        Wed, 14 Sep 2022 09:29:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0921A1682;
        Wed, 14 Sep 2022 09:29:57 -0700 (PDT)
Received: from pierre123.arm.com (unknown [10.57.78.24])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 88E0A3F73D;
        Wed, 14 Sep 2022 09:29:48 -0700 (PDT)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pierre Gondois <pierre.gondois@arm.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] driver: soc: xilinx: Save cpuhp dynamic state
Date:   Wed, 14 Sep 2022 18:28:14 +0200
Message-Id: <20220914162815.1954866-2-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220914162815.1954866-1-pierre.gondois@arm.com>
References: <20220914162815.1954866-1-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Requesting a CPUHP_AP_ONLINE_DYN cpuhp state reserves a state
among the range [CPUHP_AP_ONLINE_DYN:CPUHP_AP_ONLINE_DYN_END].
The reserved state must be saved in order to remove it later.

Cf. __cpuhp_setup_state_cpuslocked() documentation:
Return:
  On success:
    Positive state number if @state is CPUHP_AP_ONLINE_DYN;
    0 for all other states

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/soc/xilinx/xlnx_event_manager.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/xilinx/xlnx_event_manager.c b/drivers/soc/xilinx/xlnx_event_manager.c
index 5dcb7665fe22..be67f74f3b5c 100644
--- a/drivers/soc/xilinx/xlnx_event_manager.c
+++ b/drivers/soc/xilinx/xlnx_event_manager.c
@@ -24,6 +24,8 @@ static DEFINE_PER_CPU_READ_MOSTLY(int, cpu_number1);
 static int virq_sgi;
 static int event_manager_availability = -EACCES;
 
+static int cpuhp_event_state;
+
 /* SGI number used for Event management driver */
 #define XLNX_EVENT_SGI_NUM	(15)
 
@@ -609,7 +611,10 @@ static void xlnx_event_cleanup_sgi(struct platform_device *pdev)
 
 	per_cpu(cpu_number1, cpu) = cpu;
 
-	cpuhp_remove_state(CPUHP_AP_ONLINE_DYN);
+	if (cpuhp_event_state > 0) {
+		cpuhp_remove_state(cpuhp_event_state);
+		cpuhp_event_state = 0;
+	}
 
 	on_each_cpu(xlnx_disable_percpu_irq, NULL, 1);
 
@@ -644,8 +649,11 @@ static int xlnx_event_manager_probe(struct platform_device *pdev)
 	}
 
 	/* Setup function for the CPU hot-plug cases */
-	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "soc/event:starting",
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "soc/event:starting",
 			  xlnx_event_cpuhp_start, xlnx_event_cpuhp_down);
+	if (ret > 0)
+		cpuhp_event_state = ret;
+
 
 	ret = zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_REGISTER_SGI, sgi_num,
 				  0, NULL);
-- 
2.25.1

