Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18BDA74C015
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 01:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjGHXxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 19:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGHXxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 19:53:14 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021018.outbound.protection.outlook.com [52.101.62.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D341BF
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 16:53:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AVLmpjW/a1gwzwnl9/hGtWTmCXu9QcfaWXYCgFDLLs3kVDaz4NGNKpvZ9ivLXpMCx/hJiAK/iAGjJgZ+8osqGp2pNHGrz7BlSdxf6Siv83ogVXZm4QaTPcaju2uZDd3yanQrdJC0xiks8msEOqVCy7meJpu+0D3Kj1ZnbBgwYuSFvyun5h3xSufEoLxJ+ZKQj3/6sg6PfItAKYSnLhFlJQT3Mvu2/DaghFmrit9y9hxBJDXyVeDd1A4ofIcAJIUroB4Pok0QaGYx2VPSBxH2nP52cUerlC1TyMLEX4lwWOthn2Z2jxJBdflNmyZOIkqDk/SRCOlGDxllKGXMLGve8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2daOUp7JJpzEq6j+c0WUPUD2/4izuVN+FUOxZewHKFM=;
 b=L2thez0GCzFSxrQkX8nlghweQskM6I13UXY/IJDLAH+agL9gih5xAVg3Ucs2GPClNkIbJo9blVjhUa3f82ZeRo7FNImD/7ZApbwQcRr2fNwBDSsFftSOuQ3v8B16y48BreymgXO63N/Vr+NE1V6sAn64TX+UF5zHiRwU8TfeyfGlVufxS/N64KR25Lc1Z9aEe/eaUxjj58/9+rThQpI0Ps9o+gYXQ4qGlCB8Q8+Qk7Q34G0nd0uqzAGwciV+sbR4hxxUMQwD1viPixS+NYLOjySlxT+7tyKU4mtM9fomnFiNWiYXGf6oewycFkQa/dW8I+RgYG8eDxF8bGB9t33+rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2daOUp7JJpzEq6j+c0WUPUD2/4izuVN+FUOxZewHKFM=;
 b=Y1Ga79VaJHDuABpFJmwotl5cB9VsMfcal/8dX+HmHysXZ88IsNqto17rhNOgDUgo9l3LV/ZqhHdVl1/Aszbn37dKK07R5XKNdAXEtJ2ABdzrbUjj2iPguStAkE1cdZfxGW6VoEZZ0xzYZnqOTiQVikvthWGDvCYDdGZTT77QtZg=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DS7PR21MB3292.namprd21.prod.outlook.com (2603:10b6:8:7c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.6; Sat, 8 Jul
 2023 23:53:09 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::733d:6263:4482:ba25]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::733d:6263:4482:ba25%4]) with mapi id 15.20.6609.000; Sat, 8 Jul 2023
 23:53:08 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, Dexuan Cui <decui@microsoft.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCHv3 0/3] x86/tdx: Fix one more load_unaligned_zeropad()
 issue
Thread-Topic: [PATCHv3 0/3] x86/tdx: Fix one more load_unaligned_zeropad()
 issue
Thread-Index: AQHZmF1U2k/rcGuWwEuDTjMXS84AEa+qcB1ggAQXoICAAi1GAA==
Date:   Sat, 8 Jul 2023 23:53:08 +0000
Message-ID: <BYAPR21MB1688A4473FF2DF4E177036D5D732A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230606095622.1939-1-kirill.shutemov@linux.intel.com>
 <BYAPR21MB168846628450D6089242D3EAD72CA@BYAPR21MB1688.namprd21.prod.outlook.com>
 <20230707140633.jzuucz52d7jdc763@box.shutemov.name>
