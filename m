Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4403772DA4F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 09:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240320AbjFMG76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 02:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240348AbjFMG7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 02:59:49 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2117.outbound.protection.outlook.com [40.107.117.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66450170C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 23:59:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bnp7zlNQyOcaiQObXGltYOFLyaCSkMdRM4q9eR/hSAdxdzOMe/ym3xo4hIPToXU+Nh5HrUBws44rrH2bo8mjgjog/B8DdWBrdwRVxcnwBLeqkyFbGFX56S2KhS8HUpinEcmcy54aMcyeF4/Ax+Es/F10U+esf3vCnlBqN7SCKnHRbggPl/CU2GNcj5HGqJkYOHzAk88CyF4At06cbOTMeHCmZodgLLdjy9Q1mNq9n/tVOjp46HViCYvzyHotH7jAc4p6dBDUNsGnpr8/p+/oQLSHQeMI4tnwQZKPTRA1rFxGrLNJs2yxQJGnzGRXphvsrac+DsCo3U/UhrFSW7GEUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Oc4+e7EXhHKHV7K5cnyCAqrUF7nyWFB4xpnNKpo1xQ=;
 b=F4ASci7ZbQgQsGS+DB8o72a50gSjEN346lyp0uzKPSLZBVFc7+Si41xfZMtSCQmO4hVgWhcO47NBUrKHv8TMwcRt1vORTo6MDy8PhIQnY8Ql2Zf23Dtn36q4hPAXqL7Ara51B+yqIZwSIwT585RfcVjAUbk3+zTHTO2qt8qnRda0q0tDDFN1BfDhOCvDL+lSYlZyLyDeATCgRYzreFor5Q4V7fzyAQhyV4CCQP2AUi+lJ3ErNBjM2ft3LewbDeooCLNEeHx9Hmp3NQjKF3V/DstG83uSSDXKU09vegKnQKLMy/eP6xb/o/6PGYAS5QFHrBpMgEQyHJvz6a3CFi7Gzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Oc4+e7EXhHKHV7K5cnyCAqrUF7nyWFB4xpnNKpo1xQ=;
 b=mGk7Zv3LW2fK3wFDqsss0s4uViZhfky7tQAF3RhSeYwdzwvrrHto7JYkDe8qJfwTe+GcUZFlTYkzPws2swUgxPi9Jy7QjDlVKh5JlnYWKj/18ND+JXisPKPH7+4qfDrC0SzkhcDiPbTRV/o3uLODG0t3aAxv51x+RA3DKYVEnSp4j7x7tBElYuJsLcJ71bz6xEH5qd3/VtNuuPUx6Z5lqRJCQ9t8pf3YQI3uA3IKpLC/08WG1QdUUEXEv5Yuj5x+3Dx431nKtd3hWZXBJ1CkEOcWKEyFO+zwjJuPlOJjMAxSZdIS6OFma9/EMgU2TaYS5xQzVIs8WUysoF7qt8Pmfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB4096.apcprd06.prod.outlook.com (2603:1096:400:2e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 06:59:26 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%3]) with mapi id 15.20.6455.039; Tue, 13 Jun 2023
 06:59:26 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH v3] f2fs_io: expend fallocate command
