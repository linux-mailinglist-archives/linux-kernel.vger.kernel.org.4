Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8B26A15F3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 05:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjBXEhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 23:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjBXEhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 23:37:33 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2042.outbound.protection.outlook.com [40.107.20.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EDF5EEC1;
        Thu, 23 Feb 2023 20:37:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XIwqCtaXQc0ov/jjVUREKDChcqfiV5pUJLJT3BNreUtCK6urYpT/BjJP/n1o+vdjNUg+n+tLMU2J4ha9IvDf5l/y9NE7CUi9w4oXXT56ob3QGuJkkI4XTYT53kjuJlooYwjVDPDymXz0Fzkc3oKnkgOBFf7ECmlhzl4XhTubRzD4T3anVAgiLXa52SI3pG4MiMJDORcD4zGGHpCK9+7ohCZ3LuU3APatC+V3SQ6lyjy/Wlk0/4XGGJgUZuGzQ6cPKxtDHFG4jZYWS3nL7LYv0a9YDvyKyNuPjL7GK/vyMetkvmhSi0hW4rvPZie5DWs9Q/YcY7OoTkNJndSsMppDyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=to4F1kMN8HlN6amhHnRFTUgsZ/2MDG3KMUG3nFKjVlg=;
 b=KrDG1qEFQiO3MqSn2IWKfzvYPaDAc/yP+i07tTldxFXh10T0g/ex+rBLc0pxxuPpIxoQelX/ho2USBp+VPW7nXjnq3w9sEXkuqNEEY2RGUSEigJUEF0MihRNhVIHvIL6F62CpV/yqUyhdnZytZNdh1sUkWzUgL+oP2gwIjZIfBQFo9Ov45hdt5R5gdJVY2jQF+sxHhbuNXzDPhpbTRiOaqWfkC0ZpmHempPpRirVdrNRLC1yZ78g9zMQXLbJzMU3YiCC0yJxFs1TM2dLL4MYbwh9bWW89U2gpqYflBNhuKbZVRSPX4UjC0kXhttrVOR58Dcjpa8G55HlCXroZtUvvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=to4F1kMN8HlN6amhHnRFTUgsZ/2MDG3KMUG3nFKjVlg=;
 b=dtH5BVPlhkWvbG+hgt8KTgNtiwYXdPq5WqmaV1MsHzMltDHl8arVDDs8lJtD0X11ZyBG1oAxZupXQZ+fh3sDm/DrGmqYPa6mCMXwMA93vNJAXpG+EvkUMhyVbI6SQSiGr/cghnQA3E6wXWjbC7p0pz7C2AifRDMiWWhniG9rMlw=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8162.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Fri, 24 Feb
 2023 04:37:28 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%3]) with mapi id 15.20.6134.021; Fri, 24 Feb 2023
 04:37:28 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "balbi@kernel.org" <balbi@kernel.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jun Li <jun.li@nxp.com>
