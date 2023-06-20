Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617A273610B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 03:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjFTBRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 21:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjFTBRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 21:17:38 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7712E1A7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 18:17:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7brwF2IUaVKKtJo6FAdCtwt+LvqPGUovVA+JBf0D2BD8949TcCCaqP7OAdFjIxuTt8LUG/t9izJyt1e+oNDzjmyolGorN9u13bqpvzgzFsGEOjSt02+HL3dN4y+ikPHEKby3Z5rqFDaXRCLnru5qZOJQNSxfX+q72ig8v60+rFY3++6OrUOjzPvHS+neOvlDMnjcLjBsufQOJqFwMv6bzn2oAn/pwpYCW9u3hFCzoAm2ByvSlSMETC4HV235Kg2Ey3f14Jw3n2vdHqEU3ID3oSHTtuLN88jc6cooJVcJT0lgdNJv4dlChapjZZqqJ4f1EEfLdzHvrBVpPdTBx1//A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cvdHBj5yApv+3mwcH6LWSMXJlHljQnJdtS4CV2ZOt8I=;
 b=LiRJhv9vZWRQUYZb46WArDXYgGvcnKzbkLNPjjE1CGw4/ehNkiYTqeiHnDWLZv7+eNJw0ceq0DOgXUObE53ewJDgSGWCWAgu7qJu12s2vlFyDfikIjr1qZ35qO9OmbSwWM8GtvgHVhP68VjIGKvR34Oyq5KsHwJdumYeUlruwGCTJKqmD13navXeyxQFjOqu2FhDXtvkXJd23+5CApghiZ5hCTx2JmbOsQaFRrCtukX6t4Loqqtn1XwUC9+U9imO0RrkZMffapuAavIry72OYbIOnrx/Of+nrJ6F+EF52NKtYJdv4bH4Qs6iRr2K8SIlbvaQhxwz+KYXNolADIMswQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cvdHBj5yApv+3mwcH6LWSMXJlHljQnJdtS4CV2ZOt8I=;
 b=OzQaOX91pAZfoRNfnbY4LFAebi5dE+ZKyw7TpQI6clNcyn6K6e4SstfJJyH/YpXvAByiLlh2u8rKh5Nkv9rbsh8ZEEU7EnqqMwMDrSIb0w6GZCSNvOJvrco+a0FXKwITbuJbWkj0MVg9Ty+YCfXErOBdrfjjq7bihAdzjoaNAsSYdRF8CJ4Rlb5RteeQZ1gyKizb87yrLA4QYhBVMLcHXpD4FpLsMRqV8Vvf2BYjxLHNsHETqxNjJR792zokQwXjmSYDmRiuDqBo1EInvx02+D992+q2lboRIwcAOMYcm/UHMIOqAwJgY5fkErUqQ1L8VOd2zMN5qMLykLgLjPw+hA==
