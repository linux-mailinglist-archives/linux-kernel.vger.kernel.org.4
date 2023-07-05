Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2024747C22
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 06:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjGEEsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 00:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjGEEsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 00:48:05 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2127.outbound.protection.outlook.com [40.107.255.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EECA1;
        Tue,  4 Jul 2023 21:48:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4WiPcbG/0650XKZsJmk3Cqf6EBu2EXHmnHQxM+KDCk58GQRSfqd7FVwPqz3XtZPir6PbvW10FjiYNiFNAu1IfmI9ZVPTH2iJ7mIhpFwGT53KVihtiZcAx95sL0q2bZ3t8w5xpCuzbhGP3d805z9GKPIVwPt5zogzeETRp/i+xZ+T1wkbky2pt874rhg50Eru/QpBuIoP9OHjoPyivQO7Fg/VyXKzGKECkh0bo8k1dfmTll4C3tpcXZ1aEJ0kOYTgZQ6mpnxLTOPYi8tZ4Nv4dZkDbHwxv1U4u4tIPX2t/E9cfF6xXxG7nDZUY+zLeChpqUrOG3Dov3mbYEZLdQ5Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5a3jIrhU5rBDoWWyGOvC05MWGoUyX47GgHbksd193S0=;
 b=fWS7uaJRbS4Usoecuj0VHEb07NT/Y0fQV7Erse/yMKyCD5/zW2zI1VNZNDPsR8+sRTF94JG0lgEhsgz+e6t393z95bv6T7/WOTFFX+S4finEBCDfZtI54g61PJVT2GHkUWkAoLYqJcwL3dhp77UGz5YFSFso9UG9rf9HeqGYm4LgkXPYqvtoObe2fziZ1W2xhbGLtFaUlNysEOHGW834lA6jYN2MX1Lp0Kbx1Lmj6ydQ2knc6N86ETdSCUJx9lxuBoeiNDwbVNPY76NdZVZRjRDSR/UQlPEFggylK7YMTBY4wO1b2WHiHxyr8pp8ITU4/Fa4Kv8Xmw+hJ0d6ReGbmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5a3jIrhU5rBDoWWyGOvC05MWGoUyX47GgHbksd193S0=;
 b=MNGEBR/8xIYVgnPQJpjNS93kMvsSL4V/yQFsxApMYOfjEIEgbcC4HYCXYRhWqng5UMGjmZHCkuIa7shdIQroZz+dlO8ZTi4g7riemkkxNp+tiTPhTPbDXPkr5kyhAa2fQlTnWhs8JNqeGne2jFexY2qigekEsknLmXnu5dz8Cepta7tX1u3uqgAviyecT1o4lJzCXZ7RXn5vobwu+HR6S3vw8G8S9JaN7WVnwzVP+A1VkWS7MLLpmtmEn2Sq11WvjHOPI/OonMtTP/75SS6Y0PNY8oFgQZxrEibNTaLF39Gh6PUeIHufph01PcmphOItER1MogK4RNZCIpHZE+x58A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB6130.apcprd06.prod.outlook.com (2603:1096:101:db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 04:48:00 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 04:48:00 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Minjie Du <duminjie@vivo.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-media@vger.kernel.org (open list:MEDIA INPUT INFRASTRUCTURE
        (V4L/DVB)), linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com
Subject: [PATCH v1] drivers: media: remove duplicate assignments
Date:   Wed,  5 Jul 2023 12:47:50 +0800
Message-Id: <20230705044750.8498-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0105.apcprd03.prod.outlook.com
 (2603:1096:4:7c::33) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB6130:EE_
X-MS-Office365-Filtering-Correlation-Id: e6b57f1c-06a3-43cc-5435-08db7d130258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LzfRnnM48X4YQCKRpgA53GFClrLcqz3lwNGXzdeHoQ57swPTezDszaQn8J5wEShB+NnnZNfsX0KOXqrepcJTVb9EoGJhi21boIT0BTOKKVtvnrZIb/UAM+Sh+dwQN2JM2ywsnSbfW34+9MfwCiP5UqPj8vMs63aXP/NWwAp2kfDx5u6xevfzX+nOnhQK3Jdyi+q8vIvfjoaGc72OCPkyRoiOVquvUDyE9mWXyzK6O1AsMzKFcMKW85x1zPQYvxCxjURgxban69HaTm7j/Frgc1G2oCtaIiddFVZsd7evUXZaXNhr9ApzPtvrPEqmu+ja2mY0+0dXIu++eDm+s+mEH2W6aCHZ9ikpoYUju8p2i/yrl/daivxfsyLX74VMbit+AAFIMRFZEAhRDEkwJcWu9HH/0eUrgjdlKznSKcweXVs7yyLogR7Pu+lqTTIxovEogmpEzy9+vHbDtCRR6LJZuqb839L8jTijYzwnqSSI1dqVCg2xheZVSpM7DdMeWVu9mmtlqIRCGRJQ2/b8ddK0b3FDo99vmK/G2d7ezE0j9+5/f0IEPqih+bSgTgNu52IcjGlyxeCVIDGX2O8Br/uXWL/xkqgx9eQhRDfFj/vDCLH7wpfGdJZDU9oZ+padJpAJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(451199021)(38100700002)(38350700002)(8676002)(41300700001)(83380400001)(8936002)(316002)(2616005)(4326008)(66946007)(4744005)(2906002)(5660300002)(86362001)(52116002)(1076003)(66556008)(107886003)(6506007)(36756003)(186003)(6486002)(110136005)(6666004)(26005)(478600001)(6512007)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qrc1De4e44h/GhvLnEtHbSGckyes1hQAoNzJBHJNnGIRPQTZkpT3XBqmbMA5?=
 =?us-ascii?Q?biQ6/DrZCC57hK44KdEWeKPzsWG0te/uYDU9UY6XkRy4vpT1PzSURhiWcGb+?=
 =?us-ascii?Q?gwpGgKMGw3rlsWEXsBNEm0mJCmF/XlgLle/jjQY/5CLX+GB3KU/ZRd4ialAI?=
 =?us-ascii?Q?RV8q3STSbkMZzkExfTY8DpZfDDcMMDoZswtC09tQ8RJk4OLt5BZEkhlQBeur?=
 =?us-ascii?Q?yD6BulSBcmvgvCOvQpCtUE5Hg0Q14wd5mWsthtzKtDxpNAJZjH57WUqmxHij?=
 =?us-ascii?Q?PsVnovEGUp+AalunPXu5fRPU71K5c5jcYDHUEdBRRo6LEF1uh82VDbHMUXST?=
 =?us-ascii?Q?l3lQCUlxjqOMoVenuVZSf4wJzJuEOhdxKK5wuYtX8/u7esNUtXmtOy2rDT5V?=
 =?us-ascii?Q?wII9wPicxRSeaef3nU/WYepZ+5zCuTvqtx35K76eDhd36h4jSYpg/E1yjZCi?=
 =?us-ascii?Q?zRJJaN8Ku0YzbRzzIFvEK1BrpUx1g4h6QqTAVtG9Z8qIX9JH7ikQaVGrRtw3?=
 =?us-ascii?Q?GRuKhBOfd6dTwk3DNn+sJykzK3XL8HnRfPxR6Kqu3i77Zxr6pkdMhlK0390j?=
 =?us-ascii?Q?kce8v9XcJRmEKaw6Na7U1BoeMC9NAvBHdTfZUFpRSGnhDaOrM0yN0XbJ26fe?=
 =?us-ascii?Q?yyInlSciI1w9jLaplpurUMC58wLJ8J4+OosH134TZMSnfxX/cHfFa72VDIox?=
 =?us-ascii?Q?kKSa2ZwPt6W0l4k6fPMlPzEsGm9+ZpoSpg0ePkYPIgX/oQ7wS2+0RffXWJps?=
 =?us-ascii?Q?fEaxlDNjZoQr4lvyx1picLwptsoJV/S54i9GEdtln/iaKvSzRcbeam0JADj2?=
 =?us-ascii?Q?IP4F57l6RF1a+nlQ8Bqu4WPChLiYca2dPlMV9vf4O99X/GaJOwH4ZNa64qud?=
 =?us-ascii?Q?VI5jyS6BNZ9iCPZWcnaWLasp4eQN4zKafMYZqAFFr+AE28yz3DSCekLicMdd?=
 =?us-ascii?Q?E7ZXLwNhBvuocIesdC2zx1hYGoOrlubpJ+gh7Opnh8sX0o0f9Bqcv0NayTUz?=
 =?us-ascii?Q?3FP+Nav48Hf3UqFXI8uRL4b8AZsqhVJPeXVDx+hnrsrNpe1nLmnGdicFwdl+?=
 =?us-ascii?Q?VB1FkjdovUwexdMz2WZN2UtMBBQa4HBd/fPouGbSt0xf1w1YL8MXY5Mr33D6?=
 =?us-ascii?Q?TeuR2ARlLngWRbRbkfNiseQa9Bn9VmAHB9FybyoWrxld65JLwtQWxUrx+P3j?=
 =?us-ascii?Q?Dpvsx+8cQCU2N8ctsJqIb4dQbj8GGo663tPcTl9ORuHG2Xj9K0BPwL/FNN7J?=
 =?us-ascii?Q?N6tubzakQQMH85G0qQnS4OrQ7yNO/GEFIlu/BbclOuj5aJM1R+BYuhY3NwIV?=
 =?us-ascii?Q?0flLD0S5Z8Wu1HJXYMD3JDLM54PSWSBU8qi1YjFnEkZsJ+3CmG8gtzksjUAR?=
 =?us-ascii?Q?wzx2Ufl3kXqhOr/J2EFR23TWTJhpbwBTkMIpBZeD9HnUAzx0mNQKi3KBy2ob?=
 =?us-ascii?Q?51QEOOMSYs7HbVm1+uDQAV2iaUeVE3vxsekgfSIFPAB8St9S3HyDe/ammRl+?=
 =?us-ascii?Q?LC6Sl5KWpLmWXXMh13C70LxaDcQTb2BRaw6fVB0gtezOu8qUMjffnD6aRvBC?=
 =?us-ascii?Q?FRc7jk3xi7tjDXefVj6fxYsKH9RKLZ4CBkINQEO4?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6b57f1c-06a3-43cc-5435-08db7d130258
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 04:48:00.2715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MlbjDvDu4rFMQ30UkSzbf/MTo+hd8SDb6zzj0ncJ1vkF/i8czrccMVKvmjzBz0iB8KsGpZ4RiB0otTGBx9JNfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6130
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make second_timeout avoid double assignment.

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 drivers/media/pci/saa7164/saa7164-fw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/pci/saa7164/saa7164-fw.c b/drivers/media/pci/saa7164/saa7164-fw.c
index 363689484..cc9f384f7 100644
--- a/drivers/media/pci/saa7164/saa7164-fw.c
+++ b/drivers/media/pci/saa7164/saa7164-fw.c
@@ -271,7 +271,6 @@ int saa7164_downloadfirmware(struct saa7164_dev *dev)
 			dprintk(DBGLVL_FW, "%s() Loader 1 has loaded.\n",
 				__func__);
 			first_timeout = SAA_DEVICE_TIMEOUT;
-			second_timeout = 60 * SAA_DEVICE_TIMEOUT;
 			second_timeout = 100;
 
 			err_flags = saa7164_readl(SAA_SECONDSTAGEERROR_FLAGS);
-- 
2.39.0

