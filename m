Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC3E62636E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 22:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbiKKVOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 16:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbiKKVOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 16:14:19 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B180DFD2;
        Fri, 11 Nov 2022 13:14:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RzbPX5a9ycNHLUqEi3GJddAv8bFuQyw2aN75D35ncLBIL9vZbWFJ/O2jiJXjwehqI+PNQiPB69n2L4tIddVgJOxfHeLocZNUNG7c8SYgRDPKE1T/Si+CaFGXrZullbT1SANJEDQsRwBON5WSb13AkYaFapv50So8ELtGAwAA1U0yctUY8MHwA+lZcUCfBL9ob9HRexbQ1bhqQT7Pp+vP6vzxK7GizuZMdgyVaPt0J+aEIqWE58zn4PxRvUaCv34ruoOZt51sbisAqwiWfqZsLuaEn784qunKZ86zM4pYRktzcIqrUxv/Ey8ElHe9ICf2s4EYERG/NMufkfat2TdHOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+rQcASeHaNOcgP4C7RUJMY4SUQJlC1Rt43NWvipg6g=;
 b=i4umVHC8Hfvxr6SX7oogHfzxeWxs2KFluN7uCkkTDbXTyuryKwshwDbb3GjGXmxgercYerYib//TM3GKSGeObvRoOiFyKyqIPjBIevEFkwLSz0dFvKtUVgV1Y/W4bM7OqYtLuRNuvym0CD48xjfgRbVC/Ml/2jpKXJ5hx8Qqt0zeUiFkei017/ODWEcik6UiEEYMoDM0lXgRK8MLyLW++9wX3r8S2I0Y6oIkomShSA87grwnRWi4xdL/0N/rAtwE529qlpm2DVfTrfw/Y7vo5hz3wqO0HvWeNxJOfstX9qHrKv8HqiMvfe44pBIKd09vZVg25q6kci/S8LI/hdRRzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+rQcASeHaNOcgP4C7RUJMY4SUQJlC1Rt43NWvipg6g=;
 b=G1kSOywuq/RkH7GTy1Y441+9mLHD9eqEmfkQO9kwoFB40mzf34SYYZR7mID9yabO2HMgQ3aG9h6s1/G4u/HhU+QH3iD5gm8sxAHZl9WO+yFxe1pKlSA1SPMY//bBAHyzY6UtNaxGTwZnNCf0Jl0GV4+nxoXivpj0bmb8ifBIKgY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by AS8PR04MB7624.eurprd04.prod.outlook.com (2603:10a6:20b:291::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 21:14:12 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::9317:77dc:9be2:63b]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::9317:77dc:9be2:63b%7]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 21:14:12 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     linux-spi@vger.kernel.org
