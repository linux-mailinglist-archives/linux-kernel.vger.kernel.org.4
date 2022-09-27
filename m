Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473FD5ECBA9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 19:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbiI0RwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 13:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbiI0Rvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 13:51:52 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11010003.outbound.protection.outlook.com [52.101.51.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5D35852B
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:51:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MYbwM/mA93XX6f16/6LxRBdloKTELbokPDNzeUlv5v0mfluRqqm/dQQAbl2BL7Im/3nYBWFCBpnP8wrE/fGb6Ated4GHO35RZh5iwx1VirwXm5bPN/mGt1eKAlYY2MWNnwJVFrZ/vRzLi+ksyD9jt6WzR4rpistrrAEE7JA7E+pi18sICZ2mZzjzvg9aPVso/nLxqsB/T8c+JbnhRszRG6MOkJsBIc0t9o2dJBQrrT2ZuUgiv/CuL/KFI9QMc2jQpggNCp5+HfCQMjkrvxz+nVqy4FjcrV6tRBmu68dLwEk3NTbegKfpOIR8QS6dPQM/aiAJyA+z+bUTMDz23jpV+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XzyKJ2k3SJA0KSK8OgPUyUTpMvzDyfMstTiF1CFip+U=;
 b=JP/QtOZEzdpfksc+nUXz7lZPyVr9jP/62PqPPvUDm64ihyIbJtfsEHU1vhu8Uni2wA4SExVQN7J+iTaPketuWIi+u27L9zn+1sZFWcNJXuKzdMgUgtehQjXjU/PPtzO6+9nxH08pEZ7UEDarmmf7HjD9J/2Nc04cP2bWklwe0v62OcdASPTmn0BfSMV2bn67FbPXuLmqUe1GqUPvi4S9dG/s6CTXyyb3GRUfQQq2A7vMzieAMDCRuimTE5qE2C3wKKNRHKzFLQWol9qqbIcE6Vznj44Qfp1TN4ckkt3JaBjLQjGLW4k9tT8PyzeQOzGGcAFhqDq3TB7sMxdBUCx6WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XzyKJ2k3SJA0KSK8OgPUyUTpMvzDyfMstTiF1CFip+U=;
 b=HZSDIIUOypv21L3dj7WRONFkVVgGTN6sVfDW2/WBivh3Ug7lJQnTGiPvo1sXLmvczJsdhJOiXX1W7wNVes4aiU4rrS6HAWZka9pOLIja9MUpDVWWOLutNDVcyUjhZhzi9/Zr78dwZLBb9Z118plGpa2WwHe3Q1VqhGcOB1kgOEw=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by BL3PR05MB9162.namprd05.prod.outlook.com (2603:10b6:208:3b9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.13; Tue, 27 Sep
 2022 17:51:19 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::942c:7d1b:6b3d:85b6]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::942c:7d1b:6b3d:85b6%5]) with mapi id 15.20.5676.015; Tue, 27 Sep 2022
 17:51:19 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Chih-En Lin <shiyn.lin@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Li kunyu <kunyu@nfschina.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Minchan Kim <minchan@kernel.org>,
        Yang Shi <shy828301@gmail.com>, Song Liu <song@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dinglan Peng <peng301@purdue.edu>,
        Pedro Fonseca <pfonseca@purdue.edu>,
        Jim Huang <jserv@ccns.ncku.edu.tw>,
        Huichun Feng <foxhoundsk.tw@gmail.com>
Subject: Re: [RFC PATCH v2 4/9] mm: Add COW PTE fallback functions
Thread-Topic: [RFC PATCH v2 4/9] mm: Add COW PTE fallback functions
Thread-Index: AQHY0o4guHAFznI8wEuVwbu/hl4Z4q3zjmEA
Date:   Tue, 27 Sep 2022 17:51:19 +0000
Message-ID: <8041503C-D087-434D-A026-90BFD0CAF209@vmware.com>
References: <20220927162957.270460-1-shiyn.lin@gmail.com>
 <20220927162957.270460-5-shiyn.lin@gmail.com>
