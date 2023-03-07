Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9486AD7E8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 07:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjCGG7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 01:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjCGG7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 01:59:08 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on0616.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe02::616])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69B4457EA;
        Mon,  6 Mar 2023 22:58:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2vMe+2+P86UcE5qjV7g/OXOIlBKXnklhu+RyIsh5Cdnf7edZAiG45W9HG6fkgIgv45qlTPw1dB7/5ou6aLa9X6TCloxv5vRoxnhjXB+Y8Go0THcNWYpLn6xFuTLqk+mqz3iyB4fl5CYKWyedt/9MHI0GdY/+yDJBsQbiUphZ6DT/S8dXnZQPE8ArF50OJ5qYjlZ1v1+Hx8WeaZEPcat0kp4vVFmo21uBB2Uy0p2B9KZunfrvO603eu19wiLZDHKuFbr1aPe5oCIw9qR2MhnlXHoLmduVKgWGUlSCJqNLSgi+88CQDlXNNRRJRMWohkHxH7CguYUPu3bq1I6BV0p9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PEKTvT57IaUqU+7ZziTyQ2O57OYqcXjNZdBdQYHFT4c=;
 b=gC0vadS3BUrM6JX+v6dDY9iWlEgDyfJh1k/+BbUZlA89XEnXkzrSh5c7cClLojtJtV8C0VYn9SToRtBMziQ0WoeBtQ8n7B6+Ys61azhFF+MPnUDZKEwfgccR/UwK1l+yQ/e928kh/PHH+b4dhno0nmsb1n7QEkkcFs0nyLEaZeK3extR9aa5pne+rofoGQXZN/EwJ3QURm03H75ZsXpDe6wHgw8ftRamSmpMPNrAv0eFSKQ5nT30NhsVSWGqEz26u9viNVJ0qOewFHmhcPc22LqTbuq3+IYd/PFw0yRZ7l4em2KDRLr2kbmz6YDKzD175e1IS35arczLQfuiPNf5dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PEKTvT57IaUqU+7ZziTyQ2O57OYqcXjNZdBdQYHFT4c=;
 b=QN099/jNAhycy70mxdRZaEJVGtjyyMaKnu/xsISIaBXuHA2UHyidhYeP++msvSzmmNzR6m6Djl+lJgj92aVl/YOST8WDic/s4G2cwjeywlvqQE1lisN9jn46QOPnheCS7V/ZuB+/pyX09oVr/I50OQWzVZruUDCiJa7aZqxr2mI=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAWPR04MB9986.eurprd04.prod.outlook.com (2603:10a6:102:380::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 06:58:08 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%3]) with mapi id 15.20.6156.028; Tue, 7 Mar 2023
 06:58:08 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Gaurav Jain <gaurav.jain@nxp.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        Horia Geanta <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 6/9] dt-bindings: crypto: fsl-sec4-snvs: add fsl sec 5.x
 compatible
Thread-Topic: [PATCH 6/9] dt-bindings: crypto: fsl-sec4-snvs: add fsl sec 5.x
 compatible
Thread-Index: AQHZS+B5WTsB3C0yXU6n91MXqRivpK7u6bOAgAACWNA=
Date:   Tue, 7 Mar 2023 06:58:08 +0000
Message-ID: <DU0PR04MB941725532887782FA4596F3988B79@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230301015702.3388458-1-peng.fan@oss.nxp.com>
 <20230301015702.3388458-7-peng.fan@oss.nxp.com>
 <AM0PR04MB6004756C673A5141BA0529B6E7B79@AM0PR04MB6004.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB6004756C673A5141BA0529B6E7B79@AM0PR04MB6004.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PAWPR04MB9986:EE_
