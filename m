Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB47C63FF96
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 05:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbiLBEyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 23:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiLBEyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 23:54:31 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2041.outbound.protection.outlook.com [40.107.96.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93493BBBEE
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 20:54:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5UdCvg0JOGXlaDjFIfRkgvSx6TcWxUZghufo49NW5UcjoTO+b4LK7S67FbFEit7TV3PhCM2/yg4hUYTs+J9oEuhpCW4qrkEZayU9ppnVUVKmKGRX1HvfTaZQ9vW/GqK1uv4j5SQU10I3eJcBB6JreZYGM/DQfxGOQCz27BMOX4r7Dr9ldDQqjJoR2Y0WZZSwfspXHnfoS4vjNdxYTNl7SVI/hNT41/f6g7K4fal/0sSsAymcsZnytaGIjE/sXEk4kruxlAN2cqzUOILwpdOAa1DSsWEOv2w3rIlYSMVOuRWBtskIX74I5HwB1mUCTxb4pLmo2QEM2tjWHb4nXQhSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eYItnzdsiY3AEfcdQW8RpuMJ0B/+tTQHWpJ8gVWAbE0=;
 b=areq55xvDkdrkZrZx1Vv3OVNQWI6VHTLa7HUDBJ0zQXnCw+N5WIRV3zc//mk/LhiRwi4l1AK4mtUibYrkOki9p/t6RQxMTsZzNyMI1wmU1T8ZrAUkJZ1cPLzcWEXeARaI+9YDDWRqxd4JVztZTNxHMvV+fSa4fV/7tVcAOZk2deae9V7uAVJqB+3XEyDJ23GZT/cZSuxPTLCDjeRyIU6TV1RP997eP+5eFmc2+rnZ2Q+uisXHclaZeGWc23pk7PY/NG2WliWNrHGXqLqwjXcigEhco2hoUs/Ahb8jmUyyB+vPV2yD6t/CRqGazOgI8m+a/77l7sc3SIfZsBUeitzeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYItnzdsiY3AEfcdQW8RpuMJ0B/+tTQHWpJ8gVWAbE0=;
 b=Zpgw7dvlaq98UwjcBgWtLh7KBjNSnYDYFKshBjUzSTVFLFogjRMgLRHfcStjYumQTtLkPm4aNnghmpd9sG/aQFuL/0eDbjX0RYuaG7Vdmo/jG4gT7gbc8iO1encEe99EevRKTwdyEOOi2Y4myN1N84LpX++DBhtxy0PFJYh/Zj8hAGJ+uToE2NbpHUT3C2SAIXuxD7MQX/bPJVHro0PNd5gox5mk6o3B2f+j9SOFubZS3CSXRs5yxuyadazrVGWcLFtuYGGM1UFR+rXhN7ZbYqjlADHklFBQ6LHNL0IsHGyjORRrjM1HLxGZeYDNB7xxkFrQh2Td8h+oynZlCDJQTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by BN9PR12MB5365.namprd12.prod.outlook.com (2603:10b6:408:102::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Fri, 2 Dec
 2022 04:54:28 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::ecfb:a3ad:3efa:9df8]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::ecfb:a3ad:3efa:9df8%3]) with mapi id 15.20.5857.023; Fri, 2 Dec 2022
 04:54:28 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        liam.howlett@oracle.com, Alistair Popple <apopple@nvidia.com>
