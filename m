Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C4E649AEF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 10:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbiLLJTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 04:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbiLLJSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 04:18:17 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DD0F020;
        Mon, 12 Dec 2022 01:17:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QbTMO+yoTIbb7ydj7YuoW6cM4OF40ky+vw+p4Vyd9THy5MmUQSvj1eTZ2++sNhhUp0H9ZVC425tbbxP3CZhRhPdr/txEz4Gcb60kmqTjwQ/pHupHQUAnP2fb1DvUJ7QhGzRCX865lnvpDKBPUrXBR4AtXrAxCVwQKcqwmpVrjQlYuH9VojZW0/PUgGSV5y2eGofZOeWAoayVPRPQMSim4eOvBBbH+DT2cZy9Ufq0TlzzT5dxsvOrnoZaMbaGMjdSQCnlzoexaWYoVkhUewuhSznU2oXGqNX+EzAfhvml9y0HcRQgCIpAvhzU0FByQqYnU8ZwN/f2xmpYpPLpP/Lfmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmkhA1pXTd+ngPL8mf9gLsvajHnwv8aHVkDa21VDxPI=;
 b=lxe7COaXrAjV083NCdjWzo3EwU9mH21yTh0fqQJmuE/u7gJIuDgEm2OD7JbOixFLhxW+3EPRZXHs6HJV0YFjfzAAQNSruSqK6udeDtqM3zlXniqvGTX4IbAUqzJiSH/8nvbaCNli104tPr4uXQnyqkssOfkXOzA30B54qSHvVkHs/YiNWD2NyEmwOMAwHRTFddkZFs8R6cEmNBVUXLrHtC0fxbtxUwbcW+A/dNusfwPnFbxBRIngeTT6Z/9bSAYO00kHiIt+LOTwmTESxci9wxZayXA3m2jrtWPuOZ6yAyntUWjXNqNO34VYHOXtE9053mEBsRpXnO2k4DghLuLSGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmkhA1pXTd+ngPL8mf9gLsvajHnwv8aHVkDa21VDxPI=;
 b=RSp4krzQ1I7YZHycdQrmkaTxCvZJLu8ooOMUVHbFuFqegEIv9UWTg5e0Yb1oqWFaLxfp+cymr15T6Wh/R+J0Cxrck7wSF0yNoWnGjLcIlfyvaOdiYE4bzTlMsyds4fOCMdOU/v1jyu5LNBxgIMP1OQWlF8DOZBKrI4vXv9fWszg=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by CY8PR12MB8242.namprd12.prod.outlook.com (2603:10b6:930:77::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 09:17:32 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed%8]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 09:17:31 +0000
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
Subject: RE: [PATCH v7 01/13] ACPI: CPPC: Add AMD pstate energy performance
 preference cppc control
Thread-Topic: [PATCH v7 01/13] ACPI: CPPC: Add AMD pstate energy performance
 preference cppc control
Thread-Index: AQHZCvbtROnCBcp0JUOaXLGbvuivq65lMScAgARszACAAGEJcA==
Date:   Mon, 12 Dec 2022 09:17:31 +0000
Message-ID: <DM4PR12MB5278FF0C5CACCE36EFE2B1049CE29@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20221208111852.386731-1-perry.yuan@amd.com>
 <20221208111852.386731-2-perry.yuan@amd.com> <Y5Lp1n3ZuSsWjeEx@amd.com>
 <Y5agGGNf1r3Dn9bc@amd.com>
