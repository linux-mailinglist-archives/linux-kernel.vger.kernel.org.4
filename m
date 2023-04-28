Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468806F1244
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 09:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345487AbjD1HT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 03:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345485AbjD1HTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 03:19:22 -0400
X-Greylist: delayed 918 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 28 Apr 2023 00:19:08 PDT
Received: from m126.mail.126.com (m126.mail.126.com [220.181.12.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A2EAB4203;
        Fri, 28 Apr 2023 00:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=3n/5p
        i3UktdMdOC7PL3+qtIEfToIjoCQnLGC8cIVVEc=; b=MvcPxGPuqb1gxBynrMeoR
        cNvLwi6VPUcS3QQW0k1sadnaNmHESh2tfqqY04tAl/f9li6iKslx8YgkCflzwB7H
        IRkmgsHc6TaARjo//iNkZyeXKJjjWpZ2T2FMRXQDYxorQMYREWr6mkqxl5prrnLH
        q7tWnqD6XmVTHDqge/IMYg=
Received: from king.lan (unknown [103.163.180.43])
        by zwqz-smtp-mta-g3-1 (Coremail) with SMTP id _____wBn7_i0b0tkcltkAA--.5787S2;
        Fri, 28 Apr 2023 15:03:18 +0800 (CST)
From:   wangyouwan@126.com
To:     rafael@kernel.org, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        youwan Wang <wangyouwan@126.com>
Subject: [PATCH] cpufreq: create cooling device based on ACPI
Date:   Fri, 28 Apr 2023 15:03:14 +0800
Message-Id: <20230428070314.225560-1-wangyouwan@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBn7_i0b0tkcltkAA--.5787S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF1kWry8Zw1kWw13KF47XFb_yoWkZwb_Cr
        9Ygr9rXr45C3WIqF13Gr40vFn0vw47Wr1xXF10qa9xtFyUArZakr4kXr1UXrWrGw4rGF9r
        AryjyF4Skr1UGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRKZX3UUUUU==
X-Originating-IP: [103.163.180.43]
X-CM-SenderInfo: 5zdqw5prxzt0a6rslhhfrp/1tbi5RhfFVpD+ETrDwAAs2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: youwan Wang <wangyouwan@126.com>

When using the "scpi_cpufreq" driver, an error
occurs:cpufreq_cooling: OF node not available for cpu*.
The current computer motherboard is using ACPI firmware.
Go to see that the error is caused by calling the
"of_cpufreq_cooling_register" interface.
comment:create cpufreq cooling device based on DT.

Signed-off-by: youwan Wang <wangyouwan@126.com>
---
 drivers/cpufreq/cpufreq.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 6b52ebe5a890..3418c68959d5 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1528,8 +1528,13 @@ static int cpufreq_online(unsigned int cpu)
 	if (cpufreq_driver->ready)
 		cpufreq_driver->ready(policy);
 
-	if (cpufreq_thermal_control_enabled(cpufreq_driver))
+	if (cpufreq_thermal_control_enabled(cpufreq_driver)) {
+#ifdef CONFIG_ACPI
+		policy->cdev = cpufreq_cooling_register(policy);
+#else
 		policy->cdev = of_cpufreq_cooling_register(policy);
+#endif
+	}
 
 	pr_debug("initialization complete\n");
 
-- 
2.25.1

