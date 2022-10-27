Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF8460F6BE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 14:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235592AbiJ0MFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 08:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235552AbiJ0MFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 08:05:23 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60061.outbound.protection.outlook.com [40.107.6.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8257E323;
        Thu, 27 Oct 2022 05:05:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMEat3x4TbeWyp+9uW5aGJAFRW9h7Mw3HYoIi6al3v+C5ItdJ8+HYKFOIk0YzZIHR0XULazZYowCIyuorLw28EZrKEi/6/VINqUCBW8RNgpASC57Cygtqm+vwcLoYLCpIvxlAgeEkksLzLQ3ta8wYQqkU0wOUXX6c0vEtf+TRYqAnPDRyullvDh043fR6Msp1vXjzYIMlCo0FUk7YHM4lG5UI0UHfZNDBjXMVqYM5M2fZRrsfxy4J1FMRSSN0Mj8z3sidlJA++vIa14Qjfm2VlOevThPm+7vH5tmObCaelwJutho+kcakc3tTeTmDAWx3MgpYfhAOEWh5AW/VRyDmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0AsHB1dtyRY6YQUB+DBuMKo+2DOqnLB/BqjrEqTh5Ow=;
 b=gnTjIxJOSnMmJCzFlKVeRXarMsy619x5LEXTgBAJoAEQANJcQfxa2ujuNtpw+wTuppKO3u/HtBzAHTm1wxZUNQX5mZSjJZtLlBT7AXcjpgjl/hqxRj/YO2kCJuFZwL+P0xw/TUjbMq26fqmij3WYNWw9NlxXf8iveiRcz66SJrf2HANmF05+h/Vk7UxYW8mN5rRZCAm6BqrtsDafRKRtPPCKSmhyUQqq+7NiOUFeup4vhFRDRzPnTAftsTWu+cB91uuQdcoDQUegZgsFXAYrLLgiE5vk/QuykMQoZw4Gvvm2tCYmfkvRRjkmp1/IKbGd8haFxqsCIWKneErWHP2jMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AsHB1dtyRY6YQUB+DBuMKo+2DOqnLB/BqjrEqTh5Ow=;
 b=J3iF/1Xp/6X5284HmhDCgHAjwli735+5jFg75c8adQgAyB2C9uKNmmQbl5hTnBVKSSpBqW19qsjp3O+Q17A8qzk0LCiadn/of5heQu1y/Nua2hwfogqMygE+dh22zScbcct0ZsU7KFcilysCP/nBbd8UZcVY6Guu/18txgNEmrk=
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by DU2PR04MB9178.eurprd04.prod.outlook.com (2603:10a6:10:2f5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Thu, 27 Oct
 2022 12:05:20 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::6710:c5fd:bc88:2035]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::6710:c5fd:bc88:2035%6]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 12:05:19 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Michael Walle <michael@walle.cc>
CC:     Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Heiko Thiery <heiko.thiery@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH] Revert "arm64: dts: ls1028a: sl28: use ocelot-8021q
 tagging by default"
Thread-Topic: [PATCH] Revert "arm64: dts: ls1028a: sl28: use ocelot-8021q
 tagging by default"
