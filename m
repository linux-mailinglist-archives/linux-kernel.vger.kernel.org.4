Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF63472B5A0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 05:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbjFLDCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 23:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbjFLDCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 23:02:12 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2075.outbound.protection.outlook.com [40.107.117.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2F6E5E
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 20:02:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FLmwTGGpl49BfyipSvNrwDpR3gGXwt59AdCifewMscK5y1UyFFUoRTmJpmwp+XZPyrNP0lsTkFSloultFJAhlLwMxEQrP2BCuNHGLfLfhz0YNNF3X70ZVyI3OVp1gKj+5OFz2Q93ty5MZaet+oB5rSDmmSy4UgfLy+S3fFx4pLlvAJ3gMerH5xdAlqXeRIZ2TsG6rbiIKjsP+Lx+fRQI9F9RcDqjpyidhsvBSNHdOfVUYz2ucfV9fzekZ0BmOvsx/IcoLEjU0iffuK4IV5ibnd05mfMAvSmum18Xny/YTbmi0zVeHWqktjqJ0e9Vc7mz1p2S30hr9eXiSTm9XMPrsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/yS4TQai2mzZtvrjq0fu4KjMgTwIXAkvxkVkytra4b0=;
 b=UkECyUMLfE2QkY00RD7zoeEMpUX8xSY+KapO8x5+sfCHlSK4fvOhziSjRrQwUj/UPqpPNt20yUqZwjcjLu1U+hoKtIlDv1tjfjALEQVjsahRvfgWOI+hxx09z7NIb/2WjZZF9BWahiOWi0G5zjR9C0WeOrEjc/aB/SrEl8EzGfvG3Xw1KHIOuKQp3tXrSZeTQlMXygeTVlxsSNEOcMbvddiVjBxlPbgk+ZdnFNzOkhI9ZcGIdFsiZ1SQI+3/Ei0pDp5cIiPR/wDNfDtCbrI0fwoGvihrn1nMUOjNm5A9g2E9T8q7uu5gM8MhAKeOoUPTy7iygCiQJbqkcl0fCpee2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/yS4TQai2mzZtvrjq0fu4KjMgTwIXAkvxkVkytra4b0=;
 b=qmP9AP7SXEWHt33zd2RMmiKPu3u1zaCOHLC8YI/EzjKT1cQ21AMEvO3Mvtkn/lkbuJjK/4Y5VBj8udGljH9gm1kQ/P68TvV70t+4DNDPMHOL2mexJP2Z5e9FQDGpMz/Zip0tL7kPgrZtz2J2SAwmso5jv8FV6aQ6Wnc+plZB1ro=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SI2PR02MB5148.apcprd02.prod.outlook.com (2603:1096:4:153::6) by
 KL1PR02MB6259.apcprd02.prod.outlook.com (2603:1096:820:dc::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.21; Mon, 12 Jun 2023 03:01:49 +0000
Received: from SI2PR02MB5148.apcprd02.prod.outlook.com
 ([fe80::6297:13a6:41f1:e471]) by SI2PR02MB5148.apcprd02.prod.outlook.com
 ([fe80::6297:13a6:41f1:e471%6]) with mapi id 15.20.6500.020; Mon, 12 Jun 2023
 03:01:49 +0000
From:   Sheng Yong <shengyong@oppo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, ebiggers@kernel.org,
        Sheng Yong <shengyong@oppo.com>
Subject: [PATCH v4 6/6] f2fs: access compression level and flags by extra attr ioctls
Date:   Mon, 12 Jun 2023 11:01:21 +0800
Message-Id: <20230612030121.2393541-7-shengyong@oppo.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230612030121.2393541-1-shengyong@oppo.com>
References: <20230612030121.2393541-1-shengyong@oppo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::20) To SI2PR02MB5148.apcprd02.prod.outlook.com
 (2603:1096:4:153::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR02MB5148:EE_|KL1PR02MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d5894b7-1d65-474b-2ac6-08db6af15da4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M8/ecebHq5MPLUCUQoYd1NhAdrcDHkYGdIohzcEq8bm6IlOdk5QSZqgfqtSlVybtuhUm9v+D6erQAGiAIFbqZkGCJs/6MKjf5bof1tE3ip8DqsTiJ7Joi3Jw6lBsbvbd9mp+iirV8RWWgRVuo3mJNctZtdk41SjihyOvvJvU8WyR+iNIyCGZ7sga7whAyQpOO/stA2hUyj+ZEP0gYCSQ/Nv+SvRPiFD3eQ8Km8PJTodxRq0p62F3R4pLmzAk5xozmZzVAETysIYzmasZwMNGTwpjCj1VHXQSsbphS6BQEVGLTSGxSahxVObICy8Fxm0sURtBpny9i1TBrAVF+Q08w6VzoYILVl79jjCz0zZhVjrRL10fZRUr0LcIVsIAXFL/ZwuH67xQoz0YgY0v9wCP+HGig6sxZFSeoGmHA/fUdEaShZySQX3nGuC+xfL93PeqrzROb8+5W8Nz1hxyQDG3UaMGVGIKEXtqvjIEPssuxAjvsGRDbeEBP6DBkepjn+HccKDqnbEKrg4HQ3AihSwlSpa+jcDYTODlE6f0K0jEbzA1cPv7xc+4Vztxj04KtPDGYOCD7LKpTmhdwYpToeouiAkgBIuHUYNPOTfV4ASqj0MlJSmifh7LMwudx7O/YSoI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR02MB5148.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(376002)(396003)(136003)(451199021)(66476007)(66556008)(8936002)(5660300002)(8676002)(36756003)(66946007)(4326008)(478600001)(6666004)(41300700001)(52116002)(6486002)(316002)(38100700002)(38350700002)(6512007)(6506007)(1076003)(26005)(186003)(2906002)(107886003)(2616005)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X0TLDxQrr1p/ubw59DbSKq5H9tUW+1s/V76bqxa9XDe1GR/Tt2UUEbnll4pi?=
 =?us-ascii?Q?Orony1q8PjFDXHC/JYKqBfVzfTjv+ZbGv/0UZmMUGrF6ajECmcoWy7jWVBrh?=
 =?us-ascii?Q?IQB06EY/4/A3ecSHqY3KW9XU+CS6Swn/zQZ1foLo//BIzkLSgXEQswHyYDBt?=
 =?us-ascii?Q?wov6BpLAw0G82HZOk6XgMSSHAwaVa0+C6lFffeiXb+vNVYN09pJwdwnA4BO9?=
 =?us-ascii?Q?SHglS7AVIf7qcQkC2cFwD1+8R8PO6XfjZFI/xR5KqUlLdLyvs/gpZ11PCqQi?=
 =?us-ascii?Q?c5SyjnEsxh4+HkDXbwrWJe7juv/08jFhJpBgETdBOL7scKlgy0yPAhHn5u3M?=
 =?us-ascii?Q?ObnrfIcurT7puQfq/RBCeA/SlM5wS7XWhqi0dCFs9dO9mOkJe7rKddzSCTgb?=
 =?us-ascii?Q?0x0IRsXqD0vKHS3RTqKIcwpPYVwp/CAhxf6bASwA8txwKwCOFBWgGrd5f68V?=
 =?us-ascii?Q?S2a3cJoVW3OqDJL+Liwd5LAY8YjuzYxq48K3kJxOjVTgLyi0uoKBCcO48wQh?=
 =?us-ascii?Q?cmgffI62JcF6amoK/gwYoBx6GCI0S1pY1KoNGQ2C7yaBWzi2ZMvr954Gg7ff?=
 =?us-ascii?Q?aXco2VzhnlyNAbpQ2fO+OxU/PszKAP+6KTu1MCa9OA1niLzSCtkrGhzpvv/4?=
 =?us-ascii?Q?IjJij/auVKcloXD+WC9JbmiJQ/9XPHeXq9Drst/qtdDoZeicEt2KxAjJzovX?=
 =?us-ascii?Q?/9f7QxNbGnOuwxLn4jkpm91vjbtWqmcIdry+IVtwIj0I0baOoIkUZVfGtbkz?=
 =?us-ascii?Q?0R3ikcdL2VkIYdTpbQDGb2wS0SmMS/JN9P1FCEET4/s+Dh3PpYYrKYueelnX?=
 =?us-ascii?Q?1j7YpUDJXtuIGDD5Q8+K2rJsOjOAao1GjAYhaRH8rp2JDyIm0eeZW+ruqR2A?=
 =?us-ascii?Q?7bqd7/pQRjCbxnKlaaQq+mNHh06H73IqKYc9ZHkj69T1/rPo2nMtpnhGsjY0?=
 =?us-ascii?Q?BL7bb5lbfyCHm0RNuFh5g7GbjZCGxL9HV69+lBDU6bIj1zsg513ajVv5Ugbo?=
 =?us-ascii?Q?Gsne2cnOCj1vmIp1Klw4z2n1L6KPWtHhP0d+MnLftd/+LoADXE4bonIRu9jI?=
 =?us-ascii?Q?D5s8HTdzhXYEI7yrfq6+z6SUFbiTknP1HLvW8bO4uTJzhPd9ZifEcsXtprBg?=
 =?us-ascii?Q?c+/+2IlMKjLSXAGQeXKEBDxKrPvDOO5FBGcNxrJ8sXRM2Ue7HyScFefkfvUE?=
 =?us-ascii?Q?glW33q7F9nLEN6iSE2a2SRbbP4Y1floq2wmqcBt7AF8V1vix89QoFs8sudjg?=
 =?us-ascii?Q?r07JAret1b8LgZpUpVyjr25e5yUFhc5aE1jjDZxeyiEBi9P509ZfIONrpCRa?=
 =?us-ascii?Q?zrGLHJl2jYUGhRDAwjjKI9R/eHNczdvbNhTg/sw+9a1e6mHt2//zzyEWf93T?=
 =?us-ascii?Q?nEAyMtcM0EeN2+UKtyiWLFyhsT78i9LAmQm7UUeglGt2djZ9swxdUz1kwTZx?=
 =?us-ascii?Q?llo7YucKP5GxqFq1bUSY0rA1wId/uOn6sEF42NxpuJ7h/iubCqNpWUxqhh+H?=
 =?us-ascii?Q?a/dH1eemroQNIHbnfeLeEUMiI0oZJ+Dfc4Fnxm9gfFYmMQWGBxxXS6nuTzSH?=
 =?us-ascii?Q?aAcJuAT5/EyIQFN1ojTHc4aLQ8YZOsCsKxZGKRkJ?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d5894b7-1d65-474b-2ac6-08db6af15da4
X-MS-Exchange-CrossTenant-AuthSource: SI2PR02MB5148.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 03:01:49.5210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xkCDMw/Kxm7Gv3qARvNt1PooHH40IsoI0SQ4sLeJcFas5P4GqNp9oId2n755kghwGoCsk496qeBH4ws1/PeGqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6259
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow getting or setting compression level and flags through
F2FS_IOC_GET_EXTRA_ATTR and F2FS_IOC_SET_EXTRA_ATTR.

Signed-off-by: Sheng Yong <shengyong@oppo.com>
---
 fs/f2fs/file.c            | 56 ++++++++++++++++++++++++++++++++-------
 include/uapi/linux/f2fs.h | 10 ++++++-
 2 files changed, 55 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 39d04f8f0bb6b..1ac73cd59db79 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3916,10 +3916,14 @@ static int f2fs_sec_trim_file(struct file *filp, unsigned long arg)
 	return ret;
 }
 
-static int f2fs_ioc_get_compress_option(struct file *filp, unsigned long arg)
+static int f2fs_get_compress_option_v2(struct file *filp,
+				       unsigned long attr, __u16 *attr_size)
 {
 	struct inode *inode = file_inode(filp);
-	struct f2fs_comp_option option;
+	struct f2fs_comp_option_v2 option;
+
+	if (sizeof(option) < *attr_size)
+		*attr_size = sizeof(option);
 
 	if (!f2fs_sb_has_compression(F2FS_I_SB(inode)))
 		return -EOPNOTSUPP;
@@ -3933,31 +3937,42 @@ static int f2fs_ioc_get_compress_option(struct file *filp, unsigned long arg)
 
 	option.algorithm = F2FS_I(inode)->i_compress_algorithm;
 	option.log_cluster_size = F2FS_I(inode)->i_log_cluster_size;
+	option.level = F2FS_I(inode)->i_compress_level;
+	option.flag = F2FS_I(inode)->i_compress_flag;
 
 	inode_unlock_shared(inode);
 
-	if (copy_to_user((struct f2fs_comp_option __user *)arg, &option,
-				sizeof(option)))
+	if (copy_to_user((void __user *)attr, &option, *attr_size))
 		return -EFAULT;
 
 	return 0;
 }
 
-static int f2fs_ioc_set_compress_option(struct file *filp, unsigned long arg)
+static int f2fs_ioc_get_compress_option(struct file *filp, unsigned long arg)
+{
+	__u16 size = sizeof(struct f2fs_comp_option);
+
+	return f2fs_get_compress_option_v2(filp, arg, &size);
+}
+
+static int f2fs_set_compress_option_v2(struct file *filp,
+				       unsigned long attr, __u16 *attr_size)
 {
 	struct inode *inode = file_inode(filp);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct f2fs_comp_option option;
+	struct f2fs_comp_option_v2 option;
 	int ret = 0;
 
+	if (sizeof(option) < *attr_size)
+		*attr_size = sizeof(option);
+
 	if (!f2fs_sb_has_compression(sbi))
 		return -EOPNOTSUPP;
 
 	if (!(filp->f_mode & FMODE_WRITE))
 		return -EBADF;
 
-	if (copy_from_user(&option, (struct f2fs_comp_option __user *)arg,
-				sizeof(option)))
+	if (copy_from_user(&option, (void __user *)attr, *attr_size))
 		return -EFAULT;
 
 	if (!f2fs_compressed_file(inode) ||
@@ -3966,6 +3981,14 @@ static int f2fs_ioc_set_compress_option(struct file *filp, unsigned long arg)
 			option.algorithm >= COMPRESS_MAX)
 		return -EINVAL;
 
+	if (*attr_size == sizeof(struct f2fs_comp_option_v2)) {
+		if (!f2fs_is_compress_level_valid(option.algorithm,
+						  option.level))
+			return -EINVAL;
+		if (option.flag > BIT(COMPRESS_MAX_FLAG) - 1)
+			return -EINVAL;
+	}
+
 	file_start_write(filp);
 	inode_lock(inode);
 
@@ -3982,6 +4005,10 @@ static int f2fs_ioc_set_compress_option(struct file *filp, unsigned long arg)
 	F2FS_I(inode)->i_compress_algorithm = option.algorithm;
 	F2FS_I(inode)->i_log_cluster_size = option.log_cluster_size;
 	F2FS_I(inode)->i_cluster_size = BIT(option.log_cluster_size);
+	if (*attr_size == sizeof(struct f2fs_comp_option_v2)) {
+		F2FS_I(inode)->i_compress_level = option.level;
+		F2FS_I(inode)->i_compress_flag = option.flag;
+	}
 	f2fs_mark_inode_dirty_sync(inode, true);
 
 	if (!f2fs_is_compress_backend_ready(inode))
@@ -3994,6 +4021,13 @@ static int f2fs_ioc_set_compress_option(struct file *filp, unsigned long arg)
 	return ret;
 }
 
+static int f2fs_ioc_set_compress_option(struct file *filp, unsigned long arg)
+{
+	__u16 size = sizeof(struct f2fs_comp_option);
+
+	return f2fs_set_compress_option_v2(filp, arg, &size);
+}
+
 static int redirty_blocks(struct inode *inode, pgoff_t page_idx, int len)
 {
 	DEFINE_READAHEAD(ractl, NULL, NULL, inode->i_mapping, page_idx);
@@ -4277,7 +4311,8 @@ static int f2fs_ioc_get_extra_attr(struct file *filp, unsigned long arg)
 		ret = f2fs_get_compress_blocks(inode, &attr.attr);
 		break;
 	case F2FS_EXTRA_ATTR_COMPR_OPTION:
-		ret = f2fs_ioc_get_compress_option(filp, attr.attr);
+		ret = f2fs_get_compress_option_v2(filp, attr.attr,
+						  &attr.attr_size);
 		break;
 	default:
 		return -EINVAL;
@@ -4371,7 +4406,8 @@ static int f2fs_ioc_set_extra_attr(struct file *filp, unsigned long arg)
 			f2fs_balance_fs(sbi, true);
 		break;
 	case F2FS_EXTRA_ATTR_COMPR_OPTION:
-		ret = f2fs_ioc_set_compress_option(filp, attr.attr);
+		ret = f2fs_set_compress_option_v2(filp, attr.attr,
+						  &attr.attr_size);
 		break;
 	default:
 		return -EINVAL;
diff --git a/include/uapi/linux/f2fs.h b/include/uapi/linux/f2fs.h
index 2b53e90421bfc..153a6395c5f35 100644
--- a/include/uapi/linux/f2fs.h
+++ b/include/uapi/linux/f2fs.h
@@ -100,6 +100,13 @@ struct f2fs_comp_option {
 	__u8 log_cluster_size;
 };
 
+struct f2fs_comp_option_v2 {
+	__u8 algorithm;
+	__u8 log_cluster_size;
+	__u8 level;
+	__u8 flag;
+};
+
 enum {
 	F2FS_EXTRA_ATTR_TOTAL_SIZE,		/* ro, size of extra attr area */
 	F2FS_EXTRA_ATTR_ISIZE,			/* ro, i_extra_isize */
@@ -109,7 +116,8 @@ enum {
 	F2FS_EXTRA_ATTR_CRTIME,			/* ro, i_crtime, i_crtime_nsec */
 	F2FS_EXTRA_ATTR_COMPR_BLOCKS,		/* ro, i_compr_blocks */
 	F2FS_EXTRA_ATTR_COMPR_OPTION,		/* rw, i_compress_algorithm,
-						 *     i_log_cluster_size
+						 *     i_log_cluster_size,
+						 *     i_compress_flag
 						 */
 	F2FS_EXTRA_ATTR_MAX,
 };
-- 
2.40.1

