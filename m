Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62CA72D972
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 07:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239970AbjFMFog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 01:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240002AbjFMFod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 01:44:33 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2137.outbound.protection.outlook.com [40.107.22.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A319C;
        Mon, 12 Jun 2023 22:44:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LI585sdAasVrLymvPZ5vgbeZRilADI+c3cvaY2sha0LhYnyt3H9t0f/dc2tHbW8/swg80PnPB/UaCEcAiFaVhweUUGp1mHe+mRto3ct48WoNf+Lj63g14DQOOiryCCLakFFLNYrYR9E5YeQIS5/5GsDo/pn8C8kJWW2BiwDxzZTr2i/FKcaWMHJmXIuACcJpIBNMuZPuABZikmugBRZ8nO/R5sUFEuZihmh7tVswZCDA4MB12qtPY7JTpa8ohxoiJd+o9ztm47m7K2M4F5GY/M9sgmJo4gd5Y8EElpMqBPaBur6/BWT4sptKywzZusa8zGwhT0cVwrW1iXd0ZGrW8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=763gNq6HC+K4L927KHAwojvCPYeNSfj/w1ElciVOHeQ=;
 b=br0eTn37drF/T2CLFfonM2WBNVm67gRbq9YBMUAmEj2+1gBfo5YBxVcB+jEBK0HlH/Rdut18WJk8Vayi//r29dtdv+mrbLzchfyu48QcTuFkYvE6DbmlT4RNPfq/6iCv9MqKTZXUoMSRIV96yBuYIK/95FH8pqtTpt43rnWgIBSoeXo3jHnEqcs4XaShte7wRRuCAG4kBdv6p0Lx375WRt6qMhV8jO7vmqRF1f4zIVwVRDMEBOIwoSedU2xkR0EJE2KPbw3pWBqgqvwSsvvR8ipMGCk7IZC5ZA0rVSah94jTw38z23jkKSqzEFjhS3Mg/mSrb8OzyvxJqkBDm456ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=763gNq6HC+K4L927KHAwojvCPYeNSfj/w1ElciVOHeQ=;
 b=t6/QssaN8qE5o/2HuAnl3ZXOfBei2cMKRSMmMKLWYsms8EcK+xEhrcQUDzCC/TAELTTKmHM+PEFgye6HzqJNWghnYxHnttZAxU2k2BC0hd+2uFOx0K6Ziez1VNs98MLHhhJg1yH7fJq5gjrlv8yph1mWozK2KgHFDDogpHCGmYZOGkNFvUtNcPWOlJdopw2NbXWQeS63tdQ6U9rwHOQBA9YJmeisVooRazu7JjkuS6LHeArsNC2ALSr0cMHe7/6q0d0+xDLYStkTQ3hVP4bIyE6tt78t4xiILQzyAQUVKIo4LXWdl0zsJm9PtWTPT30V8Vu56z1nVy+01Caey7tbyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from PA4PR03MB7488.eurprd03.prod.outlook.com (2603:10a6:102:bc::11)
 by AS8PR03MB9094.eurprd03.prod.outlook.com (2603:10a6:20b:5b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Tue, 13 Jun
 2023 05:44:09 +0000
Received: from PA4PR03MB7488.eurprd03.prod.outlook.com
 ([fe80::fce6:c9d6:1685:4973]) by PA4PR03MB7488.eurprd03.prod.outlook.com
 ([fe80::fce6:c9d6:1685:4973%7]) with mapi id 15.20.6455.043; Tue, 13 Jun 2023
 05:44:09 +0000
From:   Markus Burri <markus.burri@mt.com>
To:     linux-kernel@vger.kernel.org
Cc:     Markus Burri <markus.burri@mt.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: [PATCH v1] iio: ado: ad7192: Add error check and more debug log
Date:   Tue, 13 Jun 2023 07:42:51 +0200
Message-Id: <20230613054250.472897-1-markus.burri@mt.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0041.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::10) To PA4PR03MB7488.eurprd03.prod.outlook.com
 (2603:10a6:102:bc::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR03MB7488:EE_|AS8PR03MB9094:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fa4a7d4-9bfb-4a4b-fbc0-08db6bd1357e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zvDt+k4x5b/tN+wujzgG4vPhQkB38+kE9ej4Alrf3wkkluswWOPtNX5jsieLGVhuC/kWG5hyC9iTFFSMt7PAiymiXEw5N8ECMRCo2pC96kBG8rWYd7n8nsrPxiQsfISEMp4fU9P2Z1dXJQJ75Oio2erMybhIFVOPJgj4tHfvzQ4wyu8Y7EdSCbkupBitSMYsLd2GEKlKXX7dQBxDEyA3F72QlZYEBXTBXdO+oMetF4+bIdTRz7HPVNMzSVPWulb0+D+17vF0aKUIvPyqK/ni5d8uCuW65HbQOvRLc+KbGzILV1WNscs84UawuODvV2o8UjqjVHlP/zwgQjUCquFEk+gqLI1nPxtcqowxJK6tbcomori3V71W3pZqmPVM2CoDsJmLLJaNGIKTSVX+XcIPsPUFfJTz+3hnV/KE04wul2FLF+8X8ZXTiyOCRwQwnkyFgrfW4cwkKyh7E5f9v5wh/kAxV/mvYnF6t58JfZ+H2vSJwpf1ZLQGQN1/vXy3Tww69APEMj42YFwMriXaiI99lLH7W4ymiRj4PPHh4be9xM5ti7MstLljk3KfjywvHyPnbm+ESPXkkeiV9OL7qtHC0V7O6aFK+owv1Dnx66WRwjxLMqAoos6/o9yp+l/+0IFd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7488.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(39860400002)(376002)(346002)(396003)(451199021)(478600001)(66476007)(36756003)(6916009)(38350700002)(66946007)(4326008)(66556008)(54906003)(86362001)(8936002)(8676002)(5660300002)(44832011)(2906002)(316002)(41300700001)(83380400001)(38100700002)(2616005)(1076003)(26005)(6512007)(6506007)(186003)(6486002)(52116002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fFXFycRGTcBjuNEJbOIpMRd1/T+ewT//jP5Fg/QL9JN2wZ6kPHrPas7ifM2h?=
 =?us-ascii?Q?uyQ+2GIy1HEFUhWUuCSrE8GcKzVH337/wLhLDUZWZ65kmCCNoq3AqYiWh5ah?=
 =?us-ascii?Q?Zkn6OordF8iDYMsFzWresb/lCzQOex0AwXlLTRidwpXV3tsbjFrfKH6wOEil?=
 =?us-ascii?Q?K2RUcQobj/3Jp+krQysoxCR5/uoAfOkNpzUPh9kw+JLqyDMdVLUn0vYlg8ph?=
 =?us-ascii?Q?vmGxdTvYtTYf3ABCPSnjbWneFd7vQOYg8CFjn1Y1k25433uhqqZXlWnES011?=
 =?us-ascii?Q?5S7aXEewS8lus0Ewa+GHOfIvgWxgQWUtxUEhlABvmOsPjA/VGh8UzSTfwT1Q?=
 =?us-ascii?Q?XicD+YsfqEHeTjw9zQjVpjC52SdAizK8le42FAZlAtOhPB5LvkMlBnJTIzKJ?=
 =?us-ascii?Q?cF3BzdB9XvF13n0BJkPrge7l5ocuBCkcDgujHln6ceFW6v0UGRmLPA4YvJRK?=
 =?us-ascii?Q?f6YBra1EFg4Yfd8omVB7iV2KQLR7zG0HGvQCpB9wKDv8BNOvPQrexVLBkvUN?=
 =?us-ascii?Q?fElv4+Xxe1dpMlMhTEUIOrSBfJjGFhkmAJ6f3qRSqT4OD+VJpygnAShGB2sS?=
 =?us-ascii?Q?R3siIJVCkRV0f6dQZWrD/ze+2QDyFqENdcjSa+Z7GbF0y9B8PIm28ZkiF5Qa?=
 =?us-ascii?Q?GZbBziuCmu6KQwf3FZE5NJG8w3Hrw6rfj2f5SsmtcEcso4O0/Y40sLtIVvqr?=
 =?us-ascii?Q?IJtWYNpzowg5DAFz4dLtxot4Lu+TZQ8LwjeyrELSO9TTME3ce2UUNbk2xjM+?=
 =?us-ascii?Q?D14bEnsywHkoSAPa/CO0YBjU1AYQ2Rmt1qBs3srpqPL6uqy+hGaaKz6diddn?=
 =?us-ascii?Q?jovseeCnkCQLA+qIcDm6E8Y7eE+lc77xIfPeEBHJUvp0ztJ/i+hy/N7Izwbc?=
 =?us-ascii?Q?r3BbsixDwe8qfUmurzKE/XGskZ3upYpL/PZZG6XfDzC2cLBQopqhguWSKtKZ?=
 =?us-ascii?Q?nZxfYu9JdYhvlUyVWq6kvVDRT8rrsSannAI9nJgjlF4Jbbkb93FZ2Z6Nc/BU?=
 =?us-ascii?Q?P0Gc4JMwsn/1AR/q5h0/w+6qvJNx9nLIHZnUyVhSbOmPvmfRyoY9kn8IdRmv?=
 =?us-ascii?Q?nxpUbBAhg8R6LF/3kRqtwmA8noR7l3zmV8tLFQ8Ob8DgCjD3dPF5mYJIPB8k?=
 =?us-ascii?Q?BHOSPEfDNurAgQLXr2CT5BxoSS3waYIIN7fekTqtPOH3OmAo4I95YWifQir2?=
 =?us-ascii?Q?GHK6ouykb97Zvyvw8dWdYvYdOBSaNz28wG1Kshnk5iErq8yL00laarONbfUe?=
 =?us-ascii?Q?j8jUXzPx10Cf3gfZaD4fE3S5DJmhoI9al08XAatdTaRLs9mhdTm6YHMZQPPH?=
 =?us-ascii?Q?A60pP/AgQJLOyL9xfp7m7vd+ar2xXjV5AZxHzJL7oE8LPtS/qYrqZhl9g5zm?=
 =?us-ascii?Q?mND7anZ8B1niRGfKBHnPxAHm8vPpCxMn2z/aKrjG9RipE3u+Q/b7V+35Y4gJ?=
 =?us-ascii?Q?m/3/b+0ZJJIGu+8tj8kzo8LHN8ByNwop5G4grtG1KoznOKqqCKXxIjymOqik?=
 =?us-ascii?Q?mBKZtPpH38c6Dp1MD309807OcmLKdz8KsZqBgmAXj6dmb9sRmYDTCOmTW1RZ?=
 =?us-ascii?Q?t05robbYUd9xCVJeaC211De22JKmLp0G9RyLVr7b?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa4a7d4-9bfb-4a4b-fbc0-08db6bd1357e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7488.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 05:44:09.4081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sYn1GNBjWhatlW05nvxohSL+vqz1/LicnsE7dkaqtbdhPhka+kwD2Tu1BlD/krDL4Wn9gRvFiCk3/xaT2tiHQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB9094
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print read and expected device ID as debug warning.
Add error check for ad_sd_init() result.

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

