Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8744B691031
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 19:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjBISQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 13:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjBISQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 13:16:46 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324C868AC4
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 10:16:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Imcd6GhvQYpEU+/dC/FnWA/vP277lYzIwLuyzMpP/EfoYxcE6xTY82oZIy8/WoVDTweelKg7CpklNqnNuu85p/G/eX/0Cv51mKLjEZy/37GqZ70S7WepyeZARQXv2RAsmML6ocUYBGYB3PC5YpnqujZvK64uQkFQhfZk+00CuQUyo0+KPdyTX1mVlf5I3out7UOuZ3Id12LnHHrxrhL6n/FFTyz9HzTJzpNyfhu5+hqrjWsGPcljOCy3LIFMypml33Zlq//Sm4kObJ8eTrQtwfrB1F9C6rUO8KQWv7bXd+7MN6GLeYB8k3TXAwWVuw32+2ty1/LRdSomRa8mFq7Vig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/2lo5vVECPIh2AIUbDWY/g83c8uxNaea9yHO85xlOQ=;
 b=H6IDibootjq6Liw+x5NAef9xjXrpFcPTU6Y7PVRKuOwtrK4qsVXr6WNf7KkBfglPDhHhrw1OYmTVAqWsMbI5f0etmpbOIcUTeAnSPyHfM2tDTToDOOcTo82aJxjjSXosorp2PvuKnqfHdPRqhyQ5FK4/LqXQltuqEAOFhZwwPNJlgELuBzcqpa5im688azqTiItiGYroTc0SHrxbDiSB9QG+Oj1y1lPPt4MlE+pAyc+laogIE3+Y6yOFcGS8OEVu9xERIYUoUpk83TysUkIWoDulInmc7xWwsC+AvD6T/0c/J+TfBuEdBhlpdnARRIF5siHLwdeMZ8vvFK9gAtm1rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nod.at smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/2lo5vVECPIh2AIUbDWY/g83c8uxNaea9yHO85xlOQ=;
 b=Bi58kTJPOwW5/cbURYvPugd3yHTkxMsK7G98k0xigWYh5LsIrAoowe4nwC7puWdFAcffwyZQSH0WDBC/wNJQy0zpGdDuPzw8fZZd5s02I9LpEKtXZmlu/AVWvEJ+9BPRW+QV6L2biryPIbTNrmkWKxXjkGi7H3gblveubICsay0=
Received: from DM6PR03CA0025.namprd03.prod.outlook.com (2603:10b6:5:40::38) by
 PH7PR12MB5949.namprd12.prod.outlook.com (2603:10b6:510:1d8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 18:16:41 +0000
Received: from DS1PEPF0000E634.namprd02.prod.outlook.com
 (2603:10b6:5:40:cafe::31) by DM6PR03CA0025.outlook.office365.com
 (2603:10b6:5:40::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19 via Frontend
 Transport; Thu, 9 Feb 2023 18:16:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E634.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.16 via Frontend Transport; Thu, 9 Feb 2023 18:16:40 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 9 Feb
 2023 12:16:39 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 9 Feb
 2023 12:16:39 -0600
Received: from iron-maiden.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 9 Feb 2023 12:16:39 -0600
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <richard@nod.at>, <anton.ivanov@cambridgegreys.com>,
        <johannes@sipsolutions.net>
CC:     <linux-um@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Carlos Bilbao" <carlos.bilbao@amd.com>
Subject: [PATCH] uml: vector: Remove unused definitions VECTOR_{WRITE,HEADERS}
Date:   Thu, 9 Feb 2023 12:16:38 -0600
Message-ID: <20230209181638.3781977-1-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E634:EE_|PH7PR12MB5949:EE_
X-MS-Office365-Filtering-Correlation-Id: 83c68bc0-fd20-41c7-9d81-08db0ac9ca50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XCKY05P92/AsudHf+4YuTu+E0KhToNi6tzbF6PF2xPUDOQPS0KbmBCPJa1sJt9Nht/8QYanyji1dju/4FJhdKaDI066QrpjUgFZ5Akg7Rw4sMdIrbiHCFNIIMFWDJIgIDCvRVTPgyyd7XP/9oDXyCCIWdhb0ez49sWKCzcclc5QlC1WGwLiNLzE6ug4BqgwrjO1EYmjFmDbaSfv9NxV1teturV53lEM7bmDBaMpJozuXAKV9Nqg7J08Dif4TTE79SJf6vjDuE2HtoTrLlEioCKaj0YadekdpqZA47AIWryLuIhiQbY8j+vbuSatWvBRjvpXRULdbz/SFD5vHKzjLqtsq6u6Bo6BVQrFdaXOfjUC2ZHxuuvigY7o4CB9XZzauBsObFsUR16uLvSJN4CzBSFTvyU/I1+YO98TNb4LzlSA8gER85QvZzK3MNozsGyf9d5/k+nyjHxStkrSuUJfbVuBaSB5h5vawO0rYVej6OIMiXSXgbBQ/0YhYzkv2rARoble13uDJ7VwptX0LP+15tyu4Z4Fohhj6o+Bdg+S70Oy8cDqY2CFIdmyMMNpalAPgzRzoKkXH51yls9p9PEIbOwDhmcmA3hRmEkYrfErU+aYEAVx4jG4I/gKJ05yJhlOEzt+3ablk4QRX3nLKwPWgUJAf7RV8oSnbMfKmmVl02lYl8fRzTVDxDGDA92CP8D9NezwX9DG+26/pEfgDL5bqXAHGvelTNt4gmnS2k1PoBnk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199018)(40470700004)(36840700001)(46966006)(26005)(186003)(2906002)(316002)(4744005)(8936002)(110136005)(1076003)(36860700001)(5660300002)(356005)(54906003)(83380400001)(2616005)(86362001)(82740400003)(47076005)(336012)(36756003)(40460700003)(478600001)(426003)(70206006)(70586007)(82310400005)(44832011)(4326008)(41300700001)(81166007)(40480700001)(7696005)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 18:16:40.1261
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83c68bc0-fd20-41c7-9d81-08db0ac9ca50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E634.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5949
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove definitions of VECTOR_WRITE and VECTOR_HEADERS since no longer used.

Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
 arch/um/drivers/vector_user.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/um/drivers/vector_user.h b/arch/um/drivers/vector_user.h
index 3a73d17a0161..59ed5f9e6e41 100644
--- a/arch/um/drivers/vector_user.h
+++ b/arch/um/drivers/vector_user.h
@@ -68,8 +68,6 @@ struct vector_fds {
 };
 
 #define VECTOR_READ	1
-#define VECTOR_WRITE	(1 < 1)
-#define VECTOR_HEADERS	(1 < 2)
 
 extern struct arglist *uml_parse_vector_ifspec(char *arg);
 
-- 
2.34.1

