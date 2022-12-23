Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3111D654D05
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 08:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiLWHwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 02:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiLWHww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 02:52:52 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08AD31CB37;
        Thu, 22 Dec 2022 23:52:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LLV2B2EK5eVVfMuZ/XOb6N8YsfY4eF4leXA2rX9nw0gvmqN0Se3aV4yp3Z5whTZo6Kh8OsG7csHBR5EVA50QuoJKau5VbdiFPZAjYah3M2n+97rZSXdFVhK2nYKswbRsDoDHbJCvUKyUS3SaqJwyFT3+gIVVfZ9ni20Z+P4K99lTYAwBI3kICAIqT2eJmPb4ZLD5yBaWlTNwlM0/UN9plNUM6kGcDSLMoC+9+rkUugkIXB9+ED2tuNESU7VHCaZTn1tasdKS4QqjV4yhVFOlTevKdekMg8+HgJu8EVzyUfjl7XOSX+AbAxTo1YYwx4BGrYSBO2oISBArznwvHp68GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XwIxSo8tywxI7Ryzqd7zSH+yjhhitptJXJlXQosm0GA=;
 b=kzKazrRBLWd+x8E1HPATDRZUytwQp8fHmWF1c8nHQR+v9v7dTLyVNE7SXlfthOwNqzK30rbPLzdFt7b1XV0Gn4ckkrsbqm42BhTbKmmcqB/6oP8UDYWxJdk9nRN0eq5Oxq+/vFIzwZdHHh4uk00lpqcVL22eotF2ViOaWO8A5t0+fzpZIrOuwhWxwA8qHSLzaUkjJPM0Fj9La2MQNAcODC8dNXwyPqb1/u9FJ3La8ILoVpyyfYvZMbqpJyftqDAgxylBqe9Q9aZuc1ibxQqrzUdtFAZ/IGpdg5HS0JgNNkkU1sccB0DNkSvcsvXnhV/ADsnMx1I6Mq45C743UMjA2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XwIxSo8tywxI7Ryzqd7zSH+yjhhitptJXJlXQosm0GA=;
 b=aGpKGkI/RiTU8CmciFsPeiO5zNK1l1vhTi7lJHq/HtwZRrOTu2J+HpJUtyxAILAjFkKFUag7CsBpYXMI3EhSud37uml4ofZXEFBEXJ59bLYVDX86pc7ZUv9Yad24byQ2yWAZdW/+zbBkzUuIOJ7QsRCS/+P29xV3VnLlBCStExk=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by SA3PR12MB7782.namprd12.prod.outlook.com (2603:10b6:806:31c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Fri, 23 Dec
 2022 07:52:47 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::960b:6963:b27e:f9ed%8]) with mapi id 15.20.5924.016; Fri, 23 Dec 2022
 07:52:47 +0000
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
Subject: RE: [PATCH v8 06/13] cpufreq: amd-pstate: implement Pstate EPP
 support for the AMD processors
Thread-Topic: [PATCH v8 06/13] cpufreq: amd-pstate: implement Pstate EPP
 support for the AMD processors
Thread-Index: AQHZE3UdtUCvwhVLD0OG45GsG4Tdoq57HYIAgAACWMA=
Date:   Fri, 23 Dec 2022 07:52:47 +0000
Message-ID: <DM4PR12MB5278CBF5ACFFA9167B738E9B9CE99@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20221219064042.661122-1-perry.yuan@amd.com>
 <20221219064042.661122-7-perry.yuan@amd.com> <Y6VcEvJGn+rM+DLc@amd.com>
