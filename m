Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A776E9994
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 18:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234159AbjDTQcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 12:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbjDTQcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 12:32:09 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809B310E5;
        Thu, 20 Apr 2023 09:32:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILxVexE3/2lPw2cUFEjpDuvsCXfrDicb76mQ2E4c+IoBpluKmsThETVK04RZe5kAU5isfjwqMMUAFa8z83no7MLKVlJj9TiOPymHZGl5qxkZOrR6nqDWrAMyIeMAyKuzngIi6DhUM5k4xDhqbdy8uUP/54eKVvI3h1f9G36W47JoPNJA3BwZipLPirCGcpsqiPImmUuNREnqFUHXV4vAu4bl9WlzeBH6f81+EpjGJGCVa6No5Ndh3Fgwzmf1JmhYbmFKYu/kL3niVKwy8Vs3K9l3lTQ27S72yP9LdW2U8l2xItH1MlSWnZikr+FgsL02wJW3x/XJbweKWLjrJBvCoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSdKNG7n/RvLaIJKetwyvHt3ewj2rtyK8PLwHwHQODA=;
 b=TiKYg25wLW+s6g66Lfv+qUrw45UGSt4WxBJfTX3JFyw5CGFJQ+BkeLC/8HMZTWcnqAx7WNCUPBiIxtWRq6RxK4Qtnk493AzXJQvRDkhygagK9Ma44y3Az7E5nNFThhlS5Kt1dtC3hTCUVafPzI5PPVFTyj6JyR5HVk+gd5/3lwtgK2LAnWBcOMTbyu+72dsSfx+XapO3SGvo25ATQGcc0vwJVSG5e7qHLyZoEmk6W9ua2X+kfr0ZuqauTbSImNWwXZ5y7x6VOcabF+8I34qHpcRJL1PDeLBSZf8gXQGQqJW4FDmwoIyjMzc69r4LI6FBMvAjOlYzHGC6hdiJp6/q8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSdKNG7n/RvLaIJKetwyvHt3ewj2rtyK8PLwHwHQODA=;
 b=F3+WYXFVKQ4jkCFTS6kRY/O6/gI6nIs5HHnJo1FiA3iy39xgxU4ofGn61mILx5GoOGqqbx4Y+vBeQ5//3D9RQ6WW7Nca3OPjlyA9A2OuOuFuND1F5zDuIggV2vAYvy9mrNgZ8S0eoJ2bnEdB964mXl5XX+qjHSQuBfTxrBxuwVc=
Received: from DS7PR05CA0070.namprd05.prod.outlook.com (2603:10b6:8:57::28) by
 DM4PR12MB5376.namprd12.prod.outlook.com (2603:10b6:5:39f::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.22; Thu, 20 Apr 2023 16:32:05 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::d8) by DS7PR05CA0070.outlook.office365.com
 (2603:10b6:8:57::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.11 via Frontend
 Transport; Thu, 20 Apr 2023 16:32:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.26 via Frontend Transport; Thu, 20 Apr 2023 16:32:03 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 20 Apr
 2023 11:31:57 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        <linux-crypto@vger.kernel.org>
CC:     Tom Lendacky <thomas.lendacky@amd.com>,
        "David S . Miller" <davem@davemloft.net>,
        John Allen <john.allen@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 00/10] Add dynamic boost control support