In-Reply-To: <Y5agGGNf1r3Dn9bc@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-12-12T09:17:29Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=44013819-8fee-44b4-bd4b-01f96c1b301f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-12-12T09:17:29Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 04bda240-2624-4e52-87ee-18aafbf8658a
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|CY8PR12MB8242:EE_
x-ms-office365-filtering-correlation-id: f9ecc34b-e6db-48eb-4a67-08dadc21b2d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xt75mO852Bj2Axo18AHIczWLG+XmkqlNt8R2ppiZhFrKb35T9yUAw/WatcoBerMzuQ3PQx6AFzYNRgVCS1cc+CGOlXJ9kONxViB+0il3tAZ4K0F/bAkViGxqQkSkYoAkKmFl3fTMagn9y5dMDouWyWnRWnsN/zNGPHTQgqegUTDVnR3XoXGN8f/KgY9zxs3FPnc19g1+n9tsYP73Lhb54b8USqpYvqLxg7niaAWsLR0Li4n2wxK4gi6TVt0q/0s6qwjpMZh+hBT3w+t/LdTGfpo0a2aehzfVZuJRMs9MiLWCmCH3+svprXGzW0q0cy3rG50LmHNGF9GL7w8pW84S0FS1eXjwJ65RWwwIdlB5taGBWZBzvJPTI/i7r6wmeow2NBu/mdPeenXGXFlLEwY4i8OfGnuybXQuHQqmIBfD4TybzDdbfwDQYXtfSD1TRS4Tvp5GLD9ABmHqdOVjnwXHFHpSZDzMMQut/1i6XBkn0CWMBTzgx2u7O+xAOBK0BcuwEvfTDfABtyP5hmBAtTk5dGg1M4qpsEZUpPjxXafTucw4KXQjvI38s2LFokiyNMWCXrQQK46VMQTPA4iyB9GKXnqPh8HAR2MI4m2JytSIC4fCStTYFbqHjK7DBjg+C6tRXgQlekBup/rvBt6o4n7sWdoy3Ub6aT3OQhPHaO+cXEY5rwcTeGdZh4CK0ZOXO/ovvyeO/QaHCgyKZgFRyzy1uQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(451199015)(38070700005)(86362001)(478600001)(71200400001)(6636002)(316002)(54906003)(38100700002)(122000001)(33656002)(186003)(53546011)(9686003)(26005)(8936002)(6506007)(7696005)(55016003)(52536014)(66556008)(66446008)(41300700001)(66476007)(76116006)(66946007)(6862004)(5660300002)(2906002)(64756008)(8676002)(83380400001)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?O8s+Hyu/6PjmiWfMTPbPpAd3XRj9KOG+XsvPtoQLBi/qi3SJ54xj4v12EyTK?=
 =?us-ascii?Q?HFyqXhkVu0h6H0Uxm7U74WG0PMdAIYSYKZTIWHR+vh5TF8hL9FqvTzivZVg8?=
 =?us-ascii?Q?G8KHMgQYuri62myrtSh5+s+bH2g4tXhs4WYGV6XV7NQvhVygkT178cJMlszD?=
 =?us-ascii?Q?3v6h2oFj+RbFj7KlOukfocGJcK3OCDUX39Zn0G8mpg5jKPk65nUibJlJCCUa?=
 =?us-ascii?Q?NWn/eqphMie9/xAMl7z5MxuFwujmlQwCqSv8JvWletu42jXyG5K1xgaggQY4?=
 =?us-ascii?Q?bmiwitpBA1nQki/Hcf3kkIw2GevHgYAH2c5H1rnynaGZeYbLDfN0kK1ugHn9?=
 =?us-ascii?Q?uFXSkwV3VukyY8CWc2LADqL67rsjVZdkKmS4q2Y0WEx6AFE5Z+JYkgJU5rxw?=
 =?us-ascii?Q?20rpr7mKy+qqWuKyaGK/e2hURkOnU+1vdZiBC3LpCB+3v24Pb7azUR32ql5G?=
 =?us-ascii?Q?3V1P/dq6xMo1wM32jsAZaBUxkIzflkH+iITQ6x35ohktEsVJ8N4UIHxSFC8T?=
 =?us-ascii?Q?om6srNhSY/qox1GFgxrdn26HLGJFuUlSSC0/twY9HWPvRuVVnn7IJdR+5XHb?=
 =?us-ascii?Q?YaeF1h8zRp305OanIgwN+uMH0j5/UfHnhPJ6Htf2Z7dRn9QG5d434lnGV4nq?=
 =?us-ascii?Q?+UVO9bqF7y58ARHkhNKt8Kq3zhLCi+02IlWMTuGpoXb+FCIM+NruvtuiLaDZ?=
 =?us-ascii?Q?2zdbtk8mbRRRkVwyKBaVgZkGftZccAjF1LP4zAuj/dxibHPgAG39PrM8mCfB?=
 =?us-ascii?Q?VnTMuPrXwARNYK8tlipPgZ6XfD/furvFXD1EJyFCW/vDIUW7V/ScvHEwJeZY?=
 =?us-ascii?Q?DXcFN1R1DqmrI5ht44lIzG5mO3DKknJdRyCJBRKAcnAA55KHAVedJtDwjWcQ?=
 =?us-ascii?Q?X7lHpQoCBcVkXl6bCFsZAm0XbvOLXj4mcL9SfkmIiDZ277sFWP8hXLtwX2jX?=
 =?us-ascii?Q?d+3pfyS9CWUgqTFlIQHU6HQ/bBPhmo3Ejz3mendgGZG7L6bOnQESlLc3Pt1H?=
 =?us-ascii?Q?jPaKPHJsO2f63S9GhgzBMpz4gsg1h75z5ZacpoNQkedYHQAc9fommEfaBPKC?=
 =?us-ascii?Q?jsd+jNYpKK3/syOSV7gK3IYDkpyLGhz3qSizreIQJNdkyxVcZIRbCgYVNigD?=
 =?us-ascii?Q?QwwfQL7XzTJoXgjJtOrvTJOK/I0r2N24ZF11wfD/M2QwcrUYxe+jbRZEhKsg?=
 =?us-ascii?Q?EzPNbkR1G+9bgJVd2wSWnHxCQyDcIFqrNDjpGyLM2Zn+yQ6kfaBuBO0pBSrf?=
 =?us-ascii?Q?W/QI9Duto/3wMnCT+hcVt/SCujHs0U0Kl7wcwjrOywf3CK7wQOIzBj3AsrsB?=
 =?us-ascii?Q?8iZWPUHjTI30NXWlt9vsj6wRQ2CF3gevwbUZgzDHFgCE62ineZBUZqebmoLp?=
 =?us-ascii?Q?BUy9etQH8umsp/fvd7bqGfYnWHCTFqbjkyvhg24cfiCGWfkguc86v6HewemX?=
 =?us-ascii?Q?EODTIDglU9jTDYscF5Pns7AE8AnNHUFI8GmYgAN3OfBGRpLSzHC7Af2k9bg1?=
 =?us-ascii?Q?UwZgMW6JI3XSTAaMSmA7hcvZPgU9l8L0/DdOtfNA2iwhS5g278Nci9ETEq1y?=
 =?us-ascii?Q?nXQW/J6PYA8NQqlpXfU2b0Zc5gX0i6/958+0nXxu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9ecc34b-e6db-48eb-4a67-08dadc21b2d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2022 09:17:31.8165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jwJvC6KpTgYLlz193JGUh6fzrBFq4UiZyZL0qRMwFFS6N2zR0i4yClO8twoMoFU89Wh35Ce5tGZct1jfkoQZ8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8242
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

