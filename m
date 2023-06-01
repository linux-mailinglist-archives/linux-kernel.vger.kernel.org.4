Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF1E7197B7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 11:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbjFAJwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 05:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbjFAJwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:52:07 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2082.outbound.protection.outlook.com [40.107.104.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746E9F2;
        Thu,  1 Jun 2023 02:52:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RkbAxb2+MoL1ctBUQT8ScDeZ1eS1PBjSgb4vJ4hemnX7Y7VPuQeWKy2aS/s3Y9RR0kL8DjT95tPX4vjjpWkudn0cpwX+T4BnlCb8an6Tpl9YeSEHHL6rHcj04ccleK5wQHowf+IzBe0PiN+tWRAW8jM/a5jsOm7lPUpg96hDHdFMclHrkDMIa2EoOm9DQGkoOXUuk4rXbY1aPQsDdW+pq7l2uIBhaPRS44TZ87gF6zyqrYmFztf/Xxw1KZ3gX+Hl+NHH6Nmm3wkHU4pbyWXdIH/VQUacQALdE1ksIn5IbxTkRzNWYE1HOYXBDbyhlpVpVK5Y2z048Bl8NBIfNI1UIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MbdLR+4K07qJ8d95WOX0PYPmOeZJvPTuvmhq8rMUyL8=;
 b=HUkM/xdwoQutHR0zBAYqeFFmS54tWTPXkzyJgRtzR1TJVWKcvSRGiNbjkkzdhlakOO1IbOL5Ij8pNmjAvcMaIjJZCcute6FVfkHkPK5+Ow8yv4qq8rkC5BgEgPGfw8M2A22luH405BJPlML5YHm668s8vX6meBCUjo6hl4ai9xKyPSqVBbdQX4vgpWXXqj0XrO7/2VPHvwypR/AQ1QjKhSR5SGgGJQK3S/LQclTlVIW29279z5BoJ5o4p1f49wsvBEIRvuljR0vWR0b/bJ7l2lQsz4SjNTofHhpVINZOyRC/aevV/08QnlxyOeEB4/DsCL4ldnUuCyZRL3JqWOP1KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbdLR+4K07qJ8d95WOX0PYPmOeZJvPTuvmhq8rMUyL8=;
 b=CRGItGLLtvaxkOi5aMy3mth1A8gPxEP5TfMFDaka5j/bSKazTvWq6CtSCuFq+xFBVJ/+ARF0H0SS6en7XANap5n5fJPPKwR9Y5oMu96sAV6F2qTT01LPaC4wn+3846u3hgLCLGRfXWmN0hCjYR50579ty8w0aXuj4Lvk/Hwhjx4=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7887.eurprd04.prod.outlook.com (2603:10a6:102:c9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Thu, 1 Jun
 2023 09:52:02 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::7b3d:4c2a:1636:da28]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::7b3d:4c2a:1636:da28%6]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 09:52:01 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
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
        <linux-arm-kernel@lists.infradead.org>,
        Alice Guo <alice.guo@nxp.com>
Subject: RE: [PATCH 2/3] thermal: qoriq_thermal: only enable supported sensors
Thread-Topic: [PATCH 2/3] thermal: qoriq_thermal: only enable supported
 sensors
Thread-Index: AQHZh9EJboPf4XvfUEydyH3VnYRxsK90T2iAgAAQueCAAAjlAIAABicQgAFdYKA=
Date:   Thu, 1 Jun 2023 09:52:01 +0000
Message-ID: <DU0PR04MB9417D574603B54AEF76480AE88499@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230516083746.63436-1-peng.fan@oss.nxp.com>
 <20230516083746.63436-3-peng.fan@oss.nxp.com>
 <3c59c4e0-68eb-b778-6b12-9f9e331f81dd@linaro.org>
 <PA4PR04MB94165217C8C0D9E8E0087AF988489@PA4PR04MB9416.eurprd04.prod.outlook.com>
 <01197bb8-da0d-f726-79bc-d8ab7d3ea992@linaro.org>
 <DU0PR04MB9417D9020578083527FC16C888489@DU0PR04MB9417.eurprd04.prod.outlook.com>
