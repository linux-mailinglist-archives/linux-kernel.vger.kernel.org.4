Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14CE633E95
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 15:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbiKVOMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 09:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbiKVOMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 09:12:20 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2121.outbound.protection.outlook.com [40.107.113.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA17B95
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 06:12:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XsMF2nKZLjb5KZrsxckN2ysfEYafWvSAYMSlAdkaBbMNKMJEv7ujsZFKHtbiu0wM8jZ11ypbB530K94QSmPiiNHBde1K3Pls+34H0qqTlVI1Y13VWsCORjIXkQhfVH/rt0iSMXnv9MVCGqAKvVHucxwvAlIKifAXbk/uQJspO9PBXs/i2RSvuWbHy2jVN6GCsZtItwNrLDa+AqApKXef24A3c/klVX7TfAA9ZUaWhGXwp7kDHrXzf/zb/pVWD/kcbvS+L+RUp3dJPAZ9C4xHp5UwbJa5xz7pjwzVgSoPfxwrQaBev4yV1OmIVj28OoXqysnscuzqGfeozadD7pRfjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9qVmWHR98x8o+pJfo2aVUgx9NWfGuPIXnHxohrjKRY=;
 b=nFXLpp++P9ltdiRpPxqMbvs1KobG27JKsYK+hhD81wu0ixkYg3IJS7iRJVo7YTGX50vvomH9giRiB1CKL6AcXWEAnUc2gOIPJxkvuZtqLMwVDbwARIikw0bvbUmwcN1GaGUTI9t4/JWpX5fOagjuqHtAtgcL64MhS7pL4qhGC+JF+ODDbr/GmZkSSZSHF2/jv+L5RrUZKvs7jKiMWoNs4H/mtobmXROAB5bQzexqH/yC4y9CXJlgqtHztLJ1NGemtZ/zoH22wybd0rTRnog5w9YKzZ8HLc1s0GNBQMWpXymiZXrMAnNPLDrK8CxYS+xekKwfPRUVzxnh0S0XJrEhYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9qVmWHR98x8o+pJfo2aVUgx9NWfGuPIXnHxohrjKRY=;
 b=XfOxchjWA+LqAHrP/NKHhayhbECe4VskXclCQPUzkvmWFisbIKkqnSaD3GRHo3HmmLA120WHHaLdjEPMmddgibBRyJ2/c+N8kGnR31f7T5adLOezTSuLki5MitemRKTi+Oe0PGQfBvma5uqg7BDc46Oeg9Y9yN9QAnoaxd0lLM4=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB8347.jpnprd01.prod.outlook.com (2603:1096:400:160::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 14:12:16 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2cfb:38d2:d52e:c8a3]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2cfb:38d2:d52e:c8a3%5]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 14:12:16 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
CC:     Nathan Chancellor <nathan@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: RE: [PATCH] arm64/mm: Drop redundant BUG_ON(!pgtable_alloc)
Thread-Topic: [PATCH] arm64/mm: Drop redundant BUG_ON(!pgtable_alloc)
Thread-Index: AQHY+w/c1mbDSQruokW0nryDLsaO8q5IAM6AgADd3QCAAHSNgIAAGLsAgADeswCAALfCAA==
Date:   Tue, 22 Nov 2022 14:12:16 +0000
Message-ID: <OS0PR01MB59226915D333B47338B0239C860D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221118053102.500216-1-anshuman.khandual@arm.com>
 <Y3pS5fdZ3MdLZ00t@dev-arch.thelio-3990X>
 <fd67eca3-59f4-4455-e3db-ba853c3f949b@arm.com>
 <Y3tuxzl54BvG406t@FVFF77S0Q05N.cambridge.arm.com>
 <5b69ff03-1694-bae6-3312-a63273be4073@arm.com>
 <05b6ea24-1135-bcaf-a24e-c0bcbf14101e@arm.com>
