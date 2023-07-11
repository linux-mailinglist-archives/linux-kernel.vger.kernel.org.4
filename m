Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5CE874ED9B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjGKMJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjGKMJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:09:09 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2067.outbound.protection.outlook.com [40.107.104.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6432310F9;
        Tue, 11 Jul 2023 05:08:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PaWwi07KBEtlJ+UsczRvdiONBQ8UF8PCL/2KPN2Aap6WnynEuCZkNEP4uamIYg5Z6GmIH0gOks99LvrxNBq4gGvvs+qt48l5mYa5liV9v/+uDVhAynvqD3xFsZTktxWlHIxjMaWF9BunLmrKaTgRl92HeAWn4wv6p0K4qREfAyDiuXjdBc+cE7qoB227FDkStaC3HJNiSCyct7UvAM47O00W7GeQ/plJPwwDDAfn41vE3g8myzbBB6DZaCzmAqD6qTT8dxMOJqSU4m73FffYHby0AobI0Mpmtme5rUx/Wg/QS2+TmYZDbGdqM3mghtXP3TgOEwRzmOpbL5beEGP0+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3o08JJ2NLz/Fgw25/v/+sKZF2ePY1JWNSfOdLKgsvo=;
 b=Of5A3TqvRxi/73O+rYAZ2Uwu4zwq70JwS2U5czMScfJVRtonBXRAWBtAxaV/u/VxZz8DHNtbL0mWAsRUTpabGUSoPFUg+r3I1eFKPUJ1gfmOOMXv10zwBXK0hx+uq7bsi9oyDCy/1WgnQcEP4GLjA04qPm4mM35nqkt02pkxGooqHSXquxXvzqHircY0fdJTeBMvnDATHj7g/ga3ox5KVq0EiEri8yBH/K15RABv4yas/7TaGJjA8/DjPlHbAoQsoy700lEqACI0fnNgaMd07zsR2uhCclOENe3fV8iO8Q5LCT6f3cGk2ttoAhebbuUcTIx/QqzEvGt6hsglXH0dgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=redhat.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3o08JJ2NLz/Fgw25/v/+sKZF2ePY1JWNSfOdLKgsvo=;
 b=JaFwhqSCDdVz/vf9nQpZrDLl3/VrJlFPm+XwzmCLtUvJXl2PwhGt/zqi3kSq1HQRu1e2jtFhY+D2gyi0TfXHpPR14cCm9ppM26BWmJmbfNM7+jF0tSSxoYf59MDllAfdjujMroYljbSrkK5dQBUSIZq+YhRsRShRxgx+QWgeNuSa8RqTg3MSFTFtInkKMemIDLpNVojP/6PJfC2BIFAlsAcfQo0XjpxGqPUs4tW2KijeKp/1iVdWiz5egcMBInpKKc+M0QrhGaS4MeXU5pBZEA6xW6UTKPpidv8lgcqk4NKYPixNXrDqOZbE9Unri8ZoKHOO49u3G80FqRKirq1HWA==
Received: from FR3P281CA0094.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a1::9) by
 DU0PR10MB6108.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e4::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.30; Tue, 11 Jul 2023 12:08:54 +0000
