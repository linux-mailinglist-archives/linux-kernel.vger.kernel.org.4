Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364E6647F9D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 09:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiLIIzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 03:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiLIIy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 03:54:58 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A99186DC;
        Fri,  9 Dec 2022 00:54:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9/SjpJahQe/A6Y8wypMmymj2CqTNHQwE6VKa3xkOdl+V2F6kRaP/n6NecW463dhIcY6bACXvfDIcrgrWxKIIF2tnbshRgAAvOM1moylUcN4olCNr9kjJSg/H8ve1u85u2Xx1qJ6GqRaetOrZrOLuSytjFK+1JOglCrJIaGPyOUjz4Bin3LRDNvN7ocom7E6JIBsT5Sw3wOHw2ttx/qrSb5CK5aaKMZK/yRzG7AtI/6V7BdE3XwA0raSYEIGPhzr0Div7twv1e2+YDDR0sDpaxX9JS3BIgBnI5mvzfkE+I4NPGWDBxwXsszUBBf+sdyvwQwmaRoK0kPXGKkMbXUYdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ew7lqkoVyni3VNxgJ1UkBqeBB5mkrJ473nyqYcr2yLI=;
 b=C69rpugnRcCnf1zGLMZrWrrL+wchhe4bsxuqHoj2X0D7xk2zQWaDSi4iSA/zi4mSKbJEMXFVVQbZuZu8yANLTj0qMxqpnAFVnrkXr4YPsQoAncIsB6Yp73WHJtRhy5iPVok/omGKoSfeuOWHiD3HWSy9hjIX0NXJhGsKzVtaZmN3XeDhUwvJO10LR5+wPr59a1Apg8aMxaBo0MQknJJr26Dx5+crKJQRcDBoAT+MO77GayNerKkq8XXjZD0uX3B37AN8WmyEppWw8uSrQ7ogG6ww8XdeYDt4EgLzPwmKCW1nKNGcgRumieADbC8mzf8JgDhwyNV4nDPoizz3psPPrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ew7lqkoVyni3VNxgJ1UkBqeBB5mkrJ473nyqYcr2yLI=;
 b=SzSZtCzL2WGHmF6NC/AgzaHBxenBe6YX7jFWPpmUptQE1PJuO33wTmK1HDneqMTVb+4R5N1IMGwiMH9yHSsCGaKZAQjF4sZUMJjJZ7TwKnjZ5gvXfitK9UawAh2A1YLQDZc8UWVS9dxnn9En4idlW2TU5WRkV7niwrmE2TSSW4A=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by SA0PR12MB4447.namprd12.prod.outlook.com (2603:10b6:806:9b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 08:54:55 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed%8]) with mapi id 15.20.5880.016; Fri, 9 Dec 2022
 08:54:55 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     "Huang, Ray" <Ray.Huang@amd.com>
CC:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v7 03/13] cpufreq: intel_pstate: use common macro
 definition for Energy Preference Performance(EPP)
Thread-Topic: [PATCH v7 03/13] cpufreq: intel_pstate: use common macro
 definition for Energy Preference Performance(EPP)
Thread-Index: AQHZCvcVwY+lM4LD2E6Oda1tHNhqUK5lMu+AgAAOkBA=
Date:   Fri, 9 Dec 2022 08:54:54 +0000
Message-ID: <DM4PR12MB527803DBD30226646B81A7E39C1C9@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20221208111852.386731-1-perry.yuan@amd.com>
 <20221208111852.386731-4-perry.yuan@amd.com> <Y5LrVdS9oFKIvC70@amd.com>
