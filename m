Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14595BB35C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 22:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiIPUUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 16:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiIPUUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 16:20:00 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2056.outbound.protection.outlook.com [40.107.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69AB13AB02;
        Fri, 16 Sep 2022 13:19:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SscHup6WkSBkUat6fLIhXO+EvyH3N6bj+oAU5+8xmZBQWA/kmRgBDrELXuOt+4913BVS5i4RxUXeYncyYlq/d7GKlB/Uu8Kvv+8kfp/aQukkNOJplmXpB46cF/0faPG3G6V+bwAtQcrK7+lEU4dc7vtVS8IfYAeL36HgJDGkGBnj+fRCq288lB4pIL1CVeLCdVIzf4lPrCagugxpnu2kytDWrz//oL9Ez8cntytpTsPGcdFJEMKvsI+Ogt7XrScUDRxZbyWCMwEybaT1PZk+ItEmPpPJvouL0mdV5cmHC/qayJSNQXkTLYgudq4ls6kx1C0R8uQy+fQq9C9fUzX/aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X4vF4D5BtQikEX7x2gGl6qS4HnSZOUTnGAPr8iihahA=;
 b=BosjRbbMthaeKs+o5eeZujFVRmol0laKUkzV3rx5Bz1lLKbiJaQYQTNgB5aQLjJDZLRHrL6V549Zdkl7yRaLR65DWw6hMijRwvwOgzNPPnl84fZwWKAx8eA9loyShkgxIx6Qw3H1v3h8BYu+OSFOJSDRocQxGeG6Qis286bJME/3I4iAyBIavZqOpFw7a/okVVkKkUMp3ePnQheA7vBr5sjI8NTnUSn80ZiTvIib/Eny+2Xt1EIOMx4bNtdJxqMBt348CDTz/28CbQYxDE1TIJ1tVE3Vr9Lh4dDqAwZrVsGAvPIf/77fPCnFERk7DqSLOSRGVBqDbT7u044SO2nwYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4vF4D5BtQikEX7x2gGl6qS4HnSZOUTnGAPr8iihahA=;
 b=nTpKRbV1d8oFvKBmoU3h1T/s0HFZUT4i/LpSTsO0J8KuID652H+hzchSPcznR9IMd4Lv3oDli7GigUcKBtkmQKzaW7t6cpHGLtN3SnjXkgYgW528SERPClnYMIWXCdGRMOxt5Cn3S7sluDrDqjrfbNzpimbBWJLxzzXqixjyzr8=
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA0PR12MB4511.namprd12.prod.outlook.com (2603:10b6:806:95::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16; Fri, 16 Sep
 2022 20:19:54 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::4120:60cf:46a8:7109]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::4120:60cf:46a8:7109%7]) with mapi id 15.20.5632.016; Fri, 16 Sep 2022
 20:19:54 +0000
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
        "eranian@google.com" <eranian@google.com>
Subject: RE: [PATCH v4 05/13] x86/cpufeatures: Add Bandwidth Monitoring Event
 Configuration feature flag
Thread-Topic: [PATCH v4 05/13] x86/cpufeatures: Add Bandwidth Monitoring Event
 Configuration feature flag
Thread-Index: AQHYwuO8ya9oGi6BY0+vRVJsZNeh463iQ6KAgABJOkA=
Date:   Fri, 16 Sep 2022 20:19:54 +0000
Message-ID: <MW3PR12MB45536DBD37AF763C642DF39695489@MW3PR12MB4553.namprd12.prod.outlook.com>
References: <166257348081.1043018.11227924488792315932.stgit@bmoger-ubuntu>
 <166257363444.1043018.17384356050516925226.stgit@bmoger-ubuntu>
 <c4a9ea23-4280-d54c-263b-354ea321f746@intel.com>
