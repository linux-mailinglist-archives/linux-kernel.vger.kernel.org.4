Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E9D616717
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiKBQHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiKBQHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:07:37 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709EC25EB4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 09:07:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sh5FgBx8NmnYDtvUM5m4DySV7Y8TMEbGq5QUyYRjzJXwWPOOVNmZSBciH/k/NZN0TLaXPuoyBEFBfYHS4AEm04WV04LxjfLSbuYL1fmgLNXNjrO/lcKY6wtYBXcfGTzzJPSs25mQ6mZNOgmp5GLGbdEp9BMP1FyJ7kek35XQ5ucqjsmEtzlqt7dPN1129kuLXWLigqC4G2qOLMmSpuzh2VEHxMcwYz+8QLpJDUDq9VMYiObv2VhGGnEZxzC2Q2dafPdREW7NM6NYTEFwZLZkkPA2+SjELiZ1TAuQIvtav+EY4FepYFIeDTqlTJGBiGHSVgP8k/yqM1liEddJ2NctNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvQEqVl3Fq7HwJDKXJkEl6eZFNflNn6HL/FZO+2mXM0=;
 b=n5vIVbIdQUrVgy6qYMfC/GVlQFASIszJQquVgJEmqnbWqwK/OwWb8ncl4FrT50nrqBq3dBsZZ85jaC/7JWZfd6LVj1K84lwbqvsG3xurY99UDbnN8Abe3Cvr9XBnHuHTCXZfeubO56rtZwvzpM06SDVQsMcY9op3V0vP6J6SjsFypkrdD2M+9C28ChKwGcrF5FVGN101BgQnLis2N1WctFkNGLkQCrqaziwB6vPnBFroRq3plzolszB86BYpr/WzEHqqDwwXf6gLWRlFIK71w4FlR80pXesL8CvKO7QoyoVeAiaMUMz1cI0kf0U99sau2hA/YTzKe6PiHN5zyB2dPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kvack.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvQEqVl3Fq7HwJDKXJkEl6eZFNflNn6HL/FZO+2mXM0=;
 b=R6DqpcmzPH4D/Z7YxtsDaDPN9fUqpIKcduW6RVzh4/OW6jipqnXphUB9tjoKMEkggaSJjbfi44jdO4fVrFg2Mcuncedq/7a/b+47yaFfRfHHEnvcePrAJezfYjc62CEDYtqJpFrsGZZtLxdszZds7++h76qG91nFeyXvDI/9n/c=
Received: from MW4PR03CA0212.namprd03.prod.outlook.com (2603:10b6:303:b9::7)
 by PH7PR12MB5951.namprd12.prod.outlook.com (2603:10b6:510:1da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Wed, 2 Nov
 2022 16:07:32 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::f8) by MW4PR03CA0212.outlook.office365.com
 (2603:10b6:303:b9::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21 via Frontend
 Transport; Wed, 2 Nov 2022 16:07:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Wed, 2 Nov 2022 16:07:29 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 11:07:29 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 09:07:28 -0700
Received: from pankaj-M75q.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 2 Nov 2022 11:07:28 -0500
From:   Pankaj Gupta <pankaj.gupta@amd.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     <dan.j.williams@intel.com>, <thomas.lendacky@amd.com>,
        <pankaj.gupta@amd.com>
Subject: [PATCH] mm/memremap.c: map FS_DAX device memory as decrypted
Date:   Wed, 2 Nov 2022 11:07:28 -0500
Message-ID: <20221102160728.3184016-1-pankaj.gupta@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT068:EE_|PH7PR12MB5951:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e9d354d-70a8-4522-4ac6-08dabcec5809
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ya+phfM6cNi+uhyGQmwVYzWilWT8Hpql+4qFwpam8ffPS8KQrICmYEAzFyXysnbAvjMDnQ6XPaK5JDHVba/cInHDorxurujlGnUB+aZZegh6Eb4y++Qdpf620U6ooX7xPpLbjmfkoxMx6TzfqzFLGdi5BjEbVPIryVgInLKBtvll1ClAnEI1h7N2Y8jgLacNFQMYmKVx8V2LN6yL9619QC1sydY93aZPzI6bpx6eSAXgOZQnGUSELd8JUoPVGTeL2CQZHjX30MkNs65AvV3HX1jLduQwQhzZ2kV1DznswuuUmvD0EOMwogsL93X+00cSlKG6TZkqopQNQ4rXlfxTrrMe05g6VR42fUeMqrM8DTDiml93aqUki4s5P7JS73lXsL42wBVxCw2j98hcP16PssRkdrfGhiwIgSwovPpHU+rtXLfxWNxhcP9khPhHLbKaayNH3hZ+ZSDNWJgwD4lfB3K/WJscWHZnzn5AIcxYofyPE11I+avWoDOkfcInQ/rExiE2xZFjaJzX11aBKyNBCKRjXFxjW99BKz233NuKtb0P67i8jEk3bTCLA2qp0pWugwrKhs/RVAc0WVeyZAL7vrmqe06jmNxO4sR+DlYJFH1LbCGy4iMlkNgtK1rvmBshPVK8uOPQkfb+Mg7NFHJrxjR2hewBahen7qTcxXTJFh1+x5j815yss6ccg6ALvk+LDK8SBjpYmIuufKRWcrvKWnKmPfRywf5AGO7h2i+OYMV8p62GTzPHcMUfg4xG27m6lb3fGROYNen+RxMqBUOEdqLNlC9Cifp0yL+N1qrfahT3905UmRnJJpo2UsBhY5Bvw6vlQ4qTy5lEZ/+IfaD+2Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199015)(36840700001)(46966006)(40470700004)(426003)(36860700001)(336012)(26005)(86362001)(47076005)(82740400003)(5660300002)(81166007)(44832011)(2906002)(4744005)(356005)(8676002)(70206006)(41300700001)(82310400005)(2616005)(40460700003)(186003)(316002)(1076003)(110136005)(70586007)(8936002)(7696005)(54906003)(478600001)(4326008)(36756003)(40480700001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 16:07:29.9935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e9d354d-70a8-4522-4ac6-08dabcec5809
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5951
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

virtio_pmem use devm_memremap_pages() to map the device memory.
By default this memory is mapped as encrypted with SEV. Guest
reboot changes the current encryption key and guest no longer
properly decrypts the FSDAX device meta data.

Mark the corresponding device memory region for FSDAX devices
(mapped with memremap_pages) as decrypted to retain the persistent
memory property.

Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
---
 mm/memremap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/memremap.c b/mm/memremap.c
index 421bec3a29ee..08cbf54fe037 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -335,6 +335,7 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
 			WARN(1, "File system DAX not supported\n");
 			return ERR_PTR(-EINVAL);
 		}
+		params.pgprot = pgprot_decrypted(params.pgprot);
 		break;
 	case MEMORY_DEVICE_GENERIC:
 		break;
-- 
2.34.1

