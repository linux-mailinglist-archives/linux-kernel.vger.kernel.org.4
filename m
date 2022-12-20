Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5940165269F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 19:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiLTSzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 13:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiLTSzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 13:55:14 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2092.outbound.protection.outlook.com [40.107.255.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAD91A3B3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 10:55:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NRetAC8GXzrZYqcjGxPFx/tIpWyOOtvo2Ghts4/3YZHvFNFlpbEtL+iRZ6Xcbg4uIINiQ+ymaLMut+ksBoO+EJxS++tmg6sqHzkMwHFCxQImWdnRNwuJhTjxpgpOLP+CBf7gZSDzUqIWOpYsrCh+g7DpV47+SlE27MDUvTxKIvHQIpALGHc0f1qIHHrywIvvVbmJLQ+yohRVkb7hE/zfxIvx+utixdY97oM0ckswSylt/2R0qf4FVW9SMrfXh81odvqEXS6DIHxhXfH1QfZ4SQUdNavN52ru8Lb9MfjYxGvYnIB0NstIT4xw59HwB0qt8suGCFjXyMi6EyvVtHi9pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hlYBh0y0FcLRb0xMOAPnPQk/aJccpRT4LiAZomTRAJ4=;
 b=gxqXiCx92GbR0hZ9WWl96F9V9HzkcfAKFOcO2Iha7qZCFJ+kTKGWjMt1aHFQD03WQGCCRPRYCQ4VLtAii09FmRILLgwePb9mUSrslyzjVpivjc+VTon6FE8sVc9Xxmhk6YcjdguI0tkKQHAQiw3fW14LNglRI8z3czZb5tcdXRtShST9D7rImbj99B7D2WSAIgputpzk/UlZfU0rKg7PjB45fpRcTgwfpi9laO4WIgd5/VR3+nJBnkNzwZXcl8PkGniT9csAknb8/mWsYLBcuad0dOwBLHRv0t60sK1GR6heI4rCWJoMCKsAdITV/Jsw0RM7SxHT87QfvfExhZrkpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlYBh0y0FcLRb0xMOAPnPQk/aJccpRT4LiAZomTRAJ4=;
 b=Ln61Elv8CHI1G75+YBA3A3SsjS3cIT5ExCK7J3VZMIsai7PT/bDWiL1Qv6aizMfZtXip+0oVRUW/43xrTxTwjaM+QU70hF4Wj9A46su37ZJWVxjZoeFfDNSVcK63kyBzW+gfSsl5hIh5EF4IhF26YfCl9PhDpEzMo7eRQ2RWdnXtT2F5uybChj0J1Z4Psw+tMDFU4qWvBF0cDbL1K8/k9YDmjOXTUYjkS5fDiuBEbHLEhKn24JsJ2hAR5re8Y+IuMwVqXXE1mcMBLsn75wneRuis7ecnRwjMecuVARZ3+r3JQhOkDRz18z5E5MHpipJr2QfWL1IQCRCtWH/JaSrOvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB5227.apcprd06.prod.outlook.com (2603:1096:400:1fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 18:55:10 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::ef03:cbfb:f8ef:d88b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::ef03:cbfb:f8ef:d88b%9]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 18:55:10 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] f2fs: update comment about f2fs_issue_discard_timeout()
