Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37FC574A181
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 17:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbjGFPty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 11:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjGFPt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:49:26 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2082.outbound.protection.outlook.com [40.107.6.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18171FEB;
        Thu,  6 Jul 2023 08:48:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBVdMU++/2uvRs1BSSxPGwRlBKVk+GXg3GpWo0adpmxeMXuQc8LdHywys/lrbDCZfRSbj+UEOUoTlwikAqSdy/RRVtMPIiECncMH5tcu0sWcaDEBS/1ocbbKPxm6ROV84PWbHBbUuVEv/8JO5+zFwbyX/JYlZnzNI5GVrj88b95X6ZDVOvLsdXxTbE+RZx+1W9SyMJstvoJDXVM+br+LO6Cx7WR6agnKxBI2BlD/6uoB/bNhU+7+oSewmHtUWmiy+kwm/06wPPOQO8k5eiL852z17cEOF+sflSnd3Gm00AJXzE9GVENT3d20xXi4vkzCkOouVvaY2DgbxSzhbBU1mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+PwWWr1WQOo/aE7TJWo/8eZI284YYi4aYzCsJx9dSE=;
 b=a5chj+X7FEcy+ke+PfuowDpzfJaenGPp8G3ISSNH1QSpZXVQnM8kLTpO5vvqWPuI4pNyz/tNGgcVRvJEOcGKl8mzl4edxgBytCcCoT/QBfR8RL++85UFx+YmyaTGX2oFY/nWECYiC/OpoBwUQseHj9Mah4VTVYy9YRTJINBxLx6FR4MMYp8miNDHoNTINaYoEZ9aR3s8I9/0UtXETMz+MpMheBTC2PRwemEONQp4OHmEG5z3IWBtUYebBXUecXY72clwdHaVTv6CfMiozI9IA2BOg+Ur6w88AzfMKNHorI9gtt9S21OGdufPIYlbCBWFAUck5BKwmrHX3ct3+C6Pbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=redhat.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+PwWWr1WQOo/aE7TJWo/8eZI284YYi4aYzCsJx9dSE=;
 b=XbRL4CuGIwfuxHOBSrR4mH2eSYpDKTR2JCj5rzR3i288WyeB9JwvMKJ8FDv8AWJfP7ayaRJJZ9n41Sp2raYZ83qK4inXSGV3jTLwEKaaKv8IqGEmB9yPYKMjnQAsWQD7uLQ+esc9HGoyUkCTNQB8/cItFcsL+8XKZ6R9DCtI/D7oY0cGgs+F9Dwbyrjr5238IwO8ko/6oMqtMjZBVz10jApBINHiEaIgmtYqqjK7R03pmiajyGiE8Wk+KeG946duiS1jNHY7lVwqJdrXpLZ8KE4NV0CARwakEKxplPIvIsGn3vbsDcjQLsDirTGOjk7mfI8bpMEOCe6dMkY2EIpqlw==
Received: from DUZPR01CA0272.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::12) by DB9PR10MB6377.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:3df::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 15:48:43 +0000
Received: from DB5EUR01FT051.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:4b9:cafe::d2) by DUZPR01CA0272.outlook.office365.com
 (2603:10a6:10:4b9::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.18 via Frontend
 Transport; Thu, 6 Jul 2023 15:48:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 DB5EUR01FT051.mail.protection.outlook.com (10.152.5.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.24 via Frontend Transport; Thu, 6 Jul 2023 15:48:43 +0000
Received: from DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 6 Jul 2023 17:48:43 +0200
Received: from md1za8fc.ppmd.siemens.net (139.25.69.40) by
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Thu, 6 Jul 2023 17:48:42 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
CC:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        <linux-watchdog@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
        "Tobias Schaffner" <tobias.schaffner@siemens.com>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH 1/2] watchdog: simatic-ipc-wdt: make IO region access of one model muxed
Date:   Thu, 6 Jul 2023 17:48:30 +0200
Message-ID: <20230706154831.19100-2-henning.schild@siemens.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230706154831.19100-1-henning.schild@siemens.com>
References: <20230706154831.19100-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.69.40]
X-ClientProxiedBy: DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) To
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT051:EE_|DB9PR10MB6377:EE_
X-MS-Office365-Filtering-Correlation-Id: da47eda8-79d7-458b-2e52-08db7e387a43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AZUixaYilKWZHnrI1n5qovndJJfjtn3ynB2T/r14GlhzEjYVCnHI1UFtLai0ejY8k2k1uiz9bNTvrcwPE6d7hQOazAww/JXdALQe4b/gMZD6wbzyce1lWy60XC/Og74z0Iis8NDW/6Khu3fPrgJzk+4Wz3G0ScvHRJFB+hXze7t70pkElytfCLGO3D4REXVB4tjN6fKlSQvfSMHdCU3sP3qcU0OuCP+ukjyApGnNVlT10ao9I+ZvzsMtbUjYP7k7ayT/mipwwVAYZTznzmHFFesunfwCGiWLdUANbP889wWn/eoyLVst/IZuX4xfrgBH7Mj+S3QLizLv29/+iweWdtLAomKAm5k8kROJpr5rAae8u/4mDfpoCJFJKmrsrZmRo+zarxcOX/NiQtJv/ELYZGHdpFFGlTEFPyFJI3nmZlUAnEtn+3jtFJfGc3uUu/Z4hmXtGfT0pPPJYAIXjpYI3SpJqJ1HZJUfaw4+Cosn+wwVLGOgJdrMdcAOWH68sVGnYUI7igbmy3VV7ShE0aPLCLz4WmdRNVrl7vmlTTu8ZkCR/5f0IAuaJZbikn01/7I2FLu6VXvyVv7EpAfB0HSD3DASFJRUoOEsu4flu9owGe9hokpejoXs6KPOoSI5TTHGo5TeWFBh3UpsqtXbDYGXdtN1uQcUqu3QchNX4juRx0GPkCcxEmHc3hpPuiZArpnUy6kHNAxZNThHGNITc8cpXTA5O8XC1/cy3DDZRfZzkKQ1bWbT5fDsdXIs0U4w3juJaCZL8L1TRTSqtO7h2b+CCg==
X-Forefront-Antispam-Report: CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199021)(46966006)(36840700001)(40470700004)(82960400001)(82740400003)(2906002)(40480700001)(54906003)(186003)(82310400005)(110136005)(6666004)(86362001)(478600001)(107886003)(36756003)(16526019)(26005)(1076003)(40460700003)(41300700001)(36860700001)(83380400001)(81166007)(356005)(8936002)(8676002)(5660300002)(2616005)(47076005)(44832011)(336012)(956004)(70206006)(70586007)(4326008)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 15:48:43.6767
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da47eda8-79d7-458b-2e52-08db7e387a43
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT051.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6377
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IO region used for the watchdog also hold CMOS battery monitoring
information. Make the access muxed so that a hwmon driver can use the
region as well.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/watchdog/simatic-ipc-wdt.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/simatic-ipc-wdt.c b/drivers/watchdog/simatic-ipc-wdt.c
index 6599695dc672..cdc1a2e15180 100644
--- a/drivers/watchdog/simatic-ipc-wdt.c
+++ b/drivers/watchdog/simatic-ipc-wdt.c
@@ -155,9 +155,8 @@ static int simatic_ipc_wdt_probe(struct platform_device *pdev)
 
 	switch (plat->devmode) {
 	case SIMATIC_IPC_DEVICE_227E:
-		if (!devm_request_region(dev, gp_status_reg_227e_res.start,
-					 resource_size(&gp_status_reg_227e_res),
-					 KBUILD_MODNAME)) {
+		res = &gp_status_reg_227e_res;
+		if (!request_muxed_region(res->start, resource_size(res), res->name)) {
 			dev_err(dev,
 				"Unable to register IO resource at %pR\n",
 				&gp_status_reg_227e_res);
@@ -210,6 +209,10 @@ static int simatic_ipc_wdt_probe(struct platform_device *pdev)
 	if (wdd_data.bootstatus)
 		dev_warn(dev, "last reboot caused by watchdog reset\n");
 
+	if (plat->devmode == SIMATIC_IPC_DEVICE_227E)
+		release_region(gp_status_reg_227e_res.start,
+			       resource_size(&gp_status_reg_227e_res));
+
 	watchdog_set_nowayout(&wdd_data, nowayout);
 	watchdog_stop_on_reboot(&wdd_data);
 	return devm_watchdog_register_device(dev, &wdd_data);
-- 
2.39.3

