Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3136068FDF5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 04:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbjBID3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 22:29:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbjBID2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 22:28:42 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2137.outbound.protection.outlook.com [40.107.255.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38D515CB1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 19:27:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j1sv53BuXfi62XjcaFBJDDvBM0U/wdOiZNHF9LOjdc5w9wdL9D378SNbTljqLzgFstQFJrX4Jk1ZrkyWkodqMQxd1JLksjfWq/KFedt5VMI/D3Q+XFKq7Fry/2+/D+aHoZ9sj34XoCvsBeOeE13E7bkAroMinYEvjbSXck241yT4NhEHP8sBQrPP4YSvtqhUV6VxW+ma/xT9C01gsU/D+SZ6/Vl/GEtBGeOOvxaUdi2sbHQnEHS6lhp6TecAQsoFBTU8UubLzPUzE2fzkavUruUNXNSI8m/rdHq2d4eyDK7hH+siGUaRwSCidOglFNs71jpne1p4x7fb17+vV1KQSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMsTfoXAVz7HPkrgNVxHHrE4a/fTKMFzP3+DIvN2VEI=;
 b=XtnV/vTnrzZDVHRbMCNSvQ0qJ8DZcyEgl58FvxVQ3DPZlLQ8Cn6bRGl8ZZsdiAOj42tPNtc6dlUtoSGk4QZQxEn/XCQ+OnL8PJ0dFqRCjs5+1Ou1pMStiAn6Z9T6/ZZ5c2uClSWPmMC+U4vnoV0erlLN6U6t8/9fC+A+Zqf941YuNxxYtKGAaVp/OR00tbcOwB8jyoGsYb0Z6ymCpkCH00uUOScTf1GuBIl8tFD6P4Y2aoMm73N+kWN8z6s/M3atLvcvjRts294pgW9Hv2q7+Qf7UhfZP4F+yZnRtqxilIUtbThdtChjI+vJ2fKc15ZHEqCFQa8oVmCt4J8busF/TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 103.192.253.182) smtp.rcpttodomain=gmail.com smtp.mailfrom=zeku.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=zeku.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zeku.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMsTfoXAVz7HPkrgNVxHHrE4a/fTKMFzP3+DIvN2VEI=;
 b=IJkFn9sKeGGhLSBpchnYsIwRyUN6haT2wv4SuYaIX1KWpN+spGWVeiEJz0d42sIJZzaHulCx2y1YfAITYPy8WdbQPB63JvA4iQgkg6uy9Yig/IUUi1VdYix6lynVkNvtRLOEFZr3Rzy/+dfWgJkj93ZKiCUPQGOrZn0/6EqhHDroKBmAflt9ht9wZTPFMngGWam42e3Dbgb9JTSmKO961j31F1IpWFPVfYlafQPzVSlACgtOpQ5VWCkJeP+0IBD/mYxsH3NO7+2CuXNEuTS22xnNBb1s/OpQDfPjzeodwEHrE6xORvPlXvKwuXrPjOwVwF/cC32Aomy92rmU+fGRbA==
