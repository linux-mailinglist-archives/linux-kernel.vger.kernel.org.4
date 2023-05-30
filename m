Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC68B7159F1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 11:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjE3JXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 05:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjE3JXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 05:23:02 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on20712.outbound.protection.outlook.com [IPv6:2a01:111:f400:feae::712])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3791B10A;
        Tue, 30 May 2023 02:22:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lM/I37o8s1OWw1YVWgtTkTeO/O1IAlh5rPg1lj8rvMRfxH+VFcCMTo9VKhn9/RH0mJgPPvvROwzu0+QJ2EwVvcPuNwgdG8tlcgKOmADxBfoH2EQoy3SooC1EL7WSUQ0fOwN/qqcSx6qyNNL2vpNXzhNO94LyN0VnMsH4hskzS+yLupI0CZ/3DidG7azqtsNLI1yQiLvSyKV4VuoMkZQgr2yw/Bgac26qD/qijKNowNLM7Td/WaaoF7WxCej5zKLbPs39G8u9/drqjWloUut92o98hjA6DIFYdPCF2EytdFkt8LEZeY+Mgo7owBAsUNSeBfnhLfPUimSMBupbPAXakA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/xqONYGmwa8T08xrQCikYyX0Wui36rF5iWm7+I74kg4=;
 b=k0D0lm1JDrhBq/eZt/ks3NrJQ9BiPGvMUEvJ5Q03wC3hzKcs6zfJvCIatdk44JvJMtCqaGoRd5A+2U9OIjx3paz0pZhLHyAc9oymkl+9ajDMBTlFp1pTj9WJRUNtfhJemFaPDThrb22W6Mj/uljIclo7Bgt+Zgl2oj2OSgkGHGv2BgjtgYprjBOlH9C32dHusYF5elOfyf2J3B+Fl/E+u0Yfg1WjRJTawFbZ3CWSO/A5hDaykYkbjGcq2//8nElZvsSh973HhDSlvOY3mUOmgICMgI1+It0TNaPj0HbQ6FUutv4T2HdV80XrmDXPvqnE6qYVV0o7E4MqpPNEUElERw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xqONYGmwa8T08xrQCikYyX0Wui36rF5iWm7+I74kg4=;
 b=GsrwNuD9rZIMlToX8xI+iWsbxcmCFohUoOijg5CtcS4Q/tDemO0SDOWOkXo0keXPg54Fdy2fR+nWKAGnjWPnzw8+RgBk0ZqRXly6X8a0EbH4HvF1glPrurwo7/naZeWgFReDzAdSfZMr5hjWWmjhgJOWxg1DIdEzG8oowWa56O5FeLLNAWJGKqgqSSWaHroYhuvtIyczZ+YPM3KClC6AmagIZUykO1+ebjzGSB0LMKuzWihBpYVqXnjw3cFex1QM20RZHtFb1Z8jt/hc280IWOOZ/59tU67vz5aOYMjkq7obh5diWNP5fVYCX/j2fdCIwGCBZ2ZkNMbB75yjj7vQOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by PUZPR06MB6248.apcprd06.prod.outlook.com (2603:1096:301:119::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Tue, 30 May
 2023 09:21:08 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e%5]) with mapi id 15.20.6433.018; Tue, 30 May 2023
 09:21:08 +0000
From:   Lu Hongfei <luhongfei@vivo.com>
To:     Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <sfrench@samba.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tom Talpey <tom@talpey.com>,
        linux-cifs@vger.kernel.org (open list:KERNEL SMB3 SERVER (KSMBD)),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, luhongfei@vivo.com
