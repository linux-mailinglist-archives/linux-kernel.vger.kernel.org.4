Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650A76F1E43
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 20:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346530AbjD1S4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 14:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjD1S4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 14:56:05 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2066.outbound.protection.outlook.com [40.107.102.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1138030E8;
        Fri, 28 Apr 2023 11:56:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HY1A8J98yACHaTM4IvQZQhj4S6vuvq0bUlPqq30xGESzt4a5oL5Jne9HbY59NSO/4eXhPmKfRDj6hG+7Ngg99HRMBcwB3+CRgYlcBmthrNIyUVxTZTBz/2AsVhsZr0T4V4pHQJ88ObTeHh68W10HuoRXKRo/nJzGRrRDTwoStwC23Iai+rFpaW1N+QljqOA3bobJYNSOsdt5tw/7EbMdv0+b/6NRXhbo1KfUJtAUMQ4sB+5fieuVLpRIzkLeiRYOb0bhLyGXsB10nzoBrelov7z+Sdp9nmKx4EhlgM+XI2e0PFl82tehH6QXzSUCZ6/DETNvA4PZNokJilMkTXEUNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WBKXGmx9NuzfV9pc9MUIG6B6C4Pr5rRTWpywlpWgOSE=;
 b=Nza+DRTTAK5o2fd9c9IGJBtcOhbEnEDMktldkp+3XQ3nra6m4yRC4nCT0PfRSooyw4x5JklrkCY708oPBR3JGoleJYJszhbou4AMoufZitdPQ3CA2Wb3I1yTvOCI79Vtj/5rn/Z7aIoCnUyDxccKMi/ZmuG7XHCikA6L5oED2JQDk55lRS+klXfsHj6lyO4QzTU0/XQKhosY3IspHwW40ySYXjaa80iLKtNWbVlk1Z1jYsAyZJRh6vXvSj7cKHZ/8MxyXH+EAU2kO5cf9PQtoUyYysfvqt3q1A/aGPioQ8qZCShCjg5JKNY3o4ektTIe9wETgX/0rFzP3Pukd1fO9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBKXGmx9NuzfV9pc9MUIG6B6C4Pr5rRTWpywlpWgOSE=;
 b=5TQd0II3wV4tbNeQXA5zPOdNZvY2iWBk+c0L6CW5OYlW5MMJvKwJlH6AFxYyKGXXxsDeB8nh8YYsk3j31kTjqByaao6kWyquVyNaSYs9UTNULYwvkV0SdH/lFsmkDYG5Z68J8tPcG08Ri3oDwPhfMAS9lXFJ+ezZxDKO813oKLw=
Received: from DM6PR02CA0120.namprd02.prod.outlook.com (2603:10b6:5:1b4::22)
 by PH0PR12MB5465.namprd12.prod.outlook.com (2603:10b6:510:ec::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Fri, 28 Apr
 2023 18:56:00 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::20) by DM6PR02CA0120.outlook.office365.com
 (2603:10b6:5:1b4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.24 via Frontend
 Transport; Fri, 28 Apr 2023 18:55:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.24 via Frontend Transport; Fri, 28 Apr 2023 18:55:58 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 28 Apr
 2023 13:55:57 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        <linux-crypto@vger.kernel.org>
CC:     David S Miller <davem@davemloft.net>,
        John Allen <john.allen@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 00/10]  Add dynamic boost control support
Date:   Fri, 28 Apr 2023 13:55:30 -0500
Message-ID: <20230428185543.8381-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT042:EE_|PH0PR12MB5465:EE_
X-MS-Office365-Filtering-Correlation-Id: 9518ab27-82f9-47c5-beab-08db481a346a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZLxM3zIBDK0TLyN5TPjRto+jW3iagBtcmxy6HMC4L087Bya+oIOBFxeEat3IinlupMyQ9rk/X7l1RX7ON+6MJbCVXzfXEtnFGs5DWPFDX/Tz0moHNYjlmUZbxzFc7jKVsLyqwIuBnujy1l3P2F3tuLuKpWEfwWVMtVnroPprOUjVNwYT8uOhwYPayl0L6pMCHCnF9fJ1LD5DdX7SHpxBv2/1Dow60kxOqnOwO35Lrl0O3Q7kQUriQJtO4wn4uU0yvffDbxj2St4l+qaSzboMsUimAvxoQ5t7nTvrABVymAwc45ewweZg3FChtI0Lddc2bZQP+IpFGCz2qre8ED26DItylstpyuMqFAIN8FY0FLS7lDg8BpHiply3miW49skd2Xes/OiNpxZD2yjX76v9iVhFBN8POGL1Itypuh8UPx973Okqi9rDdGwlo4g9t2VMD4/mk1Z3fxkLdECeISgnmbkW/kHTCJA/w4g0ODsOuhMKEtgfblOwg9rndqsf9HWSW9L7q7Lw33+LvswtVIIKNq+NCVQk2YvmhhH/yQsHB2xB6+sG3kDYC3+Le2w1TtFoH0qWAvci8ych29rmp/XN6ckIK5gLIbavLmJqk2BWIzk/cVYkIxwmp0dQb6cDk9ZauIjueWxArj8CcOxnMy/P2cFJurM2305eLBNczCNBd6ZUJPpqQbcxikYHMe4T5y0h1myEJwC88ueTfmncq+ZRBZ8ZACz6F1SkpGS0VXBxu9M=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(36756003)(16526019)(316002)(110136005)(4326008)(70586007)(70206006)(54906003)(7696005)(41300700001)(82310400005)(6666004)(86362001)(8676002)(478600001)(40480700001)(5660300002)(8936002)(82740400003)(2906002)(44832011)(356005)(336012)(40460700003)(426003)(81166007)(1076003)(2616005)(26005)(36860700001)(186003)(83380400001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 18:55:58.8036
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9518ab27-82f9-47c5-beab-08db481a346a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5465
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
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

This mechanism and key exchange process also reflects how the interface
works on other operating systems as well.

This series includes a test suite that can be run on real hardware
to ensure that the communication works as expected.  This can also be
used for an application to model the communication path.

Two sysfs files are introduced for reading the PSP bootloader version
as well as TEE version which can be useful data points for debugging
communication problems.

v1->v2:
 * Commit message changes
 * Minor changes for sysfs file commenting and mask handling

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
 drivers/crypto/ccp/sp-pci.c                |  96 +++++++-
 include/linux/psp-platform-access.h        |   4 +
 include/uapi/linux/psp-dbc.h               | 147 ++++++++++++
 tools/crypto/ccp/.gitignore                |   1 +
 tools/crypto/ccp/dbc.py                    |  98 ++++++++
 tools/crypto/ccp/dbc_cli.py                | 123 ++++++++++
 tools/crypto/ccp/test_dbc.py               | 266 +++++++++++++++++++++
 15 files changed, 1080 insertions(+), 17 deletions(-)
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

