Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0E2602CD6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiJRNYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbiJRNYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:24:14 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468BEC90F6;
        Tue, 18 Oct 2022 06:24:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZrIT8Au7mHz0qvqVAt9uqAD2Cen8qmaxCm6NcI8cU9qGijxLOOTCs2OXplI50m4z+WqhRxnW19jq8FgrbCGN99XYrSPwoutzk4SNgh/DCo4ni50dAqmyWQv0rLuqBRtOjef0Pa3kt5uDvKcaPIFoQZC8OWQUKmCiUPc07FDtAbNsVOuWajjUQAwiAkaHdjuw1eRT2ZIMTqa9T6r5eD650jUD94t7vw81SroMrspJO1Y5VwxXz2GsrE3eakvkYsv1Otlo29NUVPo1Od/cdePvNEhxUCIKHaUiH7g1I8kk4UnuJpO5sEFOKpw/6T/UhBrzCBSlUvLZ5y1x6j173j/P/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47+f61TpEsMFiD0B0ONpB5IacOSc5hZ2xFu1rQIZLYA=;
 b=QDVoRboyd2nwcvNeEq4Yu0NGn07/FrWVDoqDrTpE7EYjO5o0mCo5vC5jb3X3jW+/+en5YfCNbRiaWM5zRPBN0r4RG9jeo/UDy4b8AAx9R/2KXuCsHGJG/8oVL+7Dpqmqr3DlMqItjR74M1HPT20q02SkBoUNo0L05Qz/VXiJbrWUVhIsc17pXbR0gMNCqN6zuDjXg/Pg5wiZMlFFJVZo+abvYWzI8LYCRY3y1QrmShQazDWESQKDpKdaUVFhzx/JRncmPafta/bbNrl1YN65q101QXQIxVRCHMg5J8J5uBjsHv9H0KBhQvGKN+nnKo0exvU2+oi5VK/cmU0g7IyAfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47+f61TpEsMFiD0B0ONpB5IacOSc5hZ2xFu1rQIZLYA=;
 b=fwjihMT4m0+pRbjS8TES0P4QVj6WTUyAfGDsJRUlItlJQD+NYw84OuMXxDglTRQF3+q1gWNfM1OUQS/YkS1EoJoAZR5bfbCsUY82sfRytNfj7diPWUvvvzaAIOeTj7tPlyxIYbqmnCM2eJ1oRLYlHThSaorHC5TP9Xaujeck+qA=
Received: from BN7PR06CA0040.namprd06.prod.outlook.com (2603:10b6:408:34::17)
 by CY5PR12MB6407.namprd12.prod.outlook.com (2603:10b6:930:3c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Tue, 18 Oct
 2022 13:24:11 +0000
Received: from BN8NAM11FT098.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::60) by BN7PR06CA0040.outlook.office365.com
 (2603:10b6:408:34::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.31 via Frontend
 Transport; Tue, 18 Oct 2022 13:24:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT098.mail.protection.outlook.com (10.13.177.196) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Tue, 18 Oct 2022 13:24:10 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 08:24:08 -0500
From:   Robert Richter <rrichter@amd.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Robert Richter <rrichter@amd.com>
Subject: [PATCH v2 02/12] cxl/core: Check physical address before mapping it in devm_cxl_iomap_block()
Date:   Tue, 18 Oct 2022 15:23:30 +0200
Message-ID: <20221018132341.76259-3-rrichter@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221018132341.76259-1-rrichter@amd.com>
References: <20221018132341.76259-1-rrichter@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT098:EE_|CY5PR12MB6407:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d7d4f90-a23d-4aa2-f163-08dab10c0af3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bqzvaQFEHaOv71jBntGsTaO8EChuJlLpUVPyofvD9jsMVwV/ZgsQYqiS3QGYm79P1q9FL41c0YjIcyO/Kwh9QUJNYlbeghDDnEbnR2RXi9gBz/iwGD7Q1M8qvNAlPuZhtJI5dFHPngn1AYvnR4FLL3BYQwIH+vLpY0pzABPMUbA7sqmFAVDnz5ck59hZ9/yFlV0FmGgG2F+7/E0t6sk6TvjCewUKTLXGRJ9GPkMymQMu06yqc5MY+abWYUYvMCYV6utrbaBIt3Y5WDDEDoLlpWY7I9hA4wn6R+GrqLqfNcFzJVFl0AdN84/uI15sTxaUBv64LvH9m8HAlEfwtL2x51+GMszQEa0mwFthS4hVz1xPX1UxlBvAGb3QfTc6+dhIiulZtKGuwb38D2rdr7ouC0uI8+AlgYnGdrJcicIys6xgX4YqJnwrBF82LWoIHHfgI6FbsllkkVV38eXrgfMwzX+DzrIOQzBf74637BWrwkf3XnSFRmH8+Fh6E9c4qiaMScWyPgoN+9vxAcf1qZH0yq4MoodGv6Snq18tAV1nW1SlIrJXcblRy+L7b3mDDRDuzb7Uva2Kwz2Uxq8IgaijDkCqjxD6Kx6mQhOtr1SZSghCyCMnzOqngoE+FB6Rv0riDqJXIi601YbUnLe/ktfSvF8f7u0NUWx9Rs1HHGxQIURa/R4ituumpjt3/RGVOEuhdZ9X8MbXd7vXH3y0k783yTqwdl7vz4e1NbNgSW7Xo78itZqWlvqXaJ8PsUEdExw1DOQgXpPxYcUeQbMdMBfZq7t/BJPqRlOmTz0H1N0udq7H8j69csjaXIMuEgvQFte7
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199015)(46966006)(40470700004)(36840700001)(82740400003)(6666004)(41300700001)(110136005)(82310400005)(316002)(26005)(5660300002)(54906003)(8936002)(40460700003)(40480700001)(81166007)(356005)(4326008)(478600001)(36756003)(70586007)(8676002)(83380400001)(7416002)(70206006)(47076005)(186003)(16526019)(1076003)(2616005)(2906002)(336012)(36860700001)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 13:24:10.7360
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d7d4f90-a23d-4aa2-f163-08dab10c0af3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6407
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The physical base address of a CXL range can be invalid and is then
set to CXL_RESOURCE_NONE. In general software shall prevent such
situations, but it is hard to proof this may never happen. E.g. in
add_port_attach_ep() there this the following:

      component_reg_phys = find_component_registers(uport_dev);
      port = devm_cxl_add_port(&parent_port->dev, uport_dev,
              component_reg_phys, parent_dport);

find_component_registers() and subsequent functions (e.g.
cxl_regmap_to_base()) may return CXL_RESOURCE_NONE. But it is written
to port without any further check in cxl_port_alloc():

      port->component_reg_phys = component_reg_phys;

It is then later directly used in devm_cxl_setup_hdm() to map io
ranges with devm_cxl_iomap_block(). Just an example...

Check this condition. Also do not fail silently like an ioremap()
failure, use a WARN_ON_ONCE() for it.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/regs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 6522931df3f7..ec178e69b18f 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -167,6 +167,9 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 	void __iomem *ret_val;
 	struct resource *res;
 
+	if (WARN_ON_ONCE(addr == CXL_RESOURCE_NONE))
+		return NULL;
+
 	res = devm_request_mem_region(dev, addr, length, dev_name(dev));
 	if (!res) {
 		resource_size_t end = addr + length - 1;
-- 
2.30.2