Cc:     Vladimir Oltean <olteanv@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH] spi: fsl-dspi: add cs-gpios support
Date:   Fri, 11 Nov 2022 23:13:56 +0200
Message-Id: <20221111211356.545026-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0029.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::42) To VI1PR04MB5136.eurprd04.prod.outlook.com
 (2603:10a6:803:55::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5136:EE_|AS8PR04MB7624:EE_
X-MS-Office365-Filtering-Correlation-Id: dbaebd65-ccb1-4c12-b6e5-08dac429ae34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Su931dwWD3KgD+GzGQR1yE+lH5hM4wnPaB4Mwylfg5l7Gz2kB5Y97luXqTEd72XpEvg1yUk0ZHQlB6s22jAxfFa+odAX3RsPv27HcwG3UksV22R1iag5zaFxs8Xqix8rPE/ZsFy0wCGMtko9m9cJ+BgRs56bGYLrR4PMf+AIiJuNAop0NgPOdZkrjvyE15b0oHPQYA0rFcIVGVRH4AOFEvIzxMQX1LYaykdrqvJ+UPdevNDjkDN59oXXFWKYEhgIo8qBFL+TPsLvuqwX0DyVe3ORR+M0XSI5TJA7NY9S6Rjk3bLQJSyXj3JBVU5OUiEBKL67ud/ljIKPf/ZJy25Mx1H/525u6Ti1UPe6QZy70dbCYCwzdowiIPr0la1ZrI2ycbb1s0+Mb8s1y1HiFRFyDijOmBjAnkZpTxUTvf764UFrhrM6Xdvg4smywyOjAdCLCyXIM8gPX7ytTCj3YHiDpGpiLrEz0e/vDTBGDLbaIoRw6PYEJzzhCRViTr7d3shRIArX5gDR4JlBw1BPm8MHL0FAbxC/qhEx6oHnrIMaFYYEiCWDTheuva09NL7XYhTnEkDkbRHN0toH5JCeQwLwm1FAir3BzqpMz6OzYrC36I+zbjD7w7/AuCQF+rvziWy0ZINIOpUc5oAngb0JsjP5o1Z16VCJG1PdcwguK5z+GURsIL3m4+fVjKr0zjyK4rtRBKdJ/arMnvZwaHuEHX2bPnxVIDPxcAKQZL2zruTgvIUkIXO5d2FfLO0JIl7lvQUt9hKlimsuEIocD4+vRQLeXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(451199015)(6506007)(26005)(1076003)(6512007)(52116002)(2616005)(6486002)(478600001)(6666004)(186003)(86362001)(36756003)(83380400001)(38350700002)(38100700002)(41300700001)(8936002)(44832011)(5660300002)(54906003)(316002)(6916009)(8676002)(4326008)(66946007)(66476007)(66556008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tPfS3wZufI0+x8qo0Crz3YSq+iHcDu02K/0ey4iZWFU1DJbVgepqCp+tSzVu?=
 =?us-ascii?Q?F0Chcc9WWUjt8pGRWqptJUVniAFxuFHdEXGsq4i++FsC8iLQRusG8/dTNWe+?=
 =?us-ascii?Q?sDfDq5Vv86IvLdLR9jAeQ1q6ZZrn60J2hn0l5QlwYVicCB+HQPv2GtCcuFgA?=
 =?us-ascii?Q?UtizhQdLFjyr11Jc5xE/3f/+TwkUSmr+C3E8ivm3OJagK4abMPmwk1KCe8eX?=
 =?us-ascii?Q?8iqSOkCMFxv0GpmzYLaLvpCXow/eoFrZF6I7oDhANkHO2Ey3rhjdzJDpxAOU?=
 =?us-ascii?Q?HcMWeBTp1GOttdMoSgUbX8d1RBE9uiK3hLFGCwDWhK8WUBBp3vtb7TayFYT2?=
 =?us-ascii?Q?wPXBKCVWpaMV2MQByrbChjo3c1cbtEEwH/e58Fis/RpHwrs3VpgnuJyRjhdn?=
 =?us-ascii?Q?4YtF5RFeL7Jt5A6VUIw2v8J97g0KHaldGuSOpFmxtPSVTjvLms9tQD5COzAM?=
 =?us-ascii?Q?B9dVGElwriLszw+n7evVh3+uFyZ9UqSjTmsP6yDUi+cFAqFEgYZjg7h2sXiX?=
 =?us-ascii?Q?8LdXZRTU9u3pcSPaTOmyLLmxsTOasBhfd3lifW28Ss4UbTU/jzZO3YC+i64k?=
 =?us-ascii?Q?0eguumhB3wHPD2W815SC4j8gHO8tdADvxEFKMdYmHZXzp6iaiLUZsiclQqP+?=
 =?us-ascii?Q?mo3rGHPa3G7I4nn1keOfoK1N1lRh9MMgd0hKzVTdAuxSI/a1Q4oDFsa8PuNo?=
 =?us-ascii?Q?rvxJqsaejRpAVmp0hhmf2anoyULiudQu7H10jHywXd9Xst9C/Z8Fqs62UrPp?=
 =?us-ascii?Q?UoafPhj4HL7zA5gSWJrQkJzrSw/PM7e8A5lLWrYbDimIl3LUc+SGjNWqFCkh?=
 =?us-ascii?Q?wLpMvCPaRd3jmjI1oI4Mhg+/jDXPBhOeAvHtUsvsfmpg9Ozo5In48LmVsFSV?=
 =?us-ascii?Q?sSrvxQUbyHuMjcxcm4LbOMI9plkVJvTT10TmD41kEnmS7Q3pGXPJe/wfhyb+?=
 =?us-ascii?Q?Pxh0esLz+NIYe3rA3bTc8HpQJvmsiPlWmXT14uvyEFwCHaP7O+Nc7NFeo2yk?=
 =?us-ascii?Q?UqSOlXiNNZj5sEOiMHZa+oB+Cf9drfrxlX09yBQbJPIVKZ5/aRbtYv5hGhEY?=
 =?us-ascii?Q?rZR+oHJx/ESyd8LBHTP+1zgonGIuaHBABYbhwPBXnP4T2xffKFef6W9xAxkq?=
 =?us-ascii?Q?f+X8Pa40tS5skZuxolgqZ6Zegz1cBKcTraSOy5eIHCOxqNLXwV4LnW+PE5Zt?=
 =?us-ascii?Q?2b0tDf4dPC6Z8udmEyMj196LLaVLrLM8qbdwZ4JQ4eXmYvM54Z/FdSE7Me7h?=
 =?us-ascii?Q?gV5bDsdRmBvNoUAzrJovxDmHvg5OdmmD54EmLq2mhWJkjeKjuDlLij7CcESZ?=
 =?us-ascii?Q?hrd+9Ol54Zvx50ziokTPWC3UatC3Exe/GwS5xXbhg/AdfecL4paJqEwhUgZM?=
 =?us-ascii?Q?Ghw/urPvcNQxLZZca0FH7e/A7bkRG7pHdsHvmB2y01OLF2HSa+fSSXzItMjg?=
 =?us-ascii?Q?GtLOgSMG1jccAD4h4fdlmFRoJYBOr87A88uK6c2abDoeRfKNPSuokyGle/zW?=
 =?us-ascii?Q?vT6U8JY1LyeOwH8VIYdrnDFk+zQiL271i0r19diLyikhR98sSSDg4KbieYRn?=
 =?us-ascii?Q?LOzLgHNIyzxQ0pUrvKgMhxZ5tbCN1OCl7/Y527sqDjX3TYwfK5Q9mNfpggZ6?=
 =?us-ascii?Q?tQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbaebd65-ccb1-4c12-b6e5-08dac429ae34
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 21:14:12.3146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q3d2tYBZaws8c495Pr+L0vgpuNrd2lSkAvPzCgrz+o5IiNS31162CoTvy3s2CPDlCpbiYcqXWR7eZZXyKFAcuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7624
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>

Make the driver be able to bit-bang a GPIO for the Chip Select pin of
select peripherals.

The GPIO value is driven by the driver in that case, and none of the
hardware Chip Select bits will be populated in the PUSHR register for
the TX commands constructed for this peripheral.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/spi/spi-fsl-dspi.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index a33e547b7d39..e419642eb10e 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -900,12 +900,31 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static void dspi_assert_cs(struct spi_device *spi, bool *cs)
+{
+	if (!spi->cs_gpiod || *cs)
+		return;
+
+	gpiod_set_value_cansleep(spi->cs_gpiod, true);
+	*cs = true;
+}
+
+static void dspi_deassert_cs(struct spi_device *spi, bool *cs)
+{
+	if (!spi->cs_gpiod || !*cs)
+		return;
+
+	gpiod_set_value_cansleep(spi->cs_gpiod, false);
+	*cs = false;
+}
+
 static int dspi_transfer_one_message(struct spi_controller *ctlr,
 				     struct spi_message *message)
 {
 	struct fsl_dspi *dspi = spi_controller_get_devdata(ctlr);
 	struct spi_device *spi = message->spi;
 	struct spi_transfer *transfer;
+	bool cs = false;
 	int status = 0;
 
 	message->actual_length = 0;
@@ -914,9 +933,14 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 		dspi->cur_transfer = transfer;
 		dspi->cur_msg = message;
 		dspi->cur_chip = spi_get_ctldata(spi);
+
+		dspi_assert_cs(spi, &cs);
+
 		/* Prepare command word for CMD FIFO */
-		dspi->tx_cmd = SPI_PUSHR_CMD_CTAS(0) |
-			       SPI_PUSHR_CMD_PCS(spi->chip_select);
+		dspi->tx_cmd = SPI_PUSHR_CMD_CTAS(0);
+		if (!spi->cs_gpiod)
+			dspi->tx_cmd |= SPI_PUSHR_CMD_PCS(spi->chip_select);
+
 		if (list_is_last(&dspi->cur_transfer->transfer_list,
 				 &dspi->cur_msg->transfers)) {
 			/* Leave PCS activated after last transfer when
@@ -964,6 +988,9 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 			break;
 
 		spi_transfer_delay_exec(transfer);
+
+		if (!(dspi->tx_cmd & SPI_PUSHR_CMD_CONT))
+			dspi_deassert_cs(spi, &cs);
 	}
 
 	message->status = status;
@@ -981,6 +1008,7 @@ static int dspi_setup(struct spi_device *spi)
 	unsigned char pasc = 0, asc = 0;
 	struct chip_data *chip;
 	unsigned long clkrate;
+	bool cs = true;
 
 	/* Only alloc on first setup */
 	chip = spi_get_ctldata(spi);
@@ -1030,6 +1058,9 @@ static int dspi_setup(struct spi_device *spi)
 			chip->ctar_val |= SPI_CTAR_LSBFE;
 	}
 
+	gpiod_direction_output(spi->cs_gpiod, false);
+	dspi_deassert_cs(spi, &cs);
+
 	spi_set_ctldata(spi, chip);
 
 	return 0;
@@ -1248,6 +1279,7 @@ static int dspi_probe(struct platform_device *pdev)
 	ctlr->cleanup = dspi_cleanup;
 	ctlr->slave_abort = dspi_slave_abort;
 	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST;
+	ctlr->use_gpio_descriptors = true;
 
 	pdata = dev_get_platdata(&pdev->dev);
 	if (pdata) {
-- 
2.34.1

