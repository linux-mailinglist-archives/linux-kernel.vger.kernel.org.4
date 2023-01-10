Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9751166373F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 03:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237639AbjAJCXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 21:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237624AbjAJCXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 21:23:06 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2077.outbound.protection.outlook.com [40.107.95.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D938B1838E;
        Mon,  9 Jan 2023 18:23:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BU4irJdlnfq2r0w9V5Xr8wcoUd0lN1jRVMh7WtvmZk8BFPJwGPOwggLk88zDLKKhoDp6AryRC2q6Y8S4TtJgAG7G+rDKezKv2voGSiFlmyxKhDRR0+budRQBryxI/rw8G9xbd+J2G5fcp3bcmd9uXC+ldXcG1aq6Ufh6e/jgLwAAjlTyuuGxJkXMzYryCIhNkrHEEeuBIdXhSg289pxYjT5FQGh/IwjTXkV6wpyYPNMix4+b4TOJ3iGK1Z7kKudRXBTjj84mh9bdIFBMnCWXvs11yiNxFTRDEb7xIen92u0PAZ71fT0aqyys+rNgbLdx+DTTo18hUUduj/tgrSbeUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cWynPxGOKLOK6uiE/g/08rb3ZHhSgJWlqUF3ZMi/NMM=;
 b=iwozV/sH1k3Kh9iepkX6wszbQPrkxK6ebOd0kxTJWbI5LVkovjpjyPEcKH7/0dHjJC5UN6vSfFmx7dtA4+Yvg39VBmUeEg5LJDODEfk7lXso3PBJX4NRh5dHxF8NfUkL5kGwZF2dhVqLdvUImVacEgKufVX6UUayanLIvD8+F7vRgzwkRkifi8mIflHRkY7twkqGpj4FD1eMaVxIjc6ZAiZRiL4kzxc0NhURALdt+KQP7hCHudDjrTZzkYKbQ32OJagf6e+LUtnakzgszE9H9tjVMOr6IYJ6YlrIvc2kdjHYvwT7METGQ9+6c80xA87bRscZQloDsMEVJqzd9uQZ9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWynPxGOKLOK6uiE/g/08rb3ZHhSgJWlqUF3ZMi/NMM=;
 b=UAENZV57bWsZ883T1V4ktw9l0DglxdlY9/W8b9mdXzqnlAi+03hq3x1upixrBmFxXSbJW9+N4bYefgAY5zB2Esc695Ltb5F8AcHxnCEI2/igXbXC70s4kCnNi1OOd4yHqVGE6TGV/ER2Mpz/w8NdXnaeYii9DysVbKYI/WfpmUI=
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 02:23:01 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098%7]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 02:23:01 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     Ashok Raj <ashok_raj@linux.intel.com>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
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
        "peternewman@google.com" <peternewman@google.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: RE: [PATCH v11 01/13] x86/resctrl: Replace smp_call_function_many()
 with on_each_cpu_mask()
Thread-Topic: [PATCH v11 01/13] x86/resctrl: Replace smp_call_function_many()
 with on_each_cpu_mask()
Thread-Index: AQHZJEmeo+fLqwnbJkaFOUOI5R0QDK6WuyYAgAAtX1A=
Date:   Tue, 10 Jan 2023 02:23:00 +0000
Message-ID: <MW3PR12MB4553FFAA412FB741A73009A195FF9@MW3PR12MB4553.namprd12.prod.outlook.com>
References: <20230109164405.569714-1-babu.moger@amd.com>
 <20230109164405.569714-2-babu.moger@amd.com> <Y7yiwOerGiEKAF9i@araj-dh-work>
