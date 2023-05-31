Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F3B717F85
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 14:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjEaMFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 08:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235911AbjEaMFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 08:05:44 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2085.outbound.protection.outlook.com [40.107.8.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA65138;
        Wed, 31 May 2023 05:05:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6eGPqfETy44Hwa1hPxZxtnAeVqblMdFsvmJUoTqLRlJ/wIhHoiA3GcMQlmZjjQI0iOQOxLBKyyzoexIp5XyWtuFePtF+nD5kTyWA+y8TTvhCPzI2RsBc01p5uPTjOqakFXOq8NiJqW83RLtPflkIe7gTP+03S8XrHeRfuAh6RJNpVjT4fkmAWRbBhY6UArSxY3xNwDYqbYhYVabJrlc0M8iYGaj1mIUzG+iqaRu3Mg9N4ZuxGCgnttF0TrxGjX8WtDuNfbQn2TmEqxP0rYYKfeUf0x+zI72Z4T1sJ5DPooK3O0XoHxlTSZoJQmud/fZzjZdUmgQFgkIhs8KGw1TnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uc8sNohDMSlL5WxW4NFQ0cQ62TQ0JYFegTh5+NJlPNg=;
 b=ICtj74CEpZWYnU1K+KhOwQDQZwQOmIqvLAXeAnj9hzbFK51DPjwp23Afxc61mx9jmHcvqID641igwMkQZegPW3fLcypK4HyrOktg+RQBQJRBSNm5KaL300IVJU+yJdSAo09uYjJL51CDP/tZWMo95Q7iA1tL/8OzOf5eUKJ5lXu9mVficQfX+WNvQU1Dj5rCuz7N7rzBD+dfBcJMd2GZAG5ef/gXZrkkwmC4G9W1nZtzdtZDxoaqLD9T3kYurYNhrtcku2mbeUNTned3XgIQjGdCsb4cQKTDExb6u1qO57JoZf1ZTN0pusPxc0jiYvR6gbXKYoKLZV/MFB7YhfYxEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uc8sNohDMSlL5WxW4NFQ0cQ62TQ0JYFegTh5+NJlPNg=;
 b=QvvWzbFXkHXIV7yswjAV8QIb6XSLyNM/Obg+4H+R1a6oElCw0fHwlRb973AKIm4hSaIEFQ2t8srdQVVpe9ciPmyWqjZk8CrZUKJWJDDklvmntwu8RquDvfc/HBYKcKab+qzl/I2nfgOH+E5nMLHNZ+z71JZobd6mYuaiQmygIFw=
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by AS8PR04MB7688.eurprd04.prod.outlook.com (2603:10a6:20b:29d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 12:05:09 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::8799:40ed:fc37:6028]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::8799:40ed:fc37:6028%6]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 12:05:09 +0000
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
Thread-Index: AQHZh9EJboPf4XvfUEydyH3VnYRxsK90T2iAgAAQueA=
Date:   Wed, 31 May 2023 12:05:09 +0000
Message-ID: <PA4PR04MB94165217C8C0D9E8E0087AF988489@PA4PR04MB9416.eurprd04.prod.outlook.com>
References: <20230516083746.63436-1-peng.fan@oss.nxp.com>
 <20230516083746.63436-3-peng.fan@oss.nxp.com>
 <3c59c4e0-68eb-b778-6b12-9f9e331f81dd@linaro.org>
