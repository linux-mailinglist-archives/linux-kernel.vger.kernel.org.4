Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142065BEB9C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 19:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiITRJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 13:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiITRJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 13:09:45 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2053.outbound.protection.outlook.com [40.107.102.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F488BC;
        Tue, 20 Sep 2022 10:09:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QUWLP7Xjx3Ds46yfW2chh+v5LToy53XibSKsM9L/BrPwQIoaT/T6soEnMrtAf/rOHDc/839GiGzzHrQazrH9mt6hPfLOGSZmT3RIeUsX810TI0bEVe9/ZQ0bWBbdNJ2rcZRfl4blJO5zmhW4uN+mUULUD5laTCG/5GsZWdmJ2ScfQb5eUzz6uPPFIOu7kMiyAJCtOIO+woCizDGXEkhRBPD/TBl03aQ9IV7qdibElv2SXsBAPYQORDh7Uv0BauOcNb2F6Q9uhyCzyLA5XF28nOho+wScUNQ6zbzwDMPBWDrrGtTpIW/Ajn5CgwQaPOfLOI2VgwpVp2Ds1kuavhWnXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rxq68L2pumFc+NXtpgG1X14PZ7oFaTCYWPvYUJk2/Jw=;
 b=M585lflW3imdUq7p+/MGXgNkB7NPK+VHAekMe4Mf7eOgJZVdHdDV5kwJ9nUeuVM8HjQPlwCM193VrxwvdcErXfMPsTYRB6glmTG6o779Iu+YTMg/xF7uGxChnhlTFS9vVMb5hx/I85v7SYcIiO1oDYffw6dTkL6Ggm2IIPxsjFfX0eJcdHKBneenK5g6aMa0h1Qo4TKO/A6XY7uGdYtAIAroF59R8Jy7ctj85UoayFsKf5nnPnILRuXkuJH0Ws5+/t+IxQCgw3KFSovwEZ/4wtN+sQnf1tVB9vwEbTKoo9BhkBn2SriO0Mv1naem176/0CFTiJ3cWJNyvyRUHeWFEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rxq68L2pumFc+NXtpgG1X14PZ7oFaTCYWPvYUJk2/Jw=;
 b=uvj3KIQaKTaODmUq0gjPI6mWoBgIxF1UR7xia1xbjvX9vUOTJXOt3n/ibacNtKpDgKhepUsLzzQ2i/QsrbQDYa6m+lWMyMdUci1gOUt6xKu2gKnGda9x9/SUVdW0HQH2oWaC7CqHCpCddzqPoEiTqdZVZbkqVtsFhYcLVldyVDM=
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ0PR12MB5408.namprd12.prod.outlook.com (2603:10b6:a03:305::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.19; Tue, 20 Sep
 2022 17:09:41 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::4120:60cf:46a8:7109]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::4120:60cf:46a8:7109%7]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 17:09:41 +0000
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
Subject: RE: [PATCH v4 09/13] x86/resctrl: Add sysfs interface files to
 read/write event configuration
Thread-Topic: [PATCH v4 09/13] x86/resctrl: Add sysfs interface files to
 read/write event configuration
Thread-Index: AQHYwuPUElL9x6Uav0G/mNvc1Vq6Aa3iRHAAgASz0wCAAA9xAIAAPtiAgAALQoCAAUy4MA==
Date:   Tue, 20 Sep 2022 17:09:40 +0000
Message-ID: <MW3PR12MB45537C67691C1D4048CF25E7954C9@MW3PR12MB4553.namprd12.prod.outlook.com>
References: <166257348081.1043018.11227924488792315932.stgit@bmoger-ubuntu>
 <166257366204.1043018.4834615270384002210.stgit@bmoger-ubuntu>
 <13294a8f-e76f-a6a9-284c-67adbc80ec7c@intel.com>
 <04132d34-c69e-62a0-35ba-bafa44210c0a@amd.com>
 <bd424e21-c24d-fcf1-96e8-38c9f7546d19@intel.com>
 <9dd5a111-63ea-8c4b-5515-d24d1d9c73f0@amd.com>
 <ab2f780c-72aa-2415-7167-e23c27f9a194@intel.com>
