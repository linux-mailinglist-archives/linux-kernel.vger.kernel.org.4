Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8BD6B5790
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 02:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjCKB0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 20:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjCKBZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 20:25:36 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7364113E503;
        Fri, 10 Mar 2023 17:25:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cFG8o638EVKryutUU/X2PPNNoNd12TCiiN4A0udKE0IvRCQwreC3umdfKp3yui+KtYhaZke9zPsFv7LAngBUPVexYyDk48YEhctuDJqsQGtYpAjenH2iPPd/acmqpkpJ/jgaFGpr6EfDKxaeNq/QK3dTscs71/o2b90YH2XOsZaw288GYBZrkWXmagDUssDhVSCdBUdhJgUAK0pQmP8ftwjDo/8+TWucizbEtLuCgDGnUJA4Oi/U1HK3HDQ7UkiPBWWtUv76OG4oOMGhsTlniBR7B+MreYuho7K+2wQarTATSvrBRNGJyc0Ze6gS2Omrk3KrNIlz1hYl7BSYhggwxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iq5Z5rEyMVHSqMPDRlDtdhYiBw0b+Xm6ZoMpptwG9Do=;
 b=a0Yq9Yn8GlIwTnYPEPRrwWmFuTFfK6oDoxPwxG6e6WdzEVBxxSfbi+pie6lPajy9K+dHLF4vzvEujQcrEo7/auhxC8Ory7e5zlpK/R7TRdA4rac/zyb82fpB/RWwHjkd8v9EMjJCPLZ83TAZs03F3+uub7FdgbKLiOU4bqYZ7IOe/BfxhVnefYFaDJMfqbRUdiTDMUQXievmF91geximGPV0+yDPAnBpQvVWqssGsTbS8VHoVCQns3BMIK1qzg3Mv2FPHUf9C+wYEVUOb5ca1pb5CZ98DaQqDtYrb4K/bPX+X/mLMlEDBKuiyksGWoVvQkbJynbEQqIXABlZpXljrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iq5Z5rEyMVHSqMPDRlDtdhYiBw0b+Xm6ZoMpptwG9Do=;
 b=Tmtj480AyOK9raBK8ggpubcvNreIxyTm5B9vs+FEebAdwtyghAwQh7uvas6z+EwXIXGTP5uQnHBEHOzmuqjBqHCziLdyRCEQomrKaC2PHchV2cIbavDmoXRbKHLyJvwQsQNlLEqLCULeRFXcmP5SW+FR8o5hgzC57ms7wv0tZ6c=
Received: from DM6PR07CA0113.namprd07.prod.outlook.com (2603:10b6:5:330::16)
 by SA1PR12MB7104.namprd12.prod.outlook.com (2603:10b6:806:29e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.22; Sat, 11 Mar
 2023 01:24:30 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::6e) by DM6PR07CA0113.outlook.office365.com
 (2603:10b6:5:330::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.20 via Frontend
 Transport; Sat, 11 Mar 2023 01:24:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.20 via Frontend Transport; Sat, 11 Mar 2023 01:24:29 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 10 Mar
 2023 19:24:29 -0600
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 10 Mar 2023 19:24:28 -0600
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <michal.simek@amd.com>, <andersson@kernel.org>,
        <mathieu.poirier@linaro.org>, <jaswinder.singh@linaro.org>,
        <ben.levinsky@amd.com>, <shubhrajyoti.datta@amd.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>,
        Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH v5 3/5] mailbox: zynqmp: fix typo in IPI documentation
Date:   Fri, 10 Mar 2023 17:24:06 -0800
Message-ID: <20230311012407.1292118-4-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230311012407.1292118-1-tanmay.shah@amd.com>
References: <20230311012407.1292118-1-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT031:EE_|SA1PR12MB7104:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cc0d1ba-508e-4b2c-6815-08db21cf5cab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n5Pu2J+NT+AYwb/KslL1VXxjHguZ4XjP6OahG6SK/lcffpIFkzREwdR1xGLEDmUt77FBt1WZrmWETgqoQbnN8wMFhaLW2qJAmdmKI1JG1RPUhfmLQL5KwlN1lczscYJ1qIaTCLhapmurFAIFCRj62UyJJYrUe7VNszOdhNyEi35Au57iAP63N1IfHlPMPlNPnAecsY1Fo3kKHZuB5xq/K9ouko8uekIyg4JfDp+T0Tdu/N/+EV0IQp+Z1GPq4TLBel8w1mvuruX2Q3vaXUJ34ROy0I1ARO4/VNUbkYa81QMdvpFQmjaSctpKv5c45UByIM99Yl3ttlYjPxXlVPK9Q+MBlQwPJDb/a67HHJYLpDBsHpIP7S6hls5KFVI4K5VAMTK9C5cBvRg/IyUqiAmcH1cxMyld8WkLe9eF+w2Ycj0ZwXLbDfn8QYi0UPXlXg5hrzW9MGz4IH85JGdsK5O9Ayozii15CygZpzziloIbCLBBQtElFOi+Zav244Lax9sYzYVKsunF8/6Z/63sSSXPngdgeOgEch2Ekr4r9VOR5d5dQ9tmyImtESrtOU9Ff09kddSifyOfXHKtFB4NUHXfmEbsn0qoHoCi8LnFnFz0FXU59c/RhktLzzwbo+1UFbrnjy8W8ijSdGVCfv/Igan40ciGmKwSjbPeL6WLQ99OZIY0rGZazUe45yMZpO1q6UpvugsPpjoy3Ac7nsovEqxaV0zTlr/RxnWJIQeIWccQdMA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199018)(46966006)(40470700004)(36840700001)(186003)(356005)(15650500001)(2906002)(82740400003)(44832011)(2616005)(4744005)(26005)(1076003)(81166007)(5660300002)(8936002)(36860700001)(6666004)(336012)(426003)(47076005)(40460700003)(41300700001)(86362001)(4326008)(8676002)(82310400005)(70206006)(70586007)(40480700001)(478600001)(316002)(36756003)(83380400001)(6636002)(54906003)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2023 01:24:29.8960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cc0d1ba-508e-4b2c-6815-08db21cf5cab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7104
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xilinx IPI message buffers allows 32-byte data transfer.
Fix documentation that says 12 bytes

Fixes: 4981b82ba2ff ("mailbox: ZynqMP IPI mailbox controller")
Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
Acked-by: Michal Simek <michal.simek@amd.com>
---
 include/linux/mailbox/zynqmp-ipi-message.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mailbox/zynqmp-ipi-message.h b/include/linux/mailbox/zynqmp-ipi-message.h
index 35ce84c8ca02..31d8046d945e 100644
--- a/include/linux/mailbox/zynqmp-ipi-message.h
+++ b/include/linux/mailbox/zynqmp-ipi-message.h
@@ -9,7 +9,7 @@
  * @data: message payload
  *
  * This is the structure for data used in mbox_send_message
- * the maximum length of data buffer is fixed to 12 bytes.
+ * the maximum length of data buffer is fixed to 32 bytes.
  * Client is supposed to be aware of this.
  */
 struct zynqmp_ipi_message {
-- 
2.25.1

