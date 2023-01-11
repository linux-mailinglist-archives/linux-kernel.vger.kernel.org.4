Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D23B6658BC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 11:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238654AbjAKKNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 05:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238389AbjAKKMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 05:12:22 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B4611171;
        Wed, 11 Jan 2023 02:11:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMhQLXonhqAetESOcnrb/aq/qA5BV8XE78TchX+be25Fj2ROzmRccHkFFkopq3/LyzwBDi3QV1tzKjQ4+wHK64WqW9iT7ZKF44mIFBs8+ptV12iLf2fUeMAz6tEmkCEqAd5NSw20zr0Sn5g9CkS/Wrnq4bYkZbPNFBKpCKNszON7CCqH0QI/xShfiQhrOA8HYAlGsW/SYyL6K+eSHX1mPOfkg+ZSiJ2eW4UMzRnFNdB+D1x7JQV+TwoASMJWX+m5Vvl88rxBYJdh3WqBVM/Pj5YNN6p/fSMC+Hd3bmWBWnYd7NGih8DXKDgWYOtaUtrfRg+jcuKSoZSQUvTRTzwB4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zjgT4vdkGo4gQu7/4ZRdw/Ox8zBut/9qO68TuHMAIQ=;
 b=Is3yvyATvcqPfoWht9baSSSxHWenGAY/KtZQLAOFc/PuHFAzxJf0rLM3C9lSUtppfkezQnhrHUxcJmj0AfGbRT0C6txGhh6THq3IdzFslF4i7CIdWvbVAOqGPKS9EgdzYMOl0vSBOe+1WUFOGoNFbO/6ZkGWPPJPjH1uMeMWu1DRIBVn60A/qVymWsDE4I2qQ0baxSEApnwaC0INJUqbnl6syR7f3Y8ZiTuHTK/PEPWbXikNNkyteI3DlUkvuNFpb8MI0IAxKrAh8kY0YqcIleYLyQO5nyaGxuWBwvdF7796v0Kef72Bz+osTyHxrNTsQv99dQ/fDTYmfhMBcrKEtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zjgT4vdkGo4gQu7/4ZRdw/Ox8zBut/9qO68TuHMAIQ=;
 b=uDXV4wnsAKCGHskAHdFmyFD6i+ukiW56MyZJEhhaNfIOsn9sXcFABepqCI5qAh07HwpUFyk1973fMrcmTQZF06HonW0fXtBAbhHYnz6kzbqeIEoTA7He8pOpF8eqtE/Qig/TEG/XXJSagukQ1zEjvnAZOVpPws/vw9l7orAVmlPSz2oO0bvBrpDeFhc2NEAiv3fdKdr6m9Ve07P5fWnofHC4lTvNN5qCVB6gGbU8Y0tYPdm7j3gOd7PJnrfWMEaZxHr7p4Dxt+sY3eDeImklZtwG/oPiCxET8HQzf31V+qCSRV7x8ujv5Cziik3lr5mlQYFwslGflQPQIrTeYwqbIw==
