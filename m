Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C9B7017EA
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 16:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238500AbjEMOqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 10:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbjEMOqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 10:46:19 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2057.outbound.protection.outlook.com [40.92.18.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F8F3AA6
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 07:46:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QkSA6j/X4Z+rp24NmW72NGi5CH0eNWnUiOQRXfECmTNrj1yqIQnW+ACl6Q2cccIH4QwjCy0VK1Nb46lJeDXHKdA4SISFa6QoTDzpbsJ8rcJWDlRzxfAGCDaP38cphz6YwjImPPoMa7Vus6tohLsQ6efAb/P/q/lQf92qIfKAHNa7EbvQ8mPB+M8vowYEa8xVWxjQ8om7HVfViYMYU1+FdxlHg5XL+X0ADpPmLKA9ypC1nbnxzrZ2pS0MNZYRokZi0frGIycXAx+7tGvCDbLcshs9gEHPWeT9gTPCLuHcbUgTfVAbk5+GP3dx+dISQGBWlPHJew7OiOxL9XqmTeGBiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QqjfHygK+RUtnCXnLMttbbKxL5rcOWChexL8SNKSU8Q=;
 b=cheI0c+d7UaLAJOr54p/n2zgdxZIFBVO9KQtKNphW0UQXUBcNry4RJ9Yaf2UTCSvW+zSsjMLbriq0kGrmIyQp/8fS9I9clKqGk4nsagv0ZPUJ+m4CqV0bp5UGC9MYob6R5JF6S+tJOsw03yCtEOi4cw6dVZgBcc4IXyiR64h//eb+j/dfQyH4jn+f+LxDKkiLr7FNK8A+YIgJv/OHy54iJhglTNudLUKSQDeARmCHOGFhj5lx/MSejxNYuoIfncM4cNEueRL/Ap0bkcC+pPbHrYMqJ1GQ8Eh0rUeXsuZaaxDg6FUJR6HGO2o75HXXfXAkUxdkYM2tZMMF+mFo3ziig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QqjfHygK+RUtnCXnLMttbbKxL5rcOWChexL8SNKSU8Q=;
 b=qCl3CQpSaEl2pCRTSG7RK778B3cgSeQR4qjyeA/FS8GCDYbSesaM09Dqi+1pQWmuNss09DPLkqek5cnFG5l1zsjFFackWpOTimrl8ulGrXBeAVOpGSXrxwmMhWyp757z1x+nPnga5KGvMECXSFXwKgAyPy85yW5umaibIdoW+XSFRnDc3kIfz9o/vHauALW32ITHZ97wQAJkYQD9ihf8XrotafUI2UFIJCwXTPbKJdUU83A7CbyE4PSj9dBg+XjxzIaRywE6dZGOf5JjVva/IoS7+d760fq8E7T2sCUwn2NGGVognHqViMC4m3RgmMZabNa10QFQMO9ikMnkw638Mw==
Received: from CY5PR12MB6455.namprd12.prod.outlook.com (2603:10b6:930:35::10)
 by PH7PR12MB6657.namprd12.prod.outlook.com (2603:10b6:510:1fe::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.24; Sat, 13 May
 2023 14:46:15 +0000
Received: from CY5PR12MB6455.namprd12.prod.outlook.com
 ([fe80::eece:c2b8:c7ea:a6]) by CY5PR12MB6455.namprd12.prod.outlook.com
 ([fe80::eece:c2b8:c7ea:a6%6]) with mapi id 15.20.6340.031; Sat, 13 May 2023
 14:46:15 +0000
From:   mirimmad@outlook.com
Cc:     skhan@linuxfoundation.org, Immad Mir <mirimmad17@gmail.com>,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] loongarch: fix debugfs_create_dir error checking
Date:   Sat, 13 May 2023 20:15:29 +0530
Message-ID: <CY5PR12MB64557005ECDAFFC89FC8C7B3C67A9@CY5PR12MB6455.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.40.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [FZBOP/zqqhSB1eBn8dYsU2ozcboGbYjfmQEuDZGFUQeWAiWgViJSue2A2ENZVpey]
X-ClientProxiedBy: BM1P287CA0014.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::29) To CY5PR12MB6455.namprd12.prod.outlook.com
 (2603:10b6:930:35::10)
