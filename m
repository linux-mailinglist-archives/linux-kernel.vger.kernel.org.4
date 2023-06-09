Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36880729B4E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 15:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241371AbjFINQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 09:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241298AbjFINQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 09:16:16 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2124.outbound.protection.outlook.com [40.107.255.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4DE30CD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 06:16:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tu7QYnoxXQ3MuLl+OyCcxNmjVebhnd9ZPT+n19LbWq1w3BFR4Iwcd8ij4kKSl4mNZ3TszX6oVY5v22nVmEqzdXzR4YsyReJ9MpRdiWwwVujfoLG5kYf89SszzjN4RRZlWKcN0DVQuAEV4FR32p90D1wjvNZpVG03SE/kYUu3F638U+viY2msc5REjk2Iv5vo+ps5lcKsj61399Bhua65vEKnpL009S+JnG1+njW+VNOr9bcRAsET7JvxAatU7QDlsbuLIifog+XQ4S2GpP3KgVilCUgRAnYETW42JT7sFSYrkQ53IFbARjaKWs89CqMyUYiRnsf+BHcvyeSsf0GCig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=umCehp1ddvPRZ1k35Zb8VMKOFF6IlmsBoeOINWWsH5Q=;
 b=H/rqX8XRRR+L2ra7jAG/kHbzHmTZNSOgyPEJ+2ehl4Yt2iqWK+eHF4awngPLIUoFaguficyH3KrXFxs11XQrQtBGnJCicIHjMFNqM8iNUxfUeyT95g+Fwb0K0x674WdtcptcfgBYIGfPzMyFhXNwtFj9f2fxoHfDb2BovRU8ihRd8aFPnNPtP4pQkztxrMsKmw8/ziqd3iMQye2uSJLXfke/cyC8+vGruthW4I9PLTCzuf1RcBQk6edfAUCokN2mr3CF3bace+g3DbFio4byi5RN7sUyKxgfRvfYt43sdKllFfaWd0H2mIg+n6A0rO6WPuVSutQ3uFEa3MXVdVPwog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umCehp1ddvPRZ1k35Zb8VMKOFF6IlmsBoeOINWWsH5Q=;
 b=e5nyZFZRyWXEQGOXEXuHrcsz9VIRhCphDYsfihU9rm/dHIci9M0+k2Jm6V8gdEqlX8Lbx2uzLWKEYw8+TnYDWY61PfxL8RJhixU3DF4lRFSwy/UZzsPI5eHstxMXGzgo30jd/Xnpoz+0rliv5oopXNKpYrwlaVHLlpN+jNFN2PmZ2ubKEkRmlFCy9dbMm24ZfXXJxmxBjn2H3oNlmN2S39GKT4X/anNqzO3cBBJaeV0CjXquVP7anBn38jMzzDplEn4hEQGdV+5Zo5YMTmGEeRmUhzBKZ6r/vAzouqLqJXP+Moc0GaoVikAJWtskjcKWRC0LqCnla/w8kBq7IpT34A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB4029.apcprd06.prod.outlook.com (2603:1096:400:23::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Fri, 9 Jun
 2023 13:16:09 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%3]) with mapi id 15.20.6455.039; Fri, 9 Jun 2023
 13:16:09 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, Qi Han <hanqi@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] f2fs: compress: don't force buffered io when in COMPR_MODE_USER mode