Received: from BN8PR16CA0018.namprd16.prod.outlook.com (2603:10b6:408:4c::31)
 by SA1PR12MB8119.namprd12.prod.outlook.com (2603:10b6:806:337::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 10:11:29 +0000
Received: from BN8NAM11FT087.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::63) by BN8PR16CA0018.outlook.office365.com
 (2603:10b6:408:4c::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Wed, 11 Jan 2023 10:11:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT087.mail.protection.outlook.com (10.13.177.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13 via Frontend Transport; Wed, 11 Jan 2023 10:11:28 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 11 Jan
 2023 02:11:24 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 11 Jan 2023 02:11:23 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Wed, 11 Jan 2023 02:11:20 -0800
From:   Yishai Hadas <yishaih@nvidia.com>
To:     <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-mm@kvack.org>, <jgg@nvidia.com>, <axboe@kernel.dk>,
        <logang@deltatee.com>, <akpm@linux-foundation.org>,
        <willy@infradead.org>
CC:     <hch@lst.de>, <alex.williamson@redhat.com>, <yishaih@nvidia.com>,
        <leonro@nvidia.com>, <maorg@nvidia.com>
Subject: [PATCH V1] lib/scatterlist: Fix to calculate the last_pg properly
Date:   Wed, 11 Jan 2023 12:10:54 +0200
Message-ID: <20230111101054.188136-1-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT087:EE_|SA1PR12MB8119:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f57fa33-e1ed-46ae-5b62-08daf3bc34c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vRzdh97HJ4zjUlpKApHWm/Fx2fM+VHO12hAGIz6qJbXXXhZw9YAKYVp1C+meCr1w5xfgevbumOwA79enYObyjICkpkjqK0lOS4yBUvVvr1438OjgZ1ciKSStYO5zthjRoxJ3UUw6CQKibgV4rpCKJyZ1GcrzHddSoZU7sCLCS+6rqSuyF68ws3qYScDoyHxKYwSRyo7sy1oARD+lwzNxiTrfV3BPjAFREDSOioNsejC58aGM1lyTBWMNAOQ9M/UKgNEzGQm1VQjXAEplGRJXBTEZGjpa1MBgjkuxxKh5C/4G3JR3vXUUxm9j8Ki3VR4EF8+ZUX8jkq8seZButrDV7bcBQ9nUhEd4P3pQbseNoJr0AP2Ea9h/bLonXE7E/k0VBH2C3WM34v8ioF2Fv7Tzr3LaQX56w90PXxDKJB964X3kVjrApS+eK5hEICT7TVXMcH2Q5cCULhNv4OnigrkXzCPkvn5J00DqyOcz6qw4xJUXzEC0wxHDXSd6mulQ/gSgfPXE4ts0ZrG7J1Y1qqbnPNFff2qDFUlYMEEX3G/+9Ri4GsZxuWe5mjqCd7hc/GIBW7BUdbFH53QVU7cZxo4IPGqoTGsKDh94FY5NxN/acqxpIa2Q3wBZtxp3XcVVsuxGP/UGvdRnZ2RusG7HvEouWa61VK72dJYA0DMGE2s422dLgh7n71PZfs1IJlk3S5RKTUntHlBi+ljHYpZmnKud+4mcmqFDk5G5xl8uff76dvxC2Y26LREkIK6PMw69yBMngUE1vz74G7HX7+i5gtE97F9xNRh0zb6ThrVRz3LPaZ7O6+9KEUK8oC8Tzo1HjZnu
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(7696005)(186003)(5660300002)(26005)(4326008)(40460700003)(966005)(110136005)(54906003)(336012)(8676002)(316002)(70206006)(40480700001)(1076003)(70586007)(2616005)(82310400005)(36756003)(83380400001)(8936002)(86362001)(47076005)(426003)(82740400003)(478600001)(41300700001)(107886003)(6666004)(36860700001)(7636003)(2906002)(356005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 10:11:28.9287
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f57fa33-e1ed-46ae-5b62-08daf3bc34c6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT087.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8119
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The last_pg is wrong, it is actually the first page of the last
scatterlist element. To get the last page of the last scatterlist
element we have to add prv->length. So it is checking mergability
against the wrong page, Further, a SG element is not guaranteed to end
on a page boundary, so we have to check the sub page location also for
merge eligibility.

Fix the above by checking physical contiguity based on PFNs, compute the
actual last page and then call pages_are_mergable().

Fixes: 1567b49d1a40 ("lib/scatterlist: add check when merging zone device pages")
Reported-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
---
Changelog:
v1:
 * Rename 'paddr' to 'next_pfn' as it's actually.
 * Move to use page_to_phys() to clarify the code.
 * Fix to use (next_pfn - 1) instead of (paddr - PAGE_SIZE).
v0:
https://lore.kernel.org/lkml/Y7zyyTxdoJulq7OD@casper.infradead.org/T/

 lib/scatterlist.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index f72aa50c6654..8d7519a8f308 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -470,22 +470,27 @@ int sg_alloc_append_table_from_pages(struct sg_append_table *sgt_append,
 		return -EOPNOTSUPP;
 
 	if (sgt_append->prv) {
+		unsigned long next_pfn = (page_to_phys(sg_page(sgt_append->prv)) +
+			sgt_append->prv->offset + sgt_append->prv->length) / PAGE_SIZE;
+
 		if (WARN_ON(offset))
 			return -EINVAL;
 
 		/* Merge contiguous pages into the last SG */
 		prv_len = sgt_append->prv->length;
-		last_pg = sg_page(sgt_append->prv);
-		while (n_pages && pages_are_mergeable(pages[0], last_pg)) {
-			if (sgt_append->prv->length + PAGE_SIZE > max_segment)
-				break;
-			sgt_append->prv->length += PAGE_SIZE;
-			last_pg = pages[0];
-			pages++;
-			n_pages--;
+		if (page_to_pfn(pages[0]) == next_pfn) {
+			last_pg = pfn_to_page(next_pfn - 1);
+			while (n_pages && pages_are_mergeable(pages[0], last_pg)) {
+				if (sgt_append->prv->length + PAGE_SIZE > max_segment)
+					break;
+				sgt_append->prv->length += PAGE_SIZE;
+				last_pg = pages[0];
+				pages++;
+				n_pages--;
+			}
+			if (!n_pages)
+				goto out;
 		}
-		if (!n_pages)
-			goto out;
 	}
 
 	/* compute number of contiguous chunks */
-- 
2.18.1

