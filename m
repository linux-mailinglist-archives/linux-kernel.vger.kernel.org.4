Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB0372C3CA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 14:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbjFLMQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 08:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbjFLMQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 08:16:42 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2117.outbound.protection.outlook.com [40.107.21.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30733F4;
        Mon, 12 Jun 2023 05:16:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJyfEk5zjfZdRZZNwQzhTgfAn6dant4v6ul0qqWlIkA4+bUp7Zmtl7BkMIwd3dQR6h6NRYdyZj6KrDEFhlBqQrkMgjDXy3YpFXiBQ61prbHhJUCZb2WL5ZbVUU5Jjsvih69KMY4pRiO/ja6MNT/DSKErL3nrlMh8bdMGuklV2Zsb2BwNrRtyhEWX8BE7zMzImEPpt+b3Igu8E5Fp0oJkLYKzjnH2vZ9+Xwvb+MBi36rYLUMipCxkz7TOme+j9B8TaEe+FKIoBjBBO3g98zkAzEamSdIufDeNJzLK68Y92p+y4GUiZI+SlCTmpPp3G43VCwiwAD0QU8wI+WTiiMpgWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhy5nzPuN3x/cZUnD+cL3iseeDa2ulwAo2H7jRMJfiE=;
 b=IUxZqcjyl3M089HrGxqAj7cWLKKw8jMalNa5UD+XViN+vhTZW6q5vIATbW/HDBytker1/MsxcqqsYc/ho7/c8YAg55swgIVsrogA5ps5wRYQaCD0C+5UO/dBED3KUkB9kyN9a5adDfAxpYxkgZUSZwTJFL3+ol6KrlMP7DB3AfhIsWST+Rp7A9LCBPOtYq2Qj/kfc1pOEHbnVKSwmVL4xcq+mlMEZCOjoC6PCwZKWDaRf7mo9BcNt1Nf2ztiNLM95brFiFDPw3PtGVNw2d7CpBTFJ5PNWbE1I2qyz14TZDpbhubqNopoT9P1demhRbNItqiXOX1kpejspGr5GjyrPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhy5nzPuN3x/cZUnD+cL3iseeDa2ulwAo2H7jRMJfiE=;
 b=oTnI5bX/Lrbd3RuJoiLVaz1gTzG0pyGOEZP/Q8M1nfz+m4GnwFYId92tlbLoe+KnyD5trbSnnhWLrrnrbatRdZdgQF1TNLPhj6UhZ44kpBOhu14eTNTVD4OMSL9e7Y6dkRr87KCBOmXkxMPmAuPFQRrwTY+Ykcd7eBSYxOBAGjEb2yVZ09zq0KeHk0W9PYY9nzSw4YHDCUVpyI1jy6Zhot25MBDzh/NlaxgARfI3cFKXCztnQk1XpcXmaftapdhkClWG55Y3qDdZLcPy6TKNoGI6AgD/eqU/WrhO1l/89sMFByjr7ZZtj5KEo6229KxQ9lOo/tm8Wg3lJCFjblf/Ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from PA4PR03MB7488.eurprd03.prod.outlook.com (2603:10a6:102:bc::11)
 by DBBPR03MB6922.eurprd03.prod.outlook.com (2603:10a6:10:20e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Mon, 12 Jun
 2023 12:16:34 +0000
Received: from PA4PR03MB7488.eurprd03.prod.outlook.com
 ([fe80::fce6:c9d6:1685:4973]) by PA4PR03MB7488.eurprd03.prod.outlook.com
 ([fe80::fce6:c9d6:1685:4973%7]) with mapi id 15.20.6455.043; Mon, 12 Jun 2023
 12:16:34 +0000
From:   Markus Burri <markus.burri@mt.com>
To:     linux-kernel@vger.kernel.org
Cc:     Markus Burri <markus.burri@mt.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: [PATCH v1] iio: ado: ad7192: Add error check and more debug log
Date:   Mon, 12 Jun 2023 14:15:54 +0200
Message-Id: <20230612121554.367285-1-markus.burri@mt.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::14) To PA4PR03MB7488.eurprd03.prod.outlook.com
 (2603:10a6:102:bc::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR03MB7488:EE_|DBBPR03MB6922:EE_
X-MS-Office365-Filtering-Correlation-Id: 6af2ed33-f6f0-4139-bead-08db6b3edce4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L39wHpjE47UMIwhzBkbY5unwbmvX9eHRa8psaUh+iuAyii3ap+0r9gok1bImp/8uttsfo9ZvR3fEqbF+2aihKgEwwkb91w3ghtCmWyCUS04Z6JL7Tpnr0prCWRd9D/Qz/vlxxATlLS3sRy/T587pvtfR+dzx7XhhxEdLABxxhB6hZm3aWZvGfDHoaH/vVE3lJV9neIqGOXfmBsAUhQfFUDST9bqu7VndGRIbgkpfLwrqNe37o/Pf1MKKmv8bxn7LL3Gfz3cuhBktU1BgcV690+LucdyRBPZ+nnz4euaLZTjtvHJQ/ZyJPQps3OglFjnLrOaoKeJjDzDsXCQWrgiUICR7xvYbgEPXyFTaUfbweCLTH0R8lsgC7NihSkP3V0JlC+9TGnZRLYNmq5Dq+8zsuISCINiwQuNg5jUCFR0KnhLD9V69DlTZH/Ro80VL9mNTZVVJ+CXBwl2qgoyxIQrKQDWPFbbwWm6y4Rt/v2uFT/GH3HCrM1gpoqcmEpE9kp1+U58rbbqj8REbRgIOjwJA+vqJFSrbYBBz2RwdhwhzOLjm0BaFDKEiDYUfoGIVHgkDsSM0TT2zvHPCzK1H7lcCVUbKpRmxGnJst6GoO08zrd6z/cp0CEcMPdyc9Rr6ZW2w
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7488.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(376002)(366004)(346002)(136003)(451199021)(44832011)(4326008)(6916009)(66556008)(66946007)(316002)(66476007)(41300700001)(186003)(2906002)(54906003)(478600001)(8676002)(8936002)(5660300002)(6666004)(52116002)(6486002)(6512007)(1076003)(6506007)(26005)(83380400001)(36756003)(86362001)(2616005)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hrzI9t40dz1BvGLrQ4kW2v+GhrnVfV3eJua74k5tnRIDkc91TMox897/lMMl?=
 =?us-ascii?Q?uZ0ltAU3xA+8drW3VX4Y4lDjmUwPcDBO8Otgeh3EGmMmA7edy/HHTPcKbius?=
 =?us-ascii?Q?5S9g0yfFxh7OnJ/lhh8kf1mMLeiFITR1dYtXtca74I5TsuH5WKGYaOKBXqxg?=
 =?us-ascii?Q?e427wG+3deJ1HRfJpK3UA3nmbzqokLGTPlpZe6bDBZxLu996lzA3aHQbMLKU?=
 =?us-ascii?Q?jyPrNj5uOqbdDfBrYMTrmxUbWH2l13mMNmfpRV1XWSpX6/4+48lazt83YFyT?=
 =?us-ascii?Q?cCme8CSSCaKkFe94kY5jCdWnLYIPZbZ4hFjdw9wDr8rIMyzfon5KGYCQrozU?=
 =?us-ascii?Q?U21i+Jz5dUX+2knbi4fkK9IUqB55JRBu5+wTu+Xq+J40YDpDpdqom1VbOxEO?=
 =?us-ascii?Q?0Q1B6X3bmLFe6bfOEJ+8mPKTd/YG6znCiOUw2BENqZwE8jvBOboBLAygS9Rr?=
 =?us-ascii?Q?ankhIMlhBzMZAvK7hpHug7l4Ob30w8JQS4rsMZNodH2RD6Te+dDMOcXf73wE?=
 =?us-ascii?Q?0qzcKNSaOiemW8GlPLqlmW3dJM0mPk4fE1xZjJo8ms7PdVOMZDaBjj0+YMe+?=
 =?us-ascii?Q?OFRuDXZmKCVD9Ug+fZN3vrP0J4DORScQ08RmGWmrS4uQk4A7ZyS5k4lGW+7b?=
 =?us-ascii?Q?ORGQFAHQzPWRETV1H1mcTs4bfP2JFcffQwDcNpsFceL+6fYVcdNxC57j1DsB?=
 =?us-ascii?Q?G2+0j1gKwU2RV+AB0gALGgyOpKjQpMF+qo+ticG8PS1LTispyiUGexMtQNdk?=
 =?us-ascii?Q?uQXl0XSukDILf6ncoX8/pLGwKEoaCnOoAJc1xmEhve7DQr+84TGNpvwOT0if?=
 =?us-ascii?Q?tjz6/py+/Ye2Z/TGHqS8pWLtnUw3bgRUo50CIHnCf6Ixi/N34lftvZC3oXmG?=
 =?us-ascii?Q?JpsFIY6Lu0S6W1x3e/TZQYVvVRWKW5EYWSXianxmlt+g3UbNQSZnY6LPoiqJ?=
 =?us-ascii?Q?G8IRfaYTMq2rhn1SeFGAPHtyyc1yAL0fi979Bt7UMnkGdjz8blAOcen/tJ/H?=
 =?us-ascii?Q?eZtNrIpj1XG4DKrY70gNiVOFzTjMRoIySMlneVGykQYRP0M5gDEVdBRimYda?=
 =?us-ascii?Q?/0V3+CRnajktQuXQ6/uAnNeZBN7j0jYAVdeezZZk6YtedhUz6STdO2BIp9Eh?=
 =?us-ascii?Q?/Q/ZE0H/xWoEdA5oCTy2LBIegnYIOsaH2KXTdU2rSlr3OTweZe81bDzBs1Pk?=
 =?us-ascii?Q?wosfLl/OanepZjhxMvtJxors5BkNvgc/HbhgF6bdPkY2xutrLr6ZazdmVTnS?=
 =?us-ascii?Q?yCBh0PwIgTD4B5+4/gNbTfTkcYNS6SLxgG/UFjBFN5//jLfkF6Y25lahmG8n?=
 =?us-ascii?Q?yOR+nixfRqi+QdGDtb9dgSfRWPI4Lg/gRGBAYpQFGWZXrEzUHIaBxszqR8JI?=
 =?us-ascii?Q?12I5Q7Muz3fLOr9rM0q7+NZkES8EzjaUMVgzPHj8c0zvH0TfWAGLycFf3zOo?=
 =?us-ascii?Q?sMgfll3b+cA/dvdY9mfd0gtYIIi/nYqPVntNALVWEOcFPIg/jJ1VaKHmlXNK?=
 =?us-ascii?Q?Ci40we5rQjVDH/MEKPT7LTJYXuHFQy9rYhYjSlw+CGfazYMRimv+/BmmocYi?=
 =?us-ascii?Q?sLmxZGQX8zVxPymI9HFsfs5aZG9FZvx8CaZfy2rV?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6af2ed33-f6f0-4139-bead-08db6b3edce4
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7488.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 12:16:34.3006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1PYEJLC/IYCJo2melmuuH4yRvCZKL02rXzSoHllW6R6GT+cW2evT7IqdPbXt/0nax/lXPyvvwYnMkYYSE5DpYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB6922
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print read and expected device ID as debug warning.
Add error check for sd_sd_init() result.

Signed-off-by: Markus Burri <markus.burri@mt.com>
---
 drivers/iio/adc/ad7192.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index d71977b..220c3b7 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -403,8 +403,8 @@ static int ad7192_setup(struct ad7192_state *st, struct device_node *np)
 	id &= AD7192_ID_MASK;
 
 	if (id != st->chip_info->chip_id)
-		dev_warn(&st->sd.spi->dev, "device ID query failed (0x%X)\n",
-			 id);
+		dev_warn(&st->sd.spi->dev, "device ID query failed (0x%X != 0x%X)\n",
+			 id, st->chip_info->chip_id);
 
 	st->mode = AD7192_MODE_SEL(AD7192_MODE_IDLE) |
 		AD7192_MODE_CLKSRC(st->clock_sel) |
@@ -1049,7 +1049,9 @@ static int ad7192_probe(struct spi_device *spi)
 	else
 		indio_dev->info = &ad7192_info;
 
-	ad_sd_init(&st->sd, indio_dev, spi, &ad7192_sigma_delta_info);
+	ret = ad_sd_init(&st->sd, indio_dev, spi, &ad7192_sigma_delta_info);
+	if (ret)
+		return ret;
 
 	ret = devm_ad_sd_setup_buffer_and_trigger(&spi->dev, indio_dev);
 	if (ret)
-- 
2.39.2

