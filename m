Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30ED70E998
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 01:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238868AbjEWX25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 19:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238875AbjEWX2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 19:28:52 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B7010D9;
        Tue, 23 May 2023 16:28:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RKApgVmbXNauorBr9wReHAn7ZnpQ8RHclFSWdeF2EEXXL+RyyjWswEnEpx4PRYkPdkcnonn1+TIc5mazX+xRIuT0FlHyFj1h8nBPd86QYEeA4bdeaHs+bcmeZYESttOt0vwa4t6gU3bQtNA3qV9PdweWFmqtB83RDLD94Btp1Cw7N4Oq6gzl5QfuEJjn4H9TO3nxASJxlyjg27nHeKEDcFe6CX+v9X7vanwKQhWwNhC4JluOt7fWKmtXCbQLP6OBYuzR6U8BjR/UCjjKedYjqG188ChvfKxnp2pBbfJt2gjov8T76+eqg1rbRKrOtq/xgJkyaPEMxBc4Ib/218qc/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HTHGmIllFdtym0JWtvf2gcuLrQ/DaTCeEw9z18jtVkM=;
 b=cT5JQ9LZU6RJAwwX1o2ZhzmG2I1gUIe5qvdB69YySyIRJrB5M7fwUW5BXYS9eNjMmdqQftQl5Rn6chroKxK3Q8RqwdbdNJ8k7ZYS5kIjBE2n98yp3kHf32bw9ADM6ydHpXSqLKsPwN7MY0xMFMRqyL8Xd2owYvJ9XtWR38/AG2vYdxvxQQE7n2335QL6Issq49hRgyX8fmkFS/H2Wz8frGwVPojZn6RgxZVlXiH9bVNmqDgSfewxKc2iur5plBVg6+fyW0al5AhKkRyakb67/aOZ2UptJWQXO0PSMx5LfExh1FNoyjnC6SwPViH9cT/hAiJtqnmZTl3CZjwDFF3BVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HTHGmIllFdtym0JWtvf2gcuLrQ/DaTCeEw9z18jtVkM=;
 b=MvUgEgbrTSOLtfN8AB8fCDTIKSmexC9qiqafeywzF1nI6NSimL2UySqm9qq9Y/5N2VWj+pjmeoRabb4NQpMD5kS/AxbmvAi6Hl6gBbWh6JOo+dx4xXc90DUk9lrR6AuG8hXGHWB3H03PYk8E5LPR1B4eySMEnLjpPYf/0qfCg9U=
Received: from MW4PR03CA0273.namprd03.prod.outlook.com (2603:10b6:303:b5::8)
 by MN2PR12MB4584.namprd12.prod.outlook.com (2603:10b6:208:24e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 23:25:57 +0000
Received: from CO1NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::39) by MW4PR03CA0273.outlook.office365.com
 (2603:10b6:303:b5::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29 via Frontend
 Transport; Tue, 23 May 2023 23:25:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT070.mail.protection.outlook.com (10.13.175.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.30 via Frontend Transport; Tue, 23 May 2023 23:25:56 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 23 May
 2023 18:25:55 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v4 16/23] cxl/pci: Remove Component Register base address from struct cxl_dev_state
Date:   Tue, 23 May 2023 18:22:07 -0500
Message-ID: <20230523232214.55282-17-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523232214.55282-1-terry.bowman@amd.com>
References: <20230523232214.55282-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT070:EE_|MN2PR12MB4584:EE_
X-MS-Office365-Filtering-Correlation-Id: a575c9f5-fe6e-4adf-5805-08db5be50fa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OGtJCcz8cwQqBP3iLvE/+NTlonhDnHWGRnYLufSEOJEhKq4MHeUNZVzLs/tDdhEZXQEekTkbKvsGSgEqY7KvegqPRJbI1q4rwZ2wChyD7WE5NnLcFg95diW4VuDAbOQWtGdqIC8Ey9aHJRoESzh5bUuomgcg8+94PnUY+YgsTD3KAzDWgr9dfrEN6bsmOdz7SxByskj+OqwI+ZUn4SnXsd8nofSqY8YbM5HX5gPGpeSVu9Ta54a8XxasqhmMVo1vXAgIJy4jj6ajR+xje/mMXrOvlOjYSN08bWczxWPF+dtBx5tzmVSpO08BnYbtTNZncSCYlFcC1pRQnwHq+oWBB9pzfivLiznETczqYH3byasV+ZuhGgp3oLv7e9fKTMSt2BxCxc7lRQe254CVhR226VxjSKiP1MxXZ+Qy3lA0qKu3mOQilJPnkuLl3CIK4Z1+LnZTSuN7+yTFbwGTGT5f2ebeH1nfojca1IoIokIi4gV2UI+05jyIikJ7WVRGEmcW8UteSp8ntRBcG83hBQ1zlWS2M8XO/PjkWxlxh+t1u/3+IFC3znwviRSfl9vfMmPyEIHQ7N6NSZW3G9mFAJrIddz4+bXeeJC25y+B/AqlLAvlxmuRggvb74X2c1DH1L4BeBmB4YTD5OP7m5QRU402exnRcS1VPp92XKVN4LxQ6q/9ri/dr+bj3n831akfpfHfEsBNxddS0Vj6R7jC8mntqwbEK0jkLc7i20o+XZTp+fAAITQX+xGS2LRdFkUOJBpD2Xj/EcIKGhYkZejBirpjcg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199021)(36840700001)(40470700004)(46966006)(356005)(82740400003)(7416002)(1076003)(26005)(16526019)(40460700003)(186003)(81166007)(44832011)(2616005)(36860700001)(47076005)(36756003)(83380400001)(426003)(336012)(2906002)(40480700001)(7696005)(41300700001)(110136005)(316002)(54906003)(6666004)(82310400005)(70586007)(70206006)(4326008)(86362001)(8936002)(5660300002)(478600001)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 23:25:56.9849
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a575c9f5-fe6e-4adf-5805-08db5be50fa6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4584
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

