Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9F7708557
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 17:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjERPuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 11:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjERPuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 11:50:16 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2064.outbound.protection.outlook.com [40.107.105.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1415D135;
        Thu, 18 May 2023 08:50:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/75X+NP4ptFIIn+2A7a4WNa3m27agi1RZetG8rRdzO/SLfArm4HFlKTfNEazdMmZYUqhKCDyzJU27AKojmo8OoNc30lYRoc8k+yzxOTmg8AD30lTxBFOdX154148ELfNkg8xXiU6SVOWc7x6EUFbWDJ3j6qP/ChrVWS1DIWg8059LUx2wFcoHU8+6wyGDxmDGqO+5cf1Q115OoJQaOSZpP1aNqKXD/WNugbChsmlIx5Smflx91hPs21muWjnZaHhaz1aCipIJwGFB6fNF7/xJFU2hFycZvmBIIU185sJI8sQS5baR1yY+idPB62nCunsuP1pfIvqAg50bQDfFSIAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJyp9Ja7HPzsCqIP61WJPdlAkJWV/0UIWOrzgn7jlB0=;
 b=cbuZXHrQa4MOG2q3mojCfqsqk46qbtjN7o7yTXzVJe/Yt+c+znBbHxBU0TCF6bZzYDbtu5D2KNCylOZ1iuzx2s1lLID7zFJbvsOE/L2m/xWax8bOotNZz/QagVMesUNSR2B23tcC7xFBujpMyGTep01vvqBh11iIYnQ7TMuo2OxXYLdFMj6nuVY5C5qb+JTizFgn2qlrEyfSGWnvSvlhhYuUa1beeqSUmYNQCjm+hR5ECyaIxLXwpZOshnSMWp6f9TjRn7tg3F+eSH3VsQKobtbVx5HV0d4JTtJ0UpVMcWpFCqLWM3SdU2ETJXzj34DuvzPpudUiDdKpwPKNDyPfHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJyp9Ja7HPzsCqIP61WJPdlAkJWV/0UIWOrzgn7jlB0=;
 b=U5RbwPq2nz1bE3XVDn/eENt22b/jVZFt4Acm3O2oxW2wbOYgJ9+tqlVsTJQO0z90HOjjsoGuoQl6vDPDHBJHEdJpVaws1c1fBGdXP/Hf9XEBjMMZrHxcCDO7kd7CXPqL6FQND0G3ATRo5tEQocibaWdqh0rRZUToeE5N8XWp5OY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB7672.eurprd04.prod.outlook.com (2603:10a6:20b:23e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 15:50:10 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884%4]) with mapi id 15.20.6387.033; Thu, 18 May 2023
 15:50:10 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        linux-usb@vger.kernel.org (open list:CADENCE USB3 DRD IP DRIVER),
        linux-kernel@vger.kernel.org (open list)
