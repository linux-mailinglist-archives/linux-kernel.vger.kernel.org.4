Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C220747057
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 14:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjGDMCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 08:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbjGDMCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:02:35 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2090.outbound.protection.outlook.com [40.107.255.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E11E6A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 05:02:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+W5tZ7El2B0nmQt5CL6y53TUMJDRgTc6T1t3BPt0l2bFFy3IGRGa/lOMI1/k2PaEmqjEVgIFWL/UzBw9HIgxWawYyvg0WK2QEoP7fYzTbjGKk8SxiBbH7TEA7AVl2c+MRyQ6LywsEI5v1jjHwvuLnMu2nfkKKHurltydQEiGEN8QwX51piboK5/GAlsO2tabhtGppvoIpgSbaJBsjy8E6OG6IdO6fEhPA0GerAudviduXMslPhvZCMt9XC5qRDa/16FGtKAd5aadoqHKWXW1VMQiSkZvDwj0tVSEM4tueFvbnHZM26peIqqV7AC8AbK/Z7IVCFAH6VOFm/nTNJ+TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ey8x6ahxv7hVTC4qQRpYkZKa5U4pD29GdZ9WhcRHvKY=;
 b=EiTIDMjZbZc0UjFxNTrO+SKTYI+Dsippuo2d7IeKFhiZVCORwGRDyR4ZODW7A7Cenysj0HkkeefOvq8YpWTYiFo5FIpq/LnlWU86cqipSCHfsnhT9GWv4P1uha1ZRKPWyj0B3gQBVlN/6sjM6ezUYa/YRj/O+l6FiNSgj5wHtXX54ueLh2lmcsz5l/tnMSU/vVsr3id7UQzfemH/Qc9t6GsVMsKGeaMSMpafAdhJIdKQ81a6hPMHn8dLJwPTA/F3p/noEH0vfgmkpnSHxCmXYTdXLeveZ862/+QYl3uux6pRDhYhQWZt3E28DLM/FF8UUA83ygdck2C7FOwNZEFDYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ey8x6ahxv7hVTC4qQRpYkZKa5U4pD29GdZ9WhcRHvKY=;
 b=NFnx7x5Kqc3oxEkuLb4cKIVeuAcqwCtx2A5QM9kVo9AOlmlvZA5WA8K/oKsWVjwzIm6nnKNk/d8kJSy9SsBaUdrVX1/8KvfhQAzlNlrPRbxDKAaYvxTF9qNAAE9VAjcuJFwgNgLXt4yoSVwmODlIKJgxAz4s73pDxFDgs9wqlLzHHDP/MpfQ7U+TBlFdyyBSMTYdOHiuaS+leDV9dpjQAjtMdAvx+lIMOSIrsnrRxlemUuJtxPOFgbcEh4u/cWGr8P+R9cNioAedCP5fpIbxRgvh/ZIn0jfx+n6iMPuzy2xV/EzwscLzJ8wtVoIcc1vusRAvbm9lCZEBImVznh851w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB4999.apcprd06.prod.outlook.com (2603:1096:101:4a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 12:02:33 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 12:02:33 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Qin Jian <qinjian@cqplus1.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] reset: sunplus: Use devm_platform_get_and_ioremap_resource()
Date:   Tue,  4 Jul 2023 20:02:10 +0800
Message-Id: <20230704120211.38122-6-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230704120211.38122-1-frank.li@vivo.com>
References: <20230704120211.38122-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0144.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::24) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB4999:EE_
X-MS-Office365-Filtering-Correlation-Id: c5ec69fd-1825-41e0-04b5-08db7c868c93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xMNs/BWBhf7Gh2QalACV9HlLtveM2j4Drd5S6BAWpwMLVrEEI+HTq7kNEdw7IHA7yQ6tnNTaBrTrbp90aXjWBYd+GgY4yXqNPewxkNCHeuG0eAmBn51LhRyafjGXu3Z3+8CndIJLZiiIY2u4OoLsS7X/sZnof0qRKLVDppYNan2EIWumLXr+oSZvTfOd2qZx7EhmMd78qF/wfe5G3qeoqKhHTOQ/pGnZORQCupbnL1wcGQqvDdTOF8jpAL2ffCTr1aVcRlgXZ8ZwxYEITBuMHuQjx1pCGrvnMr6SqnmVyTsvLv6bFurm9rYrUYT9IruaVXtfCGnNhL0fXoRaKFRs4QDa2D/qhCkW4/Vv0Xp3SQiyxgxcgdvSu//Ili5GwKNIN4UQIOf4lwEyEQjitFerqZzP/sppbzABUIRp+CSg8fK9HyvYha2evgALD4ZgjfTtR/mqNdCJ0dNBCt6dGfyIEmZ85cKENH3wqDiaHbrya26djkxpZ/BmuO6bSuwg4FxZ4dZLDaIfJCwt+rLCGJ1VD84/T9GyfA+OMTKj4wiX3XBDV9S8miTukp0wGzlJmgtOOnKg7oz4kJRdrYcZA1ykD/kre+SPSNMa6Hdlcm9cNw9doAZJFI2tPlgcaL8q/VFI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199021)(6666004)(38100700002)(52116002)(38350700002)(2906002)(4744005)(6486002)(8936002)(110136005)(8676002)(36756003)(41300700001)(478600001)(5660300002)(66946007)(66476007)(1076003)(6512007)(186003)(26005)(86362001)(6506007)(66556008)(316002)(4326008)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tqVpK5Vl4cC1BpD+VWEF/njXDeZh+/+ILJszKT8VqO15uIO4sauhyH9NE0Vb?=
 =?us-ascii?Q?U5VouzeqmvA2dWkzcj4Mr/AmRpV2K1W/N9oJtyIF4rIuQQfbqAgbBFBnpeFT?=
 =?us-ascii?Q?TJzq+RPVNveJyRm4GbPT9p/Zfj/vZZEb7Tt4V8Ri214HRhEVBCh3NC9U8XQQ?=
 =?us-ascii?Q?updGL+Z0GKrDZe3qF2wxQ2QGDzc0Oj8W6Umr5ME7qJTT4HYzqb5OfLcXFs3N?=
 =?us-ascii?Q?6rcQgt8Cc2axFdCVGuzcWY4b2aXCb8pt9YHxp1SxCqXcy5ViS+UhFBv1oT3r?=
 =?us-ascii?Q?zhW6Q+bx/0/wuuf1/NewRipcw1fdhDYSPAW+8SVXPIC7OKu76x1/vS3aaOiR?=
 =?us-ascii?Q?KZepnKZ3m4dVnMxrZbGkVOfePtfW05Xmr3epa156W7y+/+XjKwn6E0fm1G2P?=
 =?us-ascii?Q?JdqNSCu2h+bMePVti3Z+aYBFSgoTKtKxNloebXM8xaeFpbZm+DODhghdzRF5?=
 =?us-ascii?Q?GzGJWOkKo915MidWbzx8LgeNZJ+j3jjQE5fiT+TeA+HvZ0SzNEEOiROh++PE?=
 =?us-ascii?Q?xoNwBfvSTTyHUklfIpvwRPIRi3mQCtJ3VaRwWJXkUWXGX1oQ38p/ZyzupWkV?=
 =?us-ascii?Q?jQr+TdXpM0HrCmRWCF1a/u7Y9cPvkB6jsG7HiV+irOm32oKSH/HlIT4aKAOv?=
 =?us-ascii?Q?q4L1O9k0eb8K5/2NTxY74MPDWjGXPsbetZlL5aJz34u0jKNkRjtchXOsUw3F?=
 =?us-ascii?Q?A4zbGuk3CfOgOVrrITGHJNRYJbLM3L78CpSseWTa36tul/jKwA8vrYCIz1lw?=
 =?us-ascii?Q?kgYXe04R0iDYpBYvtrtrKiEZA8nhZHJ8i+gcNXQ8gnzt0PP2LW/S9b3IIR3i?=
 =?us-ascii?Q?AH28/zki7mqYqwBAnPzIerBB/TR1yLOPJEVuKSqKUqf3LSR2t7uCF65Ihs73?=
 =?us-ascii?Q?ark0fzDaKdHUT8bjeY/Ofb0FzwKkfm60Fl4eEyjPieZrYi888vzGGDERCZJz?=
 =?us-ascii?Q?pGDlZgUKOJz/Of35eJ8nx/DVTCrdzKZintEEuy4Jc8RRjRWipxSl9Hk9Rq0l?=
 =?us-ascii?Q?n4rizN53tM7IcGdXrVnrBkS2CfcjRvMxZD2S9sVmD2YNEx7NsFd+YXKgnXvK?=
 =?us-ascii?Q?bq1eF2MIP60wP5pw2E3j+YH+om/1xYZOa/ZsjMUPu+MnZuqqoprCSBjmr5iz?=
 =?us-ascii?Q?AoXm6Zi9kojSD6+hLi83o3avH2axhHN66JE1Nml2PNzX37XPJA34o0t3viMh?=
 =?us-ascii?Q?QMdJn4k+T6fgZK/LfipobsfdeTXCnAMZaqCxvwBdy9dUgJCGIna9+sEs3Sra?=
 =?us-ascii?Q?evh11eRn2jIKEiaryK5xmKLU3UHIc4VIvfB62jvPyzcu9Pe+m5PBFovy68oQ?=
 =?us-ascii?Q?JU6efhuASsX3gLuqNYzqopQ9nnEBTN5LyJWgqh/i4cdYWPbeO+IQMUIDCtyW?=
 =?us-ascii?Q?7iz/gwW6qJ4nv5cAwGQypcaPz7vIZG0l2TS87wdevuDZpvBNGhBfTAeNd8Su?=
 =?us-ascii?Q?PqJBffSloIIhVm5QKrI8Nj62Hp94lkd9zMfNLBTSYYNXNeUw5o8D5NQPT8M7?=
 =?us-ascii?Q?lw7nOt7uzfjgQU1CeznW/j3hrYvdrfWelpau1wlO49truldnztrPBxA9o3qo?=
 =?us-ascii?Q?rCKWVt07zch2E/CYa0csYBn/yx34BMPsP4XiPVeQ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5ec69fd-1825-41e0-04b5-08db7c868c93
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 12:02:33.1474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5KkoX0l0oAvjBU5YLEBW1oJnWpcc17QxjC32Z7QSekjO/yAbR28yF83mS/Yx4aFtRsT9aZzVtEeoPzrJm7HrhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB4999
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/reset/reset-sunplus.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/reset/reset-sunplus.c b/drivers/reset/reset-sunplus.c
index 2f23ecaa7b98..df58decab64d 100644
--- a/drivers/reset/reset-sunplus.c
+++ b/drivers/reset/reset-sunplus.c
@@ -176,8 +176,7 @@ static int sp_reset_probe(struct platform_device *pdev)
 	if (!reset)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	reset->base = devm_ioremap_resource(dev, res);
+	reset->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(reset->base))
 		return PTR_ERR(reset->base);
 
-- 
2.39.0

