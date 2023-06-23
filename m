Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A3073BE61
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 20:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbjFWSbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 14:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjFWSbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 14:31:41 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C142724;
        Fri, 23 Jun 2023 11:31:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZRVYperM/cn6Uq9w7Oa+9xIDG6MHgIW/p1LAjAuPbYtChD87tUPP6CeO7XuvUu9IxQl7gnNcxh+UhQ1fnc75MeqBLKh5bVlkQb7qj6ROG9aRMo5Q8VHuNFT5bEbubm72Clp5G14x9GG7CNeVJaCDlEN0biGLr8THFEYRnXYg652DRipeAlMR+pn0h2Ss+lXc62hMJ0xzFJOA4BcnTJGAHcNqFuinTRUpjPLhs9Ls9Q/j/gk7M5SLXiyYs0iazxO/PmhH5mgi+oNa9mdBEcha0hBIGJPraX1QV4oj2EMMzXzMUyQJYU4uhn0lZzxSsfi+PNL+7nK6RW08LT1mDM8/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CnCQ5eRU+tBzNSLH3X5zeQR/hu+kOikkKg877wBHHA=;
 b=EY41/P5HTlwDSO7AA9QqXEhGwKYFa0//koYnQxVUxATO2ZejdsaBDtgMhJPn7cQZ8kLIvOK02RB4WnLRqPzjtjnRPeW9RpeKRW9umzHst0dVFQYSbW+N0/8ORLj9O6VocjgbEcHTSw6LlUQH5NOn44VoTM8qCxsVVgiFx0h6Y9E7EVfH6Fpk8qwls5xlqH22E4T/kKRi0SI8bJe4iuhWLILZgeFoXkVhTW0IYCuKEb1HJ/lCNezic9aZYJngFm/vcy1BPgtMgW0drfMcWnLmmCkWvfadF1kxts0avgbYlHXpWSn/oVCkc2h4XBJ7LPS7tXe0ryVAS3w0drxTS/ML+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CnCQ5eRU+tBzNSLH3X5zeQR/hu+kOikkKg877wBHHA=;
 b=CCHXaK+EJYnr7BSAWK5LyEVbYKwLDgq9AtDDs/XTGRZz2e7F9nsoTjrZbSxd3LkdJaFj1e4Zd/jFOwkLJPcc9b0TRO0DowMJ8mxwF6inhZ6phijil2TAGwl5ONSnYnswrjejytPZQcDG9MlN7t6+o5aK0Rnx7NkZ3lMdIPlThPs=
