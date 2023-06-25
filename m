Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B215373D1F3
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 18:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjFYQGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 12:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjFYQGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 12:06:50 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2087.outbound.protection.outlook.com [40.107.215.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DB3180
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 09:06:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nFKSXBa7NBcweyZgwls7l//EqSO/zk7jlStkrnSDelgrtHTkPFDnFQv19fbFHTOb8M9hq6M3XiWqzWtcjiITqarSUrtiaWoa4H25zTC8mRBzLy7F3HA36TNhzkhUy0hSGOqUFS517ABER32N9Rfau0rY8MSJNXEpGECXgLFCRdrrv06PWY9Iu1BAZ4goIpEB62CNY5L2cl7bjy/388LBuHp7Ne7r3VmUwQcjclzXbWkij9ugQliZvHxOTTX9bq3ICjZp9A+47BPFZj75B55ET0wBlqTInHsLHzuu5bREpL5G20WleuYi6xQrWoomu1RkzXKDq0sdNzsQo/nc1gfCKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iNBihyaceJnXBqNKlZm3oWM9ToYbC2/QSty5I7E97ZI=;
 b=KgVivBV88tLX9TeHHTnUI7qjOfPmMoNHEMcrGONAIJuMLAnjCgZf07L2xnAxnIbnrsBe7HSUCWFoJGFk2Ojb5u9I9MJkKBbZgO318JP+M8uaSdaca+25c0qVFRfvGCXOIMf38l6opQM/oD3s91dkshMKK0zIC78phFcjFw8FYImau4LdGv66dI1WdH+cEnY/ji/cZbky4K6ssinH4koDkuC/W0cMOXs0nk0FZJUYFUbGVp2EVhdF5bhHe+IxSuj9mlyIjult45rgVS+x2zaB1zSko6tA6hHT/XZGYFLJm4lyJtU8E1XUvpTS3YzvgL3l1fXGZ2d1NYXm/k3KcRpLuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNBihyaceJnXBqNKlZm3oWM9ToYbC2/QSty5I7E97ZI=;
 b=OS3VLcncvy98/OazcyHH+vV1Rma3WPxPISbQ3D9hwBqIoJL1cDKSn4e4hTOeTcn0JkXH9kEr6K8Ku2ESi/w7MJTONECMQDxgEfD6M01pTurRDtI42RteSEKQ3JHBAUjagiBhlkavVLJkB7mdqUtlTI4Y0H01rLbm3AZFBPUT7LA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from PSBPR02MB4471.apcprd02.prod.outlook.com (2603:1096:301:2::12)
 by TYZPR02MB6524.apcprd02.prod.outlook.com (2603:1096:400:363::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Sun, 25 Jun
 2023 16:06:45 +0000
Received: from PSBPR02MB4471.apcprd02.prod.outlook.com
 ([fe80::8d7f:e42e:6212:882f]) by PSBPR02MB4471.apcprd02.prod.outlook.com
 ([fe80::8d7f:e42e:6212:882f%4]) with mapi id 15.20.6521.023; Sun, 25 Jun 2023
 16:06:45 +0000
From:   Yunlei He <heyunlei@oppo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yunlei He <heyunlei@oppo.com>
Subject: [f2fs-dev][PATCH 2/2 v2] f2fs: truncate pages if move file range success
Date:   Mon, 26 Jun 2023 00:06:27 +0800
Message-Id: <20230625160627.4112651-2-heyunlei@oppo.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230625160627.4112651-1-heyunlei@oppo.com>
References: <20230625160627.4112651-1-heyunlei@oppo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::18)
 To PSBPR02MB4471.apcprd02.prod.outlook.com (2603:1096:301:2::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSBPR02MB4471:EE_|TYZPR02MB6524:EE_
X-MS-Office365-Filtering-Correlation-Id: e886c4b3-6b5e-45aa-3ecc-08db75962bd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jZu26Spd3t3mQaNs9JPNJoaW8o0clAuEgbxVQ4qoLz9E//0CkipzgWLK56bd3MAjxy1b23EG/1k49weBsIXeFXT0iKEOibEx9qsRDvWXLNxS7qrUf4Qd4cbIWvKtid9+gIcJc6QrCZzSotcYTciCEvNQXk8nqzgKmLfq+N09TDCBHLAoi0UqYFzpZtwQeHtnG/EhZZvJG3a0V5Nz1veD/q3SJi+fSZd5fHGNzcMZHQkg5CcOa3z1CTcVc8Y7yVJUfV97G+SK1z4fx1gst9fhPOFmDSszr3McphQ4Wf1zADYNHOxmxfwt8Tybkqz1BgK3xj+iWVQTlNvoaMAQzwcgldjewlZn2mJqHRsaIhOVN3d2J5Ehwq48Zt+QUGaZo2Xkt39mc9PK2TzP2zb8okpNh2lY6I4kMsU8fb3A6H3soKkNtfLeRiLPqpizzvRk6Bm4HA5Ox21D8TAwXNgRs8ODMOaD+CCWsu/wN7Tsr2YAxnFBAt82JMpU4OWfSHv7epBZsmIs0xEuyn92HC+iOuMyPIdvxUVIt/wnb7UqU+fhIarZdZZSEdARe4WxQPUmYrfQB66T4a2DvUZ2BJRYT3yksVwkcw9KG8cwUA7lwIBSEYdH74gJT7GJvNeOOyEOVuAJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSBPR02MB4471.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(136003)(346002)(366004)(451199021)(2906002)(4326008)(41300700001)(8936002)(5660300002)(8676002)(316002)(66476007)(66946007)(66556008)(478600001)(6666004)(52116002)(6486002)(107886003)(186003)(6506007)(1076003)(83380400001)(26005)(2616005)(6512007)(36756003)(38100700002)(86362001)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?scQZtEya1H9Zt+HGww62l7U7CjTL5cyw40s5Saj8YmYurBXCpT0aNtJpvlTh?=
 =?us-ascii?Q?r4m2gZm59OCu8UdHbtR4AG/YOrbfDohzXMmhM/4HePgBZF6AJD4zsnW/DKr7?=
 =?us-ascii?Q?TLSNH4ajw2boCwv1klaisU9dZNqo1GP+7n9Kj5u2X4fdjNzLKDig1xK4q+Js?=
 =?us-ascii?Q?sH3PVIbInbpvZMsShMY4QLLX4bYVm34lw3Zsu0hE0rJDChj/duh9YOsfvf1+?=
 =?us-ascii?Q?T0DMTQn3RbQ0F+lIK5NY1qmDSKFmBCLpnRgC+CjruvjBLUIamLWCpt5JTEcd?=
 =?us-ascii?Q?8De1G7To57b8n27+wSsDzKLpOZ+FdJRPpttx3yK6wTWiq1e7RH/L3lFBvQTu?=
 =?us-ascii?Q?OeCMlqocofUuYxBjsea9Q40leZLab7KE6LxhdBXPFR+anslTTBY67YbP/Faz?=
 =?us-ascii?Q?VGTUZvMmuklgnRsDm3pReESXKuIwDp933TZGWQ1rYkKJYQ+9cKeeEmz6+PaU?=
 =?us-ascii?Q?cipmTdcuSG4gqb9ZnGE9gl8bjt42EMCCPft5PmBB1MkDbB951CKbSWcA0lXJ?=
 =?us-ascii?Q?FwCzd7Innl1Q+V7B1KsAjk/tTYXlqvNeR5RBUfhpco3ZB9qXw50lIuEswSUM?=
 =?us-ascii?Q?TZocVtt6tCW5OuZ6Ka4c9XaCPAKdX1leNQL5oUwgERtT7lLFkz5U3zpneURi?=
 =?us-ascii?Q?kLqu4BVRFg2BdhAWAAhEObRdiNYU+Q42T0yzvztUQThinMRdyJExFQky9pHq?=
 =?us-ascii?Q?kPxsS5lW/zh8AUrYQeOQIj+cSaNC0IEM/3nTnHslA6s4PGR5tTs1MvTYEGB5?=
 =?us-ascii?Q?QTv2XNI4A+AWEC04CE3E8npG2UHKLG8YmSBSuStNj+P5GaUjNUdQthwB9Ezs?=
 =?us-ascii?Q?uudHvh0kCJt17mkTQUaAFIxiOe7FWU1ilNcZtMqC1qZ4BOxsmlDySy1VVbh6?=
 =?us-ascii?Q?WcRkSaKLiMPqZkkXVBs2DxdpSd+GCOZj4ENHwSku0aMANpFFqM6NYGxRRyMH?=
 =?us-ascii?Q?WMCvUe5hUH/vN0jqGgOJzC9T73ovCC9HnOdo/IkLWn3g+HyUum9I3ka9QZmO?=
 =?us-ascii?Q?OcXocYXjwxBxeM425K3IccKuHSiSiVIUvHHJYJQdi4uo60TpOcq2A72a8dd1?=
 =?us-ascii?Q?1ise39wTA30R5o8GpxPtP36T5VghHnisyZw+c4uwnfElLUVfk5xFaAu4qDzE?=
 =?us-ascii?Q?6KcJk6Gx5cEpomYX9QTCKXx2xHxdTkzO0p6e7hF9vpoFAMlSAI+kI3PQFFgT?=
 =?us-ascii?Q?NrSSkUkV+51aZGd7P6uXUS2XLKZMGjjrwubBhgdV4LbTSpLS6A6YHju66SOd?=
 =?us-ascii?Q?dRMPZuP49Yl+j3GiFsRX0jm3q220QBahRZ2FJ366T7h0n7VyTywiX6PyYd0m?=
 =?us-ascii?Q?lT4ShpWy20vEz6p/ZKY/jk8gHk96riWrO+a34aA8m/U3Fygf7oSRbe8Mbzo9?=
 =?us-ascii?Q?EyRpud51W8SUzkjcgX2O0O9XUJ5mAfHUS12DNCoeQyS/drp/p6Z64oexcUtf?=
 =?us-ascii?Q?+F3eUJUexq3HIuhB/Df/AYwIp35I4YPzZdJB2vK+Xf8eEXX4u4457oj4oVoF?=
 =?us-ascii?Q?sNPvhLjqkg7Z7TlbD2UGjOnjdjg6NdpjCUBZ7ZA/m6RX/djFczjsdcpiJ0Tw?=
 =?us-ascii?Q?v9HhzEO8Y3bkiW0gmrtFMpEWAwohzzm2VyAMh2Jb?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e886c4b3-6b5e-45aa-3ecc-08db75962bd5
X-MS-Exchange-CrossTenant-AuthSource: PSBPR02MB4471.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 16:06:45.0158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YfUCXUDZuzWvCZs/bf/qVDyNyy+1NXf+fTq8NCMtUZDILwi2JKSTNuiObxIco2cdkd9X2lWVW8ZKsxRPRtdsFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB6524
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If move file range success, it should remove old data from
src and dst page cache.

Signed-off-by: Yunlei He <heyunlei@oppo.com>
---
v2:
-truncate pages with filemap invalidate lock
-should drop extent cache
 fs/f2fs/file.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 5af7e57b6140..7b3b333f96f5 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2869,7 +2869,13 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
 			goto out_src;
 	}
 
+	filemap_invalidate_lock_two(src->i_mapping, dst->i_mapping);
+	truncate_pagecache_range(src, pos_in, pos_in + len - 1);
+	truncate_pagecache_range(dst, pos_out, pos_out + len - 1);
+
 	f2fs_lock_op(sbi);
+	f2fs_drop_extent_tree(src);
+	f2fs_drop_extent_tree(dst);
 	ret = __exchange_data_block(src, dst, pos_in >> F2FS_BLKSIZE_BITS,
 				pos_out >> F2FS_BLKSIZE_BITS,
 				len >> F2FS_BLKSIZE_BITS, false);
@@ -2881,14 +2887,24 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
 			f2fs_i_size_write(dst, dst_osize);
 	}
 	f2fs_unlock_op(sbi);
+	filemap_invalidate_unlock_two(src->i_mapping, dst->i_mapping);
 
 	if (src != dst)
 		f2fs_up_write(&F2FS_I(dst)->i_gc_rwsem[WRITE]);
 out_src:
 	f2fs_up_write(&F2FS_I(src)->i_gc_rwsem[WRITE]);
+
 	if (ret)
 		goto out_unlock;
 
+	/* write out all moved pages, if possible */
+	filemap_invalidate_lock_two(src->i_mapping, dst->i_mapping);
+	filemap_write_and_wait_range(dst->i_mapping,
+					pos_out, pos_out + len);
+	truncate_pagecache_range(dst, pos_out, pos_out + len - 1);
+	truncate_pagecache_range(src, pos_in, pos_in + len - 1);
+	filemap_invalidate_unlock_two(src->i_mapping, dst->i_mapping);
+
 	src->i_mtime = src->i_ctime = current_time(src);
 	f2fs_mark_inode_dirty_sync(src, false);
 	if (src != dst) {
-- 
2.40.1

