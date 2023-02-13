Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268D5693F5F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 09:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjBMIMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 03:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjBMIMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 03:12:43 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B913CC0B;
        Mon, 13 Feb 2023 00:12:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L050zO1VJyr16b6BXPWCLbd+V95G+CWKnU0ejcsqaM9rV3yD2MiNccDcowcXvkWJ56yrxOKxpdIwVeZNHhhYiO4k6NBFQ2Z7X+YUwGdXHEUQYincSZhTuuZQYLK0ZPk2PbUqUfSSYJtbdu516+NdBfixjfjtZg0XtMUXXmN/eT6bKhehi/3XbqDnmROg8p76NfXsoLoElM4cW5CTC4JHl4eDPCDN7azxmC4JcedBq1KszSj0o9iBv37krvqT5rYvfUo7eRqxmssHPyE6T/AQvMD7fUDP6goO+y9wg2o56KVW6YfSPCIKK52zg026YMzsGlagYHOnH20ccV4nGyAK2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yr+fPa8m/Gl2PUGxtOhHmtwXx3HAxTKTX92tiN6EADA=;
 b=BiTsKikMLK/a9Rs0f/WKPCPtSJvCOQgE40RuZzwX1YJbBYU/iD8HmEf4sjXyH0YmdYaMZCxHNhh8AzLrf2k2F8QFf+IWOdhrjbvBDpNYUKBSlXlE2BJ9lKidbZ4aMa1CcwVhHW7FmGJSeDyzCMJkxvbzaA4xLPfdvu2SKrPF+LyRTBnIANWK8pZwYQpRf5hkHuDJK+WYDb4bekF1GTgguG0MQGs4lGqzS8DDm/NFYq9PB6LbO9Mf730eriNFVfpq4aE//26GLj4atII4NKLf6n1crCENiC098creLhtFkpvIujTsrSaTgrUETjRRswxVj5YFyrAD95CIdIDjlg3wwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yr+fPa8m/Gl2PUGxtOhHmtwXx3HAxTKTX92tiN6EADA=;
 b=HCsgc9iYFQpbYjKCKU+q9AnJC6SoNKEDo3FU5ihSMHZpAyMdCmsM4zNsFQkb/jpWjROUZumVB3UGnfuYMtoWfi1k5kmeY+Keob+5scrdTYxIsLknMSEvH7G76S1ujs+HTZyo32B1pxV0Vt5kc29AcYycw0JPQXX3FKwpmzAYl+s=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBAPR04MB7272.eurprd04.prod.outlook.com (2603:10a6:10:1ad::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Mon, 13 Feb
 2023 08:12:37 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%3]) with mapi id 15.20.6086.022; Mon, 13 Feb 2023
 08:12:37 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Abel Vesa <abel.vesa@linaro.org>, Stephen Boyd <sboyd@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>
