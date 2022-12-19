Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3357650A1E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 11:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbiLSK3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 05:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiLSK3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 05:29:44 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE072D8;
        Mon, 19 Dec 2022 02:29:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/P8yJUEnJ29KM/ULjCMJPdAYFb/lDcXPefXyOtmky0axj62UoN76BS/5Hqq5VWQ5rGP6HZaeQddvkk3XNOilZDBJqqUro8M7BkLQJ7dfLN9Qpb2El26BChN1Gf0AYKLFGnJXuPuf7BvUpe9uAAiHp4UiJClgrfQbQc238i4WtLXDU2PwnUbZIye8EmXuZ3Y/H+1pNMCokAvFS3ogOuyQvgz0eH9s0FJOi/Ri6FhzQGivUpTjFN/VPqXc6ZyBRkUlHlbRSEvpVAtVbbfdGh2z58YhLxmxZV1s/+aRnZr75s6s+VeNpU7PRe0xUBqH+UDtpOhYPJU1dRbmmnnvByR3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CfZAXtM2GmRKaBxuq98e+br4ol7Vg6zNNNwyTMn16j8=;
 b=oHOzp1YEO4kdQRJb2HGplMfxL1CTlVjAUEr3yvvj5d/YOd5jB1aHwFzV4aGR4DlTt88PxKUcLeR7jI3bt3m6PJCEKUOgglT3pGbDTRu4PruD63wasXV+p5PrWzzLnjddQzyOY+gR5MxhQfArkbt7yD3BaD4XpqWf5n3gegsHrrWh1dkRkywR4763XtrJ4/UA7dUGs5fPvua1R692xqNIWerBGog6nNPkrO9noqoaSb0wNnveT5wquQhqKQumtY3uBf5gf4nlcBW7Ci0b7gozXlT/louTrFEccrNbp5jkxHSXFhJ3Z4OI190fiIbis0ArplN6zzouHyQEfwB17ZPu+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CfZAXtM2GmRKaBxuq98e+br4ol7Vg6zNNNwyTMn16j8=;
 b=zb9kkmBQ52BsE3lJW62BIYqEhyAY1+Tl3y05NOyYTlmsTiQw49NBOuhEDb3w6VsTzEEamlqQOi8gYB0i0IQjexMVk1GkLn8mZqnui2UV0+m7QePXtGexep/btGnOlWf4fCPpIT/0Kti/T9bMvkCbtIslNw7lXV/uHzWH3u+OGJ0=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by IA0PR12MB8350.namprd12.prod.outlook.com (2603:10b6:208:40d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 10:29:41 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed%8]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 10:29:41 +0000
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
Subject: RE: [PATCH v7 09/13] cpufreq: amd-pstate: add driver working mode
 status sysfs entry
Thread-Topic: [PATCH v7 09/13] cpufreq: amd-pstate: add driver working mode
 status sysfs entry
Thread-Index: AQHZCvcW55kqyp3ba0KvzSjdDN4Jya5qEc2AgAsBefA=
Date:   Mon, 19 Dec 2022 10:29:41 +0000
Message-ID: <DM4PR12MB5278AF8B200FA49FFF1B84E69CE59@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20221208111852.386731-1-perry.yuan@amd.com>
 <20221208111852.386731-10-perry.yuan@amd.com> <Y5cBR820cD2nc+wa@amd.com>
