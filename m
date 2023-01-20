Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4BF675866
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 16:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjATPUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 10:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjATPUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 10:20:40 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2110.outbound.protection.outlook.com [40.107.117.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629B8D88C4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 07:20:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eyJuuPUm6TGGos1xG42gXIvxpLBnpbwrjx5OctrLN/SE5LYl9L94RKelPMEPt/kV+Ja831oVMzRSOgVtlUPR0RX+lhcF8kvXa0JR1eWDxuUe83Bdl4DE0t0yIoYzl5NSDuVbptgiD+egjs9ZLvySuaKwrKrDRCemN0TNgh+dwBKdIPdK68b/8O00cjg68IXMHtd3q/VAvOdco7Uj2xcXD473fLVnUdbOqpKh1nZdT+eYs3N7x0bd9RRttviW4KUo68rtW4I/DunS9uMwjNCfcONX+WnvR2iKmaGlxBkpP6mNuaT7d4pNbo42ZIcqgjzt2Iwv4B8PMi0nUOaDCLMs8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VbygLgkTF7IWrIPpwCniLbpMYjCnpoehimvcP3XA45c=;
 b=dbW6+WGtWITNKKeEfmAuNe3mdX4Q5iL+kLEUO0MiTyihGq1mciP284+k+VVaOz94v8jH5h1AgH3KPvzye29GDcdHd+zLS98T/fu1PKWh3np6uJ65DZunNIz393+iESEFwg9WtyJuSUeAnYeMX7XrKbhNKMU2xt58KIjhsMGD+MgLb5GSTus37ON0hhuqA3i0Kne9VozHpc4CpVk1sk4YtQDDTGLd7cgehfxNPtbzKlDAxx2lyDoIq0oCOGLvhA0JP0T7sJUSjRhSoGhnn2YdumjItPoLEw5cB3ddzHowpsrq97p2c+MRu1iDjsYdQArjCLQWFsMK0AzbyfT2Y8/PnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbygLgkTF7IWrIPpwCniLbpMYjCnpoehimvcP3XA45c=;
 b=T7iA2S2qkDX+tJNhU47OcJBPP/0Cy7wVWgQi2zJv6GAB9CihSc31dllY3mRaT2hRlhc2fftGK06ZeXm+bgp00qUsHM82wZLtrzyhIYYFhmhHvMk3pqpI1NfgwixdowY5ZK64MHF6CQlzmpNnRK5vq3gV/znyqyger5LNgHoB8/uCfzZ999wm0ewLNeQbb9TiNBnj3PcfYBKEWQEKxPQs0xtmy8nDnUGCLVZPMvibdwa0bjja6+qGLeh14UEQuU17C5YjyIyL5HNSp0Zpr5R5MNsysQHzyPIal2XQCWQdF/+Y4pr16OGVyKNIBztEoNyf6c4p0FxRZM6hYqAel7/Y/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB5727.apcprd06.prod.outlook.com (2603:1096:820:b0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.5; Fri, 20 Jan
 2023 15:20:26 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::3e52:d08c:ecf4:d572]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::3e52:d08c:ecf4:d572%5]) with mapi id 15.20.6002.012; Fri, 20 Jan 2023
 15:20:26 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH v2] f2fs: introduce sanity_check_blocks()
Date:   Fri, 20 Jan 2023 23:20:16 +0800
Message-Id: <20230120152016.63430-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0114.apcprd03.prod.outlook.com
 (2603:1096:4:91::18) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB5727:EE_
