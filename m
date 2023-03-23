Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155FC6C7269
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 22:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbjCWVjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 17:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjCWVjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 17:39:06 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A1726B8;
        Thu, 23 Mar 2023 14:38:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XhE9NLMw3MgZpy8eBH1KdBAepX7oP7olo7D6O03X/pZe/7e0bHJ6TpTKRSLRaeWsK+af4tIOFqRVcQLyAWwpm3qMTpYqH/net4A1VTAcHT6TLBt4pbKpcNCls/h3m1U5UVAYRNhe9ilVt9NtBSJEgOomGCR0tNHMMezOen/fdtyIi+TqnF18QIQ5n+RuX91V9Vj8o+FKMKWJza5IUO7s2Sa3Nw9j2wycwO/8sTQhWFeSsxhVf0rriFM3DL3ACOIahtc/vbRk0AV7nJ8FsMTLEKGFF9L1qJBYjhc9Vke4+cYkWww4YxJ8JfpVGtD9Vs43SL3BqzkMzvxkzVhVExG5dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07J6IZKFhviOEMH2B3UgawtEh/IZiwn+zz+5sk0vlFQ=;
 b=Ok78CyEVZX6WsiIsBFDQcQGpx/9qRkB10CFAFi5FJMWLgFHIMKqJ/ZJqpJ/RvgRmPBBzLFim5W4aHftJgFmMu4R6NRsRI9VBlK87wAioujAUIjlkjpHcsbe/dTnZ76p/u4+lIpkvRziZDnJOpVPhgJVaDn6VtY1u/tQKa/xM91qcIurK1VgNntNu6Ec69+1MxZW7L+Qnm8Q4/KgWrNQfMDIscBP0D6JxKGyVR+HjOvKAMzCgKMG2CtXqo6bZ6FuGURFWQfF7wHCyDS2iBMW1Nsplxy6YMzQ1q3DAXLCO2jZY12LsFm86nwySO1WIdtVk2P4qBFkAlY7RZCzDj3QMqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07J6IZKFhviOEMH2B3UgawtEh/IZiwn+zz+5sk0vlFQ=;
 b=YXO2ZlzthoNNqPDKWH7gnDahMdNCbv2MEG/Z8+iHJkbHq6dbdfDaUEMAf9C3tDVUzRoes5WVGeYi2CCIhhWjUsPyQipCmEGGTGzASToy750IQXAgqUzSgC/jx5RjM/BD0TLPaIuljSAqAF5x6et+N0kN8Qsb+bpjQUx6c1jtMPg=
Received: from DS7PR03CA0032.namprd03.prod.outlook.com (2603:10b6:5:3b5::7) by
 PH7PR12MB8054.namprd12.prod.outlook.com (2603:10b6:510:27f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 21:38:48 +0000
Received: from DM6NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b5:cafe::8d) by DS7PR03CA0032.outlook.office365.com
 (2603:10b6:5:3b5::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Thu, 23 Mar 2023 21:38:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT078.mail.protection.outlook.com (10.13.173.183) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.21 via Frontend Transport; Thu, 23 Mar 2023 21:38:48 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 23 Mar
 2023 16:38:47 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>, <rrichter@amd.com>
CC:     <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v2 3/5] pci/aer: Export cper_print_aer() for CXL driver logging
Date:   Thu, 23 Mar 2023 16:38:06 -0500
Message-ID: <20230323213808.398039-4-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230323213808.398039-1-terry.bowman@amd.com>
References: <20230323213808.398039-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT078:EE_|PH7PR12MB8054:EE_
X-MS-Office365-Filtering-Correlation-Id: 39a495ed-7ef4-4e03-8a98-08db2be6fc80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QlCq3QwaTQzlgyGwXtSlQDYuevD/zK15CBkT6osL2wT1HnLbQugx+pAIZjBQOOMof90Y1ilmTimeY/ekIgIRQ1R99LoYrOFujrZdcNpDO/cyiaxwzKKcolLXVnJkDDm/CNdtTcPTicjld3RmYIKmX+potINNFQMqCMErvDC/3wFAK5ba+szOPy4fC+xv/1rbDtYwaJZlNN3xXtBbM0WvxI1t9yJLTW4acFIJ84hwNYO50vO/zeUnFQ/MfTCiql4m572NeB5uPVXuiYZe0Lx8fn3LGq6+rPU6umebOapxJeS7+M6rTNdM++VJ/j8EvMGJrwOCCxcBEAwptTGSrZeMO2kkUYWb0wmkxg2ZR4XYy/l6ezm76XGIOUoO6cOEKzwLxhS/u4LeJbL8WUqxnODdHYoFbdFSDVWONNrvYpUWrj+Y3qzC797kTmPm2Gs4XKAvqpQQipVThXV+kR1rZgivl79haA/l1Y64EEYJQqJ070PFXlOOszOe/ky95NyeqJlCXnkCEH9b9MgpnJvcbItzo4eW1/PuNTvDJRUAtub5q4aJfNFpUdk7IVBKvRBK51SROiI/RQHvtgkqgImzO5Rt3gmku2AphJl4fnzRvqROVXjB7Z2SY0kUFxPlWjUH/MVC9jPcfdFbhAmc+aII0LQ6xH9xbsvoUTKCCS2BIE0nksOqw4mxiuMZY/Cq8/5zJ8FcuGd47r34kVTTNr6WoU10YtIcbuIbpM3jfY9US/ViBSRFT1dOVp9cxwLGukutbeM0
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199018)(40470700004)(36840700001)(46966006)(478600001)(40460700003)(70586007)(8676002)(4326008)(4744005)(36860700001)(110136005)(70206006)(6636002)(81166007)(7416002)(41300700001)(5660300002)(44832011)(82740400003)(426003)(8936002)(26005)(6666004)(47076005)(1076003)(2616005)(336012)(316002)(16526019)(186003)(7696005)(54906003)(86362001)(82310400005)(36756003)(40480700001)(921005)(356005)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 21:38:48.1187
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a495ed-7ef4-4e03-8a98-08db2be6fc80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8054
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CXL driver plans to use cper_print_aer() for restricted CXL host
(RCH) logging. cper_print_aer() is not exported and as a result is not
available to the CXL driver or other loadable modules. Export
cper_print_aer() making it available to CXL and other loadable modules.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Cc: "Oliver O'Halloran" <oohall@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/pcie/aer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 625f7b2cafe4..7f0f52d094a4 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -809,6 +809,7 @@ void cper_print_aer(struct pci_dev *dev, int aer_severity,
 	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
 			aer_severity, tlp_header_valid, &aer->header_log);
 }
+EXPORT_SYMBOL_GPL(cper_print_aer);
 #endif
 
 /**
-- 
2.34.1

