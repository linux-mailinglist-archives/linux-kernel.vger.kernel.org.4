Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0679702C40
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 14:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241422AbjEOMFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 08:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242000AbjEOMFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 08:05:15 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BCC197;
        Mon, 15 May 2023 05:04:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ofbUw4g/OwWkMxt3tc2FTz+Xcoy5u5XxDlNTcv24PP8jq/Adr528OY/GcXjVka5Rh4tZqDRa93Rq4+aEIFHP+rinwqeZq9OGTZ5/w7ecReQWjVcpbjKnQVaaZD0t6y671ip1WkipH0ehWbptqWKg6wDUD/bNb1/VinBCJBUtauRZLOw+DwbKnstDqezpdT7JNmKNbwXxpwJ2z+9i7mtukkhBEeiqrxpPKsiwuO3zGRWksRZ1lyk2QEaUSNNKXiRL+5Yny6NWOj7THWp5CiXOLz4FNVh/BLMJv0uWThmko2Ra5CWGgno38o02SVI/nIVUDM4H2q+Qg8SvxCM0bqNYRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PxF79hZChhBztjfMOfk9lnisvKWE+0WbW5vWzNZeovI=;
 b=Cl/fa7LkrXv5iPl0IPkbpZFca3021zFTBeJMoN73Zk+2mJ9Eg20KJiw6v3iivNa61tmdPao17E/gmHjFwGyfN94F8H1AqpIk8A7OjR0/36vXOmjJgFvkugAaLPW552AxrSg63DPAq6OszGsFiya9Tz/9OpiCPG24dfLD+ueRGB3PQlAn4gbqxt0vX7L93LgNFcJZUiP5R/2Y8J2vmPuEzyzVO8nCX11tPeD3j3zB+xHIpqLl469Ae0nb5E6DwGoK4nLjhPFxLhlkJjq8WlujRtC7D4F1oqMQYsnQavhJPLKFDpiLRtAWLlN6XWUbz4Kn8FSrd5wLviop0MdWGpHYyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxF79hZChhBztjfMOfk9lnisvKWE+0WbW5vWzNZeovI=;
 b=dsmaJyQDOt1bKxvK9d+EzsJcyocac7ph9ZbaQdTLkAocit+4sBIaoAjM4yUlSXGvneTc9K6BN2Gg+cecI8dPgnsC2sC+HC07NvrRxsAObNekeF0aZmB7p47Af1JCbjdzjuiyLlq8DghttlxGJrbej1rIQy6dxp0KcrrS+Jas+68=