In-Reply-To: <Y5LrVdS9oFKIvC70@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-12-09T08:53:31Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=027c62c0-2a26-4127-aadc-362b049a7ab6;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-12-09T08:54:52Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: cca00540-04b1-449a-b127-afa1b22000d5
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|SA0PR12MB4447:EE_
x-ms-office365-filtering-correlation-id: 66a31464-580c-4393-62e9-08dad9c30ac2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BYEsXBqnBHCJmTXh4OUBFKvqJDDZRzpTEswffCWccs9/ksdBJKGln9Q8Qs6aJ/koO0yA9S7XGnvPRIsBBP4Br8KsO21jsoZbAeyO2a8e6tVo3iA0WnwFmgTrCwARfJItwKIFAVzI1J8qHuG5LnstzlldLUOyH35vGG4J/cbHvTwPCKMeFGlulSp55Ny108B2T+QylAGqWk15kx8ic9lCiyuUILpiIC1ldUVozHNNy99ZdIrmGgYGlhh1Z2acXKzIhlP9c2BwlMUj8AaVEGNpQVnBPJMopq4oQcdXwioFOU72+2dUctSDs8t8U1sQxbMClN16WYn52VphStmPOq/tswdKSBuP7wYac9ptv9aytLIJ6EMYRF9dlve5ucRDGM8Q234O8zTNs+c5qH/kbeCyJowjhrRYxlPP5RvLr2QMQcTz55eAZYcOompodm3wcWrsF1ci9VHOzEeFfiQtsK711zZnoFNbxSxMdJQ//4W5iyoBks8xhyNW0Xo5xc+liqbqIUNdrcrIXa1NMIejFFWZWl75lzHIuigS5u2+BpOM2jnkkiQqQ+rjGB7GSNEhqMdzUpRkkO+69XEWzS64vfPI046OdS03/AiJvnuFhLIJWtrG4itQzDhlA69nQGJplL/tNcwJbhIxbNB1pc65761OMbpncKXWTXQ7j+GsiiwRvvm/qYRtG6+6I0rGRTxCZ5RQlgLn0Ld3vQGsi01LGcgy0rCpJecU9h2+DbnHBzxBLas=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(376002)(346002)(366004)(451199015)(86362001)(66946007)(966005)(66556008)(8676002)(4326008)(66476007)(6862004)(64756008)(2906002)(41300700001)(38070700005)(66446008)(83380400001)(122000001)(38100700002)(33656002)(54906003)(6636002)(316002)(76116006)(478600001)(8936002)(6506007)(5660300002)(52536014)(71200400001)(9686003)(186003)(55016003)(53546011)(7696005)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hc+0jwMEa9MPS4fOzaO98JLoWY3Q3QgK3h3YC+/cvNjjBoiRM/vGG3yKAujx?=
 =?us-ascii?Q?MOat/ts6u0+Q2Aj6L0o8rlhorNIhtD9iXRMRui9Y1fI2VK7g231RJYCeOaqK?=
 =?us-ascii?Q?5aOWPV6tLjoa6rkWK7uL9pUQ4bCUk95tPw+dAlhhSESKWAwSpSMQtTRwIoHq?=
 =?us-ascii?Q?x6C7c1y9fmAMMvhOF1jATl9Xth+gZZYiYETCtHR0w73vZHoNAuZnCDPogbzg?=
 =?us-ascii?Q?miPSUZ0zStiZ38Kzg0qKPKcfeko/yjvQXMOUQD6ezc6HEO0vwvCQRSJUKUKI?=
 =?us-ascii?Q?fgnZBbunWO0wFkEFqGUTHuR4bRqHIyvyYrUQ1P8XE/ZtUitAXUBaQXQF4Axz?=
 =?us-ascii?Q?aa60Rx/dwU1nDaid+bT0Ib6mZN569za6lWDDYWNfNQdwEQCJRV1PBH5EuO05?=
 =?us-ascii?Q?T6phb7jNr19CPnBo/E0qfzxD/V4R7e7qqPfW/pNFlm14vmFffn+w3SzhXJ3U?=
 =?us-ascii?Q?Ic7ROqVrZqp+Iw6LGOvn3FSZPWrC8g4OM8mPrDvejomrQAnwhA6VX6Ntcqmo?=
 =?us-ascii?Q?f25BQdfegtJlACIsEEio9TuBd4xdMlE8z+dvJtwJ10bOZCmz8EOkUfWRB5sx?=
 =?us-ascii?Q?sim4h1tKqWXCLDbZdrsRk6Lzod8bob6c/GLn/rRqF4eQ/MrwHb9wSULyydXw?=
 =?us-ascii?Q?uFGIwz46jXMy2fwdolwpop9z/GzrwRDJmRLHO+zhYT2nEfFOKx0/P0Ong3JJ?=
 =?us-ascii?Q?1qud1OMRG7s0+mRXZTyTUTyrc+vUYUiYFSAo8jA3axWJXwlI0zqSEc1CMtO4?=
 =?us-ascii?Q?RrKiZfRXmfbax17EaSfd3gBak2qib5jAXmrWcj7b0DpMlrRZhZ8taXRmo9AJ?=
 =?us-ascii?Q?uWa6P2Wzxm8WQxYwhoS8qyOkY3EtQFzKOcCKb/ohOW4bxCXjVeLy6OK/+S3T?=
 =?us-ascii?Q?n22G8llpyO9P01XE7Zjvuw9GHK1AFPQB8fvG2S444UvHOtPMpF2YObBKRob8?=
 =?us-ascii?Q?7fio8OiShUcubeelyoyBB/0+iPijt9ow9gHmR1zu3nMkfm/v9UttimgGQQjw?=
 =?us-ascii?Q?8Yv0RK2iTNz0/kM51MsaipNDEBq13UP30I0XYZ6elEOwuF7n6AUr0cAQ5Vy2?=
 =?us-ascii?Q?it8PvGJGCFkYWl+tPm2K9T7qyIzmWVOWl1bf7xAohs8JWz5rohp+MjDJnv9t?=
 =?us-ascii?Q?p1Q8gnXpQnXMv+IYpSFNJS6p6BYQAWyT2/xGgcDmJQRaYQXz/4fqN+tUg37M?=
 =?us-ascii?Q?MQe4rGXhRJmZNoeNMBCPcy4nM6Zy0D3MLiauA5dB/XdfjlPeG67L4VitVZwT?=
 =?us-ascii?Q?BoA0m/BiESdPIwyofC8k0t0SYCZpY504yjjPzYR0cDpxP7uaY587wPIhGkZa?=
 =?us-ascii?Q?emc7aV7fICuPl8jyzIW4PeDw4Kp6I4fYRtNI4GPhbaqsFBiEhqfN1A6RRwzm?=
 =?us-ascii?Q?GREMLwcWjE0noPXuxYWDrPNXHc25jajGXHN2OGnp+MDZT2aMm0UCeoTewLfa?=
 =?us-ascii?Q?C0zWseRoomn8jW0zvfUJAr7ksnOAAzG3EQUQMG9Mf3RWEJCO/xVNuGI+HSzt?=
 =?us-ascii?Q?FuOhluiNGfOyPtwu10V7i/dAXx5V3mimPrjQnY5TdJ+B75W6aGayeHuG9n/T?=
 =?us-ascii?Q?mXDLU/kxmD9uXchs5swpzeku1YGU+H6Uu5pQdWjg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a31464-580c-4393-62e9-08dad9c30ac2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2022 08:54:54.8083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u5btPur1s04smUYqdzzoejFBcKthl6ixoIZtb38MnOAfjcjcNmzE+AOJ3PxOc6FgkQkihDGfIHPKM8CGQmX+Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4447
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]



