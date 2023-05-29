Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8FB67151E1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 00:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjE2We1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 18:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjE2WeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 18:34:25 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2082.outbound.protection.outlook.com [40.107.241.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FAA9F;
        Mon, 29 May 2023 15:34:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=duIcogVctI+xstN3VvVt5CAYGtzbfRRZCqX7EoD9KQibrtxosl1drbvv8w90GIl9LbRQZFauh8c9tLqWh2fdFlIBeu5qrnv6jtvyTAv90QEipZTxFmgy8a+fdp0r1TEspZGTXrVb0H2bFGCD/pel4SiDsIUVESrVI9+PlcDraJY3FB5pDOvyF37FHt7ZO5SzIi+jA+cp2qTvMG9Qh8iRGN6BOeal3H+V5IzZTQFYM8abFgH+J3oJ7A4QRPYZk6Dmxh6Nqsrfx8NkaKEkFbmrMbBa3AllRJlImM2TYuSzTbS+txcLZ3us1uhf3hVIUWiLGhiyd5DAWX53vJLHOXa5IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQRoxtHHXhOUcOs3oxtW1ichj+Gt9HHxXjXfNIEUweo=;
 b=ek8GzNN+y5whWOaxLI+6PE+bk4sxBEPCnWCy5I6j3cWZ8uRS+eIb5mOPKzbnX9mGQjXLscmZH3rYyp0BJt2nG+MFwLbg3mWEGrEuytTNiKcQbpXPh3Qo6lOuPD3btW2B2mnH0KFxjtncrrDZgSGII2Wr2srvJtqwvTxFuboN5HJHd5i2RvVCNt5waLxe1SZ6/WCB+d08ZV3nWitS7QURLQ1Lr5XM6RnW93ojwswjT2b1LJaSlReQ3LZ3Vnp671BsZq72w3GJhrqeYXqUQrirxhRIfqAv3vus3Od0FiDaVhjw/2ulIfyIl73Th7THfaBrDIflZXJM2EQnoRKqt9mf4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQRoxtHHXhOUcOs3oxtW1ichj+Gt9HHxXjXfNIEUweo=;
 b=oqpHh3wef7Q98m6AuhXTeknx7DVsBA4XmMg4mtgjywFZOVvtOd5EalZya5n+CudKpuomwR/3Lo+QhtRSEiWTNZ/Q3JHHXAWzkEl2I6V/6KUf90iu9JJfggDK7A6ypzUbuuBzImByfTCRXQKGpBDvzQCnGRYfTEEUvpDZU7wwJG4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DBBPR04MB7802.eurprd04.prod.outlook.com (2603:10a6:10:1f0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 22:34:21 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::b027:17aa:e5f5:4fea]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::b027:17aa:e5f5:4fea%6]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 22:34:21 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     linux-spi@vger.kernel.org
