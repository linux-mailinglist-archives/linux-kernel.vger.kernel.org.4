Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9267257B2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 10:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235279AbjFGIcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 04:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238762AbjFGIct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:32:49 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2102.outbound.protection.outlook.com [40.107.243.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAA2173B;
        Wed,  7 Jun 2023 01:32:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLWXgikKLtuRonol6spYzSaenBmzB0an3gPpZcgP5IZLnTFZtbhLArXIQNMxkp+M6V74QVJt8Jhy+wb3udgd1kUTDDNgDGPqPDpOr+D4wWWKqVFeGscQBeQCOrO/wkxmOM+eJgf043SEgd+a9arK5p/GdafGlPrZFazx3xTXHpIvoHZjhnievrv/3WDB62wH4/NtB9zuugoIvRI88Z4WwpeFVom//raw/9C3kMhk0WeXJ8AHQ633MlyhYe/IggZMJ7WclObnUffQL0HJ9B4Wqo+5k0mSdwHZV5Nh4Y/nvh86IPdwgq5hOFQ+9nB+5Mw7TlBx/WAh139H0/UaTQZFeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRZxhGQrvCK/OKIHPpTr118yEW8wCmUFrDRdcojm2Gg=;
 b=ZLTa4MyxcppcH04rDyfE7/qmzZ2VMo42ScYlNO+8Wi+Nx+Jc3SBfc5EHs0qm3krKNwEdgcG5FuhXcS7dMZCb6BZ1yJ/i3+5lXNT6/ckbFASRs194M0pk8GYYS/f9UlLZ4S8S0IOVmmg2bh6d9FjJrTr3+FSSR+sQnncgCp/nezis6bEJviBwqyL5rYO6bOx2pjnsRfg/cwgjjdU4NffyUkrJeRajUqgvK2Nv2sn4T4NAm3qLneXIQQJQJbAy/NlKRxBtrw5Rqi0UVlb2bGTuPfMsERmDP/c09y0+Jz6eRyZoUTpgSjlP/u4HhuCyMSkwy+kJPQchFSO8DXpstH6jwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRZxhGQrvCK/OKIHPpTr118yEW8wCmUFrDRdcojm2Gg=;
 b=ZhnG+3T9rLLg0mlIAQKOdpfFtE1JoefF1cM1DWvjbsF4vDDUDinIZ1YHL3PX5rX8iXmOjstI5uplAdkfPRhkbJIXM4TZbWYamjrNjj74FavbXqfIg4VzFM5nUzSl/7g2zteeMT1hBxVhV32TaylSslwG1u4EDysHW4d6jpBymBU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 SJ0PR01MB6304.prod.exchangelabs.com (2603:10b6:a03:297::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.32; Wed, 7 Jun 2023 08:32:43 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::5aae:2a5e:15f5:8196]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::5aae:2a5e:15f5:8196%2]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 08:32:43 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Jonathan Corbet <corbet@lwn.net>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>
Subject: [PATCH v3 1/4] perf: arm_cspmu: Split 64-bit write to 32-bit writes
Date:   Wed,  7 Jun 2023 01:31:36 -0700
Message-Id: <20230607083139.3498788-2-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230607083139.3498788-1-ilkka@os.amperecomputing.com>
References: <20230607083139.3498788-1-ilkka@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR19CA0009.namprd19.prod.outlook.com
 (2603:10b6:610:4d::19) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|SJ0PR01MB6304:EE_
