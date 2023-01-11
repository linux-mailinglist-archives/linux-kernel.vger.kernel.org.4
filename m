Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457C86651F7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 03:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjAKCpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 21:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjAKCpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 21:45:22 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B202412AE3;
        Tue, 10 Jan 2023 18:45:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VEksZbf+WZoGryUF0F/mcC5MSavCch8MLOADL9AA+kpzu6XVGMIOKF6nW0h9MYJ+IitFGL/wiWu/6AmfBGGIaVVjmCzONk03pm6uYDg2REhlsxjlze63jzQ3qFPiKqEwpfnyC8DUw7g0g+6q9gR4rNp8n/h7S+B1dvoG6/+0k8TGK7jHMmYdQXbIKNdV3i+w2J23CwuMWr3M6H/ZLx0bdCSP2r0e2as9ium1KdEbA85O76s4ytuQWshXjbnXB64oO1oRZMfQPnTq7qgpayPer68Gsm+DaEV75pJ/uwJDe7ijR40zcIiXdwqiRVRXkfvUVaowc+QAQ3w1lhm6SPTSeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=urpKKwQyFKloZ4X3rRE95177b/bUn3rCG4/tWwkVB7g=;
 b=Ce5+i3LknW1RhRzDPXrHj9IVVVsqg0Qtw7Kgfpyjg0QOSPON1Sq2isJtJGhnbPi+qAC1rY7LKbAOzQRDdKpDViykZ4U13xGuPrVksEr+51UMx2oRsMV81VB3fbhRlkGECFad3OtBVe5XGm64fntSKjhq+fZWfZYL9L/ymNPUREHvgVhZCfeqp+XpN17miE4hlEjPySLfEFB6TdkdXFm/N0DxRjra9WHFZ42638m9df6A6CAjSCpCwMKWiYSO69tWEZxUZ5uq9E5YD//mybFpNpRDjCWA3CUPbgue1z03U9ujZzcJGu/7IZVAsnXNsDe7wU9ePoWSDIKXjcps8hButA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urpKKwQyFKloZ4X3rRE95177b/bUn3rCG4/tWwkVB7g=;
 b=pvflHng3Rc+GBLhGau16EHLrzxlwZTxUQsqxgp7JfaRP61eumYgueRrC/a0vfNWTCOPP68tYk6e3l0gMeQdD+x+n59bisdsU7j1NWKPpUCuEhs+j1DsvkX49OJugIAMGED8/nb98DiUMNUGWVtd5d8StdYhZzkcLaMTDUB50szY=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB9193.eurprd04.prod.outlook.com (2603:10a6:10:2f8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 02:45:19 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e203:47be:36e4:c0c3]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e203:47be:36e4:c0c3%7]) with mapi id 15.20.6002.012; Wed, 11 Jan 2023
 02:45:18 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Michael Walle <michael@walle.cc>, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>
