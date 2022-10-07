Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E655F7B08
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 17:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiJGPwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 11:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiJGPwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 11:52:02 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DEDD01A2;
        Fri,  7 Oct 2022 08:52:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0k/QFpBm9gkk/J51xRvpo2yXLaQrzmSWJj8ztNywd+vLp6gSY8B/d/HzjpHYMnNsBplSienfpumN6Jyx2jTo5B1LfzjvPQbZhFLiEdZrRmt/H8f6VDWsypV+m8AbNboloRqUprRZ2Lxn/SmSX96Mh6ogBv51TTQ92lTgfFzIqa2z4fNdC68g3rrVX0STZ0r0Ee5a7iP7cnl3kHMOYnoR20umv8QB2ST4YtlP9oYr1x8GVquSA2dMIzevM+yxEkvwD5YNn/0VFlcCZaUbYtKRBmFjUC8TGrSBhL59Q97a1mLsqfR5usz//buGY/Fj6VIsu1R6gG7XIrXiukuBz2zfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/tBXQXcp367Ch7OTloEc42KCGN1va9Qbf0zKie99Qp0=;
 b=em9TA57fx3XGuAaDHTdU6nPr3H4Q/Vu2TeelwmJ+Ir/oqJ4fLKyleKvcWkBNPlV+iUMkoMiDZknlFwuO9tJQkdgeRJCdZe3fn1rAOC94rTm5X4dQAQw4XolH8B0SKlXTp3/27WtV+XHbyx3AzRDL5jPesrHq/p7rKrGftG+YNQQlSTn0/FeRpm4slBi2VpWvAwhLSRNG9PPFUp/h+3shp0DLkZWqPOisNg6A9B79jLS2LVlElJEZgaLBEz3D6NYIWZE7bEuiB6wZ8w31Wd8FFh51exfjpb+hSWdUSZxl2bUKQJCYcHPF8ZkPhCXw9DXo1ErJG+jwkrtIDYl6QpWiMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tBXQXcp367Ch7OTloEc42KCGN1va9Qbf0zKie99Qp0=;
 b=JgWlOz/+tFuYsrGqK4AohdW8JxfK4ghvHkSM5M+iAyFXvNIzWIkbXBnIBd7Wm+gXzBuNws9LJAlZnkoqGd/oY/l8PNqw9aZyufm49qhhvv0LQUNLLGrDaOTVjw/O0YEvPNUIDf3k0Mcz9CGB4cOVvwsXYFXhDwa2be2Zqm4X6TA=
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ0PR12MB5472.namprd12.prod.outlook.com (2603:10b6:a03:3bb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Fri, 7 Oct
 2022 15:51:58 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::619e:35bf:5e0b:c51e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::619e:35bf:5e0b:c51e%3]) with mapi id 15.20.5676.036; Fri, 7 Oct 2022
 15:51:57 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
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
        "eranian@google.com" <eranian@google.com>
Subject: RE: [PATCH v5 00/12] x86/resctrl: Support for AMD QoS new features
Thread-Topic: [PATCH v5 00/12] x86/resctrl: Support for AMD QoS new features
Thread-Index: AQHY0q9KrUGGvTk3FkG5TCKLSx8ls64CqZCAgAB6VpA=
Date:   Fri, 7 Oct 2022 15:51:57 +0000
Message-ID: <MW3PR12MB455398D9564E7C3B99D58AF5955F9@MW3PR12MB4553.namprd12.prod.outlook.com>
References: <166431016617.373387.1968875281081252467.stgit@bmoger-ubuntu>
 <eb7e7927-84b4-a952-e8c7-dec518bfcda9@gmail.com>
