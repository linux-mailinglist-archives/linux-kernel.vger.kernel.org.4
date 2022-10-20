Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6789A605561
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 04:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbiJTCQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 22:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiJTCQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 22:16:33 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2048.outbound.protection.outlook.com [40.107.104.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1360C16D556;
        Wed, 19 Oct 2022 19:16:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFHPdGCyrugRpogc5yU/0Srdcs0mLggEmf3KfYGvyQby3uhR3j1+UFyi4eHXtekMLIJ3QXIc9MlCK18fK/GvumzD4wG2YpWSA05o7HRARw5EpjcbJFDHPLBJna8VjEhCA7MEhzbkV51Wte0Hh8rBzNUVF9t3oRkjqZE/imdRmhajuu1Q9LUU1BjwUAR/Zke1s3DGl4Ci7kMsOzLYXRkHuWgiTPfq6SJDWOocunXzzQgS5isNfODAthNWLDSKMjaABt1NEdfNq5mT46s3ifW/3MwM9imCXxZ7/PTdAywWm/rEg9EUUsHOSVpcLoOsQJ9iN1ftFdDjol8h55+CYGh7+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BBDb3u4MMTlXDaFM1mRK1MKB2k7yQFTpozZPi4qpUbo=;
 b=AIvGfNNv3XFSM9Axv5Fu9M1z/xC7eiZAIyo4aVqgQxicyhS1GuSZw3GCVJpElfZQ17pO50TVYZVJUxS+6fXVTndk8o8BvdPHZIqG0ldkmogbug3U/txCu4Emq/iTxG8YzhZeh50P5D5rEIqUOrKmMBVJFuOx6eKrX/6B/XNycFLru1IJEH+qqqI6KV9TFDPBtnwtjJQg5OoM5haZkPGK9MRchvh1CGxaKnYRLL1Nc0jKp24XoVryFs2BiJjFKPL3HtIQ17S4eCCjkqAJ+lXDD6F4t/wr+ZyD8L+cTjv5im59JZlCn8nli143ohG6gB7x+niOGc0SVyfe2jUOFNLJzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBDb3u4MMTlXDaFM1mRK1MKB2k7yQFTpozZPi4qpUbo=;
 b=Jr52WfjZ+7R1iHoeVr48agQER5+lucqYWMyTvN61T7tB+dwvSl/fk3JsuI1yywttjO/uGqLpWioHO+aKPF7RUyF8SFm6zee0pkhnGHd7XqEJAi5AkvGO0yFJPOFxXwenkg+JAL8JZoSKjUI1KMpuDkt+AIyPOmLeuPs2/W88Gq8=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by DBBPR04MB7753.eurprd04.prod.outlook.com (2603:10a6:10:1e1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Thu, 20 Oct
 2022 02:16:30 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::84cf:df3f:2012:79ea]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::84cf:df3f:2012:79ea%5]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 02:16:30 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Shenwei Wang <shenwei.wang@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2] tty: serial: fsl_lpuart: don't break the on-going
 transfer when global reset
Thread-Topic: [PATCH V2] tty: serial: fsl_lpuart: don't break the on-going
 transfer when global reset
Thread-Index: AQHY46tOTi2zpRnib0CirPl552XR464VxyOAgADDwnA=
Date:   Thu, 20 Oct 2022 02:16:29 +0000
Message-ID: <AS8PR04MB8404A05CA58656C6A0060747922A9@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20221019110720.31722-1-sherry.sun@nxp.com>
 <PAXPR04MB91854B68F039C9F109398756892B9@PAXPR04MB9185.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB91854B68F039C9F109398756892B9@PAXPR04MB9185.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8404:EE_|DBBPR04MB7753:EE_
