Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E545BB221
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 20:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiIPS2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 14:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiIPS2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 14:28:16 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8EFB5311;
        Fri, 16 Sep 2022 11:28:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TO7z8HqTnUE71GgwqBVSQFGyFHAG3mil95h5s+nzdnjyUjA9udVJLU56OJJ+8iCVsSU/Pjyx0ACQNMXRjk1u2TURKaXv91Gywtaqaa7c7evNevh1gqZgRZryeRakPE3N1Mar50/tlgI287D0Zingwzj1ufZeKbnoNJmch6kLLRfsJkdM7JTQ7a1L+IbhU0TiHsokx62M1WzfVXoSMlaQZrSHY+CUxlodEsz/eQYzaZqIhJaLBX6RSsLND/+eqcZNXoHduRfJEvV4vrLiDwyTEaFeaSXDAPshenmJ4q4J5AqzyrBwKKJ03rYgNKMeHnOjvmNsu25WLyo6SErjNFtR+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/uHcpozlmLaCfOhQqPOWvK6mAuz5eIC0rbujdJPq4AI=;
 b=MG08STQ1xahhGsjfqr20IpyRokrVfKp+jiX7YPDI2BdQ4bpvsP6KJI6XIsq/x/2du6O9JeD6te27beTRGBQ9+d+29b/QtaE/jZyMJ+Phi12Xc4EtSghVJuyLKzSRpaZTx9w+CSVXfBsmNhonYzCn4lggf0/d3qt7QtW5u405FzAxJwu0HonrFxQx39gKgVYqpINjOTzfOQDpvMuGMMZcEEzJ0Npk9hPbDSDH15AZc1NUCTJOaSsMIeD1j+dZ0+YzIZb1fZ8kXI0AHtBYsrwi+RR6yR401nX2k+0lv+AlI3vyrh7gmy1ZgufA03fMgPFdJU3ChdTPD2oHfzoMd8Ei6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/uHcpozlmLaCfOhQqPOWvK6mAuz5eIC0rbujdJPq4AI=;
 b=pktOHauyf6VC8vd7uPs/009Nvs9l9hfnW/t6qjT05KZ8lId5mSC15qjYeKqeD0VojNn/ncqtDFHcnANtDl+XcEpfYdHbFQu8AoW4IszHEA1MW+dENQwG3Yt12DlbMm4NGjOj8WqH0mBoFuyZaCNezv5kPT1exGlKVppZWHiSL3Y=
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM4PR12MB6328.namprd12.prod.outlook.com (2603:10b6:8:a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Fri, 16 Sep
 2022 18:28:10 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::4120:60cf:46a8:7109]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::4120:60cf:46a8:7109%7]) with mapi id 15.20.5632.016; Fri, 16 Sep 2022
 18:28:10 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        James Morse <james.morse@arm.com>,
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
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "eranian@google.com" <eranian@google.com>
Subject: RE: [PATCH v4 01/13] x86/resctrl: Fix min_cbm_bits for AMD
Thread-Topic: [PATCH v4 01/13] x86/resctrl: Fix min_cbm_bits for AMD
Thread-Index: AQHYwuOozRcLHsbJGU2Nw2onSO0Px63XVYyAgASTw4CABlmZgIAAK06Q
Date:   Fri, 16 Sep 2022 18:28:10 +0000
Message-ID: <MW3PR12MB4553619F1201A0C97D8D00F295489@MW3PR12MB4553.namprd12.prod.outlook.com>
References: <166257348081.1043018.11227924488792315932.stgit@bmoger-ubuntu>
 <166257359679.1043018.9253512972611409799.stgit@bmoger-ubuntu>
 <a60be378-dce6-08fb-02b8-1efc660ee3cb@arm.com>
 <b3b25255-c5de-f358-33df-1dc53939a5c7@amd.com>
 <84da1039-20e0-e0fa-84d2-e718e746fed8@intel.com>
