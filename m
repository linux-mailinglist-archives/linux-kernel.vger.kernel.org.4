Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09BC874DCCB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 19:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjGJRxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 13:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232995AbjGJRxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 13:53:01 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2072.outbound.protection.outlook.com [40.107.249.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA24BD2;
        Mon, 10 Jul 2023 10:52:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PHtCumKdu50CiqYqvgBDQ4m6CFfgpN34QuFjVpBL/1qCih7IyjGx8+Ydf4v1bGDwumC2FWGkw80dtbd01n5FC9GN3ulayKgHsfHDYzaua94zPtsZwuk+bwoWUF+PyBo5LO2Np4EAx5knj8vUIdXBoBXqIutUAJP5g0HlUxz9BjEsPP0s9Vyq+awOQWx9qNu7E6Z+DKQq/ISjW6UqkRazCnGFRm5wnT9EvxJzNQkBnSz1j9sY4r8PrHQqgkzJeQtd4Ze2/sbxA+V+Fz84ww5BlHSmQzpjcZjdAaEQ6Qgj6ScOcvNRiD/B6u8fymmuYYqdWJBuJMIkZKnWCirKo74K6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWPxwfz2+IcRnl129NoZsRHTdUftfQOR2+pY1de/SD4=;
 b=LtAFQUwGMFuRPUPN4OWnjv0rc2vosAaM0K7VWGxPIU7OkXG3sPjdpZMm7bGqkAuC+1tf+mqYYIB7r+GNeRXBIWw0W0tnrk/ezg5FkVlTI16W6ZqOzmnpzXT5yhESQ0kCvB4GBPxx6NApepNRPpMjz0vILzPdL5AWi3Y3rZhteFG7y7vU+7fFNio546JRDJNz77sV8CUORMZNle13o4P6cDkKfKqdxcWtjBZlDDzBbLSdx/K0UEeBe6w7rW8hfuAmfllKwMPjgT4P7zySj49gWyKr8DEt87GhY5D4zR5TPhDR8e10Uvo1L1BTD0RFAByTUSwJrk8IG9qzDs6gTW2c5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWPxwfz2+IcRnl129NoZsRHTdUftfQOR2+pY1de/SD4=;
 b=oJQlZayaudYZB9gLcsKATXDsV569+TArWsxYmfxfZg1/rikK+scasGr0xSsP01CZ5LJN+5dzNnMJw4VFAIzXrpBBtpMSW3qeHmBTmhi9H5NzGgqzNjQhGatL727ZTt5c/nOWpKoFzaLOW9UdZEPblDoQnoFPMHP0rBjIxPhCc7Q=
Received: from PAXPR04MB8638.eurprd04.prod.outlook.com (2603:10a6:102:21d::14)
 by AM9PR04MB8338.eurprd04.prod.outlook.com (2603:10a6:20b:3ec::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Mon, 10 Jul
 2023 17:52:56 +0000
Received: from PAXPR04MB8638.eurprd04.prod.outlook.com
 ([fe80::7650:27db:4ae:b7ec]) by PAXPR04MB8638.eurprd04.prod.outlook.com
 ([fe80::7650:27db:4ae:b7ec%3]) with mapi id 15.20.6544.024; Mon, 10 Jul 2023
 17:52:56 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: RE: [EXT] Re: [PATCH v3 1/7] dt-bindings: arm: fsl: add mu binding
 doc
Thread-Topic: [EXT] Re: [PATCH v3 1/7] dt-bindings: arm: fsl: add mu binding
 doc
Thread-Index: AQHZoFASKHuzjH0W/kSFBShO5sZzaK+NajCAgBWOmxA=
Date:   Mon, 10 Jul 2023 17:52:56 +0000
Message-ID: <PAXPR04MB8638D1504946559095E1CAB69530A@PAXPR04MB8638.eurprd04.prod.outlook.com>
References: <20230616181144.646500-1-pankaj.gupta@nxp.com>
 <20230616181144.646500-2-pankaj.gupta@nxp.com>
 <a06dbb80-c9b2-3a57-cbc5-b18432b4029a@linaro.org>
In-Reply-To: <a06dbb80-c9b2-3a57-cbc5-b18432b4029a@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8638:EE_|AM9PR04MB8338:EE_
x-ms-office365-filtering-correlation-id: 57bb5f73-383a-4273-e875-08db816e7e40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jR+ja8DEThlTy31t9Li6/J6JZq6g7GAl3NRYfg0NRfbY0dfRlAS1C6owKJsxhFWkhvYLOMccSOSVrPZQFj+8/8B3pdGHLTQ/wirX/aaFfksdTie5BWv0reEOv6gMWyNcS64bu087iHmJdxBDdeTyTiESswCveAk4FV0yxgj7+NyARINXK0LxmjnX2pqalGkM1tXlfOYigM5VMDOGzCDFelyjBhu1CHGQkN8mltUgfYkbwPGR2Z80uuMnHLauOVZ6Rn6ZC7KZjmTe8/Dkw5PBCMf09NBOUEDcwXMmhsLbh+lxVgNLU3O+qgPdqaQoVpQEu8URwoaEuFAzz2vgiLmlRAxzlUZaCd3ZIaklCXRIRq0iPXTSqUh4HixJNxD19GRDBg/iZj3A5gMzC5AV5qEge0GuMpcrp4B2clu2i5C+W0IbWxTEbaOD2GmVGpoycJsi8NqvDw3dEm7Nbh4nRtIAiLV6/oKvK7HAXKmeO+ijBBzsFNlnc6l2AqfN75rrrbEc+a9O27tb3QDugT3JGfI7/and8rOo8m/EWaSEfbRuI+i6LLmftIXPUkIPm0JyUJX7LnQhuGy4SSxvEdSlKiBvtuxFgieB/ZxO4KMIwOVDKXIkS+tJMWtUw13GyCQ0Z0AEiQcmkN9cETOoOy2XTpzlDQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(366004)(376002)(451199021)(38070700005)(33656002)(86362001)(55016003)(38100700002)(921005)(122000001)(478600001)(110136005)(71200400001)(45080400002)(7696005)(966005)(8676002)(8936002)(44832011)(5660300002)(7416002)(52536014)(2906002)(316002)(6636002)(66946007)(66556008)(66476007)(66446008)(64756008)(76116006)(41300700001)(26005)(55236004)(6506007)(53546011)(9686003)(186003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U1602IoVXoKF5iGcXTqbPwkNaD+WPfLO/HQ4xr70dGg/HGfJ/Ob2uxjpDl6J?=
 =?us-ascii?Q?J87Yv+Z4UkbgcBI/Ts51M7+AEoxZ7SiVP07dYridFUI/1CEijNKjCwwPYpAl?=
 =?us-ascii?Q?5fMk9KHWeDJ/bqA+JUjp+/yXbOpGYsFWGg4Rs60dylYx+maB96SVArCxPM56?=
 =?us-ascii?Q?EhPAEdhAzAkEXr1PHM15UcdONf5V7D0gE9H5B7hi4H13ZQT23olrMpBprf0q?=
 =?us-ascii?Q?NvVcEEICLSYrzGhODMbaMZA9KAENF6ndZH5VndTlHtfYurWkE4dABbu2sqpA?=
 =?us-ascii?Q?3vRifhr3/iXw7P/ncqjxz4tn41eeEciEBjj6s63FgzM+qYMrWPryjM1GUE4r?=
 =?us-ascii?Q?uHbko4wgc47z1zat7ZHTc7HinyW50+918w0c35Ifbw1Gh/CArr2VjPPIRFV0?=
 =?us-ascii?Q?VJ0dok2kKDuKixxeASIc9FlbsOt80wmvJ45NIirn5P6DCl1GQfadOltYY1Nz?=
 =?us-ascii?Q?oVXElJ0yZPZlKwpFIihV+N0Ma2oHatqpigrZSUyFutMyhyoazGICbL2TCJ8F?=
 =?us-ascii?Q?SzXUADthKuKCdeEzomBt84MeUf8SF7Dms2QdijLS/uL+FWlNXStlGvCit+jo?=
 =?us-ascii?Q?1ZXOE7s/dF+6SpUBq5ohA1vtIzNcVggc1KGHB31kmi76pC/V0nTYRe7RSBXM?=
 =?us-ascii?Q?/FuVRgNEc3IQNf5ahOEpN7IQd7liI7wIIfqrfrdIKMTjnJwg4cBhBv//eWCf?=
 =?us-ascii?Q?dQwsj1dVwlan47FVVU6TvvwPM2StnEtY+eTxNb3enYfeoIhkZWsuBoXWwgmC?=
 =?us-ascii?Q?kQGo/XTlxpxoST/h72EvOMz2NzVhkuE1nXI7uIpNhQiZVs8MJ72/oNsr/TYU?=
 =?us-ascii?Q?COH7ebozsHR5vxPw7r6r4cBQwKx8nWoEeGbHizMDzIgkkNZnctQF0pHDWnhM?=
 =?us-ascii?Q?MMgU0KTPa3/D5OUoBfQ5OFEZaerAOVJTyycDUcOzlKYowqDmabMkWbmRnsYb?=
 =?us-ascii?Q?zLMM0C+yQz8RDVdFBW+bkdzvHZavJZozo4/iplubiRz4+TNu0UKOcMNDnYsC?=
 =?us-ascii?Q?tPviaCbOaGBMjUy2poElX+7mfgf7ru1F+EZyMCUlF1ginhPnzUOC8BV9uSd3?=
 =?us-ascii?Q?EJ7jxEMuQ2v//CwzZGLOAkSZAUSRz1crQSjbb7m25hkXuHHtgmu1qUAooYmA?=
 =?us-ascii?Q?1HsB5wqjH3GyomDAkh9mR8z/dzpqbK5kU5nJV5Pfj17nB4+twCxhoyN4KQ0T?=
 =?us-ascii?Q?0ZDTdi56RfpkwA/ZiPzVcyCU579tb0lpU/xASlur/QJ+mX6GJLCvbOB35adA?=
 =?us-ascii?Q?an+4yAFlQj/Tj4FfFiMftcftFpHdMC/cIFzUC18YW9i5BC/RhOO9VdvfQFew?=
 =?us-ascii?Q?lDl6pYQk/pVN/vf9izPsgRVK/81kMxT5evTekUx3b+Rr6PV3UxkznSpA2BVA?=
 =?us-ascii?Q?FTBQDG2SU5EmgCPbKO3PTyWHiWQKFATwq1mUMFnidajxj6fWnXzs2PYEuK2h?=
 =?us-ascii?Q?FVFOZ/K2DhP/FfbPiPOs8AU4INrwRBH6j1FwFvedE18Cz1gsFbTeubCBPFQj?=
 =?us-ascii?Q?WMuEcLO7B+tlDK7jZX6/O6ANcg91btqUeMLslDepg/vzHdGYj4emkicfeH8h?=
 =?us-ascii?Q?i6TduSt5HxEu/nTUu5T+8l5KC4WPcM+VP8vYRopy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57bb5f73-383a-4273-e875-08db816e7e40
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 17:52:56.7065
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TUxHxi0pz+aYfvm1zXL5FNSC8kEwxsjnm1a3yWaqYQMBT2Lj8EJcwCY1uSnpilMzZn3IDjLXdugcQ16Q0LCmJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8338
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Friday, June 16, 2023 6:51 PM
> To: Pankaj Gupta <pankaj.gupta@nxp.com>; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org;
> shawnguo@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de;
> festevam@gmail.com; dl-linux-imx <linux-imx@nxp.com>;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Gaurav
> Jain <gaurav.jain@nxp.com>; linux-kernel@vger.kernel.org; Daniel Baluta
> <daniel.baluta@nxp.com>
> Subject: [EXT] Re: [PATCH v3 1/7] dt-bindings: arm: fsl: add mu binding d=
oc
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On 16/06/2023 20:11, Pankaj Gupta wrote:
> > The NXP i.MX Message Unit enables two processing elements to
> > communicate & co-ordinate with each other. This driver is used to
> > communicate between Application Core and NXP HSM IPs like NXP
> EdgeLock
> > Enclave etc.
> > It exists on some i.MX processors. e.g. i.MX8ULP, i.MX93 etc.
> >
> > Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
>=20
> I don't see reply to Daniel's concerns.
>=20
> I don't see improvements here based on the previous review you received.
> It seems you just ignored everything, right?
Replied to Daniel's concern.

>=20
> Limited review follows up because binding is not in the shape for upstrea=
m.
> Do some internal reviews prior sending it.
Done the internal review.

>=20
> > ---
> >  .../bindings/arm/freescale/fsl,ele_mu.yaml    | 144 ++++++++++++++++++
> >  1 file changed, 144 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/arm/freescale/fsl,ele_mu.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/arm/freescale/fsl,ele_mu.yaml
> > b/Documentation/devicetree/bindings/arm/freescale/fsl,ele_mu.yaml
> > new file mode 100644
> > index 000000000000..29e309a88899
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,ele_mu.yaml
>=20
> No underscores, filename based on compatibles.

Accepted. Will correct in V4.

>=20
> > @@ -0,0 +1,144 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> >
> +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevi
> >
> +cetree.org%2Fschemas%2Farm%2Ffreescale%2Ffsl%2Cele_mu.yaml%23&d
> ata=3D05
> >
> +%7C01%7Cpankaj.gupta%40nxp.com%7C72b9e18a32a342bcf68c08db6e6c
> 8d5a%7C6
> >
> +86ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638225184750511073
> %7CUnknow
> >
> +n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1h
> aWwiL
> >
> +CJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3D5quVB0LAMCdjYghThl6PSI3
> CJPfuGtVoW
> > +AtN1gr4xm0%3D&reserved=3D0
> > +$schema:
> >
> +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevi
> > +cetree.org%2Fmeta-
> schemas%2Fcore.yaml%23&data=3D05%7C01%7Cpankaj.gupta%
> >
> +40nxp.com%7C72b9e18a32a342bcf68c08db6e6c8d5a%7C686ea1d3bc2b4c
> 6fa92cd9
> >
> +9c5c301635%7C0%7C0%7C638225184750511073%7CUnknown%7CTWFpb
> GZsb3d8eyJWI
> >
> +joiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
> C3000%
> >
> +7C%7C%7C&sdata=3DGyUGJThMnxLNEQX1guW9Q%2BdoVjMrvn%2FSupgJ7tu
> fkXk%3D&res
> > +erved=3D0
> > +
> > +title: NXP i.MX EdgeLock Enclave MUAP driver
>=20
> Drop driver.

Accepted. Will correct in V4.

>=20
> > +
> > +maintainers:
> > +  - Pankaj Gupta <pankaj.gupta@nxp.com>
> > +
> > +description: |
> > +
> > +  NXP i.MX EdgeLock Enclave Message Unit Driver.
> > +  The Messaging Unit module enables two processing elements within
> > + the SoC to  communicate and coordinate by passing messages (e.g.,
> > + data, status and control)  through its interfaces.
> > +
> > +  The NXP i.MX EdgeLock Enclave Message Unit (ELE-MUAP) is
> > + specifically targeted  for use between application core and
> > + Edgelocke Enclave. It allows to send  messages to the EL Enclave usin=
g a
> shared mailbox.
> > +
> > +  The messages must follow the protocol defined.
> > +
> > +                                     Non-Secure           +   Secure
> > +                                                          |
> > +                                                          |
> > +                   +---------+      +-------------+       |
> > +                   | ele_mu.c+<---->+imx-mailbox.c|       |
> > +                   |         |      |  mailbox.c  +<-->+------+    +--=
----+
> > +                   +---+-----+      +-------------+    | MU X +<-->+ E=
LE |
> > +                       |                               +------+    +--=
----+
> > +                       +----------------+                 |
> > +                       |                |                 |
> > +                       v                v                 |
> > +                   logical           logical              |
> > +                   receiver          waiter               |
> > +                      +                 +                 |
> > +                      |                 |                 |
> > +                      |                 |                 |
> > +                      |            +----+------+          |
> > +                      |            |           |          |
> > +                      |            |           |          |
> > +               device_ctx     device_ctx     device_ctx   |
> > +                                                          |
> > +                 User 0        User 1       User Y        |
> > +                 +------+      +------+     +------+      |
> > +                 |misc.c|      |misc.c|     |misc.c|      |
> > +  kernel space   +------+      +------+     +------+      |
> > +                                                          |
> > +  +------------------------------------------------------ |
> > +                     |             |           |          |
> > +  userspace     /dev/ele_muXch0    |           |          |
> > +                           /dev/ele_muXch1     |          |
> > +                                         /dev/ele_muXchY  |
> > +                                                          |
> > +
> > +  When a user sends a command to the ELE, it registers its device_ctx
> > + as  waiter of a response from ELE.
> > +
> > +  A user can be registered as receiver of command from the ELE.
> > +  Create char devices in /dev as channels of the form /dev/ele_muXchY
> > + with X  the id of the driver and Y for each users. It allows to send
> > + and receive  messages to the NXP EdgeLock Enclave IP on NXP SoC,
> > + where current possible  value, i.e., supported SoC(s) are imx8ulp, im=
x93.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - fsl,imx-ele
> > +      - fsl,imx93-ele
> > +
> > +  mboxes:
> > +    description:
> > +      A list of phandles of TX MU channels followed by a list of phand=
les of
> > +      RX MU channels. The number of expected tx and rx channels is 1 T=
X,
> and
> > +      1 RX channels. All MU channels must be within the same MU instan=
ce.
> > +      Cross instances are not allowed. The MU instance to be used is
> S4MUAP
> > +      for imx8ulp & imx93. Users need to ensure that used MU instance =
does
> not
> > +      conflict with other execution environments.
> > +    items:
> > +      - description: TX0 MU channel
> > +      - description: RX0 MU channel
> > +
> > +  mbox-names:
> > +    items:
> > +      - const: tx
> > +      - const: rx
> > +
> > +  fsl,ele_mu_did:
>=20
> No underscores. Drop all properties not related to hardware.
Accepted. Will correct in V4.

>=20
>=20
> > +    description:
> > +      Owner of message-unit, is identified via Domain ID or did.
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > +      - enum: [0, 1, 2, 3, 4, 5, 6, 7]
>=20
> That's not the syntax you can find. Open example-schema and rewrite your
> bindings.
Accepted. Will correct in V4.

Change it to:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Owner of message-unit, is identified via Domain ID or did.

>=20
>=20
> > +
> > +examples:
> > +  - |
> > +    ele_mu: ele_mu {
>=20
> Node names should be generic. See also explanation and list of examples i=
n
> DT specification:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fdevic
> etree-specification.readthedocs.io%2Fen%2Flatest%2Fchapter2-devicetree-
> basics.html%23generic-names-
> recommendation&data=3D05%7C01%7Cpankaj.gupta%40nxp.com%7C72b9e1
> 8a32a342bcf68c08db6e6c8d5a%7C686ea1d3bc2b4c6fa92cd99c5c301635%7
> C0%7C0%7C638225184750511073%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi
> MC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C30
> 00%7C%7C%7C&sdata=3Dwvrm2b84xq6KYEIEEGm9%2BCAHaDsXOfKlLvamsjh3
> jTg%3D&reserved=3D0
> =09
Accepted. Will correct in V4.
Will use the generic name "se-fw" for "secure-enclave firmware", instead of=
 "ele-mu"

> > +      compatible =3D "fsl,imx93-ele";
> > +      mbox-names =3D "tx", "rx";
> > +      mboxes =3D <&s4muap 2 0
> > +                &s4muap 3 0>;
> > +      fsl,ele_mu_id =3D <1>;
Used generic name and changed from "ele_mu_id" to "mu-id"

> > +      fsl,ele_max_users =3D <4>;
> > +      fsl,cmd_tag =3D /bits/ 8 <0x17>;
> > +      fsl,rsp_tag =3D /bits/ 8 <0xe1>;
Removed the above 3 non-hw defined bindings.

> > +    };
>=20
> Best regards,
> Krzysztof

