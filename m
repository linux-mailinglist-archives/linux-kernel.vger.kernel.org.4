Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCE171738A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 04:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbjEaCLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 22:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjEaCLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 22:11:03 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2091.outbound.protection.outlook.com [40.107.117.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8D110E;
        Tue, 30 May 2023 19:10:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/h3o0Kr5iiCRkJgITApU7nRF9hEBzGcNci4irJlXMnp52WTBnlMMS+HWWmyiyXgTfciDoh8EYZYqYn2otY1+MmqU0dWl63g2PP5LPUz06lto95blD6+v16y+yCSkHOaM80KrtgvnJCYtCiTLu1wr6IDv2ItQWvpQLgBLdjAGP0TXg/wqVWeyTLryyNWJgytWcjfABXOgc8jZnjIybS4ft9f7Q7znQ+d90Qwc3NUGvFrJMwdC7zFgNxsveoXMmYfEm9SQZw5R7+3Lps/TQjrgHnQ1I1MW7Eo21oDEJpuu3M7AIGqlog1Bk3qdJcA/KQqP+t1M80eIDqAhPCNAQ/nKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+b92XDs8y4ro2YxqUOK/a5Ee+0hilQaNgUblNhiLQs=;
 b=ajqpbTPW+87Bowt/RfAbCoRpC2c4ryRXl1w3iZCfWtL31DBy5tyG+ncQKRb5bTJwC9ljvMdTMEB3D+DuAuG1Xjh5XypZBLSYtLhqbO7opl1haTvNm+aJ0yu9jLcfiCrtzo1iVSqGlHBPfJkUMO8rbPjLU5qAzVA1OHTXzWOG2QhU74tyFgAbIsUErmzJlW2bPSpj039yjGUpGebIX4M484K0ZfRjQTbv17lHIecHstYXOpIV8l8cIPzo1lXBXJuwD8A6uy8PfN7Oy5AAr4gl/4fQdwKzOuTji7LYWkEKYEWgKQ89Wj6YHxFCbLqT4WrVrCk996VdW6C3Pjfm+hp9QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+b92XDs8y4ro2YxqUOK/a5Ee+0hilQaNgUblNhiLQs=;
 b=ecnn2h5ybHdscsM+2+iqDA2dzCooFhAygvWd8XAmlx8qtWAbf6z6NB3cFAZwXN7jSO9O7NgZM4GgRJRzknlk6DhTqfSbNCVHYmGBHkejsK8kXsHs03BLnPVyHKJyShHZ16mGWQBu+8Niigky86X4m1BjMyiCNgXeJ85utFhnOt1RsPjEvy7ovnH6HgVm7a50++/hDdst25/HTJ/exu1u8YK41A5t0BndFwaBRxThSJQjQIF/rd4IfaaiPulx9Ndy5HIk41tYLKEVb7/JXmtgYgsgoCBsfhfZ8vl9jkKKQSeNxrfsoFHcPw9Tg6O/WgexkTOeJNFbDeG6Q4lG8S9FVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by KL1PR06MB6042.apcprd06.prod.outlook.com (2603:1096:820:d5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Wed, 31 May
 2023 02:10:55 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e%5]) with mapi id 15.20.6433.018; Wed, 31 May 2023
 02:10:55 +0000
From:   Lu Hongfei <luhongfei@vivo.com>
To:     Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <sfrench@samba.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tom Talpey <tom@talpey.com>,
        linux-cifs@vger.kernel.org (open list:KERNEL SMB3 SERVER (KSMBD)),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, luhongfei@vivo.com