X-MS-Office365-Filtering-Correlation-Id: 309966bf-e486-4b58-8262-08dafaf9db81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gTOxAk1novSzc6KNdNPHeUj5wsaUpxkb8X05Dq/9edwz1hfuS0Yk18xOQt6ODlmjortviBBvDixQZs31N0/kuslp5nJMIWc3LRyYwvhwUEG0D7MXu7fpFTIFIrnkpbaVRhBdGDHEHJWn/CsCeWqh+uE+DCCPWIGkNz8KBXFmEfvCaNPS74sIk0XX3JhHJf5NNigKzL0eOHr2np9Lwh972eteIWR8egd9yoVJ2tGdme1+KwHmhWc7INh9+uID+cBuV7cdJWWnvmY8m9WSOPktMVuSHmLt+MGqp8su6J2SWgLgIVeccE/PdOdIfo8W3WLgx8HAA0slIE2ShFLG3ou8NjOMWjJ5rVgZyGPz46lmTSUkRdG/popiIHe/y0gWcEcLUZjiGcWc4YbAONXxx51VWc4eVU3ifM/EYnfTKG/19p7CawJ1rHgXDzGEgRsyo+kdg102i0sTQKgNZV2ooa7EeJD+SMjg4Aj5XpYTVMdKi3ub9KeYuv0UM4CsnQIxO+ZuytaDcROoWPMagYdb0IdjECNvAQA/tdLBWDhaH5lLAzX9RhhPGWIFVAGmcxRJL/9UG7/dpdGvp1lq4W0RkcTnprQMOPTgzmnombh3hO9J29dTYJ+aBiZxqkw7lhkzESCUgh2RKqVnErtmI+IG0HqnK/TTyRLRjqFAn9fmPFtIjqFJww51u7e0celKY7MNxRrsbJTO1IKhBnMyLTngxtmOxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(39860400002)(396003)(136003)(376002)(451199015)(41300700001)(2616005)(36756003)(66476007)(83380400001)(8936002)(66556008)(1076003)(8676002)(4326008)(66946007)(38350700002)(38100700002)(86362001)(5660300002)(2906002)(52116002)(107886003)(6666004)(6506007)(26005)(6512007)(186003)(478600001)(6486002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?prN3/9qgibHj8SYqASP+V6V1muSnNAkpUH4kCW4cNbjAWIXseCCYu4DDYMR2?=
 =?us-ascii?Q?7KYiajZiUiEfILYk06bMMhQI2NqVCck2EEr5T2HGtnff3LgmWja8hgkoGUAo?=
 =?us-ascii?Q?wJWVWQpws90q7kR2mj7YqNwNJW7vdL5RBYpyeHAo+nC76qxmytqP7DbzkY5E?=
 =?us-ascii?Q?LrqvoeyIKincqmrfv4RCzH50LPpI7yBA2njIM9L9561HENSTIYTMRuqvAGYc?=
 =?us-ascii?Q?09+qzcpGDj9BG1LIk+GdnKjKby1MHkdXlSsDZDLcjyB11N8VCPGeZemCqalk?=
 =?us-ascii?Q?XryUz5udIiIpaCVNLUqCCxQe22mRVLmoymP/+PqYDnn2gqOUDelL5ER4c63m?=
 =?us-ascii?Q?8ZGIecfz/6dn6CousT0l72t6zN82Qg5BRp7ov0+YpaH0H7o51VyrZ6OqdwJv?=
 =?us-ascii?Q?vHemhgFXGvLRasqotcgXku8oiv0o9MPDE0spMp2ojOdf/oXlKGleN8RoCDMB?=
 =?us-ascii?Q?XRHqIPbZcoWUMGi2vxTfELvdVkwvzMqtCykUDuWK9OIoXpTSreyMHoVyCbDS?=
 =?us-ascii?Q?k4UzkHHSsX+vB8xXnDacNZb7eeTW4bv7uPeofO0A/+q8aOvJOzIi3dwWvljk?=
 =?us-ascii?Q?zvLX9WH97MEZ1NPpFAtHQVfJyHd6ofYzpkcdwDjf08iyEQ0NhVVCCzhlaJNp?=
 =?us-ascii?Q?lQsTyPhfHsIYVySx7/qHNtKwgLvVjxS6ti57Ww/DChPBdDyrA21KoSd8U4oi?=
 =?us-ascii?Q?bhIREi0gWK66yDpKSpZCvfUHkCTadE3e3FqG7SiN/pj7NQY7xZu1F5bEHqSb?=
 =?us-ascii?Q?kE3mvdbKxCOa3MNCpjHazT4gtJPteK57i6QQ1zwwEQTUCuJtuUqp6/nHJHM3?=
 =?us-ascii?Q?PEwJG3+fxv58v395kzjeuwbTHkQYB4nMNe8Ck9Z3d69o3aJOVRoit9ogpzJV?=
 =?us-ascii?Q?uz/IktqgS6Hfhec7w14Ndcwbok+OEC9yrMIRbVXF/9kUCtkxmQR+VJb47ybA?=
 =?us-ascii?Q?nNqLRQnlOPhHARO+HDVJiZU+FUq8KRuTbjH8jtRAvYZmYpMeQDuoaEs5WnpX?=
 =?us-ascii?Q?Ynu3MbqQH12BY4FlR/igk2PHhCtpuO9CSQypoiGXwwQ82Z4NWv15klNBjInK?=
 =?us-ascii?Q?Y18xlvBmUUt0bdu2mDgkSfufDe2UrKwbk97n9DlGXnmV2t43LGeHHlv14zh/?=
 =?us-ascii?Q?0jtIu7gvfzyvkmcTaa9EmS+tHOd+/RKC6DEc8CEOKS/V6eGCm+cfR+LpWDHf?=
 =?us-ascii?Q?/hfY1TsbMtlkK75gF1KIgwIL2ic8jfLbRC2QxSz/tc+ECa4QLF2twfeM3x6a?=
 =?us-ascii?Q?BPRk71ldjPWGHxke2A9wMKoFQ/aWzreFd0Y1KopbDHO2ww/4IBzFigKSL2V+?=
 =?us-ascii?Q?hmkR/NEdwSXITElXqoX2i7unzwP+It1sB8Rtoc6UT0M+1rYOsGBiUch7BlJG?=
 =?us-ascii?Q?LDP1ubbU4h6fefT7OdXv5pEpfZsaHKk8I5ukB56ZYgySMJmyjmDArZLnqyrZ?=
 =?us-ascii?Q?iVRFzWtbQVFslBeUiROeo0kGcrXl+w6GEC5IeOY86oluHA/o1rZmfyvAjyH2?=
 =?us-ascii?Q?+ba945glpoSxUkaWQbo81fi0mQ06FiNgJ8rLwVGjk4KvlK/YU0jF8NwG6m2/?=
 =?us-ascii?Q?ATJ3F3KMJfGg9l197CtbB9OYASI81z/D8yvQ4x4Q?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 309966bf-e486-4b58-8262-08dafaf9db81
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 15:20:26.4407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jSruoXWfbJpaMGdTfVfq6dklCdwyQFT/bfRgl8OCzb3euoaOTmrNqaatZ4XwwiVb3681aDymdo06tyXVuVIfNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5727
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are very similar codes in release_compress_blocks() and
reserve_compress_blocks() which is used for data blocks check.

This patch introduces a new helper sanity_check_blocks()
to include those common codes, and used it instead for cleanup.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
v2:
- s/rc/err/
 fs/f2fs/file.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 5e4b8c6daa1f..3967f6976b6f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3383,11 +3383,9 @@ static int f2fs_get_compress_blocks(struct file *filp, unsigned long arg)
 	return put_user(blocks, (u64 __user *)arg);
 }
 
