Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902CD650A29
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 11:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbiLSKdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 05:33:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbiLSKdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 05:33:10 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52985DF9D;
        Mon, 19 Dec 2022 02:33:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=khpy+gnzVNW+05SsnxIrTOb6fuCcxeDVe1IRcRrSPI+xf7vQjmQueocdardYX4paONH+W9x8v8F0MvK6CTCPoQ7XC5bx/lJ5RD5w0ZBYyTNNhUft+++cbHiKlIJCitJa05EicfBvLqoy6NjrJhyTXHPuJwl+/6ZvuAT2OjXlXrNbDXE8kMFMXuufDCJg+sem/Ndn49hi14shouLoKk544oAhjvAzd80OLgh5m/88WHqKHkB/gydu0nROQPXm8prFtmEU1NVqlAn7E5HXp0GXKYE6mJSD54cdtwxuDXzwhoE+IXVEarA7ixSLFJqw2a9xcWoiKmG16Pj5hgu9gzBdyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1eKp/rcmOUgh6wVS4N128iBHOg23pPQvsS9qo9XTYmM=;
 b=danKsmaGb12xZDiRP/XPheB6lBZyHQzuCVePNwu/Gvpwtq42LL8CvAqj7oq4CkQx8NZHwD1VP1cHSoH/YdgIWGJoGPYBONvGdQFiRIZj/Cim6tyJRhiovEQle3jB8WOUltwP/bJzR9M/ImGuWyckr1G0D0WbCxpsl5vmgC0k41QBlHL+IDq2vZaNjBzH2PNiYHir5E2BYpEIgi6JwnDE90bz5C34MYafKyTChT309iVGLClnEL3WBhUtQBkHelBxh9WIzqjuaTQZjEOKzDjXNWVaEB2M8nTQ0H76NK/O4LBfn/1yptQ1UyUD5OddjRQYQDyravQwvYEVqWXZgz55BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1eKp/rcmOUgh6wVS4N128iBHOg23pPQvsS9qo9XTYmM=;
 b=TsebV/F9TMssXV+PQQqOHweLp9CziyKu8thGim6Odj7wG3ijo2xPXXZgqS7zKOjqYFb18/d5tRn0e+d6V9j1uoVcKW/NERRfXsIX1ChWnCwqZ+4KrVBaa4+xgpfg/CAA3v9kkqF0KZyWq8qqF9x0o/4F8sbPKgi3IaBsK+Yxgl8=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by MN2PR12MB4269.namprd12.prod.outlook.com (2603:10b6:208:1d4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 10:33:03 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed%8]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 10:33:02 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Huang, Ray" <Ray.Huang@amd.com>
CC:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
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
Subject: RE: [PATCH v7 07/13] cpufreq: amd-pstate: implement suspend and
 resume callbacks
Thread-Topic: [PATCH v7 07/13] cpufreq: amd-pstate: implement suspend and
 resume callbacks
Thread-Index: AQHZCvcV1DMtO4KLxUeEL2ZZVwGZJq5p+6gAgABnT4CACrDGAA==
Date:   Mon, 19 Dec 2022 10:33:02 +0000
Message-ID: <DM4PR12MB5278D42DD4C79ABD6445A9669CE59@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20221208111852.386731-1-perry.yuan@amd.com>
 <20221208111852.386731-8-perry.yuan@amd.com> <Y5butE2biSRddti+@amd.com>
 <MN0PR12MB6101C86765969ACBDF23BF99E2E29@MN0PR12MB6101.namprd12.prod.outlook.com>