In-Reply-To: <Y7yiwOerGiEKAF9i@araj-dh-work>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-10T02:09:19Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=6f41249f-7e8c-4665-a2bd-54b4700bb467;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-01-10T02:22:59Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 1e3e0c7e-89bc-4320-a96a-55bbca44e468
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4553:EE_|BY5PR12MB4130:EE_
x-ms-office365-filtering-correlation-id: 958c8ced-98f7-4111-6d22-08daf2b1989e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /X6Lc12Kq27EKPot/D28khhPyLUSF9zr/pEEZSZ07Avyttw+bl0/Wv9oCjn7LRo3bKHHN9zyqYwdY1witAjgz9TfIg/2GBhAj3aXYyG+rjP9hJQnSy/6iw/ehXGsgvbIVQL97yZ5tTMDZ2MPtz1Xz7/wpE6o1wutqpOFHt9l6lFH90Kfisvo1a7Cco8ZuBLxkEiTFPxZWmlrFOA4TcoQ7cVfBtlF/LY+XsSfinRbjg2mE72rqy6M5gbqey4kNfy3sI+GvoOUYqnnRbOrlT/rqgN2prZLk52kk0vz5bd3IG+E/C+3Ur0hrkHwTmYf3ATAPJn/Y5HGwgfFVdScTPqQTfpYRjHJS3YNjuE2gwpTMgXtknJpENT58Ov0ZywHbloHeIKcWrWbOZL4ePRl8grSmP4AR/0RJbj3t1jsAPck8UcajacHbQXaC8mpr4ZUKNBzofMUCm8tKazQAfxT6XI+SKkSNyE644juxLboVwi5CTFUCbX6dxaAo1hCK1elSt4GXbgzpZK2cBD2j3FCA18HDBpERnFtevwXs5PL4vdLWlyHHxp6Fgne6O0nEXSpQdMz/AHChPf/mZOJZbPdYAgGZiBJLiPvwLPGyevUt9+mQ/BkOqfMdBxxp4YNeuMZYbJSjFrZlU2zAFHjE9ZdSyADx3AQVoCfd0Mc946Nyib/6fG8y4NjusIq+pvDXHQIrM3v8Wmy6hsKo6p3mAnm6z+xSg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(451199015)(33656002)(2906002)(7406005)(8936002)(7416002)(5660300002)(52536014)(41300700001)(83380400001)(122000001)(54906003)(71200400001)(66946007)(7696005)(86362001)(76116006)(38070700005)(66556008)(6506007)(53546011)(38100700002)(186003)(55016003)(66476007)(8676002)(4326008)(26005)(316002)(66446008)(64756008)(478600001)(9686003)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?E6LMKMKWJtqvOhrvQFMp0M1JtUzu94PD8y/DfAVqZkw32iiIVtOL2/v4TTjG?=
 =?us-ascii?Q?+40yBsrwauhrZ6nydCGJa9RcyV3FF+8iZkfWPhJZbmIbVdH3B2iCHACTH0qL?=
 =?us-ascii?Q?YTfk2F27hAB9dYhtZIzdKxI4Tg3Om2Wlk/wwa95K8+9jJ5M/WaEIaK3gkeFp?=
 =?us-ascii?Q?4phvljuEBvch5zJb3W/sG4CzKM2ylIUluzE20XhzxWnNoVGVeoXs3AdXJ42p?=
 =?us-ascii?Q?sy9AwZn1CPawDkUCTChucA1XQQN6Jm90sEJhsfBtqT8W1q+wKPWAfG35+xYD?=
 =?us-ascii?Q?SgsT7MS3/5XYKQKGiAEEVvaDfJFwysSPVoDccnz26n5LmXla2NEFo4knAr/+?=
 =?us-ascii?Q?fFN2ybgXVB/H5Sg6Id/dccNSWUfXujoXjDo/MF0KNedGnmO3xIP0F/GtLDnK?=
 =?us-ascii?Q?bOw1XwdnCpn/p0QYZYsfbKxuAw8hFBo0tak4g0p6m6oH/p8GinLk07OzLUG0?=
 =?us-ascii?Q?Anqg64X0cYYdXzMQqJYPYvtckdtEBtiJ5ElKtTfmtBd+VcNKLCX1RyKwH3rh?=
 =?us-ascii?Q?mGCdUtqkirYaqfDaVoRWfhaUrotu9xuibX1Xp37JmdjZZnw2tNhXgXl7QMiD?=
 =?us-ascii?Q?bagOe11jO05UPv1gt5c+qX+QdumYgo+5C6Jn+cCVVvpzG58gc2O6xhJZfaxs?=
 =?us-ascii?Q?igQY1LqRzSEXd3/vmqSqZA/0rbprLXxyIVjDy/+kAi8ViNrl1qAGTTwL5tYz?=
 =?us-ascii?Q?Vgw9w0iYIWgJknPPG2RdcyshgpWEmGAj1CTVNaxfPGCXuGjf+M8tpu6K+81m?=
 =?us-ascii?Q?ELHn5+oomSWh3tbYOVoR2vg/wvP7LG7165u1DtfZV94h+j6ewGtqWs9xsfRu?=
 =?us-ascii?Q?KOrurHspZ9yk0PXfI0Mr5PHPpx/ZTSnktaFskJW2b1/JG3I9P2w1JUKjfbi+?=
 =?us-ascii?Q?VTjzW5DH/20RalViJzJy8QM7rO7emGsqQmEx2ntFSItNUNRC43XqPx4iSEKk?=
 =?us-ascii?Q?FquCTGG9T+S4PCAj7a+fHwYO+V+kSHqUZpCCqzhKlFTjic2w3H19sxJFD9Eu?=
 =?us-ascii?Q?NoZgO/ufxqJNnqgyHWPBZ3Kbw4fI2EVwMQQ/XPWU7uLZOgaR9fmWtz3JhXg1?=
 =?us-ascii?Q?ocaru28GYVLbwcPTm3DIgqHyW4lwxjI1e06cNxsiQhM7yIIl9/fmbj9Io98E?=
 =?us-ascii?Q?BdA18jGhBAnzgB6gbo8obR5Umrdn2GjcWfdl1m0brL5sja4DVyeDWdtB/MnJ?=
 =?us-ascii?Q?RTjhGPa8ZbYTt8zXK8y6vm+UEpeawdN/j+/BdJUA7l0B6QTbyBmGg1aa0KEI?=
 =?us-ascii?Q?gA+X0n4GvijioQZQhRsQtF1d4GqxjyOlrJeRhwS05PCLVGGVUSbPBbNPAd2C?=
 =?us-ascii?Q?uQHWQhAu/fmOq4ItqMTIEdPS7BPE5rDqzsQHX77YKbISpFlPZxkqyYSO0OoF?=
 =?us-ascii?Q?R6OIwBEwM7O3tci4+t+Ijw5sT1Gf33dq3iUpwGm4VepICY5EMNyLSCgkIpLw?=
 =?us-ascii?Q?FoZOhsrvsmFd/ucjItisqB4JhlIYuw+guRj6dsevAXYMC8MQcVFkOR8fmhlS?=
 =?us-ascii?Q?aPaF6xHO7Lc0mpWawiAdI0GOhr0H+z6AGq2oKbMUzEnluc0VQx9MRlWzpbiH?=
 =?us-ascii?Q?sGUSm7FIlgZFlYMudYo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 958c8ced-98f7-4111-6d22-08daf2b1989e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 02:23:00.9842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fSTWLh1f9MXPdgljp6ulCW8RFqWTKRODdlb0fJvWCPGfxnbD2yIVhHkFEy2huar6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4130
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