Hi Ray.

> -----Original Message-----
> From: Huang, Ray <Ray.Huang@amd.com>
> Sent: Monday, December 12, 2022 11:29 AM
> To: Yuan, Perry <Perry.Yuan@amd.com>
> Cc: rafael.j.wysocki@intel.com; Limonciello, Mario
> <Mario.Limonciello@amd.com>; viresh.kumar@linaro.org; Sharma, Deepak
> <Deepak.Sharma@amd.com>; Fontenot, Nathan
> <Nathan.Fontenot@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Huang, Shimmer
> <Shimmer.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Meng,
> Li (Jassmine) <Li.Meng@amd.com>; Karny, Wyes <Wyes.Karny@amd.com>;
> linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v7 01/13] ACPI: CPPC: Add AMD pstate energy
> performance preference cppc control
>=20
> On Fri, Dec 09, 2022 at 03:55:28PM +0800, Huang Rui wrote:
> > On Thu, Dec 08, 2022 at 07:18:40PM +0800, Yuan, Perry wrote:
> > > From: Perry Yuan <Perry.Yuan@amd.com>
> > >
> > > Add support for setting and querying EPP preferences to the generic
> > > CPPC driver.  This enables downstream drivers such as amd-pstate to
> > > discover and use these values
> > >
> > > Downstream drivers that want to use the new symbols
> > > cppc_get_epp_caps and cppc_set_epp_perf for querying and setting EPP
> > > preferences will need to call cppc_set_auto_epp to enable the EPP
> function first.
> > >
> > > Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> >
> > Acked-by: Huang Rui <ray.huang@amd.com>
> >
> > > ---
> > >  drivers/acpi/cppc_acpi.c | 114
> > > +++++++++++++++++++++++++++++++++++++--
> > >  include/acpi/cppc_acpi.h |  12 +++++
> > >  2 files changed, 121 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> > > index 093675b1a1ff..37fa75f25f62 100644
> > > --- a/drivers/acpi/cppc_acpi.c
> > > +++ b/drivers/acpi/cppc_acpi.c
> > > @@ -1093,6 +1093,9 @@ static int cppc_get_perf(int cpunum, enum
> > > cppc_regs reg_idx, u64 *perf)  {
> > >  	struct cpc_desc *cpc_desc =3D per_cpu(cpc_desc_ptr, cpunum);
> > >  	struct cpc_register_resource *reg;
> > > +	int pcc_ss_id =3D per_cpu(cpu_pcc_subspace_idx, cpunum);
> > > +	struct cppc_pcc_data *pcc_ss_data =3D NULL;
> > > +	int ret =3D -EINVAL;
> > >
> > >  	if (!cpc_desc) {
> > >  		pr_debug("No CPC descriptor for CPU:%d\n", cpunum); @@
> -1102,10
> > > +1105,6 @@ static int cppc_get_perf(int cpunum, enum cppc_regs
> reg_idx, u64 *perf)
> > >  	reg =3D &cpc_desc->cpc_regs[reg_idx];
> > >
> > >  	if (CPC_IN_PCC(reg)) {
> > > -		int pcc_ss_id =3D per_cpu(cpu_pcc_subspace_idx, cpunum);
> > > -		struct cppc_pcc_data *pcc_ss_data =3D NULL;
> > > -		int ret =3D 0;
> > > -
> > >  		if (pcc_ss_id < 0)
> > >  			return -EIO;
> > >
> > > @@ -1125,7 +1124,7 @@ static int cppc_get_perf(int cpunum, enum
> > > cppc_regs reg_idx, u64 *perf)
> > >
> > >  	cpc_read(cpunum, reg, perf);
> > >
> > > -	return 0;
> > > +	return ret;
> > >  }
> > >
> > >  /**
> > > @@ -1365,6 +1364,111 @@ int cppc_get_perf_ctrs(int cpunum, struct
> > > cppc_perf_fb_ctrs *perf_fb_ctrs)  }
> > > EXPORT_SYMBOL_GPL(cppc_get_perf_ctrs);
> > >
> > > +/**
> > > + * cppc_get_epp_caps - Get the energy preference register value.
> > > + * @cpunum: CPU from which to get epp preference level.
> > > + * @perf_caps: Return address.
> > > + *
> > > + * Return: 0 for success, -EIO otherwise.
> > > + */
> > > +int cppc_get_epp_caps(int cpunum, struct cppc_perf_caps *perf_caps)
>=20
> Take a look at the patch again, due to the energy_perf is actually one of=
 the
> members in struct cppc_perf_caps. It's better to modify the existing
> cppc_get_perf_caps() to get the epp value as well.
>=20
> Thanks,
> Ray

Makes sense, I will change it in the V8.

Perry.

>=20
> > > +{
> > > +	struct cpc_desc *cpc_desc =3D per_cpu(cpc_desc_ptr, cpunum);
> > > +	struct cpc_register_resource *energy_perf_reg;
> > > +	u64 energy_perf;
> > > +
> > > +	if (!cpc_desc) {
> > > +		pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
> > > +		return -ENODEV;
> > > +	}
> > > +
> > > +	energy_perf_reg =3D &cpc_desc->cpc_regs[ENERGY_PERF];
> > > +
> > > +	if (!CPC_SUPPORTED(energy_perf_reg))
> > > +		pr_warn_once("energy perf reg update is unsupported!\n");
> > > +
> > > +	if (CPC_IN_PCC(energy_perf_reg)) {
> > > +		int pcc_ss_id =3D per_cpu(cpu_pcc_subspace_idx, cpunum);
> > > +		struct cppc_pcc_data *pcc_ss_data =3D NULL;
> > > +		int ret =3D 0;
> > > +
> > > +		if (pcc_ss_id < 0)
> > > +			return -ENODEV;
> > > +
> > > +		pcc_ss_data =3D pcc_data[pcc_ss_id];
> > > +
> > > +		down_write(&pcc_ss_data->pcc_lock);
> > > +
> > > +		if (send_pcc_cmd(pcc_ss_id, CMD_READ) >=3D 0) {
> > > +			cpc_read(cpunum, energy_perf_reg, &energy_perf);
> > > +			perf_caps->energy_perf =3D energy_perf;
> > > +		} else {
> > > +			ret =3D -EIO;
> > > +		}
> > > +
> > > +		up_write(&pcc_ss_data->pcc_lock);
> > > +
> > > +		return ret;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +EXPORT_SYMBOL_GPL(cppc_get_epp_caps);
> > > +
> > > +/*
> > > + * Set Energy Performance Preference Register value through
> > > + * Performance Controls Interface
> > > + */
> > > +int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls,
> > > +bool enable) {
> > > +	int pcc_ss_id =3D per_cpu(cpu_pcc_subspace_idx, cpu);
> > > +	struct cpc_register_resource *epp_set_reg;
> > > +	struct cpc_register_resource *auto_sel_reg;
> > > +	struct cpc_desc *cpc_desc =3D per_cpu(cpc_desc_ptr, cpu);
> > > +	struct cppc_pcc_data *pcc_ss_data =3D NULL;
> > > +	int ret =3D -EINVAL;
> > > +
> > > +	if (!cpc_desc) {
> > > +		pr_debug("No CPC descriptor for CPU:%d\n", cpu);
> > > +		return -ENODEV;
> > > +	}
> > > +
> > > +	auto_sel_reg =3D &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
> > > +	epp_set_reg =3D &cpc_desc->cpc_regs[ENERGY_PERF];
> > > +
> > > +	if (CPC_IN_PCC(epp_set_reg) || CPC_IN_PCC(auto_sel_reg)) {
> > > +		if (pcc_ss_id < 0) {
> > > +			pr_debug("Invalid pcc_ss_id\n");
> > > +			return -ENODEV;
> > > +		}
> > > +
> > > +		if (CPC_SUPPORTED(auto_sel_reg)) {
> > > +			ret =3D cpc_write(cpu, auto_sel_reg, enable);
> > > +			if (ret)
> > > +				return ret;
> > > +		}
> > > +
> > > +		if (CPC_SUPPORTED(epp_set_reg)) {
> > > +			ret =3D cpc_write(cpu, epp_set_reg, perf_ctrls-
> >energy_perf);
> > > +			if (ret)
> > > +				return ret;
> > > +		}
> > > +
> > > +		pcc_ss_data =3D pcc_data[pcc_ss_id];
> > > +
> > > +		down_write(&pcc_ss_data->pcc_lock);
> > > +		/* after writing CPC, transfer the ownership of PCC to
> platform */
> > > +		ret =3D send_pcc_cmd(pcc_ss_id, CMD_WRITE);
> > > +		up_write(&pcc_ss_data->pcc_lock);
> > > +	} else {
> > > +		ret =3D -ENOTSUPP;
> > > +		pr_debug("_CPC in PCC is not supported\n");
> > > +	}
> > > +
> > > +	return ret;
> > > +}
> > > +EXPORT_SYMBOL_GPL(cppc_set_epp_perf);
> > > +
> > >  /**
> > >   * cppc_set_enable - Set to enable CPPC on the processor by writing =
the
> > >   * Continuous Performance Control package EnableRegister field.
> > > diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> > > index c5614444031f..a45bb876a19c 100644
> > > --- a/include/acpi/cppc_acpi.h
> > > +++ b/include/acpi/cppc_acpi.h
> > > @@ -108,12 +108,14 @@ struct cppc_perf_caps {
> > >  	u32 lowest_nonlinear_perf;
> > >  	u32 lowest_freq;
> > >  	u32 nominal_freq;
> > > +	u32 energy_perf;
> > >  };
> > >
> > >  struct cppc_perf_ctrls {
> > >  	u32 max_perf;
> > >  	u32 min_perf;
> > >  	u32 desired_perf;
> > > +	u32 energy_perf;
> > >  };
> > >
> > >  struct cppc_perf_fb_ctrs {
> > > @@ -149,6 +151,8 @@ extern bool cpc_ffh_supported(void);  extern
> > > bool cpc_supported_by_cpu(void);  extern int cpc_read_ffh(int
> > > cpunum, struct cpc_reg *reg, u64 *val);  extern int
> > > cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
> > > +extern int cppc_get_epp_caps(int cpunum, struct cppc_perf_caps
> > > +*perf_caps); extern int cppc_set_epp_perf(int cpu, struct
> > > +cppc_perf_ctrls *perf_ctrls, bool enable);
> > >  #else /* !CONFIG_ACPI_CPPC_LIB */
> > >  static inline int cppc_get_desired_perf(int cpunum, u64
> > > *desired_perf)  { @@ -202,6 +206,14 @@ static inline int
> > > cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)  {
> > >  	return -ENOTSUPP;
> > >  }
> > > +static inline int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls
> > > +*perf_ctrls, bool enable) {
> > > +	return -ENOTSUPP;
> > > +}
> > > +static inline int cppc_get_epp_caps(int cpunum, struct
> > > +cppc_perf_caps *perf_caps) {
> > > +	return -ENOTSUPP;
> > > +}
> > >  #endif /* !CONFIG_ACPI_CPPC_LIB */
> > >
> > >  #endif /* _CPPC_ACPI_H*/
> > > --
> > > 2.34.1
> > >
