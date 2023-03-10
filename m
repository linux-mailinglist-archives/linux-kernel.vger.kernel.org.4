Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2BF6B3482
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 04:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjCJDIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 22:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjCJDIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 22:08:44 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2095.outbound.protection.outlook.com [40.107.117.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B5DE1931
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 19:08:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/q/ber3wIdI4G/AAgqk7EyokhVxLA5yFtKJfBXfV4CHCDH6mCzWpklZFjw+YwDIraPCRW0KHVaz4A2+wmaDtfEkTGWYq1kmWVdZEOoHU5jAnrqV7GpFCiQYdtaNvk45f14bpcsEBrdx4gEo9gN1QfKWcKjoY9qnrUG0Bz05XDTa9uzzHnLe+yc3aN6j1GeXUU95B2PBEIlHHez7aimR5PhygZvt0RyI8j0334G0Tg34A9vpr3JlQm4PaPHKtcfo/YMtSl9AHkoUh9VgoKazrvPk6wUl6xiYLVMO1cJyI/8JrvE+8sUpg/lpAr1wwkQanXDUdWFi+WOo2DquslseFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SapfSKyA5hjeA9Tpi9nggPtAuZODvYJOSu/24Rc8dH8=;
 b=dy8XVRCXqhvKtYClvhtdLTayabXPgMQbI6F6ToZRxTLSm+twlNYPpAZ1DyWzb7Ff5/ESqKddoxppHmjTpAzzQW43vWl3OBXCcIVBKRHspBl27MJ2LI1jRGDxQf8RHhgLlPxJai1DE55XaewlZI0zPxO9ntClGK/xsY75KGKlCte7ES9CzlzeJ4ywfJDmoN0n4Y1BjOuy2Yh8KFXlB4NrdbV7iVxYzyFWbTdtxtrbgkbizQuHf/U5QbTnGnSUZiYSIyabL+ClcYzrYw56Sd4ZY8iaR1clN110G0tMJUbTF3M1Fj+dK3qAOTi7g69eF6mCwjs9Ui9eBq/n8Gak4CPQAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SapfSKyA5hjeA9Tpi9nggPtAuZODvYJOSu/24Rc8dH8=;
 b=qeZWkIKGnA/aY6Q1YywNWXsBVNLkQbgxh7emPFc/1Wa4OP7kuzm9/8IQiEAmqeal9CLHMBf0BI5NnoLgbL6sK3Z9XjxDNZ89/Ucngz7Pk8wN8Zw0LkL+jrqJXgXkx+sM57CLTa57bRJyIKyqJoXAuCz2mPRbj6Dt+lFar7lbW25OoW62sW1FDT9jRBEyJSuWRtOqAGwRNmBlZSg+S2LhlWndOVAqWfaF2c4VnNSgMU193CNo9GEs2mAH+TsnhNetoCayaikQCqG3s4DbBTH+VA9wOzWIWRHhBT7Cg3QsbPMI/6xa2WSH8eK/5eukeyctoLozkSREIbDTJJDnXybbcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4275.apcprd06.prod.outlook.com (2603:1096:820:73::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 03:08:33 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 03:08:33 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     almaz.alexandrovich@paragon-software.com, jack@suse.com,
        dushistov@mail.ru, brauner@kernel.org, ntfs3@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 1/3] fs/ntfs3: use wrapper i_blocksize() in ntfs_zero_range()
Date:   Fri, 10 Mar 2023 11:08:19 +0800
Message-Id: <20230310030821.66090-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:195::19) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4275:EE_
X-MS-Office365-Filtering-Correlation-Id: 2094acc3-f270-4212-97f6-08db2114bb9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hCUfcQxErox8Tyrpq6N62DFDvoXUJKgLaqAkQciRoRmVcXgKvUpe4Q/WSLboCEapJs+bOkj2JmOXmaqsTY6XNKDZz5HvTEaE9uulEhR66xi7KjIYvAJYs4kYg3nZgcGZIns9YYQaDYtwoGsIFjEJYaDXcJJW7LipypFigT3CeroY7f3n8aPY4sczBDoUVP3Sbz/uw/2odG0D+wCTMZS+ttcpUvxia9+Vq7o6nfzlVUNlRendrUxSZ/D/flBg85gHMCo8Drvhm2fCXY449Jb/x6RllaaTRfi8/hv14NijMLjS6O4hcgGxJktsZb9d99o9pac6bp7T5b5MlNVsKdsuYiYxCZOPdBlXWwDNtiHWgHHYwxdO4BYlzEGo3ULTAVd/vuavr2n9dxg3iGqCscCIrwfEwww4D149qIKRw0751JhA1hTk7ayzBodEJ3WoLaFMtw/AnmHWujODdvHtuZo8OIgM3L3yj4kDEfvrmk3OSrEmKpyplCHFqjQJ3LdA0e3HcYA+UDvkrAzKMRTiIH7S4eBq0wLuW0+f6adLom6BIJmvefE4Q8niLDiFlMePlKKUeWOMMnes9zacUp3f/I7/s4XNde4UoGIMNq+z4r0zBWA6riBX6jjJXk9ngfk6J9/3MVVY6R+vW9Hs6oXykhq6RrkGr07D0wx8hTqYOitABufrR1wZhd3h7jZ3vnniLnUAt4matyAY3DKhH+dX4gGeVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(451199018)(36756003)(5660300002)(83380400001)(107886003)(6666004)(26005)(6486002)(1076003)(2616005)(52116002)(6506007)(6512007)(478600001)(316002)(4326008)(66946007)(66476007)(8676002)(8936002)(41300700001)(66556008)(86362001)(186003)(38350700002)(38100700002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Bjiue+JRBlzWhuqnjm8kfq4oaJnWJrC4q8hYVF69bcbWwUhTkgIX5U637sFd?=
 =?us-ascii?Q?SRMINsU0f4DNy4CbTeON6Qgzc9m9HMoMmt67K9+dQ1gU/IeG0xBdIlJjyqAa?=
 =?us-ascii?Q?lBJU8bN48PZc5O8fsyundsnj1jSL2z4oBNXHf9QuE5Mz9Dz0fQTor6aJ/D2D?=
 =?us-ascii?Q?HIcYYPfN5JWt+Yit634F0hocgwqR1aokFLqBQDkMBHpOXGlVd6gUlQwhFdQ2?=
 =?us-ascii?Q?2P+ICoVL5iMkGbaInWUFJczIY0UpElwykTOMiO2iu4l70EyzUjY9NNGVCFEm?=
 =?us-ascii?Q?CI2btw8S/8mrbISkZE9lmshlQvnUMjQV2uDU8ET7ltdl3rbcfAs0Fr2/GpPs?=
 =?us-ascii?Q?g94n1ceKdGcx+YeKf36cwhziAWGdmhRA/4LcbjbONc/Q7KHDnQin2F+EQdjI?=
 =?us-ascii?Q?/9E5vLQ5SrUZXqMyVKEfsQbRp73B+9CMWEFAzDNmFpeKxI7lceAtTrosPIGh?=
 =?us-ascii?Q?N/nZAWmSUCYbIeJ8eggt02jg1J0jJhoJwgG3TL+lHnssCRYpnJ/aVyCTeTg1?=
 =?us-ascii?Q?KWpNw13X7aSULzt46rVJStD9vniXWWXv3e5c6AEZSLYVZFcIB9bAnc3UG1tm?=
 =?us-ascii?Q?DUAiZJfa33lZCz4Z2+6C8f0wYQlumTh3uN52u7zmdT2vToW7KtMmqhgIpHiP?=
 =?us-ascii?Q?ElfhQIKXYjYb3mEYOgifKGf+n5VFu+SU5irZLj7JXmFUWx2FGgs/gMwakQX9?=
 =?us-ascii?Q?87c+jSZegGFgrU1uZaBsV+bZGfbS/tTmXLvqozQVzZtAtnlKlNDg+IrWf9oT?=
 =?us-ascii?Q?E2KCz/bL9ugTL8wMsyguRkvsm5nlf8o0b3SBI2RxXIAF/bF2buy7TFQ9Pqyz?=
 =?us-ascii?Q?Db1+UNkTKUmdJf6/nKwfpuDy0V0MvKFiIJ1hPhSAMuUYScKfKSAGNcZFwiMR?=
 =?us-ascii?Q?DXPHUmKhg15+s2Cg//OvWt/7Xpul070HNCrsYeRvg58w8JQ16pH1yPQmbKLd?=
 =?us-ascii?Q?dSVF0xPcebvfQka0I0xu8l+ESfyWDpfO0If5iaFt8xWaJVju3mWGTefp40kP?=
 =?us-ascii?Q?rgQ/g02HKwLGy8imBXtDpoSPGMx42yCL0B1ovkYqlQKhMLGEzxfb3cnIBUb+?=
 =?us-ascii?Q?5Uua5VXYu/H9i9BFG58PpkvGAmnLBZdOBNQf+VvrZ/v6Pe6jBb0pNL8oJXL6?=
 =?us-ascii?Q?7NWVIMnE1Qt6ZnQmV2BuwbCZ7C28/Lt9B4xC0Ey//+1kxtEKrLaT3yl1x7L8?=
 =?us-ascii?Q?fG4IIh0tZAmT5bbOHeB85SBtEIoFM3MYfn3ulRAuPQkjKYHb4yA4393naA8P?=
 =?us-ascii?Q?bmsDVYHwdvHpaMu/DYl6WNTPBvy/x3yWIfwiuy+PN8A3wUw11Nj/Y/kpDXHU?=
 =?us-ascii?Q?xhAqyGbuqGDhMi4PhRBfM13Ja5fktdNvvHxzmagxA5GC2OzditGWvCPb4Emb?=
 =?us-ascii?Q?waSQ9zPOG5XN5g6bnS3vxjTltG5jI/wWcxnUDU6eIPeCRhHKjIhxgqH/LAos?=
 =?us-ascii?Q?EFZTbw8NLFElFZKRRH8BJ1U9tt0C+jBJJAVDzZKbejQjkkkkpCtFooip0lqG?=
 =?us-ascii?Q?DdNeu5YE9uE5PZBzI7Jv1bacjxNrumIeO5R7UbdD2BYQBa6h17r8WSfOBFpG?=
 =?us-ascii?Q?lnLoaMthcmlrfhT6iknghWYGW0cCTU8aLmI5ddVo?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2094acc3-f270-4212-97f6-08db2114bb9a
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 03:08:33.5601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZF3qKpFoCdp8Y1cOgTgWMEzpWQyPPerO10Sv6KN8YUqa7+Iujlu0tp5sikcCDD7GXrLiHwF3eKvHCWoWhZtptQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4275
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert to use i_blocksize() for readability.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/ntfs3/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index e9bdc1ff08c9..9d6ff29de441 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -178,7 +178,7 @@ static int ntfs_zero_range(struct inode *inode, u64 vbo, u64 vbo_to)
 {
 	int err = 0;
 	struct address_space *mapping = inode->i_mapping;
-	u32 blocksize = 1 << inode->i_blkbits;
+	u32 blocksize = i_blocksize(inode);
 	pgoff_t idx = vbo >> PAGE_SHIFT;
 	u32 from = vbo & (PAGE_SIZE - 1);
 	pgoff_t idx_end = (vbo_to + PAGE_SIZE - 1) >> PAGE_SHIFT;
@@ -192,7 +192,7 @@ static int ntfs_zero_range(struct inode *inode, u64 vbo, u64 vbo_to)
 		page_off = (loff_t)idx << PAGE_SHIFT;
 		to = (page_off + PAGE_SIZE) > vbo_to ? (vbo_to - page_off)
 						     : PAGE_SIZE;
-		iblock = page_off >> inode->i_blkbits;
+		iblock = page_off / i_blocksize(inode);
 
 		page = find_or_create_page(mapping, idx,
 					   mapping_gfp_constraint(mapping,
-- 
2.25.1