Hi Ashok,

> -----Original Message-----
> From: Ashok Raj <ashok_raj@linux.intel.com>
> Sent: Monday, January 9, 2023 5:27 PM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: corbet@lwn.net; reinette.chatre@intel.com; tglx@linutronix.de;
> mingo@redhat.com; bp@alien8.de; fenghua.yu@intel.com;
> dave.hansen@linux.intel.com; x86@kernel.org; hpa@zytor.com;
> paulmck@kernel.org; akpm@linux-foundation.org; quic_neeraju@quicinc.com;
> rdunlap@infradead.org; damien.lemoal@opensource.wdc.com;
> songmuchun@bytedance.com; peterz@infradead.org; jpoimboe@kernel.org;
> pbonzini@redhat.com; chang.seok.bae@intel.com;
> pawan.kumar.gupta@linux.intel.com; jmattson@google.com;
> daniel.sneddon@linux.intel.com; Das1, Sandipan <Sandipan.Das@amd.com>;
> tony.luck@intel.com; james.morse@arm.com; linux-doc@vger.kernel.org;
> linux-kernel@vger.kernel.org; bagasdotme@gmail.com; eranian@google.com;
> christophe.leroy@csgroup.eu; jarkko@kernel.org; adrian.hunter@intel.com;
> quic_jiles@quicinc.com; peternewman@google.com; Ashok Raj
> <ashok.raj@intel.com>
> Subject: Re: [PATCH v11 01/13] x86/resctrl: Replace smp_call_function_man=
y()
> with on_each_cpu_mask()
>=20
> On Mon, Jan 09, 2023 at 10:43:53AM -0600, Babu Moger wrote:
> > on_each_cpu_mask() runs the function on each CPU specified by cpumask,
> > which may include the local processor.
> >
> > Replace smp_call_function_many() with on_each_cpu_mask() to simplify
> > the code.
> >
> > Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > ---
> >  arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 11 +++------
> >  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 29 +++++++----------------
> >  2 files changed, 11 insertions(+), 29 deletions(-)
> >
> > diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> > b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> > index 1df0e3262bca..7eece3d2d0c3 100644
> > --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> > +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> > @@ -310,7 +310,6 @@ int resctrl_arch_update_domains(struct rdt_resource
> *r, u32 closid)
> >  	enum resctrl_conf_type t;
> >  	cpumask_var_t cpu_mask;
> >  	struct rdt_domain *d;
> > -	int cpu;
> >  	u32 idx;
> >
> >  	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL)) @@ -341,13
> +340,9 @@
> > int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
> >
> >  	if (cpumask_empty(cpu_mask))
> >  		goto done;
> > -	cpu =3D get_cpu();
> > -	/* Update resource control msr on this CPU if it's in cpu_mask. */
> > -	if (cpumask_test_cpu(cpu, cpu_mask))
> > -		rdt_ctrl_update(&msr_param);
> > -	/* Update resource control msr on other CPUs. */
> > -	smp_call_function_many(cpu_mask, rdt_ctrl_update, &msr_param, 1);
> > -	put_cpu();
> > +
> > +	/* Update resource control msr on all the CPUs. */
> > +	on_each_cpu_mask(cpu_mask, rdt_ctrl_update, &msr_param, 1);
>=20
> Do you require these updates to done immediately via an IPI? or can they =
be
> done bit lazy via schedule_on_each_cpu()?

I have not experimented with lazy schedule.  At least I know the call updat=
e_cpu_closid_rmid should be completed immediately. Otherwise, the result mi=
ght be inconsistent as the tasks(or CPUs)  could be running on two differen=
t closed/rmids before it is updated on all CPUs in the domain.
Thanks
Babu
