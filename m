Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774E774CC2F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjGJF1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGJF1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:27:49 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2067.outbound.protection.outlook.com [40.107.6.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7005FA8;
        Sun,  9 Jul 2023 22:27:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPy5rgpEewvRNheq8gULsTe0Omp7qt0IktG+L176Kwy0HIJuvz+0W+ERmOYMeII+ptSci81UIcQ9qx0QfZjdEdtMMQpc8iIPhI0qZY8B2Xlu2Hq9FmP4dZ8j4RH8LBCwg/wh8+nDkC96TAUiCG2nLqj7nMX3mdiocFxbBtdNlUCGE2tJfz3yTMsM/68g9aLt9kcSuxLTbRBRx9//1ZBuJUCj27750mPPo/BrrJSjtx4YDNQ+vwTKsCAEuN0jSFP6VuUUxAOl1P6yjbcSs8FKnvAJJ5okACs+6qF/ysmLXyELXSXCgk4Pu4UgFDrxc34mkdHcH84hbzC9cE3msmD50w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CzzIDFaSaHKt9EUT0paCfVjlYZGTe3pQIaD9RAir158=;
 b=gfV1X0/HS+4YtGzzvUjqbbKsPF7frdZA3RmKi2ly/9ew3vHBC8+sk/yopukeYahAA0mMRM6mMbRPvENUcS8Rnabb5pB0AaGL1xXSKcuOlIKHOlawFlOB60J54rhnHFoMuG620/QRqvGzYl9mJPT/lvouGIr7fwkU2c8k5gEeyBs1ZBaY1YLpfQn7ODli81YOd+xUknd6wmLvVh7TXjQ7zhEew4ITsW5b/U9iTQ12L4U8NNnLxpxBnEYtnNW9KSJiyyBJRppyVbK0SNkGV432OU/DvvTXT7UZ//9cdQ4bunid/Ukj9TINF0p/l48oEi8A33Sn5WK/2v8AHX6KaaOtkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzzIDFaSaHKt9EUT0paCfVjlYZGTe3pQIaD9RAir158=;
 b=jApxg9W6fotJJKbZ6EFGO+A3ItrqH9nVHYlEReJF2OQhAM1D7APN5rjP05A/TIBe8TtWB1H1Afk13t4ToKBbKUeyMztDqhejkf7SO7yQVbZJ+r6OyQdUP30dn/aNUbLTb60BYQarfVxusBe0gqMOB6yfe7goSLt7xt3BwdDUmIQ=
Received: from PAXPR04MB8638.eurprd04.prod.outlook.com (2603:10a6:102:21d::14)
 by PAWPR04MB9741.eurprd04.prod.outlook.com (2603:10a6:102:37e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 05:27:44 +0000
Received: from PAXPR04MB8638.eurprd04.prod.outlook.com
 ([fe80::7650:27db:4ae:b7ec]) by PAXPR04MB8638.eurprd04.prod.outlook.com
 ([fe80::7650:27db:4ae:b7ec%3]) with mapi id 15.20.6544.024; Mon, 10 Jul 2023
 05:27:44 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Varun Sethi <V.Sethi@nxp.com>
Subject: Re: [PATCH v2] arm64: dts: imx8ulp-evk: add caam jr
Thread-Topic: [PATCH v2] arm64: dts: imx8ulp-evk: add caam jr
Thread-Index: AQHZp+k2v8Jbz02GhkGV+zbcgHYc46+yh+rQ
Date:   Mon, 10 Jul 2023 05:27:44 +0000
Message-ID: <PAXPR04MB8638AD814BC6A3BFF6A822209530A@PAXPR04MB8638.eurprd04.prod.outlook.com>
References: <20230616174050.644880-1-pankaj.gupta@nxp.com>
 <DU2PR04MB86300C782DC7637C469599EC9526A@DU2PR04MB8630.eurprd04.prod.outlook.com>
In-Reply-To: <DU2PR04MB86300C782DC7637C469599EC9526A@DU2PR04MB8630.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8638:EE_|PAWPR04MB9741:EE_
x-ms-office365-filtering-correlation-id: 36d87bb8-d41f-4b14-81f1-08db810663ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WnRSyfZ+hXIuhis1mrRlCRi7vUydE/EW5abJHP5rRlLk4wwDlrHIpaICtGHoR5ybDgtoXpOy3neqQew1wQ6/gvHlrgsEU3neMbRwwG1Xz/CbCYktPRhG2JL5sslfTmAh943HYYsTaXYOHM3lJ+KP/sL93THOwF1WmHZlOlDqn56cmP7iQ2ZfCfg7W83vwl8gt0158vrXn1pxXYM4MQ8yC7NOoVPXu8Ig2z3MfyKE/uMpJLcoX0F/03KKfBUu9uJ7Q8/uI/7QeYl9JTaqUB6qcvgEP/lB4dvbrZyrEAzCuMKBoTzhRLPYgZAQIpIqweZokyF0ps8r0/cEyTXVs9BDw+pVaavYuFP9MaQnjMKuAw16e/gtk5eM2Ik/oUFtLkJfcllManiYvA7hD/RQMfSrGjxGrKXisbO46hLXu0FKdsvmNmJXSPDb6aojLXbokopuylquceft2DdKdpg+yRIaaD9vMwSTjxg+/S5JJllZvGdcJJBMxXuuubRXxD1sf36dW5C/gg//KFwkdMD90YfU2UfGYRaG6kEnhr3H2Clm7TafTU3n6TRs/NV+B7quDr5dXcisi3cp1FuwnTHV1t9CCiiD/3RKHCvBzQNwgIQ5HsDA2R15oZeJPO8vf+HUORGn0gdMvqucOaUVYTmXKEJWng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199021)(86362001)(38100700002)(38070700005)(33656002)(55016003)(71200400001)(7696005)(110136005)(76116006)(122000001)(921005)(6506007)(9686003)(53546011)(186003)(55236004)(26005)(44832011)(7416002)(5660300002)(316002)(2906002)(66556008)(52536014)(478600001)(66946007)(8676002)(8936002)(83380400001)(4326008)(64756008)(66446008)(66476007)(41300700001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dP8D6olppvMHmV2b7ZPkg+WrCP/XzGCehDVF4kiXO+wj6ur4rQtWIITfMLCu?=
 =?us-ascii?Q?4KSPg9TBAr2CeX8B9FiJfMrB5gX2eSRQQcWSf0XpezHonZ8Y/6RIqXmxhs9d?=
 =?us-ascii?Q?tqD7m2q7uyvw1sT726/7UlgMmpvhgME3wMa4KE3ivuRjE6cjH0JETcyc5NSa?=
 =?us-ascii?Q?HsnJgOCZcBltaSHXLNGkBHJqRlZLyU8bptIXdyYNGtLjp0XLlvplBfZEaEyV?=
 =?us-ascii?Q?nSC0Bmpopqmp5KtPuA6eWDeeOz857fmgiUr1RWbVCR3zB2CfNetc6IT5kodd?=
 =?us-ascii?Q?d87HGeRts01mSKBkrml11iMQ/DYt9B4PLg/v40gQz6o8qEeEjysHIViciT9b?=
 =?us-ascii?Q?YDTeZPZjbl2EACY0NWFeU0K73rXfhtAb1lNv+mBBhLLXZKsaNzHLhcbaVw1m?=
 =?us-ascii?Q?Y6+2fZh0rnCSUP4rqYvRu3z777PahPWZr3iCQIjxyM1xTdGYbsRihfsKRcfQ?=
 =?us-ascii?Q?WYRbxiWdupOKMwwTLs4sioQYXDTq37/IdI7tyRNPGQ2vSZVJtWVS1rhF9ITs?=
 =?us-ascii?Q?d7R9u+LMpKfdtgQNnksVqSd3mdSlqhwor1fpx4NWjxyi7X5S5iqaIOfVbesP?=
 =?us-ascii?Q?SOouqLoRQR8oiUZC1/3XgeRrqjboM4xci0LDXVqa7pMeBPRkiyzBcmkO9Vn7?=
 =?us-ascii?Q?3WSYFX5akhm7DPi8yYNnVxeU39KDnzjdk8j3ntvUVD/qCSB6m8TrTMmwizd+?=
 =?us-ascii?Q?PK/LurGDj3nlLtPtbW8YGn35WLSK4TUznhhd/AFaivcTia6TRfSVht6RNMhS?=
 =?us-ascii?Q?VBQTFCsVFz3ss4K5opyLVnZPt1OuQbbAc3vFik0TcsAh18zrWfShBdbEo6+l?=
 =?us-ascii?Q?fO6At7/+RoIe+FqsCol7vvPDuKRybVJEfodxGG6BT7Wp8hDh9l7W8e/Zv1Km?=
 =?us-ascii?Q?YfhqDwjbsLm9fDWcJu+nhZqvmuSQOSb8m/b3EyPp20r2ypfCcxiJmV/McWwk?=
 =?us-ascii?Q?bj5M1edZW/cuclHpTd/4z5XqA5HPBIeg/CAdugulZ3FmaWHzHZwvbdiVOZnx?=
 =?us-ascii?Q?wkjIBnEaPRJ0j4VYavzCXvdRQUqZ/RmW2+O8NI8hi3zk7wJBI37ZXBA/N4rV?=
 =?us-ascii?Q?kXVK6WbmBTwREYzq960LaeKLXD/j4h7Cy5g1w0ovTARKD8uiIy9Z7IplD9n0?=
 =?us-ascii?Q?NOc9luFhrD3BQbf9Bq0Gsrib/W3pe21jWEzbhrJdYmKjS8jcWogSLw1cYUJh?=
 =?us-ascii?Q?/t3JYpPEm+MLo55L4ufaeV4zNS/YXFXPRkfbO9Pe8hdIT4UYDGVGvhOGu2D5?=
 =?us-ascii?Q?kLSdRFBMh/CT/tVXVnhcGqHdpfD4sdTUza7tt8CrLJKBLxkf47y+Frikbgnr?=
 =?us-ascii?Q?5XJgQIuWNeHRxKxeEaOUXHE12mpLTCV9dxOtMQZr+jkI+7bTEelpvWNzaKeZ?=
 =?us-ascii?Q?jPap90xLZXqQoe59pEC0fmCBKjw5J7+ANh94dB60VNg7BJ+WQxioUASVCvUL?=
 =?us-ascii?Q?cXo62KLXl2aR/y79KLoA1/YzetAQRHbWfwkYDgYJ9ciPIEoTTkb9O1Tvj0oy?=
 =?us-ascii?Q?YZiX9QsUEcdltYuXxzKbKmdW650miAU8Cg5ZIXkt3+N3lRtBLGzu1ZfdEt0n?=
 =?us-ascii?Q?zOtYA3PjK6EB4FWvAVX71JaNtMN9qfJ/XrS6m1lN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d87bb8-d41f-4b14-81f1-08db810663ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 05:27:44.4486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2uJaowof+bFJP+9Ssr8t6hZSDvwGqoJS57f2zvN72eo570JURwNSeBcaE/R5u91rxpKMuiBRHEKsYAnKFh/Z6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9741
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Gentle reminder. Please review this patch.

Thanks.
Pankaj

> -----Original Message-----
> From: Pankaj Gupta <pankaj.gupta@nxp.com>
> Sent: Monday, June 26, 2023 10:17 AM
> To: robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> conor+dt@kernel.org; shawnguo@kernel.org; s.hauer@pengutronix.de;
> kernel@pengutronix.de; festevam@gmail.com; dl-linux-imx <linux-
> imx@nxp.com>; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Cc: Pankaj Gupta <pankaj.gupta@nxp.com>; Varun Sethi <V.Sethi@nxp.com>
> Subject: [PATCH v2] arm64: dts: imx8ulp-evk: add caam jr
>=20
> V2: Changed the email subject line.
> ------------------------------------------------
>=20
>=20
> Add crypto node in device tree for:
> - CAAM job-ring
>=20
> Signed-off-by: Varun Sethi <v.sethi@nxp.com>
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 32
> ++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> index 32193a43ff49..ce8de81cac9a 100644
> --- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> @@ -207,6 +207,38 @@ pcc3: clock-controller@292d0000 {
>  				#reset-cells =3D <1>;
>  			};
>=20
> +			crypto: crypto@292e0000 {
> +				compatible =3D "fsl,sec-v4.0";
> +				#address-cells =3D <1>;
> +				#size-cells =3D <1>;
> +				reg =3D <0x292e0000 0x10000>;
> +				ranges =3D <0 0x292e0000 0x10000>;
> +
> +				sec_jr0: jr@1000 {
> +					compatible =3D "fsl,sec-v4.0-job-ring";
> +					reg =3D <0x1000 0x1000>;
> +					interrupts =3D <GIC_SPI 82
> IRQ_TYPE_LEVEL_HIGH>;
> +				};
> +
> +				sec_jr1: jr@2000 {
> +					compatible =3D "fsl,sec-v4.0-job-ring";
> +					reg =3D <0x2000 0x1000>;
> +					interrupts =3D <GIC_SPI 82
> IRQ_TYPE_LEVEL_HIGH>;
> +				};
> +
> +				sec_jr2: jr@3000 {
> +					compatible =3D "fsl,sec-v4.0-job-ring";
> +					reg =3D <0x3000 0x1000>;
> +					interrupts =3D <GIC_SPI 82
> IRQ_TYPE_LEVEL_HIGH>;
> +				};
> +
> +				sec_jr3: jr@4000 {
> +					compatible =3D "fsl,sec-v4.0-job-ring";
> +					reg =3D <0x4000 0x1000>;
> +					interrupts =3D <GIC_SPI 82
> IRQ_TYPE_LEVEL_HIGH>;
> +				};
> +			};
> +
>  			tpm5: tpm@29340000 {
>  				compatible =3D "fsl,imx8ulp-tpm", "fsl,imx7ulp-
> tpm";
>  				reg =3D <0x29340000 0x1000>;
> --
> 2.34.1

