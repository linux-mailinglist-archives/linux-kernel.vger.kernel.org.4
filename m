Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8D37287C6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 21:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbjFHTMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 15:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjFHTMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 15:12:42 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2052.outbound.protection.outlook.com [40.107.95.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5563E2D70;
        Thu,  8 Jun 2023 12:12:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nyxOySKj4bVIjas+4nfH/KjFkphEDBP9V8OmHf56GjYmGyYy07FgWmJ2WCAR26Izu00j1FJ7FOJ1LrI047Evnp6gDltcF9MXNuP66ev15gdSADOchzwFEr/Itnp4mMfgZqa9Ed6P7KFzRxhlYeEQlLd7IjwF+8WgJMQ6oeZDkmw9dHTF1YSG25a8wuNFXIR1gswJpjkhSKYw35AtHDDGIHhy95w/NS1v8ThUHhr9TU7zmbp3IojFy3jsrJJswejnFvJh2PnGbx+ZCIgRCjxL192JPyvkUZXAVDfaNlAZUdxXeKjTmeHCI34zz9NIreYg5405j+zsA0wXv8p2H1RZRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qeEJf23KiqVdi186561Hz4E8bbnNIsDRZyt559ohm8o=;
 b=bbLYTfR9xit16cKNes4xGt34aYltmsWfZDzN1s28ir4r8rkoG6QdFoedpg5Qhby6qc2blY4q5kRbLWJQfJKvyLYUpgsnApmneILQkJi2BHLJkoCmiiayePEEiHKLxAz04dHx1UeGSC2muoPxsmw6U8q2TtZLOvkmxaJOwyekLE55bljbIF7ZD7D0MXc4eRooT4iWRSYlt2bq/eqRger1nyr4bvJ/Fi6uOK87UGsA+p75fAo4VNT1TELcyRpmE6YxZTRGwC5EhhmZ3pchy07KuIkD4qYzKFg9vg6ANG5anpX+4Z5vc0bN+QFAUFSBRVbQc7taQxNHXKpYFxLXDZU13g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qeEJf23KiqVdi186561Hz4E8bbnNIsDRZyt559ohm8o=;
 b=ySTDGEU6pl23N5v6PIWXOm4LSEa+ySntjYVC+uwIG8eaXAKQuyt96fmifPSTNAdWp2Fx62HY1Vtjsp6vIiNDywuIZ8ho34hJH/1/muka3XacogEzj2Mcs7ZQoK0EzAL6hYYe6WWlybsqtRvnP7pgabhjtlJ5YsCU9fX64V6R9SM=
Received: from MW4PR04CA0260.namprd04.prod.outlook.com (2603:10b6:303:88::25)
 by CH3PR12MB8305.namprd12.prod.outlook.com (2603:10b6:610:12e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 19:12:27 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:88:cafe::ca) by MW4PR04CA0260.outlook.office365.com
 (2603:10b6:303:88::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.26 via Frontend
 Transport; Thu, 8 Jun 2023 19:12:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.0 via Frontend Transport; Thu, 8 Jun 2023 19:12:25 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Jun
 2023 14:12:16 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC:     "David S . Miller" <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v4 00/11] Add dynamic boost control support
Date:   Thu, 8 Jun 2023 06:17:46 -0500
Message-ID: <20230608111757.32054-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|CH3PR12MB8305:EE_
X-MS-Office365-Filtering-Correlation-Id: 39199c6c-dea0-4c33-2361-08db68544baa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DKF32ryHJM8ODCpSW5b59tRhK+njOTKbje6DSIqsvkmjTNLiOvk0dxJdIxGMrxNJ8fhnLWm55Hac7p2IoZXXfd3k0g5j22yuYTR7LlkbQ+MPHHTlAp+lTHMZcijp4fr9A1koprFgub9w0Vldk5JLW/qnDvi/RoHtmqsqACC7P2CiaWtSiHC+2+JzkgRbzAYuI7pXBx6VMt2B0QBH13EvhWV/CpvosG0K7QaMJxR8ArGb7LqnMm+C8knYlgX5VpmrfTKLiDdJqcYi/zNUP5cwuk5Q4BfDXGQGquQh78khlSLiBYnwJMaMbTAdNUo6vsiqnvD7Lf52XAviCJTfFV2lxNhPykpmbU5dYHPBzqEmneZiHtFDkxjeRPTYFrU+jN1XbVS39fPvCbYT+eH7Ira4pImJOagdwcHwOqq+uUUyiCD4Oq4ANwt4N+4zkD/hPHMft94C7khCmgJvjJ4JlJlbqE+dudrm3dKj0pgQaJSma6BAI1/iHIKxAkpVm/oWM0yw6RVk137ePiDvuVUwfbUI5JXDuOaxnuguL2L3KNJlfCNOlNPODBTJUl+gLXECNqIIJA8xvJ82cDbOiXt2aDcIK3Qo6TTGLMTWub3TePA6qtwa6uqEIZkOceeFMkMxQP+h5jLxFzA1fEpGHRJF3iOiT2JTbpfxu7Z4qVwMAU9hbwFDRNr4yKfLUaohplVhpbei9/nk3Ear04gmaa3PgwBKhwAHTDPrFRN9ljQRiyvs3nuIibI5qCwG1hQYoMgaxthq5h7V47h71fo+Red/k1Ue/Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199021)(46966006)(40470700004)(36840700001)(2616005)(40480700001)(186003)(54906003)(40460700003)(81166007)(110136005)(478600001)(356005)(8676002)(8936002)(316002)(70206006)(70586007)(4326008)(41300700001)(16526019)(36860700001)(426003)(6666004)(7696005)(83380400001)(1076003)(26005)(82740400003)(336012)(47076005)(44832011)(86362001)(5660300002)(82310400005)(2906002)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 19:12:25.7633
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39199c6c-dea0-4c33-2361-08db68544baa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8305
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

---
v3->v4:
 * Pick up tags
 * Move ioctl calls into a shared library used by python ctypes

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


base-commit: 134e0dc6b73ab7e99464182356a8b3fa4ea3b499
-- 
2.34.1

