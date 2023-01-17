Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5236366DE30
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 13:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236671AbjAQMzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 07:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236931AbjAQMzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 07:55:11 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B54417CF1;
        Tue, 17 Jan 2023 04:55:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qf2jBY/TIbmPZp7yujQvrGdepEns8nt+GegRx045Oe0qCE1LE+plA7MVPUcp2kQbKX6ith05ZIBcLXsfuYksbquG4BXuE+sVmfA9tPcpAhxcgeURzTu0J1vjr+/7onRWFoCfTBSiOseJbinYGOaxfioasc6SrRhEbgV3TJmOK7IzqOrTIL4DdSMjKwFi4+Dppes8Aj2G6lD+2COsiLdbZaDQKgyFXjOCKubyKEu0aUlGZZVUxMHR+f6TAiPQY8pud3eTNvcgzKTnt72+aqcJSkmN/q4/UpFLeK+zTbpqObas+eU4Zp9l+Zj08etBY6tJ6UVEovDUSgG4Q28xnC89fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Dr/atFEwG6hNwdPI5uAFkkq/xlfsih9JP1ECKIP2QU=;
 b=I7kNFD4n/6WiKTVS0R1SL+zUPkeyPimkBuZPUkFTicF/IUV+FsVGg7Y58k54gvCQ7sNRl86FxcRD0JKfrnvNuylIBXbJ1P5PqWB3KsoZMynGk05kX+5eEI/1yJfB4Ac/HR30pZ5+rYeSvtAFXb79fawbOdU5qLpJdxeBijekJ3FGw0+zSWb4RhCxArt8DKPUZ3s1wF2oz01xXMR4ZEuNhY8fFVP9sAeFXSa/BqnON5msEECHAGt6jceTMoxYZQkWJ32FdPIbeLxC2RbPBuyfiub6JMoOjhK4UZpoTvLhTeVigtSJTo+VmOZSCdhoGcYMeSQIZmkirzjxOYjNxGWnrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Dr/atFEwG6hNwdPI5uAFkkq/xlfsih9JP1ECKIP2QU=;
 b=XBu8L94m6f6qPD60ZiLBEEMGSdiFJAnH8KUKTCKQCPaX36gW+09DB7nUbeGPDraz/RYa2/F/CitojlTyp8wbKvWrvZE/dNqwpguYGmuG3rNs8KIPGJnKohwtVnS4B4gPU8v5t6EOHmyJdIXDf7vTeqbD0Zu6F024h5R+tp1cTLs=
