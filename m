Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F9E647364
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiLHPnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:43:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiLHPnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:43:22 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B878D429B8;
        Thu,  8 Dec 2022 07:43:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hDrhzavUfZDSsSLP9I4oPYz2LDbUN8eEABL9BVvdvqwlb1BcCzlh8C4jPnRAuZp1oxlDvHcx2+4NhzuRi7XqJVGSLKVzU/6cZ0tXhmgjobT0tx05djaXFwBy+S3cWMGfNOzBEPKcLBxFCXcwqjBDzu+KTTVqMYv65lLG5Takleql14KJAtIunELAZkAFv3VdiSDnCCL+PQB7NbHksFYpfRd+hMJHw9dnlJRVtZiJaRPop/hz3u3sGfq5c48z80iqMDv8COF6KEF2eQgMEVn4S2SbEnUuHShafvfyq0gZ/Y/FXyNEuXMlldVG/q3mOchIqR4tO/ogVz3w9VVWojiuSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdU3MuBkfExIAxms5SU2gfIJnEEb/GT5fnGw1mFkdfM=;
 b=H5WQK5/4ArdYwHgVabldrAYcmWkwJ19wNNom3phGEpc+77cK5w5Mhl+Kh/2RmwR9Ur8yvfk80RXQWkMrHYe4yXdiIvTwxTVS0OxnFJJU1Acm59N3ge1KhfK8O/4lNoOBmKvWC/jOk1pJmHRC59blLMq45JbHn0ZC5ysYrDvofAYdHP+g3ADQFIqUcvyaFBKlwCtrGSmqy5GHjKQ+xtCpmcQF5EVHhDgEv0aPO29VX6Mq6g+4lxbz/M9JbE7ND2UfJobKGEhMzh41n8ZVuvWl+ZI30Yas1zgJXJqM2tP5ZrAFdasjjgkvCLoA5bYLyWOLaAr6Yx1ikkgJlzcOOTY8Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdU3MuBkfExIAxms5SU2gfIJnEEb/GT5fnGw1mFkdfM=;
 b=FMs7+lwpcnY51sx6pNe6i5bfw6Y25s5A7KLj5apspC8vTsi+74UVrPZHj3PpjAvnFfn18NF5WChxu3qerFCMvBn7StL42+PYLJmIBfe2nnsneBcyWAkmFAiHEp3FLohtmnTArqaZdJcfgJmc8cE9RSZboy6qOPn4S8uBgyZU9Oo=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by CH0PR12MB5369.namprd12.prod.outlook.com (2603:10b6:610:d4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 15:43:17 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed%8]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 15:43:16 +0000
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
Subject: RE: [PATCH v6 04/11] cpufreq: amd_pstate: implement Pstate EPP
 support for the AMD processors
Thread-Topic: [PATCH v6 04/11] cpufreq: amd_pstate: implement Pstate EPP
 support for the AMD processors
Thread-Index: AQHZBiMHosyw7T7OQ0+2F/ohUw7I5K5fPCWAgAAx/IA=
Date:   Thu, 8 Dec 2022 15:43:16 +0000
Message-ID: <DM4PR12MB5278CA8EEA3945C3165BC9539C1D9@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20221202074719.623673-1-perry.yuan@amd.com>
 <20221202074719.623673-5-perry.yuan@amd.com> <Y43id6YwevJiQssa@amd.com>
