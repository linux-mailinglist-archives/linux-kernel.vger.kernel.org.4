Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70100602CDC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiJRNZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbiJRNZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:25:05 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26168646C;
        Tue, 18 Oct 2022 06:24:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FqzTLk8NJ5CV8JiXMIECcc/o3yhg/hx4dcuPIi2uURd4GGC78hXb46rFCzJVF1eoQmvZcUUQSEBd1BoS6aOz7Irqel7AkkNES5tbtRngjCFK/tj7DmTwXp0yoK9+o825gwo3jws1uakAYc4I5XNFHMxMhI0iLPUsyOfxq9tOslrjyJkN97GdC1gpV3OBPxVEVuKhwilQ8XZvu/5JvVQE2XUo3iC1zIzIxHVgsO0DJrrDM4SKqIjzB/zRPX6yILP4qKu2oZyWWf4KvTe4YSN6gnPel8LSceBQBP2/f/4/I5oZ/oLTRnZQda78SjjAu1lhszrbivYCKl26dPfI6b52fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ff1xR0YOfwo6pDKZ/aMhaDAK8y4R4QFXmkwuW0YPl/M=;
 b=mNlfuT0ov5nRMI7L+v9uFLEBjZuTPYSUuTTvkT14DYV2g+j+WSlfH6kWtdt91hV3ILo75/QBLSqZmg53v1vnNTS8mm4pRWnLGquyXCZIIFIy9sC9jwUMrj8IJ6TAoNR+i3POTxtW7Q+bENWJ08OTfvnxHI3pNpB5k85yJFeVMTh66TTPkTkXbUrzY1uJRLH568rGXt9UBUZht67KJpUxi2h/nf4teHWAB8cAj0AKo57MTH8LGdbuFf6y0xX2qo/3bITcldXRo2WvUb9jT1fBxYquFiF7iWHBYzIBN2zko0qOgLrjPWywmWAN84XbNUqqH3ceh4rHM7cHTyaFP9G1IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ff1xR0YOfwo6pDKZ/aMhaDAK8y4R4QFXmkwuW0YPl/M=;
 b=PGP/jNuBhuAScFD6/srce4AsXD4YvJTC3zcaooX5hNU9e58DDAt7tkT14K0kjsZ8fnA1/ipCOFBFu2FUGSxrLe7RN6UMDxEAVg357jxSiZzCZeGOgokjpqRDi329tpQdq+d7n7jjjbppd4VmU1AVCzszAl1JiKkx78vxd4YEOfA=
Received: from BN1PR10CA0009.namprd10.prod.outlook.com (2603:10b6:408:e0::14)
 by CH2PR12MB5516.namprd12.prod.outlook.com (2603:10b6:610:6b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Tue, 18 Oct
 2022 13:24:28 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::8e) by BN1PR10CA0009.outlook.office365.com
 (2603:10b6:408:e0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32 via Frontend
 Transport; Tue, 18 Oct 2022 13:24:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Tue, 18 Oct 2022 13:24:27 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 08:24:23 -0500
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
Subject: [PATCH v2 07/12] cxl: Remove dev_is_cxl_root_child() check in devm_cxl_enumerate_ports()
Date:   Tue, 18 Oct 2022 15:23:35 +0200
Message-ID: <20221018132341.76259-8-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT039:EE_|CH2PR12MB5516:EE_
X-MS-Office365-Filtering-Correlation-Id: 10e63684-827a-40d5-ed81-08dab10c1530
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rCCd0zjDacK8EoEH3u2Y0rQvD5Rx1x/witQi2WaZoscWOsw6xgyLhMKcngyDTQkZmi/fkTM5M+lJibieYOLSVAim5uKhi11mU6ZsPexj/CK/rZN0t2KyTjsqO7IvnxjPHcD+7lckmJygmvpWJh/U/0lrTetYgw5L5v31GvMHVTW3Sk7+aPbNnzD8jjrdpQCKT66oBbtlsLUtdo1nMEIktlzU4iNL4wh0uPoILqk8pPvKvHAFYr7hvqWrFyf1f42HTcLrDIlPfXOAJ9YXEoEkeG3g0+DOZMH2XfnbLUHj9NV154kUulphZAATxcxlT24kNl5iTl66MdURhJiZXdU/U10jeTWMQb8M4p6GhL0SZAzb7kaamTFKfRXA1S3CQPsVwco3tXmedTxYIaKZOH38r0zFhfO3nGAoDBc+VSkE5EH6JbCujQFFBT0GQTHcpLkfO4Z0cZ5HPB7aieeYn/hRNwj0Mx+JklnRmLkRQM31IYZBihzJLFo3UEdtif6KDyLYG8HIDcRWCn1NOi4qBsuLlzuCcOMNK3wAYyYjc8xBWXMZghwgF1UTtOIqnJysZA5QdGJm1RINA9+sA/J4a1khE0nNsoYrPrivCDt05hsUF4CBH18JgHCoGElRn8Xk3iIne62LWcFL9Mjd5V1OTxcivT59MpvffsFrtoAbbn30t+7wstxL4g6czR15eK+4E6IaSdDuD2CqBgQMOm8/wgqa5xearJLUHcZvT2SfFj0ITZYOX3YCb1Y2z8Dx3dKy58F3YvzSN2EIKZS8R5Bu7WxTT6E81CssIi2Q09vpnC8jPES1wC3Vx2rGCKBHeV1vdQ21
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199015)(36840700001)(46966006)(40470700004)(2616005)(26005)(6666004)(478600001)(36860700001)(83380400001)(336012)(16526019)(186003)(1076003)(40480700001)(2906002)(5660300002)(7416002)(40460700003)(54906003)(110136005)(316002)(4326008)(8676002)(41300700001)(70206006)(8936002)(82310400005)(70586007)(47076005)(426003)(36756003)(81166007)(356005)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 13:24:27.9285
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10e63684-827a-40d5-ed81-08dab10c1530
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5516
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dev_is_cxl_root_child() check adds complexity to the control flow
of the iterator loop in devm_cxl_enumerate_ports(). This check is
unnecessary and can safely be removed: If the port of a dport_dev is
connected to the cxl root port, the grandparent of dport_dev will be
null. This is checked early in the iterator loop and the function is
left in this case.

Drop this check to ease the control flow in devm_cxl_enumerate_
ports().

This change is a prerequisite of factoring out parts of the loop.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/port.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 0431ed860d8e..9af2d91db9bf 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1395,6 +1395,7 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 				"found already registered port %s:%s\n",
 				dev_name(&port->dev), dev_name(port->uport));
 			rc = cxl_add_ep(dport, &cxlmd->dev);
+			put_device(&port->dev);
 
 			/*
 			 * If the endpoint already exists in the port's list,
@@ -1403,19 +1404,11 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 			 * the parent_port lock as the current port may be being
 			 * reaped.
 			 */
-			if (rc && rc != -EBUSY) {
-				put_device(&port->dev);
+			if (rc && rc != -EBUSY)
 				return rc;
-			}
 
 			/* Any more ports to add between this one and the root? */
-			if (!dev_is_cxl_root_child(&port->dev)) {
-				put_device(&port->dev);
-				continue;
-			}
-
-			put_device(&port->dev);
-			return 0;
+			continue;
 		}
 
 		rc = add_port_attach_ep(cxlmd, uport_dev, dport_dev);
-- 
2.30.2