Received: from DM4PR12MB5938.namprd12.prod.outlook.com (2603:10b6:8:69::9) by
 LV2PR12MB6014.namprd12.prod.outlook.com (2603:10b6:408:170::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.22; Tue, 17 Jan
 2023 12:55:06 +0000
Received: from DM4PR12MB5938.namprd12.prod.outlook.com
 ([fe80::bf0c:610c:35e0:8329]) by DM4PR12MB5938.namprd12.prod.outlook.com
 ([fe80::bf0c:610c:35e0:8329%4]) with mapi id 15.20.6002.013; Tue, 17 Jan 2023
 12:55:06 +0000
From:   "Sayyed, Mubin" <mubin.sayyed@amd.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "treding@nvidia.com" <treding@nvidia.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "Paladugu, Siva Durga Prasad" <siva.durga.prasad.paladugu@amd.com>,
        "mubin10@gmail.com" <mubin10@gmail.com>,
        "krzk@kernel.org" <krzk@kernel.org>
Subject: RE: [LINUX PATCH 3/3] pwm: pwm-cadence: Add support for TTC PWM
Thread-Topic: [LINUX PATCH 3/3] pwm: pwm-cadence: Add support for TTC PWM
Thread-Index: AQHZJlXED3cYNVvf4EaskBfinQgz8q6bTAwAgAWLdKCAAakrAIAAEYDw
Date:   Tue, 17 Jan 2023 12:55:06 +0000
Message-ID: <DM4PR12MB5938774A495A246EE5557BEF9DC69@DM4PR12MB5938.namprd12.prod.outlook.com>
References: <20230112071526.3035949-1-mubin.sayyed@amd.com>
 <20230112071526.3035949-4-mubin.sayyed@amd.com>
 <20230112212514.aez6oj4zfcivknk5@pengutronix.de>
 <DM4PR12MB5938E26F6A7DFC9A1875233D9DC69@DM4PR12MB5938.namprd12.prod.outlook.com>
 <20230117112724.nnokjmfffeb2wbnp@pengutronix.de>
In-Reply-To: <20230117112724.nnokjmfffeb2wbnp@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5938:EE_|LV2PR12MB6014:EE_
x-ms-office365-filtering-correlation-id: 471482f0-8517-461d-1b90-08daf88a0ecf
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wlEiT1qzZRPw3sNWBLLJiGrTFabg/K8hhmeZAPCUSVmCZzcVC1S8XDRoRMtA6364GnYEF2mjuICXJltjnjrWv6eNu7NqyMRf88GrQz/LV0ymP59jE+28tly/qWM5sEbDZjsxsd0BvsQ7Q81/2zTcm4FmTkyNTAmjRJF9yGB85CkAEYujymY2xrDf7x8ME84nhMHR7Xt91FZjYxhModYwHWHFI0TPlYNhl4y4vkKeMLWuyV0fefLdcPBOscNN4v7TnnXck9pLRVzQQyrkdQaHgYnU2Fcu+rLQDRFvfidE5L16dyi3q+JXh5abhZxXUrIt6rl4kdMKxX9eN/vxEhqpvhDCnRjnlv1o9aEbyoicNNGq4C1f+ZuWwwU2A3nuYXQ98gB+FdBwuzH3lZaa8Pw0vyKCHxyXpdTddZBE47PgIpeXEacDv8/6e3P4JdATJg77xAv4Xnaik20JUvfunNPzbTUBZYLSEgK67XLOnL6cIbqZPUYXS5GUGlcEPhaWMm/tIqDOzd51ur3+sToRwIJoTDDx7aOuaxNDxi8Bc7Nar9BuYMWVhjvmuwYsRz9mjGiToIbnx9B4K3DvWcIiqqPvN9JHSSMwkydvGaRmm9tZ+ZYmmz4lf1nDc4LjRLz6S8EZbr6bdJrymjvYW2dCyjt6Kqd3chbOdCS8b0GvP/3viArjr3DQtxp4aSeMmSTGoaa5gzRKS/lmbYjU1+hLM0wI1VBVkme/tspRNdQd+Q9l7FM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5938.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(451199015)(2906002)(52536014)(8936002)(5660300002)(7416002)(66446008)(8676002)(83380400001)(66946007)(86362001)(6916009)(64756008)(76116006)(4326008)(66556008)(71200400001)(33656002)(316002)(54906003)(41300700001)(66476007)(7696005)(26005)(966005)(53546011)(6506007)(186003)(9686003)(55016003)(66574015)(38070700005)(38100700002)(478600001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?QllBOeLp0A0KV4qApTQaZqR2kA/ikEhLBhIqTTslxkOqTkd3pt4W5GWn6a?=
 =?iso-8859-1?Q?KUaClz6VFDal8Jq7wDOMArNKRSjdS15q03UZ26rObteze0ETPyLJmsZjoE?=
 =?iso-8859-1?Q?+hG3UyjQvqoQzni3fDpeRXqRWPC5zgATd2DtNbO1eatv0Ste8z0eQPcHsw?=
 =?iso-8859-1?Q?JjkznHxyPl4BNtUPMpIc3pD29a5y7Uk7BYX8RFgzefmuY7DbJaWwmk7y75?=
 =?iso-8859-1?Q?BveSalp5FGqLep7OaYzSG9HxS0CrBA9FC3+HSvwtxBmemngHvW0f8Cztax?=
 =?iso-8859-1?Q?Zt8tgzP6NDZmWEmP25BsVhl4Dad1yQJ/Au+98OuQgDS1q4T6tEEdkzOW3B?=
 =?iso-8859-1?Q?DiFKedlBU7JtCKgQSCGZt67frzYUrDeX7RffmLTwqgtV6kNeb+trcdl4LA?=
 =?iso-8859-1?Q?rd/nktG1t87++XObg2r8zU8JpWi2xlKig0sn5LUrwfjLpZORnQ5OmHwSO3?=
 =?iso-8859-1?Q?QIYkM1SE8uFlvU38eindZV8Ay9QHWspYHC6s/SNO4nQe0rhHnrDK/zdA8g?=
 =?iso-8859-1?Q?1zw45jF+wmH6rbTrbmZDoSggTZe1ld7mKxa9kc1Pt/wTH5wHjZasCr1xs9?=
 =?iso-8859-1?Q?DXKf5faUbxC/9Bpk0bClSqaLJYASgMfCZvVCiEsop3v2laabdyQ2uKG9l1?=
 =?iso-8859-1?Q?UWtaKEpDUJ2m/NHo/tZwDSI7+KnpyfN2FJY1cPj9Lnt9kdS4K4hQWVasZi?=
 =?iso-8859-1?Q?33Wb6uML5lywIJ7Dhso5JTc2Dt+eApKVjparpJHqdTqY9KE08lT3SQw+Qe?=
 =?iso-8859-1?Q?cTBh5DW4Mr9Oa0PojuXSvMkksItXPTzw5hoCUHxEhqMmFmdTd1q9/umxPj?=
 =?iso-8859-1?Q?4MYXwJ29zGp+0R1a+tkmX7nhA1dGXltathLD7qvIGDY/IUk0sF5tJVMScM?=
 =?iso-8859-1?Q?NxozHqr3OQLxDwz8PD79/rgJxbJOD7dDsIxZfBqfCscNNYA2lsHMshVk5T?=
 =?iso-8859-1?Q?KZbwAzBd0zLjZITdWMFkXwcqZ3yMiNdm5MQUzA8HZgOztdXOO38UQmOtsR?=
 =?iso-8859-1?Q?Oz2/Uhd+05i1DIPBWNnjevaRXHuMB+4GodcVp64MrYj6C1fNLjm3V3Y6/K?=
 =?iso-8859-1?Q?/1asydCQY/Wr+JasiC4PykfS1SGrQsTQZr+G46B58SFZgslp+ebkNVaAdk?=
 =?iso-8859-1?Q?ncRQo3LTdANfqx9vAqcotSzLZOH/5J+7WcGOwAe7dFsDsz68SSPU+0Nmtu?=
 =?iso-8859-1?Q?oQucPlhyzscLKzlTbyIWSr0JlA+zQvT9zHz8NyxNRHrm8/6oEj67EFXOSq?=
 =?iso-8859-1?Q?ZU3bWNv4iTdFMXIwmCsflTI04ZiMF4fZpx+GslD3GXyYrQU4LA+dDOKO3x?=
 =?iso-8859-1?Q?VBBDyTkV3rsZpK85ieVtHOLvnNvBRrRrDVrGdzbRYHU+83WckJpMsv50q4?=
 =?iso-8859-1?Q?/NLjiqYMgC89/oEqUY1PlDgPf1TDIcu9KOuvUUgdOVy223UgFpJCSJZqrq?=
 =?iso-8859-1?Q?vFDwTwQw1iNCYLw8XM70so7kXffbQENNgOu8fkEtnmbdg/lwDRwpdkZ0Vy?=
 =?iso-8859-1?Q?yOr3FQ2hix5kVXsMz8To5BDGG2nl6wk9ShlQWnI9gZff/XDO/kIqIMEonN?=
 =?iso-8859-1?Q?srB7anVWUMRxFRoHcUYhDynla9Ae0VuRc4ifL6zHhL50ryxdXt2Ve5gkkp?=
 =?iso-8859-1?Q?wPQsg8g2SSEEU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5938.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 471482f0-8517-461d-1b90-08daf88a0ecf
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 12:55:06.3819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4xYVNV1EOxAiTOaCcTE4iS4dfvEVzFdh1Sk5drAthUBj/wdKDA47vURkTMVditsPRjP7NtkUbf2vzpg26zh9Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6014
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uwe,

> -----Original Message-----
> From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Sent: Tuesday, January 17, 2023 4:57 PM
> To: Sayyed, Mubin <mubin.sayyed@amd.com>
> Cc: robh+dt@kernel.org; treding@nvidia.com; linux-pwm@vger.kernel.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; git (AMD-Xilinx) <git@amd.com>; Simek, Michal
> <michal.simek@amd.com>; Paladugu, Siva Durga Prasad
> <siva.durga.prasad.paladugu@amd.com>; mubin10@gmail.com;
> krzk@kernel.org
> Subject: Re: [LINUX PATCH 3/3] pwm: pwm-cadence: Add support for TTC
> PWM
>=20
> Hello Mubin,
>=20
> On Tue, Jan 17, 2023 at 09:58:10AM +0000, Sayyed, Mubin wrote:
> > > On Thu, Jan 12, 2023 at 12:45:26PM +0530, Mubin Sayyed wrote:
> > > Is there a public manual for the hardware? If yes, please mention a l=
ink
> here.
> > [Mubin]: I did not find any public manual from cadence. However, detail=
s
> can be found in Zynq-7000/ Zynq UltraScale/Versal ACAP TRM available
> publicly.
>=20
> Thenk please add a link to that one.
>=20
> > > how does the output pin behave between the writes in this function
> > > (and the others in .apply())?
> > [Mubin]:  ttc_pwm_apply  is disabling counters before calling this
> > function, and enabling it back immediately after it.  So, output pin
> > would be low during configuration.
>=20
> Please document this behaviour (i.e. "A disabled PWM emits a zero") in a
> paragraph at the top of the driver in the format that e.g.
> drivers/pwm/pwm-pxa.c is using. Also please test if it emits a zero or th=
e
> inactive level, i.e. if the output depends on the polarity setting.

[Mubin]: will confirm behavior on hardware and document it.
>=20
> > > > +		rate =3D clk_get_rate(priv->clk);
> > > > +
> > > > +		/* Prevent overflow by limiting to the maximum possible
> period */
> > > > +		period_cycles =3D min_t(u64, state->period, ULONG_MAX *
> NSEC_PER_SEC);
> > > > +		period_cycles =3D DIV_ROUND_CLOSEST(period_cycles * rate,
> > > > +NSEC_PER_SEC);
> > >
> > > DIV_ROUND_CLOSEST isn't suiteable to work with u64. (That's also the
> > > reason for the build bot report.)
> > >
> > > The usual alternative trick here is to do:
> > >
> > > 	if (rate > NSEC_PER_SEC)
> > > 		return -EINVAL;
> > >
> > > 	period_cycles =3D mul_u64_u64_div_u64(state->period, rate,
> > > NSEC_PER_SEC);
> > [Mubin]: Initially I tried mul_u64_u64_div_u64, it was impacting
> > accuracy while generating PWM signal of high frequency(output
> > frequency above 5 MHZ,  input 100 MHZ ). Usage of DIV_ROUND_CLOSEST
> > improved accuracy. Can you please suggest better alternative for
> > improving accuracy.
>=20
> Unless I'm missing something, you have to adjust your definition of accur=
acy
> :-)
>=20
> If you request (say) a period of 149 ns and the nearest actual values you=
r
> hardware can provide left and right of that is 140 ns and 150 ns, 140ns i=
s the
> one to select. That is pick the biggest possible period not bigger than t=
he
> requested period. And with that pick the biggest possible duty_cycle not
> bigger than the requested duty_cycle. (i.e. it's a bug to emit period=3D1=
50ns if
> 149 was requested.)
>=20
> There are ideas to implement something like
>=20
> 	pwm_apply_nearest(...);
>=20
> but that's still in the idea stage (and will depend on the lowlevel drive=
rs
> implementing the strategy described above).
[Mubin]: Thanks for explaining, will switch to mul_u64_u64_div_u64, though =
percentage of deviation would be more for PWM signal of high frequency. For=
 example, requested period is 50 ns,  requested duty cycle is 49 ns(98%), a=
