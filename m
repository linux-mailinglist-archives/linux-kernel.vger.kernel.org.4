Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A93373944E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 03:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjFVBMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 21:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjFVBMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 21:12:33 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2095.outbound.protection.outlook.com [40.107.95.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A0010D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 18:12:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRuklgT6U014cvzJofzj7ZjO2yYZu7m8u1xtH54MrzD2mH/bTE1w0fl2d/EL+tbS1nOvs93PiDLip3R+HvZRJDlEQ14updBDZIPD0keHU9lo0jM+n0d1FmGWAqZsDf53S12Un1vKRfiGGA4F6xVsY/mtQQnVFVXZF1V+b9BRNVD6oB4hjgCL6hsUI/mDjvKMgeLcphP4UDasLLE+vfNafHBWC3LA6Ga2FdNVnYZTnxwnmjF2GYqc7ZSLYhMK4FJ/iaFfQUT7uVjYBHftOkzRVLv0dtBocXqi7UoHBX3mBSyJs95P2UILCe3Cbdq6GTGuWC8wcvmNKM7qViNIq/r4CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EyMeNQ8VaSBnknESOsgXFmP1HiOq2LuciqZ4VQX0NLQ=;
 b=AaOZ2ULwX+KCCPqv4mi7p5g9YJ+1OZNgJwmyKIJEpHdRc+GEzEbok2s7tl7JN8N+xBYaRtWc/lt0gSRx73S6ZyH0k0j5Th7xdJT5WCu4ZhQy6AO5xIDPffD07qrFI2vwnb2tZhQqYxwRty1dQ/61gkjz+2WO29imTNa2NwGKAKhEZGNVL4UXTlaQMyBV7G83aXtLJeKVC9WmnGoJh5abq4QFNOfAPUs0lXZw8nPPaKkM1EM0llAIRa6SZE17CM/sINbxSgvZE4bVMhQi8o3HKgHiXIl7zfhc4fL7+n8gTUeeE3NLfgByQs6a6u6zDvdioQ+hzHP3ad8ZwFxOC9jjnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyMeNQ8VaSBnknESOsgXFmP1HiOq2LuciqZ4VQX0NLQ=;
 b=pibXVK4H/pVSDY5CjuvGRTlj3nHRiTelAvX604C9x5tJiTVzzyGb30FkwGqYAz4b8vf2cAx68YNuWVmGlA9gVYGfGHVhg4FmJDuORAryPC0+bqnUYd7aMDwspl+XAlvFO9xwBu85MZ/fDRYNw2+Ek3XX7WXynynC/BLm8/QYCJc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 DS7PR01MB7805.prod.exchangelabs.com (2603:10b6:8:7c::15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.21; Thu, 22 Jun 2023 01:12:29 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::a323:29a7:2fd7:621]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::a323:29a7:2fd7:621%4]) with mapi id 15.20.6500.036; Thu, 22 Jun 2023
 01:12:29 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] perf: arm_cspmu: Split 64-bit write to 32-bit writes
Date:   Wed, 21 Jun 2023 18:11:38 -0700
Message-Id: <20230622011141.328029-2-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622011141.328029-1-ilkka@os.amperecomputing.com>
References: <20230622011141.328029-1-ilkka@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR13CA0017.namprd13.prod.outlook.com
 (2603:10b6:610:b1::22) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|DS7PR01MB7805:EE_