Cc:     imx@lists.linux.dev
Subject: [PATCH 1/1] usb: cdns3: fix NCM gadget RX speed 20x slow than expection at iMX8QM
Date:   Thu, 18 May 2023 11:49:45 -0400
Message-Id: <20230518154946.3666662-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0113.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::28) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB7672:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dbeb117-621b-43bf-535a-08db57b78f42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NkamWxDuezq0VrMzmyhCWmXasxAepQtUcd30tBFmFdB6kQTOXleEsDbcsD56Nw6a72EtdPcLggmi1LYY8N6ymbMtFiQwDy0/z2HLVy98eFVl6hF5HoUZ7TyM2ade0SmYvpR0fvME5CfyTv8IPpCFkrf/Ndfd8gUrTYKLps8vyOMiL0b7JqZHQ2oUzFuvO3AEhqWJ6TCI3fRwq8ZgBAJw1w9Kfev9CA6IHO6WHBvYwH/MbYg8s8qRqdKJJThzVk4NoB81pCy1Pxyixzb/D7VBuDxRopJwCLDgpdqqILe4ulAS+mHXZAOMvRf8y3CZV1+FXRE+pl3azPBZ6hvG8kvZBZZETkyvikGQi6Gt2nmIu+CvPxJaJFgeYzXSnXmo2hfkaVvah0Bk9T9gXjPesbofSzUy1TPWZsGXOd8qKmqxGGxtDIzS7nOkbAccLKUtZvRWBNU0nnHaKuZAEdfSqJDYLm78gNvpxYMw9P3eBEnBrzXXoZJpz8Ek2bq1sxNMu+11OT8Pm6MhyBvyL/XwLxE5hpIlCERnII7NnOviCr1R9AjbqRoFHGQn0GRRvih7+BULHXrk2Qq96I/j2tp44XPpDK7tHCRz0fvS+qFbhrjXfW1cq9J85SZc5n/t7BbcHw7zOrrzVSdomwfXZpxKT4as3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(451199021)(110136005)(41300700001)(6666004)(316002)(66556008)(66476007)(66946007)(52116002)(4326008)(6486002)(8676002)(8936002)(478600001)(5660300002)(86362001)(26005)(6506007)(6512007)(1076003)(186003)(2906002)(38350700002)(38100700002)(83380400001)(36756003)(2616005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/Xb7qgC7OfQ5tE6KCQeLBoGDaO2SiFe4yUMIIRVwA5WZX867Ogjc7OR6ZPEe?=
 =?us-ascii?Q?TMOctYmFM+Rxb3hNNcMgCVASB2pD1Afoiompn6j00n3Qb2vSKqtVwk1HSdj0?=
 =?us-ascii?Q?3zu+Xb7ZBAhgB7/kwSbsIrNwRBPbT4ROPexwbv4oPrI2GDmYX6GUyW0zBC2w?=
 =?us-ascii?Q?gdIqJFE//LAD/ObheqVsOdpmB5G0e0fzR60qVhGBRbP4+cTiUkgJ1HZz/yp+?=
 =?us-ascii?Q?jzVmku0+lrb0A7LSpvf3HKpB89KUbWARh/Dh3UPAuHXnUiScWzvKiah45Ea9?=
 =?us-ascii?Q?ZmS5uduY1IqtazmCo77QepGU6jA7QE3exwgkEJjvs0c43YaKz+/uG3H2uycl?=
 =?us-ascii?Q?Lvw2dzLPfgzKtkYvj9y83Pya2mZ/scjM7dLc+CWMCGNWV4N/6xKnbbocoxyz?=
 =?us-ascii?Q?B5/7JRWPpuO8H/ye8a/+Fkm+VNqhGNXfywlz2wzzf5GZ+V6RTRFrfUdonwui?=
 =?us-ascii?Q?3MP3ZPPtp9JXFRniDoYeLIuq79a17/bORB5z7NmtlPFAW64bLWr5RGpy7kbV?=
 =?us-ascii?Q?I7V01725qtyJKpEjksGNYDrJuK5ml6YU1ulcBGL66AUaAvjmykWpuKkFHpf7?=
 =?us-ascii?Q?FS2PsCnuQI0Bo02OSJc4poQ2aq1SOh84MBx1j3pramL1E+2nzmtDNQ6UdblS?=
 =?us-ascii?Q?MTAjBJqHdq7QtRTAT4xwFLR6xR/8YZ3InEGFX72m0rboh6oIqD9QngC36qQY?=
 =?us-ascii?Q?5t7uL8JXS6TrlXVjM3CS2dtF4aK2g6eSDdPoatDwOH839XeEQjY0pZtnrem7?=
 =?us-ascii?Q?l/nXXG9rOss6oUTQn6BF3Z8LkYv20aFcVIzGs4bgcqujzg2lpQu305ZhGadt?=
 =?us-ascii?Q?xP/gJPa1Ct8LG/Ks3APhOoWWONg6cplES1S9thNCNIYJbK9NXOx4YwlnnyC7?=
 =?us-ascii?Q?CEA561APB9z4xT+0yAxweHZpS0zC6L7pdRJ7PsrxjEG7z9bMgiJxy9WCgP3P?=
 =?us-ascii?Q?/ydJ6RbLejrpZcOPf+WyD0dHIr4URCXimtHdYAigzfgC5J8N43xUaP2rQfP6?=
 =?us-ascii?Q?Z+2aHcVTeEBjIR5/F/3bvpi8Ov8lEkCNbWcbI/sJQ4s3SPXEhY06XtX2aoE5?=
 =?us-ascii?Q?5N5XrAfwD/INasWQASIHrGyGuu19Z8SHV7kPcDbLHNcXkjViuIW4qIcyYiwr?=
 =?us-ascii?Q?D9RJv/3GS9S7FKj67nb2ep+gtrTVfAGl8wGj+QGsd+wOy3hdYg11zpeMG/JV?=
 =?us-ascii?Q?PUV4EedBC52iYrRNatApPMKaP+iLjwig7BWOjGD0+4bKtzX9bqc+cE1o1S1D?=
 =?us-ascii?Q?2QltcJ0ObEoi/WGW2W4HuHy8xoUfbT3kIII4kIQE+pnTGa8o4Y0Vy1/Znfbd?=
 =?us-ascii?Q?FPjNwHxFzj+K8Xwg95LvS85285iIoHfas1rMNsnY6HeF/MndpZkh/2890N8I?=
 =?us-ascii?Q?g4/YMn4cNyFvJzWLUF7RP/vU7uou6eRuzUvx+LEKJZh7qZ4mhPOv39tEAEUt?=
 =?us-ascii?Q?gQW/j8jGNF61VxCJJU31Suaie1IP1tBnftkGbOz22ToP6m36APHZQpms8A4R?=
 =?us-ascii?Q?CfuHh4TozJts/QM94a/1BnkTuz4Yh12JAIIGnMoPEJe1eavNO4xOKyJsvul8?=
 =?us-ascii?Q?p+9VLh9wlD1i4vDwUcpKg2Vy2bhBeK+Y6HGRNZJT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dbeb117-621b-43bf-535a-08db57b78f42
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 15:50:09.9647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iFM+LdLkUxJb+RCCAsKGpZ+UCo/snJ7qMUux5iO1Nahs7tc/YX7uVdP+LBW6svMk2U3esEEuWExRL6CTpXYGsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7672
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At iMX8QM platform, enable NCM gadget and run 'iperf3 -s'.
At host, run 'iperf3 -V -c fe80::6863:98ff:feef:3e0%enxc6e147509498'

[  5]   0.00-1.00   sec  1.55 MBytes  13.0 Mbits/sec   90   4.18 KBytes
[  5]   1.00-2.00   sec  1.44 MBytes  12.0 Mbits/sec   75   4.18 KBytes
[  5]   2.00-3.00   sec  1.48 MBytes  12.4 Mbits/sec   75   4.18 KBytes

Expected speed should be bigger than 300Mbits/sec.

The root cause of this performance drop was found to be data corruption
happening at 4K borders in some Ethernet packets, leading to TCP
checksum errors. This corruption occurs from the position
(4K - (address & 0x7F)) to 4K. The u_ether function's allocation of
skb_buff reserves 64B, meaning all RX addresses resemble 0xXXXX0040.

Force trb_burst_size to 16 can fix this problem.

Cc: stable@vger.kernel.org
Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/usb/cdns3/cdns3-gadget.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index ccfaebca6faa..1dcadef933e3 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -2097,6 +2097,19 @@ int cdns3_ep_config(struct cdns3_endpoint *priv_ep, bool enable)
 	else
 		priv_ep->trb_burst_size = 16;
 
+	/*
+	 * In versions preceding DEV_VER_V2, for example, iMX8QM, there exit the bugs
+	 * in the DMA. These bugs occur when the trb_burst_size exceeds 16 and the
+	 * address is not aligned to 128 Bytes (which is a product of the 64-bit AXI
+	 * and AXI maximum burst length of 16 or 0xF+1, dma_axi_ctrl0[3:0]). This
+	 * results in data corruption when it crosses the 4K border. The corruption
+	 * specifically occurs from the position (4K - (address & 0x7F)) to 4K.
+	 *
+	 * So force trb_burst_size to 16 at such platform.
+	 */
+	if (priv_dev->dev_ver < DEV_VER_V2)
+		priv_ep->trb_burst_size = 16;
+
 	mult = min_t(u8, mult, EP_CFG_MULT_MAX);
 	buffering = min_t(u8, buffering, EP_CFG_BUFFERING_MAX);
 	maxburst = min_t(u8, maxburst, EP_CFG_MAXBURST_MAX);
-- 
2.34.1

