Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197016CC881
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 18:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbjC1Quu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 12:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbjC1Qum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 12:50:42 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A577A81;
        Tue, 28 Mar 2023 09:50:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BhpG5WCRNy96wWeAW7ZeZLdBaxos09+50nPftrwjiupeu3dJIWjRUeqWGA+WIez2pPA4Ka4DOIEvsKZKUOvYW1Ah/V77/YdLxXbk4QO5J4KDgxT01K9BzxBlH9IAbgEJN4NGmn0+gknrzzeLbOw0bJ+Fyxl6qGuLLF8fNePZ0bwtFroZzwGqciYP/zW1qgBo3pJ4PJR7RJxYL335CDALzcieRqk3XKg7TxHsX++NHUEItNipp4SoY3NIH/5a0GtMwGqeSq8zGXiABizjWsXBUSZLh9KqOtqqSkZEbMh1o4HGhiRvKxjhtYvfrsUTrrJErR1oouMZLa+dOMqFeWSbPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fDwjQDllWH3bXfHz8WaEkcDkzmtqg2nWxKaXoGFDdpE=;
 b=FgF6DLE2/rDcMFAozEeQeRjcER81+dj0yQ+BxAIcXy5Bki5ULHkkePMX5dzHU6OTkVxjbmrDxhovbPeehwVOzDyxDYMIiUe16r9qbSvrnNyzfXdM93kcXV0krXKIClVsA4gqUfuy0XALvWILW9GvlUe9sP1hEOSbL0X1hWw9KBR7VhEGp+aCv7z20P6woL0u+fyxR8uRYq5QidcyLBaclkiYS8UBF6O5VHr1DpFSTFSuJrfkoWK0CyF97Uj6aGoHr/yY9dNq73m2nfgReC3PVben/CddolgctyCxfOp02indtJSDqmZH1MwyUDYldJBWmXqnrGauZsb5CakYmhNDvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDwjQDllWH3bXfHz8WaEkcDkzmtqg2nWxKaXoGFDdpE=;
 b=j6w1V6Ak1PCldoomcbRnhnuvsPe6IL3rKWHfQ+WKqcBEphesZpO8l0MH3ITOT7SY8jVj8jJpo4K06/MZDZpb/SEsxvUxbh5l5/SV3vt4BMa50tJAl7nzSjv0OBw9l+gujh5SOK4KrnZXrjDHjxWDhXxI3uF/0RmvkcFMsoNaI/I=
Received: from MW4PR04CA0126.namprd04.prod.outlook.com (2603:10b6:303:84::11)
 by DM4PR12MB6448.namprd12.prod.outlook.com (2603:10b6:8:8a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.41; Tue, 28 Mar 2023 16:50:27 +0000
Received: from CO1NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::37) by MW4PR04CA0126.outlook.office365.com
 (2603:10b6:303:84::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Tue, 28 Mar 2023 16:50:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT084.mail.protection.outlook.com (10.13.174.194) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Tue, 28 Mar 2023 16:50:27 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 11:50:15 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 11:50:05 -0500
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 28 Mar 2023 11:50:04 -0500
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <andersson@kernel.org>, <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tanmay Shah <tanmay.shah@amd.com>,
        kernel test robot <lkp@intel.com>,
        "Tarak Reddy" <tarak.reddy@amd.com>
Subject: [PATCH v3 2/2] remoteproc: enhance rproc_put() for clusters
Date:   Tue, 28 Mar 2023 09:49:24 -0700
Message-ID: <20230328164921.1895937-3-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230328164921.1895937-1-tanmay.shah@amd.com>
References: <20230328164921.1895937-1-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT084:EE_|DM4PR12MB6448:EE_
X-MS-Office365-Filtering-Correlation-Id: c10aea3b-ff8d-4c3d-088b-08db2fac887d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b4YvzlyrVz/2pOHBuPuBaV4Vr3XDzwA47NKx5uG6HEL1L3rGLZsVVKdkcwbFSGJxsTBna93l1bEPAXXly6FiAYtvuNcdJT5Y1TLfpSv3MM+qBNEOhnEM188WRJRC5E1WzHAPj1cDK/DEH2B7ikcN3t5o5kzrtd+sSMmNnvDJpfI1XypA0GhdKnl9V5wRXA6pf9TAREDe4ngBt2DXQHO1N03+Ur35RzePN5r8hXbB8j6fKaxBwSBFDu/VEgbcrM/7BLPp1nbsQqWzA1cPoxFI5QWM1vIhLvED3ZrOCWsngVjKz8N9TSGD2IALZZPk+4uL0Q1WdqwM5iOizS8SlEbVR3pgf2jgE/UdR9AnNQD9kuBdHIF9cQoNtR3fwXNUXRc/G+8z5JHlTTOlskWi2XjetJHBl/Fn2YsN/EOrONS9MasAbKwhxf3EJFmT/T/ONFlPIJ631j9IR6RdNHGCbeDBQARd3gk8JM3cu0o7rrB/Dxyjz+PwQLK+Y8I6XE8BA2LYUjDfWxORZNlSpmVqkOypfKlWRPqy4CXb248e0LY/+FVsvxQ57yyH3yGTePwEu4R5obyTZk8nY2oDY66dlLovcCSYup5MI1AV/bzaf7bf6oyl71XLv1m4nE4Dprv4egg0WcKKsCzrMT/9DzBR8FQrj1vLCUyYx6VxUVtsPUjcYKpvTIDLPzqm4916zUfNb+rBwxg3W3q+xiPG3sD44F2DpgGTGt56u39meYrMwMibiYk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199021)(36840700001)(40470700004)(46966006)(110136005)(966005)(478600001)(40480700001)(6666004)(54906003)(26005)(1076003)(316002)(8936002)(8676002)(70206006)(70586007)(40460700003)(41300700001)(81166007)(2616005)(82740400003)(4326008)(336012)(36860700001)(36756003)(186003)(82310400005)(2906002)(83380400001)(5660300002)(426003)(86362001)(47076005)(44832011)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 16:50:27.2426
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c10aea3b-ff8d-4c3d-088b-08db2fac887d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6448
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enhances rproc_put() to support remoteproc clusters
with multiple child nodes as in rproc_get_by_phandle().

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202303221441.cuBnpvye-lkp@intel.com/
Signed-off-by: Tarak Reddy <tarak.reddy@amd.com>
Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---

Changes in v3:
  - remove module_put call that was introduced in the patch by mistake
  - remove redundant check in rproc_put
  - Add inline comments in rproc_put that explains functionality

Changes in v2:
  - Introduce this patch to fix rproc_put as per modified rproc_get_by_phandle

 drivers/remoteproc/remoteproc_core.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index a3e7c8798381..d8f28c6fe3a3 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -2559,7 +2559,22 @@ EXPORT_SYMBOL(rproc_free);
  */
 void rproc_put(struct rproc *rproc)
 {
-	module_put(rproc->dev.parent->driver->owner);
+	struct platform_device *cluster_pdev;
+
+	if (rproc->dev.parent->driver) {
+		module_put(rproc->dev.parent->driver->owner);
+	} else {
+		/*
+		 * If the remoteproc's parent does not have a driver,
+		 * driver is associated with the cluster.
+		 */
+		cluster_pdev = of_find_device_by_node(rproc->dev.parent->of_node->parent);
+		if (cluster_pdev) {
+			module_put(cluster_pdev->dev.driver->owner);
+			put_device(&cluster_pdev->dev);
+		}
+	}
+
 	put_device(&rproc->dev);
 }
 EXPORT_SYMBOL(rproc_put);
-- 
2.25.1

