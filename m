Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677ED704FAE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 15:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbjEPNoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 09:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbjEPNoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 09:44:14 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::60f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E745A4480;
        Tue, 16 May 2023 06:44:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PofgylACpicavGeHhW+J3shLKh+oNvI0PZnFS5lJ170bZenD3NP0+QukU/DoKxvrHUvnwAvnXHMkYnAE34kyK6b0WJnGhOOM4ISJLj55TG0s8gllK2ZeSr52jYzz9WwI9aCABePj+EpTuR9E/66z2+uIY/+uUR9IaepxoWXAUSMVcE19d6Jue8BIz8p3tEYEnze7vQ4Qt+Pqyh1F8zBxaUxVaS479dffUx0TwALrpLl/eEB+QRntpI7YyLKBD981oWOcHx/zrPrm/whXv4JdLTiLqsXwXx1YhZaYHsYrVDTSbh/8k2oU3N3o94yCtmEQGYc6hc1Vz/7pgGtYLMzjEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rryHag/rmpAwINWli3YL5cIcfkvpSBV7QXNP57KKiW8=;
 b=K8VNMzcSVuxL6P2QrEAzZgNrotu7KdWYZY4SwehB1z6d/T+zFcHTBTh+FJbMD7pKu4MuZXDY3CBopjCY68Oh76gy0yTXlf3QWT7rUBW1H+S4SuJnDBG2/UX3525aQtGEapVATO4JuoPSEPDO/8lvM1UfOe4LrUvpBIutSb1niZ6UaTjNuQnVmhcAC15JKZMJ2BKg9WmzbTPPvXjwlmMa1sunodI3EBoKw8Dc4+MJ9+7Sx24mkL0eQAdvTasS19krn07YGPGU4R6+B8HcbkAK0O3wS17oJiQmV57ygiG6sZ8tZX++0anImYfNNvyNuTfK5L9Dl6kfgTqHUzuOFNrwnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rryHag/rmpAwINWli3YL5cIcfkvpSBV7QXNP57KKiW8=;
 b=5FsAiFI/4TGxr1TYyFyeB49u10CIDpFCP8go3TvMjylJnGFgZO6t859kgvInAItGNTNqN77tHN6lfjAAPCQPMbxrTatODNjqv4EE1hztERi2yhs8DrXvuGFvaw2vUIqJuQWWjXl3jrpVnL341W/Ld0bFPHaBFUFL1iJ+H6k6qiw=
Received: from MW4PR03CA0041.namprd03.prod.outlook.com (2603:10b6:303:8e::16)
 by CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 13:44:09 +0000
Received: from CO1NAM11FT077.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::61) by MW4PR03CA0041.outlook.office365.com
 (2603:10b6:303:8e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33 via Frontend
 Transport; Tue, 16 May 2023 13:44:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT077.mail.protection.outlook.com (10.13.175.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Tue, 16 May 2023 13:44:09 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 16 May
 2023 08:44:03 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH] cpuidle: zynq: Switch Michal Simek's email to new one
Date:   Tue, 16 May 2023 15:43:18 +0200
Message-ID: <b8dea1ca696f1b91e8ec59d53a427016af2ccb07.1684244595.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=699; i=michal.simek@amd.com; h=from:subject:message-id; bh=EKOp4hj4L+YUQX6sdCYpqVEYOalByt85C/Wa2TpQJzU=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpTkjuL3svb3T37h3nxXasLK5hKRja4d1mtr9k1XTApLK DGbNXlmRywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZhI3BqG2exXWJKn3Pv5NX9/ auNGvyn7bjx7uophfrlTkPqSi4GGoUsnqConL7JvnPXBAQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT077:EE_|CYYPR12MB8750:EE_
X-MS-Office365-Filtering-Correlation-Id: cf713f47-7ef0-4e33-de90-08db5613a04e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pEonYpYHu+CL/2MJly0NqrpnekTUsYkbejktltWaELr/Ek/BFNfZPWo5M84TOTgu+1IgAWBnagTRIsaSph77UYxHFpUBNlJth1QQ8dKLKfKwFq2xr9xQbQwraAoMph9irJXUS8LcQvqB3puDPgX6TQCU/Vg7PcaZSEnHlKIVoh3rwib/v+ByjPIda7oiMUyQGecbbfhdlfe0sEC0L9MF7VfnA/1peL5/m8eo1p7qsBsn7jA7w1743aRfVaLQBqzQziuEJJKItbJhfZkQC4xcaSqi4CreBmuk/35RMewAwwe32/7Tm6O/4unso3ibdb2uRp0bJaCtpP8pbVO0qzFJp1HrFAGrvdTyG2MsBrBiZMD7gJiSx74UxObpZ3JaXIdRIG4uf6YMkpvHYbZUfnB7Cf+uJqdOlfEVDBlJ6LV128KAygAncJLl8uKgpWtwfYASm6r5hRks9jP4tOz9R3UZzjdgmUBwC7tqY5l4BViCgmi/SXnBsb/01vhasQNEJpmZpXhkoEB+iQzU+h2L8qXu8J6aQzPkEVf0fhcDH2JVl4TKgWGrPc4ztoFIwScUCEM0fU1g6VVL89pxcquCS4GwZc8yBVQtVLlm8/A1PYBXTJu+D66+kK7z9UKFea8jorBkggRFmhI3h6//kRD2VLR/YOkv3og+94jMIcXrV1EXBbjowlnUFya6tA/NE94hE5cJ/75HJ6T38ApiPWRxmKoclWCVdJuAZPzMKXHNGSWdzDP4EzkqJ8r9Q9OC2D0D2eUPc5tsmxTYoVhKEZGiB0NGIL7w8MN83B7qb7uy+S1zIkw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(336012)(426003)(26005)(36860700001)(478600001)(186003)(16526019)(40480700001)(86362001)(6666004)(47076005)(4326008)(70206006)(70586007)(82740400003)(54906003)(2616005)(83380400001)(110136005)(5660300002)(44832011)(2906002)(40460700003)(41300700001)(81166007)(356005)(316002)(4744005)(82310400005)(8936002)(8676002)(36756003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 13:44:09.5229
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf713f47-7ef0-4e33-de90-08db5613a04e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT077.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8750
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

@xilinx.com is still working but better to switch to new amd.com after
AMD/Xilinx acquisition.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/cpuidle/cpuidle-zynq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-zynq.c b/drivers/cpuidle/cpuidle-zynq.c
index a79610e723b3..89448ae4845c 100644
--- a/drivers/cpuidle/cpuidle-zynq.c
+++ b/drivers/cpuidle/cpuidle-zynq.c
@@ -11,7 +11,7 @@
  * #1 wait-for-interrupt
  * #2 wait-for-interrupt and RAM self refresh
  *
- * Maintainer: Michal Simek <michal.simek@xilinx.com>
+ * Maintainer: Michal Simek <michal.simek@amd.com>
  */
 
 #include <linux/init.h>
-- 
2.36.1

