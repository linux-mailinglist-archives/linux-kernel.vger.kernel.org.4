Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B514674E379
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 03:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjGKBeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 21:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGKBeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 21:34:44 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DE2EA
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 18:34:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NBYM6bkd6T9oWeHBEqYvE4xhX0eopYi3MLzF+VU4nXPNahBmfqZNg5bFWz/EdwvPs0tn+0Yau91Ex7Ym6hu/ZQBTIeSyHgAaj7HHyglJS3ZIELB4KIzR6h33M6qDVRnlJ/1gjH+IMIYXmMAo+nAG4N2hQCQ2zn9OeOKFNCNUhHOyU37JCICKBIjLMetgZtYl4pLsL64AKNGngP6bVq00CDABvUbBIWOOskXXayjChj3XzTEP7UU7Sm4sNinr60Hml9/qcwJyx/cNusivmFC2aG6peBbhENXARmq8BSOsK06YvRxLlYgVuQs0sutcmNiORrLaWCeJHLpBhXWY5tjdkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ko0RVe7jLQvd8JtwLpG1J8HjUKk68OuezLymn8GY4nE=;
 b=VZDjvoKDjJeGdLnR8/BSCFmMcQGPsbgUOPyW/M2v7OVF7w6oR1AgcoWviqh2F3dNf30qJBZI9mMhQaB7a2vvBhri0jNytRJXgHGCWHSA/V6KD09fTbb4vjJa4TdQUgTMw6SCuh5mW1zofmnMfICoKeN48fLcktll73fXDE/57FVbhf13QMABz65gFO5GRuDv7mf4stkHhnCgY8PEX8dS8kroOIui78VBrSN1ItxKtD91C9M+qMkDblKJh9aI1ZwgX8iJqff8Gyb5RsPW1S+rAw3XksF2+gx9so4EUoFxoPmrVtMtcr9XU4+jRxbDyAKaoDfyrW25hahsVQKjkvYn/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ko0RVe7jLQvd8JtwLpG1J8HjUKk68OuezLymn8GY4nE=;
 b=RRzd159wtn+Wll+N8GPmEQZJvnNAdjWqJ2dsEZzBBTAEPiz3stlSwGzS+xIrjax4EVu5n/688zOTUEklG8BpB20d+6LPYZs86WdT4ilCRIt8ttMJxZW659uZPCqZMH/LYtqva5OAwAAtBlKxlwJqeyVacI6NH1o/m8SyGnwmKXn3Mb/GRgiDks14uBIS8CKYpAysbKs8SADagwntr7AcCPkha9HeMLcHMUOxv9dPx5txiMYVZALx/PRp0pQPhEi7BGeJWXc6RoPLjJUko11bRT9HsYvb65mYBgYI0andqf1oSJpcN0duRFnARt0O3DQh6QmhU5Lhk9hLOUDcZT8WUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 BY5PR12MB4289.namprd12.prod.outlook.com (2603:10b6:a03:204::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Tue, 11 Jul
 2023 01:34:40 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::12b7:fbc0:80e1:4b8b]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::12b7:fbc0:80e1:4b8b%3]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 01:34:40 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 05/32] mm/filemap: allow pte_offset_map_lock() to fail
Date:   Mon, 10 Jul 2023 21:34:36 -0400
X-Mailer: MailMate (1.14r5964)
Message-ID: <68C1B34D-B8B7-4151-B780-5A05812F402C@nvidia.com>
In-Reply-To: <54607cf4-ddb6-7ef3-043-1d2de1a9a71@google.com>
References: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
 <54607cf4-ddb6-7ef3-043-1d2de1a9a71@google.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_9D30298E-0765-4062-B4C2-C2F5A4F416BB_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:208:d4::15) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|BY5PR12MB4289:EE_
