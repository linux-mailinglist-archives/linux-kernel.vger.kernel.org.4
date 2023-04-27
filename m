Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614AE6F07AF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 16:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243984AbjD0Osa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 10:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243608AbjD0Os2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 10:48:28 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021022.outbound.protection.outlook.com [52.101.62.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9B6C5;
        Thu, 27 Apr 2023 07:48:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FidD5mo08ZZMs3qcbCHj/LsG4d+WWfJPvwFEp5DfPQ0DO4cftDKuQEIDFltayIQYWxw+91RLGJxgI4TH71etbkPZ2kAFP/LGvndIEo7qdKiSiO+e2uHwj3QDON06SmYvo7nDi1nK67JGyen8bNFqvr7m9w7YSQS81sAgp0WEF1rWbWofZiLiANR6RHoD8tan97ue7ZDWEU6wa71jenpQz99PF6ux42xqwGtDLdrGsddwQ7Pg5ylAI8Rv7I0VCF9Qjhm06BMnJOhhcs4d2aNEoAidIywGPZWKdkXHXR8UXGSCquO3884Nida3mFgA02pmfo4DuDC3/nUqy6ieM4/r+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nxt769QptW+s630rckbhmu9SAzkE81OepKrOgTaIYlw=;
 b=Ux63q2WzcXqnYJK2Kvn/0lCJgupO4k0mi8cCf1Br5LnZLFSTHZiOdEEQ4Q5uqWvZKop//nJwm6RdVxR/YyoTjcB8vww3Tw+/Ht0WIaggiMH1v7m8SAEiTbaAMpQU5clbpsXIv2dVTjoTXjdCTieV2bX2rjWjZDUbmkqQEQgLWfJrNGq5F2D2CFmbpMm/gccx3w9Q7sLM4Ubd3p8u2KxprLn7XUSOliqtnpPgKKoECEW4mQPAHim7tHyoHMgGcmVjUFyvw0EuHucoe7uFleQV9cLS4qW42h4db+7sblVoPYU+hhwmX3/VS06vBZ1E7VcjICVjlV0TyUw/X0xNipOM8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nxt769QptW+s630rckbhmu9SAzkE81OepKrOgTaIYlw=;
 b=EXJJriYI5k6vBBRh7obCiEK823hyn9Go/XSWIcZqT70cQZjkgwcTewkow5/omK1EUhEDklwwPh7Tom9jsFOQbievkExHBOumTULKvyWUrzpWxG5OW1bae7QVOCHmiGUEmUSzOCB4S5K273mpNLpK3xnH05ssPaIvMbCjK5qG4Zw=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by CY5PR21MB3591.namprd21.prod.outlook.com (2603:10b6:930:c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.19; Thu, 27 Apr
 2023 14:48:23 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::89f5:e65e:6ca3:e5a7]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::89f5:e65e:6ca3:e5a7%6]) with mapi id 15.20.6363.009; Thu, 27 Apr 2023
 14:48:23 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        David Woodhouse <dwmw@infradead.org>,
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
        David Woodhouse <dwmw@amazon.co.uk>,
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
Subject: RE: [patch 00/37] cpu/hotplug, x86: Reworked parallel CPU bringup
Thread-Topic: [patch 00/37] cpu/hotplug, x86: Reworked parallel CPU bringup
Thread-Index: AQHZbysRZA8Vj8T0G0ur4YbixPC7La8/SSgw
Date:   Thu, 27 Apr 2023 14:48:23 +0000
Message-ID: <BYAPR21MB168888DC5432883D8866BA40D76A9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230414225551.858160935@linutronix.de>
In-Reply-To: <20230414225551.858160935@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=46284e3d-8064-4df4-a070-7e25b2bb6662;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-04-27T14:22:50Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|CY5PR21MB3591:EE_
x-ms-office365-filtering-correlation-id: f896ad88-fe39-4f83-266e-08db472e7362
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NWmmkUhHIp7h/hf4wUwLyyRMGm5e99Tu/sxAss9qebk4QYmtuboxufSOw98Xn9Jt0ZxttFSNYvzUSZyK6WpDm2krqaTBg5Jz4l4fqd6c21wrPSQqpSAN8a1LDZh373yxLTlLdwINCjAntW4iPDaP8XDXxor/kXCqhLTwSbo0frTC4K1RY9NrRHp1fd6c99Rcye1jSbfSmge1ONMzgjA1hUENXkZ94m9UgyhzqwW0LoHkTP2ca/0ZExcIX/m3ja+1Q6oqPhhTnrHZKEvK1JCocNBbSUJvnRs4Yph4mOcmis2LF59OTU9rpPxLCw9StiGB/hYVN4Nf9Qza3ZRwT6G0U00fFxNgLICO/zme7wvpcWXsKgWx7h+Nf1i4j7NSRhTBgFw+7hi5U54GWTrTkqN+eJZHizwbTZMZ1eqBltl6+mWbzfn79or9B3rtl6qk8NFavH7UyJiS9c/f3wNmK/HYLbjzH2/YjsLC8wDCFBftMuJdXoMiCcoNuvId5P4pZlPMbt2KJW6w7E4c5Ml2PKFYh2BoPIAv//5ceDyJ74M2RTma8B3dmjREiNZUcZhfHitYDTkevhSc5sqqjWRrscJaWrAX3ov52oaD9cr9gKdkEbtWUSwGjwPW1VPg/+KPbir95r5FTaQ/o7YgAObx6BWjIDqluuzUj4MFghErOS7LzW0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(136003)(366004)(451199021)(33656002)(38100700002)(4326008)(10290500003)(7696005)(38070700005)(66446008)(316002)(786003)(110136005)(478600001)(66556008)(71200400001)(54906003)(66946007)(8990500004)(66476007)(41300700001)(86362001)(64756008)(76116006)(8936002)(83380400001)(26005)(6506007)(122000001)(55016003)(82960400001)(9686003)(8676002)(82950400001)(7406005)(186003)(5660300002)(2906002)(52536014)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W6lJiT+4w8ZRagviKqWC2A2XgpZ68z3pUr1Iv7/nshr39JdQIWHEB405Ertm?=
 =?us-ascii?Q?NkKNdMQ9DsUKPz0MwW1DILAaR7kNDQQin11j3CHuUZXEAvl+B4KqchkXEyKP?=
 =?us-ascii?Q?nhWdaezRu1854fiKM6cq9SdcQsEpD+0jegHUz7VMn/FAS/N2FZ7p8WkL3OKg?=
 =?us-ascii?Q?tngf7sf9/cCjDkMwQwqrV+MPQDnYncxbXl+ezboIW6ZJw3jmOZ20h7gE9WUy?=
 =?us-ascii?Q?zdXUlu9YOQ7c+rFfl1w5wECNb8rsMfRN3z5zu4ROCXrZs3songstQjaVcaLP?=
 =?us-ascii?Q?BmQ9WME8Dmxg3rArdCboQ2T+eHCQcvZh6z3gDwYt8u+YK/rR91ofsm9qPepO?=
 =?us-ascii?Q?R0qRE+F5QwTOealwAK5FXu1aQrimGigh7M89TSslTSfbYJ45yVuWHktJUa2z?=
 =?us-ascii?Q?NTw3hEOe1EJv4vX/mSodAl0iRtSRwItPFpFbOphIjwZyc8VeZ1PhhOOFKXqW?=
 =?us-ascii?Q?lDgERP+K2IbZRbpPSGKTMII8++SnMjg5gWyZHyk+uhV9jrpcDDRyI32npUNY?=
 =?us-ascii?Q?LoHysFz8GXLNTjMxY1QbnaaC5CSucG3XyEhSqoq/NQhNl4RQak+DYmulnyoo?=
 =?us-ascii?Q?TxagI9B6Fm6agr+qpi1QqwnYQWWVstCL/EKYWKwGUOOwTMMoEOUs8+VpCL5Q?=
 =?us-ascii?Q?8n7CiesCAqYE26j0S7peweAjaj+aNm8quFSGPKqe1aGjbhFkXJj1dVEZh8zC?=
 =?us-ascii?Q?KC9hQC/Pin1sU01HypsMJDdrhG9C1+UEtA2+C/SCm7bnTKeJEK0sdH0wQm5u?=
 =?us-ascii?Q?1KEPteGpPFbKn6Ery7CC9P0cyCwoHHulMEljOdU6x9ufvCujAXqvg9ANe5Vb?=
 =?us-ascii?Q?yjLELto+wNh3/qvle7RaGgCKIyGwRWXHLYZcE1FnaSP6QvKZ71f9YRtcun44?=
 =?us-ascii?Q?HSQCXv5h8esHGH4mG3SI6FCkOikDzkioLgIbN6YgA1tcAB0u03VZZVmlhUZa?=
 =?us-ascii?Q?zlHxa2Nvnl8V1uoBKaTG9jAM4bf+JRf9ag2U9K3Nef9emKMDyNgWkIodwXCb?=
 =?us-ascii?Q?Okcg08k1CJ4pTeWtLpEBpGzFksCmm6dqXDQoLkX+mOS7j5SzoorEl0vN2LGt?=
 =?us-ascii?Q?SsdKojk+Cds6BKyt+95uM95TdefFRpFxue724VdM74edz2cleZIMLVHUD28j?=
 =?us-ascii?Q?HqbzeqR971IqaoKwK1ERDKKIfPkhU9vGFtvYrdNq1Vihq4Zcvxy2aNBM5+Ya?=
 =?us-ascii?Q?SKat6d5Z+Hizrd8DqrAij9oDrqP3qzV0xRFHN0ssVx03wK1vPnhC1dj1ehtP?=
 =?us-ascii?Q?OseYF72nbh86EXpyBrRMbL6L2X7ywYN40zS6VjMzaRLdPeVzLrzct1J4Ldzx?=
 =?us-ascii?Q?yMj2fgYJAAcyuW/jUd8e3X2bxN2ko6oN8wphLeDcBrXF8WpT9H67onVge7MV?=
 =?us-ascii?Q?zbd3PtE1kPwutdsQyfiBNSvClsTExEeHVeitmV5Y8LI3KDQ18w5X9NlIwFWf?=
 =?us-ascii?Q?l3rF4HEjtZ3AGnmXr8kOIj/bgEC8bf1q+BXGgJGgmZTxPMFTA2/Gd/7jj2wN?=
 =?us-ascii?Q?HWlUBrKbiGwic/o91lN3seK+Ob71l59Ngiz0byFNibAuQlKIxc/W75dveaTx?=
 =?us-ascii?Q?ruizcvuy/bDLurjAa3I/0RiS3QmsinyNDuiIfsfytJTuNvJlPIB2EMruHvuC?=
 =?us-ascii?Q?og=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f896ad88-fe39-4f83-266e-08db472e7362
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2023 14:48:23.2371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YrxGibgeGnDk6XVTMicUZCzlePqRgHhRoxhsCC4oaF79GggjOnm7azqCR25lFAik2nmp68DOpWD/cEVwrYZZAWW2JWVxou0cU4qAsNSdxjg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR21MB3591
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de> Sent: Friday, April 14, 2023 4:4=
4 PM