In-Reply-To: <Y43id6YwevJiQssa@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-12-05T15:21:10Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=f5296cff-ece1-47d8-b5d7-eba90a78c624;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-12-08T15:43:12Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 35f12d6c-8cbf-41ee-baca-87e4d669e171
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|CH0PR12MB5369:EE_
x-ms-office365-filtering-correlation-id: 328c12ca-ffb4-47ed-48bc-08dad932eca3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0Uu1GMHoiUZKi2JCcYyrWGEVl40RZLtgfrF/FIZkEOvI/gXotIq6WMm0ZfReQJThf0Mw1oPmgOiqQqu2hOWATvSsi41XaJc+CU2eMqw9LCuYdvB+Qfykqjhg0bT67ZdvH0jI8mfcRkOo+lzxuvOQo60qieGSQXJ5iZ8QrbvuUF9/OwA7nbkI11jis6snY/Z61y5aQdcLE+v+l/4fbTE9tLa7R0zBwLs/AMDCa+YMkN0yZoJfzCaCtWwnvoNfw8OxzJlgRAhINTzbXrzfxRGLpy+50GJzAbsVXCHbIl/+yDpHbwl6k/+5NPkAiDgpLUTzP5sA2Apu+z+Iyg6/K7DVVGG/qpX0xTu+BNhrcZM3yV5cmB8fMyg2XMFR3VwGtjLzlKFWSiSat6fn55NBDdmi0ZNDn5Y5XecVXXcMD+FP/W3XMqgtDxGTPK4rYSIPGSS0aNgM/FTn7I1HHV7vdZ3/1lSov+8vNwC+y7gLIp/PJWXA8CqfbD//xH3rfnsElxNyAAOfjr6Og25VZewAZkqKvi2jDLbvGaRI8zr9jQYUJByMRDH6ZeREKeDJEjcXNQwpMQ/glEAMuddbEEVqMA+Hg7HJyo8Q9F51XGzWAybEl1IOXKQwYkfDQFgPq+Igv2GLebZQuXqfJ2OOTym1BLp6LXjBjAo7hrlKlD5iPeYnP4IcbqSXpAK0Cq8DNQ0T0o9SgKPzkWfyyAlMeHUDZ6THqw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(136003)(376002)(396003)(346002)(451199015)(86362001)(38070700005)(41300700001)(8936002)(66476007)(66946007)(4326008)(66446008)(2906002)(66556008)(6862004)(8676002)(76116006)(30864003)(64756008)(38100700002)(83380400001)(122000001)(33656002)(6636002)(316002)(478600001)(54906003)(52536014)(55016003)(7696005)(5660300002)(6506007)(186003)(53546011)(26005)(9686003)(71200400001)(559001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4DcggcP4TtW/DvyTYMyEJckOkN3Rpu4kyLoHwwanZae7KR9ytbx5D6WIVJlf?=
 =?us-ascii?Q?U2kklQJ5QQC8MpMOfiwZggaAssA2u0QHRoTFNKbvbYd/b+QbVFDB+/RpivHG?=
 =?us-ascii?Q?lG+1VueKKxa839xrFRvVhqcenntDH0q5+6BFYi+cM2A0f7f4yFS1eWwschYw?=
 =?us-ascii?Q?VxjSJX8OFmFn5UxYyRqcAQh4n8JCDsfutzQVa6hywKKhfHAyeVWsHOZLk7Q9?=
 =?us-ascii?Q?Lx6ArpolWX56a2II9JU86yPVCzbC73JuEqjSCk4/odp6FETGtN50kLBgNrLV?=
 =?us-ascii?Q?DIUZVb6d/lWBtcQRIT4kmF9ViAdQbOVXZpDdt8g9Z4raF/nUxs56blAYTrlz?=
 =?us-ascii?Q?PEIoPcljme0MigRm8qHOW9mLIPkcRDTICNA0kbXo5DdP3C0kir2OHFdPlDtk?=
 =?us-ascii?Q?+/qI/teWFZlV5W3sv3i2dS3TIt5rLRChaI9rLL3T3hN6owz9RRTTqCg20xrM?=
 =?us-ascii?Q?jtXXhhUk+LH98lkCcZ95iRLvsCsIRikTtEpRx1fLrMp/136Qs1PsGx3iKL3I?=
 =?us-ascii?Q?eq40Twc9pPLA9vEaeRffPre1IEiCsH08+veu87fM1oeOOVypW056NAEEg5ON?=
 =?us-ascii?Q?GKJAtP3OeFgsrPKBdq5+RQGOZA81monHxhj3vH/p9Us4NTOga6XoEDw60o63?=
 =?us-ascii?Q?upJArKuVX20gsewKJMblzL5Kpz/PrjU/S7bX8floMYyysPiTvw5W5HeXNvEk?=
 =?us-ascii?Q?de4fU2HM3birWdTIp8igEoXYmmczu9/Z1cffKho2gIGDyseuA6rvvb7UYDmy?=
 =?us-ascii?Q?bh4ZWX3SFKt8P5FR5jgZvTFLY/ReHp2/NSZZgUg6800AGO0NnjJ1czLXevEH?=
 =?us-ascii?Q?Zrgqo5qHq5/M6y916J29O69PcNIZCUcZB3MXLHIaUM0umv4GOGZBedi0ilOG?=
 =?us-ascii?Q?M1wNDco4vZn5BMqd5CElvgpQ9MRi9mhgmBa4etSZccYMe0x8U6Jqsdl8O4xD?=
 =?us-ascii?Q?ww+cOL9WYfEGwzXegBQ+S6gLqs9r4+iUPNGaFrxLbhN1QahVTUyYV55RifIM?=
 =?us-ascii?Q?Pu1VBKhnlkWG9gQ4LkQU9KtFp++WRXZHXwwOblUfhlfYhuZ4RqGG00invvrq?=
 =?us-ascii?Q?MX/mAZyBUyzvnyO22yS+iUsq+lKFLcdCrnUtFkprBimAawHsmwnSAy9cqRmw?=
 =?us-ascii?Q?Yak6+PJyYd+YAf6ON3FEQEHca4crXhb2pLoMGemnIEAXVVBSXsCiR9uJPx5t?=
 =?us-ascii?Q?p5m/m+qN80KfwSGm29kkaCuuuyOWpqYVO6cGqIU0FCZ3IY7K40mY6Acb39AF?=
 =?us-ascii?Q?6NhuGxd8VgLyQKwvSI+oVYwLjqqw78RZYvefRxaY0I36iZ166JAc7RQOaZHB?=
 =?us-ascii?Q?wRg52doQWVqfPdOx3a1pHqw/jFKxFRxkLIJqw8p8nXnhNfvJTDqmtSzpJXtS?=
 =?us-ascii?Q?/KlbSUmDscqGgqeQA4v4wMtG3Yzq62iDz6j9ZeRwU3LdL2qhse1MtKJRP8Tk?=
 =?us-ascii?Q?fJoZdNWhUZ7zpNDXlfmDNJQNaHCf5Li45qJ/ytFOfuWZZcq7Ose8pxsfiQ0R?=
 =?us-ascii?Q?vlwMdYzr4m1X2D4Y94dtWBkpU9GIIkW592Qu0KTjWlKnabvfVy3+l+V0R9Rs?=
 =?us-ascii?Q?p08RHIkZjyl5NnITBuPNGBKyNvc0n7gG+Q9C8TM/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 328c12ca-ffb4-47ed-48bc-08dad932eca3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2022 15:43:16.7437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cJq7fInwWUjmRySyW4a+bKK20EfbFbkH3aTj/T69UBckxv9po8nynNZODzWFkDV3AzulBm19ShX1rqnHhy06hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5369
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

Hi Ray,=20

> -----Original Message-----
> From: Huang, Ray <Ray.Huang@amd.com>
> Sent: Monday, December 5, 2022 8:22 PM
> To: Yuan, Perry <Perry.Yuan@amd.com>
> Cc: rafael.j.wysocki@intel.com; Limonciello, Mario
> <Mario.Limonciello@amd.com>; viresh.kumar@linaro.org; Sharma, Deepak
> <Deepak.Sharma@amd.com>; Fontenot, Nathan
> <Nathan.Fontenot@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Huang, Shimmer
> <Shimmer.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Meng,
> Li (Jassmine) <Li.Meng@amd.com>; Karny, Wyes <Wyes.Karny@amd.com>;
> linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v6 04/11] cpufreq: amd_pstate: implement Pstate EPP
> support for the AMD processors
>=20
> On Fri, Dec 02, 2022 at 03:47:12PM +0800, Yuan, Perry wrote:
> > From: Perry Yuan <Perry.Yuan@amd.com>
> >
>=20
> > cpufreq: amd_pstate: implement Pstate EPP support for the AMD
> > processors
>=20
> I suggest that we align the format like "cpufreq: amd-pstate:" as the pre=
fix of
> the subject like previous patches. Because it's there anywhere even in th=
e
> documentation file. I think it's not worth to change such as minor update=
 like