Subject: [PATCH] smb: Change the return value of ksmbd_vfs_query_maximal_access to void
Date:   Wed, 31 May 2023 10:10:43 +0800
Message-Id: <20230531021043.39728-1-luhongfei@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0234.apcprd06.prod.outlook.com
 (2603:1096:4:ac::18) To TYZPR06MB6697.apcprd06.prod.outlook.com
 (2603:1096:400:451::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|KL1PR06MB6042:EE_
X-MS-Office365-Filtering-Correlation-Id: 371359db-4401-4876-f80f-08db617c4457
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RZ6SJChYd+iu9QLVJCxeLf2vo38om0fHMnr9iP4I+63Cm+VHj/eBCqvXJyzJdbUh8KE0wP4F0bkUWZhCRKQkEYNF//RHp+qJ1aJVZyE6Mj78j9Ps6a5SW6OffUGJ6cTB/iiNzrktXCCredWSbqj7Y7Pd8dW5OiN9zy34akIp02tTZImzp+3MCtcJpKJK3nFoD219bjKxnF1bFoULjo6uqeUHmAL0JQjte2V9WG4oZjRLV2tCEPDjYPTu1bq0vdugpwp6+pItATYEzHEH0NBdF6lQnoYVD+TMPAhUv9e48ROz3a1P2NXohIbYSO/8COBDpC5dmZ8+rV/hqsOkc2PtAMcXrbyqFlaVan4s2a/mV6yxEWXCZdpuVlK5AeN6IKIPwUCL/0Qq2eDuskNtWMAoPNZgHYZVxrZrgaFWHDU7RO6S3jXVOUXK/Yp0lzQMLJepZy7wFNduFMCe+gZhep9P4IhQ3c8XZc5lw879f62RqTHU5BgL75BliasakF1sqQpcH2BsxXKgd9nltTVFe8HRx8oNq29UoyiQHfUF/kt3pUw2tXZnIj0Ss0dRsb6xzUPvyMJQ7cCpGm9ahrKxwt/J5+vofj3gfcmUGobUHdXe/UebifFO+JEO6ct8LhOBqVou
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(451199021)(83380400001)(52116002)(6666004)(66476007)(66946007)(5660300002)(316002)(36756003)(4326008)(107886003)(66556008)(8676002)(38350700002)(38100700002)(6486002)(41300700001)(8936002)(86362001)(110136005)(2616005)(2906002)(6512007)(6506007)(186003)(478600001)(26005)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hPhGJ6cOXBTaQdF/Pr1edcurFaHfCktQM2BTuDFPZQBzj40Z6v+P9bQJs1Wv?=
 =?us-ascii?Q?Js1z7AIF+jk/p46+vIy4GiPPhFUfkJslAI+QJivYZX7BFmdK7C0qZOCCdmr1?=
 =?us-ascii?Q?SXKNiDD2S9+q4sTkxMqZn1WBs7E5sAt6AYhZD0YcZxauTb55zRX+f53tdZ8c?=
 =?us-ascii?Q?kbWec967jRum3EcITyKVs8rJ1RjBEhWFnS0PkrsBWEjliahcoPH3dPHgjxye?=
 =?us-ascii?Q?9muu74BBL0QCTRRyTwHRv19qroupNOJbRBRLoDh3sQwdJdNofg5Oe/PfzrKD?=
 =?us-ascii?Q?LeQJGUvQKn/QP5MrXEnlVAXQ/V0k8yNzWIS0XR5g0W7YFitndpXRzUw/k4ZJ?=
 =?us-ascii?Q?4RGcjlfynm4E5K7U92GX1Sb30w+IIXqM3FHcxGRiPj0hETPHGKm3BRaRjHsR?=
 =?us-ascii?Q?uajnVlcpU/R8QGDcDNGRzJMK0ZCmMThTWNW+xYMQwuWk0WoLcvAZkkv0KP1d?=
 =?us-ascii?Q?/+FAY9Zp8/U82KhtnsdwFIHPLNWwMvOwUTq1KTNMB8Kk7c8m8PSJqCpsGiw/?=
 =?us-ascii?Q?UB4rIUc3NzQMEqwgqxVQbzyU+gwA+mGOQwS7WPbxvKoPoSVlaoF69unLeAY2?=
 =?us-ascii?Q?dDTPswjGnbms5oxGmpqk4uyiPLiSfccFh6Xm3gnzW6yRiEPjZMwvVyZ+gE3Y?=
 =?us-ascii?Q?oIAFnIiBe/waqANunjTpQJM+7XnlnTE6XhSlnxh69YHX/Fn6NMA3UPzVo22h?=
 =?us-ascii?Q?Y5EWr4oCrsc7F4LT3dGpbeo0Pi8sw8Bg+YybhcQU8Pa3pYmcRC+5QZlunL3i?=
 =?us-ascii?Q?5L8rR2mldB2X7Gvkr4hj9kMmB2Vu55Y5y8pgK9rwA0wG6R6DrrWyKiG1DQVb?=
 =?us-ascii?Q?gwVxeHU3ttUgciB0+NUlvcqR3V81uhLplzOHuS6AJ8W7fs+JnuLukZOH+Ntn?=
 =?us-ascii?Q?cx5gBSdEURERJM/IhZmSLFh1ZUCW8P+PSiH7Bnhp+1bT088HiuDR9gDDRN7C?=
 =?us-ascii?Q?P8bRuOk9+R2X2ic0PU0vApT7onDEqzj70gW1yqLQMGdsTUOSPJxDNMjP+ANb?=
 =?us-ascii?Q?qmb1WNKp/xw5hyZ9Y2//KNli40ZpWqRi7ZMFeMMVrOS97UkzpiiUNzHpHntx?=
 =?us-ascii?Q?z+G6yXgf3kabzz4J6C7QCW9dtvOLs5//EQFKE4+Qz191wvNz5Nz71S/wiegO?=
 =?us-ascii?Q?8LM6M3MAgppAoH62xmxbdFuJHCpv+sLC9218ADIvin7NwLGZ+VVWbnGdvsDZ?=
 =?us-ascii?Q?C7JAunLewdW+ROVbC1Kc/8czrz8aulNrIiM8H4krVxFf6ItILdQRbsw2TEfY?=
 =?us-ascii?Q?lwBVEWcTxMgtHAzBKzXY51eNyy/VD23I27jw8KYFArpZ9dSDc0+ULCciu9Bv?=
 =?us-ascii?Q?lq0uCKD+igSvt2Ov8krTIT0LDj2O0srkQh2P2aknnKPZnQ2bEwpBMDIsAPzc?=
 =?us-ascii?Q?GszXJF3Il3XFtO2ALFePSX0cQNc4e7a0xyijM2EEaqXMBueV3IUk88X3Cjhq?=
 =?us-ascii?Q?XWMnOdoobrR5r/atnXaVuqUbTkSAu/kgKD0T63Y2qQJyUFE3Shz+/PP76U3O?=
 =?us-ascii?Q?S8P6YzyaAWn9OgB7OsJRGYqV4cDStuEcFCm8nJptZKXLczcgb27GDznvnkcM?=
 =?us-ascii?Q?rdOG/Gv29eFjsc38CkwiqP0QjmFvi6wVH2QwZiyt?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 371359db-4401-4876-f80f-08db617c4457
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 02:10:55.5742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jqvk6KWdgHkcr26bJQ4jE4ic55WbR8MNJxkvSSOHAD+DbOB0jfc+QSU4kggCXPDrpOvscXXEnx+/11vOg1lL+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6042
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of ksmbd_vfs_query_maximal_access is meaningless,
it is better to modify it to void.

Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
---
 fs/smb/server/smb2pdu.c | 4 +---
 fs/smb/server/vfs.c     | 6 +-----
 fs/smb/server/vfs.h     | 2 +-
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 717bcd20545b..a2cf5df245c9
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2831,11 +2831,9 @@ int smb2_open(struct ksmbd_work *work)
 		if (!file_present) {
 			daccess = cpu_to_le32(GENERIC_ALL_FLAGS);
 		} else {
-			rc = ksmbd_vfs_query_maximal_access(idmap,
+			ksmbd_vfs_query_maximal_access(idmap,
 							    path.dentry,
 							    &daccess);
-			if (rc)
-				goto err_out;
 			already_permitted = true;
 		}
 		maximal_access = daccess;
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 778c152708e4..3fcd849339e0
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -117,11 +117,9 @@ static int ksmbd_vfs_path_lookup_locked(struct ksmbd_share_config *share_conf,
 	return -ENOENT;
 }
 
-int ksmbd_vfs_query_maximal_access(struct mnt_idmap *idmap,
+void ksmbd_vfs_query_maximal_access(struct mnt_idmap *idmap,
 				   struct dentry *dentry, __le32 *daccess)
 {
-	int ret = 0;
-
 	*daccess = cpu_to_le32(FILE_READ_ATTRIBUTES | READ_CONTROL);
 
 	if (!inode_permission(idmap, d_inode(dentry), MAY_OPEN | MAY_WRITE))
@@ -138,8 +136,6 @@ int ksmbd_vfs_query_maximal_access(struct mnt_idmap *idmap,
 
 	if (!inode_permission(idmap, d_inode(dentry->d_parent), MAY_EXEC | MAY_WRITE))
 		*daccess |= FILE_DELETE_LE;
-
-	return ret;
 }
 
 /**
diff --git a/fs/smb/server/vfs.h b/fs/smb/server/vfs.h
index a4ae89f3230d..68fe8347e1d5
--- a/fs/smb/server/vfs.h
+++ b/fs/smb/server/vfs.h
@@ -72,7 +72,7 @@ struct ksmbd_kstat {
 };
 
 int ksmbd_vfs_lock_parent(struct dentry *parent, struct dentry *child);
-int ksmbd_vfs_query_maximal_access(struct mnt_idmap *idmap,
+void ksmbd_vfs_query_maximal_access(struct mnt_idmap *idmap,
 				   struct dentry *dentry, __le32 *daccess);
 int ksmbd_vfs_create(struct ksmbd_work *work, const char *name, umode_t mode);
 int ksmbd_vfs_mkdir(struct ksmbd_work *work, const char *name, umode_t mode);
-- 
2.39.0

