Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC346C29E6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 06:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjCUFfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 01:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjCUFfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 01:35:37 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20609.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::609])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FACC20558;
        Mon, 20 Mar 2023 22:35:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LnNd64PEdw0/VUSbeTlAkY7wj/qsJ7HK84wAgCai49zbH9RPxNh82k0NUxJ07Mkjww3K2SG4q0MDja5OBlZ9J4bAoq+Apv8bB1ANl/ribe0Xv0VMcvlu+Cr72Zrcgp/qfsb2GCtAhipsOsTCkUI71CHMZLmLKvyAVGfJvRlNcCqw4LI4UPc4RO/M9++GY6DcnfRUQufwhcj8S/HWKy/G2yqySwazz6sZyt8q+RO+AAGNrJF1/1fLQHRKKdr4QmepvAaqloDNWZB7ooUZ1AicK09fDkKZtRgTQh0LWWCeY23kTEswxpFe3GQCZZPVubfn7uFevT2PQtfhg+8b9brAag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+32JL4z6VCwxwNdn8N0KRNJgVpYcqDdowZPrraSXbA=;
 b=E63duK7YtOAWpSVRAty/f04VUs7WWqbeoTnJ3JB4kEng9IM5hHshpZ2apDzMPo3W2V66gZip79h+3JjlVRz3cO+rjhyQr75P/U/JF+4JddtDTQcf2R6SiApFQtN2yISKqvIodY1LLa6ybO6xq8l4rscsM0o1Aj8m20Fbn/qcnwqb9p09EcGurVSpXtW6aErGcTGiT4rn720VWAlCaagcAtyFzkSX8wHWZHJZkxRN4mqOuNSmVmzHDwzDrtdNofLHhJiTnZgm+AHYYaaRi0rfnSXSX1zYilP4O70Tg72MRfmDqBwuWDiha9pHaTqkwsVMJDcWqvb0dOBDWKcsAS0Bcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+32JL4z6VCwxwNdn8N0KRNJgVpYcqDdowZPrraSXbA=;
 b=tpzNAONyAxLplI7e52Jn0iV3XHW8pNYpN8fc8In2foJArqivAWJss1yrmAJOfcmN/m3i6/s6yMr9GxHWjFi5jiD5N3VKNXEBWR4kQKQhdaTvmxVCNssVp3FePWEOB6Fu/Y+O/ggqsceYYbWQtzswdCY1Vswi6AUEYON6k1NP9P8=
Received: from DM6PR18CA0031.namprd18.prod.outlook.com (2603:10b6:5:15b::44)
 by BY5PR12MB4052.namprd12.prod.outlook.com (2603:10b6:a03:209::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 05:35:26 +0000
Received: from DS1PEPF0000E648.namprd02.prod.outlook.com
 (2603:10b6:5:15b:cafe::bd) by DM6PR18CA0031.outlook.office365.com
 (2603:10b6:5:15b::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Tue, 21 Mar 2023 05:35:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E648.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Tue, 21 Mar 2023 05:35:25 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Mar
 2023 00:35:15 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Mar
 2023 00:35:14 -0500
Received: from xhdharshah40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 21 Mar 2023 00:35:04 -0500
From:   Harsha Harsha <harsha.harsha@amd.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <michals@xilinx.com>
CC:     <saratcha@xilinx.com>, <git@amd.com>,
        Harsha Harsha <harsha.harsha@amd.com>
Subject: [PATCH V2 0/4] crypto: Add Xilinx ZynqMP RSA driver support
Date:   Tue, 21 Mar 2023 11:04:42 +0530
Message-ID: <20230321053446.4303-1-harsha.harsha@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E648:EE_|BY5PR12MB4052:EE_
X-MS-Office365-Filtering-Correlation-Id: 225338d7-fc90-4223-905d-08db29ce12ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bm7PI79tZLJ/XIYz/gpl/CXWPbIXMZs09nA0bmo32AOTABmgmw2gDj/Bd8NLfR9waVQcuJYqSi0Lw8BUab/MGFKpoNdxRJ2oFq8Q32PXu1h/P3sTf5JTriOts6vCoNCuQocOT8UPoqfpVOzmPC4IgXA+3usJ3mBSBOoQuX/N0hgArTArr4eDePmZvfiQRnuHvButOgbJM8AgQJL+cvtU+UwKVnwxlnyCcychj4Njwdr0+HhSEIoTbzu1ehWOfXPRzhgyb1lM6VkylyoSbM5MuKqO5P+UEKPq31sVaPZ1GK8Gfid0hhU7kDBcYTYfQiOSNdHhpJ1tPfzIWVuU9lLOCieSp80EZvpqzlxyP/JdRYHTrQen90W0LrCw/MwpJjYHj24UptscdIQZD/QCzOPZ2iVkSSoOmLtjISKDadMavW3pKm1FktKH2fGaaAY8RrLkTXhl3nVK9QFsn5gPOUsgLm8O4xmanSUHuzdAynBR6ykTdqKg6eW70Fl13/fpfz7HwaiO7tA2ILnB0ZD3NG99t0FBZ/PVkVk6ORkRzUgzNeSpviRc7EIQRbV/4CNRlivM4ItS40UGzjGZmL3BDUAHVK9yNjahlkJp3pEsI0ZM4aykvjt8vk9tnNGni1TSmYOyfwpbriRee7C6WsDJLG2WZXdHNzWxfre5bduoSjcfKacIP49oqvslhOooQmt6B/5R0sa841s/9Txicv16+olH0CE+vkRsAtpog3pYwM1RlzPFlfNi8i60VE/2RZSQtiBc
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199018)(36840700001)(40470700004)(46966006)(86362001)(356005)(40460700003)(4326008)(36756003)(41300700001)(54906003)(70586007)(316002)(8936002)(4744005)(8676002)(44832011)(70206006)(110136005)(478600001)(5660300002)(82310400005)(426003)(2906002)(36860700001)(83380400001)(82740400003)(6666004)(186003)(26005)(47076005)(1076003)(336012)(81166007)(2616005)(40480700001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 05:35:25.5576
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 225338d7-fc90-4223-905d-08db29ce12ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E648.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4052
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set does the following:
  - Get the SoC family specific data for crypto operation
  - Adds communication layer support for zynqmp_pm_rsa in zynqmp.c
  - Adds Xilinx driver for RSA Algorithm
  - Updates the list of MAINTAINERS

V2 changes:
- Added CRYPTO_ALG_ASYNC flag in .cra_flags

Harsha Harsha (4):
  firmware: xilinx: Get the SoC family specific data for crypto
    operation
  firmware: xilinx: Add ZynqMP RSA API for RSA encrypt/decrypt operation
  crypto: xilinx: Add ZynqMP RSA driver
  MAINTAINERS: Add maintainer for Xilinx ZynqMP RSA driver

 MAINTAINERS                          |   5 +
 drivers/crypto/Kconfig               |  10 +
 drivers/crypto/xilinx/Makefile       |   1 +
 drivers/crypto/xilinx/xilinx-rsa.c   | 490 +++++++++++++++++++++++++++
 drivers/firmware/xilinx/zynqmp.c     | 100 ++++++
 include/linux/firmware/xlnx-zynqmp.h |  42 +++
 6 files changed, 648 insertions(+)
 create mode 100644 drivers/crypto/xilinx/xilinx-rsa.c

-- 
2.36.1

