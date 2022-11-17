Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2ADD62D242
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 05:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234651AbiKQESg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 23:18:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239229AbiKQERy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 23:17:54 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE2E4FF93;
        Wed, 16 Nov 2022 20:17:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ji+ZhaSlJt/b3tfgcz4562+EIjLfqMtVXtFR3t15AuAVPLGT6zhGdyE0OXjnoOWzvCvREg66FTXxcZC7ilxP9BTB4cDr4Vb3463wtpH3yYy2WhmxEp1j66NjahwTanj6ON5eZ8EUV85mN98eZOQQQp/8X1a5/C9/hwYIr0E8LJCjGx/EhnA0XHRiF7eScfYNGR0cgpmbPZtgM2GKVQVKdEg6ttDrUI4v865lkuKMP2EmeURSeKr9jI/OlckzgxS5rl6gJW5OfXpGe57/Q02cD3lPrg8FEkbs236Npo0uNor/wc88RDjH7hhDBSXX/2kL1X4gUkAJTvcLtJaAisLdGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tszXFrr8A5A2Ong65O6PR2MEbzZFKJLdHU5EUBRFlII=;
 b=EinNBBDkTlqAxe0EhvcEiUTQFwRrjvuvmJ7lCZpo+UZ5nSZo7kKbhZUz1AsVQOwRyTFuuN3AfjOzO2H165HBnHxPkkXcY5Fl5ph9WBq+8FniGZSKuroeQ9il3cGc6QrJelI032ayFp7VLG+qO+zKTI+99pVpJINDPC3JUzXuzebKfQ2hhNMi89KPEiXgBwSr9ONNRSLRZSJOqpJF6mHh4SGDIqX4i0p7Dr3A5wZxruxrJplByMznHR8DGnewNoZxkqc+bJXhm1r1Hla+W9mmg5iWgZ4cdF6w9mHsIwhxNe+TgZoBxRa7yUBNVT/rKPivFppNkOGAV7fgrfBnabyYlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tszXFrr8A5A2Ong65O6PR2MEbzZFKJLdHU5EUBRFlII=;
 b=Th5K905HMCuIbleQXswYufoRWTaEI3sGDQqyy/5mJ+cQiV0myLSdr43LoGBzmPOQJfaMY0hQhDozP0992iVGW0Elrr3abI3S2eIZ45X60Fy9bHSG/OY+Cnlz6XTFAOpWA7tHmsnibKqt5+IUnPiKSVus2Tca87j15Pq8M2Sl6es=
Received: from DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17)
 by IA1PR12MB6260.namprd12.prod.outlook.com (2603:10b6:208:3e4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Thu, 17 Nov
 2022 04:17:50 +0000
Received: from DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::514f:bcdf:d10f:fedf]) by DM4PR12MB5278.namprd12.prod.outlook.com
 ([fe80::514f:bcdf:d10f:fedf%7]) with mapi id 15.20.5813.019; Thu, 17 Nov 2022
 04:17:50 +0000
From:   "Yuan, Perry" <Perry.Yuan@amd.com>
To:     "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>
CC:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "Narayan, Ananth" <Ananth.Narayan@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/5] Documentation: amd-pstate: add driver working mode
 introduction
Thread-Topic: [PATCH 4/5] Documentation: amd-pstate: add driver working mode
 introduction
Thread-Index: AQHY+i+eoRfua9Q0yki+a/hbazGuJq5CgjAAgAAAPGA=
Date:   Thu, 17 Nov 2022 04:17:50 +0000
Message-ID: <DM4PR12MB52786999360569BA8E50E1A49C069@DM4PR12MB5278.namprd12.prod.outlook.com>
References: <20221117024955.3319484-1-Perry.Yuan@amd.com>
 <20221117024955.3319484-5-Perry.Yuan@amd.com>
 <Y3W1eGfSQBsCASUG@BLR-5CG11610CF.amd.com>