In-Reply-To: <Y5cBR820cD2nc+wa@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-12-19T10:29:37Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=7f822d20-84d6-476b-84ee-e0e31e32f3d0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-12-19T10:29:37Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: d5d5b894-9416-4bc5-82ff-4652f24119ae
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|IA0PR12MB8350:EE_
x-ms-office365-filtering-correlation-id: c2e27497-bf13-4d2b-6a78-08dae1abf04e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t8QdWPLIiFMsGlKog9Y53JkSmB4/dbXDMmlLWzblIHLizYt7SPDpcyJ45G2fBoGTjd0BWdZOH4AS1VJ36j9wH+mStL2I36rOLavwbv5Rx/Wq5QuPSDjUySNBscCjHm2ydzFhT2+0G3Dop8IrP1ntWeTtCwMbAp9mwk9ZlXe8j5rBX7le1TujRLanpdm3yT25loYNO/MsX82ITi08MTQBQGUGrGbBClBYND33a/c21W6PLiRY7eYELIT9unUxFhYtn/uj43GgVAa0YSN0SGOT353OSkPGzqZEitOLYpq0cjkeJeCvdAL5Xfmu6sBxxkZZWdS/FaW/r1/UlXMwusWl6UGSzXpd7CJ5bAyYLuVmes0VSUHkLWyNF/KCps17bB6SxIOlAnabjjHlK/RoFx1dmO3Ve5k/uR9jBmbyM1PFVDHAvWgF9X5sypHLQ6U+KgkrG5DoQYeI6UhdnCj1WTKqL+9GUsP2hMvsYs6T7Nf+ivN40Xyfmt3F0gawobQcpYIr8BytMZ8qynIKKSj1xPNnV9zUWBAO3nmZFHdSDaZOfVEBsPrTymigJKvjznISH1FYdk6Eqj5TQiGmFIJVel4NEUpsYgWjKMaYw190AuLQwoiPm2lnsevStHYpi/4Utn1AbFRwFJxSFG2FFfb1jotFlNS7avj7KKix6G3wtjR4ViyxfZ1QfpyYZ/1qPejgrt+TnUBXar7oXU/qjCREsluk1w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(451199015)(5660300002)(8676002)(4326008)(54906003)(52536014)(6636002)(76116006)(66556008)(66946007)(2906002)(66446008)(64756008)(66476007)(71200400001)(478600001)(9686003)(26005)(186003)(7696005)(53546011)(41300700001)(6506007)(86362001)(55016003)(83380400001)(38100700002)(8936002)(38070700005)(6862004)(316002)(33656002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Wv1ih0NDrV/lccI9uGdlrdLyZMb6LCs+lGcOfbN/tpTXCD8492Fhir2KzJTw?=
 =?us-ascii?Q?7H/zNKmltjf7Y84oE1xqGNpdP0P08z9BAs9aS5Xl0jeaXK/BFtHHIZIfUoTb?=
 =?us-ascii?Q?o6DVNHM/3ugAJXhHtsgO05zpe4TGGsigyQzWIBtSj1RUO3WNCY5QRsVXVXce?=
 =?us-ascii?Q?5K8DJUoNVbj3JhCI0NKaDnpKUTGB3YqFScelIecUjnMnG/i3Kmf69ppoH9Cm?=
 =?us-ascii?Q?9kjOmg8elZG3wi9d1CmOsaUChf+uyLbmJHaX6fgC8Eaa4sqf4ptVi48wZzna?=
 =?us-ascii?Q?djt14ob6D9u/QONZCcybG8zi1MzciktWy/F5fQ25p1UeHrE/CDcypgmbmdkf?=
 =?us-ascii?Q?/f/gTXssohD5pbM47m1BqwmhY92g/DAF88/Ai7A2HCLwVG7MhTECZ5Wu8cEw?=
 =?us-ascii?Q?LDK5n8h/2kQ5M2zpaGb9UWsPKyIsYoK/Un/cn3oCWRQYy7Kx5BgMnB/yHjxG?=
 =?us-ascii?Q?rc2EOjERYM/NdX+fH/D/uafunw2DChfE85wGOWc1kqh4XdNR4ZTRE74X9g0E?=
 =?us-ascii?Q?wh6uF66wGeNKQbjwG6R/ZMANZD37yjnQ6MNNNG2mXT9CWZHVB6OzI9sJjYB0?=
 =?us-ascii?Q?mIWuv8ShjpNWLqEhWKL/8F9j/rKQjRyl32SGdwO7SuZUWQAm+mVCyhBgeKno?=
 =?us-ascii?Q?DsemGkaPti2iahYRm7HrKpboYWYOBQ85z0lvvJxhRY4en5pFittyO6lUjnfz?=
 =?us-ascii?Q?h0Vr9MBiiZUPH0njpUqBWTFYysVC0akRyNXFA1fU3V7RZ34z1dwIrdA2worn?=
 =?us-ascii?Q?2T5YM3vS0vGsQXoHxZT023nGcYkmT8IJzdI62dLelwVNFOV+mCJNwF994eIn?=
 =?us-ascii?Q?eDP760rKu1CI3hp3Gn7EKJ6hh03qL4xwr8bzOmrB/Te5QWQyXOM7QY8LXNdz?=
 =?us-ascii?Q?loaEknaPNS8Jq/Uf4i3fwTq/h6FYTp2jbr4VlrujzYBQxaVvvL17U8dCrg9b?=
 =?us-ascii?Q?Bzu1oVqJ9p+HQ7N2V9vT073rqQtGvFNiq6d66aySFDSbBjPVssxqxM8OE4pW?=
 =?us-ascii?Q?1gwT7jwXFVvlGmsQxJlDYLRFNGHVS1Fsdkw7jGveLb4rCFYWhMop6tAZQzEe?=
 =?us-ascii?Q?uCV9ZlEkaJey0PPXQtn9ftBtB6I7fRw/JKPgtGTS8b/K/Q8LackvV+G7ebz4?=
 =?us-ascii?Q?XxbO5awHzfc8blJ88PmBuj1+5Ywdzi9eG2Nc0emXYbIzSRULQL42GzQ1jGIh?=
 =?us-ascii?Q?uhQRbihzGqUfMR4x9SKIBJWAQyjOFnvj16APQUUzGAfK5KNJ9DNLW8CCccM9?=
 =?us-ascii?Q?PkQE/JwqBT/nvVR9cAF0DFwb455cQNHc7sbRHL3+bdjnspDhv3QqnBY63KpA?=
 =?us-ascii?Q?yWFqELP5APbP3FMgQacqmsxY4Te0EM1yFim+5u6HH8XtR+nRbth4hTowOY6C?=
 =?us-ascii?Q?6n6MZYd/nu2SOjRK4Rt2pmIHyLg+o/A9F6Nq1mNIHKrt/X9JB5EnqkI9U9Vg?=
 =?us-ascii?Q?LfFDnIP0JiLBxZv6T4bht9ozxx1W5vA3TwJ8536UU+n0sm9UrIp5RtsMNJsk?=
 =?us-ascii?Q?99Rgn8s7CxbbQ9iAJ2C+cAvjTIvi1rxSnRC0Pse9LWS4ZZGl8uYv/NMGtsjq?=
 =?us-ascii?Q?0VnEJYWnuYcUWDb/VRp88Cz3i0lp6PoHsmMY5Be9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e27497-bf13-4d2b-6a78-08dae1abf04e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2022 10:29:41.3205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b9OqpFc1quRTuewDAnckUmMGMPEEdgksMA8QBxQda1016/OllRIUQZIwhimtnU17LWllAcbtHBz36pQk1kcAaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8350
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
> Sent: Monday, December 12, 2022 6:24 PM
> To: Yuan, Perry <Perry.Yuan@amd.com>
> Cc: rafael.j.wysocki@intel.com; Limonciello, Mario
> <Mario.Limonciello@amd.com>; viresh.kumar@linaro.org; Sharma, Deepak
> <Deepak.Sharma@amd.com>; Fontenot, Nathan
> <Nathan.Fontenot@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Huang, Shimmer
> <Shimmer.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Meng,
> Li (Jassmine) <Li.Meng@amd.com>; Karny, Wyes <Wyes.Karny@amd.com>;
> linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v7 09/13] cpufreq: amd-pstate: add driver working
> mode status sysfs entry
>=20
> On Thu, Dec 08, 2022 at 07:18:48PM +0800, Yuan, Perry wrote:
> > From: Perry Yuan <Perry.Yuan@amd.com>
> >
> > While amd-pstate driver was loaded with specific driver mode, it will
> > need to check which mode is enabled for the pstate driver,add this
> > sysfs entry to show the current status
> >
> > $ cat /sys/devices/system/cpu/amd-pstate/status
> > active
> >
> > Meanwhile, user can switch the pstate driver mode with writing mode
> > string to sysfs entry as below.
> >
> > Enable passive mode:
> > $ sudo bash -c "echo passive >  /sys/devices/system/cpu/amd-
> pstate/status"
> >
> > Enable active mode (EPP driver mode):
> > $ sudo bash -c "echo active > /sys/devices/system/cpu/amd-pstate/status=
"
> >
> > Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
>=20
> I believe you should align with Wyes to send out a unify state or status =
API to
> indicate the state machine of different work mode for AMD P-State driver
> including active and guided mode.
>=20
> Thanks,
> Ray
>=20

