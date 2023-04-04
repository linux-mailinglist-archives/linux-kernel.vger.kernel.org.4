Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A1D6D651B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 16:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235646AbjDDOVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 10:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235728AbjDDOV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:21:27 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2119.outbound.protection.outlook.com [40.107.255.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B160326A4
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 07:21:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQylciV6GG2aXlq5XEA9wiHUuQqQZRbdrg019EqyHijes72ko11UUeTS1oN1A1BSFgoE9WVkrT8qCqBB/kwdZmV3V25JzMvQr2dTrjv375JYiOVJ2gg7wCWkDS7ljEHxY2rI0b56Fd3R5yoM4fkaljzE+9JCJe3jfL6IGTJ4eknehfm+cmbK+tCzvjhCv6FShyaH6R10u22R8SMLLl1K/HjbEQ1l8EcFtWnW1xdi35jJpMxiwJa6pjnWOROG0g4H3YbrQ9qxc2JCOOrO1VQ+JnH5MvOeZlzWkmsUAZIhSWDykGaLZvFIJYHC+1plnEKb0873i+9cEMQHqlZJ4a1J3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2f9tfY40vk+ZqB6BUcSXC64efgvRPll3GdNVfQ5m/8=;
 b=h19BuRQ4n4UGxSBrck3AeA8GsHULqc4uAmXtrT0D3jtIUwF0z3YVw/pruksPihkJ6H3fiSC6FO0lVFgZBD1sS+qGtbTTk7Z08Yb/kAsLQPvDPiL6BeAwBOPDu32GV4aTzw82WOMaPJOPrLMya4WM7X8KtLl0h6KTRBUh1MAT7MjLibmYI+MZfG6U07Zo69SgjWGht/ZrhjgsJ6WznJzi/huHpjFEXOVQaeTQT7xuR7pltDnib1vjKeDc8XZTPCEi8EtiFnEBnvrosB5xacnXUA2dyViaxlCanXyRuxW3aK+wWtsKoHcPUwkimXRI6uAtpCVQl7gruqZoFvqNx9EJag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2f9tfY40vk+ZqB6BUcSXC64efgvRPll3GdNVfQ5m/8=;
 b=K9kEG0gxkTCe/RBIoNBThbgo/f88KehaJiYhNy6GdLRAnr/Ls0axKJGhbc+h4zWL3AbTDjoJFsfk7uOSvCp19z7UgDHC9xCJxLO5BhMd6NhzygM61dl99vR2z2uL9n7GqnXgV3pm8iLW68VD/SDJ1AnJJM/I29qTe5TqpEb2Tqh44tOF6UikAFr0gzMGpLYblBTxKXZU/+Iietj4DR87b1BrwAoi+GyeDndeZOhtSrub+HMnfRvkhVQpMwESxYgaZgRuGcyeTHaUvoU0BkjscH27B+UgFL1va62Hf647kqUbrQGf+COdHvnXrItNrSkunEq4E9LPs+4b6Ts+hlHTBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4641.apcprd06.prod.outlook.com (2603:1096:820:82::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.34; Tue, 4 Apr
 2023 14:21:16 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c%6]) with mapi id 15.20.6254.028; Tue, 4 Apr 2023
 14:21:16 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] f2fs: remove unnecessary kobject_del()