In-Reply-To: <MN0PR12MB6101C86765969ACBDF23BF99E2E29@MN0PR12MB6101.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-12-12T15:14:02Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=b51c720a-9ce0-4b49-b938-e15c0df74bf8;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-12-19T10:32:59Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 7127bf22-e3f9-49a9-aaf0-8124558790bc
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|MN2PR12MB4269:EE_
x-ms-office365-filtering-correlation-id: a684d8a7-7dba-493d-be3a-08dae1ac6874
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bzssKw1UyTthv2jHO71sIlsGWUFIiUmVEzSoBj+LHHsXxdGkJpGq/kcJ+Q3B6rgPUmaMAVzjJnHYnfkrnSKOXBSEGqHG6oJKCr6dcQVc4af0NYuG0dRXGroIunvvU3FNdrN879bWM0CNvvNS6UQOdDhx4VyCq9g1ooeV2BMjxKy/w29OE912PudVd0pwpWDbJSE8OiyYH00jp8rm9XzTarljv+HNtREp0+FOlCw4TLcSBnIYncUtpBhmhfHpmVZT2lvomNb4AZvslsUJUcXoTsSmwKIwQWFVpxVTYKWZOsBiCRAYOtXsyf8xVbegL983AUV4EBTwOFNT8LEsedI1Q7IYJgpWnHUdKJ0iHabSZdmKqo4TMnhUXxWlFaRlaQXHopqQNMrJD4WK3TFnPiXGv/4E2DGNnjDXJlYIYRZFLAk0MM1/LaLZdUIxzK79pq/6LNcl3wXV+nAP42+COm+gGzajTfSGjg52sE207cTL/J29Mop+0IvwsdpimbKOiW2hn+aKHa0TeLprO7Pt+nIdgkO1P+xUnevhEWlV5a5RgC6Yl4aQkP6SDaaRQcKWDhizEQ1c8jqKr/Yvpr1BMCjSIeI6m443vnB8CNmWmjrqzdgB3unqDM30fQnKrt4SaahHG+w8mfFSKjttLV0RdCIhKhOKYYETc8ct8bL2U53Wocgp51WIHpQmP4uXpu38vhs843LZY+LLx141CdnSG61Guw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199015)(71200400001)(38070700005)(53546011)(7696005)(6506007)(9686003)(186003)(26005)(2906002)(478600001)(86362001)(33656002)(83380400001)(122000001)(38100700002)(55016003)(8936002)(52536014)(5660300002)(41300700001)(15650500001)(4326008)(8676002)(54906003)(76116006)(110136005)(64756008)(6636002)(316002)(66476007)(66556008)(66446008)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yj80B4rfHixHeobGVX8curPt5v9Hw1ew9GZn03wzfuNdDjcxVEDC4vU2xHE0?=
 =?us-ascii?Q?PUQAX2EHfCcUgWlJqD+5DftvKu93YyA2c+WKm/Ojw/lTc0UIVDW3Caq3EToc?=
 =?us-ascii?Q?LaJXavmjtYZUpumbSq4hfoEIShb0v7oII7II4gpsi4RqNlUbIhVgfj2h6ufj?=
 =?us-ascii?Q?2ixw08UOOIJCFo4JAQ1Qwmi8382eTqL3Cp48KK7GEdh4+jCoyD0rdCx5pxeV?=
 =?us-ascii?Q?C8+L48QksARZfMaw+6clXe7rjW58Vhht/dzgU9yh0lZNtXGJwlst+w0k1I4R?=
 =?us-ascii?Q?BORn4Ce48P8oJ6VvjxFcmNGwJeF7X8iUZpKINOYw16L1TzSspdWSMBx+jMsG?=
 =?us-ascii?Q?VAHgnBGSqihDUbKONgjmBYhZI5V9YJhrKjzcfstlo9bkOVNUyDHqS7KX2SQ0?=
 =?us-ascii?Q?p39NQ5I+qbNRq6ERUIYw0s3pgjYFBvvE9avSgunqWi/0SQNX8s3Shn/w4aMy?=
 =?us-ascii?Q?gOMJhu0iym0sE8QuDfjc6svdTcwgcLfHcyCu6NETJIxsg43ERywvKOPA3W3w?=
 =?us-ascii?Q?QeNv1Y6uCGCTnZBauObBlrcWfLUm4AAaPTIiZfuUBtdBeL2LyqaYM33EPdZe?=
 =?us-ascii?Q?XLRYlIxXBlIHqIzO/ZUx6meJXZ8g3bwRAN36wkpf5XCLQjW1sbs/LWNjmsy6?=
 =?us-ascii?Q?NpuNmuRQ2eTp4MESFNSErITp0n1tZd80rm3CW9Pyjq8KQUTjMzGH+U8hBrfH?=
 =?us-ascii?Q?MRGZOZEmSY1VtFm/aup8lh4McpYn2hbdD9LHlv/N5OS4Lb6QkBl4+jXFKv7O?=
 =?us-ascii?Q?bvCXJ2OYXyQyKctlz1MDUFoBC9bLZxYssayB5GJkZGi15KvQo+LWj8PO74Uz?=
 =?us-ascii?Q?LYt2aSzk9VDL1jXUDxnEGdjzyRheLD8JH4hz8GYY6HXMJ+R0zWBLmzWJUl+R?=
 =?us-ascii?Q?IkQqYV3JSzfdUFU1k0Ly/Cq7vBNCYxJT85dOIUk658wQqcRFcTM1Pu/3cKDo?=
 =?us-ascii?Q?JNTsmHdZjyeX0Y1b1Z8h1yTDLSxkHkWysg+lhAVTDXF/Af/5/6IsqzfLbYD7?=
 =?us-ascii?Q?3JU5qgkfDG3kCeyPMoRZCWzNOojBg7508spGHkwsdS+EA03CDUOYCKm0OTQS?=
 =?us-ascii?Q?AmwSXWXuriHd5rViaRviubc0+e1IZXRF9T+tbc+9AzKL0Y7wRz+ijp2hrYqr?=
 =?us-ascii?Q?SFYBn+nmlr6DQljsqn70sxBu1jZnzoG+55/51QDEobJl/AIBve7mQdWI553M?=
 =?us-ascii?Q?oja6LrKstH/FbEdlykNpI5FiFRglptgayitYCdtKaoRMRaWfq2fvzmkXsnKR?=
 =?us-ascii?Q?8BKOIdUgK2JE4s0k18QxUxtXtitUWdEt6JwI3skpIAb+98gbA1mMByCtE70F?=
 =?us-ascii?Q?QwlbgSts3gjGPVhi2XCP/q+QzmF9TVcZsPC4R9S3AFC3gOYn4lgOU7v+Vxgy?=
 =?us-ascii?Q?/Z4URPcLRZdHLrZdgDZjjs5fJiZUexngqBHr/iklKXRiC0WZ8DKUYlgxD6i5?=
 =?us-ascii?Q?IMyLesn4bLyjNbXoT+3vIaij+t7XblKeqLRq86mkOFwcJjsaTbvbDuoclhRD?=
 =?us-ascii?Q?Yh0oXwVA8PXkXkbQtvYlvdUOwi4tAi05PCePRc/JTQoFByklrMK9dSiUjkHa?=
 =?us-ascii?Q?QxHP2emFdW/KvpTbbl1ZMCpOc0VNcxv8ODVC8mJI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a684d8a7-7dba-493d-be3a-08dae1ac6874
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2022 10:33:02.9296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MrYAgeqoDG4bLOBpf/C49sq+8OA1iJjiY3L1mO/Pffx+VMVKRAL5eJYTZkJXLqxzxhx0MlYRt/XpyT2eqQ4J6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4269
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Public]



