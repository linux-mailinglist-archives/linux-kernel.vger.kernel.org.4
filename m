Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E0C64E2D2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 22:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiLOVLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 16:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiLOVKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 16:10:48 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A03013E2F;
        Thu, 15 Dec 2022 13:10:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZmpY8kAm4pxZkDjTYtiLPuIRRLgcyingP40R79+0YaOFtXuumrwhQdPOXHD+n0vEzCShHx7d9nZEZbUhXVVsSHp3pGnNnViBN7A1pnNJUaHBUHxCIDeRq7MOFFp4qmPqqqsXNepONytYWATWXgu1FQuVmXvEMmR+pOaiExSuX4lVXglZQmDVuWz5TkgDd+QQ9x3XI0I0mb9/WA2/6GN5HJPyaP/glBe1P58/NxA2fu78sZOXkSaV17awT8JlP6tucnQMbZb55ksO0Arpy+OpHscyQ7rmwgzS5HvDXaqrDaK85HtmIsetBOFjFbDrheSqGrfR+dHYS2YrMoovWV2YJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LSXi770/GjyOw43BxDUavRwcDDAD0JZSDP+xtJoYcUU=;
 b=Rtr0UoMWt99zKRfI4J8jNzG7ysWyRorW+BB7Px4vOZlz3E+OMUUnA0M44gq9dGeKJQs70x9Y0iIBG9qYHrZJ1LPk5vZGH9C6qE4B+rNU1xGNJLVSduw8imnefP6O+aFBzKsRB+74QmqpHw9qonlOZoA9SyofnTTS/rTae0jiG7tSM7CVYWHAfXKzKdohPFKafXoV+KSvv16k5Wh47CxKRbaqUA3jimyZifWnQiBW2TliqVwXDrK03KCHV6PstSvsFFN9I932IcMlkugprUzMDwdJwaj0vMJUZdAPwxrQ2tQ4rwUEfMheR59oO+jTrTUbfJfkc3M6IuEaFJ6hfPv/Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSXi770/GjyOw43BxDUavRwcDDAD0JZSDP+xtJoYcUU=;
 b=z8ifQ6XND95m6fOYTzR91+EkvxJujqc0YPmbfh+TNCeXzD4/9n2xb8/+hwfzdqnhrwf9JVOF31p0JLT/VSy+xSRTcSt+moVcrYOCNumtgKRma2SEoR/0VUhbTF4dMmYcE7zFjlw2qiFm2BuUPOOW6lNZBEDzDdpA4KkDuHGXxsw=
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MW4PR12MB6874.namprd12.prod.outlook.com (2603:10b6:303:20b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Thu, 15 Dec
 2022 21:10:43 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098%5]) with mapi id 15.20.5880.019; Thu, 15 Dec 2022
 21:10:42 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>
CC:     "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "chang.seok.bae@intel.com" <chang.seok.bae@intel.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "Das1, Sandipan" <Sandipan.Das@amd.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "eranian@google.com" <eranian@google.com>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "quic_jiles@quicinc.com" <quic_jiles@quicinc.com>,
        "peternewman@google.com" <peternewman@google.com>
Subject: RE: [PATCH v9 01/13] x86/cpufeatures: Add Slow Memory Bandwidth
 Allocation feature flag
Thread-Topic: [PATCH v9 01/13] x86/cpufeatures: Add Slow Memory Bandwidth
 Allocation feature flag
Thread-Index: AQHZBZqjQ+biHwSnXE+6vehVSZpIjq5vRJUAgABDViA=
Date:   Thu, 15 Dec 2022 21:10:42 +0000
Message-ID: <MW3PR12MB45535221CCD8CA3BCBB06ABB95E19@MW3PR12MB4553.namprd12.prod.outlook.com>
References: <166990882621.17806.16780480657453071426.stgit@bmoger-ubuntu>
 <166990896023.17806.9274990355490405865.stgit@bmoger-ubuntu>
 <8b6b0e74-3af6-b5ba-8496-eb0614c9f148@intel.com>
