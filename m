Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2E77287DD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 21:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236618AbjFHTNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 15:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236602AbjFHTNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 15:13:00 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1531230FB;
        Thu,  8 Jun 2023 12:12:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RiPk2GmgDOBzjHdjRzH3PRQV5xI7/tGU4D5crJUWUH5/gyAyaKklaPhOc/md0q3/G+LgSF6DWDfVqaHcjSZaCa91pwBOmXCQ340XrPTeTWfV6nLDBWzZmQ9m1MvZjEBIavZgnv7S3bDlZFKZZOmqC/OCRb5070VQ7yCj74Ts8ICrGWx1b6Wsckd+AjVgNWl8ziLDe+DHvItpbaCILIUOew6/ETRmv8/8ac3xIq+AvLXXJCPFU7/rlz3WSpDcNB0yZ0Ud3+PIoMzHSepUUGhVShwYinIxU367nNAAUmpFSA5ldpYDBGEcgc5G9pE2J/079NVybaJvMIET7E7imEAIBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a73otbbPyEuAM4HluaeLP7RTDTRMl+tnfUEHKBvkGr0=;
 b=O0q9EQHN5URw5EPfVgy1W3b83bA5vzv3pINOY7zy0V6ElIrWAYVj2itb9yqDqbKcw5oZiRRyECPcHQsZvu6RxvptNHgqf+Ap5LvshortzfPqXXG59BZy6DVxDZWN/aUrWhRopr1+iYLm2jYE8T6zYJc4AXyO4SN7zLjCNRUCA3P68wIP5TqPHumAGWLERk5vd1Sw4zpP9/7lvm/G2LypDFf42kl38yPnG6pTI9EFh0Eo9h17ALvr9oWUccgp5zHmIssbfMluKXW1vAwhS40yQltWAIT4pfxz47mzwnzIVw6J136ZW22C5a/k74pXrLhlXettA/cGvnMvz0VpGWaoDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a73otbbPyEuAM4HluaeLP7RTDTRMl+tnfUEHKBvkGr0=;
 b=U2LzrB5WN/RGGf+iZEfJofIwF8YSEj94hPEr76fd467e1MhSUKcl0a+IuCbHsrbgfUAlLNURj7z1pIZJvtnj5gdRQeu0fX2f+Yadf2+/yfYREQUmdeXgt67zk+M7owD0IM0SRjeJktcb0ghLxL84o4bhcw0kc7BCfXBL8J7JE6Y=
Received: from MW4PR04CA0252.namprd04.prod.outlook.com (2603:10b6:303:88::17)
 by PH7PR12MB6717.namprd12.prod.outlook.com (2603:10b6:510:1b0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Thu, 8 Jun
 2023 19:12:34 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:88:cafe::f2) by MW4PR04CA0252.outlook.office365.com
 (2603:10b6:303:88::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.25 via Frontend
 Transport; Thu, 8 Jun 2023 19:12:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.0 via Frontend Transport; Thu, 8 Jun 2023 19:12:34 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Jun
 2023 14:12:29 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC:     "David S . Miller" <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v4 11/11] crypto: ccp: Add Mario to MAINTAINERS
Date:   Thu, 8 Jun 2023 06:17:57 -0500
Message-ID: <20230608111757.32054-12-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230608111757.32054-1-mario.limonciello@amd.com>
References: <20230608111757.32054-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|PH7PR12MB6717:EE_
X-MS-Office365-Filtering-Correlation-Id: fe523062-cdd1-434f-5c7c-08db68545097
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pEGkCpPRbh3V2CpGR19CaFOFNd13/J5Vk47aV/fh7v8i6TCaO65tY8PMpINjPDNPdiPf4Jxz+FMFX/eGd7ISu3QbOMrboSggiSffd62OVzZaG8MbeonUZAhJHR911EbJiLFoCVEsK7y6j6Ec+VivUFCPh0xNt1K75vkIYPwVN/HJ0gKQluKIDKam+frZzwhR+FG6k97BCi54M4Zi3LLixLMPB6dYU+iB8YbgUGYhzgYYzg19cKYvNnQJcKDRTxsaUnTQqEq0Sq/YHvIe9DXPPQ3+hZN7M5tr+iSiIpNEGE3mPwtGs59lT4aH043yvv0G/mYJUye4qWv5/w4E8fzyQ8d3pU+WPt4T4unUYchQ3i+w+kEtpjJCwNWpFYI2xnozev9MGx435Q8MHcyJ7JpFYYcQPudrT23nHAGIpZEvl5OmJdntou+p1mqFSwawKYt6CqND+/+HN+g0i08huXIf5kQIw6YHvO6RMX+GeG2idHv/7G+n5mYK/ztxve5gRlhLLH0fNl566LI7YMytQ5X70tW7KO/6VnxEWMH/jjQCRxIJQZ3sMPullUxnX41JdzJUNgwqTOWgDztHaH6cV/bJ2l4DXEHZDjRqfKnpGVCruOT09ZAOME7Ia7xIHEHmjFXDB8Q5V+mcN/zpTz4zmYEBwOWE7MqanqqmhKTyeoB5hgJqle9tuTMjOtqssI+Vw7s04A5K+efnmLCXi3lIi5pT+rdui+zNAUl2OZoUJTiDA9On0arQXmphaYqXgmqEToJG1rpA0N9IAuyVFU9CVlzcUw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199021)(46966006)(36840700001)(40470700004)(110136005)(186003)(54906003)(70586007)(70206006)(81166007)(4326008)(356005)(6666004)(82310400005)(336012)(47076005)(426003)(478600001)(83380400001)(36860700001)(82740400003)(7696005)(2616005)(26005)(4744005)(2906002)(1076003)(40460700003)(36756003)(316002)(44832011)(41300700001)(40480700001)(8676002)(86362001)(5660300002)(16526019)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 19:12:34.0289
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe523062-cdd1-434f-5c7c-08db68545097
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6717
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I will maintain the platform access interface and dynamic boost
control support.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v3->v4:
 * Add reference to new tools/crypto/ccp/dbc.c
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f2e19f576fec..709ebc2ebbe2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -988,6 +988,18 @@ S:	Supported
 F:	drivers/crypto/ccp/sev*
 F:	include/uapi/linux/psp-sev.h
 
+AMD CRYPTOGRAPHIC COPROCESSOR (CCP) DRIVER - DBC SUPPORT
+M:	Mario Limonciello <mario.limonciello@amd.com>
+L:	linux-crypto@vger.kernel.org
+S:	Supported
+F:	drivers/crypto/ccp/dbc.c
+F:	drivers/crypto/ccp/dbc.h
+F:	drivers/crypto/ccp/platform-access.c
+F:	drivers/crypto/ccp/platform-access.h
+F:	include/uapi/linux/psp-dbc.h
+F:	tools/crypto/ccp/*.c
+F:	tools/crypto/ccp/*.py
+
 AMD DISPLAY CORE
 M:	Harry Wentland <harry.wentland@amd.com>
 M:	Leo Li <sunpeng.li@amd.com>
-- 
2.34.1

