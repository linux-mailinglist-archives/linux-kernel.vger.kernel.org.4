Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22FE37180ED
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236090AbjEaNCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236120AbjEaNCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:02:31 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2058.outbound.protection.outlook.com [40.107.20.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280EBE61;
        Wed, 31 May 2023 06:01:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kp7IYNgOdOkNgY8mUwYKy11JgsacO6gIJuVhFPBdxln3PM5YkVIvLvalixNwcgALbQf2AhtcuDTZIY79uVP3+thx0YRG1eVYhqjmeQ8kSbH4XgwDJd2j+c6uXX5MyfqdRl0iwfL/9DB3/z+CWLxzoNt7axL08qff5EzoI0S37pgbeqq75oE2I7dg0w3x5GWswXbyC+jtn0M02z9CjTaq7cV9yYw1HIBDz2BvOlaqvQA8k8E5mnqab+ZzPPQCK/TE1UD8jwxD85MA71pXEGLVpWC7Fk/IZMKLXEa9SK3riRmTDtQKPk4StNWUrTC9hQpHg8xQgNS2YxVNoInV2OASaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGrUiEhJKSXFv5N9yjXvfuM4iHzt+OcfgyVFqRib7kM=;
 b=m3kLS/BNvoLxNP3SuyWcAUWuFLGJ5Vr8yb6kvWow0hi4ADHuKQaRr2geZV1WLko4Iby/kx6tzGhUY57cnVNE9KsbcpmBzjc1t89xpyyyHORJ9YEAc96HxHzkDgj69vMPLuZBhttTGd/595W+d0vIV2xOuP9/sOFiboqB1l4/gF0v+C/LyRJtlwOiZGjPnrvgTxiysXWuVnuQXLBUVQvDT9iEwuaJoViqe5j9KjNAWKWJAt/ZlttbkmQ7Q2+9kAJT7jG+vQhOQpH8VX4Z4z6IFhnEvWnKacyJA7yyGPWk5sPMETZ4suITRL5PD+p5V4aD38ps4SvURBZ6WxrNtVDVMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGrUiEhJKSXFv5N9yjXvfuM4iHzt+OcfgyVFqRib7kM=;
 b=IXEcSSey0qt6b3zKJsn0aCp0RaJ3D0pbML8JhCB9/54bpqFV/gtGbYs9PjSpg7JRB1VzMdFd69ornuvIVNSUosRm4EE2JUKcn/MJTgZn+wXeEAHaL2d0pi9ttBDng+4AzKKWmcYdmZEHJjDmBbf+fCreeVipZ++Er3IYrgdRBmg=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8979.eurprd04.prod.outlook.com (2603:10a6:20b:42e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Wed, 31 May
 2023 13:00:27 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::7b3d:4c2a:1636:da28]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::7b3d:4c2a:1636:da28%6]) with mapi id 15.20.6455.020; Wed, 31 May 2023
 13:00:27 +0000
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
Thread-Index: AQHZh9EJboPf4XvfUEydyH3VnYRxsK90T2iAgAAQueCAAAjlAIAABicQ
Date:   Wed, 31 May 2023 13:00:26 +0000
Message-ID: <DU0PR04MB9417D9020578083527FC16C888489@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230516083746.63436-1-peng.fan@oss.nxp.com>
 <20230516083746.63436-3-peng.fan@oss.nxp.com>
 <3c59c4e0-68eb-b778-6b12-9f9e331f81dd@linaro.org>
 <PA4PR04MB94165217C8C0D9E8E0087AF988489@PA4PR04MB9416.eurprd04.prod.outlook.com>
 <01197bb8-da0d-f726-79bc-d8ab7d3ea992@linaro.org>