-static int release_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
+static int sanity_check_blocks(struct dnode_of_data *dn, pgoff_t count)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
-	unsigned int released_blocks = 0;
-	int cluster_size = F2FS_I(dn->inode)->i_cluster_size;
 	block_t blkaddr;
 	int i;
 
@@ -3404,6 +3402,21 @@ static int release_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
 		}
 	}
 
+	return 0;
+}
+
+static int release_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
+	unsigned int released_blocks = 0;
+	int cluster_size = F2FS_I(dn->inode)->i_cluster_size;
+	block_t blkaddr;
+	int i, err;
+
+	err = sanity_check_blocks(dn, count);
+	if (err)
+		return err;
+
 	while (count) {
 		int compr_blocks = 0;
 
@@ -3553,20 +3566,11 @@ static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
 	unsigned int reserved_blocks = 0;
 	int cluster_size = F2FS_I(dn->inode)->i_cluster_size;
 	block_t blkaddr;
-	int i;
-
-	for (i = 0; i < count; i++) {
-		blkaddr = data_blkaddr(dn->inode, dn->node_page,
-						dn->ofs_in_node + i);
+	int i, err;
 
-		if (!__is_valid_data_blkaddr(blkaddr))
-			continue;
-		if (unlikely(!f2fs_is_valid_blkaddr(sbi, blkaddr,
-					DATA_GENERIC_ENHANCE))) {
-			f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
-			return -EFSCORRUPTED;
-		}
-	}
+	err = sanity_check_blocks(dn, count);
+	if (err)
+		return err;
 
 	while (count) {
 		int compr_blocks = 0;
-- 
2.25.1