Received: from SG2PR02CA0051.apcprd02.prod.outlook.com (2603:1096:4:54::15) by
 SG2PR02MB4347.apcprd02.prod.outlook.com (2603:1096:0:5::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.17; Thu, 9 Feb 2023 03:27:35 +0000
Received: from SG2APC01FT0026.eop-APC01.prod.protection.outlook.com
 (2603:1096:4:54:cafe::d0) by SG2PR02CA0051.outlook.office365.com
 (2603:1096:4:54::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.18 via Frontend
 Transport; Thu, 9 Feb 2023 03:27:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 103.192.253.182)
 smtp.mailfrom=zeku.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=zeku.com;
Received-SPF: Pass (protection.outlook.com: domain of zeku.com designates
 103.192.253.182 as permitted sender) receiver=protection.outlook.com;
 client-ip=103.192.253.182; helo=sh-exhtc2.internal.zeku.com; pr=C
Received: from sh-exhtc2.internal.zeku.com (103.192.253.182) by
 SG2APC01FT0026.mail.protection.outlook.com (10.13.37.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.17 via Frontend Transport; Thu, 9 Feb 2023 03:27:34 +0000
Received: from sh-exhtc3.internal.zeku.com (10.123.154.250) by
 sh-exhtc2.internal.zeku.com (10.123.21.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.12; Thu, 9 Feb 2023 11:27:34 +0800
Received: from sh-exhtc1.internal.zeku.com (10.123.21.105) by
 sh-exhtc3.internal.zeku.com (10.123.154.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.986.5;
 Thu, 9 Feb 2023 11:27:33 +0800
Received: from localhost.localdomain (10.123.154.19) by
 sh-exhtc1.internal.zeku.com (10.123.21.105) with Microsoft SMTP Server id
 15.1.2375.12 via Frontend Transport; Thu, 9 Feb 2023 11:27:33 +0800
From:   Weizhao Ouyang <ouyangweizhao@zeku.com>
To:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "Andrew Morton" <akpm@linux-foundation.org>
CC:     <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Weizhao Ouyang <o451686892@gmail.com>,
        "Shuai Yuan" <yuanshuai@zeku.com>,
        Weizhao Ouyang <ouyangweizhao@zeku.com>,
        Peng Ren <renlipeng@zeku.com>
Subject: [PATCH v2] kasan: fix deadlock in start_report()
Date:   Thu, 9 Feb 2023 11:11:59 +0800
Message-ID: <20230209031159.2337445-1-ouyangweizhao@zeku.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2APC01FT0026:EE_|SG2PR02MB4347:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e1cfa4d-addf-44e7-25ac-08db0a4d961e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YPH2u0bp0ju5wCWJXcCtE/QYoZuaJu1/882wCqkNyaVht3NOrkfzFtc6hg5shXdZfVptF8XNfGh2h/I/VW/4LvIlKbKGCxeTVv6ucePatHtEpibCwdBvVohRDUd8LjHbhaMfPGZwRhUnhdzvljpqoYfjcZhJzxuKZLKNAt3xPZDp/8b25MRSjgOolpqWLTDDfi2b+E0Aue8OI06zykg+DSa6QiTJUaOp07I/Zktwv3rTBzQyD+gY2KJ7pmWe4/Odtj727BKp1FCC8MkWlOHNXNk16HOKi8lQaxu3HZzgwmpX79Claz0FD19ZSUjmqxi1fFRYWqXoafMiVfIqFJI2KjmIXcuU7UdEniQzHs7rxf35mufs8gig6AAPbUdm9pEcNn2aHq1cGkCpML6cUl0fHaxrciDo88ql7jyr34vfo67D/Tc/40Mx9Vsh3cRzWvHkhN1moBiH8m6RWG/DTldJiNt5k7tjmgZEgosMyfc4XMrBdlqUtA8FMFJC0jv1qi8zXUv7ptrHpMz0x6/rS63MWijiDihuL8P5KDjy9Nq/HqLa9KhRlHCLpvfmfemLJzxccsnS27j8t447DgZQTt7RnyHFVB6J+KlrsExxJojKvqdO5jESPXPfBzm9rXvPwej35IWxI+zXsb3Rv7OaU+EGW+1PezKq3egxmNeFTNEZN7mtIeXQBmkKLdj9ya0TGeat
X-Forefront-Antispam-Report: CIP:103.192.253.182;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:sh-exhtc2.internal.zeku.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(376002)(39850400004)(136003)(451199018)(36840700001)(46966006)(70206006)(4326008)(70586007)(8676002)(336012)(36860700001)(316002)(83380400001)(110136005)(54906003)(86362001)(426003)(5660300002)(7416002)(81166007)(356005)(478600001)(1076003)(186003)(26005)(36756003)(6666004)(107886003)(2906002)(47076005)(82310400005)(41300700001)(8936002)(82740400003)(2616005)(40480700001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: zeku.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 03:27:34.8968
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e1cfa4d-addf-44e7-25ac-08db0a4d961e
X-MS-Exchange-CrossTenant-Id: 171aedba-f024-43df-bc82-290d40e185ac
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=171aedba-f024-43df-bc82-290d40e185ac;Ip=[103.192.253.182];Helo=[sh-exhtc2.internal.zeku.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2APC01FT0026.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB4347
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weizhao Ouyang <o451686892@gmail.com>

From: Shuai Yuan <yuanshuai@zeku.com>

Calling start_report() again between start_report() and end_report()
will result in a race issue for the report_lock. In extreme cases this
problem arose in Kunit tests in the hardware tag-based Kasan mode.

For example, when an invalid memory release problem is found,
kasan_report_invalid_free() will print error log, but if an MTE exception
is raised during the output log, the kasan_report() is called, resulting
in a deadlock problem. The kasan_depth not protect it in hardware
tag-based Kasan mode.

Signed-off-by: Shuai Yuan <yuanshuai@zeku.com>
Reviewed-by: Weizhao Ouyang <ouyangweizhao@zeku.com>
Reviewed-by: Peng Ren <renlipeng@zeku.com>
---
Changes in v2:
-- remove redundant log

 mm/kasan/report.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 22598b20c7b7..aa39aa8b1855 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -166,7 +166,7 @@ static inline void fail_non_kasan_kunit_test(void) { }
 
 static DEFINE_SPINLOCK(report_lock);
 
-static void start_report(unsigned long *flags, bool sync)
+static bool start_report(unsigned long *flags, bool sync)
 {
 	fail_non_kasan_kunit_test();
 	/* Respect the /proc/sys/kernel/traceoff_on_warning interface. */
@@ -175,8 +175,13 @@ static void start_report(unsigned long *flags, bool sync)
 	lockdep_off();
 	/* Make sure we don't end up in loop. */
 	kasan_disable_current();
-	spin_lock_irqsave(&report_lock, *flags);
+	if (!spin_trylock_irqsave(&report_lock, *flags)) {
+		lockdep_on();
+		kasan_enable_current();
+		return false;
+	}
 	pr_err("==================================================================\n");
+	return true;
 }
 
 static void end_report(unsigned long *flags, void *addr)
@@ -468,7 +473,10 @@ void kasan_report_invalid_free(void *ptr, unsigned long ip, enum kasan_report_ty
 	if (unlikely(!report_enabled()))
 		return;
 
-	start_report(&flags, true);
+	if (!start_report(&flags, true)) {
+		pr_err("%s: report ignore\n", __func__);
+		return;
+	}
 
 	memset(&info, 0, sizeof(info));
 	info.type = type;
@@ -503,7 +511,11 @@ bool kasan_report(unsigned long addr, size_t size, bool is_write,
 		goto out;
 	}
 
-	start_report(&irq_flags, true);
+	if (!start_report(&irq_flags, true)) {
+		ret = false;
+		pr_err("%s: report ignore\n", __func__);
+		goto out;
+	}
 
 	memset(&info, 0, sizeof(info));
 	info.type = KASAN_REPORT_ACCESS;
@@ -536,7 +548,10 @@ void kasan_report_async(void)
 	if (unlikely(!report_enabled()))
 		return;
 
-	start_report(&flags, false);
+	if (!start_report(&flags, false)) {
+		pr_err("%s: report ignore\n", __func__);
+		return;
+	}
 	pr_err("BUG: KASAN: invalid-access\n");
 	pr_err("Asynchronous fault: no details available\n");
 	pr_err("\n");
-- 
2.25.1

