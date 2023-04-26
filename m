Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4B36EF256
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 12:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240373AbjDZKmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 06:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjDZKmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 06:42:00 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2134.outbound.protection.outlook.com [40.107.21.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFD646BC;
        Wed, 26 Apr 2023 03:41:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LG8+Eoz4WPIpCgZj8OhYZlMsziInJJtSOwPuTOsJ8bGVo6YLyINiZJNZL+Ypl2Biz18Ia4J2D/rwJPaFBxhZVxeZCkaAtao3GEz4roMoTqOkmfQAZIH825CFzwfXXSyast/3iy6Ny1rqTiyhDT8GBgQm8T7PcvdD1pphhec9U2jB+UHiStb9o+XWPTySeJ4ZI7uUNcFZ20cgJYYyF19BGCO5JCjsrJGK2CYP7B/KMgob/cW96c52OK+lb0zixCedBh2y79fCqxsktqkm5WK907ph2Y3WW/NY6x4AYnhajFIWZXB0+qiTtMQUuiwfAiF//OmE93eQ35Cl2lwF8qtbZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qu8USnRP+LQisbAxv7nzB6SeUzWZUbFaw7Y1TAMLR10=;
 b=PsL6jpS5hrKx1v8gQbXH0Y6I4sanx6kqiAzmBBWYTGPevIPoh0LyuADtzeOp1H593aiBGnCrpLeLZIhXe6sMzDwEme30rbCFUuHOiSciWSi3cBv9b4v4ygvjw5skvJdJvuavO4pYHiMstjG7ClxG2A+hFLYCDzRqKt1O6XERGHdTOyGsGMdIbTHa8GKSOaDXfUpqPC401Mrx28wazBqyh2SVzZ8BaVoZjYovllnEbUWnDGhG30cLyaJDJ6HsbAR9GBXJztIEPrNGDufHKj74lLDt+vs2e+oh9xPBm1X/0Xcf+Hamj3TG7UwO1iWZnlNt9SKBjMeh694pG4FL7tUE+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=estab.onmicrosoft.com;
 s=selector2-estab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qu8USnRP+LQisbAxv7nzB6SeUzWZUbFaw7Y1TAMLR10=;
 b=g1Kw38m+wbw+hI3nUIiemJenybKgtTmyCjvZnuoU0UpA60BbBJg/fWCXJ4oX6GFfSd+0AZ5iYmpGBaMrgkFF+/NapHGeAjv/v/0HbPnLtWB5sKyeV0tCm7stf7Gd2hekT6g754Tr3lI2wsUT04jbKM8GdpBCBq/pzCTQxOTwcMw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e7::15)
 by DB8P189MB1062.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:166::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Wed, 26 Apr
 2023 10:41:53 +0000
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::c697:dbef:e1d6:c2b5]) by DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::c697:dbef:e1d6:c2b5%6]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 10:41:53 +0000
From:   Sriram Yagnaraman <sriram.yagnaraman@est.tech>
To:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Subject: [PATCH] perf script: Align kfree_skb tracepoint parameters
Date:   Wed, 26 Apr 2023 12:41:49 +0200
Message-Id: <20230426104149.14089-1-sriram.yagnaraman@est.tech>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF000000F8.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:1:0:22) To DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:1e7::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBP189MB1433:EE_|DB8P189MB1062:EE_
X-MS-Office365-Filtering-Correlation-Id: c92558ba-5ce3-4d44-2aed-08db4642d919
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bmUHEJQs5UjcscZ+OyRE5GqARLpdZk4cnXtRmfWgmFmKLFCE+GF+7ht4T2W2gQbBiLet01wWKRikfM8ip/COoMrCP9jQloNZHaKv4oVHQowgJ/NciR97gDjehkdVWU5EovWwq2JP7V1KLW/3KvRQJaH0Umvi7F5U7PIrx4CunhFiawAYFX8+d3anzh9pPNdCwFYKWY+p3EefIdUUaQR9KxoI+MpQgwwl91UJA/fygROKyPr1dJKD11E60j9qbYhN5IE5zq+qabRXu4b6hqSeLp05ggLi8mfqwKfgqI0TV2ai6a5zddCwlr7J87LhyIYAoDSMiwNYT3TIay4guHuKkzdBMojsLqohY9tQ5Ej2PoA+VdJR5LFiqp3NeH9GbQ73B7WhX9BR3sGJGxjBuXygSF0hwXG08BVjJbI0x9Fanb6TjbNEVeR09QaLi7KqZ57p+hzs4JT3xQLP1dZdDaW42ePf3o0ux3ELpju32KT85Sz5HCHTjMKHYEZv4JmDnyFqj+MxN4hnF/aNxAaHTFeQotfgzMvLvlbba4p06jWV4dadN0SYiR42ED3vLRXcZjAulA/SkS1EkKIlNbmL3Uh+RXLcOcQFlga6oJNocqCyfRVCxQskbK8XF6150kCkI8aF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBP189MB1433.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(39840400004)(396003)(136003)(376002)(346002)(451199021)(1076003)(26005)(6506007)(6512007)(186003)(2616005)(83380400001)(36756003)(6486002)(6666004)(41300700001)(316002)(5660300002)(44832011)(54906003)(2906002)(478600001)(7416002)(38100700002)(86362001)(8936002)(8676002)(66476007)(66556008)(66946007)(4326008)(70586007)(37730700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yQX2awOa5FYC/x2fWXiJ9dXOoxcD09xAtwNSAwye+7TZgZjJY40GDgJH/xm9?=
 =?us-ascii?Q?SS6nN52Mdkw5gXrIuNc81NZkYXzqI+LPh4Bv0vaE2MavwNbQiSLrtk5ROgq4?=
 =?us-ascii?Q?K2sikPITRM3KXboWrnKTDHhQ7gs95xhZIUVLnlhSopmuu2frD7/DQtWhTGto?=
 =?us-ascii?Q?YgcL/cNPgt/7JS8mcaQXedmFuQ/UySjxBzTwpX8SpxpZVSs/8I3Vn9UA3bRF?=
 =?us-ascii?Q?AEi/u+NaunSgdSP3XdNsOOILaHS65AD/woANM7DPQs0L9JVn4ZL9l0dKnIWZ?=
 =?us-ascii?Q?cvNSLT8IVqxBAFjmLCYkTmIGvU408E8ViRKWU6xA8ShOWeRllc5kQjIzt+C9?=
 =?us-ascii?Q?LDckEZRnuVxRduGEi3bkqrT8i9Kw4JlZNYPIO5Lf/IzZgoUjEx6PI7n6b1go?=
 =?us-ascii?Q?FXivaDsPlHOspcx3sFu485i5AxFOdQJPYXbgvcETeDwIjX0hGnPMMeMDXnD3?=
 =?us-ascii?Q?tHZbv2xp5D53asAeUr28jlER6zDwp+qaDSDHe4uTL8peUn183w7PyOE8T31S?=
 =?us-ascii?Q?vFV8vo8w+/c4N5TL+gkkJAhOM7JQ2Rf+D1aWFwpFTKP5vFprurs3/+ZvIrZ0?=
 =?us-ascii?Q?hpLQv7JAvfJZQPY03b5qIixPT3AWVT+OMcb7G01L0p1mKcuopysX2y8gyWAA?=
 =?us-ascii?Q?+FFFdRgG95QwqkQcQ0prW9nO3hET+FR45JNBUBqcS1unamWU5ZKHPFfc7Kxt?=
 =?us-ascii?Q?FtdQI2jEEgKuVF0ASkGw6QB2+DLgtY7+qIrWB1QEk7Z+B/UsH378Nkml1zJc?=
 =?us-ascii?Q?X9gFBl7bztWbnZonPSKJfxmZNio8A00UbGs/dEPIoGBdnOyaSiZwg8ET9dm0?=
 =?us-ascii?Q?4Qzi0f2B7r+CcRvYzd9Ska0JvsIs8o2QwiJ+MLrj6W/lERc3oCFcYazAkJMd?=
 =?us-ascii?Q?3dw+NZDdhr0yukxADDTNZPi8BJlB1SoEFn8pJOMnDu7RijGIHOhDjsmJrSRZ?=
 =?us-ascii?Q?RunDPgfsHxAAzQqSVGVcfQQ4Gr+9a6Tiw+8+wdjNIZpIUVhUWk2SKq5LG8Tr?=
 =?us-ascii?Q?Z9yAzk8rJd1I2KAXGuglMq9bkvwTSKd0mbOllM2Hl54+m20trXynuS+kfU3T?=
 =?us-ascii?Q?2FWSs8ocKI0lex/8fy1SI750LyDO+kBCLe/oiXgNHrPmyf0InozhCqWjenhm?=
 =?us-ascii?Q?GclMffOJSmBHDNMz0K7M0ziuOuJIwHqJaAC611VWeIqF3bkU6sS3PHnEJad2?=
 =?us-ascii?Q?Y5jd894Mw0s57KTQ77ZUnWu0pEDNCARqY9yMS2sINoBDrYgoPLG4zwUUk+Xk?=
 =?us-ascii?Q?m9vzWlbws0HNWynPRLjmVWEpmNSUhjsPI1SBzT2YO0dK7ZPfIvaPVaaoi/Sv?=
 =?us-ascii?Q?cMsuvZX53fe0uLIICnPj1DxQ41j8viEkGZCtfjy0wiS+VvhMnV1ZCiHv7pI1?=
 =?us-ascii?Q?xF24iqXJvxgIIFewlF+LreiaTl/P+pOQOIAJ/kPdkO1PJq+zF2Lo0lnqXopF?=
 =?us-ascii?Q?sPGwfFjHZo/3lrk97ANThMhX4vlyrc6VY2Z0DmdiElNKHAyUcwg1WY3OKsLF?=
 =?us-ascii?Q?i4diFDFbMly3Bj0UsbOVd9oVXzTdsNLAKFZg1E5yPdg/XXROaoyfw9+G7V+O?=
 =?us-ascii?Q?H08H3ewC7xMMlHfYcLfR+V5wyklRbwpjHCXZYgU8Py9F5xig1qckz8TR7LIm?=
 =?us-ascii?Q?cA=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: c92558ba-5ce3-4d44-2aed-08db4642d919
X-MS-Exchange-CrossTenant-AuthSource: DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 10:41:52.9830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GO5wHtZQ1qJP3aL56EGb6VJCpaMQdRqnJIJk4p+7l4F0b0LdE9LtkrJ1PFFaNh3iVvBlKGov8bZJ3ONKHRS7uGYhu3abI9pSAgHw4svcfMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P189MB1062
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure if the scripts changed in this patch are used, but nevertheless
here is a patch with a minor bug fix.
---

Include reason parameter that was added in
commit c504e5c2f964 ("net: skb: introduce kfree_skb_reason()")

Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
---
 tools/perf/scripts/python/net_dropmonitor.py | 4 ++--
 tools/perf/scripts/python/netdev-times.py    | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/scripts/python/net_dropmonitor.py b/tools/perf/scripts/python/net_dropmonitor.py
index 101059971738..a97e7a6e0940 100755
--- a/tools/perf/scripts/python/net_dropmonitor.py
+++ b/tools/perf/scripts/python/net_dropmonitor.py
@@ -68,9 +68,9 @@ def trace_end():
 	get_kallsyms_table()
 	print_drop_table()
 
-# called from perf, when it finds a correspoinding event
+# called from perf, when it finds a corresponding event
 def skb__kfree_skb(name, context, cpu, sec, nsec, pid, comm, callchain,
-		   skbaddr, location, protocol):
+		   skbaddr, location, protocol, reason):
 	slocation = str(location)
 	try:
 		drop_log[slocation] = drop_log[slocation] + 1