> amd-pstate to amd_pstate for all the files and comments.
> So let's align the previous way.

Agreed , I have revised the title  and part of the kernel docs update patch=
es in V7.
Please take a look at the v7 if you have some other concerns.=20


>=20
> > Add EPP driver support for AMD SoCs which support a dedicated MSR for
> > CPPC.  EPP is used by the DPM controller to configure the frequency
> > that a core operates at during short periods of activity.
> >
> > The SoC EPP targets are configured on a scale from 0 to 255 where 0
> > represents maximum performance and 255 represents maximum
> efficiency.
> >
> > The amd-pstate driver exports profile string names to userspace that
> > are tied to specific EPP values.
> >
> > The balance_performance string (0x80) provides the best balance for
> > efficiency versus power on most systems, but users can choose other
> > strings to meet their needs as well.
> >
> > $ cat
> >
> /sys/devices/system/cpu/cpufreq/policy0/energy_performance_available_
> p
> > references default performance balance_performance balance_power
> power
> >
> > $ cat
> >
> /sys/devices/system/cpu/cpufreq/policy0/energy_performance_preferenc
> e
> > balance_performance
> >
> > To enable the driver,it needs to add `amd_pstate=3Dactive` to kernel
> > command line and kernel will load the active mode epp driver
> >
> > Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> > ---
> >  drivers/cpufreq/amd-pstate.c | 643
> ++++++++++++++++++++++++++++++++++-
> >  include/linux/amd-pstate.h   |  35 ++
> >  2 files changed, 672 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/cpufreq/amd-pstate.c
> > b/drivers/cpufreq/amd-pstate.c index 204e39006dda..5989d4d25d0f
> 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -37,9 +37,12 @@
> >  #include <linux/uaccess.h>
> >  #include <linux/static_call.h>
> >  #include <linux/amd-pstate.h>
> > +#include <linux/cpufreq_common.h>
> >
> > +#ifdef CONFIG_ACPI
> >  #include <acpi/processor.h>
> >  #include <acpi/cppc_acpi.h>
> > +#endif
>=20
> The amd-pstate module depends on ACPI in the kconfig, so we won't need
> add CONFIG_ACPI here.

Removed in V7.


>=20
> >
> >  #include <asm/msr.h>
> >  #include <asm/processor.h>
> > @@ -59,9 +62,130 @@
> >   * we disable it by default to go acpi-cpufreq on these processors and=
 add
> a
> >   * module parameter to be able to enable it manually for debugging.
> >   */
> > -static struct cpufreq_driver amd_pstate_driver;
> > +static bool cppc_active;
> >  static int cppc_load __initdata;
> >
> > +static struct cpufreq_driver *default_pstate_driver; static struct
> > +amd_cpudata **all_cpu_data; static struct amd_pstate_params
> > +global_params;
> > +
> > +static DEFINE_MUTEX(amd_pstate_limits_lock);
> > +static DEFINE_MUTEX(amd_pstate_driver_lock);
> > +
> > +static bool cppc_boost __read_mostly; struct kobject
> > +*amd_pstate_kobj;
>=20
> Where is it using amd_pstate_kobj?

Moved the amd_pstate_kobj definition to the patch where it is actually used=
 in v7.=20