From: Robert Richter <rrichter@amd.com>

The Component Register base address @component_reg_phys is no longer
used after the rework of the Component Register setup which now uses
struct member @comp_map instead. Remove the base address.

Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/cxlmem.h | 2 --
 drivers/cxl/mem.c    | 4 ++--
 drivers/cxl/pci.c    | 3 ---
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 2823c5aaf3db..7b5b2d3187bf 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -287,7 +287,6 @@ struct cxl_poison_state {
  * @active_persistent_bytes: sum of hard + soft persistent
  * @next_volatile_bytes: volatile capacity change pending device reset
  * @next_persistent_bytes: persistent capacity change pending device reset
- * @component_reg_phys: register base of component registers
  * @info: Cached DVSEC information about the device.
  * @serial: PCIe Device Serial Number
  * @event: event log driver state
@@ -326,7 +325,6 @@ struct cxl_dev_state {
 	u64 next_volatile_bytes;
 	u64 next_persistent_bytes;
 
-	resource_size_t component_reg_phys;
 	u64 serial;
 
 	struct cxl_event_state event;
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 0643852444f3..618e839919eb 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -49,7 +49,6 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 				 struct cxl_dport *parent_dport)
 {
 	struct cxl_port *parent_port = parent_dport->port;
-	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct cxl_port *endpoint, *iter, *down;
 	int rc;
 
@@ -65,8 +64,9 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 		ep->next = down;
 	}
 
+	/* The Endpoint's component regs are located in cxlds. */
 	endpoint = devm_cxl_add_port(host, &cxlmd->dev,
-				     cxlds->component_reg_phys,
+				     CXL_RESOURCE_NONE,
 				     parent_dport);
 	if (IS_ERR(endpoint))
 		return PTR_ERR(endpoint);
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 00983770ea7b..0db71493db5d 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -661,7 +661,6 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	 * If the component registers can't be found, the cxl_pci driver may
 	 * still be useful for management functions so don't return an error.
 	 */
-	cxlds->component_reg_phys = CXL_RESOURCE_NONE;
 	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
 				&cxlds->comp_map);
 	if (rc)
@@ -669,8 +668,6 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	else if (!cxlds->comp_map.component_map.ras.valid)
 		dev_dbg(&pdev->dev, "RAS registers not found\n");
 
-	cxlds->component_reg_phys = cxlds->comp_map.resource;
-
 	rc = cxl_map_component_regs(&cxlds->comp_map, &cxlds->regs.component,
 				    BIT(CXL_CM_CAP_CAP_ID_RAS));
 	if (rc)
-- 
2.34.1

