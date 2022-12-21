Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C996536F2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 20:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234668AbiLUTUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 14:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233664AbiLUTUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 14:20:17 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2112.outbound.protection.outlook.com [40.107.255.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93D627141
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 11:20:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eSImNqJ9VM5LeThka0V5HF+oFr1XSFaamYGKMD0NVvYtkHqXm6wC2DHyVG8BlqFNkZTTXCYMBxKDNu2iQYJZMvgjGRVgXTvZa//zD9WSVEo7/B5HS5b0I8qghnmWAVHKUChexl7haCFeX9Hm604/R1Cfb9NMivPkOWD0YTdCtjSwSyxQGKOipDHN+zRgVPXs3tSq5PWpvqZ69nHFEhk0Y/BFVYoBA1Yj8BF5YgS21MKRAgG4ZMc16d1NCUIPJHtC8vWafKfN+Hq2XW0xi1T7wpNAdWunGpgqSewt010/LMtTcco6pCfFsU3GhDNY80yvo/SUJIs+rpCi5KQceJISPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=manLWJpBlusLkA5eGLaVDFvtlKx1XkR7w9uvnNCgAlk=;
 b=XNSjVoA4NXvzEGZrruHULuExJimy5lahN1y/KU2jVTdgb/ZchOSSmezqkDy2A+L4/GXTR2LV7clQ88XeXOUxmjyODGXH9X/edVMGOQXUTrfEvWNYLoWDl7JFV1BMlrzj/VGZB7wHnluv5seTakXZcvI7g2NoBzSjnkU1BvApU388qa9PGPM3aDT8uRyhB5jwIj2tgGBZQKvaVrVUnYkGl5dIEKhTar694PLdhS38tACWEzydQiJYCAyx7UlANJ4+5PmDFoP8D8BSBcVPNC56ycMntkpaLVoZVELKGUUAHnumn2XcsADMuyo785HVCOZhkttnb9+UjuR/1VOh1iyLrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=manLWJpBlusLkA5eGLaVDFvtlKx1XkR7w9uvnNCgAlk=;
 b=Da0Y5g786ZkiGyxpaqY2dlTqxR3/KkcnrF/itZjoSLcvdLws3TWhaXHJ2FZlpUpWupIVRydi9mRE355LAhyJSuL1hJWN4WckG0znwtW543C66wu5YZWy8D21IWFI6pQnMx6OcqwTTrf8Tq9pEQEHAn4kw+QrWjbVr50HHm4PBOmWaSni47AceSAGQzGzMuK/WaaJR+bbtFKE8x71ZUjQZNcw0HHWNQOFBL7zv2wFcfwDJ1YGoWb+Vx3HyE+Aa1meskWhA1l+vRTbrx15KoUGC3kXLs3bUhoEoZJiVWZX5k3c7IOH4Aa2RDy0pA7/cAJY1Tbk5NaiQfrIYv24bFbZbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4106.apcprd06.prod.outlook.com (2603:1096:4:f7::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.16; Wed, 21 Dec 2022 19:20:11 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::ef03:cbfb:f8ef:d88b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::ef03:cbfb:f8ef:d88b%9]) with mapi id 15.20.5924.016; Wed, 21 Dec 2022
 19:20:11 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 2/2] f2fs: add iostat support for flush