X-MS-Office365-Filtering-Correlation-Id: b46b91ca-e24e-43c2-7b7f-08db81aefea8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HlEroNe2sYVwRcR/iFbwCMemh9OSDHzUVazM+D0o3Rn56ixtindzyd5eRTpsybhe4zUpkHtB+miw+268s8RP0s+qZlfEHMJj7zL4fmndXMw+VYUMxLw5z6rynOQHC61QZjNVga9JawsEjA5bk5cxLFQcJRQXWZPdsQFgZvvspmJptI4C3HrhZ5R+4/+9xiHBqcf/H14lIlLW5SIsR7L6bPT8Eps1GloOSPAsyBSHv9TZo0kVcRWAkZ2dwgCzOPZ+tH6rAo7NAxwH/kUYg5m+rA3cHZUPq0K/eZFvdjmW/wK+N6sr17oR8Cnkf18uHrcO6YgOMiPJKJ3EvP8WR2AdzEpBlGaFdM48ojLvOkbFUdaZjGlLAgUNTsR0cJbITu8ganMA+tX7PB62ZPKPdDkdwl1Kbfft0G/BbkrOy02ZWQDgOKbGyBqsxSG63HzN/2rqr+W5T3A/lFQZ09eaP9O+ZWxXbDWjdS0BTWFHAybuObDwmzCAcIHy1t3n9QL3kg1ia9XAySvFcMiwgf5QS/GjyoBiPiteHKviO+UiSKrD/B2jBtPIthHfR7rUDgyTkiXxIxGCHdu1I15/oV4VwisnyJwmAelus3UOCd052DVsk3Qzf5s4u3N885/0QhJW9jJhS9QhbKGQKDHyqddsdRj+Kg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(451199021)(7416002)(5660300002)(235185007)(8676002)(8936002)(7406005)(66556008)(66476007)(66946007)(2906002)(4326008)(6916009)(316002)(41300700001)(6666004)(6486002)(6512007)(54906003)(53546011)(6506007)(26005)(186003)(83380400001)(2616005)(38100700002)(478600001)(36756003)(33656002)(86362001)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cLDOV2mgX4YhBn04a+gLNF0PKdd20FG8GtMQ/aPQETpMEP8rXjhpbzwIn1oX?=
 =?us-ascii?Q?ahcEleZNAyHJC4VZ/Ya91z0KQsbQoMGaqLpclMCMKExPLButHhZHyBH4cVyD?=
 =?us-ascii?Q?Ghml/OigjsBRdT7ioZQoRCK/mIVyLWjxSC7yJY1rrU6WmXWSwVzaiOWLaNEm?=
 =?us-ascii?Q?MzI1DuJbSkVepVa3CW4kL7R4rtxs/dlW1CkBTCZyoA2DJeyGmGfr5c9ZMThV?=
 =?us-ascii?Q?cfinjA8oXFmPsNOknqrBUj8o+un4m1nju1W6K0a1dqg9+qRoiFSWnHI/KzmO?=
 =?us-ascii?Q?+Nnr0uMpOTEZqMIjpYCf0bcxCaoUaDWAvhqRZmZX8LyH7qlnZytCjswZcXx7?=
 =?us-ascii?Q?iy+LW+0ERF5wPJiZda6V+Rs77/+fbxhkvc2tSrgG0BwbfbLpJIim39DohMCZ?=
 =?us-ascii?Q?6HEk3IY0F+jSrzK7EITXff7btrBaovu/GHVwv0fjCeZLldtN93CW/aIHbiT3?=
 =?us-ascii?Q?lxTChWEKgkCqet8Xul2KV14vBsRaAklsP9zdPnGfE8AWg+VuzcOaiCQAwAJB?=
 =?us-ascii?Q?EyX0KceH6WqNqvh63mCgiCohkrMPaCTXKIsVA4yLG33jwYLGVH/lbeF73+XR?=
 =?us-ascii?Q?avWRbPL9y5GyGgJDjPzLj1Fb6oCB5L3fVrwvYANuy2UCeqcljBRUMlQDmokf?=
 =?us-ascii?Q?IAIFplTZ7nh+bvyW0EHD/kYUJdsM6acB+ra6acuDLT8gg27We651rUXhJaO5?=
 =?us-ascii?Q?4x4lgOy+56NU4pOCBkm8CRzt7LvxqmlJMsN/6RDw6bkOf9rlUd4Mmuz/aNMg?=
 =?us-ascii?Q?MuFT+zQlecKC98LrRm3fIMacA6gB/5FXh3aB6VvwICaY4Or5CnaylspsrDfY?=
 =?us-ascii?Q?NsDwquH6hayXjhp4uur0kN0HDxmukMN3kuk5zY+qAeNfenZMatkwj3C+wSEU?=
 =?us-ascii?Q?7mGTSvstXjaCiHdk7scca3I/gFMOHAr62iKXI7BhAxTjSXRPyULxtJx5gKh6?=
 =?us-ascii?Q?QUxYJA4jZyq6wrdynfgKYv2D4osGPvVCB2dOsJscS0vcR+8UnUhA/WPb4s7p?=
 =?us-ascii?Q?sEgsOsEqkCe0Wi7SKEzdDsmtRwZe7BXV78R8aiNSb9/rvB7Vv2nyIDDwae8z?=
 =?us-ascii?Q?Z/mmzRfFSnN4BrRSGxPwiCUBjwFyT9wVD/5YBrAF6T6Rryc5IzxQaVhm+OAy?=
 =?us-ascii?Q?PuBUrQTww5rhdVk1gHpm9D8QpzMgncc4zTjhH50J54ik+CQTAztTes+f2hp3?=
 =?us-ascii?Q?4Lf6QBxv/u78BQVEUoJoBHuDhlb7Q9+loUhRTpMhrNl2oeC+DI7xLrZvVpoV?=
 =?us-ascii?Q?mcmxO+mR7EFDZ2yOlAirLCkXZ+HQieCy9ePUJdWtkTCduLv5cEu0tS9xxZ/+?=
 =?us-ascii?Q?L51MZBHJLcqUDRnFreP44qF0l2NvaANPo7uWvPdSBr2dTPEeJ9GshdXVOITn?=
 =?us-ascii?Q?CSK5nIvzXwi59HRn4t7IghhrzZKe9nuAx7J/Porek1WxoP4bZt+qwYL5MkLH?=
 =?us-ascii?Q?MCrAfAUssHzPKsfwzNCfHAlCjUZkiMpbBmmchnE9RZ32ocv86O0WpNildm0M?=
 =?us-ascii?Q?B+N5ky2IFtdkB0LRJdIu3BftZD8eImFuj+sG5oIQSEk9zPhjtyk6LzbIjodb?=
 =?us-ascii?Q?eWOZOIHWnglScv5q3Es=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b46b91ca-e24e-43c2-7b7f-08db81aefea8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 01:34:40.1693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xxc8aR1ZtIcAmxnTXV9djulzmZTNHlIY10oihlO9Af7qWnbsV/8hFRGmMOLHX+wx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4289
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_9D30298E-0765-4062-B4C2-C2F5A4F416BB_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 8 Jun 2023, at 21:11, Hugh Dickins wrote:

> filemap_map_pages() allow pte_offset_map_lock() to fail; and remove the=

> pmd_devmap_trans_unstable() check from filemap_map_pmd(), which can saf=
ely
> return to filemap_map_pages() and let pte_offset_map_lock() discover th=
at.
>
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>  mm/filemap.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 28b42ee848a4..9e129ad43e0d 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3408,13 +3408,6 @@ static bool filemap_map_pmd(struct vm_fault *vmf=
, struct folio *folio,
>  	if (pmd_none(*vmf->pmd))
>  		pmd_install(mm, vmf->pmd, &vmf->prealloc_pte);
>
> -	/* See comment in handle_pte_fault() */
> -	if (pmd_devmap_trans_unstable(vmf->pmd)) {
> -		folio_unlock(folio);
> -		folio_put(folio);
> -		return true;
> -	}
> -

There is a pmd_trans_huge() check at the beginning, should it be removed
as well? Since pte_offset_map_lock() is also able to detect it.

>  	return false;
>  }
>
> @@ -3501,6 +3494,11 @@ vm_fault_t filemap_map_pages(struct vm_fault *vm=
f,
>
>  	addr =3D vma->vm_start + ((start_pgoff - vma->vm_pgoff) << PAGE_SHIFT=
);
>  	vmf->pte =3D pte_offset_map_lock(vma->vm_mm, vmf->pmd, addr, &vmf->pt=
l);
> +	if (!vmf->pte) {
> +		folio_unlock(folio);
> +		folio_put(folio);
> +		goto out;
> +	}
>  	do {
>  again:
>  		page =3D folio_file_page(folio, xas.xa_index);
> -- =

> 2.35.3

These two changes affect the ret value. Before, pmd_devmap_trans_unstable=
() =3D=3D true
made ret =3D VM_FAULT_NPAGE, but now ret is the default 0 value. So ret s=
hould be set
to VM_FAULT_NPAGE before goto out in the second hunk?

--
Best Regards,
Yan, Zi

--=_MailMate_9D30298E-0765-4062-B4C2-C2F5A4F416BB_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmSssa0PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUzu0P/RasOUfRsb1uFZRkZyAwOaCy+cBQmc6bzaR7
wGJkMjsyfYMebEXtmpqsO5VpsTzDLC0LE5CQH//hRP6XGS16aF6oexlo1FB9j+Q9
74lZibnKBxtlayO/v5xWg6Dq4pagOxCPp2EkbbYyAr+ZCOgVYO6ANBHBezJh1QkW
ju0WfI7wFlhjxd/JcmFrHjeqgglfBF09jz5EPkWJ2R1JQgbAftXAIVmOfbxE9RrH
vlnU8FsrR3wvTZUmmZcXPBqgx559FYxuThWo9ZbY9H8sqH8pggN9CBKrsSSeuisz
1dRG0PybbrKBBAHDOjeEze/xOQ388SlSY/m6Go5dyKYPyZAXFplx8afXmsZIpI+6
IixH/oflqLM4QMSJ9+CExFjS80xoallkktnE7ysVksRD4/LwV3gU8YhoWMK4v0/w
WjakImXetyPeEDqIWkFFIFO5iuNJRV1f/n0PihjgfEvo4Ft/WO98XR4Z7Weuw4yF
eDc3vz84n/gRy6B7PC4zkGPR8/Y3prvDVS1RFyXY5P40/wPV8XUSp+mg+AU+9vIc
ucBmdIdrgqzl9G96zaHXvdJDmvBzPCp9PwY338FpqxIp5YWrAWI3CM8hcTFSTEiC
QZzz1gixbiClP8q4+ncdYMEWqmwgI2fxdfXbwf+ef/LxAepBPkf53/YW05A2dmcT
JOG8SPmr
=SJHj
-----END PGP SIGNATURE-----

--=_MailMate_9D30298E-0765-4062-B4C2-C2F5A4F416BB_=--
