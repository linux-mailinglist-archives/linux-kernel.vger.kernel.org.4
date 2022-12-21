Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E276533AB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 16:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbiLUPwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 10:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbiLUPwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 10:52:18 -0500
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8601A393;
        Wed, 21 Dec 2022 07:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1671637937; x=1703173937;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fPHbtq9qCbxUujjnY3/7YX+cvjvbTVPwrWqhH/h+PEk=;
  b=JJ1Fsp534wZA9AD1yviaKPtplc1g6I0dGyLxS10aSnMnPQZcuoFlA9H0
   MJjOlk4CoauWjggrH5KI4gsZG3f9sQ2eAKTWp9CFi0dJkwpP3gxVINcuJ
   c1XzecTP9Ne0c9IR2fKLxMmAPNhuuEE8vE2yWy4wcWzshoQfFsjHY2VMN
   Y=;
X-IronPort-AV: E=Sophos;i="5.96,262,1665446400"; 
   d="scan'208";a="279685468"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-25ac6bd5.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 15:52:14 +0000
Received: from EX13D46EUB002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1d-m6i4x-25ac6bd5.us-east-1.amazon.com (Postfix) with ESMTPS id B0BFB428FE;
        Wed, 21 Dec 2022 15:52:11 +0000 (UTC)
Received: from EX19D028EUB002.ant.amazon.com (10.252.61.43) by
 EX13D46EUB002.ant.amazon.com (10.43.166.241) with Microsoft SMTP Server (TLS)
 id 15.0.1497.42; Wed, 21 Dec 2022 15:52:10 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX19D028EUB002.ant.amazon.com (10.252.61.43) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.20; Wed, 21 Dec 2022 15:52:10 +0000
Received: from dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (10.15.11.255)
 by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1497.42 via Frontend Transport; Wed, 21 Dec 2022 15:52:08 +0000
Received: by dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (Postfix, from userid 23027615)
        id 4B3C120D20; Wed, 21 Dec 2022 16:52:08 +0100 (CET)
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
Subject: [PATCH 1/2] acpi: processor: allow fixing up the frequency for a performance state
Date:   Wed, 21 Dec 2022 16:52:02 +0100
Message-ID: <20221221155203.11347-2-ptyadav@amazon.de>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221221155203.11347-1-ptyadav@amazon.de>
References: <20221221155203.11347-1-ptyadav@amazon.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases the ACPI table can have an incorrect frequency populated
for a performance state. For example, in Intel platforms, the Turbo
frequency is just listed as +1 MHz above the max non-turbo frequency.
The frequency can actually go much higher based on various factors like
temperature, voltage, etc.

Allow drivers like intel_pstate to fix up performance state frequencies
with the actual maximum value. While at it, also update the QoS
constraints if needed to match the new frequency values.

Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
---
 drivers/acpi/processor_perflib.c | 40 ++++++++++++++++++++++++++++++++
 include/acpi/processor.h         |  2 ++
 2 files changed, 42 insertions(+)

diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index 970f04a958cd..4958aee4c024 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -766,3 +766,43 @@ void acpi_processor_unregister_performance(unsigned int cpu)
 	mutex_unlock(&performance_mutex);
 }
 EXPORT_SYMBOL(acpi_processor_unregister_performance);
+
+int acpi_processor_fixup_perf_state(unsigned int cpu, unsigned int state,
+				    unsigned int frequency)
+{
+	struct acpi_processor *pr;
+	int ret;
+
+	mutex_lock(&performance_mutex);
+
+	pr = per_cpu(processors, cpu);
+	if (!pr) {
+		mutex_unlock(&performance_mutex);
+		return -ENODEV;
+	}
+
+	if (!pr->performance) {
+		mutex_unlock(&performance_mutex);
+		return -EINVAL;
+	}
+
+	if (state >= pr->performance->state_count) {
+		mutex_unlock(&performance_mutex);
+		return -EINVAL;
+	}
+
+	pr->performance->states[state].core_frequency = frequency;
+
+	if (ignore_ppc != 1 && state == pr->performance_platform_limit &&
+	    freq_qos_request_active(&pr->perflib_req)) {
+		ret = freq_qos_update_request(&pr->perflib_req,
+					      frequency * 1000);
+		if (ret < 0)
+			pr_warn("Failed to update perflib freq constraint: CPU%d (%d)\n",
+				pr->id, ret);
+	}
+
+	mutex_unlock(&performance_mutex);
+	return 0;
+}
+EXPORT_SYMBOL(acpi_processor_fixup_perf_state);
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 94181fe9780a..daff978cfa7d 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -258,6 +258,8 @@ extern int acpi_processor_preregister_performance(struct
 extern int acpi_processor_register_performance(struct acpi_processor_performance
 					       *performance, unsigned int cpu);
 extern void acpi_processor_unregister_performance(unsigned int cpu);
+extern int acpi_processor_fixup_perf_state(unsigned int cpu, unsigned int state,
+					   unsigned int frequency);
 
 int acpi_processor_pstate_control(void);
 /* note: this locks both the calling module and the processor module
-- 
2.38.1

