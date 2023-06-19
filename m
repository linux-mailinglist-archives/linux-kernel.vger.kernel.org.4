Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A80C7355A3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 13:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbjFSLVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 07:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbjFSLVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 07:21:11 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2136.outbound.protection.outlook.com [40.107.117.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A66E7D;
        Mon, 19 Jun 2023 04:21:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJQpcIhOJt2a6OkCGlXQoM7RAa2kd/iBtBi6EcBgN9aY9l648S/IYpx6P36jOI6tWW55F8dGbmiXGS7p3puRykkFqOHe/jykCAguA92WMWP3p70emABuIpDHPSr57MLgLsOPhjYxkJLwONbEn8VHraSj3/voO9BL+f+4iL3OJFxCrdZ8vqm1msY2u01tBYDyopQQIAcLsKTVA6OZelPo8EaP3kP45DR6Abux87NIyEJ+//CxY5/2q+IKEzGGcj6zsef21Fzk/YiDn7umwgkBjeuo18zJbTQG74yiraOJuzj63QeY6340qZDGueGvgLl0jRQPBhO0LPmaHB3Lx1aDFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cymM26igNk6uecYIYiHKL6JBjD/MQDa044Dl8pK/01A=;
 b=CGD/SzxxdWsdnNuDmyd+P0xSp7MVjoT5TTjb856nJJ4Pvm1TStwWICaBClQGX0WcOMkQlb7xEF71ieU/xj9BaUVMXztKIc1rPTwC7k9iVPr4SpkLZbEUp+1AK04pDJ6SbU1uTiUZqS73zu0HRjkawBpFZHB0I9gae+tSZuefsQM+sbvmWleyqNQUzJHoFz9195H2qi00YzYuJuxSScMjBduwyZlq4Z+aXfrVeLF54YJ4UkKnEhvfuFuKmpX71SNvrvycBfO6zFsBFPRwkJAl7i2+eCmFgPhifjOdN3ZxC7AYxkj9+x8O6vUmKEYj/VkaJyklFMehi4SAN6opUS4P+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cymM26igNk6uecYIYiHKL6JBjD/MQDa044Dl8pK/01A=;
 b=Mx1AV9rvwD6Xt4U1Nex5QMPemcTsgxU5YhTMEU3X3c/uCMsIpmkX+SZLft6MhY1r5B5Ubu0cDPc17RSodOprDiqCNS1WHFiEuQ8foymH22zyAws1NO+e+aZaRUfyXZn1/gUgfZgG6FmdwA8eS+ZzGkitvP5gJs/xerA738wotrroBVUhPNwYufUbF8iMqUux5HG3YftcmeJZlj4Dx/se90vy5OlPjeBxGLbmcHFT3Ygy9ifwC/REskkDs++ibH/arDlvTXkYmzk2MfQhhkoCNbYfbnAPqCnOzMV279g6YZKLdFP0Npm53AGW65qqeGmEuSeB0VQajqFmsr5Y1zEH1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5022.apcprd06.prod.outlook.com (2603:1096:101:48::5)
 by SEZPR06MB5294.apcprd06.prod.outlook.com (2603:1096:101:7a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Mon, 19 Jun
 2023 11:21:00 +0000
Received: from SEZPR06MB5022.apcprd06.prod.outlook.com
 ([fe80::37cd:b3a2:1fee:705c]) by SEZPR06MB5022.apcprd06.prod.outlook.com
 ([fe80::37cd:b3a2:1fee:705c%6]) with mapi id 15.20.6500.031; Mon, 19 Jun 2023
 11:21:00 +0000
From:   Li Dong <lidong@vivo.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS
        SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM)
Cc:     opensource.kernel@vivo.com, lidong@vivo.com
Subject: [PATCH] tools: Optimize the variable with 0 as the return value
Date:   Mon, 19 Jun 2023 19:20:17 +0800
Message-Id: <20230619112047.1966-1-lidong@vivo.com>
X-Mailer: git-send-email 2.31.1.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0033.jpnprd01.prod.outlook.com
 (2603:1096:404:28::21) To SEZPR06MB5022.apcprd06.prod.outlook.com
 (2603:1096:101:48::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5022:EE_|SEZPR06MB5294:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b4d94ad-0a34-4840-0ae7-08db70b74261
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uy8ZaXUVDHP9cvuKkH+PB/8g+Sanffhk+Fs6zHrVsxxCMtqNqAICtKiZMzxWsOdE53eQeGe7b0jtzr+iT601ZVS8IKS8ILcCbMnUNUrCF3lBafGKffjQEXZWnyB3ULruaOkiksmnVRJDlxhl/j8PzlG3kFXKbdaCGQi5UShuONFLr7MLfctGw2MIb8NHWpu+XnMlkhN7w9/f4W9AD8Gqd7MhgKxj/WvPuwvyh+yn7yz7by7BpbsUorf4XhwgORdqxm/TGGY8/n2ikkKSoKFQvN/zKIAsp48FhPxQbXb9R/RVB4Z5gpKL5FZM2GF4ltuaVLsqA+Eg9dkqQk9d5gEs/QmT4W4AcIjbvq9O7QcQGgKjbvWr/GlGSnTdjqsqDaSpJcTxQ7gxfviCLr9sQevzXtH+LxoFQ2C9gPkZxty0hHryXaWCX27qp1EKZCZWmEITc/Greb4o23dV2bEV6neTE764Ja2C3pp3LijZNTPEI3UW7Y3TPRNUQjJ3i7HAiwRI2Vucyz3UASBkXI2KoZRBRRpEXlwyneeJZaRKkob2r9ynzCVym5N1oiljNyn2IDs8Yaggjq7BwQGwfB+IFuA2OpmQg9v7lRIxBsD8BvfekyaWtaf9zB7vZTE2rsl07e4SJLaL2UW1xj1EeNMDsFFTCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5022.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199021)(7416002)(66946007)(8936002)(8676002)(66556008)(66476007)(107886003)(1076003)(26005)(186003)(6506007)(6512007)(36756003)(83380400001)(41300700001)(38100700002)(38350700002)(5660300002)(4326008)(316002)(52116002)(2616005)(921005)(6666004)(6486002)(478600001)(2906002)(4744005)(86362001)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q3Yyp2d5/o9uhS1QgcoswTfS6cRtzQc7Rlt0vo+/FijWAA6ay4x8lmeJfxyW?=
 =?us-ascii?Q?YU9Q441llx22GIQtSw/9ItQjvCfSgKol2mP2zaL94/VNrDNQps9f+Kq9ESI6?=
 =?us-ascii?Q?OLcxKGsjh06BQO0xv032LjTW0ef4ZfV8JkBvO5b0DzFnoobndnpHJK5+jCTk?=
 =?us-ascii?Q?Q/ky/jTcyttUnEPLnWGmV4bu0iugirr33K6Wlkk3lNgsn6Aji6o2CNx+3e8C?=
 =?us-ascii?Q?Pnu+rZ5Vtjnesz2Eg9DeLEOGLoy6zQU9jA9WL8xx/tm8Mccx+W0m15w+bRsY?=
 =?us-ascii?Q?3QlKzXNEuJ40EjmqCQmLV4yz24OGnAembJNwBXYdRqKOTT3BHFZoCMSqDOnQ?=
 =?us-ascii?Q?Izq+XK0wiOx6EliLYsIiuIKjyRKYQmgU//J3WtqYc6bp7hJqUN7SoEBFbrqF?=
 =?us-ascii?Q?+EAOOjoMa17ZXM46uRT9+qmR+ZtNjaF7g2GAAEyJifNyPAQ3R6gfRQqzn4xD?=
 =?us-ascii?Q?N1YD40UJtCGokeb9Nq1ryYaYtnDhIVcvKdzfQyF/10vUb4HTvly4gXg1nAZS?=
 =?us-ascii?Q?zkFGANRU+XwznY+5k/Mj2OeYZvOaIwS/Iga3bB8CMV9dnaIV+Nyh0LWdXqG1?=
 =?us-ascii?Q?oNdqlfayZ4AHyLmPpETELvexZ7JTJklHLpD16iJqi2RySDh7XPvTk9Oi3wNU?=
 =?us-ascii?Q?FObB/rojaLQVyK6Zcw4g/owV+271SFiNO7QkAETv7C52JRZokyOw5pQFW0Ae?=
 =?us-ascii?Q?Z4HWSKZYWlI4NhGUPpznrjd2ouxLVUDZwHjxOMO6zE3pTSGGSZQ6GEb0131x?=
 =?us-ascii?Q?UhrA6m0zdVaD6Jv0q4yAZreuhSyGdSJ/3oU8D4iQqfod7TrxzuGjLjPKJ/L/?=
 =?us-ascii?Q?AtN1EzKiPD5y1e5QKw8Yn7YKMZvjbqMpTueGMP3hgZ+s4tne7thdXydhN/yc?=
 =?us-ascii?Q?U4t7/4j/0d4JeiAgbL71rfFgOJo3MC5D3XFENINKjOiq1xHxXoyH6H3hLHWT?=
 =?us-ascii?Q?jAzp4veWnlCITP6UiuwKLWiSGzjeiMsOcjYG/Wnhc4uYOJRm3hcI7j2vhRKi?=
 =?us-ascii?Q?1VuNymYtW8jzHWt6RYQDt1oBkvLy8bAQAtgHokT2zhGt419f6uLRbXM/cG3D?=
 =?us-ascii?Q?msA55X0LqNgwlYoxBAPMOCb8W3zJTDv0t+9bYtVEDidN/hda6Vi0IxwrjVDQ?=
 =?us-ascii?Q?cxO6i4WDBLvh/72uYK2VU+OVnz4g+8Sje23ZsrOGD/Rnodn3HS2yMsJgHigd?=
 =?us-ascii?Q?9hknj7rIrJDlkZD3AM3FOFM3QwNWsZDQBzHsNDTO1GoawHSb6wRI2H+1Ddf8?=
 =?us-ascii?Q?2DQB5H5Y64ce+sLy+2mMogIJoc5ScFWWNGFgvH4IxTHbe0KhQfkwACW1DvXz?=
 =?us-ascii?Q?55yLWYq3Qpxq4RSzHWRvfia1h/t5ZmasPB+/JYsBh5L3r5hUAS9wlhCDUCR0?=
 =?us-ascii?Q?BGn4pvPg7vEKQFpjEwv8NHnasOCBhuv0H2lWeih0pSfh5KupqekNtDHqvxde?=
 =?us-ascii?Q?/SjhKFWmLfljDyIw699WR9/BWmMP0gAwcqM7fHcdGqim5ImZ5gU9FVf/ogtI?=
 =?us-ascii?Q?Wr/7Sjc52OfVLNMMMJrB9p4CEbbooQKJrkAHfgy+E64uJ72H3Q/mNz4iSJZX?=
 =?us-ascii?Q?/5T/YDepEB4xpJVO25DFFnNdEQ/0sKjb+aUMy5Q2?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b4d94ad-0a34-4840-0ae7-08db70b74261
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5022.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 11:21:00.1008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b9YffR9QW74ybaNpavift4b32LUdu6uGKGioBzKq7nLGwdNomaiMd5RnjHKYenPbwf8IwYoqQ7fW8DW1Uc85zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5294
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable ret is not used, replacing ret with 0 as the return value

Signed-off-by: Li Dong <lidong@vivo.com>
---
 tools/perf/util/intel-pt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index dbf0bc71a63b..a40017458185 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -3398,7 +3398,6 @@ static int intel_pt_text_poke(struct intel_pt *pt, union perf_event *event)
 	struct machine *machine = pt->machine;
 	struct intel_pt_cache_entry *e;
 	u64 offset;
-	int ret = 0;
 
 	addr_location__init(&al);
 	if (!event->text_poke.new_len)
@@ -3439,7 +3438,7 @@ static int intel_pt_text_poke(struct intel_pt *pt, union perf_event *event)
 	}
 out:
 	addr_location__exit(&al);
-	return ret;
+	return 0;
 }
 
 static int intel_pt_process_event(struct perf_session *session,
-- 
2.31.1.windows.1

