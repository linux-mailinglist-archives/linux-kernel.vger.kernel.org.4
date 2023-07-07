Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A4C74AE50
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 11:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbjGGJ4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 05:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbjGGJzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 05:55:41 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2095.outbound.protection.outlook.com [40.107.215.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950F22119;
        Fri,  7 Jul 2023 02:55:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DS2Zz9XSjLy60ReM2VWFoC1On45rJaZLQmtXc4dzoGJa4gkCseWBIKGdDB9tEtWaf4xmj21wcaqKzJPZEDzbdicoK5qsvxJ27PByohHzTSN8MJFAebYUc238/W19PGeBUQMN/EZje/zN+Qg4JR9vL5gekPVORzCyKvNHYN86I4aIPAknXDMyooH1IbuwaE6lVabiq7peOh6oWBpNFkD0Vw7DqLE5ijS+4Jxal2xdxxfzhW8rouy31K+Yj/BQER2Nkn07uZhNsVAgcHJOx9AU52uTdbsugVVySBYyCjfY55pQzf7l71JXuwyMVvUkprvk27aAoCEUUjjWIIVqoWKwOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tk8Zx6CrKzQ3NZBVW+Uu0HKZvDqlMr64Zf0cUpm1qx8=;
 b=IsZ4vagZmVHkBwn05XB+e7MT/jL/ablPNlZaM6nOJM0fdZWs2tG2he/ynP1/IqCN+DW1SKAiOInr4WgQv7UrcS07ddSPvuid4R1jEKrCj1Bv5KEnnC9d2ei2+yKDDm/I5iHgoBKzA8xNqI/nThs231Bl3Mg3GSOGDUijVg4C78P0AVGrQ+M37J5aM8yHaDsGYhpc9efkUMaPe0Lgc/vvaJSF/aFMas+oZi6lfJCDgWFeCKckAnjUsq04e8CPCOKQCzncYvJVQCRVh654+PeJ6PvrOlKv4K9P5Ew1IagD3ccUHa8GIK4CkJAmrJ0NP0TtqHUshEEA/wbdKJB7DpAOjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tk8Zx6CrKzQ3NZBVW+Uu0HKZvDqlMr64Zf0cUpm1qx8=;
 b=nR95alaB7KaZHfgN51wJiE4PpRQWzue4xX2tkHVnTw/JForEfx6kIEwimeugwOhbB64PMhnjkZgIK34umUaoW9G4KeiqT0JdRtqNO4/oZjnpQlsSKEvN2Wmf5+m3YsBT3c3eMSzEnNsBX33n21F1xSZqe8e2sH0TciCa4UWZVK+DznBvIMIXMkbijIwWfUSNOaLbVQ5zDDTTLxxZ4NQkMNQqkGV2P+ag852G7px0FxIODiHJ3NiHXIsopM959K+L1mmlzEiPwR0kDbCOZgKr+u9rExPW0n/yTacjdCL6QGSsS9eh16E5dITPdg/9lIw8v5Aoej4QE2017JDZPKaU8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYSPR06MB6793.apcprd06.prod.outlook.com (2603:1096:400:473::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 09:55:36 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 09:55:36 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <dlemoal@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-ide@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/11] ata: sata_rcar: Remove unnecessary return value check
Date:   Fri,  7 Jul 2023 17:55:08 +0800
Message-Id: <20230707095513.64224-6-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230707095513.64224-1-frank.li@vivo.com>
References: <20230707095513.64224-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0004.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::23) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYSPR06MB6793:EE_
X-MS-Office365-Filtering-Correlation-Id: c1d05c79-8ff4-4d06-2e11-08db7ed04fa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L5nZ+DTcOcdQpDNTLqGdqx9q2tLQOVh7P31CRh6sGfGGph6kzzIpDO+h2MXqcszoGI2aF3Fp88xKcdjAKk3ITaUTTsqYDTeACNLuzvpXL8oEShQjbaLA1pytgzNbGJk2q02JBBFMGu414WwHix/NykE/E8f/hiVRbkpOt5sF1q26zMxpFygEEa4TromKbY+JD0aYQm8R+/OpM5+TmGtruUSm8ZAs+zla7NcnCR5N+EtjHYD8uOSRkIxA9yQ8bc2ImAaJZ4ciyfHnST7fmDuPHIwOhL7PFyy/qWwmBvAJPlSh76kEOULlLbZ/gM6breZtDjhNWFZmG0j83XhJdOx3DJMqMvrgEZiLx9qnTfBhF2+4tgnX+PeLm3mxVkNvDvFWXrqq1+onFq8+LIIAE5f3s+wd0EQdzpVChmKZv4v7GE+zr+sfTnEOX/Gj6tiwuG7grIDHSBd74F4hb2Vpbiq6FvT0q8gu9k+v705Lj705Ji7INy2Z8MVEq7W5O1heXYwDsckLTBRECBQyxo4295m5u6Bpfsd2KaFEEXskUPZdaMeBKN1XXnADVceJAf+328B8yS/TuL/aU5LmA7QbmeH5u+rb5NnBoIH0JrEjXypFsXm2g66ys6+yFAGKpjFx1h1V
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(451199021)(66556008)(66946007)(66476007)(4326008)(2616005)(38100700002)(38350700002)(86362001)(186003)(6506007)(26005)(1076003)(83380400001)(36756003)(52116002)(478600001)(6512007)(6666004)(6486002)(110136005)(41300700001)(8936002)(8676002)(4744005)(316002)(5660300002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vX+QZquJA0/RW1HNVXMJfA9ij5Xm0nZziKnc27C+iGmOu+mMjAHl8jyAu3Y4?=
 =?us-ascii?Q?W7YT7mX8xxhV4ye1T6CAKP64ynFq+kiIQ7v/ATCIo0lx/RZQEp3hC4F/4NEJ?=
 =?us-ascii?Q?oCcJr+o9PUHHi5Np15cD++QWnjzmeC0sAZ9tJdLfqf5ehZpgRSQnx6mil1m/?=
 =?us-ascii?Q?h9sOxMloN7PNiZh+nDvjJcBGc0tUoRjgovMTguqkhqSFmknVEXqn/mGZbay7?=
 =?us-ascii?Q?Ieuve/o6VfrGAmCc255bCUJniuppQbjUQtOJ58sbT8zSCK/+9y2JUaLjc4aW?=
 =?us-ascii?Q?kNTywqeLGXfU0VkVOoolUH4iARLOJI+okhTIpxIQ3LePW0XhP0Bnyk4Qk6Ug?=
 =?us-ascii?Q?NVhq6XvaqUkSUty8XyAE4W+fISGQ+xAqlJkuziSTuX55Gsi0IGRCeVrQzN9B?=
 =?us-ascii?Q?uziRp0wtLLT8Jd0l9Nhou2FNxQgZvlH4kI0ucDWtxPXwBRp6HtA1eDLxzlvN?=
 =?us-ascii?Q?cuhHIO6rt5DRAhoDaOoSoy+ZEZ5N7AL19AOTZkPWS6cVDa3baSsGmpD1+Zcc?=
 =?us-ascii?Q?dAnaeY3Nihg469DYJlOg8UQzJwyqmpBZbR7Dz5I5Fbw60802VmfWMdradTR7?=
 =?us-ascii?Q?BuQqtGOQAQ0MAkAXDc5u0kFfLLsRs/lHd3P6n8U/BatrXLNVZMxSMXDnq5Xh?=
 =?us-ascii?Q?VbJ3va2YPPMoB5IidY3lgMbx/UbaB+FnIft5i/ndFSFaOgtiXC9bKtoPJkIs?=
 =?us-ascii?Q?T1tGRLKvxAdGdTwd3qq70BXOClFSppTiBsiByn87/LeFiVSa4fozmYWENQf/?=
 =?us-ascii?Q?twik7jxWSqoA7AINLBp64cnJ/itCf9avtyrXe1+BRHnpt2o5U+zwrjKKcvIs?=
 =?us-ascii?Q?CT57Zl4T2coIIssnxx+I/0aSmYY9xYGdo/l7rZu6kCxJkj9a9BGDyBiX66fQ?=
 =?us-ascii?Q?TlUd6LqsBUXzIxe8Cnmkh23CuKhQBl/teyUovqO3mk9mnJFLMD0GitVixIbR?=
 =?us-ascii?Q?eiY2G9Z+W/1DhSX0SHzatdruEuPWISK0k/4wMIXrCwERLGa7FYEI/CUjOLwI?=
 =?us-ascii?Q?C6txW672Yzz00JbA3Pktg5vVDAd2aMTcuEesTXhYmiipwsyLoNWV4yXjFlaY?=
 =?us-ascii?Q?hE5mIYpu0mN3Ya7GAePZpnoqSDzMEH4c7CBXxnKsOIbkD1EdmiIJ9MTTEtbH?=
 =?us-ascii?Q?zoTvfLOFQLSQpKBbf4a1X9Ti9MfcmE9enU2kaB/d7bfq91xvqRlPkkSbMoxw?=
 =?us-ascii?Q?bLBYYWf5m4XOyRSVrdM4vrE2PwIaXFDpU/1TRdDlNkASKc6p5puAr19DAzWi?=
 =?us-ascii?Q?9tnPro3bcaATbmTKzI4wOOpetiQBCZ4mutsI/LzaeP6F4h8w1d6cnQ8YLyoL?=
 =?us-ascii?Q?DfNip8ueh+yaYr9uYxbQiwxTkS0jIm3WISEM0ToZ6LNMtta+keYb6c7GrI9V?=
 =?us-ascii?Q?WWIutMUg6BKvw/OsCo1Umm6AZ/soqu9AQT6eRFeLzRjf1aaSiNweqtZxCkkR?=
 =?us-ascii?Q?Tl1yqzg4V3eUNtaYQ45f9Oz6TK3Mo22srbaoJEunySiLBXAiW8oatWv5rTbg?=
 =?us-ascii?Q?WRxb1zmChBrfgosWCX+CgW6sn6ABGAsj8+A9sF2MoeY6+UmvcGHgfWmwiDqz?=
 =?us-ascii?Q?FwO2geDhFNCrEGaG8f1vlQwDrVVXqsgirMCBUD4x?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d05c79-8ff4-4d06-2e11-08db7ed04fa9
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 09:55:35.9809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YPU3scDOVMtlhZYqO2GN6/dUxH5BzWdhNVQwuw8MTagN4THKUKRdJvQDJjocFq1kCQ+jg4lJioOQYsEa6A3eEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6793
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As commit a85a6c86c25b ("driver core: platform: Clarify that IRQ 0
is invalid") says, there is no need to check if the platform_get_irq
return value is 0. Let's remove it.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/ata/sata_rcar.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
index f299b41ab3e6..43c55ac89daa 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -867,8 +867,6 @@ static int sata_rcar_probe(struct platform_device *pdev)
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
-	if (!irq)
-		return -EINVAL;
 
 	priv = devm_kzalloc(dev, sizeof(struct sata_rcar_priv), GFP_KERNEL);
 	if (!priv)
-- 
2.39.0

