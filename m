Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA3C6C1588
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 15:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbjCTOvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 10:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbjCTOvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 10:51:22 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2050.outbound.protection.outlook.com [40.107.15.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0A7158B4;
        Mon, 20 Mar 2023 07:49:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JzJoWFnCFSuQAbhZoMNmCUD2NMEoninOI9v0cpDdXTQ04rf4qUvzRh6QXknhc1q762tKVjIEldqnwg6KkIBtEIGHmc2Cz6yi9HO458GYTL65uhVdvMfcVmE+9w4XwGsqsC8SAeEaECL+IzPpy37iDKXsgy8cexuigG97HQjq5Rw1nAqnnGzEr1X0QUspz/E5nYJeB584joUkP5nDM/J2EYTaUeEzLUCc/xMDdaCQPqGAVCY+YCbSaEkOvLpsGElS/QxEXfANow79GthFZAqyKsi9rhNDiRFlZ5wbED6wXDvIZcRPGPIaJlA5lXrxcy9FfJ+TpQGFmHwrQZLKoupQMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frPrIeJLF0whALGVlIKRC36kdWHWxNDga2x0bzZMrgw=;
 b=J6ZXApt59CcGYdNMu2guRZV1ss+cue0CxBmfeIeCRPBZ9V+TQulLLYRnLCAhjx9SFHAyJDd62r/WqzXwnxyi6U7vR4t6Eyft0/KOwop02QNTkm0FltNhRfnge9M1LYWdp+eacbATaNjcVvjDhKAEzDgsn/RJLhb5M208HuTAneumy7fqply0bs08w8n3+hCJAnOnjDVstSYqCOsqxpyoDM+oyQQGZG0FVWdmt4ur2ADs79zUFcNUPUTyERVLV7UXAPyWCPMurw+84NeedIRCUWZ2ZzBSRJk+d6gmq8uGoPDmWFrC5BKw4vRzcLJ+GgihV8MqDVrMBBW5uj00r0f6sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frPrIeJLF0whALGVlIKRC36kdWHWxNDga2x0bzZMrgw=;
 b=Hik0HC3BaTisLaNAcJERawDMUhgXDCIFP41TUA1l/5BojpX4BJarDn9wRRN66l9ZioGUFNK7kLl4DeYckacbV48XmjAWkbShAIvXofHWx6RyT0lcSSRc/+hh2LqhC0rH9RmRjsjdLDjqnCGO731uJqDtzg4HzuGTJgv0rbQeTuU=
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PR3PR04MB7401.eurprd04.prod.outlook.com (2603:10a6:102:8d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 14:49:08 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5%4]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 14:49:12 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: RE: [EXT] Re: [PATCH v2 1/3] dt-bindings: usb: cdns-imx8qm: add
 imx8qm cdns3 glue bindings
Thread-Topic: [EXT] Re: [PATCH v2 1/3] dt-bindings: usb: cdns-imx8qm: add
 imx8qm cdns3 glue bindings
Thread-Index: AQHZWE4ev2xmRcSa20iFYFwtFRu1OK7+r7IAgABftWCAAueGAIABzLvg
Date:   Mon, 20 Mar 2023 14:49:11 +0000
Message-ID: <AM6PR04MB483800D7CDCC7AF48F88BF9688809@AM6PR04MB4838.eurprd04.prod.outlook.com>
References: <20230316212712.2426542-1-Frank.Li@nxp.com>
 <20230316212712.2426542-2-Frank.Li@nxp.com>
 <e6935c0c-375e-b763-ea91-3b8bbc906ebc@linaro.org>
 <AM6PR04MB4838D1958A029701E1601BA588BD9@AM6PR04MB4838.eurprd04.prod.outlook.com>
 <1fd1fe42-3da6-1598-a04d-cb99a9b4b145@linaro.org>
In-Reply-To: <1fd1fe42-3da6-1598-a04d-cb99a9b4b145@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB4838:EE_|PR3PR04MB7401:EE_
x-ms-office365-filtering-correlation-id: c2d059f6-f121-4dbe-3b22-08db295244cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GcjkIwCWGf8RhTkxalc4FCny4QkALGV/nmqbAqYyVIOoUA/PKJtfqfp0ZIPctjPJ85sJHy4nQ7FwXRdvJt7g4f/yIlZ8pZSdF7267yN7hdd41QuhogRu9WfuatW4s6/GYR5KbO+W3G23wjQTqC0lVFsCVUgmwUBebX0FNRALr4hlBQGU4embhJuk85gusTdZra+NlAD3JvumlaN6sKg4vvXSkOuEAJ8hHF52y9eJ6xTN3hmNnbj95NNGewJHHYfRsxKXCFfWYoVZw3eWPTbTCD2OALAVUo/n8trqIHMJM2RBdo5lzFyX6mt6aex9DzF0r9UldTlmOTXteEPQKvnByeo0uJ1KUyayKtTIUWncq7QVgfLmMy0GNX3uaVsWAKMjsLTyzlJCyxrHiqDlEHVEHkx7z0+yvEBd+/KgLNyGqotcuarGPJ+3yfSn3v1t3I9UVny+pG9NVYoye+bkvllSXJsKzJV8mdYDeIDpQ/i/ohzAx4pprfO4SuEbu8/Px6+PA7h/EZxuJJBMoBTfX4kU2tpfq0tcQjTc7nHzvcSlP19M5u8YyMSgqyLLm7LMC7kf0KR+dD6VVt307Qj09UeVtp5B7XuWSm4J2lGJVwiY/1rwRQ6g3tOQSCmO8O1aYzLklgUttx7htyZyVqXCBicVassGvcTZYXRqpGNrXbrTCxeYCLYLbE+FpDFl4anHAAeosxSChcNVtWaHW8EsV770lI0MUdKcQr7dFAuMPoaDNig=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(39860400002)(376002)(366004)(396003)(451199018)(7696005)(186003)(478600001)(9686003)(8676002)(26005)(966005)(83380400001)(6506007)(54906003)(45080400002)(53546011)(55236004)(110136005)(316002)(71200400001)(66446008)(66556008)(66476007)(76116006)(64756008)(66946007)(4326008)(8936002)(44832011)(52536014)(7416002)(41300700001)(5660300002)(122000001)(38100700002)(2906002)(55016003)(86362001)(38070700005)(33656002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IhQCz2phUbEC8XIPnrKBW5AXshPhQ+8hQh9bCrjaYFdZfuXGOTbdS1m5DfST?=
 =?us-ascii?Q?Au9J3hcUkiStk9oO4DBMTEJ/B6mGhi4hESDJUflxjNS5OyQunr/7S6jPZ3ll?=
 =?us-ascii?Q?vxGGgsKt3GQ8/nVRCp4eeanmS1q4BY4qlqRbI0ZtcAZSDBJfX91G4BYvW/Sa?=
 =?us-ascii?Q?CtZ4x7IhUjYeiM7brM1Znly/yxKT1Wts/kaUu0/fJsp/+IoUAsXAQctQisle?=
 =?us-ascii?Q?4hK1CVhwaj6p8ZIfrLw+r2gzMWXLUflmRIBWrACriiR/tKRtlMyTc/yO6ZI3?=
 =?us-ascii?Q?Uo/WH0DXDh1eM+/HrjDics/rkMPkw1hfkOTvykDwqHBck4j3lI2Z3EX3JGqj?=
 =?us-ascii?Q?Jl0htwFq7VOsdHjZnUN1+kx6tcldTl+8Ue1cda3eG55Wl2J1MOive8JX55xY?=
 =?us-ascii?Q?6nuY5E1CRbko6pRvzKijEVVbWNsrNGzISfpjqfjo39Fa++KRUv6+wBAyduN3?=
 =?us-ascii?Q?3u1Ippc0ZxvYfqkhtPoZimmKG7lTXaI62wHuh3wXM2fqDn0HztbaHu8RNO9Z?=
 =?us-ascii?Q?nPmoAYPzgTV6TdK5PhjrFyAKPAS/aPKeeSZaHaSTkaYlR/9+Saf+ThTbCRsj?=
 =?us-ascii?Q?DCByCqiQLktCIJ8OuKBU0D9nOayDd9LpFEwFo4y82BvWtetaZTfWffpgGhAv?=
 =?us-ascii?Q?ptew/luBD0yWd5ZC79Ho9Ae0BRZMbUOnCUDl54M9r5fxk/2jIBvqIgDLfNGg?=
 =?us-ascii?Q?nlgcaAMOA/qXZjAyHbb7BRz2nQv9PP/UlMDm8lBOvuxQ6ylKGYk4AQN6jRaE?=
 =?us-ascii?Q?wWFGYMO9JM6MEy7/dKQ5uKTsqumjwYgUPveR1XtktB44uE4RvewRh7IoGrzl?=
 =?us-ascii?Q?l/D8WxGQTxtAEvQvQ7aOForPmwguZpmxpRVyKWMyFKcM8fk1O9MRVMK9qsjf?=
 =?us-ascii?Q?g8O+dd/P/f36TFsdWndDUhszUiksM5mBVumyImlEG5fVQhgbOAMqCMvnclxw?=
 =?us-ascii?Q?/kzqXlJYhGhXKlhLc/cmFHfpK14SYmEgKwFzSThrmP1adyDkicC8nHnqOO/h?=
 =?us-ascii?Q?6JVBn/RCqlFgLh/e0obuge110MqAXi3y74TILyIJJXIOQkF5G2WjaWE8qThe?=
 =?us-ascii?Q?GPxQGDEAKSnDARSFzZb7q4k3/qBvc6nd25wamXj9cgcmU1zYoQWB5sfefVf8?=
 =?us-ascii?Q?1OjuXQiN4q+dgAvzmyXDQpCCQ/vNHi6spRQiTYVDvI/y979qZYzkOsg6X+hy?=
 =?us-ascii?Q?TL2QNisKa+/5QwBqhGZitHeUh8LTN+olK8NXlPaMjwZGdRZ2U8mI5eEkEvy3?=
 =?us-ascii?Q?L0odztFUEzbVdmPxEgEGzG0bfzqeDHfxQ1uABNu7bD5mDl5cXrrl7qnHtnvr?=
 =?us-ascii?Q?Q2ChAGInUou+GW6Bi0ggSL4Zk67S48pvsQhu3AYQwEgYd1gfOcetmcFodbH0?=
 =?us-ascii?Q?5Bw6Mi+M/OSGAu7N2hwGHWB7+aMlRfJrGpOk9niTKgFBg8DJEE4NWeVjTRh2?=
 =?us-ascii?Q?RWbFQu2RM+bNbyrT8VWfaTErSf1hgARFWbyCB8meVohlqM+D2M2X/jkCr+DC?=
 =?us-ascii?Q?iVI9ocUfiN5m7PDIT/kx6M8sRixJNegfbB3w3iisfHPXQ35HKMMKwygupqG4?=
 =?us-ascii?Q?mg6y/5eWB427bCGVGA0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d059f6-f121-4dbe-3b22-08db295244cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2023 14:49:12.1102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yYXGtoD+1mkWMMFzkQf80Y5WWCS2SAWYZdba6nUEsOyrHDycdXcJc9Zl4Evt5HyOUrSr0ninHm9uG9BCGFwbXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7401
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
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Sunday, March 19, 2023 6:13 AM
> To: Frank Li <frank.li@nxp.com>; shawnguo@kernel.org
> Cc: devicetree@vger.kernel.org; festevam@gmail.com; imx@lists.linux.dev;
> kernel@pengutronix.de; krzysztof.kozlowski+dt@linaro.org; linux-arm-
> kernel@lists.infradead.org; dl-linux-imx <linux-imx@nxp.com>; linux-
> kernel@vger.kernel.org; robh+dt@kernel.org; s.hauer@pengutronix.de
> Subject: Re: [EXT] Re: [PATCH v2 1/3] dt-bindings: usb: cdns-imx8qm: add
> imx8qm cdns3 glue bindings
>=20
> Caution: EXT Email
>=20
> On 17/03/2023 15:55, Frank Li wrote:
> >
> >
> >> -----Original Message-----
> >> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> Sent: Friday, March 17, 2023 4:09 AM
> >> To: Frank Li <frank.li@nxp.com>; shawnguo@kernel.org
> >> Cc: devicetree@vger.kernel.org; festevam@gmail.com;
> imx@lists.linux.dev;
> >> kernel@pengutronix.de; krzysztof.kozlowski+dt@linaro.org; linux-arm-
> >> kernel@lists.infradead.org; dl-linux-imx <linux-imx@nxp.com>; linux-
> >> kernel@vger.kernel.org; robh+dt@kernel.org; s.hauer@pengutronix.de
> >> Subject: [EXT] Re: [PATCH v2 1/3] dt-bindings: usb: cdns-imx8qm: add
> >> imx8qm cdns3 glue bindings
> >>
> >> Caution: EXT Email
> >>
> >> On 16/03/2023 22:27, Frank Li wrote:
> >>> NXP imx8qm integrates 1 cdns3 IP. This is glue layer device bindings.
> >>>
> >>
> >> Subject: drop second/last, redundant "bindings". The "dt-bindings"
> >> prefix is already stating that these are bindings.
> >>
> >>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> >>> ---
> >>>  .../bindings/usb/fsl,imx8qm-cdns3.yaml        | 122
> ++++++++++++++++++
> >>>  1 file changed, 122 insertions(+)
> >>>  create mode 100644
> Documentation/devicetree/bindings/usb/fsl,imx8qm-
> >> cdns3.yaml
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/usb/fsl,imx8qm-
> >> cdns3.yaml b/Documentation/devicetree/bindings/usb/fsl,imx8qm-
> >> cdns3.yaml
> >>> new file mode 100644
> >>> index 000000000000..fc24df1e4483
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/usb/fsl,imx8qm-cdns3.yaml
> >>> @@ -0,0 +1,122 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>> +# Copyright (c) 2020 NXP
> >>> +%YAML 1.2
> >>> +---
> >>> +$id:
> >>
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevice
> %2F&data=3D05%7C01%7Cfrank.li%40nxp.com%7Cc2d76d3694194fba130a08db
> 286ae90e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6381482118
> 66106607%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
> V2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DLo
> JUcnJnBaGjywN1zF%2BuUpFVUmldixTci96NPzVuio0%3D&reserved=3D0
> >> tree.org%2Fschemas%2Fusb%2Ffsl%2Cimx8qm-
> >>
> cdns3.yaml%23&data=3D05%7C01%7CFrank.Li%40nxp.com%7Cac9af3d617dc4cf
> >>
> 14baf08db26c74b07%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6
> >>
> 38146409617970248%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
> >>
> AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C
> >>
> &sdata=3DEczZhjyMUGnnp7ZGfSvTj4lmOUuGlOtWYIsxxXIlNXw%3D&reserved
> >> =3D0
> >>> +$schema:
> >>
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevice
> %2F&data=3D05%7C01%7Cfrank.li%40nxp.com%7Cc2d76d3694194fba130a08db
> 286ae90e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6381482118
> 66106607%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
> V2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DLo
> JUcnJnBaGjywN1zF%2BuUpFVUmldixTci96NPzVuio0%3D&reserved=3D0
> >> tree.org%2Fmeta-
> >>
> schemas%2Fcore.yaml%23&data=3D05%7C01%7CFrank.Li%40nxp.com%7Cac9a
> >>
> f3d617dc4cf14baf08db26c74b07%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C
> >>
> 0%7C0%7C638146409617970248%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiM
> >>
> C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000
> >> %7C%7C%7C&sdata=3DuTNYuDm%2ByhZ56oQET2pX8sHpEqVvsUYtmOBCPX
> EK
> >> v40%3D&reserved=3D0
> >>> +
> >>> +title: NXP iMX8QM Soc USB Controller
> >>> +
> >>> +maintainers:
> >>> +  - Frank Li <Frank.Li@nxp.com>
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    const: fsl,imx8qm-usb3
> >>> +
> >>> +  reg:
> >>> +    items:
> >>> +      - description: Address and length of the register set for iMX =
USB3
> >> Platform Control
> >>
> >> Drop "Address and length of the"... or actually just maxItems: 1,
> >> because the description is a bit obvious.
> >>
> >>> +
> >>> +  "#address-cells":
> >>> +    enum: [ 1, 2 ]
> >>> +
> >>> +  "#size-cells":
> >>> +    enum: [ 1, 2 ]
> >>> +
> >>> +  ranges: true
> >>> +
> >>> +  clocks:
> >>> +    description:
> >>> +      A list of phandle and clock-specifier pairs for the clocks
> >>> +      listed in clock-names.
> >>
> >> Drop description.
> >>
> >>> +    items:
> >>> +      - description: Standby clock. Used during ultra low power stat=
es.
> >>> +      - description: USB bus clock for usb3 controller.
> >>> +      - description: AXI clock for AXI interface.
> >>> +      - description: ipg clock for register access.
> >>> +      - description: Core clock for usb3 controller.
> >>> +
> >>> +  clock-names:
> >>> +    items:
> >>> +      - const: usb3_lpm_clk
> >>> +      - const: usb3_bus_clk
> >>> +      - const: usb3_aclk
> >>> +      - const: usb3_ipg_clk
> >>> +      - const: usb3_core_pclk
> >>> +
> >>> +  assigned-clocks:
> >>> +    items:
> >>> +      - description: Phandle and clock specifier of IMX_SC_PM_CLK_PE=
R.
> >>> +      - description: Phandle and clock specifoer of
> IMX_SC_PM_CLK_MISC.
> >>> +      - description: Phandle and clock specifoer of
> >> IMX_SC_PM_CLK_MST_BUS.
> >>> +
> >>> +  assigned-clock-rates:
> >>> +    items:
> >>> +      - description: Must be 125 Mhz.
> >>> +      - description: Must be 12 Mhz.
> >>> +      - description: Must be 250 Mhz.
> >>
> >> I would argue that both properties above are not needed. If your
> >> hardware requires fixed frequencies, clock provider can fix them, can'=
t it?
> >
> > Clock provider don't know fixed value and turn on only used by client.
>=20
> So maybe fix the clock provider? Or this device driver? Requiring by
> binding specific frequencies for every board is a bit redundant.

It is not for every boards, it is common for a chip family.  Only a place t=
o set for
QM and QXP.=20

The similar case is network driver, which require a specific frequency at c=
lock assign.
Generally frequency is fixed,  clock source name may change at difference c=
hips.=20

>=20
> Best regards,
> Krzysztof

