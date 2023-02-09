Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C37F68FDB4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 04:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbjBIDGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 22:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbjBIDFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 22:05:55 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2093.outbound.protection.outlook.com [40.107.117.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639251A4AF
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 19:01:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DlG2zw9WLZWMOQZgFVpY7O9luAXzQgLOJ0GDnX7g3uOAoVnToviIvUzprejLmTSVhFLHNLlJOcPnzO4F8/JiVB95lMM39MXKQ5NHcalEtIz1MNzz5gUl3aktwQFD4xDOsGIZiZMD8wL9d467m04DZvYNEYes4qEwCUJHCBR0zC+0zCPnXJcjmJke9Fkc3wosoAo8udGarlVJjT+BvZ69wR8ZBQ97nCF+tsOPmPUxZOWxr5i5ElXIDeqkFNfl11VtSIKH5PHuX7fqbcKAmyt6DGO7kQR4yJiscQUVKwxDk9qfgGosKI/PSwY+Yy1t2tfpLcUR3C37MznFovPTPgSf+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWaUhcl4kG0zsK/TYIg/dCOuIL+aus58oCG3ZDDofFQ=;
 b=XMRG5V0MXtCzocmihDslMoTGmhAzVOiehH1/IZyj3mcrIUBM0/fsPOC5X0y3LwTujw+2cQFzZr5OpINtmycAighvlSVQZseNTN4tcpS9lDNfk1o6kZgp70NReON39M0wrKq9lL0ifWhIJPMhlunP8ClU/oiy8LB/2AaQg0z1rVlL5YGy65ld3wDbFU+CMR8GI52ggFg2Z7tsislkGmDVg2eOa9+f62q/rw11EjZvp0k4cohzEgyPgkO5AnG+WB9G5zoq5D8WGB/Fufn/rRU1mTYonCTpuIZBhHPBwAZWPQRHhHRkm0sAkBJ4I2iejth99UA6XdtGPMyG7rw2bkkukg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 103.192.253.182) smtp.rcpttodomain=gmail.com smtp.mailfrom=zeku.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=zeku.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zeku.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWaUhcl4kG0zsK/TYIg/dCOuIL+aus58oCG3ZDDofFQ=;
 b=y381y1oct+JNTGBhjLaFmUBAvZirU4BIStjM9LVRcyOibkLbyt1WKXlHPwm5YuaCoJF3fJg15re5JX+DaUTc02IxpnuNLm0kTprt38L0ZykRFFd6MQxYWwmBreARdLVWVCAsNMYJvr6XG8Jw+2luSVq79JTKHhqUrGQlhWgcoNLLebym8NvlPm0Cgnb2xk7IatKVxGizcxZZJc1bh7GAk7WwlWePBAZ3YqK/5tqqCjdWZ//MiXakptjuXP63gf+eT4C2R7m8MQlntuFvQPiT1K6tIE3He6oF+jBWKQk1dSujHqpCQUg6nh0QEK6gOMHwhXKZhFEc6ruZPrmAUjs1TQ==
