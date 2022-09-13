Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16EC95B6AB1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 11:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbiIMJ3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 05:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiIMJ3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 05:29:21 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2046.outbound.protection.outlook.com [40.107.21.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A395D138;
        Tue, 13 Sep 2022 02:29:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lv6AYtnaJQ4xlk+XK8YAkPleOWQZ3Jqut9YoS9W3mid09Q+I8ELAxsNKmE0xTlZMiYBI+uTxZ7Y5rPwiT0WcUdG8QztoRyifENvQSTXMGmk5RQMmM+FX1z+eH+q8GJ0vMJIOeFMUS+bjNaemnCqIKN3BgS8vV2HIxLGXJsJH/HELGIZahGWeA1WV5kO/amshgfPNGcPJpo4rG8aVLLN1Njlx+X842V6Nd0cxvoZ8TgiGWmmDkFVurkacyaAWx6eyMh2f0c1rdl6jzoKQdeopouaMnf8hlaSevpKfC7WDLINIjnglbiOdF5UeW8SpSFnz7hPVs7VEYMRzEc4rczWbFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHebwR6qjr8IWbWSnMwJOTaF6zkAx0MmKE7inwd/SpY=;
 b=TgrkS+fayP2g66Pj+YA4rlqO8RzUzG1ohnjWAdAUfLmujCYq6cDHvb99qSnGuwA5n24Brx7EWv0UQR07ehpG2JnVqQOPz/P2D72LXFzn0Bb5sg+grsGlN9vhzaXi8JwOWeLv8a2O1S53QSu9c3zuk8/nzxw9E95ZPrAg1kpP25GSeY1w3ZKqftv+tohmv83EXUlm0JA2dIwAgE1UcdnXt9DHUUKKgIS1NlfIeU/ywdzZf3i82+wGFlWG5iwiPsiD4h6qWmJ0vV+pB1Utw26Z1tcFhVNaKiDQ4+dv4VeM7nwwIP3INGRdBf/vFlkJHeHPBu3OYeEcrTQJgqU9BnJCVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHebwR6qjr8IWbWSnMwJOTaF6zkAx0MmKE7inwd/SpY=;
 b=dTrCMRg+Fo9/Z+Pb+M6zq2hh6Gg6QsSziEdcTmMlQWAkfqknyprFgvvlTDX0rmxJN59JGXfeiVs/4kEmR9CKuk/jcR9NDhXRmqFXJGIV85tj5NEJ/u2hUzw48OIldLKJemZLugZnk+ci7/u9T6MzSQ4o2QG/5HjTyipqApMxKMI=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8398.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Tue, 13 Sep
 2022 09:29:18 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::75b7:64ed:bc9e:5354]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::75b7:64ed:bc9e:5354%5]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 09:29:17 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "abelvesa@kernel.org" <abelvesa@kernel.org>,
        "abel.vesa@linaro.org" <abel.vesa@linaro.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH V3 1/2] dt-bindings: clock: imx8m/imx93: introduce
 fsl,always-on-clocks property
Thread-Topic: [PATCH V3 1/2] dt-bindings: clock: imx8m/imx93: introduce
 fsl,always-on-clocks property
Thread-Index: AQHYx1IEc6GyPo7n/U2e0q7HAGhwja3dF+/w
Date:   Tue, 13 Sep 2022 09:29:17 +0000
Message-ID: <DU0PR04MB94170E9F1324C345A66C750688479@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220913092136.1706263-1-peng.fan@oss.nxp.com>
 <20220913092136.1706263-2-peng.fan@oss.nxp.com>
