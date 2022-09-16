Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543DF5BB29A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 21:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbiIPTCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 15:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiIPTC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 15:02:28 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1888227FCF;
        Fri, 16 Sep 2022 12:02:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UuUefu4A1XrXo8amVMP6k9hNvDzX5VBBSe/qYzwv/JiwMNG5n4s+kjyNCImBhC7/ayT0co2I9E6R+FIgFUfqFcI8k13HWq0AMHwBPtC+MWx6dj0xd1azfV/FoMUibrAlMS/dXqdpRzx+oJpYbvrWwbkk1+Nw1g6BSULvBO+Snz70tatCC1GRyNz9T7cOsHZpt0Fstk9S5ui92b2H0O5AuDVEW+cdhS68KIsVGPQxLSd27rp+3eZyLwWX6tLLdj+HH08YlScWiFrM32uOKog2X8QX7BTWKYFvBnxoNF+OkyJcd83xgvxe6kEVd/SvK0UxcyDCmotD3KXwZeXyEE4x5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tIXTIt4vsfMXqa6O3rKv6nKPH1QAxTF/YAGTybWRhkI=;
 b=PaYHxtMwuH863oNPrQ+Z22CBvoYdjBwxdrP/uGO7bD1VGJiGhwplnPr5Iu6GYsv+SxloEUy6rRp8cEvctezwSh6qh5RJLK+4bSbsqcjyMRzqIVeX2e9EWyWT8+kl86lUrzGqkp0uvu1u3taM8v1mTSZk/xyJexomxeHj1/8hxRDKta/YVUpf22oda5p61q6FIFzmXNZt9LIKzuKDWOkZKMZdVHe2AeKct3zee8r+t78dzPSFGpBR4DUg5oD/tF6EOV3Bmm9RJ8zUNFgvdd6XNKLy1tzI9RaeiwPnvOw5TirXs1gdh/KXBiKLuOsO7kGlkMR08WMkcOfRYlfrrf7rKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIXTIt4vsfMXqa6O3rKv6nKPH1QAxTF/YAGTybWRhkI=;
 b=LkdWjXz0iM3sprw5mXmBsUAqgEC8ykHrqodU05pj1VBudOffZvXQZHID6lEPgSYOz4o3NosDQIYvTuGJbojKOdA7V1EhGnMNanPJMpA1lvmcj52NBg0f5r9I8fMhAtHcm8yk+RWdwFd7C+Ge98RTxvIr2gNHvbEjria6/v46xNo=
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by BY5PR12MB4871.namprd12.prod.outlook.com (2603:10b6:a03:1d1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Fri, 16 Sep
 2022 19:02:22 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::4120:60cf:46a8:7109]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::4120:60cf:46a8:7109%7]) with mapi id 15.20.5632.016; Fri, 16 Sep 2022
 19:02:22 +0000
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
Subject: RE: [PATCH v4 03/13] x86/cpufeatures: Add Slow Memory Bandwidth
 Allocation feature flag
Thread-Topic: [PATCH v4 03/13] x86/cpufeatures: Add Slow Memory Bandwidth
 Allocation feature flag
Thread-Index: AQHYwuO2S/v5Jg6pDUqKmPNExiXpc63iQ2UAgAA0BLA=
Date:   Fri, 16 Sep 2022 19:02:21 +0000
Message-ID: <MW3PR12MB4553B766C278823844C8155695489@MW3PR12MB4553.namprd12.prod.outlook.com>
References: <166257348081.1043018.11227924488792315932.stgit@bmoger-ubuntu>
 <166257361558.1043018.12046795385220064687.stgit@bmoger-ubuntu>
 <ba36c68c-0b13-e8a2-fb45-8b84ea9f7259@intel.com>
