Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C615BB229
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 20:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiIPSbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 14:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiIPSbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 14:31:09 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E416B72A3;
        Fri, 16 Sep 2022 11:31:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iNyp1iyBrXfYfEXBaXIYCiEs03ydoC5v46W6gexRjzs4uv8IjAmJo82g6LMqL8Wry0315/AEfK70JNOXNyLR+0KPYQk/nWMAvLyqWpSGcaN86tUlLLy/vcyOEc+eJk+0oSxB3lambSxz2D/liOSCX6qJ+a7PmIRX7peM4eRu96gEUeu5B/gGJ+AOlh3hX1D2i15yAgM+Ejijo/wfVkACVPZUoXdzJuSCyzKwJsc4azoXIa57SxPzG7hxeGSY9g7Qvo0waJzw8SLLxAJZy4Vs/MsjwLKTEHQmC0laoX7RUdWoZMwSQqXhRctS2rZqjBotOs3rAwdQJ5JiNZSShh0/rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+GxoxMgVFdMr3XqTGbuEN02btN8GUrPuLw45Nq//hE=;
 b=esQXmvDF0tfVRXbuuCJCi7fUXOemDc6oyHKuid97mH0kzz+RZkq610JuVy7KnhBV57NPHSVdLhPnulIYe6Hp7JdOBurya7mA7vv2JUKQWzcRsA+AFkMmYeORc/HaTJoIE7TcfYgtMoKeq6SG7kNmxgfpF0UCpMp8A6AAqBJp8sqV3CUpxsMnNggXPurFnIXuU8B6cc1/Sl/GpGy4RmHlovvNWY7Il+QxevhCwvj5UtwB/hk5YmRZh70Q7hPApEk4U/SdUSlrdZmY3LprD3vgmxHyXqjdMsnjKsBdNn3udKm9ZdyFayj30JBn1hcXtIjwS21Ql1oSPK+CTj2RpsAD+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+GxoxMgVFdMr3XqTGbuEN02btN8GUrPuLw45Nq//hE=;
 b=cfmpg18hk5bV1Zaz8UDdtUAZHE/Mi2+w00IlGm4UTCppEGc97AhkvMmFlXiyftvVhwjJlTy20rX67IYTU6GmE52LaZCMrSgHIVG6uu4FdYkDfJNngJ+XbnwUJN7C9rCDiVpFeRkMdvLpD+nJuE/90tk3zqP7Hb1CqRwEmlCxeZU=
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH0PR12MB5092.namprd12.prod.outlook.com (2603:10b6:610:bf::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16; Fri, 16 Sep
 2022 18:31:05 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::4120:60cf:46a8:7109]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::4120:60cf:46a8:7109%7]) with mapi id 15.20.5632.016; Fri, 16 Sep 2022
 18:31:05 +0000
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
Subject: RE: [PATCH v4 01/13] x86/resctrl: Fix min_cbm_bits for AMD
Thread-Topic: [PATCH v4 01/13] x86/resctrl: Fix min_cbm_bits for AMD
Thread-Index: AQHYwuOozRcLHsbJGU2Nw2onSO0Px63iQw0AgAAr7vA=
Date:   Fri, 16 Sep 2022 18:31:05 +0000
Message-ID: <MW3PR12MB4553557C746E9B432AA5935195489@MW3PR12MB4553.namprd12.prod.outlook.com>
References: <166257348081.1043018.11227924488792315932.stgit@bmoger-ubuntu>
 <166257359679.1043018.9253512972611409799.stgit@bmoger-ubuntu>
 <7c88b2e8-2cc9-404e-7167-6743d796b0cf@intel.com>
