Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5073F70D0C3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 03:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbjEWB7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 21:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbjEWB7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 21:59:52 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2055.outbound.protection.outlook.com [40.107.104.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4ECACD;
        Mon, 22 May 2023 18:59:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXf1HSYsfeKF5whE/LY0kmhZWgsxlpW0CY7CEg6mXXtPRKjbwJI/7WM1vSXSQYv6lc+gk/rX/y/Dj04mHpWxgvlN08UAzfM+PXRkV3rV3T+GQrsYzJ3lO2gM0CWSf5ouE/Sh6lRsKouD6H1ta39pQjA9Ap1rZGZt4FDlWvVQQaF+9rcvmjZ2SsakrUQc8ndjxUYikD50fj83aX3QmY85lpYiJpR+TV6EV5XKqhMBzvmMLSPG25jP3bZwlWm1yXBpiyutioXuDGS9SGnfE6IkpvUx7j1+H5MHJFRg2b11SFmdQUJ5qrLmRAqj1QuKecqKqJZpw30SfWsQXmluKBgVAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xaVr0uHECHjzZ89uNYkN6G/685kJnDhniQhCdK2SU7k=;
 b=cBBD2PU/2OR5Anbh8z67e0etZOcJN+NnFfTjRDTLrTbPQobXq/y1aFW6jlGYusbvYxdtOaYMwDYq35I//Xe825sMszgx/odSGNv55t603gtZErVznHe+ya3PzaJeJsQWkPEyyt3HbCrr/TVQA5Vc/4lF6ulsUEEYSJA9D0/iBhBTaFBiotfIai94lUMfBdb7esvRLUVqJrrIyVkp+SrVEeRT9ihhcz904jXYx5LzJmKvdEU7wraOhQn6BE5dy5rTPDmXjxt3Lf6BnptCGN/kZ1Ab1p7hCyT/yb3BY2wyrdtU/FSISvAp93bKMRTYnxJT0x1ln6n1vmea9ZX7S5JbVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xaVr0uHECHjzZ89uNYkN6G/685kJnDhniQhCdK2SU7k=;
 b=mlZpjRMZnioKNoSYz2s2Cb7LRUbRk6fINKQoaadfNBzyQ0xfqcbollWvkMc6j+0QVPhc/tBBIQdG6sn4uZo/hHi2DvawBPIc5FJTb/lajwVo7fA+k5uuChLdCwuW2Wi1JPLN+csJB1D2LG3Ey+tZWmMs+pqigvsA0MrG/YPxRzM=
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by PAXPR04MB8441.eurprd04.prod.outlook.com (2603:10a6:102:1d8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 01:59:47 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::5977:6fcd:63f8:aea5]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::5977:6fcd:63f8:aea5%3]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 01:59:47 +0000
From:   Alice Guo <alice.guo@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "amitk@kernel.org" <amitk@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, Peng Fan <peng.fan@nxp.com>
Subject: RE: [PATCH 0/3] thermal: qoriq_thermal: support TMU 2.1
Thread-Topic: [PATCH 0/3] thermal: qoriq_thermal: support TMU 2.1
Thread-Index: AQHZh9EEbOCsfGmsh0eUfH3lTkqbIq9nI83A
Date:   Tue, 23 May 2023 01:59:47 +0000
Message-ID: <AM6PR04MB60530CFC5198CADA2AABE71BE2409@AM6PR04MB6053.eurprd04.prod.outlook.com>
References: <20230516083746.63436-1-peng.fan@oss.nxp.com>
In-Reply-To: <20230516083746.63436-1-peng.fan@oss.nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB6053:EE_|PAXPR04MB8441:EE_
x-ms-office365-filtering-correlation-id: 851686bc-8aad-4e6c-3ac4-08db5b3162f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Il2gH5xRmPRN7hVbUXQ2dZ21VV32VmGBYRi2GDKG+u5CMO5QFYuZdbJX6pK4r0GOUzxHOdLnCpW9VZySdIVkZq1vdBLXJQXZmoqro6pAFbZ4/+x9IMcy3MulItRumhY/k1Jrz/WxPwGtMmcJXkGdXpkaSBvQgldKmlfBXEWEafyGGJcYklevBOEuZE/jOSt+HrnoRlrI4hDNJdBRC9nBo5k8VV6AcpUASL+BjVQow64Nuqi39Gha2p6QTDKygDRaleXthMZ7nCvCPzO38jQLpjO0VR2r2hCQtUcxSz0MnYqHkC2h03Zj3V1s2OGkkMxcgAedtvkWp+3Nl5XfaHOZKbrsfIKsV/8DVqmDhkaXFWsZdBkO7kUREphctS4bxp9Snas1v3qbsq/lm5PoB4ahQ9eZF+dX9cXlWVBWQrtBYoLh8nW8+J/MQ57LOECuRsIRHFzGQ4EyKPxoA9u4ngo5ICJmmLMCZ9IMfWbWriSnAdQQSc4JM8nup1W1lkn0ABXURV12ozvOvvyCH4gl81fEb7FWSRV19EPhBale6aocieZXzlaXSsP89LyCBv+lU3HaOXaUSfP5DV+FzIgtRG+v0zamLoJYWuuTp+IcXQ8szAsTGfXgsuBEBdtpQ57x6uD6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(451199021)(122000001)(38100700002)(8676002)(8936002)(38070700005)(7416002)(5660300002)(52536014)(9686003)(53546011)(55016003)(6506007)(26005)(186003)(2906002)(83380400001)(44832011)(33656002)(86362001)(71200400001)(54906003)(110136005)(316002)(66446008)(66476007)(64756008)(4326008)(66556008)(66946007)(76116006)(478600001)(41300700001)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1yTuWyKTA8uEi9qHqxK6UQ5fxh0iuWP/a8Xdj65EIx93Y3iZDV6bt7nK3rUH?=
 =?us-ascii?Q?i14BV+rDZlw99TgwUsREYfW7qPLPmYZOnoLxcv1B0jBgojvWr4ELnpSi3nz+?=
 =?us-ascii?Q?OKbsQWhvYvUKDVeFy8QxJwHa5NCLabuwkVfkr4uku1hv377rCyucEwOk1CSX?=
 =?us-ascii?Q?V9ddS5bHIwx8Y4MWjPp9pSLKOqetjS2/1qv83QIxOBuzfezYkcvZGuotaKCb?=
 =?us-ascii?Q?9PkPx7+xQ55bQQ1sNduOp/a4EAjKCQuSOk9rcoVtiT5Nr8LqKHXCDyxuDMZd?=
 =?us-ascii?Q?eqwHlv3q25I4HANMZuiDKxTIyjLIQs7A5PFABptGtVU/pOC+I4FthNcOHnck?=
 =?us-ascii?Q?VkWutcehR/Dix0nzpwvam2aj3A3bgvOEYVPzamPCsWTjVUMEUKfy7SSi549J?=
 =?us-ascii?Q?OcNSXyZqzv6pdDmKneoqy9ExBD/1/mbBdwM2MCM2NcfzAVcc6x7tymkHkpwU?=
 =?us-ascii?Q?mgZ5OQZueC6S7CmfPaiKz/n70+AOAYBgnGNrVWlpOSb2+mc7TGp1l0+FqthO?=
 =?us-ascii?Q?LCZOIsw+TVSLndWwOZyn0pYq4TeuqbBs7O7UPE6dQivlXbrqKSU/gha/yBML?=
 =?us-ascii?Q?2Eb8Q5jUYE1IfNviw929iBpC5B+HjwcuveHomkxmnWuxFEu6HNjFWy8BmeuZ?=
 =?us-ascii?Q?U8TFe9ogwvEAeB05PNPjP2scm01RD65N7aptfjCSE6GInV0K3Vyxv126Of4P?=
 =?us-ascii?Q?PyWIA/CUNnbOm/u6cAtbTwEGM8us59dO+HJFaixMhgy/It0JeNgK0D6DM0VL?=
 =?us-ascii?Q?0N9ztAETDH3QKWqz7VrL2C/efh9X/nN0qkiW8rjOfVAvZ4Hgil9OneSJqMcO?=
 =?us-ascii?Q?zf47X5t3RzgHr43JW6R+rKo0D58nX5xD4mVB2Ppt9I8IcNnd89L1jDZo37bl?=
 =?us-ascii?Q?9bbnd8aN0t1AfiadDarTmUp0GJan8ccSOQmOc6hnAcXWBmxU31PsJP/hE4qK?=
 =?us-ascii?Q?fglORcLjWjNyyktQwXPOVac+RRn4d65lJWgR35KkH/UtjEUeszI6807QdAKd?=
 =?us-ascii?Q?eHUypkT2WKsWS8InvipGi4B3fBpdyJAJyZ7vjPPYOk4PBcwsNZQDB0I/B9Fr?=
 =?us-ascii?Q?z4RAdeL6YpclNJE8/O1trOElLQED+814sB91tXog02zCkQrlqEZAvp5wVIgl?=
 =?us-ascii?Q?9ASxzdaFLOy4vPSkGJLj+Rr2oOYRur5+ubkhQEvm62KSlczs0kHDKG027NJK?=
 =?us-ascii?Q?IjJ+eBLCc+pnA60RJ5YrxRZ6QrO+7S5+w7EeLYmGsc0y1yvSYV21J4724YDJ?=
 =?us-ascii?Q?pk1vJDgXbRsT3vG6iNsO2W1LH770jjsQio8TqgprHlmlQ6l088bxrMhBr3yV?=
 =?us-ascii?Q?ZaevMYIRIezrfmVtau4OACnLB54edQIVwKmhaZYhSPOsgqrrQROcsAAcI13T?=
 =?us-ascii?Q?Zc5nff3dfkFiL5XFQv/+zHhWKMC7d+rLt8TcCrWkWY7y9obFpc53Sc6khyqe?=
 =?us-ascii?Q?uR0WsdU5RC3SMiDo+yC8TsLoMI9XUJprWbqGvZvpyeVFtyjFj0t8MyghL5rQ?=
 =?us-ascii?Q?dobxcLYnTGc3vev7MLZN4IDt5kgF7ksnaWyxxl11w3KBNeVAmKXuPZZM3RQd?=
 =?us-ascii?Q?T/8inuIzObux+pEC9Qw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 851686bc-8aad-4e6c-3ac4-08db5b3162f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2023 01:59:47.5034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rzhdGYaAqF5v1+K10kv2gXDq3LChakkMHy0o1gcA8j28K+b6BMWn1deyBCWnBXxXSXLePF5M+VbateZtaPg9NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8441
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