Date:   Tue, 13 Jun 2023 14:59:10 +0800
Message-Id: <20230613065911.4304-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0117.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::21) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB4096:EE_
X-MS-Office365-Filtering-Correlation-Id: 90e894af-606f-472a-74cb-08db6bdbb993
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /lybIc3rqWhSKofmo0h721qXtTTRmE44UkP6fsNyD7ScNxhLnLFckjbv3rlc49sQ/ea4Jj1yat1Y47lwM+Pg3jkTx4I+7u+8VFcI5yYXhxEGjbLzMNLjOT+BtvXcf4Pos2pVH93FPTqaE9loAcaD+fNcQpu2+U+1RfrRq4m09ifJ+j4vI7v/141CqSuDv3bk/N7o8Fk4r9gnUICaOYes0gfoAFjwsQrwk3cVcipC/t3afFjW1r8UYq5Cc8rqdBK/du6Ae3sOnyKrlQ32LJuTIbJaXZf+a0QnnhTQ/cSlxrNTbctQ60WGuFTtRaOrlmYXZGyYZMOZnGqYvoug4YkN30TPaRHscFkG3UQqGZXmX3rKKzEoIb85jkiMCaqvEFvVtwkenMK9Xfd+a0uxZmgxRaiuQV0KShEqi0BMFnO+EBJUu1rjDtY3Bz9GOki9VEd2we9dike55Fy0TBLKvtL+/F4CNOWnh4woasJV+6NaDAWw54HwKp8pCNIwMwniYGghPy6UCXrCL5pOtz6eGF5Ca3WvfXD6NGfkmQRbPD28Qdnh0c57hCIThntRu64IJBOTFE2FHuRI85xNDwxqPRbp95dsPFwLl2ncENjJhlRIp09v66FblcDwTfduacFd9Jml
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39850400004)(346002)(396003)(136003)(451199021)(2616005)(83380400001)(86362001)(38100700002)(38350700002)(36756003)(478600001)(4326008)(6486002)(6666004)(8936002)(8676002)(2906002)(5660300002)(52116002)(66556008)(66946007)(66476007)(41300700001)(316002)(186003)(107886003)(6506007)(6512007)(1076003)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zbE4BA2Mk84uk+vmNR5RGrOF5m3ml0baLjBQs0a2aNI2xPYzVJRg4swvGewX?=
 =?us-ascii?Q?1Drs2madEOl+l4YXksZwB6VO4lEITlC0EP8WyIMe1D6SUW5uWUjlUIecMbC5?=
 =?us-ascii?Q?KRtEo4upXoI4wAopRVbrf9IcHMUgV/VRwsFxuRvOSPjRwh8zzAAj6A95geVT?=
 =?us-ascii?Q?+us0UEn7DgruTbG3qz4TJO4TXCFdsKQbT6TLCvoQQg3eNUh5mz1uDERcLD09?=
 =?us-ascii?Q?yDiVwA0HM4WJfLBmGXTPf1IyvCkdd1jHfL85PPRth0vawe2qCrBHj2dc1A5T?=
 =?us-ascii?Q?QzVu3mY4hei7Z3ynj2ePcDyiDihxGvit2v5cSty54/G1Cv9m57U1O8uUp/oW?=
 =?us-ascii?Q?ZWB+om3SUxFo5GtOHSfHd2GxICbructgrOZ3Mv2ZmZN+FL/g5QeudsXxNezU?=
 =?us-ascii?Q?O875Equti2pE7m7/qq5mGB3QOUpm476kTBi8d/blJH86uxmTGOVoz/0quoaR?=
 =?us-ascii?Q?jci9P0noofjRFKsbo77Fs3C/zvnMRZdRTgHkXnWM1jj/hLpOhNIsw5xUzna+?=
 =?us-ascii?Q?HQfZefXrDLCL6eZgdTL5+IjxWygIDrt/yx8tPXtUx/4yzrlQLzA6dxb06O/p?=
 =?us-ascii?Q?DylwjkOKJP8MqHrzvwUSDcQ7MTHGEQAhJX3MmwjjJvvEBTPnAIF6YISPLTRb?=
 =?us-ascii?Q?X8U6LHL4OfuI4N0NZC0tiKZ4HF5kzdRNLvYBzjjkeidpPiU6akpLLYCyRXr2?=
 =?us-ascii?Q?dYpDj8DgWuEb+Sn8K01pNd9ucYGD+9930FP8PS7J/N0qSuPNg38XoLoVC3iv?=
 =?us-ascii?Q?Uh3lm5V8Atpyj+2t+xqBMetkTz1HmcQe4uuOLyB1bDQdxpdkK8OnUHKGJvX+?=
 =?us-ascii?Q?286EqB5NVBdKrqT8K7Wh8j3QluxUoXLqkSg+XSHOZY/jOw4+HQwR68OTSRWG?=
 =?us-ascii?Q?Q75UAMo4vmsZsvSU5jGKMOhdGs95BdCntqh72UxVNdhZ9R2j/o9nug+lRbyk?=
 =?us-ascii?Q?GJZfTxw+Um++RmT4GdelXcdKnrmciFlqPCPy87ZXwVoi/dYWDM+z20nlpJfJ?=
 =?us-ascii?Q?FUdPepTk6r23zVQv1bVrZviTlUeZYZ4lf3TViXezSgkMqa/uSSghcNd9NZMV?=
 =?us-ascii?Q?j/r5STnqHLKzsEoK7I/jFvkPm+Gu1xsT+GJb/p9uxivOx1RtKuMPwRO8n8Q1?=
 =?us-ascii?Q?HQ2C4eRQpAeTn4+0ScVJi+L5DOeRN3kaDAccKdDheb2NWvIVTuJXX1JFB+BX?=
 =?us-ascii?Q?f/Q7FEYOFqHjvYW+WhA9fFTNO843guzszJSICcIonCPQGV5UmeUQEzFZHJVP?=
 =?us-ascii?Q?wecxYpifeHSVV6Acu4XhNUOq6eotWWjdee3xJlTEYzVUF9vOxqE6Z0HNq2ZR?=
 =?us-ascii?Q?t9P8MxFinUE4BWsscVNZHx6UpIJMcGMX1vuImwTYiGYvcs6vvMt8lKL3Ywt7?=
 =?us-ascii?Q?NS/o4lwBMrn6iPR6BAEBKCltnjp5+GY9ib6DUVkXBorjfreB+kMPGSf+Kn7r?=
 =?us-ascii?Q?GBGL4No54HaQv0PbmOfK86ghijalpb2rdECyWBkPL8lJFn/2it3lOF3YYAOu?=
 =?us-ascii?Q?o9oFvD0n/dR2rz9UJYceufMSf/QNpPEf2kLL3iZnqZOGlxOvJtJxBp69n24+?=
 =?us-ascii?Q?Wk/PNODN8YeEp4fwiywSBK97iRSX8vNSGArSeEjU?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90e894af-606f-472a-74cb-08db6bdbb993
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 06:59:26.0968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: STmn6fwZXErJFRlZigRVXqtuqAsCflwHZpm0LmjYq8sPnhkL9BMY2+kRE5aZKrMZCAHuiRK3NNUoM3MwwR/zBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4096
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expend fallocate command to support more flags.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
v3:
-update man/f2fs_io.8
 man/f2fs_io.8           | 19 ++++++++++++++++++-
 tools/f2fs_io/f2fs_io.c | 39 +++++++++++++++++++++++++++++++++------
 2 files changed, 51 insertions(+), 7 deletions(-)