Received: from VE1EUR01FT066.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:a1:cafe::f0) by FR3P281CA0094.outlook.office365.com
 (2603:10a6:d10:a1::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Tue, 11 Jul 2023 12:08:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 VE1EUR01FT066.mail.protection.outlook.com (10.152.3.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.20 via Frontend Transport; Tue, 11 Jul 2023 12:08:54 +0000
Received: from DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 11 Jul 2023 14:08:53 +0200
Received: from md1za8fc.ppmd.siemens.net (139.25.68.237) by
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 11 Jul 2023 14:08:53 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Tobias Schaffner <tobias.schaffner@siemens.com>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH 1/2] platform/x86: simatic-ipc: add another model
Date:   Tue, 11 Jul 2023 14:08:41 +0200
Message-ID: <20230711120842.30044-2-henning.schild@siemens.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230711120842.30044-1-henning.schild@siemens.com>
References: <20230711120842.30044-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.68.237]
X-ClientProxiedBy: DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) To
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT066:EE_|DU0PR10MB6108:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a637c0f-902b-452a-5c71-08db820798b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fpPq6WfLLS9MUtQT5myGzZVKb3jyYjt1gaTXZrG7d/2+cVgp9mf2rpTqu6HS/iyEKXkV6DI44SgCuC4HezMPT7pddb8r/dHgT1/8qUKF8IyIE5FGdywecleaI4Vh+QOFnnnDdUvfq6UN+vG0s0hdjw7ZUk1QETOfelUBovkM2aRpJJX9YQACYQhS5aKob50qll0KIHKTTFXS7jn3pi+XC0uJhViJ2qtMCKojWZIrzxblDdI7Xwkx3gGuwt7qedP0u3D1xrYL9+WVYMoqn1l1+dMch6wVgeyL9uX6qrz5CSQ1P9qVp/6lWYVo0GtXElDcF6gylzUr0yCUg6dsf8ynp1f3oDV4K9ACsQGDnluHpt4XuHB+26OqVkOBdksiYQnVDi183lbA0QV2B4LKce3EM88068k6et1R8Kb8oBGwdTKNShjBGZ0HVm+ueQ30KLdOfbEDMalT9BKizJip1M/ZAGCRks2xrUF4GGyr3dEx/sKAbpLpjpfLDd89WWhOJY/Fhtwd7ycmtXMqm8/iVfKyAr+kOmWTo4bDYNpd8U7DN2dT/UFLYy8Mo9mIx63sJuyJM22J9wX8xeGusm2ze+BqHgkH9fnKtQCbhmx3lMzO1xRA4WmIotI3413fVvRa8CWkXVpwqpbhSDLO5RTpI/nBNDAply3CxdEAOaHORkrysssmBkLQxcTXtMcLi9xxQ6wX1cKkF3cWP4Vy3qn+NPqRWTRLcL1Q//rYBIG3Hn2MshJJYid7s3h4VpJ4al/DMwp2RU7TQZgHi5vfJTMUcE4teQ==
X-Forefront-Antispam-Report: CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(396003)(136003)(451199021)(46966006)(36840700001)(40470700004)(336012)(41300700001)(1076003)(26005)(36860700001)(107886003)(47076005)(186003)(16526019)(956004)(2616005)(81166007)(478600001)(82960400001)(356005)(82740400003)(110136005)(54906003)(6666004)(40460700003)(4326008)(44832011)(40480700001)(70206006)(70586007)(316002)(86362001)(82310400005)(5660300002)(8676002)(8936002)(36756003)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 12:08:54.1058
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a637c0f-902b-452a-5c71-08db820798b6
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT066.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6108
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the panel variant of a device we already did have. All the same,
just no LEDs.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/platform/x86/simatic-ipc.c            | 2 ++
 include/linux/platform_data/x86/simatic-ipc.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/platform/x86/simatic-ipc.c b/drivers/platform/x86/simatic-ipc.c
index 6d2c94c17414..71487216d33f 100644
--- a/drivers/platform/x86/simatic-ipc.c
+++ b/drivers/platform/x86/simatic-ipc.c
@@ -48,6 +48,8 @@ static struct {
 		SIMATIC_IPC_DEVICE_427E, SIMATIC_IPC_DEVICE_227E, SIMATIC_IPC_DEVICE_227E},
 	{SIMATIC_IPC_IPC227G,
 		SIMATIC_IPC_DEVICE_227G, SIMATIC_IPC_DEVICE_227G, SIMATIC_IPC_DEVICE_227G},
+	{SIMATIC_IPC_IPC277G,
+		SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_227G, SIMATIC_IPC_DEVICE_227G},
 	{SIMATIC_IPC_IPC277E,
 		SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_227E, SIMATIC_IPC_DEVICE_227E},
 	{SIMATIC_IPC_IPC427D,
diff --git a/include/linux/platform_data/x86/simatic-ipc.h b/include/linux/platform_data/x86/simatic-ipc.h
index 1a8e4c1099e3..f2eafa43a605 100644
--- a/include/linux/platform_data/x86/simatic-ipc.h
+++ b/include/linux/platform_data/x86/simatic-ipc.h
@@ -32,6 +32,7 @@ enum simatic_ipc_station_ids {
 	SIMATIC_IPC_IPC477E = 0x00000A02,
 	SIMATIC_IPC_IPC127E = 0x00000D01,
 	SIMATIC_IPC_IPC227G = 0x00000F01,
+	SIMATIC_IPC_IPC277G = 0x00000F02,
 	SIMATIC_IPC_IPCBX_39A = 0x00001001,
 	SIMATIC_IPC_IPCPX_39A = 0x00001002,
 	SIMATIC_IPC_IPCBX_21A = 0x00001101,
-- 
2.41.0

