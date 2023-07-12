Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5639574FF4D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 08:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjGLGaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 02:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbjGLGaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 02:30:21 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2131.outbound.protection.outlook.com [40.107.117.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8F72113;
        Tue, 11 Jul 2023 23:29:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hnpNmCGBDuXRdoxdxPJfbTZhcGR5s8U0xLnwPl9wzOWAD33ut83hGZMlFpILfo/kJbm0euly2m01ZkSjb1Yh+yg/jjZemDoFlJ2BdL3fw5NRg8jZgg9mJkl3o4KKYd9anu87QqEzSmkswR0+N9xAnKSkvhWaTcBOflTMwGwhKgJB84ZLcZotERG02rJl8T/PJi7KdIFU13ujrncFC0JYSdQR9nBJLKGqEkxuMrnLG28jlflHkQB0lBToXhC5Na3/L6Mw52oP0buE49gEIPpwtt1IhUMkTi13GEGD439JCoywYWBX5VQR1dcoqh8LGXvNKcQ8Ft4tX8KLEHpePm9NbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJG7lBhE2HPrLIVL7EjyhsgmdRsNn7Xe1vYizuUZA5o=;
 b=ffzM9FeAH7mxzpc+6ey9njibUOVyYhiZeGseC6A18NyffrlelnXFSAM4m3NKBD9fmBVC/tFRpi7a5n3f7NmHilhaentVhNH5bK44OckgVHF/eV9BsuGeKbDvQDZ3kQeju8WNcfDle9GJYbWDWWL738ATnGi6a+8YC7J8radQVuOhdqLbR/fqFG7QNDD+8yGoO/4K8AhbhpHN+3TWYxK8Oug37tzcNO95Rid4wF6g0+CxrBX91TQrYMOCnTFH2dy9ApDG5nSjU6hFQtywEafoVah00iOSk/AHbVYsBkEG5dYznbBwJp9Q4QvdqHzHgxs7klyWuWwPUMGpvaYuImmjtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJG7lBhE2HPrLIVL7EjyhsgmdRsNn7Xe1vYizuUZA5o=;
 b=b1dTDlwva5odJy9JfNaYO2iO0Az9lRNexqrAPXqNEKhxUUeobNVsiJT+IjA+xo9QszzK61y9QrcBjzyCgGVjZiaOlwx+ZwFiWtsZebFKjx0/V/RjdRQdS4I5VnNBqYv5OZ3rv44P8R9IUobw2HZ8ddFSQZ+NgAur/ahQd4M6kK/PwwQoldzLtoUXr6JAqKKZbHanKWNkfikMYCSDDPUlblK2znGyWT6zDYSmXkgaDV+rK12vOzF1PU129xPuWNPYDQ/57KRB6vMSrdh/h+0RR2o6Laxqi+GyMBLHDH5h1lZI6QSZO8ybwKYYkjvFCDjLpALenaJCssxY50TN0YZwMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB3963.apcprd06.prod.outlook.com (2603:1096:4:f2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Wed, 12 Jul
 2023 06:29:23 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 06:29:23 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/15] serial: vt8500: Use devm_platform_get_and_ioremap_resource()
Date:   Wed, 12 Jul 2023 14:28:46 +0800
Message-Id: <20230712062853.11007-8-frank.li@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB3963:EE_
X-MS-Office365-Filtering-Correlation-Id: ee884843-5262-4538-7320-08db82a154d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gzcAU1nzl9eQwBRa6F1fMoGts/oEx2DpZXW2MhiEMLr4rkhDYsNk/aPNykoAi1v5hOYnZaMrV5NNpR8vsdosDcFx9FV6XPQoOf91QtakyOX5jhbGqXVzCKfZWr5+TEPgb0HGAX4tEzmfrSmJ7d0gJHzhahLNkrPlFBZybCa6J2QE2MW076AAGjUs6xbT8tCgP02vw7IBFeFjBZ1aqihdxfVJ0dD1YCay5uWLv0G1Tvy0XltmJUa1eMa3OqR8xyr21SSwyEsmsx9/N9yqawhZrEzYrF/SOR6bfWbFfdfvhHqAyVu/uMNU4EViMRs3tufSJ2ZzV92aC4NAQRU1ttXctH/nO7aQD1RES+qtwE20AvYQOhFvvSo4Y6dnDTX/XVZ8DwjQQubJ8s+Wn3V25UMqKgRQBeLKcJJhbmzE00MICm99it9k7DYB9vhVfhXxkV5yOvLdSvOgepsquLMTbbno7oltp48fjC1F5Ri5ufTHPZK9ecI1ndFPPwsdnOUU+nB5vGX+vgo5dJCQb37nWT0IPX95O2KqH3E+DdudOPbGkTaxtJUpBZoDfUDZauDmUq9TZXAeT1tMowScGCUMoAHUdxStFOeKput0llAwE+GiTFmqsc3hinWW+INQ/5gSEQpW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(451199021)(41300700001)(316002)(8676002)(8936002)(6512007)(478600001)(110136005)(52116002)(66476007)(66556008)(6486002)(4326008)(66946007)(83380400001)(1076003)(6506007)(6666004)(38100700002)(38350700002)(86362001)(36756003)(2906002)(26005)(5660300002)(2616005)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TtW7kSZYd9kxJKoHyOwMAKS5Qxao2OVXMXMlLXvAW9wis0+DkrZ2uxThvY34?=
 =?us-ascii?Q?cgISoHN9HQvfOeHYbH6rYh472MvRnfhqZtYQuc7LpiTgN1B6SarktnuvfQOu?=
 =?us-ascii?Q?zTYde/3PaWmoloPc2Y4uGpjufPMthodUEoiTO31MTlXMizTcPIefsXCbGfXd?=
 =?us-ascii?Q?pT7wrmtAZsEMZ8ywkx5I3KDL74iN25wDoPigLyNzGNZOWpDjLnIfCQ01+S8Q?=
 =?us-ascii?Q?FHKvqnzr7d2fT+Gx/YnSZVZdSBrKC+f4bVGhZct314bqnqrgnN3bxechKr2f?=
 =?us-ascii?Q?RkafwBPjaQvnBfKm2Z8FaSwHZR9QO3kTVgbmeQEsiyh+Q770CzLIJ+nMc7o5?=
 =?us-ascii?Q?Fq2LX9WHVKk/AL/8Ewjk+f0NuiGfkp0dig7xbZMTfUEj/k/eY91l/zVJZlCr?=
 =?us-ascii?Q?0LISfsYTZcWwQEvwLuWqo+llC1+V+RgZiv93erQXW3aj4QNkc0NsXwLS5fA6?=
 =?us-ascii?Q?cH+im6RMtjBzIxdZXXdphwIQoXLMF9CsM73PBY9ZhUizwL+wbTbgRJTD5osZ?=
 =?us-ascii?Q?29yhqO6Glssif6+yvH1SZtQmG6wkHSHf+4NF15MtZRbIcDJ9CVjkxF+1JKz+?=
 =?us-ascii?Q?LORyQ8AeyRJIA2wENfKQZDu632WgKvl8usBXNlJZvFA2E5HklTDmEa/DfoXJ?=
 =?us-ascii?Q?vF1E2wIFgFwv1LzMA/KJupvpdivlVLM/ao6LTzvXK7XVHMb8ATeA11UDdEdw?=
 =?us-ascii?Q?XrbPAs6yk1BJnNL7nn+OfZ8QdjyiJ59O46Hen4AL5rt3rAUiIQ8yJQN7Cwer?=
 =?us-ascii?Q?11tPOVxVeoE8ryMQtKOSZAnFk3z9sP2hVbE4JMk1QKRcVXejoIF8FSaWk6Yl?=
 =?us-ascii?Q?NRXMgoQrL+YquloBL9pMgfWWD5XPFCrw+dk0fhOX/syfGvWDWwx4RJH5ar6S?=
 =?us-ascii?Q?6+h3/wKw2wOeLQdCtmRzjRqvdEFdJzrTWgtXBmfbJLoiW65tM/ThV3607wgN?=
 =?us-ascii?Q?03ahXODeG/s6rn17ecatR7A7r6HH8dPqAg0r8dlxCy31VzcrR/s95B6pP2CN?=
 =?us-ascii?Q?FKh+bsLkVDTyE9RA5TngBiq5cvJ3Aq2H+VDDFchWV7fVMUxXNPzIcMnwB1ag?=
 =?us-ascii?Q?Edb3v+yskGrxyDFrO8/ju/mNiObRFXLRx9SVGCbOsU6Y3saGoq2jYr9ZVyRT?=
 =?us-ascii?Q?HZZPxQuxPNwcwvNZDETDO/Bhz/NRxlgvGKBQgFwx3KDmx2aItyrICN+3XuO0?=
 =?us-ascii?Q?VWy5aeUeT5i+dAOvtn/z5v3ZIufrMSbAEp3CuuepPDaCwwXnZHFozRx4egUz?=
 =?us-ascii?Q?KHIVtMIa6ORJqSD3pCy6aJrCoi+DyuPPx2sg5+tU7bExIezZZKIowqFZaEfe?=
 =?us-ascii?Q?XW75xR09X5xufm8HYvJ4Z90s4oP9ebouHkA9CbJIybzjfV03JqKme9OwsPVl?=
 =?us-ascii?Q?x6Ux1G2r0Hr2PR5JwQgaoZyHxIUFIzskcUvRNbVZv2RS1LnD3dWi1ZqKEC7E?=
 =?us-ascii?Q?ypko9pd9jAhols40+V/uhQTeVtsmL7WIW4Y1VssE0OfBYCdmRv2YATsPd1iW?=
 =?us-ascii?Q?4xKSgzcxTRB4eugKu6FHF2ow/+sZqAR7sMbt+Q7anLJKmlx1XzV79gft6QbA?=
 =?us-ascii?Q?JioygCa2BZwuUbcGEBdAqubnqJu8LwGEZR1um+p7?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee884843-5262-4538-7320-08db82a154d5
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 06:29:22.9596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YUbN+FsCqmME9rv02SszgmlFi/ZfnpDQF36GRJTmODS82iKtZqw5annmXkETAObNy8m4OQQDN6LL+0cgPfDi/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB3963
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
 drivers/tty/serial/vt8500_serial.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
index cc9157df732f..bcef41c0262e 100644
--- a/drivers/tty/serial/vt8500_serial.c
+++ b/drivers/tty/serial/vt8500_serial.c
@@ -611,10 +611,6 @@ static int vt8500_serial_probe(struct platform_device *pdev)
 	if (!flags)
 		return -EINVAL;
 
-	mmres = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!mmres)
-		return -ENODEV;
-
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
@@ -647,7 +643,7 @@ static int vt8500_serial_probe(struct platform_device *pdev)
 	if (!vt8500_port)
 		return -ENOMEM;
 
-	vt8500_port->uart.membase = devm_ioremap_resource(&pdev->dev, mmres);
+	vt8500_port->uart.membase = devm_platform_get_and_ioremap_resource(pdev, 0, &mmres);
 	if (IS_ERR(vt8500_port->uart.membase))
 		return PTR_ERR(vt8500_port->uart.membase);
 
-- 
2.39.0

