Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723326947D1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 15:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjBMOSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 09:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBMOSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 09:18:48 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2138.outbound.protection.outlook.com [40.107.255.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A14215577
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 06:18:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5OH0fRHM2eV6OsluyHiDvBCicztRoc11MQ/YTN7AsBpIO8SxwfPF7xMskuag7YUcPkg3kJtKG50X3A/G4wiG5jICc+eb75L/pzd2bWCjtlrCkrRTfmB0blNhtztJksGtO70Mw81Dj4aNq0c3WkEqwOlTF/cHnzAbFgoWWSDZAN7DGHNw0bV2HngFPv8/hY5QnNtEZyz5PxfunC19+tNX9gCygmSKJcIJQ0XZzy43bPhLUboxeokv3uNP4OytfBfzcPFqFtNS6eCXNSSpM94PMgSPFxdIWNPO71BhGdZULgEYp0xP45R75frVRiRcEVST+Qgj3+HH22RVOeNg27yCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDFWDTXexUBb2oDNMvreaD10TViR+8VJmb02+gBmZ68=;
 b=bBHVmIFJdOxEXBcXvdDs1yJtZB+VlnUfSYC1JzylV37F8/+f+/9EGPZl3/9dEsyzqc+kb950egsQRjQLteIcFY7dHDGA0A4iOIZqtXHZeNoPW+8Ko87t+PDfpKPN/hWTmgvI+diYbaYIo4lKSiw2mUnYU2qXDO2hrBdfxnyOk3sMkbFrkzyfnU5ehfT2AM5wRh2pRgAHKg28I80tOx3Jr911DTHSDWDnfl6eImZevXTeF7Bkp51LKsE4PLA9dqsWPnwcns6/WlTGq2lbgGFHbbuS3NL0YOfPS4wq9fuzUaKLvMfUsG2jPXvyIKR5tdVFvbgV/TK6ea2DzGEKxFHiBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDFWDTXexUBb2oDNMvreaD10TViR+8VJmb02+gBmZ68=;
 b=qLrbt1BNRdUmzqjnTL8tKmffoh964WjUKLINzC6DVlAwR4GPyhjmWLnTfVs6H/SokbNxPG84zjAVAZH6b+2M5xeFz6cwJylLD2SSHB4/1XbhflTfi2A3LCSRisLoQ8F4fy6LGgYd+BOhjHtv+p4MwE/JJJR0Ye2Zol/iX5Rgd3JAgLEOB0h4//QE1zHIrToFlZfbTF+oKPTDXjPxqTrdoV8SS7o2Zd21g62jveE/SIClNLZtNa+lUAMGbzPKkRhaCOjqvUV1PvW7TdARiAmEEvG54/sxTtDZqUPR/CrSarNkqfU6aUK2e5HvSuojoI2ZbSmZe+4aZBLKBbTOlR1zPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4083.apcprd06.prod.outlook.com (2603:1096:820:25::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.10; Mon, 13 Feb
 2023 14:18:38 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6111.010; Mon, 13 Feb 2023
 14:18:38 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH v3 1/2] f2fs: export ipu policy in debugfs
