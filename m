Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5350B655DC6
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 17:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbiLYQmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 11:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbiLYQly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 11:41:54 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2067.outbound.protection.outlook.com [40.107.212.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2967213;
        Sun, 25 Dec 2022 08:41:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oKFI55Gpb2FZ59HHLgzkVMispWSV4JPJ5VaaIDXYQBCWl/LwDjpvhgVWlafreTeLMCQzVcyPsFszuol94ylOJRCweCBDiNebLewR1wI8NOtG14o1kmrcOekVF+x/9fJAe3XK4IuMomxx0kaUskd3/hHXDSOjZVdwq2sRsfiWqy6OdVupwye90AqdWRMxZKT++DgC8OgA8pD4qbEYgy0SnlMJAJjVITHvwLakxi/2d2y47WFLHNDF+WEcq0/Y1xTcqyS0qhdvS5OKBL9EO4nX5Jby1O8haRkzhgFT0/SGEdU96vEw45hi4Hyr8KiCYUnfkLc6mFeRCU4uM+SiCgvxVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9am6XBwEKadNZsehRKQIWz1qbQbuf4TIPHiZrNFVtY=;
 b=md7kXT3ttrrclWfE6u3tm5TQaWoamElPIgks9DssnbeWrffOGg1KFmbgqt2Qqh8qnzgMKGQe8ZndzYwHx/OesWE0zZpUcQYDqEruXN8JMVFFVRPJuzw4z7BkBJ3+t2vE3CVswkmO/flmJWXEuWBf2yQap7ES6D56FgD4qV2VGmvcnxkTP/3Zg/r5KrYW6cuA9zYXiGhLTWXcqP1lr4e4F3Fa/El4/IaRJoi+0q577auAVZ89HzvMSQwFxp6FAnLZkPnPjNw0HosCoFHhUZ3GHDNPcO5mFz6hcsoy/DFLpSWOBnymQYZC67UQ4SuYeiKssDix6vo5E+BfWygZ8BGwlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9am6XBwEKadNZsehRKQIWz1qbQbuf4TIPHiZrNFVtY=;
 b=ccnMsdMDoYku7k9zyZyGd/+PVOKPbuCPc4E0iKhkTfGVXBZTrQAzUFtIG+Er3slXmPadsgyyYabOWmFBw0FfUcI3rY/Do1mLgFAhAQWn0UkCNDq4f4QQV3qSJsh6lBOP0xCal2/pz866NbEwCL1lyDsUyKq1/+fD0mZ6rpxgUKs=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by CH2PR12MB4860.namprd12.prod.outlook.com (2603:10b6:610:6c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.14; Sun, 25 Dec
 2022 16:41:50 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed%9]) with mapi id 15.20.5944.015; Sun, 25 Dec 2022
 16:41:50 +0000
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
Subject: RE: [PATCH v8 09/13] cpufreq: amd-pstate: add driver working mode
 switch support
Thread-Topic: [PATCH v8 09/13] cpufreq: amd-pstate: add driver working mode
 switch support
Thread-Index: AQHZE3U4TKgox8MrB0eBMbwmECJHIq57Me8AgAOlZCA=
Date:   Sun, 25 Dec 2022 16:41:50 +0000
Message-ID: <DM4PR12MB5278B9BD3DB938CF4EC628D69CEF9@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20221219064042.661122-1-perry.yuan@amd.com>
 <20221219064042.661122-10-perry.yuan@amd.com> <Y6VtNOgfohaewEtW@amd.com>
