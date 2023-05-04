Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9849C6F6DED
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 16:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbjEDOo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 10:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjEDOoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 10:44:24 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2125.outbound.protection.outlook.com [40.107.255.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B30ACD
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 07:44:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6XnvMfXxeJ/EasPRbIlK06f71APRD+0Vg5rJJ5FY/QM7T4PMorkNiiaMnLlMAJ8aMOiPnoNdpG6oDrDwNAxLIeoPXWSW59cYQ+8DtCpjwvAY/UboXWHmhzXt22lKx+gB3H81RzSmG4tU1UEXzU6z5T/MfVsIr+TRb6anCOQdqKyy+vNJslvu+54meQ9g+hhrSc3mVyN1BT2dSnJ3H1ObUWou6NEJ+HA2B9vjejaOjJhUXku75QZqO7t5IBMjQcq66qkMZPAq0wHdgXw7TEfAqMo7YBw/lqqCntKv3/bE7jVGuElW10Cw93RCTUjo3dzqhw4nygjHchtyyaTbb+D4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58WzU6uCQfB+vCcXe3oAuOzMFVi6wl7k0PK7KYH2dnU=;
 b=CmtbALFVhZTgrkKLfONJjkE2Q1gQXLw6Gfj77Epj6+dk1j5pwKilUW1K9NlmsqgKie8uTgBcYmDra0lYoyVTQGf1JfYn+x7I6i0LM97hHOXNKMs2aS1zD53zqTG62W1OUoeNBz5VcYIpJWtfKPnNzXc4wR/5QX0YxwiE4d2AABY8yX161GiVTjIx7CdQa6yoIkxlJnnkwqeN8JglNQ7edWAeSdjSJbLB5pkLG/SnFJn1POEW4haqKvjLxbivEMS4QsPfc3Z1Py0CpSXagVw3pyO/POpEU5DlmNQykC4YVMi91uXFk0qJX88RHM9/9ONkFBlpJyXKk2EqHTz3SIs9jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58WzU6uCQfB+vCcXe3oAuOzMFVi6wl7k0PK7KYH2dnU=;
 b=ndqXD4heNnmVotNbvAUTbMZjdH4o1WXP7zzQ07UFL+Pd/M5sR/BOeriVDEqtMm37NGbCxERed+G8Y/6nxw/Epp0WcwteBVUaRBD3uK4l4LWezhvS7FC7BWgH6aI0ZAZStLME8+FOUPvl1/cN8FOorO+1giqJYSE8KihTc4k5bO3ZYmT/R9HycNT4sIkYPVVXC1jgyDy1c8xROHIlXX5xNGDKkRuqfkRjM05uxHwM87f6dx8F1MJkcb97ozXlGAklqHOrpUiq+f/oDVD/iqgxT0eS6qovqMcNksBGrkZbbtBWLXHMKVDz0fGqkD7rnAhr0F8yVHKPI2kq0vlHlJGHSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5258.apcprd06.prod.outlook.com (2603:1096:400:205::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 14:44:19 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%7]) with mapi id 15.20.6363.021; Thu, 4 May 2023
 14:44:19 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] f2fs_io: support move_range command