Cc:     Vladimir Oltean <olteanv@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Lisa Chen <minjie.chen@geekplus.com>
Subject: [PATCH] spi: fsl-dspi: avoid SCK glitches with continuous transfers
Date:   Tue, 30 May 2023 01:34:02 +0300
Message-Id: <20230529223402.1199503-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0028.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::19) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DBBPR04MB7802:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ca219f3-6025-4b86-f576-08db6094d8c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gVa8gaZgnQgzrlAXWRYX+PiT7QW7aX0icCHx7OznQdu2IfIjbSNHeeDLklWoQrKAa0ZoqA0oiwxmYxpYbuyMNRfzNLQQ+m7Gx105+RQU+SA9iG2ssdU7xYjbWjrqiJcuri4/AC2aFpe+PuhWYaZsrFZmlXk3wADu3yHNXCy+mRsU2yDeXwRBTWtsyxn/0/5Rid9M6v0WrO5gV1i3bSoiygqnVgPnLjD5vF7LeDmbVRCfhrzjrxDjy6q1d8WQe5ArMxBBkdEFVbzCcJEPRZhUcOTo3D6hdJMn69tasrAgtmz/rCJMYxoNIaHe+lYY+1odSA/hrAAs8esgZ9u6mqiejJoo2xxC65t3z/4eBVLC+tDUzMDz8JRc66dtjrhk174GprzYMCAGFhuKgmiLaNTOMtGOHu80cg3lvFBXqhcQVwS6Dhy7urh13zdwwrAy24ccAUMUpJLycdmJH4KKYEJjxk4JvWLQU0BJu7/9Rnu+2DgJpCmv49OM/kL7yKFpqYB9tUSbgxem8BTwZLNGbOPpuSXQGVKVAqCRq2du/sEiWk7jRya3EryeE5bVw0edSv/iPvt98jjJXIUQFWvBAgyRCcG6dTmjuMgmTJusszt5UzB8P0ZyYfeIuklVh9ZmgCvl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(366004)(376002)(451199021)(66946007)(4326008)(6916009)(36756003)(66476007)(66556008)(83380400001)(5660300002)(44832011)(52116002)(86362001)(38350700002)(41300700001)(38100700002)(186003)(2616005)(8936002)(8676002)(2906002)(6486002)(6666004)(6512007)(6506007)(316002)(26005)(1076003)(478600001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTlHckVXd05kUm80S0pLSHArcTRGb2c0QVRWSEhHUSt1N2hyR2FkcE1taDJL?=
 =?utf-8?B?SUsxRHh5NWM5UVJxTUM2SlJaSFgxMG9NSkxBL085amVFV1NZbTNGRzNxYllz?=
 =?utf-8?B?OTd2N0x5cWVIbmkxK1orclYxZjNtaCtWam4xZUR4WWJUWnMwdkZWMXZob2NO?=
 =?utf-8?B?ckE4eU5DRkNCVjAzMldvaWduQUxseFRsL3ZsWmMyN1didDBSanhXQnZNRXdC?=
 =?utf-8?B?VE5XK0J5NmZFZ0JLcWJkNTh2b0dTVHhMK1AvWTEzbnJocTZGcUM5WnhjNmlW?=
 =?utf-8?B?cUNRdmZNT2RRZ1FxQmhLTFc3K281MXNIK0o2Yyt6Z3VrbnVTdVZUcUNKaWxI?=
 =?utf-8?B?ZDFqZmh3L3BOUTdRcmNOM1pWc1lGR3FsVURxVWUwT01zSlU5ckJvdW9aU2xK?=
 =?utf-8?B?MUFFTFMyQ2tjYWtaOWhMc0F1QlFlM0RUTTNmaVltZlFLeEZKUHlHRW42S244?=
 =?utf-8?B?eVRtYzVnU3AyNXdWdUNJdXhzbFEwYlVZZEc1Q09VYXNOMXE5N3FaelJxQVVL?=
 =?utf-8?B?TmMvUkZha3ZuVmMzbnRVUlkxVUVjMnIzMGptc0RjemExc2plR2EwZDBkMEFB?=
 =?utf-8?B?dGxoY2FMWjZCbVRlanN6eUhVZnBJWndrRDAxOFdtd0E0NHlHSWRXcFNIVEg1?=
 =?utf-8?B?N1BvY1BMMHFWRGtwRzUzcERCZ0N6dFErRnIySzNYbHh5dHg0UkxpaFFWWHNR?=
 =?utf-8?B?UzdZMmpnR3FpR2JjSGJ3eHVhbzVEMVJtdElFeDB2eXo2Rk1UdHJaR2hFUmsv?=
 =?utf-8?B?SHpOZk5BUGhlcjBjeW9ML2t2aGp5WWpOVm9XSzNybk5WSnk5WTExV3V6SEtz?=
 =?utf-8?B?bnhoL3ZzRXAzV3dnR2VsNE13TFFQbWNuZC9DWGpnYnN3VkV1bTBYbUhPd25I?=
 =?utf-8?B?NytLN0JiY3BnOTlMb1FCL0NtNWxveE5jdFdhakJ6R2xsSENFOU1OY2JQMlAw?=
 =?utf-8?B?RnlWdXNBZmR6UktCMDh4OC9vTWI4NjZ3UG95emlqd2swS3RwRk9JVlF3NE0w?=
 =?utf-8?B?KzJjdXg2ajh6enBHeEEwUG1PSjE5aElmRlUxaXhkR2I3dUx2emNpSWJZa1I0?=
 =?utf-8?B?a0k4TjlLTnZDUytuREVIUEF6L24vSFJ1MkVHL1A3bEVKeUZ2UTFFdnlUaFlV?=
 =?utf-8?B?U2FmMlcxd3BKWFdDdElaLzFubkdhUFlZZUNkQ2lhYzNodE9DOVFHZm5BVkRm?=
 =?utf-8?B?dGMzVGN4ME1CREFzRlJ5R0ZHTlNudWJiVG1lMWNMNmdnVnBqWHJkNk9XKzF6?=
 =?utf-8?B?ZjJMK01GNjRMT2pkKzJnODhhSDhQaHFVWUQ0dkFibnVROVR6OFpWUW9FUEFD?=
 =?utf-8?B?VkVwZUJIdEU3Um0xemZqeWpkRytyeDJNbkVuQmR3NHBhRGh0YVo5OHU4WVBm?=
 =?utf-8?B?K051enlUb2crNzhZOVo3Z3V4VXY5bjVSaS8rdmxGS0hWZXV3RHBjb1FadWto?=
 =?utf-8?B?YmlySUo1ekRXSkJGRnFlV3JaKzRscGdXNVZ5eXJLd1RUa0hOZVVhZDZXSVll?=
 =?utf-8?B?dXNKLytsNmROMkFjcm9TNXhwZy9mdHk2OUh0WW53UzNmTWs2Zm1DNW5GanhM?=
 =?utf-8?B?cnIxSThVWFdmeHV1ZzRYZlJwRy91WEpaalFzcjJ3b0Vaenk3ejZlKzVNdGpL?=
 =?utf-8?B?WTBScHlxcFR5Qkl1MnBvSVViRjhrY3BRS1ExMVI2VVJkL0F3d2pKT21EMEgw?=
 =?utf-8?B?M2J4MXZIL1FyTHkyMG9KK3hDc1ZwSEVhNHJhM3M1Z3pVdDFWNzdYM3hwZXlF?=
 =?utf-8?B?SUs1ZlQ3L2JLOXBlUG41WjRBam1TSnpma09rbEdFQnZLOEtaMlgrNFFBM1dY?=
 =?utf-8?B?ejNwejB3TW9qU1JwM1BrRW9WcFRmc216WndWNXZBV1ZxLy9NTU5JVzhFZyto?=
 =?utf-8?B?amZVb1dlS1o3ZGlSK1haMjQyS3kvbkJ5MGkrRDZLWm9aMUt2cTNSendNUit1?=
 =?utf-8?B?TW40dUd3SitwakhSUEVYakU4cC9GZ0NEM2w1Z2VoYzExVGQ4QXZrKzJqZlBm?=
 =?utf-8?B?M204UFhpckt3Y0g2WFJhMlB4NnhUY2pBdDNwakF5aTJoL1lmendadDdXL01S?=
 =?utf-8?B?c0dRbHNIQ252dXQ5SXc0YmtxalNiNEYvbmV5N0ZuT0tKU04rQWJkcTVUOGJF?=
 =?utf-8?B?NHBMN1FobzFxUGhmSm1KUi9uaFBhd1huZ0JUZngvTHdlZXNkVjNpTnJmWGli?=
 =?utf-8?B?Ymc9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca219f3-6025-4b86-f576-08db6094d8c2
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 22:34:21.3431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Lx+eb0S3PemfRc2LGILX+3mCS2qYes0fvaFBZ47IJ6s8Y2CqNHIrMbtZhgSYzyldE426lIo8EasrBgpry8KUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7802
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DSPI controller has configurable timing for

(a) tCSC: the interval between the assertion of the chip select and the
    first clock edge

(b) tASC: the interval between the last clock edge and the deassertion
    of the chip select

What is a bit surprising, but is documented in the figure "Example of
continuous transfer (CPHA=1, CONT=1)" in the datasheet, is that when the
chip select stays asserted between multiple TX FIFO writes, the tCSC and
tASC times still apply. With CONT=1, chip select remains asserted, but
SCK takes a break and goes to the idle state for tASC + tCSC ns.

In other words, the default values (of 0 and 0 ns) result in SCK
glitches where the SCK transition to the idle state, as well as the SCK
transition from the idle state, will have no delay in between, and it
may appear that a SCK cycle has simply gone missing. The resulting
timing violation might cause data corruption in many peripherals, as
their chip select is asserted.

The driver has device tree bindings for tCSC ("fsl,spi-cs-sck-delay")
and tASC ("fsl,spi-sck-cs-delay"), but these are only specified to apply
when the chip select toggles in the first place, and this timing
characteristic depends on each peripheral. Many peripherals do not have
explicit timing requirements, so many device trees do not have these
properties present at all.

Nonetheless, the lack of SCK glitches is a common sense requirement, and
since the SCK stays in the idle state during transfers for tCSC+tASC ns,
and that in itself should look like half a cycle, then let's ensure that
tCSC and tASC are at least a quarter of a SCK period, such that their
sum is at least half of one.

Fixes: 95bf15f38641 ("spi: fsl-dspi: Add ~50ns delay between cs and sck")
Reported-by: Lisa Chen (陈敏捷) <minjie.chen@geekplus.com>
Debugged-by: Lisa Chen (陈敏捷) <minjie.chen@geekplus.com>
Tested-by: Lisa Chen (陈敏捷) <minjie.chen@geekplus.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/spi/spi-fsl-dspi.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 4339485d202c..674cfe05f411 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1002,7 +1002,9 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 static int dspi_setup(struct spi_device *spi)
 {
 	struct fsl_dspi *dspi = spi_controller_get_devdata(spi->controller);
+	u32 period_ns = DIV_ROUND_UP(NSEC_PER_SEC, spi->max_speed_hz);
 	unsigned char br = 0, pbr = 0, pcssck = 0, cssck = 0;
+	u32 quarter_period_ns = DIV_ROUND_UP(period_ns, 4);
 	u32 cs_sck_delay = 0, sck_cs_delay = 0;
 	struct fsl_dspi_platform_data *pdata;
 	unsigned char pasc = 0, asc = 0;
@@ -1031,6 +1033,19 @@ static int dspi_setup(struct spi_device *spi)
 		sck_cs_delay = pdata->sck_cs_delay;
 	}
 
+	/* Since tCSC and tASC apply to continuous transfers too, avoid SCK
+	 * glitches of half a cycle by never allowing tCSC + tASC to go below
+	 * half a SCK period.
+	 */
+	if (cs_sck_delay < quarter_period_ns)
+		cs_sck_delay = quarter_period_ns;
+	if (sck_cs_delay < quarter_period_ns)
+		sck_cs_delay = quarter_period_ns;
+
+	dev_dbg(&spi->dev,
+		"DSPI controller timing params: CS-to-SCK delay %u ns, SCK-to-CS delay %u ns\n",
+		cs_sck_delay, sck_cs_delay);
+
 	clkrate = clk_get_rate(dspi->clk);
 	hz_to_spi_baud(&pbr, &br, spi->max_speed_hz, clkrate);
 
-- 
2.34.1

