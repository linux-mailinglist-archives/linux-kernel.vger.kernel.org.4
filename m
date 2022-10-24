Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0A860B0F7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 18:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbiJXQNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 12:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbiJXQIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 12:08:39 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B21A3442;
        Mon, 24 Oct 2022 07:59:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VGuVE/mJooH8IrnmpGzo6QJAn+5GOpknLSgRghSzl/bjmXMaurvCHbQL1b47g5Sxw9gi8LeU+G1Y6jqwy8Uf3Vc+4Mg/zT5oYd90FmFg1sx4hoswUejYgVZHXjygPYpazmZuMoKUzeYyNfgRwNcoiKn1F6WDmEqeY2b3kVQr00XqpycmVDHkkNpW+zwyTLy6uG2XJZKULMd8n/Bd44ei07foZd022MmFNKzHLxOlPp1Lp/J4DsEPHghzuPr/XuLYfwOe338oEERPnQnXjzkpsoTR/WID2Iey/k9p62CJDmoBhdkbMmlfv4PMRC25Mh6G5JoGYvl0Hca8wyIhFneSJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VesB2xX4veSjSHsHKaAEVjrYKKt6Vf6NxhiwSMHnnsA=;
 b=SqKpjtELADMLVhQtES4Dp0d0R6GI0Widdgb+2xIPVelXeL+DqsRHfi9uFbAFWg9KRgZ4D/9ea9ipi0UAqlorTfwGUAgMbhP8/Bh64HnZ0H8iDJqrFMuovoktFyNjOY7K6W2eWw9btmhWMVFnAC6wUDvSH/sw89QacnAef6hBGOzSMwOHb8VeRyVqZZh9fQeE8yuZmjemqqb0BheufTJVjmbZhe8uNXGM1i+7B/jeBEfGxca8t8RdtrTubsqHOM3rNwACyXqT+kRfXPOxSSonZ4fR5nvdGwEs0R81AjqGJFV/T8NGu41rKk/pN+p7ZXNMJS1DFUJ3vUuaNNDgnEwuYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VesB2xX4veSjSHsHKaAEVjrYKKt6Vf6NxhiwSMHnnsA=;
 b=1uKvdEnoIo33q9ScdkuQs/ib804RB7gztrpXXSpBFppAOFBWDJ0uLPll8m+pwLmjzVqC9kMCSEk/QgrvnX3tqRtvkIUq9ankI/CcI/4xKxVn5rh0qWJ3ONNvjsVOoQyr+2ySZG2Rm/67tKsxlSg+5T2X/j7mm47BnFAngun8IOU=
