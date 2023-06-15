Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA14731825
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 14:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239455AbjFOMHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 08:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239068AbjFOMHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 08:07:35 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2059.outbound.protection.outlook.com [40.107.8.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A55F184;
        Thu, 15 Jun 2023 05:07:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dc2XXoDod3JFufp2KyuTCO1GlANPTOCx6Tm0R4NNEWRzn/k9Wwg3XUUbnm6s6d2cAsg4o4GJW8GtISB3Zi7NwW57PJokyr8q4T7itRI76KxdZmyBFzpEv+WKrKkc1wFwaD4OXCkjsCbNHqxZhiadrQe57UAjoF1lR79PCMjMdpGAH1MNbt8pFo1qS7yRUNoesFVyETcUPWSLb22S4TFzMBRa20HOpRiMjQKiEYmytIY9svhTWhlL909GVJMPN1x72n6cNpJwf72qF+zJ0Zdp3JSWfzrTvC6VK+rhqhRkq2dpAK+Ariqh3Vg80g7ZIRN26jxnD80qjeriWDovpH0GsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d2zk+HQO6Hd7+uBVkYAXBzGSBoS1DfM2EsYoC92zt2I=;
 b=BnETkWtFsvU1+XiWyPwf/1jxqelUsxKUMjG18p6loWyHWplPO1K+7NB1rT5iSD8m1HKEeaC+R5/gkuh1fCXUnW2ORtKHS9rlcb+5+4N7Ysz8vMZlyD91KRMr4ZIyBCvTIFMGm8J7OuXlYM14Kfbhvj6MFcSY94y2H3pHSw1S/L2Jfex5K/PsyELLNBg6ewGoJk1DkimLnw5y04TYbXGF1T+qVzRdFloy46WGN997dqzvP3xI9rCiRCPtqlhFlgAuyX6i66yA9jp4ALLCC3i46TKA28GKi6Bduubstm8fUJwzD0zicz3RCIyr6Sq4QV9B3UH11Rd5UG357kkN8iJ9og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2zk+HQO6Hd7+uBVkYAXBzGSBoS1DfM2EsYoC92zt2I=;
 b=ghgATWoGnMkOLIptn7rDlRIneSRG94iSshoQcaZWr5laNBa5vIvcq1gnyAPaiP85daBKD179BwI3E9ozjFNeF10w0hLPKrOCb0sq8JBbByQhe6Q5CTkZIJULHCe3k/PJMtlktPtIqAREkSdTvD2rLpz1dqfnnJdTtgNpigV4TiQ=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB9524.eurprd04.prod.outlook.com (2603:10a6:10:2f7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Thu, 15 Jun
 2023 12:07:30 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea%6]) with mapi id 15.20.6455.039; Thu, 15 Jun 2023
 12:07:29 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
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
Thread-Index: AQHZh9EJboPf4XvfUEydyH3VnYRxsK90T2iAgAAQueCAAAjlAIAABicQgAFdYKCAActWgIAHY2kAgAApSICAAJqRAIAAGJ4AgAt65YCAAAbHgIAAE+yAgACBtYCAAAQrEA==
Date:   Thu, 15 Jun 2023 12:07:29 +0000
Message-ID: <DU0PR04MB9417A508A757AF8964CDAEA6885BA@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230516083746.63436-1-peng.fan@oss.nxp.com>
 <507b5daa-73e7-8d21-4f73-c56f88c6bf77@linaro.org>
 <2e57d14a-214e-c3e0-e011-e804ce8c9b39@oss.nxp.com>
 <4844567.31r3eYUQgx@pliszka>
 <3518a2e7-806d-ad46-a439-ff4a57ed8158@oss.nxp.com>
 <3e397cf5-0ca3-fa10-b5d8-bbc7b1038a37@linaro.org>