In-Reply-To: <20220913092136.1706263-2-peng.fan@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM9PR04MB8398:EE_
x-ms-office365-filtering-correlation-id: d41d79c7-b706-4434-55d0-08da956a6e76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: POVdU+OlX7NYh/xo9rPy9m+R9O+nDN83RoKb3TEV8tlkAZz1a3anutdan9OMqWTbN5O4NQDjntglbEKr1bjJTH4rgpJ9x4vlY/zAu9pglAnoCo3A+m9H7TGahyFVfMPLef9c3/NqxYSHdiXjsfVo5YRPqLGE2Nt7UbIUbSSBqAyI7ugoWNfSrcz7kIyZuzNMehvDnLSRPJOW91uGFsdFnNJWGj5OG0wSxY3uaqTmy1ql6HubVh+O5AhtXlvTRbWzLQsK/p2VMH7d10XanV/SotCrN8vftHlMIxBBLaRukt+IuIKpCIPenYQ5dWNZTg9NAOQ+xc6XOgtWi47ykXOeR7vBVqv2mzTmHUn6aLouH4yQK2/YYL1OsYYatEQ5aLzCfQUv4I+dkbMXiY2htCM4guNeXj3TsXM4CIEGUGUh7C1FwXTGxMs8ZYpwxTzN4ctS07Dt2jK1g1x3vm1sbFDQOdTzgZQT7D7Rnev17WXzu+l8qjBN9MI/R5ijymCAlmW1wt0mm2k2LWxEJWDiI5Kt+ZeyX5DN68BwoUp0/30Su5ayNVExcP1MemCQnR+2Ti6cT4753nJ6M3HiOApojYtF+TKFVLfDMspfbEV7RrU6CK7lnxufp+vANQKWlFnIyc3wMkhMzKQ6yXxGnErljtrRaPjCgOV+r3S/YW2oKJ6fohYHAjmGTAh0xo/sfUz7gngDf/UfvYFrfJfAL4QV1UE7rYk6AR+5laFEYk+JINveLuhHGIdkAnebBqVmXYP4uT/cVoqbQfVq2AbKJWyvW1ROYLscB+rKcMpS12wceYsSsbSmcjcxvX/0FfJmxlqnbywR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(451199015)(41300700001)(86362001)(44832011)(5660300002)(52536014)(71200400001)(33656002)(7416002)(38070700005)(921005)(8936002)(478600001)(66946007)(66556008)(122000001)(8676002)(76116006)(66476007)(4326008)(316002)(55016003)(110136005)(38100700002)(54906003)(64756008)(6506007)(2906002)(83380400001)(186003)(7696005)(26005)(9686003)(66446008)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wOVS8PrmHWfoVFGh/tRi13ykBOZLvA6Wz71mIWfXDlA8PCjciP1uYM+Pr8+6?=
 =?us-ascii?Q?bcAKnob2Dj7/fAuYGg1AybxfazS+ZPc3opX43S6oLLbGEDVaP23EbiIqx5o2?=
 =?us-ascii?Q?wzwYdn6HfyyUr9wYoXaEWlHnJO9SmKE9Yp/PJ/InK4dUbGYSiX1dHnYXNQtI?=
 =?us-ascii?Q?vyNs1zHh4CuC0nA2rokSi67u8ex3qDHzYqGHCUMrnyLTM0onXgJw4bg3Mw3t?=
 =?us-ascii?Q?/XLZzhU/YBEldBiMgBYYaA/FcvZ4Q4SC51tQ/817NsNUFQEvLPk6KKVmL9Ho?=
 =?us-ascii?Q?KbySL2aySPyrRZ7d2pU54yP4+y87hgAGi+KXvHeaA/IEc0EhAKF6ZtKtcO+R?=
 =?us-ascii?Q?R0UrCBQBe1ZPnOkDPMdYQJM5z3YqW2C88OLfYFQFHhpgtN4ildWrLq3ovJxq?=
 =?us-ascii?Q?P2qd+3hBUITZKkGKXGuNXTpvYfSqt3uozdhQeFfeUJb9hHRI2lqQPE4zyFhq?=
 =?us-ascii?Q?kdmXHxxiwFT0yB0SSDHENozTy+hXmf+0vht0zA3O7nD6wsxCTemtSv2PRzfo?=
 =?us-ascii?Q?2l+Whz1+qbh1IvVjLUg5MhG9btlOSgDoMASk8PN0qI+NGSRjB13licYvLW+I?=
 =?us-ascii?Q?T7ISkNIz8u6FNf//NQW7MtG6zNTr8AqIlDgzFswruI19ubUkVWyDVjLHqFAj?=
 =?us-ascii?Q?2g8gLcl4W34zrGjhNcr66jgLWdyummxaf4/It69f5T1F8UW20Tj8m6PY4NM1?=
 =?us-ascii?Q?BlXUcHQksdBlOT1M4eqhaJyJqAPe4G1edo+8mQAlBLYrmwvN61J+qNrMfcLi?=
 =?us-ascii?Q?UdDnTqL8+zI8erelemMSCvIl60/mTACn0FXhKnVl+5/aLh97vjNKqdx2m+k2?=
 =?us-ascii?Q?RKDk/QjKMMyEoIrTLXcI/iaxv74cxnZLDstFE6/7giwGaCobxi1UFnn4DIFA?=
 =?us-ascii?Q?Ot6DQ1ZRqpJ8V+GLSay+5TrN4xboZsqCqsxPoqDdktakY4zedy+o8+1Itfoa?=
 =?us-ascii?Q?p0aNmNXXMvLjNf++yrlbIdew3VEZfg9tmm1TFXn5PCAPNBRKUFFffRp/DV7X?=
 =?us-ascii?Q?dcsbOGDLvlvzoINvkv/K6hB4ioyJCzLan6qX+NjOPrdCi6U/hGv8/W99O7Jd?=
 =?us-ascii?Q?TFrRVQu6RZnkkl9RjP69589shXZbsx2UEq/ozXCrivIk5uEdHjXXkaH4iuVd?=
 =?us-ascii?Q?0INgNj5BRzTdOSdR/KbiObiLJk1Ga/kNpURRRbfHFMPbXv+CDsOjhcradZpl?=
 =?us-ascii?Q?662VyMHb8B51cbnfzisJdLcGhLU3u+3EX/b1gryuXrZ7ksCOfLyDtI8BrJXU?=
 =?us-ascii?Q?nt9o6UW2LS2sAjPvQ4BE/1vLI4lF8bDD6KXtP4dncSqbepFLI6COzsE9FnCP?=
 =?us-ascii?Q?baisNB8t2ET2UvNCfdGH1aeA5BxXZCMgC5HjyYuGmdAfn2aFu2cz7hil1nai?=
 =?us-ascii?Q?cRC9NX6qFaNrrEngdwCsuTiXSN/vGisCs/z9T3QJDQiY4vJ73ySLLmImSDUM?=
 =?us-ascii?Q?R5CSxR2/whWpfttZu9KUj2iDFK9KjMuti8n9hK+N+ISLeyGhHeGUhjaehc2i?=
 =?us-ascii?Q?OX98IxKAqFva9KnyuLUp3J6TrgoyT4NvcregkSaDkJJsQQ7COJiuLGUp1bTk?=
 =?us-ascii?Q?pRiylDT/PgBSotYEkvfeC3txRowGQS8R6cDs3IEs?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d41d79c7-b706-4434-55d0-08da956a6e76
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2022 09:29:17.8042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CqdR5dvN95eoCA8ecLKfU+8zS7LHSmFl8wZWWH4+vW8Ala1XDJ+tING+3gwJ0LtUrHDxKxEp0iueg6wg6dJN9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8398
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Missed to cc: devicetree@vger.kernel.org