Date:   Fri,  9 Jun 2023 21:15:55 +0800
Message-Id: <20230609131555.56651-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0001.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::7)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB4029:EE_
X-MS-Office365-Filtering-Correlation-Id: e577d4d9-47ea-46df-0481-08db68ebafe2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gg5xYU57LgSLRAac+HIJ6osrjScqTFNILLIUVsjID6bFSygcCKxnv2WMM7Dh0nSBcfY7Ak8GEmDNs5QsfLLg8Gun85E24q611Q3M9IRYUgJQ1NAu65lgmPJVnmY+kUQy/o1921BH1z1sBO3QwFaSIgrh+6xYRI+DWTt8y5BZsGL8Ffk6cvYkWc4PmEuE+qTGvQPXtafeedCzfr17CyDR2hbuNjnhwbo0CzEsG+ftJVN1to/drXvQOxY743NkUS9SQlTprO5tHVgpIA+bBd+EWCVmHoYZdpzypLlOSXyqV45R7+4JLpO83vIgQ2LCb5QmiUg5IUmMqZ4T1O+M6Ff4filRuu4kynLQrJ4UK9O6NpcTd6H3fpVnsw0bqcurQTxYaRTtVv1CuzTuRRf7+1mv3ldoLBgVA3dA0w6fu8gM1mBOM6bcaWxfhKuxZ1UtKQoQ9XJi0IAj2tqDkSkiT4j0EWO6S1wPmlmbHy9DeC8exojy6uBs/RV5UUDUGRAbDu8gL9HvNRf1Pncse7cDavutF7RoSiDoQoY+LSXTzYWKVRbCZ1FmMCD4IQNooWzMjRp3wuU1NsK4t7BVj3eAFir/8Wetg3CeVlJTrk2LgFgNOkS+r8U72l5Du1OlkCfez44Q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(366004)(136003)(39850400004)(396003)(451199021)(6512007)(1076003)(38100700002)(6506007)(2616005)(41300700001)(38350700002)(6666004)(6486002)(52116002)(186003)(26005)(83380400001)(478600001)(54906003)(110136005)(66556008)(66476007)(66946007)(316002)(5660300002)(4326008)(2906002)(8676002)(40140700001)(86362001)(8936002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QFFhz9WzN5PP9OLEU6kaZ8stx7GFFNOEQZNP8J9+GuR1Pnj6EMz0sjCh2vJz?=
 =?us-ascii?Q?V9u0bQltj2O3lP2AUpCywcuVuHJ8icwDoWAZD03asWZPcXjZy5LY9mkTdnaz?=
 =?us-ascii?Q?zL3HH3rFiCEPGN2u0ead8dGfEUWDb4xBPueB6n0Rl6lOrLxlInUSaZTDnm+O?=
 =?us-ascii?Q?f1B1/JWiPelzEH9pHxMi2nJy4JmRygtq53MT/pUhe1EDNkyzzI20nd/O9yd9?=
 =?us-ascii?Q?qlJY/hi60XZpkOMIeo42ZnCKClauLOxYqfi+7BSR9ERmtjn/37fMQay2HVlA?=
 =?us-ascii?Q?0befMbylFNisGhjQ/cJDW7UqsnD4GrXaJTRacllhOH7gyFSSQd/t6iEhzvFC?=
 =?us-ascii?Q?frHzdTm5d3IRhLjiaoZuoYxZbT41scLJPBsl1nIhz2FifKfTaCJFeGtX+a9N?=
 =?us-ascii?Q?0u5U3bYwui5TcIDryVy1ggsCTQEQU8+gAvkf8A0oN9L3yZSnuMWwxoAeh9HH?=
 =?us-ascii?Q?YSuKDvYyMD7nn0+0ikRtybJTtZCUgjksJ1Ptyt4I4khzWNITnrw09TYSrlJG?=
 =?us-ascii?Q?s5y2am/kdWicAdQ0jHwPWOtuFfxMwKNubj/U33WXPxXJZuulI/Yp6F9ag+vA?=
 =?us-ascii?Q?41msmFEtd7a5i2b/evoINHgxnejRyeQu2XMPAntoZDe0eRa7hRS+eJwVr6CX?=
 =?us-ascii?Q?WJ+dZZxeMdevhoyr7FWHqEvGP9hYh1wpPaXJ/nXko0jwNQUK6RUJtEKQrk11?=
 =?us-ascii?Q?htpB+a4jq7oYILrBxPQwmflg9kx+3kFzx7V/C1dE++HB66OpT5FqHSQ+/ZzQ?=
 =?us-ascii?Q?Pwf/tFA7IrjPYagIJvxBqSpXzBsGXFpo3hnkoFnGGIqItZ/kdS4ZRLkrn6bA?=
 =?us-ascii?Q?C3UNu2RLopzA9uqHhhhl0TPPk/7IYg6oHrplabpChVgPIw5Mn1Iz2jJd55Sm?=
 =?us-ascii?Q?7xrNDt/VwMFJPrLgzXLVe9FuQp3Oaz06fZFch41Oh+aLb5C1LnYvGoZXEShx?=
 =?us-ascii?Q?Jq7XCJRQLQhhReIB0BVa9/B90zVUVQFwOk4CY9Ax6l3BNLRu4v0aZK+egw5v?=
 =?us-ascii?Q?sPLFRfMfu9oWBeghXdTwB8BGSPf50vFIrziWvlfzFW0jniyFZ76YSBbs3uSm?=
 =?us-ascii?Q?EvlUn9mzPqfWEDefisWsISp69NY2/sSltPDnNv6ZuSmwJzqOf+ZJoZcAQ1pV?=
 =?us-ascii?Q?GsEArxPYG29+OArG2Ql45E9JkQidQ08rzb/V74VNquAHoxK6dEFdV5LicTvX?=
 =?us-ascii?Q?nKy8rguaJzhSEl6F0gFJfv4X1G91CpnK38vLHfgQIWHF57GVOQ/y2KyivK9t?=
 =?us-ascii?Q?oi4sb9f3mFgYzAY8gH9+UnKLKpW2wrCg1xA6yqGBGLAZRTVi5JKzkdikdiC3?=
 =?us-ascii?Q?5Sjrh4mm40cMuAjRc0261J7A1Ug9yEi56Q7bqLFyi+tt5mW9QO/kGbsUyg7l?=
 =?us-ascii?Q?M6D5O5mSuL0V33QvP7SzYETiLpWX0g7Jax3HRPBVmGDoS6LNhfZpQgiKqnUO?=
 =?us-ascii?Q?S8ConJE/7Bc+z3ujibNFrUKhfgJXpaJii1bK/qccu9t+eC1X/vvZNh7Cp+bb?=
 =?us-ascii?Q?xiahul0whB2diM/c6nEOKC4u5ahp0Og0+4/hl7ioUuLe+tdTV7k5gwTtQJW9?=
 =?us-ascii?Q?B1Vu34MeqJLZo+fCjws4be6AMw2n0P1f8VafIgmD?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e577d4d9-47ea-46df-0481-08db68ebafe2
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 13:16:08.3521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: azduNq+TZL/jYh00dSniVpAwrqS3qpsLVjXOSx08fl+7M629adGlxsY/1lv5+XjTmuV/P3DLP6TI1hVMCHlo7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4029
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is observed that when in user compression mode (compress_extension=*),
even though the file is not compressed, the file is still forced to use
buffer io, which makes the AndroBench sequential read and write drop
significantly. In fact, when the file is not compressed, we don't need
to force it to buffer io.

                 | w/o patch | w/ patch |
seq read  (MB/s) | 1320.068  | 3696.154 |
seq write (MB/s) | 617.996   | 2978.478 |

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Signed-off-by: Qi Han <hanqi@vivo.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/f2fs.h | 14 ++++++++++++++
 fs/f2fs/file.c |  2 +-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1efcfd9e5a99..7f5472525310 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3168,6 +3168,20 @@ static inline int f2fs_compressed_file(struct inode *inode)
 		is_inode_flag_set(inode, FI_COMPRESSED_FILE);
 }
 
+static inline bool f2fs_is_compressed_file(struct inode *inode)
+{
+	int compress_mode = F2FS_OPTION(F2FS_I_SB(inode)).compress_mode;
+
+	if (compress_mode == COMPR_MODE_FS)
+		return f2fs_compressed_file(inode);
+	else if (atomic_read(&F2FS_I(inode)->i_compr_blocks) ||
+		is_inode_flag_set(inode, FI_COMPRESS_RELEASED) ||
+		is_inode_flag_set(inode, FI_ENABLE_COMPRESS))
+		return true;
+
+	return false;
+}
+
 static inline bool f2fs_need_compress_data(struct inode *inode)
 {
 	int compress_mode = F2FS_OPTION(F2FS_I_SB(inode)).compress_mode;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 74ecc9e20619..0698129b2165 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -821,7 +821,7 @@ static bool f2fs_force_buffered_io(struct inode *inode, int rw)
 		return true;
 	if (fsverity_active(inode))
 		return true;
-	if (f2fs_compressed_file(inode))
+	if (f2fs_is_compressed_file(inode))
 		return true;
 
 	/* disallow direct IO if any of devices has unaligned blksize */
-- 
2.39.0