In-Reply-To: <Y6VtNOgfohaewEtW@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-12-25T16:38:35Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a9bab72d-7657-4697-9017-9f2e94d0b059;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-12-25T16:38:35Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 430552d4-1f43-4c1f-a785-f2d7de558f45
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|CH2PR12MB4860:EE_
x-ms-office365-filtering-correlation-id: ea92e93e-f501-403f-76b7-08dae696ec24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5KhtLbJtd7SPV/dJQvt7ApwVvA4sVrdILidW8TqmkSvOFfh1WIs4aoRD6xoxk1CyJi9HhqGYPKMmV4DqIFJnyz28YdXVw9PlKdZBvFOj3cug6U57yKZHO/pOAFhQJzlIFgWTvNiJ6bDyoKZeGPYEXFV8QE4bc+MR0PepOAUFUIvhUKcRXKZE9zUFS/VSSWGL4wmKxzIN0s6Jm7asiRnGVtbYAayao11CE2GtlygGuPq/VCQ3hoYX0+PwAhqMtmenWzOK/C0Ep05vNUtMv1ltxmskbWYWizf7gOz5EIuGwifog7UeHcOjQYRZfOaRjgzchJH5QLEsTHw9Ph/XwonhlDXLvZ0g7KMd7lXrYjX55b9sObPrNa1+W1CnT45LLzXH90vC47IA0BKsZGOpCkYiTph7+837mKucu1qOlOUN7cOynm0R/ef40M4SvrXEnj4kK0ufj4r4L6nkwaxxjicCIScE8TET6IP8osmRx+DaI4DrOyjxYIRxwv8FV/rPcUKEjMaBpaCNsd1kWOKz6Pu64AglVpXPd+5tybLlvfJYyn1BiEx2r695250QBagle5GmFCM0mI5g3t91JPdRYjRD7srNNfqnfHypXVwfmS0WnRwr5qGcbYpMU+pYl7L/4rZ2YjmOuXPzf/p/9IfE/QyLLQ9r/26WKNUjfMSNVtUw2gTGDW7FsI7kNzY9G+Vv+P/9+AqDOz3c+e5/epYj3QDO+Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(451199015)(83380400001)(2906002)(54906003)(6636002)(33656002)(316002)(38070700005)(26005)(478600001)(9686003)(186003)(53546011)(122000001)(38100700002)(7696005)(6506007)(71200400001)(86362001)(55016003)(4326008)(66476007)(8676002)(66556008)(64756008)(52536014)(66446008)(6862004)(8936002)(41300700001)(76116006)(66946007)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EDItt6v/h4MinEB2xcUsT0VxnvlWvUbI+MC2tBeMmlAX1zgujGuNrdtkv8Z7?=
 =?us-ascii?Q?98+5+cN419rc1NN0rLl9BRhxAP45mLVKCWWXWRJSL8PHaBoj8SrzgRAOBCf5?=
 =?us-ascii?Q?qw8qMw1ksE5iV85Ri8YKdVHYbw6pHHIq8OhU6Q8uCgNQC0hIv8XeMRDUgLre?=
 =?us-ascii?Q?8tjyH1KauQp02E87vfxsUxfGTKbjdlppnRtcmFncTCGnGejXvAZqDBiPZOmc?=
 =?us-ascii?Q?Te6wdcLlADm2VtpZIZeLjcUMxs4zhy/E+Qx11KB6LiFJ0wY2IZwSMLVF5dfG?=
 =?us-ascii?Q?pL4+4ue4BGznVjTwRAlt50Igfs6K3bPgsz73eyRd1nXhyeXcLy05ZQEYxs7L?=
 =?us-ascii?Q?xpnjkRh93AWHY7dxFxBDVPwd93cHWhSrq2u1YCNU/l1XLIThrNPq6M/5aUmI?=
 =?us-ascii?Q?YF1s1nGIvRH0yIvGKDiVHBwB35mhdgoGQJ1EFpvhB76azq0a/E6ZQdrZ/gA0?=
 =?us-ascii?Q?Re7pYOP48zkmjYSE7iJPcQT26MC/E3AOmPf2GhcvhxyZwWRmW2inUmfDDN4M?=
 =?us-ascii?Q?AyaRdQcQMX7KGe0Z4kXGC4JvWkTi8RboBe/RYb3mBzEjcd5/wPQOTedkIioL?=
 =?us-ascii?Q?t6A1GxoM/7BJoYOudNqsq/eAfbs0HWL3ROtMKLfbh+0d1Cl5MWdps1R31lf0?=
 =?us-ascii?Q?ZIRF72gKIKmCaWopfgegGUpVXLVM53Rgr6MuQxCjBuCT85YQUkQ38BAKG+be?=
 =?us-ascii?Q?6bVGAM82wwxC+tDmL+IUded28l8u06kw5qzWJj/dh9ezxS7zqHWIdf0OL9Lo?=
 =?us-ascii?Q?65a8I5xN/k6X0/Nts1fuS946W42oLvo3l0u20rvPWLEPInjzTs34uvATJiLv?=
 =?us-ascii?Q?fNUZJCXU2wTof0+MpVpNUDbanvIyc2Ws9z6/GmuYV96lH1JSHT9GIMJWmFQe?=
 =?us-ascii?Q?JwnHgJEOnzIjUtAgCIosy8Cr9zEs8WuMo5YXXMEytnrhfsJ89kKgK9qC7Pkf?=
 =?us-ascii?Q?Lsp5dX8N/wvrlYp+Jzeu423/MPSROpD/g8d42EbVOO9xMZ+gnw6NDnji/ri8?=
 =?us-ascii?Q?plFyNviHtRnNMaHFLPopJouudziTkkMPqXwfM8XPxNpxeXTPf4YftZNhefgP?=
 =?us-ascii?Q?EknDJhQx0XL1Mxr002FMRAbrelSPGT7aB+tHnbOMDtbShkowYPyzHUIAifPa?=
 =?us-ascii?Q?cSJ9zHe83KJroQfqcQVd5sRE3xNEWt2QsDbvNx9mH+wROGTpQrI+F68xBBRp?=
 =?us-ascii?Q?OQNj9jMNukmIOKSzqK9RyViidv8LbtuGfUXtl/rYmlt3e38G13zW1qe8JjCk?=
 =?us-ascii?Q?m4qmx0SyGWRxk0bsxZ5QyfoMQ/k4cMs8DeY1TeUR4gLobBvoGeZseHXH1dj2?=
 =?us-ascii?Q?aatiZKUDxtvgHnJY2KLpr/Mfg3jMQCpqp52c2MogCp4hnSTABie6M9daN/I1?=
 =?us-ascii?Q?HlOawc4tLED/OZyEb3WR5M1XmBU/kzo2Y4Qw7B0n2Z7W8OnZShq2STdADwco?=
 =?us-ascii?Q?skYLJk9rcyhLlxiIohR0YoYpBgVjyDDXK/mZXtUPMQohI5sSOY9M4yjkL+p7?=
 =?us-ascii?Q?K37CBYYJUe23kVVebYJI0G7zgSALDMv+4c3lZlJn5LSen82BThEtoDs5RB8w?=
 =?us-ascii?Q?RJ7fnZi2XDIIq74yw58WpJYkS2bCJEnGKIZbRnOc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea92e93e-f501-403f-76b7-08dae696ec24
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2022 16:41:50.7329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AegG/3VT8UcZkU/xvrFc9Z5Nr9bVhRA0rQP8y/0F9v2cmUjo5uMnAw0+1SmkVAkjMV4u9pp5jsEGbsYiT1UQog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4860
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
> Sent: Friday, December 23, 2022 4:56 PM
> To: Yuan, Perry <Perry.Yuan@amd.com>
> Cc: rafael.j.wysocki@intel.com; Limonciello, Mario
> <Mario.Limonciello@amd.com>; viresh.kumar@linaro.org; Sharma, Deepak
> <Deepak.Sharma@amd.com>; Fontenot, Nathan
> <Nathan.Fontenot@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Huang, Shimmer
> <Shimmer.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Meng,
> Li (Jassmine) <Li.Meng@amd.com>; Karny, Wyes <Wyes.Karny@amd.com>;
> linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v8 09/13] cpufreq: amd-pstate: add driver working mod=
e
> switch support
>=20
> On Mon, Dec 19, 2022 at 02:40:38PM +0800, Yuan, Perry wrote:
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
> > ---
> >  drivers/cpufreq/amd-pstate.c | 128
> > +++++++++++++++++++++++++++++++++++
> >  1 file changed, 128 insertions(+)
> >
> > diff --git a/drivers/cpufreq/amd-pstate.c
> > b/drivers/cpufreq/amd-pstate.c index fc12d35bc7bd..e8996e937e63
> 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -64,6 +64,7 @@ static struct cpufreq_driver amd_pstate_driver;
> > static struct cpufreq_driver amd_pstate_epp_driver;  static struct
> > amd_cpudata **all_cpu_data;  static int cppc_state =3D
> > AMD_PSTATE_DISABLE;
> > +struct kobject *amd_pstate_kobj;
> >
> >  static inline int get_mode_idx_from_str(const char *str, size_t size)
> > { @@ -90,6 +91,8 @@ static struct amd_pstate_params global_params;
> > static DEFINE_MUTEX(amd_pstate_limits_lock);
> >  static DEFINE_MUTEX(amd_pstate_driver_lock);
> >
> > +static DEFINE_SPINLOCK(cppc_notify_lock);
> > +
> >  static s16 amd_pstate_get_epp(struct amd_cpudata *cpudata, u64
> > cppc_req_cached)  {
> >  	u64 epp;
> > @@ -644,6 +647,8 @@ static int amd_pstate_cpu_init(struct
> cpufreq_policy *policy)
> >  	policy->driver_data =3D cpudata;
> >
> >  	amd_pstate_boost_init(cpudata);
> > +	if (!default_pstate_driver->adjust_perf)
> > +		default_pstate_driver->adjust_perf =3D
> amd_pstate_adjust_perf;
>=20
> If default_driver is passive driver, it will be programed as
> amd_pstate_adjust_perf. If not, the epp driver won't need adjust_perf.
>=20
> Thanks,
> Ray

The adjust_perf() should be set again when switching from epp to cppc drive=
r.
The above amd_pstate_cpu_init ()  is called when amd-pstate driver loading,=
 epp driver will not load it.


>=20
> >
> >  	return 0;
> >
> > @@ -784,12 +789,106 @@ static ssize_t
> show_energy_performance_preference(
> >  	return sysfs_emit(buf, "%s\n", energy_perf_strings[preference]);  }
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
> > +static void amd_pstate_driver_cleanup(void) {
> > +	unsigned int cpu;
> > +
> > +	cpus_read_lock();
> > +	for_each_online_cpu(cpu) {
> > +		if (all_cpu_data[cpu]) {
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
> > +		if (cppc_state =3D=3D AMD_PSTATE_ACTIVE)
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
> > +			cppc_state =3D AMD_PSTATE_ACTIVE;
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
> > +			cppc_state =3D AMD_PSTATE_PASSIVE;
> > +			default_pstate_driver =3D &amd_pstate_driver;
> > +		}
> > +
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
> >  cpufreq_freq_attr_ro(amd_pstate_highest_perf);
> >  cpufreq_freq_attr_rw(energy_performance_preference);
> >  cpufreq_freq_attr_ro(energy_performance_available_preferences);
> > +define_one_global_rw(status);
> >
> >  static struct freq_attr *amd_pstate_attr[] =3D {
> >  	&amd_pstate_max_freq,
> > @@ -807,6 +906,15 @@ static struct freq_attr *amd_pstate_epp_attr[] =3D=
 {
> >  	NULL,
> >  };
> >
> > +static struct attribute *pstate_global_attributes[] =3D {
> > +	&status.attr,
> > +	NULL
> > +};
> > +
> > +static const struct attribute_group amd_pstate_global_attr_group =3D {
> > +	.attrs =3D pstate_global_attributes,
> > +};
> > +
> >  static inline void update_boost_state(void)  {
> >  	u64 misc_en;
> > @@ -1228,6 +1336,26 @@ static int __init amd_pstate_init(void)
> >  	if (ret)
> >  		pr_err("failed to register with return %d\n", ret);
> >
> > +	amd_pstate_kobj =3D kobject_create_and_add("amd-pstate",
> &cpu_subsys.dev_root->kobj);
> > +	if (!amd_pstate_kobj) {
> > +		ret =3D -EINVAL;
> > +		pr_err("global sysfs registration failed.\n");
> > +		goto kobject_free;
> > +	}
> > +
> > +	ret =3D sysfs_create_group(amd_pstate_kobj,
> &amd_pstate_global_attr_group);
> > +	if (ret) {
> > +		pr_err("sysfs attribute export failed with error %d.\n", ret);
> > +		goto global_attr_free;
> > +	}
> > +
> > +	return ret;
> > +
> > +global_attr_free:
> > +	kobject_put(amd_pstate_kobj);
> > +kobject_free:
> > +	kfree(cpudata);
> > +	cpufreq_unregister_driver(default_pstate_driver);
> >  	return ret;
> >  }
> >  device_initcall(amd_pstate_init);
> > --
> > 2.34.1
> >