In-Reply-To: <eb7e7927-84b4-a952-e8c7-dec518bfcda9@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-10-07T15:51:16Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=4cec0c39-bd4e-4343-8411-aa32cb61c56b;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-10-07T15:51:56Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: cde14760-86ec-4776-b977-1c6b5a3e906b
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4553:EE_|SJ0PR12MB5472:EE_
x-ms-office365-filtering-correlation-id: f2703fe1-a26b-4be8-5e79-08daa87bdd94
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ekMUqljtbwtIhely7BmIOigYzNwBsJJwTnm50Wm+UM3NjS5dx+c9ntPxywB0aoB3SGFMJTDpGbjVbz7t/07dlCBELJOr5ZzJzsR0O7qlvDyosFZPogdh1Y/skd/Nr4IRijwx6Z5tHIxW79vIvAAkdUSGX8dABi2fdw1RKbFRtjKqR8p8Y0V3TTnBwNlsEn8TWNPNo7Nr0NToXcpWIJXfm7ZrE7qb6mdWwD/xY+yuMBXgZerpnXVBP/G115FI5LAE9fNz8rWUHtfh0ILbTzPILsYXHoB8kalWBpdROR+N7NVvnmwsnPGC3HF4kopjedPeey11bi6NBJ6VpPWood4Z/33bgB0CmI4rgQ64O5uSO+xF5zPb4JeE5teqvaMwfEp5nzvW/dwhnQSXIL9MnzcroSKMsPbagsXELsdTy/0/fbCXvnUrLBiAtgwQaKzy7iyTte+bNQrCOxHnvLlwIBO0pkbpzGOQL8P6TwMjT7B4WScIlNlfiIjzuYQzakbQInbNQVd+BjERS4TcdiIGfedSu+q+0Ec0ZJxsywzsLCsd70EZBlFrmbIL2Zk4TpDKCeNq4SWegEtsZCF9DweVYtTHy9sibSTVbLr4HRQQL5fDrfAFIZ4O6YP7V0bKO3a+S8GnAsLA/HTCuRfxOApMuJbS0xb/TSu1df4mJrR2irCz9i67Y0UIaWtvyppZtpkhuSCyllJGQepfadvydOujXAgmoT0z59bDfTq92TpJdB2Xp8QXjZxssM8qhYUXbFPZEnnxohqfQeNd3Ty1Y7nUQ11VBCxazl7O2b7uxvq3JVm8axit8WLOToJpswZmFsF4fvAz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(376002)(136003)(366004)(451199015)(54906003)(2906002)(41300700001)(7416002)(8936002)(66556008)(4326008)(66946007)(64756008)(66446008)(66476007)(33656002)(38070700005)(45080400002)(76116006)(8676002)(110136005)(86362001)(71200400001)(966005)(6506007)(55016003)(7696005)(122000001)(53546011)(38100700002)(478600001)(316002)(186003)(52536014)(5660300002)(9686003)(83380400001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/84hIGmQ/06g/fcny5ZH0xkNC5/OG0S5HopBDNP4KVVqTLj37T75H4DKVoMV?=
 =?us-ascii?Q?IGR9Ay95v016UIQ6a+yzeGijnWldPn8br9c0vHaJiMlso7ltk8IvqWZuc9XX?=
 =?us-ascii?Q?rq22v6A+GQ8bLKdeDrcH8jB7/oVMj8WxOLGG1BqOK1UZ4OUC5PqcxQK4BK6S?=
 =?us-ascii?Q?Muf88t79wYPBBtokG53cHHRkRi7RpUhVt7cAAVuEw+KlWiZSHfMteR1m2eRr?=
 =?us-ascii?Q?jFFs5F3p/264a87XaMlpjTY+BbH+AeZWfRmq58ecl4cLjxkr45FfDACz90D8?=
 =?us-ascii?Q?1w4vryp3wLFTEvKVjf0BHixxa4XgBTjsO9VreJyORVL2tsUKIy4ZPF4LvUkj?=
 =?us-ascii?Q?Sr6X7xPmZavehzQed1lRZQ9IuY3cM3z1h9iKzjOaVV6kvDalTJaVbV+lu+4E?=
 =?us-ascii?Q?tXMe7qEkd0a6sXPBSJrkOc2vUBmieI32oXpmDNoKEryFWWjonctrSL61bwJi?=
 =?us-ascii?Q?Dk3mdm157C3rd21o4vGHDltwNjqO1hnSd9CrRoNQ5t+AbZm9IgccpO7QmK9X?=
 =?us-ascii?Q?EviInlwSvDmaiel/5TMYH3m1CaE3d2cTRHa0paRX/AM52aWwW38mmvN2SYQb?=
 =?us-ascii?Q?X68xMkhAhGJYRdu6ip2Kwg9P/vaSrfwT9i27uVXRqy0sko/5orK8mXmcC0X1?=
 =?us-ascii?Q?7YOPKvsCPfAJBDMkGUPRNpgqydhUaqSfrfGWbZqgI/HIEOgBfTswXwJtWo5u?=
 =?us-ascii?Q?S7MJ9fMgCG5O0uerVkrKmTz1HZgV2U8nuamiMPSHMxnknoO9AWoIFRY3ue8Q?=
 =?us-ascii?Q?9xixYxCxfPx8YoBkBZX8tzkwn/FNlT8D/jp2g+jVlQgsrTn5Poc8VzfHOEzb?=
 =?us-ascii?Q?Ogsq500Cp+NmcQx8Tk+sUcHqalqILDmbJr6n69Qoc/y/0OvsREOVJn8xtGDc?=
 =?us-ascii?Q?GMF/Vte8RHunGZTgg+9eEt12h3Gz05RYQPR5dO6qAgs9ub/O169iuWCXLnCA?=
 =?us-ascii?Q?tcK11fzmqFRxjofv3XXvokSVGRZH5u7SOmwQdP1bl5Y2M14X+Lbg82plarcI?=
 =?us-ascii?Q?ZV/5olUcGg0T4nh36IegBmPokZwMYz20ZFB6/bauAQQKim5b7whzf5kDhcbE?=
 =?us-ascii?Q?alMpw6rBvCuJBWcPOLeDtU+8KE/arT1rAg7OxhaI0QeFu7r5n9ZaMHkwFcOg?=
 =?us-ascii?Q?m6MPNLKoZuo8Gw0fQv24YjtiS4uhAAYagOa6wBYajqQpSTfB7bjkpa7NaIYE?=
 =?us-ascii?Q?vFrBi5OEc8F8w4d2qQTLNUykxEkCGvbLxyHTUKpxAJFEfVGuVwB7siq51CVf?=
 =?us-ascii?Q?rkG/DfBUHuf27LHmdHtvGmKa/ntCX5q4/dIBdX/FQuvtAmn+mUE92n2QwjeD?=
 =?us-ascii?Q?3yxa8T77p9BsGcnI8/jNU8UzjV7x0C5l/oDA/CjUUEB7Lh7c/HbmVzMyAd2/?=
 =?us-ascii?Q?Npg9l+/hKeGsF7UUok7UZU0+fEiBh9M++yr0PvwGejjhaKFqjiDGIuQTdhfF?=
 =?us-ascii?Q?ssP1n7bG0yQsrhtu87T2MZocSqkoAbPeuePVPRZkHaHjArwbrWqLhAYsotg4?=
 =?us-ascii?Q?7lYHlrp1kdisyyYv4uQMqtoBEe3mB13fR3dmNkztbPNMu+kB34soTQwc04z8?=
 =?us-ascii?Q?t6IFjmfruNk/4BpEvZM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2703fe1-a26b-4be8-5e79-08daa87bdd94
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2022 15:51:57.7966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HhUGQTrRkffpM9tLOXfYkqxR7BB0utyruUpLTVGmCmG7ibb9fTveCVo4J/HoXzmq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5472
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

Hi Sanjaya,

> -----Original Message-----
> From: Bagas Sanjaya <bagasdotme@gmail.com>
> Sent: Friday, October 7, 2022 3:33 AM
> To: Moger, Babu <Babu.Moger@amd.com>; corbet@lwn.net;
> reinette.chatre@intel.com; tglx@linutronix.de; mingo@redhat.com;
> bp@alien8.de
> Cc: fenghua.yu@intel.com; dave.hansen@linux.intel.com; x86@kernel.org;
> hpa@zytor.com; paulmck@kernel.org; akpm@linux-foundation.org;
> quic_neeraju@quicinc.com; rdunlap@infradead.org;
> damien.lemoal@opensource.wdc.com; songmuchun@bytedance.com;
> peterz@infradead.org; jpoimboe@kernel.org; pbonzini@redhat.com;
> chang.seok.bae@intel.com; pawan.kumar.gupta@linux.intel.com;
> jmattson@google.com; daniel.sneddon@linux.intel.com; Das1, Sandipan
> <Sandipan.Das@amd.com>; tony.luck@intel.com; james.morse@arm.com;
> linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org;
> eranian@google.com
> Subject: Re: [PATCH v5 00/12] x86/resctrl: Support for AMD QoS new featur=
es
>=20
> On 9/28/22 03:25, Babu Moger wrote:
> > New AMD processors can now support following QoS features.
> >
> > 1. Slow Memory Bandwidth Allocation (SMBA)
> >    With this feature, the QOS enforcement policies can be applied
> >    to the external slow memory connected to the host. QOS enforcement
> >    is accomplished by assigning a Class Of Service (COS) to a processor
> >    and specifying allocations or limits for that COS for each resource
> >    to be allocated.
> >
> >    Currently, CXL.memory is the only supported "slow" memory device. Wi=
th
> >    the support of SMBA feature the hardware enables bandwidth allocatio=
n
> >    on the slow memory devices.
> >
> > 2. Bandwidth Monitoring Event Configuration (BMEC)
> >    The bandwidth monitoring events mbm_total_event and mbm_local_event
> >    are set to count all the total and local reads/writes respectively.
> >    With the introduction of slow memory, the two counters are not enoug=
h
> >    to count all the different types are memory events. With the feature
> >    BMEC, the users have the option to configure mbm_total_event and
> >    mbm_local_event to count the specific type of events.
> >
> >    Following are the bitmaps of events supported.
> >    Bits    Description
> >      6       Dirty Victims from the QOS domain to all types of memory
> >      5       Reads to slow memory in the non-local NUMA domain
> >      4       Reads to slow memory in the local NUMA domain
> >      3       Non-temporal writes to non-local NUMA domain
> >      2       Non-temporal writes to local NUMA domain
> >      1       Reads to memory in the non-local NUMA domain
> >      0       Reads to memory in the local NUMA domain
> >
> > This series adds support for these features.
> >
> > Feature description is available in the specification, "AMD64
> > Technology Platform Quality of Service Extensions, Revision: 1.03 Publi=
cation
> # 56375 Revision: 1.03 Issue Date: February 2022".
> >
> > Link:
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww=
.
> > amd.com%2Fen%2Fsupport%2Ftech-docs%2Famd64-technology-platform-
> quality
> > -service-
> extensions&amp;data=3D05%7C01%7Cbabu.moger%40amd.com%7Cda5fc806
> >
> 9ca2484b2aef08daa83ea08a%7C3dd8961fe4884e608e11a82d994e183d%7C0%
> 7C0%7C
> >
> 638007284215759374%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
> AiLCJQIjo
> >
> iV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdat
> a=3DqAZS
> > ze2Mbg24Z0%2BX0GN4yrVO2ooQqQyum7NUjwIGg5o%3D&amp;reserved=3D0
> > Link:
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fbug=
z
> >
> illa.kernel.org%2Fshow_bug.cgi%3Fid%3D206537&amp;data=3D05%7C01%7Cbab
> u.m
> >
> oger%40amd.com%7Cda5fc8069ca2484b2aef08daa83ea08a%7C3dd8961fe488
> 4e608e
> >
> 11a82d994e183d%7C0%7C0%7C638007284215759374%7CUnknown%7CTWFpb
> GZsb3d8ey
> >
> JWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
> C300
> >
> 0%7C%7C%7C&amp;sdata=3D8%2BFbGTVfkp%2BCbyyk%2BYa9u0JiHi2YZEVaHiUs
> CBw335g
> > %3D&amp;reserved=3D0
> >
> > ---
> > v5:
> >   Summary of changes.
> >   1. Split the series into two. The first two patches are bug fixes. So=
, sent them
> separate.
> >   2. The config files mbm_total_config and mbm_local_config are now und=
er
> >      /sys/fs/resctrl/info/L3_MON/. Removed these config files from mon
> groups.
> >   3. Ran "checkpatch --strict --codespell" on all the patches. Looks go=
od with
> few known exceptions.
> >   4. Few minor text changes in resctrl.rst file.
> >
> > v4:
> >
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
kern
> el.org%2Flkml%2F166257348081.1043018.11227924488792315932.stgit%40bm
> oger-
> ubuntu%2F&amp;data=3D05%7C01%7Cbabu.moger%40amd.com%7Cda5fc8069ca
> 2484b2aef08daa83ea08a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0
> %7C638007284215759374%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
> MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7
> C&amp;sdata=3DqamR1M2sVSo4vE9NVZzFmvIop7YMKNIYHT74NJrbVVk%3D&am
> p;reserved=3D0
> >   Got numerios of comments from Reinette Chatre. Addressed most of them=
.
> >   Summary of changes.
> >   1. Removed mon_configurable under /sys/fs/resctrl/info/L3_MON/.
> >   2. Updated mon_features texts if the BMEC is supported.
> >   3. Added more explanation about the slow memory support.
> >   4. Replaced smp_call_function_many with on_each_cpu_mask call.
> >   5. Removed arch_has_empty_bitmaps
> >   6. Few other text changes.
> >   7. Removed Reviewed-by if the patch is modified.
> >   8. Rebased the patches to latest tip.
> >
> > v3:
> >
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
kern
> el.org%2Flkml%2F166117559756.6695.16047463526634290701.stgit%40bmoge
> r-
> ubuntu%2F&amp;data=3D05%7C01%7Cbabu.moger%40amd.com%7Cda5fc8069ca
> 2484b2aef08daa83ea08a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0
> %7C638007284215915604%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
> MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7
> C&amp;sdata=3DogINZslT9yExkkFww4X14XQEg8W8heYBrJB59C50Hqk%3D&amp;
> reserved=3D0
> >   a. Rebased the patches to latest tip. Resolved some conflicts.
> >
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit.k=
erne
> l.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftip%2Ftip.git&amp;data=3D05%
> 7C01%7Cbabu.moger%40amd.com%7Cda5fc8069ca2484b2aef08daa83ea08a%
> 7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638007284215915604
> %7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJ
> BTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DZOK3iwsaq
> 3%2BGAUIXJwn9Thg3cJBxWDMAfu4UqHlo2J4%3D&amp;reserved=3D0
> >   b. Taken care of feedback from Bagas Sanjaya.
> >   c. Added Reviewed by from Mingo.
> >   Note: I am still looking for comments from Reinette or Fenghua.
> >
> > v2:
> >
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
kern
> el.org%2Flkml%2F165938717220.724959.10931629283087443782.stgit%40bmo
> ger-
> ubuntu%2F&amp;data=3D05%7C01%7Cbabu.moger%40amd.com%7Cda5fc8069ca
> 2484b2aef08daa83ea08a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0
> %7C638007284215915604%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
> MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7
> C&amp;sdata=3D14viyG9elsn6BYGpDOwrqYQFNOlpyC6oqoJwJm49oV0%3D&amp;
> reserved=3D0
> >   a. Rebased the patches to latest stable tree (v5.18.15). Resolved som=
e
> conflicts.
> >   b. Added the patch to fix CBM issue on AMD. This was originally discu=
ssed
> >
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flor=
e
> > .kernel.org%2Flkml%2F20220517001234.3137157-1-
> eranian%40google.com%2F&
> >
> amp;data=3D05%7C01%7Cbabu.moger%40amd.com%7Cda5fc8069ca2484b2aef0
> 8daa83e
> >
> a08a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6380072842159
> 15604%7
> >
> CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI
> 6Ik1
> >
> haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3D%2BHEvN2PNNYyH
> ohvLg2sbth
> > BQo4cgDj5Vsw9AqGb1Pr8%3D&amp;reserved=3D0
> >
> > v1:
> >
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flor=
e
> >
> .kernel.org%2Flkml%2F165757543252.416408.13547339307237713464.stgit%4
> 0
> > bmoger-
> ubuntu%2F&amp;data=3D05%7C01%7Cbabu.moger%40amd.com%7Cda5fc8069ca
> >
> 2484b2aef08daa83ea08a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0
> %7C638
> >
> 007284215915604%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLC
> JQIjoiV2
> >
> luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DJ
> R03cAA
> > 9pzmq0SgNsgAsajOH6LX%2F4s3px3b%2FJ8409Ys%3D&amp;reserved=3D0
> >
> > Babu Moger (12):
> >       x86/cpufeatures: Add Slow Memory Bandwidth Allocation feature fla=
g
> >       x86/resctrl: Add a new resource type RDT_RESOURCE_SMBA
> >       x86/cpufeatures: Add Bandwidth Monitoring Event Configuration fea=
ture
> flag
> >       x86/resctrl: Include new features in command line options
> >       x86/resctrl: Detect and configure Slow Memory Bandwidth allocatio=
n
> >       x86/resctrl: Introduce data structure to support monitor configur=
ation
> >       x86/resctrl: Add sysfs interface to read mbm_total_bytes event
> configuration
> >       x86/resctrl: Add sysfs interface to read mbm_local_bytes event
> configuration
> >       x86/resctrl: Add sysfs interface to write mbm_total_bytes event
> configuration
> >       x86/resctrl: Add sysfs interface to write mbm_local_bytes event
> configuration
> >       x86/resctrl: Replace smp_call_function_many() with on_each_cpu_ma=
sk()
> >       Documentation/x86: Update resctrl_ui.rst for new features
> >
> >
> >  .../admin-guide/kernel-parameters.txt         |   2 +-
> >  Documentation/x86/resctrl.rst                 | 130 +++++++-
> >  arch/x86/include/asm/cpufeatures.h            |   2 +
> >  arch/x86/kernel/cpu/cpuid-deps.c              |   1 +
> >  arch/x86/kernel/cpu/resctrl/core.c            |  51 ++-
> >  arch/x86/kernel/cpu/resctrl/ctrlmondata.c     |   2 +-
> >  arch/x86/kernel/cpu/resctrl/internal.h        |  33 +-
> >  arch/x86/kernel/cpu/resctrl/monitor.c         |   9 +-
> >  arch/x86/kernel/cpu/resctrl/rdtgroup.c        | 298 ++++++++++++++++--
> >  arch/x86/kernel/cpu/scattered.c               |   2 +
> >  10 files changed, 496 insertions(+), 34 deletions(-)
> >
>=20
> Hi Babu, sorry for having to do public reply to this v5 cover letter due =
to
> accidentally delete the preview documentation patch for your upcoming v6.
>=20
> Thanks for privately sending me the preview patch. Seeing it at a glance,
> LGTM. Please send the full v6 series for us to review.
Sure. Will send the whole series.
Thanks
Babu