Subject: RE: [PATCH V2] dt-bindings: usb: snps,dwc3: support i.MX8MQ
Thread-Topic: [PATCH V2] dt-bindings: usb: snps,dwc3: support i.MX8MQ
Thread-Index: AQHZN3EBIMdG65+qaUS6uw5+ONteWa7dpF7g
Date:   Fri, 24 Feb 2023 04:37:28 +0000
Message-ID: <DU0PR04MB9417FCEB7D14C5914D80EBCE88A89@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230203014526.1461386-1-peng.fan@oss.nxp.com>
In-Reply-To: <20230203014526.1461386-1-peng.fan@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM9PR04MB8162:EE_
x-ms-office365-filtering-correlation-id: 0f085442-656c-4cb2-1681-08db1620d5e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aOBL7ovTMEM6S7V8kPlyKid/0ul4nUPZKYPZ68qIQS59j4QqiQq180oyO4R2Ozc1OnSHLplgKhmuGubXUaNbXyBAoZgsF+XscuPFIpqyCy7NBQfU9ZMAfXlRCt7DM46yl7P0yix/ErhXfxGNEXzaf8fKctdtyYE9cSRVWIqpUaXPY0KvCG0AlpC6P9kDTjomyexkrRx1gBgNL1J1xSvfVnUe8hTBFHhs9bm+8glWCnO+9MQpB9EKxztfBEG0iCHa/jFE+H7phnpUBDA4YP6A73yji1MxF0ecI9fzE9K08o7pGmoNCs/NzSX4Pf3gTbW9/MzIK0Bp7XgPkR/8iQ/ajf8EJmBYabGsdf0md+YqdSZensDvGrGNQ8884NqmzYSM/+re9+NzVgoBDc7k+zZ5Jl+B4MeSHSZ8dOoHwngH6Wou2WGzL59hQkQKys0mPpnFsueJ0LTLDoruULouaBuruMgbl70LNy6Z7XmopH+vWPkiAEwaJGbKlaY6QzpEoZlyV1rUTSHtGPRpKIlp+WqvMzLvlCGW91rRpbW77wICXc76EWQSAU4xTH6sezgQ+ZiqI2W9El4tEhJCba6lxNqu9WNVizSnJFBGMZ4bZGAbghGZE737RQoCd6OgvmdGEgAFGdftCzTo/P43hlyjXxx5iABZuicuzvmGyrEgqH8VRfplpLXvcvKbPbCHPd3iUB5K2BRFnfo2eIeTixYyj70jq8wrcY11YVKZb+HXNZperH2qlTzts1aRSo4CC3Oagasm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(396003)(366004)(39860400002)(376002)(451199018)(122000001)(8936002)(52536014)(54906003)(316002)(38070700005)(26005)(9686003)(186003)(478600001)(6506007)(33656002)(7696005)(71200400001)(86362001)(2906002)(55016003)(44832011)(110136005)(5660300002)(38100700002)(64756008)(41300700001)(8676002)(83380400001)(4326008)(66946007)(66556008)(66446008)(76116006)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?G98rXYIyvTWGdY4LW38KzeB1kKW5Hqp7zOwagdbQ2WWZ6t/5kiUFOa4Z6R2g?=
 =?us-ascii?Q?1TVcO2OCwAjtOtIzn1d/Sq1b0VvnNk4FGW847Qa4zNvzh4BJw6QMLCWTbDXV?=
 =?us-ascii?Q?kcs+zQFY1KAZs3fxsvHEeVYdJDzAYUpBO/dZ4ry/CiGA197N6kVd+fVAZbId?=
 =?us-ascii?Q?ps4dwqJP2zrKcWpQ8i0pufLcmib7FVzm8Lou92wO3Bof2hbaHZWZK/0i0IGE?=
 =?us-ascii?Q?coyQovs4ELzK2EwCj554eI2SDwFZX4SQ/cFCOfdaII7/mU7PhEkTrvTY/03d?=
 =?us-ascii?Q?mCmpQ4JzySt1/rcjEl+Eoc5c+j0/yI0br+GEl9FruyeKAFdJH4PAjJkHej0p?=
 =?us-ascii?Q?WmwMdiuMpw/dFPqzw/BQEb025R6WVeLmRF+VhJdI62BTKc3y2Q62e6k7WH65?=
 =?us-ascii?Q?OZmbVKaQzIU/Er8ox2YMRRRZgm6ctQVs7WQovEhY7P6AotREZrphsusrYxMm?=
 =?us-ascii?Q?OwvkNC7/5kl+IkutkaCEDgZq7DjpuC75mS63WggTv50XCkCs6WtcR7oUQY7f?=
 =?us-ascii?Q?45e3LVIlzyQ8byHakKvvenMJ+5H58oz3lEDtma4D8MFSLu1MWrtvm8U7/Wmj?=
 =?us-ascii?Q?zipB4bi26iTf/tCP5w8JxqAq3wrG1oWBMm9tzEmCU/Q8ZoRDYywqp14nY7sN?=
 =?us-ascii?Q?A3dP/CQ0CumbANlon4fzNlw3xRgnRWHi31M5NUYZJ4Lc96nWVxlsvBQHK0Rm?=
 =?us-ascii?Q?Y0jtuCd5HXdU2H9KxKQ/ojZ9GCJslEPhz0vD62riIw569kqwPqMYBRdfvSlc?=
 =?us-ascii?Q?ES+B2XydvVj874vIIb7ViK6nvRKYBcyej8Q2b3mTzkhKhyGiDuXhETxzesMW?=
 =?us-ascii?Q?PVuXRnFKbKORYEC6OctrXQgisfIsDU/Q2w/KNzVU6cnWaFU8yGbIob3AyAOJ?=
 =?us-ascii?Q?wnumunY4Xmnx4zz5Hv3VXEPTP9WzK1952KewUagWDpYrPiXUoP4r82ETVD+D?=
 =?us-ascii?Q?zaRQvjIfQswVl3NMbPXm9Hg6PBgSPjfhm08bFFeirF1UKNrIOA8APRVh0lZO?=
 =?us-ascii?Q?yR1aIw9RtC6lqNH/Eh9tjgPoCGqNyWr+LpvGpq7xVHtpAyODbnfXXj0L1bfG?=
 =?us-ascii?Q?XyVyanLVibhdz3YXbAfKvB71HcrsZE5UuBa2xenOxBaFTIhBUY1YQKalMKsv?=
 =?us-ascii?Q?NDXe1uBhKP3rfrNDtSk7ZUgpIZsM48+n/n9OsPRCvo8DpnY9UdZFrGfGpp0d?=
 =?us-ascii?Q?qj8spTZVKFjg50lpig1+I+CsM+nF5JORtHUl7anhTUoFRMbhOXuSPrmx2N3u?=
 =?us-ascii?Q?Xk0pdhqCfo2Ogv62kR5smNRwoOjNcGJYDuK6NbEipjH9FMBPXaGLZQW/Y3K0?=
 =?us-ascii?Q?AsxzV2dngh9Elv4kcC5W4vvCSCdX5SWFAOflPTT8MKFXhG3Kxi4zvKChsOJV?=
 =?us-ascii?Q?YOmXce8h2AeqwEcsF3bE9wlzIZqS57nU9VloyOw6EyVvQXuQWi9rPt4/uzUg?=
 =?us-ascii?Q?4Sh9xkQUbp3YKbPXrxS/Xj3Nkgc4w01L5D61cojmabPsvNXR2WZI8YnipSg6?=
 =?us-ascii?Q?ibMpnH/x6oVI7ZivXlZUM+H2uvfmgTrwOjQey0WaRCevh92ulZASLxdf2Fm4?=
 =?us-ascii?Q?AUJllWWZcVbCc+tGl74=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f085442-656c-4cb2-1681-08db1620d5e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2023 04:37:28.5782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vNg1ZSC0ZZd/eYB3ji/4fSJIxy+zJmYkeAC44FOpYsZzzwXHhuKddrLpC5CC1LJLYy42MhEtguIJIokMiHgSdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8162
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping..

> Subject: [PATCH V2] dt-bindings: usb: snps,dwc3: support i.MX8MQ
>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> i.MX8MQ use Synopsys DesignWare USB3 Controller IP, so add the
> compatible.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>=20
> V2:
>  Rebased on linux-next, remove power-domains from v1
>=20
>  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> index be36956af53b..fefd6610ab45 100644
> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> @@ -30,11 +30,13 @@ allOf:
>=20
>  properties:
>    compatible:
> -    contains:
> -      oneOf:
> -        - const: snps,dwc3
> -        - const: synopsys,dwc3
> -          deprecated: true
> +    oneOf:
> +      - items:
> +          - const: fsl,imx8mq-dwc3
> +          - const: snps,dwc3
> +      - const: snps,dwc3
> +      - const: synopsys,dwc3
> +        deprecated: true
>=20
>    reg:
>      maxItems: 1
> --
> 2.37.1