X-MS-Office365-Filtering-Correlation-Id: 377a1352-ecfb-440e-a4e9-08db6731c33c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4wB8M7nkXrsw/zPVL7RaFOj+qSoo1GmryHXnmSr8QDIqfbI4kq6DeEhluW7yTpfzawXMEdlOLQkqaf/Sx2lfX6YQByfTmj6Ge00+5OYXOVUwGLyG+rRDu4o59Md8hNlBnWiZaS6ufX0n4maar03HHgJJkpFFWIi4xdWsdWv/G6/Zo+P2DkX3Y/mSzfvLl9Q7yyhmBPVRqCpRCA5d5RLk7yYS5QIA0v6OLMWW2FQ11GBC5n5MwDIMQikfDHuVdcZ5hn355Ltv+v+PqBk65w8he0ceCMEs4gEvwLSyBOm0eZ+ZnwVC9jbaiShJxJLkIouUQEdBCsGxkcyFoInNH68vumni6wAZ8Nx0WoqLamWduhKEf0t80XU1C3JQjyyllj1/e+0SGkGDEg5D0jckLmxSTjEjwxRcwRhK2Zwj4IDxbRMa5g7SUeLutldLbxGKRoUUj0fRo51s7K8t9joZQk2BOGcNhKwBmP/5cut6iEKzAByVPojr219zKLuRE/pwBskBNyslK/RGIy0HeyosdYMVutlYVmRSxrBei4MeRASlD0y78IE5OPpyo57amMU9yiLUGwbaxJ8KZJakzejrE20n5o5g1e+AvbuqLkp8iN/Z/YKlnCFlJnY5Qwf9UvZHITDJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(451199021)(107886003)(6506007)(1076003)(186003)(26005)(6512007)(2616005)(83380400001)(52116002)(6486002)(6666004)(4744005)(2906002)(8676002)(8936002)(110136005)(478600001)(41300700001)(5660300002)(316002)(38350700002)(86362001)(38100700002)(4326008)(66476007)(66556008)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/NyPUTRQifks3ng3fY3UyWvMrde3UKKjDnf4UIjRafhMDuOxQYHYw6kjiVWi?=
 =?us-ascii?Q?gdVYqieb+Nce3wF3ZMWhWXoh3V29LNClCLGZBkDRwSPPU6EqGeJMtvOVIbno?=
 =?us-ascii?Q?0aTnEwy29nkfwg+Hk2PU1gMzJ/xzxPNmN/guUIP4wQj5DIqcG8kQOZ/fTcxi?=
 =?us-ascii?Q?mX5YQToXuJ0LzcpPhcqAS2l666Vg5/P8PvYmBTI+XflmuWeSbivQ0V/ptW25?=
 =?us-ascii?Q?0DpDT67aPQh8wUjISz24jqv1JKJk9QgJId2AFmbjFfsbTCvCShBZzZRazs8b?=
 =?us-ascii?Q?2aMVE61YnwKs4IEFcE/9fA4BTnm7UvAdLPxJ2BH7+qQnrmln7nMUKs5gpuwY?=
 =?us-ascii?Q?Ur6uzzM/ee6SyRJ2EFBSvDH0yBIH+ZTsiZ95A2PcqZ0MSpAdFKQFvZ6quWAa?=
 =?us-ascii?Q?9SST+oFiy2n+5PUHy5mZNJ/5JcHq10Ysym1JQCo9/Z11qcVGH+rauunqKNFa?=
 =?us-ascii?Q?qv5IUgbHEI1dwaAxkqL4u4BPW2qGURmyRtLBzkAbMzhjpygSjK6lpeGclZP2?=
 =?us-ascii?Q?YK7bzOMSf6UOio5VippeW+qhIi+5XpcIi8NXepYL8J5CXEFgPJREPNzuv+j+?=
 =?us-ascii?Q?92z3TxcvJEhAP1LNG1BNK0x+9SIwfoEv95lB9TXBZVSoiZa/4iaiX2w92trp?=
 =?us-ascii?Q?2o4gCRF8h7dvareQ1M7aux8J+UGph6ThWqq2gVZfSQpUhD+BNeqig3lB4JEa?=
 =?us-ascii?Q?WvN9BKzxT0/pQHYiS7xZa6HGcNPMN7WDrVyeVzRPf3cAhaOwSP1QA0ZCE9bG?=
 =?us-ascii?Q?y4tT0Lc47vWyQPm7GGdXInQ3r4sfJwQuwI2lVSw9jOmsDhCvLsHqeCoXVM98?=
 =?us-ascii?Q?okKK70Zn0fSJLJdvhNjC+nZvURWaHHisEGhgBcIZgJxQJrhdukCZ9rdwOQES?=
 =?us-ascii?Q?5uHo5OiHEpJvz45DhoxWTM6LXS4U5mADowFyr9BbFCR95LQeWtOOrGgcz7G+?=
 =?us-ascii?Q?PhvrcO5O12thpyZs5YQP/g2G9ZIbu45Ew4v7gMWJMELBnDeA4EArlNdlOKiN?=
 =?us-ascii?Q?xLulDQgqm053e0Ell7Epz++DM5WBDT1oCPpTE6luCjycu2aQaPS0PgOYNpWe?=
 =?us-ascii?Q?68WKbRXLJw3JXiV7uiTPieTSIJDO1a3jDAFv16PP+9Jf86cqBocWpxNizMRk?=
 =?us-ascii?Q?bhSWfUELTHrs2hFEAye9QcJWBrk6b89FfDstb3Rz98xt0MdDaNAosWhUw+AQ?=
 =?us-ascii?Q?RWzmRIvQG2WfAyGiNKqMahVoYJuXa4zd3CLZVr5gmwycooPqs6XhUxkkfrt/?=
 =?us-ascii?Q?knlzDbEFhj2m+/YTvyk4AGgPipHhPzRAPY1zESSx1orGAqp6blAUabhYwcNq?=
 =?us-ascii?Q?Kow9sXbEWXe/3MxbBfQmosGMHMkBuhXQ7XyMBX1o2Nt3XpMCDKVsMRVSwlq+?=
 =?us-ascii?Q?aZBcRpcnmGYnvCw39Y7VuLeKea8zDqQMPiLMDUwUuezGqsr3sVQ6rokY1bjE?=
 =?us-ascii?Q?LXqquzTjLlEZTjWxpXGV1EjBkda/h3H7dCp+Ouzn/DRXobvfxqdnUkxb6efu?=
 =?us-ascii?Q?QJe+58R+HsRP6GQq4rTrR6+4DnoewvkcP94DOkeLGu3bR5/mXegMWv/DHkFC?=
 =?us-ascii?Q?tJEgIz72wMNS90umgGwaifi4Etp2heAZ6Mw3whxGGy76O82gA9FtkAYdoMZ2?=
 =?us-ascii?Q?Uw=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 377a1352-ecfb-440e-a4e9-08db6731c33c
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 08:32:43.1132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DH00x18ptTWAQoPpvPNhCBu1vwb7i5syYSjB9SW2DFaY1MDktKkPjInxOYO/kb1scBjT4qDmlCarnwawPA6YLZW1KnqCTsqc1NNoWtrMAH6kqN+su6fE1LvX4L7VWMqE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB6304
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
index a3f1c410b417..f8b4a149eb88 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -702,7 +702,10 @@ static void arm_cspmu_write_counter(struct perf_event *event, u64 val)
 	if (use_64b_counter_reg(cspmu)) {
 		offset = counter_offset(sizeof(u64), event->hw.idx);
 
-		writeq(val, cspmu->base1 + offset);
+		if (supports_64bit_atomics(cspmu))
+			writeq(val, cspmu->base1 + offset);
+		else
+			lo_hi_writeq(val, cspmu->base1 + offset);
 	} else {
 		offset = counter_offset(sizeof(u32), event->hw.idx);
 
-- 
2.40.1

