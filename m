Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF35736110
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 03:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjFTBSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 21:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjFTBRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 21:17:42 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF3F1B0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 18:17:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nENOMRcIwHu9FxJu9qd6AAdd8QDYw8kNg2FZGBi9c/vslCNxZB5LaOPDz7/cujE86Yo7yq8N6aSzN4MKdpRBc3lTJUf3WC04anQol+qHM/oon8UymhsnF7cX1aK5TxcDaywakCaeEdx3mQTjFvjC67Fano1uju1Pq73g21lauz7EVWJIBsuceiLVCDm2jTFr8ZKw/ZldbD/0jm88CnvzYo6kFS+Iw0VEfUQRx6BPHAxUGjGvqKbeTp07V3VZvKOWY0bn13pAj85lLmqBe71hOCYsGbEjSJ+xat8GhPrl84lh0niSXXEA7MLPdaIumcp5HDQc7UEOZvtRTisglfdM5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PNITXhlW7/50q8EibhFIrDa2v1XwHbp1VFAUfpMqVhA=;
 b=mzN+PuZwZR5bssL/hDJJlC38S/OD/IJCUm3ySJqOwhJDyUgkFJs10kE2Wl0KaLtUpysnOhvxj2RQOEcLTSJBQodHO5KwVR13hjbVyrBmCl+odUc5P0HQbx/5c0LmWtz21eY/Ta7SgRgBY/qsUmP+VFUGosUvbFzuY4FTZHODhMyazIuQBeHu4yXR4OwSX7xFV+Em6prssPr5onUIA4m88K6u+1tRcLXeqtpPVmDXJ8S6R2KMmi7vS+1joDWKdpwRmqQK9eNpTM5AIh7Gi+ESrPmjrZJPLH1AZ2GKa3R2dqvnDDm/9tCubd1GNXjQtoO1Y9BiQ3hiBKhYR9eYPzbMqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PNITXhlW7/50q8EibhFIrDa2v1XwHbp1VFAUfpMqVhA=;
 b=jR8oVN9AU2BcZsmuXx5nDrjtpnFTeB/Vo8Ye9vTxV5XyGec10HaoU0FM22v9GxLx62L6iocpzXF+gnRXrrnpNOJgZSHRKVLYuVxp1765M2xnxTlnBOgoXrfn1hQXIt7g+48tAXGe4t3UHquM+/NFZ9jgSGVmfdqDlCCGdNIf7GffHv8YQSwmmpoBQVLfGBTn7OKd35a7ZwYAF+G2FVLSW3UqoKS+GzAR/Dr27yYMlOVZ+pVTn7Y99H9DPPKRcKxxcUETudcOskiCRGNtMKlrE8csicxMwkN9+S0xu5P00Ek1uaufz1HcXxzLRBwmCeLDGmy8TqUYoNRxjh29EpELiw==
