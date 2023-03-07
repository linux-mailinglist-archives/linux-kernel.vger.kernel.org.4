Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232096AD79D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 07:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjCGGrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 01:47:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCGGrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 01:47:53 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2051.outbound.protection.outlook.com [40.107.21.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A022410BF;
        Mon,  6 Mar 2023 22:47:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HTDrTqBLhU8Mgiv7//BuXU6OTmkXRk/Z25xO6RxcBOQ1R9IfMplCRysOFhNZ2tgRMthPt1RjOa+K+5yliR9dJUUjqZK6lIgXRWgoFzO3eKx/jdSPP+jP1oM3+ibpsNJOaGdbClxA1cSzpvy/bPuWGoOHYXVeJtmC4DuhPIxTgidylBAEq+qUiy/njDavZOBWz0WNVbYMDr6YC/ZYqmBuQvtqHT5wikWmLRtrxlKKYWiGHH9OyOcAsVamLBUshM0Se+tKkVvpLqpfJd9X/ifk0Kif7/WSJ82uwI04h43upWMp3nMJP3xHL/S2cepFslCOl0DQl7dZP8+FgxEVi/0lAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FqYAeHDK5sRPaQ2XGAdQkGDM2mco4Zz/b/NFioZYEzQ=;
 b=d7+5Dq4/GnubPtWTg5CAK9/DZOaNoY2tyt4D4AQyvYcuJF40SkMndwIZYpywArPGmlFQY7G1I2vnzBq6af3uy7cqZKTI82zoziS0x7KqULpq9zjrr8QpLkoVJO95Qpnpe9O3QxXX//qG+yyF8pd5duXosEwt8NW9dEcF0yH0CVY0dfsJGuuFvwsy0VbhN/4L/MaVq4AfavQvKAzTOndcxziLRyfgMwxLyESMR/HpC41MIENjCYVDqxtpmZ6IkQYoYP7Adq84JOdf5dgYcglFY0hw7ndBfHp9dl3u66y/eKy7lXoQprH3xJMTAdS/5KT5da+fJbl7vYR6OcLrANe53w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqYAeHDK5sRPaQ2XGAdQkGDM2mco4Zz/b/NFioZYEzQ=;
 b=M/qHXqcNKEpVJnBRqGh668M6D3Fr0wGg3WwxttXqBFx/cOBaf7J3d5gT3frvSfn/3ZuFdrW6m+MdAz+UXOU4O7jGrJHefyQBSBi5IHIGXsyfJFQKBqTjrNpJ1/2FrfLIu8518BloiDk4ojX1zbd5wc3+PCS/iYCEpyAUXVCqCpg=
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com (2603:10a6:208:11a::11)
 by PAXPR04MB8592.eurprd04.prod.outlook.com (2603:10a6:102:21b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 06:47:48 +0000
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::c2c7:5798:7033:5f87]) by AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::c2c7:5798:7033:5f87%7]) with mapi id 15.20.6156.028; Tue, 7 Mar 2023
 06:47:47 +0000
From:   Gaurav Jain <gaurav.jain@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
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
        <linux-arm-kernel@lists.infradead.org>, Peng Fan <peng.fan@nxp.com>
Subject: RE: [PATCH 6/9] dt-bindings: crypto: fsl-sec4-snvs: add fsl sec 5.x
 compatible
Thread-Topic: [PATCH 6/9] dt-bindings: crypto: fsl-sec4-snvs: add fsl sec 5.x
 compatible
Thread-Index: AQHZS+B6izhEfVoXwkOn0bxXLVGs7q7u6TDw
Date:   Tue, 7 Mar 2023 06:47:47 +0000
Message-ID: <AM0PR04MB6004756C673A5141BA0529B6E7B79@AM0PR04MB6004.eurprd04.prod.outlook.com>
References: <20230301015702.3388458-1-peng.fan@oss.nxp.com>
 <20230301015702.3388458-7-peng.fan@oss.nxp.com>
