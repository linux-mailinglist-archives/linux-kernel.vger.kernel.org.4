Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C265BC55B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 11:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiISJ2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 05:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiISJ2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 05:28:32 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70050.outbound.protection.outlook.com [40.107.7.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42E37674;
        Mon, 19 Sep 2022 02:28:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=acxaJ/4Z089rWhNHmYfvP3VPVyjWtM9W4B0zjG935VZlf3ZPTowyhlPEMNYnMkQvEErL28out4qSeqEmN+9953DfZ3gs9lPfZrNogrtgZpcRSY4kPjFq95vNm9Xs9FfTFu6XqlQqTXdtZBcIBQ8HCcsSwJklFMygIwA2OcAZ8s95kpEDYL6K2qdzwrfp3ogjhQkmS5XbUxTgV1UzFBh6ttz43XQEfRQ1Adb393QTPpUFwVI90l+Qb+XlVsJ0enuT/Z4XA3Vy8k9WF67bZYS/RUffUnhbJx38vVwiitccQxdMVrVyz+OoOEufKhhplr/WNiMf9cvwWSCk2URgn4L29w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOfg16nZGh4igk1ZFbaHuQ9QUHkLYWqMhH7o96hID9E=;
 b=gdbn1/ZczHGBl4tmsZvkhNERaQWhqj+4X+FQ+tMx5ZXXnUJcM2p3fgB/R7nq8AewFRdzkF8iFQMysnBMnU0DTMtBATjTHPSFIzjU5SvAqWCMI6VkJTX6DlgOv93LHV6yffmr1wzrH2YMyh+bvA8VDJNmoKyAQI8nk70EC0PwUklTpX07X607xim3v15ZWtgykNVBDZKjKfJTzvu3SZnwow8P56iF6+Sns0+Mrvw8QBuzhwf/t0y2nIX/WlAiEG84aqxTYR/HbSS8AIIlq/VVwp3HLN7xwZyxC7VyN29fH+Znnu2ic0GmIxRlwtCGl+X7kPaKpjuFlQ7RGm3uv9PUqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOfg16nZGh4igk1ZFbaHuQ9QUHkLYWqMhH7o96hID9E=;
 b=Qyp5gcXAEhUI7ZpDHjJZr7HhWVVam9wePFAwH1CMj1ehD5+nuIVtr9NJnj1HjbGZ3CUnv5y1S9Q2da7X0JYDHqLM17IPl8+qaJdbjjcu4W34O5ZG6mQZ9bZ9EKKSqFX76qEiOuIGeS1B8cEryL+KnX0jSlvtJSTb4C27MVFq5ic=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8142.eurprd04.prod.outlook.com (2603:10a6:102:1ce::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 09:28:28 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867%5]) with mapi id 15.20.5632.018; Mon, 19 Sep 2022
 09:28:27 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "abelvesa@kernel.org" <abelvesa@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "abel.vesa@linaro.org" <abel.vesa@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>
Subject: RE: [PATCH V3] dt-bindings: clock: add i.MX8M Anatop
Thread-Topic: [PATCH V3] dt-bindings: clock: add i.MX8M Anatop
Thread-Index: AQHYy+zLLUWaBrxw10ay3iC1q9pX7q3mUo0AgAApgdA=
Date:   Mon, 19 Sep 2022 09:28:27 +0000
Message-ID: <DU0PR04MB9417BF9DF3BB65B859BBB676884D9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220919055904.1659124-1-peng.fan@oss.nxp.com>
 <20220919065820.fk3ppcdoioubqfbg@krzk-bin>