Thread-Index: AQHY6ffdJD/5Oq16AkSmf/jVUKUJTq4iJNOA
Date:   Thu, 27 Oct 2022 12:05:19 +0000
Message-ID: <20221027120519.7f3xun66l4lamcq6@skbuf>
References: <20221027113248.420216-1-michael@walle.cc>
In-Reply-To: <20221027113248.420216-1-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR04MB5136:EE_|DU2PR04MB9178:EE_
x-ms-office365-filtering-correlation-id: 574ecd4e-271b-483f-de89-08dab81384d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x4v2NlikFYOP0FZ0n56STgaG0Is466A+vMcgk1oOBSIfh0le4vl6QJS95Xv6sXT92Y4feF3FtRVSftzwSQ+M5BHSFzPE3mYqik6Pn7LYDQtqa1JspvOh+xMwrSzyoTUCYRFq9FeRF3bJE7PTKYavNASHBN0ngFM+dw0Ek7Ipwgs9O0e++O2cyipnpPkTj4XOwZVvT3cGMcUy4MwjXZ+A6fJerh3IioeOp9tk79RWfiLzztMObwVBYPNav3KaqjsJNXFiudDe9h0Ko+bNz1QaFAnwtUbcpfhQ4bnqmqv1vCO9+vlGeZx7f/Mc6N/pX3lQkONPtirwVhNHhwJTZ/PggGR3M97VnXukB0yuTPd00b1OcR5Wnu/nXOTolUyv/SAOAlLeifTu+rI/Wn7MvqIzXb+NtIQvGjLmn+ODH6SsmL0MzrFaH0YfD16zaY1UPdRVOqkIkP9EJkd6PkQCI+Jm+YL97blOcmeQFwJCJheA1BSFmBsIPgPZiyQI/Wze3s9HSSooP3AtXLOU1Wz5hXVslv++uAhy+/PcmC8+glGBAkETAyYSumPPyJsHzBrtKLPDjNISfyTNaWQbqzdzjs5dkL6sVfMYaiNei+uKcMXJHVt8yGn6Szjf9cW2Uq3calo3KcMrmaiFvUUCn4lJ/g7JspEX2HWFvyumixiby7EG7UkXet3Ch+3QzpUk3+Esy4FOyXDEqXU85GPPilpHeSUiNblTxXUElC+6wxQ7KCOS43qqALZwDneypUmHs7JuNg+3jWKneeo05EVD0zNqPqWbcw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(396003)(39860400002)(346002)(136003)(366004)(376002)(451199015)(478600001)(71200400001)(8676002)(6486002)(54906003)(316002)(9686003)(8936002)(6506007)(1076003)(186003)(6916009)(33716001)(26005)(6512007)(83380400001)(4326008)(2906002)(86362001)(38070700005)(44832011)(66476007)(66446008)(66556008)(5660300002)(41300700001)(76116006)(38100700002)(64756008)(66946007)(7416002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rLpckhxQ/ODtI3kMrj4jRL7gi8TpPkmrnwD3AxPd4shizsEoOsGOqXRptfBC?=
 =?us-ascii?Q?D+yirTGgjrRKhzmR9+xkv+fIU4e5NhFUgbFGAO7DsW3CNm72hRoujmvC5WOD?=
 =?us-ascii?Q?71BK/AlEOBjJ3Tv8lasuMh3EQ8JPQr60MAYI/zYNTIiMPtQ9Ot5m6Bgv/apc?=
 =?us-ascii?Q?m48m5eUrfToZbUHtpTgPRlN8JdmPGliXwEq4+Z+Ia/LWdYNKpoiYjrhI+Qx5?=
 =?us-ascii?Q?SpD+U5KzNOntvH72NHPVVc1MNorn3jh3OQ2XVU+Jpm9/Z70MFujetv24pTF3?=
 =?us-ascii?Q?7qC8gQV++dc3iaprx+VFJYnwx7/tE53L2l2PuohiDUZierEWrDckPw3WzFB5?=
 =?us-ascii?Q?bM96G2H3ISGK+/at1s2DHiPCd6vbNxLLVz7gt7ViuSQlXL3BGrpwPStmjD0W?=
 =?us-ascii?Q?cFTXSZPqIV5oIdsUN3tPhjd2M44DUzJDJiqxgkl7usQ5EOeClqJh6qIoks+h?=
 =?us-ascii?Q?aBFyrglvdgvGzm6US2zSxAmQkLxryhDnAIj6GZDpwNSJCVxvGsWZThhqDTm2?=
 =?us-ascii?Q?iefVa6oOIQWe03T5tRe6HleseJITrIcWOE6GMTGxuHk95AsMh5mH5KO4AUEZ?=
 =?us-ascii?Q?y/v/bHRDI8E/exSIH3yWJYRevLrzATi8pdu1zGxusQJCp4x4jOVXxdUBf7wN?=
 =?us-ascii?Q?OBZOrCXUO4uNPyv8fx2jrzTECZg7AvjdP1LzsbA1F4rAFGR3cE/rKwyJahnA?=
 =?us-ascii?Q?hS9zcGhyFPTDFfagW1uZAMkhsPq61Jnk7nndD7qSGfYRmRTRqy+2xCHqsfPi?=
 =?us-ascii?Q?I845X7qp70l58/EwqYojcrL1MPnM9ca0z2E2opwf/bHHI+/0gGUcI3PaqVUc?=
 =?us-ascii?Q?G7AYjS3pyrgsCiuN6UOgitMfs7vX7iJvlMBN0yezFnUsUurSJnpSZFEd9N49?=
 =?us-ascii?Q?BYT7AFkm/cpfxfX2Ob93GF+akDQ3yRwX4lt6ZVEuKrrb8hWgA8y58ofqPc1t?=
 =?us-ascii?Q?tXnElKLtOzCYAPTulAw9godphJLLlI7kaZyhEnrwphoPK46qRMrjeP/4Wxaj?=
 =?us-ascii?Q?xfSBfJUI0TpKxkwMF9MC+dk4EyjueScK2czk1er/rGfttPBOCxx0OWIe5cAU?=
 =?us-ascii?Q?6ruxyjNzTurNE21ZAUGzNdjoxfVIYgKPl3DLE67gK0K7jMDL2ShWPKQPUMXk?=
 =?us-ascii?Q?mWZOyIA8VDlieJQqSSNEZ6bqJjDWHtLsdHqwifpYPkOriSnG/5EtMvxnkdGP?=
 =?us-ascii?Q?FsNSMdrXGP1PA+6+RinE6r25PXEMFH2sLex97mJ4F80CyiwABUhoVuLFJXB4?=
 =?us-ascii?Q?HQQ6JWPjGhlYKY8xdSgNuZ59tPrP9umK4/9sauWmsiPywSvBLuq5VAALWopQ?=
 =?us-ascii?Q?JWT6XNEcz3iD/8/KeH9BHMi8OqS8EKBZa/LEtxV4JYwSKwf0gf30CRhbROdB?=
 =?us-ascii?Q?YzFKX1Oh6nLDm54/GCzDi6BdiXnHjxCfRzVfyRD27qIohzjIjL7L3ab9zAl1?=
 =?us-ascii?Q?Uh4dhZclEcGs8fHQN7gmHeJcmpI6BZeWuyA8WG3ahKVSsenhkjwmdzrWtRwM?=
 =?us-ascii?Q?Kp/Xv35f7lWt8YOw5nkQS9Ti3JQBhzJYXjn8EQ6OtxT4Z8DlKormsRjnYFaf?=
 =?us-ascii?Q?yTi0IHgDR8dW/NoNC7QUzFEwvA4ngnF9al3yYYEb2LKWN8dvPrySqChXCxF4?=
 =?us-ascii?Q?Cg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <05C2EB2B8000BD45AE0530C4C8BFA3E4@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 574ecd4e-271b-483f-de89-08dab81384d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 12:05:19.8022
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pox08mUg0bI7D25wPprWjNWryDSV63UQ+h09ANY/BCkuxhv4Nr717OiUp7/n7lo60rX4dz4KiXpB6vm4Gb6LFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9178
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 01:32:48PM +0200, Michael Walle wrote:
> This reverts commit be0b178c50c37a666d54f435da71cf9f008362a0.
>=20
> This commit will break networking on the sl28 boards if the tagger is
> not compiled into the kernel. If a non-default tagger is used, the
> kernel doesn't do a request_module(). Fixing that is also not that
> trivial because the tagger modules are loaded by ids, not by name.
> Thus for now, just revert to the default tagger until that is fixed.
>=20
> Fixes: be0b178c50c3 ("arm64: dts: ls1028a: sl28: use ocelot-8021q tagging=
 by default")
> Reported-by: Heiko Thiery <heiko.thiery@gmail.com>
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> Vladimir, I'm not sure how to fix that one. Adding aliases to the tagger
> modules? Something like "MODULE_ALIAS("dsa_tag-ocelot-8021q");" and then =
do
> a request_module() in dsa_find_tagger_by_name(), too?
>=20
>  .../arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts | 8 --------
>  1 file changed, 8 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts b=
/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
> index 72429b37a8b4..771c50c7f50a 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
> @@ -324,14 +324,6 @@ &lpuart1 {
>  	status =3D "okay";
>  };
> =20
> -&mscc_felix_port4 {
> -	dsa-tag-protocol =3D "ocelot-8021q";
> -};
> -
> -&mscc_felix_port5 {
> -	dsa-tag-protocol =3D "ocelot-8021q";
> -};
> -
>  &usb0 {
>  	status =3D "okay";
>  };
> --=20
> 2.30.2
>

Pretty nasty. Of all the switch drivers that support tagging protocol
change, Ocelot/Felix is the only one with this bug, because in all other
cases, the default and the alternative tagging protocol are part of the
same .ko. Only here we have tag_ocelot.ko and tag_ocelot_8021q.ko.

The problem preventing us from calling request_module() is that currently,
the string identifying the tagging protocol (to which we match device
tree information) is part of the tag_*.ko. I think we'd need the
translation table between string and enum dsa_tag_protocol to be part of
dsa_core.ko.=