In-Reply-To: <7c88b2e8-2cc9-404e-7167-6743d796b0cf@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-16T18:30:22Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c103d8ee-cf11-4e80-8436-fba5d18a8638;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-09-16T18:31:03Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 0694db06-217e-4d92-8701-7e1d6c1ab9b1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4553:EE_|CH0PR12MB5092:EE_
x-ms-office365-filtering-correlation-id: 32962224-b0f4-424c-476d-08da98119d93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k+abPJ5NoY9WUkFCK9xRy4pKPP1D5Y3wxWAockKKQS7Tz3U9VYEiL9cOKAPXbVZov5asv5IbK7yBhcUF2crQjszKbRng/r4KjfeW76cRhfJZVQJLpu0EVPjXPenGJbGjOr8gZIN7sJffPPDBye8n8zUBsawi7gYrklzbKv5q4Z52BIMNcRwNu4ws4LOURHzN3mNPh4+jwohKEppzCVORPL4us+OhF8qkIL5i8/RtRwGspIkUP0DIYqMgcUUGL2OVuwwguEF0MnyvI36kREnb4viCYuamrMFFKcY/bfAZ8t226P/3VDnMkuAKKQT1pjsAHojK2ZxOJoL3ZPC5BNlPK3RP51z24obI4Ei+7XVwMmVbOVBkU0fPZTmMNZ4Wi/WCuFvZQ6t5xbIpc8pWyKUC0rMW6XWKGtFKbpOrE1pcaaKPVIsPJHEmz723ltlfDdih8yrM0UMgpqwt7aHkUXzxPhdK39rdC6Y4tcy875a/8F4xP9yNqeRXzZdCFn2UAQ7dpOnEx3yT76b0n9uuk/njxoqA6csgYdDDc7vwq7dd12BR5w/hJNzd/ovejSV9p+h1u0t0yhEUYzEIqz+g5fktN95kk0khM5uWO2SOXEPyiztya4Eh0SrZO2OFtZucI5w39KDrjIAVAkPx3MwsIVRAu8cIDuCR7dORcJAFZuKq4OALwLXIQDzNgnVTwmAeAgVz1I72TyxEpIZ/3zh0rwFvO5JRWdHB40QETRDJPHCPGEcHwMGNFHwhTVEb6UG7+/XOPuf/9khwkfU7QgyemGxMxQdbWZgmbH6QRYyd88/LR5M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(451199015)(52536014)(64756008)(66556008)(66446008)(83380400001)(45080400002)(110136005)(7416002)(54906003)(2906002)(38070700005)(33656002)(86362001)(8936002)(66476007)(122000001)(38100700002)(41300700001)(316002)(7696005)(966005)(71200400001)(478600001)(5660300002)(26005)(76116006)(53546011)(4326008)(186003)(66946007)(9686003)(6506007)(8676002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2aRod7TcUAS32p0yR5UQtxflzR8L7t4YjdKt9nB9EwHgpetOA1cEvyz3Hk5I?=
 =?us-ascii?Q?KIvP6AwaMyLmhRnTkR2E287GKboh3Eiy609I3RqosjxL9iCfVTn8AMx54Xcl?=
 =?us-ascii?Q?Zk1ESFS38IAL2BWPGjIlDY28zMzWBiuSDdpzFL1KxRJTmQRG+lsVmxpzN2IX?=
 =?us-ascii?Q?fpQ67Yamn9f32rrJlh1SWWFZEZLxEzzJ31YHy6wqZpu1lCyVtAvYMVR/vvev?=
 =?us-ascii?Q?VRKUPYPVWNVeTGGdN4CAD/Pz9BCkEsUUBiFoF5cnxRaE6tNSTGJcXgh/aVbJ?=
 =?us-ascii?Q?28ajXe0dgqFrBSlxxjdaIFtugFRw9/req0JEvz9pikeIocJNtNUosF7kM28z?=
 =?us-ascii?Q?9WJn9m5qI5ZpZJpdmrWDIRg7RwpcoGJpjO0B0A0AwKmgXfb/mrUKeaPvgTd1?=
 =?us-ascii?Q?++uJhS/g8oszT44ymqlm5X6pv7XaM7nKrQ+6mSCFpku7dMMiD6m401HTl9R0?=
 =?us-ascii?Q?nxfWvwt5eFnA15uvQvlaSOjM9YspKXzePt2IQrccNfH7Zr+ks5wgtGU8y838?=
 =?us-ascii?Q?DDXGFyn98bdRJBzE7UVXYFaU/NqnYZMDyj2BRkpAGjkWZ0k/08nnqczq9VQr?=
 =?us-ascii?Q?jE9yXHWJb+D0tL60NRSZfRXxYi9eujqNySQqse9TsOwZvHSnLvqnCl/DZrVG?=
 =?us-ascii?Q?z2lb7yzLdUoWJe3wKWuNxqCptTSKLKtQ7Uda+9qvV1VazAqRBnRaHUw/uiA9?=
 =?us-ascii?Q?39hGIwJN5TS1s+f3RGwtW8tF+cz3u1dPhd7vKnPRG1vCcrLfNUDrmtxxzkl+?=
 =?us-ascii?Q?DwghlaXO6t/cFUy7vMGM0qwtBkrvvXP5tFCbKYPfSaQHMRUxnNbGaZQjZDLl?=
 =?us-ascii?Q?/xVHnK5pOCbj+U7cniJbShlqSTN3Nq/lT4vNaPQPzVXwrZfYdz6R/yI1l8jm?=
 =?us-ascii?Q?3Q1nvVCt6gUWHyLjUrEmwoZ2cWelxhPq2Sw8mhb1GrXAPE5Jl8FYy7D3T7aV?=
 =?us-ascii?Q?b9AcuzkDzofyY5McmhiILnNrd1YFyM80JmNozUWMzIELKbC5eB+nBmxHa73Z?=
 =?us-ascii?Q?F4R6EFtr4xyKyJq0a4qPtIy9V55Y/op83HnRvQa5QfWuCLgYca0A2EZtEj/E?=
 =?us-ascii?Q?ePUVVIueFG1QziuWmNtbtsGhEQpo6KaVf/jSGEdEt2GMRnojCmTpSDyWyWWS?=
 =?us-ascii?Q?bsW2QtA1SbE0qIHXFP6/vMhgVvW/KHb5zlSG8P4l7gsso4G7gvmrjBLHcf1M?=
 =?us-ascii?Q?DJshNao/YOmiBfO8N/NY1TgW7ZQN2XBrSLedlDoohggAWQhVj6UjQILWYv/4?=
 =?us-ascii?Q?mj6JgL8JhrKuabNzocN5rx9BKJVU2mxVtoKjlbQCf5KTldQ1Oz9vSRq6obRd?=
 =?us-ascii?Q?XCWwSxKa+GldnlCVhxNfD2zj/a/Yd6IgCC9D9Dv/82oqu93FwQIEeqSQkBuO?=
 =?us-ascii?Q?PdoNEm3z1XUw8EDLkERSudlXMoJdF/1VyItnKPRh31Fi4RNw9Ii04gG9aRNV?=
 =?us-ascii?Q?dXOAqnSBXrvz1WHtMa6lqcbhZjJLkhoaQfPIvdR89CHkzdU1WGJglcYXgpiA?=
 =?us-ascii?Q?sb2V17qfJNZHpbkhuV+Aohfq0dcFHwXqYQkRt5TCMgEg1ljHopZlasXMjM2l?=
 =?us-ascii?Q?c+RIW8zhy6os2Lv5ZPQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32962224-b0f4-424c-476d-08da98119d93
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2022 18:31:05.1731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mB7CpQ/gE3QWoK32OGGom2R//PMHtNicJWROe1N0Ro4XgZU3NYgpL6fZOQG02o3w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5092
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
> Subject: Re: [PATCH v4 01/13] x86/resctrl: Fix min_cbm_bits for AMD
>=20
> Hi Babu,
>=20
> On 9/7/2022 10:59 AM, Babu Moger wrote:
> > AMD systems support zero CBM (capacity bit mask) for L3 allocation.
>=20
> Above mentions "for L3 allocation", but the change impacts
> L3 as well as L2 allocation. Perhaps just "cache allocation"?
>=20
> > That is reflected in rdt_init_res_defs_amd() by:
> >
> > 	r->cache.arch_has_empty_bitmaps =3D true;
> >
> > However given the unified code in cbm_validate(), checking for:
> > 	val =3D=3D 0 && !arch_has_empty_bitmaps
> >
> > is not enough because of another check in cbm_validate():
> >
> > 	if ((zero_bit - first_bit) < r->cache.min_cbm_bits)
> >
> > The default value of r->cache.min_cbm_bits =3D 1.
> >
> > Leading to:
> >
> > 	$ cd /sys/fs/resctrl
> > 	$ mkdir foo
> > 	$ cd foo
> > 	$ echo L3:0=3D0 > schemata
> >           -bash: echo: write error: Invalid argument
> > 	$ cat /sys/fs/resctrl/info/last_cmd_status
> > 	  Need at least 1 bits in the mask
> >
> > Fix the issue by initializing the min_cbm_bits to 0 for AMD. Also,
> > remove the default setting of min_cbm_bits and initialize it separately=
.
> >
> > After the fix
> > 	$ cd /sys/fs/resctrl
> > 	$ mkdir foo
> > 	$ cd foo
> > 	$ echo L3:0=3D0 > schemata
> > 	$ cat /sys/fs/resctrl/info/last_cmd_status
> > 	  ok
> >
> > Link:
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flor=
e
> > .kernel.org%2Flkml%2F20220517001234.3137157-1-
> eranian%40google.com%2F&
> >
> amp;data=3D05%7C01%7Cbabu.moger%40amd.com%7Cfdccc20e6a234fb3872a0
> 8da97fb
> >
> 94fc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6379894040498
> 44076%7
> >
> CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI
> 6Ik1
> >
> haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DDIpkBAkI7lAjj5QQ4
> 5VahssT
> > dWGj%2FcUwGJDiHXNYzz8%3D&amp;reserved=3D0
> > Fixes: 316e7f901f5a ("x86/resctrl: Add struct
> > rdt_cache::arch_has_{sparse, empty}_bitmaps")
> > Signed-off-by: Stephane Eranian <eranian@google.com>
> > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > Reviewed-by: Ingo Molnar <mingo@kernel.org>
>=20
> (apart from the changelog nitpick)
>=20
> Thank you for clarifying the way forward for this fix.
>=20
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Thank you
Babu Moger
