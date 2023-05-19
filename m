Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A0E708D1E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 02:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjESA4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 20:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjESA4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 20:56:07 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2063.outbound.protection.outlook.com [40.107.101.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2065CE4D
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:56:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8ZOp+dUHRVXFNpe2TE1b+2/iDJSf22VLR2E5xIk88UhxzBLXMk0cA3iiXcf5+ON0jUR6dPmfxdvZqy/qWxnQHzx3JjH13LDKoVP2soa/CS0ey11yZKnvwksqrGYWRSVDMLomueMPEG7OYgGFirO2JoR2D6H+fAcZoQ+vk3uKnfQlav7Yi6JBFxNQdPSl/pfBTcybhYCRO1rDNW7KyzT+1glzwR3lxQ0MWs86NBZbYb0UlizBbGaMo8AyoYV5WqyI7VMqEw5ZN6cLlvFTJaRrdzWb4CQpDVgHoRcHoH2YEXZvnRaOLTFVPZF5niGu3kO3sE1cZU2assi9zdTMHbJZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sAzvRax9ZO4PmRWi817wjYzFwxMNMYQCmsDk4g2BsW8=;
 b=MtlLsL3+pOGIB4OCv6PXmx7W8EfH02DeHlqsQrCG/FgYzKdx6JKqPanizodfy6cyYxAReZpxWZs6eoboXAff1eglAJrdaOl+UUFSi6wYs5wGdkuywKXC+IgDetLkxpngUfAlcZAcq7qIYF6EqF6Xc1ErjYo5VDlm9Gp+eNL40sGE5mHYywtzmHLGXls3Kb1LUxFR159lK9qgUKi07Iyqtz689jUv28yYwQaZ4WFOfqM7Fj1MWCy/O87i/fp/ggwxuu4TiFT8qR7PUl0akMa3Lzy75TCsU93bIjlO3cbBGw1nwGcC8kJGumF+yDk0Hf4m94T6xJh236WY9QZJWEkmmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAzvRax9ZO4PmRWi817wjYzFwxMNMYQCmsDk4g2BsW8=;
 b=jy7utv4j6GA/+FN1q3jI74gPezUQDig6K+1G+CpkhjpRWmSU796igmLfW3+/OrT/bRpdZfDYJE63i/q9Fb4okSe6qtAA3F8Vx/+8gitHnw52I0eWFGHKXRg6PO3kN33oZx9vfWDO42NtNmK4rlUNcqbZXta0vxTHHrOAdBc1gq0=
Received: from MW4PR04CA0374.namprd04.prod.outlook.com (2603:10b6:303:81::19)
 by DM4PR12MB5311.namprd12.prod.outlook.com (2603:10b6:5:39f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 00:56:04 +0000
Received: from CO1NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::cf) by MW4PR04CA0374.outlook.office365.com
 (2603:10b6:303:81::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19 via Frontend
 Transport; Fri, 19 May 2023 00:56:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT070.mail.protection.outlook.com (10.13.175.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.21 via Frontend Transport; Fri, 19 May 2023 00:56:03 +0000
Received: from titanite-d432host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 18 May 2023 19:56:02 -0500
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC:     <joro@8bytes.org>, <joao.m.martins@oracle.com>,
        <alejandro.j.jimenez@oracle.com>, <boris.ostrovsky@oracle.com>,
        <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
        <vasant.hegde@amd.com>, <kishon.vijayabraham@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 1/5] iommu/amd: Switch amd_iommu_update_ga() to use modify_irte_ga()
Date:   Thu, 18 May 2023 20:55:25 -0400
Message-ID: <20230519005529.28171-2-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230519005529.28171-1-suravee.suthikulpanit@amd.com>
References: <20230519005529.28171-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT070:EE_|DM4PR12MB5311:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f2087f5-3c37-4886-61a8-08db5803d242
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Njc34ouT1EZ5O7QwsHbFBmH8GvYigtVjc9tKlQLHTlAEi/MzhddBamE9X+G3dtmDn7xt66/Zi/S9HZCN8vIgGhx5vXJZZ6AlME8TkRPT6KFZDGhmpNUAmZmXSGlnCJol4JlInozMIeTTM/C3O91gZIUz0k1r+7pCALaerW0TKKWi9jEWzOCJKBtbwRXnd5m5aC+ToUlYpa7AZcbc5DrzsPFOsI2AZsGYmvCYDcskItxYkDhhxH+yjM52QI9r+NQ6OxbS8FgiJ5WMUmRFrbKezWFlaZ8368n++lHx98aIBNxYEvCWXecV2jQ95SCw+AWkrmiBSvsHFG1OrX3SmYyT82J7lIhKuQkqbBFHfzlZOf9IZ8ZtaK9astn7+g9J744wACZcuXsQQah0wldM3BnzbXkT/nb1RKDL7UmjmfmudXKcfGVBXAGPmD/67l7OMce/ar98PTTDg5Xj6wreZ6ceHvv+7XgC1USdsxNG9tWdzqCWCpNWMY2sciwRxeY61dNs9bO4q91RHjs8NkN+w1FpFF+jbJtFwgSN8Pm8snGy0zV+GWgAeh1C842ezjYELc3Gbjp5Whi76+JucQvROng+PT+mKwUyx3NZh5fCdBDafARQF+Kz62trIFyF6oIg3gMp5J4Khh/UHebhL+zrih8Y3CVFG+RfghBnlqFTkQeDZpjsWMMqFOtT33gA9AYU5s2ohd1hR80YwNJu9mtgR85hL0yjx657p9CIXHAzsW0TbyTOj/Gak+TFc2G1lx6OjC9g6dyT7sjE7Owu6uOCPI40JA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(86362001)(36756003)(40480700001)(82310400005)(8676002)(8936002)(26005)(1076003)(2616005)(44832011)(426003)(336012)(2906002)(5660300002)(16526019)(186003)(316002)(54906003)(70586007)(70206006)(110136005)(41300700001)(478600001)(7696005)(6666004)(81166007)(356005)(82740400003)(4326008)(36860700001)(47076005)(83380400001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 00:56:03.7206
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f2087f5-3c37-4886-61a8-08db5803d242
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5311
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

From: Joao Martins <joao.m.martins@oracle.com>

The modify_irte_ga() uses cmpxchg_double() to update the IRTE in one shot,
which is necessary when adding IRTE cache disabling support since
the driver no longer need to flush the IRT for hardware to take effect.

Please note that there is a functional change where the IsRun and
Destination bits of IRTE are now cached in the struct amd_ir_data.entry.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 38 ++++++++++----------------------------
 1 file changed, 10 insertions(+), 28 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index ebb155bfef15..4a3a7346ab21 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3700,44 +3700,26 @@ int amd_iommu_create_irq_domain(struct amd_iommu *iommu)
 
 int amd_iommu_update_ga(int cpu, bool is_run, void *data)
 {
-	unsigned long flags;
-	struct amd_iommu *iommu;
-	struct irq_remap_table *table;
 	struct amd_ir_data *ir_data = (struct amd_ir_data *)data;
-	int devid = ir_data->irq_2_irte.devid;
 	struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
-	struct irte_ga *ref = (struct irte_ga *) ir_data->ref;
 
 	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) ||
-	    !ref || !entry || !entry->lo.fields_vapic.guest_mode)
+	    !entry || !entry->lo.fields_vapic.guest_mode)
 		return 0;
 
-	iommu = ir_data->iommu;
-	if (!iommu)
-		return -ENODEV;
-
-	table = get_irq_table(iommu, devid);
-	if (!table)
+	if (!ir_data->iommu)
 		return -ENODEV;
 
-	raw_spin_lock_irqsave(&table->lock, flags);
-
-	if (ref->lo.fields_vapic.guest_mode) {
-		if (cpu >= 0) {
-			ref->lo.fields_vapic.destination =
-						APICID_TO_IRTE_DEST_LO(cpu);
-			ref->hi.fields.destination =
-						APICID_TO_IRTE_DEST_HI(cpu);
-		}
-		ref->lo.fields_vapic.is_run = is_run;
-		barrier();
+	if (cpu >= 0) {
+		entry->lo.fields_vapic.destination =
+					APICID_TO_IRTE_DEST_LO(cpu);
+		entry->hi.fields.destination =
+					APICID_TO_IRTE_DEST_HI(cpu);
 	}
+	entry->lo.fields_vapic.is_run = is_run;
 
-	raw_spin_unlock_irqrestore(&table->lock, flags);
-
-	iommu_flush_irt(iommu, devid);
-	iommu_completion_wait(iommu);
-	return 0;
+	return modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
+			      ir_data->irq_2_irte.index, entry, ir_data);
 }
 EXPORT_SYMBOL(amd_iommu_update_ga);
 #endif
-- 
2.31.1

