Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F2773DF45
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 14:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjFZMb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 08:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjFZMbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:31:25 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2134.outbound.protection.outlook.com [40.107.255.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5DB8E;
        Mon, 26 Jun 2023 05:31:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6IJwkakLMHeuW+jzUM/XcoGC7L3yqJFAt5Oa/Q/RKzSROyC4so+p4O2VpZHRQp2y4gqmddugF54/F2/OoyPtIsflnZZSHSL4nyCAO5CMM9OInbzyHwO+3gHmAmqhSCVH0mqq7cfI72o5N9/l5qb43DjYDs5fQnHmqIsI8C4YUswVHm/rn55RmrC6dYpOLfgUPpba5DMG+95qwQHzJKM5Z9nsslcctHgdBN4bgTA7Q8FlxBfVH+zI1iau/Ykq45FGts382uUKJs+CYATM3SDKxT1yu5qSScRMS58+sCtwX8O2FGtq1g/Jgryy0mm9DL3YDIFcmUGR2ssdPtvEHAnyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5DSXrju/xnGLwUPmvpbE/UYPUz620RTKQ6BwxqLeHs=;
 b=k+aScyd31badXndVhgcWPKRHkrMLv2RPsskk0LIospSGXyqNT/GqhGQQss5Qk0/wGxDefHcWvKXFjCCiTJ7NiZdcwKQGOW2m+LFN+Qay65XJOjrdgxl1/C7G2xaWKgKVjmY5QStvZMDO5fo0wX1jlp6mANHxI1oaGioGyMx+n0Exe/q3nLihuWTKN3lIAFKyO97MnLiGasbDUeNTNhbpAP0stf3TRMApC+SgRPSloBtEjXvQQRyyAgbBWi5u0+7+Xcb+lGcEjUyWyOPgkxvIBEQCYGC/3KrjvErjChQUsveQJaSvKfyG3dEqztC1+GaO6LRfiOqxayu7X1amWYZV+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5DSXrju/xnGLwUPmvpbE/UYPUz620RTKQ6BwxqLeHs=;
 b=X4m/Q8YKsbQIlghuunJQEc/5uEckNG1fYh551Xuh9t5hSoYMk3EfCxJ+lkwPPCSZJBMjAoAOiSJ+ceFp0hW3ib/NwUfbJAgW+GCeoNOrcvnfhTU15Kw0ZAly1IdbcIww9q5s89QI87JonhoQ+6ppCkhclk1KngHEsu5qRnoI6LouOZD+a1XxJua0pNtZ8S0d/PxM4rEJcTBJxwzmf8o4jAYR14mERD2hpyP4ueNiWFFkAX07nyazfhNzMrjD++1pTJf4EaQBVjhQ70LiQ6DVR4xS/rVz7EhlkYkpwT5SJhSdMlwHa/kWQVmS/CEomUleS1jXaqCD47dqRM811CsGtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5936.apcprd06.prod.outlook.com (2603:1096:301:11d::13)
 by SEYPR06MB6375.apcprd06.prod.outlook.com (2603:1096:101:148::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Mon, 26 Jun
 2023 12:31:20 +0000
Received: from PUZPR06MB5936.apcprd06.prod.outlook.com
 ([fe80::adc0:c22:ffae:227b]) by PUZPR06MB5936.apcprd06.prod.outlook.com
 ([fe80::adc0:c22:ffae:227b%6]) with mapi id 15.20.6500.045; Mon, 26 Jun 2023
 12:31:20 +0000
From:   You Kangren <youkangren@vivo.com>
To:     Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <sfrench@samba.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tom Talpey <tom@talpey.com>,
        linux-cifs@vger.kernel.org (open list:KERNEL SMB3 SERVER (KSMBD)),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, youkangren@vivo.com
Subject: [PATCH] fs: smb: server: Replace unneed variable ret with 0
Date:   Mon, 26 Jun 2023 20:31:12 +0800
Message-Id: <20230626123112.3624-1-youkangren@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY1PR01CA0196.jpnprd01.prod.outlook.com (2603:1096:403::26)
 To PUZPR06MB5936.apcprd06.prod.outlook.com (2603:1096:301:11d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5936:EE_|SEYPR06MB6375:EE_
X-MS-Office365-Filtering-Correlation-Id: 71c1093a-d13c-4428-252f-08db76413eeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ShUf5jwUsH4S/HkYbZ04iq0MC5ntjr41PxWUaHYeglTLabQEKfMZRM0BE2yqEpt01Ctov7vBJ0pBRrmtsT779+ouyuxLyrYAR/29BbRPifwAFQoHKChtkrX39PKarmSuv+PHILFgAhGseimCwyi9CKPgUWOUYniVt/a28otvDNmJVp0lT+2WAp4+7zzTpkgXQDTN+8ARJu9bZbcPvnJaGMCRy60WDO3huSw7WV3ABr2yBm9FOBuVESPsrkTwhRDrLTeTf2KorUnmkJuyMoOLalvzvk+1VoiHJSZmCyLXxhMD2Ua8UARtNDKLlHCbxSjYSpDI63yeBXWV0tj4vaS/GJZpyQ9VJwVtXgoxoAyaPeMPD/YjLU9s5gj8g9jdWyWtwJ0ezhEETpAuXe3/x2OWyOpkKukTo3vSxZLhjCKyccmDRmiCgqWgX0cdE1DSPE8slgnbioImyx1HUzEH/o03SdMRgOPSL/r8nWXjamCF3THG0MeALmb9dMX76dBobzdhk1NU8b8N79nFw1Yx2KClK6skyE9lMOKi44Ibf2uiCQK7pYGfHhW1ETTJownKP7lcRv0wbYsvMP21j3bCfRv28UVN5NXtTtB/u5f6PcrmblrdG0y2V3972+PpH8KxtzIq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5936.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199021)(2906002)(6486002)(52116002)(6666004)(38350700002)(107886003)(38100700002)(2616005)(83380400001)(6512007)(6506007)(1076003)(26005)(4744005)(186003)(41300700001)(110136005)(86362001)(478600001)(316002)(36756003)(66556008)(4326008)(66946007)(66476007)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KZK76RajZH0Frd7c5AE8o2AShNb5jDnPR3dNm0eqJK/D5wlm5xES8kVJLI+P?=
 =?us-ascii?Q?7RxIhvopXPN8DN/BFNe8f4im204rhrknncZLy/Iovmuh/9EU2zf83nlpCt3E?=
 =?us-ascii?Q?LtfjCWjBjVmxFFWKBm2xPSjCU/to7FZMJhmmNRF70KcbIjfzcHctncNiFkhf?=
 =?us-ascii?Q?CduP8RbYOZ3pulz5INowFD7lfD+VygC19nmnF+PIos2S1p25TbwOlI0sammb?=
 =?us-ascii?Q?dWHobmoeFlVxlxLWtFU4D6tXmTBhUJZO9TqJ3cw2M+oDg/s6WSKa2+iOYhsJ?=
 =?us-ascii?Q?kbpX1ZPmk0NcRI0y79FVIlkntHTQDZWJqCEcOyMW9lkWJaUPlYPVFteIKt1d?=
 =?us-ascii?Q?c5E0AGUamkPW8DhUrpdqZ95uO4EYqsTC9dDybFij5ue+CMpLzjzTYxfph/8k?=
 =?us-ascii?Q?XpDAHTBLdGGkch4RPTW2wZQVdrpJD0OBzOBnr6d0ykoFrSs6yzCR2WsiEqbO?=
 =?us-ascii?Q?rzCZk6ZJo0m5m3i94KWyHGfmY5/y+9VFe8c2LP4mQLKPS+5TQp53WB8UU6eH?=
 =?us-ascii?Q?PJrBh1yoI7bZjzIQaGKciVhiL22FL7St2QcWhFHEMXio6U4nklVF0nY8LYoh?=
 =?us-ascii?Q?utThMgma/768EqYZLvcbQ/Fwuzq5Al8L1q3T5h8bAx+puArK715HG6+lv7Ud?=
 =?us-ascii?Q?v60Nu6CkcKFtyIzhK4hdtCVn/MsIHe2XVzppvurpvLmU87NpiUeju/OnPVbc?=
 =?us-ascii?Q?9/C2Swal+V9WT4ZrOoYoERGbG2ys94imiJexjoShNRJeTJj2mi0JF+OINpEl?=
 =?us-ascii?Q?uFlak6grQBHdLCR14f+rO8SDy57/zv7PhCK77d7z2l0yg2/X5Hc2DuyDM7AY?=
 =?us-ascii?Q?dx7G76fj5XZzfLK0yGWlX4AGHDJqkM2vVX5esHphW1E5Sai+XygzNMkotQvj?=
 =?us-ascii?Q?9XA7B1reCApTkOVzW0u6UR5yoe2zlpa04B56ssjl+UtfRAA+F2UTn0e7RRxW?=
 =?us-ascii?Q?Kmsc8pNDNbAycOnmJvgqYXfvl+G9qjJRaw3NG7oxc99Yt2rQC2mrMfA3336p?=
 =?us-ascii?Q?/XyhEsSHVimsNH+voDK2EPZGEtXdy2P/KN35sME9amkFZ1xMvN0EJhwGRHBN?=
 =?us-ascii?Q?ngUMqf1kS0jKlK1nM1NPbOD1faWE4GNVPVotrBfYIA/qN2rdkj22HUAPSGMx?=
 =?us-ascii?Q?A1nSzFqZ8TbkZx9CiDPxgoJO1QgbUfIz6AtY1Hry1mxrWN3uAIW29PKQ5L/C?=
 =?us-ascii?Q?KcoP/uOQgZrrkbhw+rHS7PHgCsBWUyqX54WLfcIuyzxw0zRzwXZcknbt+qvo?=
 =?us-ascii?Q?qNYkKhfkSwmfqfoIMp7H3E3Fwz22lCEl1nR/atK0baE4P/S62uZViPIC9OiD?=
 =?us-ascii?Q?Iaz2x3sUaOdEeadUs6VuXqaHdjgTraDD88inejXpa9A4c2w1pCWYyQMlcwSt?=
 =?us-ascii?Q?+qr1iBs/iz7gpkVf1Ze6sNVgZ8owcpOtdMsT0Bi5Sc+CzPpCUuVHtqfMp1DY?=
 =?us-ascii?Q?+Za1LgGfDWYU9xDHJMLOA41V+v2ZpIo1bt0xFmr652ZwpjHzMSWt6TaKxRiI?=
 =?us-ascii?Q?2azizuUni3mfgXJ7gmpgEjQuoJgdYpA1SHZTkAo6Eb2JBzwB+/GYVtC5lfXn?=
 =?us-ascii?Q?R5c9U99CvqyDTfRRoytt2jh6SRQmF/o///v0+8zY?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71c1093a-d13c-4428-252f-08db76413eeb
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5936.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 12:31:20.6380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4peUolvI3+BRRm36ujqEm1bd26CUlC2/OHdcFaj+xk7sDoV0vjL/ZVjMGI4w+d6VrW8K6xmA1cW7LVXY3bNTXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6375
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace unneed variable ret with 0 to make the code clean

Signed-off-by: You Kangren <youkangren@vivo.com>
---
 fs/smb/server/vfs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 81489fdedd8e..ddf60f439617 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -124,8 +124,6 @@ static int ksmbd_vfs_path_lookup_locked(struct ksmbd_share_config *share_conf,
 int ksmbd_vfs_query_maximal_access(struct mnt_idmap *idmap,
 				   struct dentry *dentry, __le32 *daccess)
 {
-	int ret = 0;
-
 	*daccess = cpu_to_le32(FILE_READ_ATTRIBUTES | READ_CONTROL);
 
 	if (!inode_permission(idmap, d_inode(dentry), MAY_OPEN | MAY_WRITE))
@@ -143,7 +141,7 @@ int ksmbd_vfs_query_maximal_access(struct mnt_idmap *idmap,
 	if (!inode_permission(idmap, d_inode(dentry->d_parent), MAY_EXEC | MAY_WRITE))
 		*daccess |= FILE_DELETE_LE;
 
-	return ret;
+	return 0;
 }
 
 /**
-- 
2.39.0

