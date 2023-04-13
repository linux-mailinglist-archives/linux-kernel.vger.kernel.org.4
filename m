Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756586E1156
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 17:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjDMPmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 11:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjDMPmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 11:42:12 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2102.outbound.protection.outlook.com [40.107.215.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1622210F3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 08:42:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=naFxda0D0HOduI2f0hBryuKB5glUWRMhAhhsyN2cHPQlsba+ytd0WpUH4wsQHIiCJfeziPf5WJp7xG7ujVYiaVkQs+PO0Q28cJmmZGepkXGcNqIBTGVZz/urW46N3US7SDRmGs5zHE7Qh91bFEjz2eLRV5ocppniR+1349C7fCmJUPlJgGH3OOcBf8C/G/YmZY/NKd5dD1uxXPEcCkK4KE77wNS3ajVHvuoYuWy/DST3mE0Gx4hMPBBQWboyWnFEyfdYoIO8KWjM2wESY+5Tgo75RGNtsXUW8MJVXCB9pyedNoQXK7hqaajD3nscWar/hE+lf+NMbq9tWlyQFUZTsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1EIkrNzrymZuKVXSFaDoPvl6NVEnq9mSryuFYHdYrN0=;
 b=MDdX0cgirBoxzysRSCIdm2lrVq31BldjTlBb3wieqxIARVnI5MY40TwIzlucKnRPea7pH0jqz/xfdjyPLYWVfn2SA7jj5EwrrtbmbdHKqer73GjcSofhG/DDVeTpZzcjsPdWkox5VYiCbUIuipIwwaJRpAF3x462z9Q+tmERWZKPxkteKWYRDrMF4g6h/cJxamdiUe4Y32fquKy39gpKNJ4Duh74pJZEtWPo5bIrDrSJdUqXGD3OOK33WCyl3rxPamJ/Mmo7vDbjAceqTwUC4Yy3dT2XO/uNOx0t8sRYFYZwNDLqcKsbwDDws6vzL8P1UjLGkLvK1dq+BAl3+gFY+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1EIkrNzrymZuKVXSFaDoPvl6NVEnq9mSryuFYHdYrN0=;
 b=QnvlXqVtisWt0PbtCNYto5lvFAZOXJm9BsGDfhRsnKc46ktLjuiuWlYQKBNRoxCgLwQQhtF1rPkestZCoA8qrwYi65ypIgI2Jw5PjyCYTSPwUIwBdXhpChovQ7GhatdUl6Sddb3/ZKs4MoR7Z9K9Fa41Npe6L2C2No2GsVjB6UxqVaDyzQgekO4a5x284sP+m+Grdmn4fGMYvdrj20jtjvliUiqyHk3XChVv3soSldOFmB1604dhyeNveuNXUJAdk5qxzOsCL1GVMYgtlaqxAs3X9tseuf/mcugsQlGoB4WWh6gYLIKhgGArRlwutU/Q57Y+4XvZuIx1IBjI/ujKsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4027.apcprd06.prod.outlook.com (2603:1096:4:eb::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.30; Thu, 13 Apr 2023 15:42:02 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c%6]) with mapi id 15.20.6277.038; Thu, 13 Apr 2023
 15:42:02 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Jan Kara <jack@suse.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] quota: add ALLQUOTA macro
