Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5D16A6650
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 04:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjCADKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 22:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjCADKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 22:10:15 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2072.outbound.protection.outlook.com [40.107.8.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B91E2BECA;
        Tue, 28 Feb 2023 19:10:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMefczn8cC24pykUGzUf6nRr7DtMhAY01FvxNFIVEY178lTP8kBEfa6rz+jp7RbIeFv4Ea0rA8rEpzCKPLdUYd/+pTbWkyKbuXpXXk6TqCoDrvjD45BSTYz10givPl0XZQ/Al6E3kzVddUAcax3IDEms+xI2eKiCvzJ0HL1Iba0SUtN/dNAyhUDdvBpmGZWwXgFtY+CIYtWd8zj1K0A673iVcx57SWBMHl7hImNeqPeX+ci5OJfCm+BGdEkhgdKAusEaFLAFfiFYrmZ5KwHCiItfCHru3/UVVFAePcbqdQgnk4+v7UkUjDBT1vZ77pgLd5vetH62/z00pVU9gX/VwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DW1YlEs50bZ1GdAfXumfVKIYJZ5aHJKzNSPVJswORB0=;
 b=UFQDKpUrqaTbRnGrpqgbZH9VQ1WfBbfEXLNaAvfaR31aV9IbXJcex5wEE6jkXWtyDp7KT35pBlzE3tu1avOlqqiJhXCXmFqGGfm9DBXoyxoBwxnSIqZmMIBbVPbqgLAl1Fnlx+KeN4ufGlJzvqIb+vsRBoFM3SMT/M/PnEbi/NXflTk0eykgQDRv5mzn6YUl1pwo5npI47TlnPFaFABW2JOG8SzVeuRIr9YT5PcvHnp1Bem3IQlV/u3VjvSnNu2Nmuj/ArtQAdZt1F2943UqXgro7OTZ5i8yT+epoeF9SFzo+juK4FKDktqH3JjX/lykHi2vfu76o2aSgHsy1W9UBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DW1YlEs50bZ1GdAfXumfVKIYJZ5aHJKzNSPVJswORB0=;
 b=epWzJDRtSwTA+O2SoJpmJ5dO4zxvC/eFupvrRR6c11yet/oz13KM08Z5PYNWxc1C186J6pmF8Eq/EZPkqKkJCnaw8q57+3W7S+SgIhLBlZ68p0CjgmVzjb28y08KTI0hGv8TtzFP5R0M4J0Y/OxipE2Mi+XmOmFelKfwYbxqCLI=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8420.eurprd04.prod.outlook.com (2603:10a6:20b:3fd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 03:10:09 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%3]) with mapi id 15.20.6134.027; Wed, 1 Mar 2023
 03:10:09 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        Horia Geanta <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 0/9] dt-bindings: crypto: convert fsl-sec4 to DT schema
Thread-Topic: [PATCH 0/9] dt-bindings: crypto: convert fsl-sec4 to DT schema
Thread-Index: AQHZS+Bnbs5IsRHA20OKVri3xBRy6q7lPd+AgAAAiBA=
Date:   Wed, 1 Mar 2023 03:10:09 +0000
Message-ID: <DU0PR04MB94176D0F8ADF945822BE39D688AD9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230301015702.3388458-1-peng.fan@oss.nxp.com>
 <20230301030627.GA287352-robh@kernel.org>