In-Reply-To: <DU0PR04MB9417D9020578083527FC16C888489@DU0PR04MB9417.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PA4PR04MB7887:EE_
x-ms-office365-filtering-correlation-id: d625ce7c-b258-48c3-eca0-08db6285d943
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lMWoBnqiHc8TDc31Gu5OrpRF480OICnrc5vHwnaaAhkDIgkFsC6FgS7cXDbdqt4edRBKoWIRPsh2KkJ85iO4ObwAkLLVzeOUQADTlwMAZMd293fTjUhUSq/PZ0VabrLZE5DS+YPqSv/wpISlwv0NPNvXGqUkP+6CtGj34ac9aWWFLhvhcj/PwE6UR1MhM6pcFMepTuwyjZw8gg/YApMr6a5kx32nSERlH0s5gnB1jej4D4bDtmBWbZI1S6B8pj2WCi0MTUJuR6PxsAxFtgGzlV9rt/wEVy8chkCT9KNxRM1GiGoygq5pGGr/2xloVfniYwIkdS0Epqnmwp6i3dkPWSIwI2Ft1dYdgdvxrd7RezmeVT6U7GTPvezc45FDHwbKQYni7jYWPI34vPQtiG43GqEvx57h1VtpyCsjS7DyrJMTaczAdME1Jz26TQMiN0+cE3TbmJMKsNPVsaqWVYY4YJidx03+YkCTwPLHIPyhgVP+xohz/AO0cWbxfx32Qw4o1TNQt7hv2NcM1zRcFOZSOhHxxJ2VX0s6Ai1q/k7jjLTlihHZUvsTVSsVFyDoqBrQIVRmErG78GsxebJUKTasbvGwZH1HRjzXu0dzuwlNaCSC9T/RoQ2t2bF9nSqLi3b8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(376002)(396003)(346002)(451199021)(122000001)(38100700002)(86362001)(33656002)(38070700005)(8676002)(41300700001)(26005)(44832011)(6506007)(7416002)(53546011)(5660300002)(52536014)(9686003)(55016003)(8936002)(2906002)(186003)(83380400001)(71200400001)(66556008)(478600001)(316002)(66946007)(66446008)(66476007)(76116006)(54906003)(110136005)(7696005)(64756008)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?koi8-r?Q?Lvwnq4SvCIxUpE9e3+zbJR5nfudnL/XvUQnPI/mqehJKjZ4a+69xEHZFAhk2DW?=
 =?koi8-r?Q?ZlXqBsElP76h8rJy69w22anQTK83cIzgdZ+s4GVfaHRFzs1/3B883F69U1a1em?=
 =?koi8-r?Q?c94XDlvNk0qEnCtchnhIdFRIdezZNVrI+TAFUSzlklKNpwICuR6iUJeELwvqy/?=
 =?koi8-r?Q?TbK/6E4+rTfsuqu2bZfQfbwLYlaVW6OPwS9AZq49+AWMzMutYTIxJKwNzyfKW+?=
 =?koi8-r?Q?A2Y/7xrNyaeoFtAoISSB2WW2vtrQRf7Gi9q6nHjzHanVr7oTJm33k5fHn3CCsg?=
 =?koi8-r?Q?wPullYvQLnKpSa3bAyt5CeKvH+dFONoIZ0o1Zxm97zrdspbZIk9MdfDOIkgP/z?=
 =?koi8-r?Q?Eqc59hM7pQiReI8l+zs40HuS6knXcsHHN+7dCjREW6lRhc2NKnNHzFvQvxuSpn?=
 =?koi8-r?Q?AmCh2TyoK86SnaK8kxEEMF5awPjTdhK8bkGekhmAsCuvbIL06GjQ3omwpVD7zq?=
 =?koi8-r?Q?gJqhnSZt12ezWApnsa0xbvEHThZtwrHO6C6YArtK2tdNMo4auX8yLwcTpOj9ZH?=
 =?koi8-r?Q?Oj5xvq9cchmNBBwTC2RZ5B3tQo8PNJr18aQMjYbl4rQKLfI2vw9sRWpMJR8F9w?=
 =?koi8-r?Q?CHE0ciQG78/qt2/ohgjQkWl+vlhmzlcTszuMC9hP93XskxynqiTE66JlGI32rj?=
 =?koi8-r?Q?MXULuZoTm5MiaQ63Z/k3gtqPQW2cKsF7RHlvtgPgjzR13ujys1qKXTTKAiKl1P?=
 =?koi8-r?Q?55Yg9lOnC2k7St6+HUrmP/6/iG3OBwZiJMxGxX+Sij6hBYq0LMhtju14s4YmXU?=
 =?koi8-r?Q?Ki/0jVd7GpkQmw8oA8EYLopighp3CL+vuJZch20/5sqtTcyYISAJhV6AErivlQ?=
 =?koi8-r?Q?XJLopuc2Zpg+z5dPPkvGqSVzxNtwnkcQ6dsz9P0vNMPtLmRjK0pv0b00OsBjdz?=
 =?koi8-r?Q?eOiOT8cGBjrZ3HHpGaWTJB6Uen4TYN9vWa6B8Qz01pydeV+JZ38WIZdnjmY/Th?=
 =?koi8-r?Q?kOy1MZ8KfS2XDEiGJeM0ltyvYpJMIKxp/jx9Tb6Te1G0vGCkEdSPRts1XdGGqa?=
 =?koi8-r?Q?ue+7b0ZncuMZKcc/2EwUBa5ZV6GR6KZ0ezpMYKjKm0AwQjs0EpVbK7f7o24Shl?=
 =?koi8-r?Q?HoQdGfZ7Co2Qaou8Arf0Bq2MXbUye8odSTbzPuvpF1KGxhNmMgSQpmEgahd43R?=
 =?koi8-r?Q?IB5XQsLpRy1x/pR4gaxT7o+rIg/AnwKsWZEE+vlX3f8Zavqwhu2j17RtD7D36E?=
 =?koi8-r?Q?TTDObwkfuzhJAtw6EAxxb7Zd0Q9ecEzjZBifb0rNSyA8d7WVp3ca5ZDwyevGhS?=
 =?koi8-r?Q?B9eN1Qlp5jVLLsevTruMr51rCNuifrjOVfOWgcxdi3UP6b6dlFV/VDrDNdlKPq?=
 =?koi8-r?Q?yekJd5TNKduHdsiuqWjzD31eX68BqY8rmu1MUNQf7EjGr/vgMeRpOehbv8g7AF?=
 =?koi8-r?Q?aZSucGzReh6ArFeNs6j88sQVaDbZlTYSgb2y2H/nMl4Z3UJ5NNmL58Sne45FF0?=
 =?koi8-r?Q?CDYBfXbXfo5ONsemLFcqBoEasTTwo+Y9zX6YUpeCfcZ5YR7GWd9sYb+elw7LX6?=
 =?koi8-r?Q?zW5n5oRBHIyXJwkYMjdeKqwkZxr5k=3D?=
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d625ce7c-b258-48c3-eca0-08db6285d943
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2023 09:52:01.7959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l56GJ0szGpwiCS2hdZNuhtmZNEMIMvtNWL+mMLBUv0ZM2HOah+y6AzaOL4WcDJhwlSA/pRHm9EbblrwMS7S8VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7887
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