In-Reply-To: <ba36c68c-0b13-e8a2-fb45-8b84ea9f7259@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-16T19:00:32Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ce53a0e6-45e4-4af6-ad6a-1a2983e23e70;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-09-16T19:02:19Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 11a76ce2-b1d7-4c9a-9778-f472e26bac2d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4553:EE_|BY5PR12MB4871:EE_
x-ms-office365-filtering-correlation-id: d132b0bb-a130-4eb1-a8a8-08da9815fc48
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CXLDthdQuq4chD7VvfycfFRGxp9aG5PSY+wGWxeNMINxRpH3bq2TUdVqxwsLyFJ4EnaQrFPdw2gRzt2S02eVRRlW/FV/lJJRCFxaG0Q9Cc+yq9Tpz1NdfiCTwWBN0FhjuhuPdb5m7fkZjrFh1FVpb0ZDkUlVorPc3eDTbOy9HIDvExM1xu06vJliiOdvmwWJ16SIHN9u/dLOwVDVgoPAQmvqwx2nXjpAgalXRkuSoHRMbmKZgxmVhLQ2XcC2Mc7iJ5RT0SwzhgcIobelwwXIYZt6Z/tz8dAnh9Lzd5fVYtTMDNYE0+nelolV7CJC2AiBYOnmUuzN0jflo33c29X4y9UaWmjKfibmuJKIiI94CzPFG8yHv5r0KP6Ei2UCOJMWlXxgzbNECsAfeEmOGbz6EtPtNiALiUltwJAa33+qKHiw8keAAsy6wj0GD7NJag8vmvJcSzje9gOSmCXH0YfQLD0yh5giafjHoSEL2ZNOyu4fcVX8K04Fu8Q81hljJeV/01HrhzxA6lxH+NlE0AYvaOor8VLNEvBuVERZHcsBfGoVUm2eB3ZX5LVfgQYhywqRA7MOwnBvEvOPzN4mayu6vMFV2P4d8BvFxqAbPorjgyw6CpPoUE0phiP7Jm21QRuibV8GEKogxo/mdRpuVDNB6OQ2DjxIltX8qvltYcpdH5SuwHbtsXdc+ksfZ+d4MCmM7M5lNh0cXdBCHZDRPeDrb34oKyR6WzqU98NIeflz4JHaJ+eM3mhUuM3Wry6GanblUeyuMOwUjdF7d30+e3euH5VrlJtl0gCiyPXU2QKBn/3upf7MvkU4AwstBuQRRZToN8IqghnHJiRXWKnh++2qJg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(451199015)(38100700002)(66446008)(54906003)(5660300002)(33656002)(55016003)(64756008)(122000001)(66476007)(6506007)(71200400001)(66556008)(110136005)(52536014)(4326008)(53546011)(83380400001)(76116006)(7416002)(8676002)(478600001)(45080400002)(41300700001)(86362001)(186003)(316002)(9686003)(7696005)(8936002)(38070700005)(66946007)(966005)(26005)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Anyo+ixmiJR2vcbIpS1y3Ob38PCZlyuPRykJo84qa4884rRBNz4qn9EQiGhw?=
 =?us-ascii?Q?qcj+e3TgMxtMzjKKeGadWoKso3hfE1wskAFlJaSyYq4+YWb6G33em2nu/YF8?=
 =?us-ascii?Q?0BdMDB2CgLYP9bNmgHMpoGn7OTwngotHSvfaLQVAKp8jgZGa4Id52PTeZybP?=
 =?us-ascii?Q?t9ORXvjdMzto8GVwtQcntfgaW6krUqhDkrnUIT2qnz3p/aHsZMfaTjlNtdJT?=
 =?us-ascii?Q?SPOYtbwdyOfQZv6U+XnQtzqVwEF+JvPbi4pNLQXN1CV8rpAczKeMMIoKK1Y1?=
 =?us-ascii?Q?VacZGdntixh+Sa+8GxjWCEWE3ICfg68vXhJqmdX2zEz7EARxa0305M59wi6d?=
 =?us-ascii?Q?HxGmNo4ZXXdzwiIsi/KPlAkJhFB+Ixx4fjEhdAHN1dLDS9aZE/RdHFqep1Bo?=
 =?us-ascii?Q?yaSGo3HDCQG+94ze69e+pels+eExeEKUPO4hzsXgIgidKwMKO5xupANT6C6z?=
 =?us-ascii?Q?bMSkpuJobBfe8pF1tq3yZCxZ9L5O6yrbfag4ACMSRUN8gXi2nGhlh9ZQgrlH?=
 =?us-ascii?Q?VPmbdytGVTp1CO0kTfLJ1aYjmP2GgqZoGWHDjHKrnn+uxSFqVxE1cW3cvIOn?=
 =?us-ascii?Q?MAriofqHL8JrVqqVcQhTG+lyWcsrJkbLiSxl6YhUiGH0SuNhHjRIpZxC3LK4?=
 =?us-ascii?Q?1zS74Bbze5JduZZdGvQuCA4t/vD0dyojj/Al6JU3zJBgO3NEono3pe6/FgFh?=
 =?us-ascii?Q?cPfxcVA811GSGoazLyjIT61+fqr/dxq5jp2ZfDqHuCMAvoT5E+54bzZDYJG4?=
 =?us-ascii?Q?oQhOp4xYFKdZbavtpIm0i19oNjYTTyJLys4MjO0fMxYdDAvjfAllxKJVKkYW?=
 =?us-ascii?Q?rjs6yqCprIZ1ZgjrYwW/k7FuM5OeWTBtjKr4BlWDnezq2htVm2BeWeBQdRa6?=
 =?us-ascii?Q?/GGZ0gMFIBqrCRX76hOrn/wQyO4rK/rK6P90oS5nHJHle7OO0/yxhooA94v9?=
 =?us-ascii?Q?nz7e4Tj7dp2uMNiW/Iyv5CcT7dPBf2a3Y1P6VRvmRJASIUjxGBYW4FYvbVZ9?=
 =?us-ascii?Q?VHJWlisqXKLLpF6X0ikkW4zX72P9vmGOhITH+GD+4bNxU+LPfB708cYjeIcy?=
 =?us-ascii?Q?Owp0A4q6nH+osAz+hqc65nLCrF7x+5cM7D0oE+2yorSlu9RlN1bc2jtKBMML?=
 =?us-ascii?Q?LrSrhV65NcRwiPMpIFR4TefIAqoPr4Ol4SV9Zjy545l3ItGACSCZGCPGFkq3?=
 =?us-ascii?Q?DyZFuoNP4bdFYEXG/TWDvq8MjYGj5TJspb5ddtQwzDqBR3PZ1o1buPo8PCoU?=
 =?us-ascii?Q?W2LaZIOiHv1I+R4uwDyVOHny8fFxhtTO7kBY2f8E83zPQwTXGQ277a4+Efyh?=
 =?us-ascii?Q?nDIRo9tfnz0E8eeJ8mxQGTz2A2x//0d9RuIAQeSxt/YV3bziKjcoctSrFcsr?=
 =?us-ascii?Q?+yDViFSq2AvFxWKGt8wGsmC9Uhr7IydVai/xVLDrx28ub24+3xYhfyylwaQD?=
 =?us-ascii?Q?Fou9qxV/UufyDdXzxeZ8DxaxL0HHY4kxy3hFf42nxATeE9lUREZJr0ydpKIE?=
 =?us-ascii?Q?XF1KxttH3sLuNfRsOEMRLjHjhmIIO92Xww1Gx4ZLNi3KJrEAGMpE6YH9YX1J?=
 =?us-ascii?Q?A8DZHsGRZG49xAaGjMg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d132b0bb-a130-4eb1-a8a8-08da9815fc48
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2022 19:02:22.0233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rNY0S2+sxoeEZaB2/w1J69JO82Q/yy1MGqZAl7E+Gxr7ZX0CQwH11kzKGqReXsty
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4871
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
> Sent: Friday, September 16, 2022 10:54 AM
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
> Subject: Re: [PATCH v4 03/13] x86/cpufeatures: Add Slow Memory Bandwidth
> Allocation feature flag
>=20
> Hi Babu,
>=20
> On 9/7/2022 11:00 AM, Babu Moger wrote:
> > Adds the new AMD feature X86_FEATURE_SMBA. With this feature, the QOS
>=20
> Adds -> Add

