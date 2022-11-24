Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4D8637DF5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 18:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiKXRDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 12:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiKXRCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 12:02:51 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1500B2C65C;
        Thu, 24 Nov 2022 09:02:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPYeIYuvPiELxxWzcE1g/Y6Xu9ZAigkqkylx+SJIKkgRSpOBX3DxX+UQ6K/bRh8znCf4Pk73xe6CJxCTreA+DVHSYW9dXQIoeoFkz6mb4f/eABDrrz0rH51VVKrSsInG0r/vK8zjZZKay9y2dt3GDsvPl267BWsc8dcpK6hAUF3IU72X3UC+rCpu6nieTPLG55E1vQwdvXrzuJh018Tk7MaoFgQF/ByLo5pQV5rU4k+q3IWg9u8XeoHlgZ5ICtY7KANIpaXS0OR1pMVsd538gf8Mx38Jk4+D16S/RgUyxm2QCO/Sd6F1RIZLABgk4ZjHFksGyBqF3Yy3TkafNxdv+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vseCKTTFKFB+uzoJQf10x/BUEbwHlz76A+E0w0c6lU0=;
 b=QcInqSVgd8eGe5QMe/7tnOOVNMT+KevqxIWTAtlob+OUv7zv19OEfh8JSJZ2bAatuKQntmPq539fX4ml68qewW2dCxu+CeYOXcrfsTtYHVzWcsykQrPmhgUcxNSa0LHvd+DFVFgRXUNcP7pLGl61oK1Nrgp/Reti0UId3PyVSSd/+2o2SPu/nDegWk1ZUr+LrdQl8OFjnDJ06hqkm+Gnns2bxzDG0u27Dciu4s0TqZmGfYeIRrHsYUGAQSEVSE6RFmHLeDmptutFdHFWE/z78hcY77OoxiHqbhNpnIpvRl+mdnC0xlqcEXDvVjlRvXbWeqIH35uuIzMa8dvczvnjmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vseCKTTFKFB+uzoJQf10x/BUEbwHlz76A+E0w0c6lU0=;
 b=YyZrqqWGdoVmuedMGc3Z3NtDp0+cYTcDj4DGmUOUYKv/gzkiBDot/RqKrSiqt5yscWSs3067WwnMEob5AxhaWVe9Xp3UvlIlTOmVCn72ptnw+jhUxc9kGvv5WXb8n73Zmn5hR2yQNOK3+ZboPYUauc3vuQ9U1BsAP/5UcDbp3C8=
