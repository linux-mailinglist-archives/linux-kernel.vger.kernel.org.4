Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F166C001E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 09:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjCSImx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 04:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjCSImv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 04:42:51 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2094.outbound.protection.outlook.com [40.107.117.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74892686C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 01:42:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJXnn42dupxCn/aHuoPhXc1MJewqxf5DQEi914iewchXmxgf7B4urbDMd7vy2GgBA+InpHukLnptxAcBim1uHM0F/S0O/ig47VMbCrKH1vzV4aUhgjBVAJMqFAC6bfQe30kNOdQaOMlHVOIxrbbwKbvAuOcOTcgH7a1WMF+7BKqTAGQRew8GzNqYvXvw7LNZ/Tf6TUp+mTd2d1jjb+si6x9toOJEcTgXMgUEgv8bHV4CZbxaVZhl6W+hx+9mGQI0Ed36U9hI9uwtnWhg/kagAropb7Jn8DI4jz7DMM7yQrOv07Rlg0eZp3V9HShgdtZPtGoaS1lqFPawvaZcRAxIsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gaz7sro1mufIsFtGo/KmH1j43gttN9A3IKPHYDRmxN8=;
 b=Yb0s7HzDWYBmeIlYWcEdC+zUuwgh8L9PecUrJLscn2tOxqhcBmw0/JGyFliAS8wM6fuYehC5/8WGciNedFc254peauMkfa/Mph82bYpzqFwtZr7ifA8EkUeUEoGm88P4qnlB3rkHFMPlOJ47sbkVjfx8KYFV2x1iSMPPwArhtnHH0aofi4e9hTP8xHkLIOkz+lp5pVgA9oyUFRVbly8EOydBq0IvmDxMk+Xj969rRxgimuuJD8fs4Co2UiGdT/J/Q39jMfqy7RA2gK/yfjpWid3mTKluULdFOYzq14TJ/nvVfU0JzKfUleQCihL9Ru/l+/bWGRUv/25hBMqGCZ3wqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gaz7sro1mufIsFtGo/KmH1j43gttN9A3IKPHYDRmxN8=;
 b=U6V+YN+TCMI1JvM+09xhAPNn5qJLmiivicecQMHjisYYMEqLtBYBY9ZRoaSaSG5PIrKqSrNYL1VYvU8VPYDqFaFj9n5UNBRvwLav267zbhlaM9Ltm9gWMbeebRIdNpvzpEYUnz3ffoCMorwgAxLqdmbkDwEKMGVhleOJjrJGoGbR0XVycABs1lO2+bxpP6/5/oS4CFLYOQCPGA5ieAoZA1kmBMvOTKvxQffF0+7KtZyMckDiDWpGnZtXIyGhkZO9UGEXsEpko9o8C9YAq2lZO3tvwPGuZvtPciPW9oV3XAzwaW8QQjNHMNRii5a116jz4G8cSRr8xhOlDQHdk0K3Qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5350.apcprd06.prod.outlook.com (2603:1096:101:6a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Sun, 19 Mar
 2023 08:42:07 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.037; Sun, 19 Mar 2023
 08:42:07 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     Yangtao Li <frank.li@vivo.com>, ocfs2-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/10] ocfs2: convert to kobject_del_and_put()
Date:   Sun, 19 Mar 2023 16:41:31 +0800
Message-Id: <20230319084134.11804-8-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230319084134.11804-1-frank.li@vivo.com>
References: <20230319084134.11804-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:195::20) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB5350:EE_
X-MS-Office365-Filtering-Correlation-Id: 32019a8a-39ed-457d-5b04-08db2855d251
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ajOiPF8D8AeqrOC4LS/FV9TLlRp3sXOc1Vrd7DVy8SsfK+W9EUCzMPnz8vFjCAZwsAdyzGRIrBGv+t69aPf+2Zvn7MJIF9WqF3AzQYqGgpv29l+akxAYvGjBOUMPmZtRN4+KIU7TGe5iR7/MxDk/0eN6VyYy7XU7irqeVXrPjQH3DTkB6WvbhbTRURRthhmPs09Sa1hF+hfIRp9+Y6Hsnc0nVmof1HD6I6xQIFoJL3yRB70BeFB5tqgJjdTsbJMzeaNgMbxM/RFd5N2th1mtUJMSZBj29ZTg6sl2bQzsJ8lTxlAwdeYKkZIP9kFA+Yn9shLndlgno0MZXIYM/fzUegSU3f+rcNueF4aQZWpQ0mdELp/+dVbzX353qUVTbUTa0+ZzsNbxUWhQsUemDLGEoX6ZzqQ+7gLhk288yDXSoD8fUFw4zTMlI1UifQDSQdfZHReFGJEnjV/ZtcPDKKMbAouG8m/O4+wNfQBha7tcZg8HF/ez8Y8xKFgiLB7/04Wuaa+NQ8yIuH4Eb7Z2YM3rYMl8KRlntXAnDnt6wQ3ucvxV5BzYIrhYOB45Ql5Bgc5iVCKb7WaYtz0Qsi69njwx4je61IP+B/rXt8+SnydhfNN3L1K2RGDCg6OJ1An7GGLGEWiH0FyivJfvZaIddHg8MGZ9q0RYBc0x0G9XRRgMIABan+YhyD8EgPteDWG074MlT1hJGtMtxa9XXld8wB9n6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(451199018)(86362001)(36756003)(52116002)(83380400001)(316002)(8676002)(4326008)(66476007)(66946007)(66556008)(110136005)(478600001)(186003)(26005)(1076003)(6512007)(6506007)(2616005)(6486002)(6666004)(38100700002)(38350700002)(8936002)(4744005)(5660300002)(41300700001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VlU0kjacWlZOW/0rCPcU3wNLD4fttd161KHqZxuWXlLSrZX+7hHfrQTkdC8m?=
 =?us-ascii?Q?aYWr9klOitjAl2FDKkwEkepPUj4WesqnQUI1O7TxwrIQtFA6x92XpWrhGqcB?=
 =?us-ascii?Q?xhUurv3Xo9tkKHUUrdGTwWgPA/aTZH6U3Upqx/ayHGZ+bMN3XyzrkwEyL1zc?=
 =?us-ascii?Q?t942F82EIyjZthIf9WU1OUfdmrkKFxSF7jGx2pQhv84LZfRkkOqecfVQyUdE?=
 =?us-ascii?Q?kqpqbjlPZ4GapE1W6/kynRkArFyITAov7hVhbIO4nbUhbkEd1f0fwQpIgb/w?=
 =?us-ascii?Q?j4Q0MqoUXmqTezEGtNE3XXDN+crGWrKv0S+ByKzNOQrnY3zXNNtEvqI8Wq0H?=
 =?us-ascii?Q?fQpUDBkCq5WtRbJwR5qBYXnzpCCv21cw9IoC79Zokn0+stQ9VQtqTafuvX0b?=
 =?us-ascii?Q?Nro2seUTRJwdwvG5hGM9woiffbEAtNcpFbpdZPCMHPOyhUzkGX3DOSEUjlj+?=
 =?us-ascii?Q?5u66wP+IDY3w1rDX9z3C7wJs2RBFXkETuXDtxHJ1/TbkvlkCSO0XFD8tJ8l6?=
 =?us-ascii?Q?JH9IYMRfMtYFEQY4VwtUrsTgOayLKHq/8lXxKwVPUPUjWIyZjOc7H75VUnUR?=
 =?us-ascii?Q?/PcYGCrHLdvZtCKsMSYgtpJmRBQlxXplMBm5NXTwEZzTy1G65rztfc5N5Siq?=
 =?us-ascii?Q?jfN6EPygypTx/BPiik8FCh8m7pNVlMvj6KlD+m8ct+vKC8b2BqTttEHoiAxk?=
 =?us-ascii?Q?Tf91gi8KhZOMwtf8b4BcAgN2a1laLMzHacdJBta2TLzyYizABt82AjP8J3PO?=
 =?us-ascii?Q?rFqhi5nFphq5nCwmVenkugSLeey9jiKCxu96ZMlDC2idjkYmD1ujYEfkTKTn?=
 =?us-ascii?Q?mBqndmkHgfZmU9omE+uE3V8hSAtqX35K3do/dg3CSu3A368zxfUg9wRKTQTX?=
 =?us-ascii?Q?Q1kWWnP7bQQJsQoxXM82whiitAMHA8NC3UqOcj5aM6DMomFjTsWWYZ4iqFQT?=
 =?us-ascii?Q?sjVtMZYuXqbgLCW4tZcsTNm/8OPms9Q9fn4Y/ZHJzCtupXOP1fFfxMCHtb8g?=
 =?us-ascii?Q?27qysESvABCRAjfgqHq6t+92rNbUjPHRPB+wP/LfxYWntUgPDJIPLGncXNog?=
 =?us-ascii?Q?G0lxxqf/Soi3RNfBttmeKlPC8MO9EZaNIH993D79zYuAFi8FCWpXQluAflu2?=
 =?us-ascii?Q?32tD/vHZMleGiNcgAw0FwRNX2JMqwzSceW3tJ4hrYpw5ebP8MXvaEFqKLsYO?=
 =?us-ascii?Q?pP+2sgfPATttd+IyywZAjjiXgj3efgs9gVvRvJza663bSLvF4ZK2phioMnHV?=
 =?us-ascii?Q?hwe1g4adU4N3YQ/WglWbgH22o6WuXnJVEOAAmxVhbf1QEV3Mku2p07tOKMOf?=
 =?us-ascii?Q?ieVSB/poL8pb/wtM/diBnQVSCSwkSdnBPeOaImgG9m0MR+jo+LV/bJ9XmAHu?=
 =?us-ascii?Q?+QZ5T4dCgLt1GqOF06q7KqhC/dHhly1qoHqQG1fUoSoobGNzXnUnPdixZsa+?=
 =?us-ascii?Q?/NRCM7Dhkr1TsxxmUZb8Zqqg0R2fsIK8gt4vDDgr59aJuc9io9v19n6BLSTx?=
 =?us-ascii?Q?Z55fqe4A0ojZ892pXSTGlUOyYZGdvTl/Mu9aA8Rm+HOqYBLxrltGZjT1vzNR?=
 =?us-ascii?Q?7mjp94V65G3PTcUEicBbYLjgdgg/izmzN47zsdI+?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32019a8a-39ed-457d-5b04-08db2855d251
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2023 08:42:07.0653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GvtUHCsDKmudGeN33oZdCIADbe75NO6GjYl/GToOAygYWhYUftcojTxBoLP00iuakud5DOUWfvS5BV5eK+dIqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5350
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kobject_del_and_put() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/ocfs2/filecheck.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ocfs2/filecheck.c b/fs/ocfs2/filecheck.c
index 1ad7106741f8..fb9cf601245b 100644
--- a/fs/ocfs2/filecheck.c
+++ b/fs/ocfs2/filecheck.c
@@ -198,8 +198,7 @@ void ocfs2_filecheck_remove_sysfs(struct ocfs2_super *osb)
 	if (!osb->osb_fc_ent.fs_fcheck)
 		return;
 
-	kobject_del(&osb->osb_fc_ent.fs_kobj);
-	kobject_put(&osb->osb_fc_ent.fs_kobj);
+	kobject_del_and_put(&osb->osb_fc_ent.fs_kobj);
 	wait_for_completion(&osb->osb_fc_ent.fs_kobj_unregister);
 	ocfs2_filecheck_sysfs_free(&osb->osb_fc_ent);
 }
-- 
2.35.1

