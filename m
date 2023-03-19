Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9FC6BFFE2
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 08:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjCSHvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 03:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjCSHvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 03:51:52 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2093.outbound.protection.outlook.com [40.107.117.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE057296
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 00:51:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YbAONHybI8u8v5fs7gkwHN6KIARK48us/fwPo6fPtaAhCULkmvnoQx7A8x5FppOzprcfLPEDT1DbQedLJRQoFreI+hcvSe2zk64VNoysTBhsAxM6nciNIyEO0tRvdZmbv8cCFagCoHkAFMxCaGHAVJ58lEIjUUak117Jvi8cUIMQsQFGptLrzjZtX3aOkwMWXPSC2asPUagCNY33PaSI2bI1cpd2GtjqTYEN057OVhN6P/5NCZZW8BGvzikjl1wsvhiIYejn2Ul4jJeyj6oJSG/igs58yM3ZbQzv2f7CV5rwwQiWA8odl1SysFOstRKRLpUKOKcMMwcqpHt8SSx83w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VUWwBkzOfM1kB3c/5VYdcEvnLFhDOME4sOKTv0gGYpM=;
 b=Mzz6Y50+vsfvbYtIKhnWWqO8yCIU0prZ9fd3WWiq+kHid7SIJWoGgWxgPhisAvLuHKVcdWfOZEyP0P5EFy+XempPFCjBEW7pvIdCjdnh67Wnx0hNVoqAt9GqfQwf5ARmfi9olecP766dAmRQ7d4nlBGnZA0C7bJag6Sp7xbXO9EUIFUN6poSO06g4Rp5lxDL/f8Ai6jy9B4Vf63YxoSKUQxnhb4OcsPi8NAag3/p4Ybcvwo3TjFQXox28NzAOook+3FiHIsXMRzD5sYePEJB2B0qjM980N8ZfVkcAmohfMuWWFsw131V//nujyIU00LMUyq5+VEzmeXHKaQcqP8K3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUWwBkzOfM1kB3c/5VYdcEvnLFhDOME4sOKTv0gGYpM=;
 b=Varn4LiMc1vDpxyVjT19E9aCEdc7uQBeUoORfPLdo921+QdzUqEPOXBRDbdALc3b0RmBm+Mw/nHuUBTQZ55Or19xSspOo9+SXomuFm6Igd5wZu3CEjZVKuRpdaekOndfHSXKenIBuRHlmIEva4svyJlbKlHWVCXJE07BxO1ml6uquQFLNzghPy6nsmuXdqvxuGiBPM2J4jDWvwUlzRAQ+cn35yolZ8N6P2x7ZwoUMU3rhiNz5AeNGRH0wvUZZlKDUQtmXMgAy8YEswD4vu2D6nmzs3hp/BxIM5Bx82AKaYqFd7rLu2tlF/KqWD8skoFsKDgWFjMUn5idEnx6msSbRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5626.apcprd06.prod.outlook.com (2603:1096:400:31f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.36; Sun, 19 Mar
 2023 07:51:45 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.037; Sun, 19 Mar 2023
 07:51:45 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] f2fs: add compression feature check for all compress mount opt
Date:   Sun, 19 Mar 2023 15:51:30 +0800
Message-Id: <20230319075130.24962-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0074.apcprd02.prod.outlook.com
 (2603:1096:4:90::14) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TY0PR06MB5626:EE_
X-MS-Office365-Filtering-Correlation-Id: a36a097b-f488-46c7-f941-08db284ec8e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oRI9grBx3OlfcClQONykPGfF/kkEyaEQV095ERTsdlfdZ+VpJuRAAeWx71UfEyUfJsXIHz6YvLkgWNAqaRlgG2pbEsztNAuR6F27Ou1icS8khRlunsdufKe4Htau17xoVCuWZHi5w9pvANcLfu5lC52rg52AHK3OxbIe+ItlEf3mdMW59VTIaK0bWNT9FRiHdoZkW69BOEBAKovGD402JAvkeznIj76XG1boBvrE7YToLHs1f78WfJmAc5OglxL5KLbK26kvx084hMDM+QNcY6Ohk0XpsN4rxRpuUvDPH3oWrZmz2HoALvakJuSSVH2uNlLQcPrjCXhftkuNvet0nAY7VLidJC/1qhwPhn/ujUzSlhMtk8Ibar/NkE3IJk3j+aoWKSFC8LbV/lL7vko54jZIsLfbxICjjx0uZih9aHjJ031awCZ1nQUdE6rkBNiisrfv2nOSbN9keMAVPesZFsMAoZEEWlO2zoInD6fTc7v7SuQJsJYLLGasZ2IDMAQlqs5KSdOUMMSPIX0Tj5+mSYi7Y+VXE74vZUKOsH9THJTgKFPN2aDoRy4OFYCTFVEimQWmAAGXWnYLHeGILYmh6x1IK9sjdY7Zwk67SYL31VH84Dx6D6P7/ZegvKcijX7QKwkppBgU8QVJlKf1xxWe0b0YtOCnGIiv6c1FwccVSUi5B7c0l3VOLjprcwuz4kQLDwWdkiwVd5YrYiwRcKQ6Ig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(136003)(39850400004)(346002)(366004)(451199018)(316002)(110136005)(66556008)(66946007)(66476007)(478600001)(4326008)(41300700001)(8936002)(5660300002)(8676002)(36756003)(86362001)(52116002)(6512007)(1076003)(6506007)(6486002)(186003)(26005)(6666004)(2616005)(2906002)(83380400001)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZbjM4SqKlKfA2PXX9Cd/4DxchugUhbsuRLWn2h9c7i32OlfsCiVR+gx80BZD?=
 =?us-ascii?Q?MPYpvPAmt3d5VGpsguXhxFhAIxFXrYccdB+0miH18E/o9+AKWUPhTX09dWuH?=
 =?us-ascii?Q?86/nt5m6yeDFSIPnCjrKm1qac+I6XAqntYD+Iishu9i7Nat9yWfkrE5v1lg3?=
 =?us-ascii?Q?wNrWRvJ+3Szxy2cGjRWv2E5i1o7x5IpGOWNDQzQU6e609sYXeRqp5qNSSdrp?=
 =?us-ascii?Q?KH3ADGgbX0VL+k9OxVeh5fwJxumgcnrjf5QqHVcq7zLFoOYAtWsxw3J5giyV?=
 =?us-ascii?Q?AMe1gN6zNqTmSPTa4Xb7TXt6THvhn1MeLRSkmi47zfse1o4Tj+XnKvlnrJzm?=
 =?us-ascii?Q?zNxIi+OCwkdzpRE5qb1LkM1DsOY7G17OAOOK91oeqS9lNvf4KZUScm/ZMFJS?=
 =?us-ascii?Q?NTFs+LLpKhZ5/AedgRJTZ4NgRApCLc90TJa+ozQLAm27NMdqAaAddHwIZUWy?=
 =?us-ascii?Q?SRqOJtZvHO6YWfCDfIV8UGX7CjusxjA+If4GSpSDyXkkPcCeA14dW2LB/4UG?=
 =?us-ascii?Q?BiBC/O6QXR82dj75kRos0uk1/VkWa6kCzUK2iVbmeQ/n04l9Gqia/aFYBjlt?=
 =?us-ascii?Q?zO9htz+Md7D+OMtYuCVnguBN85L4oDn/z7ddlzi1Tl9ZzF8suLt0aP4dYRGo?=
 =?us-ascii?Q?X9ccuuJuvwm1DcdMxl7NqUhyYiplj5Xujip9Zrxm7cXqCeEKiKTMtye2XWpO?=
 =?us-ascii?Q?7xNHPWVdQCdH5kmMqzUCoIgfyv/OHCT71Z2ZDwT8oQ7JNzvkl3dgihgEovIu?=
 =?us-ascii?Q?u7WbhaEv3ayQR1uDZSuFztOtlXgnoby/e84+KH+R6kOXIP6DqZKQ8EOqwzS3?=
 =?us-ascii?Q?Naq4mfgJw4IA/lsLN3HPOnmp9cBgCItp7Rd2mWB3+KKyF12Bd9Wx3EyySE3o?=
 =?us-ascii?Q?n9BMDtWi5ra258ZI9FlGruzPB2Jo4+0RbtSNZ9i5ENFvSMrlMwCPIxmMmHX/?=
 =?us-ascii?Q?oWOpDh5AoZ7TkhnxXHYencrFH3+oPNqyT0uwj1B2rIw5vmmUwrp4QfU+mamv?=
 =?us-ascii?Q?pOosKE0WbwM2LRsa0f16IIjPN2lZYSlZNlS0xADMd7RLwXidq8Tw3LO+KA2C?=
 =?us-ascii?Q?b2NIuqeeaf8dCekpb1VVwavKx4Bzo3bsqh5b4hLvDqKkpSuATT5RHigQA5j9?=
 =?us-ascii?Q?iCbVLQT9T43NSR14zj2iQdrQsNQhJaTbmwk1X434cjHUKrMMYEGZi11lWlo+?=
 =?us-ascii?Q?1cYX1l6Mjp0hRNwTAI8o5tcSNLFvVPHgCU+aIdbBM/8nXmpyiwV9v0CtzNAG?=
 =?us-ascii?Q?AFqFC5xP5CAGi8qyLjzB7rPB+2uP4c0mCkIsGHR+w5JL7axFIQhJBTZ5KIR3?=
 =?us-ascii?Q?2j54RhGE90ITBTTaoCvmkWOj8M3oN4hIFWGOyv1oe3J3He/8RStLrb4EX/ie?=
 =?us-ascii?Q?BI+aK43+h8oibRPBhqwztITHsgHqgoyrnwgVm4a3oQOo2N5qpFR9DXBLqeoW?=
 =?us-ascii?Q?5ms+/d9+jn4yEbQ48iZ6y28wlW5i39i99k0EG3nnGD1YXsuV/njGeUrwI72A?=
 =?us-ascii?Q?J8JYCpBAZ0RUfbFwFZU6Vohi6VV2y7eFaOX5Lnex518AeTYSodf+lMd2pNJp?=
 =?us-ascii?Q?V3YpqZhx53FnkxhanuWQqGBp3fl8sfmIzYqFy6AI?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a36a097b-f488-46c7-f941-08db284ec8e7
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2023 07:51:44.8762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FSRP7/uUvfg1JwTS0F8rZ8p+lPhZBZAkMFfc0ruvFX28gsjpGxyPN/qFF4TZbBy7helu6ABKXFdb9PCx9Evxtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5626
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Opt_compress_chksum, Opt_compress_mode and Opt_compress_cache
lack the necessary check to see if the image supports compression,
let's add it.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
v2:
-drop f2fs_mount_opt_need_skip()
 fs/f2fs/super.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 9c87d91df61b..a88706bbfc0d 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1179,9 +1179,17 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 			kfree(name);
 			break;
 		case Opt_compress_chksum:
+			if (!f2fs_sb_has_compression(sbi)) {
+				f2fs_info(sbi, "Image doesn't support compression");
+				break;
+			}
 			F2FS_OPTION(sbi).compress_chksum = true;
 			break;
 		case Opt_compress_mode:
+			if (!f2fs_sb_has_compression(sbi)) {
+				f2fs_info(sbi, "Image doesn't support compression");
+				break;
+			}
 			name = match_strdup(&args[0]);
 			if (!name)
 				return -ENOMEM;
@@ -1196,6 +1204,10 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 			kfree(name);
 			break;
 		case Opt_compress_cache:
+			if (!f2fs_sb_has_compression(sbi)) {
+				f2fs_info(sbi, "Image doesn't support compression");
+				break;
+			}
 			set_opt(sbi, COMPRESS_CACHE);
 			break;
 #else
-- 
2.35.1