Received: from SGAP274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::29) by
 SEZPR02MB5784.apcprd02.prod.outlook.com (2603:1096:101:42::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.35; Thu, 9 Feb 2023 03:01:07 +0000
Received: from SG2APC01FT0038.eop-APC01.prod.protection.outlook.com
 (2603:1096:4:b6:cafe::95) by SGAP274CA0017.outlook.office365.com
 (2603:1096:4:b6::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19 via Frontend
 Transport; Thu, 9 Feb 2023 03:01:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 103.192.253.182)
 smtp.mailfrom=zeku.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=zeku.com;
Received-SPF: Pass (protection.outlook.com: domain of zeku.com designates
 103.192.253.182 as permitted sender) receiver=protection.outlook.com;
 client-ip=103.192.253.182; helo=sh-exhtc2.internal.zeku.com; pr=C
Received: from sh-exhtc2.internal.zeku.com (103.192.253.182) by
 SG2APC01FT0038.mail.protection.outlook.com (10.13.37.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.17 via Frontend Transport; Thu, 9 Feb 2023 03:01:06 +0000
Received: from sh-exhtc1.internal.zeku.com (10.123.21.105) by
 sh-exhtc2.internal.zeku.com (10.123.21.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.12; Thu, 9 Feb 2023 11:01:05 +0800
Received: from sh-exhtc1.internal.zeku.com (10.123.21.105) by
 sh-exhtc1.internal.zeku.com (10.123.21.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.12; Thu, 9 Feb 2023 11:01:05 +0800
Received: from localhost.localdomain (10.123.154.19) by
 sh-exhtc1.internal.zeku.com (10.123.21.105) with Microsoft SMTP Server id
 15.1.2375.12 via Frontend Transport; Thu, 9 Feb 2023 11:01:05 +0800
From:   Weizhao Ouyang <ouyangweizhao@zeku.com>
To:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "Andrew Morton" <akpm@linux-foundation.org>
CC:     <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Weizhao Ouyang <ouyangweizhao@zeku.com>,
        Shuai Yuan <yuanshuai@zeku.com>, Peng Ren <renlipeng@zeku.com>
Subject: [PATCH] kasan: fix deadlock in start_report()
Date:   Thu, 9 Feb 2023 10:45:36 +0800
Message-ID: <20230209024536.2334644-1-ouyangweizhao@zeku.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2APC01FT0038:EE_|SEZPR02MB5784:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eac3196-879c-4f1d-9cc0-08db0a49e362
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wksN0Y9Vip71lZFpkS5My1FoolxuYdrr76CkEWPxYoTpiF/rCPPBJFE15tRFLePMzyCtrmYNFbsjIpS8Qqyj7Lk9iygHDFwkFyNktxVg6qPGHdcITmfi8tjl///ssWzsnEfr1Iwikg5FFqj/WZ2oVc9+yol6I9CuUKaYKYp0CtaVVIxscfji8e4ZJLVgac0kDY/uE1DfVl0cnFP32EQ1OmBkuNmMs9Ag4XCB84c9F9CgFEMJsDRBmDFY65/BBNOGB7Z351g4hXDebJtyWbbCgFKJIeabJlapoHgu9YJ6a43DRlb3Y69HG9CVJ094p/PSjGietJLtlpXZOOaezie3PZuWKKDwxaqFrNs4tFE56pTFEw/yulJIUS35sNZkKu09VzdrG0KtFJlx7SfvcDBTCNGtAToNkRWCzIhadASGcWFpnseDC8/Uhj5ETQRR7/bCintCSC0ezjnTB1nTz0yNrduUejrB5LoGLYJ8JuPIlfgngyYhAeWDgK3BPAwHX8R6KVrHf6VezfBsMDom5SvLE5ppWQbGsfOVlf7uUKMQVLuGlumbPKkFR15/gqJT63xjT/HZS3kSDN6acLGBqZH40tNFYXA5wW+IVbIpd6a1d72bQVcUdQSxhzsa0zvNT/5FcK8DxLq0Q9PzV0NdCrR3xxv+iX3m7js/vRvmck7fxlyoUGB3cHmGP/+CRMGKURBy
X-Forefront-Antispam-Report: CIP:103.192.253.182;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:sh-exhtc2.internal.zeku.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(39850400004)(346002)(396003)(376002)(451199018)(36840700001)(46966006)(356005)(2906002)(8936002)(1076003)(6666004)(81166007)(82740400003)(5660300002)(107886003)(36860700001)(110136005)(82310400005)(426003)(2616005)(47076005)(41300700001)(36756003)(54906003)(70206006)(4326008)(83380400001)(70586007)(86362001)(8676002)(40480700001)(316002)(336012)(26005)(186003)(478600001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: zeku.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 03:01:06.5432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eac3196-879c-4f1d-9cc0-08db0a49e362
X-MS-Exchange-CrossTenant-Id: 171aedba-f024-43df-bc82-290d40e185ac
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=171aedba-f024-43df-bc82-290d40e185ac;Ip=[103.192.253.182];Helo=[sh-exhtc2.internal.zeku.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2APC01FT0038.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB5784
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 mm/kasan/report.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 22598b20c7b7..82aa75259cf4 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -166,7 +166,7 @@ static inline void fail_non_kasan_kunit_test(void) { }
 
 static DEFINE_SPINLOCK(report_lock);
 
-static void start_report(unsigned long *flags, bool sync)
+static bool start_report(unsigned long *flags, bool sync)
 {
 	fail_non_kasan_kunit_test();
 	/* Respect the /proc/sys/kernel/traceoff_on_warning interface. */
@@ -175,8 +175,14 @@ static void start_report(unsigned long *flags, bool sync)
 	lockdep_off();
 	/* Make sure we don't end up in loop. */
 	kasan_disable_current();
-	spin_lock_irqsave(&report_lock, *flags);
+	if (!spin_trylock_irqsave(&report_lock, *flags)) {
+		lockdep_on();
+		kasan_enable_current();
+		pr_err("%s ignore\n", __func__);
+		return false;
+	}
 	pr_err("==================================================================\n");
+	return true;
 }
 
 static void end_report(unsigned long *flags, void *addr)
@@ -468,7 +474,10 @@ void kasan_report_invalid_free(void *ptr, unsigned long ip, enum kasan_report_ty
 	if (unlikely(!report_enabled()))
 		return;
 
-	start_report(&flags, true);
+	if (!start_report(&flags, true)) {
+		pr_err("%s: start report ignore\n", __func__);
+		return;
+	}
 
 	memset(&info, 0, sizeof(info));
 	info.type = type;
@@ -500,10 +509,14 @@ bool kasan_report(unsigned long addr, size_t size, bool is_write,
 
 	if (unlikely(report_suppressed()) || unlikely(!report_enabled())) {
 		ret = false;
+		pr_err("%s: start report ignore\n", __func__);
 		goto out;
 	}
 
-	start_report(&irq_flags, true);
+	if (!start_report(&irq_flags, true)) {
+		ret = false;
+		goto out;
+	}
 
 	memset(&info, 0, sizeof(info));
 	info.type = KASAN_REPORT_ACCESS;
@@ -536,7 +549,10 @@ void kasan_report_async(void)
 	if (unlikely(!report_enabled()))
 		return;
 
-	start_report(&flags, false);
+	if (!start_report(&flags, false)) {
+		pr_err("%s: start report ignore\n", __func__);
+		return;
+	}
 	pr_err("BUG: KASAN: invalid-access\n");
 	pr_err("Asynchronous fault: no details available\n");
 	pr_err("\n");
-- 
2.25.1