Subject: [PATCH] mm/mmap: Properly unaccount memory on mas_preallocate() failure
Date:   Fri,  2 Dec 2022 15:53:39 +1100
Message-Id: <20221202045339.2999017-1-apopple@nvidia.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY0PR01CA0002.ausprd01.prod.outlook.com
 (2603:10c6:10:1bb::6) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|BN9PR12MB5365:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f1de8f4-ec48-45ed-6519-08dad4214adc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uH1z3Ra64mFdBZDSENTchW3XEaq3/TCUNQI5z+A+y+biGtg4en+Bl9+PknK7Wz1hK3Ef5LpP8UjRgKrVODEEoTlWfoBkE10h83llINT6KOpebDMIWMF1yv25F1pWQfAouBMqs/+bJr5TyzdIAtUqyVoJUBTTkUnKea7w9aludT3nMsqFXFjnXPmOuDSwiILeXIS/LMfv9f7GdFFVjWHvV2Ct8DFxCR5l7VFDHjvbDRjb0O1gxci2dGeLnp37VfOFQU5oM+R+fH6iZRbQZGdjYi30+Zmn9ZDHSFlutwj7nb56Lek5strV0WEGwA0SmzMeC3YX5Cam52ALXQP3ijN0T6uZqNaLfU+Br17OOn1bVJaBg2t77Tfzc+nq5piclTkgl1DGVaXKZ683qTiz4Xh8hAXBKfkujpUaBjzM+G18hwXxj1rno2VdA6mlInLe9CFCaujq0uEjB4d8J0MHPdSV2WBA9CCYdaSQuw/kUxWbo0kjcLNepFiFqHdaI51eF4jLPyOOCsJhvy0fPWU0QpHpNW2a5RSGCvssVT7N+qFSoy263m9e4ehgNi1dwVVs81oUaRYutKkajsI1Q3Z+ikoAw4xoC4ooBCzfn3NxLUqjf14xGpuOoXeV9McTZs2bLe5kHCa6cNehHwW4SaqpvBW0Mg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(451199015)(38100700002)(6486002)(36756003)(2906002)(66556008)(8676002)(5660300002)(8936002)(41300700001)(4326008)(86362001)(6916009)(66476007)(316002)(66946007)(2616005)(478600001)(83380400001)(6506007)(6512007)(1076003)(186003)(6666004)(26005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WWTF+z1+mvmWkRNvzHSzr1J4wjY8/e13zchm3QRKR/9KT/QIWwtimVFdJNoP?=
 =?us-ascii?Q?FjwnMX+t3TRIktXcdM8gptCea4NBRLTK1FND/7rui3UZTSdZrpNWBb8VkL4M?=
 =?us-ascii?Q?WeFgi0UmV8hJjTrgM0Pqbcl8QFXuromD9BTZUPed4hD336nOYwfvrrjitTRQ?=
 =?us-ascii?Q?ps64H1uF8u8J0SPpKLioE6/rIvcvUcft3Y2PWvysTCV7LeO5Q+qihrzC5vsP?=
 =?us-ascii?Q?7SlvM2wcRmsGlEzIMHrgmV2W0LZvLN07c1PgkhuEAZiY/WWet8NXEopYVFkL?=
 =?us-ascii?Q?MkRLYn/hls4T9GCXZ9tkGmCYEJEGwIhAoAXyJh/uSMpXtQPOHtpdJr03IGzr?=
 =?us-ascii?Q?FWth8Mg5+YZBjRfZLtWiZWz6UoGHQeN4ZwDkRK2HCgXCS8MGlCgeM0GD6hDl?=
 =?us-ascii?Q?DpUYzxCswO40S9t8id/tDYDnTWkSXaNgtnKSUKY0EEqSkxz/YrajLbY1CqdA?=
 =?us-ascii?Q?fTRWs7Kdle0LIoyOsHFb00ADb9sK5y9YjIVbkNcI8Dt7zDwa/P6s8qP6GT+8?=
 =?us-ascii?Q?gdSf1FYYBOxlesd2rJvbspzZgYePbeh22sb23rL5k9CxI/AcsLloLfBV1/My?=
 =?us-ascii?Q?fkkEsbGEABZmYtX5cy4/IZQ3IzboyFP3Iivan2jr8nEDzw9zLZQyrpP2MtAw?=
 =?us-ascii?Q?+a6S/wWd8rD4Xu285bqt7WAwD/jWZrgQFyMWqsKvTzxFZSYoWt6Kx+CyygeG?=
 =?us-ascii?Q?3B9Tuy9rr7jEnlwpoaWUA8tOmnzTBU13ly9MwIfNi9c7uYghsdYpDevfmLp1?=
 =?us-ascii?Q?2M0tOZ21mjpp94rAYKIFdhoAp1Tl7Q2OXfnZzpNIC62Vjdb4Yy7zKHAgpIKx?=
 =?us-ascii?Q?/yQK643djKiVgi4ltimgPwLbqu1AsQtyvHUcWvEkjjI+CJGgAKln2koBBKrj?=
 =?us-ascii?Q?gFrwfhHJPJWrDSEb6DL9sXA19L0YeaAsHgCoyXlNBpKL9k+bZZoIm4iBNkms?=
 =?us-ascii?Q?Z+BiNfjlgyJTXz3+PVm3urfgfrhNQZyL8QRpL7ByM2kFbDJar1aK+YCJ4JEX?=
 =?us-ascii?Q?017h1aHaKo/cbKc+lox+baOrDGBr4gibioKA0JRNFrgd1BAzVwkvsBSqNTEK?=
 =?us-ascii?Q?kIeWEt/hBm8cypySs5x72xX7yegM+92GpaRTQb/9JuysK1YXtntctgpS+pO1?=
 =?us-ascii?Q?C7LM/ka+CjO5ZtEiW5V9xZTNN4nJ5HHH81GvDXoASDvYHbftXGsLlhkCfP4F?=
 =?us-ascii?Q?wUYq2PQD6CAGhHA0gS+qrUSo1fODArHjaR2qOwCjS5ge1zasX4i5OYQzdmEn?=
 =?us-ascii?Q?52kW6WT64AJetrz6ZdtKJL0w1R8XYL7Ue1CvkZUd/duuhqJzgQdQANnPTCGC?=
 =?us-ascii?Q?mT/8Sjwyz2GXoX74dH9y88cMaX2aW/5uJsyrEgWc8Y5kI+swdUJXqkhudbVZ?=
 =?us-ascii?Q?7NzG1V/2D69ovx7AlLV/rKozjupBReGKM0wpINylJ0PZhKFzWJKpe8ensJxf?=
 =?us-ascii?Q?dM6gQ8Jy2wlM+KHotDvEgiCqbP3FOGr5yW295xifAe6+JJd8qdq7SBbTuZEs?=
 =?us-ascii?Q?gJS277zdNwTmksVpCzaTTYOvSzuY5Dss63mupDxjOAmdG612uVsppqRZY5zN?=
 =?us-ascii?Q?ZJigqEmbE1WIxXCbsqI9AXDW3SkyGuweDCr40SZC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f1de8f4-ec48-45ed-6519-08dad4214adc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 04:54:28.5219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NHf4E7bOco7COCPRdHU9zoY3l0shxBlsKGibjwIl2Zz2UeT+1pLP9qaCetmknF+ZGlnrX6ghl97I1hqTrAR1wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5365
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

security_vm_enough_memory_mm() accounts memory via a call to
vm_acct_memory(). Therefore any subsequent failures should unaccount
for this memory prior to returning the error.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Fixes: 28c5609fb236 ("mm/mmap: preallocate maple nodes for brk vma expansion")

---

Pretty trivial fixup that I noticed was needed while working on the
code.
---
 mm/mmap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 74a84eb33b90..3e50a571c3c4 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2954,7 +2954,7 @@ static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *vma,
 	    ((vma->vm_flags & ~VM_SOFTDIRTY) == flags)) {
 		mas_set_range(mas, vma->vm_start, addr + len - 1);
 		if (mas_preallocate(mas, vma, GFP_KERNEL))
-			return -ENOMEM;
+			goto unacct_fail;
 
 		vma_adjust_trans_huge(vma, vma->vm_start, addr + len, 0);
 		if (vma->anon_vma) {
@@ -2976,7 +2976,7 @@ static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *vma,
 	/* create a vma struct for an anonymous mapping */
 	vma = vm_area_alloc(mm);
 	if (!vma)
-		goto vma_alloc_fail;
+		goto unacct_fail;
 
 	vma_set_anonymous(vma);
 	vma->vm_start = addr;
@@ -3001,7 +3001,7 @@ static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *vma,
 
 mas_store_fail:
 	vm_area_free(vma);
-vma_alloc_fail:
+unacct_fail:
 	vm_unacct_memory(len >> PAGE_SHIFT);
 	return -ENOMEM;
 }
-- 
2.35.1

