Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775EA706B05
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 16:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjEQOZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 10:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjEQOZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 10:25:27 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2054.outbound.protection.outlook.com [40.107.7.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FB2131;
        Wed, 17 May 2023 07:25:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QzqOmrlNrqmZw36Ys0Vk+4zL7ihgarmEUAfDCpv1hMO2NFEnC1CFhXTddbtrjFeYzjhS9s4ddeOWwHrO4yQooFC1ckQJuShRcHQOlfrTjxKjyxy7MZQOYGxpW0P9FPSA+Rcv0tkphO1YBG9S+5VLjLszY3glJILRilRz5t1pH34oiMhlOd/vUUaYSW1fISvpmuzxQyZrdxL2PFF/pynLl6YQ+jwaDQN/yoGL1XlUIzE0toZH5DTb+YIJftGS3/f/0mRXM4bmhksYl0Ax1jmKHkcu8Phw+2DYjgZ+ngxcBePSeH0KhANOOBZlZKwdkmRcbubStTmg1cS7+Xis+ayOfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MeGK1jVV4yXBKIxT3F40WjJeg/KuApeWDVYYdN1Dmx8=;
 b=nAAIDTBLL8X9bXZWFLcR6EFaYzXwwL6A5cwUzE1xaRLtj2j6huSP2MKBLX7pXzfIghG7/YPAwzZdB5xhPnPZYupkgArzpE2ajLNDi0XDzv2IBiZSktMYeDcy4u85i7aTXnPLTZ9sAEbfvT/09vHFXwSdnatzH1xzNlQQ2nWv5ZpuGCTb3QSuTstFZhREY55OCSymVmmmb/itUPDa8CzjFqSoVFgVnGZTXlMkl51SSmKI7Tk0g20p0x0eGm8OwfkxyeHpDkOnr2anEBAggdyXd94LtRvLReYDBTz/GbKoYgdFUnEC+E7Y70p+TBDYpa4t5Vwg7Ek882boME7v606b9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MeGK1jVV4yXBKIxT3F40WjJeg/KuApeWDVYYdN1Dmx8=;
 b=ZjNbo50MgYH2xCYdW4ws94gaIxWkZhJtu9E9il0tvuc6oZQWASpb5sZeVXGvdYikODOO41FHcuLlC95sSd1wBU7fO9m1XUDSnW7rMwKraRZim/C6j/pD9xGY1hxKahGRNsUPzRH6i8vl2WO3ZPEUSBi4k3oPL2g7lr583FVk7eU=
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PA4PR04MB7872.eurprd04.prod.outlook.com (2603:10a6:102:ce::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.34; Wed, 17 May
 2023 14:25:23 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884%4]) with mapi id 15.20.6387.033; Wed, 17 May 2023
 14:25:22 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: RE: [EXT] Re: [PATCH v5 0/3] dts: imx8qxp add cdns usb3 port
Thread-Topic: [EXT] Re: [PATCH v5 0/3] dts: imx8qxp add cdns usb3 port
Thread-Index: AQHZYLwz9foY+34alUyR/LPBJOX9ma8dkSYAgEFDlPA=
Date:   Wed, 17 May 2023 14:25:22 +0000
Message-ID: <AM6PR04MB4838A0B0FABE405800E00741887E9@AM6PR04MB4838.eurprd04.prod.outlook.com>
References: <20230327145523.3121810-1-Frank.Li@nxp.com>
 <20230406014422.GK11367@dragon>
