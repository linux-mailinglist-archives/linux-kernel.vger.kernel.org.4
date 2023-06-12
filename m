Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18AA072B596
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 05:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbjFLDCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 23:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234005AbjFLDBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 23:01:55 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2075.outbound.protection.outlook.com [40.107.117.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F3FE51
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 20:01:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gefyTtI6qnFg4mkf8Cn5DbsVqG5gtPdulGlp02XsqhYcswjCBZRs89t/YPauvre5PEt9QW4a9c+FzlBMSooPhRpnKqDqcabw7eGNMsuY7EJjIb4Y/ziF6sCC5uVnMVEjVEi0x7Ux+8ZN+c1uDVnmQaNiAPMtmBFRw9EnVPG6a/hMfpbTku/FcM1bVoPxHjkXc4u+biKLzvMFevFZ8znzUPZ0VjYuKqk6CVM4h3aiJDfAWTrZ0Qhc8X0NLCBSq/9wIB8wz3ulRchfvPKJ7HY8ThOKr61N+9V5TZ7Xq+CjSd3e+NVeqe43v8g0YQF9MBQPpgE9R1wWlxqG+OjFluQcjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1K6vKgsEBr9XA5kkiRlKqIymaZ3HjuFwbvqRqXXQqE=;
 b=f55LxVh15ouqzAbHz1IOQVvf7mnTS6J3tpTuaMwVCp7HGmJgCxQXmlJ7Bw2xm/rrkgMs6gINrWqLNpg9l3L1G94rhRt4uiESbQ9snbCHa3UEW4m+JeQ35DEi5gVa645QoYwch7laUEYjwzXS94+c1TzWOjt5EST02bYJ95/pt0wuFeFgxUaUrWrBhjgIFfiXm6PkCXhxepl6wiRGeBJIjGQcHT7PXN4RSjvQ6vCrC8Lx9ZgJ/nP6TwWLMeoYWPoUApo/PjpJPsQ1BhNwROXif7lCQgQpdTDuqEEsFhYb0nHNk+KaqEcXn0/o43JDAuRVzhYl4F+Gmg6Ta0hPOHKjxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1K6vKgsEBr9XA5kkiRlKqIymaZ3HjuFwbvqRqXXQqE=;
 b=u9BdKaewtxNIrKB9JOt2ftXsBKq5qTztTk6EdohVMn9ztNYZix00psdCpf5xQRUqM6syFigK4dWltIYG1eOBhAoD1A3omoKZGFuD+xJFqflAHBxaaqZ1VQCCc3eLDTvzZ6Gq7U9Rs+DHfVEzMMsWDSD3ktIBn1ITT3rcUtOSQcg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SI2PR02MB5148.apcprd02.prod.outlook.com (2603:1096:4:153::6) by
 KL1PR02MB6259.apcprd02.prod.outlook.com (2603:1096:820:dc::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.21; Mon, 12 Jun 2023 03:01:47 +0000
Received: from SI2PR02MB5148.apcprd02.prod.outlook.com
 ([fe80::6297:13a6:41f1:e471]) by SI2PR02MB5148.apcprd02.prod.outlook.com
 ([fe80::6297:13a6:41f1:e471%6]) with mapi id 15.20.6500.020; Mon, 12 Jun 2023
 03:01:47 +0000
From:   Sheng Yong <shengyong@oppo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, ebiggers@kernel.org,
        Sheng Yong <shengyong@oppo.com>
Subject: [PATCH v4 3/6] f2fs: add helper to get inode chksum from inode page
Date:   Mon, 12 Jun 2023 11:01:18 +0800
Message-Id: <20230612030121.2393541-4-shengyong@oppo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 13e7c429-77f1-4b3a-143d-08db6af15c16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7I4/FA2hFiQuVVAz9R1yGywr3BSyyNCCeOGFWK/DDCND8Q3TgWMzzdJ77ZYZjCp28Kg9CiNAHOfMf4zUSEfAyW5sJ9qVCAnqVUQ37qiQBgl7Zc2FAchop24Wq+sumgsuO1l+/gkuFCOiwvWqiRBh5yI8rN2XKpx1o3d8inEBJ1my2Meh/uS8fkDt7d/hWcrlgVJfQSkOmew251XggV+Z/5DV6i0UVUSvh6EuKPfXR+1yQnVhvVsppP1Q2WH4qw6k7dbpBmRMZsCLsY1Ecj5IBtZVsuG789R577hgApLdvGisD0eWhmpDwAjWWsRSQjJ7d0Jk3O3F6nNquTGcsddUny2fqdIgHOM5TAk+k2IKKvwD/G6QfWAbYIFhAp8A2HLwUa5oRj2Q5mu3RXAI0oxwaehiB7d+8jYI1ogt7A1mg1SkzXD2r9d7FJgZh7tiAn40skelpacIkDA13/f307ML+pBL7MBY6OfBqMCJEWC6nMVj8pjzgn96N0BdL+S2QlyVMMSgNPe0tPhq8FlDj/Ir2AEUvDflFp1H/FGvyj4RxroW13q7XqhSiZvdWICxbl8qGipWpU5ircVxqBV6dXsanIoHKk9MO9vokY66mphoOfPYVC5PkKNGt2xjmuxiGnAV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR02MB5148.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(376002)(396003)(136003)(451199021)(66476007)(66556008)(8936002)(5660300002)(8676002)(36756003)(66946007)(4326008)(478600001)(6666004)(41300700001)(52116002)(6486002)(316002)(38100700002)(38350700002)(6512007)(6506007)(1076003)(26005)(186003)(2906002)(107886003)(2616005)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1oKzPXMpSFmRfjZLMxqYewpPNuxV4U5B/mePqkADj40sDpDTYWgkQ8xtfqOA?=
 =?us-ascii?Q?9xS0RN7c3KH4fjHxlTjljPJ+fZgc2t5xKIe4kXeAcXIlbExYSL2Yp5Dw/U8Z?=
 =?us-ascii?Q?M8FUYxOm4qOVYLstU356bWQSMerWEyeMhyaKjnyOD4TYi1sg4bZmKNwm20AX?=
 =?us-ascii?Q?3ycUSi9WsqAmgqPqAKj061eGbeojguWNnnjM00mZQT8jHWip5+1bkgiq7oVD?=
 =?us-ascii?Q?5SHquULCaTeu8+CEFZicXGZdhS4uhQIKVD7hAth0qpAJSmMwlJs0tKm4kIUc?=
 =?us-ascii?Q?JKLY8YKOKYsdKp+XPGoBBpGu1QFXpuZAceG2lE43JQllX+JEU0Ai8mQg2q4r?=
 =?us-ascii?Q?8iuRn42NqL37Wj+svZ99MumzizLBL7zXJwQFGHocvuK6cO9v6/M0cffnHYHE?=
 =?us-ascii?Q?Sz8XLMoDJEmIkw91pw3Wru2WhvNDxKihKZXUHRiCSoIXgj/SZRt36fujHmG2?=
 =?us-ascii?Q?AWXfpioux9CnDUJ16xJ1HFQjByezHHjcT/+iVtYqbpx57Drnwvb5kc/hrSux?=
 =?us-ascii?Q?PgNSpx8Zs2GsH/rDf/9wb0hmptAOGvs+uyeF/7tJBUroyyBzFILeCiRHmd/2?=
 =?us-ascii?Q?DyiQi39po/p31Joe4EFJnSlfzAy6cCZ5NhVgysRL//DNjXsgEBw2Yw5S9KnG?=
 =?us-ascii?Q?+2lQyLMIITo9sxzgr8Pkiur/7vCAsJPI34v2TmM//ws1t4z3qkmv/6Ymjsi0?=
 =?us-ascii?Q?QtOqjfHWe/O+DjocNAvO0NeAmkMCuVsRxb3UR6WRI+B6Ug778KTcXoGGSvBS?=
 =?us-ascii?Q?cZTY9AlnawowSB1RSChOhpxwG/xDToA6p1bn4Tp7Iq3t3qP+8AltX/d/+Gng?=
 =?us-ascii?Q?Kp2lcYC/lX7RAcKOO0I8vcRs+XKcyLe2dPxME7mmidT/Td/B7wc6st5NKDN5?=
 =?us-ascii?Q?wfT87Rekg07lD060zRtC3yK9ooUpn6GnIbYSdmq9z7ONDFvhsdf922YCFMzo?=
 =?us-ascii?Q?UQJyqvzZwdmlciuiqa/GoaXTyRbalKbenCJXyeFLzvBSsVcC8wbmI3HmsENr?=
 =?us-ascii?Q?zvU6eL9BMDJwWPvsAFfTBmvzOGvKY17f7TFPr/8aMv7LZu6rJCWHSNs2IUll?=
 =?us-ascii?Q?RDLeFehGWdekET62FM/Ehjni+G7uLw8mYac49pNwDHtFISATvEq8RzyayPl4?=
 =?us-ascii?Q?vFuK0Hr/ExaDdWalTJEt4jGFbTzFyqpeJ5ejR2cdIagOas3WqgMUO7SJj5IF?=
 =?us-ascii?Q?YaFkteTT6RQ1aoSUK4PcSy8Nx5EDv7kYTw/LkFicxhlcAdbOYaUAHx/ft+cz?=
 =?us-ascii?Q?6PlcnkF0bp1+fEgN/rabONFEovxpQDxux0FT1kKDhGIlXn10Hv42/+bpzr7i?=
 =?us-ascii?Q?FZ8C+CcsE4Z7nPrqriGqab9esiCTLMr67PDlWQWiCceiJlFlbgfFac2TvpEn?=
 =?us-ascii?Q?5kYt9r6CJpc0GBR2cVEVsvfwmG8al5s0J8JIUA0mhviPLTgYopHKdM5ViZmb?=
 =?us-ascii?Q?1bd3aF9U0nYkMmNnfas31rILU3IMzmOtVvqcehO9C+jAHy8Lz/pZSyQeUhMh?=
 =?us-ascii?Q?E9kwuSI01NmjwGQAus8HovbtK6IYKwhX0FBQ27KhE31aVOxuSd+JwXD/vFdj?=
 =?us-ascii?Q?8AdmaEBs+ZfGzR2KJWJlNzMgxow8JWAnhaUlN+Sv?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e7c429-77f1-4b3a-143d-08db6af15c16
X-MS-Exchange-CrossTenant-AuthSource: SI2PR02MB5148.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 03:01:46.9602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mgWw5wjkY7sxwyorLErmFc6VP/7e97rVTxegs4d31L6M0exywRVwEEJ8zlCNNzFDcIVG3jrftUgQAXZDK4iFKg==
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

Signed-off-by: Sheng Yong <shengyong@oppo.com>
---
 fs/f2fs/f2fs.h  |  2 ++
 fs/f2fs/inode.c | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1b17bbe7e8656..a30c81ac7299d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3478,6 +3478,8 @@ int f2fs_pin_file_control(struct inode *inode, bool inc);
 void f2fs_set_inode_flags(struct inode *inode);
 bool f2fs_inode_chksum_verify(struct f2fs_sb_info *sbi, struct page *page);
 void f2fs_inode_chksum_set(struct f2fs_sb_info *sbi, struct page *page);
+int f2fs_inode_chksum_get(struct f2fs_sb_info *sbi, struct inode *inode,
+			  u32 *chksum);
 struct inode *f2fs_iget(struct super_block *sb, unsigned long ino);
 struct inode *f2fs_iget_retry(struct super_block *sb, unsigned long ino);
 int f2fs_try_to_free_nats(struct f2fs_sb_info *sbi, int nr_shrink);
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 1e49009831c12..098d1ee72bfcb 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -204,6 +204,27 @@ void f2fs_inode_chksum_set(struct f2fs_sb_info *sbi, struct page *page)
 	ri->i_inode_checksum = cpu_to_le32(f2fs_inode_chksum(sbi, page));
 }
 
+int f2fs_inode_chksum_get(struct f2fs_sb_info *sbi,
+			  struct inode *inode, u32 *chksum)
+{
+	struct page *ipage;
+	struct f2fs_inode_info *fi = F2FS_I(inode);
+	struct f2fs_inode *ri;
+
+	if (!f2fs_sb_has_inode_chksum(sbi) ||
+	    !f2fs_has_extra_attr(inode) ||
+	    !F2FS_FITS_IN_INODE(ri, fi->i_extra_isize, i_inode_checksum))
+		return -EOPNOTSUPP;
+
+	ipage = f2fs_get_node_page(sbi, inode->i_ino);
+	if (IS_ERR(ipage))
+		return PTR_ERR(ipage);
+
+	*chksum = f2fs_inode_chksum(sbi, ipage);
+	f2fs_put_page(ipage, true);
+	return 0;
+}
+
 static bool sanity_check_compress_inode(struct inode *inode,
 			struct f2fs_inode *ri)
 {
-- 
2.40.1

