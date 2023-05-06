Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3E96F928A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 16:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbjEFOnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 10:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbjEFOnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 10:43:17 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2122.outbound.protection.outlook.com [40.107.117.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBA51AED4
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 07:43:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DB55EITw/PhE6n6DdsChgqpNCn5sNIImfl38ZDe2Z64fBIHET8HIgrlCU6QO9sMPY3t0qPvdRfrgqGiNMAbLl18Yf82yA1aWLv+drZj5Q7Qj01nccuHNcLn9JWgFtDRFt3HQuLLZDPIEkvD9usUE9oLrKeve4Cg0TQEOwzq+tovGIo4mqBFbQ3iLOVdZCuTOqUknJTkzcdDmCqv37nooCbNLLD1S8hRqZcpbL4sTtDd0t42A7CFI8nWYp/Ho079vBt6MpOntg9YgCUNdpF0TMMkSMvB8j7jtMd2uPRGkt/YiTjMvNb0xMLYV94qYIfex/iGwukYvRYwZiT+FPYyFmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMuSe6FEFxGDvX/sqWgJC3oZ5D78m4r6nwK/M2i36wM=;
 b=ALHbEXxDgnOkYb9xRTWpZFoVg781ypFPZgMVerCpkkRPyyFHPH++PoY6BVUMZI66Fproi8KLZjQ6udVlWYt5U1KwfCmAFLnXp9UfBtbIYFax+NnyKnh/QMHgCsowDxmFRV0fkkEyYnIXKbw7OxBD0AhILoG87Nv8Yg96ZqP66yDy6kQchq0Lk5BNeE51lIjbiPhW16Kf269TgdAAYK1b/gsIs/JMdtbTP6XhH9YSYT+vnmBYxNBAWtSPmWWq9qEhRB+Qr1i96C+Mq3rrkhkMVDO3UdLNNFhsZU6kc4zjLa0EzQE0BTOWNT1vL1da7AOXLOSg+naDYFveMA30aTjdgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMuSe6FEFxGDvX/sqWgJC3oZ5D78m4r6nwK/M2i36wM=;
 b=g5dcgSVLGalWzUqV0st6jQfb12w7tQNbWKC0ne8AJGZjsgFPKFBc2op8GG0QKyUWLBZHqOKCHXn58pwpiV1hgdmA3IrPRstqWqZ5bexZ+1avFiWKp1QKqQaQKdadQlhFCQbZ1hdnFI22XU/ShfF4NiFFrhnDtKSq2DtpVtKRhQp2kXsNoZ1mQhvL0yMhnDvugBNDHTwz9zqdyAPFHFbX+LvFzxMJD76kgY0F1i6UKOP9mk/olzbn1Svx2y9l2ixP1ePxnSGJm6xn75rmKDVFk5M13EPBJh65z2kzuy3fY/O3jEaI1W7BSsbCGR20MVjOmf9LhuiLeQ98Faa6SQ8Z7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PUZPR06MB5818.apcprd06.prod.outlook.com (2603:1096:301:f1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.29; Sat, 6 May
 2023 14:43:11 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%7]) with mapi id 15.20.6363.029; Sat, 6 May 2023
 14:43:11 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2 2/2] f2fs: move the conditional statement after holding the inode lock in f2fs_fallocate()
