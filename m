Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998FF701C03
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 08:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjENGoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 02:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjENGoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 02:44:30 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2097.outbound.protection.outlook.com [40.92.40.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F39E1FED
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 23:44:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5k+u/Gy1kZ81DYPgtQdnNQuWEzukYXSmDHF9hzEBEdwY8VHIJPo1xMRDnj2nsJ3pAWp3WPRVI0pn26lSYqOZbEhGXM/nPy2vaKnltaZYJiztB46FvBmihSsAif0Vflgb94qoVPeOxZ/Db7TVwziqDETO8JG9UFjkDycpEFCCJg2ge9VgV1Jib+APUAnC+5+iPyufmfKfMtr7pLM3JWNy5eysuojZmaUcujIQnzOLt9XwVxPeILYz/oo5cIoZ6Bl57tNdFnleFg9Fd+1kiunA8tsY+2gK0KmdmsPKYFnTiizaNgKwbX4Uda7Lh/eac5zXgzOduHtT8JdYcLyc2dx5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFojvHt4yblPll/23JiNXv0wkZ0S8N5BnD9OglZLvXE=;
 b=c5IvapCNTOVLv7jVQ54pNi44CBlrgngd6YeWuvyuu3s7h0Nyv84mD7Mf4G2jIQmlvqJRXGqPy9Dvm2GzE1u/ztc5WXA2f31p2ZxYOoEFPT+ztqopFZ3y9DFsSwxjCIYpaLyCmBsIx9bsORmC77/9ZbKz3byCWpuTvEmoUa8cFlYZCZZQoImE4wSoDUkcQkGvlhpTuJTBFXhMRjcrjQSjO54QZDn54b5ywtN9RhooXE0lYre9FPoDT87Vvfiss4YYomuiBI8m2oIeEsiy7jKCK4GOwmavMwnU+lzlZ1OKwF8m6XF2cbKScWymGBmaGv3FQrGfeu5BCsiRlcX8Q0IuRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFojvHt4yblPll/23JiNXv0wkZ0S8N5BnD9OglZLvXE=;
 b=BBtN/H1aATFwMgr/th31JvWPG4jU2AZLiiiy4y0r0rDi7y+fHvFWTe/+hzEhqQeoO0wpNgALY1hXrrj7tetPCD0k+p+eAi0OToAHjOSd5RlgpjPUZfv3sqngSL+cHrHRR9WlttI1u3qxmW3RU0USPLiBltF5uG2ZW3EcvSvBToEeq5oaMyhy9qct8XNRmsO5hgUkueW1CWNFzDM9C2Hwmgr2/aNSdbLJyw38jfai1Y46zcWYS7Uu7YTpQoVsBwvIrDAZUIL0bYAkGy5aLv2/4kSEcsS0ia4LywVa675FX5QZUYzCLJMy/r9mStHxP/CJS6LCvKBngeiqrRUJ6XtBBw==
Received: from CY5PR12MB6455.namprd12.prod.outlook.com (2603:10b6:930:35::10)
 by CH3PR12MB9077.namprd12.prod.outlook.com (2603:10b6:610:1a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.29; Sun, 14 May
 2023 06:44:27 +0000
Received: from CY5PR12MB6455.namprd12.prod.outlook.com
 ([fe80::eece:c2b8:c7ea:a6]) by CY5PR12MB6455.namprd12.prod.outlook.com
 ([fe80::eece:c2b8:c7ea:a6%5]) with mapi id 15.20.6387.029; Sun, 14 May 2023
 06:44:27 +0000
From:   mirimmad@outlook.com
To:     chenhuacai@kernel.org
Cc:     ivan.orlov0322@gmail.com, kernel@xen0n.name,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        mirimmad17@gmail.com, mirimmad@outlook.com,
        skhan@linuxfoundation.org
Subject: [PATCH v2] loongarch: fix debugfs_create_dir error checking
Date:   Sun, 14 May 2023 12:13:46 +0530
Message-ID: <CY5PR12MB64558068B314942BA1B2ED2BC67B9@CY5PR12MB6455.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <CAAhV-H48t8tDmWoZOSqx06HwwXKY1CR=X+hi0o_ok6gSu6dQSg@mail.gmail.com>
References: <CAAhV-H48t8tDmWoZOSqx06HwwXKY1CR=X+hi0o_ok6gSu6dQSg@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [IVcKfHWj8F5gRP9FLvLf7qeOVNpJFIHJbBhVex5aIJ4cH29cjop6+hiQnK+1mI/o]
X-ClientProxiedBy: PN2PR01CA0214.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::9) To CY5PR12MB6455.namprd12.prod.outlook.com
 (2603:10b6:930:35::10)
X-Microsoft-Original-Message-ID: <20230514064346.12744-1-mirimmad@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6455:EE_|CH3PR12MB9077:EE_
X-MS-Office365-Filtering-Correlation-Id: cbcabdf3-8e96-49ee-fc84-08db5446a972
X-MS-Exchange-SLBlob-MailProps: ScCmN3RHayH7ocfjk3L3dZBU/GwNzE2mxiG5SoRpMefMvLHfDuFax19edQ8/iL4YCvPKOSu06PvoasGFbLxvFJMdjxsn0WBv3dZUiLXnBjC81RxbUB2IkREtS2ofBiaCLOyNt5+f/k6bmmVPPTIuVe/snZAA8/jOcHFAY5aQqkepKg9OKHOZBG5ksZeeGJGOzUKh9S8eb1Ekp06dL+coxwBFaHv4XX3h3j5p2exPHpIO8kwMY1AugXpXPWTVXayqSwgtfdHM13JkzM35nQaXDvVGqsrKyK9tz6cIxRxcjy6ylmQtbSP5mlcL0EFEaXAbNPVbj9yMxnGHTWjPabpr61/F5Gj3bLbxJyESqgGpg3L22FIuelt8dSg/EJcct8uf+Zl3Zp/1QzP9sllTYvHDCUN0HzL6uhKcVrK4QJ798hwem4q0C2awms3sAZdHngD3vGUu1lQWHYbU9rarRTcQYMHXGQXOBfdC5/wyKYo7aroB/4I60DEOUNrszRkB4jtL//jbkI4Pefj/wnhLQT+WgG2can5zgZ2KUz1rjkFnIB48Gy+7TN960fTeEC8+3bu61bUlHOKx5IQxUg6tiaImdAl6ot7lKs2WXMZ5wGnWjqf7jgKqBvnh4MYPLQZgWmc5t4G46X2tRVY138i7aEtPj31BcLRGkso0g3s+CzCvESbEgTxGZjGt4bESvZnWNduvH94vR4PvoD6loDnAdhXWtjp7McNoY8XB3l307X+NPnM=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ArddcTdAKrc7SGAXsHX6vaKZbO0uM+BFGv+AkUO/Rnr22UaHC/vCv50TYUviXyIFW/NM0FZg1rjm1zIfs+Z4wIjjRiCGvU0+q4d43aSWtFmmMj0563yZV9KCw0KLzis2VApIXk39fifoISoTB/deW/vkCfaD+nRnCwR8pFSglxTTRC+BVsWmDAMqQIM9yG1SUUxHhbzLio2MICuLKrbL31x7AwfMFxci1A3Owo3kA8W+YxqLNXdkXDYsNYcOnVwoscxXFk15HbFSLgQWwGqIVWzgOFt39yn1+AornaCAohiixJVDSvZZhTwU1d5W7HCt8mgjxK6XsacEHO8JJ5JYRDVJmBWmPr+ZtAtLTRW/jLm4SNb7YFImKgOr9xWQTgSgt2Q+nqBMQoLyQ0AfhpI2Okbm+0u/EStTgU9T2PNVZ6ICfJaPAB7NYWB0Xz7gtwWjIc0MJ8f5Npi3jIFhVVht+mxlS9smlMXJ9HJxXs2Ot/qlCzZ7zadRUPpn6oIKpZqUx8G89XY4HzJUX+l5TkSfMgmHW4fIVAfv4HUifGTFWAI2eaxME8lS2ORufh6Ijjv+13s5KYIlA2AyGhCss0zdjwD14BGU/jZFTk7GXtKkw6yY6BxQOTGtqgNfrYE72UtQ
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gIUCl6Q9Rpznz7mwyU3wpQHYT/nmB0B/rs2CL+MB0MIByE38vMPdK3cemprP?=
 =?us-ascii?Q?VxXdeTpYaLMEFgM/umiTWfr3zPxM57xni4xoy/iBpnDWPFx5KCN3bCrzRhuT?=
 =?us-ascii?Q?jefSI/7fmlWRmdxPO1eX+wxFTb/doySDVLnyTLmUw0Lj1JYsEob3AwBEjgNJ?=
 =?us-ascii?Q?Rk1KJuK0lUns3QWbHlgkLkBdVDyedgkzi+KMWgj+sVkhf4EM+1s66iO1M1Ai?=
 =?us-ascii?Q?stc5/BokxIBobIMUL5VlObgG9yyL1iDVktkR68z4UQq2j7PP7Q4xxAuZyOen?=
 =?us-ascii?Q?o+l2zXzVf9Jt0gLNII3SPzo+WtyStHkO0b21Z/dpeqRQsAH98l4VVr38rZnp?=
 =?us-ascii?Q?XpYotHv8/3LlmD/E5eE4n0BCstjXsmdBl0Zq0KC05s3Raaa+ZjD2pJcxJCeD?=
 =?us-ascii?Q?7B9F+b13a40OyP9vhYiUobgzy/ovmXx+VIDA8Q7SLlCrG93U/RAaU03Oft9O?=
 =?us-ascii?Q?QpAbBx1LK9Qp0ZsR6axWizmJ7e23ilt0m7A17iup3dN+BO4PyavvYafS9U6c?=
 =?us-ascii?Q?o1hKkewtqQDb0neo1bP5208WcSY00ZvxKHo1EzrRCOWoSlH7ESh/QxOeUIcg?=
 =?us-ascii?Q?zcjJ5YulCIMNkSNFndAp/JW3z/jCMyz5BXLROEFi6QDEmrXBzIWj8iVGB9uu?=
 =?us-ascii?Q?x/RwncB+y7kGkKo5X54r+zLryxfcRBUQF9AQjG6Lenk0KqmPqB9GihpDsE1Y?=
 =?us-ascii?Q?ltb6+BdP7GWUGAz6oPiFMd0AneQUripvsDF2VPppay2lOhzV7AL78mzJdMK+?=
 =?us-ascii?Q?1j/ZLyTLdLPOt77SiH3pAyB0f+NXOGKgvCJPWwa7R+hQDZEiDjaFLJFac6z/?=
 =?us-ascii?Q?fTWDaAhLmcYHGHRQMAkCH34tlazGLeRMThyLu9okBqOHotqi4f0q43hWOgYY?=
 =?us-ascii?Q?+WwZQCI5Fz1t2u0ZC/CK7+yXRl9dAuuEgpnGlJYycX/vUF3SIMp1KYRSzK1o?=
 =?us-ascii?Q?Z0R4CFr8SDeC6o7895gU8Z1czhgjqcZWLrWclBlWjD/8qISdqOspjx7+CaBG?=
 =?us-ascii?Q?90MP5pHaZrDp7LJomfiO+cqaPqrVsxPoA9OyXwP2HWTfIURwMKc3V1BO1QiL?=
 =?us-ascii?Q?2GjmvRK9gMg3+FG5yOoD0IwEZFteqz7wgJcShP9a0+Q4wHbeNZlRH5R5JgMs?=
 =?us-ascii?Q?8hI102oATS0+ZQSdofpcFwtl94j6O784ra/NJblXKCDTodKIkknfNbwPNBqi?=
 =?us-ascii?Q?RsEnmGgsh7vHgKNHtl+hbtFoNtVula6Jv09Rdi0El7Mef+9HLNntljnRYJOZ?=
 =?us-ascii?Q?G5Ph5zdDVXSAwv+RHyv89HT67RgHr1N+3FE9jeH4Dg=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbcabdf3-8e96-49ee-fc84-08db5446a972
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6455.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2023 06:44:27.6441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9077
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Immad Mir <mirimmad17@gmail.com>

The debugfs_create_dir returns ERR_PTR incase of an error and the
correct way of checking it by using the IS_ERR_OR_NULL inline function, and
not the simple null comparision. This patch fixes this.

Suggested-By: Ivan Orlov <ivan.orlov0322@gmail.com>
Signed-off-by: Immad Mir <mirimmad17@gmail.com>
---
 arch/loongarch/kernel/unaligned.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/kernel/unaligned.c b/arch/loongarch/kernel/unaligned.c
index bdff825d2..85fae3d2d 100644
--- a/arch/loongarch/kernel/unaligned.c
+++ b/arch/loongarch/kernel/unaligned.c
@@ -485,7 +485,7 @@ static int __init debugfs_unaligned(void)
 	struct dentry *d;

 	d = debugfs_create_dir("loongarch", NULL);
-	if (!d)
+	if (IS_ERR_OR_NULL(d))
 		return -ENOMEM;

 	debugfs_create_u32("unaligned_instructions_user",
--
2.40.0

