Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3333F6A6584
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 03:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjCACbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 21:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjCACbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 21:31:20 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2046.outbound.protection.outlook.com [40.107.20.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63674136DE;
        Tue, 28 Feb 2023 18:31:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYTQp//cQ3cpMnixM31/iC8LAkd67Y9yv9CQ/u4RPPdAeS1r9QsXVRTQY8rdpVJeaFCbfW3SDeYzlkGrO8gZf4Emim/vtrfT9T+waN4JBWbxpDzOVB3zV5QfFT7wY8aZWHRjXN8ZvHcg3omTuUZ5nWstNogqSGbS4uChrZRPbJydaJUfm4UesRwyqMzDSsJ9yScckoDROx5XcYpWNKTDgGnUoxCfubiPNNA9OImXffYMcyZJcrk2bXLM6mzMnLGxue6FkR6equAAt7EUucdcgxNbwJYp84wnuD3ZA1fQR7l/GAq+1ETrAvF7oaq5arDMSO3Cbq1PkxHBLPgPPif0jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pu25rw3CBr0x6LN1tcHOFYx7B0UCJjR23bdFDjW3sXU=;
 b=a1z6RbhCK0wVfeSz4npmqpXd3sQFTd+ItTTCzeeXSuB7nS2xTxkqM/JZGF4H7x5mM1Dog/XDEMVp4iIXSGfP1qlpKEdGay1josIn4yY0Pb3UWlyQS1U7Yju2IGFnvOtHTziuP7QXQapYjOaHplziQ63OXsyxqWro1/oN+SKzcNFVOaHyzTj8whAiBji+uhuT/2ecdhxSdOUW3f/KARRLi0Bz0V+Ps0guzH9/6krAnTGAW6G5eV9slAJdPq0D7apPxwGxgQoEABqcW5IMxgUnIQw7qoyhG1jjEuaSvP+5yHZgCIF8KQiCbfoX6zck+Qjx3Qptb85Sqtu4CvKPIzcy9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pu25rw3CBr0x6LN1tcHOFYx7B0UCJjR23bdFDjW3sXU=;
 b=XGyCL0Qrv1pkAX4PLhNLiVh22XoSaLWUaqAKsy5SOzb4kmpaEL0zbS/yhgF7rBJlhp/GGKLRaPYem1QpfQLYSyF2sOAcySIaq480SFTeVPmuhft205MPtRnXb7ab9gInS7O24nVlawk/oLOeVhrzETQ+TnduznZgHHjQKWdf0Z4=
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24)
 by DB9PR04MB9913.eurprd04.prod.outlook.com (2603:10a6:10:4c4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 02:31:17 +0000
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::1793:79b4:2cb7:4db]) by AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::1793:79b4:2cb7:4db%5]) with mapi id 15.20.6134.030; Wed, 1 Mar 2023
 02:31:17 +0000
From:   Jacky Bai <ping.bai@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "abelvesa@kernel.org" <abelvesa@kernel.org>,
        "abel.vesa@linaro.org" <abel.vesa@linaro.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Subject: RE: [PATCH] dt-bindings: clock: imx8m: add interrupts property
