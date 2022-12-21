Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA73C6533AF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 16:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbiLUPwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 10:52:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiLUPw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 10:52:26 -0500
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F210B1AF11;
        Wed, 21 Dec 2022 07:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1671637944; x=1703173944;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J37cAmUSy89NFuYuAIQwv935ukDljKuizMPHPLJPbKM=;
  b=nMl2HKAYop3b/z5l54nQ+AhmJQkqYOczWdr3s4fX9f+pRGMEGl6dUC8u
   sNd9weT/8qTJpfM56u6RHXCMwb+8BODhQw1PdnYG0IXvWkJzndDkskPcn
   v8mSGKWyUAYbulbspBJSSPVmBiFly2+5DVULNbBm/dyFjUhqvcoslvvMT
   4=;
X-IronPort-AV: E=Sophos;i="5.96,262,1665446400"; 
   d="scan'208";a="293101506"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-3554bfcf.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 15:52:16 +0000
Received: from EX13D32EUC001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1e-m6i4x-3554bfcf.us-east-1.amazon.com (Postfix) with ESMTPS id 7C927862F6;
        Wed, 21 Dec 2022 15:52:13 +0000 (UTC)
Received: from EX19D028EUC002.ant.amazon.com (10.252.61.186) by
 EX13D32EUC001.ant.amazon.com (10.43.164.159) with Microsoft SMTP Server (TLS)
 id 15.0.1497.42; Wed, 21 Dec 2022 15:52:12 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX19D028EUC002.ant.amazon.com (10.252.61.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.20; Wed, 21 Dec 2022 15:52:11 +0000
Received: from dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (10.15.11.255)
 by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP Server id
 15.0.1497.42 via Frontend Transport; Wed, 21 Dec 2022 15:52:10 +0000
Received: by dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (Postfix, from userid 23027615)
        id 412FB20D08; Wed, 21 Dec 2022 16:52:10 +0100 (CET)
From:   Pratyush Yadav <ptyadav@amazon.de>
To:     <linux-pm@vger.kernel.org>
CC:     Pratyush Yadav <ptyadav@amazon.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robert Moore <robert.moore@intel.com>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devel@acpica.org>
Subject: [PATCH 2/2] cpufreq: intel_pstate: use acpi perflib to update turbo frequency
Date:   Wed, 21 Dec 2022 16:52:03 +0100
Message-ID: <20221221155203.11347-3-ptyadav@amazon.de>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221221155203.11347-1-ptyadav@amazon.de>
References: <20221221155203.11347-1-ptyadav@amazon.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The _PSS table does not contain the whole turbo frequency range, but
only +1 MHz above the max non-turbo frequency. The pstate driver then
updates the ACPI perf data with the actual max frequency. But doing this
here directly would mean that frequency QoS constraints that acpi
perflib imposes do not get updated.

This is a problem when a CPU is brought offline and online again. When
the CPU first comes online, cpufreq is not initialized. So PPC
constraints are not applied (because ignore_ppc == -1). This leads to
the frequency QoS allowing all values from acpi perflib side.

Once everything is initialized and then userspace brings a CPU down and
up again, intel_pstate_init_acpi_perf_limits() calls
acpi_processor_register_performance(), which then eventually calls
acpi_processor_get_platform_limit(). There PPC is state 0, the turbo
state, but the frequency has not been updated yet. So when
acpi_processor_get_platform_limit() sets QoS constraints, it sets them
with the max_non_turbo + 1 value.

Now even though intel_pstate says it can support the full turbo speed,
cpufreq only asks for up to max_non_turbo + 1 MHz since that is what
satisfies all constraints.

Call into acpi perflib's function to update the frequency so it can also
update the QoS constraints with the new value.

Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
---
 drivers/cpufreq/intel_pstate.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index fd73d6d2b808..b312f87ff522 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -464,8 +464,9 @@ static void intel_pstate_init_acpi_perf_limits(struct cpufreq_policy *policy)
 	 * Also need to convert to MHz as _PSS freq is in MHz.
 	 */
 	if (!global.turbo_disabled)
-		cpu->acpi_perf_data.states[0].core_frequency =
-					policy->cpuinfo.max_freq / 1000;
+		acpi_processor_fixup_perf_state(policy->cpu, 0,
+						policy->cpuinfo.max_freq / 1000);
+
 	cpu->valid_pss_table = true;
 	pr_debug("_PPC limits will be enforced\n");
 
-- 
2.38.1

