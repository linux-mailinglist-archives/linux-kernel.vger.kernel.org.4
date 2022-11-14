Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67CF6273C4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 01:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235593AbiKNANo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 19:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235566AbiKNANm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 19:13:42 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2041.outbound.protection.outlook.com [40.107.101.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B55821B9
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 16:13:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Chds9Zbu19p4Rn+ugCb28zOl8d79Du42n03A38qDqOOCdlQzQb3DWuWXVbxLAiU99MrqjyepsOVmTtIPgpul2oEF+YuHnvJYuagUlvQwUdiPqetNzOkVlJSQLQhubTIBd1+3lwpCQPl9J4Ezj+rjlCq17bbiYKaCR0h31tpaF8Yvfw02T1tm0ZOS61DIDUiJFWj2ywJ8Ds760WHtFU41GFyW3f7HWtQTRq+DYjJ0A55kPhIWCl3Fo+dYShHv6LkW7jxIQK1ZoLSBVLZF37eVRTbL74ue3xgA11a+LE/oMgz+vD79ui3keKub8LiZibsc/HaM8tVhgy443oEFh6k3QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3MYz4FkzQj5AP2fInvSAvY5snpDTDABVqYx5eBrxDw=;
 b=binvkndGs2nMvVElS/RSvyFprcrEAKCllXY9ave3Bi30VfnfVGNhECJKrppCTSQ5nry6aydD0GpeBd10Kl7+lV8ZllTVHPkDBuLTq8en62743F9zPi2nIKjzs5A6OB0zzokx/dFQAEEJnj7hOtctSqlUF9C/2dZdYUEvA7CdqKmKqnxWaNulgOZFfzqXGYgZ6K80w2amnVTguhSXliCjuJYBd/+FQU8jV6irudessRtUMqXuP7mnpwPbeapLcfBVvBIyQc61oCNhGVW/8FxLa96RG5mGn58xjlfIjf814DQwj0ZdeyVirvbM3/EkVquGJnCcoONQmMIefdPjJ1pkNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3MYz4FkzQj5AP2fInvSAvY5snpDTDABVqYx5eBrxDw=;
 b=MOCOza/CBELhorDCJCmfL8F86ynz6p5UE0OPGLpI77hCr7cVtFg/N63op/Wzck9VCWO+/ppP0w9lA2Z3yvJ3bKXSzNw482zhJdCwkgUVj85wBIOHPCOhNOEoeETPnfNoD0rasME2mT0KlJVrcUggegCfP3KQJW5aCE6zz40m8HU=
Received: from MW4PR03CA0122.namprd03.prod.outlook.com (2603:10b6:303:8c::7)
 by DM6PR12MB5023.namprd12.prod.outlook.com (2603:10b6:5:1b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Mon, 14 Nov
 2022 00:13:38 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::81) by MW4PR03CA0122.outlook.office365.com
 (2603:10b6:303:8c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Mon, 14 Nov 2022 00:13:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Mon, 14 Nov 2022 00:13:37 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 13 Nov
 2022 18:13:35 -0600
From:   Alex Hung <alex.hung@amd.com>
To:     <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>
CC:     Alex Hung <alexhung@gmail.com>
Subject: [PATCH 2/2] MAINTAINERS: Update Alex Hung's email address
Date:   Sun, 13 Nov 2022 17:13:02 -0700
Message-ID: <20221114001302.671897-2-alex.hung@amd.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114001302.671897-1-alex.hung@amd.com>
References: <20221114001302.671897-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT039:EE_|DM6PR12MB5023:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a37ab0e-e0c3-4583-3b4c-08dac5d5139b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XfeVT79CzVG7kyb4YEbW45X4a9jVWOYt+rWjL1SJeChCSxXqKa4aTA2wgRvahzkYj/1CJ5JKRfxKoDnN2oCjeuZvlWAol3hpByf62S+vn2yuVPqV5gjn1MyP+UMHtbqgv/WYWT3qydHsG1MShC+1INUD/kjdHTinIYxcVCz3UUEGs8AC/ma52kqwHoJXog5oyyN5ItGfjgkJH3ACJxacarilha25YrekUgY8ann/i565ZgkB2hwBmUJmHYMT+6LdGSXxx9sE+MnXfZ9xCKUYwmnibgVuO3A3AIpvEZoT8BGfeR7vYK9mdQtKQagCaHNCQLwznoTCDBE4GvWrz9s1QRxx/CRKOvanZgl8X+Dd2YU6CrysEByZNnqJJYORPikGebUcVOooztFGGnTBvZzC5FVD+CqvbqdUhMDhdy3unS0x0FVqEHZWls1yCeNBvEoZEHVpn15evSZtyAj8Ek8Zkklc/0Q72shLO6I+mY0+ogvNIgYtYLy1xfHBpauIFgqKwrrmGSWXQ1fCaZIPHPdxfhavssH0HBOLlyTojHpIncXZH8pLtPFxkjGhyDjzAtAr4/6Mm2U+rXE7olx+eioCzlc4/a+TLeGrxbntPcisEuIq8rxxfmzCPOv9txGksw/HA9TB/c2uEaay5htmENURw89RDY+ojfoVczBgeCXYvEvJf5tuBN5du6OWvWG31OxAvy6+jSjYKjF9xu4s+rPuXpWThUS2+d8NQCTfpRfzwEZPiyGHsNjjmRABm3oLvoWJFMNlPEUJSM39h+wNhnHzGdWAGHC+IzjnDE1nNgZz8HxJQNbc9j2Lc/GLPqSUWoLvhEx/s6k7EqTcV9M+hhOcgQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199015)(40470700004)(46966006)(36840700001)(83380400001)(2616005)(16526019)(426003)(1076003)(186003)(336012)(47076005)(82740400003)(81166007)(44832011)(356005)(2906002)(4744005)(5660300002)(8936002)(40480700001)(40460700003)(82310400005)(966005)(478600001)(7696005)(26005)(36860700001)(4326008)(6666004)(70586007)(8676002)(41300700001)(110136005)(316002)(70206006)(86362001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 00:13:37.2586
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a37ab0e-e0c3-4583-3b4c-08dac5d5139b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5023
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Hung <alexhung@gmail.com>

Use my personal email address.

Signed-off-by: Alex Hung <alexhung@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8b3e9097137d..5ace9a9a6bd1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10288,7 +10288,7 @@ T:	git https://github.com/intel/gvt-linux.git
 F:	drivers/gpu/drm/i915/gvt/
 
 INTEL HID EVENT DRIVER
-M:	Alex Hung <alex.hung@canonical.com>
+M:	Alex Hung <alexhung@gmail.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/intel/hid.c
-- 
2.38.1