Date:   Thu,  4 May 2023 22:44:06 +0800
Message-Id: <20230504144406.33713-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:3:18::35) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TY0PR06MB5258:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ba3e74b-adee-41e8-d426-08db4cae0a88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i/+DvSTMM0Bz79/lG4AeIDPTnQ5JWvRPxkDUm+iG850Lv5X6fIPNpZBj9PDqDq7vmKJYCEPZdYNNn2cWPPZCMEJBHMreug/Nu2kyXOlKbdkkmiemqcmyO15Wz7DDEXzU6PJdfMYvuPLi1wYoCIiOJ0oKw4wiHgqL57f3QwhX4WMi0AC3q56nK/cjopeapwd0rzzAdPsjbILlEpRIIopq8jmc0iwRJHTI2uIkvCsZbOgGXPOv8rfpVLFBronCaask2+vArxP368I0pkpJuickmuARV8pDB0Lq95cyowIRqytIp/9vQYMXuDkclYITnkJEmQGa5g+8UDxkMUtosSDI704Fehh6hYysBGD13SxMBkN9Om7Sw778EGTW/32LdjzQ9HrFUW+apqLYDtwgHcCK33J8LAn2ZtAOGQJcrQWHgsRX1l1KACDe2Z2d/d+2cwk9pFwypvdwDp65GdkAhPSzVuBHoOKuKo1QEds41hqc/vsUqstRqKjD/oNB2YcR57ync2zIfcYCQt4mjBnK8Yl8tNAdZTsoDse0loHShKGcJzbgxuwOWs6f7Mj1ym9KHjw9nmuEl7BGXWxfN6VGgHanK3TIz6o2xgIHYtrwUskxH8REyiQTXO2e9CqN5AuD/tWr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(451199021)(2616005)(6506007)(1076003)(6512007)(26005)(478600001)(2906002)(83380400001)(186003)(38350700002)(66476007)(66556008)(66946007)(38100700002)(5660300002)(8676002)(8936002)(41300700001)(36756003)(86362001)(6916009)(52116002)(6486002)(316002)(4326008)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?muj4pde9pl4U9hc0yt7giuKU+6HV/5NFLcJSvpMAEDnvIU2qjzGP2JdyDT/C?=
 =?us-ascii?Q?oMiGKKQqDKK+KTjB4HfZKFArTCU0PEXMu6UBDVoAgwA+bIzt5pWmmg1hxGxl?=
 =?us-ascii?Q?nhZhD175WxojY4ZosG8T+E0CEx2OpAfPNvfq6nwHnrN5v/eBA+2heIj8ivXO?=
 =?us-ascii?Q?F5ad5anyz5kGVubV6DQ6cDfukbq3urrJTgrq3rOiZcAbCHobQdAIJwCp4pjG?=
 =?us-ascii?Q?imuFxDacQY5zG7RX0a9GXlntbIH3lAq8elsTIfHF3i3ZY1IBxUnhZ28gFppk?=
 =?us-ascii?Q?PVJTrQRjXzYR4HFQFpukbiS/l+cJMgN/7I4AK76uBiR9z5vuAoDuGBuIHZ3O?=
 =?us-ascii?Q?35OU0AdO7TzoYlQUsEfUxHY6x9MtcMBojEuCDcBFvpFf4KSHJ/MN2fDv9lUD?=
 =?us-ascii?Q?ZeL1G8xeEs/Cl1XylN1uQm+8RoA45VIPzYbztgziWvtbSdo3lZcPFzENfz8k?=
 =?us-ascii?Q?8SxaK1T/y6Lnjh75FsrFyLpSFW5jefrQ4Inp/F2ET4wJCAeqgFZfurha6hk6?=
 =?us-ascii?Q?yUoM7Q4gSNVeeWkLjWAbpM1I9kHg5Wqj5RR02Thw5cokNuQldZ/0UiYzoAf8?=
 =?us-ascii?Q?ebwM6etR66x7ibC4ox4RVEObZc0DLm7kiH9VV5FtzcX7XyoUK26r+msI/CfM?=
 =?us-ascii?Q?H4cSpcH5J3ITkkmAqU7tQ3T/ELJrxL4g0m5SS/KSRQaUTQxcxnFoqvJexyyq?=
 =?us-ascii?Q?cRg3RHnZ90hncDJ2t40XT/TMTkl00UixXQi9iWeLZPXivKSJQ+qFvcImFIlr?=
 =?us-ascii?Q?TCb3Bj/3j6mvVbVpQLyqysLJv9vt//EKdQ0NTLr74Q6TwH8pkttuplOWgimY?=
 =?us-ascii?Q?ytJ0p5/NnX452H6LoekgG5Zmx8G77s3AmlP9NYExkQxVZY18Tuu5fp1GA62H?=
 =?us-ascii?Q?e8sA0AKwFvJEoBIKzmCxkJPZBhO+eN/E4CBxr/Fd0MDUrXqlLAtEodwBV7M4?=
 =?us-ascii?Q?Qv3rREtPshJ+NF9lpbjN1c/nP4GRS8VR8UWUG+o0atTrLWMx/hWLYbcwziqt?=
 =?us-ascii?Q?tvIJ9Xh2QW6qRbonod7ScSHz+6vHy7w983ZdBFu1zyXgAWiyuaLn+9Dv43uD?=
 =?us-ascii?Q?+iHUEUXGpgRalFMPzdaKoCGTymfj1JJrJdC2e9JJs4LddF5aSoj5AtSLJRK0?=
 =?us-ascii?Q?yxL1vjwILy2wms9WIT4FWlOiGU5VlPkfyEYdAYaWGIb/BYdX7vjmzlkYZ7O7?=
 =?us-ascii?Q?JaiZ/z5f1ysX4oi2iHmshNiDzO0jZ4fBYQ4/vUr4QErV2TmTAtswtAVbJ3lE?=
 =?us-ascii?Q?gN3T1TbZwDWmgJctUY0kPuGfAO7N2aiK/0tvTp8YpeoopUJVa8cpt3iFPv0e?=
 =?us-ascii?Q?af63Vl6hMTcxBV9BS1Azdkf3GVeVDH4M7Olxciin8FXRDk/GGzejN9Lo+TiF?=
 =?us-ascii?Q?w8QKtqvzdPcFRHRCwGmuMG+e/pEFQLlSSxdcGj1fxzcLmraQ/bprdrcTb1Hj?=
 =?us-ascii?Q?0bV1Pk4Se/b87wwVXr5ZlsfCidtTBVMpJZ1xj8OK0Qn8AAxC1KEwnciE9iQu?=
 =?us-ascii?Q?UFC7VXwp/hErmmWqAmvwp0HzX5cSE61/IqCoOr8ydyqUHa7uNOL1f6DQiLSU?=
 =?us-ascii?Q?Mct4LKNwBhelthrEjLDXyz1smRT/TWMKO6daaW5K?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba3e74b-adee-41e8-d426-08db4cae0a88
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 14:44:18.9315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iat2orIySzOsPlZGLJj9joCzwf0K4UrX2H0blQagQoiusG4W92CjutOC15Hm07IHFY+jDJdJsl/CMcx4qodsgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5258
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch supports a new sub-command 'move_range' in f2fs_io
to move a range of data blocks from source file to destination
file via F2FS_IOC_MOVE_RANGE ioctl.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 man/f2fs_io.8           |  4 ++++
 tools/f2fs_io/f2fs_io.c | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/man/f2fs_io.8 b/man/f2fs_io.8