> Subject: RE: [PATCH 2/3] thermal: qoriq_thermal: only enable supported
> sensors
>=20
> > Subject: Re: [PATCH 2/3] thermal: qoriq_thermal: only enable supported
> > sensors
> >
> > On 31/05/2023 14:05, Peng Fan wrote:
> > >> Subject: Re: [PATCH 2/3] thermal: qoriq_thermal: only enable
> > >> supported sensors
> > >>
> > >> On 16/05/2023 10:37, Peng Fan (OSS) wrote:
> > >>> From: Peng Fan <peng.fan@nxp.com>
> > >>>
> > >>> There are MAX 16 sensors, but not all of them supported. Such as
> > >>> i.MX8MQ, there are only 3 sensors. Enabling all 16 sensors will
> > >>> touch reserved bits from i.MX8MQ reference mannual, and TMU will
> > >>> stuck, temperature will not update anymore.
> > >>>
> > >>> Fixes: 45038e03d633 ("thermal: qoriq: Enable all sensors before
> > >>> registering them")
> > >>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > >>> ---
> > >>>    drivers/thermal/qoriq_thermal.c | 30 +++++++++++++++++++--------=
--
> -
> > >>>    1 file changed, 19 insertions(+), 11 deletions(-)
> > >>>
> > >>> diff --git a/drivers/thermal/qoriq_thermal.c
> > >>> b/drivers/thermal/qoriq_thermal.c index
> b806a0929459..53748c4a5be1
> > >>> 100644
> > >>> --- a/drivers/thermal/qoriq_thermal.c
> > >>> +++ b/drivers/thermal/qoriq_thermal.c
> > >>> @@ -31,7 +31,6 @@
> > >>>    #define TMR_DISABLE	0x0
> > >>>    #define TMR_ME		0x80000000
> > >>>    #define TMR_ALPF	0x0c000000
> > >>> -#define TMR_MSITE_ALL	GENMASK(15, 0)
> > >>>
> > >>>    #define REGS_TMTMIR	0x008	/* Temperature measurement
> > >> interval Register */
> > >>>    #define TMTMIR_DEFAULT	0x0000000f
> > >>> @@ -105,6 +104,11 @@ static int tmu_get_temp(struct
> > >> thermal_zone_device *tz, int *temp)
> > >>>    	 * within sensor range. TEMP is an 9 bit value representing
> > >>>    	 * temperature in KelVin.
> > >>>    	 */
> > >>> +
> > >>> +	regmap_read(qdata->regmap, REGS_TMR, &val);
> > >>> +	if (!(val & TMR_ME))
> > >>> +		return -EAGAIN;
> > >>
> > >> How is this change related to what is described in the changelog?
> > >
> > > devm_thermal_zone_of_sensor_register will invoke get temp, since we
> > > reverted the 45038e03d633 did, we need to check TMR_ME to avoid
> > return
> > > invalid temperature.
> >
> >
> >  From a higher perspective if the sensor won't be enabled, then the
> > thermal zone should not be registered, the get_temp won't happen on a
> > disabled sensor and this test won't be necessary, no ?

After thinking more, I'd prefer current logic.

We rely on devm_thermal_of_zone_register's return value to know
whether there is a valid zone, then set sites bit, and after collected
all site bits, we enable the thermal IP.

If move the enabling thermal IP before devm_thermal_of_zone_register,
We need check dtb thermal zone, to know which zone is valid for current
thermal IP. This would complicate the design.

So just checking the enabling bit in get temperature would be much
simpler, and there just a small window before enabling thermal IP.

Thanks,
Peng.

>=20
> Agree, let me move the temp sensor enabling before register thermal zone.
>=20
> Thanks,
> Peng.
>=20
> >
> > --
> >
> <https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fww
> >
> w.linaro.org%2F&data=3D05%7C01%7Cpeng.fan%40nxp.com%7C2a5070b5049
> >
> 14957160008db61d37861%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7
> >
> C0%7C638211333111330055%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
> > wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%
> >
> 7C%7C%7C&sdata=3DaJBF2UEqaCAqcAbHcKzbGReVv6pbYlyQ25riVxEdG08%3D
> > &reserved=3D0> Linaro.org =81 Open source software for ARM SoCs
> >
> > Follow Linaro:
> >
> <https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fww
> >
> w.facebook.com%2Fpages%2FLinaro&data=3D05%7C01%7Cpeng.fan%40nxp.c
> >
> om%7C2a5070b504914957160008db61d37861%7C686ea1d3bc2b4c6fa92cd
> >
> 99c5c301635%7C0%7C0%7C638211333111330055%7CUnknown%7CTWFpb
> >
> GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI
> >
> 6Mn0%3D%7C3000%7C%7C%7C&sdata=3D9l627puhL7hQgMlPWaKkCIDkQKGX
> > TH49rEM0NFipvDs%3D&reserved=3D0> Facebook |
> >
> <https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Ftwit
> > t
> er.com%2F%23!%2Flinaroorg&data=3D05%7C01%7Cpeng.fan%40nxp.com%7C
> >
> 2a5070b504914957160008db61d37861%7C686ea1d3bc2b4c6fa92cd99c5c30
> >
> 1635%7C0%7C0%7C638211333111330055%7CUnknown%7CTWFpbGZsb3d8
> >
> eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> >
> D%7C3000%7C%7C%7C&sdata=3D%2B0Oa%2BrxHmGPga0%2BGQjOOX6Dxaiuj
> > oPJhzwqBjjO%2B2Qo%3D&reserved=3D0> Twitter |
> >
> <https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fww
> > w.linaro.org%2Flinaro-
> >
> blog%2F&data=3D05%7C01%7Cpeng.fan%40nxp.com%7C2a5070b5049149571
> >
> 60008db61d37861%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C
> >
> 638211333111330055%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
> >
> MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C
> > %7C&sdata=3D2lfwzPj3p%2BjowtVDc03plo1Ds%2BnT%2B2eSwdTQ9yQosfo
> %3
> > D&reserved=3D0> Blog