Aligned with Wyse and I add one new working mode switch support patch in V8=
 adding epp,guide,passive mode in it.=20

> > ---
> >  drivers/cpufreq/amd-pstate.c | 101
> > +++++++++++++++++++++++++++++++++++
> >  1 file changed, 101 insertions(+)
> >
> > diff --git a/drivers/cpufreq/amd-pstate.c
> > b/drivers/cpufreq/amd-pstate.c index 4cd53c010215..c90aee3ee42d
> 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -64,6 +64,8 @@ static bool cppc_active;  static int cppc_load
> > __initdata;
> >
> >  static struct cpufreq_driver *default_pstate_driver;
> > +static struct cpufreq_driver amd_pstate_epp_driver; static struct
> > +cpufreq_driver amd_pstate_driver;
> >  static struct amd_cpudata **all_cpu_data;  static struct
> > amd_pstate_params global_params;
> >
> > @@ -72,6 +74,7 @@ static DEFINE_MUTEX(amd_pstate_driver_lock);
> >  struct kobject *amd_pstate_kobj;
> >
> >  static bool cppc_boost __read_mostly;
> > +static DEFINE_SPINLOCK(cppc_notify_lock);
> >
> >  static s16 amd_pstate_get_epp(struct amd_cpudata *cpudata, u64
> > cppc_req_cached)  { @@ -629,6 +632,8 @@ static int
> > amd_pstate_cpu_init(struct cpufreq_policy *policy)
> >  	policy->driver_data =3D cpudata;
> >
> >  	amd_pstate_boost_init(cpudata);
> > +	if (!default_pstate_driver->adjust_perf)
> > +		default_pstate_driver->adjust_perf =3D
> amd_pstate_adjust_perf;
> >
> >  	return 0;
> >
> > @@ -802,6 +807,100 @@ static ssize_t store_cppc_dynamic_boost(struct
> kobject *a,
> >  	return count;
> >  }
> >
> > +static ssize_t amd_pstate_show_status(char *buf) {
> > +	if (!default_pstate_driver)
> > +		return sysfs_emit(buf, "off\n");
> > +
> > +	return sysfs_emit(buf, "%s\n", default_pstate_driver =3D=3D
> &amd_pstate_epp_driver ?
> > +					"active" : "passive");
> > +}
> > +
> > +static void amd_pstate_clear_update_util_hook(unsigned int cpu);
> > +static void amd_pstate_driver_cleanup(void) {
> > +	unsigned int cpu;
> > +
> > +	cpus_read_lock();
> > +	for_each_online_cpu(cpu) {
> > +		if (all_cpu_data[cpu]) {
> > +			if (default_pstate_driver =3D=3D
> &amd_pstate_epp_driver)
> > +				amd_pstate_clear_update_util_hook(cpu);
> > +
> > +			spin_lock(&cppc_notify_lock);
> > +			kfree(all_cpu_data[cpu]);
> > +			WRITE_ONCE(all_cpu_data[cpu], NULL);
> > +			spin_unlock(&cppc_notify_lock);
> > +		}
> > +	}
> > +	cpus_read_unlock();
> > +
> > +	default_pstate_driver =3D NULL;
> > +}
> > +
> > +static int amd_pstate_update_status(const char *buf, size_t size) {
> > +	if (size =3D=3D 3 && !strncmp(buf, "off", size)) {
> > +		if (!default_pstate_driver)
> > +			return -EINVAL;
> > +
> > +		if (cppc_active)
> > +			return -EBUSY;
> > +
> > +		cpufreq_unregister_driver(default_pstate_driver);
> > +		amd_pstate_driver_cleanup();
> > +		return 0;
> > +	}
> > +
> > +	if (size =3D=3D 6 && !strncmp(buf, "active", size)) {
> > +		if (default_pstate_driver) {
> > +			if (default_pstate_driver =3D=3D
> &amd_pstate_epp_driver)
> > +				return 0;
> > +			cpufreq_unregister_driver(default_pstate_driver);
> > +			default_pstate_driver =3D &amd_pstate_epp_driver;
> > +		}
> > +
> > +		return cpufreq_register_driver(default_pstate_driver);
> > +	}
> > +
> > +	if (size =3D=3D 7 && !strncmp(buf, "passive", size)) {
> > +		if (default_pstate_driver) {
> > +			if (default_pstate_driver =3D=3D &amd_pstate_driver)
> > +				return 0;
> > +			cpufreq_unregister_driver(default_pstate_driver);
> > +		}
> > +		default_pstate_driver =3D &amd_pstate_driver;
> > +		return cpufreq_register_driver(default_pstate_driver);
> > +	}
> > +
> > +	return -EINVAL;
> > +}
> > +
> > +static ssize_t show_status(struct kobject *kobj,
> > +			   struct kobj_attribute *attr, char *buf) {
> > +	ssize_t ret;
> > +
> > +	mutex_lock(&amd_pstate_driver_lock);
> > +	ret =3D amd_pstate_show_status(buf);
> > +	mutex_unlock(&amd_pstate_driver_lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static ssize_t store_status(struct kobject *a, struct kobj_attribute *=
b,
> > +			    const char *buf, size_t count) {
> > +	char *p =3D memchr(buf, '\n', count);
> > +	int ret;
> > +
> > +	mutex_lock(&amd_pstate_driver_lock);
> > +	ret =3D amd_pstate_update_status(buf, p ? p - buf : count);
> > +	mutex_unlock(&amd_pstate_driver_lock);
> > +
> > +	return ret < 0 ? ret : count;
> > +}
> > +
> >  cpufreq_freq_attr_ro(amd_pstate_max_freq);
> >  cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
> >
> > @@ -809,6 +908,7 @@ cpufreq_freq_attr_ro(amd_pstate_highest_perf);
> >  cpufreq_freq_attr_rw(energy_performance_preference);
> >  cpufreq_freq_attr_ro(energy_performance_available_preferences);
> >  define_one_global_rw(cppc_dynamic_boost);
> > +define_one_global_rw(status);
> >
> >  static struct freq_attr *amd_pstate_attr[] =3D {
> >  	&amd_pstate_max_freq,
> > @@ -828,6 +928,7 @@ static struct freq_attr *amd_pstate_epp_attr[] =3D =
{
> >
> >  static struct attribute *pstate_global_attributes[] =3D {
> >  	&cppc_dynamic_boost.attr,
> > +	&status.attr,
> >  	NULL
> >  };
> >
> > --
> > 2.34.1
> >
