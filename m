Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C361174EDCF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjGKMNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjGKMNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:13:14 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCD010C0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:13:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AxTWwatRlKnd/HK0XWzvHGPwjPzjxprbmwaBAc+s5NpP1jsVG+WYQIXRmGyMXPfVsAWszTZQr9s0nr5Mjeci++/xx+uXmOw4Er5IlNJ7WCbgFPx9FyZObjQK8IRHixZgx7G+gomPFHu09hoLFDmggs4HIRHQFyFQrH+2muZjre3up/MGc2c0eABz332zsyCVWBnrMIbX2QvhwYAKsPLNhpCviUmdX/0WsiKRbTREWVyX78dJp8aIpU38amdute9EPS3ElVpZXuPqMBYhvRWLC9KCW/1HxFZ0O5N0u0uxSxh4gBofOSGDZTe+jC5hYjmFGC543Nz4clyTsKFG72DBKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8CPtBG9GJ4LplObeV79/T2NizvYvgmRVZjEhf7cA/YI=;
 b=XoR4SEAeiNuawhwFeYQ5z9BzDekUvsCXj/QmeXuF4jzWOLusDprBHf2uZ4FfOxfzShFs7u4TOX1120lPn1eI6DJOwLpW5w6WiPdN2fe79ZzOZFBskfsHRY8KL2gJvqMEQb3Pb48eyKKPn3mCcXLOLdabuggp+pMYGqJcDUElXW4FvBpIA+WkXW8to3/bQM1Qm0fXOk6atOcnaZulKUdxA5TCqljQ++hhs71w3F7AW+E9iJD54eNSlz2SqIaERpLT3dQFMYoxRRhzGw4xW/lMUNpEbj/g1vzcI+x/lBH6NMrul3EmKK7A7f+sMevOlC+9RDwt4e6t6YNL8uL3fAo0bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8CPtBG9GJ4LplObeV79/T2NizvYvgmRVZjEhf7cA/YI=;
 b=kvwCSn5raXX3VgdIR/XLcmu8LqdnmJqaslqc2OPDB/fVkPRMpYn632nccNg58IKX9taxxFm0/lIoqN2OyvJvwzYUmB65OSlTLcctSmYtAK4ZYVF7bl8JigBo9MZEmH1HLho9pFhBNEBCcD66ygZzXwSfJB/R6MTUONZv0ZvN7zM=