Sure

>=20
> > enforcement policies can be applied to external slow memory connected
> > to the host. QOS enforcement is accomplished by assigning a Class Of
> > Service (COS) to a processor and specifying allocations or limits for
> > that COS for each resource to be allocated.
> >
> > This feature is identified by the CPUID Function 8000_0020_EBX_x0.
> >
> > CPUID Fn8000_0020_EBX_x0 AMD Bandwidth Enforcement Feature
> Identifiers (ECX=3D0)
> > Bits    Field Name      Description
> > 2       L3SBE           L3 external slow memory bandwidth enforcement
> >
> > Currently, CXL.memory is the only supported "slow" memory device. With
> > the support of SMBA feature the hardware enables bandwidth allocation
> > on the slow memory devices. If there are multiple slow memory devices
> > in the system, then the throttling logic groups all the slow sources
> > together and applies the limit on them as a whole.
>=20
> The above is a useful addition (made in patch 13/13) to the documentation=
 ...
>=20
> >
> > The presence of the SMBA feature(with CXL.memory) is independent of
> > whether slow memory device is actually present in the system. If there
> > is no slow memory in the system, then setting a SMBA limit will have
> > no impact on the performance of the system.
>=20
> ... could the above snippet also please be added to the documentation?
>=20

Ok Sure.

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
> > CPU list for CXL memory will be emply. The cpu-cxl node distance is
> > greater
>=20
> emply -> empty?

