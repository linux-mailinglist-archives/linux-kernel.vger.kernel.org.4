Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553F363666E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 18:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237965AbiKWRCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 12:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237847AbiKWRCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 12:02:13 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2124.outbound.protection.outlook.com [40.107.255.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545446A683
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 09:02:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHf3FK1IP9qlt+2EoEduIlSFp4B0WFCzCfdoGMjlMjG1PrcaOnGZ90rmRHASs6tm5uzzV+PMGEhZSgzp7VWMhx4w1S58jkSGUpKDdx0r9xpejkDHPTh9qh4Y4CpH6iut6jKk3KmEWttBCjh77Mb7LurOGkk+xgG8t4+2O4PkDECiYLulCE8f2Fs7K79AczpaTOgi9OV61DDusgBlygysSUU1/kDqTQ+5BnVZz5aTuu7Hr+Z6tSYuiZCOyacTz9dbnfFCeoCSIdT3dSwdqwDZEAEv4+WipCnHwy7od2nIsj3quYbANTebPJzUaiMFZN2uLHicJ5fZ2aKSPrlOb3LLVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rg0i0W5xrwdsPIA5Ur0h0yqNLe6MEW9VThXh36b9KOY=;
 b=PZRXGCWdUl3Djk5EEa52BKQKnirEFE9nMDhFPIpqoUgjcKvjMk53O40vynhCdX0VdJU0TG9gsMBm+Fl3PYero84udWi+KCIApW+XwlBXKEssV7srMgHPE1FkJvAs62OjYPlcEwINDqwH1QIN9MKWmJ6YFsgpLyk5AUF1X3bWZIhy2kJJ/lwY3rqphO46ZmIHjl4wb8C0wpkIM4AM7WNU3F6HL81jFDLe8/z+NcaWTi44C1LDTHa3hwMwiuPTQyDE3s0Nv6Bcd8KQmHgjddwEXTmvmK3UTlh1yj3QCeNiD+YNCYu02OkB13yM+fIVWoo198M442i6eRwz2JXWNsBZuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rg0i0W5xrwdsPIA5Ur0h0yqNLe6MEW9VThXh36b9KOY=;
 b=OpID7fjJeTgtFeiVvjNWj9OYdvoMqzKLlqZxcgf8//fAi+Ent270oyBs2hDg8CQgw2gl9zqSpMc8GvsHPw/sVvAsyD6N0Eq+fGsz3HijbhLJlNQ2iK0Ruz3xi5cx1iuHZ9+9nJkJyZqlOgGI0rAmZ82znABmUYBJlGmi7unJ1klJRCVMgzxC03B51DUYgytvqo5dPjNMOzfLNbGTgIBi1tzORMXsraFJNesryX95kP7Yy2znVbMsgvLN6a3r8Vp40DX+hehqKUJvKugQzejtLx06gNB8QTJyw03dy6v5Su3CDsdJpwLACCsRD8UKrsr4d1u1vqDzJVMJQTjU6HciBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB5368.apcprd06.prod.outlook.com (2603:1096:101:64::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 17:02:06 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::1230:5f04:fe98:d139]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::1230:5f04:fe98:d139%7]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 17:02:06 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] f2fs: introduce f2fs_is_readonly() for readability
Date:   Thu, 24 Nov 2022 01:01:53 +0800
Message-Id: <20221123170153.15888-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0240.apcprd06.prod.outlook.com
 (2603:1096:4:ac::24) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB5368:EE_
X-MS-Office365-Filtering-Correlation-Id: a7bed81f-5264-4e27-df99-08dacd747394
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C9H2sJs9Cu+OCNb3UFSmxFeLOyijzKvAmIHtQf4fkm+qRZGy6xE25GNAObkHPb7PWVYrU6vsugiBTIFuZHnehIoClzNEDMhnCOfSpWSNLQRI/BrpjsqyJPKwvkW3TO8HSeDDQi4yVpS8iD9+bUBvArQewsa/QDro9/QO/ebzj4ZaONzxtLAWp1JbSgk7CRxDIa+Pmz8PKT7eOhVnLcobyrJsYH1dB0RewXdvrPmFMRCAzT5Q3gjXlO007xoVy1ysWx5FvaIRWcR+C33t6TpFqzrYamlEzASQU4hxbH8qS+WOPgzKGFM2CRc93tWmV2JowETG7XGLWQzJCuxi3MgSEqV6/QQ+uDFg88bxQXo2XYvXNrpVd2yjPAqm6ajmBGZ8dK2iW4btNYIKZ/y4hbmWThaaRwYDHGewXiqs4nh3Grd1YxP/FUFDRK+fmYxABPJMefEH9NVMzxdPomhcdiV/P13y22E+wnpxbGoHTwxjQmLiu9Z1HULeIgsNsKZgJZGkMFoBiLOcv4mtDdxfc5nMRt1BbC+fH30oZSBd3HfpTIGqZJauJZ3VSCvIz4VlTkyM4RY4//ynhLO1tYl+X5bjjgRbexlD+4WYcTyjh0rhizsOVtHAGIBU6gGME4/JVkIxhShBfMjOH6ZhSXqIZB16/J1Nhdp65dDkpNr6SYXEnAhv0p7eHwBl7Y1FZnnGoSD4kmwJ9hghHb9wCAwaPIK5YW8yacCWzghFb6Lg6TzxVd4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199015)(36756003)(38350700002)(41300700001)(38100700002)(2906002)(86362001)(83380400001)(66476007)(66556008)(8676002)(66946007)(316002)(4326008)(186003)(26005)(6486002)(478600001)(8936002)(5660300002)(6512007)(6506007)(2616005)(6666004)(107886003)(1076003)(52116002)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EtzF4B+kBRbZf9wQ8ZzMLEcgWHpBWCx3UDlXRlvvSGuqGRVGrvvKD4iVzKTn?=
 =?us-ascii?Q?TeBmk6rPbLJS0/7/oerew0E1jUSqIIdgURkOHl890N0LJ5jY96eOBgciwdGp?=
 =?us-ascii?Q?3jgmcEkex8i/0UAbKEtfxWcPb0TB/wjZ5N/Ngu0GfeHJewj96aslAEhwRObR?=
 =?us-ascii?Q?7axOFSnikgn939pAdYDDQt/uEV8yl+Zh5SlHTuV4i+jt9iA9zjFrf4GF+Xz+?=
 =?us-ascii?Q?wO0YWalJKidomH/BapdfQ6EvS9mIrBnbDAVV7Iuqc7u/YkTRklakgo8gFfIg?=
 =?us-ascii?Q?POy2uWEzCJ3EjgsmRCGf7RAaTNyJOrjd+prb2T8VKrkYI1LyRW2X7v4heM2Z?=
 =?us-ascii?Q?IM99b2omIiV8hUs4QuE0mHNr2M+xetICGWc+DGQ66Nq1eMjcwmYU3rBHqjPJ?=
 =?us-ascii?Q?cOXKfUoZWQjEU+zTn/cMC9GnCr7ic5A3mZdyKSvoaJgdpSBcrD9AKyLVPnL1?=
 =?us-ascii?Q?Em9LUHjcGcGQdgK6k1ABWZeqnExvLCRoFzdNWUrtStob59PTDRKuxgR6AWPt?=
 =?us-ascii?Q?X35jY4LJoaGk9W4omv0Q3TOcpAnu1TJG2b92anLWQ6Sjecmd9xsUKyuDiJ9D?=
 =?us-ascii?Q?ytXJ5BfpOxIab3AO2ZeTf1FlqMN0pFAvXp2Zgs7wG1hZsol6/gyzLqOEe+xJ?=
 =?us-ascii?Q?tewljRKxnqvzzEvGrV3HJlA85WuRvYJGqmiF4pDJyJX7FO5dr7l/fLdQfNBa?=
 =?us-ascii?Q?x1ln194v3f8aEB115xUBvi0U2cC71oAgaggJslGUQgsVkHsHUA84avIGX2VJ?=
 =?us-ascii?Q?MBzLeOKDuDtCup0S82ERsfR5N0dcKSpXtacSyhFiEo2nm0tzZgj2EZoSFIqS?=
 =?us-ascii?Q?ujOilsM5jqlW0OwcrBLWg0+zhugnKV4BcVSIpU/i3fHvZ/O251oIqr3DQuCT?=
 =?us-ascii?Q?VEvafaJg3RA59N/JmCAcww4usAQHfPFbpSIS6HU48MMY3ljRWK6gfTRXXQML?=
 =?us-ascii?Q?mgKjjZL0eEHW1b6ftOTD/U2yBGB+YlzK/yG7J8ObqtOwNIxyIMeAW5zgHrWW?=
 =?us-ascii?Q?Jcz/FbXChuyeDiMRAFZypbOTr0MqOQ3AZ7mE3iKsqFpbpQ0rzuJOfCN6Dww2?=
 =?us-ascii?Q?BDqmGaNJWiMVJp3PS4RBZcX3o7b7BZP/wDaqwUjeQThad+mfX1IBE3Y2mwDW?=
 =?us-ascii?Q?np6tsxy2vIVPR+nQd2kVInW/579Pavb86j9wFzUKrSvxWU8nQxz4jo3wQd16?=
 =?us-ascii?Q?giDizf7ar/1mecV1v59chCgnmDSqEnFwMmcDYmigcWBnkI7bIAQrgxZxeWtU?=
 =?us-ascii?Q?ES7XzX/QMeh3MboJwu1AfQHbNBHQZSjXG3R/DkhZsgQPGkIXiOgdgojmjxgL?=
 =?us-ascii?Q?+XwAVwAVL3jjURfG/Dg7ysCLyGGk5AiLWdjZ9Y4FCUR33o72NWI6cKLyMM7Y?=
 =?us-ascii?Q?NkCQS1YGYmQswBkICKpKhKu/nbpqeybxEigGyhzK5C3nEctLTCvLwMF2xaUR?=
 =?us-ascii?Q?thAZqrybDN5lilxGqAuZS0SM9BwswalWOZjUrOtHg3PjY10g9YQJYKJkGpTH?=
 =?us-ascii?Q?uwSqjHK4S4eSsR3hPXNpurz2TtDVBqJprQ7r3YnL3UqHFellVssUwnSzlA0T?=
 =?us-ascii?Q?rnKyYNnnJUxOoS5XhOp5MP4n9qE/oRZJhMKYdIc/?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7bed81f-5264-4e27-df99-08dacd747394
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 17:02:06.7270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jh8gKV1VRG3JxVfqLvTnphSrfZOMKuzfaASOZx2SM2P0PRlluso+vI6XYwEzrf9K4OYfnsUTvDUoIjkaM6iy4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5368
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce f2fs_is_readonly() and use it to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/f2fs.h  | 5 +++++
 fs/f2fs/super.c | 5 ++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f0833638f59e..efc9d6d7b506 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4576,6 +4576,11 @@ static inline void f2fs_handle_page_eio(struct f2fs_sb_info *sbi, pgoff_t ofs,
 	}
 }
 