Date:   Mon, 13 Feb 2023 22:18:24 +0800
Message-Id: <20230213141825.22858-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0112.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::16) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4083:EE_
X-MS-Office365-Filtering-Correlation-Id: 955b7598-b560-4735-4adf-08db0dcd32f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cKqD2054K+iBG76s/W9cASTnPGoR8THEtzpdcO/04LEopie4vtZSm8kXqI9QTllRcgSHCYIWxBrgemdZhvMa7WVtSvVgCNTgqtxw/Bv2Su+z9TMbC7SwWkX32L89A1FKD3nLm1CyCuNhMaGQV/uPJafNB1FoqdXAmaEJWhq+bmwinWVBy71EFakg07aAULnEd2zsJ+/ku8qamFJKwmMem3Kiewn4r9+/cXcPk/DoQwHJh+SjBSs3LvCfnjCUg4Q5FmAZl8MDirreck9spsKllssNhYrgzl+nkKmsfPHADRo45vaB1jw7HH9a2/OGjQS1jqfYRtwlmZypilB3uMSXbL3OcuGMnGU9q2LGZi1B/i5ai+PGX6n2VD4oITXgXGP3etAGfXRukEMKI3CNzlfLZQX/U8jAi3P713PcHZanig2Qd/oezQwQ8ftONeu+akHGnSxEPmwZcjr9OQhzbeHNoQwXIBxbvHxN1kuTBdMl3JfPJCsy+2k3KxSix09TG1hIqh1aNAiuK9ok6zqiC99I6/e6uLIWdzAk8g++ayyvgYetkaJ/YoXP5h84dP47bHddPItm3Dak2IZ3+2Hnl0RgFz3gdhR6q2Fe+jsVP5bz/KiTcZT2FF0+7aP1t3Xj+wib7xDfeZePqtVtOjYSI7ukF0YWBZpeg6P1ajX2p4BmV7tNxrjgbxjK9NRPRYj9h4f8zH+jIyAimHnTOvygNZOYZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199018)(38350700002)(38100700002)(316002)(86362001)(41300700001)(8936002)(66476007)(4326008)(83380400001)(5660300002)(26005)(186003)(1076003)(6506007)(6512007)(107886003)(478600001)(6666004)(66946007)(8676002)(66556008)(2906002)(36756003)(52116002)(2616005)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+g9p9zvpeWBmhLwMwHrgIj1uXTQ5cMp1o9Qqkz8a8mcJ/V8d/yk9zekfIBHD?=
 =?us-ascii?Q?xGwyHnewlpLmuszR0CpbcQWMeZcmmLoUPvQlv2uf1Q4XGRymCEofSMh2VhhT?=
 =?us-ascii?Q?CtpI9C5K2H56uy722XAIH49qUyNrEBlIlEY0HlLvwVLDqEUOdk7WtqKClKco?=
 =?us-ascii?Q?j2aHSXwbxAUbVQJcEpAMqtm3rmchkyfZZhGUIiTj8MLz/9n+jgoPHgnEK/nx?=
 =?us-ascii?Q?NVK835XvlMb8vXnyo6V6g1AXwk2HcJuvLIu1jqNailXcZI3JYNZUXp7EfRK+?=
 =?us-ascii?Q?ndQlm84dhX1x/2mnlQaVVZR/EMwmGm2NFed2BGK9UUja0tGmfnWXeb0XuSRc?=
 =?us-ascii?Q?cMPJmU9/KcuDY0GETJ1x2TXfCM1ATAbvzBCP12ijtjYbyCa6ip+s8ojnt8WO?=
 =?us-ascii?Q?+UjgRo7+ELyJWEhyPw0nhbWR7g9DUoFctTxPIIDv+U2/WfpwUtVXcfUxqy4d?=
 =?us-ascii?Q?/UzK9fYCWwtHJXGtIGeWpkthmaQVerE8X6xpTHpIEL4c1jSu0OWXQe4nw8DN?=
 =?us-ascii?Q?1Tmec1cI4tierFyjX3dqsRrhrQza1opJKcy3Lb/9SQHWTDZ79fwnkiUuLzvg?=
 =?us-ascii?Q?8O0SasN/RIP/p7B/fv59zhhCUZ/O8d+jI9s9wC8/prLvy9o/KwXTJshzLcYd?=
 =?us-ascii?Q?HN7GDKCb1ioadaDQRqS3lRQ806Jh/mogFDu/hDWJi1XHRdcES/cexyjgdvcG?=
 =?us-ascii?Q?y28w0l/K8ZScn8EySkzB4DEPl3SpwDgWEfvgbLGbvShYvAyJdilLWTICCq65?=
 =?us-ascii?Q?qtxeTKFWN/rqqEJNGm4a+ns6m1X2kmJ+XwfS8FNX1KXjLiQtwbftoF2YnOkr?=
 =?us-ascii?Q?S+LyY3OMAf6+tzsbh1t55J80kmQ9ZZzLw2CgPlopsp29CjDDINJyas1NkedE?=
 =?us-ascii?Q?6+DGh6dojx8fKB2Z3wWQor3KToIPItLLdDoZsWu38Yr22cl55arq8ISSxvSI?=
 =?us-ascii?Q?0fDrWCdr7DiiKITbFuAGceQYDQX3LL9zv5OdMnv1xPRd2Ljx927jIBudwJJ4?=
 =?us-ascii?Q?MCV5xEPQyVSopNiuj5NfLjhRp0pt3guWaBzSs+XBh+3xr2M2qFPJVV/GWWIc?=
 =?us-ascii?Q?zpH1vpK1ye9XmbG8RuMlTkx3hB9o1cq4vIDWws+8BycRX1U4Ww+SDTx0cMZE?=
 =?us-ascii?Q?apJJyGfrYxTHRK49YQSTkD7kzvSznZkGF8JTzrmmL1Uo5rOn9Vqq5dTjUTJL?=
 =?us-ascii?Q?/UaIKZp5mQAvnr+4Sviiub2naOKQ2GzqilV+yfA+AhnfVtsY16zklIn4CeHA?=
 =?us-ascii?Q?Sh+QlH1nMNL4TU7vsto1BlIQYuY+d844fHwRAGEpkodPrjLIth4ZPh0P14Kr?=
 =?us-ascii?Q?R1zlX7nV0n2xCFJ9pxxlPsPf+TZlHOLUH9TneqGzrYuXn7pIp1jnU8ArXOHE?=
 =?us-ascii?Q?/B0YMrAlvP/WYFvyDnej70E4hE9NpogeF/Vu9cQ1vpg0+zlzqmDIFeTVLgRh?=
 =?us-ascii?Q?Gx0Cr9CVgHEFdd0Ti17uet3wUwPC5kMKsA/9bo2Ci4UOykZDcqsvz4E9Y3sN?=
 =?us-ascii?Q?R7xKYC50rt/hATGADiSGCelYqTnmEt4L+CwlB5kpXc+oFDhmQPfkydPIPLvb?=
 =?us-ascii?Q?ptq+CQmGVGDVMkwrRXmtsx1zCJnuYeEXcKvkg6nN?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 955b7598-b560-4735-4adf-08db0dcd32f0
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 14:18:37.8840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N0Z15d8MAwiDS/kiZnY6HHuCBhHktoabqRpH8THryKoS7k0To59UvN0QeuWaHt+wLYcfCeuqAMk8HhavQNnu4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4083
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export ipu_policy as a string in debugfs for better readability and
it can help us better understand some strategies of the file system.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
v3:
- remove unnecessary '\n'
 fs/f2fs/debug.c   | 24 ++++++++++++++++++++++++
 fs/f2fs/segment.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 32af4f0c5735..ff5995cb9560 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -354,6 +354,17 @@ static char *s_flag[] = {
 	[SBI_IS_FREEZING]	= " freezefs",
 };
 
