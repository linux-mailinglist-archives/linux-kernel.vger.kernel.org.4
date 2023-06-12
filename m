Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBF772B741
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 07:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234499AbjFLFVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 01:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbjFLFVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 01:21:39 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2092.outbound.protection.outlook.com [40.107.117.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B039F113;
        Sun, 11 Jun 2023 22:21:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dg4kdEDLxsW6xRz+DDDkSAPYIb3VKKo3+kVbdcM9tNsSGJrh6lLuo5X0L+4RW8DFI81swinyOgdLsDVwxG7Dxa81Kh44/wBDXiJwJy/u8tRn6/RxKYjpk1lJKElJ0jfhKzx480kZ6lO5zQvnSKuiHQbj1WZ5Kza0mIfECEH/9lrIWIhWQrJP8eZivRGflDCstGeaL10t3N90pkWGEyY5S+4XZi+hqRBTUFJY2MJBR9J6PXIfRWiCQFhUW6UTgWaQiGOvhujScNHUg44zm5o2bwm+o32b99qJlchS9F/jyULBEXzUt/+0jO0oTBER2PzH4cgDYRdnaZB4P0g7Xyz1Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PvvdKUUfNcJS3nBQv8rvaeSStgeo00qww+sv+7NbkIQ=;
 b=RRQldagPBJGIe4LVegbVWEoCBQud6cQvhCOrytVIzYZBuZT5e0QMejbem5ASMkCPewEyUwY/9E6Ugwx30C1Hkz/BPvLOhI3zth8g3sqfTRKFZ8+sJmo5tETaOCey/S26iFgtV+3/jPl9u4mjouh5H1Kvy+/x7xMfDCZnxZeYADoAGgxMn5HpZTJX7s3JbSJIbMhgEjxv86v4UWKkUhQuwdShfVEaLNWliAfbL7sKGH0BwQfg8HSCtl1wjNmdnWb51CewTRt5ewrLN2/dwDNxDS+jmBxjp9Q2Q3yEnbvlTORTovrl3c7GO5OcXZSDlp5uz3k2L3Q7T5vgotrPVwyjWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvvdKUUfNcJS3nBQv8rvaeSStgeo00qww+sv+7NbkIQ=;
 b=mxjFWikSYGmgfCLebGQBQdgZRvPk2lC2Tc0YKk4ZciEDDvb+CWJFErjnJQy3rEkrp73QgE0pGUJeSXmp8oiqMO0VV8+q8TIWTCv+y8cvYR8Vi2WoIIgElO39l6blN1W2LjHBIZyXgrOR+SviLv2Ro4+X+dXS+VIdisy295FFzhmG/67UiAot/jp+MDubW2xad4bk2xKZHHCMsn32gNKulUEczxv1U6B+Cr87J5CE1qY0EoZq5JXaXNOI0PxLiTV4eq9r6NBCDy0hAE3h5S10ZhQKD4f7LIXSWskbmApfuMMEh1H9BZBi1q3FoVJVeJv3FEBLEK5RgVYnvUpZp9sgkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by TYZPR06MB6468.apcprd06.prod.outlook.com (2603:1096:400:459::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 12 Jun
 2023 05:21:34 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e%5]) with mapi id 15.20.6455.030; Mon, 12 Jun 2023
 05:21:34 +0000
From:   Lu Hongfei <luhongfei@vivo.com>
To:     Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        linux-cifs@vger.kernel.org (open list:COMMON INTERNET FILE SYSTEM
        CLIENT (CIFS and SMB3)),
        samba-technical@lists.samba.org (moderated list:COMMON INTERNET FILE
        SYSTEM CLIENT (CIFS and SMB3)),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, luhongfei@vivo.com