In-Reply-To: <ab2f780c-72aa-2415-7167-e23c27f9a194@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-20T16:58:06Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=46eb1b75-b716-4b1c-853c-2cd03db07911;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-09-20T17:09:38Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 49204c32-928f-427f-b98f-be4e2d1e5dd7
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4553:EE_|SJ0PR12MB5408:EE_
x-ms-office365-filtering-correlation-id: 509f98b6-0af8-4f1d-7071-08da9b2ae812
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CHYw/F+Sla8FPkrkCb0JgmQhBgezllievgwlScA4JhWSKBHrXYcK7Z9cJWfhxO2FwvF5nlzXDYzDNYuZBWSyE01rMw6DifWpsuIyjNYFRJHHDc55m7+C+mrYZ8q9zpufLhoMsWXb1Ko3Og5wkJU3GQjaQUv3zXGTiKRtrKQ8PDpNVdJ1iWfSsDMrZWANymCZoCHdTTx7spTj0fPkwTJ9jos6+JUyluAgVb05guijNSIY6aAePiZ5f3y7mB4FfjbGv5GURn15hTWoV5yG8qy3CslaI6rEESaETwas4CVKnaT0vpABJFzpP7CMK4vCN/Ov0NgpckLouJJtMaxp1NT1FGTocVclzom9JHbitYD8u3mkq/pZGsk50uMLH6MIQG4WIL50gCcObl475MnE0zssCi817mQLesjPB1fOQ1bOREbRmNnOwVeqQE+Ho3a6JSssDwDshBi6gVnWUUjY6XjaR9afJ2hB3IA8FBzOqtUBSk2y+tQNK0FoRUWhbqrZPSBFe/PPmTO0bgq6MH1ziMmsAlrD2BRfJmJArNt2ChQJazhyrnGKAmPWresebKPSaufprJUEc4ubigtuEBuy6TCl4OpbI1MU8lU2afatvxGuOIAoSdwvNFCj/GEC5M87mTK6PcUZjL1UH6k7Y7wZ5dEmWg93qObPH6yYWLD8BgyoymnokhpvaTwAkTZnPRhnaLLV3mYeeSxE/TvIxdlMoGRjpaiBZ3s2yMKA0Sb8RIR9jrK/u9yBUzM3KuvCMvQgQTsHWGctTSIQtt5+d+0EbLYuKWMwIjK+dcV4vS1/MuL1oWw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(451199015)(2906002)(33656002)(122000001)(316002)(38100700002)(4326008)(66556008)(64756008)(5660300002)(8676002)(66476007)(52536014)(66446008)(66946007)(54906003)(45080400002)(76116006)(110136005)(8936002)(86362001)(186003)(478600001)(7416002)(9686003)(26005)(38070700005)(83380400001)(966005)(71200400001)(53546011)(55016003)(7696005)(41300700001)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?B6rmRoPHM8kIsYeLNZ4IPYEiaovswWmeVoJttT5qLuTNnHmGBrgpEnGLe0?=
 =?iso-8859-1?Q?ceHSExlgdmBXEzzYIRtERG4HzeyHBANkXQ6AXFxTWqAbwr0kakwS7AxHoG?=
 =?iso-8859-1?Q?vjZubfUWTIx38DjRFdpVuXTc+1G9sc6fP8PV7z+Cgk3OpM+BqEm0W09kMm?=
 =?iso-8859-1?Q?SygkGgTPL5/vWJKho8TRiXGJj3V7jDUwRHtsdi+qugWWdSBC6sAIzNCvdl?=
 =?iso-8859-1?Q?TbcNuYDGmLuAUu7m2yqzF0dAgPRlUZuI6pklc5B+fdO95JoLqdOCHSvq6n?=
 =?iso-8859-1?Q?PLxs3twIhGd66keebLsQDS+O60CBVZBqIh+eubv7RtIyyIHWtnpl6ewdhS?=
 =?iso-8859-1?Q?5FdWcgyXCnukfUjbcA0jnGMBuRlPB91X4JagAxq5AmXTWXFoG/itkveP1b?=
 =?iso-8859-1?Q?fM7jRc69kpTI0d2uVJ1SW3AAWXZkEYdQJEL0QYAOTZ+sQHAbyCrlSLKUck?=
 =?iso-8859-1?Q?l6NS+HT4MMJLIqZQtiUbbCHHrS9HNJM86mZT7xYSHkP3Al2Ly8kRBX8MDx?=
 =?iso-8859-1?Q?jRTv1ANGCj5w6i5Zne5wCJ223u5tLw3uA+Ecl54myNG+4Wh9ACCrcsmOCW?=
 =?iso-8859-1?Q?EFPddB13qe+MwOu6pk0U/ifOob5sd0kRyImQe8rCjVeV9jQL/RRYyGu/x9?=
 =?iso-8859-1?Q?eKi/vDF8RIOkjMGtnGXSe8Lwo61hooIucZi/kr0LsknAbv4H2M8bX3ScIj?=
 =?iso-8859-1?Q?3/+f7RoITyls9Wnb8Ha28WgsL9WE3rB+2df4nEKVN1IJThqDsCfIvG68+w?=
 =?iso-8859-1?Q?iLPqvuh6kYj6WehSlKczKhAXPsdIILyY6PuXcDQUZgr0U/0NU0PFg88Lxw?=
 =?iso-8859-1?Q?LaC3VYHPcKG+AULLWH/MUFinvVDGVOBQmaWm/vFZEtrUDqjTlloQDZL5dW?=
 =?iso-8859-1?Q?KNH1+EGgdC2hZHvYAje/tT/uII6JlJqLg/S1JFGiQ4XgVYMfY3W2rqCfmO?=
 =?iso-8859-1?Q?avVzAgsvbMDxF6QJwIM9kU15CmIT2e/yr/IXzvdb0p1uwCYVA14LfxGS/N?=
 =?iso-8859-1?Q?+0wOg23WOFwdHKlPDE1JJ1SxJZbAm7U2kA22xm56Z8EA58X4IinNCuAarW?=
 =?iso-8859-1?Q?RDQU4le30Frq3+W4G07Rws3whqcheGz8W5OwxqQQdqMhQJgSLXovGXSDFl?=
 =?iso-8859-1?Q?6Ib2v3gAPJqIoaqDWAQLQJQCyhMyjt/7MH1NsLL2sEEjTJUHz2FNqDoaqw?=
 =?iso-8859-1?Q?0OufPHn3IS4GXQUze48Pya1PKQC/x4GJ+JLjOtYTK/AJZ3oOApl+NJvWQC?=
 =?iso-8859-1?Q?TgZgzLvRCueCZh+qtqAsgapqMuEn1AGJduQ/KxyMK6J/i3476NxKGXId4F?=
 =?iso-8859-1?Q?mwd28HZhVfGf54go2TMlVYqYfXN2Hwi7SI6xbLiQrYBzys0mekpUfR9x2g?=
 =?iso-8859-1?Q?fCJgAHV/TVbRKwsp78ryy6eHlFdLEq5EEFH9oN/9bH2rnPS8HV7rqJUKqB?=
 =?iso-8859-1?Q?4OmhJC15NzlF8vk2nCQq5tHAEI8hN9zRfhXIuF4bVdiKI2hIIfHypn+kAT?=
 =?iso-8859-1?Q?ltGvPzcf4U63d4CWHXeWX8P4wHO7qcpyCwJIJBEk2NPdY0ibSPciKFkkB6?=
 =?iso-8859-1?Q?Z9InMjetY3S2KJuMoI0DrpdHEVqFGy2LszqL3qJA8xyImBeEBQA2XRUGFr?=
 =?iso-8859-1?Q?/fZHsEDSOXgro=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 509f98b6-0af8-4f1d-7071-08da9b2ae812
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 17:09:41.0175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xqoZp15tlNaTT/aO0eu8UlBzU6+opgHtlm3Y/Jzffovm4zo87tAMYfcwhVLKYfsY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5408
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
> Sent: Monday, September 19, 2022 4:07 PM
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
> Subject: Re: [PATCH v4 09/13] x86/resctrl: Add sysfs interface files to
> read/write event configuration
>=20
> Hi Babu,
>=20
> On 9/19/2022 1:26 PM, Moger, Babu wrote:
> > On 9/19/22 11:42, Reinette Chatre wrote:
> >> On 9/19/2022 8:46 AM, Moger, Babu wrote:
> >>> On 9/16/22 10:58, Reinette Chatre wrote:
> >>>> On 9/7/2022 11:01 AM, Babu Moger wrote:
> >>>>> Add two new sysfs files to read/write the event configuration if
> >>>>> the feature Bandwidth Monitoring Event Configuration (BMEC) is
> >>>>> supported. The file mbm_local_config is for the configuration of
> >>>>> the event mbm_local_bytes and the file mbm_total_config is for the
> >>>>> configuration of mbm_total_bytes.
> >>>>>
> >>>>> $ls /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local*
> >>>>> /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
> >>>>> /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_config
> >>>>>
> >>>>> $ls /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total*
> >>>>> /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
> >>>>> /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_config
> >>>>>
> >>>> This patch makes the mbm*config files per monitor group. Looking
> >>>> ahead at later patches how the configuration is set it is not clear
> >>>> to me that this is the right place for these configuration files.
> >>>>
> >>>> Looking ahead to patch 10 there is neither rmid nor closid within
> >>>> the (MSR_IA32_EVT_CFG_BASE + index) register - it only takes the
> >>>> bits indicating what access types needs to be counted. Also in
> >>>> patch 10 I understand that the scope of this register is per L3
> >>>> cache domain.
> >>> Yes. Scope of=A0 MSR_IA32_EVT_CFG_BASE per L3 domain.
> >>>> Considering this, why is the sysfs file associated with each
> >>>> monitor group?
> >>> Please see the response below.
> >>>> For example, consider the following scenario:
> >>>> # cd /sys/fs/resctrl
> >>>> # mkdir g2
> >>>> # mkdir mon_groups/m1
> >>>> # mkdir mon_groups/m2
> >>>> # find . | grep mbm_local_config
> >>>> ./mon_data/mon_L3_00/mbm_local_config
> >>>> ./mon_data/mon_L3_01/mbm_local_config
> >>>> ./g2/mon_data/mon_L3_00/mbm_local_config
> >>>> ./g2/mon_data/mon_L3_01/mbm_local_config
> >>>> ./mon_groups/m2/mon_data/mon_L3_00/mbm_local_config
> >>>> ./mon_groups/m2/mon_data/mon_L3_01/mbm_local_config
> >>>> ./mon_groups/m1/mon_data/mon_L3_00/mbm_local_config
> >>>> ./mon_groups/m1/mon_data/mon_L3_01/mbm_local_config
> >>>>
> >>>>
> >>>> From what I understand, the following sysfs files are associated
> >>>> with cache domain #0 and thus writing to any of these files would
> >>>> change the same configuration:
> >>>> ./mon_data/mon_L3_00/mbm_local_config
> >>>> ./g2/mon_data/mon_L3_00/mbm_local_config
> >>>> ./mon_groups/m2/mon_data/mon_L3_00/mbm_local_config
> >>>> ./mon_groups/m1/mon_data/mon_L3_00/mbm_local_config
> >>>>
> >>>> Could you please correct me where I am wrong?
> >>> For example, we have CPUs 0-7 in domain 0. We have two counters
> >>> which are configurable.
> >>>
> >>> Lets consider same example as your mentioned about.
> >>>
> >>> g2 is a control group.
> >>>
> >>> m1 and m2 are monitor group.
> >>>
> >>> We can have control group g2 with CPUs 0-7 to limit the L3 bandwidth
> >>> (or memory bandwidth with required schemata setting).
> >>>
> >>> We can have mon group m1 with cpus 0-3 to monitor mbm_local_bytes.
> >>>
> >>> We can have mon group m2 with cpus=A0 4-7 to monitor mbm_total_bytes.
> >>>
> >>> Each group is independently, monitoring two separate thing. Without
> >>> having
> >> Right, because monitoring, the actual counting of the events, is per
> >> monitor group. When a monitor group is created a new RMID is created
> >> and when the counter is read it is per-RMID.
> >>
> >> The event configuration is independent from the RMID using the counter=
.
> >>
> >>> sysfs file (mbm_local_config and mbm_total_config) in each monitor
> >>> group, we wont be able to configure the above configuration.
> >> I do not understand this reasoning. From what I understand the event
> >> configuration is independent from the monitoring group. Thus,
> >> changing an event configuration for one monitoring group would impact
> >> all monitoring groups using that event counter. This implementation
> >> associates an event configuration with each monitoring group and by
> >> doing so it implies that it is unique to the monitoring group, but
> >> that is not how it works.
> >
> > The event configuration is designed per L3 domain. The mon_data is
> > also per domain (like mon_L3_00.. mon_L3_01 etc). So, added the event
> > configuration file inside each domain. We have all the information
> > inside the domain. Thought, that is right place. I am open for suggesti=
ons.
>=20
> It is not clear to me if you are also seeing all the duplication that acc=
ompanies
> this implementation. As you can see in the example I provided in
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
kern
> el.org%2Flkml%2F13294a8f-e76f-a6a9-284c-
> 67adbc80ec7c%40intel.com%2F&amp;data=3D05%7C01%7Cbabu.moger%40amd.
> com%7Cc22190a25ac044ec5f5408da9a82f5b7%7C3dd8961fe4884e608e11a82
> d994e183d%7C0%7C0%7C637992184504699692%7CUnknown%7CTWFpbGZsb3
> d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> D%7C3000%7C%7C%7C&amp;sdata=3DuPuGOlwaIgwJ9VnwNOS%2B4mUrqJnS65
> OdrEsEXtztUbU%3D&amp;reserved=3D0,
> if I understand the implementation correctly, there will be several
> configuration files scattered through resctrl that all configure the same=
 value. I