[snip]

>=20
> Conclusion
> ----------
>=20
> Adding the basic parallel bringup mechanism as provided by this series
> makes a lot of sense. Improving particular issues as pointed out in the
> analysis makes sense too.
>=20
> But trying to solve an application specific problem fully in the kernel
> with tons of complexity, without exploring straight forward and simple
> approaches first, does not make any sense at all.
>=20
> Thanks,
>=20
> 	tglx
>=20
> ---
>  Documentation/admin-guide/kernel-parameters.txt |   20
>  Documentation/core-api/cpu_hotplug.rst          |   13
>  arch/Kconfig                                    |   23 +
>  arch/arm/Kconfig                                |    1
>  arch/arm/include/asm/smp.h                      |    2
>  arch/arm/kernel/smp.c                           |   18
>  arch/arm64/Kconfig                              |    1
>  arch/arm64/include/asm/smp.h                    |    2
>  arch/arm64/kernel/smp.c                         |   14
>  arch/csky/Kconfig                               |    1
>  arch/csky/include/asm/smp.h                     |    2
>  arch/csky/kernel/smp.c                          |    8
>  arch/mips/Kconfig                               |    1
>  arch/mips/cavium-octeon/smp.c                   |    1
>  arch/mips/include/asm/smp-ops.h                 |    1
>  arch/mips/kernel/smp-bmips.c                    |    1
>  arch/mips/kernel/smp-cps.c                      |   14
>  arch/mips/kernel/smp.c                          |    8
>  arch/mips/loongson64/smp.c                      |    1
>  arch/parisc/Kconfig                             |    1
>  arch/parisc/kernel/process.c                    |    4
>  arch/parisc/kernel/smp.c                        |    7
>  arch/riscv/Kconfig                              |    1
>  arch/riscv/include/asm/smp.h                    |    2
>  arch/riscv/kernel/cpu-hotplug.c                 |   14
>  arch/x86/Kconfig                                |   45 --
>  arch/x86/include/asm/apic.h                     |    5
>  arch/x86/include/asm/cpu.h                      |    5
>  arch/x86/include/asm/cpumask.h                  |    5
>  arch/x86/include/asm/processor.h                |    1
>  arch/x86/include/asm/realmode.h                 |    3
>  arch/x86/include/asm/sev-common.h               |    3
>  arch/x86/include/asm/smp.h                      |   26 -
>  arch/x86/include/asm/topology.h                 |   23 -
>  arch/x86/include/asm/tsc.h                      |    2
>  arch/x86/kernel/acpi/sleep.c                    |    9
>  arch/x86/kernel/apic/apic.c                     |   22 -
>  arch/x86/kernel/callthunks.c                    |    4
>  arch/x86/kernel/cpu/amd.c                       |    2
>  arch/x86/kernel/cpu/cacheinfo.c                 |   21
>  arch/x86/kernel/cpu/common.c                    |   50 --
>  arch/x86/kernel/cpu/topology.c                  |    3
>  arch/x86/kernel/head_32.S                       |   14
>  arch/x86/kernel/head_64.S                       |  121 +++++
>  arch/x86/kernel/sev.c                           |    2
>  arch/x86/kernel/smp.c                           |    3
>  arch/x86/kernel/smpboot.c                       |  508 ++++++++---------=
-------
>  arch/x86/kernel/topology.c                      |   98 ----
>  arch/x86/kernel/tsc.c                           |   20
>  arch/x86/kernel/tsc_sync.c                      |   36 -
>  arch/x86/power/cpu.c                            |   37 -
>  arch/x86/realmode/init.c                        |    3
>  arch/x86/realmode/rm/trampoline_64.S            |   27 +
>  arch/x86/xen/enlighten_hvm.c                    |   11
>  arch/x86/xen/smp_hvm.c                          |   16
>  arch/x86/xen/smp_pv.c                           |   56 +-
>  drivers/acpi/processor_idle.c                   |    4
>  include/linux/cpu.h                             |    4
>  include/linux/cpuhotplug.h                      |   17
>  kernel/cpu.c                                    |  397 +++++++++++++++++=
-
>  kernel/smp.c                                    |    2
>  kernel/smpboot.c                                |  163 -------
>  62 files changed, 953 insertions(+), 976 deletions(-)
>=20

