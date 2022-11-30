Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262C563D7D1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 15:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiK3OLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 09:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiK3OLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 09:11:17 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2067.outbound.protection.outlook.com [40.107.22.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CC49491C;
        Wed, 30 Nov 2022 06:09:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MEbLnfUBelk2YqDivhWCKDu1/Q9n6yhG6xHGke36HPM7CNZna0IU6hRYKnOmvcK4Cx+0fYR8URi9kDyRKukf/JwEXG4RCQzVo+9QPNle6FVW/RufJgLXil6aKOuNQY8vzdJw6Vqe9/jkY4dXNpghyieOPGYX3McCv8+3Dujp+SXeEA1m+QnKmzwA5MX7iTEmocXFiHGppcFPLtaiDBuUSQbk2MV7t7zhXSzEHphDShTlwMQV1+D8MRVaP27w8G8kdLqi3Bl+PGgq1tNxKO8sIzWqQrckmIO6ExVxkN4T7KnjQ79I2qlD3QlJPgHYOFuA7RX++ROUoTtq2qWb9b5dCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1BQFatqt9C13dZ0gqvdCcbJsegRprpF3FprMU0dqhQ=;
 b=ZcpZmXI491Ju59oZG1sKOih62DYccBDsXXyZE0h8TlVgR8lHcGESlnuuD9kZVTVjEs9HLWmgo6Fy/pNQfUwV3JM8XburJjxqHDsRxqOiMFNojKQ34wkWMulM2s62EoCfD/9nXu48T82tdIln2+mvAVJPAAL0V3n6TyJJ2bXlicXmQsXaQlv4u1IZ1UQ6Z/kwBXUuuwWdmLGoUb8PHyNSULJMwOh+3jcG74exnJx9Y0hjn2I5XHYXA6am2vG06JwD1lp6kWXX7JioxaSfdUQ6JzZ31VjUelh5LLrHN1KOiUn9ebStjbeTGneDOiwPfYEAqKmuc3krSS0IXupiik33kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1BQFatqt9C13dZ0gqvdCcbJsegRprpF3FprMU0dqhQ=;
 b=ltKCRzY5gnZJ8eaiLj3WF7z5dr2RHTM7Zt7heD+C4sT8czFgKWQabikeW/YRF9z3wQkMccBmseAtCaNUOeqDve/gHZxNB6kLQB2mAzhOD6wnzsU+Ov0S60Vu5hawfy3QOFtYLegIyHKyR5ncbhaF6RsH9ZYkD3+ziz3fv0LTdTw=
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by AS8PR04MB7861.eurprd04.prod.outlook.com (2603:10a6:20b:2a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.17; Wed, 30 Nov
 2022 14:09:01 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::203a:e5da:a4a:7663]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::203a:e5da:a4a:7663%12]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 14:09:00 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Bough Chen <haibo.chen@nxp.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "open list:NXP i.MX 8QXP ADC DRIVER" <linux-iio@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH 1/1] iio: imx8qxp-adc: fix irq flood when call
 imx8qxp_adc_read_raw()
Thread-Topic: [PATCH 1/1] iio: imx8qxp-adc: fix irq flood when call
 imx8qxp_adc_read_raw()
Thread-Index: AQHZBBITIcbXLdLL4k6c7baUCCsSgK5WG9cAgAEggQCAAEUfsA==
Date:   Wed, 30 Nov 2022 14:09:00 +0000
Message-ID: <HE1PR0401MB23316F98F160D737F07D7E4A88159@HE1PR0401MB2331.eurprd04.prod.outlook.com>
References: <20221129164531.2164660-1-Frank.Li@nxp.com>
 <20221129164531.2164660-2-Frank.Li@nxp.com>
 <DB7PR04MB401094B273FB9F851CE9A06190159@DB7PR04MB4010.eurprd04.prod.outlook.com>
