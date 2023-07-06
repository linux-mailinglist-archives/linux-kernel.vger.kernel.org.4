Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D5774942F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 05:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbjGFD14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 23:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233339AbjGFD1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 23:27:46 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2125.outbound.protection.outlook.com [40.107.117.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1241BCA;
        Wed,  5 Jul 2023 20:27:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OlooU4Ki/UXDtZD4av/p4tezHyzcfajQDPjzzcgQ08uX0tMxs44iz8eIFUIIkt7RpW+M8z6er7P3YJwqJ3AMov4Ap61DpkO8oAEELrShGaZIGRl5bAVR1rXlKFMXyBqIXNQWB3YmtJReAZAPgsish9ZPvQW4ZfMV0/Co2gFNfYwNqoLCS22CA1pQnjNztp54Vx43N59vkUHktoJHTkQJ1EE83ho6siNaJT0FaDAXX4RpRwFm7/QIujWyYEintIvJE6thj1WvPnDf39uE6j8e6TMmwd/gMAcSbC72yTinYdbDS9Zh0DD7nCz/SaiWTMJuqaGblWQJkrCRFDFdIOO8Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J38d30aTpIQfC4mNjrjxXuDl3D9wgHNmq2biXk44o/E=;
 b=Ud1vNfO2M1tAjoVgMDDiakwnz0RS1ADtwQCLaGJjXVmbT8f4AgDPgEGGM0jiWxxZzBZHDfSldsGB7CAvKlU/3tIRZHOSUWC54n8TS5tT/tD0SAS7tmjJr87IcqBv9rM0Jyqnbc5QkohWE/2Ig4ztm+qE/sSOPY/D68G8m1LG6d3YQT9hB9jb+HMYZyPym1kTHEangSUnMHrKh0eTPWH9WED1IAvgVMpilqEJFOQONCo44bs1unDZppO1cY70MA0p4wDc8EP5DXHawAKT6e6IyDf6ghn7oBwqI6/Kf5u1Zl9vtZ1jBoNq0CPdAax5X6N5FuLPzpNbQcFEykuBk0eVTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J38d30aTpIQfC4mNjrjxXuDl3D9wgHNmq2biXk44o/E=;
 b=Wnk7qZDb5/OjIySRJUpGwoqwwpYK5jP2IEZMWb6dwlvG2oG7IATpZcqXcmOk+oaZBm3gDoIwZl9RNuR3I+h2UfTiKENewh7Ab4zobVO2KYV4UU9MPyllURBQ64e2YjjRtyGCUOHrR2yMT9D9Cs1jK++aKOdsd3MzBsPkg2lSjGE0QRx+OlP19k/0lLoMIYIIJcZ7YNvNY633e6obM5YVmveSGONJrbpTO7g5R+nb+rHKWgmNOF8l27QyBPj5+WObBhsS+i9Jr+Tnh5Qh7mwwIVPTCpj76up7pCCiWBpBn3L3uYp9zEcxuNjY6aO7f/eD4TgOulNWkL31VHJXZ6MbYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5468.apcprd06.prod.outlook.com (2603:1096:101:b5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 03:27:42 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 03:27:42 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Han Xu <han.xu@nxp.com>, Haibo Chen <haibo.chen@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] spi: spi-nxp-fspi: Convert to devm_platform_ioremap_resource() and devm_platform_ioremap_resource_byname()
Date:   Thu,  6 Jul 2023 11:27:23 +0800
Message-Id: <20230706032727.9180-4-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230706032727.9180-1-frank.li@vivo.com>
References: <20230706032727.9180-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0174.apcprd04.prod.outlook.com (2603:1096:4::36)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB5468:EE_
X-MS-Office365-Filtering-Correlation-Id: d0be662c-f4ae-4086-0f04-08db7dd0f518
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z7GC/S39orlfrRdHbUUB/dFtb5njmNqAUI3TxRwp01ULFhKQdGmDuL4y0qp7VATdhaNoMcZbdAWEaaUB4fDSlOxK86ZqwyvvBzLXthsq9YGJ5U0fM1xSwbRs9p1obuJgew3JV2Yd5toP5fwuhr4i8Ayo9BmdLstv/6IJqr9/On2DY4tohqH+ctXpsc6pQISwUrDiv1gBagpCIMDzyHgl0tJ2FRYsMEO7+VnX8P3ppJjhDTwG/QNbRNg9N6BmiIZIxxZqeNQfshbUTaipvUT9GXBgIRHHUz8UPbKTlRiR12DY7ZYjLRifEP5VflsjTscYxxZn2IZPyucx3Rpz1h1E0/+lG0+MXJavYZBGT3f6NiI7Q9iZLiIDwFwh7I0yRfXpiwTpG4CuP36Br6Xvqj8nqkzkoUSdNLgtMmWCPgtryNHhaur3uLyiFoB2K+zyJq3ndt0t7b5nXZF+Kt8g/alVgZT1NXB+NL/seLfBBoy7Ae3j57uQOJURonNdxy34RCC08ILgYool/peMMjdc3N+PW3V0W2UezhJ8HNc+FJ8/KtGj7UHgwm5/pzEBy42/fPPa+Ir8XKw0CNxH6mu6Meuh1req2DwfA/yoxLdp161squQPMeQLaGoPPOYkuAW9V7HC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(451199021)(41300700001)(4744005)(478600001)(6512007)(110136005)(52116002)(86362001)(38100700002)(38350700002)(6666004)(36756003)(6486002)(316002)(66476007)(4326008)(83380400001)(66556008)(66946007)(8676002)(2906002)(8936002)(2616005)(26005)(5660300002)(1076003)(6506007)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RNMG3ShvImXYti50aHu+HlcBXeW92x/t2ysommgVDZHaL3IFMFvp9R8OO3Rm?=
 =?us-ascii?Q?qqibzceIwqE+VCBUTrtEn/8eRokqkqQ2CvHtaO2Lp8s3RoBvjOykogyboaJN?=
 =?us-ascii?Q?MWgDuaxWs6M4Kle26og7Hev5jsUnEY+TvVWoS2Nd90ewVl2MhLvYG5inkRTC?=
 =?us-ascii?Q?USsFgopzHuwmwCXo+GsrtABEQxBm/uzMVt8ldqp3shGXo8egpIqQY/Ou0Qb0?=
 =?us-ascii?Q?otwhwl+ORguKGcI844wgKSgYrMI3NJ6o8vbYSOAMop/ZTyMwSj4JLDfQRC2u?=
 =?us-ascii?Q?l/FWyR9EXw/h8nxVQfEvRm2ptgtArM+uNfTFHxncVg0a0tAIy3mOzs0PaO0f?=
 =?us-ascii?Q?Tid31KsLkVNO/yxt8giq/I1U132SE4ngKFKwxFGeKhs7dTGX03fNb5IoA3qG?=
 =?us-ascii?Q?cZSQCQrEA4C7p+HNMTELozxFOXULUUBDAykvnURD03h8YlGlJC3EGVNxEt84?=
 =?us-ascii?Q?kn2wawYDi6UzWQC4Xz9Be29O06HmgsX3fTiwUEXMQCaEObwyVOBVW/5dcDFh?=
 =?us-ascii?Q?JNQ0RpQnNBayj6yVp71Lu/sTvBsEt2rr9V8IFCIVXJRZ5cNhgn/6eEChyO0/?=
 =?us-ascii?Q?hgqlVdxqpTLiW6eBtbFSQ+2YxZmdQcFpv9y4GsWhbdCa2caB76zDgHI99Yqm?=
 =?us-ascii?Q?DqDmXNzbewvG0NZiPs0q3dRQKrxHVE7vgrJxTcQ/IKIHEcyXB97b/UAVx1MD?=
 =?us-ascii?Q?a9xJykbJWO2ZCLJFC3I8EQ4YC7vnUnFKLh53lfZl8OG4Md+awUYD21LRuqcF?=
 =?us-ascii?Q?9zs8p7/PqaKl1s3MsqsChkZ05YoijqJW0J5XZys05zl4nXSRuW+Y4aajkPny?=
 =?us-ascii?Q?Bv9Mgm9m2UpF3eqQmLMG95LahGX8OSPx12E/RWFZWLPeH0sFik6WPBJoXu/b?=
 =?us-ascii?Q?w+5I1Ig2nox548lXUlGG/K3PdlLaeVANLdKA+DSq5Otjs22lt63HlhZ7sJdE?=
 =?us-ascii?Q?A2QSnlttP4wdGX0lDUsRd7uJ7T2B3pg1jHSacm1ec4UD5vHISOu/hFQUFgwh?=
 =?us-ascii?Q?uhUFH63q38oTXw1+Bz9u6iFEP1ga1xqstrFZqCr5qJQM664nbH5++Yjdtwz5?=
 =?us-ascii?Q?OzK2DMnoWRyK9cY1N2mpPd8uEd1rYQtCsLTYCM27x/Id8CXC9exNMzCMvP6L?=
 =?us-ascii?Q?5AkRJ8klun/c8qfs3xY0wb0OB8iG8Lf137dv12rbIJv2uNixpbzKHJdgHk6d?=
 =?us-ascii?Q?xRG8cnP/+IW8/cWmoudCnPFzPfwj2y+plKH6Z7OdJWhc/0FKJXE3fyojea1C?=
 =?us-ascii?Q?ISHu1aOdSJUT9RhJN+KsShcDROT3FI3ZJK5+GDgBcBaDkiBj3YGAl+vFs3xK?=
 =?us-ascii?Q?ot11+lzxczu+O/LjxOJeqd5Fg5qEoG9qfUvBadLhsGTbKWkVkbs80ON3UVGG?=
 =?us-ascii?Q?k4K+bRMS/3aTCVD8JJOZC3F8eKuTuSdA0VB7fvYNA1vvumc7uMrY2VYdkNjU?=
 =?us-ascii?Q?9yDFrRR4C6HOxvs1V+qNmcIB/xM1HWBTsnRaxe6AfubOpAJ5A+AzNDZKZfW5?=
 =?us-ascii?Q?fMIa/qsnaSxlGp5mK2uMpB3frp0nhoG0RgUs+iihvrBEqmAOo5c/ZdACsk8x?=
 =?us-ascii?Q?p+KcW5loab1HuLq109y40Gbdy6MaHKIBq9HE/qsL?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0be662c-f4ae-4086-0f04-08db7dd0f518
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 03:27:42.3729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m+usL/bNQP7QsRnDrrFs/eQ9XMe0GUewJa3GUCIXE2Vrvj5VkQ36ejub4kAMZq2OmTKAagdIgsDLoKKIV36fxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5468
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() and
devm_platform_ioremap_resource_byname() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/spi/spi-nxp-fspi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 544017655787..4cf9b3bf7b57 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -1157,12 +1157,10 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 
 	/* find the resources - configuration register address space */
 	if (is_acpi_node(dev_fwnode(f->dev)))
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		f->iobase = devm_platform_ioremap_resource(pdev, 0);
 	else
-		res = platform_get_resource_byname(pdev,
-				IORESOURCE_MEM, "fspi_base");
+		f->iobase = devm_platform_ioremap_resource_byname(pdev, "fspi_base");
 
-	f->iobase = devm_ioremap_resource(dev, res);
 	if (IS_ERR(f->iobase)) {
 		ret = PTR_ERR(f->iobase);
 		goto err_put_ctrl;
-- 
2.39.0