diff --git a/man/f2fs_io.8 b/man/f2fs_io.8
index c5eadde..450f1b7 100644
--- a/man/f2fs_io.8
+++ b/man/f2fs_io.8
@@ -43,10 +43,27 @@ going down with fsck mark
 \fBpinfile\fR \fI[get|set] [file]\fR
 Get or set the pinning status on a file.
 .TP
-\fBfallocate\fR \fI[keep_size] [offset] [length] [file]\fR
+\fBfallocate\fR \fI[-c] [-i] [-p] [-z] [keep_size] [offset] [length] [file]\fR
 Request that space be allocated on a file.  The
 .I keep_size
 parameter can be either 1 or 0.
+The
+.I pattern
+parameter can be:
+.RS 1.2in
+.TP
+.B -c
+collapse range
+.TP
+.B -i
+insert range
+.TP
+.B -p
+punch hole
+.TP
+.B -z
+zero range
+.RE
 .TP
 \fBwrite\fR \fI[chunk_size in 4kb] [offset in chunk_size] [count] [pattern] [IO] [file_path]\fR
 Write a given pattern to
diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
index 1774eca..b4e7307 100644
--- a/tools/f2fs_io/f2fs_io.c
+++ b/tools/f2fs_io/f2fs_io.c
@@ -413,9 +413,13 @@ static void do_pinfile(int argc, char **argv, const struct cmd_desc *cmd)
 
 #define fallocate_desc "fallocate"
 #define fallocate_help						\
-"f2fs_io fallocate [keep_size] [offset] [length] [file]\n\n"	\
+"f2fs_io fallocate [-c] [-i] [-p] [-z] [keep_size] [offset] [length] [file]\n\n"	\
 "fallocate given the file\n"					\
 " [keep_size] : 1 or 0\n"					\
+" -c : collapse range\n"					\
+" -i : insert range\n"						\
+" -p : punch hole\n"						\
+" -z : zero range\n"						\
 
 static void do_fallocate(int argc, char **argv, const struct cmd_desc *cmd)
 {
@@ -423,20 +427,43 @@ static void do_fallocate(int argc, char **argv, const struct cmd_desc *cmd)
 	off_t offset, length;
 	struct stat sb;
 	int mode = 0;
+	int c;
 
-	if (argc != 5) {
+	while ((c = getopt(argc, argv, "cipz")) != -1) {
+		switch (c) {
+		case 'c':
+			mode |= FALLOC_FL_COLLAPSE_RANGE;
+			break;
+		case 'i':
+			mode |= FALLOC_FL_INSERT_RANGE;
+			break;
+		case 'p':
+			mode |= FALLOC_FL_PUNCH_HOLE;
+			break;
+		case 'z':
+			mode |= FALLOC_FL_ZERO_RANGE;
+			break;
+		default:
+			fputs(cmd->cmd_help, stderr);
+			exit(2);
+		}
+	}
+	argc -= optind;
+	argv += optind;
+
+	if (argc != 4) {
 		fputs("Excess arguments\n\n", stderr);
 		fputs(cmd->cmd_help, stderr);
 		exit(1);
 	}
 
-	if (!strcmp(argv[1], "1"))
+	if (!strcmp(argv[0], "1"))
 		mode |= FALLOC_FL_KEEP_SIZE;
 
-	offset = atoi(argv[2]);
-	length = atoll(argv[3]);
+	offset = atoi(argv[1]);
+	length = atoll(argv[2]);
 
-	fd = xopen(argv[4], O_RDWR, 0);
+	fd = xopen(argv[3], O_RDWR, 0);
 
 	if (fallocate(fd, mode, offset, length) != 0)
 		die_errno("fallocate failed");
-- 
2.39.0

