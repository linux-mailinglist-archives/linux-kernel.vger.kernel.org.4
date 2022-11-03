Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DC8617603
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 06:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiKCFIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 01:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKCFIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 01:08:19 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20064.outbound.protection.outlook.com [40.107.2.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADCE18B01;
        Wed,  2 Nov 2022 22:08:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0AVXTsM0mXxL/6SHkX4sj9BTzjnYWBo92YyAmBvfLCYsUAPHIatQblGJlO/MLrv84p2/9ekeBOvYF/BDBCQb6sgUcfW0RzPyW26zdZ6lNB9pUcohGz1d4HMtFXeDVSHOmn3e1JWsAC8hQCpuOg+6JGAGUkZ5uF9eOB1Ynn20M/OqiwJC4xwJ2JTCLyArxwHHN17t6KcKZGyoGvTxypge4dqPutlK/mXwAtm+f4OgY02zdqvt0ghfyV6FiVp1/uIQffXnAtCF8fiWC0vdwnUXzLijY0uKeg+TSoHlSS/Sv4ZFCjdjPFtdMYhTEuWfzg+Q+ycakrvdqEInkMwgVMOGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESU28PmRmNCz3CY3dTxtqSFw/NcI8402WVJeardR9aQ=;
 b=dpgKsArP1kAGPqnkgBsRWxukfCGP9qvv95D8gXeMqzFJYD97QJOzltep4NeWQ39ECclG0b3B3/M/Cg+JEDHLX4EleVZwMU/UEKsQNhaIvdAU8eyO2Em3EZstdK/H1Ut/6KH6XQkL092MKe30XmavMRRiuh9Y4g4fRdmPR0IUpsL/Tx6+sjFYHTvEvTbN+WbvjeEpoa6adSfYvmefWOkm23CltivHz/SAkOUx3LVv1F0v/8BQIiXeXKyHUihZBVT1B/IAgFbY5o69NDmDeBeiazz+8iVPv5WaY60683RIWepPChOTZbr3F2MCzrqpOR3JuPUBbXVt2Yyu37amk3pzWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESU28PmRmNCz3CY3dTxtqSFw/NcI8402WVJeardR9aQ=;
 b=sLdiod6myNqvZ//5Iv5IeCRrVv4rwElrWdp0w+hX7UH5PtFgJefzjYiBaGgndUofdRFd7PRucyLF0JXBKMvMGV0t86dJqXt/mS1XmSTniXicxAn1M5Fb14dzrr8OX1gr/z49i7GDnNQ/6AEr6wB+aCEoDQgKe5qryhgxEu/9YHU=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6834.eurprd04.prod.outlook.com (2603:10a6:208:17e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Thu, 3 Nov
 2022 05:08:15 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::36a4:e1fc:67a2:c701]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::36a4:e1fc:67a2:c701%7]) with mapi id 15.20.5791.020; Thu, 3 Nov 2022
 05:08:15 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "andersson@kernel.org" <andersson@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH V2 0/2] remoteproc: imx: add start up delay
Thread-Topic: [PATCH V2 0/2] remoteproc: imx: add start up delay
Thread-Index: AQHY7q2EQ7vW7H0K9kapWb8mOaD0564r5BSAgADBV2A=
Date:   Thu, 3 Nov 2022 05:08:15 +0000
Message-ID: <DU0PR04MB94170F02CF6BD02D7869A75388389@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20221102112451.128110-1-peng.fan@oss.nxp.com>
 <CANLsYky1j_BMD-Dg1Lath4bftE-0qPEod7fxcaN3UkKUpjP7dw@mail.gmail.com>
