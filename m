Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7659672637F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 16:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235877AbjFGO5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 10:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235617AbjFGO5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 10:57:23 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2115.outbound.protection.outlook.com [40.107.215.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7E71FEA
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 07:57:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/6/HfoRtg1GWz6MKYL0arRCSIIEOpHTzvMyzRAAAFF7LeclXA6aKX5kMGC42dU3NObzpkZylmtGDZ9B3htaqhkbeLeZsdvB1Crs4kjZgrTMQyXWqXSFSF3BwgHHraHgA3EBO4MDqj+GloXHXXXhYlZFVeUlJAZOFiNV8riIfvP3xh+BMnPTCiJz7oLFHmBaWlSFU9Q1zL+XRk0xnB5AIrpoFIMoGNj//8mi1VttbnR09tAWndLC6KazdtfCM1doN38EwAKIMRum17+ThddtIxjEjSpYJKMo4lG4CQVTlnUy3WqVSnQ7Teh7KcPY1vKHRXMltqrk44jo7299Or74TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zwFMrIxTQV4iF+ddpfy+9Y6iUrW/T1xCHoWeHWOGyRw=;
 b=TiMsJIlk2qTxC/GGUmxfYVfclrAtSZQ0JV57YS+JpaKYXsLWFy5NKYkZf5eyIbUPfQAP0BKFj6euDewnSHMTC60WUX9wTPJiJjUX5ycaFdclxEYB7JG2deWVrQeX4vO9iWF1UiP70MvOIenv+IRPUYQRjMGmu7BSYM7g4c8/2WDJQ6GgIrSL3mXvHVYmaHlBHDO6Gnnod9RdCb/8qflx0Y65CZ1o9roX78FFEBvuIK4szH9qtE0hzBPkX5DPKRDCsCghFhOBtBJZZkv6Zila4WFoVlQgwQkXxvokzOK+K9YFcr8/6jv6f/fAHrr7xQ2oQc+ZSTvQ4+hZt3LQffZBYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwFMrIxTQV4iF+ddpfy+9Y6iUrW/T1xCHoWeHWOGyRw=;
 b=JOkX2A/68pZJ5sUAXaafbuWLhx5d8QOmCQAVX7OC2zfJ/OsNqHIN/3FrxtjSZ7wXnysUFSbYcmv8Fo2uY0Zh6JXYQLOR0GzOpM1wuITr3ptW/DCBNpwQrYKDzsYJDmofoyKUfaclmUbUqpchwA4G5rth3UfNaaLlDc1c2x5xgx5zryEujGTaZ/RwhoWHDP+fIGykFeljIQtpGkiZd2xtwyBdDQs+ZEe2x3C4QpXpw20AJU8i13uLU/OBSYnxlAFY7A65+esS6AwBeyF8y+0t3qqQrSex2qPiNUBgX/k4iw+Tax6j0CBn2PGMFI8BMu5lv4TjBiDFB6scCy89UuNeAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5847.apcprd06.prod.outlook.com (2603:1096:400:276::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 14:56:56 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%3]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 14:56:49 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH v2] f2fs_io: expend fallocate command