In-Reply-To: <20230301015702.3388458-7-peng.fan@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB6004:EE_|PAXPR04MB8592:EE_
x-ms-office365-filtering-correlation-id: 60188d95-86be-4310-1583-08db1ed7dd1a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ICc+yJ3+/6honRe9YT3X1JVsWtcO7K1wS0xgreMcHtqvTCvjxGLSXlYGLVMoFzKWVPHx7l8DJIF7dLIQrbI1f066jOBoNs3myiwhNRA7bC4UcpZad3fLx3fADTRpHJbZ8zFUt6FyMt0wTgydqaz9Znji4GOloJxzVzd9KOqpp463KhoOZhQ+9KvjLwFHkLcbQGglWcIzoM/eDXRAYqfzqrVmTogQEQrTXGCDFSa3BDjEMnyzNYGlY1vOBJtoRmR31V7B1FWq5CNrlpKge4zEHidm9gBA0CYm3g17V5DKPTK3Tz3DoOBa22knvkjXI9LWjtDXgbC6jNqsPEbFgIF0emlz5tOZpKVaQfJS8lkxDxjjP3DjxOCj6TH1pYiDv0Ws4wmYbD7PuCFsA/ndtbR94mB74q4v1qY4s4b61HKOjWZXqPQIdtIYceFcelQpyzcVOMbAw1/WHrOCj7FRVS5+h+sWJHJbzfvv/udzJFMdY1OFXzb3/PFptU/uytwBHwkpXDQhNOrjQkmKll9WqlDbfVBh3fbb+Y1I7CykmYxmjKUmwFazz9XxCa2uqcexuEN7nch68DA29aOa3v5ywY6LdbRgv0KmuKE/UIz13No0Whgnje+vohNxMKkMnilNXBdeuslfik10AymI2IXRO+AO+BfFHzr8+EFTrW2Q1PJ8Wuzd3oP4vtJltb2mc+oFOEVCOL2pHwJiu1Dv0NXq6FZWAg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6004.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(451199018)(2906002)(38100700002)(52536014)(122000001)(9686003)(186003)(26005)(6506007)(53546011)(55236004)(44832011)(38070700005)(66946007)(64756008)(76116006)(66446008)(66476007)(66556008)(478600001)(8936002)(5660300002)(7416002)(41300700001)(7696005)(71200400001)(55016003)(110136005)(316002)(54906003)(4326008)(8676002)(33656002)(83380400001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UtutDizrqpTW4dIy87RYCO1zPAsN3LwGGiOAKfSC65aBJWCPAd1IdBXVoyml?=
 =?us-ascii?Q?+ry5hE4+hnDOhsvQQqVokRChCjX9f8GKycgUPgP7L+CSJuAbr0y5v35Np020?=
 =?us-ascii?Q?nhEqpJPbgNVQuKHuPN+7rVWgX3pD1PnyeYtFvsCznBbQ8lRlDl+besCA5GZS?=
 =?us-ascii?Q?9h+wcMxloX7qruO5VMLEXPKbp/WAqlsnOxk+djpq52Z96a11XUkrB8JFWyAY?=
 =?us-ascii?Q?08YvOLocPu6H3DgDrB8gwGgykzjxqK+lCp6txL+E9OqZy+biV8gYUkJjldsa?=
 =?us-ascii?Q?e0t4OWQTmWleiFhVaoIBpt7HsAmOoSQEAPNCV6+pC6VTEfeWFhVv4DdK+24h?=
 =?us-ascii?Q?HLRnjN2c+xW6P3X9q9IKTXys4NgaX1gdLzpC4lvAeL++hhcCBrx+ft2Llo1v?=
 =?us-ascii?Q?xWx3Q3QFAMDhYD8dZlzSyv5nxOdKF7akduZTjgo6V2UD8Fb8JOx2n7P3aIfi?=
 =?us-ascii?Q?NR6ZRzqmP5ZnDZjsPFKNbi76d28zEQ9G4UzMg6zoctdD4kjIgAUkLPhwcDTs?=
 =?us-ascii?Q?IykRTeQvryzq/dJ+eMlVV3gltwVCzY242BD+fKVdwUgbT1F2ZfleTuJ6vBWF?=
 =?us-ascii?Q?H3DvaDRQOPTJEU7YjJaOrRHFxJxZAl4RdDq9KoHYem6PWULrx15sQKZJnjIt?=
 =?us-ascii?Q?e4Uo+cZ0agyRiakun4QRDOHGzY1BZrSSHPUeh9jJWLDHeslums9a5EtrZwkB?=
 =?us-ascii?Q?qhpz1pYEGpxFWBHpY8VjHJWr7/yHkou+92vO/elsmonAib9ro4ED6m6PoFjS?=
 =?us-ascii?Q?7Nf/j4sKCttzSIy46iSSSdt8MDqs55bshiSFT+On2/ESXhFBXJumGs0d6EAc?=
 =?us-ascii?Q?8h26u+qONUklfdsf09QLG2ihUgjuxAzRW2NCByMOKoD9G0RNF9LdLzySNgiW?=
 =?us-ascii?Q?kK4CWvOWbuCRyRooNjH0Qbh5fdR8bZEA3+pyrpR/EBi3cuM22eUVDPUoIAd3?=
 =?us-ascii?Q?eDGFa44xsPWgApi+jEJVD6LHuFDrxiNsE2P3Ze94qyCGP05IGXM+qnHA6JOG?=
 =?us-ascii?Q?/O3dqDh7iVQ+7agnHK75rIhSS+N2PVz+/lPDhAcPeOYOThp7iQUA1qayCSll?=
 =?us-ascii?Q?YBoSjD0VD1J4oypRMeYTVH/+Sf6kslTygnoUwVuTQjhZ9mDL5sZ2ZsQcHcJa?=
 =?us-ascii?Q?1df6EM+B9kWEWVg8aSTmvYAPXs97P1t1ccucy2QMTayQB7PQfYbBO0pvOyT+?=
 =?us-ascii?Q?dyZt4exK3dDvFDYrYz8/1++xTYSOOQvpZ1M9VopuifEiBD61wjbxZwrk7TqP?=
 =?us-ascii?Q?q8wqNWnUlk8NKQQugou83Q9QJ2ro5aNYa+gWz/0SB/czSE6hOJvgFj0pM/k+?=
 =?us-ascii?Q?cC5Bl9VUIuYJfmdoNhXJkcOMmrUlAPAVd5p8VnVw/0T3RZll0gGz73MCH5kR?=
 =?us-ascii?Q?nJNREJ0J7gaqSrYB/+tLdPTCU+/0k3l4LW5kzEjPXp80kSfREghIyJIuOqoZ?=
 =?us-ascii?Q?izAFpmPqPXqaU7btr3Rpm+bosvOBtRvxeX/sJz8FkAslJEKf+eXMK7id5FUG?=
 =?us-ascii?Q?xwMYF+BpQ0s4Y2vaGp3gpQuWip5FzXZSHGeBIPDAQlfKBsJvtB8wMrgc6EYA?=
 =?us-ascii?Q?Uz4xeX5uUPX1wd6x+X927x0kqbb9EU4MzQ3X/4L0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6004.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60188d95-86be-4310-1583-08db1ed7dd1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 06:47:47.9177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eN8MkPdbRT5qGgMXDRWntHMzOBy9JIRwKsw7kvH3G0vEFAZF+pdwlKQWWkFOmsO3wQcqXFYHVgkjsvMGi4McBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8592
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Peng Fan (OSS) <peng.fan@oss.nxp.com>
> Sent: Wednesday, March 1, 2023 7:27 AM
> To: herbert@gondor.apana.org.au; davem@davemloft.net;
> robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org; Horia Geanta
> <horia.geanta@nxp.com>; Pankaj Gupta <pankaj.gupta@nxp.com>; Gaurav Jain
> <gaurav.jain@nxp.com>; shawnguo@kernel.org; s.hauer@pengutronix.de
> Cc: kernel@pengutronix.de; stefan@agner.ch; linux-crypto@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; Peng Fan <peng.fan@nxp.com>
> Subject: [PATCH 6/9] dt-bindings: crypto: fsl-sec4-snvs: add fsl sec 5.x
> compatible
>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Add fsl sec 5.x compatible, which is used by layerscape SoCs.
I can see sec-v5.2-mon, sec-v5.3-mon for Qoriq.

Regards
Gaurav
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/crypto/fsl-sec4-snvs.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/crypto/fsl-sec4-snvs.yaml
> b/Documentation/devicetree/bindings/crypto/fsl-sec4-snvs.yaml
> index 6878ae8127ec..1a4b4975e1d9 100644
> --- a/Documentation/devicetree/bindings/crypto/fsl-sec4-snvs.yaml
> +++ b/Documentation/devicetree/bindings/crypto/fsl-sec4-snvs.yaml
> @@ -24,6 +24,10 @@ maintainers:
>  properties:
>    compatible:
>      oneOf:
> +      - items:
> +          - const: fsl,sec-v5.4-mon
> +          - const: fsl,sec-v5.0-mon
> +          - const: fsl,sec-v4.0-mon
>        - items:
>            - const: fsl,sec-v4.0-mon
>            - const: syscon
> --
> 2.37.1