x-ms-office365-filtering-correlation-id: 459fb5d6-5291-43ab-c83d-08db1ed94ebc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9NqqVh1RoDZ+grXjh5W2jqAk1FgVbMl6oSZkVXxfXnbUINMXfTOG/osqZGtY0sEnCIrxo9zfeMywqs9sRTJ8rJVnxOZiWM8TlVSjGcWJ4bVj+/FxPFW9f2/8VR+3NbmJlTjs2qcpn6/vYAags9QGijcGBHXL1VnE7Mmwv1zCEWccNvOISf/8NrlIR9hCDoAjvnPsmMKDNJilD+sFOPV+3En9QjCMedKjO0zq+aXa59KRGSPYwmv4YgN0l+a/H/crFYNtrAfv57jRgezGmrDCGMYd28N5+PIlD7vu5n+cqK3iZ6eoTV6aPRa1fe5lH65ldZgWaudElWyyEsxuEoArOEmmlzmZoKopEMV6VSJLMYQvHHtQh6AZMqTTBzP8pS7kiAOaWGYxjPQRDLpLZ4i3RepwE3jlXb/JYcO4D0nNZikN4JGuY6ZfCQyp4OZ4e1afZNKn5TP06mehoJaTDhOyeN0R/8IpW6wcACmBPept/54uYbRioiZokZRDKoSfS0yJxwjLLmAXytNiQoX43hMsXQyYSrwCjDNFNEd76XxvRc/rjIwDM7cB2W8ppPAGkuYE2Q7HIacHlT5KvZMSjFna0XDTdMmOuBmHYzO2Rteh87HGTHu6SvPU9lKlqM4FsVzaGOLN6GeWMvUxS1qdg+JSic6Un1WYsO1TUN9aTaHoDDXnFzaqBnrAdnBnesBqxiv/qXpujSVxbjR5E3J1qxny8A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(396003)(346002)(366004)(136003)(451199018)(921005)(33656002)(66446008)(7416002)(41300700001)(66556008)(4326008)(8676002)(8936002)(64756008)(44832011)(76116006)(2906002)(5660300002)(66946007)(71200400001)(38070700005)(86362001)(122000001)(66476007)(38100700002)(7696005)(966005)(55016003)(316002)(110136005)(54906003)(478600001)(52536014)(83380400001)(6506007)(186003)(9686003)(53546011)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?28B3xnlB9JnWflFPpWPg7HuegM047J4FxiRL0o5FeTPgmwgdeVOV8uTfvjtw?=
 =?us-ascii?Q?coeGkP/w1UbrIsKNbFnIs1NlbSJqZrCw8GMtromHDBdbJfR20FPHGW9rQGkO?=
 =?us-ascii?Q?2utPMVCWrllvKXbEi4e/AfwD8IB2d5AiGhc/l6KoHdPJu00zOkrqAa929QSO?=
 =?us-ascii?Q?2yz2sf+t+owxxCZEK+36z86hhxaLdaXdfVZxohaqjIe9izwOcrUYrH31DU7b?=
 =?us-ascii?Q?qQMbi6EXf+q/0ORoJJu+7J8j5VRwpGpvQuZErAbMZX13e3OUiuH/nPcdUio/?=
 =?us-ascii?Q?WANqQUkM77kMANVcPviN+Zi+c4sbOrgalUCsRwHomkhDVh3aMz5Lq8cJCJ8i?=
 =?us-ascii?Q?tbgs1JZ3SjAfe8P+EP/Ewg/Nmh8e6rXnx1B2+UyW4/xP4byu6AprbtEbQdj3?=
 =?us-ascii?Q?qbxEInju/aF9LzIzoE420mw7aLD9VppEVzTzTR4Dz7s0Teg5OzjW1qPnG7ib?=
 =?us-ascii?Q?d5tK66BmAwWzNC6OZgJ7PtVHQBekVw9AQYyI7ZgEbFuQPeewEDyE+c+UzLRj?=
 =?us-ascii?Q?fReRFVO5of6HScpHbSVzVyITfXBFKee9SWggWcKJQG7N0PaSVO29jfQ7BLTa?=
 =?us-ascii?Q?TeAe2fqIeQLt4xdXF/p2jgmhUIEr7E4jBUFi6NYKBdsDmG6UUSgFgVY0x5li?=
 =?us-ascii?Q?ymoABF7xeNixhyaywhqH6ifDwXQ7S2paVe7SwjVHCSaaUz91q4eu/r1/qtK0?=
 =?us-ascii?Q?k1auxA6zgq5qEDML1pwSnmxMv/ye+TJv3eYXfOsqz0oggVPgTbsLEmMBY+Uz?=
 =?us-ascii?Q?sJKITUmJo9vBaOJrbrKsOl/h/PYxAQA18DvK16qHwM6gP512wl6A/hgc2XnH?=
 =?us-ascii?Q?2Nf2DtAikkEjD8YK2OFi0gmGru3CGTYEqUoAKMgpEt43h7bgGs7vkjudoWtW?=
 =?us-ascii?Q?IfDb1K+PIx30f9Y24bO0GPf7tRIJ3ArfmR5PBZZWU8EmYxfOAZxfTg5SSDcs?=
 =?us-ascii?Q?qjqAtzE2GIAc2EiQQW6gl169PKsONnbjBH58FxwDdHx/z3kGC4A15dtiesKP?=
 =?us-ascii?Q?RlbmkVguHJFNhiWFgCC1Uzx3YbjuV6H7rIFLG5CZMGGS9Irdhyq1jmKbaBw5?=
 =?us-ascii?Q?D68wyjno6OzuCQ2kudGenJE0rjDpXMew//gw3GD/q6WRBW8txCDP2zl/db4I?=
 =?us-ascii?Q?eCFeFzsluhRTOCKW4wakoa8gefLRJB2VZDdsG9lGPitvWCqYNEGKpDaW/n1T?=
 =?us-ascii?Q?hvFP52U1Bfk0jJGkYyoLUkmuA4kMbx8It32r2dBhrtn14yh5kwFymXbs/oJa?=
 =?us-ascii?Q?dk55++RqsS0u0LtRdwT0Sqbhw7r0kSx9aj0dZO1Qf0pMbP9TtjHD9O15jQOz?=
 =?us-ascii?Q?KZUCHLXUfWECss95zdvYbx0rhPO6SL+FAw3+iKUF83JTqNxaJBY/rRmQEiec?=
 =?us-ascii?Q?T3zuaUF03cfRj93F4vhFjJPGRoDxIurj81WbzgnO3IQwjS5zc05vxIxilxos?=
 =?us-ascii?Q?ye9/vA0lWPPeqrK2eeJnR2rZMwqh6PNIM7meysgTX10o4RklkGGr4QKa2dci?=
 =?us-ascii?Q?9eQuHhxmEc6Yhq/1zs5UY8fEfi3tZ1mRCKJo+d4kM030n2C/HHUYHvggxwlJ?=
 =?us-ascii?Q?h/7YixjSHZ7jCTdHP+c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 459fb5d6-5291-43ab-c83d-08db1ed94ebc
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 06:58:08.0163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Rw2d/ZCaMwSlmKuZtS8uHlHte7ltAwpZ/L/UN7ThTYoCGsKILmIingXv6q/67pxUwu4M53Hr9VOTPBE5IaOZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9986
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        T_SPF_PERMERROR,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: RE: [PATCH 6/9] dt-bindings: crypto: fsl-sec4-snvs: add fsl sec =
5.x
> compatible
>=20
>=20
>=20
> > -----Original Message-----
> > From: Peng Fan (OSS) <peng.fan@oss.nxp.com>
> > Sent: Wednesday, March 1, 2023 7:27 AM
> > To: herbert@gondor.apana.org.au; davem@davemloft.net;
> > robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org; Horia Geanta
> > <horia.geanta@nxp.com>; Pankaj Gupta <pankaj.gupta@nxp.com>;
> Gaurav
> > Jain <gaurav.jain@nxp.com>; shawnguo@kernel.org;
> > s.hauer@pengutronix.de
> > Cc: kernel@pengutronix.de; stefan@agner.ch;
> > linux-crypto@vger.kernel.org; devicetree@vger.kernel.org;
> > linux-kernel@vger.kernel.org; linux-arm- kernel@lists.infradead.org;
> > Peng Fan <peng.fan@nxp.com>
> > Subject: [PATCH 6/9] dt-bindings: crypto: fsl-sec4-snvs: add fsl sec
> > 5.x compatible
> >
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Add fsl sec 5.x compatible, which is used by layerscape SoCs.
> I can see sec-v5.2-mon, sec-v5.3-mon for Qoriq.

Please go with Rob's patch which is earlier than my patchset.

https://lore.kernel.org/lkml/d4c76900-1985-428b-4050-26fd4a0daaf8@oss.nxp.c=
om/T/

Thanks,
Peng.

>=20
> Regards
> Gaurav
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/crypto/fsl-sec4-snvs.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/crypto/fsl-sec4-snvs.yaml
> > b/Documentation/devicetree/bindings/crypto/fsl-sec4-snvs.yaml
> > index 6878ae8127ec..1a4b4975e1d9 100644
> > --- a/Documentation/devicetree/bindings/crypto/fsl-sec4-snvs.yaml
> > +++ b/Documentation/devicetree/bindings/crypto/fsl-sec4-snvs.yaml
> > @@ -24,6 +24,10 @@ maintainers:
> >  properties:
> >    compatible:
> >      oneOf:
> > +      - items:
> > +          - const: fsl,sec-v5.4-mon
> > +          - const: fsl,sec-v5.0-mon
> > +          - const: fsl,sec-v4.0-mon
> >        - items:
> >            - const: fsl,sec-v4.0-mon
> >            - const: syscon
> > --
> > 2.37.1