I smoke-tested several Linux guest configurations running on Hyper-V,
using the "kernel/git/tglx/devel.git hotplug" tree as updated on April 26th=
.
No functional issues, but encountered one cosmetic issue (details below).

Configurations tested:
*  16 vCPUs and 32 vCPUs
*  1 NUMA node and 2 NUMA nodes
*  Parallel bring-up enabled and disabled via kernel boot line
*  "Normal" VMs and SEV-SNP VMs running with a paravisor on Hyper-V.
    This config can use parallel bring-up because most of the SNP-ness is
    hidden in the paravisor.  I was glad to see this work properly.

There's not much difference in performance with and without parallel
bring-up on the 32 vCPU VM.   Without parallel, the time is about 26
milliseconds.  With parallel, it's about 24 ms.   So bring-up is already
fast in the virtual environment.

The cosmetic issue is in the dmesg log, and arises because Hyper-V
enumerates SMT CPUs differently from many other environments.  In
a Hyper-V guest, the SMT threads in a core are numbered as <even, odd>
pairs.  Guest CPUs #0 & #1 are SMT threads in core, as are #2 & #3, etc.  W=
ith
parallel bring-up, here's the dmesg output:

[    0.444345] smp: Bringing up secondary CPUs ...
[    0.445139] .... node  #0, CPUs:    #2  #4  #6  #8 #10 #12 #14 #16 #18 #=
20 #22 #24 #26 #28 #30
[    0.454112] x86: Booting SMP configuration:
[    0.456035]       #1  #3  #5  #7  #9 #11 #13 #15 #17 #19 #21 #23 #25 #27=
 #29 #31
[    0.466120] smp: Brought up 1 node, 32 CPUs
[    0.467036] smpboot: Max logical packages: 1
[    0.468035] smpboot: Total of 32 processors activated (153240.06 BogoMIP=
S)

The function announce_cpu() is specifically testing for CPU #1 to output th=
e
"Booting SMP configuration" message.  In a Hyper-V guest, CPU #1 is the sec=
ond
SMT thread in a core, so it isn't started until all the even-numbered CPUs =
are
started.

I don't know if this cosmetic issue is worth fixing, but I thought I'd poin=
t it out.

In any case,

Tested-by: Michael Kelley <mikelley@microsoft.com>