In-Reply-To: <Y6VcEvJGn+rM+DLc@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-12-23T07:51:38Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=0ddd864d-334e-42e4-ae17-a0570fe88498;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-12-23T07:52:45Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: b526d977-5e6d-4c3c-9847-17ad16ff1305
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|SA3PR12MB7782:EE_
x-ms-office365-filtering-correlation-id: ff5b5573-ac2b-497d-889e-08dae4baaf0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cyglz6k0QvCNtnOpf7wK0aUZAx08pKkyqVqrAIRBZWgamPZKIfPykehCw1A8JGkkgVDbixJXOSvE9bqw4U6T2jLA6OtXIDOMMU3X+O1ppsXsfj7yFJQoTo10dY+XiXWXwJ9WRToWTjweU0GIQogOX3EGs/YXQ9zSMS3YILzsJL1cw5IqePLZgPB+hi+9/QgwsQ2oIVyvGF4kG19dqfMk0AHCG3GZ5fAnafEgVC2BCePD65U/WjfLZfgfylUWiCLJwEtnaZGtXGn5VppFL3rMJYMoGWDj48mprgcogbO7WJ0bqnhBEWfJ3Ijb7YfZOu64EeiE9LhSvAeuzsdnGa/7nGH/DOLQUJKJ5ccXnhZnbXjR/SZody5HZGOZvvFKPhYy8kzWvqMlYSFl+c8pfvzSWsar8Mv+2AUvOxWFRfludXS/EPvpZNvFjIVzVXW9x9Sb8qSiGlH1MFWuXuT9uHJG9/uWxrmYE0Qz6cwu7WUBuvOjVhMFIOOjxc3FdF+K75W3dz6z+XqW8gSXDIahYjx5s/BI7XAJviT8Pnkb1unSY+Y/zpmo4lDmkRv72PWlGqKc85RaUAA2Owx2fjMrYtjZcXH56QIOKfxQCBMVuyH8IBfk5rqMa2X8qfOOzGsO9cnerNOlrbdAlihFgldwU6Z3K2jGeflmZ661T4Cr6GQz0cziHacssI97glZFcF9UiZMPOfwMibdwFeLlIPprsknf5zfdW5/xZBDPiQSMeQ1klws=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(451199015)(8676002)(6636002)(30864003)(5660300002)(54906003)(2906002)(52536014)(64756008)(76116006)(4326008)(66556008)(66946007)(66476007)(66446008)(966005)(71200400001)(478600001)(53546011)(9686003)(41300700001)(26005)(6506007)(7696005)(186003)(86362001)(8936002)(55016003)(83380400001)(38070700005)(6862004)(316002)(38100700002)(33656002)(122000001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DDryufrOUugDvxf1/hqUzpIOpOtx/u4PSqj7YOSUeqG4nQaC3ROhVxGcgig/?=
 =?us-ascii?Q?USrTQhTwrpGwCAECAUKq+UcBKyraj5jPdS1LjPMr3attQBTddSXBkqLmU7ts?=
 =?us-ascii?Q?uu4owsiNAMIKqO+6rLqB4MxmlrX87L/qOOwgToX2w6Grv/P4G+We9PPQRCcv?=
 =?us-ascii?Q?lJjsVNeykUs/KnMRPmHr8lBjKnOJ/1Lz5SJIAVwFo8G1PY4YMHOrnaDWYAP7?=
 =?us-ascii?Q?BvNza12CswNdXcvfvcKk9qAjuJUQ17fCPaBxN13DWJWJgrlUwNU+SmOfzaNc?=
 =?us-ascii?Q?Be97AsMmgZ/ZnvJilv+0Ig6z+9vvbiaM+C4uZvp/oV/Fjv77TGVlwo0kPUFI?=
 =?us-ascii?Q?6GlnWUZJTkJ9UFI4SP1yOYz+EMhISgD0MMhhmrmZ7KaEFOEhxKcMNJ2bSHv0?=
 =?us-ascii?Q?6EB0j2Q1yBADxOItQMvcLOoFjiI7sHjL/VXEZ+Nm2uy1/AjDDSo6XHiSsE3f?=
 =?us-ascii?Q?tO4kvnCDFwSNsxqsnJan+s1QhuLAZaAPd3++4r2s+cQiT3pGbp2VowwqpVCY?=
 =?us-ascii?Q?+7GILAR3phCMQ8birMQhdBzvyLdRiVNwEV9Uk0+uJRFiSL0+qCiVETTzfdMg?=
 =?us-ascii?Q?kLdCG69WoPocIu9dpAsfV6bS2Sv5LbJC2V7oXdu+bBJ8I1DExoCISwIoTJwP?=
 =?us-ascii?Q?NNHBrGddjG1bVPmQOH9g9zlV5yLnQwxJhtvaS2LKD6+k6MmFEbVPX3TRte+z?=
 =?us-ascii?Q?T/y6iHpyhUD/I3u46gthbsDD0Mj4bnYCL7PjlARFEjtxI/Yd59fsBAzCSb/3?=
 =?us-ascii?Q?GvFX/VVFDZksrwx3XX8kexRnpS9skYpPiM4Vc/82JdQNn8pMDwLLvlb2D+S4?=
 =?us-ascii?Q?ADmL8TpMlh9T3a+S7wUQuAgRDDLE776vZT90I/MNS0SdO60QTotUAApqNHHl?=
 =?us-ascii?Q?i2XIySZ3sGfNRt0OHigTZ0eWVuJeHmtGrOl6/FLa1bp0Mf6YiO9w10C6W3D2?=
 =?us-ascii?Q?6oqCuygMVe/kpDtVtktKsAedM0+7dLV8YOWAlzzo/FUsjBWxEWERsJZ++xxR?=
 =?us-ascii?Q?vn64Lx9GgxcvcydNEFCCItAGQ9Wz6/tt6GtpB3bYjVi0/3MAbi8ZEPcNwKRK?=
 =?us-ascii?Q?NwKzSxnMIgdbJGWiwjXROBiA+PzANS8KRkI9wuaovIR2/ONedsfUhX28NKiR?=
 =?us-ascii?Q?TCFWxw+sESWiGFRHmre4VcAWY94h8tJU3eOy+23Vut4uvi/71GUAC359OeVt?=
 =?us-ascii?Q?kWuwuwBQFRo1pNrOFtaI8LGC3y5HanmhbKZfRAGZHpc9doYV02ptDqJGnqZm?=
 =?us-ascii?Q?MUDdJZZxysYIO3tqEiG3mceO0b3E5zLZhrTFLLCD4otpq7F1wCqxGMVka23h?=
 =?us-ascii?Q?puyknpN0mY2GiA+cuOsZ4e9ELUMYfs9BVIHMdDgtubltoph5YGn2N7AxKVx7?=
 =?us-ascii?Q?8WnZXrBea+Y6fdKWjYp5n08g0KJ56544b54BGK4Bl2yEefACDrjl97VQAQLB?=
 =?us-ascii?Q?2gSO3+jmoGeWrdUwAC8wJi+qYnmhHfN788qKn6dt+QfmFwVq2gCu376vqLR6?=
 =?us-ascii?Q?yRt/m4pwKHT3yhNhSvjysSaTliDdi/xkVO4X+7WBZp4rWgnjzmHuXOmqdcIw?=
 =?us-ascii?Q?FQJqq3DEb8jcgiMGBLXMzngk7tRP0Sx4wuAYITkV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff5b5573-ac2b-497d-889e-08dae4baaf0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2022 07:52:47.8074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R14je6waCeyHrCctQLvoN/shL++IWvmzPaJqF03ktNFAE1Kf6+unk8q+lVWzBf234quitQvIvThfdKD26nFUHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7782
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

Hi Ray.=20

> -----Original Message-----
> From: Huang, Ray <Ray.Huang@amd.com>
> Sent: Friday, December 23, 2022 3:43 PM
> To: Yuan, Perry <Perry.Yuan@amd.com>
> Cc: rafael.j.wysocki@intel.com; Limonciello, Mario
> <Mario.Limonciello@amd.com>; viresh.kumar@linaro.org; Sharma, Deepak
> <Deepak.Sharma@amd.com>; Fontenot, Nathan
> <Nathan.Fontenot@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Huang, Shimmer
> <Shimmer.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Meng,
> Li (Jassmine) <Li.Meng@amd.com>; Karny, Wyes <Wyes.Karny@amd.com>;
> linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v8 06/13] cpufreq: amd-pstate: implement Pstate EPP
> support for the AMD processors
>=20
> On Mon, Dec 19, 2022 at 02:40:35PM +0800, Yuan, Perry wrote:
> > From: Perry Yuan <Perry.Yuan@amd.com>
> >
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
>=20
> Please check the comments in V7's reply:
>=20
> https://lore.kernel.org/lkml/Y6VVr+WYqwWb6XV0@amd.com/
>=20
> I think the static call is not hard required at this moment.
>=20
> But the boost/refresh_freq_limits stuff and cpudata may still need some
> enhancement. Others, looks good for me right now.
>=20
> Thanks,
> Ray