> -----Original Message-----
> From: Huang, Ray <Ray.Huang@amd.com>
> Sent: Friday, December 9, 2022 4:01 PM
> To: Yuan, Perry <Perry.Yuan@amd.com>
> Cc: rafael.j.wysocki@intel.com; Limonciello, Mario
> <Mario.Limonciello@amd.com>; viresh.kumar@linaro.org; Sharma, Deepak
> <Deepak.Sharma@amd.com>; Fontenot, Nathan
> <Nathan.Fontenot@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Huang, Shimmer
> <Shimmer.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Meng,
> Li (Jassmine) <Li.Meng@amd.com>; Karny, Wyes <Wyes.Karny@amd.com>;
> linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v7 03/13] cpufreq: intel_pstate: use common macro
> definition for Energy Preference Performance(EPP)
>=20
> On Thu, Dec 08, 2022 at 07:18:42PM +0800, Yuan, Perry wrote:
> > make the energy preference performance strings and profiles using one
> > common header for intel_pstate driver, then the amd_pstate epp driver
> > can use the common header as well. This will simpify the intel_pstate
> > and amd_pstate driver.
> >
> > Signed-off-by: Perry Yuan <perry.yuan@amd.com>
>=20
> Please address the comment in V6:
>=20
> https://lore.kernel.org/linux-
> pm/Y43aq2gMKnFRIhxh@amd.com/T/#md503ee2fa32858e6cc9ab4da9ec1b8
> 9a6bae6058
>=20
> Thanks,
> Ray

