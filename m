Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034CA63C009
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 13:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbiK2M3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 07:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiK2M3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 07:29:43 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2102.outbound.protection.outlook.com [40.107.255.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD86057B7D
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 04:29:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cV2eonGG64kz+Qf9ZFn3mi9rzcFNHTphEMlhnGA3o5O3FnngIYyY8e4J8NDnyJEpl25xA9JK4JuOnnhh5xMj8YXBOuaWLJbRuu/JOjhtaliE8rwmarV6ZZMaYKAVf7IbM6JvfmYEN5JNuhOn2L8Z3H4pbQIpQjttYiY24MGKXgeZX2O7sx5I81ls+H6sf3k49E2W3BpnXlZFGl2EG/pTCw98D7PiIXFFJIDiDmDDKmISE3Bif1HbTkF1k3LoePfIM4kgBf/Yzq52fnks7JukGALU7CbQSWX1u9Fw7LBRQcXL5u9aJILZuKm29pHslA42uwMuWqqbSSSuovBc6T8ZDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/xSPZnF3yE4m22lxPRK+tWqeBNDELmXx2wPfAo1agLg=;
 b=jGaxI9PZTLtKQ+/zH8C5WqJ0T866ji/oHnwigWIyqKBVVQI4zJTMDqemNGlz9fjUcOV3LcBM1RTNQsW0ueEQFhLXBLA+R+ZhmrTtvfAACtWzJHkHRByyHMRJsQRt1PigLJOR441OeIQHmstgkinWHu6CoAw5zQQODEunKAsb5F8jzp8Cnr+OVtFl932Lxs/kPt1FZ8aoVEhLWA4V9w8XMNCYWr1JnSduwKvA4dJsjkCSDjjG+5hd66cfe8dOoPVqpIVQWeRHq3/IGwfpMLYoiJxvPW9GRBT5ihTAMMGVK606t/MgIL/4v7S2b0d1HYmcgEPXyfH8TrAZ7z2nCNf18A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xSPZnF3yE4m22lxPRK+tWqeBNDELmXx2wPfAo1agLg=;
 b=KreVcyFDxzTGTJ+wd7szG5qR+067EOV21Y+NwMwISV7NXNLYW3SCkVcTMjfLHDUSG5n7i0VW+6/RYI87oPNpa5uhjU76JJEaLPRNKrNlYSNZsWuO0uo4E9KLvh4YKfXYFfO+A/iolXVqT2Og7V20WG0byv8ptEyx+Xnvsnauwxf9DsbdQTtHLjadsWPwXx9b55EmmwrCLn1zOrvdvZOg+WS50g1391MuLsnR8M/Al0TARVOxThs3iHl/QR9W3dxjLuvY/XrowYjuAxy4R4QlVcdzyaU3dqM5Zv2i5+/2Bwq6wJiPk85f5O5R6k7QJF+F71krOT2a3Fzk7ToCoVRiFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB3907.apcprd06.prod.outlook.com (2603:1096:820:2e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 12:29:40 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::ef03:cbfb:f8ef:d88b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::ef03:cbfb:f8ef:d88b%9]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 12:29:40 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] f2fs: judge whether discard_unit is section only when have CONFIG_BLK_DEV_ZONED