Thanks for your quick review at this hard time.
I will rework the patch as your suggestion in V9.=20

Perry.=20

>=20
> > Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> > ---
> >  drivers/cpufreq/amd-pstate.c | 447
> ++++++++++++++++++++++++++++++++++-
> >  include/linux/amd-pstate.h   |  10 +
> >  2 files changed, 451 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/cpufreq/amd-pstate.c
> > b/drivers/cpufreq/amd-pstate.c index 861a905f9324..66b39457a312 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -59,7 +59,10 @@
> >   * we disable it by default to go acpi-cpufreq on these processors and=
 add
> a
> >   * module parameter to be able to enable it manually for debugging.
> >   */
> > +static struct cpufreq_driver *default_pstate_driver;
> >  static struct cpufreq_driver amd_pstate_driver;
> > +static struct cpufreq_driver amd_pstate_epp_driver; static struct
> > +amd_cpudata **all_cpu_data;
> >  static int cppc_state =3D AMD_PSTATE_DISABLE;
> >
> >  static inline int get_mode_idx_from_str(const char *str, size_t size)
> > @@ -70,9 +73,128 @@ static inline int get_mode_idx_from_str(const char
> *str, size_t size)
> >  		if (!strncmp(str, amd_pstate_mode_string[i], size))
> >  			return i;
> >  	}
> > +
> >  	return -EINVAL;
> >  }
> >
> > +/**
> > + * struct amd_pstate_params - global parameters for the performance
> > +control
> > + * @ cppc_boost_disabled wheher the core performance boost disabled
> > +*/ struct amd_pstate_params {
> > +	bool cppc_boost_disabled;
> > +};
> > +
> > +static struct amd_pstate_params global_params;
> > +
> > +static DEFINE_MUTEX(amd_pstate_limits_lock);
> > +static DEFINE_MUTEX(amd_pstate_driver_lock);
> > +
> > +static s16 amd_pstate_get_epp(struct amd_cpudata *cpudata, u64
> > +cppc_req_cached) {
> > +	u64 epp;
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
> > +		ret =3D cppc_get_epp_perf(cpudata->cpu, &epp);
> > +		if (ret < 0) {
> > +			pr_debug("Could not retrieve energy perf value
> (%d)\n", ret);
> > +			return -EIO;
> > +		}
> > +	}
> > +
> > +	return (s16)(epp & 0xff);
> > +}
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
> > +
> >  static inline int pstate_enable(bool enable)  {
> >  	return wrmsrl_safe(MSR_AMD_CPPC_ENABLE, enable); @@ -81,11
> +203,21
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
> > +		if (cppc_state =3D=3D AMD_PSTATE_ACTIVE) {
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
> > @@ -429,7 +561,7 @@ static void amd_pstate_boost_init(struct
> amd_cpudata *cpudata)
> >  		return;
> >
> >  	cpudata->boost_supported =3D true;
> > -	amd_pstate_driver.boost_enabled =3D true;
> > +	default_pstate_driver->boost_enabled =3D true;
> >  }
> >
> >  static void amd_perf_ctl_reset(unsigned int cpu) @@ -603,10 +735,61
> > @@ static ssize_t show_amd_pstate_highest_perf(struct cpufreq_policy
> *policy,
> >  	return sprintf(&buf[0], "%u\n", perf);  }
> >
> > +static ssize_t show_energy_performance_available_preferences(
> > +				struct cpufreq_policy *policy, char *buf) {
> > +	int i =3D 0;
> > +	int offset =3D 0;
> > +
> > +	while (energy_perf_strings[i] !=3D NULL)
> > +		offset +=3D sysfs_emit_at(buf, offset, "%s ",
> > +energy_perf_strings[i++]);
> > +
> > +	sysfs_emit_at(buf, offset, "\n");
> > +
> > +	return offset;
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
> > +	return sysfs_emit(buf, "%s\n", energy_perf_strings[preference]); }
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
> > @@ -615,6 +798,235 @@ static struct freq_attr *amd_pstate_attr[] =3D {
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
> > +	}
> > +
> > +	cpudata->epp_policy =3D 0;
> > +	pr_debug("controlling: cpu %d\n", cpunum);
> > +	return 0;
> > +}
> > +
> > +static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy) {
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
> > +	cpudata->epp_cached =3D amd_pstate_get_epp(cpudata, value);
> > +
> > +	policy->min =3D policy->cpuinfo.min_freq;
> > +	policy->max =3D policy->cpuinfo.max_freq;
> > +
> > +	/*
> > +	 * Set the policy to powersave to provide a valid fallback value in c=
ase
> > +	 * the default cpufreq governor is neither powersave nor
> performance.
> > +	 */
> > +	policy->policy =3D CPUFREQ_POLICY_POWERSAVE;
> > +
> > +	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> > +		policy->fast_switch_possible =3D true;
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
> > +static int amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy) {
> > +	pr_debug("CPU %d exiting\n", policy->cpu);
> > +	policy->fast_switch_possible =3D false;
> > +	return 0;
> > +}
> > +
> > +static void amd_pstate_update_max_freq(unsigned int cpu) {
> > +	struct cpufreq_policy *policy =3D cpufreq_cpu_get(cpu);
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
> > +static void amd_pstate_epp_init(unsigned int cpu) {
> > +	struct amd_cpudata *cpudata =3D all_cpu_data[cpu];
> > +	u32 max_perf, min_perf;
> > +	u64 value;
> > +	s16 epp;
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
> > +		if (epp < 0)
> > +			goto skip_epp;
> > +		/* force the epp value to be zero for performance policy */
> > +		epp =3D 0;
> > +	} else {
> > +		/* Get BIOS pre-defined epp value */
> > +		epp =3D amd_pstate_get_epp(cpudata, value);
> > +		if (epp)
> > +			goto skip_epp;
> > +	}
> > +	/* Set initial EPP value */
> > +	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> > +		value &=3D ~GENMASK_ULL(31, 24);
> > +		value |=3D (u64)epp << 24;
> > +	}
> > +
> > +skip_epp:
> > +	WRITE_ONCE(cpudata->cppc_req_cached, value);
> > +	amd_pstate_set_epp(cpudata, epp);
> > +}
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
> > +	amd_pstate_epp_init(policy->cpu);
> > +
> > +	return 0;
> > +}
> > +
> > +static int amd_pstate_epp_verify_policy(struct cpufreq_policy_data
> > +*policy) {
> > +	cpufreq_verify_within_cpu_limits(policy);
> > +	pr_debug("policy_max =3D%d, policy_min=3D%d\n", policy->max, policy-
> >min);
> > +	return 0;
> > +}
> > +
> >  static struct cpufreq_driver amd_pstate_driver =3D {
> >  	.flags		=3D CPUFREQ_CONST_LOOPS |
> CPUFREQ_NEED_UPDATE_LIMITS,
> >  	.verify		=3D amd_pstate_verify,
> > @@ -628,8 +1040,20 @@ static struct cpufreq_driver amd_pstate_driver =
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
> >  	if (boot_cpu_data.x86_vendor !=3D X86_VENDOR_AMD) @@ -656,7
> +1080,8 @@
> > static int __init amd_pstate_init(void)
> >  	/* capability check */
> >  	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> >  		pr_debug("AMD CPPC MSR based functionality is
> supported\n");
> > -		amd_pstate_driver.adjust_perf =3D amd_pstate_adjust_perf;
> > +		if (cppc_state =3D=3D AMD_PSTATE_PASSIVE)
> > +			default_pstate_driver->adjust_perf =3D
> amd_pstate_adjust_perf;
> >  	} else {
> >  		pr_debug("AMD CPPC shared memory based functionality is
> supported\n");
> >  		static_call_update(amd_pstate_enable, cppc_enable); @@ -
> 664,17
> > +1089,21 @@ static int __init amd_pstate_init(void)
> >  		static_call_update(amd_pstate_update_perf,
> cppc_update_perf);
> >  	}
> >
> > +	cpudata =3D vzalloc(array_size(sizeof(void *), num_possible_cpus()));
> > +	if (!cpudata)
> > +		return -ENOMEM;
> > +	WRITE_ONCE(all_cpu_data, cpudata);
> > +
> >  	/* enable amd pstate feature */
> >  	ret =3D amd_pstate_enable(true);
> >  	if (ret) {
> > -		pr_err("failed to enable amd-pstate with return %d\n", ret);
> > +		pr_err("failed to enable with return %d\n", ret);
> >  		return ret;
> >  	}
> >
> > -	ret =3D cpufreq_register_driver(&amd_pstate_driver);
> > +	ret =3D cpufreq_register_driver(default_pstate_driver);
> >  	if (ret)
> > -		pr_err("failed to register amd_pstate_driver with
> return %d\n",
> > -		       ret);
> > +		pr_err("failed to register with return %d\n", ret);
> >
> >  	return ret;
> >  }
> > @@ -696,6 +1125,12 @@ static int __init amd_pstate_param(char *str)
> >  		if (cppc_state =3D=3D AMD_PSTATE_DISABLE)
> >  			pr_info("driver is explicitly disabled\n");
> >
> > +		if (cppc_state =3D=3D AMD_PSTATE_ACTIVE)
> > +			default_pstate_driver =3D &amd_pstate_epp_driver;
> > +
> > +		if (cppc_state =3D=3D AMD_PSTATE_PASSIVE)
> > +			default_pstate_driver =3D &amd_pstate_driver;
> > +
> >  		return 0;
> >  	}
> >
> > diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> > index 922d05a13902..fe1aef743c09 100644
> > --- a/include/linux/amd-pstate.h
> > +++ b/include/linux/amd-pstate.h
> > @@ -47,6 +47,10 @@ struct amd_aperf_mperf {
> >   * @prev: Last Aperf/Mperf/tsc count value read from register
> >   * @freq: current cpu frequency value
> >   * @boost_supported: check whether the Processor or SBIOS supports
> > boost mode
> > + * @epp_policy: Last saved policy used to set energy-performance
> > + preference
> > + * @epp_cached: Cached CPPC energy-performance preference value
> > + * @policy: Cpufreq policy value
> > + * @cppc_cap1_cached Cached MSR_AMD_CPPC_CAP1 register value
> >   *
> >   * The amd_cpudata is key private data for each CPU thread in AMD P-
> State, and
> >   * represents all the attributes and goals that AMD P-State requests a=
t
> runtime.
> > @@ -72,6 +76,12 @@ struct amd_cpudata {
> >
> >  	u64	freq;
> >  	bool	boost_supported;
> > +
> > +	/* EPP feature related attributes*/
> > +	s16	epp_policy;
> > +	s16	epp_cached;
> > +	u32	policy;
> > +	u64	cppc_cap1_cached;
> >  };
> >
> >  /**
> > --
> > 2.34.1
> >