Date:   Thu, 20 Apr 2023 11:31:28 -0500
Message-ID: <20230420163140.14940-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT016:EE_|DM4PR12MB5376:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d1fca9b-2a05-4765-cfdf-08db41bcc64a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qfCDxCpEy6WtK39Giop4eSdoMQAgQ1bMHKaJGnW2Vz2yfcPkkcuDX57bNsmTNEkgS4J8C3WPnq5QPUduLcnMJIYv8vscMMfB57O2q/JegvJ6Fj+ZO/r6/OBC5tY5Z5pHqJtufqNXwbRpuNPZQcaXlF3V+GE+dmVjXmPJIwPc3OzutjKo6SOHjW/GFGDQ0nmLRuWNOFUW2AKq9kHBvahwcwr7GehbVWmesa0KpIBsY4DxcwBA2+BK67LZhf+iixAKuyjN3sp3RCiOpo4rYEoPKWVeRDcvyJ/i9CzL3shUM/kumpLGD0qh8PbBghnG5RZ+k3tDpu0xAKhxdFCOlNubVt4MFNtt0D4VBKlb8XE1pPrBW5i4rcwj0WVX0cHKKaP3/aBiQNKmjyYE9quIRNpTq0zNAhrYSW66KuiWp9AKxbo/jNLlO2+lAKXO/GXnO7/baAajyaGH8qp9BSiAe2w63VPfnaH/sscQJaBMZR4KlxItxphLCdrPKSDpIn2qEOfuKoSWwzJ/FueKf0SK4HGC7Jp5g62QRF/1k07LpS1Zie2/LlzkPnhRMKN2ytEiahgCPvgJAg9CxlOR9Ejp/SmqYOQqgETRSDbJHAgnfc4u6yPOs088IOarjo7noOGmjJ4vkbRppE2zUJxaadbPjJu4fDNi5u1eJl7cYiYdxeXn+2J9noV21bPAFix5RmbEmHIKYI5DzMG03pwR3PSyvQSxknyzVArFiMPMfL1JNWS/rrM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199021)(46966006)(40470700004)(36840700001)(40480700001)(1076003)(26005)(186003)(16526019)(316002)(82310400005)(8676002)(8936002)(2906002)(44832011)(86362001)(36756003)(5660300002)(478600001)(6666004)(110136005)(54906003)(36860700001)(47076005)(4326008)(40460700003)(83380400001)(41300700001)(2616005)(426003)(336012)(81166007)(82740400003)(356005)(7696005)(70586007)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 16:32:03.8724
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d1fca9b-2a05-4765-cfdf-08db41bcc64a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5376
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
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

Mario Limonciello (10):
  crypto: ccp: Rename macro for security attributes
  crypto: ccp: Add support for displaying PSP firmware versions
  crypto: ccp: Add bootloader and TEE version offsets
  crypto: ccp: move setting PSP master to earlier in the init
  crypto: ccp: Add support for fetching a nonce for dynamic boost
    control
  crypto: ccp: Add support for setting user ID for dynamic boost control
  crypto: ccp: Add support for getting and setting DBC parameters
  crypto: ccp: Add a sample script for Dynamic Boost Control
  crypto: ccp: Add unit tests for dynamic boost control
  crypto: ccp: Add Mario to MAINTAINERS

 Documentation/ABI/testing/sysfs-driver-ccp |  18 ++
 MAINTAINERS                                |  11 +
 drivers/crypto/ccp/Makefile                |   3 +-
 drivers/crypto/ccp/dbc.c                   | 250 +++++++++++++++++++
 drivers/crypto/ccp/dbc.h                   |  56 +++++
 drivers/crypto/ccp/psp-dev.c               |  16 +-
 drivers/crypto/ccp/psp-dev.h               |   1 +
 drivers/crypto/ccp/sp-dev.h                |   7 +
 drivers/crypto/ccp/sp-pci.c                |  90 ++++++-
 include/linux/psp-platform-access.h        |   4 +
 include/uapi/linux/psp-dbc.h               | 147 ++++++++++++
 tools/crypto/ccp/.gitignore                |   1 +
 tools/crypto/ccp/dbc.py                    |  98 ++++++++
 tools/crypto/ccp/dbc_cli.py                | 123 ++++++++++
 tools/crypto/ccp/test_dbc.py               | 266 +++++++++++++++++++++
 15 files changed, 1074 insertions(+), 17 deletions(-)
 create mode 100644 drivers/crypto/ccp/dbc.c
 create mode 100644 drivers/crypto/ccp/dbc.h
 create mode 100644 include/uapi/linux/psp-dbc.h
 create mode 100644 tools/crypto/ccp/.gitignore
 create mode 100644 tools/crypto/ccp/dbc.py
 create mode 100755 tools/crypto/ccp/dbc_cli.py
 create mode 100755 tools/crypto/ccp/test_dbc.py


base-commit: 482c84e906e535072c55395acabd3a58e9443d12
-- 
2.34.1