In-Reply-To: <Y3W1eGfSQBsCASUG@BLR-5CG11610CF.amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-17T04:16:42Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=92ed9284-3b04-44e6-8bfb-20e20fac669d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-11-17T04:17:48Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 08e0f8ba-8be0-4e6d-9819-b261d043fec4
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5278:EE_|IA1PR12MB6260:EE_
x-ms-office365-filtering-correlation-id: e4142e30-471c-43f4-301e-08dac852b093
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1/IHahPMRAa5hN2gSIqz/UdIMvaVjIElOVkwFXqBBv5bZr+8t07HM2M1Yz7E72x+Dgl3QL3cKvY9mM9lgjUi9K90spVTceZ2mTBXae9xEgzjyRhmeDSnF+fHOQsQmz+kQikfXKcWrJG5/8zI+6CEl11iNSvVnOBGrnGagvLgn9YeMiYz5x3555AR6T0e6z3Jyd+qwUm5ixGh2XJ+BcFzuKg4JiOguEzv6XDIHPf18RzKWtTGXvdPOc7H8YnGUHgEBxIc/LS8+OhM4ggEHzfJE/AgRdo6iEs0gb8zw8cHMc5Q8NccTYoikVlOymMARLSepLGR05XwRqKfoW6H39whAxcxufhuL1Eg4TPA0QJpr6UaB4VFeIfqBS4ipgGB+6JbseXInKxKL6j+AkHtlvmEzBY0/mOCMIo03eF+gY1BTALNaAaEAz+CtiIwQ9YKBx6rJHej/tsxDu/Uaf0X8Nj47iwUf0TIoaZTX4+2PTkZPxdLioMR0hMXaio8ecbe/TLPDmKxmhD16dm0yD5AtU6NmJU0fP2KwGaqkbHRIXGQPRw4HW8QZKpJQhDQDiSO/1imwlGY8KGBUyWpWqY/ybvgJRYjKjAp61Rr29sokMVSSfGYsRzFTy48CoHOYBf1RgQOECmipFm6rKK5vreWbU/Bdh32xN9FDfqgwX7T6875yqlO8zWG6sz6k0JKZ3UkUDtfrJNIWuucSu9gmxuW3PtKPI/6y4O72Z2h75pNvTliWL8Mo01EnFkCyPodSBijOh+P9rDUsKMOyXrQOZv11IscXdh5t4vBTjYpowWsT5j9kMg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5278.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199015)(2906002)(41300700001)(52536014)(5660300002)(186003)(8936002)(55016003)(6862004)(33656002)(83380400001)(8676002)(122000001)(86362001)(64756008)(66946007)(66446008)(76116006)(6636002)(54906003)(38100700002)(316002)(38070700005)(53546011)(26005)(71200400001)(66556008)(6506007)(66476007)(7696005)(4326008)(9686003)(478600001)(473944003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rW/w6SZ+WTGX4VPQH/385/49/TDld6QHzGUaJz+n8w1Yk18fRtpLGnBDfqcJ?=
 =?us-ascii?Q?2d3ON6wc126sIi+Yo5cxRk6ZqRaee25ghpfjUfU2L+hXkqQrj2Anf5ZdsKVH?=
 =?us-ascii?Q?yYqFVTZ9/wu56rM/Q7kM7T6boJgGC0P8KYw6uS6QWehDAWwCZSf9NcblqQVF?=
 =?us-ascii?Q?hMGPoDuYdSfxGcgIMAUMfkGd6v9cbzAMRiauml9Mm+VcS8na/AXM7CAlLlo7?=
 =?us-ascii?Q?olavJh5ToCbrKkxmbe6YO2eZuC9ZpnahKfqhGi5n3GnoQtKB5jGZ49i2E5iZ?=
 =?us-ascii?Q?uMYoMpG+xe+FdbA5CTNT16ypi/WB/9pwL5rvqPVsb2yhtEdhOAG6bIZ8sAal?=
 =?us-ascii?Q?KKaR5ysmaz+JX/y/BDcRbTJjLuG6/n5vchaLwwZt9B+Sqf4FZdu4ePC+p9Fj?=
 =?us-ascii?Q?4ErcWlJMSg6I9qE2VjfQnjNXymk4OKG6QBBUk3k9VkFXaiptkYH//fyuHWFs?=
 =?us-ascii?Q?Y8JZdzaHA5ZOFTlauOslAdAiiYCpgTDzLhsJdDNDRIH/pKAAfZk9+KBAWrhe?=
 =?us-ascii?Q?9FHuWRmaje4CGGP4NLfgrpbEBMHJPsJ+4m5fOYDCvEifPUKB+Fxhyw/Io6gc?=
 =?us-ascii?Q?OH9/J7jzL39lNrc+agBWBDmtHL1kwhvKbGHtsZpjIag4A8g+35Vte64ALQ15?=
 =?us-ascii?Q?w7K3kyW5Hty7Br4Rj14jE7ZHjvZY7Pt7h9ftfZ0AGHyW+6iv5SQdqejRx9rW?=
 =?us-ascii?Q?QkDA1qf2/ngFRASj6t9EvQFCJvHe1i781GD2UXQvatrH0OFsJyAJMaN2p2k4?=
 =?us-ascii?Q?vRgdtu9JChuNn4K5B1at2vAm1cdZcj5zO0grajJColA1wBBGrF/sMvMRDTvk?=
 =?us-ascii?Q?Jhm0RvuvhTvYqQdvPlOnyNQeKeIxsltszEYlKV+w18yGJyVBrL72JFfZAfmK?=
 =?us-ascii?Q?uJ3IyS/PKwx6uVTFHMbrcce6FDGTcHeuxzFU7jMxr1l4hGFhpVGtU+j2fihc?=
 =?us-ascii?Q?dEjtJ2Gvr5k1zUK24Xv/paKJJicVDoPnRdkRYB1V2k65PP212pugonZ8IKoT?=
 =?us-ascii?Q?EoCoXpDlpn9Kv9OJfos9sds2c/80WHXdFE7VekPcxjhvAddPKkRuOJF7uWH1?=
 =?us-ascii?Q?wswH1l/yc2/o0HiqwME27KYkQbv1UArrFqGwRuxgfYvf8h+fLBAfLTU+G1b8?=
 =?us-ascii?Q?Owh53uf31EpHuHq9oKdGCey2mNTTT137sGy1JpBRl1Ip4HpFuFzjt1PQkl7N?=
 =?us-ascii?Q?QoJfgD68TR0xTmMB9i5De23iOFR/Ijy18GyTmR8tZy7wZf+vjevpSgHDGzz/?=
 =?us-ascii?Q?HNeEcDs/bALKKw9376FWHrMVttzJo2D8c2XVSmSQ66tZC1XNhd83fRX0+u9E?=
 =?us-ascii?Q?dSuL3R7xUYXTRlsvzO5g9wPPEtWK5eJsYkM3jJHd/O9DswuiV/Ing5Zld3YA?=
 =?us-ascii?Q?ujF7fBT9P3Z20MQ/7gQcYkxXnOTxnjahwyQbn1Qo0W/nvHLl1+mdKKHr6XPG?=
 =?us-ascii?Q?Pcs/14tMGwEOxNmZ54ig7koyJ5rRyXTwJWEYcsbYDVSyql/CXai9rpS5GZia?=
 =?us-ascii?Q?xNDdvikU+fsjU0bTaKXEAL7/lMZqBBO0m7H7nTZajpTqwErIan7t+xosO1vs?=
 =?us-ascii?Q?2R0pCTx/NhMjdIo9SfrCE6TS5adwtjfG429q1mTq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5278.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4142e30-471c-43f4-301e-08dac852b093
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2022 04:17:50.1031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nzYmU8D7X2zhla8PwCJnYme+bN6kQ8Ki8r1TEnFa/9sD/6kUzPTsDvSjQ0gEsoJO1UviqmHFo9fM6EL8KlJfww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6260
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

Hi Gautham

> -----Original Message-----
> From: Shenoy, Gautham Ranjal <gautham.shenoy@amd.com>
> Sent: Thursday, November 17, 2022 12:16 PM
> To: Yuan, Perry <Perry.Yuan@amd.com>
> Cc: rafael.j.wysocki@intel.com; Huang, Ray <Ray.Huang@amd.com>;
> viresh.kumar@linaro.org; Limonciello, Mario <Mario.Limonciello@amd.com>;
> Fontenot, Nathan <Nathan.Fontenot@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Sharma, Deepak
> <Deepak.Sharma@amd.com>; Huang, Shimmer
> <Shimmer.Huang@amd.com>; Meng, Li (Jassmine) <Li.Meng@amd.com>;
> Du, Xiaojian <Xiaojian.Du@amd.com>; Karny, Wyes
> <Wyes.Karny@amd.com>; Narayan, Ananth <Ananth.Narayan@amd.com>;
> linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 4/5] Documentation: amd-pstate: add driver working
> mode introduction
>=20
> Hello Perry,
>=20
> On Thu, Nov 17, 2022 at 10:49:54AM +0800, Perry Yuan wrote:
> > Introduce the `amd-pstate` driver new working mode with
> > `amd-pstate=3Dpassive` added to kernel command line.
>=20
> It should be `amd_pstate=3Dpassive` here to be consistent with the early
> parameter and the rest of the documentation.

