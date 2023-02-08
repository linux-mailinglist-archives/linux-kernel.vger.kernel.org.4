Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB4868E9DC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 09:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjBHI1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 03:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjBHI1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 03:27:31 -0500
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A327442D6
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 00:27:28 -0800 (PST)
X-ASG-Debug-ID: 1675844843-086e23137e022e0001-xx1T2L
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx1.zhaoxin.com with ESMTP id 3J9LMXbM7YTxfFn4 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Wed, 08 Feb 2023 16:27:23 +0800 (CST)
X-Barracuda-Envelope-From: SilviaZhao-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXBJMBX02.zhaoxin.com (10.29.252.6) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Wed, 8 Feb
 2023 16:27:22 +0800
Received: from silvia-OptiPlex-3010.zhaoxin.com (10.29.8.47) by
 ZXBJMBX02.zhaoxin.com (10.29.252.6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 16:27:22 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
From:   silviazhao <silviazhao-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.6
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <tglx@linutronix.de>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <hpa@zytor.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <cobechen@zhaoxin.com>, <louisqi@zhaoxin.com>,
        <silviazhao@zhaoxin.com>, <tonywwang@zhaoxin.com>,
        <kevinbrace@gmx.com>, <7vvbbqzo567a@nospam.xutrox.com>
Subject: [PATCH V2] x86/perf/zhaoxin: Add stepping check for ZXC
Date:   Wed, 8 Feb 2023 16:27:22 +0800
X-ASG-Orig-Subj: [PATCH V2] x86/perf/zhaoxin: Add stepping check for ZXC
Message-ID: <20230208082722.14219-1-silviazhao-oc@zhaoxin.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.8.47]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX02.zhaoxin.com (10.29.252.6)
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1675844843
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1768
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.104486
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of Nano series processors will lead GP when accessing
PMC fixed counter. Meanwhile, their hardware support for PMC
has not announced externally. So exclude Nano CPUs from ZXC
by checking stepping information. This is an unambiguous way
to differentiate between ZXC and Nano CPUs.

Following are Nano and ZXC FMS information:
Nano FMS: Family=6, Model=F, Stepping=[0-A][C-D]
ZXC FMS:  Family=6, Model=F, Stepping=E-F OR
          Family=6, Model=0x19, Stepping=0-3

Fixes: 3a4ac121c2ca ("x86/perf: Add hardware performance events support for Zhaoxin CPU.")
Reported-by: Arjan <8vvbbqzo567a@nospam.xutrox.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=212389
Reported-by: Kevin Brace <kevinbrace@gmx.com>

Signed-off-by: silviazhao <silviazhao-oc@zhaoxin.com>
---
v1 -> v2: Add some statements for Nano and ZXC FMS information.
---
 arch/x86/events/zhaoxin/core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/zhaoxin/core.c b/arch/x86/events/zhaoxin/core.c
index 949d845c922b..3e9acdaeed1e 100644
--- a/arch/x86/events/zhaoxin/core.c
+++ b/arch/x86/events/zhaoxin/core.c
@@ -541,7 +541,13 @@ __init int zhaoxin_pmu_init(void)
 
 	switch (boot_cpu_data.x86) {
 	case 0x06:
-		if (boot_cpu_data.x86_model == 0x0f || boot_cpu_data.x86_model == 0x19) {
+		/*
+		 * Support Zhaoxin CPU from ZXC series, exclude Nano series through FMS.
+		 * Nano FMS: Family=6, Model=F, Stepping=[0-A][C-D]
+		 * ZXC FMS: Family=6, Model=F, Stepping=E-F OR Family=6, Model=0x19, Stepping=0-3
+		 */
+		if ((boot_cpu_data.x86_model == 0x0f && boot_cpu_data.x86_stepping >= 0x0e) ||
+			boot_cpu_data.x86_model == 0x19) {
 
 			x86_pmu.max_period = x86_pmu.cntval_mask >> 1;
 
-- 
2.17.1

