Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C409860133A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 18:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbiJQQOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 12:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiJQQOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 12:14:17 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3406CF66
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 09:14:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XldIan6s6PAEbl9gskW7cX0cTpJi5bFpOYB6nBStPoaUbSK8vSO+kE43AuPreDWBmbuaOAQgQg60s0sb1YSSaHEoMB/jH3R5p/+T69hzhwSuj4JCjVBhKWkhD56PD3NLQXeyt+yX89l2Lt2wOZv4RFKT2CYydftcY9k6eIMP4Em/pylnJO8UcVkWuZNtMOX6N/jT0qk3hHJnW0TJMBNHTj106iKA2qhiN3JfRDv7HKnaneCeuE8PDrS0QydfNVATZWnFAG8yO04Z6ukydP6oPZkDfM2DEDku2eMu+AHxnIeURDsnXrc2NjzRCYWS1X+IOwNSXTXzHyr/3SOfz3KbxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujfJIlq22G84VPkWfwNQ3i8i1u19Q82jUaBuh+exsCs=;
 b=UvjkfwoyG/+vrrfXROOW2mCJkXTZhkuVuDTQ+D5FERwpBEHdMpRhJD80GTcjWpYBso8AJZV8Zd43smqTLOAkrrYUxlxeA0DDZuMcDNrqFrtSAwFupd0eZ5HLPKB15PyqAM5kcrdFyn799Mlr77PLglR+Bn6zsX2OtGAurzbzxow++F2CzWyJ3nFd4QYmgInXAmHrwtkpD3uH1I3Sh0gd4zTKb+5FkgNh4t+YMzoGRWU436gLMJ4hyHCX1Dk2fbN6w9d19hQsROKFq4eleu27YgbziA3mq/1qjOzjVafhvvoKzbbMk7mQIaVDvFqI0V5ipv2+e0+ggbHAfEi0bpco3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujfJIlq22G84VPkWfwNQ3i8i1u19Q82jUaBuh+exsCs=;
 b=Ly85MXmdurpEmEcODq0BbmO7gQ2/AAeSlGtDkCu9SZ0V4NxXVdHcM0QJMiJyne+5fJZsTkVxHR1j6eJw89qyq5SwTo0IiW3hr5QYSMmuMoGtaqV1ddbTmxNsqdcTo0t5PUH3kGaxYRIvbbxKsx+XHuQ8gz87Ils/JMW8huPqzBY=
Received: from DM6PR03CA0034.namprd03.prod.outlook.com (2603:10b6:5:40::47) by
 MW4PR12MB6779.namprd12.prod.outlook.com (2603:10b6:303:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Mon, 17 Oct
 2022 16:14:13 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::c7) by DM6PR03CA0034.outlook.office365.com
 (2603:10b6:5:40::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.31 via Frontend
 Transport; Mon, 17 Oct 2022 16:14:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Mon, 17 Oct 2022 16:14:13 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 17 Oct
 2022 11:14:10 -0500
From:   Hamza Mahfooz <hamza.mahfooz@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     Roman Li <roman.li@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>,
        "Harry Wentland" <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        "Rodrigo Siqueira" <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Stylon Wang <stylon.wang@amd.com>,
        Alex Hung <alex.hung@amd.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] drm/amd/display: add an ASSERT() to irq service functions