Date:   Wed, 21 Dec 2022 02:54:59 +0800
Message-Id: <20221220185459.55950-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0001.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::7)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB5227:EE_
X-MS-Office365-Filtering-Correlation-Id: e112560d-3051-4d56-2365-08dae2bbb843
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0QRjDmUic+WcdsPzsCVE5mr0j9fc4RvRMPb/XfIiXJvH44bXAdia2+jPK1QA/8JhbWdhDqvdtkqZ94Zd5wFNuPOlD2KE4NwIkZPHb3Ost1IZb/QWd/s86t7p0/C9Saawbk+p9FjCWc7Lcmlc1hZmgyAKCuj6YQLOw3b7q0qPjShKLacojmNp2a5trYHRClLgZdjjohWvOiNshMAJXwKBKSxsm2mW27KN+hglud367HcLwuVak0VRyxN1jorva/AXGKvZSCwlVZh3xlLCfUnarNumf/34CgvA6mrNVuDSkNr3ulBdT9wAwWZD+aDUZ8OgZvgXtYyn8KeT0nWHP9S5BrEvI/r9oECBTHdZy/csZqD6y02xC83WYiNqzHnU6bERjPRKjrilEDDUJ3Mg7JirGEWAFKEYu9wRVAPZg7KxHZTTkG+v3XOxCkUrlslwVKxoXhuPx4DyYeKwDuVWfmZrOhek5w9sL5GvKAZ4sjSczvTaTypu0u7VOxBYJ25KgbOzKRltSm9UhTrBk7wKlf2/jr0N0fg0CdMaoi66YIPAwjtTjxc+XaUNEaXiXUPSCiuDfC75FMFKDwC3GWk/3OJqs7fy7MZS2H7PJJEssaWQSA0yT6GpDaXP4hFG+1ru3xf7cMd3+hoXv/VOd2u1RwDkdPnk2xKYZ5K2i3y7iqwPzYFtb6feThZ5DkreuYK9nzGPJtsXVdvcwJaoClcYPG0aIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(451199015)(6506007)(6512007)(6666004)(478600001)(52116002)(107886003)(6486002)(66946007)(66476007)(2616005)(186003)(66556008)(8676002)(4326008)(316002)(26005)(38100700002)(83380400001)(1076003)(38350700002)(15650500001)(2906002)(41300700001)(4744005)(5660300002)(8936002)(36756003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RN1u9WrVtG4raNsRMRTNZRW5s0KzsQ9oL04WDN9KlSnrs29WGHmFrD4Urn+A?=
 =?us-ascii?Q?ohFyrob+7loOPgHnkbmgkDvNnHp3Xx9P36VCXskT1lpwCeRyHy5SDOMGfm3k?=
 =?us-ascii?Q?LYk1UsUn7CxDW9KA2ZeG0Un7Zx1MGVaWBThXW7hVwdCucJMtvZltdmH2QqS1?=
 =?us-ascii?Q?dJ3jaPnp7QtMDXoaGT0xib73xtVUHdyXZM1GM9WngdgHHdc9mWdWmCn5JUPL?=
 =?us-ascii?Q?ygvnFtaYwyIS/DaGVn+nBQMghsO6nJQHBX8e97q1C0+v1vc+uW0/Q2dMxkg6?=
 =?us-ascii?Q?ckV6fO80pqHnfY8apgbvzqZm1i2r0sop+90uS0kvC7wToltMjgPpYUJh0dx6?=
 =?us-ascii?Q?UUqZfCgR+HBZNc9eTeSEOIkv8W1U1m3f30ciXVZKueNQrFtSH0BtC3qyM7Ju?=
 =?us-ascii?Q?Kuxm15QKANv45wHrPqwjSQTyXvhNRG7SkUnl49iROwibEz505ClYNx7Ez7nx?=
 =?us-ascii?Q?c7nAI85Aq75Ncb3NCo00/bZo0mvnNji7WSZ8fGoIv8AEs46Vjs/yx99YAl8Y?=
 =?us-ascii?Q?YcijjNWVihfw8bE8i+ySa0ZcsxsMJ2BLL/tYCaxV8ATPzvn0iwNT+EZeRqdU?=
 =?us-ascii?Q?LqpM4euWJLcTRrjfMfECAo5LuH1JlFx/HmDYNfBnYz00ip8wpcuOil4FZk/W?=
 =?us-ascii?Q?/iZatKfyYjmutP5LSPf4GdZucyTVZNwMAkvcD9laDN/jrYf0E+ZwnFtMO1Lm?=
 =?us-ascii?Q?6ylYYV2nIjBAYSQKnzNHMUcree8SrO0Iukx43/sA52tEzkYOfOKwj7l42dzG?=
 =?us-ascii?Q?oJEdD+h8/btRnvYbNUJP5a0aVwySAZZL1cL9HbioBRpveDUGrrrJkgKqRQby?=
 =?us-ascii?Q?Ufn7aK0Fsu9EifZyPgGF/vJXN2rxeo1GQPMlSM7zEASDg/5S5wbM2NxD4Nfq?=
 =?us-ascii?Q?lS9qhDGenAEBeQeGRaISqBvR70xueGfOXly05mrBC9FULWTWHnLp+oI2IQtN?=
 =?us-ascii?Q?W/y/xo+O58jYFUPZpSv0dq6ZHhCcNqgbxZxH1C5ZxEf922gETwJgGhLP0DLl?=
 =?us-ascii?Q?N0sGI30NeKtcJ9L5/l3Mqn9cajc8VjV4s8Np5n5pz+poMglD8RKAIRkPW25k?=
 =?us-ascii?Q?gAlkOzUjrMh5JF74E5LyrFx5s3Eppxf4zVxC7XIlKbgYO37dimK0lqGhDh9/?=
 =?us-ascii?Q?6fFV4TdQ1hMoVnXNjPYrNEhhfOh3TTurapgPBxYOC6Sh2SjVhHEX9kdtvHmm?=
 =?us-ascii?Q?dpIsTcm9pERvr1ALO7LIcx+gDl5mCHh7jzoRUYKmxPtQNW013AJvifPiEMQA?=
 =?us-ascii?Q?N3thbfJVNSer8wXejtUOXtQmx1orhJjWa9mMDP2EOYBTKpqVI4JHHINNKgyw?=
 =?us-ascii?Q?e+ajkDGj8ti8gAUXpsPOtwepUK5WjGN1POXtDlnZrnKKGsG3dvbZgJgX2gYi?=
 =?us-ascii?Q?7ZwqpXkrB7010MIBu11pjW8tNsxK1Ah6skbr5fVQxlk3ANCbrodB0Okmp3Wa?=
 =?us-ascii?Q?rSTYDACnlWkjfbQv7OqGb/06/FovxLsAst5PQGlHI/HA4F337Xg6ie18ixGw?=
 =?us-ascii?Q?J90ZrLRIFHwCuys0KZj4v7VCFnRh3AC1vNSDzbKn6ZdOxgkuod+yWfAMxe/Y?=
 =?us-ascii?Q?nw8wkWcsdlQzmWSdVfvE1jDA/Gl4cXxCXQrXb5Dp?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e112560d-3051-4d56-2365-08dae2bbb843
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 18:55:10.6859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DmbxiXRip0V6BSGxo2XwPm/h8TFAcCjcf2k6jBtpz/AZCGFs2SFmQwcZUMeHqald6qa+9jKJi9chi4k0qkhIpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5227
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 4d67490498ac ("f2fs: Don't create discard thread when
device doesn't support realtime discard"), f2fs_issue_discard_timeout()
is not only called by f2fs_put_super().

Let's update it.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/f2fs/segment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index af2d522b1a89..fd3b16f68ffc 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1654,7 +1654,7 @@ void f2fs_stop_discard_thread(struct f2fs_sb_info *sbi)
 	}
 }
 
-/* This comes from f2fs_put_super */
+/* This comes from f2fs_put_super() and f2fs_remount() */
 bool f2fs_issue_discard_timeout(struct f2fs_sb_info *sbi)
 {
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
-- 
2.25.1

