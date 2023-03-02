Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B92F6A7F06
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 10:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjCBJzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 04:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjCBJz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 04:55:28 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2136.outbound.protection.outlook.com [40.107.255.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA2E1516A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 01:55:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ATuH6nG91DBxYCmRuHAuO5E6CqjdqPv7GlBiLM4cPVQn69heD8r8k7sBuvVKJh2VLedxCQWlqePlbi4VfkTH+iaV5l2Jnbit6ZOqbzhcnxjVp80UFH5KzQ++DIrGfMaAcrx4BVyYBKlaEnXx0+2bBOW+rX+bdSoke4qKmto6Fa0hrMX0z9yBRAvPWhDGNCWk9VY/v4b6qfutwQvB05GXsbW4MnryEXyyaDaVeuW2ubtwixg4aXmA5vPvpv93zbNG1uEdPaNetOHZb8F9BaceRngymON9DN10kIXwdFmsJOwRdcW4HViDqJVRv+R714ln3NCNO5SSIbOgDORwjJxAiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BzFvqQ0HO2a1IcyqY0OGt/5shS2c8LKXTIlpPqilV7Q=;
 b=DuLGDwNeypVkkJBzX28CKYw9ExsN5qZpUMZsBAA8u/TaoW4k6tMNKzbOsdivbtWYEyJAUj+KyBp5FgFj9PRlvYQ6pU+hl4aQdZ8zGN4DnmyksTplAduJWTw5bsdVt8VAs1LZkaR88zmD0utG2bwnizL5e+xBxUjppt7q736iSJh23uTZ6nqGbAag9GrfccC3c5fH+RTjg4rxHfFk80AvxsKKHXDVTJpDBOKklqNubKSXx9brd/Km/CfCP6eEbP1FiTxbRzOGt/uc0HjR0Lc+HS5nkgzTInaSFjPVxr1uAuWVId/+APj43D5ZSU9j9AEjAENz/Zt/9KSx1ynQD8mt3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzFvqQ0HO2a1IcyqY0OGt/5shS2c8LKXTIlpPqilV7Q=;
 b=Ik/vKmeWC0UXTQyWwK0UxBdNRF5mr6s0Uy5wFcAjc9uN0lvKUZbGT7VCmwhQpscTBae4a5iVdKqwuo3u9+XuT2q08bKNw/j0Tnxvh1bZ+r34v60nKOSQXZG9dey1TWoEoxhdwL+adTfSHoB5COeQkrpvlkfvAxslAhisU4dBa2OsNqLzsJq1GyNdgDboHujwIvSuox64jzlFy8y+/qyv8Udpn6v/ULBxZzZxmR4MPWKo732/ESUhWV2xDThonSY1fyF9UrHuTXYH0u6AakrnjwBzZzbjCgbNQAXUy9+B4jmMsUzAj0QPctoh3OreWrl4Viw8seDynO8x5YYURLE0KQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4560.apcprd06.prod.outlook.com (2603:1096:820:81::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Thu, 2 Mar
 2023 09:55:20 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6156.016; Thu, 2 Mar 2023
 09:55:20 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] f2fs: fix to handle filemap_fdatawrite() error in f2fs_ioc_decompress_file/f2fs_ioc_compress_file
Date:   Thu,  2 Mar 2023 17:55:09 +0800
Message-Id: <20230302095509.53720-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:195::9) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4560:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fa765df-2543-40a7-2f1d-08db1b043bb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f6HiTdryc5HJTsjn6y8VK1wzHCVQW7KMyg9YruShkVM4B89shDH7fX/bkJRUGgZSNaW6lqRwc3c5s9CWrlpRT0hNN3+QkOyvYJh2KeLY700yN1QC7R9pQv/2zryqFcQ/ZVx1WpE0sHp2xKWmtcLRb7njmPz/3FZ2FOt2ftTEOmUGz3P3X9cjSa4y2+IHBjn9Jk9HA6H4ptPPwlbqzQLDKB4si6EcI+NKPgGN7ucQwUMkJIum84tNpkHGf01nTbfOq9gIraK/yBqik3Vnzb8KR+tCPPKw6gtnZHcb8MpDyMrsqJXqpQWQb9ZArRg72cx0zne9dOC0fliS4LAMts3L5yTeS2MWCLj8bq7ojMtWxtneDwPyg75gu2l14dtjVD8VzY0gEi/C6l+v9WXgoZa1aV3JNS+AAr61R71hQ4fV+4TBMJ/ulemU9KcZOqPzlAqTF7mcfmFEwWUoNZK3UCzae0N1CYsXUkd4R+n4PLVUdlNb6TPY5Cl23baJgioAWDSGms9AGB4GAsa/rdfcPWNN8VuSiUwBexpO/1fngFA/n3msQUbz+DypOF5prKhUCL8DnZHeYwdSDRilRzFUpcx22mJ7aF5J5qNBC8SKVWvcq0uXvewEQHyI/F+nTIwf/OYZCW4at7o6dWdZp9LYi+1gBUQ4Zjp/6gbsqX/NJtMQ5XW+dy6XDX+u060ehnuWLev/e2OzyU7WT4NyvVBSt4kGcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(451199018)(186003)(66946007)(66556008)(2906002)(36756003)(86362001)(6486002)(478600001)(6506007)(26005)(6512007)(1076003)(6666004)(107886003)(52116002)(316002)(66476007)(41300700001)(2616005)(8936002)(5660300002)(8676002)(4326008)(83380400001)(38350700002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lW+ajp1RxE5zv3E/7o3OPO7+wjdbgDu8euSjd30W0TB1zkk+AxdnfaT8ThC6?=
 =?us-ascii?Q?rUSJJOmCvEPPCxcnOB8WjlB8/+qmj+f5yOZawL55lZ9ssU1bDS8hxOEv+a65?=
 =?us-ascii?Q?XfJQcwOtnGm0Xk+0IHhNtE+B4dkH9ggs1D6B4q67Udr/38EZjrc3l+1Z5urW?=
 =?us-ascii?Q?kd730nl42g5t2ImWZM96BvC/91JE2VXTwGodlooMpALq84BYT2cR2vatbkse?=
 =?us-ascii?Q?ZHftE5UyxqiGf8tl7KqTRnaDkuc0Gz6mR5riSPyoEqSbNxa4rECf2UgWZCTR?=
 =?us-ascii?Q?0SL1Ny8uB7VZiE7jbnZyS20+gjH3fSipHLn9kjkMu8N7Ik1mTdZWT/Bm+apo?=
 =?us-ascii?Q?V7mzWvw5bTcyQimvpMjlVMw3JXX65gxUl5hmyiM+bd3geRBp2cz0xwI1g5Ip?=
 =?us-ascii?Q?pkMm/YpMdAtKpK8WZHIY8lUS3pHDa9PeWpN8KjFp8xUth0r0bkk4YlUtH4/e?=
 =?us-ascii?Q?sVO/pqZ0CLmb/+/QvmZMdIKjdUWrDyVBv1Xw/1kexccOGYo3qqTc6Tu1ACCl?=
 =?us-ascii?Q?3Sce4N0kwcmFIcu1JyKd9geHsA0GI0teqNKgxSJIZqPILYouIlK0sUmz9+lX?=
 =?us-ascii?Q?jBjAHABkqB/ByvP5P6OXIndFisny+GIZ8EYaJcU3C/IVx2JtnPF7V+adPqUJ?=
 =?us-ascii?Q?jInqO29/ixyP1qtQ2cI+7PKhqg08MZiCT7M2WkoaT0kzBMJAzdapFBpbLx7V?=
 =?us-ascii?Q?sHRDKWWIH6yFkzy84KZcOLc5n/oRaUIxVlXhV3csIYu0VctQil+HLp/M+Pxw?=
 =?us-ascii?Q?3G1FAD8dtcC2upFidHs/Q8bkM9iaQtcWyRikWU3mHGpT3yKZuPMxGqRAs1dY?=
 =?us-ascii?Q?8ONordYRe/741gbqgZGR8JgbL11HmOUB+C9+xqc48bOpbNKsk/TNf3Ol3U14?=
 =?us-ascii?Q?D9VrO9DhN8idT+ubQXSf0H8XV/lyyf8SsxcqZj9ogxfDApJ2oOxJPH/CX2aU?=
 =?us-ascii?Q?W/Rgi4cMEz9NTrQFVDekH5wXfnY/RuTnpprvPD2ryNDdgvpgWkj/RvuPp5u4?=
 =?us-ascii?Q?yCLPkqs1iI8h5j8Hp84oqvSLicj9kJ3cjtkySygjUmAHj2DPvGKJP7KldoWD?=
 =?us-ascii?Q?BAsxtqVPQ6Vlh+uRVLBasOUuJTUZY0XdSQvsJNkHe8BSX10MLiqfW7mB3Gm9?=
 =?us-ascii?Q?rcAX2tOAEd+hzn36A4/QrQ0eBWAGtrq1KeK13UUb5HeSNH+O5yZ1/qeKHmOE?=
 =?us-ascii?Q?D0te3g960/98sFHQojiP8hGVGMTiYLr0vqpJ/qUcwJ2wIHY+zpN7Lj6XakDu?=
 =?us-ascii?Q?Hp2aYnU7dDnvKEm8r6u2WFEP8XBXFpNpR9Mn5wRS6x56fLAJcYPr+F+xvS8F?=
 =?us-ascii?Q?4QyfaGb0R3EucS64iV9uwG3R3/ppO2PA2Fgii2TeEEjernxJah9kdL3VyZxH?=
 =?us-ascii?Q?LWcmeE/X9lKseL4+A00OdiohVWStxzGZWA9ijEr1Kwl5b/9PuTtLPZbt8o8n?=
 =?us-ascii?Q?9V5c5+xalE7jS5CewqDKNmEO2sbasS1Cs30AkiQt5OxiPMGGkTjZ/DWSBj+N?=
 =?us-ascii?Q?UtshS1cXi7vshfsUh8MH7FTj9AY2Q30QHSu0y72ozAeWar71G8X7c575anIq?=
 =?us-ascii?Q?GcvIf1GQAM8sVdB6M1waOiid749DW4ESjiu52hG+?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fa765df-2543-40a7-2f1d-08db1b043bb2
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 09:55:20.1221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IMfYY4zOtgAlfStUAhIRS9Vi8w2y3u7vYw0fCuuG/xU2YvakzOfcmFidNurrXMgtnL+rUjSDXyfZfzBOTAvOsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4560
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems inappropriate that the current logic does not handle
filemap_fdatawrite() errors, so let's fix it.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/file.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 15dabeac4690..6de2f27c4eec 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4062,8 +4062,11 @@ static int f2fs_ioc_decompress_file(struct file *filp)
 		if (ret < 0)
 			break;
 
-		if (get_dirty_pages(inode) >= blk_per_seg)
-			filemap_fdatawrite(inode->i_mapping);
+		if (get_dirty_pages(inode) >= blk_per_seg) {
+			ret = filemap_fdatawrite(inode->i_mapping);
+			if (ret < 0)
+				break;
+		}
 
 		count -= len;
 		page_idx += len;
@@ -4133,8 +4136,11 @@ static int f2fs_ioc_compress_file(struct file *filp)
 		if (ret < 0)
 			break;
 
-		if (get_dirty_pages(inode) >= blk_per_seg)
-			filemap_fdatawrite(inode->i_mapping);
+		if (get_dirty_pages(inode) >= blk_per_seg) {
+			ret = filemap_fdatawrite(inode->i_mapping);
+			if (ret < 0)
+				break;
+		}
 
 		count -= len;
 		page_idx += len;
-- 
2.25.1