Date:   Mon, 17 Oct 2022 12:13:22 -0400
Message-ID: <20221017161322.95808-1-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT030:EE_|MW4PR12MB6779:EE_
X-MS-Office365-Filtering-Correlation-Id: 43cffad2-b170-449c-09e3-08dab05aa1ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sqo4uldCXgFs1oi2wYAa5fscYiVrQ3wyR1tbvwYtq6EHYT2ScSJKUrUphIsf086HxYIkqm/olqHb0mjdxGmCUtkXV4NGeG6h+ar6P465wcAcYqmM6oOZKXJXgJqPZwjuVP+B/D4UR8g+AXEah2Nyhwxopa3vAd6TLDubeFNlliN6G4PS2UjeW+PUYadyZMyTGjYrmeCBuJlDcvhg67ot3ao43zxu2Gfrl7PPBR4DYaIA12Va7elRGyABcuQa03ALCL1mLaZlZ//GL9fFyulcvSe3QYKm3uAKmz09/WsCIf926jPu6yi/hhrl+sqwnautyHeCGXuwFwifidUJNjBbmjCCOnpWSWdpqs1WX2Rq2u/dvASRIJuOPD6+6YNos8L1qUgdNRsZtoc24aARQlCRV8XhvnfjNXXWu1bYtNdHp4jE2XYx2JZmN8DMBzY42mrLWST5cw8Cx6L22YppYaajSnGudScYxELm5V1XAlBo3e8uEr/RkwpiSRhgeZM8furtRfkAZ0kS4bdyFA2hIX5wZkLthcWjs5XG6MTOj/9PRPEzZvROplwzzy+9tyQHu7YsG109UFSoyIl14ui1R6jQ88SNb675k968cVwDAKaVC3fHdu9yulEN+wexN5B5PRu8+cixVaH5y+rbyyvn7AkkiXB7A/A0kstSOAYWYf2S6qqNESQ3U6DKGSpbR4liTz2m4bnsp2g0aKmUbRsDZwYeWuYye/heaWT6+HNM5GY8GMIVpG5K2EpzDKrRUTkD/3/AFZ5Y43+KqgjqKtYpko5bOClwULSBlAjH4oglJ88TleV3wv4Jyr44TsDj70rAuGmzhf8jD4gG5H2ueODvfzNe4A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199015)(46966006)(40470700004)(36840700001)(70586007)(70206006)(316002)(54906003)(478600001)(6916009)(8676002)(6666004)(4326008)(8936002)(2906002)(356005)(41300700001)(5660300002)(336012)(7696005)(1076003)(40460700003)(186003)(16526019)(26005)(36756003)(83380400001)(47076005)(81166007)(44832011)(82740400003)(36860700001)(2616005)(82310400005)(86362001)(40480700001)(426003)(36900700001)(16060500005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 16:14:13.1451
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43cffad2-b170-449c-09e3-08dab05aa1ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6779
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, if we encounter unimplemented functions, it is difficult to
tell what caused them just by looking at dmesg and that is compounded by
the fact that it is often hard to reproduce said issues, for instance we
have had reports of this condition being triggered when removing a
secondary display that is setup in mirror mode and is connected using
usb-c. So, to have access to more detailed debugging information, add an
ASSERT() to dal_irq_service_ack() and dal_irq_service_set() that only
triggers when we encounter an unimplemented function.

Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
v2: detail specific instance that I'm interested in and use ASSERT()
    instead of WARN().

v3: move ASSERT()s inside the new if blocks.
---
 .../gpu/drm/amd/display/dc/irq/irq_service.c    | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/irq/irq_service.c b/drivers/gpu/drm/amd/display/dc/irq/irq_service.c
index 7bad39bba86b..d100edaedbbb 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/irq_service.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/irq_service.c
@@ -112,8 +112,15 @@ bool dal_irq_service_set(
 
 	dal_irq_service_ack(irq_service, source);
 
-	if (info->funcs && info->funcs->set)
+	if (info->funcs && info->funcs->set) {
+		if (info->funcs->set == dal_irq_service_dummy_set) {
+			DC_LOG_WARNING("%s: src: %d, st: %d\n", __func__,
+				       source, enable);
+			ASSERT(0);
+		}
+
 		return info->funcs->set(irq_service, info, enable);
+	}
 
 	dal_irq_service_set_generic(irq_service, info, enable);
 
@@ -146,8 +153,14 @@ bool dal_irq_service_ack(
 		return false;
 	}
 
-	if (info->funcs && info->funcs->ack)
+	if (info->funcs && info->funcs->ack) {
+		if (info->funcs->ack == dal_irq_service_dummy_ack) {
+			DC_LOG_WARNING("%s: src: %d\n", __func__, source);
+			ASSERT(0);
+		}
+
 		return info->funcs->ack(irq_service, info);
+	}
 
 	dal_irq_service_ack_generic(irq_service, info);
 
-- 
2.38.0