In-Reply-To: <05b6ea24-1135-bcaf-a24e-c0bcbf14101e@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYWPR01MB8347:EE_
x-ms-office365-filtering-correlation-id: 337814c4-72c9-46cb-8b95-08dacc938f45
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hu8KNm7EzKYysRJjP76d842zmoKxeyNFbL2eNHTxf90xnnNxllJo33GUc/+tPMuXmdIiaLd1B0RcVQ5pkSNSCJKaSNU3Za8VCTvQpUMqXf4zARkqx+AmXFavSiDPWD4v3hvw36cGD4SwDQlZ0pLLsErBxZ7MiVJJ+lozcDcgTzbItzxn+cPdExHWL5oPpVC25YcujhDUao73mMtM6eJF1KjUT83FxQP9OPgLYjRp4G7ahYe/blh90w+/hXB7gKn7bj3Wdj0eVKKUs2do3dYeftbLMmxNXU7AhP62LLrcT/iBuqYDUIWyb+6Y7m4Qdg0P6E7gihFm5uUotAjV0PMsZrsidCpv+0duZS4vvNf56KJjtROleqhDAIxjGUKw9Y4WpFcP665kqJ4qLzbxbmbbMWm94GOkQcmyc4ZMGX5eT97SBmRZvD7ECFhcZ6U+JadCr032nPMbRr6+Z7WoZA6CqHEn5ZaaMZoUrvVIYRJ8q0SCLHw4VRVkGTHvHVTzNwPcjHBGWHLwKWjXMWG28MiCh9wi/UhAeJdlAInyOd5PjJRc0CqbLFRz0mzTkLE6yoJ3Hvb0G9cT7gR/1XkHs9poiMcCONbFZhO1or3Xp7gEYGWM8fBInyP31Bct7XfD6zC7avsXzF0UpDUVvn/VLQAv/NGPBx+sdLO/rdD9Ibf3EgiCOLtVdJ4ewzj9CoJdgQxr/HrSBpPJ139FzVt5RlSNuAkj7K8lQnAfQnfvEQZz5vI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199015)(110136005)(33656002)(53546011)(7416002)(7696005)(6506007)(26005)(316002)(9686003)(8936002)(54906003)(52536014)(64756008)(5660300002)(66556008)(76116006)(4326008)(8676002)(41300700001)(66446008)(186003)(38100700002)(122000001)(2906002)(55016003)(83380400001)(4001150100001)(38070700005)(66946007)(66476007)(86362001)(966005)(478600001)(45080400002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?RYywq2NVJ7ur9YdUes8pjnqPaJBlem22ttvYWxEu4ERTqjFjg9nVYnMBI3?=
 =?iso-8859-1?Q?aEzU4Yhb5yMasE8M8m7ENqAhm4nrAKeSFFnThA+xg8Jf4zFzyJtzMrWwCj?=
 =?iso-8859-1?Q?7StlRx+62cv55c64rDF8b/IsJz6T1a4LIZV29jTbLVZOBJnvoYsET+1j22?=
 =?iso-8859-1?Q?5Zwd4W4HCQbk+QxP08lEUn3Xv68RbRK4HWmdYDCU767riOLrfadehdFHJP?=
 =?iso-8859-1?Q?Ww3D7I4bzz/nDJc5pXkiWtHN22yjtFMDYLvq1TA0/eBmUgPZgmwQtfY3eo?=
 =?iso-8859-1?Q?/6q5ONV3qhJxuLUc+upT+PTWjWHZIoWq1Km2+zeO9GCdoPb22LNjM79KXH?=
 =?iso-8859-1?Q?aKdNlvpsmxv16DjSWSbdGg9e8f2O2nkeeha1gUeP/mk3zGql6+n1DKYW3J?=
 =?iso-8859-1?Q?RaTSiEfqir5tAyZh2JtpQ6efeeGp0FF56SqEP7vZLixK5FKzhhUtjufBEk?=
 =?iso-8859-1?Q?+5NnWtRB5lMGOroBagM7a81p23DRDv2nYwHxyczzxTscLHeM2Y6oAxwepx?=
 =?iso-8859-1?Q?R1cdmXlcFmIA6DNO3pfc4SRMZaqDdIdyUIN1R6a3sie+i54QAmyTXnakF5?=
 =?iso-8859-1?Q?mSD1kUD24DnquI6xdKlGq+2/i8B5En9HWtvI8KmSbOhUwplcQwmfxXKzJd?=
 =?iso-8859-1?Q?dQnYSGUMwWvE+rC48JADVXUjPihWEYGGYM5xXw3pjad5v81ao3i1XHWTy6?=
 =?iso-8859-1?Q?tn1cbUloM+lHh9A8HGgxa2rt7sOY7jdMJApl1MFYxr3KKiY/UU8Pqib1gT?=
 =?iso-8859-1?Q?nFPYMpp71jDKfp+L/yNgbVYgzJCnGol4pbufn3tf0P4UaxhEmCUKgybpJO?=
 =?iso-8859-1?Q?8BuV7ZTyiEdQV9vNecIvToQ79ZZril5GAELXevBpniL7XlaL7ExD/0g4IZ?=
 =?iso-8859-1?Q?KV3UjcdFHRFJDlcv0pgRp0bOEblj3Ou0wuRXiQWnFywN3VCIQmPVPk24Wh?=
 =?iso-8859-1?Q?sgc21wx7u1R37fIAjv/QOTRnUr6bpQ4UVcBS4+Ap7fj/mlLWQD7CskPrfv?=
 =?iso-8859-1?Q?VDu5ZuTi68t84dV8WbzqupFtg4fvWJglrOUWkFpLT4L0KNrwzylX5nTJRu?=
 =?iso-8859-1?Q?Oa4CU16Km63xUs+O0+CoDkRTCB52LnzvhaaqjOyTlVrTH47UIIgt8/D2Z6?=
 =?iso-8859-1?Q?OienACeY0m87AxWfF1o8VNKJYFocteC8/qszk39Cq3vsbqErZD0ulkccQR?=
 =?iso-8859-1?Q?Qwel0hWAIv0RFivN7mjW7jV/hbAJXI2O2+6ieIU3EGE4IHFtkJs4RdYvip?=
 =?iso-8859-1?Q?NLT0DmmZ8lT4mCL9YddHMF1z/7Im21ItFc/50GIVy7WIWpB3fnn0gQEGmS?=
 =?iso-8859-1?Q?V/gBr1VTyjg3hXr0ztfyjzJMJDUPUb5Sy3Xk6T7Js5yY+0Mn3ohE/vEAwj?=
 =?iso-8859-1?Q?F5WJqHBfNlZqt2xDHsFSWmUyS+DY4d8WvFI0mg65d0ikq2pu2EhhkAdbAB?=
 =?iso-8859-1?Q?NgcfcG82iOJXpLgYBMWoQCGBa+B/b2zsJdiKgfASv/9mHoBhTR0faHZ2Nf?=
 =?iso-8859-1?Q?J3DpvKBicGkCzACF+F9KfYfAOHmcVgw134L/olhDrXWTXmA5IExftuu1oC?=
 =?iso-8859-1?Q?m0gXLS5GSYK4E8Tp8SsYt1B46tARimjSgH7CR5sLEI2VptMSjJ12qOOlov?=
 =?iso-8859-1?Q?1qfo/8EHZsYIl8FmQ2tK2FFJSCsvrN8NHu4UEMY7rJRgmFKcgNYKy83w?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 337814c4-72c9-46cb-8b95-08dacc938f45
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2022 14:12:16.1836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4tyty2riXUYEGiB+znyG+jbVHiK5oG6RKlF/v6qmdisINDWWhBLx2bQOGdhg0MmQ/zRw6TvFKhLTrtyMklKZxTpXpxQFQjtxaaPoLHT6tXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8347
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

> Subject: Re: [PATCH] arm64/mm: Drop redundant BUG_ON(!pgtable_alloc)
>=20
>=20
>=20
> On 11/21/22 19:26, Robin Murphy wrote:
> > On 2022-11-21 12:27, Mark Rutland wrote:
> >> On Mon, Nov 21, 2022 at 11:00:42AM +0530, Anshuman Khandual wrote:
> >>> Hello Nathan,
> >>>
> >>> Thanks for the report.
> >>>
> >>> On 11/20/22 21:46, Nathan Chancellor wrote:
> >>>> Hi Anshuman,
> >>
> >>>> I just bisected a boot failure in our QEMU-based continuous

This patch created boot failure on RZ/G2L platforms as well.
Reverting the patch fixed the boot failure.

Cheers,
Biju

> >>>> integration setup to this change as commit 9ed2b4616d4e ("arm64/mm:
> >>>> Drop redundant
> >>>> BUG_ON(!pgtable_alloc)") in the arm64 tree. There is no output so
> >>>> the panic clearly happens early at boot. If I move back to the
> >>>> previous commit and add a WARN_ON() like so:
> >>>>
> >>>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c index
> >>>> d386033a074c..9280a92ff920 100644
> >>>> --- a/arch/arm64/mm/mmu.c
> >>>> +++ b/arch/arm64/mm/mmu.c
> >>>> @@ -383,6 +383,7 @@ static void __create_pgd_mapping_locked(pgd_t
> >>>> *pgdir, phys_addr_t phys,
> >>>> =A0=A0=A0=A0=A0 phys &=3D PAGE_MASK;
> >>>> =A0=A0=A0=A0=A0 addr =3D virt & PAGE_MASK;
> >>>> =A0=A0=A0=A0=A0 end =3D PAGE_ALIGN(virt + size);
> >>>> +=A0=A0=A0 WARN_ON(!pgtable_alloc);
> >>>> =A0 =A0=A0=A0=A0=A0 do {
> >>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 next =3D pgd_addr_end(addr, end);
> >>>>
> >>>> I do see some stacktraces. I have attached the boot log from QEMU.
> >>>>
> >>>> If there is any additional information I can provide or patches I
> >>>> can test, I am more than happy to do so.
> >>>
> >>> There are couple of instances, where __create_pgd_mapping() function
> >>> gets called without a valid pgtable alloc function (NULL is passed
> >>> on instead), as it is not expected to allocate page table pages,
> >>> during the mapping process. The following change after this patch
> should solve the reported problem.
> >>>
> >>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c index
> >>> 9ea8e9039992..a00563122fcb 100644
> >>> --- a/arch/arm64/mm/mmu.c
> >>> +++ b/arch/arm64/mm/mmu.c
> >>> @@ -42,6 +42,7 @@
> >>> =A0 #define NO_BLOCK_MAPPINGS=A0=A0=A0=A0=A0 BIT(0)
> >>> =A0 #define NO_CONT_MAPPINGS=A0=A0=A0=A0=A0=A0 BIT(1)
> >>> =A0 #define NO_EXEC_MAPPINGS=A0=A0=A0=A0=A0=A0 BIT(2)=A0 /* assumes F=
EAT_HPDS is not
> >>> used */
> >>> +#define NO_ALLOC_MAPPINGS=A0=A0=A0=A0=A0 BIT(3)=A0 /* does not alloc=
ate page
> >>> +table pages */
> >>> =A0 =A0 int idmap_t0sz __ro_after_init;
> >>> =A0 @@ -380,7 +381,7 @@ static void __create_pgd_mapping_locked(pgd_t
> >>> *pgdir, phys_addr_t phys,
> >>> =A0=A0=A0=A0=A0=A0=A0=A0 phys &=3D PAGE_MASK;
> >>> =A0=A0=A0=A0=A0=A0=A0=A0 addr =3D virt & PAGE_MASK;
> >>> =A0=A0=A0=A0=A0=A0=A0=A0 end =3D PAGE_ALIGN(virt + size);
> >>> -=A0=A0=A0=A0=A0=A0 BUG_ON(!pgtable_alloc);
> >>> +=A0=A0=A0=A0=A0=A0 BUG_ON(!(flags & NO_ALLOC_MAPPINGS) && !pgtable_a=
lloc);
> >>> =A0 =A0=A0=A0=A0=A0=A0=A0=A0 do {
> >>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 next =3D pgd_addr_en=
d(addr, end); @@ -453,7 +454,7 @@
> >>> static void __init create_mapping_noalloc(phys_addr_t phys, unsigned
> >>> long virt,
> >>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return;
> >>> =A0=A0=A0=A0=A0=A0=A0=A0 }
> >>> =A0=A0=A0=A0=A0=A0=A0=A0 __create_pgd_mapping(init_mm.pgd, phys, virt=
, size, prot,
> >>> NULL,
> >>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 NO_CONT_MAPPINGS);
> >>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 NO_CONT_MAPPINGS | NO_ALLOC_MAPPINGS);
> >>> =A0 }
> >>> =A0 =A0 void __init create_pgd_mapping(struct mm_struct *mm, phys_add=
r_t
> >>> phys, @@ -481,7 +482,7 @@ static void
> >>> update_mapping_prot(phys_addr_t phys, unsigned long virt,
> >>> =A0=A0=A0=A0=A0=A0=A0=A0 }
> >>> =A0 =A0=A0=A0=A0=A0=A0=A0=A0 __create_pgd_mapping(init_mm.pgd, phys, =
virt, size, prot,
> >>> NULL,
> >>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 NO_CONT_MAPPINGS);
> >>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 NO_CONT_MAPPINGS | NO_ALLOC_MAPPINGS);
> >>> =A0 =A0=A0=A0=A0=A0=A0=A0=A0 /* flush the TLBs after updating live ke=
rnel mappings */
> >>> =A0=A0=A0=A0=A0=A0=A0=A0 flush_tlb_kernel_range(virt, virt + size);
> >>
> >> This is now more complicated than what we had originally, and it
> >> doesn't catch the case where the caller sets NO_ALLOC_MAPPINGS but
> >> the callee ends up needing to perform an allocation, which the old
> code would have caught.
> >
> > Well, it's still "caught" as such - all that BUG_ON(!pgtable_alloc)
> does in these cases is encode the source location in the backtrace, vs.
> having to decode it (if necessary) from the LR in a backtrace from
> immediately dereferencing pgtable_alloc(). If that happens before the
> user has a console up then the difference is moot anyway.
>=20
> Agreed, also the fact that certain callers are sure about no page table
> page allocation would be required (hence they just pass "NULL" for
> pgtable_alloc function), needs to be notified appropriately when page
> page table creation stumbles upon a pxd_none().
>=20
> if (pxd_none(pmd)) {
> 	BUG_ON(flags & NO_ALLOC_MAPPINGS);
> }
>=20
> Although there are might be an argument that all erstwhile
> BUG_ON(!pgtable_alloc) has replacements with BUG_ON(flags &
> NO_ALLOC_MAPPINGS), but there is a subtle difference.
> It captures the fact (in a rather structured manner), that caller made a
> choice with NO_ALLOC_MAPPINGS but called __create_pgd_mapping() on a
> page table, where intermediate page table page alloc would still be
> required. IMHO adding that explicit structure here via the new flag
> NO_ALLOC_MAPPINGS makes sense.
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Flists.=
i
> nfradead.org%2Fmailman%2Flistinfo%2Flinux-arm-
> kernel&amp;data=3D05%7C01%7Cbiju.das.jz%40bp.renesas.com%7Cbcd488ff5f5c44=
a
> aaf3708dacc387479%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C638046840
> 104902697%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLC
> JBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DF%2B3%2F2E583sYk=
S
> Z2bYIUN6HmHO7aGD5KT2EuGCE8MY2w%3D&amp;reserved=3D0