Received: from MW4P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::11)
 by PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Tue, 11 Jul
 2023 12:13:09 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::bb) by MW4P220CA0006.outlook.office365.com
 (2603:10b6:303:115::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31 via Frontend
 Transport; Tue, 11 Jul 2023 12:13:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.20 via Frontend Transport; Tue, 11 Jul 2023 12:13:08 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 11 Jul
 2023 07:13:05 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 11 Jul
 2023 07:13:04 -0500
Received: from xhdipdslab59.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Tue, 11 Jul 2023 07:12:57 -0500
From:   Abhijit Gangurde <abhijit.gangurde@amd.com>
To:     <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>
CC:     <Nipun.Gupta@amd.com>, <nikhil.agarwal@amd.com>,
        <puneet.gupta@amd.com>, <git@amd.com>, <michal.simek@amd.com>,
        Abhijit Gangurde <abhijit.gangurde@amd.com>,
        Nipun Gupta <nipun.gupta@amd.com>,
        "Pieter Jansen van Vuuren" <pieter.jansen-van-vuuren@amd.com>
Subject: [PATCH 2/4] cdx: add sysfs for reset_all
Date:   Tue, 11 Jul 2023 17:40:25 +0530
Message-ID: <20230711121027.936487-3-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230711121027.936487-1-abhijit.gangurde@amd.com>
References: <20230711121027.936487-1-abhijit.gangurde@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT052:EE_|PH7PR12MB6588:EE_
X-MS-Office365-Filtering-Correlation-Id: f7bf16de-4fc4-49fd-8fae-08db82083093
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YXMNnpPYNiZoIFmyrHw5hhCHlslz2WCHuW/DN+kAg8FktewhAlzhVDssT+FVM3UuZP7poZlOprq6Q198HtmZe2uAPaqcHcyNdgRlNsmKjxlxFfTjRslWLAOoblPcwAuG3Q73AixaZlw+FUJvHcLZg1p9E3TAYajOZQf/Hx4izdql5ABTjb3yaBa+KqN0/VOHZ3m2BROW7JZxLOnhe0CqK9k9BrtWOPxtyJ6IGz06dkJP43NrJ0ORZH/jthE+iPU+3Wn0fnx1IjQT66aWC08GHSZwXF6oA84rTJ5nnQisNN/lojVu4HmXLbP7fMgBtGWvvKfT/CbyKMY3/vrenjSvoEvo5nIqH9BDF411kNoOP5LWqF1/taaz5j5KnLKAFeHbzONjaRLIuu8VgNgjL1ldxZ4RSQplE+leh6J1465ME9lcf/hjyX5HWLAmSKOIszaqPIW1bPJQ/hTiyltYbg94iqDaLPFYkbTKWIpuB9PDtuLl+fiKt5IafOxzW9tUhHXcsMyGyuYwwfhmknCdELIMNf9Y58eorxbpwOBl2qXwCQ0BMejkMytf5Bi0fqjeQxxf8zSROpCPyqCOeinw73gPVoYwzu0T6w/gFJWvDfE9LxVZXy6QbzxkgGlqjsP1HQ1Rx2laEuv+m/Up+Lc+CtcuVG8Po2TtVdKnFSXHWlHK6gslYODZq15K22fmfLqSFSB5ztNpwd7LPeCheQ3wNJqjTrJdJ2rIqEuyZDAsC5DQgxZ2TjrfC18AK4Y15IYnH9neEN5P31QqQBivuVTadr5l1w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199021)(40470700004)(46966006)(36840700001)(82310400005)(86362001)(82740400003)(40460700003)(40480700001)(36756003)(6666004)(110136005)(54906003)(70586007)(70206006)(81166007)(356005)(36860700001)(1076003)(26005)(186003)(2616005)(478600001)(426003)(316002)(5660300002)(2906002)(8936002)(8676002)(336012)(4326008)(44832011)(41300700001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 12:13:08.7664
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7bf16de-4fc4-49fd-8fae-08db82083093
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6588
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sysfs for reset_all entry which resets all the
devices on the CDX bus.

Co-developed-by: Puneet Gupta <puneet.gupta@amd.com>
Signed-off-by: Puneet Gupta <puneet.gupta@amd.com>
Co-developed-by: Nipun Gupta <nipun.gupta@amd.com>
Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Tested-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
---
 Documentation/ABI/testing/sysfs-bus-cdx | 11 ++++++++++
 drivers/cdx/cdx.c                       | 29 +++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cdx b/Documentation/ABI/testing/sysfs-bus-cdx
index 0afa85b3c63b..d9e00058471d 100644
--- a/Documentation/ABI/testing/sysfs-bus-cdx
+++ b/Documentation/ABI/testing/sysfs-bus-cdx
@@ -22,6 +22,17 @@ Description:
 
 		  # echo 0 > /sys/bus/cdx/enable
 
+What:		/sys/bus/cdx/reset_all
+Date:		July 2023
+Contact:	puneet.gupta@amd.com
+Description:
+		Writing y/1/on to this file resets all the devices
+		present on the CDX bus
+
+		For example::
+
+		  # echo 1 > /sys/bus/cdx/reset_all
+
 What:		/sys/bus/cdx/devices/.../vendor
 Date:		March 2023
 Contact:	nipun.gupta@amd.com
diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index 48c493a43491..4d20047b55bb 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -106,6 +106,11 @@ int cdx_dev_reset(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(cdx_dev_reset);
 
+static int reset_cdx_device(struct device *dev, void *data)
+{
+	return cdx_dev_reset(dev);
+}
+
 /**
  * cdx_unregister_device - Unregister a CDX device
  * @dev: CDX device
@@ -433,9 +438,33 @@ static ssize_t rescan_store(const struct bus_type *bus,
 }
 static BUS_ATTR_WO(rescan);
 
+static ssize_t reset_all_store(const struct bus_type *bus,
+			       const char *buf, size_t count)
+{
+	bool val;
+	int ret;
+
+	if (kstrtobool(buf, &val) < 0)
+		return -EINVAL;
+
+	if (!val)
+		return -EINVAL;
+
+	/* Reset all the devices attached to cdx bus */
+	ret = bus_for_each_dev(bus, NULL, NULL, reset_cdx_device);
+	if (ret) {
+		pr_err("error in CDX bus reset\n");
+		return 0;
+	}
+
+	return count;
+}
+static BUS_ATTR_WO(reset_all);
+
 static struct attribute *cdx_bus_attrs[] = {
 	&bus_attr_enable.attr,
 	&bus_attr_rescan.attr,
+	&bus_attr_reset_all.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(cdx_bus);
-- 
2.25.1