In-Reply-To: <CANLsYky1j_BMD-Dg1Lath4bftE-0qPEod7fxcaN3UkKUpjP7dw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM0PR04MB6834:EE_
x-ms-office365-filtering-correlation-id: a639903b-bef6-4d50-1db3-08dabd596a30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ypv5EnPjMppB6KOklj9Z0Tfd2JGuAqalaQX7SzcjTI/vmPHK10HMX7uaZc7UC/ygDwTXqg9+R3gdY/c2gQZI9wlKw5ol+QUyLhkmP/xOL1Sn8jsgiD7iMzH5c62o+hUiTRM8K+4ZTO8AkgDy3X/a+M74QPIHsSoi8o9ZegZZ48eHRzLY5/jQj0lBq2CNOuBCRhUMGLxIzVDE0tLw1zgK539n280iFEXjOvBeH+XGlG+jURwzhDdqilMLw6n5cnS5pw5VWV6FcHZSaU+n8Ky5Ultgk29EUBTTuGOSoKrij0D2S+WaehWqFRwFkXRhGI5GKUM8sOSrt1iy2nb+J1fNLFjb1kS34+6eGnjB/KUCDw7DenV4m4JaCcvcGVJZ9Xx5tU9GivOdtmcXuf4fZw18pMz/e6nc2Zi66ExdTsn+2UZFYZOXCUHFa34Tv6bXLz/wzypTQ5bEcyW7mLgaBQOXeaGzyYAuPsn8qbZ151OTHblxXoqY+ymKIn8FhHYU8cM7CdOUslVK1hiN4dNYtk2dicKrgJaGOc7GADT7unEZAQuUC0LUgAM2j84pttHRcQ55gyGQtK9ZStj9LPvL2YQAFEgAwq5MqdhdBNZ6lAiURHoNWRdrEdq+u1bFkBor+70nQNRmht8dtwpo9CLN5oGU+sBydCYghiYdRwFQX+XaUZHa2JnOX6VQlD+Ahbds+ngsq2J0r663acY2KYoz7LoaYFdc9uOQ1xO9E2xs5t25BzSbBaC+KbI9JNOkprnh4zoIojZNpeH8fHDbk+eg6RRnbzqljs43KFiq/2/m178ulHQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(451199015)(38070700005)(122000001)(38100700002)(55016003)(86362001)(33656002)(71200400001)(76116006)(966005)(2906002)(44832011)(8676002)(64756008)(5660300002)(4326008)(66556008)(41300700001)(66476007)(66946007)(9686003)(45080400002)(52536014)(8936002)(54906003)(316002)(7696005)(66446008)(110136005)(478600001)(7416002)(186003)(26005)(6506007)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?t04DOPxBtSB/Y0uRzMuFmdg2KtQucBFM6tFRuKZC/NgFZCt+5QR6ytjas5yf?=
 =?us-ascii?Q?UxBsfnBq/cjFa6zkxiWrEkUymWEo84x/IpllumrYXsThpOGm8r01Stzpc0Lq?=
 =?us-ascii?Q?foyUkoyqBflmyQVIr/C07xbYH1IehfaJUh8o+YJz6+04XaIxtDtEIq+Nza0k?=
 =?us-ascii?Q?85SZsU2u3hv2iMa3tdiLZ4tY2XEXGtTbfOCX1G/O/zYHacCu0S2FEftVIxaQ?=
 =?us-ascii?Q?F/uHSEPwfGvKQNVnwp0bcnD6wvuD+/zdxvLTowE2wE+N3AeM14bR/mNG4QJd?=
 =?us-ascii?Q?iltfAy7Kp+B54V41dkaxktf2XBULhtq4fTeGni28DoYduJGQa003dhc5oDOZ?=
 =?us-ascii?Q?EFBRSEOiQkbx3Wgblesol7xT43WECP8KaRte83Z8S29XrUlAwxj2ovaNiTRL?=
 =?us-ascii?Q?W/93WNgV/2NVjtzSovi/yXMAdz8Ozrka7zAsyRt6L6zrPrnmaoAEunrRwIr5?=
 =?us-ascii?Q?iAYqrljQ2Nub/SuGMe7pnFrrwj3ZbvW+ydfxk6LhbOmlB6VRwnJ2m7s7LHj2?=
 =?us-ascii?Q?iI7dMUy2f7RkOELfOty36mD+0k9ThJ5tg5LchRKjUJ0yuLu76ftxs2bHz1fQ?=
 =?us-ascii?Q?qteZiduWnwZz//ylGEx67p2trgyc4oKfOE7CloOhIwQClYMByDNnPxES1aHs?=
 =?us-ascii?Q?Ooq0njhni/bhDaDxw+SggA0GWs2bskTMFeUWxvY0PCEpbmu8xbat0dg8Y6gd?=
 =?us-ascii?Q?50LKsTeW2wJIiCnV6iHKYT1wjUeR4wsC/bI2CfZUfsfN0eg0CvG26ge0UZbv?=
 =?us-ascii?Q?M2n7BmTvalVqVfuL5XfRySp2VfJf18F1QtHLpeGr+HGVzQwyWVKVM3HG8d1K?=
 =?us-ascii?Q?l4lN3AcsqV5PlumAeB3guElaXFfoI6diOxw+Mc6dgPinoZ6R+pp3WlgJTDH2?=
 =?us-ascii?Q?9++JjSB0JUAn3XAvVctn0OfK72ngJxjJ0pPlFlTmc/e87gPWH8aSgQmuEOQn?=
 =?us-ascii?Q?5+ue/MZgtqlpZLEKxbK30g4jsFj3bo8Q3cxQOSvppd1ld2LDbF4gbjrF7GCR?=
 =?us-ascii?Q?sOt7xrLIgum9AKRTlsw3lMQjK6zUYYhfgk1lWech6TQQOnPS+Pocg6/0WVY3?=
 =?us-ascii?Q?ECaS+UKX9mufy1E55cR8tVLy8zTCWw3mvqVju1xnLtnkuV0e1osj3H+S+0OP?=
 =?us-ascii?Q?uT391x4dbM0mcd6lQUzqNXlvstkXT9I3/hi1ie4pA16MYgnDgavb4OE0MaQr?=
 =?us-ascii?Q?ipF3YUfxjGnzalj7l2mDXRGyLW/FzTr/Uvu5LQO/HVl7/45bNoF2QlSGxY6I?=
 =?us-ascii?Q?ZdIVz/ZIkMmLDhoyr46WEG7whjhHZR4NxkY1BD1eVAmHkhQKFJ2oWGDEQI7k?=
 =?us-ascii?Q?KNOb7q/nT/ooRqeImRJUZ3YKDQxGhSxixWZJYQ+T236xN0ElPD1iocmNeD6i?=
 =?us-ascii?Q?mlLgOi61YaaKipGSnJy+X7Avlxb47ImjrshEku2N2N6GpgAo7kFz05SZUz2h?=
 =?us-ascii?Q?3MPz1jyvC8Hw0XB44uxh4YqROP+Cv14n2bdKXFQ1ApkHsmcFm+uSmQnInXnl?=
 =?us-ascii?Q?os5y0zD3Z9trjH6EG86PfAxPxbNKv1+Jr1BqN0z9MZ0eUaO/5T0Fo7Vg0h3s?=
 =?us-ascii?Q?Y5Ow0Jiz47ovt4HyxHc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a639903b-bef6-4d50-1db3-08dabd596a30
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 05:08:15.7311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DhwJUvd7LWngUMlm3WDkok1+tHsAx86wQ12cQszSz2HBEVl9VkhI8WZ227ZJgbSIu9kysge+uL7ex0XFunnJcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6834
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V2 0/2] remoteproc: imx: add start up delay
>=20
> On Wed, 2 Nov 2022 at 05:23, Peng Fan (OSS) <peng.fan@oss.nxp.com>
> wrote:
> >
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > V2:
> >  Rebased on linux-next
> >
> > V1:
> >
> >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore
> > .kernel.org%2Flkml%2F20220609123500.3492475-1-
> peng.fan%40oss.nxp.com%2
> >
> F&amp;data=3D05%7C01%7Cpeng.fan%40nxp.com%7Cf14584bdef9349e744ca
> 08dabcf7
> >
> e1be%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63803007007
> 2451509%7
> >
> CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJ
> BTiI6Ik1
> >
> haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DCk73gkOPpNVT
> kcZL8olCZP8B
> > %2BrIpZHV48uZBl2R8HdM%3D&amp;reserved=3D0
> >
> > There is case that after remoteproc start remote processor[M4], the M4
> > runs slow and before M4 finish its own rpmsg framework initialization,
> > linux sends out vring kick message, then M4 firmware drops the kick
> > message. Some NXP released Cortex-M[x] images has such limitation that
> > it requires linux sends out vring kick message after M4 firmware
> > finish its rpmsg framework initialization.
> >
> > The best case is to use a method to let M4 notify Linux that M4 has
> > finished initialization, but we could not patch released firmware,
> > then update driver to detect notification.
> >
> > So add delay before linux send out vring kick message. It is not good
> > to use a fixed time delay in driver, so I choose to get that from
> > device tree.
> >
>=20
> From where I stand this is a hack to hide the lack of motivation to enact=
 the
> real solution that is outlined above.  I also wonder how these problems
> were not caught during the testing phase.  Either find a way to upgrade y=
our
> firmware or keep this in your internal tree.
In the beginning, i.mx not migrated to use remoteproc, i.MX release only su=
pport
uboot kick Cortex-M core and use downstream imx_rpmsg driver to
communicate with remote core. There is no runtime stop/start.

After migrated to remoteproc, we do see some issue, but old firmware was
there.

Thanks,
Peng.

>=20
> > Peng Fan (2):
> >   dt-bindings: remoteproc: imx_rproc: add fsl,startup-delay-ms
> >   remoteproc: imx_rproc: delay after kick remote processor
> >
> >  .../devicetree/bindings/remoteproc/fsl,imx-rproc.yaml    | 4 ++++
> >  drivers/remoteproc/imx_rproc.c                           | 9 +++++++++
> >  2 files changed, 13 insertions(+)
> >
> > --
> > 2.37.1
> >