In-Reply-To: <20220919065820.fk3ppcdoioubqfbg@krzk-bin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PAXPR04MB8142:EE_
x-ms-office365-filtering-correlation-id: f47240ab-6fe9-4f88-43aa-08da9a214f2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Co/+CBL19RX1GDj2o3zh71zyBlNw9QYuXum3cbWSBKxbAbVcCVXOY/G63Th00zyLEOklws1Uoax7EWeZHH8vhZhTrhwGon4k/bPrmq0bknxA5rK6aywSs04M95yuyHccN9wwtM+Hrg/bccdYXjPrmKYgRfM3JvHysCs15y4gFRTek88Sj0H1SD9hZuW3RQJkwwXEeRpmtFp+6P4A+NfGrC1V49CA74RvkgfIBhQ0w0jeh15tNqFlOeO3JsXHR37sSF7YfATYSiB/xl/lZsQsI4RnMYw7T163AW/w/jcIrS5YXuiazSR/m+ItpGwYq7sg/RLaybsDm3l2i9YDD0LGupol7dV+H3fekJUmiVIBrZkOP1Yah0L9LRSa7wH8wlI7WHCLl0Rs2D1AYpsyoBS03c9VIsLE+cu2j3Or2BBqYHrpaUNjfWwIQv0RNBh8V5eb/2hRfSEOa+SLnNPejinPvbAxhZq8FBQtuY2SlWrdLVyqRQbZau/Jhh8l5WpRMYemgJK2oOC8dHdlEcc5oZU8YWnOVyqWzXE417pr/tBfCwVbqzly1HfCLeTz1yLVpvC63JPAPZr3JzTMys8I+8ewhce+EyGM1pcNxQOwnSkyJFtP0PPxS8vz3zbpY+M3rAtEAv0jUshpmUbFFv/cJVM32Uk7Rhh8kfElaYrdcNhU2x9LYattR9+x7imOg/MRoqvra7myCXyeaQDqU0sfjYBaINgKTMJk0gJ2+19VL8UWJtQQmmzn2JT8FTrscxFdDui82n89S43cXyKPVcJRo5PHNYlmbck75Wg+uBeLNVova2A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(451199015)(55016003)(7696005)(2906002)(186003)(6506007)(26005)(9686003)(33656002)(45080400002)(86362001)(966005)(316002)(71200400001)(54906003)(4326008)(110136005)(41300700001)(8676002)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(478600001)(38070700005)(52536014)(7416002)(8936002)(5660300002)(83380400001)(122000001)(44832011)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?d0+y+SqW++tktx0OmoCVtdIGzP871ewLyZCjqypgCo9cj18bHAWKURGpWmdZ?=
 =?us-ascii?Q?63bVUWEf+b/WaSlA+hjgdw42+AnA0u8UiDlsQBPkdyMj7s90Hk2jhRx8BF47?=
 =?us-ascii?Q?N54NbUsLdQ8lFv9thFErPIw5f30Xc08NqjBzQXgBH+C7hX2VS2XcWNwlYWbM?=
 =?us-ascii?Q?65sSm8ajIy/8bZoIiUAygaF/e/g6Sfs3z6C8EaUHBslIE9Dr/SlKpofPTrf/?=
 =?us-ascii?Q?/vjnipCWzJTFH8VerSp8AAzAZ5f1a3J3FUiakyAiStwO/AqfwVKaHgneNNRV?=
 =?us-ascii?Q?/UDpWqagqAZKzFxwThcpy7psqlDZryHcYcwLx6ehVl0f3asulzEVujTLaVz9?=
 =?us-ascii?Q?VwcIlqc7mBfZ+KYxhNAffyoufzyfEoAfVj3JKoeRIoYYscoP6joAeSby47pd?=
 =?us-ascii?Q?mT6Q2eIPckhEmSdEuRQrlmdIEyA7eRsml3ALA/aLepltvrJ6vHyMBrYIyUjP?=
 =?us-ascii?Q?/HVAOrt+YsZtbZ6hjUocKUqcQKo0DyDhnkStW1XSrejXf7wZ01XAGxtHTxKP?=
 =?us-ascii?Q?znW2v+r7vszPRuSOXfmYBxQN7rMDryg+WGMVc7vVjgLBfWSBBOOdjc7MiK4Q?=
 =?us-ascii?Q?30cfl85cQuT6/pg05VtV578VmbA6aSLZYKYz6tAHr/liBit68qUawS9va1gN?=
 =?us-ascii?Q?x7F+uk+j8hN06XwRlRu0ouB2GIZKHHQEf9eCKpAPpYqwj/C0zD4oZHripPE6?=
 =?us-ascii?Q?FsycpjKF5i+CLeHF/BkdA92EId8Ht3sKcw7sCCoYXqiVEL80wWyq6O5I4Sok?=
 =?us-ascii?Q?r4bA3tYqeHZEr9vkm4p0CAgwQlRw/94PkW8CFicVPckzqdDrCpiI3JkpHzyI?=
 =?us-ascii?Q?M+w48qRd/eACsaObxj960eeRx7OA6k40a+dHzJjIv822VpQt/+ohveONsV9v?=
 =?us-ascii?Q?349lXIfByGlPrdpIFqEae4LL9q7zqslk5KRVvnWkv+r6HRo3GG6ZuyCMhUN6?=
 =?us-ascii?Q?XTT3Pme/EvHeD7vU5zJxtc00p00YSEF3MupcUAlGdssZkW25KL+zRY46IKww?=
 =?us-ascii?Q?404dQN3sqlnbyiVdBPU8Qbb9uYZ4KUENaBVO1WqVD/EHoioP9wJcpv/Wx1oM?=
 =?us-ascii?Q?UbaGMCgc1Zic6KYw0ogIJHA4nJKrdFfwTTbBWyW96l2ucbNUAFvyqS+77czV?=
 =?us-ascii?Q?5nmE2/4pvZNWX8zSZON7iFcDlmkc3FabEmgpvyKHs939TLoRr0Kv7yNXKPnH?=
 =?us-ascii?Q?ENwT9b5Kym8DFCx+sFBopnAHMICm7f0srWVFbvBGo9eo46kc70csT2YkWij7?=
 =?us-ascii?Q?16lEvh/IXTTtID7vMtLGdhA2jQnPXuKVTGmSxkW0IWULvQXIkPXh5soZBkSQ?=
 =?us-ascii?Q?2T1on2Curr546MTw6PfXTFD5EAi/AZwcM/nA3010v92PbcQq1mzaOXVE8kJW?=
 =?us-ascii?Q?X8CcXL+RHICRUejjwEjTaGtVixUgD7jJuqNySfEE9xYV5HhlY6D41MSfGxDT?=
 =?us-ascii?Q?H2lWLgRNbAF6ojJDUorosYeY3G4B6lerlygIxnSB0Ydn6L9PyzwVkx4j69TK?=
 =?us-ascii?Q?YGHnW98jQ7C6lhsqsU9EgGdEbT0tPvtcAbdncp4D23CyYBJBMG2DyD3UsGaU?=
 =?us-ascii?Q?MD9tgD5EMeUAFVEbvDk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f47240ab-6fe9-4f88-43aa-08da9a214f2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2022 09:28:27.9024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 36xdzYXvVNSVlRk0GQcuGvVFx/izBXu1zrdKXPzgNjwsI4syqScMPCK+meOVLAsmE61vgzFIxzMdXj/3OioG7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8142
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V3] dt-bindings: clock: add i.MX8M Anatop
>=20
> On Mon, 19 Sep 2022 13:59:04 +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > i.MX8M Family features an anatop module the produces PLL to clock
> > control module(CCM) root clock. Add the missing yaml file.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >
> > V3:
> >  Add #clock-cells property
> >
> > V2:
> >  Drop syscon, use clock-controller
> >  Add fsl vendor prefix
> >  Add interrupt property
> >
> >  dts update not included, so there will be dtbs_check fail.
> >
> >  .../bindings/clock/fsl,imx8m-anatop.yaml      | 51 +++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/clock/fsl,imx8m-anatop.yaml
> >
>=20
> Running 'make dtbs_check' with the schema in this patch gives the followi=
ng
> warnings. Consider if they are expected or the schema is incorrect. These
> may not be new warnings.

