Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C40D74FF33
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 08:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbjGLG31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 02:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbjGLG3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 02:29:21 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2092.outbound.protection.outlook.com [40.107.255.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A1C10E3;
        Tue, 11 Jul 2023 23:29:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2YD/DpUbPhJLNKoObUsi7K6B/5j3QK7WQtFgdCtwoAoGbdZ6A3uLhJSgWfzzCC3BXXv+K1PBAi2ceaJY3zusEbKs0flq8aB+2Zyy6s2U4GURFdB8JU/uWkMsD6memsfJjfpcK7fdg9vNs5a3L6rqI5u0sIG7WD+XLu/ZqQZHOAbZ3jBY0BdkBhUiDvYAjWbdLKZv1fLu4PJmobYYSzpu9KD2wl9UWEWr0qiLxVdJ5s80lMK0zFctL7c0x8RUGJT8R1p5djrrrJPc/jncF/V19pWxYr6sMU54mwzve3WbU0dIuEQuRkoJ47grrMfr+G7Yd/FMdOPZ0Lmz9+pPjdFYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rd+u1Qrb4fHxvJ174iO7/CkQT4Fk3N3D2gEf2kL+6Hw=;
 b=ZOEVQwGHjgQ3okATU8dtN8cSefnl4LfEzkQYISsgbNSMczpgu2vQST7MBFgcaXyuQiqbzdxBOS2zyQN+WRYLPnZNy5clsQF/cGnb0sZH5y4J/zN1pFhSV59PiW1FcvoJQiCtsARgkQmDP/uk+sDjpDYSmL1y6mf9xadhzEZ+8shUXwk4YQCqXEBRN7t1K7TqLpqXxQZ1UxGGDd1aZOfPpRU1WfKYyJlLPgRQ/cen/tEvRuyqumArQaZa2JXkM+yoKYWFe2Lpa+PLvwV11P1sH0TpW+a8cxs179C6IUrnCviM/PaE1yZe0PnTWlDnBxdHkRya5LLmr/Llt9WrWh+G2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rd+u1Qrb4fHxvJ174iO7/CkQT4Fk3N3D2gEf2kL+6Hw=;
 b=Amlou53fel404wg0XDiAoCA2Gse9kyS/OCJ+lBavqDNwvOTcqW477+8ktgE1YiDAADH4LC4UXECDxjSSvOcDICOasAwIlmbsY9VCHLqPuAZyuO9BcsBNyaqDficP4zxULfES2dFiKmryx7FSW0Of8QwsrbEeMmpGYCuly7gRKRaXKZzoUhLrWYwBnHKR2yAVSvhLCjHLBDjhQD3y8u2spVJ59s/bRvePxK2QVduZjRzYvaf5a5DTUfLV71bgKdxSCMVID7HkJ8Ir7YlzHoBedwkR76NSx30dSMyjj3XRzew008GmtI119BUj9s1ex9dlFqUF+nh/tORkKJm+Hj9ZHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR06MB6672.apcprd06.prod.outlook.com (2603:1096:820:101::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 06:29:14 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 06:29:14 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/15] serial: linflexuart: Use devm_platform_get_and_ioremap_resource()
Date:   Wed, 12 Jul 2023 14:28:42 +0800
Message-Id: <20230712062853.11007-4-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230712062853.11007-1-frank.li@vivo.com>
References: <20230712062853.11007-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::20) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR06MB6672:EE_
X-MS-Office365-Filtering-Correlation-Id: cb1d1eca-66b6-48e2-1b36-08db82a14f89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iO+vA1l0Z50lcIAvqXB/eX+9jaTgcLraR2l7c84D9OBqb4XnspCd/fOXAQ7cxadnGb8UsTWt6f9AqiU9Iqe1Ik/8+xRe3R7FvUVw128elrzxZ0I8xlHqv54FK5cAbVwzhiuXdv2wg+PB/KclXE2W5OaTx1u6loHB01ispCUd6vc+GYsbU2NHKq9g4rqS/ptajjrFllU0TbyZ7U534Iyma7enLqXorVEALva6AUd0+IJq+a23JXU1aIfBSQCGl6XJCZvXEal4+8tzAqrAPA1iYZ0F1SfOvqDFPkHZKzHKl7eqlHYhE/O04oiLK7QH2eNOrL35eOpVGFAynsv33HBFhhHEH7/vMDcIASpNGfauVGgZjoWG1yta9+yoJXzXgbma9kSN93nS/yn4yi0mMrpyM2BK7HmS62AYwbZU4E/vmlIboBD3g3/NyWll900zDIg6nCiwxFFkN+q0An4PQ0ImNuEtJ1amhrXv97Z/vEaRuhkNiU0qVlp6bfNjFsLOMB6wGZRQv+t/HFe8tpMo8ol6KIF9/E+EvYVCHByMRKtEYrgPhjLXwqEAlCJ+xCwrjbfMM2d8vx5yr58eb0xhhLw51En9YXFnHULXkwf6JID7oQxux4cjkXWaYDOT9jpzIoKW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(451199021)(86362001)(38350700002)(38100700002)(4326008)(316002)(110136005)(478600001)(41300700001)(66556008)(66476007)(66946007)(5660300002)(6506007)(8936002)(8676002)(2906002)(6486002)(6512007)(6666004)(52116002)(26005)(186003)(1076003)(83380400001)(36756003)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VxsMs66MFTnsMn2uPonI6ReWH8PfIz62SnePoTpcgBbWJQQ+AwNEXvHcryQE?=
 =?us-ascii?Q?bDMlRFwFMfnUY+btaJY85BNn7SXwmW7MY13Pr96xitD7Z/RyWApA+safzljM?=
 =?us-ascii?Q?z/t171dhcK4jjXj+CZEf1JIPRKYt6a7b6Ah0CpZLgXVQ1qB8ojdDq2sfYFYZ?=
 =?us-ascii?Q?UvDyXbGijZ14/75K/GaRtHPHwQFX5I7PGjFBvEbLePLJiUx8bgvmldysnvEc?=
 =?us-ascii?Q?NPO76wYCv/Szk3R09EA0MADxu7cPdz1/F8AP7ZEntdhCf77HBrI3HmCSlnMg?=
 =?us-ascii?Q?ouqqtXmkBEuGEkXPf8N1UJh8h9/uz+UrCY+7N7aPei85pSR+5NEnVbWPwY+V?=
 =?us-ascii?Q?rD4xnTqpl3mJMEJjqp+2N4qNJwNh/dWAxwm0mmZvubSpdYPac4CvhHhjk0do?=
 =?us-ascii?Q?ap8S33+3tBC6nMjujLWYDOuwLGzXaLirgVb6bnd8Ff6Mt+ruZCxudEQH1Hy1?=
 =?us-ascii?Q?gbCjWK7fUiCN+VipjgVFlx9F/Swt99QGCktV0Q5+7x3nS6rnEaL2JTHLoinr?=
 =?us-ascii?Q?02VMSBcWa4XD8TiCdjEiUMN7XmGJGXKLBm7hQi128XDsTm2nmOv2UyXVNSTn?=
 =?us-ascii?Q?0yPR6RAI6tL2oVShYL/Tn169ucGzbToXafrVCU329SvGepufT1icC9uY7pnA?=
 =?us-ascii?Q?FdHlFEJbhNwYy822exQtl+299QjK5yJzsqEMDQS9e2tt5TYqN0D30koBVdSz?=
 =?us-ascii?Q?Adv70/LsfUTRQ9ZAnVQwZsmmjGzcuxNQnh78fOKJXEho4O07iFQkUEZ0T8/K?=
 =?us-ascii?Q?+rM+Yw2u3ZJV9rGHP82Ge+DeTez0Zf0GO2wkjgMzZL2BD1nhDoYnzmKFtZDJ?=
 =?us-ascii?Q?1xiJDLKZOneZ2JgDJOoKeUMWTnUcXUXm+XJ3g6SuIXLS7pPUojpu3nVxeZnZ?=
 =?us-ascii?Q?COH2lir9dKBzipuaeaKU1Omta2EmBZHdHYdnwxYMj/dDMdEjYs+LBkbqVmAd?=
 =?us-ascii?Q?IJD6vWVRd8hQ1n2oC7GjhE8mlT5jqxu4Vo8zFTPkgdvTX9RoqWvdv8iM9wZn?=
 =?us-ascii?Q?pZ/l13Wj/Yyka69qXZ1jaalgFQHblTxBvOyMonN7VtJvwcDIc8fthtLSwm2B?=
 =?us-ascii?Q?TLzUqn0PFQRWhXKeOQ2XfmwR0iPcZ5xTouPCnp0z7qXDfbiUr/DHMZm8weyG?=
 =?us-ascii?Q?MRF9QZOy3rysZWq3BW65iu90620nQig0LgCmO1N5ibhjzrEzIU+faDFpwr0Q?=
 =?us-ascii?Q?xGbYOB/9v1epp/bjjRgBZAEEWx38FOQD1fLLld8coAoW2ozaUIcMTTnN/BMq?=
 =?us-ascii?Q?LSfbqpPom350YbdrLLL8UYKBDFhzytg1nyNjnBYNgrrV9/JbgD4PNK4G4/rW?=
 =?us-ascii?Q?akMKBpWX0GDbKFvsUMV1A8Peanie/ewdpkqOxf7O8pXj76MpbtSPFsgQt/ng?=
 =?us-ascii?Q?mHJj+xShGvmyQL9PMnlrmxX/R7xBfpLYRXZqB6rAX166sMbbf8c1UwIc6eje?=
 =?us-ascii?Q?dKLfWCZjD7KR1o01n6lye/IBBzrf+atbd5cE8cFpBnVUpumdkE8gnyYNg62x?=
 =?us-ascii?Q?SGbYLX/AXRkdTfx8HGbybAqk/ZBNi25dtuPyZhxfosVEyi3r33IOYEXITkMG?=
 =?us-ascii?Q?ueG4quosrSryZW82QALPfuRbwjft6t0hPDqAWtyG?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb1d1eca-66b6-48e2-1b36-08db82a14f89
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 06:29:14.1251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +obdWoKwwUlDB7ZIw98Nad6RIpvtFIlXsMfk2zbYex1clyBz775BBf44W4HlJqWyrT9sxxYD3v5iEbJyZnW0KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6672
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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
 drivers/tty/serial/fsl_linflexuart.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/fsl_linflexuart.c b/drivers/tty/serial/fsl_linflexuart.c
index 6fc21b6684e6..d3b38a376e08 100644
--- a/drivers/tty/serial/fsl_linflexuart.c
+++ b/drivers/tty/serial/fsl_linflexuart.c
@@ -827,14 +827,10 @@ static int linflex_probe(struct platform_device *pdev)
 
 	sport->line = ret;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENODEV;
-
-	sport->mapbase = res->start;
-	sport->membase = devm_ioremap_resource(&pdev->dev, res);
+	sport->membase = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(sport->membase))
 		return PTR_ERR(sport->membase);
+	sport->mapbase = res->start;
 
 	sport->dev = &pdev->dev;
 	sport->type = PORT_LINFLEXUART;
-- 
2.39.0