> Subject: [PATCH V3 1/2] dt-bindings: clock: imx8m/imx93: introduce
> fsl,always-on-clocks property
>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> i.MX8M Linux run on top of Jailhouse hypervisor, the root cell Linux shou=
ld
> not disable clocks used by inmate.
>=20
> So introduce fsl,always-on-clocks for above case.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/clock/imx8m-clock.yaml | 4 ++++
> Documentation/devicetree/bindings/clock/imx93-clock.yaml | 4 ++++
>  2 files changed, 8 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/clock/imx8m-clock.yaml
> b/Documentation/devicetree/bindings/clock/imx8m-clock.yaml
> index 458c7645ee68..4b481737895d 100644
> --- a/Documentation/devicetree/bindings/clock/imx8m-clock.yaml
> +++ b/Documentation/devicetree/bindings/clock/imx8m-clock.yaml
> @@ -39,6 +39,10 @@ properties:
>        ID in its "clocks" phandle cell. See include/dt-bindings/clock/imx=
8m-
> clock.h
>        for the full list of i.MX8M clock IDs.
>=20
> +  fsl,always-on-clocks:
> +    description: List of the always-on-clocks.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +
>  required:
>    - compatible
>    - reg
> diff --git a/Documentation/devicetree/bindings/clock/imx93-clock.yaml
> b/Documentation/devicetree/bindings/clock/imx93-clock.yaml
> index 21a06194e4a3..2b35e8af1438 100644
> --- a/Documentation/devicetree/bindings/clock/imx93-clock.yaml
> +++ b/Documentation/devicetree/bindings/clock/imx93-clock.yaml
> @@ -43,6 +43,10 @@ properties:
>        See include/dt-bindings/clock/imx93-clock.h for the full list of
>        i.MX93 clock IDs.
>=20
> +  fsl,always-on-clocks:
> +    description: List of the always-on-clocks.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +
>  required:
>    - compatible
>    - reg
> --
> 2.37.1

