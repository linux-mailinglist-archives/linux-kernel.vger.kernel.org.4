Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E48E74841D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 14:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjGEM1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 08:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjGEM1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 08:27:04 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2123.outbound.protection.outlook.com [40.107.117.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCADC9;
        Wed,  5 Jul 2023 05:27:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLFmn2HAqDOxkSGNFbDBKlXrBw5kYi2E75i/oebAtG5bcAJunNiUB2rHO3QY0a4AMKq98gOFCasizE/WctTt/c8YThO+m46PsSPAzK9sdm8/gVohdqZwL5a0pmY2GgoH/DEX8EGANOq71rDXLL5+VYkAHpY6873b9p37QAj1BF04dbKifL0J3aQonDF1bkMvGfYegcp9VhGZfNQxXAhf6Oh8Mume1V3Lp8Ea7Va0s5ISi8Q0z/1GMWyHKobjJA0LHRjH8B4fXNBlMVpPO3za34HIwqzeIQhCPEmeP0v+U1SXfaq7hvYPXr/RDkB3KTgtl9JwxSqDw+05r30+P3+4+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFvQx3P8o+i8altPGyA3RKgwDnQclR6Ck05iIl4UkLg=;
 b=jNef+xTCMEmh4IXRk3iFBOpEPO1m/+8l8VRgMZ9161USScTDA5/1TqrFkz0KwHnDmgy1M+E/uWYxScD6yBnbuVMfnpZwgzVzhBaDqOw/jHG5Mh7z42+TUVgMeBt0JW1DObJU5ayeLMZHjFx6LnpvUMEMAa1UuQSIu/EbqFzdTU6fsEZ51re2db/jUY4scXNThqUE6xxJ8qhWRwHCna3fB8W/YGpF4bKGZzCRzA2s877UyLxbM680wg6gi4//YMrG+DxJYUZwKuq6LKCIkk2kkKPpfMRP7oZWBBuEadc+4cNLw6HYaZIc0uP3AgAtVqyF4P1kwdm6ShTUyLy+p6r7nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFvQx3P8o+i8altPGyA3RKgwDnQclR6Ck05iIl4UkLg=;
 b=DljxLrCaTJxF55K90Y5VgMKY49flg58Iz+kPVIc0UtRMCn0EXNS0s3cJ0jUqp5c46ATSAks/OI0Gf6qQF0KlKLgb+VSdQcnURbqAhTUibXUOs1aUCAg4rfpWzo0D2PacYObxmSVjyg0jibTi3dWutMyYYBhvviwKHkHpNvH1p/xSJ+rFhcXJs5492Vsj9CPcighX8n8W18EGJBIA3sB0qPja2ljoyOg3VZDm4firelS0Rw23gD8KiM3DVinPh8F8YPIEqy6ROQfBDR/mWOwGB/SggLkVcrm0OOfP68LtpdvF7mdPNmuTJv9T0A4zGdiaV7+Vg2QMrg2rbXMnVGnWFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB5551.apcprd06.prod.outlook.com (2603:1096:820:c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 12:26:57 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 12:26:57 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] soc: qcom: spm: Convert to devm_platform_ioremap_resource()
Date:   Wed,  5 Jul 2023 20:26:41 +0800
Message-Id: <20230705122644.32236-3-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230705122644.32236-1-frank.li@vivo.com>
References: <20230705122644.32236-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:4:197::12) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB5551:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c5d897b-d067-4240-3e8b-08db7d531fc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sapX0sVlegUFMQiMZOarm0jP7+m54h5bUkzur0S4oTntn6HBpQU++lyMLYMVHk31U3IlQRe4TQlfW9qHDzAFrgNlaGH4uumnagvbBlOAZpf1jZiF7CTe/btcgUi+GnLxiMf8o/+fz5YTfhk+OgxPlOgMAJ3H1tobFCM9t6Y5aNByXEzRTVZopnRLlKmXUzo2sVznexWtgC+fp4Z/7yKpkkS/UNjOrbgrHiHTsfoHHbqELWsQbye7Znsi/+X+PRvmn6NoC5y+kL5y5zbFeKjAQOWUkf5aX9Tui6GZcsJGl3xU5HHuhu136OTj8byGAyDIVnLqDnIVpwKLoK06ROYi9TbTYVgqKkekWO2fOE9Qn+3SbM4Hr942nb/mwgDF3w+iF1GJdllZRGQrB2nFmzVOdG4+EGAlH8fjk3AG+G8Rv5vOIdBYKP9WitwXVwuYtw433Ce+QKuPiYIsvm+atxtd5nnxN7zT7Nqo7xzIRwelxjkbTnoUu6C8PZSTn1ruB1krFrM9fcHD9zD7H3bhUru73PqYV0t1uldqu6fkxVqcAWbeKoaexTn7SnbRMg10zXRNP3gzJ2JLMHQZqq6OpYjm6YEYPMyU/HMZ6vyc0PYdHKbpk+SVflKrBfgbmHyxYqlu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199021)(4744005)(5660300002)(8936002)(8676002)(41300700001)(316002)(2906002)(83380400001)(2616005)(66476007)(66556008)(4326008)(66946007)(6506007)(38350700002)(38100700002)(86362001)(186003)(478600001)(26005)(110136005)(6666004)(1076003)(6486002)(52116002)(36756003)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T+WsshEpQYy3CLLa2pLGes9lqRuQfCQPBBuU/pjqfgexbJ02+Jodd7hYgKD7?=
 =?us-ascii?Q?5M3O4yRcxW4W2/jAd93wkEf+gg8m74E0ao0ctAJL2VEQeuQbAlZ39JmExEvy?=
 =?us-ascii?Q?vCr21FEIsFs2peMZ3/e/Sr4B6vVHING0MHG5n+eXXu34wcV+0AIb+ppY/5N5?=
 =?us-ascii?Q?Fet1nz6lmbAf7LCSktIat4PxU1ni6FmM5dCamXPKjRiZqF7NSmMBbEgv+n7k?=
 =?us-ascii?Q?BpmMQtSTnVd1xbH43xpEuG1dZUuVtQS6seXOJ1beMOixBdWWRjgaeGWLNGuL?=
 =?us-ascii?Q?HsDJ+AHA0E7Kbbwg/yveMrFLDIYkvrcivnSrQRQi6EqhA+G/Ml/WPAadHGmj?=
 =?us-ascii?Q?1vdAJdkTbtS01KcvLiGRD9OBH4wE5p7xcSa9V9XR8X/jJwHWw+rAB1ikp9Ua?=
 =?us-ascii?Q?8ogRAv8UGlvypFk+rDAQnB7MfFtS89NBQHobn6GcztYyeoPVotil26a3SDnn?=
 =?us-ascii?Q?hzPOqQoOC5FNMSOIilz8fe/WU5gjh0JnW6Noz1fvtszNHfKZxTaSyNoNyqpj?=
 =?us-ascii?Q?+/MGKdEpEYRQQgCVlde5P4B2+iHqLLDAAc4H2tdlsASLbJJJP8gcfveF/F3r?=
 =?us-ascii?Q?FQ4TpfG//u7l6CsmkF0GXsU2jNliETUQMzjCOzrpXw3EI4oaKBG3rWUZxpdo?=
 =?us-ascii?Q?81mUr6ubNed/kRHCfUbSMBO6+Usn1NLoUlOmBX49TN1GS+bgfdzEaXafqA7f?=
 =?us-ascii?Q?wPfPK0B9Hk1lYbEIcIkrkCTSHfzCLghSd7+qJK5NwwSl8cH1CbLB83tBkI4Y?=
 =?us-ascii?Q?FVJ3YHxwAJQeU3sBYnC19/Yl9G+Bccgouz9th5CaOnSgdyq738C/I21F0OiC?=
 =?us-ascii?Q?BRfYtLdTOMLjQGb/mkUukLZLFPzMcBtCca1kJs6RRVW8XJLmOrq4X4dBLsWd?=
 =?us-ascii?Q?CUUW1256zPOCT9u6CB+f527+Isr629megfEXhVLer4JDwGnyuTcRttLzL1KF?=
 =?us-ascii?Q?PreE+preE3Sdh1avGIokmLsLkwlf9lwRmVKhAqYWoZiUGXVAz6z89Ln9Uvqt?=
 =?us-ascii?Q?1MMLgpVw5z20fOn2aIIVLHhTLOlym2MrDaxdCR5zbrz9P5aaXTZh6W7rjIkZ?=
 =?us-ascii?Q?YPzQ+Q45bZfWXVCNHUequpeQSNpVsEuZvYi0l0/BsN/vsCVHgvIg5NBnTp93?=
 =?us-ascii?Q?yTMp6Ti9hxvC0WI0BibShZh4+Jx1dtOYqpQ2T2QLjfVdyR9X5xPIrY3eKAsu?=
 =?us-ascii?Q?GUa5dngqq0vVsIIFlMjDKQP4zo7rrgRmAcbOCq3RePxUwRztLyTYEmNOXtaR?=
 =?us-ascii?Q?e7p7MaXDa7WzaEDgcMacFm2hYOX9k9EfGdQc+CeXVYiR3RcJNSRajUCZos4Q?=
 =?us-ascii?Q?D+lXGsmnIujgvgi7umQ7uaRpAtBcNQ20LOX6IoJ3UpzXYb/Xc8BtskrwnoYX?=
 =?us-ascii?Q?WNZp4qNCX/1cjyCA+4LJkUUhNQz6BrF9BJswzM1gpy325kilVJNec8ZCHtvt?=
 =?us-ascii?Q?ISDDHet95T0ZQzsP0cCPpvXd1rDip+QgGN8/A8voOE4WWAkpFE6fOrJKxtBw?=
 =?us-ascii?Q?CF0FSAN6CXTHYamkV3darQm9oxSIX+feM+OtdVQ1KS6cgXXjFMWL6YOkFoHR?=
 =?us-ascii?Q?mnnQmFDp1AbglllB149PrWgsFaNdC6zmqoXASSjP?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c5d897b-d067-4240-3e8b-08db7d531fc6
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 12:26:57.3844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q3Up4dcZIwATdOG30LTazUFdmiBauJb/waGuujPx1UH3FRidyhRC5ygIBqhV97K6sxuwsTUje3NQBzegrCKEJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5551
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/soc/qcom/spm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
index a6cbeb40831b..bab4897267b9 100644
--- a/drivers/soc/qcom/spm.c
+++ b/drivers/soc/qcom/spm.c
@@ -275,15 +275,13 @@ static int spm_dev_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match_id;
 	struct spm_driver_data *drv;
-	struct resource *res;
 	void __iomem *addr;
 
 	drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_KERNEL);
 	if (!drv)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	drv->reg_base = devm_ioremap_resource(&pdev->dev, res);
+	drv->reg_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(drv->reg_base))
 		return PTR_ERR(drv->reg_base);
 
-- 
2.39.0