Thank you help to review,
Will fix  this with V2

Perry.

>=20
>=20
> > If there is no passive mode enabled by user, amd-pstate driver will be
> > disabled by default for now.
> >
> > Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> > ---
> >  Documentation/admin-guide/pm/amd-pstate.rst | 30
> > +++++++++------------
> >  1 file changed, 13 insertions(+), 17 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/pm/amd-pstate.rst
> > b/Documentation/admin-guide/pm/amd-pstate.rst
> > index 8f3d30c5a0d8..06e23538f79c 100644
> > --- a/Documentation/admin-guide/pm/amd-pstate.rst
> > +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> > @@ -283,23 +283,19 @@ efficiency frequency management method on
> AMD processors.
> >  Kernel Module Options for ``amd-pstate``
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > -.. _shared_mem:
> > -
> > -``shared_mem``
> > -Use a module param (shared_mem) to enable related processors
> manually
> > with -**amd_pstate.shared_mem=3D1**.
> > -Due to the performance issue on the processors with `Shared Memory
> > Support -<perf_cap_>`_, we disable it presently and will re-enable
> > this by default -once we address performance issue with this solution.
> > -
> > -To check whether the current processor is using `Full MSR Support
> > <perf_cap_>`_ -or `Shared Memory Support <perf_cap_>`_ : ::
> > -
> > -  ray@hr-test1:~$ lscpu | grep cppc
> > -  Flags:                           fpu vme de pse tsc msr pae mce cx8 =
apic sep mtrr pge
> mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_op=
t
> pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid
> extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16 sse4_1
> sse4_2 x2apic movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy
> svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skini=
t
> wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb cat_=
l3
> cdp_l3 hw_pstate ssbd mba ibrs ibpb stibp vmmcall fsgsbase bmi1 avx2 smep
> bmi2 erms invpcid cqm rdt_a rdseed adx smap clflushopt clwb sha_ni
> xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total
> cqm_mbm_local clzero irperf xsaveerptr rdpru wbnoinvd cppc arat npt lbrv
> svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists
> pausefilter pfthreshold avic v_vmsave_vmload vgif v_spec_ctrl umip pku
> ospke vaes vpclmulqdq rdpid overflow_recov succor smca fsrm
> > -
> > -If the CPU flags have ``cppc``, then this processor supports `Full
> > MSR Support -<perf_cap_>`_. Otherwise, it supports `Shared Memory
> Support <perf_cap_>`_.
> > +Passive Mode
> > +------------
> > +
> > +``amd_pstate=3Dpassive``
> > +
> > +It will be enabled if the ``amd_pstate=3Dpassive`` is passed to the ke=
rnel in
> the command line.
> > +In this mode, ``amd_pstate`` driver software specifies a desired QoS
> > +target in the CPPC performance scale as a relative number. This can
> > +be expressed as percentage of nominal performance (infrastructure
> > +max). Below the nominal sustained performance level, desired
> > +performance expresses the average performance level of the processor
> > +subject to the Performance Reduction Tolerance register. Above the
> > +nominal performance level, processor must provide at least nominal
> performance requested and go higher if current operating conditions allow=
.
>=20
> Otherwise looks good to me.
>=20
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
>=20
> --
> Thanks and Regards
> gautham.