In-Reply-To: <84da1039-20e0-e0fa-84d2-e718e746fed8@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-16T18:27:37Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e9bdd7b8-5eed-4e03-90f5-9b088078aeea;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-09-16T18:28:09Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: d612be9d-b713-4ea4-967b-b2f41c1ac1fd
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4553:EE_|DM4PR12MB6328:EE_
x-ms-office365-filtering-correlation-id: 0c62d58b-373d-43a2-034a-08da98113592
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GZsA7nQuJQk+h/dGanx3fR/97wYUNjvWZk1QrFkSqTxM9uKj+MDShJz/yPztEyVm9jdmI/kqXGSivsbLKaaLtLP3ZDmH3La9X+sK+DkzdEv3mUoiwLPn8ubvnH2mw6U0fwO78KXc2PUo0aJZSsc0GZEzkI9O0Q7yE/+onIewzFzkgLqCX0wDjBKqeRZZzzIDbwi0eR0lBEw2OMg93OnFA2bEJMVJMyj/+E/7kGX3bHVzbeMjd5+XbjiQjdnu5WFx/wycV64NlSWTTR5Kqe6k3eakpUIy32y+HM+ma/KF0euy66gLIDVFnCBA2+ODA28ZpkqkrYJyY3e8qSX8cwDih6MjhMGMbmVg2ITiINqrciI+YijHm34qnq0FMfsSiZbXsVkWdPpCzgt4zigjqX/Td2Kv5I/qtzlCQnwdFjzQkFD/6SQOCvwykfZjsmM9Qpf7YIGUtdTzN9mqBgZSkTqZgRS4QdxTmQXehkwCD8K21Y4RUdwtJjVaBcTxzz3X85ds8eI98S89GVkYgLNAGED8ZpmB6IDIN0JQzVcTnEQwm0LWFJngXZs51W0zxQ5LnD9gZoSODxaqhSSea4RUohSePNBd9Pp++zK8DoJGQNC0wtMr0uCalUfx1MKs3OqIUdPAOI1d0BdS5aOeJ6K6q6xFZTKgj4CqpabXjUy/wJDZ4AatdqmQLYCUAsqhPH/u5Z/Jt/FBk0qa9DkilOfDatxN7cQD6BoXH82CKWU2SjegxsAANlK+VRySBgXhR3M/GnTx9uAfOqQ0RPeXaUGbegMcuI4TImKM8TATos2Jl6juWkQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(136003)(39860400002)(366004)(451199015)(83380400001)(186003)(26005)(9686003)(33656002)(52536014)(2906002)(53546011)(8936002)(38070700005)(7416002)(54906003)(5660300002)(110136005)(38100700002)(478600001)(7696005)(122000001)(41300700001)(966005)(6506007)(76116006)(8676002)(71200400001)(86362001)(66946007)(66556008)(55016003)(64756008)(66446008)(66476007)(4326008)(316002)(45080400002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YrQ4kCx8734lQYK9SldOxAPtvdTVYSp7bqJpv4rAroaIe445869SnUins61M?=
 =?us-ascii?Q?n0hk6tlBJ2sEq6txrXYVJuvVVcWDlwop5tLRL7pRJNlEFfnlldgh2xsRZ4vC?=
 =?us-ascii?Q?UPyENaMAnUxcNzb01EZ+EIzLhCy/Hj8+vBXpIbCkNx9LBHLb3coNcQZyAM8y?=
 =?us-ascii?Q?bFsbIU1i5Yu80bq1KdSXrXtAYhGQeiBoPfjwDlpmlP9pjSDgyCa1FmhxLmkC?=
 =?us-ascii?Q?LZ2SbcLq6Ob+czgbK+Si5KY8CEHCBPzUp7eq3VRV4KhMy9guubj23pt+7SaW?=
 =?us-ascii?Q?hnA6Ectp1+IIvN6zY2VRJ6K3ceh1p5ZUN5U5gs6nW7id5bhcMHcS0h344LNA?=
 =?us-ascii?Q?TlzaoK9icGwZre9rs69aUGChcT4PdYRrhKxiYbJuuRgK7Yl3J1Vt8KXopYx0?=
 =?us-ascii?Q?C5gYWLkZHrsL6dY06if0BFGtAkrWkSa60ZLKqNiWDonkI+v3kyzWxOsQOIfd?=
 =?us-ascii?Q?gtZOfSoF9nSj3dLfilAbavUlmKwxOUvfjLLYlhHyVeLQ02EVfk4X8JncXSCp?=
 =?us-ascii?Q?+ukwl+Zd+AsOlZwmFS1H+thlKCL/EIGGR8pLyKDFkNjHM4ea9zh5O3QZ7wCO?=
 =?us-ascii?Q?qcoIisnAOvKbzmDPQkcluFchtG2lnen8q5hDlEeLIcINb+MXibXC4f0qvRxt?=
 =?us-ascii?Q?nwqAs8XySJNXz7kCVGWfHuoauudwoYB+ZWcHR9u6Tf/O40H7Lt3Chx55cRz/?=
 =?us-ascii?Q?g3Vr4B2tmB1ZFBU7qrYHyp+uWbvxhtXUckG6d+/DrIjsHzGHkrhr3tllDvPd?=
 =?us-ascii?Q?U8U8NoSvpwOzUq5Kdw7WDbRBTfmCYnltTo1rBbq5e7EtR8KPO623pr8sIhQ8?=
 =?us-ascii?Q?cLPZWDtSROFEHiAxz/VS5C1Hr1whK4mGYxjt+57DyISr7WorJmwIaHjQzDVQ?=
 =?us-ascii?Q?1wB7di+hri+5/Y5R6+iFO8qHu0i0hOjjFu8hqB6CpAoph7je9iqCkDdQjoYF?=
 =?us-ascii?Q?S2rSJWxJ/+kXt9XbR6Isn3kCfoOsIjy4HHJZvO7CBZAfvHEQ++WH4R6+1s/e?=
 =?us-ascii?Q?bhfAdJr8ZqvOpuZyyhT6lpv4Gw5SI6PXzTU2tFh6sFeD65egVAotJz2s29+G?=
 =?us-ascii?Q?ZslZa6ay85aHRr/3Hm5pGRzy/HI5eJxF08qNZYW/7xL2CJkRF5XcRHefUKuD?=
 =?us-ascii?Q?BnfeXSJ5+eWMwygwrVHa0VsfNkJWN3ksQGjlK7rC+GGEurD/twubGPgN+mAQ?=
 =?us-ascii?Q?94I3YcVLgtT4hmeymXKPLSSbdXXbfvm9YHuI4onP4aHqowNhX7s+cUcw1kyk?=
 =?us-ascii?Q?ZVu99U8nvxzrb8jDaulaUv4s6v1hdn+GqTGAbfPKSs0nlGbvSMLIoKo32etk?=
 =?us-ascii?Q?zuViFfoZjByw+IJJMuqIk7xvou0dE6wuKo1pFJ8l1hettN8rckcv5BNy1Of9?=
 =?us-ascii?Q?Et8Bp2er5BWmvaksAvxk1uCKgFfwxJV+JBggjBmvldTE1p5zq89/I3CaxoJz?=
 =?us-ascii?Q?80KlEPUquYkeF4ITL31rM3yPTa0InIEDqX/u8QZu8oKfS6ZiLVwlca4huaUl?=
 =?us-ascii?Q?TbbrEsEJ1UPJhtp5dNfkVTe5bLDsHzvcgXtfx7V6oNW747mHmO+2aMeeN1Gj?=
 =?us-ascii?Q?2mIvCjiOMf4G44Dft+k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c62d58b-373d-43a2-034a-08da98113592
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2022 18:28:10.6505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vRX2uzBJDLZ0w2J6UIL51XuVhHVRR/5l4krpEpEy92lsPx2VzvGgtP4LMbEZgAbk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6328
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
> From: Reinette Chatre <reinette.chatre@intel.com>
> Sent: Friday, September 16, 2022 10:53 AM
> To: Moger, Babu <Babu.Moger@amd.com>; James Morse
> <james.morse@arm.com>; corbet@lwn.net; tglx@linutronix.de;
> mingo@redhat.com; bp@alien8.de
> Cc: fenghua.yu@intel.com; dave.hansen@linux.intel.com; x86@kernel.org;
> hpa@zytor.com; paulmck@kernel.org; akpm@linux-foundation.org;
> quic_neeraju@quicinc.com; rdunlap@infradead.org;
> damien.lemoal@opensource.wdc.com; songmuchun@bytedance.com;
> peterz@infradead.org; jpoimboe@kernel.org; pbonzini@redhat.com;
> chang.seok.bae@intel.com; pawan.kumar.gupta@linux.intel.com;
> jmattson@google.com; daniel.sneddon@linux.intel.com; Das1, Sandipan
> <Sandipan.Das@amd.com>; tony.luck@intel.com; linux-doc@vger.kernel.org;
> linux-kernel@vger.kernel.org; bagasdotme@gmail.com; eranian@google.com
> Subject: Re: [PATCH v4 01/13] x86/resctrl: Fix min_cbm_bits for AMD
>=20
> Hi Babu,
>=20
> On 9/12/2022 7:54 AM, Moger, Babu wrote:
> > On 9/9/22 12:00, James Morse wrote:
> >> On 07/09/2022 18:59, Babu Moger wrote:
>=20
>=20
> >>> Fixes: 316e7f901f5a ("x86/resctrl: Add struct
> >>> rdt_cache::arch_has_{sparse, empty}_bitmaps")
> >>> Signed-off-by: Stephane Eranian <eranian@google.com>
> >>> Signed-off-by: Babu Moger <babu.moger@amd.com>
> >> Er, who is the author if this patch? If you are reposting Stephane's
> >> patch then there needs to be a 'From: ' at the top of the email so
> >> that git preserves the ownership. You
> >
> > I can add Stephane's name in "From" if it is right thing to do. But
> > this patch was modified from the original version Stephane posted.
> >
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flor=
e
> > .kernel.org%2Flkml%2F20220517001234.3137157-1-
> eranian%40google.com%2F&
> >
> amp;data=3D05%7C01%7Cbabu.moger%40amd.com%7C69a28ad3fcfe444404a50
> 8da97fb
> >
> 82ee%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6379894037788
> 16201%7
> >
> CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI
> 6Ik1
> >
> haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DOnLKz6cBiypVvv1x
> 8PSv1JUz
> > ugilG1Gpwgkcz55ydqI%3D&amp;reserved=3D0
>=20
> True, but also please consider what Stephane posted originally:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
kern
> el.org%2Flkml%2F20220516055055.2734840-1-
> eranian%40google.com%2F&amp;data=3D05%7C01%7Cbabu.moger%40amd.com
> %7C69a28ad3fcfe444404a508da97fb82ee%7C3dd8961fe4884e608e11a82d994
> e183d%7C0%7C0%7C637989403778816201%7CUnknown%7CTWFpbGZsb3d8ey
> JWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
> C3000%7C%7C%7C&amp;sdata=3D2mTjDYC9B%2Fr6HR6SlwToWXewsWub2rfPQp
> c9JIkETus%3D&amp;reserved=3D0
>=20
> A "Co-developed-by" may help with attribution:
>=20
> Co-developed-by: Stephane Eranian <eranian@google.com>
> Signed-off-by: Stephane Eranian <eranian@google.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
>=20
Yes, Sounds good to me.
Thanks
Babu