> -----Original Message-----
> From: Limonciello, Mario <Mario.Limonciello@amd.com>
> Sent: Monday, December 12, 2022 11:15 PM
> To: Huang, Ray <Ray.Huang@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>
> Cc: rafael.j.wysocki@intel.com; viresh.kumar@linaro.org; Sharma, Deepak
> <Deepak.Sharma@amd.com>; Fontenot, Nathan
> <Nathan.Fontenot@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Huang, Shimmer
> <Shimmer.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Meng,
> Li (Jassmine) <Li.Meng@amd.com>; Karny, Wyes <Wyes.Karny@amd.com>;
> linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: RE: [PATCH v7 07/13] cpufreq: amd-pstate: implement suspend and
> resume callbacks
>=20
> [Public]
>=20
>=20
>=20
> > -----Original Message-----
> > From: Huang, Ray <Ray.Huang@amd.com>
> > Sent: Monday, December 12, 2022 03:05
> > To: Yuan, Perry <Perry.Yuan@amd.com>
> > Cc: rafael.j.wysocki@intel.com; Limonciello, Mario
> > <Mario.Limonciello@amd.com>; viresh.kumar@linaro.org; Sharma,
> Deepak
> > <Deepak.Sharma@amd.com>; Fontenot, Nathan
> <Nathan.Fontenot@amd.com>;
> > Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Shimmer
> > <Shimmer.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>;
> Meng, Li
> > (Jassmine) <Li.Meng@amd.com>; Karny, Wyes <Wyes.Karny@amd.com>;
> > linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v7 07/13] cpufreq: amd-pstate: implement suspend
> > and resume callbacks
> >
> > On Thu, Dec 08, 2022 at 07:18:46PM +0800, Yuan, Perry wrote:
> > > From: Perry Yuan <Perry.Yuan@amd.com>
> > >
> > > add suspend and resume support for the AMD processors by
> > amd_pstate_epp
> > > driver instance.
> > >
> > > When the CPPC is suspended, EPP driver will set EPP profile to 'power=
'
> > > profile and set max/min perf to lowest perf value.
> > > When resume happens, it will restore the MSR registers with previous
> > > cached value.
> > >
> > > Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> > > ---
> > >  drivers/cpufreq/amd-pstate.c | 40
> > ++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 40 insertions(+)
> > >
> > > diff --git a/drivers/cpufreq/amd-pstate.c
> > > b/drivers/cpufreq/amd-pstate.c index 412accab7bda..ea9255bdc9ac
> > > 100644
> > > --- a/drivers/cpufreq/amd-pstate.c
> > > +++ b/drivers/cpufreq/amd-pstate.c
> > > @@ -1273,6 +1273,44 @@ static int amd_pstate_epp_cpu_offline(struct
> > cpufreq_policy *policy)
> > >  	return amd_pstate_cpu_offline(policy);  }
> > >
> > > +static int amd_pstate_epp_suspend(struct cpufreq_policy *policy) {
> > > +	struct amd_cpudata *cpudata =3D all_cpu_data[policy->cpu];
> > > +	int ret;
> > > +
> > > +	/* avoid suspending when EPP is not enabled */
> > > +	if (!cppc_active)
> > > +		return 0;
> > > +
> > > +	/* set this flag to avoid setting core offline*/
> > > +	cpudata->suspended =3D true;
> > > +
> > > +	/* disable CPPC in lowlevel firmware */
> > > +	ret =3D amd_pstate_enable(false);
> > > +	if (ret)
> > > +		pr_err("failed to suspend, return %d\n", ret);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int amd_pstate_epp_resume(struct cpufreq_policy *policy) {
> > > +	struct amd_cpudata *cpudata =3D all_cpu_data[policy->cpu];
> > > +
> > > +	if (cpudata->suspended) {
> > > +		mutex_lock(&amd_pstate_limits_lock);
> > > +
> > > +		/* enable amd pstate from suspend state*/
> > > +		amd_pstate_epp_reenable(cpudata);
> >
> > The same comment, could you please double confirm whether the
> > perfo_ctrls registers will be cleared while we execute a round of S3
> > suspend/resume?

PERF_CTL register will be always 0 if we do not load acpi_cpufreq driver af=
ter kernel booting.=20
So suspend/resume will not change the PERF_CTL MSR as well.


>=20
> And if they are; identify what is clearing them.  It might not be the sam=
e for
> s0i3 and S3.

I checked the PERF_CTRL with suspend/resume,  offline/online test.
The MSRs of all cores are not changed while amd-pstate driver loaded instea=
d of acpi-cpufreq.


>=20
> >
> > > +
> > > +		mutex_unlock(&amd_pstate_limits_lock);
> > > +
> > > +		cpudata->suspended =3D false;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  static void amd_pstate_verify_cpu_policy(struct amd_cpudata *cpudata=
,
> > >  					   struct cpufreq_policy_data *policy)
> { @@ -1309,6 +1347,8
> > > @@ static struct cpufreq_driver
> > amd_pstate_epp_driver =3D {
> > >  	.update_limits	=3D amd_pstate_epp_update_limits,
> > >  	.offline	=3D amd_pstate_epp_cpu_offline,
> > >  	.online		=3D amd_pstate_epp_cpu_online,
> > > +	.suspend	=3D amd_pstate_epp_suspend,
> > > +	.resume		=3D amd_pstate_epp_resume,
> > >  	.name		=3D "amd_pstate_epp",
> > >  	.attr		=3D amd_pstate_epp_attr,
> > >  };
> > > --
> > > 2.34.1
> > >