Received: from SJ0PR13CA0066.namprd13.prod.outlook.com (2603:10b6:a03:2c4::11)
 by PH7PR12MB5902.namprd12.prod.outlook.com (2603:10b6:510:1d6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Tue, 20 Jun
 2023 01:17:32 +0000
Received: from DM6NAM11FT069.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:2c4:cafe::f7) by SJ0PR13CA0066.outlook.office365.com
 (2603:10b6:a03:2c4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.20 via Frontend
 Transport; Tue, 20 Jun 2023 01:17:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT069.mail.protection.outlook.com (10.13.173.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.37 via Frontend Transport; Tue, 20 Jun 2023 01:17:32 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 19 Jun 2023
 18:17:23 -0700
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
Subject: [PATCH v2 06/11] selftests/mm: fix two -Wformat-security warnings in uffd builds
Date:   Mon, 19 Jun 2023 18:17:14 -0700
Message-ID: <20230620011719.155379-8-jhubbard@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT069:EE_|PH7PR12MB5902:EE_
X-MS-Office365-Filtering-Correlation-Id: f6f40616-c612-420e-4e75-08db712c1f6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T/3n+HgODfg6Zo2JstGcGTNFtgVJwUyjMO1+NqAi5xXJN7ptMQ2JkIZorqaL25VkWZurttFVpj8VtmK2XlQRs5jSW7ZrKBxo8tDaxMxhRm8UL88IERW7+sqzzE7KZl7LQ1cMLR82RIwCxH2HC1YRZcBf/F8MHvkGngoI3S6XwzyPMCUHORiddhzN9GlRhqQE6iWBKSx25sAOX3SfFBXPXPMUtyRGO34Nznh0e1JPmSeBozk4/mGUjUY/tyhcFCm2iIJRSqRaq7qhofPQsEgVtVFRPePLzhg6zsKaBxLrenhiN0nbvWn5Ioh8U2MBOhrdkoKSUXqBcwKOiFO/z/CXoJI50T/DrRYT/p95wCMed2UvxV1v70+X7QBfSkfuYB1UnN7EjbqebVxlmOBd/veHpUHOzKtLxIRVUUCINoXkh3zKaalpiwjuQdglkI7KxLsbkvZznJD3LzPM2FvO45Fujii1zHayXufaNKawU8trRd7wV+8fsSpuY25djJ0b4z7m5H6YX2jA2VsGoaW/KgjbNfDkj8RfkuWeQha1LLNMbAbRwJl9hBUXjcL2751KVX99GlHs2pmNsZhPhXwB+MUXiRkpEBno2o2UAW8HcrUGwIBwRPsV742ltuenaYIop3BjWhV+qR8uuHMyX62VM8p8Pn5/me51/0mXBRYRBJtnIFPJpbL2t/8QHLqABsgJe2OQwvXjCkuAC+mPWkhSTBD/fyb5zzKif51lOYbYTLxVlIHrCMywB+GjyK2+NJEJtCuL
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199021)(40470700004)(46966006)(36840700001)(186003)(26005)(1076003)(82740400003)(36860700001)(40460700003)(2616005)(40480700001)(47076005)(7636003)(356005)(336012)(426003)(83380400001)(82310400005)(478600001)(4326008)(41300700001)(70206006)(70586007)(36756003)(8676002)(316002)(8936002)(54906003)(110136005)(15650500001)(7696005)(86362001)(6666004)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 01:17:32.1407
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6f40616-c612-420e-4e75-08db712c1f6d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT069.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5902
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

The uffd tests generate two compile time warnings from clang's
-Wformat-security setting. These trigger at the call sites for
uffd_test_start() and uffd_test_skip().

1) Fix the uffd_test_start() issue by removing the intermediate
test_name variable (thanks to David Hildenbrand for showing how to do
this).

2) Fix the uffd_test_skip() issue by observing that there is no need for
a macro and a variable args approach, because all callers of
uffd_test_skip() pass in a simple char* string, without any format
specifiers. So just change uffd_test_skip() into a regular C function.

Cc: David Hildenbrand <david@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/mm/uffd-unit-tests.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index 269c86768a02..04d91f144d1c 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -109,12 +109,11 @@ static void uffd_test_pass(void)
 		ksft_inc_fail_cnt();		\
 	} while (0)
 
-#define  uffd_test_skip(...)  do {		\
-		printf("skipped [reason: ");	\
-		printf(__VA_ARGS__);		\
-		printf("]\n");			\
-		ksft_inc_xskip_cnt();		\
-	} while (0)
+static void uffd_test_skip(const char *message)
+{
+	printf("skipped [reason: %s]\n", message);
+	ksft_inc_xskip_cnt();
+}
 
 /*
  * Returns 1 if specific userfaultfd supported, 0 otherwise.  Note, we'll
@@ -1149,7 +1148,6 @@ int main(int argc, char *argv[])
 	uffd_test_case_t *test;
 	mem_type_t *mem_type;
 	uffd_test_args_t args;
-	char test_name[128];
 	const char *errmsg;
 	int has_uffd, opt;
 	int i, j;
@@ -1192,10 +1190,8 @@ int main(int argc, char *argv[])
 			mem_type = &mem_types[j];
 			if (!(test->mem_targets & mem_type->mem_flag))
 				continue;
-			snprintf(test_name, sizeof(test_name),
-				 "%s on %s", test->name, mem_type->name);
 
-			uffd_test_start(test_name);
+			uffd_test_start("%s on %s", test->name, mem_type->name);
 			if (!uffd_feature_supported(test)) {
 				uffd_test_skip("feature missing");
 				continue;
-- 
2.40.1

