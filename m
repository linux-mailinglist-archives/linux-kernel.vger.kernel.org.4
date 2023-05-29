Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A537141B6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 03:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjE2Bfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 21:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjE2Bfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 21:35:48 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on20600.outbound.protection.outlook.com [IPv6:2a01:111:f403:704b::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B474D9
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 18:35:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLoF6aJUVzlm8BO1zVnRNfCWfKwmcGbxuhvsTjgvs6RQAOjnP9Kiey/UbLfnq1S3KFxJKC4XhOc+bhtc68v5ZFD0Zvm25ikGCHJH0BGhQLLi6r4LrvohbStI2W8lVpUbxMTAt2LVRbd3qn9l7/gB9Zsw4pS1o666Z6RyHPqjsIRb3Ain9yCFKmUG23AFFFDjVhOFrJB+dTDFultsGbOPZ4hfP2QUNjpOJZP1aP8m73/+5NljLhtSZF1SPx1yyOioOr1NfPHxLd3Ezaiwiyd7GafRYKvadZ9E42owGV8viD48iSJTLCzm8t/XDnnpvWeYTIF9mQmHgwRhWEOHL4AHow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7r/zxUgmuxQXMDU3qp+JPeKNewmWPPAaLXu3laNQANg=;
 b=kIi2kqRWYNPNBO31OPrjhXf2jVe9TIR+BRT6a2mYx5QFZXcbjg6enB3uLr+TwlACukpPyRXh8VUsGcC14QvWg3ybOGhHHbC4p1zIiz9XunRaCpY5mBrqtR+LvsHlKkba3CydsITzUri/unhT+eEpDHcFmzlQJw2T5GoiCW4fPW16hHwkAFoHMOcd7YNMa3szLAXd/rvndWAVyONnaeCinGbZPl/CR6chTY4zH0TmGPeizImGyfqrJ6cB5pd705lCqyyEvXgHY/juMJd4mC/eZZYMD4Apyy/VC+t8kgeEDOk08jtisAe9Le6K1yBB0fzSI4TnvQtAakucmSLNHompZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7r/zxUgmuxQXMDU3qp+JPeKNewmWPPAaLXu3laNQANg=;
 b=DVncgw2KnO4Yy2+hHhdeWfY156DbnqIXyHia5BCB8HvXLGcwZkUk2O3l5UCJAEVfJ2JbmoFOpZ5CKLYMNNRISo77T6/zAKlyPciFfC77YMbguMJdCWXdJi5cicW3t/upmHLZzN0Sw6JzFeu6Sow1A39WXNgBN2hZD/kyWw+xl5s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SI2PR02MB5148.apcprd02.prod.outlook.com (2603:1096:4:153::6) by
 SI2PR02MB4617.apcprd02.prod.outlook.com (2603:1096:4:ec::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.18; Mon, 29 May 2023 01:35:41 +0000
Received: from SI2PR02MB5148.apcprd02.prod.outlook.com
 ([fe80::1bc4:fbb5:b757:83ee]) by SI2PR02MB5148.apcprd02.prod.outlook.com
 ([fe80::1bc4:fbb5:b757:83ee%5]) with mapi id 15.20.6455.020; Mon, 29 May 2023
 01:35:41 +0000
From:   Sheng Yong <shengyong@oppo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Sheng Yong <shengyong@oppo.com>
Subject: [PATCH 2/2] f2fs_io: convert compression ioctls to [get|set]_attr
Date:   Mon, 29 May 2023 09:35:02 +0800
Message-Id: <20230529013502.2230810-3-shengyong@oppo.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230529013502.2230810-1-shengyong@oppo.com>
References: <20230529013502.2230810-1-shengyong@oppo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0175.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::31) To SI2PR02MB5148.apcprd02.prod.outlook.com
 (2603:1096:4:153::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR02MB5148:EE_|SI2PR02MB4617:EE_
X-MS-Office365-Filtering-Correlation-Id: 4de4f23c-04f2-4474-2add-08db5fe50358
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5QEtpbDPVkS07ZLmaE70gnSIasJCi2QPkAu8AnFB+loBHH/9PNUvwK1xof9qyxca/CI3hkDCLvZalPWLHen6IemtzUced6xNW+ShlERS86HPp+OM0KF6z2DAiXcARQOq55m2gwDXaMAKJc/UxC/wxdKtuu2K/RTt1zsYRQwk7wqs1qLb4U9r//7dpiyjVFea/LiUrWwpgrMSLoouvveb0KIa4gq5xa0AOMPN130rKwIxlcOxGL1fvRFhf+OmWGT9zld7/z7nXr7HLunz4FOfrJtwQ7Ol/jHHJWVXDf1tg/0qi4LBX7LrjURs0EmxRio4iA1maeMGZ2X5GonzglxzuLUVAYFGFYFJzKOGrmtZxFBJseq85rw9uBxe+lwJft/nz34iUYdRIqlOnOw1//zpfKIyE0dD85sLF5ozNmKifaCfIbCGL/bi24I6wLf1YBEVXTe+w9+GDTMTo4SBpQ6bu+AaHMOBXh0vNudAjBffpwaMM3csrirmxOPZkRJmkd+EJQnv+QtGd9ksZ1oe9C+YBDMO6T1Hx2e27pFVDADPtrFyaF+lfVK95CrM8H1G6Y4K3HFv5y1reIqoKtdE2J2rQrO9SS7C3lZ7iAJsutbaKmsK0MnTQJT8zmsVsuQHceAn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR02MB5148.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199021)(2616005)(186003)(83380400001)(2906002)(4326008)(5660300002)(26005)(1076003)(6506007)(6512007)(36756003)(86362001)(107886003)(478600001)(8676002)(8936002)(66946007)(66556008)(66476007)(6666004)(316002)(38100700002)(38350700002)(41300700001)(6486002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BlBoxuf7fRH1zRGY5JhVYiJTKt16abvC4KQGjPui2pfDSA3H/S3ujlzgIkMZ?=
 =?us-ascii?Q?0eSP9tF9Ww2GOzncs56ID6BsE9ryYrzPpmLIFvDUmLV1+44uYTPdaYYFh27k?=
 =?us-ascii?Q?6z9QdDlqjatwZaSQcw+U+qQAulhr1TdRqxybuQ6B2h8mHEp9l7+YgIK+gs23?=
 =?us-ascii?Q?92AvipfGVhhktPWV6XGSIrhj8BB4B5elwqiXjvbjsl0sEywVxh2k0lXRZr52?=
 =?us-ascii?Q?cqbFf6Gogn+hTT4yGrN1exYlYWz2xJi5irzwm4tzqcR7r09VeQpQhvyik6QG?=
 =?us-ascii?Q?SKOH3VJIgGLr9kv7DehcX5IiaNhTiSXE1NgE+YlKq8mI20nVa/iXkd/6qzfG?=
 =?us-ascii?Q?OYiQ1DvxvK5fdfFA9M84Nm9HJgATyCWlsvAmD7MagPznMxef/YeMywxnfc8/?=
 =?us-ascii?Q?MHkwEIfprQ36+Txg5BL52nSWcealdPtNdmJBFmyontLaxDikebO3ai1Y+flD?=
 =?us-ascii?Q?8zp9cqucxalNiZskyPo2EJdGvQUUlLpLgz3FlrJ7OQrwqOhg0PHyATlA/7ZC?=
 =?us-ascii?Q?9ddNh2+1TV0T+b7bXnLPJlu3hVYAEZDAeiWcOge9y/tp9/W4aZAJX0oFOUrh?=
 =?us-ascii?Q?Nv9YqJVIrdxogXceGWIR0HWqKzOy6fkYF79LO6AxfLyqoGV88Sj0w3a6vT1W?=
 =?us-ascii?Q?ZVy7o2APbWtd/gEkwAV5H39BMHSCDTvXk62PIxUMnpp7rjbsby7Bvh27MKK+?=
 =?us-ascii?Q?SwrlU6cHOBfua4GzeHifb6eIJ4uCMFMh+9+OUhWEyt7enN9vwiaUksvvjeNT?=
 =?us-ascii?Q?XaK0t7gt8zk+GXT/jbsdOvOcsKkNfPcsDUY4D1KMhttR3ZAH/WSGO+sBdXxG?=
 =?us-ascii?Q?EvfVFhGLY2ohgO27EO55lPtxawpSe3wH2V0TRr3ccDY/V7hnNkHpE4v6FGzC?=
 =?us-ascii?Q?D5KoqFZhEUq5AMAbG3cmKHGZYtY+YJ/PeoCkvUy4qBg2zScRN42vRjrcadu4?=
 =?us-ascii?Q?eQzc4L3z1KBt5r4JP3tbJejtyG/ZzxbWa/SHok49k8xsyyVJax1RzypKsHF6?=
 =?us-ascii?Q?Ce47n7itJwAuhKXVqbcqsRtrHUocbb3FtIc6p0r3QxSRpZwBTcXhWBPC4IfA?=
 =?us-ascii?Q?H6Rm3S7VFHmy0Lqit1Pi35nsYYyw41HU3tR1j51X+SpUdliBkuBM8To3wP0k?=
 =?us-ascii?Q?Y304SBiyjlMiE5tPPNUlhC7gwvu/aLfeO93xSYRdo6JLMNX28rm4dajcCSG4?=
 =?us-ascii?Q?a4K+1OXBFE/f7/leH/VI8CaNUgZB1Tri+2D4AGXg/19qMMmetNXHiHEkAcBF?=
 =?us-ascii?Q?G+TZcPd9zUD3EIQa8F973A7u1PO8t7/a3RbPDd6+wmAobt9L8/QD+NTXUU2D?=
 =?us-ascii?Q?b2APDGxqvnMTR8hVYXyhx7eymS5iGbcyU+loSlNnwuuFzncxH6+Pjb0yXgoA?=
 =?us-ascii?Q?XIlT3WhgxPqWLmZ88EojWuhAwVIh8hS3mTFFcofOH+zmEVRuQ1Od4aGt1/wd?=
 =?us-ascii?Q?AHkwqpnFFEDYWHTLgWtF9MHgIbBvgVjCeZuUd1LR3UVfJXOlCv+mnj3uK8Fp?=
 =?us-ascii?Q?GkG6LZ8EAohMR+laGfBTsqZ1PZhYh8ovEdxuVJ1/vnBSzzNH6lVb908tGD3T?=
 =?us-ascii?Q?/TEfs3zClDehYuAmnWRgFyiklMCCpjGbLNVcW9Ll?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4de4f23c-04f2-4474-2add-08db5fe50358
X-MS-Exchange-CrossTenant-AuthSource: SI2PR02MB5148.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 01:35:41.3453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y+YZ45ehPDNgxKDps3uL5+pDHeqgvKmuemS/zKVCPxK36Q3N1c0SacxGnPaggg7G+NgjBDL9jFDWYjiyYnl+Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR02MB4617
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert compression related ioctls to get extra attr ioctls.

Signed-off-by: Sheng Yong <shengyong@oppo.com>
---
 tools/f2fs_io/f2fs_io.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
index 70e0347..f6e6057 100644
--- a/tools/f2fs_io/f2fs_io.c
+++ b/tools/f2fs_io/f2fs_io.c
@@ -1012,7 +1012,9 @@ static void do_copy(int argc, char **argv, const struct cmd_desc *cmd)
 
 static void do_get_cblocks(int argc, char **argv, const struct cmd_desc *cmd)
 {
-	unsigned long long blkcnt;
+	struct f2fs_extra_attr attr = {
+		.field = F2FS_EXTRA_ATTR_COMPR_BLOCKS,
+	};
 	int ret, fd;
 
 	if (argc != 2) {
@@ -1023,11 +1025,11 @@ static void do_get_cblocks(int argc, char **argv, const struct cmd_desc *cmd)
 
 	fd = xopen(argv[1], O_RDONLY, 0);
 
-	ret = ioctl(fd, F2FS_IOC_GET_COMPRESS_BLOCKS, &blkcnt);
+	ret = ioctl(fd, F2FS_IOC_GET_EXTRA_ATTR, &attr);
 	if (ret < 0)
 		die_errno("F2FS_IOC_GET_COMPRESS_BLOCKS failed");
 
-	printf("%llu\n", blkcnt);
+	printf("%llu\n", (unsigned long long)attr.attr);
 
 	exit(0);
 }
@@ -1090,6 +1092,7 @@ static void do_reserve_cblocks(int argc, char **argv, const struct cmd_desc *cmd
 
 static void do_get_coption(int argc, char **argv, const struct cmd_desc *cmd)
 {
+	struct f2fs_extra_attr attr = {0};
 	struct f2fs_comp_option option;
 	int ret, fd;
 
@@ -1099,11 +1102,15 @@ static void do_get_coption(int argc, char **argv, const struct cmd_desc *cmd)
 		exit(1);
 	}
 
+	attr.field = F2FS_EXTRA_ATTR_COMPR_OPTION;
+	attr.attr_size = sizeof(option);
+	attr.attr = (unsigned long)&option;
+
 	fd = xopen(argv[1], O_RDONLY, 0);
 
-	ret = ioctl(fd, F2FS_IOC_GET_COMPRESS_OPTION, &option);
+	ret = ioctl(fd, F2FS_IOC_GET_EXTRA_ATTR, &attr);
 	if (ret < 0)
-		die_errno("F2FS_IOC_GET_COMPRESS_OPTION failed");
+		die_errno("F2FS_IOC_GET_EXTRA_ATTR failed");
 
 	printf("compression algorithm:%u\n", option.algorithm);
 	printf("compression cluster log size:%u\n", option.log_cluster_size);
@@ -1119,6 +1126,7 @@ static void do_get_coption(int argc, char **argv, const struct cmd_desc *cmd)
 
 static void do_set_coption(int argc, char **argv, const struct cmd_desc *cmd)
 {
+	struct f2fs_extra_attr attr = {0};
 	struct f2fs_comp_option option;
 	int fd, ret;
 
@@ -1130,12 +1138,15 @@ static void do_set_coption(int argc, char **argv, const struct cmd_desc *cmd)
 
 	option.algorithm = atoi(argv[1]);
 	option.log_cluster_size = atoi(argv[2]);
+	attr.field = F2FS_EXTRA_ATTR_COMPR_OPTION;
+	attr.attr_size = sizeof(option);
+	attr.attr = (unsigned long)&option;
 
 	fd = xopen(argv[3], O_WRONLY, 0);
 
-	ret = ioctl(fd, F2FS_IOC_SET_COMPRESS_OPTION, &option);
+	ret = ioctl(fd, F2FS_IOC_SET_EXTRA_ATTR, &attr);
 	if (ret < 0)
-		die_errno("F2FS_IOC_SET_COMPRESS_OPTION failed");
+		die_errno("F2FS_IOC_SET_EXTRA_ATTR failed");
 
 	printf("set compression option: algorithm=%u, log_cluster_size=%u\n",
 			option.algorithm, option.log_cluster_size);
-- 
2.40.1