In-Reply-To: <8b6b0e74-3af6-b5ba-8496-eb0614c9f148@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-12-15T21:09:48Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=75fe0fb6-fdec-41f3-ba77-268e6f5eb3c6;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-12-15T21:10:41Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 91b5c02e-01ce-4787-870e-8f50a237a178
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4553:EE_|MW4PR12MB6874:EE_
x-ms-office365-filtering-correlation-id: cf944b44-d85f-4dc1-1e83-08dadee0d36e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h4aYWLWGgUePV/v+2sKtAD4VzCPL4aajaMty21ltr8rLwd3/8oW4+HhwEVAakdjn41SPHzU0WZAZUPxQXOjacoQ4olpVq7s2xYWAbzuNV0ZMevp/eLdWIomQ+8loKpIHL8rXbMPJHcT/rnURPDs2DjHt2KbUB/ksksl8fI37JTuVyvjr3ABWunTzV9D/ICNW7U0VFz04K5jQaBevuzUF73+pVoPcJMQdCugzK4ULa6j1EkQdDv6fJBnBk92X9jVGgFBx1ZPcL9UfDmYVtUHAVF+u32l5Ti0mySIUryFIj3rJq1ThF0pLOWwVUalzfuEaMZLftwmVJnN2c+eLO0a1GvF12jgAwztCVns+RVgCNUcKS3oDoRvG9urY3dPN/JLHb1foCRZzhNxFTYYLyUAtiB5pWyC9fj2QJGkUFJ8ximXKGoI40iS3Cibsmi0XH2nzAmoalC/VsyeKrN41J+4Sdr54krijAzRXOJErce0He6uMGy9sYIAP66GUPpH2jx/LTfIrwi7GPQLGA9kWRxdwBtvwpHvJYFSg06elfHX8WZDeJ3XA7RiHw9iEJOn51yEmSz/wfWK3srawC30DpEE1uBuQKsNZ5XDs9QMOepB86RBycXALMzPcyw/kVfmkHAJBea2flDbu3akmRTUKe64GJomRmZeUBFAqHf3s9k3zJLy6eVmXZJDwUbU8ZnPO8Y6AxsKVcImWuV9UswFn+1xN1moaRImsnrns91SsDxeaipjusCYnQl+4CxnOwT/hvpKH/vpOd1EbEQ8DRKmEAKl9yg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(451199015)(26005)(966005)(478600001)(6506007)(7696005)(2906002)(38070700005)(53546011)(55016003)(45080400002)(9686003)(186003)(71200400001)(86362001)(33656002)(110136005)(38100700002)(83380400001)(316002)(64756008)(7416002)(66446008)(76116006)(66476007)(66556008)(7406005)(54906003)(66946007)(8676002)(4326008)(8936002)(122000001)(52536014)(41300700001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sHUa+3J0kT4xM8IGDjBWyg1UcZYyuK6++c4UblX5Fq05SrPUF8r0lDpk8rY5?=
 =?us-ascii?Q?pp6sD1k+wwUfBaXE/dmYZ6UkHMSDxfuA/IQjR93s0vtvJxagsM/wO4rXuXzY?=
 =?us-ascii?Q?C0FPWniG8/mUbfTmcCcIfmy73Gd9TJPj32VKjtNKL0HrrOgtEgA4WKJnywcB?=
 =?us-ascii?Q?u3Sd/z5O+ZEqRoEo8LGq6T0sjvfYET6ME58Yd8uSiRbGXuUSgpf3vYdPZtbk?=
 =?us-ascii?Q?tbRM0uBgTjwI7Iv/wiJK+Do8HVsRlilkivE8wsoDFv9JahYCTljPzwXPsNRJ?=
 =?us-ascii?Q?dPnjSvhI3z6nAhBmFcKl3bStwnvrL6Ddd7ob53Iw8UMtppLunfUaZGFRhpaS?=
 =?us-ascii?Q?VG2bqDykdiMarn22gPxuaf7rNM26kgGsZ3P5wXX7ZNUeaxUOvcFIXYvBHK2m?=
 =?us-ascii?Q?bPZDkaTZN0eBKoFAqxxDxoL+7j4rzASBQjiSOnd1q+UV/+qaYLKNYAnubiEV?=
 =?us-ascii?Q?wZj6p55e4qvYv3aV3R9mVQARG2uT68xcBw+ksZYu/1J57mWcNNpzTnL3dN6Y?=
 =?us-ascii?Q?t45kvAJY5DDtve9UDZhrwZAz/1+ul7roKLHmjw27z96cstUbf3cjkj3SQcfB?=
 =?us-ascii?Q?B6Z56CK7qYzpcsHPDXbYKYHfu0uKXkAKxfiethZnk9LlpKvXkKC7eNsfJXk0?=
 =?us-ascii?Q?ef79Q40tou5QsFCX81gHnPZQEmbyPOrF7gaxMRxutxG3f2oEShRIitc5W341?=
 =?us-ascii?Q?huLHXrOGP2v85jbNapE+vToZRJeMoSN9Fg84KgQhZEGU8RfCBawtRT06RoRk?=
 =?us-ascii?Q?0PaGz/TQETDC+hEU6uCCV1ZJouYX9Yp/nLbpRCCCmSkgYi25SeMjMgDdxqsv?=
 =?us-ascii?Q?xUBx1vQWyKIRChY4uUwZOr5bvmY+KcbcTKU4aq/7hBp6y9fkzrIHFcrbSe8U?=
 =?us-ascii?Q?Yz0Ni8fvgDKtQ6gq2wv22nHZEIgtY8rNDucJL8Qd6R0MVOzhx2GojBqQJmyc?=
 =?us-ascii?Q?/VpOdDnZLvw6EYe/tVTlFfmh1bBB86IWbVHeS/hUgaIjIuz6hjHU7pVQt+iC?=
 =?us-ascii?Q?SaRupJH4hf8UWbcWKTJWcl0wZfYDkWbd7ppfjE1oAfXMDmgX2Vfyau84OO2y?=
 =?us-ascii?Q?wc0+mf7y1O/lbFZ0Wdt/fd/pzPYyEH1AhiKJ/q4TltVGN3/FjBUQmxKnuwtU?=
 =?us-ascii?Q?aE3WKU42n2+H83i/r93R2N5caezuy5vWmOW/BX9EvWY1e3+cMZjg71309Vc/?=
 =?us-ascii?Q?WcOeluj/LTyT1VwzE98rsJy+BVWsUUcGJh3ihnlwsmy8/FoMTfVR/MYkQrJD?=
 =?us-ascii?Q?xVBYqAHdSk+xXEtLidyFEQ0q37qDExkxEBb4HfL7t0RL2dj3Fgd9VbAaO8P6?=
 =?us-ascii?Q?r5gOcBVjIoQPIWP4hFinGuHhBVcDSkailvtHX5rPrLL0fqTnaT3ABneaAr8+?=
 =?us-ascii?Q?mLPMpIXa05w1mTx4USKiCoKhXbGBAC0Aff9ijr61wLt+yYJUzDXkPoHdoOOQ?=
 =?us-ascii?Q?E8GnqXYqPb9tTQQf35Igw+vfYj329ELdqdbKHP538TkfIkBtdT9BP2uwdjam?=
 =?us-ascii?Q?hJCtfAWuhoJU4xH50vf4LoUkAzZQQdMuVNiYrMKQs/CdA6uf4cGsKBfWYPWA?=
 =?us-ascii?Q?3t/PZufyCn7bzJD7/WM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf944b44-d85f-4dc1-1e83-08dadee0d36e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2022 21:10:42.7127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: haWsp9rET70q29KwaF7WIIfgIVBtTKLBJnXN13lxojlA6eczFt5xQ1sHPmx4EhiO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6874
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

Hi Reinette,

> -----Original Message-----
> From: Reinette Chatre <reinette.chatre@intel.com>
> Sent: Thursday, December 15, 2022 11:09 AM
> To: Moger, Babu <Babu.Moger@amd.com>; corbet@lwn.net;
> tglx@linutronix.de; mingo@redhat.com; bp@alien8.de
> Cc: fenghua.yu@intel.com; dave.hansen@linux.intel.com; x86@kernel.org;
> hpa@zytor.com; paulmck@kernel.org; akpm@linux-foundation.org;
> quic_neeraju@quicinc.com; rdunlap@infradead.org;
> damien.lemoal@opensource.wdc.com; songmuchun@bytedance.com;
> peterz@infradead.org; jpoimboe@kernel.org; pbonzini@redhat.com;
> chang.seok.bae@intel.com; pawan.kumar.gupta@linux.intel.com;
> jmattson@google.com; daniel.sneddon@linux.intel.com; Das1, Sandipan
> <Sandipan.Das@amd.com>; tony.luck@intel.com; james.morse@arm.com;
> linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org;
> bagasdotme@gmail.com; eranian@google.com; christophe.leroy@csgroup.eu;
> jarkko@kernel.org; adrian.hunter@intel.com; quic_jiles@quicinc.com;
> peternewman@google.com
> Subject: Re: [PATCH v9 01/13] x86/cpufeatures: Add Slow Memory Bandwidth
> Allocation feature flag
>=20
> Hi Babu,
>=20
> On 12/1/2022 7:36 AM, Babu Moger wrote:
> > Add the new AMD feature X86_FEATURE_SMBA. With this feature, the QOS
> > enforcement policies can be applied to external slow memory connected
> > to the host. QOS enforcement is accomplished by assigning a Class Of
> > Service (COS) to a processor and specifying allocations or limits for
> > that COS for each resource to be allocated.
> >
> > This feature is identified by the CPUID Function 8000_0020_EBX_x0.
> >
> > CPUID Fn8000_0020_EBX_x0 AMD Bandwidth Enforcement Feature
> Identifiers
> > (ECX=3D0)
> >
> > Bits    Field Name      Description
> > 2       L3SBE           L3 external slow memory bandwidth enforcement
> >
> > CXL.memory is the only supported "slow" memory device. With the
> > support of SMBA feature, the hardware enables bandwidth allocation on
> > the slow memory devices. If there are multiple slow memory devices in
> > the system, then the throttling logic groups all the slow sources
> > together and applies the limit on them as a whole.
> >
> > The presence of the SMBA feature(with CXL.memory) is independent of
> > whether slow memory device is actually present in the system. If there
> > is no slow memory in the system, then setting a SMBA limit will have
> > no impact on the performance of the system.
> >
> > Presence of CXL memory can be identified by numactl command.
> >
> > $numactl -H
> > available: 2 nodes (0-1)
> > node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 node 0 size:
> > 63678 MB node 0 free: 59542 MB node 1 cpus:
> > node 1 size: 16122 MB
> > node 1 free: 15627 MB
> > node distances:
> > node   0   1
> >    0:  10  50
> >    1:  50  10
> >
> > CPU list for CXL memory will be empty. The cpu-cxl node distance is
> > greater than cpu-to-cpu distances. Node 1 has the CXL memory in this
> > case. CXL memory can also be identified using ACPI SRAT table and
> > memory maps.
> >
> > Feature description is available in the specification, "AMD64
> > Technology Platform Quality of Service Extensions, Revision: 1.03
> > Publication # 56375 Revision: 1.03 Issue Date: February 2022".
> >
> > Link:
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww=
.
> > amd.com%2Fen%2Fsupport%2Ftech-docs%2Famd64-technology-platform-
> quality
> > -service-
> extensions&amp;data=3D05%7C01%7Cbabu.moger%40amd.com%7Cb03ef091
> >
> f14847baced108dadebfaa5a%7C3dd8961fe4884e608e11a82d994e183d%7C0%
> 7C0%7C
> >
> 638067212053430832%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
> AiLCJQIjo
> >
> iV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdat
> a=3DHF%2
> > BYN5rW5i8fw6588RXfgCKMSMF4EmZZ252Q0N7Mew0%3D&amp;reserved=3D0
> > Link:
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fbug=
z
> >
> illa.kernel.org%2Fshow_bug.cgi%3Fid%3D206537&amp;data=3D05%7C01%7Cbab
> u.m
> >
> oger%40amd.com%7Cb03ef091f14847baced108dadebfaa5a%7C3dd8961fe488
> 4e608e
> >
> 11a82d994e183d%7C0%7C0%7C638067212053430832%7CUnknown%7CTWFpb
> GZsb3d8ey
> >
> JWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
> C300
> >
> 0%7C%7C%7C&amp;sdata=3DIm%2BiT7NDUpcgR0dAYFDJALge6Wf873MNLyntsyC
> MwlQ%3D&
> > amp;reserved=3D0
> > Signed-off-by: Babu Moger <babu.moger@amd.com>
>=20
> According to "Ordering of commit tags" in Documentation/process/maintaine=
r-
> tip.rst
> the "Link:" tags should be after "Signed-off-by:". Could you please re-or=
der
> these to ensure this series is ready for the next stage?

Sure. Will change it.

>=20
> > ---
> >  arch/x86/include/asm/cpufeatures.h |    1 +
> >  arch/x86/kernel/cpu/scattered.c    |    1 +
> >  2 files changed, 2 insertions(+)
> >
> > diff --git a/arch/x86/include/asm/cpufeatures.h
> > b/arch/x86/include/asm/cpufeatures.h
> > index 11a0e06362e4..b6a45e56cd0c 100644
> > --- a/arch/x86/include/asm/cpufeatures.h
> > +++ b/arch/x86/include/asm/cpufeatures.h
> > @@ -307,6 +307,7 @@
> >  #define X86_FEATURE_SGX_EDECCSSA	(11*32+18) /* "" SGX
> EDECCSSA user leaf function */
> >  #define X86_FEATURE_CALL_DEPTH		(11*32+19) /* "" Call depth
> tracking for RSB stuffing */
> >  #define X86_FEATURE_MSR_TSX_CTRL	(11*32+20) /* "" MSR
> IA32_TSX_CTRL (Intel) implemented */
> > +#define X86_FEATURE_SMBA		(11*32+21) /* Slow Memory
> Bandwidth Allocation */
> >
> >  /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12=
 */
> >  #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI
> instructions */
> > diff --git a/arch/x86/kernel/cpu/scattered.c
> > b/arch/x86/kernel/cpu/scattered.c index f53944fb8f7f..d925753084fb
> > 100644
> > --- a/arch/x86/kernel/cpu/scattered.c
> > +++ b/arch/x86/kernel/cpu/scattered.c
> > @@ -45,6 +45,7 @@ static const struct cpuid_bit cpuid_bits[] =3D {
> >  	{ X86_FEATURE_CPB,		CPUID_EDX,  9, 0x80000007, 0 },
> >  	{ X86_FEATURE_PROC_FEEDBACK,    CPUID_EDX, 11, 0x80000007, 0 },
> >  	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },
> > +	{ X86_FEATURE_SMBA,		CPUID_EBX,  2, 0x80000020, 0 },
> >  	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
> >  	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },
> >  	{ 0, 0, 0, 0, 0 }
> >
> >
>=20
> With the tag ordering addressed:
>=20
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Thanks
Babu
>=20
> Thank you
>=20
> Reinette