In-Reply-To: <20230406014422.GK11367@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB4838:EE_|PA4PR04MB7872:EE_
x-ms-office365-filtering-correlation-id: 82a34d15-b491-4570-fd95-08db56e28ce2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9Cg7EE/QMK6/J+dnemuNrj3qXPoMOLrBy92/dJarlb7/BveQAHe3QXVQ6Rlai58AALPkABnFtHnk42KSPXK+BkVHHBtbfzmpvccfNRHrwrHmLGeB9qbImS6r6eCu8hBvyerBjImsR0/HEF7pmfNqKHszHGukJn8MnuuujLhuSMATDkRv5b+S+ugb04p4UebOOMxRAuDZyYIlWqHIPYb33lfQr70qF4PyGxWZHTCzfv5ZUgdybITuAwC/nIqeuNhXbNxknLY8NyxQtmplFdt6TdBqNc8nxrj6K9XwsirALejRxsUF9ovMoOWTHsOShdxwXKS5FXSY/Ga34PO2wEpJnPTWKPSTMYg+xqhdsJFc0D+fuwKDUxIcUpFAfLrF47F5tLz/HBkejf+iaRFYFJ63Ac2EyBlKtv6eefWeuiTt5WXzVqTh2kVdwUQgRwe9YfvqgfyXMFywqnC/iIOFBWclde/nNKPVNTBHmLgSaargzZ4OwCCfLS4I1dwGMX9yXxW9AMHNNoLPoW810jPOn9xfRp4XGLyTYDlTwn7u//MmzkJo0VbNb3B/LOXQ83QvAQpvb3VE5L81zopJFibv4BH91UOoGrqX/oe7k5FRGMKILsh+8zHmAofDgrrRnyApir8TgrgrErKnqpoDX5ImCpXMyQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(376002)(39860400002)(346002)(451199021)(76116006)(4326008)(66446008)(66556008)(64756008)(66476007)(5660300002)(66946007)(8676002)(8936002)(478600001)(54906003)(110136005)(4744005)(2906002)(7696005)(41300700001)(7416002)(44832011)(52536014)(316002)(71200400001)(26005)(6506007)(9686003)(55236004)(186003)(55016003)(38070700005)(122000001)(33656002)(86362001)(38100700002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IZr9fQ89Ui413BNxlOMA27h906q4P6ssMr8FRsgN1SFmoKGETgDiPvUe5su7?=
 =?us-ascii?Q?eoCCMLiSOLM2B46uchpUrQibzXuY9xnLgsu9SqH6gsBadbmb02nOHf0uUwdV?=
 =?us-ascii?Q?9jBS/G+fZKqWgMJqJgFODpl6MxXSrRv+pufa9ubegQ2qZZQbYSRZicvRf2WF?=
 =?us-ascii?Q?EqDt566tP0SA6ngPCyF1YvQdZqi4nJ1GpOVuPTCeRWiFjVyDVfhMzij+j8xD?=
 =?us-ascii?Q?dqGFPh+wEKzjGxmp/xE2s6/pDk/sY8xnlXlf2HMg1Ttrxmf2yCha7Aht4boD?=
 =?us-ascii?Q?OgY7yAqhV8Q8XX4o/CTA7MATXNAHvJpp0rFRVLpPtA/eNTzQ/KSklTo2mqLt?=
 =?us-ascii?Q?sFgWEpi0h8nMsLUS5/d89UAGSAniixpU43Pscyrx7WXcetN1CaP+Flzjm3ek?=
 =?us-ascii?Q?7hJb+c9kwfxp79Q59P2mgXMCXQGfyCnxQ97ogiG/Kf7UIWFVZNOS8Dy40un9?=
 =?us-ascii?Q?suu87ZcdOIJrAvaA2XdaMtGMWxSu0lw2Cyw/IXWmAokp7uJqfgxsI8Mx7hQW?=
 =?us-ascii?Q?JKOoaCVoVHQ3huIzNnn8sfz+pJMm02P5i7r+ReIBZ+4oPRAN/Njn8BVUMhsb?=
 =?us-ascii?Q?kegWWLDGAV66gZC4oOPaVkFA3ODj6lhc0MAkExbOmllNFRUOBM6ZPaVLQlJk?=
 =?us-ascii?Q?RSW+EsMnS/zdy22JttpGJGACAD7DTKrmPaeYJ1a6S4BypGIa0OSZV9F6a5Z6?=
 =?us-ascii?Q?DVZlZ5EpuB8t0mDNimM+BHQSWRyWiX2yH2jyW9Hl+ykgztPzyAq0ZeTN6Nnd?=
 =?us-ascii?Q?jPoULoI5gqC98zxNbRyHAE3Ga3Lh9FXIRG0furrg1VOba3zOuO2Kg22F+GOX?=
 =?us-ascii?Q?DGjOMoaiItSEc9hGKoGg9zkWHKLD9Q/y1JlnEuwMvBbSHKucq3RMDhLBy/QX?=
 =?us-ascii?Q?IU8dj7AK+UVW+ZVPHoA9tOpxEkLxYPGZg1sNXytpNR5MX2wLFoOJpTPRf71G?=
 =?us-ascii?Q?GBOj22QhvpM8qUD2GApc3y7Pspku9gWizXhRDOmF5s/h3Q3zD7E06nj8MhB6?=
 =?us-ascii?Q?FOYCPreEwvtbIWRQGWHr4aDqIqHSOcE6WPEc/82hr9ZXABFdwygSsQr/JVoZ?=
 =?us-ascii?Q?E+ScmEEoUsUkHYDl1qt5NyO7Vd7iDGA9IABAIMPpALDVRFgKhpznKQ1hJlqs?=
 =?us-ascii?Q?kfGrlaKZY5GbP/f3fxwW/82sGhcsT9zhZYckO8vlqfGfbubWOMdZ/zC1kzUK?=
 =?us-ascii?Q?v1VWcERcDqiE6zritT3lD8pDlpZ7cor0dKekbnxIE32pRb9SK9sVJZUrOXAx?=
 =?us-ascii?Q?GXDONLVNIbVRLOU+c1rpxiIZk+YwSgGqVV1uMcckt290Xrv47dJqZ/JENmm0?=
 =?us-ascii?Q?ZQTUbPsQgZnugwqYMsp8AegQZtdTeEGGIABfYZ/lRV1Pex1HoF/QisDZexN5?=
 =?us-ascii?Q?cWBAcsv6kcPIO0BPEfi39pJvflaK0h0+4bvZDJJs/RL6zFPS04uge9mvzKWC?=
 =?us-ascii?Q?IMJvP+5Ov8VnFyi+V5UPHIGNXQ1xjaGI9gzZvaKyirgpzWVoWLtJgBJ2Bg05?=
 =?us-ascii?Q?ha4glG2d30cISRvccIj8IOunOzPfMC5XZ+ki55eFaIG8fpTmmyFJKGI/mXM1?=
 =?us-ascii?Q?Hqu2AxgjU70jPfKgKnE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a34d15-b491-4570-fd95-08db56e28ce2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 14:25:22.8858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WA6VYHANcpUqeyiF5WdaGW9AE3d0Q0B6wvULx+zlFp8mnk7fM1+3cyBq0ZuAPsMlXRySbh9LtWdL5uv384b7Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7872
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > Frank Li (3):
> >   dt-bindings: usb: cdns-imx8qm: add imx8qm cdns3 glue layer
> >   arm64: dts: imx8qxp: add cadence usb3 support
> >   arm64: dts: freescale: imx8qxp-mek: enable cadence usb3
>=20
> Applied two DTS patches, thanks!

Krzysztof Kozlowski:

di-bindings missed, Can you pick up this one?

Best regards
Frank Li