Received: from MW4PR03CA0189.namprd03.prod.outlook.com (2603:10b6:303:b8::14)
 by BY5PR12MB4211.namprd12.prod.outlook.com (2603:10b6:a03:20f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Thu, 24 Nov
 2022 17:02:48 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::ce) by MW4PR03CA0189.outlook.office365.com
 (2603:10b6:303:b8::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19 via Frontend
 Transport; Thu, 24 Nov 2022 17:02:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.18 via Frontend Transport; Thu, 24 Nov 2022 17:02:47 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 24 Nov
 2022 11:02:46 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 24 Nov
 2022 11:02:45 -0600
Received: from iron-maiden.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 24 Nov 2022 11:02:45 -0600
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <corbet@lwn.net>, <lukas.bulwahn@gmail.com>, <ojeda@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <bilbao@vt.edu>, Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH 4/6] docs: Create translations/sp_SP/process/, move submitting-patches.rst
Date:   Thu, 24 Nov 2022 11:02:40 -0600
Message-ID: <20221124170242.1892751-5-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221124170242.1892751-1-carlos.bilbao@amd.com>
References: <20221124170242.1892751-1-carlos.bilbao@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT059:EE_|BY5PR12MB4211:EE_
X-MS-Office365-Filtering-Correlation-Id: 03cdf752-8518-41ee-539c-08dace3db68d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9sz2yR1O23dMbimaT43xPF/FGz4+H4iUbL8qjV1tc80oztm/AcPb0/aUzJY6Kx+V6VNLRrjL7ktYX8A3vNbAxQF1UdfjRxChsoNnOqArNHIhiGYJUkkeBsj9JidNj32nNnyCEqGVgMPVAvawZUNdsTezH94JW6KRpigq5kHe/LnpbBp006ro7t91JCy76/y+EJIkHC/0BsbeAKcbfhFt2fl9QKf1u1QnnjxjP5QPQXGfUHeGaZOLQeKkiOVr1Yvrpvww5QK+SxU7fcLxWdgeJz2HuXmWV+3PHjcH5U8i7BwYMCE92NAaieJoA06dJkmCurezAq8tnxfvY51gQv7+B13T+qqcN0Osx/dBHsIyIFEotZZ+sgxvjv+OGcbb5uGzknZkm7t9g8tX7LD3tg8Dvj57qFsU2uAeUK2yiONCOX62WCo7GgRBbQrK0BTh8JZ6Ow9sk/J59B90ENrLsz/bWs23o6iy5LaDGf2TQwNbCysUs7hAFnWmDJEem4TChgLN2wxUaHLNM9cNWhKpzcJItzh4iGgDuDk+lLIlQT/I7DoIqLoRprSadbT5jVPTYLGIcw/s3JDe528QcKu9zHxr42M/I8zaRJF4D5gtWXLU4kAEXu9Cjcl44tva8r34tnBjsmeQJ8jyYr+BWllh8krNKaM3PHPjPuZQ800sd1gk3ighbJmzO/6lUX0KjXV2SLUrt8mGzTgFOkUyj/iXtgy9sBS2NTu3rjXdBpeoTodxsGU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199015)(36840700001)(40470700004)(46966006)(6666004)(7696005)(40480700001)(316002)(478600001)(26005)(110136005)(54906003)(4326008)(8676002)(70586007)(70206006)(5660300002)(186003)(1076003)(8936002)(426003)(86362001)(336012)(44832011)(47076005)(66574015)(41300700001)(356005)(81166007)(2616005)(2906002)(36860700001)(83380400001)(36756003)(82740400003)(40460700003)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 17:02:47.5357
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03cdf752-8518-41ee-539c-08dace3db68d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4211
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The organization of the Spanish translations should be consistent with the
rest of kernel documentation. Create directory process/ and move
submitting-patches.rst there. Update indexes accordingly.

Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
 Documentation/translations/sp_SP/index.rst          |  3 +--
 Documentation/translations/sp_SP/process/index.rst  | 13 +++++++++++++
 .../sp_SP/{ => process}/submitting-patches.rst      |  2 +-
 3 files changed, 15 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/translations/sp_SP/process/index.rst
 rename Documentation/translations/sp_SP/{ => process}/submitting-patches.rst (99%)

diff --git a/Documentation/translations/sp_SP/index.rst b/Documentation/translations/sp_SP/index.rst
index e20dd6e875e7..791cbef75902 100644
--- a/Documentation/translations/sp_SP/index.rst
+++ b/Documentation/translations/sp_SP/index.rst
@@ -1,4 +1,3 @@
-.. _sp_linux_doc:
 
 =====================
 Traducción al español
@@ -78,4 +77,4 @@ Traducciones al español
    :maxdepth: 1
 
    howto
-   submitting-patches
+   process/index
diff --git a/Documentation/translations/sp_SP/process/index.rst b/Documentation/translations/sp_SP/process/index.rst
new file mode 100644
index 000000000000..ecdf6fa9df0c
--- /dev/null
+++ b/Documentation/translations/sp_SP/process/index.rst
@@ -0,0 +1,13 @@
+.. raw:: latex
+
+	\renewcommand\thesection*
+	\renewcommand\thesubsection*
+
+.. include:: ../disclaimer-sp.rst
+
+.. _sp_process_index:
+
+.. toctree::
+   :maxdepth: 1
+
+   submitting-patches
diff --git a/Documentation/translations/sp_SP/submitting-patches.rst b/Documentation/translations/sp_SP/process/submitting-patches.rst
similarity index 99%
rename from Documentation/translations/sp_SP/submitting-patches.rst
rename to Documentation/translations/sp_SP/process/submitting-patches.rst
index 5473bce87360..bf95ceb5e865 100644
--- a/Documentation/translations/sp_SP/submitting-patches.rst
+++ b/Documentation/translations/sp_SP/process/submitting-patches.rst
@@ -1,4 +1,4 @@
-.. include:: ./disclaimer-sp.rst
+.. include:: ../disclaimer-sp.rst
 
 :Original: :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
 :Translator: Carlos Bilbao <carlos.bilbao@amd.com>
-- 
2.34.1