Subject: [PATCH] fs: smb: client: Replace the ternary conditional operator
Date:   Mon, 12 Jun 2023 13:21:23 +0800
Message-Id: <20230612052123.2775-1-luhongfei@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0206.jpnprd01.prod.outlook.com
 (2603:1096:404:29::26) To TYZPR06MB6697.apcprd06.prod.outlook.com
 (2603:1096:400:451::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|TYZPR06MB6468:EE_
X-MS-Office365-Filtering-Correlation-Id: f5c7807c-f047-449f-6508-08db6b04e2dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9tr6aCb+CaKSzGhqRXVgmsbivYa2cBa9D30O1drm/b0gZFuQf8n0PtODaRWFl0Qqs0NkRTytAWI08u3sTx7x1wAmB5dujS8gGpLcIz/tQmtrTeGTUlZccyPtELVc9lqzU8HAQdSpEbh+F8fvLJG01XZ4tBbdLCHQf3svGNf0ew5AU/rJBE3aX+lAL79ZS7RW7HsTv27tFiX/rFsqa1sCe+cFAn3peFZZTWWbeHJN6Dxowu8oDw2T4jhim/8jUOEbnIPwfuuyPkvny08vHRRD6VnBU2Vl68dKYy3DrMX4/7zcfV53S2Y8w5NYAVxwzE6Jk1FMdjmABVjX/bTzfTJHwK/1InlJTWw0j+hxzEku7v+8xT5Rfxt/L91BughFyUNt63t1VKYxJN1TZ8NVy232G3ac6a6Kw/IlXJIZc1wpGGT+wCwDiJlm6WYRhHYZTCr/qcjfFmjHKDpZvqmjQCqzszzd1k+AZGmPwmZwqVNVabfOOcw9F2F9GgP8Z4C79FGR5dYWFf+YdARv7vl3UMQ/cl16jeIo18ImeqJFOEtTdxJlZKfls7XBlM8udwAyoPP8q/VNwf5b4cDpDxbIWryqRliz5J4FXJyipNn45KhN2RirSuanbzbxgnT6KjKRVuUa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(366004)(39850400004)(346002)(451199021)(8676002)(316002)(66476007)(4744005)(66946007)(8936002)(4326008)(2906002)(66556008)(41300700001)(5660300002)(110136005)(52116002)(6666004)(6486002)(26005)(1076003)(6512007)(186003)(36756003)(107886003)(2616005)(6506007)(83380400001)(478600001)(38350700002)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6CWcg9jcy5nKkBk8O1JMfhWo5oOhUc1f/8LgIMODfI3TsmOkSQgjMZQd7x98?=
 =?us-ascii?Q?E++W1g3ozVyJppzii+MmSTqP1aU9OKPrqIZt/YI4tKJ0ghohkdb0llRIxnAm?=
 =?us-ascii?Q?kI1rVPunFcr90yEF1DSSO/jrkjkkZAcrN3B1JXsS2PfpQLy5AgUkT2+mjP/0?=
 =?us-ascii?Q?Ls8Y5OghufctqU/xdpSqavJnf1knY8it3b12mX/T34Tx0ToZ8x86P3sEEFbg?=
 =?us-ascii?Q?h9Lq0vBh14BCCkPbnIiL9d6XnuxPpHL1z0HyIyS1LfRWbcrqC4+jvQ1oSoa/?=
 =?us-ascii?Q?neD9tLrUJwVxNxe2YN2ig3Z2aOAOYerB/EAvYvqA19LPzWZbfKR0seltWeL9?=
 =?us-ascii?Q?6hhVdx7DMwOvRcZYO39nLQPmLY3ZpzAX8/Uu+04XWe/rk40Vp4m0jsvwB4lc?=
 =?us-ascii?Q?KCH0cZy6De2zv0E2OG8YDd5tHgyerqg9LJ5kuhcfb5gHgW5u6lPAc2ZwrbtU?=
 =?us-ascii?Q?HEHqvveUoG4IvuwH1Dpn1v0rDUzWWZ63zeLpTvBiBGOP4Dbnqsb6+2Ruet6X?=
 =?us-ascii?Q?iFsBXmAmrWZCiz75wYXhHB2RnISNC+rIHNQDY77KVfaBRnyCf4nKvpwTbTAU?=
 =?us-ascii?Q?D2PDbAaqBoEdnwIOFD7+rlQPpuwOVelo6aSSMaHd8zcmStXhrvN+BB40EBZQ?=
 =?us-ascii?Q?JYbBXF+mfT3ULsbfry3giTIoCnAO1gSpoohhGv6d9BrRuNZ4tPL13JfLjOW+?=
 =?us-ascii?Q?XlRrLq/DhFpRlS+GuhplXFdpGTUslAWOachl+H/ABxpE2S2si1K0Oeg9UXwz?=
 =?us-ascii?Q?zwchWPSdvAf93mEWx2WaDdmNjUMPZAyo2BTpiR/lNZV4OISsSB8xz1rsoSRc?=
 =?us-ascii?Q?Pd8s6ZAgygT5NqhdMT52tyNCd2zAt7OZjZ1OE80YHoDrI2AdQDMnqV2utw53?=
 =?us-ascii?Q?lIxNyfD4YVu5QBnRDwUE5mFd/Krym3FDBD8pbJ5SZ6hACKmVnVGFo86iPM0T?=
 =?us-ascii?Q?cRjzGBe/OUtKw39SPswEokEMHKI48lH2Vx7jNkAicIml4fGhQLQ71cFbQ/9+?=
 =?us-ascii?Q?1Up5AvTkG/QoB+VbvZBQzA7T8lCgsfGGod1dgILGDyE1ezs2dcCOi3LzFyr0?=
 =?us-ascii?Q?3LphVa1xvivI5dziP3xPalr5XIfJ5epOA2jzIXnt3UWPoAlEtpyFHrIl4+2H?=
 =?us-ascii?Q?OPexghH3KIvtdi5Zv0PGqmYystKIMnugdNZ8/Lf7MLhtYJNcpFSE/9dCbdHR?=
 =?us-ascii?Q?wRKVwGAFlrF2zvEjNokFyYa+wNSxAf67cXU58kPZsRsv2PxvljTzGoc216Vz?=
 =?us-ascii?Q?MRF6y5Yxwni+5ptbBP9ib3DCoViuEq12IJuIjfkITJQpZTc2BSB8XRNgUwtr?=
 =?us-ascii?Q?tpSLTfvazyoPbMXqdDThaWFX7BYQ4+B04c/FpdQ6Eyd1Isoor4puGdU+qFcB?=
 =?us-ascii?Q?J4qZJ5rI2wbtsCuiFg4f1wq2j8S4BFaeKbnZwkP9wOL+GOtOJoIRqjBZr28L?=
 =?us-ascii?Q?ZpnQaAtONOc0H8upAkTXCBfcja5c2Pox8ipg5Aa6Nz1MT9aqVpX/akaiO5zL?=
 =?us-ascii?Q?/IEMxJK7snxtp7rRPKgRRGxt44gQSkKLRZHm0pQfKY5pSUVP/b5juaU1ACUI?=
 =?us-ascii?Q?VhYbJXir5A3FbrXMfEwS0BYiWPQHj+v6/DroytHi?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c7807c-f047-449f-6508-08db6b04e2dd
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 05:21:33.7466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y+2y2hclpQCWfatWy/CJrEnnG9WYwYEeXRlzGBbJYub3qG9zZN2Az9Xoj/cp1Be7UhO28ggRuaF+ybCltMkWww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6468
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It would be better to replace the traditional ternary conditional
operator with min() in _smbd_get_connection

Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
---
 fs/smb/client/smbdirect.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
index 2a2aec8c6112..69f9023f89f9
--- a/fs/smb/client/smbdirect.c
+++ b/fs/smb/client/smbdirect.c
@@ -1582,10 +1582,7 @@ static struct smbd_connection *_smbd_get_connection(
 	conn_param.initiator_depth = 0;
 
 	conn_param.responder_resources =
-		info->id->device->attrs.max_qp_rd_atom
-			< SMBD_CM_RESPONDER_RESOURCES ?
-		info->id->device->attrs.max_qp_rd_atom :
-		SMBD_CM_RESPONDER_RESOURCES;
+		min(info->id->device->attrs.max_qp_rd_atom, SMBD_CM_RESPONDER_RESOURCES);
 	info->responder_resources = conn_param.responder_resources;
 	log_rdma_mr(INFO, "responder_resources=%d\n",
 		info->responder_resources);
-- 
2.39.0