In-Reply-To: <20230707140633.jzuucz52d7jdc763@box.shutemov.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0f9c8eac-1372-4e8d-865a-e587b14598ac;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-08T23:21:07Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DS7PR21MB3292:EE_
x-ms-office365-filtering-correlation-id: d0753ed6-1d20-43fc-87fd-08db800e7b32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7ZDfIaThlr9InvhaRmUPa/rEMG5D7N7ca9VXNqWllwPDR9y70lcPnfXVMps7OpbGUgK868XuU7zB2FGc6/N3PiAvqNZeF5nBnRXzPu/rIJDJ7EJBtKZLgjRtNGTyvM0vACuYLaUQqIXoNsZgMSJJgv+T7omkDNgEtJF9OMmJYab+dvxGNHrrDv/hxCL2xqTjO4RY9hla1jPg0qvcqIYWgdhRftnn0brMIjzbIzWrERpe1kRKoeWf9LHKE+1qk8FI42cqXzfAw2IcUnd38GwTae46B7JAaJTPxcJHWaqVtRYwqVyVKkSkpHptEuUf8AGIKDi9ap5SQ4T7YRmThS8vVX8HX2ogKXvDXWNMzi8Us4JvxyEde5XHn/Y5k+tbG51IPeLZ3EwncBRE9V7ujW+7O9OVoro1c8isHvL9Fvtmi1Om4V/7qNERF4JFGdXWPPWfWbjC/wnC+5iUiruBAJYvodANy5wBtBJiCHyVR6+375FDf+IUJnQDXa+kdUn37gnn1bPzEeoAIa8acjp/a6xkLdt8j2bCgbILbLlO163+9JJAphxE5CHaSiYZhDUWJUu6iF2GWWVd17242erOOD4f1y3hYvjNAq883WOHmloZB+MrigiZoeMEosf5uYm5BjF+s3DDLbcoxIo325etBpWfXIoxt56stsk/Jkt6XhRb15c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(451199021)(7416002)(5660300002)(8676002)(8936002)(66946007)(64756008)(76116006)(55016003)(66476007)(6916009)(66446008)(66556008)(2906002)(316002)(8990500004)(52536014)(41300700001)(54906003)(4326008)(71200400001)(10290500003)(7696005)(478600001)(6506007)(122000001)(33656002)(38070700005)(9686003)(186003)(26005)(38100700002)(82960400001)(82950400001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Zreh/O3+xC7gNBvnTC9CtOWEjwP5MrShC2S3Y2f7l2BAIPq0klx/IPo1qzvD?=
 =?us-ascii?Q?TVqtv1EdFX9zYWQ2ZjGUpyBfIo1VGXXuCmaBtGw3s4pWqbxj8Pr9thBm9exd?=
 =?us-ascii?Q?1hPsYGimXuVNxVRTEFsuPPHP2xHcXJol+aXHs/1V/csioT3gvTp4ERA4NnZN?=
 =?us-ascii?Q?gClS/TSHdfldHiS8Di/EVeolg3a2eb4A66laLPRbloZQUI9T5u9keN6BEmuu?=
 =?us-ascii?Q?d8m6SLGcnukqEBsXa3z79fhxeapkhrej0l427B0J1lmM5KzuMxrQVAGbsZfj?=
 =?us-ascii?Q?/weW2Tf3WNl5GupDbeyPeYns4t+VGSnRqmqZINLxNzMQ5lU8gWy7cE+2Z+sC?=
 =?us-ascii?Q?6Wx9PJv0Ea3eriPHGR8RsiKLFCCg7sW7ugCY0nGjiQ9D1TderByByAorsFeJ?=
 =?us-ascii?Q?Radq8NfGeatHwTSf2tEAV8tizce5pkZ+jgjgjPhQyxVf48TynA+WpfDr8ZOX?=
 =?us-ascii?Q?fprKKLlly446vKBqcTKQp3A4fmEHuA34mPKi8quFGavjTBDbDvAT+MH1qGSN?=
 =?us-ascii?Q?SprcfnZe/ul/FZaWOS3homn/7OwWTnIUfENdoXbBLh13g2BcqGHDxfQ2q1rU?=
 =?us-ascii?Q?bjpIyjPGA0MdaYoVelZ9WK0y9GM4sqanwe0bp0APgRbP3mFEtthb370PFzUj?=
 =?us-ascii?Q?teGJRhdHrq//b5Y/wyVdifNu9fBUW5qP6RVkhXy94+nYR+i4P60PESsJlJyh?=
 =?us-ascii?Q?0eJjhMLyocYavEdsb55KO9cTS+xLHAxnQZhM3oAeD4N6DaeDRquyrupKD/PJ?=
 =?us-ascii?Q?R/wf5oB4wyml9Dp/VgXog96qp11bNzPB4A4x8Dmt9FzC7+wW0Uyg/SgI7dct?=
 =?us-ascii?Q?PHaJA/jIrbkwdC7QnozY2Y+iaSV8mbwECwnqvbkeFcvPX3R+aYNiP9/fXn2c?=
 =?us-ascii?Q?KSuRwlEw40rT48IdzCryIGwJ/RFqnyRvuD5gciME2pp/jsVvnzfTtOBkcWqE?=
 =?us-ascii?Q?PABBPPKboK6kdFRIiobUT5/8y4NZXHrrk/l9kyHeZP6Xvp65YFmc6JDymglO?=
 =?us-ascii?Q?G0np2444JoDhhML4bOPyTkBZXPkcHbwwuBUv053ut6X3wzvBXa38zcCJ7RHD?=
 =?us-ascii?Q?Z6WCUax1t9wgObzrxPJVkwXsvrfOqv138U6WizvInRaDusrJjnPGfv91eR5y?=
 =?us-ascii?Q?JfWcuSscjRGjZPDz6lCPCuZwwwqh8KLYPc/HkDUO32crVIqmVl9C9kIH0rdG?=
 =?us-ascii?Q?ETWUjuZ+Ur7PXfGBW4kYl+GzOutRzlxF/bRwrDvIGvaHUqvnfAYJ1rwKXkpZ?=
 =?us-ascii?Q?V512hHFo0RCppbqHRMgbl21DC0r0uzLcWxMdLXoeZKNe6Ttzi+KMRRPU0JGf?=
 =?us-ascii?Q?MtLLS202a8f3pfX3cmxxaAyN5977hA5QShH3CDTYK8T++c1+RNA9CP8l5k0F?=
 =?us-ascii?Q?klFZ4hv/3nrMc+MqheSTV79cyFKAwZrgkJFMe4vtwQtXbwqxkL3GyTbpEc6x?=
 =?us-ascii?Q?g3XqalfSvfCru/iNB9/LQfJxOuwCyLWk6vWivljRHJMqufaViCGX93ailB9d?=
 =?us-ascii?Q?jc7ELQHb5tALZIPwnjr7uzJNIupbxGnWyMwiHHwgGK922NS3QKTIcdODZe+U?=
 =?us-ascii?Q?5KVlMUYGLFYsmsz08bM46pRyYJIGXrtiPzxpA3VQjCZZ25mpaP7bNFNZb7QC?=
 =?us-ascii?Q?Ug=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0753ed6-1d20-43fc-87fd-08db800e7b32
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2023 23:53:08.7589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8eALyRcOl3FOmwm74xkK9y3LOpSCl4QL2o29jXuXTKVlRAoaU0nvAmOM1f5LH95LZVY33SCRmAUEx3hUVvXs2UrmFKLCCXYwXGmODmacFQw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3292
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kirill A. Shutemov <kirill@shutemov.name> Sent: Friday, July 7, 2023 =
7:07 AM
>
> On Thu, Jul 06, 2023 at 04:48:32PM +0000, Michael Kelley (LINUX) wrote:
> > From: Kirill A. Shutemov <kirill.shutemov@linux.intel.com> Sent: Tuesda=
y, June 6, 2023 2:56 AM

[snip]

>=20
> It only addresses the problem that happens on transition, but
> load_unaligned_zeropad() is still a problem for the shared mappings in
> general, after transition is complete. Like if load_unaligned_zeropad()
> steps from private to shared mapping and shared mapping triggers #VE,
> kernel should be able to handle it.

I'm showing my ignorance of TDX architectural details, but what's the
situation where shared mappings in general can trigger a #VE?  How
do such situations get handled for references that aren't from
load_unaligned_zeropad()?

>=20
> The testcase that triggers the problem (It is ugly, but useful.):
>=20
> #include <linux/mm.h>
> #include <asm/word-at-a-time.h>
>=20
> static int f(pte_t *pte, unsigned long addr, void *data)
> {
> 	pte_t ***p =3D data;
>=20
> 	if (p) {
> 		*(*p) =3D pte;
> 		(*p)++;
> 	}
> 	return 0;
> }
>=20
> static struct vm_struct *alloc_vm_area(size_t size, pte_t **ptes)
> {
> 	struct vm_struct *area;
>=20
> 	area =3D get_vm_area_caller(size, VM_IOREMAP,
> 				  __builtin_return_address(0));
> 	if (area =3D=3D NULL)
> 		return NULL;
>=20
> 	if (apply_to_page_range(&init_mm, (unsigned long)area->addr,
> 				size, f, ptes ? &ptes : NULL)) {
> 		free_vm_area(area);
> 		return NULL;
> 	}
>=20
> 	return area;
> }
>=20
> #define SHARED_PFN_TRIGGERS_VE 0x80000
>=20
> static int test_zeropad(void)
> {
> 	struct vm_struct *area;
> 	pte_t *pte[2];
> 	unsigned long a;
> 	struct page *page;
>=20
> 	page =3D alloc_page(GFP_KERNEL);
> 	area =3D alloc_vm_area(2 * PAGE_SIZE, pte);
>=20
> 	set_pte_at(&init_mm, (unsigned long)area->addr, pte[0],
> 		   pfn_pte(page_to_pfn(page), PAGE_KERNEL));
> 	set_pte_at(&init_mm, (unsigned long)(area->addr + PAGE_SIZE), pte[1],
> 		   pfn_pte(SHARED_PFN_TRIGGERS_VE,
> pgprot_decrypted(PAGE_KERNEL)));
>=20
> 	a =3D load_unaligned_zeropad(area->addr + PAGE_SIZE - 1);
> 	printk("a: %#lx\n", a);
> 	for(;;);
> 	return 0;
> }
> late_initcall(test_zeropad);
>=20
> Below is a patch that provides fixup code with the address it wants.
>=20
> Any comments?

This looks good to me.  I applied the diff to a TDX VM running on
Hyper-V.  When a  load_unaligned_zeropad() occurs on a page that is
transitioning between private and shared, the zeropad fixup is now
done correctly via the #VE handler.  (This is *without* my RFC patch to
mark the pages invalid during a transition.)