Date:   Thu, 13 Apr 2023 23:41:51 +0800
Message-Id: <20230413154151.72935-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:3:18::14) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4027:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aac1dc0-34b6-47c0-e38a-08db3c35a040
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hpU7PT8Ck04ggOVv9USpOhy837TjNUk9fgRQO4JvpfLnN4gaIy0Wt/vHf/vEL0ZwfRafqZvnx5v76+svsmwBC9nB+DH4N6wMTBlMJzNGAxpZHczjEiGj5Z8isKOUkyn93BUYyj3MmV0QSAiGIYqetS5rKiYGlU+p6uh59f+Vx2XtE6k1iVp1oWCE2cpqochrQMbrftbxdCbzwSJDY/GllZsx5/Hgn+x1NK5AEzsUJW7GErxxDFN6Rt9U2JO2djGBG6hTAIQ5j4ptmpHmXdn2MqnZPOwsHTfJ34Y2or4Lgi7leDug4XZ0naBcsJCsdp8sDFVEtRCBJbJA3Tzv1211bxuT0RdQUA14zUfM6tvhmigvHROfjPodDcsdSc4ZKPa5wDErXBtvB3/vRDiCLxSOz54r5++pfDzlAtLSWp+BRcpTZKCzdtmoUyO04OHgs5rCJEXiOnxpRy0M+oZsRr748PzhBXdphg9p5K/3K62S/b8fCYqoQyXZ8eDOPuxHbRfks5dAc8mZt16Y/S4XJzhnQSEXC34Kx0f6KpYA4UWR0Bi8/wudj60N4o6nBrJfdtBfAZW/PoWKbLpQGkkWwLw3CR3KiYV7tdPB1kkJBqdenff1hPn7c/HCMptABgKJOoxX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(451199021)(5660300002)(38350700002)(41300700001)(38100700002)(36756003)(15650500001)(2906002)(8676002)(86362001)(4326008)(6916009)(66556008)(8936002)(66946007)(66476007)(316002)(1076003)(2616005)(83380400001)(6506007)(6512007)(26005)(186003)(478600001)(6486002)(52116002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jtp4KFIBTnW623AYsKpWZEwOOy9I60A6IHQZJDwkWuFkMIClkHuV4yqD8FsI?=
 =?us-ascii?Q?ND/uELjxpHvud7QPAPvU5owZAE8FL5qhrGrig+xYTw1+DvO86D2mZ5Zbpc4O?=
 =?us-ascii?Q?Hr/SzCZ/H+qeNdtSaD0VLwhZ5wyO/58f4Y+NG38vsaZt+/k5y6WUWKILEAvK?=
 =?us-ascii?Q?UrJ3be6xPDvFhexZMsVOrkweYlG4oHGOhu0U/jZQeZYOu+GsuQgqR5iUzHvN?=
 =?us-ascii?Q?TFQNytZKnRPN3h+NUl2XlWWrGxc08X0Q5L+hZ4O40hxIOz4edCfRGnJN9Tnq?=
 =?us-ascii?Q?v879OeqOuaUvIpxyhyIcPnofROnRFJ1071A0zXy5aCHNkHKHuuyhc91c/J79?=
 =?us-ascii?Q?vSvPOb1vZyS2vew5c/XzFoioqI+6AvoopEnmYVCyC12qB6ur3KlfPUVswjBb?=
 =?us-ascii?Q?/XZt2YUvq8i0DuKWkQEdMEaEEhdHXmER9dgkskLFFnyW3jt64RUmV0dOWaiK?=
 =?us-ascii?Q?EmdSXeTRPW/tMf993HnxhW1WHatqn4++f0Vfu1QzbOOhalD9xW/R8hEhRuP2?=
 =?us-ascii?Q?d87VqKwaIH4FDR/nBcF3Aja5F97p0vOxlDzcCJXhTDPoUc6axgOaxHrZwOW7?=
 =?us-ascii?Q?CmGDQ4S3KzysvW9wzM5XW0uUv/wn4KBVyfaYc/xDFJONGzilzHVt4NqdLBUp?=
 =?us-ascii?Q?aJs3tiMz/pRccj2KB07WBc/jSVySKbPF4XSZHuLEHHHihLJMWFGXjnmxNJDq?=
 =?us-ascii?Q?pKJzUoI3/8k24l98x+SA2I63C40J+0V5QHFxG3eWIbk7Y21urXBoNHw5rAgk?=
 =?us-ascii?Q?XfAEfZme8gjBbbhbHGmN4HR2a6tPZG1F4Di8DaHCxLr8JBC6iw329w0+OQRI?=
 =?us-ascii?Q?7NcYZG/tdMS9c8Ezc8Roqjy1BktUe3vdBCRvuSttsJqMW/l7SF7oEQgU8kD7?=
 =?us-ascii?Q?2KKiwa7eaazHlzg/vyJd412XfS6l/C63PRyWhZt0EEr4kaDgkid7io1ofa5K?=
 =?us-ascii?Q?JZg3TUtFimHmdCISMzYAAkh9spdemVNdrwdU56Heo6xw0rX1JtgSLb0Ur9ki?=
 =?us-ascii?Q?CVhdUgKkvpMLWyiMF7s+uGWoQrMYRK0EQQJUsVYW+95lzpblYAs6FeImr0y4?=
 =?us-ascii?Q?+oqml53E6FdgTqFL2IexfiOhCn+HxXDnWUVkzdNoEnkWlRmF/N9kcCM04AIe?=
 =?us-ascii?Q?o2Y/nnv9OaKh7ECdy9HZTZt1z+dRh896xsZyHmRJlOiAUodDGo0/4yF7aJYu?=
 =?us-ascii?Q?Z8PvH/SYlxyEXAm1h+vGDeUzeBSe/+dxI9+6waYITKimZouEA/SlpOOxoCbx?=
 =?us-ascii?Q?N7qEsws9xS1EzBXkTY3p3drwMk/b9NuK2IEy0EZ7XoEdeEpe7vCdgW92HDVp?=
 =?us-ascii?Q?eTuy5qvZfUyuxpeeBem9b2J0nLxVL3R3zJixkGeEtt3pR5+iKT+Cuk0pXrRO?=
 =?us-ascii?Q?kdBRo+ib5gmJbDrMBxX3MNpu3qlRV+DW+HPoEas80zgxig4VWx6YbRrn+bIq?=
 =?us-ascii?Q?Oey4n+FoqfEguqk/ZXi72KrukakP7c2NhN1Pmlc5O+pw343qu5r/aR67d0EZ?=
 =?us-ascii?Q?VajBll4RSewfhpVdLADCi0Waxgx3MB1pJQgQ753i38zyXyTL9RO5gV1A/65N?=
 =?us-ascii?Q?1xyb6OrpAhveGxeNXoSAybfs+JVFK/mIbUPisZtK?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aac1dc0-34b6-47c0-e38a-08db3c35a040
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 15:42:02.3922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yVKciuK6nkF2FakCLwyi5fCGPgBhfUSConHe6eUH0Lw9qZFXkhAJ1Xkfx+jpnetjNizP0rq9LypO+u8ULvY2bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4027
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert to use macro instead of raw number.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/quota/dquot.c           | 20 ++++++++++----------
 include/uapi/linux/quota.h |  1 +
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 10b46c403bdb..62ee6cb32e57 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -640,7 +640,7 @@ int dquot_writeback_dquots(struct super_block *sb, int type)
 	WARN_ON_ONCE(!rwsem_is_locked(&sb->s_umount));
 
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
-		if (type != -1 && cnt != type)
+		if (type != ALLQUOTA && cnt != type)
 			continue;
 		if (!sb_has_quota_active(sb, cnt))
 			continue;
@@ -675,7 +675,7 @@ int dquot_writeback_dquots(struct super_block *sb, int type)
 	}
 
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
-		if ((cnt == type || type == -1) && sb_has_quota_active(sb, cnt)
+		if ((cnt == type || type == ALLQUOTA) && sb_has_quota_active(sb, cnt)
 		    && info_dirty(&dqopt->info[cnt]))
 			sb->dq_op->write_info(sb, cnt);
 	dqstats_inc(DQST_SYNCS);
@@ -714,7 +714,7 @@ int dquot_quota_sync(struct super_block *sb, int type)
 	 * that userspace sees the changes.
 	 */
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
-		if (type != -1 && cnt != type)
+		if (type != ALLQUOTA && cnt != type)
 			continue;
 		if (!sb_has_quota_active(sb, cnt))
 			continue;
@@ -948,7 +948,7 @@ static int dqinit_needed(struct inode *inode, int type)
 		return 0;
 
 	dquots = i_dquot(inode);
-	if (type != -1)
+	if (type != ALLQUOTA)
 		return !dquots[type];
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
 		if (!dquots[cnt])
@@ -1391,7 +1391,7 @@ static int __dquot_initialize(struct inode *inode, int type)
 		int rc;
 		struct dquot *dquot;
 
-		if (type != -1 && cnt != type)
+		if (type != ALLQUOTA && cnt != type)
 			continue;
 		/*
 		 * The i_dquot should have been initialized in most cases,
@@ -1440,7 +1440,7 @@ static int __dquot_initialize(struct inode *inode, int type)
 	if (IS_NOQUOTA(inode))
 		goto out_lock;
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
-		if (type != -1 && cnt != type)
+		if (type != ALLQUOTA && cnt != type)
 			continue;
 		/* Avoid races with quotaoff() */
 		if (!sb_has_quota_active(sb, cnt))
@@ -1478,7 +1478,7 @@ static int __dquot_initialize(struct inode *inode, int type)
 
 int dquot_initialize(struct inode *inode)
 {
-	return __dquot_initialize(inode, -1);
+	return __dquot_initialize(inode, ALLQUOTA);
 }
 EXPORT_SYMBOL(dquot_initialize);
 
@@ -2131,7 +2131,7 @@ static void vfs_cleanup_quota_inode(struct super_block *sb, int type)
 }
 
 /*
- * Turn quota off on a device. type == -1 ==> quotaoff for all types (umount)
+ * Turn quota off on a device. type == ALLQUOTA ==> quotaoff for all types (umount)
  */
 int dquot_disable(struct super_block *sb, int type, unsigned int flags)
 {
@@ -2158,7 +2158,7 @@ int dquot_disable(struct super_block *sb, int type, unsigned int flags)
 		return 0;
 
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
-		if (type != -1 && cnt != type)
+		if (type != ALLQUOTA && cnt != type)
 			continue;
 		if (!sb_has_quota_loaded(sb, cnt))
 			continue;
@@ -2392,7 +2392,7 @@ int dquot_resume(struct super_block *sb, int type)
 		up_read(&sb->s_umount);
 
 	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
-		if (type != -1 && cnt != type)
+		if (type != ALLQUOTA && cnt != type)
 			continue;
 		if (!sb_has_quota_suspended(sb, cnt))
 			continue;
diff --git a/include/uapi/linux/quota.h b/include/uapi/linux/quota.h
index f17c9636a859..1707ed43365a 100644
--- a/include/uapi/linux/quota.h
+++ b/include/uapi/linux/quota.h
@@ -38,6 +38,7 @@
 #define __DQUOT_VERSION__	"dquot_6.6.0"
 
 #define MAXQUOTAS 3
+#define ALLQUOTA -1
 #define USRQUOTA  0		/* element used for user quotas */
 #define GRPQUOTA  1		/* element used for group quotas */
 #define PRJQUOTA  2		/* element used for project quotas */
-- 
2.35.1

