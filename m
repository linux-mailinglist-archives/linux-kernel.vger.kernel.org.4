Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCF66F96D2
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 06:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjEGEOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 00:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjEGEOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 00:14:16 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-cusazon11020025.outbound.protection.outlook.com [52.101.61.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62E91492E;
        Sat,  6 May 2023 21:14:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HgnllY60NA2knDjebBuJ09rGPOHOpdonOv0P9PLzY+zYpEo8LTZPIsd74baBbQ//vFyOx+4wg8Hd4CyAqZ3+7cF/wcrwNLGvwZKjrfDZPy65spPoVKmW7VteNgJbfTJ/vOzXKBXL6K3PUI436ByiAk2MRm0kUwbROWZzaPrFMyFOlWTDDofeMTZUvhQ/hboktMfj2ZQCgZ7b8xIs85o7PX1RyZrWBWjuOkNBfzQ7eG+SvjEzN75K7LITuK5JYLsF0dOA4Hae44bbsImNmx8r3WdWiJwVdlXysFY67vIIXlFFLrmxqkeBb6hBrwBmAckexrqbe/qsJMM6tk9WRqVuRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tY+33LB3hpYbL+5KySOOuT2kgudd0q8zip8Km+tZUW0=;
 b=HsbO2Hg/BfAWKLCq3ms5vQtUdu90499l2F02MZEUB2OOug5qU0GDLmIQb+gHCs24WETGvcw4dFl/4BwHgAxR8t7A4CJEsMdRS3oZcT7gTfalYWwDqxiAzyovFVtQx6wbD/u0g75bd8VChDffhWJxFUpHPTDx3yu3eE6f8XwFiltVl5XGstJzF/yUDvHypLduT+Qf35KyWlYvaPZX54HE8IDLV4YbcbN/saO2tpYyz/n02dOjZGmsLAdF9vR5bvuTvw4oec7Hx/x8evkEXqTCbAM6xIVPTjIeJxaDVQ77RQHBbBdua1PnzS7DBoMs4MZihDW6u8JmnKNX/sZQ9nHI2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tY+33LB3hpYbL+5KySOOuT2kgudd0q8zip8Km+tZUW0=;
 b=Gl5dthcrtDqT0ZEU2+vNpfSqJMAVVcebESZC3e92llUNLHoBpEz3orQzinxr9GFOPAvkA5CDdFoE953M814HAv10BFO3Lwwp1aqOH1X+aYnrfC3AdWq9oXhomvzZsDCYBEXjElbQbAuArmtGY1YO6+cMhWesspDHM9FpLWpWQek=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by BL0PR2101MB1330.namprd21.prod.outlook.com (2603:10b6:208:92::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.1; Sun, 7 May
 2023 04:14:09 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::9a0f:a04d:69bd:e622]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::9a0f:a04d:69bd:e622%4]) with mapi id 15.20.6411.001; Sun, 7 May 2023
 04:14:09 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul McKenney <paulmck@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Piotr Gorski <lucjan.lucjanov@gmail.com>,
        Usama Arif <usama.arif@bytedance.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Sabin Rapan <sabrapan@amazon.com>
Subject: RE: [patch V2 38/38] x86/smpboot/64: Implement
 arch_cpuhp_init_parallel_bringup() and enable it
Thread-Topic: [patch V2 38/38] x86/smpboot/64: Implement
 arch_cpuhp_init_parallel_bringup() and enable it
Thread-Index: AQHZfrsPO9aHmT4GeE2OzCti+2hGJa9MacrggAEGsICAAMVzgA==
Date:   Sun, 7 May 2023 04:14:08 +0000
Message-ID: <BYAPR21MB1688A75D614165C5E4E0302AD7709@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230504185733.126511787@linutronix.de>
 <20230504185938.393373946@linutronix.de>
 <BYAPR21MB168869144087644F89BAC89FD7739@BYAPR21MB1688.namprd21.prod.outlook.com>
 <87sfc92zw2.ffs@tglx>