X-MS-Office365-Filtering-Correlation-Id: 794599c0-eb21-4ec2-4806-08db72bdbf80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3T/ANUbScoYp5dWglgH9lY2+1DAL5BGiZYCGOjEdxt1txH4u+1QVuBl9oOM4z1yS9dlQKaOMM2VQ1464VojjfQJOn5RjdQ3ZX5cCBGxzsyrxzkR+PqizZfTRFbbvzeg+/O6VIh5d9whLUtOeqPIXIs0V05qhrM65AzXysWNLMmlz5nUVwWHBzSHJ6jU/Ax5zGLPchWfChSf4j3p1yEMv/p9jtsAt4J3QRCYQ2h+3bTwEDAkO/m2QhI3jmIMHFJMhhvKlDSENCyBh8jk+9t+l/iLs+CQCb1OOzRGmiZyp0wA2Wnveul7Rd4tMzXAOvLmfZ/bVGLxhqyylCKzAk9ASiULrnhMjW72UypHZJMWjGRz3Ic1veVfVsmHVQDySmC508sdfLlk99M5HsAJEotpoGdXdLasZQXm+a+3p+2SkItK4kBGAXZghDKzwob5cRpG/T25vA3uX3e7C5s/FIfTGqIkDBUY6sHelVKiojkJdDTBg/VQUc9MquU1ZOTgwk3P2tChq6YgiNRkwdQxbjiXOtGQd6OrO+Xo4Xo8UjvbyNCb5YmthwsgUuujWu5L1mQZcyaC0kEOn6kPosYO2YgpabLW06OfhcTVZPWKjgDwN9LKJPmuDOENJfNd+QNENqZAE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39850400004)(346002)(136003)(366004)(396003)(451199021)(8936002)(41300700001)(186003)(8676002)(26005)(1076003)(6506007)(2906002)(6512007)(86362001)(110136005)(66476007)(66556008)(4326008)(66946007)(6486002)(6666004)(316002)(38350700002)(38100700002)(478600001)(52116002)(2616005)(83380400001)(4744005)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1SyzApxP7MosD/4QAC9nqppPDFrk1fGiaWPrJBrPfXwnCv47s5ITOc4Z4330?=
 =?us-ascii?Q?uywpzR9sEOOjDIJWwoMVjm3ijlaDZ7v7xXT6kyIT9b5jC81lTbHsOd5p+EMe?=
 =?us-ascii?Q?xmEehoWmWFPxVbrt0JXhRLfD6fkfaNKL1FG+KfDaw55G02R5GkqshVMhHZRz?=
 =?us-ascii?Q?2IZb7tlzF5rrN9JXPFc6XBk48/k8p1mpEGAJsb3/VS+Igbx+j2pFJS5hm0YK?=
 =?us-ascii?Q?G3DITJ1aAg+r/Z762t6Hcp1rAUDOllPJB3JaaJ0LFk8D95QVveGqjusvIF63?=
 =?us-ascii?Q?utSDT22/nIn3kMDH53DCENyIa/ebs8SH3hLOv0PkpdnD59XrtCJ/M9cKccL8?=
 =?us-ascii?Q?rbuCiB1LcnCkq1TvgzdHoAsDzcm69vPUJkspka+I5cgHo7wOzVFsv4I6hJ65?=
 =?us-ascii?Q?ta7kZqIJKsOVS3W6irHLSMlO9xukyoERwgRE5AzIzqFG+nVG/9xNACF7WX/r?=
 =?us-ascii?Q?wqu5pH+n8c933bziVNB+Y3CkSHe0R3xMiSZdKvUOygYSWq5+82/z2ggqQi4V?=
 =?us-ascii?Q?xWavJPEU5mW8V+o5UqHJLzEr4XQa/G/Rqc4LfequswwlvnzQRq0a+Vy05qWN?=
 =?us-ascii?Q?fxt8er3FyA27ABVC81UK+MqU1WIn8VCgSGk0uVHMN7bWxLy0A3xvq3/JqTyv?=
 =?us-ascii?Q?BeeUmvXqksPumQqBxYCWDSFdhMghwpTl7IokZOAuNCE0gNWBYFfnAocYUyXE?=
 =?us-ascii?Q?SgqX7UBIw6JoAtc+lmoA0RppMxQA0Oi5ynlld86oJP+YL1Y0OyK++wJAyLSK?=
 =?us-ascii?Q?Yexg9SCa5U6Eh3xjNiyrZFD0mDILFeNMKIHcjzXCIFsdNca8FLR5OcP7cWYY?=
 =?us-ascii?Q?g1CVwcoedJeDdJA+iMItjqRX1PkEGRLzkcyk0KrcV2IFytU08g+H6QCXMOgT?=
 =?us-ascii?Q?jb6E//8oxASF/qrPK0bjZbPjOCiY7my/PlFumDxz8zhknUDA5w/2DqT3GpwQ?=
 =?us-ascii?Q?zOprVhdVRvdE1kPr4g5mfIgE7MzPLe7CX+rbxt7kbg5lPFB5v7pStOI9IpT1?=
 =?us-ascii?Q?17gLkBz7Q+jCn0bj8k2WrxEjeEuUmHzf9dzgFzXUtDcNqfNLfs40+7hkOK7I?=
 =?us-ascii?Q?EpVn2/Mo45htn3S/fOJhuJwe8eTlyGktJnzS3fmUXzKfu1vUsRloDnx+MNqj?=
 =?us-ascii?Q?n1KME4JRH97R0QwuIdg4+D11p8ePRysTO+OkHV9QbkmckwlVI15L73dfV0st?=
 =?us-ascii?Q?gyAjHzGjCjRqt7Z3DpbK1XrVw2JMiUaaEqPDK2GUJaWLlQqVALKnXFbbV+NN?=
 =?us-ascii?Q?tvOfOoFrADBBL8smjR0H0qvwOafOF+Tw2G84JIVbDKmVMheUm0TDcxUtmESO?=
 =?us-ascii?Q?m8JSlpPWJeMeE0Np+Q9tEzhwlpL/HctWLc7JvA4NaTiWiYcuN0i5IJ/cRdBl?=
 =?us-ascii?Q?y06lYn1e466f/2t67N5lk6R7Q1NGYxUTH0Pu8ztqXetJdtv4tJQOAHnPOwbP?=
 =?us-ascii?Q?V2ErSlTwdhHr9MbWSLcpp9pShhs9pU5AhKbBOTtGJd+0McRSewbnrQJvgL1k?=
 =?us-ascii?Q?8fLy+XmJpJ3P5zqdhldJtPB4K7XJXpt2qNDmrIT67UskHraGAj+UcVCGgqk9?=
 =?us-ascii?Q?qyi3OM14ICHVt+gQgs9P0Dw5D79MCAzV1HWAa3qzbclDWVDZRkWMJf1FW4l0?=
 =?us-ascii?Q?KaOWQYI0j3wIzN1eE+mmlzQ=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 794599c0-eb21-4ec2-4806-08db72bdbf80
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 01:12:29.1639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rzPN8FWw1q3iLGW6+tSVy0WDur8CY2zNXlTvcxIvD4s6JGGE58UzVjB2lErCUbUQFucZmjfDh+Md12diMRqJDRS7AGbE7P2TnMLozp2LgZJvwxO2ZgOpxmIDBla93Iyj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR01MB7805
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split the 64-bit register accesses if 64-bit access is not supported
by the PMU.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 drivers/perf/arm_cspmu/arm_cspmu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index e2b7827c4563..0f517152cb4e 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -696,7 +696,10 @@ static void arm_cspmu_write_counter(struct perf_event *event, u64 val)
 	if (use_64b_counter_reg(cspmu)) {
 		offset = counter_offset(sizeof(u64), event->hw.idx);
 
-		writeq(val, cspmu->base1 + offset);
+		if (cspmu->has_atomic_dword)
+			writeq(val, cspmu->base1 + offset);
+		else
+			lo_hi_writeq(val, cspmu->base1 + offset);
 	} else {
 		offset = counter_offset(sizeof(u32), event->hw.idx);
 
-- 
2.40.1

