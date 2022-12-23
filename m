Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE49654B9E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 04:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236062AbiLWDMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 22:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235877AbiLWDMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 22:12:35 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75427B87C;
        Thu, 22 Dec 2022 19:12:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LDHhZuHKe9xPYbjvzH1wZYcWOcuqA0kpCJiIgGnIfYbPd16t0gGmqlLfcgFyGAV5ZbQ5e61mZCLon/B6RwR9TzrEOCBN2U/9QyJvivnlb2SuTMt7QSwngb/ztPsdU4GWZphqNl3R3d70RwWDgyZ3If5Bk+RL8wjQ39JIYWHe7tKUTZCq7ZFvRIxUhYD6scCC/xSbHRf6vsRCSsgkokK4wSPZHOKpvNNKcCYRCqUZzcOiNh2WM54d5YkKHKBjfQhC2WzdNLvkMJM9d4KKqInID7Vg/olJyBRR1oRknplY9gGBKlXsJS85gznhgunAyccJ0eKttq0eK4IUwFFWWaySig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6uNZ9pFX5sHHvwdRN1nGh5/8UrWY8tyVqiUN5UbkzlQ=;
 b=VAdMqkeybItCAPhxtOkfUt7mH5mc4jm9ih0l8juozmHwCWiOcVNf/mcvYJTrU9TXrbcQR3i5joPdb0M2rGbqn4QJqT+N7+FqYS+v77INiKZwthYg45HLVoX6nF7fHhiQmVn8DeQvLwwLD90+LuY27DNmfNqkPyAAwMlaBbv2iUxpBUfLeicHBFlCST5/i1rew7oIBhxHhzyO6TOAX+spdsWOQ1RSkekJvUsuJoscV2KMFuvFhWfgdh7f6sqUIdto1otVmpiYlSYvHST8b+93vpLC4k9tiHXELB1H14g4gAUedb34mjIh+x1+fe8yV11EWJbb2XuWv2u1LdosGrzbHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6uNZ9pFX5sHHvwdRN1nGh5/8UrWY8tyVqiUN5UbkzlQ=;
 b=Ds+9xrPvKocUG4KoAQKzcRKfvfc5X5ucDoVkaS+bXsrUWaGrjXWh9d1f8BMeCG9EO6fM/vLA3ycgeL/DUZtbrGWr3e4a190Lem3ImLvlh0kBexjsmLNG1s7JA2jG+iaTxDG1+0NASdRCOuGXY7X8GWf1sM7o7azmWQZ1zTzjRDI=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by SJ0PR12MB6685.namprd12.prod.outlook.com (2603:10b6:a03:478::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.13; Fri, 23 Dec
 2022 03:12:32 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed%8]) with mapi id 15.20.5924.016; Fri, 23 Dec 2022
 03:12:32 +0000
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
Subject: RE: [PATCH v8 03/13] cpufreq: intel_pstate: use common macro
 definition for Energy Preference Performance(EPP)
Thread-Topic: [PATCH v8 03/13] cpufreq: intel_pstate: use common macro
 definition for Energy Preference Performance(EPP)
Thread-Index: AQHZE3TwEOXJ6wu9V02HCeEe/K0GJa560UgAgAAATSA=
Date:   Fri, 23 Dec 2022 03:12:32 +0000
Message-ID: <DM4PR12MB5278141DE955B00DAC4F849E9CE99@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20221219064042.661122-1-perry.yuan@amd.com>
 <20221219064042.661122-4-perry.yuan@amd.com> <Y6UcIBWKlYsUOybH@amd.com>