>=20
> > +
> > +#ifdef CONFIG_ACPI_CPPC_LIB
> > +static s16 amd_pstate_get_epp(struct amd_cpudata *cpudata, u64
> > +cppc_req_cached) {
> > +	s16 epp;
> > +	struct cppc_perf_caps perf_caps;
> > +	int ret;
> > +
> > +	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> > +		if (!cppc_req_cached) {
> > +			epp =3D rdmsrl_on_cpu(cpudata->cpu,
> MSR_AMD_CPPC_REQ,
> > +					&cppc_req_cached);
> > +			if (epp)
> > +				return epp;
> > +		}
> > +		epp =3D (cppc_req_cached >> 24) & 0xFF;
> > +	} else {
> > +		ret =3D cppc_get_epp_caps(cpudata->cpu, &perf_caps);
> > +		if (ret < 0) {
> > +			pr_debug("Could not retrieve energy perf value
> (%d)\n", ret);
> > +			return -EIO;
> > +		}
> > +		epp =3D (s16) perf_caps.energy_perf;
> > +	}
> > +
> > +	return epp;
> > +}
> > +#endif
> > +
> > +static int amd_pstate_get_energy_pref_index(struct amd_cpudata
> > +*cpudata) {
> > +	s16 epp;
> > +	int index =3D -EINVAL;
> > +
> > +	epp =3D amd_pstate_get_epp(cpudata, 0);
> > +	if (epp < 0)
> > +		return epp;
> > +
> > +	switch (epp) {
> > +	case HWP_EPP_PERFORMANCE:
> > +		index =3D EPP_INDEX_PERFORMANCE;
> > +		break;
> > +	case HWP_EPP_BALANCE_PERFORMANCE:
> > +		index =3D EPP_INDEX_BALANCE_PERFORMANCE;
> > +		break;
> > +	case HWP_EPP_BALANCE_POWERSAVE:
> > +		index =3D EPP_INDEX_BALANCE_POWERSAVE;
> > +		break;
> > +	case HWP_EPP_POWERSAVE:
> > +		index =3D EPP_INDEX_POWERSAVE;
> > +		break;
> > +	default:
> > +			break;
> > +	}
> > +
> > +	return index;
> > +}
> > +
> > +#ifdef CONFIG_ACPI_CPPC_LIB
> > +static int amd_pstate_set_epp(struct amd_cpudata *cpudata, u32 epp) {
> > +	int ret;
> > +	struct cppc_perf_ctrls perf_ctrls;
> > +
> > +	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> > +		u64 value =3D READ_ONCE(cpudata->cppc_req_cached);
> > +
> > +		value &=3D ~GENMASK_ULL(31, 24);
> > +		value |=3D (u64)epp << 24;
> > +		WRITE_ONCE(cpudata->cppc_req_cached, value);
> > +
> > +		ret =3D wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
> value);
> > +		if (!ret)
> > +			cpudata->epp_cached =3D epp;
> > +	} else {
> > +		perf_ctrls.energy_perf =3D epp;
> > +		ret =3D cppc_set_epp_perf(cpudata->cpu, &perf_ctrls, 1);
> > +		if (ret) {
> > +			pr_debug("failed to set energy perf value (%d)\n",
> ret);
> > +			return ret;
> > +		}
> > +		cpudata->epp_cached =3D epp;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static int amd_pstate_set_energy_pref_index(struct amd_cpudata
> *cpudata,
> > +		int pref_index)
> > +{
> > +	int epp =3D -EINVAL;
> > +	int ret;
> > +
> > +	if (!pref_index) {
> > +		pr_debug("EPP pref_index is invalid\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (epp =3D=3D -EINVAL)
> > +		epp =3D epp_values[pref_index];
> > +
> > +	if (epp > 0 && cpudata->policy =3D=3D CPUFREQ_POLICY_PERFORMANCE)
> {
> > +		pr_debug("EPP cannot be set under performance policy\n");
> > +		return -EBUSY;
> > +	}
> > +
> > +	ret =3D amd_pstate_set_epp(cpudata, epp);
> > +
> > +	return ret;
> > +}
> > +#endif
> > +
> >  static inline int pstate_enable(bool enable)  {
> >  	return wrmsrl_safe(MSR_AMD_CPPC_ENABLE, enable); @@ -70,11
> +194,21
> > @@ static inline int pstate_enable(bool enable)  static int
> > cppc_enable(bool enable)  {
> >  	int cpu, ret =3D 0;
> > +	struct cppc_perf_ctrls perf_ctrls;
> >
> >  	for_each_present_cpu(cpu) {
> >  		ret =3D cppc_set_enable(cpu, enable);
> >  		if (ret)
> >  			return ret;
> > +
> > +		/* Enable autonomous mode for EPP */
> > +		if (!cppc_active) {
> > +			/* Set desired perf as zero to allow EPP firmware
> control */
> > +			perf_ctrls.desired_perf =3D 0;
> > +			ret =3D cppc_set_perf(cpu, &perf_ctrls);
> > +			if (ret)
> > +				return ret;
> > +		}
> >  	}
> >
> >  	return ret;
> > @@ -417,7 +551,7 @@ static void amd_pstate_boost_init(struct
> amd_cpudata *cpudata)
> >  		return;
> >
> >  	cpudata->boost_supported =3D true;
> > -	amd_pstate_driver.boost_enabled =3D true;
> > +	default_pstate_driver->boost_enabled =3D true;
> >  }
> >
> >  static void amd_perf_ctl_reset(unsigned int cpu) @@ -591,10 +725,61
> > @@ static ssize_t show_amd_pstate_highest_perf(struct cpufreq_policy
> *policy,
> >  	return sprintf(&buf[0], "%u\n", perf);  }
> >
> > +static ssize_t show_energy_performance_available_preferences(
> > +				struct cpufreq_policy *policy, char *buf) {
> > +	int i =3D 0;
> > +	int ret =3D 0;
> > +
> > +	while (energy_perf_strings[i] !=3D NULL)
> > +		ret +=3D sysfs_emit(buf, "%s", energy_perf_strings[i++]);
> > +
> > +	ret +=3D sysfs_emit(buf, "\n");
> > +
> > +	return ret;
> > +}
> > +
> > +static ssize_t store_energy_performance_preference(
> > +		struct cpufreq_policy *policy, const char *buf, size_t count) {
> > +	struct amd_cpudata *cpudata =3D policy->driver_data;
> > +	char str_preference[21];
> > +	ssize_t ret;
> > +
> > +	ret =3D sscanf(buf, "%20s", str_preference);
> > +	if (ret !=3D 1)
> > +		return -EINVAL;
> > +
> > +	ret =3D match_string(energy_perf_strings, -1, str_preference);
> > +	if (ret < 0)
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&amd_pstate_limits_lock);
> > +	ret =3D amd_pstate_set_energy_pref_index(cpudata, ret);
> > +	mutex_unlock(&amd_pstate_limits_lock);
> > +
> > +	return ret ?: count;
> > +}
> > +
> > +static ssize_t show_energy_performance_preference(
> > +				struct cpufreq_policy *policy, char *buf) {
> > +	struct amd_cpudata *cpudata =3D policy->driver_data;
> > +	int preference;
> > +
> > +	preference =3D amd_pstate_get_energy_pref_index(cpudata);
> > +	if (preference < 0)
> > +		return preference;
> > +
> > +	return  sysfs_emit(buf, "%s\n", energy_perf_strings[preference]); }
> > +
> >  cpufreq_freq_attr_ro(amd_pstate_max_freq);
> >  cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
> >
> >  cpufreq_freq_attr_ro(amd_pstate_highest_perf);
> > +cpufreq_freq_attr_rw(energy_performance_preference);
> > +cpufreq_freq_attr_ro(energy_performance_available_preferences);
> >
> >  static struct freq_attr *amd_pstate_attr[] =3D {
> >  	&amd_pstate_max_freq,
> > @@ -603,6 +788,429 @@ static struct freq_attr *amd_pstate_attr[] =3D {
> >  	NULL,
> >  };
> >
> > +static struct freq_attr *amd_pstate_epp_attr[] =3D {
> > +	&amd_pstate_max_freq,
> > +	&amd_pstate_lowest_nonlinear_freq,
> > +	&amd_pstate_highest_perf,
> > +	&energy_performance_preference,
> > +	&energy_performance_available_preferences,
> > +	NULL,
> > +};
> > +
> > +static inline void update_boost_state(void) {
> > +	u64 misc_en;
> > +	struct amd_cpudata *cpudata;
> > +
> > +	cpudata =3D all_cpu_data[0];
> > +	rdmsrl(MSR_K7_HWCR, misc_en);
> > +	global_params.cppc_boost_disabled =3D misc_en & BIT_ULL(25); }
> > +
> > +static bool amd_pstate_acpi_pm_profile_server(void)
> > +{
> > +	if (acpi_gbl_FADT.preferred_profile =3D=3D PM_ENTERPRISE_SERVER ||
> > +	    acpi_gbl_FADT.preferred_profile =3D=3D PM_PERFORMANCE_SERVER)
> > +		return true;
> > +
> > +	return false;
> > +}
> > +
> > +static int amd_pstate_init_cpu(unsigned int cpunum) {
> > +	struct amd_cpudata *cpudata;
> > +
> > +	cpudata =3D all_cpu_data[cpunum];
> > +	if (!cpudata) {
> > +		cpudata =3D kzalloc(sizeof(*cpudata), GFP_KERNEL);
> > +		if (!cpudata)
> > +			return -ENOMEM;
> > +		WRITE_ONCE(all_cpu_data[cpunum], cpudata);
> > +
> > +		cpudata->cpu =3D cpunum;
> > +
> > +		if (cppc_active) {
> > +			if (amd_pstate_acpi_pm_profile_server())
> > +				cppc_boost =3D true;
> > +		}
> > +
> > +	}
> > +	cpudata->epp_powersave =3D -EINVAL;
> > +	cpudata->epp_policy =3D 0;
> > +	pr_debug("controlling: cpu %d\n", cpunum);
> > +	return 0;
> > +}
> > +
> > +static int __amd_pstate_cpu_init(struct cpufreq_policy *policy) {
> > +	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
> > +	struct amd_cpudata *cpudata;
> > +	struct device *dev;
> > +	int rc;
> > +	u64 value;
> > +
> > +	rc =3D amd_pstate_init_cpu(policy->cpu);
> > +	if (rc)
> > +		return rc;
> > +
> > +	cpudata =3D all_cpu_data[policy->cpu];
> > +
> > +	dev =3D get_cpu_device(policy->cpu);
> > +	if (!dev)
> > +		goto free_cpudata1;
> > +
> > +	rc =3D amd_pstate_init_perf(cpudata);
> > +	if (rc)
> > +		goto free_cpudata1;
> > +
> > +	min_freq =3D amd_get_min_freq(cpudata);
> > +	max_freq =3D amd_get_max_freq(cpudata);
> > +	nominal_freq =3D amd_get_nominal_freq(cpudata);
> > +	lowest_nonlinear_freq =3D amd_get_lowest_nonlinear_freq(cpudata);
> > +	if (min_freq < 0 || max_freq < 0 || min_freq > max_freq) {
> > +		dev_err(dev, "min_freq(%d) or max_freq(%d) value is
> incorrect\n",
> > +				min_freq, max_freq);
> > +		ret =3D -EINVAL;
> > +		goto free_cpudata1;
> > +	}
> > +
> > +	policy->min =3D min_freq;
> > +	policy->max =3D max_freq;
> > +
> > +	policy->cpuinfo.min_freq =3D min_freq;
> > +	policy->cpuinfo.max_freq =3D max_freq;
> > +	/* It will be updated by governor */
> > +	policy->cur =3D policy->cpuinfo.min_freq;
> > +
> > +	/* Initial processor data capability frequencies */
> > +	cpudata->max_freq =3D max_freq;
> > +	cpudata->min_freq =3D min_freq;
> > +	cpudata->nominal_freq =3D nominal_freq;
> > +	cpudata->lowest_nonlinear_freq =3D lowest_nonlinear_freq;
> > +
> > +	policy->driver_data =3D cpudata;
> > +
> > +	update_boost_state();
> > +	cpudata->epp_cached =3D amd_pstate_get_epp(cpudata, value);
> > +
> > +	policy->min =3D policy->cpuinfo.min_freq;
> > +	policy->max =3D policy->cpuinfo.max_freq;
> > +
> > +	if (boot_cpu_has(X86_FEATURE_CPPC))
> > +		policy->fast_switch_possible =3D true;
> > +
> > +	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> > +		ret =3D rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
> &value);
> > +		if (ret)
> > +			return ret;
> > +		WRITE_ONCE(cpudata->cppc_req_cached, value);
> > +
> > +		ret =3D rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1,
> &value);
> > +		if (ret)
> > +			return ret;
> > +		WRITE_ONCE(cpudata->cppc_cap1_cached, value);
> > +	}
> > +	amd_pstate_boost_init(cpudata);
> > +
> > +	return 0;
> > +
> > +free_cpudata1:
> > +	kfree(cpudata);
> > +	return ret;
> > +}
> > +
> > +static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy) {
> > +	int ret;
> > +
> > +	ret =3D __amd_pstate_cpu_init(policy);
> > +	if (ret)
> > +		return ret;
> > +	/*
> > +	 * Set the policy to powersave to provide a valid fallback value in c=
ase
> > +	 * the default cpufreq governor is neither powersave nor
> performance.
> > +	 */
> > +	policy->policy =3D CPUFREQ_POLICY_POWERSAVE;
> > +
> > +	return 0;
> > +}
> > +
> > +static int amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy) {
> > +	pr_debug("CPU %d exiting\n", policy->cpu);
> > +	policy->fast_switch_possible =3D false;
> > +	return 0;
> > +}
> > +
> > +static void amd_pstate_update_max_freq(unsigned int cpu) {
> > +	struct cpufreq_policy *policy =3D policy =3D cpufreq_cpu_get(cpu);
> > +
> > +	if (!policy)
> > +		return;
> > +
> > +	refresh_frequency_limits(policy);
> > +	cpufreq_cpu_put(policy);
> > +}
> > +
> > +static void amd_pstate_epp_update_limits(unsigned int cpu) {
> > +	mutex_lock(&amd_pstate_driver_lock);
> > +	update_boost_state();
> > +	if (global_params.cppc_boost_disabled) {
> > +		for_each_possible_cpu(cpu)
> > +			amd_pstate_update_max_freq(cpu);
> > +	} else {
> > +		cpufreq_update_policy(cpu);
> > +	}
> > +	mutex_unlock(&amd_pstate_driver_lock);
> > +}
> > +
> > +static int cppc_boost_hold_time_ns =3D 3 * NSEC_PER_MSEC;
> > +
> > +static inline void amd_pstate_boost_up(struct amd_cpudata *cpudata) {
> > +	u64 hwp_req =3D READ_ONCE(cpudata->cppc_req_cached);
> > +	u64 hwp_cap =3D READ_ONCE(cpudata->cppc_cap1_cached);
> > +	u32 max_limit =3D (hwp_req & 0xff);
> > +	u32 min_limit =3D (hwp_req & 0xff00) >> 8;
> > +	u32 boost_level1;
> > +
> > +	/* If max and min are equal or already at max, nothing to boost */
> > +	if (max_limit =3D=3D min_limit)
> > +		return;
> > +
> > +	/* Set boost max and min to initial value */
> > +	if (!cpudata->cppc_boost_min)
> > +		cpudata->cppc_boost_min =3D min_limit;
> > +
> > +	boost_level1 =3D ((AMD_CPPC_NOMINAL_PERF(hwp_cap) +
> min_limit) >> 1);
> > +
> > +	if (cpudata->cppc_boost_min < boost_level1)
> > +		cpudata->cppc_boost_min =3D boost_level1;
> > +	else if (cpudata->cppc_boost_min <
> AMD_CPPC_NOMINAL_PERF(hwp_cap))
> > +		cpudata->cppc_boost_min =3D
> AMD_CPPC_NOMINAL_PERF(hwp_cap);
> > +	else if (cpudata->cppc_boost_min =3D=3D
> AMD_CPPC_NOMINAL_PERF(hwp_cap))
> > +		cpudata->cppc_boost_min =3D max_limit;
> > +	else
> > +		return;
> > +
> > +	hwp_req &=3D ~AMD_CPPC_MIN_PERF(~0L);
> > +	hwp_req |=3D AMD_CPPC_MIN_PERF(cpudata->cppc_boost_min);
> > +	wrmsrl(MSR_AMD_CPPC_REQ, hwp_req);
> > +	cpudata->last_update =3D cpudata->sample.time; }
> > +
> > +static inline void amd_pstate_boost_down(struct amd_cpudata *cpudata)
> > +{
> > +	bool expired;
> > +
> > +	if (cpudata->cppc_boost_min) {
> > +		expired =3D time_after64(cpudata->sample.time, cpudata-
> >last_update +
> > +					cppc_boost_hold_time_ns);
> > +
> > +		if (expired) {
> > +			wrmsrl(MSR_AMD_CPPC_REQ, cpudata-
> >cppc_req_cached);
> > +			cpudata->cppc_boost_min =3D 0;
> > +		}
> > +	}
> > +
> > +	cpudata->last_update =3D cpudata->sample.time; }
> > +
> > +static inline void amd_pstate_boost_update_util(struct amd_cpudata
> *cpudata,
> > +						      u64 time)
> > +{
> > +	cpudata->sample.time =3D time;
> > +	if (smp_processor_id() !=3D cpudata->cpu)
> > +		return;
> > +
> > +	if (cpudata->sched_flags & SCHED_CPUFREQ_IOWAIT) {
> > +		bool do_io =3D false;
> > +
> > +		cpudata->sched_flags =3D 0;
> > +		/*
> > +		 * Set iowait_boost flag and update time. Since IO WAIT flag
> > +		 * is set all the time, we can't just conclude that there is
> > +		 * some IO bound activity is scheduled on this CPU with just
> > +		 * one occurrence. If we receive at least two in two
> > +		 * consecutive ticks, then we treat as boost candidate.
> > +		 * This is leveraged from Intel Pstate driver.
> > +		 */
> > +		if (time_before64(time, cpudata->last_io_update + 2 *
> TICK_NSEC))
> > +			do_io =3D true;
> > +
> > +		cpudata->last_io_update =3D time;
> > +
> > +		if (do_io)
> > +			amd_pstate_boost_up(cpudata);
> > +
> > +	} else {
> > +		amd_pstate_boost_down(cpudata);
> > +	}
> > +}
> > +
> > +static inline void amd_pstate_cppc_update_hook(struct update_util_data
> *data,
> > +						u64 time, unsigned int flags)
> > +{
> > +	struct amd_cpudata *cpudata =3D container_of(data,
> > +				struct amd_cpudata, update_util);
> > +
> > +	cpudata->sched_flags |=3D flags;
> > +
> > +	if (smp_processor_id() =3D=3D cpudata->cpu)
> > +		amd_pstate_boost_update_util(cpudata, time); }
> > +
> > +static void amd_pstate_clear_update_util_hook(unsigned int cpu) {
> > +	struct amd_cpudata *cpudata =3D all_cpu_data[cpu];
> > +
> > +	if (!cpudata->update_util_set)
> > +		return;
> > +
> > +	cpufreq_remove_update_util_hook(cpu);
> > +	cpudata->update_util_set =3D false;
> > +	synchronize_rcu();
> > +}
> > +
> > +static void amd_pstate_set_update_util_hook(unsigned int cpu_num) {
> > +	struct amd_cpudata *cpudata =3D all_cpu_data[cpu_num];
> > +
> > +	if (!cppc_boost) {
> > +		if (cpudata->update_util_set)
> > +			amd_pstate_clear_update_util_hook(cpudata->cpu);
> > +		return;
> > +	}
> > +
> > +	if (cpudata->update_util_set)
> > +		return;
> > +
> > +	cpudata->sample.time =3D 0;
> > +	cpufreq_add_update_util_hook(cpu_num, &cpudata->update_util,
> > +
> 	amd_pstate_cppc_update_hook);
> > +	cpudata->update_util_set =3D true;
> > +}
> > +
> > +static void amd_pstate_epp_init(unsigned int cpu) {
> > +	struct amd_cpudata *cpudata =3D all_cpu_data[cpu];
> > +	u32 max_perf, min_perf;
> > +	u64 value;
> > +	s16 epp;
> > +	int ret;
> > +
> > +	max_perf =3D READ_ONCE(cpudata->highest_perf);
> > +	min_perf =3D READ_ONCE(cpudata->lowest_perf);
> > +
> > +	value =3D READ_ONCE(cpudata->cppc_req_cached);
> > +
> > +	if (cpudata->policy =3D=3D CPUFREQ_POLICY_PERFORMANCE)
> > +		min_perf =3D max_perf;
> > +
> > +	/* Initial min/max values for CPPC Performance Controls Register */
> > +	value &=3D ~AMD_CPPC_MIN_PERF(~0L);
> > +	value |=3D AMD_CPPC_MIN_PERF(min_perf);
> > +
> > +	value &=3D ~AMD_CPPC_MAX_PERF(~0L);
> > +	value |=3D AMD_CPPC_MAX_PERF(max_perf);
> > +
> > +	/* CPPC EPP feature require to set zero to the desire perf bit */
> > +	value &=3D ~AMD_CPPC_DES_PERF(~0L);
> > +	value |=3D AMD_CPPC_DES_PERF(0);
> > +
> > +	if (cpudata->epp_policy =3D=3D cpudata->policy)
> > +		goto skip_epp;
> > +
> > +	cpudata->epp_policy =3D cpudata->policy;
> > +
> > +	if (cpudata->policy =3D=3D CPUFREQ_POLICY_PERFORMANCE) {
> > +		epp =3D amd_pstate_get_epp(cpudata, value);
> > +		cpudata->epp_powersave =3D epp;
> > +		if (epp < 0)
> > +			goto skip_epp;
> > +		/* force the epp value to be zero for performance policy */
> > +		epp =3D 0;
> > +	} else {
> > +		if (cpudata->epp_powersave < 0)
> > +			goto skip_epp;
> > +		/* Get BIOS pre-defined epp value */
> > +		epp =3D amd_pstate_get_epp(cpudata, value);
> > +		if (epp)
> > +			goto skip_epp;
> > +		epp =3D cpudata->epp_powersave;
> > +	}
> > +	/* Set initial EPP value */
> > +	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> > +		value &=3D ~GENMASK_ULL(31, 24);
> > +		value |=3D (u64)epp << 24;
> > +	}
> > +
> > +skip_epp:
> > +	WRITE_ONCE(cpudata->cppc_req_cached, value);
> > +	ret =3D wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
> > +	if (!ret)
> > +		cpudata->epp_cached =3D epp;
> > +}
> > +
> > +static void amd_pstate_set_max_limits(struct amd_cpudata *cpudata) {
> > +	u64 hwp_cap =3D READ_ONCE(cpudata->cppc_cap1_cached);
> > +	u64 hwp_req =3D READ_ONCE(cpudata->cppc_req_cached);
> > +	u32 max_limit =3D (hwp_cap >> 24) & 0xff;
> > +
> > +	hwp_req &=3D ~AMD_CPPC_MIN_PERF(~0L);
> > +	hwp_req |=3D AMD_CPPC_MIN_PERF(max_limit);
> > +	wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, hwp_req); }
> > +
> > +static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy) {
> > +	struct amd_cpudata *cpudata;
> > +
> > +	if (!policy->cpuinfo.max_freq)
> > +		return -ENODEV;
> > +
> > +	pr_debug("set_policy: cpuinfo.max %u policy->max %u\n",
> > +				policy->cpuinfo.max_freq, policy->max);
> > +
> > +	cpudata =3D all_cpu_data[policy->cpu];
> > +	cpudata->policy =3D policy->policy;
> > +
> > +	if (boot_cpu_has(X86_FEATURE_CPPC)) {
>=20
> X86_FEATURE_CPPC indicated the MSR support, but I believe the share
> memory CPU also has the EPP, right?

Yes,  the shared memory system which are using below preferred profile will=
 add the util hook with another patchset.=20
Current I would like to add this to MSR systems in this patchset as tight s=
chedule.=20

        if (acpi_gbl_FADT.preferred_profile =3D=3D PM_ENTERPRISE_SERVER ||
            acpi_gbl_FADT.preferred_profile =3D=3D PM_PERFORMANCE_SERVER)


>=20
> > +		mutex_lock(&amd_pstate_limits_lock);
> > +
> > +		if (cpudata->policy =3D=3D CPUFREQ_POLICY_PERFORMANCE) {
> > +			amd_pstate_clear_update_util_hook(policy->cpu);
> > +			amd_pstate_set_max_limits(cpudata);
> > +		} else {
> > +			amd_pstate_set_update_util_hook(policy->cpu);
>=20
> May I know why amd processors also needs to set and update util hook?

Like intel already implemented this scheduler hook, it helps to improve the=
 I/O performance, it is not enabled by default for Client CPU.


>=20
> > +		}
> > +
> > +		if (boot_cpu_has(X86_FEATURE_CPPC))
>=20
> I am confused why if (boot_cpu_has(X86_FEATURE_CPPC) is still inside of a=
 if
> (boot_cpu_has(X86_FEATURE_CPPC)).
>=20

Fixed in V7.=20

> > +			amd_pstate_epp_init(policy->cpu);
> > +
> > +		mutex_unlock(&amd_pstate_limits_lock);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void amd_pstate_verify_cpu_policy(struct amd_cpudata *cpudata,
> > +					   struct cpufreq_policy_data *policy)
> {
> > +	update_boost_state();
> > +	cpufreq_verify_within_cpu_limits(policy);
> > +}
> > +
> > +static int amd_pstate_epp_verify_policy(struct cpufreq_policy_data
> > +*policy) {
> > +	amd_pstate_verify_cpu_policy(all_cpu_data[policy->cpu], policy);
> > +	pr_debug("policy_max =3D%d, policy_min=3D%d\n", policy->max, policy-
> >min);
> > +	return 0;
> > +}
> > +
> >  static struct cpufreq_driver amd_pstate_driver =3D {
> >  	.flags		=3D CPUFREQ_CONST_LOOPS |
> CPUFREQ_NEED_UPDATE_LIMITS,
> >  	.verify		=3D amd_pstate_verify,
> > @@ -616,8 +1224,20 @@ static struct cpufreq_driver amd_pstate_driver =
=3D
> {
> >  	.attr		=3D amd_pstate_attr,
> >  };
> >
> > +static struct cpufreq_driver amd_pstate_epp_driver =3D {
> > +	.flags		=3D CPUFREQ_CONST_LOOPS,
> > +	.verify		=3D amd_pstate_epp_verify_policy,
> > +	.setpolicy	=3D amd_pstate_epp_set_policy,
> > +	.init		=3D amd_pstate_epp_cpu_init,
> > +	.exit		=3D amd_pstate_epp_cpu_exit,
> > +	.update_limits	=3D amd_pstate_epp_update_limits,
> > +	.name		=3D "amd_pstate_epp",
> > +	.attr		=3D amd_pstate_epp_attr,
> > +};
> > +
> >  static int __init amd_pstate_init(void)  {
> > +	static struct amd_cpudata **cpudata;
> >  	int ret;
> >
> >  	if (boot_cpu_data.x86_vendor !=3D X86_VENDOR_AMD) @@ -644,7
> +1264,8 @@
> > static int __init amd_pstate_init(void)
> >  	/* capability check */
> >  	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> >  		pr_debug("AMD CPPC MSR based functionality is
> supported\n");
> > -		amd_pstate_driver.adjust_perf =3D amd_pstate_adjust_perf;
> > +		if (!cppc_active)
> > +			default_pstate_driver->adjust_perf =3D
> amd_pstate_adjust_perf;
> >  	} else {
> >  		pr_debug("AMD CPPC shared memory based functionality is
> supported\n");
> >  		static_call_update(amd_pstate_enable, cppc_enable); @@ -
> 652,6
> > +1273,10 @@ static int __init amd_pstate_init(void)
> >  		static_call_update(amd_pstate_update_perf,
> cppc_update_perf);
> >  	}
> >
> > +	cpudata =3D vzalloc(array_size(sizeof(void *), num_possible_cpus()));
> > +	if (!cpudata)
> > +		return -ENOMEM;
> > +	WRITE_ONCE(all_cpu_data, cpudata);
> >  	/* enable amd pstate feature */
> >  	ret =3D amd_pstate_enable(true);
> >  	if (ret) {
> > @@ -659,9 +1284,9 @@ static int __init amd_pstate_init(void)
> >  		return ret;
> >  	}
> >
> > -	ret =3D cpufreq_register_driver(&amd_pstate_driver);
> > +	ret =3D cpufreq_register_driver(default_pstate_driver);
> >  	if (ret)
> > -		pr_err("failed to register amd_pstate_driver with
> return %d\n",
> > +		pr_err("failed to register amd pstate driver with
> return %d\n",
> >  		       ret);
> >
> >  	return ret;
> > @@ -676,8 +1301,14 @@ static int __init amd_pstate_param(char *str)
> >  	if (!strcmp(str, "disable")) {
> >  		cppc_load =3D 0;
> >  		pr_info("driver is explicitly disabled\n");
> > -	} else if (!strcmp(str, "passive"))
> > +	} else if (!strcmp(str, "passive")) {
> >  		cppc_load =3D 1;
> > +		default_pstate_driver =3D &amd_pstate_driver;
> > +	} else if (!strcmp(str, "active")) {
> > +		cppc_active =3D 1;
> > +		cppc_load =3D 1;
> > +		default_pstate_driver =3D &amd_pstate_epp_driver;
> > +	}
> >
> >  	return 0;
> >  }
> > diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> > index 1c4b8659f171..888af62040f1 100644
> > --- a/include/linux/amd-pstate.h
> > +++ b/include/linux/amd-pstate.h
> > @@ -25,6 +25,7 @@ struct amd_aperf_mperf {
> >  	u64 aperf;
> >  	u64 mperf;
> >  	u64 tsc;
> > +	u64 time;
> >  };
> >
> >  /**
> > @@ -47,6 +48,18 @@ struct amd_aperf_mperf {
> >   * @prev: Last Aperf/Mperf/tsc count value read from register
> >   * @freq: current cpu frequency value
> >   * @boost_supported: check whether the Processor or SBIOS supports
> > boost mode
> > + * @epp_powersave: Last saved CPPC energy performance preference
> > +				when policy switched to performance
> > + * @epp_policy: Last saved policy used to set energy-performance
> > +preference
> > + * @epp_cached: Cached CPPC energy-performance preference value
> > + * @policy: Cpufreq policy value
> > + * @sched_flags: Store scheduler flags for possible cross CPU update
> > + * @update_util_set: CPUFreq utility callback is set
> > + * @last_update: Time stamp of the last performance state update
> > + * @cppc_boost_min: Last CPPC boosted min performance state
> > + * @cppc_cap1_cached: Cached value of the last CPPC Capabilities MSR
> > + * @update_util: Cpufreq utility callback information
> > + * @sample: the stored performance sample
> >   *
> >   * The amd_cpudata is key private data for each CPU thread in AMD P-
> State, and
> >   * represents all the attributes and goals that AMD P-State requests a=
t
> runtime.
> > @@ -72,6 +85,28 @@ struct amd_cpudata {
> >
> >  	u64	freq;
> >  	bool	boost_supported;
> > +
> > +	/* EPP feature related attributes*/
> > +	s16	epp_powersave;
> > +	s16	epp_policy;
> > +	s16	epp_cached;
> > +	u32	policy;
> > +	u32	sched_flags;
> > +	bool	update_util_set;
> > +	u64	last_update;
> > +	u64	last_io_update;
> > +	u32	cppc_boost_min;
> > +	u64	cppc_cap1_cached;
> > +	struct	update_util_data update_util;
> > +	struct	amd_aperf_mperf sample;
> > +};
> > +
> > +/**
> > + * struct amd_pstate_params - global parameters for the performance
> > +control
> > + * @ cppc_boost_disabled wheher the core performance boost disabled
> > +*/ struct amd_pstate_params {
> > +	bool cppc_boost_disabled;
> >  };
> >
> >  #endif /* _LINUX_AMD_PSTATE_H */
> > --
> > 2.34.1
> >
