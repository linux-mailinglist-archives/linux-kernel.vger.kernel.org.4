Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E51A7505F1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbjGLL0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 07:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbjGLL0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:26:17 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2121.outbound.protection.outlook.com [40.107.255.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D74DE5C;
        Wed, 12 Jul 2023 04:26:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3zFAALAyuyczpcqjCPlVqRsZQfrtrhtg1oYkbBCU3ETJIqOnJNqecwvc0fk+gJaxkdVwa/9UZQGKnkez2F6tnUVf0vRm6N45geVDzu2cFMDd8ftjcg/SyYD4ASXjrBevVJMqc06cxCBcFkQZnP9zcfs4rBREQnpZ1bEmphUL0tXg0EQ+Gz4nu+BTpwudBYP8W4GfZyw6c30SlaXucoUU5TO+3E5IVOfIZ4H5P9rNciY7eMlihZwKoDxKVWctJ4DVOUYHq3rM5J3NCT1xnuo9bCF8hFIpmPkHmDs2+xuG3hY0cR602ea/DuPkZY+tupISv7ALUWjqHdTmYEsIMF8ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1DTBXf/4vDCbwtE9Gs3NN2Md/C/8ipwaa6GRzVMGogY=;
 b=RrTleB8y3dsVjCBldEb6D2caY0weTPWD+yyu9GhuAKoUDhy7Fr3LU7nC5e620IzsPFnAde5kDbjrNJvSQcX99WtaLaqaLGlmjJQ1A2RcnfUDMzCr1Or3M7/TPrRZwJQZH42FeScJgRVpU9PrkSUcM0EVR2HgR90dIskY+mEBLnww0a7y5Xsba+mqsghZyZfM7Yz3+mrLaIR7PnpxrjIpKhhYeHhKFhnnm78/rlF/eiJqNjWATD35kH+k44BbdcaO29V8bP/WT6Oqy0l0LvoznT5nTUDgcAyLTU+EQ1m5we1MOiIG5LA8LjSbSQbyy3avxgOVFFIBY/aNfG5XxWXi9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DTBXf/4vDCbwtE9Gs3NN2Md/C/8ipwaa6GRzVMGogY=;
 b=DUk+1WWgQyaCRnZRRG3uknm0a5iw0/G/YzDm2M9v5Uq6hksqQTXXo6YTznYjEE9WhnAUryaJuqA530ZHCpjus575TGd7JxS4wTvvbsgK87awWMElZ7p77oB+BmjEHDrsoCBVzpTqLBvj4/PUyur5koFWZSmVkPz7P2ONg5t+LOc2QcXZNqyt18G+5AjY2KLBZh4qqA1FX0nwnLcFhIa0hKRWuBvj/Itp4eYq8nJptQrg+NCCh7y5g1zrDoNwZZKG+z7ZGvj122+DK1zznbNarR8JUpQ3rcYfBUU9G4/y0w25XS7qsvMKJ2WR7p/ZnYyJXD8UG1BBtKUr1AbgR+Ui8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 TYSPR06MB6713.apcprd06.prod.outlook.com (2603:1096:400:479::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.32; Wed, 12 Jul 2023 11:26:11 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a%6]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 11:26:11 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        linux-wireless@vger.kernel.org (open list:MARVELL MWIFIEX WIRELESS
        DRIVER), linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, Minjie Du <duminjie@vivo.com>
Subject: [PATCH v2] net: wireless: mwifies: fix parameter check in mwifiex_dev_debugfs_init()
Date:   Wed, 12 Jul 2023 19:26:03 +0800
Message-Id: <20230712112604.12572-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:3:18::24) To SG2PR06MB5288.apcprd06.prod.outlook.com
 (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|TYSPR06MB6713:EE_
X-MS-Office365-Filtering-Correlation-Id: fcfa000b-1cbe-400b-4667-08db82cacbaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hrUipCblrx9YgmUjCRwf0pgKug1PLAsSASskwNdj3a29P1iHM9Jw8+k1IufSj4sPtZsooo7jdNUW0bwwp3xbCXyOPfdizqMBnTD6Cwb6CUELoqATl+U9bPch3JlWB7/tXywN9s0KUDDGUW5X0trK3PKhQtsWK/a7hCYQtrJBV4J9AQVP4Vu0OWBaDQUaQj6ls5XLa1bksw+RLv3IbZtyGU9r3nHcsrWJNHpabPo+tDzTz2GnP/L5G0BuncOXLVISrplqBA+As02OutChfmOZv7BGGmhUB6hYJIwONo8AvKDMfESMAZeTi0lBrCmRliMmstIyvg1VwlWB8XXlr/9ret8QonFnMZD56TgjjsV3zI1Ob+sNTF9Qz7ThCQn8Fgv2+e5zmv02YX/YNxlMX/znuH/Cgye0O4AJJrcBp8ViKIFglkgvoptqiBYqNquZd1yL91LVIj/xGJSJsUPTYc+NTCVB8Xbmg+akGGt95APXUjdCGtk0JanQ7h7gjnVQkIbqR9nHVMcMV09f9pMzliAntN/tsbMCR3RfE6wP9qed8UNQYVCKbypXzOeVh7HNgu5JvcPAnmkt0iSYP2elfmD/FRjk50IXQFvOnTwi8/Mdt0x3qUIMYG9Sq84YJTRRx9+a
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(136003)(366004)(451199021)(6666004)(186003)(6512007)(478600001)(52116002)(316002)(110136005)(66946007)(66476007)(66556008)(6486002)(4326008)(41300700001)(107886003)(8676002)(8936002)(6506007)(86362001)(1076003)(26005)(5660300002)(83380400001)(36756003)(2906002)(4744005)(2616005)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EBiWXec9lfdCQ4kKyio5DQjykQO+VedvmiogKmzqT7LHRc0+fQW2L83JqE+T?=
 =?us-ascii?Q?rjVjQLAcyfusqYXmQB0XpkoWxdfQP1xNMm4YU3zTN5/QXDxxJi1juhidi1Wm?=
 =?us-ascii?Q?fAjJi135VzYrk3oEMsKQXcU17DMUeVgZEG+zE4nDcL+TqkwBKFCdTK7MAN+S?=
 =?us-ascii?Q?g/JpxnUJjfc+alQ7jqWp0aaBWu3rDQuUUtoixSvZEXv/aJwFiVZLxKWz12Qh?=
 =?us-ascii?Q?7MYNYg+MIQaePwOfVCt2zl0j5IU9RXEIcLKW8bacUsSJUG1Evlyta9Z7Lyh7?=
 =?us-ascii?Q?Hgqs0LF1e9YyxeUGC90OzLXd+O5R5LVAT3sHKg60/+EDbSMzfIwhLZA5IE5l?=
 =?us-ascii?Q?3D056VyFDdHeAig4+DJ3FJj2yO6Aj51SowDp0Ai3i2z6c3xmcFbo/I0AxqEe?=
 =?us-ascii?Q?nt3YSVHWeEbavS3BrJpFApx7Y7WEuRXsXeh1dQXoB2L47d0IoSIzWVmUkjOr?=
 =?us-ascii?Q?5UiGobMRy2kmyTVwNQIect5neYIz92lXvB4StBG7bcRKZS5j83xf+CMOO0SJ?=
 =?us-ascii?Q?Yz1j3ofSucUmS74xqwQ2LBVjHmyVRXp3USGogTk9ReE0M6HSRzinXsIZ6M39?=
 =?us-ascii?Q?M9n5OpzLVeHZ1D4VYDc5EY0XuANgc46RelqgPGf0XxSJfrB4DpK82jgdy27z?=
 =?us-ascii?Q?2WvH6qClDB59DJumCFJMnsqvw8tlt19EAZzJmEYvEPHe6lAIumjqNuKWDYCU?=
 =?us-ascii?Q?RZU8AOEFrKcgB22jxv0OCWr0gTReoguCqn4VT05LbZseKpbMOTLdsM52e5nX?=
 =?us-ascii?Q?NbfsxqqFaSDoB1A3Qz5HHZtGGe4l8/HJFmrTEVaZtqFU61TlfHbPU9Yw2aKM?=
 =?us-ascii?Q?fNpyLnbZzhipqQf6KtDYbcj1rJrtjN8Wudv2aJqAK2CL4bIGNn6tTTp2418Y?=
 =?us-ascii?Q?MzUlG9sHqpQts9rV/eO/7O0HRv7CWPLjTS6aOEbbRRmL9OZ9DAaAUL1Ujh94?=
 =?us-ascii?Q?+zGq9BsXVvT1YeHjEt4aoh0tyFatnePY2smsoYcpa+0lRdCW78oqV9rC367J?=
 =?us-ascii?Q?ZlBaq5S94hpJLcct/7t0/OfUasagNof6R37HTquEj8i8lblqgRdT8Wm/AXXz?=
 =?us-ascii?Q?3zRx8UYif4hRQez5bygwEmP0lCH+4J+/WT79RCFh1YmCktqjcf+/J2UMWuDw?=
 =?us-ascii?Q?APcwWHlYl7M2PxFT0Azj3BolxtZjqor7dIwzSCDjIflF0/I5LzTBJaQCiqfA?=
 =?us-ascii?Q?C/BqdrZAy7+0AADt6Ri8xA0OrQi5yTv7xeLP+8fIhMmn4h1oxC8YA7N7QyhM?=
 =?us-ascii?Q?EqziinfnhiC6J0j9YF8jDQLS9Pe0byNxyMBqVdR1wVc8QoXPDQGFYeZPTdlj?=
 =?us-ascii?Q?i0QJ0PhsUUt03nzI9beZb9rUOdeiBnTssLbf//zulN3/MJWpOZr4hqTzeMiz?=
 =?us-ascii?Q?f/7QHm9P7uFm744FHhKiZkbijkBL7V6HERPZ+v9dKDNirtFkWvkyZeTl7Y2K?=
 =?us-ascii?Q?RKlDZSW2N9CvUj6O+9XK4vWGlVEcTwk8M7v/tLgUZCw+u6N6OV//nD1+et/h?=
 =?us-ascii?Q?yqQeXhIJEPfi0KnzvRLLuNjbMH7I0agRSj1++gg88qsJ9H+aSCy+hAji9313?=
 =?us-ascii?Q?GQrb9LEePfttJaypDAVPeDEgZtnq1lnp7Pg7ltoa?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcfa000b-1cbe-400b-4667-08db82cacbaa
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 11:26:11.6371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vneDq8FZAm8KkWh3kvWIgFzpgB9TllBPkPUuj6ZXkRueKZ7CAEDJL6/6W1Nyz6gd24fY04+Xl2OYCe5lSFYDaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6713
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make IS_ERR() judge the debugfs_create_dir() function return.

Signed-off-by: Minjie Du <duminjie@vivo.com>

v1-v2:
Fix judge typo.

---
 drivers/net/wireless/marvell/mwifiex/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/debugfs.c b/drivers/net/wireless/marvell/mwifiex/debugfs.c
index 52b18f4a7..a44bca561 100644
--- a/drivers/net/wireless/marvell/mwifiex/debugfs.c
+++ b/drivers/net/wireless/marvell/mwifiex/debugfs.c
@@ -959,7 +959,7 @@ mwifiex_dev_debugfs_init(struct mwifiex_private *priv)
 	priv->dfs_dev_dir = debugfs_create_dir(priv->netdev->name,
 					       mwifiex_dfs_dir);
 
-	if (!priv->dfs_dev_dir)
+	if (IS_ERR(priv->dfs_dev_dir))
 		return;
 
 	MWIFIEX_DFS_ADD_FILE(info);
-- 
2.39.0