Subject: [PATCH] smb: Remove unnecessary variables
Date:   Tue, 30 May 2023 17:20:54 +0800
Message-Id: <20230530092055.16919-1-luhongfei@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0058.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::22) To TYZPR06MB6697.apcprd06.prod.outlook.com
 (2603:1096:400:451::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|PUZPR06MB6248:EE_
X-MS-Office365-Filtering-Correlation-Id: a553c121-99a7-4061-8266-08db60ef33a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 92sDB/oPGRNwaIJf0mL0f6pRWoom8bjXIskAKP5PCLHHjPPhhAOmV3nPgNLbBldV7olKKJubiCSveOjoSKPXIjmc+w6+O/HIVsmt1Z8UGWokQXydQDXVETB94hfsatt3ANS198/by9CUSA26SOz6dER6zFeQvUURCaOireHk8c8WuWz5X7ltDk0byJDZAx6FJ4idCb5LoQIkrr0NFEBDkgyuOGlJ1gKipM54gA41ScrvvRw9x/kppg07juWDvh53xaKRUxJtdhLF0snztAxOCxp538NX+C1ryx56R7LZ8bA/yhU1HrMioRVUJVIDtrUT1a/jmQRApN+Hn2s90ikyOf9HZLdlXpRmjHELDDE15H6ullfnYtNgejYzdAY3gFZyCeuhQy+cqcHx/bIs+gmE401zp50xqcay8Krsl+qKfTwFGD0JYIPd0VKe/P2/56vHmI4OeteO/qfa7D3GJ5EUXAmmDA/xYYArBZraZdDAinm0Aybs5r1ENP7jQi/sYlfd9d8O5ImKKJDtQaJxBltd4QO+8QGhtJzowMDe7ZZEntQIWz5/jsZC6rHrbjk+4CpaRFy178DY2wGA0HPlRgpM1I+FK0II2ZPudAx/QHiLf6qlAD/uvbZd9DSp+Z27UsZu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(451199021)(1076003)(186003)(26005)(52116002)(6506007)(6486002)(6512007)(316002)(4744005)(6666004)(2906002)(5660300002)(107886003)(41300700001)(36756003)(8676002)(8936002)(478600001)(38350700002)(38100700002)(110136005)(4326008)(86362001)(2616005)(66946007)(83380400001)(66556008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NgJmxUENB2qSgCuMOKIo/yly0IjEmWixkA/lAXA0P6DQ57ya08LPCll6CjC6?=
 =?us-ascii?Q?63ruNgxrI5n5BjiIIkKbej+mktad7F9mjgnoN2/yjOydjO5PfLAfpYQoVvlb?=
 =?us-ascii?Q?HvPv8E2O3b0gJLafbH91EGoFDNzbm6D4InPMnTSr2stoM7OCDOtoOWoifaqt?=
 =?us-ascii?Q?1xI7BxXwMW+kFxW6aJKs8ztEywae6c3Qcdd0zSHb62CcHbxbgENmQezAgugz?=
 =?us-ascii?Q?MSatbZj+7/mNXI8z/1VVAdEXGV0p1wSbVDu+H0l5966wUe8B0Ep0UNfGoKP/?=
 =?us-ascii?Q?Io9fPw2bxxR9RxFwtYe+gVcYBa8rgk9d9Zl/wt1VUgQZRtsDEdH6wSL4kULQ?=
 =?us-ascii?Q?nFJi0dEzafL86Kg5zM97Heotmsl42aEjTJfEq5SF2YIOFS3BO23f1kbLZh2x?=
 =?us-ascii?Q?dr40PmxP/yCO5g0ZLhtqo3l96rODNEkd42ncdEcR7L1UPv6HwjBpUWn7OQ9s?=
 =?us-ascii?Q?hqwKpSMoB6s3lqIuEFPc69mHbYq6CbwutjPfNm+n0mQoHjjnerlia70zi7/5?=
 =?us-ascii?Q?dNSBncXDOHeTXOzMCS8vtbzpKqmdk1bNZj5AMopj8nFtfCaz6fXN4onGSXBJ?=
 =?us-ascii?Q?Vyiz4sXMIuNXmHMT53FeGvGBmT6+Q6YVZrZTYQSvjE2X7zOoRiqs2dSw++EZ?=
 =?us-ascii?Q?1ycNWdLV2Q2mYaZi+MQ8JTYeQTqE54k/bfcb9p5l6tWyuYBXBZhb7LLVL1P0?=
 =?us-ascii?Q?QTUP8jE9fP1BvYCipYEg8FkQDmAShhoScK9rZ28HoCq10Bcn/vOB+VW+hqyk?=
 =?us-ascii?Q?8cXe3nypt93tx8q2wOAqhoCz8UkrmqhYeYXbRBl7jKPJeB/cprmoSQnBkTAP?=
 =?us-ascii?Q?tkX/unPLLKFwB8wS5o3nQz2juVfCl0bT2VngDQ+i+gfz4VIO7XvSBtDpu6MS?=
 =?us-ascii?Q?owS/Tc3JID8kCHcl54bxmOQG61y5itsoTbSaMtWB6nggtD1r6q/SEpyLqGBY?=
 =?us-ascii?Q?IJgdgiTLARqe2w9gXTGERHazOnokz604F3nvjjWysNlknNlYbtyC83dx4tnl?=
 =?us-ascii?Q?YTc1O173Wf3DW3VT+VXyT4OLK+Vl48vpv8P2hZ4YxHBaFKjGoctViUd7NASg?=
 =?us-ascii?Q?Mpat0uJ6wgAeA3VBINz4Yt3aTEu1or6rsvYD2TzEbWYEKYdH5eRw13WKvI5z?=
 =?us-ascii?Q?GKSO0HcQdtoS7NrPjm7kI+HGNQRS8prXJ/y41AyM+OlxeL0MSJWANWWkWIs9?=
 =?us-ascii?Q?mp5wVes2RWoQB3UFXgExCNVwr4QZlwdrnGBIXylxcbAQdC1WZ/iXzUOXHXRq?=
 =?us-ascii?Q?02vbong3cUXr+TDgRoFu9/TWp+tHcJGIIoa718tS9FT4qLYT1fgqGEtaph/m?=
 =?us-ascii?Q?XXDx+QVkTJSdbj0VEiAn6SEeNEEvgdvzcuq0IvlylHOPu03/ELSrWaFTVqG4?=
 =?us-ascii?Q?cbCvmDaA5Lvccjae3YD/bFlQmnwhPuxZhW87IPkIkWanR8n8E6pMaXPMyJOy?=
 =?us-ascii?Q?nU7038Pa4mdfDDYshN+PYQ1jOa+aRHGJMDpvTr5ae0t9+wueRGTw7bsM/UxF?=
 =?us-ascii?Q?tVz1jQ56OdJJ+vkmkMLXzq8+yVxY0XuEDYqlVSFIq3O49V3PFo/3ko3Lme/E?=
 =?us-ascii?Q?FFe3SO5Zx5UJTe9yRIba1dyK4fHkDY+40wA1jP1U?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a553c121-99a7-4061-8266-08db60ef33a6
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 09:21:08.5542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: et7xkGbp8lVcMvtQtnuOgZP/dzH7F5UKrjVo1E5/mDKQzCbtUwhbRSPVaxFnj5GtIPZmSJqn0qISmvq6zieg/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6248
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unneeded variable:ret and return 0 at the end of the function

Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
---
 fs/smb/server/vfs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)
 mode change 100644 => 100755 fs/smb/server/vfs.c

diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 778c152708e4..cb3fc71cc59f
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -120,8 +120,6 @@ static int ksmbd_vfs_path_lookup_locked(struct ksmbd_share_config *share_conf,
 int ksmbd_vfs_query_maximal_access(struct mnt_idmap *idmap,
 				   struct dentry *dentry, __le32 *daccess)
 {
-	int ret = 0;
-
 	*daccess = cpu_to_le32(FILE_READ_ATTRIBUTES | READ_CONTROL);
 
 	if (!inode_permission(idmap, d_inode(dentry), MAY_OPEN | MAY_WRITE))
@@ -139,7 +137,7 @@ int ksmbd_vfs_query_maximal_access(struct mnt_idmap *idmap,
 	if (!inode_permission(idmap, d_inode(dentry->d_parent), MAY_EXEC | MAY_WRITE))
 		*daccess |= FILE_DELETE_LE;
 
-	return ret;
+	return 0;
 }
 
 /**
-- 
2.39.0