+static inline bool f2fs_is_readonly(struct f2fs_sb_info *sbi)
+{
+	return !!f2fs_sb_has_readonly(sbi) || f2fs_readonly(sbi->sb);
+}
+
 #define EFSBADCRC	EBADMSG		/* Bad CRC detected */
 #define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 31435c8645c8..39c6be61450e 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1353,8 +1353,7 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 		return -EINVAL;
 	}
 
-	if ((f2fs_sb_has_readonly(sbi) || f2fs_readonly(sbi->sb)) &&
-		test_opt(sbi, FLUSH_MERGE)) {
+	if (f2fs_is_readonly(sbi) && test_opt(sbi, FLUSH_MERGE)) {
 		f2fs_err(sbi, "FLUSH_MERGE not compatible with readonly mode");
 		return -EINVAL;
 	}
@@ -2085,7 +2084,7 @@ static void default_options(struct f2fs_sb_info *sbi)
 	set_opt(sbi, MERGE_CHECKPOINT);
 	F2FS_OPTION(sbi).unusable_cap = 0;
 	sbi->sb->s_flags |= SB_LAZYTIME;
-	if (!f2fs_sb_has_readonly(sbi) && !f2fs_readonly(sbi->sb))
+	if (!f2fs_is_readonly(sbi))
 		set_opt(sbi, FLUSH_MERGE);
 	if (f2fs_hw_support_discard(sbi) || f2fs_hw_should_discard(sbi))
 		set_opt(sbi, DISCARD);
-- 
2.25.1