ctual duty cycle set by driver would be 40ns (80%).

>=20
> > > Another possible glitch here.
> > [Mubin]: Can you please elaborate.
>=20
> If you switch polarity (say from normal to inverted) and duty/period you =
do
> (simplified)
>=20
> 	ttc_pwm_disable(priv, pwm); // might yield a falling edge
> 	set polarity                // might yield a raising edge
> 	ttc_pwm_enable(priv, pwm);  // might yield a falling edge
> 	... some calculations
> 	ttc_pwm_disable(priv, pwm); // might yield a raising edge
> 	setup counters
> 	ttc_pwm_enable(priv, pwm);  // might yield a falling edge
>=20
> so during apply() the output might toggle several times at a high(?)
> frequency. Depending on what you have connected to the PWM this is bad.
> (A LED might blink, a backlight might flicker, a motor might stutter and =
enter
> an error state or accelerate for a moment.)

[Mubin]: Agreed, will modify logic to avoid toggling
>=20
> > > > +	clksel =3D ttc_pwm_readl(priv, TTC_CLK_CNTRL_OFFSET);
> > >
> > > TTC_CLK_CNTRL_OFFSET is as parameter for ttc_pwm_ch_readl and
> > > ttc_pwm_readl, is this correct?
> > [Mubin]: Here TTC_CLK_CNTRL_OFFSET is being read only for 0th channel,
> so using ttc_pwm_readl does not impact offsets.
>=20
> So which clk is selected (for all channels?) depends on how channel 0's c=
lock
> setting is setup by the bootloader (or bootrom)? Sounds strange.
[Mubin]: I confirmed that each channel can have separate clk source. I will=
 update it for all channels and modify ttc_pwm_priv structure accordingly.

Thanks,
Mubin
>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