x-ms-office365-filtering-correlation-id: a6468b30-af49-40d1-986c-08dab24119ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LuXxf2P5aBmSbktVlk4UtuOUaIfqvI1o90MgKGqbS4lBJgh67L2z4i9oHtSNfph2iMxf7q2RQojYB+oW44+M78yfopjjrCbr8dqUlFhJdyk3aTAnDe3pHZMLDSzBuYIIC6hldUE5VHVsQTFdxQCH/77qr1VmhPPe5tMDfAF0C8n1bgD1LQUTXPytXuBlWQCUI0kNfWRPfZWYiViG3GL4WwusmwgJI+1ZuSXAloMdigB7zKi/WeoqgDekxHLjIZj4h8PwgcwTeVo3CgvKmqBl7Fw/hUdbjPd1iGYvE6vy4EkggDm5iHy79K6B0AC/sozZZ5uMeCZSmk0+ROciZdhGljvIoGgADm0tF0eirdU43ZyoTQR/5DTXsw33IkuE8ARdIPYWjEeAQSuQMEiy8S0hBBnDcMF9oFImtFjvSn4XVBLXFEzsjk1tO1nqCT7fEN7q5/6IkFuctdvjcMQs+A+CXL5jhHEMFhWKDA9xRH3D3wpC5o7kFuYW9J6/eaES0W8tO+Grw13XeoctOx1rZFmVIoyv9+0DbH7fS67TlxHJBVxK6CCSSasZGxg5snMRvdjvkI4LqgeOwL9COAr3yCEpqbjSIqhAIqBurfpOSx3pveWEe8SjSOmIHniW35yaPbViSI5FIItrwomP9C9YaoDJ/SWv4LfrytHbjDIhr5llvogHP+63CusZt+wMhAz2YTyzoyua4S4oFwzIczeWz9pLFG+GjZuAC8gVr00Jonofp4fJ6O5dvlZArDi+tquyIynA/6vLSbHdxdw3vOUioSrC4Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(451199015)(86362001)(44832011)(110136005)(54906003)(66946007)(8676002)(4326008)(64756008)(66446008)(66556008)(66476007)(7696005)(83380400001)(41300700001)(26005)(6506007)(5660300002)(9686003)(53546011)(316002)(8936002)(55016003)(52536014)(76116006)(38100700002)(186003)(71200400001)(33656002)(2906002)(38070700005)(478600001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?n9FeJ1WFH0QK0D2kIKenlxCLd2BCejhu+osZhJo60lMcvKeilW9OljLdsjIl?=
 =?us-ascii?Q?Z9mUMUUAI4YLjzEMRwIsL5xA3FRSr6AXg+leKMXZDdn7swo2E3vGGWyyjm5q?=
 =?us-ascii?Q?HwhXQB+uiHpcSQOJUBehP6ipbcHckdv/amC51SGknOqtWZNyacJWB0Gf8l2p?=
 =?us-ascii?Q?t2Xe+hALsx7GU38gn9D9PBTxeNQU8t5e3gKG6WoaGUkFXxznmANR9fVesVXT?=
 =?us-ascii?Q?4grSZeWL8X4QPRsNpN3K6kI3+jVsGO3dGyXSVINeZQ2P/7wL9uXjJcfVOLS2?=
 =?us-ascii?Q?chSw177RQ1TihOrQadJ5jAVpBvKtJNHNDxqhCFM1HcdR8mMNPeVOUAEm3MLz?=
 =?us-ascii?Q?BgERm15PrRAj+Qsb7/MjSwkeU0cixof0iiJAdqBtPkp907m80fytOmUWaXjP?=
 =?us-ascii?Q?NzsIxcJ90n2MywE0ky/1gFTusOpi4ZI3eGFrnsjgrPUlkY4UUZaAXvKCE+SU?=
 =?us-ascii?Q?gkivJgufIGeYRMCTKljLAApDAQlcEbT3YBOVd2DCabvkICECodPTqJaizyw0?=
 =?us-ascii?Q?X7ulIaMo8nzDbhcY14+emdXGZ2iYsIKxw0QI4Y1XhH0/i3Eqd81FNrOSkUgJ?=
 =?us-ascii?Q?szR2+zMAQCMmW8aDVlgNIEprvs8W3ZmHQZFcsUkFQtuujXEmFZk5AaOZVXvH?=
 =?us-ascii?Q?XW1LjU0xqrXlzcInGtfk4L7kAHEvMuoCbCwrwhY/Cn+5napmBvRx1wv6e/vI?=
 =?us-ascii?Q?Ag2FQZKVLrRyUanhu6QmIIgnZ13Ynj3/MNYm69D5KSxSCuDrnLhGz/4poajv?=
 =?us-ascii?Q?pDWvvx5BRNjDH+zOXPknmnrV7qh3QuPtcZ5LfAPiPAgJrwa5Rzb9QsAfx6VB?=
 =?us-ascii?Q?T7dlZ8Uw1qpVy1C5fdY4maNFiPXyWkwnOjAXgPoDDG9+6aVpldxp9Y5KZJg4?=
 =?us-ascii?Q?wC7Bt2p56VbuZRtfCLIAiOikT5RvztJTQ9WOSVRA/0AkSIIrqWYIhdGb3vFW?=
 =?us-ascii?Q?z7gwQkvbjI6UhJUUeHpTN7zVDILkyohhoxjFzXbXLuqocbgV0x03vkQv4WPQ?=
 =?us-ascii?Q?soOWpnRubmQvQpK8CHwBXVLRxCh5bE/fGu9cuKEdnAJ1JeS4FvPlKMgQmp5U?=
 =?us-ascii?Q?PJ6KvDT1gFCBjX10YOoH5kviIuYra2pOtD7SBKgFBUnPtYUcA4VA61jH46bM?=
 =?us-ascii?Q?WbX3XOH66Ha51inPPjarnlJ3cjym5BKGpdO8Gn/tlyw0MoN20ZR9brdLcbAw?=
 =?us-ascii?Q?g1x6rg43zx5bmE54I8/MaVcqnsiPevEjidZMjoRRej2aYUy0ZxtsSI5hpUSQ?=
 =?us-ascii?Q?HUbn8PtPPl5PslXvDbbUgtH7D8zqtGt3iYUuMoeWoZ6YQNcCNVWevH951j13?=
 =?us-ascii?Q?Zs0dATD/oK3sCqUlTRah8LyoendLm4fJuvh59kIjOTBP2k8BrS8um1EPLqbe?=
 =?us-ascii?Q?uPp2K360nJA6EHTwRddFr8GBe20re3cyELv7TUQlBOpIOMPJIuzlIJL0cf3q?=
 =?us-ascii?Q?bUvnzrsdph7lxlvaKVg6wXWh1NcA16+YKFOwiFRfo0RWOalYejpfneuRvGO5?=
 =?us-ascii?Q?OFTl0tVAFtOrfYmWHiGvE6T1g4tnpvNe4cIAZawia6PLQT8+GxXpPnfDqCKi?=
 =?us-ascii?Q?7+lOcJnV6rBZH55KyRypgHJjZniCfnVvu+C3LfPT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6468b30-af49-40d1-986c-08dab24119ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2022 02:16:30.0311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CkKCEpU6dfeo9KNFUXPsEqh3wEKzjJg+O+sAIn96y2LfRFQkkFuzrl/AhODunX96E1JOC4qYaq5HeFdJcfDW4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7753
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> > -----Original Message-----
> > From: Sherry Sun <sherry.sun@nxp.com>
> > Sent: Wednesday, October 19, 2022 6:07 AM
> > To: gregkh@linuxfoundation.org; jirislaby@kernel.org; lukas@wunner.de;
> > ilpo.jarvinen@linux.intel.com
> > Cc: linux-serial@vger.kernel.org; linux-kernel@vger.kernel.org;
> > dl-linux-imx <linux-imx@nxp.com>
> > Subject: [PATCH V2] tty: serial: fsl_lpuart: don't break the on-going
> > transfer when global reset
> >
> > lpuart_global_reset() shouldn't break the on-going transmit engin,
> > need to recover the on-going data transfer after reset.
> >
> > This can help earlycon here, since commit 60f361722ad2 ("serial:
> > fsl_lpuart: Reset prior to registration") moved lpuart_global_reset()
> > before uart_add_one_port(), earlycon is writing during global reset,
> > as global reset will disable the TX and clear the baud rate register,
> > which caused the earlycon cannot work any more after reset, needs to
> > restore the baud rate and re-enable the transmitter to recover the earl=
ycon
> write.
> >
> > Fixes: bd5305dcabbc ("tty: serial: fsl_lpuart: do software reset for
> > imx7ulp and
> > imx8qxp")
> > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > ---
> > Changes in V2:
> > 1. The while loop may never exit as the stat and sfifo are not re-read
> > inside the loop, fix that.
> > ---
> >  drivers/tty/serial/fsl_lpuart.c | 22 +++++++++++++++++++---
> >  1 file changed, 19 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/tty/serial/fsl_lpuart.c
> > b/drivers/tty/serial/fsl_lpuart.c index 67fa113f77d4..9a0781395b1f
> > 100644
> > --- a/drivers/tty/serial/fsl_lpuart.c
> > +++ b/drivers/tty/serial/fsl_lpuart.c
> > @@ -408,11 +408,9 @@ static int lpuart_global_reset(struct lpuart_port
> > *sport) {
> >  	struct uart_port *port =3D &sport->port;
> >  	void __iomem *global_addr;
> > +	unsigned long tx_enable, bd;
> >  	int ret;
> >
> > -	if (uart_console(port))
> > -		return 0;
> > -
> >  	ret =3D clk_prepare_enable(sport->ipg_clk);
> >  	if (ret) {
> >  		dev_err(sport->port.dev, "failed to enable uart ipg clk: %d\n",
> > ret); @@ -420,11 +418,29 @@ static int lpuart_global_reset(struct
> > lpuart_port
> > *sport)
> >  	}
> >
> >  	if (is_imx7ulp_lpuart(sport) || is_imx8qxp_lpuart(sport)) {
> > +		/*
> > +		 * If the transmitter is used by earlycon, wait transmit engin
> > complete
> > +		 * and then reset
> > +		 */
> > +		tx_enable =3D lpuart32_read(port, UARTCTRL) & UARTCTRL_TE;
> > +		if (tx_enable) {
> > +			bd =3D lpuart32_read(&sport->port, UARTBAUD);
> > +			while (!(lpuart32_read(port, UARTSTAT) &
> > UARTSTAT_TC &&
> > +				 lpuart32_read(port, UARTFIFO) &
> > UARTFIFO_TXEMPT))
> > +				cpu_relax();
> > +		}
> > +
> >  		global_addr =3D port->membase + UART_GLOBAL -
> IMX_REG_OFF;
> >  		writel(UART_GLOBAL_RST, global_addr);
> >  		usleep_range(GLOBAL_RST_MIN_US, GLOBAL_RST_MAX_US);
>=20
> According to the statement in the RM, you don't need to add delay here.
> "There is no minimum delay required before clearing the software reset."
>=20
Hi Shenwei,

Assuming you are referencing the imx8ulp lpuart RM, yes, for imx8ulp/imx93 =
lpuart, no minimum delay is required before clearing the software reset.
But for imx7ulp and imx8qxp lpuart here, the minimum delay is required befo=
re clearing the software reset, so here the usleep is needed.

Best Regards
Sherry