Subject: RE: [PATCH] of: property: fix #nvmem-cell-cells parsing
Thread-Topic: [PATCH] of: property: fix #nvmem-cell-cells parsing
Thread-Index: AQHZJUuc/xRPHKO7TUWtARzIYLeDM66YgsCw
Date:   Wed, 11 Jan 2023 02:45:18 +0000
Message-ID: <DU0PR04MB941732E9BB61E51ADD66F82088FC9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230110233056.3490942-1-michael@walle.cc>
In-Reply-To: <20230110233056.3490942-1-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DU2PR04MB9193:EE_
x-ms-office365-filtering-correlation-id: a6bd89d5-bd89-4f62-9986-08daf37de080
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oYvhT/bjchQjawtFbWgxvrNI+1jrCEaZA+Jf4ur9VWGkjrDM9ajscsnQvFt4v8Qsmx7nqt2pyvvB0C7GkyYC1exhxfBWMRQgVZNXZTRhZBg0CYLjJ5IxkO+qHxa+w9/hwLarlQmCYzWlnVxuo/Lm0hPprL2Nq2tFimVAqYFbqJ9WNRVvn3hqbHa/lh2v6AmSG0NypwjwJEUuyZNMpbomKi6NVpjolmKCk6gPj9qhH/t3qmPRetH6ZeO5JkCA6WbqwMSiiOHlcQ1f30bp0Hiz3e7EdbQpU4sjloCMES50yjJRZ+XzX9uw3HIneBkvkTpsLXE1Xwqi6/ge01idbFYa1pSlA9bKgqDn0KS12IvhsIyQDNcWAyTZ5hFAPUq7jgkoj7Rw3mbEQBUyS7Mz9Ik3DJB0yW58g/QVQ74xyevQr8G3IWnoDWmrrDiQbCAbX8WocO+lHWE5hsvmtYCvAR90pLznAmnXM5WOFg2Dia45y0oi6AYDfPNPsLDiTW2DuIbU9t5DTHpF9nnqh7DbJMLLRV2kVBDDPJkIaMotWbGHIC1VwiclQUvesjLxXDSjwRUDUw7i0gAvhda8s97NkN5W88yxAnJhmEiU/eYbbfoisufmgOnxTqF91rpLhRS+0d761ut7D12SNoP0UC+RtVtK8dJa43XT2/NkwsyksHyxKMyM7KWQoBc3+d1E3VmdfzdkXZRyORYZwEP6tzV1EukcKg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(451199015)(6506007)(26005)(478600001)(9686003)(33656002)(55016003)(186003)(66476007)(76116006)(8676002)(64756008)(71200400001)(41300700001)(66446008)(66946007)(54906003)(4326008)(110136005)(316002)(7696005)(83380400001)(86362001)(38070700005)(38100700002)(122000001)(44832011)(52536014)(66556008)(2906002)(8936002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J15PTdn1Z8XYwrNyKgtf4eC4tmCx2By6RYJjiuQJhTLK85J5flegc2cVODx0?=
 =?us-ascii?Q?7SCtnNwRkR9M++9HQp/Ny9X0l8EStOTXpug7jFpERMoXEalmv2kEwHaofnoD?=
 =?us-ascii?Q?GH6eYIrubKxS3cVT5Oc06IcySBeFOb48FrBE761/943UrkL4Lj3zVVE4K+BI?=
 =?us-ascii?Q?0UJ+NT1wdKC+E9rkuNzMXMuFmkHtSymRi9uHfZHxVKW7aYMn6NNRRTiuGhNz?=
 =?us-ascii?Q?c5Nm401jF+mTLwouUKqQ+tsdRxOblBJQizdgcJnc11p9U8fu+pMNByG53NzU?=
 =?us-ascii?Q?nobs1XXs/diBkS+Za+k3VaPJxVBBDCfe37jVOvfmX5kv5pVHePFkF/1I+qQL?=
 =?us-ascii?Q?Vf4QGyHf2NZQCVHYMhCiwlDpbP8BX+MK13vSLVTmpV8fCnK+zJrH2Jxd/NAY?=
 =?us-ascii?Q?7Z9/a4B1cyiiT/2ooTRKh8elUx+i/n97JSuRrfiQ6USQ2zIJu5vJSYawnOG/?=
 =?us-ascii?Q?qw82za/KeHLQ+VM3u5sN5Lv9aN1IJCNlG/2g5thz57zFHIWk47xkTpNE0IT3?=
 =?us-ascii?Q?cYhr21dwvgIguIKn3cDPNskBduVXQfPy7ApJ30HdpWKNUusJC6M6efiM8RVy?=
 =?us-ascii?Q?+9CLewWAEp8fIsWZVBWc3IaDK2C+p/5cd8M0RyDR4dDWlomZvteXbkrR/w9p?=
 =?us-ascii?Q?k2u365LCX7Byf5eqqOm157lkp588ijvy/Ym3Iv6FugybEI978CINItt5EwCr?=
 =?us-ascii?Q?lh8L3vZY66bvHxUebnaZffnbQFC5Ud59pIjTHuHr/+LWZwmI/NLjpDkSE/mQ?=
 =?us-ascii?Q?cYwFnroaMWkZ588IU3CKkMdvdUq4C4ZDk6fiCyNjaZHoR+c3EfGCocOAeHsg?=
 =?us-ascii?Q?mDlKxZC2p6vEWjZfJn8gZZv0hW4sOgMqhREhxPUJLH+GwwrK6JzmkfKu/m5S?=
 =?us-ascii?Q?F/YAuBIw1bj2aGrbt1o47Wzt9Lr+XFKTIDSx/GvwtUp1A3EsPRC6TU4jM/z0?=
 =?us-ascii?Q?dbqHzFXtNMsv9K/OQu7xKnpb6DgGB/0C2eyP3zdNUX7/oki3vR0Wl/w5wGBj?=
 =?us-ascii?Q?di+0651o2cv5TSCKxiR/CPV4mdfuFiTIhSOr6WWf5A2yS/eF52bDZhhNgvrG?=
 =?us-ascii?Q?QzWwFwcBf2WdFLwfDO/kiitjT3eIFxr1VdJC17wnRAZdIo4AszaFGnPo8ol3?=
 =?us-ascii?Q?JMFFwUSYapAPPetlD2SFck+kgU9EoR7+N1FSel5QPRpqwen9TJLb5p21BcOh?=
 =?us-ascii?Q?+L2Hm9k/KXZaaGdPGobTmuyt5gpj1qJXG9gURxIjiysfkKm8LEs3wP2OGU19?=
 =?us-ascii?Q?mc2SJCttl26MBxkqvfcvOnMCeGF/d2AdRQV745dLhve816NKODUnBfw2Euyy?=
 =?us-ascii?Q?H31yMdHXaxe8iKVf4FZg48M6EnJE0XaQvftgKGMuxLg7ZnMmv+2O17Q/Gd2l?=
 =?us-ascii?Q?zVcJu2zQYxzjEZDovknwb/kOcbUKMg1u4oxiqubfZA5m+q3b+ZfKxiQa6wrU?=
 =?us-ascii?Q?owTiaO6nMK1mZFkmC5yVZp+eF+yMIY7VdCMOiMKA0741buLSa8sTKigpsiik?=
 =?us-ascii?Q?Eo5kKoc8qsfcAAGqj+o/YEhS+DfHBTFK8tsfhdTQlek6aAjO7k8+ihw0JBp7?=
 =?us-ascii?Q?fN9dOTiT7exOHiS/gw0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6bd89d5-bd89-4f62-9986-08daf37de080
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2023 02:45:18.8864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N/kEIaOBPrTn7qX4stZRbBhS9K+GfirlD3Xf4Ie5rHDbzyZrMGLbsU5PLvwF5epJOcKSIJTAZCQ9C7PLZ4AKGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9193
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH] of: property: fix #nvmem-cell-cells parsing
>=20
> Commit 67b8497f005f ("of: property: make #.*-cells optional for simple
> props") claims to make the cells-name property optional for simple
> properties, but changed the code for the wrong property, i.e. for
> DEFINE_SUFFIX_PROP(). Fix that.
>=20
> Fixes: 67b8497f005f ("of: property: make #.*-cells optional for simple
> props")
> Reported-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Michael Walle <michael@walle.cc>
> Tested-by: Robert Marko <robimarko@gmail.com>

Tested-by: Peng Fan <peng.fan@nxp.com>

> ---
>  drivers/of/property.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/of/property.c b/drivers/of/property.c index
> 8d9ba20a8f90..95b838185b2f 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1202,8 +1202,8 @@ static struct device_node
> *parse_prop_cells(struct device_node *np,
>  	if (strcmp(prop_name, list_name))
>  		return NULL;
>=20
> -	if (of_parse_phandle_with_args(np, list_name, cells_name, index,
> -				       &sup_args))
> +	if (__of_parse_phandle_with_args(np, list_name, cells_name, 0,
> index,
> +					 &sup_args))
>  		return NULL;
>=20
>  	return sup_args.np;
> @@ -1256,8 +1256,8 @@ static struct device_node
> *parse_suffix_prop_cells(struct device_node *np,
>  	if (strcmp_suffix(prop_name, suffix))
>  		return NULL;
>=20
> -	if (__of_parse_phandle_with_args(np, prop_name, cells_name, 0,
> index,
> -					 &sup_args))
> +	if (of_parse_phandle_with_args(np, prop_name, cells_name, index,
> +				       &sup_args))
>  		return NULL;
>=20
>  	return sup_args.np;
> --
> 2.30.2