Received: from BL1P221CA0030.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::21)
 by CH2PR12MB4939.namprd12.prod.outlook.com (2603:10b6:610:61::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 23 Jun
 2023 18:31:33 +0000
Received: from BL02EPF000145B8.namprd05.prod.outlook.com
 (2603:10b6:208:2c5:cafe::fd) by BL1P221CA0030.outlook.office365.com
 (2603:10b6:208:2c5::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26 via Frontend
 Transport; Fri, 23 Jun 2023 18:31:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000145B8.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Fri, 23 Jun 2023 18:31:32 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 23 Jun
 2023 13:31:31 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC:     "David S . Miller" <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v5 00/11] Add dynamic boost control support
Date:   Fri, 23 Jun 2023 08:49:50 -0500
Message-ID: <20230623135001.18672-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145B8:EE_|CH2PR12MB4939:EE_
X-MS-Office365-Filtering-Correlation-Id: ebf25341-c092-466e-7297-08db741811a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OnAW6c1WLWxQkWGZ9tbNjrXUHKb73zD5r8Un41ggn5EoU9RSYPuEKizduukSXnz2de96KfkosR24Znme1JRmJDqp95AB/QaqredfTq1vCSyId902WQU1Dd/JCmyBCqzMuCoGU7ibhZv13sN4BXip2ViBCb28Jeccpvga/c+uW5O03zreGThHeD5Vu48mcvuXv1aT+80yC9zJWeP/Wpy5dVWofrOeU0eeJndcVv2q5WzZipLQD4ozK2FveF+pnQTgFVKW2JT4/kmaCdilOCsoPSmd3V26tfAVYZtU9LSs5/NCo8Cx7nWm9acv2mOYG5F8uEP6x8ird4C6vEV5f7/XYV+IfJfxMG1Zy3BmjT6IVe7zWVbHNiCfoCsvNjhFH37+tNnKwZ+MqGY7wH1IxnOaQHjo5ecJvIdH2qp84h/Ji6OfjUlqg2VsHGPgGcna2W33QT74VCwCqNg7OIcS7901afMtcq6puylSMUqOvZ2pTIYEJQDDP5+Bynl95eSeuVU4d82Zcy1tDvgO3wjuwgcb1kBu2r7wkcS1tLZQovBPmEbLQbcKzP9+DwWg8FiZ0A5Ymai0QWalh7+iIcWVJkcLKWpusWl+qxGxoeeQNzagImgt3WR3psnP2TmT3GVONM+bGFj/3k1niTO7aK5mncZKuFcPGlBV4jWAEkQBlPS+A3J2Sj5rdreXnuhhDq0RghYeHb1k3PSTP4yTzUlKMCgXmqYL++f0KI1W2OPk4X8Gy2BYW0zI0BoHKEzv2kHzcX3+wn5rN11/Pa5Jk3iRS/+Jiw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(81166007)(356005)(40480700001)(40460700003)(82740400003)(336012)(426003)(83380400001)(2616005)(36860700001)(47076005)(316002)(8676002)(6666004)(4326008)(70586007)(7696005)(36756003)(41300700001)(70206006)(8936002)(110136005)(54906003)(2906002)(26005)(186003)(478600001)(1076003)(16526019)(5660300002)(44832011)(82310400005)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 18:31:32.6680
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf25341-c092-466e-7297-08db741811a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145B8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4939
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dynamic boost control is a feature of some SoCs that allows
an authenticated entity to send commands to the security processor
to control certain SOC characteristics with the intention to improve
performance.

This is implemented via a mechanism that a userspace application would
authenticate using a nonce and key exchange over an IOCTL interface.

After authentication is complete an application can exchange signed
messages with the security processor and both ends can validate the
data transmitted.

This series includes a test suite that can be run on real hardware
to ensure that the communication works as expected.  This can also be
used for an application to model the communication path.

Two sysfs files are introduced for reading the PSP bootloader version
as well as TEE version which can be useful data points for debugging
communication problems.

v4->v5:
 * Pick up tags
 * Pick up a static fix
 * Fix a mistake found in dbc_cli

Mario Limonciello (11):
  crypto: ccp: Rename macro for security attributes
  crypto: ccp: Add support for displaying PSP firmware versions
  crypto: ccp: Add bootloader and TEE version offsets
  crypto: ccp: move setting PSP master to earlier in the init
  crypto: ccp: Add support for fetching a nonce for dynamic boost
    control
  crypto: ccp: Add support for setting user ID for dynamic boost control
  crypto: ccp: Add support for getting and setting DBC parameters
  crypto: ccp: Add a sample library for ioctl use
  crypto: ccp: Add a sample python script for Dynamic Boost Control
  crypto: ccp: Add unit tests for dynamic boost control
  crypto: ccp: Add Mario to MAINTAINERS

 Documentation/ABI/testing/sysfs-driver-ccp |  18 ++
 MAINTAINERS                                |  12 +
 drivers/crypto/ccp/Makefile                |   3 +-
 drivers/crypto/ccp/dbc.c                   | 250 +++++++++++++++++++
 drivers/crypto/ccp/dbc.h                   |  56 +++++
 drivers/crypto/ccp/psp-dev.c               |  19 +-
 drivers/crypto/ccp/psp-dev.h               |   1 +
 drivers/crypto/ccp/sp-dev.h                |   7 +
 drivers/crypto/ccp/sp-pci.c                |  96 +++++++-
 include/linux/psp-platform-access.h        |   4 +
 include/uapi/linux/psp-dbc.h               | 147 ++++++++++++
 tools/crypto/ccp/.gitignore                |   1 +
 tools/crypto/ccp/Makefile                  |  13 +
 tools/crypto/ccp/dbc.c                     |  72 ++++++
 tools/crypto/ccp/dbc.py                    |  64 +++++
 tools/crypto/ccp/dbc_cli.py                | 134 +++++++++++
 tools/crypto/ccp/test_dbc.py               | 266 +++++++++++++++++++++
 17 files changed, 1146 insertions(+), 17 deletions(-)
 create mode 100644 drivers/crypto/ccp/dbc.c
 create mode 100644 drivers/crypto/ccp/dbc.h
 create mode 100644 include/uapi/linux/psp-dbc.h
 create mode 100644 tools/crypto/ccp/.gitignore
 create mode 100644 tools/crypto/ccp/Makefile
 create mode 100644 tools/crypto/ccp/dbc.c
 create mode 100644 tools/crypto/ccp/dbc.py
 create mode 100755 tools/crypto/ccp/dbc_cli.py
 create mode 100755 tools/crypto/ccp/test_dbc.py


base-commit: b335f258e8ddafec0e8ae2201ca78d29ed8f85eb
-- 
2.34.1