CC:     Abel Vesa <abelvesa@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] MAINTAINERS: clk: imx: Add Peng Fan as reviewer
Thread-Topic: [PATCH] MAINTAINERS: clk: imx: Add Peng Fan as reviewer
Thread-Index: AQHZP4KwEJSr3wsQR0Shg2JUVB6a1K7Mhn4A
Date:   Mon, 13 Feb 2023 08:12:37 +0000
Message-ID: <DU0PR04MB9417CA0869E867DB50A3688C88DD9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230213081038.3958833-1-abel.vesa@linaro.org>
In-Reply-To: <20230213081038.3958833-1-abel.vesa@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DBAPR04MB7272:EE_
x-ms-office365-filtering-correlation-id: 196170c0-5313-4560-495c-08db0d9a118a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9FOv+s1pWzZzJLqIBNgQyhRTTkwjvtdRDaynN99Xr60U+JtU2B1AN1S72SaDhOxQ33iiYahkeSWp7T/cO8W3Vuzm74B3W0/Dqh+CiGfygkkYgd/oBbNTopNq3JdqhvHSDKQdAc07djM0Yv3hyci4zexk+2WP63wsD91JLuz/wFyPhUb2H9cLxSvZiuUssrz3zoPWMDbW7RyPxJ3pf6xpbqgNbpssQth7CdiosTNl+uWd6MkAWCeM1LAkNvJXE739wkkB6dF+4RuJY0Gl+VmZHBPF0Y8xNcmQjYAVj8f6ICSqhqU8b3ahizG89OVa2uL4S6LhH3BD0C0BUunTSYEgWU+USxIbxvMKoGjKCjPtlSumugaUxwRDgwnrJ5zxVi0AKYaiokefDUXkE4D5wnF+LHRp5xPoGOfvejtZhV8VVtmhey6MvKGJuRCa3hfWzt1ineB8K2cHp8ZxVjjqBDLPy3m25omrzQwYcapSYpa+q32M5UJBaksZzygmzvDGoNqvtO8bodwqQjYTrtRBbPCoWo4KsS7Mhe3UgO0DJcwqaZMz3KY3IoX6r8X8553lEDVOW4kOj4bpGUER7vZfAObqnaHMkyOJet/B//EssJQ8LV+fbJmQEvnfCeTpX8anc7vP9Qjxoc+irISEtHgwt64mT9wYL4kTyD1jOdksq35WQRf9VXSWQzXeCxMQCbbhUutNo++qbQ6D8/78F5yIca5ZXw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(451199018)(8936002)(6506007)(4326008)(5660300002)(52536014)(41300700001)(33656002)(38100700002)(8676002)(66446008)(66946007)(76116006)(64756008)(71200400001)(86362001)(66476007)(66556008)(55016003)(38070700005)(478600001)(2906002)(122000001)(110136005)(26005)(316002)(4744005)(54906003)(7696005)(9686003)(44832011)(83380400001)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9KY1jb8RHEAINKgQDXbY1LoAr+xsu1VaW0CNH8x3+rcdSYPKNBLelDP97BQk?=
 =?us-ascii?Q?urah9Ze2+2KkGNWWlt2FS99E88XS8uz5GihRNN1/UyuSQ31GUNy6dodTFzr0?=
 =?us-ascii?Q?3qlQ4yv27Fn6kY5cu0L4nxOgvYKJyx/RpDncAFOb+Hir1VjRYiMVODEOdsBt?=
 =?us-ascii?Q?6cwp6fTRq6YlaH4Hm4oCg2oFdlbnwyL1XarQszSYuXSx6GyPzakoGIj5pcKo?=
 =?us-ascii?Q?bR0kKnb5eG7yzv5okyz1nDadupf0fHmeV8jQ5ujnhcADnQMPyJ8IhlpzWBQn?=
 =?us-ascii?Q?aSMwyCerupKwh5SjliNmMY4eexHjWVYkEYWq7/Cs83j8bAVWGZaX5m7mptj4?=
 =?us-ascii?Q?XP77UaTLLKWla1nVb1tHIfXCLaJaHu5mrFOO2GGdrnn0Zl7khruiajS4o6Zm?=
 =?us-ascii?Q?IRIlE/sPNIh4+8OLCqLVX86+LPzcZ3Vwi4onpvYRyEzE8Y/XxF2QL28+h5gh?=
 =?us-ascii?Q?GNoUDZTxzj4cKJfWM7GSbagneOuNW7L+ofaj++e5bW6CxhCGNL/WM8hkpOgE?=
 =?us-ascii?Q?ZrONfi8fcBIAwfOG8iZJZkm42Gkv9WILLcmijbqCZvXRAhYLk2WddaDY7VOa?=
 =?us-ascii?Q?tvEGoTVg1fxTHnjloS5J6SO38Qr0F+3vG7t7NeTMwgEXC0UEkFKMbl7R6rGE?=
 =?us-ascii?Q?VeIWXy6iRtnaovYs/LEGyXyUMB0VGut0KE9DYRKP/z3iTpDYn8SFMrI2aGe/?=
 =?us-ascii?Q?YvgVBa/jYtheSnYnck4ytzogjr0AJeO2W1pzs+ITZz+5+6x8ZIvKBjOt+Y/w?=
 =?us-ascii?Q?WGk/G1yiIXLtCyFwe0JxjWUyRH8mdP2MBvWQ12o2BTfYwDjSopoKACBGNnrl?=
 =?us-ascii?Q?f1ogjg4jBJarJVnljJWGHO7+GOG79ZkE74QVY0Vcw+HdHetyMstn0jnh3Ibc?=
 =?us-ascii?Q?od3nONjB/Qse6E9GKSU+ziRAcEOCnnFW4oph6YQ1HhDiJrPigQ3yvb0ywPPr?=
 =?us-ascii?Q?0X4X04aUVTvJQNGI1TnZnPiXWBGkxJh1WgzMMBxbwML6HQ1LSxr8G/SviF0u?=
 =?us-ascii?Q?JQVhbJ8gHAHJowOoCQ5g3pKjIICEGZQ5PpSTBHKMYH6imLK+5c27kYx2909Q?=
 =?us-ascii?Q?hBcOLO0W3e5tAEYNBbbSAKMBIO7/3LEGafeye/I++lefMMXGQcdOcZrhPNHb?=
 =?us-ascii?Q?jmFKKldpmZ7lAIQk7pfCaZ3Cw9anAZAnzYQGcC0gPFAjHQIq313u/Qc52J/k?=
 =?us-ascii?Q?vOJ9Qs5s82EYmqPFGdI1z2ISC1EuQpT8pbbWRtANm1q5E2xtiEOE8mF5h7fP?=
 =?us-ascii?Q?3iBXpsQ3+29mKwy9fYx7vhreCXFwV0GZrU8kW1jvH1ruwcKc7pmVcUrRmcOl?=
 =?us-ascii?Q?6+jnIEMbG5GsjNdeDJfwyw4RSHRMpBIytOxq9mKF9k7QlDl8xfjNofzoT5hg?=
 =?us-ascii?Q?HYMFJiRnd/3WbYQy2SMoDq2kGcFQdou1qBL2Kzg1ajn5DPYsLs+YJ1m3f0s4?=
 =?us-ascii?Q?dX4TI0/9vGgkiCs6bwy7bWPhat3N8noiueomoGMnbkMa2o2zrG0GmOaIUf0l?=
 =?us-ascii?Q?VYXnr4jRUxdowtO/xxuF1HbwcU5eogjkcG2NJ+Nq6Qlk+jwXtZfPJ3BV44bd?=
 =?us-ascii?Q?DhwhKjbztxgN+nvqn1Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 196170c0-5313-4560-495c-08db0d9a118a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2023 08:12:37.2832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BpLIuSVcK5fA8hD9tttYpbO0CDYvZcH4TEg5/R7Uf42Kn7Dq+b+pFz4vqQ9OFTZphzaTSQTMjI+3IVEIAZHmlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7272
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abel,

> Subject: [PATCH] MAINTAINERS: clk: imx: Add Peng Fan as reviewer
>=20
> Peng Fan will step up to help with reviewing.
> Add his email to the i.MX clocks drivers entry.
>=20
> Cc: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

Thanks!! Acked-by: Peng Fan <peng.fan@nxp.com>

Thanks,
Peng.

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 57d1d6ecb33d..af62e299726f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14905,6 +14905,7 @@ F:	drivers/iio/gyro/fxas21002c_spi.c
>=20
>  NXP i.MX CLOCK DRIVERS
>  M:	Abel Vesa <abelvesa@kernel.org>
> +R:	Peng Fan <peng.fan@nxp.com>
>  L:	linux-clk@vger.kernel.org
>  L:	linux-imx@nxp.com
>  S:	Maintained
> --
> 2.34.1