Date:   Tue, 29 Nov 2022 20:29:28 +0800
Message-Id: <20221129122928.23730-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0170.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::26) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB3907:EE_
X-MS-Office365-Filtering-Correlation-Id: fd576a91-8dcf-4c7b-f604-08dad205629e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l4oMLmM0x5MxDXNGjBKjlAyspJfhUqcHx7luoEwHinc/Dfnbg73rtth+g6Ppr/YhpG0AFyemV4tyw07H0ZQVzSuQNeQ0sG3APfqtyMiGdeNYtNn2sF5Zd3/MKc2akF5VIWYb0GDq27hqBspjPnetY6/nFFNSpcIEDaFMjk4o9r/2uI5KO0AWuyN5lPkpe5DeTVs2IYgHUknKBl4Ffnz+q7qmQ1dPNo4oWzXuPzqrn7LJyFydBSoW/YsWalfnFU0q7HHXa3YAwm7kQjRRiaAIPXRwHnOLeB2kQztqJqW+18Ff5ih+ePq6tMJqGk2HaDKzJfEYKLefs0DxLEvVhxRYOYwlKNlQLPf1EE71NPkFWCGVJy1z1oa420cyXdGymBZmXPZx06CsxvMagkczuFzIvw1xGp/yuSM3U99n3EeWSvgEPppHW8A+A8tuJp80JiyMPsquhivCZALO2wVWxBA8d+1gOxhsjigW9jOTI2ITrzIlxOnPacIWg4dJmJP/ik4srzCKY57X1r50FyVbrWXiAV3SoKG8IIHMhc3JVwmCiVlYgmEoabvaAkURAYiyCRcnKzt7cL56PgXEH6Emm5zpvmUmfjRc9i1rd9yl48RfAJKAr/Smc5P1l6GMS0JTaqKnPIy6Vn37naPcbELsBF/hjsFwvoTUOOrE+CC00g1Jv6rrlOBXLOXFwsPMCO93w2Ii
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199015)(6486002)(107886003)(6506007)(83380400001)(86362001)(52116002)(478600001)(6666004)(316002)(26005)(6512007)(41300700001)(2616005)(5660300002)(38350700002)(38100700002)(2906002)(8936002)(1076003)(4326008)(66476007)(36756003)(66946007)(186003)(66556008)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1JWPWQGBW5Yraj/rOFk5ak0ifwtgcTCJxbnvvNpv/dM0EQiPQSJN4mk3a64n?=
 =?us-ascii?Q?t3L6ecMDCqNDbxR8FTx87VoEZLnsUFDQC+A/WlNG6PMm3wFewI6VuKJC/PkG?=
 =?us-ascii?Q?Gv+84CpFE/XS0sGkICAVUrBy7hmpYazDsyWtsvsSvlQ5tK1dFWU2RF5ncqIj?=
 =?us-ascii?Q?VgiPugLh2faeEBNLEfIpmKt/IzBtW7W5tLv59W9EtNoUhHe3WPWSkPf4F7AQ?=
 =?us-ascii?Q?kttIOUSp9rHNWAOAywrPJGD2Zrjrq7TcFUGL73UFOI2cwcWg/LYSNAbB+5l8?=
 =?us-ascii?Q?tfZ6AB9Fgc9x+ffDNMwoE1kkOvD7sO6mH73wU+tZ3I0hNKm5AT7xHzVdnCx1?=
 =?us-ascii?Q?CtM7LJvktB72p/lJrqgvmCNDTKeO3KHv5IvQlCaxkaDEa3SQhKcyBMXtQGON?=
 =?us-ascii?Q?aBkYhoPab5ZZtMWZYp4PcPhSXhu4HBE5jQNbSUdoSAkix1KihxUffjolDFmu?=
 =?us-ascii?Q?p/+3w5jsROMuVsJNEKglpEKh5DVlWfJ7C6KL/gaZSx2xyvCmULB2vmhLFmSd?=
 =?us-ascii?Q?SgW56p4OI0Z7SG1IgwcupR1mZQEPCqhOCl55NAuzaHc87xLTwV9/0ej5gbYK?=
 =?us-ascii?Q?vejXHyMT1ZiezLrAtcO9y3uVVkQKn6/T60HjN0OWsXtW+yEpoH3sdr01KinQ?=
 =?us-ascii?Q?+dIW4ur1fuyLZeHdxEf26XcsTVkOK50c50/ApcexOJJMkYV3jl6Bh7VrRtyu?=
 =?us-ascii?Q?Xwp/OUzNYljh5EOV5tJjGd+igDsS75jeY/u8xJl74fgi+1DO8z5WWF86Trz2?=
 =?us-ascii?Q?35hMvKToAPZi52PV3ekdcgTZbbm8vy/F2BDszXq/6wC0BOt7E4fNGFmfr68k?=
 =?us-ascii?Q?55xsrVaWd10xzX2dzBTGEdCVYjlDQYwvrBzyAGSfnvT4OdUBypE4lF4Bf9Sc?=
 =?us-ascii?Q?jnFq+NPyO3lH3DKDW3+fpN/uCz8P7OyDGtUIxYdiu0zP4thH53rhcZ86rEEg?=
 =?us-ascii?Q?whmsCueNMmntb1TlQIpjzvg3sEPM8ohxZQ9rWrpfhdSXjmKkCeqkcaNWcTRf?=
 =?us-ascii?Q?DPdIfP7NUGm3toTj5VGJiprOPN/3S3rNxnJ/LcxRej4nEHA+GzwzFkoHRf/k?=
 =?us-ascii?Q?+49SxQBLAp4/SkO7CG/kezuog44BubuSi6nULPixs+Z3pKB8yjS4p10ekaoz?=
 =?us-ascii?Q?xrf6BIKP9FLG38YO0bntkJfFjvG9uA+ZgMWzJL7q7t0hUQglw7IbDFnYbQ5g?=
 =?us-ascii?Q?V5+T9QUCWVIv0cy9FJRWxp1XSIVlfFIbl+nwH38SSZuRukzbrnrV3wgivR38?=
 =?us-ascii?Q?EttFE806EhGI7gBmGxKPqsHGVCUSW1MLVtsykl59GtD2DZ3XYDuC/9SYrPS6?=
 =?us-ascii?Q?mUWO/pY0dKTTWkoLcCMfcyYrhtvLG4oohYy+dkJPeF1epc2BlGP1/PCDG7I0?=
 =?us-ascii?Q?5t3YYvIya51UcQVpkauUz/YZP6XO27mxeulZzHiaGaEf+3e67unvvDG7jIu9?=
 =?us-ascii?Q?RT3+c7TWW7YomdHGKV+6o75giA5jSTcCFQLW6yLKGthjTr/MYewMsm0gXfvO?=
 =?us-ascii?Q?OLO8Lgd1s75iS1DYOSoCRABhULn0a069tbpOzBERGh4blQLbJ89wlp3y4KQm?=
 =?us-ascii?Q?jHnBUJiNVUGUq+UrJWQokBbAl+nmqPAHBRl9859p?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd576a91-8dcf-4c7b-f604-08dad205629e
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 12:29:39.8850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f/i6Gf8+euPycAUlyr+S9UKMVb32gWpI35H9w7FA3GN4iHX4FQOJ/Zw5QjqHESuQI7VS8+ZNpmG5GWn/NmQ35g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB3907
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current logic, regardless of whether CONFIG_BLK_DEV_ZONED
is enabled or not, will judge whether discard_unit is SECTION,
when f2fs_sb_has_blkzoned.

