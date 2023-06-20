Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2E773610C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 03:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjFTBR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 21:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjFTBRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 21:17:39 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CDF19A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 18:17:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ye3LYtuT1M1IXmZgTQNVOt8Lj3FQ1IyTTI5aOFVqT5yvpBzJ45alRZIzo+jVRNkq564/J/x86cvGd+d3RxzDD2LENCGaXkhI85Qm8+76Ri3vkvdRW9qsGUm6w+mr9sRC3F6vMGt7hpRTtcaJedoDALDuwprIO2ZOywc+y9zSRIlucCmvuWIm80eqOyaqBA59cn/6W7MNBywwAnV7/3ctqCYCEfaYU5P1zndgNpgna+AMsYBmelTsfpiyyjaRdI+0hdhKkgcZbgmxpwWNaFYgf9J5M5xif/c5czq0aukLfHhgOX8o/9XHi0c4MOk0wFNXDZ0SDrc4CyJTlfUNLq2roA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iP9o5A+zo7bJweh4Rc7yXQPSG4GKmkDno5NX83EjreQ=;
 b=kInNYkIH2IM8KceOBH5gXw0vTqkn57iyIvADmIGkFhmf3xNje0xpZVVKWspoMLrvGB2/AkhfhVXWld2xoXPU/qLB0o2gt++JtfCQyoc8ah8V2yiuVYKlR7gRnQM4pHQib5cotwy35ZTSmQ2oYDyTPPw0FCrwVm0/RVMDyn1Khl6e+19xpIwbhnDuSFXGr7zQtJs9pPdnasrooEPEHh+i2sMu5ulOoKyALAtx+RNjn5rl5FcPqFRMJVE2QTGRkJpX4lePwoxdD6dBRF6k4TB6MKvc6ouB8NltCyWKV01DqoDjJFUOH08PnMst5siNjtu5WTA4CSIX9VpKCihunRLkMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iP9o5A+zo7bJweh4Rc7yXQPSG4GKmkDno5NX83EjreQ=;
 b=tn1RRm8DLqjXU9UiTJQcDt3h+2O93Ygo0GojKlWt5cLnqFiEclhj+N48pUNAvjd5FgwHS8bR4scn06vOgAN+sEma039o3MDCUp6yblJWyt+JjfKScoVrYp02w0/NekzyrkyQvxfICejzOSluV+UFXkNpRAITjTl+t0qmMJluWnhEVPBmo0Efq5FWNz9qOD5Q8qPZMLpUqAfgYe8GpVKDVicge+C955lYuIkLN3RcHcADdgTtuuyedeU/act2pLzy+OCbGIrtD2vQWum3Mga8MsCW43l7qYjGx7qgQOHJH6pTsjC2/X5J0SV98kxs2KMSQFva+XSIE8Pec4fDt0lkSA==
Received: from SJ0PR13CA0076.namprd13.prod.outlook.com (2603:10b6:a03:2c4::21)
 by LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 01:17:30 +0000
Received: from DM6NAM11FT069.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:2c4:cafe::c9) by SJ0PR13CA0076.outlook.office365.com
 (2603:10b6:a03:2c4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.20 via Frontend
 Transport; Tue, 20 Jun 2023 01:17:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT069.mail.protection.outlook.com (10.13.173.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.37 via Frontend Transport; Tue, 20 Jun 2023 01:17:29 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 19 Jun 2023
 18:17:21 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 19 Jun
 2023 18:17:21 -0700
Received: from blueforge.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 19 Jun 2023 18:17:21 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>
Subject: [PATCH v2 01/11] selftests/mm: fix uffd-stress unused function warning
Date:   Mon, 19 Jun 2023 18:17:09 -0700
Message-ID: <20230620011719.155379-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620011719.155379-1-jhubbard@nvidia.com>
References: <20230620011719.155379-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT069:EE_|LV2PR12MB5990:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e5db98e-4a20-4a4b-e01d-08db712c1db1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cbrTX2hbqEXVUecY2Sx225TXnfoF7a/S+9KcMbgPWgUprG2wzUd94jaelHG3U+/4+MCifGTBbPaJl5/51WVXzNXphRCoE3BIZOENPWdaKnrT+tnLaIjDZejSAKmHmdMM1ldrGM9ujvjmnNLLny7USwLGrk4dMQTHh7GLxx3HHoUWxaJaiqdD2QpXVCxCzhECrelsjE7kHKhijzlvB5Jx83/jruUzeAghgPdW2TJaOeP6ZLpCvaU/Mw0ziLLTIlZlHIHehNZzu/WW4WQD2iPMZ/nnsgzLNJEIai1iYcMRvTK28Bt1nOAPbKRqXV4O2AQGbP2IhxthzLkJUlCeplYB3SuaufwP3xBJLRykNRu0R9WFiq+sXo45DOXH34UV3KGHKE899sYDuvivQMACwE0UVHghWOQl6MEgxE2YM/e5tH9Jd7N1txcMdqMLzNvIjrRk+NIXdWmEmyv4vAsIlzJClKWroSnH6m0l6IQhNK8q5nYcxVECL9BMPKl/EkygMHgXARDVdLikqHqlNMB1mkB5FnXCp0u4z5TO2I9tmjFD9M6HMwjRaddBB+he8Bm+jzhFSfNd3gx/puqwlx1hvsxgCHClS8O0RWAUkycvtgYMYzvnZJh8GBpfKxN+i+pgYAV/oC12956G6M4Im2kKqofpqSZogB1noX/ce+u8kHL9+NXksE0uaNXlMCkeqzQfbnxghVCeMCa31riDI0fTTM8oA2B/4cbsYp08GIqRtMvNNKIL5Jmf4T/k7nrtrCOOljrC
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(451199021)(36840700001)(46966006)(40470700004)(4744005)(2906002)(36860700001)(40480700001)(8936002)(8676002)(5660300002)(316002)(6666004)(7696005)(41300700001)(36756003)(54906003)(110136005)(82310400005)(4326008)(70206006)(70586007)(40460700003)(478600001)(2616005)(83380400001)(82740400003)(356005)(7636003)(47076005)(336012)(186003)(426003)(1076003)(26005)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 01:17:29.2347
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e5db98e-4a20-4a4b-e01d-08db712c1db1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT069.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5990
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

uffd_minor_feature() was unused. Remove it in order to fix the
associated clang build warning.

Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/mm/uffd-stress.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index f1ad9eef1c3a..995ff13e74c7 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -88,16 +88,6 @@ static void uffd_stats_reset(struct uffd_args *args, unsigned long n_cpus)
 	}
 }
 
-static inline uint64_t uffd_minor_feature(void)
-{
-	if (test_type == TEST_HUGETLB && map_shared)
-		return UFFD_FEATURE_MINOR_HUGETLBFS;
-	else if (test_type == TEST_SHMEM)
-		return UFFD_FEATURE_MINOR_SHMEM;
-	else
-		return 0;
-}
-
 static void *locking_thread(void *arg)
 {
 	unsigned long cpu = (unsigned long) arg;
-- 
2.40.1