Received: from SJ0PR13CA0084.namprd13.prod.outlook.com (2603:10b6:a03:2c4::29)
 by DS7PR12MB5958.namprd12.prod.outlook.com (2603:10b6:8:7d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Tue, 20 Jun
 2023 01:17:31 +0000
Received: from DM6NAM11FT069.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:2c4:cafe::44) by SJ0PR13CA0084.outlook.office365.com
 (2603:10b6:a03:2c4::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.20 via Frontend
 Transport; Tue, 20 Jun 2023 01:17:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT069.mail.protection.outlook.com (10.13.173.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.37 via Frontend Transport; Tue, 20 Jun 2023 01:17:31 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 19 Jun 2023
 18:17:22 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 19 Jun
 2023 18:17:22 -0700
Received: from blueforge.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 19 Jun 2023 18:17:22 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>
Subject: [PATCH v2 04/11] selftests/mm: fix invocation of tests that are run via shell scripts
Date:   Mon, 19 Jun 2023 18:17:12 -0700
Message-ID: <20230620011719.155379-6-jhubbard@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT069:EE_|DS7PR12MB5958:EE_
X-MS-Office365-Filtering-Correlation-Id: e0713533-9bc8-4b39-b872-08db712c1ef3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1hdJME0ht5nOVxtfdnwbLMaqXiI7VFqO4QhAZffGyEQcekRntckPeGnYUyp8x9cEC1SacSmuSN4eIs+8Dy9rphZjSRIbP36CIKUcw9Uv5WAFQzuL2pX2LQ3+WrDrZ5xM8LuBDu+oRyN+yQjxhGoE7RZby6DPb+qSWcXmvjZGjpRDsswer2m0wlR4gBACMZUlSiynDS349oVZazOFNhyAKAv9Ss52O9mlSDELx+u+BkA8o+tDmYs6EbprQfIl1AZhHNyLrIH9LGxYIecgB6CWFuNoHe8bHStcXsAq4nQ8ewjVRa8mffHOsPzovFX/Y3y8fSYLWB4CcvTlqCQUdQmx3wcf+oHpLGlcM+qfCpBzycG5uYDwWiAJVfy9aHDgcOPkCNyvTzNHOOCwVbfWUMbOvlINZx5dbCNhi9duKO75JRVZHix/BiqFnXbfvZPaQjrq5rzPQ7noTduewV1REqE7pUsHTiPqiVM8geuQPvYnMYrjQSxU5AyVnPc27w6YHlEWt7VicQYP3PU/s9pNGuzedfhBTWvWCF4YIu3aHQreSs+C3afqOEiZidzUSKRM0IEcQocskNpnVGTBxtL/IG/VAp2iwl3V1x3ii1tmc5Lt5GKu4StETgLPLAt9Fk9t58kJhAmVNOIOWFCFyEq7Bk+vl+G80bRNV/G8SiG8bMErElBe+EyVrxVQ6qKT67nO3OwDNu+Rfox8CfRn113zq/DsoS5D65XEG7+Oua2Rj01xbZEs9QoTYkQizskuyuJbKcXY
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(478600001)(70206006)(70586007)(36756003)(8676002)(41300700001)(4326008)(7636003)(47076005)(356005)(40480700001)(2616005)(426003)(83380400001)(336012)(82310400005)(86362001)(7696005)(5660300002)(2906002)(54906003)(110136005)(316002)(8936002)(40460700003)(1076003)(26005)(186003)(6666004)(82740400003)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 01:17:31.3439
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0713533-9bc8-4b39-b872-08db712c1ef3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT069.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5958
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

We cannot depend upon git to reliably retain the executable bit on shell
scripts, or so I was told several years ago while working on this same
run_vmtests.sh script. And sure enough, things such as test_hmm.sh are
lately failing to run, due to lacking execute permissions.

Fix this by explicitly adding "bash" to each of the shell script
invocations. Leave fixing the overall approach to another day.

Acked-by: David Hildenbrand <david@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/mm/run_vmtests.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index 4893eb60d96d..8f81432e4bac 100644
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -242,18 +242,18 @@ if [ $VADDR64 -ne 0 ]; then
 	if [ "$ARCH" == "$ARCH_ARM64" ]; then
 		echo 6 > /proc/sys/vm/nr_hugepages
 	fi
-	CATEGORY="hugevm" run_test ./va_high_addr_switch.sh
+	CATEGORY="hugevm" run_test bash ./va_high_addr_switch.sh
 	if [ "$ARCH" == "$ARCH_ARM64" ]; then
 		echo $prev_nr_hugepages > /proc/sys/vm/nr_hugepages
 	fi
 fi # VADDR64
 
 # vmalloc stability smoke test
-CATEGORY="vmalloc" run_test ./test_vmalloc.sh smoke
+CATEGORY="vmalloc" run_test bash ./test_vmalloc.sh smoke
 
 CATEGORY="mremap" run_test ./mremap_dontunmap
 
-CATEGORY="hmm" run_test ./test_hmm.sh smoke
+CATEGORY="hmm" run_test bash ./test_hmm.sh smoke
 
 # MADV_POPULATE_READ and MADV_POPULATE_WRITE tests
 CATEGORY="madv_populate" run_test ./madv_populate
-- 
2.40.1