Thread-Topic: [PATCH] dt-bindings: clock: imx8m: add interrupts property
Thread-Index: AQHZS+ECotOWgCkTKUua1Qtf9bVuNK7lMhAg
Date:   Wed, 1 Mar 2023 02:31:16 +0000
Message-ID: <AS8PR04MB8642379DB76D1C529CB8960487AD9@AS8PR04MB8642.eurprd04.prod.outlook.com>
References: <20230301020122.3389102-1-peng.fan@oss.nxp.com>
In-Reply-To: <20230301020122.3389102-1-peng.fan@oss.nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8642:EE_|DB9PR04MB9913:EE_
x-ms-office365-filtering-correlation-id: fce786c7-2942-4099-527c-08db19fd08e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LV2XuN/djKRT4X4CGT2cyyEiYuHiIMo5A4w3tSDUkYx2n+LYaVxvIJMtpdW9r44RtmfV9sFIPWvJ9QTfvwbe9MSU8JHbGRQoe4XhruSHiiRGmCbOTs836bpUIRsIBhoQqblnYBESdstKd3ETtvZPQWOKurIG/ozFxzFm3OBCF0y9xuQ5ZAkiqkI8VlIKhDBMHnfKdoEiLyHTW0P1sYlssjrVKpGbGlZpJVyyL5ISUBXJCqf8oggDEJOf0JFtsxKbEL+f0pyVCint2oI1yJt1B0K5JEGtAi8/XPymSJY5930fH6/rFBny8jYPZxN83bcpzudbAi4UtI5CIQanK4mvlKeo561SJLU8XYTomOxDyTYj4jk814eiKvETmAwtWtnbMSbZsReyuf3nCq7rs7kk6t3ZgAwHEbEKZdOYnca2d+g6HYwIzZu91dSVYEs13ceM/ZbIe9CH/dqzQRiG+C6uuZ+WZ/Ybd6ftSOW8ylSBoSxSTKnAeIci3Aq4l1GoZg1vTduHJWrMPYtoP4YhYzbpMv2PUmXp5lV43ZgEgltR1nNAnUGf7852z2jnJlBrvNOeJNET7l2yJoHPJ6IS3n9UrV1LR/BSlwibEuNiyz/pMjMAQIz+5k+2B5uwHXNaTty7MkNWkpuBRPAgc3rnOQ3FkT/QaDv5IPmOdpdloEWTy5K0Hc6McVlCbJFPI5fPCWG/+8fbI7qO5ypkdbkm6qwqpEDnov6vV9B9aeennYukQe+Ln84RqU6WD1F6C4JpEKzB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(451199018)(33656002)(55016003)(54906003)(316002)(110136005)(478600001)(7416002)(8936002)(7696005)(52536014)(5660300002)(2906002)(71200400001)(66946007)(66446008)(64756008)(66556008)(4326008)(66476007)(41300700001)(8676002)(76116006)(38100700002)(921005)(38070700005)(122000001)(26005)(186003)(83380400001)(86362001)(6506007)(9686003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?doO+eTC/aI6QQ1HGk1ch2doeUlpcBEYeVzehaX0SLKPt6Ihq5z0dxRH3Zluu?=
 =?us-ascii?Q?0GCSq55CQpgJY+eknMqaMXEvZzgKKU7OQftKoqYXB5Z1RJ26pClWcg+cKfDH?=
 =?us-ascii?Q?ZHTJQPk4KvPWVufJKDzOwFpQro2MgeusNislydMsq50BCURt0Y5MnYjC+DrP?=
 =?us-ascii?Q?OQi86PasPA6NpTIjCJFaChfcM6xG3w3PCH9FotVhCvOY/1UoLBIRlKM8M8YS?=
 =?us-ascii?Q?SlQxLN8vFfv+W8fMozteLy2RFvMPpMECFCnvDnWK3mOBT/Cu/3dpRTShqQ4D?=
 =?us-ascii?Q?nBGTV6ek2D+TSbFDP+qTm3XLv8penmRjEksafKtlJFUJ7mwiblq0quKIaCi5?=
 =?us-ascii?Q?IqdAVhtqy6HU98OUyuuDQ6ikoITr0phWr699mlBs5EUUqeQopz723rIs7vx6?=
 =?us-ascii?Q?rJ6OqQGbwylRVlNOqICir0PeeNtrrXibq91Esz2r64eMkA8/CD9OA1kSUxpK?=
 =?us-ascii?Q?hWIX6IZf47H4vljGNR25IYB9SX+8m7kIe7MY8f2Wy1eriYT2/QylpvCqfNjt?=
 =?us-ascii?Q?X4RNHhdsO4qS8MhTk6wPaw+S2fpxPPpb0OB/6r7m/CfW/Vx6i9SEMQJb1o5V?=
 =?us-ascii?Q?V63AmYp5nfZCUbEovl5Ka7pfYM9qWT6w6wuJMb/mRRmKlPSUwJryVOZXyWCr?=
 =?us-ascii?Q?Ni1H61UdR1Vm+l409bENueRJvIOa5DtSSWaQwEMHcSpvzHaBQrZjKc2tZF0H?=
 =?us-ascii?Q?8MSd+fCA0hLlMBTfuX677cJixTalVZjz3USVj77SMX64mcO4WKRsuFU69O08?=
 =?us-ascii?Q?jXUbv8xPXUHw/y++HY3YUTBZd7+nSCBZRXUa0U3/hymtwBl3wSmkZoLQ/w5W?=
 =?us-ascii?Q?fw0IOSObl4PCHbP1KsTaZRMn13Nr7nucNVh+Nmgb9MTXc62ZhGPmUWKTZtuG?=
 =?us-ascii?Q?kIUROzzsKQZahUNnB/gcLm5zQCe31BIihxszv6V2AsU6GKvGiNnFLDzgejYP?=
 =?us-ascii?Q?k8JZE9olEV8Jg8WnmfML51rEFjKHecCO8wAWKuEPl+6QSDbeoyUbdR/GxSMd?=
 =?us-ascii?Q?OHsfBy3L1+SYGpYDldJfm3qeYN2uRzudqqxFURi6ib5HHqTJZ2l+c0OwwJ55?=
 =?us-ascii?Q?kgoZoCqYk0wbK2dljq9NtTYxeISAZUQUQssj5ZxygqtZs33ZMQ204DuhFN3n?=
 =?us-ascii?Q?FTbnxcVWJhaA3H4YY59aILzd0TFxaJvfXjCUIhl7aRckl1SmUmAFjO/eu/k8?=
 =?us-ascii?Q?cmHbjK6Nt93Dx0/oL+TFgRcPNLd9Zl6i004aFXSFEcle8aTZlJapdO8Eou+k?=
 =?us-ascii?Q?g0y5oerJabVeq4XNWfbT83Ant7QP8bhXz6yb2v8HcSjjqkrGlDeoOzLRUwdd?=
 =?us-ascii?Q?JmBMPIUf9Cbyhrd3EZ8gdNdcT9UoHadoD31YZUx3/HpL+H4wU3nHfN/IplhZ?=
 =?us-ascii?Q?y5mpPtHM1mGKb9qKlG4ZE7oX5FdYd6TZT3jgDu0aa3m5/hTXtRxX9nI6ti8X?=
 =?us-ascii?Q?u8QACSw0uE2rWwrEMvU9QdERv6oU73eaK1ki9kOvl4OzyxqYwhdiSXY85rGq?=
 =?us-ascii?Q?DeMLiSXQHu9WLJpZiFJLc+LTl5UGOy1p+to5sm96D8rY/13N2H25rIX3UBMA?=
 =?us-ascii?Q?DOudt473i71a3oZtJ/g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fce786c7-2942-4099-527c-08db19fd08e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2023 02:31:16.6496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2PAUWDRxC/Sm2CjW+rZyjv1cpRaYeUsM8SPXZHKSHLKqVWluN/9r5qF73W8+dALZteS4dMDSQG8hDC/DJFq7Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9913
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH] dt-bindings: clock: imx8m: add interrupts property
>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Since the CCM module could trigger interrupt, so add interrupts property =
for
> i.MX8M.
>=20

Any chance that these interrupt will be used? More likely such interrupt ar=
e useless and has no details
about how to use it in RM, just piece of words in the interrupt table.

BR

> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/clock/imx8m-clock.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/clock/imx8m-clock.yaml
> b/Documentation/devicetree/bindings/clock/imx8m-clock.yaml
> index 0dbc1433fede..ac7ad8459c79 100644
> --- a/Documentation/devicetree/bindings/clock/imx8m-clock.yaml
> +++ b/Documentation/devicetree/bindings/clock/imx8m-clock.yaml
> @@ -39,6 +39,10 @@ properties:
>        ID in its "clocks" phandle cell. See
> include/dt-bindings/clock/imx8m-clock.h
>        for the full list of i.MX8M clock IDs.
>=20
> +  interrupts:
> +    minItems: 1
> +    maxItems: 2
> +
>  required:
>    - compatible
>    - reg
> --
> 2.37.1