index 13d4bf3..b25f807 100644
--- a/man/f2fs_io.8
+++ b/man/f2fs_io.8
@@ -138,8 +138,12 @@ Trigger filesystem GC
 .TP
 \fBcheckpoint\fR \fI[file]\fR
 Trigger filesystem checkpoint
+.TP
 \fBprecache_extents\fR \fI[file]\fR
 Trigger precache extents
+.TP
+\fBmove_range\fR \fI[src_path] [dst_path] [src_start] [dst_start] [length]\fR
+Move a range of data blocks from source file to destination file
 .SH AUTHOR
 This version of
 .B f2fs_io
diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
index ac7b588..d545d8e 100644
--- a/tools/f2fs_io/f2fs_io.c
+++ b/tools/f2fs_io/f2fs_io.c
@@ -1357,6 +1357,40 @@ static void do_precache_extents(int argc, char **argv, const struct cmd_desc *cm
 	exit(0);
 }
 
+#define move_range_desc "moving a range of data blocks from source file to destination file"
+#define move_range_help						\
+"f2fs_io move_range [src_path] [dst_path] [src_start] [dst_start] [length]\n\n"		\
+"  src_path  : path to source file\n"					\
+"  dst_path  : path to destination file\n"				\
+"  src_start : start offset of src file move region, unit: bytes\n"	\
+"  dst_start : start offset of dst file move region, unit: bytes\n"	\
+"  length    : size to move\n"						\
+
+static void do_move_range(int argc, char **argv, const struct cmd_desc *cmd)
+{
+	struct f2fs_move_range range;
+	int ret, fd;
+
+	if (argc != 6) {
+		fputs("Excess arguments\n\n", stderr);
+		fputs(cmd->cmd_help, stderr);
+		exit(1);
+	}
+
+	fd = xopen(argv[1], O_RDWR, 0);
+	range.dst_fd = xopen(argv[2], O_RDWR | O_CREAT, 0644);
+	range.pos_in = atoi(argv[3]);
+	range.pos_out = atoi(argv[4]);
+	range.len = atoi(argv[5]);
+
+	ret = ioctl(fd, F2FS_IOC_MOVE_RANGE, &range);
+	if (ret < 0)
+		die_errno("F2FS_IOC_MOVE_RANGE failed");
+
+	printf("move range ret=%d\n", ret);
+	exit(0);
+}
+
 #define CMD_HIDDEN 	0x0001
 #define CMD(name) { #name, do_##name, name##_desc, name##_help, 0 }
 #define _CMD(name) { #name, do_##name, NULL, NULL, CMD_HIDDEN }
@@ -1391,6 +1425,7 @@ const struct cmd_desc cmd_list[] = {
 	CMD(gc),
 	CMD(checkpoint),
 	CMD(precache_extents),
+	CMD(move_range),
 	{ NULL, NULL, NULL, NULL, 0 }
 };
 
-- 
2.39.0