In-Reply-To: <01197bb8-da0d-f726-79bc-d8ab7d3ea992@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS8PR04MB8979:EE_
x-ms-office365-filtering-correlation-id: d86621e3-0df1-4c8b-f7c1-08db61d70133
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 27th5SCfqxqIozdyQmyFd7dd21JvGpwPwK/EJ8p5HfOqUddJyRrTRzbabActI9yVGUNeZxM2CUGTN1JH/V4/drgYAATvLVbLEHF1tEH1JldfTE9xZla321+AFaMsdRzEzaDglGgrXdhDiJ8zEs/O56MTxo3M6RYN6NwE7om5B2q0IAbf9l/cotW/LDNwcE6uKC+egs043MTd/WAgARINObiecrg1pK8f2ERIpVFGnoXSNd1r12kNSR/4jZQ7+fi1QYAdUV5H/7WT96RZPUwZuKyr4n1hX4TvDRsRwGpfiWvvPgvaHlXLWimR0fIa7N5+ZPvAcle5uZwJgYzwAQkowl4Roe3tuPQph2lF5xbTBomDmK1GVpw36vVNcvEAR0D2Z7P6I00BcFhFAbtM4f1Kow/Sh8PONRH53Tge7KgfkzYXkEs6eeobb46Tn69laC7VrCdI80jeYCLREUo+kYzvGs4dmDBbBEBI1Br3vYFXdiCZHRVmPBD3snoylLlgEF+bHKnHtvTGnDbllOQ21G3nxUjsPD+/Bjjjdq84AHSHETYN9oUZ8YTleuIUzcMcPhBd/z8K1QLgy4Ny/0Ah/2D+4oV5e/uK9pKLOE/ZjBLG5tY0NdvaLXgCWpG3v6AD3jLc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(451199021)(186003)(33656002)(7416002)(86362001)(54906003)(110136005)(71200400001)(44832011)(53546011)(9686003)(6506007)(83380400001)(38070700005)(76116006)(66476007)(66946007)(66556008)(64756008)(2906002)(66446008)(316002)(38100700002)(52536014)(478600001)(7696005)(55016003)(5660300002)(4326008)(122000001)(41300700001)(8676002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?koi8-r?Q?2hAtITRb+4aV8lpg9bJRZRgYRlUUfRQYwDFA2RjIFq1wvw68wiBUPNzT6ewAL1?=
 =?koi8-r?Q?C5H/b3+sZ49hZfFQq7ZZSa8tB3mgSBrA7iw26Zu7SADLtrFHIy8z0dPfvDz6vU?=
 =?koi8-r?Q?KhfWjWnCr705bSlcZpvY62pg719IKApVcOloEYysrwFoAV3JUtRTx+n0HJsjXw?=
 =?koi8-r?Q?tHjCMbSfzSN8L5STNsahq/xs7jhBXc4nJTtHivkOyaJTH/7faOJLaotVhuhc6E?=
 =?koi8-r?Q?wE+Qs0/LTJs+sg2nocUBER/vEfS78tPt0xCaoLyUJckepj/mLlD01GBtTfe6j9?=
 =?koi8-r?Q?5agK3oag92KR4PMqiez+x+UN4DgYHvRz/JEqmARABZD0VwzF/P1WmwXJVxoCHO?=
 =?koi8-r?Q?ncxZkMNvrWxl2pCWrEikWW3rJVchJ60ioU4WSlXmqseYe4rpne2ig7IXqfYfIY?=
 =?koi8-r?Q?HDCT2QJ/fZ+IMGGEKObTzw2FV+WSwiU/VSJu0Zlx6VyOAmnD/76uT+Mov7lHGR?=
 =?koi8-r?Q?c4DWFubRxgdIQehT+ZAVxAVQC/B4RQm7ooNjKTdhFznuqeoPc77ZER9LGUq+By?=
 =?koi8-r?Q?+Vkd8xcJnoFPcXHJa2DI9oICkYNaXNj05SzLcixWtxh6fWefjP9npaj/5y+f8v?=
 =?koi8-r?Q?KTv/8jlwUAEK2eBp2tpPjzB1ZoYShyfL13EYXcjvzBBbB+4fh6HXzmLUWsE31d?=
 =?koi8-r?Q?Pkv5e0j7JP4G+1VuAVg8+CyaxDZ3oJqyIA3PIw52teU9UjHExYPfq/QiKnBkmD?=
 =?koi8-r?Q?bmbKF6CXp2gq6lJY5rpgaZb/P0XIp2phmtLwluLQDCYevQO6eqSnv4D4IIIAfI?=
 =?koi8-r?Q?HEbRByp9J53Xk6UJXJTjO4t6W5ZSeF+iKVyDo6oq0FgxyNgrJ5+/u1dWx96jp/?=
 =?koi8-r?Q?GfSUk5m7nq7xbAvVMZLD88KviPFINYJ4vTfyz3YB0WWBy6SNXn8LkaqVgKK9E0?=
 =?koi8-r?Q?raP7g4j/b4HdRCG1xv4M1XOZMiEdhm9Oze2W+KnAh0fmlhql+VKxY7K1+YERt7?=
 =?koi8-r?Q?KGZ9WQt/xeTURqF+aobE1zGUya+U1wN4WxgjiSnne/aQv/av9UY3+eHoe1tgCc?=
 =?koi8-r?Q?YoljtrDphjvMUU9mke/PtwVkBQkCPMnrXlRVYu+ScOsYPeem3Y9ljchofifOUJ?=
 =?koi8-r?Q?PMnzM3imcGWCPhcOr/NLZIOetfNbpu28er76rfDtPWnUcAd7+V2EMJDV2mWKbu?=
 =?koi8-r?Q?Y89tHdf+Uf2FpT2rQ1RdzMHSkJ1WfWb5J/4FGhL81HIwpc63X+AvLRxjd2MsvC?=
 =?koi8-r?Q?Jmg3KHi/jI5HpLrg0ozBbVxuerWCAsy0hpJr87P2KXjooPBqiqZh40xfM2+ob8?=
 =?koi8-r?Q?iNADnkwMzPZoolwi4teRAQDEPsgDJHsGq74NypQMEXLRseWDzn14xN0L+fQhUd?=
 =?koi8-r?Q?Odmsh981mhcUWlBFK2HdnWbD1tPu2tvFgtvKAxf87nSGNSW5+qQyBPTPv1u/ZZ?=
 =?koi8-r?Q?qY+yNlaqM49CDpV31L30bwaASozankVJXMaVyu/UV+iugyN6DPmCHdJ0X4LN4P?=
 =?koi8-r?Q?+Dh8w2iR5ApD/5agiBBZKhHwJRRtJnPcFyHoYyuQnb+tv1BJYgtWE/tGQ2F3uS?=
 =?koi8-r?Q?8PqJNBGA=3D=3D?=
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d86621e3-0df1-4c8b-f7c1-08db61d70133
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 13:00:26.9094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mrr0iSeZacIx0EnSzgpTubCyc41P7E96HOumCgpglAJfEI3fKRG7Y85aHMLpKm3vGAm56YsTYMB2sMhZ5A7o3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8979
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH 2/3] thermal: qoriq_thermal: only enable supported
> sensors
>=20
> On 31/05/2023 14:05, Peng Fan wrote:
> >> Subject: Re: [PATCH 2/3] thermal: qoriq_thermal: only enable
> >> supported sensors
> >>
> >> On 16/05/2023 10:37, Peng Fan (OSS) wrote:
> >>> From: Peng Fan <peng.fan@nxp.com>
> >>>
> >>> There are MAX 16 sensors, but not all of them supported. Such as
> >>> i.MX8MQ, there are only 3 sensors. Enabling all 16 sensors will
> >>> touch reserved bits from i.MX8MQ reference mannual, and TMU will
> >>> stuck, temperature will not update anymore.
> >>>
> >>> Fixes: 45038e03d633 ("thermal: qoriq: Enable all sensors before
> >>> registering them")
> >>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> >>> ---
> >>>    drivers/thermal/qoriq_thermal.c | 30 +++++++++++++++++++----------=
-
> >>>    1 file changed, 19 insertions(+), 11 deletions(-)
> >>>
> >>> diff --git a/drivers/thermal/qoriq_thermal.c
> >>> b/drivers/thermal/qoriq_thermal.c index b806a0929459..53748c4a5be1
> >>> 100644
> >>> --- a/drivers/thermal/qoriq_thermal.c
> >>> +++ b/drivers/thermal/qoriq_thermal.c
> >>> @@ -31,7 +31,6 @@
> >>>    #define TMR_DISABLE	0x0
> >>>    #define TMR_ME		0x80000000
> >>>    #define TMR_ALPF	0x0c000000
> >>> -#define TMR_MSITE_ALL	GENMASK(15, 0)
> >>>
> >>>    #define REGS_TMTMIR	0x008	/* Temperature measurement
> >> interval Register */
> >>>    #define TMTMIR_DEFAULT	0x0000000f
> >>> @@ -105,6 +104,11 @@ static int tmu_get_temp(struct
> >> thermal_zone_device *tz, int *temp)
> >>>    	 * within sensor range. TEMP is an 9 bit value representing
> >>>    	 * temperature in KelVin.
> >>>    	 */
> >>> +
> >>> +	regmap_read(qdata->regmap, REGS_TMR, &val);
> >>> +	if (!(val & TMR_ME))
> >>> +		return -EAGAIN;
> >>
> >> How is this change related to what is described in the changelog?
> >
> > devm_thermal_zone_of_sensor_register will invoke get temp, since we
> > reverted the 45038e03d633 did, we need to check TMR_ME to avoid
> return
> > invalid temperature.
>=20
>=20
>  From a higher perspective if the sensor won't be enabled, then the therm=
al
> zone should not be registered, the get_temp won't happen on a disabled
> sensor and this test won't be necessary, no ?

Agree, let me move the temp sensor enabling before register thermal zone.

Thanks,
Peng.

>=20
> --
> <https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fww
> w.linaro.org%2F&data=3D05%7C01%7Cpeng.fan%40nxp.com%7C2a5070b5049
> 14957160008db61d37861%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7
> C0%7C638211333111330055%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
> wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%
> 7C%7C%7C&sdata=3DaJBF2UEqaCAqcAbHcKzbGReVv6pbYlyQ25riVxEdG08%3D
> &reserved=3D0> Linaro.org =81 Open source software for ARM SoCs
>=20
> Follow Linaro:
> <https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fww
> w.facebook.com%2Fpages%2FLinaro&data=3D05%7C01%7Cpeng.fan%40nxp.c
> om%7C2a5070b504914957160008db61d37861%7C686ea1d3bc2b4c6fa92cd
> 99c5c301635%7C0%7C0%7C638211333111330055%7CUnknown%7CTWFpb
> GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI
> 6Mn0%3D%7C3000%7C%7C%7C&sdata=3D9l627puhL7hQgMlPWaKkCIDkQKGX
> TH49rEM0NFipvDs%3D&reserved=3D0> Facebook |
> <https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Ftwitt
> er.com%2F%23!%2Flinaroorg&data=3D05%7C01%7Cpeng.fan%40nxp.com%7C
> 2a5070b504914957160008db61d37861%7C686ea1d3bc2b4c6fa92cd99c5c30
> 1635%7C0%7C0%7C638211333111330055%7CUnknown%7CTWFpbGZsb3d8
> eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> D%7C3000%7C%7C%7C&sdata=3D%2B0Oa%2BrxHmGPga0%2BGQjOOX6Dxaiuj
> oPJhzwqBjjO%2B2Qo%3D&reserved=3D0> Twitter |
> <https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fww
> w.linaro.org%2Flinaro-
> blog%2F&data=3D05%7C01%7Cpeng.fan%40nxp.com%7C2a5070b5049149571
> 60008db61d37861%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C
> 638211333111330055%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
> MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C
> %7C&sdata=3D2lfwzPj3p%2BjowtVDc03plo1Ds%2BnT%2B2eSwdTQ9yQosfo%3
> D&reserved=3D0> Blog