Michael

>=20
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index 58b1f208eff5..4a817d20ce3b 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -697,9 +697,10 @@ static bool try_fixup_enqcmd_gp(void)
>  }
>=20
>  static bool gp_try_fixup_and_notify(struct pt_regs *regs, int trapnr,
> -				    unsigned long error_code, const char *str)
> +				    unsigned long error_code, const char *str,
> +				    unsigned long address)
>  {
> -	if (fixup_exception(regs, trapnr, error_code, 0))
> +	if (fixup_exception(regs, trapnr, error_code, address))
>  		return true;
>=20
>  	current->thread.error_code =3D error_code;
> @@ -759,7 +760,7 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
>  		goto exit;
>  	}
>=20
> -	if (gp_try_fixup_and_notify(regs, X86_TRAP_GP, error_code, desc))
> +	if (gp_try_fixup_and_notify(regs, X86_TRAP_GP, error_code, desc, 0))
>  		goto exit;
>=20
>  	if (error_code)
> @@ -1357,17 +1358,20 @@ DEFINE_IDTENTRY(exc_device_not_available)
>=20
>  #define VE_FAULT_STR "VE fault"
>=20
> -static void ve_raise_fault(struct pt_regs *regs, long error_code)
> +static void ve_raise_fault(struct pt_regs *regs, long error_code,
> +			   unsigned long address)
>  {
>  	if (user_mode(regs)) {
>  		gp_user_force_sig_segv(regs, X86_TRAP_VE, error_code,
> VE_FAULT_STR);
>  		return;
>  	}
>=20
> -	if (gp_try_fixup_and_notify(regs, X86_TRAP_VE, error_code, VE_FAULT_STR=
))
> +	if (gp_try_fixup_and_notify(regs, X86_TRAP_VE, error_code,
> +				    VE_FAULT_STR, address)) {
>  		return;
> +	}
>=20
> -	die_addr(VE_FAULT_STR, regs, error_code, 0);
> +	die_addr(VE_FAULT_STR, regs, error_code, address);
>  }
>=20
>  /*
> @@ -1431,7 +1435,7 @@ DEFINE_IDTENTRY(exc_virtualization_exception)
>  	 * it successfully, treat it as #GP(0) and handle it.
>  	 */
>  	if (!tdx_handle_virt_exception(regs, &ve))
> -		ve_raise_fault(regs, 0);
> +		ve_raise_fault(regs, 0, ve.gla);
>=20
>  	cond_local_irq_disable(regs);
>  }
> --
>   Kiryl Shutsemau / Kirill A. Shutemov
