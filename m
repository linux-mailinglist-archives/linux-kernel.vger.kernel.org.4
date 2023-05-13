Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BEF7017FC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 17:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239162AbjEMPM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 11:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjEMPMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 11:12:54 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2010.outbound.protection.outlook.com [40.92.20.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A465C1997
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 08:12:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bELjW96sXeKv6uMhQrNrOeb6SkxV9qxX2xtz1XmbS1rbvqth4bsffldyZTocKt2H8cZ0aEQKwT8Ywn0zhbbS1khb5ACH9Z/gkIUPclZsZogntidONUwSlucdhHbUWJltLqAr8jkuKSmsvyaG8V98cGibG5o87DY6kIQtvIxDBmMM0Gk5TVa0M0iDjn9wtfVL9tY1aEDGsjY+cfa16Pyap8Ahd6jEvKvi5yBL0viY0qc0B+QBerWKhpQUHjCG17yHtSYYvE8u7kCeqQX7+63Ig+Bdy3niql/O2AX2hlZyJ5LZ8d+j/tYiZ1+1xzfgLcl2WI2q8vJjG6m1tnvNFjQ0NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjS1N65ZDmqs57j1FSHtVm24YWtFdEP1MdFyJtzlQ10=;
 b=ElA/MkriRhbEnimUCBhM3pVxUcfKvfDs79jOgMr6buS3rqFerX0HUYc1zzpQfydN7+AT2/y8stVk01xsyfY6w1UcjHgL4y1/RdXstJrfkYFvUlMf9F7qoHRay0JzwfJiZdhcmK0u4bfQ0bpiLELP9sVQfIagy6kyRlzR3XCohXBaTPrwRhSnkpt2FRHvQSA+8kPthmcReRkp3E95sGt6WSnoUDw7kzArmpaHdrHHUEPrGcw6jJ0OYMWjzoWsgDJ8x35O08NA/ihbfsjnBW/vJqYc1t3+rJ3t75dwMbEUKnILDwarTC1WZ3x91lGowk84qgWXcA+EfSmgR1GQDSyWfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjS1N65ZDmqs57j1FSHtVm24YWtFdEP1MdFyJtzlQ10=;
 b=EFe212MrmHQSMnKf8hzFGhu8CXqhaahx6mmq1rEK2tFj83JqJo0r6vlpsATsLL7B7UvTeN4mrLeiaVzwS6moOg2Ea6i9OUXHzJaFZBWUrNDpNPEZ1GccQWFNeom5Li2kBgF3s5RiNPnTXSvULB6jG8wXkJUfsAiFuB1uU6gYk+o/33A/8nHBZs+blqZYpKf3naBFZvplhVUfkyAPd+J4jaRQA+7YiQ0zmvvscGSJWcw0+/Zbyl9+nyKiq+btUKsm5Pf0y+dlt3Z4No3P08gbyOnJ7SvoDN09aX3LAAxWzeK0d6Ty1b2KstM0eaRUESu0P2J6xYMN6Q/vN80TIyWUtg==
Received: from CY5PR12MB6455.namprd12.prod.outlook.com (2603:10b6:930:35::10)
 by CH3PR12MB7593.namprd12.prod.outlook.com (2603:10b6:610:141::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.23; Sat, 13 May
 2023 15:12:46 +0000
Received: from CY5PR12MB6455.namprd12.prod.outlook.com
 ([fe80::eece:c2b8:c7ea:a6]) by CY5PR12MB6455.namprd12.prod.outlook.com
 ([fe80::eece:c2b8:c7ea:a6%6]) with mapi id 15.20.6340.031; Sat, 13 May 2023
 15:12:46 +0000
From:   mirimmad@outlook.com
Cc:     skhan@linuxfoundation.org, Immad Mir <mirimmad17@gmail.com>,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: fix debugfs_create_dir error checking
Date:   Sat, 13 May 2023 20:41:53 +0530
Message-ID: <CY5PR12MB6455FCF0BD8CF075FA6C8386C67A9@CY5PR12MB6455.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.40.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [f4gXV2RqkrTCkGmMEzT+BSG7noXHnHM67NZHcHYLtYsbwPQfsqtB1GCn6VNfZWHa]
X-ClientProxiedBy: PN2PR01CA0236.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::20) To CY5PR12MB6455.namprd12.prod.outlook.com
 (2603:10b6:930:35::10)
X-Microsoft-Original-Message-ID: <20230513151153.266877-1-mirimmad@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6455:EE_|CH3PR12MB7593:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a995d73-8bac-493b-3842-08db53c48191
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 28AacB9tP8OfoZFRRvkJEFVSFGZdvwpBdWsrAGyzb/k3cVuRDmlzxFbysr1kHGO4cajjbCOtp+hEXuB+PPaGUEpgo/pgpoQXAQwoDBO6AzWOam5nqpPlUzSNPC5XFtk1AUVbWKTXzdktYCxDm/tGOlealuAcKZ3wKQaY/nX2/N49ljRlIoK6UUC18cLHE8v7zuPl0bsqSXJxjo2YHFUsxD7casdw1PzZt8CLlQxsAlst+xYoUQKTBSX7ka35mTpRWY4aZqZP8zBbkEkVe0KHuFr1kjTbBtrTPbjYARm/VN7Kpax6RUlAf5o2CUQHcPlBt2K7Lml94Bzo/TRE0AKuGI6sKVwjJspWftoNsORCAN+sCnySyP7rwayiinmea0kneK5hlMz2t65RnGgnubwqsJTAEoanTcGhIzWDtoTVUZwBWclnLKayoYsQbXlm9Nm3cb0AAR+k7AV3pO+ESbtd9b66ME/soTOCdZrc3FscbUo5tc+3UjMHyoeGZSZpJn1Pp2CN6lTeUVDwnim/is2FAa0Ib/YrJZYInUyicllLIsxD9ULskTptG3lii2/SDF2p
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZXIoLlEtwJJdoG1FxJoILjFFqQwALnBKQ15QlcPjbWOrfBq0ELhiXFpNAWB0?=
 =?us-ascii?Q?ZFR/G+rFOozAxJYkZFp8Ld+/pNvDdTUYO4f1OLIV+0AMZFYV8nqYvXGfaDSa?=
 =?us-ascii?Q?FZ7pdEvdUyI0egbAblwXDXWKxvy7EZXpEJ4HX1Qo0Km2nSPh1x27CdIG/8ub?=
 =?us-ascii?Q?QgZAqzr0mU+Rwfdf27/WkmfmwRTi6pYQbun1RA2KVeSUBYi3sEgYI5eIMXO8?=
 =?us-ascii?Q?sc38aX8mS3PxCWZDTItpbFKH7LIGb+Udc0S+jtAPuQZJ6i844Xwj1Hg5bx3N?=
 =?us-ascii?Q?uUPW+OBpIE2zLUAmTvxDlW+0mInOjPMjy1WGasDKVVqVjT2Qx6El8s6U4Dl/?=
 =?us-ascii?Q?+l3X9mFNzQXJLK8bnWCpIGVpJpeaxXVPqYX8XTCATnbZnIEKIz7sHYADxj52?=
 =?us-ascii?Q?ov0b9pBlorbD0dNoNeMspP4co6lLCya89nqrgtNyOseuahomNNWEB1fcRksg?=
 =?us-ascii?Q?8z0U1gv4qyKQk7xHRW6p11uoRExSwTcVr6RNLEvjQC5CGcinapa/Iutt7dyu?=
 =?us-ascii?Q?oca532siSPPj9/e8DiBNxW+qRmH2Q9k2kjQP+sLpWjuP14CkwkdRrDXSj3Hr?=
 =?us-ascii?Q?WGpEbXEsZhwMkZcYpTqj38Dy1JPAMe3Bz9oM1Ezz1bOjWHVyqA+3NTGp4wmx?=
 =?us-ascii?Q?UInAANn+BQ9JGgcu/67dU3DvE3+WN13Xq3uRg8NQI0VMLWftVRPyZ54gTZY3?=
 =?us-ascii?Q?a1hGCkKRJ8m8MX0yhdGV28yYVUCqH70HIE7WBRNGi5qKHuXh667L6H/bkoRx?=
 =?us-ascii?Q?XCnKKE3R7VDYIcF6OHoLnwVVjGlQvyeCUrTD6JZ1WVZvtLRGIDf6nhYPdian?=
 =?us-ascii?Q?tl6tdIz6znRSoIzX9Gas4si3SOD/1dOzsBS47fsAOp8ReIaDu9NyvdU+z7gs?=
 =?us-ascii?Q?FUkTA/5iAjvo+GlAkPjA2A82/FB4IlKqXO52bZG0lR2N6h8GV/Iah8GUo10g?=
 =?us-ascii?Q?aIAroTIfbKJE3pU2TIItQNpmWu1+juc4D4/owtkUv1IsUSEdPy1KhPXbCR9W?=
 =?us-ascii?Q?pBX3p7fGSIO3SSp/SXEHOmyobog27mPNAZ7FY11mYmWHzTmrJQBB0j7SdsHu?=
 =?us-ascii?Q?HRo3bKH6RgzOF9YAnrbl2esWV4RIIQDEJDIWkCRe3W/ldvrAKMjv4t6+ZV6t?=
 =?us-ascii?Q?MGB2ja95IdpiBR1OCmi/sunsPIrQKAxhpmre5Px238j8A3hTV93DsXL6BqZe?=
 =?us-ascii?Q?0pg4kI44pfT8Dv7H10+96cRhcd7cDLFSqS8IhZ204B1f23aKljBLJXoVmOz+?=
 =?us-ascii?Q?raQUgBDBehHCBlhFiPpNTaZNgJaY2UAkmrsTPZ6gOA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a995d73-8bac-493b-3842-08db53c48191
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6455.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2023 15:12:46.0372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7593
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Immad Mir <mirimmad17@gmail.com>

The debugfs_create_dir returns ERR_PTR incase of an error and the
correct way of checking it by using the IS_ERR inline function, and
not the simple null comparision. This patch fixes this.

Suggested-By: Ivan Orlov <ivan.orlov0322@gmail.com>
Signed-off-by: Immad Mir <mirimmad17@gmail.com>
---
 arch/powerpc/platforms/powernv/opal-xscom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-xscom.c b/arch/powerpc/platforms/powernv/opal-xscom.c
index 6b4eed2ef..262cd6fac 100644
--- a/arch/powerpc/platforms/powernv/opal-xscom.c
+++ b/arch/powerpc/platforms/powernv/opal-xscom.c
@@ -168,7 +168,7 @@ static int scom_debug_init_one(struct dentry *root, struct device_node *dn,
 	ent->path.size = strlen((char *)ent->path.data);

 	dir = debugfs_create_dir(ent->name, root);
-	if (!dir) {
+	if (IS_ERR(dir)) {
 		kfree(ent->path.data);
 		kfree(ent);
 		return -1;
@@ -190,7 +190,7 @@ static int scom_debug_init(void)
 		return 0;

 	root = debugfs_create_dir("scom", arch_debugfs_dir);
-	if (!root)
+	if (IS_ERR(root))
 		return -1;

 	rc = 0;
--
2.40.0