Received: from DM6PR05CA0037.namprd05.prod.outlook.com (2603:10b6:5:335::6) by
 IA1PR12MB7544.namprd12.prod.outlook.com (2603:10b6:208:42c::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.33; Mon, 24 Oct 2022 14:55:23 +0000
Received: from DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::6b) by DM6PR05CA0037.outlook.office365.com
 (2603:10b6:5:335::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.8 via Frontend
 Transport; Mon, 24 Oct 2022 14:55:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT038.mail.protection.outlook.com (10.13.173.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Mon, 24 Oct 2022 14:55:22 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 24 Oct
 2022 09:55:22 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 24 Oct
 2022 09:55:22 -0500
Received: from iron-maiden.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Mon, 24 Oct 2022 09:55:21 -0500
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <corbet@lwn.net>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bilbao@vt.edu>, <bagasdotme@gmail.com>, <willy@infradead.org>,
        <akiyks@gmail.com>, <miguel.ojeda.sandonis@gmail.com>,
        Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH v3 0/2] Documentation: Start Spanish translation and include HOWTO
Date:   Mon, 24 Oct 2022 09:55:19 -0500
Message-ID: <20221024145521.69465-1-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT038:EE_|IA1PR12MB7544:EE_
X-MS-Office365-Filtering-Correlation-Id: b5407909-f4d6-4e4e-0818-08dab5cfc6f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9YB1oaUeCzVJfcadI8t4QDeJm5Vf5F5iH6MXV3S5KO4HwSyG+HXdf0YTENbi3U9ZcC5ZnrcvGbPsr2fm3qZpZdCuK3VrPKcfPPZ043crdw6Gy+5e8pXyxZTcfRZ0cNQGiqw0BMDMZE2d/YfcH1gVvehKl4dewDTcEIfJsMKsm7N8mK2kPrQlji2K1eK5zHRF3Zv6Qi1eWEIW5Hi+O3JeZS40nSYsxV2dMuuBTWcIPt3RS3q2mUjnqXt3BDlW4XZhGcP6Om9w7aHaZeqtaW/Mui6qEeCfOGnlXD29ACfK9mFYmDWsWiJ91z7tiPrJXCvOasZflz8pyfveZ1npV46eN2OR64E2Ia0jSQZIpnqOi8qKAkWkaYbaN9LPOJApvz6aSyfQ0iWc2GOzJIREmW9iQDfVyviEysc2fW7gV/fJ+o2OqIKmr72GeNDVMxbXEfsRPQm/pN7kCDn9In35wsLzRF3Y8ohL+R9kzBQdsMmwn/BH6pI+YVDhu0Ii9USicri/HKL68z/muf0X10y+Km9V4LtAPE2/a2HCmmwrcLh7I151nWqrVdzicqJdoBO8TXbIomqEVgYzYcXGD/ONC7t9//oGJaJ7YaYqLMSyTi09l86hOJX3SE5ugyBuCELKZhSVoTNZRZhJ5nQxgIRnxsaaUAoTCNwISO1sB7arbeOtmrOQWPX/rtiWTWfumuoFQCKW0zYdjix7J8smbCqxIU8Qetr8+zdXJhH5iEPS6RFmxoezzrYXiRu25bVcVVD7rUaYMvo7I+4asRaEU+MhpeEmxLEu1u/oOGtVEcxIzTwVq5xiXJD3AS2wyO3DwF4btNqYC8bgQVJCya2LFlAbVFaCpg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199015)(40470700004)(36840700001)(46966006)(186003)(70206006)(356005)(1076003)(81166007)(47076005)(70586007)(336012)(83380400001)(2616005)(40460700003)(426003)(5660300002)(41300700001)(7696005)(26005)(966005)(86362001)(44832011)(316002)(40480700001)(54906003)(82740400003)(4326008)(8676002)(82310400005)(36756003)(8936002)(478600001)(6916009)(2906002)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 14:55:22.6788
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5407909-f4d6-4e4e-0818-08dab5cfc6f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7544
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Spanish is the second most spoken language in the world. This patch set
starts the process of translating critical kernel documentation into the
Spanish language.

Link to v2: https://lkml.org/lkml/2022/10/13/866
Changes since v2:
  - Apply improvements proposed by Miguel Ojeda
  - Added Reviewed-By of Miguel Ojeda for first commit
  - Added Reviwed-By of Bagas Sanjaya for second commit

Changes since v1:
  - Added me as MAINTAINER
  - Fixed warnings of kernel test robot
  - Use imperative form in second commit
  - Improved minor translation details

Carlos Bilbao (2):
  Documentation: Start translations to Spanish
  Documentation: Add HOWTO Spanish translation into rst based build system

  Documentation/translations/index.rst          |   1 +
  .../translations/sp_SP/disclaimer-sp.rst      |   6 +
  Documentation/translations/sp_SP/howto.rst    | 617 ++++++++++++++++++
  Documentation/translations/sp_SP/index.rst    |  80 +++
  MAINTAINERS                                   |   5 +
  5 files changed, 709 insertions(+)
  create mode 100644 Documentation/translations/sp_SP/disclaimer-sp.rst
  create mode 100644 Documentation/translations/sp_SP/howto.rst
  create mode 100644 Documentation/translations/sp_SP/index.rst