diff --git a/tools/perf/scripts/python/netdev-times.py b/tools/perf/scripts/python/netdev-times.py
index a0cfc7fe5908..00552eeb7178 100644
--- a/tools/perf/scripts/python/netdev-times.py
+++ b/tools/perf/scripts/python/netdev-times.py
@@ -288,9 +288,9 @@ def net__net_dev_xmit(name, context, cpu, sec, nsec, pid, comm, callchain,
 	all_event_list.append(event_info)
 
 def skb__kfree_skb(name, context, cpu, sec, nsec, pid, comm, callchain,
-			skbaddr, protocol, location):
+			skbaddr, location, protocol, reason):
 	event_info = (name, context, cpu, nsecs(sec, nsec), pid, comm,
-			skbaddr, protocol, location)
+			skbaddr, location, protocol, reason)
 	all_event_list.append(event_info)
 
 def skb__consume_skb(name, context, cpu, sec, nsec, pid, comm, callchain, skbaddr):
@@ -430,7 +430,7 @@ def handle_net_dev_xmit(event_info):
 
 def handle_kfree_skb(event_info):
 	(name, context, cpu, time, pid, comm,
-		skbaddr, protocol, location) = event_info
+		skbaddr, location, protocol, reason) = event_info
 	for i in range(len(tx_queue_list)):
 		skb = tx_queue_list[i]
 		if skb['skbaddr'] == skbaddr:
-- 
2.34.1

