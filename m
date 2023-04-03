Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373DE6D4E39
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 18:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbjDCQnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 12:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbjDCQm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 12:42:58 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8D31BEE
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 09:42:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=caj8Z0IK0TVpqieFUvTVFM0vF4BQ4+NVwrx6FZsYZU+X6qq9NIiUd/Y5vu81Mxm82LxietMTZ2XVdcujF8em7iiKYhKNe54pwTtI3/j8S5prUGfHTL72hPMwt2r6fE60Aut1/ISOCxj4CK87++GhPreTbDLqldC+50y35OaSzQ10d5+YVVO/oka+qduEvcT0zCAgmz8gB5Dw1AxuuH8f5RmmmHOwHP0ZzbNJ4c2f22LEccSiPqKiSeEF4YNkRaHxGIuHZkzm8Q6NZaRNssRckg3ElWvOOeHhGmBnZU6crnRZtbaM5MJGrUm10nJo3xQvsEH93GpK37GFhpT+rmdKyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dRELnkK0Fjfmzounsy/XUGWeqGlfwbCOV6lDuEHS8zw=;
 b=X0qwaqleFa8cljtwOvSavm1HGFswO9Ngn0DGyrRgMte9CzPEUvPvmoRoghp+3REEjcvTOj8p8deLOWmzWzueu/7iDzJmibJYc0d8QStf2BBWlp4le6S3zyISW3zkbiO5KUF0D4s2ST4NCbGnw4GAUsOtDB5jzLY5oIh0Xfk9KdHngxWnQ+TNez6rBuoxdpUkSW9ihNAjzQ6ZdQCZPDrdaxA5S4JhVrV0hTGRjKow5LzPnfbSNIfCqJQzeUM/qYiWIvV8MtP/JwuZVuNgKEc421WYOA3Ke8lDP05truKnWkdHbmW5LtvSed6wlqB2pXCCvvd8EpTf70S5k3uZ2+8lcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dRELnkK0Fjfmzounsy/XUGWeqGlfwbCOV6lDuEHS8zw=;
 b=hEARFzHhkK4qvPBDEOpN9Y+TRlYA4nmyOUFKKm9simH+t1hv5dQLskkCATDVgcOVcmnJDopPW+NevRGBx8uWoYAbPdr345WzKOrdT7i3QboLqGe4f5EJfmCxV+2VymCBby9MRmDqiaBl0iy/+wWC9fVIaI3gVYRy8rDgdH3au6A=
Received: from CY5PR19CA0070.namprd19.prod.outlook.com (2603:10b6:930:69::16)
 by DM4PR12MB6205.namprd12.prod.outlook.com (2603:10b6:8:a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 16:42:55 +0000
Received: from CY4PEPF0000C978.namprd02.prod.outlook.com
 (2603:10b6:930:69:cafe::53) by CY5PR19CA0070.outlook.office365.com
 (2603:10b6:930:69::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Mon, 3 Apr 2023 16:42:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C978.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Mon, 3 Apr 2023 16:42:55 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 3 Apr
 2023 11:42:54 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH] x86/amd_nb: Check for invalid SMN reads
Date:   Mon, 3 Apr 2023 16:42:44 +0000
Message-ID: <20230403164244.471141-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C978:EE_|DM4PR12MB6205:EE_
X-MS-Office365-Filtering-Correlation-Id: 07fef346-36ab-4faa-a555-08db346279b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YJxtkQAX0njVSumMo/1qASZZSzw/SahiXJ0fhzfMKGQvm2cWwJfyrA8ycQoAqQdEcbA4p6yQn7zGxDH0/PEmWKjrKZSwBzMZWi8OSTa60T4p++izTj5W2xsvrUH9nnO5J6YTnxMI7DBoeaZcbuUFW60Gyx14L1jJnqa1E8bCfrmwhH4zQ3wNhm1Z/qCsrlOrQL9I5aPaPNolPbV7+AwywB4pIsXVFVd387vwXk9TjmbHZELp+PauR7mEhXGtUSNsY6gL+QaeN9HbCfF5PotQruTqdKdihmAlB3eWJ40wJA6tHsxEuDHBkK/9Ka+kakR3uh/FR8MihsTjJ74eEXEWaJcUBZXJiS/PHldwF7+ooIgqKsv7cvOFwZzZ22ryGlhNBuwqa9kv5kMSOnFhy6Nj3Zdz2SRTAdVWSU87dDRVCll01qXWKnv3WgP7RX178w8BAnzqWZ8mCpAf7bNOPuty2QN0gKeEpwD2H1owI3trVhTDSCeZq/jNMNR1n0YIRtr1y24ddH6g8voI48TJr+wQNZUnHYL3H1S9rcTIZnuALm69IQs25dVD8Vi7qCcma22e4/roNXEaAGEDGlrWEjlMr1K1tzKkkaBR+0o4VprthMB//3+SWg8t5OIWLyMxDuR3DRy+6WfqoMEJWxw0WFNGnuKrj/h5DFEt3uVV4+limHt8PB+TGIMUe0Z9Sc90xgjO7md1H37tzZUf6pVnoLDv/trEg8IALmWdGxa/QCMnqAo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(2906002)(44832011)(336012)(86362001)(426003)(5660300002)(40480700001)(8936002)(8676002)(40460700003)(36756003)(4326008)(6916009)(7696005)(316002)(70206006)(6666004)(70586007)(41300700001)(54906003)(478600001)(16526019)(26005)(81166007)(1076003)(186003)(83380400001)(2616005)(82310400005)(356005)(47076005)(36860700001)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 16:42:55.5375
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07fef346-36ab-4faa-a555-08db346279b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C978.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6205
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD Zen-based systems use a System Management Network (SMN) that
provides access to implementation-specific registers.

SMN accesses are done indirectly through an index/data pair in PCI
config space. The PCI config access may fail and return an error code.
This would prevent the "read" value from being updated.

However, the PCI config access may succeed, but the return value may be
invalid. This is in similar fashion to PCI bad reads, i.e. return all
bits set.

Most systems will return 0 for SMN addresses that are not accessible.
This is in line with AMD convention that unavailable registers are
Read-as-Zero/Writes-Ignored.

However, some systems will return a "PCI Error Response" instead. This
value, along with an error code of 0 from the PCI config access, will
confuse callers of the amd_smn_read() function.

Check for this condition, clear the return value, and set a proper error
code.

Fixes: ddfe43cdc0da ("x86/amd_nb: Add SMN and Indirect Data Fabric access for AMD Fam17h")
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: stable@vger.kernel.org
---
 arch/x86/kernel/amd_nb.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 4266b64631a4..33ebf104a020 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -190,7 +190,14 @@ static int __amd_smn_rw(u16 node, u32 address, u32 *value, bool write)
 
 int amd_smn_read(u16 node, u32 address, u32 *value)
 {
-	return __amd_smn_rw(node, address, value, false);
+	int err = __amd_smn_rw(node, address, value, false);
+
+	if (PCI_POSSIBLE_ERROR(*value)) {
+		err = -ENODEV;
+		*value = 0;
+	}
+
+	return err;
 }
 EXPORT_SYMBOL_GPL(amd_smn_read);
 
-- 
2.34.1