+static const char *ipu_mode_names[F2FS_IPU_MAX] = {
+	[F2FS_IPU_FORCE]	= "FORCE",
+	[F2FS_IPU_SSR]		= "SSR",
+	[F2FS_IPU_UTIL]		= "UTIL",
+	[F2FS_IPU_SSR_UTIL]	= "SSR_UTIL",
+	[F2FS_IPU_FSYNC]	= "FSYNC",
+	[F2FS_IPU_ASYNC]	= "ASYNC",
+	[F2FS_IPU_NOCACHE]	= "NOCACHE",
+	[F2FS_IPU_HONOR_OPU_WRITE]	= "HONOR_OPU_WRITE",
+};
+
 static int stat_show(struct seq_file *s, void *v)
 {
 	struct f2fs_stat_info *si;
@@ -384,6 +395,19 @@ static int stat_show(struct seq_file *s, void *v)
 		seq_printf(s, "Current Time Sec: %llu / Mounted Time Sec: %llu\n\n",
 					ktime_get_boottime_seconds(),
 					SIT_I(si->sbi)->mounted_time);
+
+		seq_puts(s, "Policy:\n");
+		seq_puts(s, "  - IPU: [");
+		if (IS_F2FS_IPU_DISABLE(si->sbi)) {
+			seq_puts(s, " DISABLE");
+		} else {
+			unsigned long policy = SM_I(si->sbi)->ipu_policy;
+
+			for_each_set_bit(j, &policy, F2FS_IPU_MAX)
+				seq_printf(s, " %s", ipu_mode_names[j]);
+		}
+		seq_puts(s, " ]\n\n");
+
 		if (test_opt(si->sbi, DISCARD))
 			seq_printf(s, "Utilization: %u%% (%u valid blocks, %u discard blocks)\n",
 				si->utilization, si->valid_count, si->discard_blks);
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 6003fbaf4b7d..7230d0c6c138 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -672,6 +672,7 @@ static inline int utilization(struct f2fs_sb_info *sbi)
 
 #define F2FS_IPU_DISABLE	0
 
+/* Modification on enum should be synchronized with ipu_mode_names array */
 enum {
 	F2FS_IPU_FORCE,
 	F2FS_IPU_SSR,
-- 
2.25.1