Date:   Thu, 22 Dec 2022 03:20:01 +0800
Message-Id: <20221221192001.17290-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:194::15) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4106:EE_
X-MS-Office365-Filtering-Correlation-Id: 621f440f-c62f-4221-1775-08dae388614f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XeiASiP38B2BjTsoinkKmsKzcuSgBjqjTfLjuJCztTL3PFqas1PgIqErzkMvCef4w8QCXWODipYv079yUz9q9tcvVB+mptN9l1MiPPz1lRQs3qEFzUWCUdIXD/lLBibA0giiTkxEk6xGGY5xklwr4w8k6hmM6bdoAu/kvWyeCYeD71fuMFolOlV0whaeguj2xXmfTG2poUE6HvQJQDYsiPTkaWb3aEyX3HU30qMWccmU5M6qofNHw4xJKm3QjbsIjy8fgnOtF47N0385WhyzFaGI94cpO9f3CLEYSmrUs90roIFwZWio0lQCxnZq1oxgORkVtzBAxkHWPaSiQrBqsAiy0c0Y3j2ffek9FX1rio1YXDvlYz2A46qlEYabRxHIhwG6fUkju84OXLqhnOqc0wReMbtixFvlGWxb2gVV/MQNsIYBszrj7rrKj0KVhFfGa5AvOz7KQeu3PMzu2EQICD/zHcXgw7WIfhPgwtJg3Sd4lfU3kbV1yDBwLpwQmeFEsut+CY3cd2KhOE646+a9Vk+LdDtQrHyVwuvwwJDfKuuKjKPuDrGwcE1I2UhgWNbpxqO8pi0kzY7TJW5CbS64s4gveXxzdHny07201TaprBq3fLZyPWZNE5qZTQNs0lz5r4pZgHkmz8Z7E2PSmKChshBSFPcW6VozckHF5uKx9NmIJtCXOW5uEAxujAVX1760
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(451199015)(36756003)(26005)(186003)(6512007)(6506007)(107886003)(8936002)(6486002)(6666004)(5660300002)(52116002)(83380400001)(316002)(2616005)(66476007)(1076003)(8676002)(4326008)(66946007)(86362001)(66556008)(41300700001)(2906002)(38350700002)(478600001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1kp1/UB9fp86FheWukMODvDeZ21UYND1f7BoxEfyjNOuJ4FHuvmovacgEk0h?=
 =?us-ascii?Q?BynwCSbQt3PUipf6Y9wQmBjN1IpkyD/UdQ+P0gSjTu3uARYEYI2XKb3y/XgL?=
 =?us-ascii?Q?W/+1GmFGmYlb4TkYsCEgkagTIWzRTJ/PTT0nST3Ho5s2UQeazpIzcv8/60LZ?=
 =?us-ascii?Q?5WVTR8BNnTc+hkaDzRa1/tthka5XXdrOuVO35JHLTQTknie6f/hIp/5jQo2L?=
 =?us-ascii?Q?xmZOKY/qxFFf/dwcc8Ug8cOI/RBsb8CbM/cDave370gyMqEQj5n6guAlmfPF?=
 =?us-ascii?Q?3m6uQpAuswZJEbl4vNQllw3w8TY6fq10KFtpnw8pdUkOTuufkYt8RBudu0cu?=
 =?us-ascii?Q?sVgT3SmMkE4+Ogve5KQIkaDK8EugsJP699BC47hC9CcybhW76OkkdRv0aa2r?=
 =?us-ascii?Q?UYZQcRaxRXGgwA5XdB8D1uygrKrgzfAxKPwUHVRm7JCUSwJi2Y3lXdpOeVXK?=
 =?us-ascii?Q?PART28M5/jANrhZtjV7JnJdQeuNymuyPLaub6QAwmwOBXsmeKFUo+3d7Nlit?=
 =?us-ascii?Q?DWYzXZoYxbaBm2aOjFlvnXwWA46jAvVXfMAa9Eh991R6dteYeZ7UU5DFRcIf?=
 =?us-ascii?Q?2fPXXldNzN/HaOxOeCiNq88F5klpwPvyz8+7FXXxF13t+JKZCEHEwecMM3k7?=
 =?us-ascii?Q?Jct76fT8w0x5Yw6tPpejO4+kLV17NAimu5C3PLfLUrQ0YMbVTJW/jZq20HG9?=
 =?us-ascii?Q?nFIoBC0jisxfKyqCNw2U25A35hh1cay2inU78JByYS8UaTUpF0Cu0EdB9NlP?=
 =?us-ascii?Q?ihsalNU2/muOYGYSYqBjcmejCaHhPyRl8aGpyr7+YV+JwNGxT/Kd1L13/2Ad?=
 =?us-ascii?Q?yG67GzMiSuvLXsg8+3c5ZYO2HvMLAtMtwCMt1nMt5MKxvoeWjwi9RmCW7tlJ?=
 =?us-ascii?Q?X0SKuTc8pSj/Bl9JYHmULTIPBZ+NluEDkYvTFst6MAco38DjZbMwYxAjTGfW?=
 =?us-ascii?Q?aBvrorsBgEV7wVHtRE+avWyeZcoMn2jOPu1jbEgQjF7eLjXOQmKfu1esVjG5?=
 =?us-ascii?Q?QSDBLGK0ipZmePT+gz23aOINYuBLN6K7sVeIGbN+5vOmXvErMSKbZh5+8GV2?=
 =?us-ascii?Q?eYyhL+0lniIOtcfe4rZVyVVsbRMepAHZgVCmFb3mYTdvQpxgI1Laoel5tVqs?=
 =?us-ascii?Q?E1Z39T91OuDKec3abOGRuVILVfWOYVnseyXrvuCtGBREiankcQIz6EQsUisi?=
 =?us-ascii?Q?ABbV1xNCqi8oyPWNxgOkhNdfcA9wwlwFCtswCRU51iynlzBaBzvgSgkJ4xdg?=
 =?us-ascii?Q?A35qaNCbQYsneMD42krntlETMsf9Qv4pGt4k72Brh0B408XNAiz4IrT2MHI9?=
 =?us-ascii?Q?DzMaWOFRQk2ZXECUVTlkQFwDyL+VwkkGm/eT1aa579arj0/6jJoWcMb3qSzG?=
 =?us-ascii?Q?mhsNxS1s+fVXxS2YYVtCxt9ItM1PozkOZJ5/PnOHBU2gq+h9vMKsPK4taqHi?=
 =?us-ascii?Q?LjlBlPwRvdQyusXUS5M3uQRGiqOddgrBTM9iHZl6euDytgemKhdue019D2k4?=
 =?us-ascii?Q?gCmHkVRKfS2UIhewnSJnM4WwIQwgRNDljxodm5MqepkvCBnxBr0ah7aLTBHw?=
 =?us-ascii?Q?CV+lUxEwOWKfLsU2ah+KKc/09ENGDqtk0Lo7qi3d?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 621f440f-c62f-4221-1775-08dae388614f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2022 19:20:11.4915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6bgBH3IFvpzogj+oBgrBn0ArSbHI/u+JZnzOMtmJ8GvmgJG8hIbkoXyynyiUo2o/CGsukRx6oV19Bw8zawVN4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4106
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this patch, it adds to account flush count.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/f2fs.h    | 1 +
 fs/f2fs/iostat.c  | 4 ++++
 fs/f2fs/segment.c | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b116c778fce6..7d7b96d1e1d2 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1194,6 +1194,7 @@ enum iostat_type {
 
 	/* other */
 	FS_DISCARD,			/* discard */
+	FS_FLUSH,			/* flush */
 	NR_IO_TYPE,
 };
 
diff --git a/fs/f2fs/iostat.c b/fs/f2fs/iostat.c
index 3d4503fef183..721294c40399 100644
--- a/fs/f2fs/iostat.c
+++ b/fs/f2fs/iostat.c
@@ -150,6 +150,10 @@ int __maybe_unused iostat_info_seq_show(struct seq_file *seq, void *offset)
 				sbi->rw_iostat[FS_DISCARD],
 				sbi->iostat_count[FS_DISCARD],
 				iostat_get_avg_bytes(sbi, FS_DISCARD));
+	seq_printf(seq, "fs flush:		%-16llu %-16llu %-16llu\n",
+				sbi->rw_iostat[FS_FLUSH],
+				sbi->iostat_count[FS_FLUSH],
+				iostat_get_avg_bytes(sbi, FS_FLUSH));
 
 	return 0;
 }
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index af2d522b1a89..ec4ed7603d1f 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -505,6 +505,8 @@ static int __submit_flush_wait(struct f2fs_sb_info *sbi,
 				struct block_device *bdev)
 {
 	int ret = blkdev_issue_flush(bdev);
+	if (!ret)
+		f2fs_update_iostat(sbi, NULL, FS_FLUSH, 0);
 
 	trace_f2fs_issue_flush(bdev, test_opt(sbi, NOBARRIER),
 				test_opt(sbi, FLUSH_MERGE), ret);
-- 
2.25.1