Date:   Sat,  6 May 2023 22:42:57 +0800
Message-Id: <20230506144257.9611-2-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230506144257.9611-1-frank.li@vivo.com>
References: <20230506144257.9611-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0058.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::9) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|PUZPR06MB5818:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ef9b1c1-268b-4ce7-90db-08db4e403716
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SPEGXC3cvuV/dwoYYMEROvgvnBJtstvMElx8U2mxXtg1ry4T7B7z30VKR4/+VKLio0wim9csHrOnpRKEza9vgOuMz2Hds1EsbxBEyiXAHv4BtoCcxArQ7TkKM4O125R85TteGMfo6edvzsbWFtMqEB3q/TCjkhYsE3a2MPL8gucjA7iQAkjzoOAQfbiRS3k5Meb1mfxtVn+SMXPXjrWF2Ww5RB3l0YfiZuIKmnKvUxtTAjHULZ7BiWSUqt4Uo7mYdvpFFXdAoz50qmc9zt7dFctBqqaBUgQDCCZuiG8Ot5dwbd24e24uaT0JzJnO4fEJNVBiN6mvlyhKR0iWzR8rsq2IZnuk0TgfbeEGv13stna7ZDVQdBhN0f8z+RJR20BpMMaZu1uZjC6Jpmwc3NRX9gZjP3mnHunZfBTiZsF9LCRmSOJdKxWfAh+wj4EJen8v+rWtT1ZbIZK0VzrVKdiuSL9SuthdvmDLI3AsiCnA5nftPLz4SVXP94ZHlztLM/NGAQxOUpC4VuuK1zSrpxqSy9U+BLu6YZY9zFgzs3cnmpwWtB8S6LPhL3o1ezCdnh0EdkhMI7F0kkkDMHgKImVZbM9a+OPdG0Ni3ddmqMACtdqmgUAA8IdGe7bXt5BXDJd3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199021)(8936002)(41300700001)(8676002)(5660300002)(2906002)(54906003)(66476007)(66946007)(66556008)(4326008)(316002)(478600001)(6486002)(52116002)(6666004)(83380400001)(6506007)(6512007)(1076003)(26005)(36756003)(86362001)(2616005)(186003)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K7A6gPUT0wrpTxGSiiVutqxu/Sj6Vjy5lHVsuybi/trTUwM+2c8eU8i2+Urs?=
 =?us-ascii?Q?sC4tVI2ZTeEeZ8yBYy/gFBSDRTiZd7qh1PVqDtCYHhpcmV6H/dUiAVDzPoiS?=
 =?us-ascii?Q?GNwjbgcJQhE2qPc3Bj3OKyMoTpykpTSxIno6fTgRHxaovwEtBtTEqMAXVQGp?=
 =?us-ascii?Q?m4QulQrvozxmS8+0tsgMoFr1i8prw5e19xo5d3K2YmnHzDRC7caOOCis1kFe?=
 =?us-ascii?Q?Ut8wBQP4nc4b5HgZI6ItADdrb8C8VzZNdKH++nhL/zC2zL6oc0ZOe8PGgBwA?=
 =?us-ascii?Q?Zwy0o2U91SDAZF4oRTOqjXvNQKWHS7hbwheEIZYpkYv/YJs4abm07L4wZhHV?=
 =?us-ascii?Q?bmmKI2Njee+tt1lHsoER97UHV4gLLpoVDUhqsDEBD40fqyCFnZuN4fRAqFmE?=
 =?us-ascii?Q?+JiShbTbgqPqktVmwN4xXEhMT7v5NhtO0RXlC26WGe4tuInG24EA+LNOQFkd?=
 =?us-ascii?Q?Ld+qsICyeFuvTGl05LeEfMNLaRRU+OX5hUSEl6L4uFLFJyFkWjNLEiJbH0D1?=
 =?us-ascii?Q?O6I7vm9z60qf3uoi7vUzmiG9IxIHzf/TZhcupNlh/KiL1tddO9v7mgUqtcyc?=
 =?us-ascii?Q?3X2wwUUs7jw9HuRxT4tMLUcLZjV1IzLqhhuI/PsVDps2ejK5m5UbtIg6yNYC?=
 =?us-ascii?Q?3RmbRjdEYXtIW3taeLCDFEXJITvrGwiGsg1o86LEqc3dqmAczGsDyFnOaNxR?=
 =?us-ascii?Q?GR9jMhbPY6aGKztudkFcTVamIek9nbBTRwlp+dYAQ/NFC99cYb1IQ/FtdhkW?=
 =?us-ascii?Q?iiZBiNCsoZbtIiqFVjQT/i3ag7ahAt37Ln/hMZYrQ7BYIXhNNeWRAikLlnLu?=
 =?us-ascii?Q?V4YH7BraUZ7t6htagkAcWvqisaoJ2twNcI3aDaH7zIGf5hGFC2+X/Sa4oL+f?=
 =?us-ascii?Q?FeomrIQ/y/YlPT0mkkuA0wlqCf3DPHtqhq3E6f8euhOKfNksrbLGsMbfDw+O?=
 =?us-ascii?Q?FSkdbCk4j16TPneG0+gapXimRvvtGXQHKdghSGE5kRyUVRv6BcKmDzhDKSu7?=
 =?us-ascii?Q?UnsxcuVejL31UOksF7FbfYuZTo4dompg0EIsxiItnU/kPwAMS1WB4Ct4kA3O?=
 =?us-ascii?Q?Sy2DRJXm60aV0q/248eJf+ak17uOa+9bdrDMcPS9HYx8NebQkBrRDWraUiq0?=
 =?us-ascii?Q?aOC0yOkThof2ksB7aw8ji2WObbVrh3kBYSTvnsdMLrFy5t7FsFqdfgakMLfS?=
 =?us-ascii?Q?NlO3Dkr37ej5x4RxqUo0Aqr1u4hSDHcO2875kKPIFILd4fU5R2qu+CRWy+gz?=
 =?us-ascii?Q?S0DFsgUifeY9NjL0vI8k8/e/N7yQG0H7O5VbqLEgaOphZKqovbx00FoT46D4?=
 =?us-ascii?Q?rYVIuJcn4z9GmZ1irMvFGbQmfy3SPp1dZxIy1vEuwCkYNqm1BLowfV7xPZmA?=
 =?us-ascii?Q?1D0MnzonQx9gkdeB+HmNoUrIti9vIQNqMBzxiyUVFbkpiyrpxb+xnlkK3YNL?=
 =?us-ascii?Q?UZzc2mCdaKK5PIxV05YL9f3QjRqwO+9W23RJK2yUsTdBPNarxtr3YzWbK+Mr?=
 =?us-ascii?Q?g0RPQQboKqeAxzztsiRS5jfQE8Rxvy8S2/0bVxSl+hlEVuWQEZjtcd+ln9p+?=
 =?us-ascii?Q?hdH6Vq3Yw+HjvSDgaP4ycwuysg8YkOzVIb+x+C9G?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef9b1c1-268b-4ce7-90db-08db4e403716
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2023 14:43:11.3666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EjKB1tBwy1Y4JyibvcTFKWNr32UDbFjbr85gkYI+anEYWXQlf6dLgxs2ZrI/KYy3Tr479qn91dblGl4eoJxFGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5818
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For judging the inode flag state, the inode lock must be held.

Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Fixes: fcc85a4d86b5 ("f2fs crypto: activate encryption support for fs APIs")
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
v2:
-add unlock
 fs/f2fs/file.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 42a9b683118c..0dbbcb406d3f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1801,9 +1801,18 @@ static long f2fs_fallocate(struct file *file, int mode,
 	if (!S_ISREG(inode->i_mode))
 		return -EINVAL;
 
+	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
+			FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_ZERO_RANGE |
+			FALLOC_FL_INSERT_RANGE))
+		return -EOPNOTSUPP;
+
+	inode_lock(inode);
+
 	if (IS_ENCRYPTED(inode) &&
-		(mode & (FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_INSERT_RANGE)))
+		(mode & (FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_INSERT_RANGE))) {
+		inode_unlock(inode);
 		return -EOPNOTSUPP;
+	}
 
 	/*
 	 * Pinned file should not support partial truncation since the block
@@ -1811,15 +1820,10 @@ static long f2fs_fallocate(struct file *file, int mode,
 	 */
 	if ((f2fs_compressed_file(inode) || f2fs_is_pinned_file(inode)) &&
 		(mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_COLLAPSE_RANGE |
-			FALLOC_FL_ZERO_RANGE | FALLOC_FL_INSERT_RANGE)))
-		return -EOPNOTSUPP;
-
-	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
-			FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_ZERO_RANGE |
-			FALLOC_FL_INSERT_RANGE))
+			FALLOC_FL_ZERO_RANGE | FALLOC_FL_INSERT_RANGE))) {
+		inode_unlock(inode);
 		return -EOPNOTSUPP;
-
-	inode_lock(inode);
+	}
 
 	ret = file_modified(file);
 	if (ret)
-- 
2.39.0