In-Reply-To: <Y6UcIBWKlYsUOybH@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-12-23T03:11:29Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=d613ba61-1ef9-493d-b130-16b4495af604;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-12-23T03:12:29Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 5aae393d-de60-41e2-b7cf-7d2b3fd7dc03
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|SJ0PR12MB6685:EE_
x-ms-office365-filtering-correlation-id: 0a355b44-4d9c-4e01-2a65-08dae4938823
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D3g0SPKrC9NeKRUYmPhyGvPfrl47YJfPAC8tq9bnL056r/dZvl/Vx76qrjwIDjJG+D3xZ+D82LFLZ7qmpXC5i1fpzs8qWft4UVTuL7iA3rhJnF1S1PDAFL8uwWHwq2Isb0AoRukyogxw4nwKnyn4LmmeBQXMd9v33TfROUiir1VX2ySCAh1/1g64MNIQiCQL92HejqaDSRI29KG5LxvZwzAHb/n7vaj4dvv2YvlBM3KsLO67CvdD7WGBXdYHfK82pT7NdZXaPotUgNfAuUisiUt48SQmX9yqIcy+t05Q93ZEkEepXEag4dEzLQUu8i+pBWhBgb0JTmd2qobnA3487r0CSRsInQHGm5Dy5dEOzrpeMtJZ74kPNbb78gTDIE70UxtL6j2LnyXotvhOALNyBBzEbO5JBHzLuRp0VVxmcQsCuGILgYG/oVet5dVOBI1ucFP0kx7j4Sg/WLQEU1WcOqe1r+UmnXsFdzQTQOPHc4l3D9XHxLukpEsqxnwdhLxNqa9AaoWIGOaXeqq1XFLpHyVO3P40UUklS7hx7+jqiSqh13JmCtEEGaJo0S9hfZrz+faQj/1KKt9aOmdGlSXKmrOTocwUE9b2qKPSrQ12Z2TLI0ALnLj/A1z9yZuq9SOY8ztH6lREfQcGTaKU28yecN/3U2lq6m4GfDHBXyQ/c1+g9yToBKw9az3Jwj1h+GHq6hqEdliXgmF5T8b5aoclsQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(376002)(396003)(366004)(451199015)(6506007)(53546011)(186003)(26005)(9686003)(478600001)(71200400001)(7696005)(38100700002)(122000001)(38070700005)(86362001)(55016003)(83380400001)(54906003)(33656002)(5660300002)(6862004)(8936002)(2906002)(4326008)(8676002)(64756008)(66446008)(66556008)(66946007)(66476007)(76116006)(6636002)(316002)(52536014)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TmAv4uk/uwXOKf72BZWfHTa64mn8olzhV0u0f78fcsqMFGPi5nntLd5sQQ4U?=
 =?us-ascii?Q?iiSsc8K6TgjL/oZWhsWwWw1OsI1Thge8tCbxUXXqNQCWoXQUJSNZyrJP3z0Q?=
 =?us-ascii?Q?2PZuKZuvFRsLmAU7MTNJZSou2WAlQ0W0skk7kGtHTOMYWB/nYvxFMY3zupbK?=
 =?us-ascii?Q?5YEH2Aym28qf50Z7o/Ng6n4Ny6sFSP0Xv215O9Zwnzoqztg9grwsKWvcfzgu?=
 =?us-ascii?Q?mYEMNCZlUkfDNLTCdIqRGyXlHLgB5xwpvbmegfMCfDgp5FzHe8j7JWZOxud7?=
 =?us-ascii?Q?mAGjGMcgp9myR5pK6R2jFDwlkVC/214TN5G2vfTSr0NdayJq5ZGKM895mAYM?=
 =?us-ascii?Q?xA2MDrOnggofsLbPMHTNBzatqQHKQUB1RK8rsrMpg2cSs0XxXlzTkcCFI2lw?=
 =?us-ascii?Q?sVlbwDUFzSAlcEiv75RzutRyL7ZO29SyN8x8vPW+uy5c2b2kHLcLPNim00Pc?=
 =?us-ascii?Q?c13fXILtnt6TVhTLHE0nLpyd12sPy2iXC3MYvX4nP63HrPQX/waVcTkhZ7SM?=
 =?us-ascii?Q?Ahql3DMUaOmS+nPxRZkOyI0/hzZZdczm3rRjJEv9MJDQbxs0AB4yLyNJWyX3?=
 =?us-ascii?Q?CbdGy+o+QAwiF81Mz9gOndroVDuNeGEYAM4lX7ERmup56juEu+JEqkPgib1d?=
 =?us-ascii?Q?Mh6dbU2lF8x4aWO0QsGw3SahG8CV6rqH08Qu5keGnhgD9lfx+PcaQlFdQQen?=
 =?us-ascii?Q?muj8Sw+vjGBLqY3rC014rIXvElvhRV0JRdC2g0Yu5ognHrpur8vfzIqwMlZc?=
 =?us-ascii?Q?40u25yA0L4HsYi8R44t+bV2id6ksHO8vtmtVdaxDf3KAkY5PcbxNVk0Ke1ln?=
 =?us-ascii?Q?v9oYjYQtO1vBurbe9EWh6Cj7kfZUBZGBto/A96K64hx89Yh4qWrWHZWenuVU?=
 =?us-ascii?Q?C9FngBNJ4y4Zjl53GMUcxffHq2m2qr1BTwJ8LLlPX+0o1Wib9hvmf70XSis+?=
 =?us-ascii?Q?E6ZQT8jKQfYK5ouY7QcIgmFkPnBzVUpzIItm0wo0t6xMGS/Z797opuKkSuma?=
 =?us-ascii?Q?LrzBHK1BMKblJiuPWuN4AkCY5VMEOMMGH49N2nODVC6uLTA4Y1GMinil+PQh?=
 =?us-ascii?Q?LO4sW+ger//6qVcIM6Xn2gsSkLIzsvGsY6c8M0efOGyn1RofoPh0uqVcFLhg?=
 =?us-ascii?Q?jMg9MSMr40j+Y2z+xRwJm+6kRwXv8ugFQOiFTzNNkbf2p83qIqjZ7GBB6j5p?=
 =?us-ascii?Q?YkkiYrrdn+/KsPznDVKxkmduCQtmpfZIHm9d16ZcqpCeq8Dm6s4w5IkQZLf9?=
 =?us-ascii?Q?xgO5qp+CHlyddCdzgAx4OQhwJ9FOSJDoeSVyxyJ86XAmKWnrfwIb+sR830wV?=
 =?us-ascii?Q?NxVLHaA82ZmWouTBx2gL7OWROA5R2oTO7DiL+yX8JjdOkS6l3OjETH7hYiHS?=
 =?us-ascii?Q?5lgqh/XBoz6cSmopER5t7XZsdaaNPJP+s41cgIWk6xpvifDPpii/qA3/VAYS?=
 =?us-ascii?Q?UULbqZcc9+D+SmCZEFXZufga/df4LSR8qVdC2rg4vNFExKkIthO85/rn2SOk?=
 =?us-ascii?Q?smrc+KGnR5yti2cacNo0yHb16ZnauFlkC/A1ead5XFUp3H8s8k6AiDBgC+z9?=
 =?us-ascii?Q?L/rlv/rofRRpu6GGfYKsbMTIjQ7mP8X6hAyvpS0i?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a355b44-4d9c-4e01-2a65-08dae4938823
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2022 03:12:32.1365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oIWtdZx0tIoirnwq705uW3cPtu4S2TDPS0PGgsXxxpHY8cVzihWfQQdFj6CgAfSB6S2gfEFnMlBMDewYgJlzYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6685
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
> Sent: Friday, December 23, 2022 11:10 AM
> To: Yuan, Perry <Perry.Yuan@amd.com>
> Cc: rafael.j.wysocki@intel.com; Limonciello, Mario
> <Mario.Limonciello@amd.com>; viresh.kumar@linaro.org; Sharma, Deepak
> <Deepak.Sharma@amd.com>; Fontenot, Nathan
> <Nathan.Fontenot@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Huang, Shimmer
> <Shimmer.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Meng,
> Li (Jassmine) <Li.Meng@amd.com>; Karny, Wyes <Wyes.Karny@amd.com>;
> linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v8 03/13] cpufreq: intel_pstate: use common macro
> definition for Energy Preference Performance(EPP)
>=20
> On Mon, Dec 19, 2022 at 02:40:32PM +0800, Yuan, Perry wrote:
> > make the energy preference performance strings and profiles using one
> > common header for intel_pstate driver, then the amd_pstate epp driver
> > can use the common header as well. This will simpify the intel_pstate
> > and amd_pstate driver.
> >
> > Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> > ---
> >  drivers/cpufreq/intel_pstate.c | 13 +++----------
> >  include/linux/cpufreq.h        | 11 +++++++++++
> >  2 files changed, 14 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/cpufreq/intel_pstate.c
> > b/drivers/cpufreq/intel_pstate.c index ad9be31753b6..93a60fdac0fc
> > 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -640,15 +640,7 @@ static int intel_pstate_set_epb(int cpu, s16 pref)
> >   *	4		power
> >   */
> >
> > -enum energy_perf_value_index {
> > -	EPP_INDEX_DEFAULT =3D 0,
> > -	EPP_INDEX_PERFORMANCE,
> > -	EPP_INDEX_BALANCE_PERFORMANCE,
> > -	EPP_INDEX_BALANCE_POWERSAVE,
> > -	EPP_INDEX_POWERSAVE,
> > -};
> > -
> > -static const char * const energy_perf_strings[] =3D {
> > +const char * const energy_perf_strings[] =3D {
> >  	[EPP_INDEX_DEFAULT] =3D "default",
> >  	[EPP_INDEX_PERFORMANCE] =3D "performance",
> >  	[EPP_INDEX_BALANCE_PERFORMANCE] =3D "balance_performance",
> @@ -656,7
> > +648,8 @@ static const char * const energy_perf_strings[] =3D {
> >  	[EPP_INDEX_POWERSAVE] =3D "power",
> >  	NULL
> >  };
> > -static unsigned int epp_values[] =3D {
> > +
> > +unsigned int epp_values[] =3D {
> >  	[EPP_INDEX_DEFAULT] =3D 0, /* Unused index */
> >  	[EPP_INDEX_PERFORMANCE] =3D HWP_EPP_PERFORMANCE,
> >  	[EPP_INDEX_BALANCE_PERFORMANCE] =3D
> HWP_EPP_BALANCE_PERFORMANCE, diff
> > --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h index
> > d5595d57f4e5..e63309d497fe 100644
> > --- a/include/linux/cpufreq.h
> > +++ b/include/linux/cpufreq.h
> > @@ -20,6 +20,7 @@
> >  #include <linux/pm_qos.h>
> >  #include <linux/spinlock.h>
> >  #include <linux/sysfs.h>
> > +#include <asm/msr.h>
>=20
> Please don't include msr header in cpufreq common file, we already includ=
e
> it in amd-pstate.c, that's fairly enough.
>=20
> Thanks,
> Ray

Good , will remove the msr.h from this file.
Thank you.

Perry.

>=20
> >
> >
> /**********************************************************
> ***********
> >   *                        CPUFREQ INTERFACE                          *
> > @@ -185,6 +186,16 @@ struct cpufreq_freqs {
> >  	u8 flags;		/* flags of cpufreq_driver, see below. */
> >  };
> >
> > +enum energy_perf_value_index {
> > +	EPP_INDEX_DEFAULT =3D 0,
> > +	EPP_INDEX_PERFORMANCE,
> > +	EPP_INDEX_BALANCE_PERFORMANCE,
> > +	EPP_INDEX_BALANCE_POWERSAVE,
> > +	EPP_INDEX_POWERSAVE,
> > +};
> > +extern const char * const energy_perf_strings[]; extern unsigned int
> > +epp_values[];
> > +
> >  /* Only for ACPI */
> >  #define CPUFREQ_SHARED_TYPE_NONE (0) /* None */
> >  #define CPUFREQ_SHARED_TYPE_HW	 (1) /* HW does needed
> coordination */
> > --
> > 2.34.1
> >
