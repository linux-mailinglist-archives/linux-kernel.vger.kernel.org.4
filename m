Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4DA6A60E0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 22:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjB1VCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 16:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjB1VCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 16:02:36 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216D12312D;
        Tue, 28 Feb 2023 13:02:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itPvrE+lNliuZHsBJCW+UaAe0DlfPXXff68cjTWMIK5syjN0UvIx3nM/rAxTkY9CdPc6eOVcKqoCqJpI8ysjfuKDb1h766euDdn9R3WLr56mkQVIii0nvoEBR5Fiw+svZP9nSKfn7tHCEIEFJduyB4ys8WQw2CIhHDrJ9mbbkaIzJ/z31jnP+lsX9Rm3/aeknkbrmxOEtkl3FpViOD1Gcd7Oyr/1nKgQ8Uhpcd3GZOF3s+LBeyUUkhvtHMdHMzqzFxMS3MGXmLbPNK82dLZbNDTNQjP2+csFu8/KuzudxayM4bKUOmmJodGtz4DVCRn78OI6bSUFq2Kc66TDdYFj8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C7Wl1JYpP6lqT61SfXqmrBexlILLSeSkm6bACCOLW2c=;
 b=DuS80NGbC0hr4doLgm8OuwvgbE32nSF9uFbIXP4/JYooZH2McEaV+jsSTPU07km6ZjtcRjYlMtBXALT30eVLeUWBJwcxCHSRzmMDWUFC+4Jicm1LC63Zq1oi95O4jMDktf8nNvAwtsBqjHoxG9MCJhzUXbov6ayvOAFVvd9OhphvZLhIHYNPOPnjbmRUexX9uwyJXbdO7esCRjueQ9spuVkqcN0UOt7a1P3TZXwIBe6wD+Vmx9AQw81AL6hMbIp4iny1ytmfHVNMh3Q5uy/7CNJJ3x8sOHE9RX2v9wXoG283yA86nSAvMM4PdOjbiTYSfMuKmXyg4eFDr0sWtSdI1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7Wl1JYpP6lqT61SfXqmrBexlILLSeSkm6bACCOLW2c=;
 b=0TBZzOY5Bedz5uJuIfAwWNEOcDRECFhN89LyRkQl0FXnAoGDq53wrfeKISD4sMprP6Yd0dCxR/JPeU9EDxDvqhoxv7XZpwUn/tVl/5ApFv3FKog4GdOaREdQPLj24EQ1DQV8VBho1PjoNcF8StK/ouWrnth0fFXszYlIe97wy/w=
Received: from DM5PR07CA0109.namprd07.prod.outlook.com (2603:10b6:4:ae::38) by
 DS0PR12MB7702.namprd12.prod.outlook.com (2603:10b6:8:130::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.25; Tue, 28 Feb 2023 21:02:27 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::4d) by DM5PR07CA0109.outlook.office365.com
 (2603:10b6:4:ae::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30 via Frontend
 Transport; Tue, 28 Feb 2023 21:02:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.17 via Frontend Transport; Tue, 28 Feb 2023 21:02:27 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Feb
 2023 15:02:24 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Feb
 2023 13:02:23 -0800
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 28 Feb 2023 15:02:23 -0600
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <michal.simek@amd.com>, <andersson@kernel.org>,
        <mathieu.poirier@linaro.org>, <jaswinder.singh@linaro.org>,
        <ben.levinsky@amd.com>, <shubhrajyoti.datta@amd.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>,
        Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH v4 3/5] mailbox: zynqmp: fix typo in IPI documentation
Date:   Tue, 28 Feb 2023 13:02:14 -0800
Message-ID: <20230228210216.447373-4-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230228210216.447373-1-tanmay.shah@amd.com>
References: <20230228210216.447373-1-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT018:EE_|DS0PR12MB7702:EE_
X-MS-Office365-Filtering-Correlation-Id: ce1cbf60-ed00-44b5-3e78-08db19cf1978
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nKgAI4nUn0v9CW3OB5befPynj8BAb+mdHNJ4GdCBI+uWxYeSS5PEG5c7xjRBT7VrK/rN9OCGWHESwKBNeKB3L502jhiUddgJpORnJm9yNoEFnc9C5856fAFi973c8AA+tvXzNhQDz+MT2o5Pntf/eKe8NhIdxpXrlMse5xvOS5ImiK6NJfGdza7lCKewArrujrK81DKs6wAAuQVffW4Yw+4FZFrYZnlVwfqM45CjjHvkxFpc1AQcQ0KB5z3CWygRAOoSo9qnuDJDGFEnDmZ2aQsm1t7fvNx2nLmBbSTIT6Ju4PWEOeNXmmiQNzDSyXuPmFGCOrp/23CNgzvgfRLn9ya9eppGvEgK4ojJR5u6f2O1gSJWiH3LrUOgSeYWO0Hzm3ix1uoH+pYHMTvw/Ffm3aBW6ouKIyX8le9GIddnm0ntEPdHiv77y9Xxcfl8GiJRI2ASeP4x5fuBoCtMqissmzYwn/BUJyFEJH6Wb81/uagUu2/o2Y1+Hkclse7iuIIGa1Oj5Z8djTYjp/ejH7lmP8ah1slAJi12btzuALFhj8JU/9Us2/fHM9EK4GQYxhDNy++/Jp6tr3e7MlfJKuBHd4evUY81N+qGshzg8hHaydHPSgZvoKvzUPi1soq9quIKGH+gvjlBKN1ccMoQDbVBWWnupJzy2jGU9WAx1BUZp3nAARhij9NIXgaHZYdj7qPU7VScRnkpygoafgxXI3hy88e2/kvrxlEqp4U8uM7y/4o=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199018)(40470700004)(46966006)(36840700001)(8676002)(4326008)(70586007)(83380400001)(70206006)(426003)(47076005)(41300700001)(36860700001)(36756003)(316002)(336012)(110136005)(54906003)(8936002)(6636002)(81166007)(82740400003)(5660300002)(2616005)(44832011)(356005)(86362001)(478600001)(26005)(186003)(40460700003)(40480700001)(2906002)(15650500001)(82310400005)(4744005)(1076003)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 21:02:27.8511
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce1cbf60-ed00-44b5-3e78-08db19cf1978
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7702
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xilinx IPI message buffers allows 32-byte data transfer.
Fix documentation that says 12 bytes

Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
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

