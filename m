Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5924C72B9E0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjFLIKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjFLIJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:09:36 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2121.outbound.protection.outlook.com [40.107.241.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95EE9210E;
        Mon, 12 Jun 2023 01:09:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZB8Pcgq86cJMoHYb3+lCye3zTFED0GOVQqPloSwb/YUshNZc1VnzX3Astls65FKYzomOrYNsN5q96n+YT5eFXdaqm3yeyMWcHJ4zidE71gLcyPrXa1138GF96iAuXYZKfdVvtQIQpwjkJWLpiT5fouxeQxp/OG05vCaeuidWSOQO/v6jiqcz1i65oFXWVh51/+uAuA7iXeE7KtghkDG9xjpkfrpJn1S83Ot3uB5NpRqNaMvKUWE5eKlifw4Zcfv7f+pS51VHlbyGJ/0J5pC36C3zpRe984QtEayOvPVtOLkj0dwiql0rnyhEiuU37EWwqPsomma8Y6iGS6U3u9vdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tVxPQsAGNNR/w8FplJo7mrlA3UOZG5GtPgXl6ZlCVk0=;
 b=exPwfaaS24CGindR61jADe1dsE/RrBFpV+nWZzJHz9XeKLMQV0+WXdVBpQFTk/KpEv0cIoDkYDS2mriiiDCYgO6uBKBZyK0zYq8ApXsjfKuJ5Omf3c/4QDIu3+o+hdwDbJfZwJQLxjEe+tnfq7AU1qSRszIafb6wSwgzu4+3Npb6TIK1ViLVcVjPkN1WhYAIStRVdMUyjCtABoqyJE+o6q85x/2Q9sZTGdvIvi2S2rxYpqcueO8oi+ytcxeJ24J4F0wav2jH/o5ZbARu9K0Pvhhve/dbSdN5D3/sZSnphrrGipqh8PUNasUyMhT0ywwEXiUydr+pSqaYUOUqB470Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVxPQsAGNNR/w8FplJo7mrlA3UOZG5GtPgXl6ZlCVk0=;
 b=saDQ4ZjU6+j2Ope7ApnFTXAcZJFQckRMdc+ZwnmKQWOoQIYR1fSYAq6th7fm76iCuFZ+M/eQ0mlZVzRzLJ1LxA0r18JvbRec4UOwiuwkvz7j9/lOHZJSzItp0LKas6fdtuSEML3/eDhW78jD096QuW3XvrquEcrdCnSxnkfnPMIgziifEzfXqpQry33B0A/7p+ZKb8lh9xc82pFZfZXkkqNCbyLQqL61wk/28H7Ka0KiR0o7foMDVsNX77Wou2HeZ/fAj7Bu7/M5pGIBvCZq+MTDxiODLHBbknVXW0ZbDLuS7EgamrqL4WHAHIXC1o7TMXMLA0pQ4+a14nI21vv0yA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from PA4PR03MB7488.eurprd03.prod.outlook.com (2603:10a6:102:bc::11)
 by PAWPR03MB9902.eurprd03.prod.outlook.com (2603:10a6:102:35e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 12 Jun
 2023 08:09:09 +0000
Received: from PA4PR03MB7488.eurprd03.prod.outlook.com
 ([fe80::fce6:c9d6:1685:4973]) by PA4PR03MB7488.eurprd03.prod.outlook.com
 ([fe80::fce6:c9d6:1685:4973%7]) with mapi id 15.20.6455.043; Mon, 12 Jun 2023
 08:09:09 +0000
From:   Markus Burri <markus.burri@mt.com>
To:     linux-kernel@vger.kernel.org
Cc:     Markus Burri <markus.burri@mt.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: [PATCH v1] iio: adc: ad7192: store indio_dev into spi driver data
Date:   Mon, 12 Jun 2023 10:08:47 +0200
Message-Id: <20230612080847.39170-1-markus.burri@mt.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0048.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:53::13) To PA4PR03MB7488.eurprd03.prod.outlook.com
 (2603:10a6:102:bc::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR03MB7488:EE_|PAWPR03MB9902:EE_
X-MS-Office365-Filtering-Correlation-Id: f0ba6fa7-bb1b-4e9e-4e71-08db6b1c4ced
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GvxBz0jEcoCozHJhKxOxotqR4HVrHgslbjJSFoinsWmkG+gQ8PAmzXHC8yvCevcr59QuqEgvFm0BSIQkj/WYQ721GKjkOMyINnSNa7MLsKmB+cK4M3K/sKgtE0LP4gg+2pLYo7F+HnNunzohEAQp9PkJzk31IZkN0qE/Ar5jTQ5ydCep8+3BjNMDcVPh1p+KPHcFeCpMoffdkPF4l0GJrxCpMES0k7GI6TSYCTY9PmloaovgXFLMlb2VYoollG5QvNjwJdxs2IWCoOhOehPYbPhBqWxS0NB9kmCgOGpGp4zmJwC5j9pRoILzT7pGfp/RN1A5JFGRZ1tFXLRgq/qTuZdlXxKJtqbWHi4t+3HKRPkOkXnsiodgNH+WeS07E0U9wgHx6qbwGN322+bzh7ZdiYysL3ngN5nOv+UwqPUI6mYwkTwVtZOp3OJJapwY3nw7nD3k0eg+HX+vWNI5buMOZJbPiuzD5rC/RJnkEyZFkGjd/PgdtsDQgrosjSThfxJv+tBWcI4sWbuATqi0qW3sXws9VVvulpv4zRgpOrx3Jub9n9TpfcEv9lrnJncPUoOhaassI7HRKPidD+k4MbH8NN9iZ5k2TUdX/g/lzSKYH/52FkH6K4fQzOks8ji5hZkT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7488.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(376002)(346002)(136003)(39860400002)(451199021)(8936002)(44832011)(8676002)(5660300002)(4326008)(6916009)(66556008)(66946007)(66476007)(316002)(54906003)(2906002)(41300700001)(6666004)(478600001)(6486002)(52116002)(26005)(6512007)(6506007)(1076003)(36756003)(83380400001)(186003)(2616005)(86362001)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PdQGud0YuAd/ZIIQ3h2Jia47NIJvlNFRH5zcyDCY7602+VVnZgkXQKrONrDw?=
 =?us-ascii?Q?yOSQPgvrTz+zH9MhYzhFsHxBcAfYVsWx7PX1E6NochDdGmo/KOhsAY/V4JC+?=
 =?us-ascii?Q?TQWOgBOldXeZnDThmtAALSzKlNOJpkofZMYMuLGEGRLpSoJsddjsrHJkOrXW?=
 =?us-ascii?Q?mHfFQRbfxiyaAlKmm3UdJ+k+iDvprRGYBesD/txvs4rPvQwLRv28wm8nNerS?=
 =?us-ascii?Q?iurXlmruB9GFfVImVWQOr3kNGiW/203vWA+wgP5rOkYFqfZZnPl61Af7X2tu?=
 =?us-ascii?Q?q3YBQiN3chB+b+VBZAryM5Il2PMQq7GI5iBEIfm+Y3SNVCFqv7uQJlReUXKK?=
 =?us-ascii?Q?z1iMzUr0iSPOGU/G65ExJMT4J3G3iZpHZhup9OU+D8zPENZXkkIkYo0CM0aH?=
 =?us-ascii?Q?p1G6ndV47oEyeDOYOIlO/wTHbjdeONs3kbnjpvqYv7gQuvNtlzgr9XBtEhem?=
 =?us-ascii?Q?d5wZpPWnPENDb2ocVVJoCW7F9HdwjbbH97gUtQ/IHXKmpev1mAOMmMg+0lDs?=
 =?us-ascii?Q?yTtxJUXUi39y+Y96o91DZf3qVRgjL5aWUfVQrE7h4iBiFVXx9RtdkkxzOyOZ?=
 =?us-ascii?Q?pQWPlnLQtygbK822ovCLbRuTTqkodcRafw+eIyansEp2Xp06RIGOQMYNYAWr?=
 =?us-ascii?Q?+gBfJYxxvZx05EXDSRQfRc4ZPG3U9QyXMImoRS4syKir3anRlquxAZK3wEb0?=
 =?us-ascii?Q?S1+BV7dTWIqDMOFBQqv20zju3glkYIFmXePUxaFed3YyhFEC8f6tK+3mFYRK?=
 =?us-ascii?Q?KTvlvLOs7uLs6oJlXi7Q/gFFd1RpDt0Em9xr7PYu0XHQZcnI99AdL7hPmzU7?=
 =?us-ascii?Q?nV+dMforP4IGj3rYvtU5AUtIJeyLhqvD+bXJJFgQbm473aA4UTKvmdLWv+js?=
 =?us-ascii?Q?aUHtCj4SXB56xqtxBLM0tCHEoxp3ifUoYmQdPMEo74NiHLE2NPGqzQtsKj0o?=
 =?us-ascii?Q?CoHIVfKBMAn3b2+va6hKyeZoMJSqMVSWmHPerend0pstQ0F0v4jqqUQhd5Na?=
 =?us-ascii?Q?/7rfzncN/11cFEfhhEQIRWQRtN6Yrdd4+XyNdWAb/2PBzyPnMjI9cX7m82oL?=
 =?us-ascii?Q?6k40+iLnhWeIjQxKeg1Jyzxg/bjT5GQIBWW8nhq+evjEZMtyjKGrutLrYkBv?=
 =?us-ascii?Q?QpacwVLY5UvsR5/WnBElxwa2Hl21axDcn3N/vwgwXw5nhr+SR9CIKEBoFn2z?=
 =?us-ascii?Q?HgwO2F1LLXkVIihj/kanK2ff3LLsQFKBRlFR7bSn41L5XaHPncPLdgyl+1iT?=
 =?us-ascii?Q?M5qVoWh3iJBe9iOgUvx5lQy+q7hByduGOCCmCaD/aLLruPoXW+eHeEKdZuuT?=
 =?us-ascii?Q?7v6Gz56EZGP9esI8BwrmNcHXs7ZSj+JGWJTfIZ27QBc4ITJEwYRlMIi1i0Kx?=
 =?us-ascii?Q?Q0Oj99F1O7pGIcyfHhn/tL81Nj0em60QthWxgnh04zV5MVhxq524vbOC2ZkV?=
 =?us-ascii?Q?lbAvqZSZ21aoOVo5XtnBn1fDMOqXLr8qs0nHH6UrbSgoAac5MlXo9weUSLdL?=
 =?us-ascii?Q?lMw4VzUSesYa2XRSlUHu7ep3vwiHAXm2aQ3PGb3kRVnxYYDlL6e68lzJSK1x?=
 =?us-ascii?Q?kuFib17RmWvv0qo2rVAQl4h73/lQndVscXnlGpzw?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0ba6fa7-bb1b-4e9e-4e71-08db6b1c4ced
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7488.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 08:09:09.7947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BeGmukFJht23IvpJsBlsY5VjPewM8PiFJ9Jb6m8CNIPBNwVyQ1EMmBgqJLL7lAONsxI0yIAN4YRKFlb18WGong==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR03MB9902
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After calibration the indio_dev is used to get channel information.
Since the pointer is not stored into spi driver data, there is a kernel
null pointer dereference.
Store the indio_dev into spi driver data to fix this.
Add error check and slightly extend the debug messages.

Signed-off-by: Markus Burri <markus.burri@mt.com>
---
 drivers/iio/adc/ad7192.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index d71977be7..7c2ead72b 100644
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
@@ -998,6 +998,7 @@ static int ad7192_probe(struct spi_device *spi)
 		return -ENOMEM;
 
 	st = iio_priv(indio_dev);
+	spi_set_drvdata(spi, indio_dev);
 
 	mutex_init(&st->lock);
 
@@ -1049,7 +1050,9 @@ static int ad7192_probe(struct spi_device *spi)
 	else
 		indio_dev->info = &ad7192_info;
 
-	ad_sd_init(&st->sd, indio_dev, spi, &ad7192_sigma_delta_info);
+	ret = ad_sd_init(&st->sd, indio_dev, spi, &ad7192_sigma_delta_info);
+	if (ret)
+		return ret;
 
 	ret = devm_ad_sd_setup_buffer_and_trigger(&spi->dev, indio_dev);
 	if (ret)
@@ -1077,7 +1080,7 @@ static int ad7192_probe(struct spi_device *spi)
 		st->fclk = clk_get_rate(st->mclk);
 		if (!ad7192_valid_external_frequency(st->fclk)) {
 			dev_err(&spi->dev,
-				"External clock frequency out of bounds\n");
+				"External clock frequency out of bounds (clk:%d)\n", st->fclk);
 			return -EINVAL;
 		}
 	}
-- 
2.39.2