> asked you to correct me where I am wrong but you did not correct me.
> Instead you keep repeating that placing the files in the duplicate locati=
ons is
> convenient. I can see how this is convenient for you but please do consid=
er that
> having these duplicate configuration files scattered through resctrl make=
s for a
> very confusing user interface and unexpected behavior. Users would expect
> that a configuration associated with a monitor group impacts that monitor
> group only - not all monitor groups associated with that domain.
>=20
> User API is hard so this does need careful thought. Perhaps the architect=
s can
> chime in here.
>=20
> One option could be:
> # cd /sys/fs/resctrl/info/L3_MON
> # cat mbm_total_config
> 0=3D7f;1=3D7f
> # cat mbm_local_config
> 0=3D15;1=3D15

I think this should work.=20
# cat mbm_total_config
0=3D7f;1=3D7f
I would think 0 and 1 are domain ids here.

We have to provide interface to write also.
#echo "0=3D0x70" > mbm_total_config  (update mbm_total_config  for domain 0=
)
#echo 1=3D0x10  > mbm_local_config     (update mbm_local_config  for domain=
 1)

We will have to parse the string and update the specific domains.

>=20
> It would be clear when changing mem_total_config or mbm_local_config that
> it would impact all monitoring groups within all resource groups. What do=
 you
> think?

Yes. Thank you. It should work. As long and we have the ways to modify(and =
read) the specific L3 domains then it should be fine. Let me start on that.=
 Will reply if I see any major issues.
Thanks
Babu