In-Reply-To: <DB7PR04MB401094B273FB9F851CE9A06190159@DB7PR04MB4010.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: HE1PR0401MB2331:EE_|AS8PR04MB7861:EE_
x-ms-office365-filtering-correlation-id: 6e9e29a9-9dec-4e57-238d-08dad2dc6e1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1bJ7Bz9YeiZ7qbodhk9GbCvVETCaq31zWvWJhv4qDIawgBs6FZ058OcozKLEebYE7gJCejJUnZ+bvKtjoLxjldiI0TvlHIIlXMvxhRv39TV64fJBHZR7nNzA2frIXOFuOvzFEfgbkB0vWQFw6W4ECipOpYGRf+RDndxbWgkaf0qbiRW6JKC9dnZGyypzfTjcyeZeVDiCPbbi+bBJunIgapSbeX0L/PiMMWdMnumPW9poJBXw701ZI+I+WIXi2LtiPCpRzONaS6DQxCvlgesbqbNvck5GjHwHp3zyYZ0Nkyq3/apb1tmBVdxM5JOMihoWVRB2+O+MPMbAGnIO4B7HCgOpBE8CrC9wBbYK9ht7cZd7wY3liC31hvrNRmwxwbc7rGdiwoI8aqnAhCcDnaORgwFEiAbZi9m9AHsma+42N+YtMZlCDB94r8gi24y5tVxkLRiVfeV+P/dHFHTAkf+rGIAOxZ1xoY9XWsnQsaf6HC4L+x3fjkyIPNr7qsSnjcsNdZoe0P1ztV/QER5uNWGUVQfFrt1EsC+AVLNdDHdsukytpv+5YNYFpo0Rx+82YGUkMpwH25vxJUWwi28OW8iLEReobOYRIiWaY7TjZIOHbQJ3GQsSAPKGYV8Vwdxwcuzk8sHrzSPdpDlss0XTOZqYK5VvtqDPdnPqYFr8soa0dMSj9cQIlU2so4g1i2To5eqrBmxetmlJ7TPRF/JkovAevOXmsFNy5RXbcSwsYLuLyr8ltQ+S9/DEFHEg8h+CaUj9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(451199015)(7416002)(8936002)(5660300002)(44832011)(55016003)(9686003)(41300700001)(110136005)(33656002)(52536014)(316002)(66946007)(4326008)(66556008)(66476007)(66446008)(8676002)(122000001)(64756008)(186003)(26005)(38070700005)(38100700002)(921005)(2906002)(76116006)(86362001)(83380400001)(6506007)(7696005)(55236004)(53546011)(71200400001)(478600001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?eTZPMUU3K2NUTENaMllpckE5NGJ1bGd3WFVIa01CRm5sMlhsNW9BTHpV?=
 =?iso-2022-jp?B?WWtxNUora3BSL29tZGtkcHZ3RGUzcmw3QWR1ZE1hTzhaem5CaE5kVmNF?=
 =?iso-2022-jp?B?bEhVVW9BZzdMYVE4UGJhbDVaTGUyMTRVMzgzSXN0K21uTThRNGFoVnAy?=
 =?iso-2022-jp?B?MWtZMW9RaDlDMjZwR05zeTdObGJ5N05VSEt1T3hjSExiR1FNNjhCUklR?=
 =?iso-2022-jp?B?WlNEamFXUmIvcFVhdFBZTkRYYWFhSUkxa3BnRzlWN1FqSC9nY1QrbTdW?=
 =?iso-2022-jp?B?T2R5SVVjalBaWW5NSE1qalNsUitteHdMTFdlWUFKbG9wNVJTNFVhdU9B?=
 =?iso-2022-jp?B?TjdnbFB6MHVvQ2RXTFZvalVKYy9oc1ZKQTZvMjh4bUV3VEE0WlVGV3Az?=
 =?iso-2022-jp?B?VG1Td2lzYklxWmF5Q0pkV2hDTm5QUXFKS2xuQUtTL0NYRmhablhoSE03?=
 =?iso-2022-jp?B?ZlFUdnlhSlpMT1pmUHVJNG91a3V5aXVBZVhEUVJNb3JoOG54TzBNMkpI?=
 =?iso-2022-jp?B?S3ZGT2hKS29Wam1LdG9hLy9nT3ZjZ1JzaHNNZGxHeDJhbFdTdW92QnNO?=
 =?iso-2022-jp?B?bVRMbU5OWVAxQU0xTjZ2RkhQTHRSdjlPVmRuREljd2d5L3VFV1BCK01M?=
 =?iso-2022-jp?B?OFdLYVhUbUVuY2F1dWJoNFgrdEdMUWVKeUdOek9wVk5PcjNBZFlwalFm?=
 =?iso-2022-jp?B?ell5OEJZajVrUHpTTGxGL2IxYW83QlNxamZoNWdsS2RCWDZHd0VuOTdP?=
 =?iso-2022-jp?B?TURvZEY1NXI5OHJ1N2RScU53c2xZdk5ub0p3YTJVb0hzQkx1UFpJbjlZ?=
 =?iso-2022-jp?B?bEtDVmhvazZpVTBNMDRhc25CSysxNVpPUkdQZmJKdThIcWQzUWM5am1w?=
 =?iso-2022-jp?B?OEpyRFpFL1JuSml5Q01wWWpzWFZ4bmhVbUtBQ0tDeGVUbHQrejg0NUVG?=
 =?iso-2022-jp?B?NmNKMDBINjVsdUd0cEFsTDBNVzNLUTRCUHVzTFNUTWt3aE9vdmg2RmQx?=
 =?iso-2022-jp?B?UTBmTENjQlJpanZRcXpPWWg5SXQ5VDUvZlBIWUZqNEtFVEVtSUFkWnpJ?=
 =?iso-2022-jp?B?L0ZRUk5VendSVFBOSmx0RmNQYU5DVXY1cEh5dy9Pb3gycm1RcjBvaFhJ?=
 =?iso-2022-jp?B?djBSdTA2NDkvNkNKYUM1ekJRMmF2VUxmb2U3VG1IdnBHOFBLYzdQeFNU?=
 =?iso-2022-jp?B?UGpFa0F6Q29OaGF0ZFh4MXNKNGNOV0Y2S0RPNWl0QUdreVRxMlVHc1ZH?=
 =?iso-2022-jp?B?a2R5anNMblNwcW1RVml1c1JvZWowc1Y3TlQxYzg1Nit3Ukx3Q25RUjZk?=
 =?iso-2022-jp?B?b2JDaVNYVjBTaTNBQVJITTZqTW5NeWQzS0twb1RLV0hmTnN5MmFFNmhR?=
 =?iso-2022-jp?B?djF3SGZpTGZSZWh4TTBFTGVrM085b1FuNytEdmpXRWxrUnNDdUloNGFI?=
 =?iso-2022-jp?B?NDF1c3FJTUpXNXluR3IzTjdPd2tOTGs3VlZTZVpXeHNQWExad0NNNWNr?=
 =?iso-2022-jp?B?MHJweDZPaVdmV2Z1d0VPb3diRWFPYTRrUFovSXA3UEZWcUVLUVdTTUNL?=
 =?iso-2022-jp?B?ajg4bnNtMWh1eWczK2tQSzFiV1NQc25JaUgxaGJnUmVsZytPSVp1bXNT?=
 =?iso-2022-jp?B?SlpSUXlXOXBhYS91ZzBiV1c4YXhzaG9vRTYrVktBSHFKZm1CSTVUSlNr?=
 =?iso-2022-jp?B?ZFpxR2tYWVl5dWJyQTM3Z0ZsTVM0K2piNW01MVRPOXpscDg1M0ltQ3ZB?=
 =?iso-2022-jp?B?d0VGYzZ2YkxobDlMVkFaTXZpUkxTMkZvUkcrNUM1V2ZYRmdndXNiL2JO?=
 =?iso-2022-jp?B?aUxwSjRJTGYwS2ZQcExHY2E4TkY5aXVaYnNIS084c0ZEYVhWMXdYWWU2?=
 =?iso-2022-jp?B?eGVyM0hzVHV2dlplZ3E2ZzAyc0pxUXFlZmFnU2Flb2h3WWg0RmVpYk14?=
 =?iso-2022-jp?B?VlJTekFjNXZCbU9WVTQ4dlpFRFRSbkIzeWdNUzllNWdoeUNzSFpGa1Vj?=
 =?iso-2022-jp?B?R29oc0JjbjZrRThBdE9xV0RrL280ZS9FbU5xUEdjMll3dC9jd0toMmh1?=
 =?iso-2022-jp?B?bEx6d0pqWm9xZ21TZ2wxcVVVNFBFdDQ5RWhSUXBpdTAwWTU0UmYvdlB3?=
 =?iso-2022-jp?B?d09SZ3ZQMVBOOFk4bzBSTEpXNGh1OFN4RWxVeGcza2tmVEpjU0FuL1BF?=
 =?iso-2022-jp?B?NFYvQit4dkphZzVFN1cxTVVBeE9keVRXdG1kRTl0YlFic0U3dnQ2SWVE?=
 =?iso-2022-jp?B?aTQxOGNGaWhWNFRteFdrZDlrY05ubmtOaz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e9e29a9-9dec-4e57-238d-08dad2dc6e1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2022 14:09:00.8231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4uYxXI7ToMkIOFmL/JN5UtK2pqaWVL33A1HpCCYDxw/S3RdkBHXIjaZX65/tOl6jQiMgtIelIByNscReXOPgUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7861
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Bough Chen <haibo.chen@nxp.com>
> Sent: Wednesday, November 30, 2022 3:58 AM
> To: Frank Li <frank.li@nxp.com>; Cai Huoqing <cai.huoqing@linux.dev>;
> Jonathan Cameron <jic23@kernel.org>; Lars-Peter Clausen
> <lars@metafoo.de>; Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; dl-linux-
> imx <linux-imx@nxp.com>; open list:NXP i.MX 8QXP ADC DRIVER <linux-
> iio@vger.kernel.org>; moderated list:ARM/FREESCALE IMX / MXC ARM
> ARCHITECTURE <linux-arm-kernel@lists.infradead.org>; open list <linux-
> kernel@vger.kernel.org>
> Cc: imx@lists.linux.dev
> Subject: RE: [PATCH 1/1] iio: imx8qxp-adc: fix irq flood when call
> imx8qxp_adc_read_raw()
>=20
> > -----Original Message-----
> > From: Frank Li <frank.li@nxp.com>
> > Sent: 2022=1B$BG/=1B(B11=1B$B7n=1B(B30=1B$BF|=1B(B 0:46
> > To: Cai Huoqing <cai.huoqing@linux.dev>; Bough Chen
> <haibo.chen@nxp.com>;
> > Jonathan Cameron <jic23@kernel.org>; Lars-Peter Clausen
> <lars@metafoo.de>;
> > Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> <s.hauer@pengutronix.de>;
> > Pengutronix Kernel Team <kernel@pengutronix.de>; Fabio Estevam
> > <festevam@gmail.com>; dl-linux-imx <linux-imx@nxp.com>; open list:NXP
> i.MX
> > 8QXP ADC DRIVER <linux-iio@vger.kernel.org>; moderated
> > list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE
> > <linux-arm-kernel@lists.infradead.org>; open list <linux-
> kernel@vger.kernel.org>
> > Cc: imx@lists.linux.dev
> > Subject: [PATCH 1/1] iio: imx8qxp-adc: fix irq flood when call
> > imx8qxp_adc_read_raw()
> >
> > irq flood happen when run
> >     cat /sys/bus/iio/devices/iio:device0/in_voltage1_raw
> >
> > imx8qxp_adc_read_raw()
> > {
> > 	...
> > 	enable irq
> > 	/* adc start */
> > 	writel(1, adc->regs + IMX8QXP_ADR_ADC_SWTRIG);
> > 	^^^^ trigger irq flood.
> > 	wait_for_completion_interruptible_timeout();
> > 	readl(adc->regs + IMX8QXP_ADR_ADC_RESFIFO);
> > 	^^^^ clear irq here.
> > 	...
> > }
> >
> > There is only FIFO watermark interrupt at this ADC controller.
> > IRQ line will be assert until software read data from FIFO.
> > So IRQ flood happen during wait_for_completion_interruptible_timeout().
> >
> > Move FIFO read into irq handle to avoid irq flood.
> >
> > Fixes: 1e23dcaa1a9f ("iio: imx8qxp-adc: Add driver support for NXP
> IMX8QXP
> > ADC")
> > Cc: stable@vger.kernel.org
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/iio/adc/imx8qxp-adc.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/adc/imx8qxp-adc.c b/drivers/iio/adc/imx8qxp-ad=
c.c
> index
> > 36777b827165..3cfba5c0fa34 100644
> > --- a/drivers/iio/adc/imx8qxp-adc.c
> > +++ b/drivers/iio/adc/imx8qxp-adc.c
> > @@ -86,6 +86,8 @@
> >
> >  #define IMX8QXP_ADC_TIMEOUT		msecs_to_jiffies(100)
> >
> > +#define IMX8QXP_ADC_MAX_FIFO_SIZE		16
> > +
> >  struct imx8qxp_adc {
> >  	struct device *dev;
> >  	void __iomem *regs;
> > @@ -95,6 +97,7 @@ struct imx8qxp_adc {
> >  	/* Serialise ADC channel reads */
> >  	struct mutex lock;
> >  	struct completion completion;
> > +	u32 fifo[IMX8QXP_ADC_MAX_FIFO_SIZE];
> >  };
> >
> >  #define IMX8QXP_ADC_CHAN(_idx) {				\
> > @@ -238,8 +241,7 @@ static int imx8qxp_adc_read_raw(struct iio_dev
> > *indio_dev,
> >  			return ret;
> >  		}
> >
> > -		*val =3D FIELD_GET(IMX8QXP_ADC_RESFIFO_VAL_MASK,
> > -				 readl(adc->regs +
> IMX8QXP_ADR_ADC_RESFIFO));
> > +		*val =3D adc->fifo[0];
> >
> >  		mutex_unlock(&adc->lock);
> >  		return IIO_VAL_INT;
> > @@ -265,6 +267,7 @@ static irqreturn_t imx8qxp_adc_isr(int irq, void
> *dev_id)
> > {
> >  	struct imx8qxp_adc *adc =3D dev_id;
> >  	u32 fifo_count;
> > +	int i;
> >
> >  	fifo_count =3D FIELD_GET(IMX8QXP_ADC_FCTRL_FCOUNT_MASK,
> >  			       readl(adc->regs + IMX8QXP_ADR_ADC_FCTRL));
> @@
> > -272,6 +275,10 @@ static irqreturn_t imx8qxp_adc_isr(int irq, void *dev=
_id)
> >  	if (fifo_count)
> >  		complete(&adc->completion);
> >
> > +	for (i =3D 0; i < fifo_count; i++)
> > +		adc->fifo[i] =3D FIELD_GET(IMX8QXP_ADC_RESFIFO_VAL_MASK,
> > +				readl_relaxed(adc->regs +
> IMX8QXP_ADR_ADC_RESFIFO));
>=20
> Hi Frank,
>=20
> Since the ADC mode is config as single-ended 12-bit conversion, every tim=
e
> when trigger the ADC conversion, only one 12-bit data push into fifo.
> And we also config the fifo watermark as 1. So here only need to read onc=
e. I
> already confirmed on my board.

Interrupt handle should guarantee read all data from FIFO.  If somewhere in=
crease
Watermark or set auto continue sample,  irq flood will be happen again.

Best regards
Frank Li=20

>=20
> Best Regards
> Haibo Chen
> > +
> >  	return IRQ_HANDLED;
> >  }
> >
> > --
> > 2.34.1