In-Reply-To: <87sfc92zw2.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=56484d60-8d00-4ff5-b5f8-f0c240f99b2d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-05-07T04:09:18Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|BL0PR2101MB1330:EE_
x-ms-office365-filtering-correlation-id: d2a9855f-6ecc-44e8-ad10-08db4eb18117
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Pb14TKVPccx1vLCQs4eRlRzYXHVFHH59/7A2ShGhhIsvercQIIFPQtRK5tTfroxEBlHgTnggZvPnyUm+VsjEvMwyoOQS1/z1ofXcPzEfAIhRPxftL3Yh4EZww8uHXXKVY427W7ynwAeSO+SlZ6pCMh7XkD9MXp4FgkpFO5GQ0RLjo0Dgg22zWsiyQ33C7YEI2PnUxGbpW0TJ6JIRG/u+vucSesCosp+MeHJAOaoSrFmuaw788Nvx1K0VrEWBz/GfrY+2gs2SSExMQFWZJhLzUxZJnPuBQGfCOycrFo3VchIvRHelvk7crBN2YcUcna772LtatamGN2zpOiwnPCTPYWdV1ZVtZ9QNNEQxEN2CCWxLHzTP9tSUAWQDAD89A5prOTPEDUShF/Gg0+/6kTkOsXr+moLbT8N/IM11CtWk1Rnj1ZwCDyLWtw/XFjIyf1GUNBRCsKQRf2cCs8wgYT5MY+NlLSocQX5Mhgz8mQuD7BcRnvAeKx3AAOy9gv62UiND4Jary1QGZBMwJv5R4KGxcfl9RKoVTkptldyM1ZjU6n+iB5CNh7Fnt5bv1DrPYkHV2BmIvwmLdqsX2kQ0knlQ0f4gIJTJV3baN6Q9s8/2+0prTV+0VHPfsL0bdsi9PY2sCA22ied3nu+9RLV0BBYQzdD4DokLSPJgJfzzsvzqJbw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(451199021)(55016003)(8676002)(8936002)(9686003)(6506007)(26005)(7406005)(7416002)(2906002)(83380400001)(41300700001)(4326008)(76116006)(478600001)(10290500003)(316002)(52536014)(5660300002)(186003)(786003)(110136005)(66946007)(66556008)(66476007)(66446008)(64756008)(54906003)(7696005)(71200400001)(33656002)(8990500004)(86362001)(38070700005)(122000001)(38100700002)(82950400001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?z0aqLtKFIy4X2xpEiS9mMQ4+5lLnex6ibca9LtOq2LbE+x1rS/7Sm3dEDZq3?=
 =?us-ascii?Q?s++E9MprvXS2cnxe8posYjK2HQdLjlVKIj3svAbzaa4qrXh5lkAR9jRdEgsj?=
 =?us-ascii?Q?5hgwImtAKMv5da3Sf8wlxZTwI7E8We5sqmdIsZWvUnJEjRYvAAXxBBlKxSTk?=
 =?us-ascii?Q?a0kx3E6PnMEPGTaeULuLhNclZziiz3r1kMtDBYseaGSEHAsYTmfjmJW9iBaO?=
 =?us-ascii?Q?LV4fc+97zXi0UflD6k5GJECzVIn44omntZlNIQrX0pVEW9qgYeuWI2cufSDb?=
 =?us-ascii?Q?UpJggbisruSvV8mBvrZBxup1WqoPF/0gEcA0RUXH7iOLAx6dKSHA6I4iAaEp?=
 =?us-ascii?Q?Ai3n2ocUtzX7veOptz60VGVCPUV3Euzd4wkA9suFpCQ3a6BHF8418LghejCp?=
 =?us-ascii?Q?9DnK0TsMSUISZD8GhLXyUGPPZvUhDOEIw9kvlyzCTy5z9DofGP6PK/ZQeAxA?=
 =?us-ascii?Q?Qnla8HHAo0OWugb1TCgYYEi6v3iC33byigPPA4go9Br93v+64BNPC1nf0ELh?=
 =?us-ascii?Q?vw9oYiCFyzHs40G2atVGmfFaJAGXCNtUmXQI73LQy2Ng5zIOwfHprdvnJejG?=
 =?us-ascii?Q?pwNSNGGLLqqg7y5UlOB6eA3h8pWWLF5AbWNDn2GSNqfcxry8DmqbTKNJykjM?=
 =?us-ascii?Q?HY3qvbo8WtdGBnQf0/XW3kp0w8xzDsE58LiYXeAx3OGBcE64WwpYqPxY5TJ2?=
 =?us-ascii?Q?A/14FLGDw5LuV+QbLrX12rprd85VurwxmnisQDG+UwmV1V9CHSKohVcJgacK?=
 =?us-ascii?Q?uNmG6ClxtW8pF7cIZpc7KVgEFyUd5kSlW9i5/xAx8YujzU7jgdhiaWFI213j?=
 =?us-ascii?Q?NKoqX3UOnR4DwHeJfWQR9I9xGbILpo2tKJvp6vjQ1jPGv2F/IiTH/GeKUk4+?=
 =?us-ascii?Q?ahbJ3Qmpc0eMaNFlSYXYzukhwF+vKVkXUonz3owEGJd+xU97mQ9o8prTUfVv?=
 =?us-ascii?Q?Q8bHLDP0HokxyGua/lVUiRQgidZM67622lIwbsm/uHsTUXiVeerC6iz9Q/x4?=
 =?us-ascii?Q?DMu5LVjsZmgxAKClmiO4Ik40w3qsh8CRbO9tiMxqoKDAxcOvIK1MjCro4+IU?=
 =?us-ascii?Q?mpv+dG9RiNhhXfELN0nLiBZb1g7apAc8rooIQYtJe3dC/0wUoXq9Dmb7jg6O?=
 =?us-ascii?Q?l2mT3pLhE/Wd0HKNfu4IqKkbCR2q2/CwweWVYq4p22a1G3d4rSMiT9MmzI6R?=
 =?us-ascii?Q?97sIH2xkKJbfFx1tZTr27sqsnqaW4NAlRbjMyxmL5c7MlN24cklKs+XnA6AV?=
 =?us-ascii?Q?Dw4y9WXP9VLHPxN7cfUXvWa2Fv6Ky447PEnTkNuQQ7Qsz8vozOHsy5EdiYs/?=
 =?us-ascii?Q?ri1etBGeiGS9QZIidf6Y2b1zdLGQ3BoRAOty1cMLaleNS4ZbWMiwUm0Cf/hl?=
 =?us-ascii?Q?3q0nys4JPbDvETnlS6NY1Lj4Xr3vOdld8BIshI8OGXdjgF8rwacr5Q9qREWq?=
 =?us-ascii?Q?c8P6EsakQXzYroPIQ4yfqSmuvG+Azn5S62l1MYx5pd38qdTHc4Syh5EB86lB?=
 =?us-ascii?Q?eYMoplvic0qW8BBrqSF6OhrAyouce7msBO/X8f5eBYwstLNJspXyKMYjJVGr?=
 =?us-ascii?Q?zzhpUKZ2k+j1dZZUiaDplfn3cCDGWKMj+kLy/61gL0UWItLDCS+c/mpteDgt?=
 =?us-ascii?Q?QA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a9855f-6ecc-44e8-ad10-08db4eb18117
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2023 04:14:08.4773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /2wc1Blo+i32hKbcJuYuEh2AjgD9x8NsYa714HHvOCBKIZfz4f2amMVxJ/MZXr5GCi6+eqQjdr7SRGZDqhB3VIBK5fKEPc41CaxMMvYAeyc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1330
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de> Sent: Saturday, May 6, 2023 9:23=
 AM
>=20
> On Sat, May 06 2023 at 00:53, Michael Kelley wrote:
> > From: Thomas Gleixner <tglx@linutronix.de> Sent: Thursday, May 4, 2023 =
12:03 PM
> > [snip]
> >
> >> @@ -934,10 +961,10 @@ static void announce_cpu(int cpu, int ap
> >>  	if (!node_width)
> >>  		node_width =3D num_digits(num_possible_nodes()) + 1; /* + '#' */
> >>
> >> -	if (cpu =3D=3D 1)
> >> -		printk(KERN_INFO "x86: Booting SMP configuration:\n");
> >> -
> >>  	if (system_state < SYSTEM_RUNNING) {
> >> +		if (num_online_cpus() =3D=3D 1)
> >
> > Unfortunately, this new check doesn't work.  Here's the output I get:
> >
> > [    0.721384] smp: Bringing up secondary CPUs ...
> > [    0.725359] smpboot: x86: Booting SMP configuration:
> > [    0.729249] .... node  #0, CPUs:        #2
> > [    0.729654] smpboot: x86: Booting SMP configuration:
> > [    0.737247]       #4
> >
> > Evidently num_online_cpus() isn't updated until after all the primary
> > siblings get started.
>=20
> Duh. Where is that brown paperbag?
>=20
> > When booting with cpuhp.parallel=3D0, the output is good.
>=20
> Exactly that was on the command line when I quickly booted that change :(
>=20
> The below should fix it for real.
>=20
> Thanks,
>=20
>         tglx
> ---
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -951,9 +951,9 @@ static int wakeup_secondary_cpu_via_init
>  /* reduce the number of lines printed when booting a large cpu count sys=
tem */
>  static void announce_cpu(int cpu, int apicid)
>  {
> +	static int width, node_width, first =3D 1;
>  	static int current_node =3D NUMA_NO_NODE;
>  	int node =3D early_cpu_to_node(cpu);
> -	static int width, node_width;
>=20
>  	if (!width)
>  		width =3D num_digits(num_possible_cpus()) + 1; /* + '#' sign */
> @@ -962,7 +962,7 @@ static void announce_cpu(int cpu, int ap
>  		node_width =3D num_digits(num_possible_nodes()) + 1; /* + '#' */
>=20
>  	if (system_state < SYSTEM_RUNNING) {
> -		if (num_online_cpus() =3D=3D 1)
> +		if (first)
>  			pr_info("x86: Booting SMP configuration:\n");
>=20
>  		if (node !=3D current_node) {
> @@ -975,11 +975,11 @@ static void announce_cpu(int cpu, int ap
>  		}
>=20
>  		/* Add padding for the BSP */
> -		if (num_online_cpus() =3D=3D 1)
> +		if (first)
>  			pr_cont("%*s", width + 1, " ");
> +		first =3D 0;
>=20
>  		pr_cont("%*s#%d", width - num_digits(cpu), " ", cpu);
> -
>  	} else
>  		pr_info("Booting Node %d Processor %d APIC 0x%x\n",
>  			node, cpu, apicid);

This works.  dmesg output is clean for these guest VM combinations
on Hyper-V that I tested:

* Normal VM:  16 vCPUs in 1 NUMA node and 32 vCPUs in 2 NUMA nodes
* Same configs for a SEV-SNP Confidential VM with paravisor

Tested with and without cpuhp.parallel=3D0

For the entire series:
Tested-by: Michael Kelley <mikelley@microsoft.com>
