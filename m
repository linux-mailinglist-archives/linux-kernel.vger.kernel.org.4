Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD1C5B8D18
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 18:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiINQbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 12:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiINQbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 12:31:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D32525C50;
        Wed, 14 Sep 2022 09:29:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A96211BF3;
        Wed, 14 Sep 2022 09:29:59 -0700 (PDT)
Received: from pierre123.arm.com (unknown [10.57.78.24])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4F8403F73D;
        Wed, 14 Sep 2022 09:29:51 -0700 (PDT)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pierre Gondois <pierre.gondois@arm.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] powercap/drivers/dtpm: Save cpuhp dynamic state
Date:   Wed, 14 Sep 2022 18:28:15 +0200
Message-Id: <20220914162815.1954866-3-pierre.gondois@arm.com>
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
 drivers/powercap/dtpm_cpu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index f5eced0842b3..1dfbfe54d3bf 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -33,6 +33,7 @@ struct dtpm_cpu {
 };
 
 static DEFINE_PER_CPU(struct dtpm_cpu *, dtpm_per_cpu);
+static int cpuhp_dtpm_cpu_online_state;
 
 static struct dtpm_cpu *to_dtpm_cpu(struct dtpm *dtpm)
 {
@@ -296,12 +297,16 @@ static int dtpm_cpu_init(void)
 	if (ret < 0)
 		return ret;
 
+	cpuhp_dtpm_cpu_online_state = ret;
 	return 0;
 }
 
 static void dtpm_cpu_exit(void)
 {
-	cpuhp_remove_state_nocalls(CPUHP_AP_ONLINE_DYN);
+	if (cpuhp_dtpm_cpu_online_state > 0) {
+		cpuhp_remove_state_nocalls(cpuhp_dtpm_cpu_online_state);
+		cpuhp_dtpm_cpu_online_state = 0;
+	}
 	cpuhp_remove_state_nocalls(CPUHP_AP_DTPM_CPU_DEAD);
 }
 
-- 
2.25.1