In-Reply-To: <c4a9ea23-4280-d54c-263b-354ea321f746@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-16T20:17:19Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=0e28819a-f30e-4178-88ce-9df133afacf4;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-09-16T20:19:52Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: ad17f8bf-c93f-4f36-8925-1c42183bae2a
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4553:EE_|SA0PR12MB4511:EE_
x-ms-office365-filtering-correlation-id: 6659e38d-f67f-4507-7426-08da9820d182
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZtN78YDi3mzJOkfkCVWHOfl8A57e25BSy9teX1VJbcw5aSOmg57f+q4vME2vYvWWQPsz5InNYQ7sVwhxr9bn3vOWIiCXD7OUvwa5qsLTMxDDc5GIpn+FEOSw5N5jRbJC5jp82pZxrstfJJZH3eEzIpluyG/LBXBp6Dfsv3HizzWXLRGePyMSjWvxywItC72zOKLJozdzK3LDQYAaIrwzWXdvbBxFlcyvm4Ck6sPNipDihJwwVP3N3IjVs027Bf6DwdqsW+qldpJzv2t5uUEbKh7BpXJFXoFIAi5lCO5sWsKYvGtV9UJWkzsBdkBHBM9bzU8pakjN/ayjg4gZFBbqTAQNq9zSmW5VrWUcKz185fvvCBp5XNQvi5TztmhUnX7C1uoeLKHugtY7yXwo8Yo5xcchEPI0Fj6E69Lz1y7pz6ju6dIv28a+O4QBcR/uQEz8mX/eJ1GfSzZNXJZTZ/EQQ0YTADqtTzzuHq5vhHgXV2pwJXNjMLgtzl19Rmjdty+B5eXgI9oTbD6ycmWufrG+zucSx0YlpWWa77qg5Mq8d7TcdjuNWRP+efMkvrgEFSAdVD/ssM8YFEIrAwiZO7mi3B2Zir46TW1B0fLJUIdJtgtvLNg60Aw2reA/eDTKRtkpD2/UKsdn2jy80o06KiDZwnnG+5r9uiyiYNdGtRChkA41jdVG06HmLtxZcQcOIHyFV4ivBWSDUhzq08p4aJhWtzfUacRlMtRFG36d9e4sDodWhl7fnhMw5ju1U8WSbsfjMZxVlaY9LXSTeMPOA0xpti6kTihWBSePBsDap6L5E4DDrbr61ekID7lzUiamfS4syD1jSPY1u2vwYwmebxSruA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(451199015)(186003)(83380400001)(38100700002)(122000001)(38070700005)(7416002)(71200400001)(5660300002)(8936002)(41300700001)(2906002)(52536014)(55016003)(478600001)(26005)(66946007)(6506007)(7696005)(53546011)(9686003)(966005)(8676002)(64756008)(66446008)(66476007)(66556008)(76116006)(54906003)(45080400002)(316002)(110136005)(33656002)(86362001)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?G9Ky/XJIjOYJ2owqmDBaYg/oG9tBCLZSjGBH7FDDnY2S6EtF7Y21BCrhQnSq?=
 =?us-ascii?Q?OD+FY1aD2zZOONbRTdR2UyDbPfjMN7NqWmUF4vsy0T9BO8dxDpQVuWOpWYVF?=
 =?us-ascii?Q?j5duMAEHp8a6OH6dJIJWXCaRBePS2Z5Bc9h3ZwhK2R+zU4yL1XNg0XxBNp77?=
 =?us-ascii?Q?XHo45ZMGZW3PrM0c8yMM9l7H9BM/XrCQGnWgKVHV8Zg1qDUK+qj9B57gSEip?=
 =?us-ascii?Q?y0hF0Q4cZKQQofFJ681v4RknRu8XO9P8jJsaPuxIpKwqv6prL6JET+QCngFH?=
 =?us-ascii?Q?hq6vhfMlyBsrY5yvCdw/5yT+dzBTrbHF+fZn8qCGLvQT0k+y++TfTHMUiN7H?=
 =?us-ascii?Q?oRy4wbXimRUC+9+9hA3+Jgte4YEDsHzKif5dVp32WXrGKR/rHROV1Fjtp4vt?=
 =?us-ascii?Q?h7rADZjFXucR59wq5S5LAeRW2k6cxFWE158Flz3g6YDags6TTjX2yy7wGhO8?=
 =?us-ascii?Q?Ci6q0Is/hPflYd0qKpD4GmVa7+Rh1NT4fu8CU2p5lMMhMQF9ftVTekxb8ZVG?=
 =?us-ascii?Q?dH1FhuXKH5SPIMqB5w790PCqAabloSw4aYglaRxvyRzPKRCFGh7NTor1QzLX?=
 =?us-ascii?Q?WJU5ieXpcdb+YAeoCOtUKQinMdYWBuOvFfQoU3S1vvRdN3sO/NKyXdpba61H?=
 =?us-ascii?Q?Jmg+3xFjMGH9qd7gmnaMErRXL2TpfKvesqUh7O/OFnMiI5MJfae4ebQKchI/?=
 =?us-ascii?Q?WEKIAGWkPJG6oqO8+B+ij5PByX0C1ADxWz5uIXA5QrioK7PaisDOmavR6HDp?=
 =?us-ascii?Q?ySt0v6hCaKXkGrKySfz8914/wzeh8A1l35pv9dBPBL6N8G2Qg4iMFW4A2ElR?=
 =?us-ascii?Q?HbaHLlqfzLsF5DMBmkM+hVGXjyUvy6Uv3ny12v+eHAFdlTBm3ZiEVKC37YKn?=
 =?us-ascii?Q?btQ9m4kX2Y65mhoLqCl4e9U0NJgxPeqWim731R5SHEFSRTVtIx509ILoQi0k?=
 =?us-ascii?Q?SaIuCvmW4uCZ9X7nzOJGYC6ZiBU27/mI9jHZDWPxBACdvj4phY/NWvWKN5Wo?=
 =?us-ascii?Q?HqdmAMSQheen43nteDcgZSbo6IMUdSYzIQJsW4O6RNBwOah4Nd67ZbvsflzG?=
 =?us-ascii?Q?O+sRXmU5XYS5GlOfNSClUG9j/hB27n1lTzIh2rXbIwVzjEZnpfQhjJkga2bL?=
 =?us-ascii?Q?4tWpozSnvY7rzA5NV88KLmrPoTivbB4UtC4jII+68TUWOseiB4IWQRu1nZFd?=
 =?us-ascii?Q?bIWfHhU2TCISNh/9oQp53i5SX8jhfQQAJiVDES2CqEJH5OVwVuLGWT8P+YZU?=
 =?us-ascii?Q?lTusE5XccnRmFQnsTO+Cgtk/qofrq0Dvwe//lMU0zUlZzBM+1SPff7ftKRLe?=
 =?us-ascii?Q?BIUxyfgftBt6eABKgXn0yn+Ael6ihs8JvCuQAtpIXNqWfzeEoRV3r9WxfSfC?=
 =?us-ascii?Q?ZmrZ7J5W2dkb4+9GJeB8JTLscuETZgIy5pO71kROI7iVXN8juIOTuGWWchCX?=
 =?us-ascii?Q?TIeP/IZ57izjKkRVBTjV70eoHVYCRb85IZ6uHi+oCc58RS04Mc55jvkRNupM?=
 =?us-ascii?Q?spC9i0y9t+cQtginxGhWW1lQtcZ2A/DYu7TT12EFau2+9t3HtgKhIusB9AAt?=
 =?us-ascii?Q?Af+Yo1/gSi+5J+qquuc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6659e38d-f67f-4507-7426-08da9820d182
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2022 20:19:54.7397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c8LbOYGLH11Cp9KjnRFGqHgu8bPvLd7h/QTxSCdWn1OP0QJYlSBBHh+M6Y2j2MBj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4511
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
> Sent: Friday, September 16, 2022 10:55 AM
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
> bagasdotme@gmail.com; eranian@google.com
> Subject: Re: [PATCH v4 05/13] x86/cpufeatures: Add Bandwidth Monitoring
> Event Configuration feature flag
>=20
> Hi Babu,
>=20
> On 9/7/2022 11:00 AM, Babu Moger wrote:
> > Newer AMD processors support the new feature Bandwidth Monitoring
> > Event Configuration (BMEC).
> >
> > Support of this feature is available via CPUID Fn8000_0020_EBX_x0 (ECX=
=3D0).
> > Bits    Field Name       Description
> > 3        EVT_CFG         Bandwidth Monitoring Event Configuration (BMEC=
)
> >
> > Currently, the bandwidth monitoring events mbm_total_bytes and
> > mbm_local_bytes are set to count all the total and local reads/writes
> > respectively. With the introduction of SLOW memory, the two counters
> > are
>=20
> Why is SLOW in caps?