In-Reply-To: <3e397cf5-0ca3-fa10-b5d8-bbc7b1038a37@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DU2PR04MB9524:EE_
x-ms-office365-filtering-correlation-id: 4b95fab2-0936-4e68-73b5-08db6d99176a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iEjb5O/Jg05XQ4MO3+FqvXPnXz2ptRZ2bZL0Ub/KzWXPrBUEpVK+1KInf0OKu/4bGwiHXtxuUDKBH1SP7B+JyfVNG1zseK+lTb2xKZGCmpKXI7PgVBKbbIXgaMgJuFdD0ug2JV/O7PyPnGcLjEj0JAg9gdNmgSzRGjvDSDjZGQxtvsJgPeTNaNY4IlZOgXfGZG+Wn8XJZX3z6BiRnjVWKnSB2o/qlQE26OGPpFAEO3UYc0ivtjSrypmYmu+8dSfO+6CBwLFqyfSXMRraVrUw+qW0IMA0qbQbB8f734lhq4iErQ3FHpa7le9KayzwDWo8PKen5AsF1prZX0eJFr5W2bVsYIkQeJhGp4j2G/uWsOyx1Fcu4UchHJnfX2D0ao7KWLQgj2SO8U7hoA9aJTYM3t5ug++43dcCPfrNreb2AHjxvWl/rk3H2vectQpY3svoPqrYmr/okWCyw0s1FWMh2CwYCfsn+b1HkMB1y6XHXQRPzDB2rpqGZc1jcyfF2bE4ODrJSmX12kizFDu8KMq1nFroVYz0sa1Rlxx9b0yYzZwwDCWtK6lEwz66fi6ZXFbYd+MHqhmQ25anx1O7zbk1jH+YEoW6g5CzKaAq3DXCsoDUJP2UrYLMYUuOMH8KYCBw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(451199021)(83380400001)(71200400001)(7696005)(26005)(6506007)(9686003)(53546011)(122000001)(66946007)(66556008)(4326008)(64756008)(66446008)(66476007)(76116006)(478600001)(186003)(110136005)(54906003)(41300700001)(8676002)(8936002)(5660300002)(52536014)(38100700002)(44832011)(33656002)(316002)(38070700005)(7416002)(2906002)(55016003)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?koi8-r?Q?uyp9oOG2fHQ3Hi+O1gOy1h2Eti4FElRfBSdfxgNq6hlrpqlq3BBSqMIws7tFCM?=
 =?koi8-r?Q?aciIiE7kg1pG67ZqO9KakoOQSNMcLFURA5C+ls/ogDvE1DXVOILIpc05dYWQYB?=
 =?koi8-r?Q?lMT/iG31SOVKwGCnm5Fdje97Ui0x38FO95lqhBCW1XaWetyf8T26NQ7FAqdA52?=
 =?koi8-r?Q?uzvbtCpsrUzFOB4K36Wm1Tuy+XQQbnrbEcyMV4Yh5svW+C3dU66MvQ2vRLI7ke?=
 =?koi8-r?Q?nfFuLc5BbKR2BeFJB39QrjAm5vU2iAKvu452bpuklcxMvr01Wz5KfvLaK+TGBE?=
 =?koi8-r?Q?oFO3JefGECljpBGlRW/ySVwgMQDlEM/y6cgtZVYB+8K25DyzzXjnEO2nWEpz3F?=
 =?koi8-r?Q?lPXOPR9KwfAjLA1CXujcBPF5srQ7iI/FNuSVfQTvLZybxjr6Ef1r9N/+Iq9XJW?=
 =?koi8-r?Q?Ne2O3958Jc07r6+zn41c+X62xSezC3AIgl2+ilWY6zi2XaDFOnMSTMXb5z7dIU?=
 =?koi8-r?Q?gAtt1sqDcAG/gj73pl+RIXVIjTtReWOenMdGuyiTuUmOjhroZw552ZNTTQBv3W?=
 =?koi8-r?Q?XiMBwDcGYJ39EwCufVYmRFdyWtKWHfe0FVuFSJrQ8auoDJ8PJApRRPvKwDKuwQ?=
 =?koi8-r?Q?IadzyyZoVevk7qsg7c5c+9gKWNbqyaN1yRyU8VCu9K2Rn5rsf7Wje2lgpLWAai?=
 =?koi8-r?Q?Q8KGdEg3rHdCdyy8j0pWyGWOHzX6sQtYgxnX8f19i1AIUzxaXQfek2138C1yMb?=
 =?koi8-r?Q?EqnsOw0JoebaxeYEKcdl1/wF4Wm7gVWPdDZV1xmFUepcBh/AbnsJ/Y+OgR3sjd?=
 =?koi8-r?Q?YGJ9CsQ4wB0VTthL1uvpWAGg34+FcUUm3J0GuPcRRBHXYxq9zweLvdlmzHTLjI?=
 =?koi8-r?Q?Uc5x3XflnauFYIh5CDQ3l2fzD2nuXD02NFDzU8YZlSYnMkd4cWgpeTtYH+Tqzi?=
 =?koi8-r?Q?TvJFfvULZIkOTci7eWKKmoF06N8/8RAfYrZl658M8Cd6RsI9i6DCDcdwJhxE23?=
 =?koi8-r?Q?Xb3D5arN+4qfQiANZI5vUu87OKLVgN64oYN3qmBXE+s1o2A5lgPWbK2ri9o/OH?=
 =?koi8-r?Q?BSUyDrKpddkqTnp9nfEKH6TTjV8+YuvpMCdMmx9W9O8kR4ydgNCLOQcq2ZYr60?=
 =?koi8-r?Q?+c+HxrnvXgNm1pHFx/O1zGvkPnI2SlIBOhggyozeC/azRPdejgQlfK2X2Lj2+w?=
 =?koi8-r?Q?ZhXQWa9e+8kiJwLm4RTP6eROTfkztScO5oOlJzDmM6zUEvaBeRI0pJoQHz6r7Z?=
 =?koi8-r?Q?dx8Rnsx9WvtUE/bBSbmkxdAbJxljEs2mxpN4sqaygZIxDbPTwZI7DQEUnjEKLR?=
 =?koi8-r?Q?xvZ2J6Y3RBfHPANg0i1hD0NssBSVstX82Xoy1L8m9JZ2177XZzdA5TFTBShnPi?=
 =?koi8-r?Q?tuKUcqh6+BNI5sptaoZZ+TepRvW45Eqft8Msqk3FttAzvVf0GXTpSiFc8np/Xr?=
 =?koi8-r?Q?qB+QAR2qaWHLuGUZJpDif+xCYHMUNrAwg4WxFMXLIp/6BrrsBHOqt2F8jr0pS6?=
 =?koi8-r?Q?hwSXj1r+BuX8IFalvRxKWs01or5De9FQZOF57qXR6JwheDmTVMym7dko5qoIyX?=
 =?koi8-r?Q?ZEsFh0EXq3kUKTAvQlWMsHZ1zoOMI=3D?=
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b95fab2-0936-4e68-73b5-08db6d99176a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2023 12:07:29.2773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qozr8AfhnqJQicjYCmMsKd+VLrtZK9dV4WvnmENfu3FCdhWrb0WmxT6xvZ5EqHfzWQzGf+vSwWe1+nxX02Kl8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9524
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH 2/3] thermal: qoriq_thermal: only enable supported
> sensors
>=20
> On 15/06/2023 06:04, Peng Fan wrote:
> >
> >
> > On 6/15/2023 10:53 AM, Sebastian Krzyszkowiak wrote:
> >> Caution: This is an external email. Please take care when clicking
> >> links or opening attachments. When in doubt, report the message using
> >> the 'Report this email' button
> >>
> >>
> >> On czwartek, 15 czerwca 2023 04:29:01 CEST Peng Fan wrote:
> >>> On 6/8/2023 3:10 AM, Daniel Lezcano wrote:
> >>>>
> >>>> [...]
> >>>>
> >>>> Ok, I misunderstood. I thought that was for failing registered
> >>>> thermal zone.
> >>>>
> >>>> Would enabling the site in ops->change_mode do the trick ?
> >>>
> >>> No. ops->change_mode not able to do the trick.
> >>>
> >>> devm_thermal_of_zone_register->thermal_zone_device_enable
> >>> ->thermal_zone_device_set_mode-
> >__thermal_zone_device_update.part.0
> >>> ->__thermal_zone_get_temp
> >>>
> >>> The thermal_zone_device_set_mode will call change_mode, if return
> >>> fail here, the thermal zone will fail to be registered.
> >>>
> >>> Thanks,
> >>> Peng.
> >>
> >> I think the idea is not to return a failure in ops->change_mode, but
> >> to move enabling the site in REGS_TMR/REGS_V2_TMSR register from
> >> qoriq_tmu_register_tmu_zone to ops->change_mode.
> >
> > But qoriq_tmu_register_tmu_zone will finally call ops->change_mode.
> >
> > And it is per zone, so we not able to enable TMR_ME here.
> >
> > This way the site will be
> >> enabled only for actually existing thermal zones, since those not
> >> described in the device tree won't reach thermal_zone_device_enable.
> >
> > No. The TMR_ME is the gate for all sites.
>=20
> What about the following change on top of your series:
>=20
> diff --git a/drivers/thermal/qoriq_thermal.c
> b/drivers/thermal/qoriq_thermal.c index c710449b0c50..ecf88bf13762
> 100644
> --- a/drivers/thermal/qoriq_thermal.c
> +++ b/drivers/thermal/qoriq_thermal.c
> @@ -107,8 +107,6 @@ static int tmu_get_temp(struct thermal_zone_device
> *tz, int *temp)
>   	 */
>=20
>   	regmap_read(qdata->regmap, REGS_TMR, &val);
> -	if (!(val & TMR_ME))
> -		return -EAGAIN;
>=20
>   	if (regmap_read_poll_timeout(qdata->regmap,
>   				     REGS_TRITSR(qsensor->id),
> @@ -131,14 +129,40 @@ static int tmu_get_temp(struct
> thermal_zone_device *tz, int *temp)
>   	return 0;
>   }
>=20
> +static int qoriq_tmu_change_mode(struct thermal_zone_device *tz,
> +				 enum thermal_device_mode mode)
> +{
> +	struct qoriq_sensor *qsensor =3D thermal_zone_device_priv(tz);
> +	struct qoriq_tmu_data *qdata =3D qoriq_sensor_to_data(qsensor);
> +	unsigned int site;
> +	unsigned int value;
> +	unsigned int mask;
> +
> +	if (qdata->ver =3D=3D TMU_VER1) {
> +		site =3D BIT(15 - qsensor->id);
> +		mask =3D TMR_ME | TMR_ALPF | site;
> +		value =3D mode =3D=3D THERMAL_DEVICE_ENABLED ? mask : mask
> & ~site;
> +		regmap_update_bits(qdata->regmap, REGS_TMR, mask,
> value);
> +	} else {
> +		site =3D BIT(qsensor->id);
> +		mask =3D TMR_ME | TMR_ALPF_V2 | site;
> +		value =3D mode =3D=3D THERMAL_DEVICE_ENABLED ? mask : mask
> & ~site;
> +		regmap_update_bits(qdata->regmap, REGS_V2_TMSR,
> mask, value);
> +		regmap_write(qdata->regmap, REGS_TMR, TMR_ME |
> TMR_ALPF_V2);

Per i.MX8MQ Reference manual:
MSITE:
Monitoring site select 0 - 2. By setting the select bit for a temperature s=
ensor site,
 it is enabled and included in all monitoring functions. For proper operati=
on, this
field should only change when monitoring is
disabled. If no site is selected, site 0 is monitored by default.

ME: Before enabling the TMU for monitoring, the TMU must be configured,=20
see section Initialization Information. Failure to properly initialize the
configuration table may result in boundedly undefined
behavior.

So we must set the SITEs bits before enabling ME bit. So set TMR_ME when
each time call invoke mode violates the spec.

As I understand, change_mode is per zone, which means per msite for TMU,
but TMU_ME is a global gating bit which should not be set before all msites
are set.

Thanks,
Peng.

> +	}
> +
> +	return 0;
> +}
> +
>   static const struct thermal_zone_device_ops tmu_tz_ops =3D {
>   	.get_temp =3D tmu_get_temp,
> +	.change_mode =3D qoriq_tmu_change_mode,
>   };
>=20
>   static int qoriq_tmu_register_tmu_zone(struct device *dev,
>   				       struct qoriq_tmu_data *qdata)
>   {
> -	int id, sites =3D 0;
> +	int id;
>=20
>   	for (id =3D 0; id < SITES_MAX; id++) {
>   		struct thermal_zone_device *tzd;
> @@ -158,25 +182,11 @@ static int qoriq_tmu_register_tmu_zone(struct
> device *dev,
>   			return ret;
>   		}
>=20
> -		if (qdata->ver =3D=3D TMU_VER1)
> -			sites |=3D 0x1 << (15 - id);
> -		else
> -			sites |=3D 0x1 << id;
> -
>   		if (devm_thermal_add_hwmon_sysfs(dev, tzd))
>   			dev_warn(dev,
>   				 "Failed to add hwmon sysfs attributes\n");
>   	}
>=20
> -	if (sites) {
> -		if (qdata->ver =3D=3D TMU_VER1) {
> -			regmap_write(qdata->regmap, REGS_TMR,
> TMR_ME | TMR_ALPF | sites);
> -		} else {
> -			regmap_write(qdata->regmap, REGS_V2_TMSR,
> sites);
> -			regmap_write(qdata->regmap, REGS_TMR,
> TMR_ME | TMR_ALPF_V2);
> -		}
> -	}
> -
>   	return 0;
>   }
>=20
>=20
> --
> <https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fww
> w.linaro.org%2F&data=3D05%7C01%7Cpeng.fan%40nxp.com%7C5c60b05b18b
> 9442223cc08db6d967d30%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7
> C0%7C638224265339069492%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
> wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%
> 7C%7C%7C&sdata=3DStV3sHe7fjGIMNjEYaDwiuTm8GpB6IDmoRhKoRpmUQY
> %3D&reserved=3D0> Linaro.org =81 Open source software for ARM SoCs
>=20
> Follow Linaro:
> <https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fww
> w.facebook.com%2Fpages%2FLinaro&data=3D05%7C01%7Cpeng.fan%40nxp.c
> om%7C5c60b05b18b9442223cc08db6d967d30%7C686ea1d3bc2b4c6fa92cd
> 99c5c301635%7C0%7C0%7C638224265339069492%7CUnknown%7CTWFpb
> GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI
> 6Mn0%3D%7C3000%7C%7C%7C&sdata=3DAjK1yxq5PT60YfQRlxOBzlM2YXnhl6
> 9NWCQFRIUwVm0%3D&reserved=3D0> Facebook |
> <https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Ftwitt
> er.com%2F%23!%2Flinaroorg&data=3D05%7C01%7Cpeng.fan%40nxp.com%7C
> 5c60b05b18b9442223cc08db6d967d30%7C686ea1d3bc2b4c6fa92cd99c5c30
> 1635%7C0%7C0%7C638224265339069492%7CUnknown%7CTWFpbGZsb3d8
> eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> D%7C3000%7C%7C%7C&sdata=3DViShZhpql%2FJ6xUGJ2M9acJtmKuG%2BFCyZ
> Ivy99cPpfxA%3D&reserved=3D0> Twitter |
> <https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fww
> w.linaro.org%2Flinaro-
> blog%2F&data=3D05%7C01%7Cpeng.fan%40nxp.com%7C5c60b05b18b944222
> 3cc08db6d967d30%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6
> 38224265339069492%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwM
> DAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%
> 7C&sdata=3DPCNIqUJPZve9x1sgsdkPtRjIKQXnr514I%2BUx%2FbLcGC0%3D&res
> erved=3D0> Blog