In fact, when CONFIG_BLK_DEV_ZONED is not enabled, this judgment
is a path that will never be accessed. At this time, -EINVAL will
be returned in the parse_options function, accompanied by the
message "Zoned block device support is not enabled".

Let's wrap this discard_unit judgment with CONFIG_BLK_DEV_ZONED.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/super.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 79bf1faf4161..753c97be7d39 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1289,19 +1289,18 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 	 * zone alignment optimization. This is optional for host-aware
 	 * devices, but mandatory for host-managed zoned block devices.
 	 */
-#ifndef CONFIG_BLK_DEV_ZONED
-	if (f2fs_sb_has_blkzoned(sbi)) {
-		f2fs_err(sbi, "Zoned block device support is not enabled");
-		return -EINVAL;
-	}
-#endif
 	if (f2fs_sb_has_blkzoned(sbi)) {
+#ifdef CONFIG_BLK_DEV_ZONED
 		if (F2FS_OPTION(sbi).discard_unit !=
 						DISCARD_UNIT_SECTION) {
 			f2fs_info(sbi, "Zoned block device doesn't need small discard, set discard_unit=section by default");
 			F2FS_OPTION(sbi).discard_unit =
 					DISCARD_UNIT_SECTION;
 		}
+#else
+		f2fs_err(sbi, "Zoned block device support is not enabled");
+		return -EINVAL;
+#endif
 	}
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
-- 
2.25.1

