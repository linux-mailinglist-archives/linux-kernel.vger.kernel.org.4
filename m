Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7418D736105
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 03:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjFTBRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 21:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjFTBRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 21:17:30 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427ECFC
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 18:17:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQIER0G1xXhxcbXGhaerBVdni6B+gfN9pXmNCgP7XJec4Ef7DwdEKm8qHWj0yr6n6BZ0N4hxI92zljdmPWcAy8UuRlJMPVQxya8Tm9bSYNlmcfa2xJaff5k+SlTxPWLdme+ft5HaRRTdAYLbYrydBUAJ34dQfB7YtOX+vhPqAuTHQ0NY1b7Sk8WyAu5ROT4kdZ3/VmjYWNEQE2iyipsEMTD5XuMyUUv8aOr/11T368WllG52zeO7kqRuydm8ckDSwRJI2NkmXs6Y2DpX4hUCftZrfxDNutliYSdOP80OclyFn9dvjD6fcUULgZhns9n9yC25cPNTadJj/uC2chvm6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xYe3VM8yuX4vtW90lhI/aysRTnQnkFoQxzyk2ZljDI=;
 b=a2sqNCh+w6GfCL8wFP+oMizw+LqlPq1bWGfEbXi/9rllHVbuonqrbUEcYyz8TUzAC/WhlInzndidxBOCSGUfUH5GcZrBNHX8+Kvd4R9VsOrHKlqFg7Bail8ygpGFjoKqkbMtFkr0A3VVKEedIlHAgquU4wXbYD1SyJlpU6sWtIw3NNbhBiujgLzrs7n48H041W3RsxrftxQVpqPKjrh8UbrNYkpBXuBOeSbF3bSRgr4mGQZi9B9Kt57pdedo2ceykzv/HWX4UaFJQK4fOCQgaBroYBVVzXPwBJ6PQlwS9c2GyJ6zlDiHtvCVUNU5gzxAz9upwVNSsDRDK8rmiroWyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xYe3VM8yuX4vtW90lhI/aysRTnQnkFoQxzyk2ZljDI=;
 b=UB6cFM6sADuoXKJgQtUnziqa98rGnpf48Px5xvTRAlIRj0S+3jUeP5lcWN7d+w+JZQ3ACMdQoVUI6B7XCRwoAZJOHhs2LN4r4BqLGVcTGr2Er528Vk02tDrrt5MyNBWIOGRfyBNvoZ1LhNQn3am8I4weLMdDW0Hm0Avwq63dk/eIY8rpl1kLeXnAFu58MMlE5nPaK+Yxkxdm1pTK9VS2dalnnPpyNxvbuz5JPOl4xeDNCR7AxpwJrPjaWRasNiUuru9vXp0jwXAYTXE99EGZffR+t9wEl1Yh+gS20Azj6k3HHn589MJH0oSN3K70Z3XBAMRdy1sS1WHIalHsisSo6A==
Received: from SA1PR02CA0022.namprd02.prod.outlook.com (2603:10b6:806:2cf::29)
 by LV8PR12MB9153.namprd12.prod.outlook.com (2603:10b6:408:185::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Tue, 20 Jun
 2023 01:17:26 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:2cf:cafe::d9) by SA1PR02CA0022.outlook.office365.com
 (2603:10b6:806:2cf::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37 via Frontend
 Transport; Tue, 20 Jun 2023 01:17:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.17 via Frontend Transport; Tue, 20 Jun 2023 01:17:26 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 19 Jun 2023
 18:17:20 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 19 Jun
 2023 18:17:20 -0700
Received: from blueforge.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 19 Jun 2023 18:17:20 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH] mm/memory_hotplug.c: don't fail hot unplug quite so eagerly
Date:   Mon, 19 Jun 2023 18:17:07 -0700
Message-ID: <20230620011719.155379-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|LV8PR12MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: de1975a9-e916-48af-8375-08db712c1bee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4VeQw7sm+l7pxXz6V5bR2DuPHDo049YdZGgw+m/uSNwR1y4f8sOBFHIa4nZNV4d2dvMLR0itcuz9eQu/7nravJ5QzqkzfJ4I1Nl6yznGXQulQcCyCdmQpcYDMb7Dg4ZTTiLb4VwsEdDKhEdsZ50ucK7qaJFv9EkZI7fSq51xh7eOfNoipKB4qRxGNVOFib9o6Cis4m3VB5ix8xMJpp7eungIFE4K6qyRWH1+s179UFoA3g2FwNYyKu4JgzLOX8gIt0pTdYNZJ97M9XyEDb/hAO1bKFVm7y2qswAcehxKktheY2nQgqCHAOJ7M9jzQmasscIffRZpA0Vp63PRgbVn800pODgRV8EmC9CMj46UIZqM492SPN3GSrMAr44uYkldN0mL0FBawIAXHKiG9C072xs+SF1dENoBYkGdj5qVgzswGcqoy+vAdZTeMLoQopAlJCfFcpEjYCGq/rDiovhsJ1pxrxag8mByXTbftfRVrh84w6mqF27QMMHfxbqWXngBL6x0m5TA+dkM7uEHQ1JdHVJzTisnxXWX5IfwRaJQ+ipxqTDChinCExdeM6dbYRtq5Wcyk+g7SyVmNNG4Uiv+aBIRSuJ37QeHQFen6Pn5iv53AYe5tWnea6puUUUG5mXjz1hAFKJnZG/Aatn88tsdBReV4pwlKs/ZwUcixFE+h4oZcXp+mSt+PcSLc9qdY+waBy5Ffr2hnkFOUwGDEFKgXHg2tdVVZt4k9/knHIDQ6YmVxDKahiFhmdTCMA52UA1g
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(186003)(110136005)(478600001)(7696005)(6666004)(86362001)(26005)(54906003)(1076003)(107886003)(2616005)(336012)(426003)(316002)(82740400003)(83380400001)(70206006)(70586007)(4326008)(7636003)(356005)(36860700001)(47076005)(8676002)(8936002)(5660300002)(2906002)(40460700003)(41300700001)(40480700001)(36756003)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 01:17:26.2922
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de1975a9-e916-48af-8375-08db712c1bee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9153
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mm/memory_hotplug.c: don't fail hot unplug quite so eagerly

Some device drivers add memory to the system via memory hotplug. When
the driver is unloaded, that memory is hot-unplugged.

However, memory hot unplug can fail. And these days, it fails a little
too easily, with respect to the above case. Specifically, if a signal is
pending on the process, hot unplug fails. This leads directly to: the
user must reboot the machine in order to unload the driver, and
therefore the device is unusable until the machine is rebooted.

During teardown paths in the kernel, a higher tolerance for failures or
imperfections is often best. That is, it is often better to continue
with the teardown, than to error out too early.

So in this case, other things (unmovable pages, un-splittable huge
pages) can also cause the above problem. However, those are demonstrably
less common than simply having a pending signal. I've got bug reports
from users who can trivially reproduce this by killing their process
with a "kill -9", for example.

Fix this by soldering on with memory hot plug, even in the presence of
pending signals.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 mm/memory_hotplug.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 8e0fa209d533..57a46620a667 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1879,12 +1879,6 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 	do {
 		pfn = start_pfn;
 		do {
-			if (signal_pending(current)) {
-				ret = -EINTR;
-				reason = "signal backoff";
-				goto failed_removal_isolated;
-			}
-
 			cond_resched();
 
 			ret = scan_movable_pages(pfn, end_pfn, &pfn);
-- 
2.41.0