In-Reply-To: <3c59c4e0-68eb-b778-6b12-9f9e331f81dd@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9416:EE_|AS8PR04MB7688:EE_
x-ms-office365-filtering-correlation-id: 9bf240bb-2a26-493e-547a-08db61cf4802
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SsSatsI/i5k66eOEVQ0UFdsJO84Awig8d96qe5MjGYRZIQaXVQ3z1YbN3LXAqAgu4I7UxeCiLuuR4HTXAPmhEqAXJ41A60bWRfycrTvEiMLfWYQK7JJsJWie8aNi61JbW2itUPxZo/yJk5p99UG/DmRIscZBv17D43R5hWmfOz5d0bcTei3ogDP0kx++vOMh/UxdgHpT28torYBq3Q9BQp8qUpXNfOMrJJT68Fd1ZHmU+vu0xwuzx0Z362iASadCFgurhT4MFLr1U8ODXUSxWuH/szvmh0TJXagWIjqtnbswHN8wi8Kh6GtU6o9GQXf7K9LMWsvl1hlLxkvTVfl9P2IXrAO8MOiJhH9tAXXSB52dIWc8ULp4qd2CTNlDJoDkDSMM3DWS6eqVeWIEY8nGP03Z6dhnmQ9Cjayz1VTIoeHkdvO4Vy7m8qDiCArp8SZA1s6Nt7M0h8Ux4bIyzELPfcmp6qdVc4N5DgR3urRqCqzY+8HxvprPcr89RL96DYTCB1xYLNXgVq2mQuQbFSwLJDj42m3A+wNmACosDKtcdWJIzAsaOWQIqFBYuJ1D2Ap/kdYVmu4dX8khz75VsXiKMxQP34d1ukMyHDowTDRy4yeX3p9ZchesNRZ2tKkOtlOy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(366004)(39860400002)(396003)(451199021)(71200400001)(110136005)(478600001)(54906003)(52536014)(8936002)(8676002)(7416002)(66556008)(5660300002)(33656002)(44832011)(86362001)(2906002)(38070700005)(76116006)(4326008)(122000001)(64756008)(66476007)(66946007)(66446008)(316002)(55016003)(38100700002)(41300700001)(186003)(6506007)(53546011)(26005)(7696005)(9686003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?koi8-r?Q?FvWikhYdQfmjWdx9kqLvkHH/odnBdoiWIJM19JminfdA/cYrWR+PZ72C9xJ1+x?=
 =?koi8-r?Q?9euL771UekGL58MZcW0X6dXBu/zl+YKNf/wpAAfEEYr5SYWbG2FBFz29Ff2/PV?=
 =?koi8-r?Q?SgIIgUi70+uJG1rKMo+LgxctOwQx0Za8tF4Plzem4z9OOkxa3XabLfCwi/1I+G?=
 =?koi8-r?Q?+IgLgLUsj3EE20zm8qUXxWUfkJId27wyN3VPAdEXQtiKIK3D2wjyi5XT2NeRsl?=
 =?koi8-r?Q?mL7plFPMugwBCLYfxYrSOxZsh2Zi0751cqg77aUzVDQKSEoM6r6SVN41BXB4SD?=
 =?koi8-r?Q?Bp9KOf2M76IXjBG/DQKvkVWUd7ac39jJYkhRMPYg83wkr7YQQrBaOEBKF3KzfZ?=
 =?koi8-r?Q?3Ts030YDbCsBHJM4o5i68yMNXGnm7vd+0RmRaPHSfBMmmER5iOhgkuCIv7wwD6?=
 =?koi8-r?Q?mP/juzVcuM5hU0QSJvNIGHFSUHPSp0bWtigOipbyiF62GALQXN4TcQFGKlLCuy?=
 =?koi8-r?Q?Q/k2T1KwBL6VJuXlOR3pLrvo9UA+RhqBcVZRglg7R+H9ZxUhPfZtPHvkU8WuuX?=
 =?koi8-r?Q?WF2ZKNUv/llkqtCWfqn5DnH6u5X1fPeqWgj7UmRb+B/tM3ORIq1jycgFNSDNC1?=
 =?koi8-r?Q?JmhyUsiKxLr268CCOklyD0J+GBzgQA8dNbblsfOsfTezlB7agVqgXOfqRBpsfy?=
 =?koi8-r?Q?8fDbCbeJUQBxX+i0ijp34/8cxXaBAmbah7b7K7wUiXVBkZDOK45PSjJu9v3Yqm?=
 =?koi8-r?Q?Dr93u/pLRw3WYBkf1oc2Z7qT9Yk+rNoafkXFmO9G1wsZNwNOw6/jrMQGA296wO?=
 =?koi8-r?Q?0Wf1PzLB+1H3CVe/yCay6YVXSuLAj3I1ZJq4EMxtShy41Gy8RXfqf9zNs4wzWm?=
 =?koi8-r?Q?pFvNsY6vAjoSwOrEcp06rKhO7TdZu89cegS0IQMcP8+17/Qo+ipl8TfER+Vwt2?=
 =?koi8-r?Q?/diqmNAUrAV4ODG09vYQy7LVQLptFvTPERUuLj10sc8kq8j2ikkx0In+pUBNVA?=
 =?koi8-r?Q?rKsO240oc0MN0uG1MG2bxPpXRUt99dZ7o7IwK4mqlxg3lfMc3L5ysDQbnA/zGq?=
 =?koi8-r?Q?KT2vU8Jcyg4tuhWtTykFi0YaCFGc6E23a5gv+ipQxOdDN2ZNdAwsCmfne/+8Jf?=
 =?koi8-r?Q?y0/e/iJEs2QLBhbqMRk6B2tYGkD54MvBQcYOaP4xlRwx/WPgFMmu7is8AgDzN0?=
 =?koi8-r?Q?y2qP5UK3pF5g8T3I9aiGSutMFPpUOkB/lFVb4eyv/M1qOpvZTvlKdlHYqdedtW?=
 =?koi8-r?Q?lfNQYpYVGLscg5cg9m6ksBKUoSUCL0rG9iR6VmqKSm/CNjrYGpcF0Db2bAUJMd?=
 =?koi8-r?Q?CvMshC6k/qaAA5uu+/Pa3kjOLyU/cs0TFQFh4L8+YhHEU0WtMQEPuPyBX0LqTB?=
 =?koi8-r?Q?CGibUm+GgdEP3mBESW5AsOYZgkWaOv9VyAO4VjfX+Sq/S1tuj++jHezvzHtFDY?=
 =?koi8-r?Q?ZJiI22/yYgHdYLyxgvVAZyg4SO01lgdADA31l0fyLp/sNhtkDyfq0ugKSAWlG7?=
 =?koi8-r?Q?rUH2UqDk6j7NR4UoHXCyegC25xfyY5/gOnA23oBt5KSk4yj4etIBINFL588Y8o?=
 =?koi8-r?Q?xK8W+ELlhuV+gwi4yQab+f4JSvf0E=3D?=
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bf240bb-2a26-493e-547a-08db61cf4802
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 12:05:09.6756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TBqUR0itdu/vi/GcBW1ThBBVnbTPHy6sYKolA1S1qUPiVtPU4ivJ5YcQsQsUDVrtIKuUpsnx/vK0W7OVr7gGAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7688
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
> On 16/05/2023 10:37, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > There are MAX 16 sensors, but not all of them supported. Such as
> > i.MX8MQ, there are only 3 sensors. Enabling all 16 sensors will touch
> > reserved bits from i.MX8MQ reference mannual, and TMU will stuck,
> > temperature will not update anymore.
> >
> > Fixes: 45038e03d633 ("thermal: qoriq: Enable all sensors before
> > registering them")
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >   drivers/thermal/qoriq_thermal.c | 30 +++++++++++++++++++-----------
> >   1 file changed, 19 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/thermal/qoriq_thermal.c
> > b/drivers/thermal/qoriq_thermal.c index b806a0929459..53748c4a5be1
> > 100644
> > --- a/drivers/thermal/qoriq_thermal.c
> > +++ b/drivers/thermal/qoriq_thermal.c
> > @@ -31,7 +31,6 @@
> >   #define TMR_DISABLE	0x0
> >   #define TMR_ME		0x80000000
> >   #define TMR_ALPF	0x0c000000
> > -#define TMR_MSITE_ALL	GENMASK(15, 0)
> >
> >   #define REGS_TMTMIR	0x008	/* Temperature measurement
> interval Register */
> >   #define TMTMIR_DEFAULT	0x0000000f
> > @@ -105,6 +104,11 @@ static int tmu_get_temp(struct
> thermal_zone_device *tz, int *temp)
> >   	 * within sensor range. TEMP is an 9 bit value representing
> >   	 * temperature in KelVin.
> >   	 */
> > +
> > +	regmap_read(qdata->regmap, REGS_TMR, &val);
> > +	if (!(val & TMR_ME))
> > +		return -EAGAIN;
>=20
> How is this change related to what is described in the changelog?

devm_thermal_zone_of_sensor_register will invoke get temp,
since we reverted the 45038e03d633 did, we need to check TMR_ME
to avoid return invalid temperature.

Regards,
Peng.

>=20
> >   	if (regmap_read_poll_timeout(qdata->regmap,
> >   				     REGS_TRITSR(qsensor->id),
> >   				     val,
> > @@ -128,15 +132,7 @@ static const struct thermal_zone_device_ops
> tmu_tz_ops =3D {
> >   static int qoriq_tmu_register_tmu_zone(struct device *dev,
> >   				       struct qoriq_tmu_data *qdata)
> >   {
> > -	int id;
> > -
> > -	if (qdata->ver =3D=3D TMU_VER1) {
> > -		regmap_write(qdata->regmap, REGS_TMR,
> > -			     TMR_MSITE_ALL | TMR_ME | TMR_ALPF);
> > -	} else {
> > -		regmap_write(qdata->regmap, REGS_V2_TMSR,
> TMR_MSITE_ALL);
> > -		regmap_write(qdata->regmap, REGS_TMR, TMR_ME |
> TMR_ALPF_V2);
> > -	}
> > +	int id, sites =3D 0;
> >
> >   	for (id =3D 0; id < SITES_MAX; id++) {
> >   		struct thermal_zone_device *tzd;
> > @@ -153,14 +149,26 @@ static int qoriq_tmu_register_tmu_zone(struct
> device *dev,
> >   			if (ret =3D=3D -ENODEV)
> >   				continue;
> >
> > -			regmap_write(qdata->regmap, REGS_TMR,
> TMR_DISABLE);
> >   			return ret;
> >   		}
> >
> > +		if (qdata->ver =3D=3D TMU_VER1)
> > +			sites |=3D 0x1 << (15 - id);
> > +		else
> > +			sites |=3D 0x1 << id;
> > +
> >   		if (devm_thermal_add_hwmon_sysfs(dev, tzd))
> >   			dev_warn(dev,
> >   				 "Failed to add hwmon sysfs attributes\n");
> > +	}
> >
> > +	if (sites) {
> > +		if (qdata->ver =3D=3D TMU_VER1) {
> > +			regmap_write(qdata->regmap, REGS_TMR,
> TMR_ME | TMR_ALPF | sites);
> > +		} else {
> > +			regmap_write(qdata->regmap, REGS_V2_TMSR,
> sites);
> > +			regmap_write(qdata->regmap, REGS_TMR,
> TMR_ME | TMR_ALPF_V2);
> > +		}
> >   	}
> >
> >   	return 0;
>=20
> --
> <https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fww
> w.linaro.org%2F&data=3D05%7C01%7Cpeng.fan%40nxp.com%7C032080272b
> b84255c00b08db61c6a962%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%
> 7C0%7C638211278103002380%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC
> 4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000
> %7C%7C%7C&sdata=3DOBOfWzY2%2BAZDHWoiqwsdShvt0P6o3JYhSCmlz9wN
> Wzc%3D&reserved=3D0> Linaro.org =81 Open source software for ARM SoCs
>=20
> Follow Linaro:
> <https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fww
> w.facebook.com%2Fpages%2FLinaro&data=3D05%7C01%7Cpeng.fan%40nxp.c
> om%7C032080272bb84255c00b08db61c6a962%7C686ea1d3bc2b4c6fa92cd
> 99c5c301635%7C0%7C0%7C638211278103002380%7CUnknown%7CTWFpb
> GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI
> 6Mn0%3D%7C3000%7C%7C%7C&sdata=3DPBMinw85VAW%2BvLnNtNnxui1e7
> kqJioymsokTrRRoB5c%3D&reserved=3D0> Facebook |
> <https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Ftwitt
> er.com%2F%23!%2Flinaroorg&data=3D05%7C01%7Cpeng.fan%40nxp.com%7C
> 032080272bb84255c00b08db61c6a962%7C686ea1d3bc2b4c6fa92cd99c5c30
> 1635%7C0%7C0%7C638211278103002380%7CUnknown%7CTWFpbGZsb3d8
> eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> D%7C3000%7C%7C%7C&sdata=3DGrd5C5p1cwjl6kwHUfhCFVwFMOhZjedAm5
> UnPoU5%2FUU%3D&reserved=3D0> Twitter |
> <https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fww
> w.linaro.org%2Flinaro-
> blog%2F&data=3D05%7C01%7Cpeng.fan%40nxp.com%7C032080272bb84255c
> 00b08db61c6a962%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C
> 638211278103002380%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
> MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C
> %7C&sdata=3DjWOAT8Eg0AzCePPrAsNtY%2FdZzNs2kvY2kGp8uO4I7a8%3D&re
> served=3D0> Blog