X-Microsoft-Original-Message-ID: <20230513144530.140410-1-mirimmad@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6455:EE_|PH7PR12MB6657:EE_
X-MS-Office365-Filtering-Correlation-Id: e08031b5-e9dc-4061-b4d5-08db53c0cd34
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QPCkCNus5tkYGAJKRayxPM77KPQ9B2hKUMLDubZqMtj8tVWF/90hGa4vfNP+p3EAlkrz8FN8RuNhJkxSlJTwbe6bml4l9d0DaNakrxOYPA4YQsKbdDCZRbbIfMMnoxB3v54ggY3xVrt5XL6tutgOnOrAz1qx40X7VOvHbKPzHMlATbfVLSpmghjT1P+ijGHohvnOG7aIjKtoWmZZzWywzLNdltEtsdUGXwiC4UVCSAPp7dXIlvLdUSHzOomCyo633lTsRekslp6oARzhNCihqeQIHJJ21BudVWka9uG5lzSCDCbAlQgZlwy1RkOTR/Yg4uJWEVXpapOarEfeaXdpjBdFRNrkECnMylJfjJgBcVUaqTYT7tCb7nKaqmaVX52d33NBkhG1PLZpQv5ZGL40cvYuIFLSn4P2gTXdl1lG2heTVLdABShk6DkuqJQEfHEBmfvQEOt7U9d7mSxOAXIZw2z5g0R2KE1mCGoAgfddKmRspaJXH8lphLmGrQRoy1AE4Wo2SimY8MV6eWuD9x6IbT2davRyVpuzL0tTTAiWVdQpDjT+EBziRel/gsCoskBu
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lWahLwpxr0foIbJ3eSnDMRgKentKpF76eDj2iAMSjFw79VUVwSIycHw/kPdm?=
 =?us-ascii?Q?7D02r3hAfXYOzgkfRxz2LHQUnyS46nNNqHQbjiJ8VHecKH00rPqDcj665eps?=
 =?us-ascii?Q?bfRtBrbtH126CcuZgR/Y+/DhvBH1OHGgZrvtgcYXf0oeezNL867MGnUkASjl?=
 =?us-ascii?Q?e1571aXZmS6yRD/NB9Y4EaJzXl+Sr15Kv4w+OlwjWKtTDYElC8cze8w9UYxx?=
 =?us-ascii?Q?gXEjoy+O1q4LILrYQJvrzc02mjFAJWF82QSGgS9Qe0mScH8bDMa5gEOUg0yR?=
 =?us-ascii?Q?Tmclmt0MNNqLkJfNpO52YotNF+hYm142745CHC8R8yBXeDyxHEa8xZ1rjDjj?=
 =?us-ascii?Q?KugFLTPIG4aHr6x3h6PKcvWkKyIg1570DrQgMGrEk3CPPV/OBpoXM3UNlDm2?=
 =?us-ascii?Q?VK4t7IdBrcb0LbYmT1C2yFhmUraFzd7rJK4dQK8RYdslKT7PNTrFoRZHbPiy?=
 =?us-ascii?Q?tVAMr+d+EcLxStekxAtP69ywqVd2vood07uTcieuDtKLNwD0GyoycNdnsVXe?=
 =?us-ascii?Q?oELaa4hPhsqQGRiy9tV7h2gd7JKzQyEclVazytLLItNXM6NLznSACl4Wf86l?=
 =?us-ascii?Q?aUc+2SPQCQDV7RwvB7u4t0ugBrkWwPQh3/1MR89CmaKE5JZiyHQC1dwffiJt?=
 =?us-ascii?Q?9txHPhsYzAZ6uZIEXn6Z/g06uVXNob1zleNE9G15iTQzLr0dMvwPdQjTZ/+4?=
 =?us-ascii?Q?8BDeRiWjrQ3C+v6Dc3r8ksvUvTYCCklFVRcbUAJSgHPHz/IZ/q/pU7nynvSk?=
 =?us-ascii?Q?qsnZj295nofXEPZ2YucS8PO7P1F//8FCPnZxNOvPVt81jYI+7OcugIlLCtyb?=
 =?us-ascii?Q?3CGmf/AUV3kgZBPYQypkb4tgKcm+ar88TWYpiTzroJy/t73nyPRCzeekUO1a?=
 =?us-ascii?Q?tcGl57Orcwgy94lmtE2nuKodVdmH1pCZfj1BGNxPHgsNBubd4yFOtAm8ZcFY?=
 =?us-ascii?Q?YwKdsvzu6EOOdzWhpTjxXB1qeuMdMCkdznQdCTyNrnfKr8F5pFoljXZqyK0P?=
 =?us-ascii?Q?BggisAJ6K15Tbiuq/PEIECnwcfEV5SaxOe2gOTCrUVWZ2EDo0saLwpoj+wXQ?=
 =?us-ascii?Q?ANy++3u75hHgLFCDEZLF1C2frHBFCyEnYBXTd9wctG8+EVmmIV4fro/L07j5?=
 =?us-ascii?Q?1luP7lt1CgrQX+0fb8FscJgfn9e2SrhgXd5ZzWRfBC0NgHNkrcHMQ4QDyruH?=
 =?us-ascii?Q?JL46cbSaQgdIxk9y8nREmVM+JLzTr9Akp9LeNfU8nKUWcPKxnoKKTTnSRJEk?=
 =?us-ascii?Q?deKKbAr8TE46V6o9+yVCq/q7sL6BQwR82W8e4GLkpg=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e08031b5-e9dc-4061-b4d5-08db53c0cd34
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6455.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2023 14:46:15.1546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6657
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
 arch/loongarch/kernel/unaligned.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/kernel/unaligned.c b/arch/loongarch/kernel/unaligned.c
index bdff825d2..be2a5bdc5 100644
--- a/arch/loongarch/kernel/unaligned.c
+++ b/arch/loongarch/kernel/unaligned.c
@@ -485,7 +485,7 @@ static int __init debugfs_unaligned(void)
 	struct dentry *d;

 	d = debugfs_create_dir("loongarch", NULL);
-	if (!d)
+	if (IS_ERR(d))
 		return -ENOMEM;

 	debugfs_create_u32("unaligned_instructions_user",
--
2.40.0