As I wrote in cover letter, dts patches are not included. Should I post V4
to include dts fix? I planned to do that after this yaml got reviewed.

Thanks,
Peng.

>=20
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
>=20
> Full log is available here:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatc
> hwork.ozlabs.org%2Fpatch%2F&amp;data=3D05%7C01%7Cpeng.fan%40nxp.c
> om%7C04615617c9f24c44c92e08da9a0c57f1%7C686ea1d3bc2b4c6fa92cd99
> c5c301635%7C0%7C0%7C637991675050725656%7CUnknown%7CTWFpbGZs
> b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6M
> n0%3D%7C3000%7C%7C%7C&amp;sdata=3DKO8Opg2Mln4R4L%2BtgHnSGdXZ
> 4qCFOqWk57FXwR%2BrJXU%3D&amp;reserved=3D0
>=20
>=20
> anatop@30360000: '#clock-cells' is a required property
> 	arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-data-modul-edm-sbc.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-ddr4-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-emcon-avari.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-
> ctouch2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-
> edimm2.2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-mx8menlo.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dahlia.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dev.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dahlia.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dev.dtb
> 	arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dtb
> 	arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2pro.dtb
> 	arch/arm64/boot/dts/freescale/imx8mn-ddr3l-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mn-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx.dtb
> 	arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dtb
> 	arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-dhcom-pdk2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-
> edimm2.2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-
> mba8mpxl.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dahlia.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dev.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dahlia.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dev.dtb
>=20
> anatop@30360000: compatible: 'oneOf' conditional failed, one must be
> fixed:
> 	arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-data-modul-edm-sbc.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-ddr4-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-emcon-avari.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-
> ctouch2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm-
> edimm2.2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-mx8menlo.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw71xx-0x.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dahlia.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-dev.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dahlia.dtb
> 	arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-dev.dtb
> 	arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dtb
> 	arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2pro.dtb
> 	arch/arm64/boot/dts/freescale/imx8mn-ddr3l-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mn-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx.dtb
> 	arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dtb
> 	arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-dhcom-pdk2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-icore-mx8mp-
> edimm2.2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-
> mba8mpxl.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dahlia.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-dev.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dahlia.dtb
> 	arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-dev.dtb
>=20
> syscon@30360000: '#clock-cells' is a required property
> 	arch/arm64/boot/dts/freescale/imx8mq-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-hummingboard-pulse.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-librem5-r4.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-phanbell.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-pico-pi.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-thor96.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-rmb3.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-zest.dtb
>=20
> syscon@30360000: compatible: 'oneOf' conditional failed, one must be
> fixed:
> 	arch/arm64/boot/dts/freescale/imx8mq-evk.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-hummingboard-pulse.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-librem5-r4.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-phanbell.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-pico-pi.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-thor96.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-tqma8mq-mba8mx.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-rmb3.dtb
> 	arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-zest.dtb