ok
>=20
> > than cpu-to-cpu distances. Node 1 has the CXL memory in this case. CXL
> > memory can also be identified using ACPI SRAT table and memory maps.
> >
> > Feature description is available in the specification, "AMD64
> > Technology Platform Quality of Service Extensions, Revision: 1.03 Publi=
cation
> # 56375 Revision: 1.03 Issue Date: February 2022".
>=20
> Please shorten these lines to the recommended 75 chars per line.

Sure
>=20
> >
> > Link:
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww=
.
> > amd.com%2Fen%2Fsupport%2Ftech-docs%2Famd64-technology-platform-
> quality
> > -service-
> extensions&amp;data=3D05%7C01%7Cbabu.moger%40amd.com%7C60553f32
> >
> e9ab4ed1219c08da97fbc048%7C3dd8961fe4884e608e11a82d994e183d%7C0%
> 7C0%7C
> >
> 637989404770663129%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
> AiLCJQIjo
> >
> iV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdat
> a=3DWY4H
> > EzWHdMpMUUR%2FBnBupwdHuQ6O2RfdrfcGx4TkXfI%3D&amp;reserved=3D0
> > Link:
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fbug=
z
> >
> illa.kernel.org%2Fshow_bug.cgi%3Fid%3D206537&amp;data=3D05%7C01%7Cbab
> u.m
> >
> oger%40amd.com%7C60553f32e9ab4ed1219c08da97fbc048%7C3dd8961fe488
> 4e608e
> >
> 11a82d994e183d%7C0%7C0%7C637989404770663129%7CUnknown%7CTWFpb
> GZsb3d8ey
> >
> JWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
> C300
> >
> 0%7C%7C%7C&amp;sdata=3D7e7sGH0iaEW8mlst5mK3fn9wy%2FYRhDU%2BbBm
> PWzSrGL4%3
> > D&amp;reserved=3D0
> > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > ---
> >  arch/x86/include/asm/cpufeatures.h |    1 +
> >  arch/x86/kernel/cpu/scattered.c    |    1 +
> >  2 files changed, 2 insertions(+)
> >
> > diff --git a/arch/x86/include/asm/cpufeatures.h
> > b/arch/x86/include/asm/cpufeatures.h
> > index 235dc85c91c3..1815435c9c88 100644
> > --- a/arch/x86/include/asm/cpufeatures.h
> > +++ b/arch/x86/include/asm/cpufeatures.h
> > @@ -304,6 +304,7 @@
> >  #define X86_FEATURE_UNRET		(11*32+15) /* "" AMD BTB
> untrain return */
> >  #define X86_FEATURE_USE_IBPB_FW		(11*32+16) /* "" Use IBPB
> during runtime firmware calls */
> >  #define X86_FEATURE_RSB_VMEXIT_LITE	(11*32+17) /* "" Fill RSB on
> VM exit when EIBRS is enabled */
> > +#define X86_FEATURE_SMBA		(11*32+18) /* SLOW Memory
> Bandwidth Allocation */
>=20
> Why is "SLOW" in all caps?

Will correct it.

>=20
> >
> >  /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12=
 */
> >  #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI
> instructions */
> > diff --git a/arch/x86/kernel/cpu/scattered.c
> > b/arch/x86/kernel/cpu/scattered.c index fd44b54c90d5..885ecf46abb2
> > 100644
> > --- a/arch/x86/kernel/cpu/scattered.c
> > +++ b/arch/x86/kernel/cpu/scattered.c
> > @@ -44,6 +44,7 @@ static const struct cpuid_bit cpuid_bits[] =3D {
> >  	{ X86_FEATURE_CPB,		CPUID_EDX,  9, 0x80000007, 0 },
> >  	{ X86_FEATURE_PROC_FEEDBACK,    CPUID_EDX, 11, 0x80000007, 0 },
> >  	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },
> > +	{ X86_FEATURE_SMBA,             CPUID_EBX,  2, 0x80000020, 0 },
> >  	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
> >  	{ 0, 0, 0, 0, 0 }
> >  };
> >
> >
>=20
> Could you please follow the coding style (wrt tabs vs. spaces) of the are=
a you
> are contributing to here? Please do so in all patches in this series.

Sure. Thanks
Babu Moger