In-Reply-To: <20230301030627.GA287352-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS8PR04MB8420:EE_
x-ms-office365-filtering-correlation-id: d4e1c89d-f33a-4652-cafa-08db1a027748
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jA6JFjSvTaMWOQVAlXPyj8qCuvZhTp/ADrdXx7wz58zGvqcWvMK/t9N9pKaQg8XbLfq/8mJWyOPxc/dGfS+9ZKf0YcWN42WYq2nwwOyMMEmwGn2W/+MJRFnj4PD+f8icm28mCa0wqbAOOXfYDy9c2y9JKsEl57RQsJHssN5u66W44BmuNsG5XXvmOyU6kti2Qpnhp0gkVaXf0cVRL+p1HgwILBPY3LLBJmy4e7Y5r1Iby7eOAHjsadHezMgUFeqFZvLX2WvHQJY8UEbWZdSNs7101zMchGrbpcmqXg+79W5LCs2/dVfncuoCrQJ+bLtUiSJl1kO4yV5yv6anoxFbk2V4Vxm1oj24RCmVKBIatswPRPG0tT2W9hTVCiAYpzD1NqmW8yRj9MM5J/kIKftZ84iGwSfd8lmrahLlgQnq0QQqNDBiQ6jlUoIIpSYwa9VvQS3ZwSmTVSrgFh3kyn0kJojwq5eiNfkDY/2XDxEerKVDxaV+Tgo4WFYZlqeezUtkf8rn1NEPlsmQi1dKSpuSG6uEZkQwIa/ZifegjdolvMjwB/WYLWmA6+gGCg/21TNVz7/T+6WF7KanDu6Bzq9T2u/kWx1YjuyaB2LwJSa+1npFxFqeWYVaol64CUiHMx9WKeaNl2ZBghUHouG8jeXU7+2g8Rt9L/ffYnzxLxibHPJQwpZ1BDOEyMV37q8b/XXw641rp8nV9l8P9N2mntKh6Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(451199018)(71200400001)(33656002)(86362001)(44832011)(5660300002)(66446008)(55016003)(66556008)(8936002)(64756008)(7416002)(52536014)(4326008)(8676002)(41300700001)(66476007)(2906002)(66946007)(38100700002)(122000001)(966005)(45080400002)(478600001)(316002)(38070700005)(54906003)(7696005)(76116006)(83380400001)(110136005)(26005)(9686003)(186003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?chX0c996+u9jia8SXBXhdXcWN0YNbZoUNC+zxCneeWZ9W3onqQEyIXAfA7CK?=
 =?us-ascii?Q?bBkLww8JwiIPfVtyDasJPNMWbokoAY8KsUZaWu4VfOuu+yn+nrhl2yQIi/R5?=
 =?us-ascii?Q?QV//FIuvnrKqHWzvLC1HIv36Q0O/MlQFjjP2BCuI8vSlgDwk6OPk2Zeu3fnK?=
 =?us-ascii?Q?fU9BtYvL5veH81jruVUL66Y0HYKSnVIzzkgwHyTWjsFxSnsBEgbfBuXgrJoS?=
 =?us-ascii?Q?xULt98uMs6LUjkwMDVEfjOcFdUGPHP8ZUDp/mL4WferLBBL2+E+9NheZFB0q?=
 =?us-ascii?Q?LjWipTed+La8xZYmwR4Pq+3F4vXCL32UwccUoIv0j04rS7bS2XUfLXv2EXKW?=
 =?us-ascii?Q?/KE0XLn+jm+U/Ycpp3Wmricu8ZAOTx7cVf21ntYZrhlOQ5Z6NtcStDGZYqVc?=
 =?us-ascii?Q?VMA+kmbKTfBB5vEETipmzUelxOPAA7O4pQSvK48ZXc3uN/4LzYmd6ONEdhi6?=
 =?us-ascii?Q?X3Y2hZuFNsH6028eqHVeG24k/WJFHTy+TJ7l3vxE4PJ8LEYZaKkgpwvOq0Yl?=
 =?us-ascii?Q?lB8Xb1KuWkILYvL/7ahYrasL0n5zdHjQhtMAwV8GwX6mtcUIxNsctKHd8fhu?=
 =?us-ascii?Q?CQVsdYn9lKqc4cPxI/iSNpUr+wziq4HKZG4Bh4dI4OZl2XrAGNJyTg1pxkS4?=
 =?us-ascii?Q?NG1Ig5dwA4yDAWM/H4ffatQfkY8ovpXC/rEqQmrgWgPWw8X5oIP2Zsp5SJje?=
 =?us-ascii?Q?ha+hiB3Cv35mJg/qvdW8vX8BgbAhIS3jID51gTYLnBk+Sl7Td3SnHXZCXsOS?=
 =?us-ascii?Q?DOoNHP6BzPcYLD2PFo0UdpEOKda6PBVgdD5RAgUiNOfuB/dTHACoG9H6UAQa?=
 =?us-ascii?Q?W3AMUrMG4Gz657BzhCdVWvcv45x1cWmc4FF57PeFMcI7D6YpKUMiaHODN1/j?=
 =?us-ascii?Q?LqyxsgJxrHntOSaGYVZSYdjiJU6bBPWmdjzk6sF9YaDVK6kYkEQAXKUXZQgC?=
 =?us-ascii?Q?9taytAYxso31OnFlyuCeSaRiJw5IuoIuvEDjZ7qz/TU+vgTthWH56C8VzPls?=
 =?us-ascii?Q?aJ9pK7QMgAhSPaK7hidfL3fB2g5hDjm6ZyzOqvoglwTnsvVgpMd9J9ImV5S8?=
 =?us-ascii?Q?YopmcFr/qpzsOmyApZ4QsHRGoFaDDa90HcK2NzxC/tnIAD65AXAmsZET/WlF?=
 =?us-ascii?Q?ShKhs8QerxEpDLoVZa4z8oKvnRLymkCx1Q55i/uxgTSVD7Rh+upPMjc4lJBW?=
 =?us-ascii?Q?TGXOrlDNROew1yIVO+qWtRrmhAImG0QVMDvNzORYscC5l3YEL5N+I87Q8ys7?=
 =?us-ascii?Q?/apBqMbrUhk7/vj4hXEIX0slonvGg5twy3PSQMzQR+0WNzs7weOr/+HjR5D4?=
 =?us-ascii?Q?7YhVOIR6PpLJdQD0YBGPSbFcl7x0x6nRfhoLOVZeBAQA8UYb4xMUVa9FA68M?=
 =?us-ascii?Q?VzuwIV2nB7cnHx0AGRqBqTHqZYtwjXWA3PN0UjDqfzraYx17U2wXVzOkw7qF?=
 =?us-ascii?Q?1WdYswzNWOA3fMEuHfyClrKdmDBT6zaRnmvBBogy82HPrWDvA50tm+Gd5Ag7?=
 =?us-ascii?Q?0grrFG4B4WkMeWr+l6ZsglxmqjSlGrLAurdFo537UeGIjybLZdtqsBAcRH7d?=
 =?us-ascii?Q?ANQmLomYei5D9QyYeBM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e1c89d-f33a-4652-cafa-08db1a027748
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2023 03:10:09.5948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZQSBjUdd1QwSe7TLPdwDdJ2GPf6+KQV6BOE4uWT0cwKcOup2fw1EJody+tWqRIsly+KYnECjNyL8F+r01lqjoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8420
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

> Subject: Re: [PATCH 0/9] dt-bindings: crypto: convert fsl-sec4 to DT sche=
ma
>=20
> On Wed, Mar 01, 2023 at 09:56:53AM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > This is effort towards SystemReady IR 2.0 to convert the txt binding
> > to DT schema.
> > Patch 1 is just to drop uneeded number since following DT schema will
> > update the name
> >
> > The fsl-sec4.txt binding has two parts, one is crypto, one is snvs, so
> > I split into two DT schema file. patch 2,3 is for crypto, patch 4,5,6
> > is for snvs, patch 7 is to drop fsl-sec4.txt binding. patch 8,9 is to
> > add new node
> >
> > Peng Fan (9):
> >   ARM: dts: vfxxx: drop the number after jr
> >   dt-bindings: crypto: fsl-sec4: convert to DT schema
> >   dt-bindings: crypto: fsl-sec4: support sec5.4/0 and i.MX6UL
> >   dt-bindings: crypto: add fsl-sec4-snvs DT schema
> >   dt-bindings: crypto: fsl-sec4-snvs: add simple-mfd compatible
> >   dt-bindings: crypto: fsl-sec4-snvs: add fsl sec 5.x compatible
> >   dt-bindings: crypto: drop fsl-sec4 txt binding
> >   dt-bindings: crypto: fsl-sec4-snvs: add snvs-lpgpr support
> >   dt-bindings: crypto: fsl-sec4-snvs: add poweroff support
>=20
> I'll leave it to you to work out which one to take[1]. :(

Thanks for working on it.  Let's go with your patchset.

Thanks,
Peng.
>=20
> >  .../bindings/crypto/fsl-sec4-snvs.yaml        | 181 ++++++
> >  .../devicetree/bindings/crypto/fsl-sec4.txt   | 553 ------------------
> >  .../devicetree/bindings/crypto/fsl-sec4.yaml  | 366 ++++++++++++
> >  arch/arm/boot/dts/vfxxx.dtsi                  |   4 +-
> >  4 files changed, 549 insertions(+), 555 deletions(-)  create mode
> > 100644 Documentation/devicetree/bindings/crypto/fsl-sec4-snvs.yaml
> >  delete mode 100644
> > Documentation/devicetree/bindings/crypto/fsl-sec4.txt
> >  create mode 100644
> > Documentation/devicetree/bindings/crypto/fsl-sec4.yaml
>=20
> Filenames based on compatible strings...
>=20
> Rob
>=20
> [1]
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.
> kernel.org%2Fall%2F20230220213334.353779-1-
> robh%40kernel.org%2F&data=3D05%7C01%7Cpeng.fan%40nxp.com%7C403af
> 158981344444a5c08db1a01f439%7C686ea1d3bc2b4c6fa92cd99c5c301635%
> 7C0%7C0%7C638132367911500608%7CUnknown%7CTWFpbGZsb3d8eyJWIj
> oiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C
> 3000%7C%7C%7C&sdata=3DKsKhl8M5Z9Mqy0%2BfW12WJ9MRw6lTWFYTN1Qi
> xnSagJo%3D&reserved=3D0