Date:   Wed,  7 Jun 2023 22:56:36 +0800
Message-Id: <20230607145637.14769-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:3:17::20) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TY0PR06MB5847:EE_
X-MS-Office365-Filtering-Correlation-Id: af6f61ea-c223-4793-df59-08db67676c16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PrS9HEkTc2GLv0uZbLciLYW7u3ys6hKrIidHHre8XQWihUcXX6NuMKJN2otmf8sVNJQiWyIKmE6Tl1bgJdFdtGf+OWwJUbVzRMY0Yzl3OuuQr9PCXK8rMIbfy4nJK4IIBySV3LEaz18T12FYp9MTiU8OYdGduNP+TZIL7Tz/3NsbVFzh2PEJ7ZV6mm6DasUaBycBzXDxypv8UjbdIU+bvHLUScU1j++/Vs+uXrR6zdfrpGueiX18ioFQYC/5fD1kXuNhdfBv7My8jkuj/zBcXzoL77QTneoCFD9mGHCKVrnbgq+zzqDCLH+tunUhXuv/e4MOwukEMKegXU7NngBVOJaHk5PiXL9GAJYXTVvo9h4xEAD27VFq6rUR05oQKdYqEeGGooncXdluI+Rp7dvLA1h/e+yaoM2nnxP168yAPy3OdCfZURQSBqgCB8aJytmQ7JqkYSCRufUpaQsYaQCEAgifUPnVrnEi1YVdb9V8x5zqmNA3GpNcNzLcHXEMceijvqLUETJWXhuMw70hMzYist6B8OutYfZocz0/yBpT6eFrwfS2awcV6BPysBD0vJFFO+thLkofqE7vJsBprgzYaAfiLFRWanA/9FPXZLpCmeBz6GPFS7f8U7sf+GSVLltd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(451199021)(66476007)(66946007)(2906002)(4326008)(478600001)(6916009)(8936002)(8676002)(41300700001)(316002)(66556008)(6666004)(5660300002)(6486002)(52116002)(1076003)(6506007)(26005)(6512007)(107886003)(38100700002)(186003)(2616005)(83380400001)(38350700002)(36756003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4340QNsxYyADy9VYA6Hd3uNyGqbPmJZvk+Ij5AT8VRADWSMrG6zRxb42eM0b?=
 =?us-ascii?Q?EddKHjkQhUdAohOIJoEX0C72vGheC46Yfzvhj1Jl0GEV2C3Q9Uza+m3CTKJ6?=
 =?us-ascii?Q?QytUg0Mht5iVRG0qFgIYNMr3408hLRI3GpK+TLvrmaHpxwOp7KSzJEa2wJd1?=
 =?us-ascii?Q?kzZOrlfg2Pda5C6KSADgbf1fSEao8KieP9YiGK2PbPVA4GjyNPEuih2QnCUl?=
 =?us-ascii?Q?3xQBTIynOzdYs8eFIvMZx82F3upITQVdzbpopzhRJul9ZAQcydEvTBRsqEKX?=
 =?us-ascii?Q?5Sh1U9qiJZKAxRXQHQc6bDHjTlWuqiMWYTbdg50FdufMCLp0sJmthx4GcFBM?=
 =?us-ascii?Q?GW4tr6P2Z5AqrP5t+/+bPir9/m+V2WQwNDshP+xfgrQmrfrDKLxAHcgxQfi0?=
 =?us-ascii?Q?QO8y8qU1SxGROoWBJjelRbP+4hXB3oNfTQRGSmbM7qUZ1c3WjjN547Y5gKjS?=
 =?us-ascii?Q?icqmFDOAn61Sfvjz3/f3SH/hugT/i+kfqwnIqfGA/b2HULekU6Ym8eHuyI4H?=
 =?us-ascii?Q?22290B+JBvLqWe1CU2uH/B26xP8kltEwOM8zMyDEQHiEGZup5TafWxCqL/fs?=
 =?us-ascii?Q?weOuFW8DzhWSnEatrwKGBfikRVavBNuH7lz4DhLJAZ8qmv64Rg6Vh3iZ9EnM?=
 =?us-ascii?Q?lgUQuCJvyxfchybLfLlFzK7YPn7i6NrIZ0iBnpohQEYTnLPAUaIa2ZHPvQfL?=
 =?us-ascii?Q?LRSF3cMwKfAsfmPI5OJvXg7dIdWVyWPIdnOBuFwjKscvH9sZwu/OCtlkrl6C?=
 =?us-ascii?Q?KiOEdYOxt6We5Wy+HAES4I74Bngh9Uya746sf/oCraul9NwevVVnSxK3/ewy?=
 =?us-ascii?Q?QGXbo97EiRqFz5JJXFArN0z1M3RQkOMCDTU05VJI1ghTxDUaz+ar1wqul0Cj?=
 =?us-ascii?Q?XuXN5RfAA3TAi1TPGUWADTbQuPshKrMkN+ZCAFkSIX/ysi9eZEZZUe2pt7Xa?=
 =?us-ascii?Q?QVFXcDGXeidUa95EaFVuoVHWQjU6VfMYOdIXlKee1hYlIIazoEnxok7pQmXQ?=
 =?us-ascii?Q?A34iQvBE/KVFMPTR+LIXyXMGLCBA4f6Gr4dB0V2MF7bwfol8hsBhIsgepjqo?=
 =?us-ascii?Q?5gwTISYBhx5OtIoSzKrvcPljMRqWRYWS9f1CISMs/xm7+MlemtdEIm/7Mpt+?=
 =?us-ascii?Q?6oZEul6dBLneiQcNYGXP+Ugg8HgW8JQYAPoy457Ll19Ove5/7vocSEVyepEf?=
 =?us-ascii?Q?bLWmPfnLJFp0UBSsWUfMyYXq7Rti+YfmpGbEuc0uiu04MncC8qovaa2x2+Nu?=
 =?us-ascii?Q?rDB9K7HDIOywdehFujqJoRTxO8YvsKXVvWAT8O4RKskGI5R4VB2FwqF8jSAv?=
 =?us-ascii?Q?nbmJNfdzxUqh0g/JPm69joT6CvvQzLUCweoCK8E+c5tdk++sI9OBFrqzXC3L?=
 =?us-ascii?Q?bmKibG8irn9gg/FhnyBAzG3IHCVczz9jzdXssN8yNsvDPa8zuRRXFCGs8fQO?=
 =?us-ascii?Q?D1ADMblTdtk2Zro+XH3jTJCVQjy/MIVE8ePJ2PmkE/x59sfMA0g+qOJO0kVm?=
 =?us-ascii?Q?72dvtbyBOCDGUV8+FH4KMt7QDtwg8OghBiP3dy/bUqrJfkAPB1M7K+6HW0eK?=
 =?us-ascii?Q?oZhTBmw36kszX5f+phMuXFxJJmHuXMPl01Wq5OiD?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af6f61ea-c223-4793-df59-08db67676c16
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 14:56:49.8246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HIW19bXaG5OuUoigdaKeeXbwS8HBv8v+AypdbsBSL9sRQU6AagZRJzRcucWV/FsNSu01OdIGFr5qjhHzBNf5jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5847
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
 tools/f2fs_io/f2fs_io.c | 39 +++++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
index 1774eca..5a6a6a0 100644
--- a/tools/f2fs_io/f2fs_io.c
+++ b/tools/f2fs_io/f2fs_io.c
@@ -413,9 +413,13 @@ static void do_pinfile(int argc, char **argv, const struct cmd_desc *cmd)
 
 #define fallocate_desc "fallocate"
 #define fallocate_help						\
-"f2fs_io fallocate [keep_size] [offset] [length] [file]\n\n"	\
+"f2fs_io fallocate [-cipz] [keep_size] [offset] [length] [file]\n\n"	\
 "fallocate given the file\n"					\
 " [keep_size] : 1 or 0\n"					\
+" -p : punch hole\n"						\
+" -c : collapse range\n"					\
+" -z : zero range\n"						\
+" -i : insert range\n"						\
 
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