Received: from PH8PR12MB6675.namprd12.prod.outlook.com (2603:10b6:510:1c2::15)
 by SN7PR12MB7369.namprd12.prod.outlook.com (2603:10b6:806:298::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 12:04:38 +0000
Received: from PH8PR12MB6675.namprd12.prod.outlook.com
 ([fe80::a9cc:895f:cc74:30b7]) by PH8PR12MB6675.namprd12.prod.outlook.com
 ([fe80::a9cc:895f:cc74:30b7%4]) with mapi id 15.20.6387.029; Mon, 15 May 2023
 12:04:38 +0000
From:   "Goud, Srinivas" <srinivas.goud@amd.com>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>
Subject: RE: [PATCH 1/2] spi: spi-cadence: Avoid read of RX FIFO before its
 ready
Thread-Topic: [PATCH 1/2] spi: spi-cadence: Avoid read of RX FIFO before its
 ready
Thread-Index: AQHZgpUsoHY1RY/m3UymshDymAXTqq9bRGXA
Date:   Mon, 15 May 2023 12:04:38 +0000
Message-ID: <PH8PR12MB6675F6CC30254C5EED898FD5E1789@PH8PR12MB6675.namprd12.prod.outlook.com>
References: <20230509164153.3907694-1-ckeepax@opensource.cirrus.com>
In-Reply-To: <20230509164153.3907694-1-ckeepax@opensource.cirrus.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB6675:EE_|SN7PR12MB7369:EE_
x-ms-office365-filtering-correlation-id: b5a25430-d4be-4fed-ede1-08db553c8ed4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jkfmB8hf+8qX1ChEJfSKxqDbWuGCC7pZPguDcFlowE3dQ+Ol6ZT7KsMHz2hrqb3FpWEKMzW3s5Aki/H6LlA7RvhwXf0Y3MZUxVYwAo4A67hx5mKl0vByHDDVpMhWlrLyFoEQQabyuQLrkjb2CjoEPZtwMZ0S/+pM5wSg+1vLZ47KCmskpSZ4CT7h+QbWxrQk1Rx82pxHtEb2qmFcgBqYvNol50IX0y7VcO630aGHdJDf77AvWkZcxDUgy7hSbb/m50zf2UL9H3c5dokRgAANLdp5FSmVL7ljha4+0ja3Uu2OxR/Uv+Of2MgdOW9IAhfnL3HwcdrNAGvQddVHl2JqDTVUXDLhZNNU9BQzIYipp8MTGT8VKfqCMoI+QRmrgaDAFkc+7Cn7uwwBT8T73SPsbLSvIutdZHFi+46ZA38jhn5bLa1ae2ArrZ6zU32ZL+gX/1TwUhofFUmYuWd0o06z0/yPMo0nlEIsnNCw+laTsq5BpEkMIQkKkn/Khgv3tXtukpDc6yy6ISsfQAYTX8HtGZHV+Hf8oP09nFKwHplBGxkZnuavqZInLgMd1DU+EQU5dDJU317vsZLk56+AOLM0ea40MoU08OlbqvTJqrffsWVLk2gQOg7CRweniZKKbN4t
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6675.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(366004)(136003)(346002)(396003)(451199021)(7696005)(71200400001)(8676002)(8936002)(41300700001)(83380400001)(478600001)(110136005)(54906003)(38100700002)(186003)(76116006)(2906002)(26005)(66946007)(6506007)(38070700005)(9686003)(66556008)(66446008)(66476007)(86362001)(122000001)(33656002)(316002)(55016003)(64756008)(4326008)(5660300002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BtVS6iGk/Yh8CYTd62VgQRjvC/XXbI+lIcZPddeIzx3nZ5NbCQadUE+GDwlV?=
 =?us-ascii?Q?Gx4WgeMOa/GHFYmxyJWnNoQ1was3R4AhjsmLGAK8+MYX7B+2mLLuFDU+fg4d?=
 =?us-ascii?Q?EkfL2TjEDsruz26FboEt8K464j9T7F4JoEvPPYCwfZ3hhsleyHWrYMLn8NvD?=
 =?us-ascii?Q?BXlYlnPI/CeNrndMQElmYsK1Iax68RcUKPwePGEh9a+TH/SqSuF0W1grPShI?=
 =?us-ascii?Q?ng1Qq3Psws3DvnNPgEsgldLxEpkTd/11Gjix2BZRmv0G4Sxr23oUj6IX9GsH?=
 =?us-ascii?Q?yRtHpfFoYxcJljVLlzQPed3rM7xtE6mgtItkvxskAXKqGVjoCKUxRkJ7B1o6?=
 =?us-ascii?Q?cKmK1WYpH6okeKuyZ2e0OP0bXNiu1A+HfnAIQtcoO1+0/zkw0UTrQeCv5srP?=
 =?us-ascii?Q?mjd6RGZX32AaEx+pnjiVBrtFZoHfIfLkCQcP5Y5ab56S2OVHSspZ2S5EalBa?=
 =?us-ascii?Q?LMVnJhZdu+zKOSG27xh0i2vVVr1FVYxLZw2QO7EwwEFJtSrbOgFpGtiKvd1V?=
 =?us-ascii?Q?PcDoIgRH2J5NqsMcxfrC6i3jeeQTYPXvDQwofYYlHjtJF9D6WdevGbSOUzir?=
 =?us-ascii?Q?Ytk7C69fVdF8yYrRIHK2BW2wmXOU1FzTYh3gkMAxQ71aXDqX1UzVeH+vzFGQ?=
 =?us-ascii?Q?DwG+QYZF+PkW62MT2gm0Q1YiYjg399PQXBBoagTIQBDqHQbgWshkoonbnCOa?=
 =?us-ascii?Q?B8nPq8w51zFU5h5Hk47wquIY8Xejmec4hgvg6PSCSvRoBJNToyZBUQWxqztW?=
 =?us-ascii?Q?9B237d5i239kPaZC8CsdaADqNZI1kQJBXYeRym0FhvdD0BOQJXiySRcbFiRs?=
 =?us-ascii?Q?c6qRfNh9DO56N9daHkkOBTLCGg7OyCzvF/mZGJyzYX6EiDoiGnUettOD/wFs?=
 =?us-ascii?Q?hipOzWtCnAowlG9xQiwaly5fy7V/VN3xgfCXlGV5S8q7i++cVw4HZs01GUTG?=
 =?us-ascii?Q?Hk/KzLemlS3355wXzJ9Yjoa/jQUJa6QGgReuUCzkkQXi/rX/WYUo0qF5xeKb?=
 =?us-ascii?Q?W8Ep/9EYAyLl1Z8Ar5nMNi44Po5GcLnU5pIVI+94E/+jl8loW+nh2uGr6Tyo?=
 =?us-ascii?Q?WGfIhDUQ7DauBRmV7ZgvmVedvAjwghwCzYQRrM1ipljhpULebruzkQEdy+zG?=
 =?us-ascii?Q?lcVhuEIPSWuBtZT3WbL7PZwJSxN42h4oO7FbGmonL+Df34VMYdVUOKn4z0s5?=
 =?us-ascii?Q?fKcJkiGajz3QAUP7oQLOKZrB5Q3foX8IvgEBMJekozaxsJez0rey+FlBq3FX?=
 =?us-ascii?Q?aDof7SkJRkqWz6rgLaKUA5M8wapvzCmcsVHZ7DTakB2uQBkYEkY7VzjwWY5w?=
 =?us-ascii?Q?va2ls5MjnmLk9sBxIJJT9E2JmIk4Q/KGDXg6JW2yNR5yK+wA2emcTmltG6V9?=
 =?us-ascii?Q?iuhE4gWS+okKBn3mYxhqop5S87I3NfsFRSGHjGaaycq1Vlj5Mh5y1GiBN8JD?=
 =?us-ascii?Q?eNj3YZ34kXlt0uYAIkQSIf1XHtnl27mtEq30Bqp0lK7bH1wgx2//alC71voy?=
 =?us-ascii?Q?+E6udeTYEu9QFctfZ4kYI+2HgEVDC3iCQHfiKoVgJwaP+2Yxyhu+yE6Q7aYV?=
 =?us-ascii?Q?TC/JvWfHEnhDTSvayUU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6675.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5a25430-d4be-4fed-ede1-08db553c8ed4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 12:04:38.5419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jq5Lse04CfFYbu/xQqZ/oHp2ne1v+uKzUi0+HN88gdbBzu2ndQoRrAmd6iOBMDmM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7369
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>-----Original Message-----
>From: Charles Keepax <ckeepax@opensource.cirrus.com>
>Sent: Tuesday, May 9, 2023 10:12 PM
>To: broonie@kernel.org
>Cc: Goud, Srinivas <srinivas.goud@amd.com>; linux-spi@vger.kernel.org;
>linux-kernel@vger.kernel.org; patches@opensource.cirrus.com
>Subject: [PATCH 1/2] spi: spi-cadence: Avoid read of RX FIFO before its re=
ady
>
>Recent changes to cdns_spi_irq introduced some issues.
>
>Firstly, when writing the end of a longer transaction, the code in cdns_sp=
i_irq
>will write data into the TX FIFO, then immediately fall into the if (!xspi=
-
>>tx_bytes) path and attempt to read data from the RX FIFO. However this
>required waiting for the TX FIFO to empty before the RX data was ready.
>
>Secondly, the variable trans_cnt is now rather inaccurately named since in
>cases, where the watermark is set to 1, trans_cnt will be
>1 but the count of bytes transferred would be much longer.
>
>Finally, when setting up the transaction we set the watermark to 50% of th=
e
>FIFO if the transaction is great than 50% of the FIFO. However, there is n=
o need
>to split a tranaction that is smaller than the whole FIFO, so anything up =
to the
>FIFO size can be done in a single transaction.
>
>Tidy up the code a little, to avoid repeatedly calling cdns_spi_read_rx_fi=
fo with
>a count of 1, and correct the three issues noted above.
>
>Fixes: b1b90514eaa3 ("spi: spi-cadence: Add support for Slave mode")
>Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
>---
> drivers/spi/spi-cadence.c | 42 ++++++++++++++-------------------------
> 1 file changed, 15 insertions(+), 27 deletions(-)
>
>diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c index
>ac85d55622127..b0ccb138e3566 100644
>--- a/drivers/spi/spi-cadence.c
>+++ b/drivers/spi/spi-cadence.c
>@@ -304,13 +304,11 @@ static int cdns_spi_setup_transfer(struct spi_device
>*spi,
>  * cdns_spi_fill_tx_fifo - Fills the TX FIFO with as many bytes as possib=
le
>  * @xspi:	Pointer to the cdns_spi structure
>  */
>-static void cdns_spi_fill_tx_fifo(struct cdns_spi *xspi)
>+static void cdns_spi_fill_tx_fifo(struct cdns_spi *xspi, unsigned int
>+avail)
> {
> 	unsigned long trans_cnt =3D 0;
>
>-	while ((trans_cnt < xspi->tx_fifo_depth) &&
>-	       (xspi->tx_bytes > 0)) {
>-
>+	while ((trans_cnt < avail) && (xspi->tx_bytes > 0)) {
> 		/* When xspi in busy condition, bytes may send failed,
> 		 * then spi control did't work thoroughly, add one byte delay
> 		 */
>@@ -381,33 +379,23 @@ static irqreturn_t cdns_spi_irq(int irq, void *dev_i=
d)
> 		spi_finalize_current_transfer(ctlr);
> 		status =3D IRQ_HANDLED;
> 	} else if (intr_status & CDNS_SPI_IXR_TXOW) {
>-		int trans_cnt =3D cdns_spi_read(xspi, CDNS_SPI_THLD);
>+		int threshold =3D cdns_spi_read(xspi, CDNS_SPI_THLD);
>+		int trans_cnt =3D xspi->rx_bytes - xspi->tx_bytes;
>+
>+		if (threshold > 1)
>+			trans_cnt -=3D threshold;
>+
> 		/* Set threshold to one if number of pending are
> 		 * less than half fifo
> 		 */
> 		if (xspi->tx_bytes < xspi->tx_fifo_depth >> 1)
> 			cdns_spi_write(xspi, CDNS_SPI_THLD, 1);
>
>-		while (trans_cnt) {
>-			cdns_spi_read_rx_fifo(xspi, 1);
>-
>-			if (xspi->tx_bytes) {
>-				if (xspi->txbuf)
>-					cdns_spi_write(xspi, CDNS_SPI_TXD,
>-						       *xspi->txbuf++);
>-				else
>-					cdns_spi_write(xspi, CDNS_SPI_TXD,
>0);
>-				xspi->tx_bytes--;
>-			}
>-			trans_cnt--;
>-		}
>-		if (!xspi->tx_bytes) {
>-			/* Fixed delay due to controller limitation with
>-			 * RX_NEMPTY incorrect status
>-			 * Xilinx AR:65885 contains more details
>-			 */
>-			udelay(10);
>-			cdns_spi_read_rx_fifo(xspi, xspi->rx_bytes);
>+		cdns_spi_read_rx_fifo(xspi, trans_cnt);
Cadence SPI configured in Slave mode,  when threshold is half of FIFO depth=
 cdns_spi_read_rx_fifo() function continuously in read mode,=20
due to this we see incorrect data received on the Master side as Slave is f=
ailed to update the TX FIFO on time.

>+
>+		if (xspi->tx_bytes) {
>+			cdns_spi_fill_tx_fifo(xspi, trans_cnt);
>+		} else {
> 			cdns_spi_write(xspi, CDNS_SPI_IDR,
> 				       CDNS_SPI_IXR_DEFAULT);
> 			spi_finalize_current_transfer(ctlr);
>@@ -456,10 +444,10 @@ static int cdns_transfer_one(struct spi_controller
>*ctlr,
> 	/* Set TX empty threshold to half of FIFO depth
> 	 * only if TX bytes are more than half FIFO depth.
> 	 */
>-	if (xspi->tx_bytes > (xspi->tx_fifo_depth >> 1))
>+	if (xspi->tx_bytes > xspi->tx_fifo_depth)
> 		cdns_spi_write(xspi, CDNS_SPI_THLD, xspi->tx_fifo_depth >>
>1);
>
>-	cdns_spi_fill_tx_fifo(xspi);
>+	cdns_spi_fill_tx_fifo(xspi, xspi->tx_fifo_depth);
> 	spi_transfer_delay_exec(transfer);
>
> 	cdns_spi_write(xspi, CDNS_SPI_IER, CDNS_SPI_IXR_DEFAULT);
>--
>2.30.2

Regards
Srinivas=20

