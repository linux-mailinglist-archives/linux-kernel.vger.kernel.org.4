Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0BB6878FD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 10:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjBBJgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 04:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjBBJgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 04:36:36 -0500
X-Greylist: delayed 1111 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Feb 2023 01:36:15 PST
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF79366AA
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 01:36:15 -0800 (PST)
X-ASG-Debug-ID: 1675329459-1eb14e798049070001-xx1T2L
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx2.zhaoxin.com with ESMTP id fIQu6BWVEJRrs4Go (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Thu, 02 Feb 2023 17:17:39 +0800 (CST)
X-Barracuda-Envelope-From: SilviaZhao-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXBJMBX02.zhaoxin.com (10.29.252.6) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Thu, 2 Feb
 2023 17:17:39 +0800
Received: from silvia-OptiPlex-3010.zhaoxin.com (10.29.8.47) by
 ZXBJMBX02.zhaoxin.com (10.29.252.6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 2 Feb 2023 17:17:38 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
From:   silviazhao-oc <silviazhao-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.6
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <tglx@linutronix.de>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <hpa@zytor.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <cobechen@zhaoxin.com>, <louisqi@zhaoxin.com>,
        <silviazhao@zhaoxin.com>, <tonywwang@zhaoxin.com>,
        <kevinbrace@gmx.com>, <8vvbbqzo567a@nospam.xutrox.com>
Subject: [PATCH] x86/perf/zhaoxin: Add stepping check for ZX-C
Date:   Thu, 2 Feb 2023 17:17:38 +0800
X-ASG-Orig-Subj: [PATCH] x86/perf/zhaoxin: Add stepping check for ZX-C
Message-ID: <20230202091738.5947-1-silviazhao-oc@zhaoxin.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.29.8.47]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX02.zhaoxin.com (10.29.252.6)
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1675329459
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1478
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.4337 1.0000 0.0000
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.104216
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

Nano processor may not fully support rdpmc instruction, it works well
for reading general pmc counter, but will lead GP(general protection)
when accessing fixed pmc counter. Furthermore, family/mode information
is same between Nano processor and ZX-C processor, it leads to zhaoxin
pmu driver is wrongly loaded for Nano processor, which resulting boot
kernal fail.

To solve this problem, stepping information will be checked to distinguish
between Nano processor and ZX-C processor.

Fixes: 3a4ac121c2ca (“x86/perf: Add hardware performance events support for Zhaoxin CPU”)
Reported-by: Arjan <8vvbbqzo567a@nospam.xutrox.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=212389
Reported-by: Kevin Brace <kevinbrace@gmx.com>

Signed-off-by: silviazhao-oc <silviazhao-oc@zhaoxin.com>
---
 arch/x86/events/zhaoxin/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/zhaoxin/core.c b/arch/x86/events/zhaoxin/core.c
index 949d845c922b..cef1de251613 100644
--- a/arch/x86/events/zhaoxin/core.c
+++ b/arch/x86/events/zhaoxin/core.c
@@ -541,7 +541,8 @@ __init int zhaoxin_pmu_init(void)
 
 	switch (boot_cpu_data.x86) {
 	case 0x06:
-		if (boot_cpu_data.x86_model == 0x0f || boot_cpu_data.x86_model == 0x19) {
+		if ((boot_cpu_data.x86_model == 0x0f && boot_cpu_data.x86_stepping >= 0x0e) ||
+			boot_cpu_data.x86_model == 0x19) {
 
 			x86_pmu.max_period = x86_pmu.cntval_mask >> 1;
 
-- 
2.17.1