Will fix it.
>=20
> > not enough to count all the different types of memory events. With the
> > feature BMEC, the users have the option to configure mbm_total_bytes
> > and mbm_local_bytes to count the specific type of events.
> >
> > Each BMEC event has a configuration MSR, QOS_EVT_CFG (0x000_0400h +
> > EventID) which contains one field for each Bandwidth Type that can be
> > used to configure the bandwidth event to track any combination of
> > supported bandwidth types. The event will count requests from every
> > Bandwidth Type bit that is set in the corresponding configuration regis=
ter.
> >
> > Following are the types of events supported:
> >
> > =3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Bits    Description
> > =3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > 6       Dirty Victims from the QOS domain to all types of memory
> > 5       Reads to slow memory in the non-local NUMA domain
> > 4       Reads to slow memory in the local NUMA domain
> > 3       Non-temporal writes to non-local NUMA domain
> > 2       Non-temporal writes to local NUMA domain
> > 1       Reads to memory in the non-local NUMA domain
> > 0       Reads to memory in the local NUMA domain
> > =3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > By default, the mbm_total_bytes configuration is set to 0x7F to count
> > all the event types and the mbm_local_bytes configuration is set to
> > 0x15 to count all the local memory events.
> >
> > Feature description is available in the specification, "AMD64
> > Technology Platform Quality of Service Extensions, Revision: 1.03
> > Publication # 56375
> > Revision: 1.03 Issue Date: February 2022".
> >
> > Link:
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww=
.
> > amd.com%2Fen%2Fsupport%2Ftech-docs%2Famd64-technology-platform-
> quality
> > -service-
> extensions&amp;data=3D05%7C01%7Cbabu.moger%40amd.com%7C5ba4a608
> >
> edb04202be2708da97fbe2df%7C3dd8961fe4884e608e11a82d994e183d%7C0%
> 7C0%7C
> >
> 637989405343884737%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
> AiLCJQIjo
> >
> iV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdat
> a=3Dhoyj
> > zeINRtp1n%2FWsG0MHxzmQ8aLdDV4V03xlJVsNRv8%3D&amp;reserved=3D0
> > Link:
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fbug=
z
> >
> illa.kernel.org%2Fshow_bug.cgi%3Fid%3D206537&amp;data=3D05%7C01%7Cbab
> u.m
> >
> oger%40amd.com%7C5ba4a608edb04202be2708da97fbe2df%7C3dd8961fe488
> 4e608e
> >
> 11a82d994e183d%7C0%7C0%7C637989405343884737%7CUnknown%7CTWFpb
> GZsb3d8ey
> >
> JWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
> C300
> >
> 0%7C%7C%7C&amp;sdata=3Dn0gR1mooP9QuEzhrvXrvPaateof4XrBABrAoK5N8e8
> o%3D&am
> > p;reserved=3D0
> > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > Reviewed-by: Ingo Molnar <mingo@kernel.org>
> > ---
> >  arch/x86/include/asm/cpufeatures.h |    1 +
> >  arch/x86/kernel/cpu/scattered.c    |    1 +
> >  2 files changed, 2 insertions(+)
> >
> > diff --git a/arch/x86/include/asm/cpufeatures.h
> > b/arch/x86/include/asm/cpufeatures.h
> > index 1815435c9c88..a4ee02a56d54 100644
> > --- a/arch/x86/include/asm/cpufeatures.h
> > +++ b/arch/x86/include/asm/cpufeatures.h
> > @@ -305,6 +305,7 @@
> >  #define X86_FEATURE_USE_IBPB_FW		(11*32+16) /* "" Use IBPB
> during runtime firmware calls */
> >  #define X86_FEATURE_RSB_VMEXIT_LITE	(11*32+17) /* "" Fill RSB on
> VM exit when EIBRS is enabled */
> >  #define X86_FEATURE_SMBA		(11*32+18) /* SLOW Memory
> Bandwidth Allocation */
> > +#define X86_FEATURE_BMEC		(11*32+18) /* AMD
> Bandwidth Monitoring Event Configuration (BMEC) */
>=20
> (numbering issue has already been discussed)

Yes.=20
>=20
> >
> >  /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12=
 */
> >  #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI
> instructions */
> > diff --git a/arch/x86/kernel/cpu/scattered.c
> > b/arch/x86/kernel/cpu/scattered.c index 885ecf46abb2..7981df0b910e
> > 100644
> > --- a/arch/x86/kernel/cpu/scattered.c
> > +++ b/arch/x86/kernel/cpu/scattered.c
> > @@ -45,6 +45,7 @@ static const struct cpuid_bit cpuid_bits[] =3D {
> >  	{ X86_FEATURE_PROC_FEEDBACK,    CPUID_EDX, 11, 0x80000007, 0 },
> >  	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },
> >  	{ X86_FEATURE_SMBA,             CPUID_EBX,  2, 0x80000020, 0 },
> > +	{ X86_FEATURE_BMEC,             CPUID_EBX,  3, 0x80000020, 0 },
> >  	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
> >  	{ 0, 0, 0, 0, 0 }
> >  };
> >
> >
>=20
> Similar to previous - please use same coding style as area being changed.
Sure.
>=20
> Is there a feature dependency (cpuid_deps[]) on X86_FEATURE_CQM_LLC
> needed?

Good catch.. Yes. Its needed. Will fix it.
Thanks
Babu