Date:   Tue,  4 Apr 2023 22:21:01 +0800
Message-Id: <20230404142102.13226-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::15) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4641:EE_
X-MS-Office365-Filtering-Correlation-Id: d21be895-bf05-4f64-0b92-08db3517da06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VER9UM2IJTnpKd4rLlRB1QcSKUcUU2cZA64KWk+hcFebgoRcsV4gbCIotRKdtIEkAr7Wbx2n2+bmKE+Dcz/I6VqEP4P61tIY6W3S6rKUYbBoyPDup1DBG6V1hJFvO40fs9nPkwiQjI85Sl0oUppFps0G2T45GT2HRxxnaK/Xq6fU+V/gtfaK6gonkty7pDT95tQXw49Ko8LmZfmhknvzfVXE8cZYH43Qo10SrHa11uUoLzZLiKk1V6vCSkWSGDlfwkiiZ/n51CPe4LXH69NiGG7lD3asF16QiTsrGbrTNZeRGF2kn2FPxlK5UpT97jWRI98pa60bTDc5I5cR6MQDh6PKjlorrQxT/H1KS68g30cdjGSmYLI2guU/24o2GiLlqFHpqLvJVC+fuTeKXDDiRH4FE0FoXKRd5ANPiS6TtVPDYd0NdzJFLwWuDp3BulUzUZOlaSWCf7e+Li4qNSfXxtva84EfITZn0LO+tMorYc1Nw1+zM1PAxFdqaEybqBR4Cr4khrDj7N73N0sBwVe1kFKuGCvGMSZx9wHJG7dkD6qMsDW3gH+KZlSnasp0mNiWEzS2T//v1MvyFYMyf7266c/8fmSir+XXL9VQPpMa1SAb8v2UT7+7xb9dcH2j7V/8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(451199021)(4326008)(6666004)(2616005)(6506007)(66476007)(66556008)(186003)(66946007)(26005)(6512007)(1076003)(8676002)(6486002)(41300700001)(2906002)(52116002)(83380400001)(4744005)(5660300002)(86362001)(316002)(8936002)(478600001)(36756003)(38100700002)(110136005)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rRSsgMtlERLxe57+xBJyCSFxe8dh9u8GUsORTfTAgfDtb825VDGZzL1gYS8m?=
 =?us-ascii?Q?iElLefQwhlBIL2imMUKHMA+k7sqicew3RBWQNi81gvHBI6CpaGZ5WO3r1/uW?=
 =?us-ascii?Q?28rq2gzousBXcLH4I8Ez1gqVwtG327R/F+gAsh8jVCma3XpRSs6s6N+z1u52?=
 =?us-ascii?Q?wLqbQ0csAg4eeUORNhHLUJTpFbPimVFbPMzvQXDR54RAwU+UZiHtPujd+JpW?=
 =?us-ascii?Q?/Ifxto85h2KEhjZvx6/oUA5dl1FfE31mMdePYSkTw4YcKDWl4nS+fX1kvidg?=
 =?us-ascii?Q?yxG7U7FhHz9uqLCQQeC2zZRHQ/A3pmzibD++JHj6ISTZD0k/QKBIUa0OV9tv?=
 =?us-ascii?Q?keluZ3hd3cwZXqX1y/lN/BBdwuOU9V0O2PR+1Z7Bh64boLY5UfGzUtqEYS3Y?=
 =?us-ascii?Q?6RG5xVD2u4lMv11mFdNzPR0wkmnIgvwATEK4ciwuLX6Eykt0WhRzKI1Gc9a5?=
 =?us-ascii?Q?rMeL0WfBuBmx8q2jSfC95rYMM1S4oXs11ssnXSAZ5zNxAQeirTP3ck55mMif?=
 =?us-ascii?Q?jny8EhFJMpfwJrhKputT2CMdJZuedn3fCHwF68Bn5DiI9PrzlWfvtXRv+QFp?=
 =?us-ascii?Q?Y2kXKMLfQ3dWQ4LKX53P/Krh9/Qd3B4/oXBQ2yqjBl1/otdfDpsm1p4W9ChY?=
 =?us-ascii?Q?CPuLkw9g7AGoO1Pbe3CxZED3FaiACQS+yzT9FPz7WqKiJgi1K/GzfEsAQp8R?=
 =?us-ascii?Q?tEBWAOAlDMA73B3us1IzCNstAI60ZbdgdTLQ3mNPjaJmLNMmSAqkXJX8F9GU?=
 =?us-ascii?Q?7HDuPYEZgXVhe6utEq1X1B88U5KK6qMg0r+eFU5QbJQvVAuBWdzhl2zwAkG8?=
 =?us-ascii?Q?TqSrSPkezzltaePQ2WPIGEIMVgEhQDFB6ejpzkWkis/73xoubar/zRL6za4t?=
 =?us-ascii?Q?dbk0xxKSz3Gm+JE+ZYpvhTC0a5OzXXxuInMzvLnnmZIwNQsIw718dN2AhSbH?=
 =?us-ascii?Q?lEotneiFcHB9wBke2+nNToR6LkNomjRh/67BXj43/m1kCrv70O9vDBbqyZLm?=
 =?us-ascii?Q?+3ZDTPXrqmDqDypyNx+SdpSatYgIUMFL+N6WSJsLT7Zmegd78lAotOlP5PH5?=
 =?us-ascii?Q?FJIvBzx9MShM5zg2IYOr6IzBJjm5awEGKRAnB9LSxDDj7MbPzAqpdD1nRIhu?=
 =?us-ascii?Q?HyxseL0VuJz3++lgaCxu36wwi0klC0tmsjeaAEiXQlEi86kIMFoUqMOGRZqY?=
 =?us-ascii?Q?DXdzHn6MUVDoLs0p1HopO13WMNtcOF0YDGJKdkIz0UWRXBoNGaYPtT9FmtPx?=
 =?us-ascii?Q?hfrOevZQ6qPVXa1oHoEhL0E4s4W4Y4Vqg3UKBNZNn39y6vjY7VF4KJA1G9/k?=
 =?us-ascii?Q?HKQBX7FguJHsp7+Cc6b+b5IqlHWpvXzCsc9r+NV5Vwj6reRCGsdhQ9bhHKmL?=
 =?us-ascii?Q?zZ5o2EysM+vCsM5gGmSAcFw7OTOqpi5SlXD2TC1wenT646LZGmLZDFGrpRhY?=
 =?us-ascii?Q?8mjwM7/1YJFX8PjdDPLleaAAG/NHvmR0Ycy+JbH0PZHKaJCWKPUA/LB5az8x?=
 =?us-ascii?Q?amNyrNpuqb+a2ztiaVIE1PY/cENVrRTBMVQp9zA/iOdzlrx9dtidwb7ivnMW?=
 =?us-ascii?Q?gSgKTl12LGhkfw08bOPO05Ocf2xZjzkfeTJcPT+i?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d21be895-bf05-4f64-0b92-08db3517da06
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 14:21:16.4194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lQkPSwg74eB+FTt4oyb50mADa71HGUwSIou3huvrs8pkJ1aD60iCJkpP7w08Rvi90dFnRJ9vn6tYJeBdbeS/oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4641
X-Spam-Status: No, score=1.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kobject_put() actually covers kobject removal automatically, which is
single stage removal. So it is safe to kill kobject_del() directly.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/sysfs.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index dfbd17802549..d5712627fc96 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -1472,14 +1472,11 @@ void f2fs_unregister_sysfs(struct f2fs_sb_info *sbi)
 		remove_proc_entry(sbi->sb->s_id, f2fs_proc_root);
 	}
 
-	kobject_del(&sbi->s_stat_kobj);
 	kobject_put(&sbi->s_stat_kobj);
 	wait_for_completion(&sbi->s_stat_kobj_unregister);
-	kobject_del(&sbi->s_feature_list_kobj);
 	kobject_put(&sbi->s_feature_list_kobj);
 	wait_for_completion(&sbi->s_feature_list_kobj_unregister);
 
-	kobject_del(&sbi->s_kobj);
 	kobject_put(&sbi->s_kobj);
 	wait_for_completion(&sbi->s_kobj_unregister);
 }
-- 
2.35.1

