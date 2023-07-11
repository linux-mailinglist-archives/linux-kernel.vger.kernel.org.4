Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED58374F10D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbjGKOEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbjGKOEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:04:10 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on20613.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::613])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83599E;
        Tue, 11 Jul 2023 07:04:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QvW6YyEToRwioS7gzXwgEx67G6pT7uRiMXFMP6vrGhk67AZAvAV48elfzLexiS4TQ65oPflGMG7yoyVRZlZuAhYj72XI/6YblmERmRdg+l/qZeyDcKxM/T/gmS736H4bTUkYrROCvydBDl9n3QqXaVK05QM7V4aetGdaWsaYKKRacGMcE1kjffGj0I5+wEQMydSlOHIsasl3eeTDLQafJGRij4tlQfZEuiZSsV7nZh++ZL2HZKT4I5O5ScBNgLpA2xsVxTRXhSHYQ9elc0TJhIEQrCJguGA0hka2dcn0gSILteiTIpmy54ClY2Rh7pTkv6Q7KmAK8oVIZwg9jQ5+3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3LhRzvJcOEI8vmRt7Xpld9wRzlXodS7WT8YmwdNHrc=;
 b=PjphlJMBixH6QOjz/DxyEt9zfRwDfvNTY+uPslZHlAcJjKH2KPtQ8ypcs9vU6blp4JmpS9t1ONNhdCh65zcHyoP49jtg5IYncsrYnGQtwXQe0NOmNSER1c/c8epAZ2PNjURTji7qI3r7h43c+sWi3NLDzpVQdIBuCI1ndohLKt2AK3rgKl+PsE6n/ev98lMk0NLvNYyVBRHRbpeb35sHeo8D7i55DTI21oRDXcnxBGg4ZbO15sIPs/a1+4lZqdCcuA8rlbbz4qP7efI2Ksced2GkkA++mysjoHkSm838NIjeLzeXHmo5RkQR1NVcKoKaM8McjwKpKCzTNyYlWo6SxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3LhRzvJcOEI8vmRt7Xpld9wRzlXodS7WT8YmwdNHrc=;
 b=ZgS6N7TOaJJIgZTBgVdqLscPYza8kQzFsbQCFjqz6KTdlpHbtb55wkILhcw19LUyXU2A/hnJBh1OVeqWVPtnU40rp2AIgcVt90pKkoPZiWkcRYp3bE0CETvn7vwmJ44Hk3LwmeVxX3HX45Vt5fNc8xT33bZ4T7EBlCSVY9C/g6o=
Received: from BN8PR12CA0006.namprd12.prod.outlook.com (2603:10b6:408:60::19)
 by DS0PR12MB7778.namprd12.prod.outlook.com (2603:10b6:8:151::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Tue, 11 Jul
 2023 14:04:04 +0000
Received: from BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::f8) by BN8PR12CA0006.outlook.office365.com
 (2603:10b6:408:60::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30 via Frontend
 Transport; Tue, 11 Jul 2023 14:04:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT062.mail.protection.outlook.com (10.13.177.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.20 via Frontend Transport; Tue, 11 Jul 2023 14:04:03 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 11 Jul
 2023 09:04:02 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH 0/2] can: xilinx_can: Add support for reset
Date:   Tue, 11 Jul 2023 16:03:53 +0200
Message-ID: <cover.1689084227.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=473; i=michal.simek@amd.com; h=from:subject:message-id; bh=UpGZAvGk7X5kDR+J9E5G4WYCox6QV/3iaH6VAi86SU8=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpS1iS4x9bfClAVmqTHIL73edWL3X1v5rhVsoSpGG1f3X gk/1VTSEcvCIMjEICumyCJtc+XM3soZU4QvHpaDmcPKBDKEgYtTACbyewLDguZDdivmSXVIfHdx Mztv2cj8fc6pSwzzEy5NP88iJ8dz/tPU4NklRoWG76VXAgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT062:EE_|DS0PR12MB7778:EE_
X-MS-Office365-Filtering-Correlation-Id: 7426da94-7394-40f4-9020-08db8217af5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OX86xHo9DmF7pYaA2DIE7VjY1FLYyjsvNiMFwGNMpD9nHVVaLnIPVHdBB4cVq4Yv/JcWX+W/BBEybb0Cnjo2WZ3PeOP0VqgSDOxsbuqTRKPRMTNuvd4olNNZ9956RicUitoy9Stux/haAuQ5ZucXywwYueyFSp9GPlPDfPVKn2d55UA4fbA3qI9enzjg3gjJFvDxdC6mCgviurSSzEO+rV0lUlVIhf0mbIcb4CVp16F6gqChuFbt487dvpZD5jfR8NvYBNzOasI8B7I5uwJyJILD1wCaHA2Bcz8uDUXk4zrBI58UmU1Z+eo2e8WpGjj45xK+4pAftU/qioy1wneiEZ3nuzFlVJ9yR3L84GY0E12gXU/5NOOyz2kba4MeJsu/botRSM/YuGQrdtqirOD35Ub3yrKfJ1ti8vM+pMNcbU/X1KgO3KrsVDsIMtp4n2AkfFpcHLbUgqCXB5bjFwAvr551lTtKCkhDBhaoa2WrNIBOff7VT2cYoQjRb/4SysOdYURVdki+MWHcW1NOE2oRFUaKcyevBzb34r6PujizqrO0xDFzGhfFURhWInvm1GJ/769ydF2eOb4Y8m4TcMefSpuglT5er4JOxhtpZBlknRNddS3ncemqPPzAwASlQ8dWdeNqBIQ65xBbiHU8i68yKOEd/yKvj/j+Xme/1oohtCGDqpfdDcMSB2D7tPfUQ6BC6kcjw8p5GvAQOYSf/ULb3fz1fqX1VIuFtUdJwoaacrcKI5CXOdceGH9hNbRgp2eVUX5/G+W3VbU7u0QxdWsmSy9yH1cY7+IDa8UDAvkC1wk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199021)(46966006)(36840700001)(40470700004)(110136005)(478600001)(6666004)(54906003)(36860700001)(26005)(16526019)(336012)(186003)(70586007)(4744005)(2906002)(70206006)(82310400005)(41300700001)(316002)(5660300002)(44832011)(7416002)(4326008)(8676002)(81166007)(82740400003)(8936002)(356005)(40460700003)(86362001)(36756003)(2616005)(47076005)(83380400001)(426003)(40480700001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 14:04:03.9654
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7426da94-7394-40f4-9020-08db8217af5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7778
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

IP core has option reset line which can be wired that's why add support
for optional reset.

Thanks,
Michal


Michal Simek (1):
  dt-bindings: can: xilinx_can: Add reset description

Srinivas Neeli (1):
  can: xilinx_can: Add support for controller reset

 .../bindings/net/can/xilinx,can.yaml          |  3 +++
 drivers/net/can/xilinx_can.c                  | 25 ++++++++++++++++---
 2 files changed, 24 insertions(+), 4 deletions(-)

-- 
2.36.1