For this patchset, Reviewed-by: Alice Guo <alice.guo@nxp.com>.

Best Regards,
Alice Guo

> -----Original Message-----
> From: Peng Fan (OSS) <peng.fan@oss.nxp.com>
> Sent: Tuesday, May 16, 2023 4:38 PM
> To: rafael@kernel.org; daniel.lezcano@linaro.org; shawnguo@kernel.org;
> s.hauer@pengutronix.de
> Cc: amitk@kernel.org; rui.zhang@intel.com; andrew.smirnov@gmail.com;
> linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org;
> kernel@pengutronix.de; festevam@gmail.com; dl-linux-imx
> <linux-imx@nxp.com>; linux-arm-kernel@lists.infradead.org; Alice Guo
> <alice.guo@nxp.com>; Peng Fan <peng.fan@nxp.com>
> Subject: [PATCH 0/3] thermal: qoriq_thermal: support TMU 2.1
>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> i.MX93 use same TMU IP as Qoriq, but with version 2.1, so update the driv=
er to
> support 2.1.
>=20
> This patch also includes a fix for i.MX8MQ
>=20
> Pankit Garg (1):
>   thermal: qoriq_thermal: No need to program site adjustment register
>=20
> Peng Fan (2):
>   thermal: qoriq_thermal: only enable supported sensors
>   thermal: qoriq: support version 2.1
>=20
>  drivers/thermal/qoriq_thermal.c | 48 ++++++++++++++++++++-------------
>  1 file changed, 29 insertions(+), 19 deletions(-)
>=20
> --
> 2.37.1