Talked with Mario as well, will fix the build failure and get this changed =
in V8.=20
Thanks for reviewing.


>=20
> > ---
> >  arch/x86/include/asm/msr-index.h |  4 ---
> >  drivers/cpufreq/intel_pstate.c   | 37 +---------------------
> >  include/linux/cpufreq_common.h   | 53
> ++++++++++++++++++++++++++++++++
> >  3 files changed, 54 insertions(+), 40 deletions(-)  create mode
> > 100644 include/linux/cpufreq_common.h
> >
> > diff --git a/arch/x86/include/asm/msr-index.h
> > b/arch/x86/include/asm/msr-index.h
> > index 4a2af82553e4..3983378cff5b 100644
> > --- a/arch/x86/include/asm/msr-index.h
> > +++ b/arch/x86/include/asm/msr-index.h
> > @@ -472,10 +472,6 @@
> >  #define HWP_MAX_PERF(x) 		((x & 0xff) << 8)
> >  #define HWP_DESIRED_PERF(x)		((x & 0xff) << 16)
> >  #define HWP_ENERGY_PERF_PREFERENCE(x)	(((unsigned long long)
> x & 0xff) << 24)
> > -#define HWP_EPP_PERFORMANCE		0x00
> > -#define HWP_EPP_BALANCE_PERFORMANCE	0x80
> > -#define HWP_EPP_BALANCE_POWERSAVE	0xC0
> > -#define HWP_EPP_POWERSAVE		0xFF
> >  #define HWP_ACTIVITY_WINDOW(x)		((unsigned long
> long)(x & 0xff3) << 32)
> >  #define HWP_PACKAGE_CONTROL(x)		((unsigned long
> long)(x & 0x1) << 42)
> >
> > diff --git a/drivers/cpufreq/intel_pstate.c
> > b/drivers/cpufreq/intel_pstate.c index ad9be31753b6..1b842ed874ab
> > 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -26,6 +26,7 @@
> >  #include <linux/vmalloc.h>
> >  #include <linux/pm_qos.h>
> >  #include <trace/events/power.h>
> > +#include <linux/cpufreq_common.h>
> >
> >  #include <asm/cpu.h>
> >  #include <asm/div64.h>
> > @@ -628,42 +629,6 @@ static int intel_pstate_set_epb(int cpu, s16 pref)
> >  	return 0;
> >  }
> >
> > -/*
> > - * EPP/EPB display strings corresponding to EPP index in the
> > - * energy_perf_strings[]
> > - *	index		String
> > - *-------------------------------------
> > - *	0		default
> > - *	1		performance
> > - *	2		balance_performance
> > - *	3		balance_power
> > - *	4		power
> > - */
> > -
> > -enum energy_perf_value_index {
> > -	EPP_INDEX_DEFAULT =3D 0,
> > -	EPP_INDEX_PERFORMANCE,
> > -	EPP_INDEX_BALANCE_PERFORMANCE,
> > -	EPP_INDEX_BALANCE_POWERSAVE,
> > -	EPP_INDEX_POWERSAVE,
> > -};
> > -
> > -static const char * const energy_perf_strings[] =3D {
> > -	[EPP_INDEX_DEFAULT] =3D "default",
> > -	[EPP_INDEX_PERFORMANCE] =3D "performance",
> > -	[EPP_INDEX_BALANCE_PERFORMANCE] =3D "balance_performance",
> > -	[EPP_INDEX_BALANCE_POWERSAVE] =3D "balance_power",
> > -	[EPP_INDEX_POWERSAVE] =3D "power",
> > -	NULL
> > -};
> > -static unsigned int epp_values[] =3D {
> > -	[EPP_INDEX_DEFAULT] =3D 0, /* Unused index */
> > -	[EPP_INDEX_PERFORMANCE] =3D HWP_EPP_PERFORMANCE,
> > -	[EPP_INDEX_BALANCE_PERFORMANCE] =3D
> HWP_EPP_BALANCE_PERFORMANCE,
> > -	[EPP_INDEX_BALANCE_POWERSAVE] =3D
> HWP_EPP_BALANCE_POWERSAVE,
> > -	[EPP_INDEX_POWERSAVE] =3D HWP_EPP_POWERSAVE,
> > -};
> > -
> >  static int intel_pstate_get_energy_pref_index(struct cpudata
> > *cpu_data, int *raw_epp)  {
> >  	s16 epp;
> > diff --git a/include/linux/cpufreq_common.h
> > b/include/linux/cpufreq_common.h new file mode 100644 index
> > 000000000000..c1224e3bc68b
> > --- /dev/null
> > +++ b/include/linux/cpufreq_common.h
> > @@ -0,0 +1,53 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * linux/include/linux/cpufreq_common.h
> > + *
> > + * Copyright (C) 2022 Advanced Micro Devices, Inc.
> > + *
> > + * Author: Perry Yuan <Perry.Yuan@amd.com>  */
> > +
> > +#ifndef _LINUX_CPUFREQ_COMMON_H
> > +#define _LINUX_CPUFREQ_COMMON_H
> > +/*
> > + * EPP/EPB display strings corresponding to EPP index in the
> > + * energy_perf_strings[]
> > + *	index		String
> > + *-------------------------------------
> > + *	0		default
> > + *	1		performance
> > + *	2		balance_performance
> > + *	3		balance_power
> > + *	4		power
> > + */
> > +
> > +#define HWP_EPP_PERFORMANCE		0x00
> > +#define HWP_EPP_BALANCE_PERFORMANCE	0x80
> > +#define HWP_EPP_BALANCE_POWERSAVE	0xC0
> > +#define HWP_EPP_POWERSAVE		0xFF
> > +
> > +enum energy_perf_value_index {
> > +	EPP_INDEX_DEFAULT =3D 0,
> > +	EPP_INDEX_PERFORMANCE,
> > +	EPP_INDEX_BALANCE_PERFORMANCE,
> > +	EPP_INDEX_BALANCE_POWERSAVE,
> > +	EPP_INDEX_POWERSAVE,
> > +};
> > +
> > +static const char * const energy_perf_strings[] =3D {
> > +	[EPP_INDEX_DEFAULT] =3D "default",
> > +	[EPP_INDEX_PERFORMANCE] =3D "performance",
> > +	[EPP_INDEX_BALANCE_PERFORMANCE] =3D "balance_performance",
> > +	[EPP_INDEX_BALANCE_POWERSAVE] =3D "balance_power",
> > +	[EPP_INDEX_POWERSAVE] =3D "power",
> > +	NULL
> > +};
> > +
> > +static unsigned int epp_values[] =3D {
> > +	[EPP_INDEX_DEFAULT] =3D 0, /* Unused index */
> > +	[EPP_INDEX_PERFORMANCE] =3D HWP_EPP_PERFORMANCE,
> > +	[EPP_INDEX_BALANCE_PERFORMANCE] =3D
> HWP_EPP_BALANCE_PERFORMANCE,
> > +	[EPP_INDEX_BALANCE_POWERSAVE] =3D
> HWP_EPP_BALANCE_POWERSAVE,
> > +	[EPP_INDEX_POWERSAVE] =3D HWP_EPP_POWERSAVE, }; #endif /*
> > +_LINUX_CPUFREQ_COMMON_H */
> > --
> > 2.34.1
> >