In-Reply-To: <20220927162957.270460-5-shiyn.lin@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|BL3PR05MB9162:EE_
x-ms-office365-filtering-correlation-id: 906ea4f7-47d7-457c-ccc9-08daa0b0e20f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jjUaA3x/+Ka3DtHbrF38sgL01nH0oaQXXw/NEuD7CGply7zCP+06Y+zG6F2IbmVbr5t+/q22juI6/IHlTCj7fEiCBEOitY0SsSdp7VBfW/PTq3A0IK3RtA1a8MqjBuwB+xu7lNIMxB4Ve1o75d3zmu0mxl4l9fUArzR3CaweWsJUE/XoWEHn/oUTjBXXcsanK+JqFpaY/XVQLu/y0cKrw4oR2q6UZDmPIJHJ4rfjGslVXf19GrA4ngh98iWB90j9QazhnuoYlMXdCqiSAI0XpySHyIOF3ND5P9YXy8JFor4WgvS1LZcMdCMh/PajLuJvpeEeD41oPmkirTx64mceanMAAfQEZA++Cv6wy/k2KAYkwifBqdhgqOf1+iZJ8oxYr9JvegbxIGdvUznk2jGWCNUvYk7WNbFD/LAiALd+FKF4MSoqxStYm21SIish4AzNa0roHdWh3lgaxtR5LFqfspMjY2vcjhIg6V5bP7hUeAgOnz8bAu+uFqoqC9d5LV87vJe3L5j8EXkBzQupPNBz49B3B+uKHtr+elT94sQBb9+/6IxE4pJIMHI/5D//53bX/JddAzagFsOlK0JNAZ17HA3t00QvAgV8yWoBLX0TJXmwdcXSQcVgMvozPVjjxSAf5i+6cqUBTG3W15XmdB+uf0hkUvp3+4uvLP2Y1BUx0SgdgugZSjhIUksb70HVt6tTSYNbZUZUV9ikqZmPTpSDxMcatD83rEGfKAsvgws3ivqkVdn6qunMrVQ2KyNi7m2PDBvwIkewU0Zgb287Zjv7OMvmuiO5Yvl14YODj74ELVk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(451199015)(4326008)(36756003)(186003)(83380400001)(2616005)(38070700005)(33656002)(86362001)(66476007)(122000001)(38100700002)(66556008)(66946007)(76116006)(66446008)(8676002)(64756008)(478600001)(54906003)(71200400001)(6486002)(41300700001)(53546011)(6512007)(316002)(6916009)(6506007)(2906002)(26005)(8936002)(5660300002)(7416002)(7406005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L0z/xyW5cYhwz+uA3LxSdFm/+VTHKuASR81Mg+W50fav73MDYwwmz3eAdo6S?=
 =?us-ascii?Q?WhtEK+6BmHb3Gxyx2b3TvwUiX8dBNIjzlCLp+tVkipjF5uCaANVTFH1Di8M5?=
 =?us-ascii?Q?k+fx+blNfXFSY2nMqvyXP1ENXsBkpkBNU7bz6yZzecrFUOXukDTcB9ijiyTu?=
 =?us-ascii?Q?VnlHO3MxKkB8+TprA5kfyBMWcNPXjUP5CeYuQdsVAmbiY77rTRjsbRRWgFyZ?=
 =?us-ascii?Q?1odB76btIWZTppLrg34mhfNhqwaTv0dTJMg4aFHzCo4QHG1PPB2XNd3uIPQw?=
 =?us-ascii?Q?UyxdOrv57AYQHF/QOw7YCzKJAZvSzYSQw+Bk8PIQmTuA/5qrBIZzOIcjPUfH?=
 =?us-ascii?Q?eudV3BuuktyW4+KB04rmUAAo3F+pCXfivgkJqi7sfW2Wi53aPObsRL/Fma54?=
 =?us-ascii?Q?knYmdu0K2jISOs3Lyhkdouhzi/VdQXagGOIq5vQuZf+NasieVHOesu1TzBDL?=
 =?us-ascii?Q?bdGS8SgLMQH97lmGCZCshjCMn8UDkddOdep7BKXjAYxh6UdJQ8tNFau71q7d?=
 =?us-ascii?Q?W5yGwYfODVDtQeX1julZbCVoKMOuBpCZt9HwGJP2qBqL7OJjY3IGODEyOs34?=
 =?us-ascii?Q?+DINqGbxkx+R3Gh1DtYrZYDINnpg1P0FH2P+hXIPfSdckR4KUsX/SdByEbNV?=
 =?us-ascii?Q?1QN9fNgJY4VQoTLUdTTLQ0R83gdUEqE+G0AVhPqelMdaPKoDlDNAH/Z0nVot?=
 =?us-ascii?Q?ml9KgoviDln2S1OHk77KncvPWqtif/4KcOm/7+5tzOzUAc5Y05SzA2+uoV17?=
 =?us-ascii?Q?WMNyyX9buHbjzkEkhGQ2UwHvK/nFBoYktTvfMBaFpXwOgcWG1n9PtoVCGASG?=
 =?us-ascii?Q?SDhUn9Apo+CdqHWOQaqSl3hiHxmJIlmzHDGOL5Cn3XG2Whs/4CaV0UisXam9?=
 =?us-ascii?Q?ff9FEVxt8MmcXXIkp2H87afCDLa0E0mNjKgagWha5TsfQd1Iw8Vb0cgcsvNI?=
 =?us-ascii?Q?H72BepzaxGxWXAdB5Z3Y/ZNZC6Ud7o28/e++u8mzmpVZrAQwqFndw6336gQU?=
 =?us-ascii?Q?elT0rhKjoh1S+gF2l3kMcUYwEWwTuIRe42UXp30w1nrRb+eSiQ9fADfwCBne?=
 =?us-ascii?Q?XiU6qdoq+JLWeN3SwGLz65PaaJE17ZJpv7CCjuDR+CDUrmhmDayjyQS/Zc5G?=
 =?us-ascii?Q?ZAneSPF4wgU2yDMtl+om96937afEY1h48DKW7EKGan5EDwSQsi8cn8ONvq+P?=
 =?us-ascii?Q?dxgQlkIp5keIe0kVQS+SN9egn9e98nGISPOOViD83Z9oT6s4FXVbXGpAaOAt?=
 =?us-ascii?Q?dENuuHkRS2AdnzUaCIwFD3mvRXjN3VgbBnR4ospOW+03axXkaLD9IrpibCIs?=
 =?us-ascii?Q?RlMVKu0fjbjAVPzQrvFDVa1fUDkMIwbPMuifJslNEjc+Nnl+SjnWsbcL66O9?=
 =?us-ascii?Q?wDH+1q+BekOMjY8IKMo3k3oyTAJvX5su6v9ged71387v1k4OIvFt/MLKgT/e?=
 =?us-ascii?Q?Z2Ffv/x5cI8RxAQwoGomd5BLQQDW2+viivx4yb0Vdon0Ipq3O/csFZ6oSM8y?=
 =?us-ascii?Q?IPsX338JwSjTegPpiIHSNy31GuZNwyT90MHkQoueyyeFdMLFxCVfFjJySB5V?=
 =?us-ascii?Q?msy1FOKBdU0qG8ivRacb3jspz+T+psSzNKdFIWYL?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0BA39C160582404BA77547E736D10AFC@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 906ea4f7-47d7-457c-ccc9-08daa0b0e20f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 17:51:19.3564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LVIS96JKjtumEdDTZt/91ZqxV/riThBigZMd99WuSWFLrWgNWmpLWWm1NJqob6sFmNkMMIZ665QLd9owTqbC+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR05MB9162
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 27, 2022, at 9:29 AM, Chih-En Lin <shiyn.lin@gmail.com> wrote:

> The lifetime of COWed PTE table will handle by a reference count.
> When the process wants to write the COWed PTE table, which refcount
> is 1, it will reuse the shared PTE.
>=20
> Since only the owner will update their page table state. the fallback
> function also needs to handle the situation of non-owner COWed PTE table
> fallback to normal PTE.
>=20
> This commit prepares for the following implementation of the reference
> count for COW PTE.
>=20
> Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
> ---
> include/linux/pgtable.h |  3 ++
> mm/memory.c             | 93 +++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 96 insertions(+)
>=20
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 9dca787a3f4dd..25c1e5c42fdf3 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -615,6 +615,9 @@ static inline int pte_unused(pte_t pte)
> }
> #endif
>=20
> +void cow_pte_fallback(struct vm_area_struct *vma, pmd_t *pmd,
> +		      unsigned long addr);
> +
> static inline void set_cow_pte_owner(pmd_t *pmd, pmd_t *owner)
> {
> 	smp_store_release(&pmd_page(*pmd)->cow_pte_owner, owner);
> diff --git a/mm/memory.c b/mm/memory.c
> index 4ba73f5aa8bb7..d29f84801f3cd 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -509,6 +509,37 @@ static inline void add_mm_rss_vec(struct mm_struct *=
mm, int *rss)
> 			add_mm_counter(mm, i, rss[i]);
> }
>=20
> +static void cow_pte_rss(struct mm_struct *mm, struct vm_area_struct *vma=
,
> +			       pmd_t *pmdp, unsigned long addr,
> +			       unsigned long end, bool inc_dec)
> +{
> +	int rss[NR_MM_COUNTERS];
> +	spinlock_t *ptl;
> +	pte_t *orig_ptep, *ptep;
> +	struct page *page;
> +
> +	init_rss_vec(rss);
> +
> +	ptep =3D pte_offset_map_lock(mm, pmdp, addr, &ptl);
> +	orig_ptep =3D ptep;
> +	arch_enter_lazy_mmu_mode();
> +	do {
> +		if (pte_none(*ptep))
> +			continue;
> +
> +		page =3D vm_normal_page(vma, addr, *ptep);
> +		if (page) {
> +			if (inc_dec)
> +				rss[mm_counter(page)]++;
> +			else
> +				rss[mm_counter(page)]--;
> +		}
> +	} while (ptep++, addr +=3D PAGE_SIZE, addr !=3D end);
> +	arch_leave_lazy_mmu_mode();
> +	pte_unmap_unlock(orig_ptep, ptl);

It seems to me very fragile to separate the accounting from the actual
operation. I do not see copying of the pages here, so why is the RSS
updated?

> +	add_mm_rss_vec(mm, rss);
> +}
> +
> /*
>  * This function is called to print an error when a bad pte
>  * is found. For example, we might have a PFN-mapped pte in
> @@ -2817,6 +2848,68 @@ int apply_to_existing_page_range(struct mm_struct =
*mm, unsigned long addr,
> }
> EXPORT_SYMBOL_GPL(apply_to_existing_page_range);
>=20
> +/**
> + * cow_pte_fallback - reuse the shared PTE table
> + * @vma: vma that coever the shared PTE table
> + * @pmd: pmd index maps to the shared PTE table
> + * @addr: the address trigger the break COW,
> + *
> + * Reuse the shared (COW) PTE table when the refcount is equal to one.
> + * @addr needs to be in the range of the shared PTE table that @vma and
> + * @pmd mapped to it.
> + *
> + * COW PTE fallback to normal PTE:
> + * - two state here
> + *   - After break child :   [parent, rss=3D1, ref=3D1, write=3DNO , own=
er=3Dparent]
> + *                        to [parent, rss=3D1, ref=3D1, write=3DYES, own=
er=3DNULL  ]
> + *   - After break parent:   [child , rss=3D0, ref=3D1, write=3DNO , own=
er=3DNULL  ]
> + *                        to [child , rss=3D1, ref=3D1, write=3DYES, own=
er=3DNULL  ]
> + */
> +void cow_pte_fallback(struct vm_area_struct *vma, pmd_t *pmd,
> +		      unsigned long addr)
> +{
> +	struct mm_struct *mm =3D vma->vm_mm;
> +	struct vm_area_struct *prev =3D vma->vm_prev;
> +	struct vm_area_struct *next =3D vma->vm_next;
> +	unsigned long start, end;
> +	pmd_t new;
> +
> +	VM_WARN_ON(pmd_write(*pmd));
> +
> +	start =3D addr & PMD_MASK;
> +	end =3D (addr + PMD_SIZE) & PMD_MASK;
> +
> +	/*
> +	 * If pmd is not owner, it needs to increase the rss.
> +	 * Since only the owner has the RSS state for the COW PTE.
> +	 */
> +	if (!cow_pte_owner_is_same(pmd, pmd)) {
> +		/* The part of address range is covered by previous. */
> +		if (start < vma->vm_start && prev && start < prev->vm_end) {
> +			cow_pte_rss(mm, prev, pmd,
> +				    start, prev->vm_end, true /* inc */);
> +			start =3D vma->vm_start;
> +		}
> +		/* The part of address range is covered by next. */
> +		if (end > vma->vm_end && next && end > next->vm_start) {
> +			cow_pte_rss(mm, next, pmd,
> +				    next->vm_start, end, true /* inc */);
> +			end =3D vma->vm_end;
> +		}
> +		cow_pte_rss(mm, vma, pmd, start, end, true /* inc */);
> +
> +		mm_inc_nr_ptes(mm);
> +		/* Memory barrier here is the same as pmd_install(). */
> +		smp_wmb();
> +		pmd_populate(mm, pmd, pmd_page(*pmd));
> +	}
> +
> +	/* Reuse the pte page */
> +	set_cow_pte_owner(pmd, NULL);
> +	new =3D pmd_mkwrite(*pmd);
> +	set_pmd_at(mm, addr, pmd, new);
> +}

Again, kind of hard to understand such a function without a context
(caller). For instance, is there any lock that prevents
cow_pte_owner_is_same() from racing with change of the owner?

I would expect to see first patches that always copy the PTEs without
reusing the PTEs and only then a PTE reuse logic as an optimization.

