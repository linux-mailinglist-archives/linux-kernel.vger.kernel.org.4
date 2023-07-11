Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45FE874E36C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 03:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjGKBYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 21:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbjGKBYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 21:24:37 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48929170C
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 18:24:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FSJeXNGQUbKSlqeByYbXp6lhQB3tlyx83YU90xg0quIzLWqJYEzBjl9lw71wGQw/8fBGIg540Fxbdp0Tkka7NKxxKkZiCWGCw4RYcN4CCi+SqY4+l2mZith4ir1+X6hDkt/kchzg2HFyT+3krur8cKc8NFo18MX0PDGSj+eV17EB2SUmAyoeQrtR4JI8LTGAN5GlBkW9fjp3nS2ZijEq9mStufMKZ4OjUZlpSw93DoL3LAfvj3t1x5F+SCjdLUP4xpBDRTmG+kOCCWUFHEQmJFx7V89M62eTV0t48U+RCkLZy2pSfWnHnSClCMo62xJDBRUU/IS7BRkihsx8e2f/Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y1JCEDEaAdLvJpeEl1IQRxOS6FCeF8jIzJLchhD66Xc=;
 b=Ia2ILqKvqppzvtJQKwa4fd5Pgn6zH1UtNuc3g2U/zbPwxToat88YVvikNM6TnMRZJE0x3Sm9nZU7mMfZDZWemGrKFl4/LAI3XW7bNDAB6WRrwJ9Nj048fuSIktiE/ERhkfeZptxGSQCLbFLHmrxd8AMDU8KRoh6r8qYtghbK2E9DIZAhJ2iXAPqi/oZawo7ECJT4ckahB9X0uvZVGIFblBLsJ0LHkqhWXjcSM1UFR87mezUcCN+gcg1WCkUpPlKWV6Ogy7jo9qZyE+Ia1iSmJA8AMRUZQ0ctLfCKx1SKUj7VLZpLbphYrEmKnminrQtm1aU7XFPyG1qTTAmSx/jw/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1JCEDEaAdLvJpeEl1IQRxOS6FCeF8jIzJLchhD66Xc=;
 b=t5IzehC2PmyvAnNaF1F96xGYxTmYHD7pXFrQUvTEYqIdhWoGbrDgi8AJIMcR7j23UuxwtFWL1UsIWEjYIiWoQ0xtMgFIyEMtjbovYPt72vWujRhaUyGJxIOuuUneEKs0Fmrs7mx0TUM1sAhCWGnNKVtEuvLgEZAEohhFoaGcJio9C2dvH0w7H2IDnr12xliOzBTSm0GiigpprSOxA59aIn5G1iHXj4guFMGyoLK3CMMKJJeciiFT/CeSCL8/zbH5dOZXvXZFDeyvJb7tf8Zq4zx1IjFp8Ipnnv+PuQePFXyzPL6Fy/HNFqYEw3nEjW8Egge+uQuMy+oyPkyMU1On/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SJ2PR12MB8160.namprd12.prod.outlook.com (2603:10b6:a03:4af::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.30; Tue, 11 Jul 2023 01:23:24 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::12b7:fbc0:80e1:4b8b]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::12b7:fbc0:80e1:4b8b%3]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 01:23:23 +0000
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
Subject: Re: [PATCH v2 04/32] mm/pgtable: allow pte_offset_map[_lock]() to
 fail
Date:   Mon, 10 Jul 2023 21:23:19 -0400
X-Mailer: MailMate (1.14r5964)
Message-ID: <6C07B14E-7CAB-4F2F-9946-45A27245AB8D@nvidia.com>
In-Reply-To: <2929bfd-9893-a374-e463-4c3127ff9b9d@google.com>
References: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
 <2929bfd-9893-a374-e463-4c3127ff9b9d@google.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_91AF7087-EA12-41EA-9642-3658CA83BF1F_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BLAPR05CA0035.namprd05.prod.outlook.com
 (2603:10b6:208:335::16) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SJ2PR12MB8160:EE_
X-MS-Office365-Filtering-Correlation-Id: be282798-0691-4921-47c5-08db81ad6b40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T8Jnz1VAsfKssk3Dq0hu+ZYC3pfeUV8ceXf5gFzZ9EeyQkrz5yLXDEY0W8pRfdHv+UpF+rK7Dpbp0iQJsjfPbc5aDArN/N9Nv4l1cdFAqAwjxpZV9ZZLbrHdBXXAb7zAxenrEPJto2O0qUU4hJPAMstzLO4TZu3zrK6tbUqNLtt7/1Qns8VlFBuhm6iarR1tBY3p1xlvfGoLanwc97tG6ZKfV/OFhZvFkH0GWoA6Y/K4uSBL33HJJDHlHWlue3gf7XMMR/2udYB9SUlRrmm+StOVzlqaIGuGu+bbOlAtkM/hQU8BINcUh883z1UrGCLtSqv/AUA3w0Pp+KButAHQppfO/bswlQstKuSpPfw5DJsDciDfQLNyuCC8aQlJdMHhkbkhXyE2IHiFPMtskWXfusn8b8K1tLR2SVqK8bbTT4pEyQgRQ0dIhboj1aI3ZypmJPNlCpfCDMG2yb63LvC53yNBSsyPCncn6eP5dc9vPStMGiLvtmDmAczoMpjUIOYAl1MhN6Fvj6JHBb65MK65mS66PkYaN1L61nsYvfA0MotAuKQmMtIrdOvuZfN7E8n/NgqstAEc6Chz1TmBqYZR8FQTtg3SMWQ5VgF9kMqlI40QFktVFDNyec4Ya64yMqrPoMB6qXS/9xCL9RdsuddR7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199021)(38100700002)(86362001)(7406005)(36756003)(33656002)(6666004)(6486002)(54906003)(478600001)(26005)(186003)(6506007)(2616005)(6512007)(53546011)(7416002)(235185007)(316002)(2906002)(66556008)(5660300002)(6916009)(66946007)(66476007)(8936002)(8676002)(83380400001)(4326008)(41300700001)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PlCXvow1Z9A1JrnfawReUScH1Ieiu8GtKQTaXweaaX3vreqd0K7WNh8kT7CM?=
 =?us-ascii?Q?o+6mbR0fJiUanzW3EE9PlnVeGm01Jfl9sefE9SqrnPTY5FAeydzDdkpH2hy8?=
 =?us-ascii?Q?MKIh0KZpJFAqhs2uChO8ga+91P8CyNrNvyQ6h/2925Lyw8MKoYbm+jYqIXwp?=
 =?us-ascii?Q?JJhShIh7904AOw3ZI+GAv6Mp6ykfkd+CQHswvBf+dqxh1hDI4aR1a4riY1og?=
 =?us-ascii?Q?J4X+ABRrvnJbqLyGR5zWFnbpRJge410qa/EegDsRF7ChQTnp/Jdm2jdm8M0e?=
 =?us-ascii?Q?CvJVGXozg+3QeC2SUFKbuwJwoZhWUx/6dEY+K5Dn9ljJrg8i7m4Vv1+YBR/1?=
 =?us-ascii?Q?PLJ8BlyiWHMjb0fgHpIqKYhDyUPfFg9r9r8Ay4HgqzOig5L4BcqyAlMZzWKY?=
 =?us-ascii?Q?SfnKaD/+RzBP9SxQttltxjC9m3LCDQuqGeL2aQp4RM3k0mPdnRYDKcxHkiVw?=
 =?us-ascii?Q?/ZMIIlFEzwGXRZy0iQSEfKW9MXkWLPkjaSbinO5hkF4QyXaNOoxmvTctXjT/?=
 =?us-ascii?Q?hpX4qeBR/mUJZd7YZwV6lctB7rwfgr6PFHCHhT4CwPllPzUVTNV4V7zeyU9A?=
 =?us-ascii?Q?AJnfZ7+srySIi8SYaPTzwkhULd0w0LX31/D5EilTV835YeAQsP7TteFCdbVD?=
 =?us-ascii?Q?3UgRxntjnp2jmSfJDNQyQXyqVpAl4qRzKSuBeQJzDH3VKOp7l39i5GG1eifc?=
 =?us-ascii?Q?RVeXaBu/RfcZFwLTZT0MtuvIZRpapyXkpMXDUAcOpoLnMvKN1oljvqGCox8o?=
 =?us-ascii?Q?UsFDG9bPCasxkD6s6ugFVMfjjiVE8o+WLkBx3HssksETG+ymw5lHmXgU7Gq9?=
 =?us-ascii?Q?PUH2rw8DjZexBp89LeMj4HUA7sXOMFHSxM0+NpNK8V9S/bOqx5oGuRmAqwIW?=
 =?us-ascii?Q?Hp9lwVHnmTo8+0Uv/PD0X6rJIzDpjux5j+S61xxST5b0+Ky11B0DYUGHtncq?=
 =?us-ascii?Q?5FCtumVFEUR56/M+sAp20XR6lkLgeTgTqcf12LbscP7IrFFYaSvWwjTG5o79?=
 =?us-ascii?Q?Y7fjRAHWWGZPH2ORA/nElAx3UlBXfZ7D7DRtHBZiIQMfUbKjqf+aeh+g+lBX?=
 =?us-ascii?Q?zC8It6R9TfmvODtD3ugFTJyL9b7f91fXb88zEXuZRRVV9OV5mRZdIpiTuZBU?=
 =?us-ascii?Q?xnlcZz8Fz8+iEfJg034oWbQeNoFPLGrRZY/QYHw6vvExo+TSN/RW0DHUig47?=
 =?us-ascii?Q?Y4ANsI4mzMpRJP7mbzddNOk4NQUZ9dNl9tFnZs61T9CkrelwEwM9Aqqs1T2v?=
 =?us-ascii?Q?oFCDBBDocdatWL63vD5TKZWMfYsmZRCh1QcK826dmZ7Otcf0/+xi4W1Smvu0?=
 =?us-ascii?Q?s7D4roRVqq2hSP5Mi20EZJoh3npm1NoIgsmesktAaXv5GrxssXyDXkqLJVjP?=
 =?us-ascii?Q?i3OnPGkbzC6XJvrNCYiS3ND1qYY1J7z7sgQ+wgE9N3vFPCesOoo6HtwbugiR?=
 =?us-ascii?Q?py0jLOzLJxBg/fXK77CCx2I6FVyAsnYkO+teWyv+LqzNoTi4wuVrbrFxZWNv?=
 =?us-ascii?Q?R+PH9gGgoa1a5z6SEUJGRkaKbiStIT7berCUQyv2INo7Wf4kjHKKOaYiRa6y?=
 =?us-ascii?Q?FflCYPNqnbCflGsnoe0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be282798-0691-4921-47c5-08db81ad6b40
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 01:23:23.4676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 57DXyOlnqaxjqkjLe4Qa9Wbs4bZsqoEzEVBF5JlUK5eU1f91NbCMmk8iO46Ryo0I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8160
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

--=_MailMate_91AF7087-EA12-41EA-9642-3658CA83BF1F_=
Content-Type: text/plain

On 8 Jun 2023, at 21:10, Hugh Dickins wrote:

> Make pte_offset_map() a wrapper for __pte_offset_map() (optionally
> outputs pmdval), pte_offset_map_lock() a sparse __cond_lock wrapper for
> __pte_offset_map_lock(): those __funcs added in mm/pgtable-generic.c.
>
> __pte_offset_map() do pmdval validation (including pmd_clear_bad()
> when pmd_bad()), returning NULL if pmdval is not for a page table.
> __pte_offset_map_lock() verify pmdval unchanged after getting the
> lock, trying again if it changed.
>
> No #ifdef CONFIG_TRANSPARENT_HUGEPAGE around them: that could be done
> to cover the imminent case, but we expect to generalize it later, and
> it makes a mess of where to do the pmd_bad() clearing.
>
> Add pte_offset_map_nolock(): outputs ptl like pte_offset_map_lock(),
> without actually taking the lock.  This will be preferred to open uses of
> pte_lockptr(), because (when split ptlock is in page table's struct page)
> it points to the right lock for the returned pte pointer, even if *pmd
> gets changed racily afterwards.
>
> Update corresponding Documentation.
>
> Do not add the anticipated rcu_read_lock() and rcu_read_unlock()s yet:
> they have to wait until all architectures are balancing pte_offset_map()s
> with pte_unmap()s (as in the arch series posted earlier).  But comment
> where they will go, so that it's easy to add them for experiments.  And
> only when those are in place can transient racy failure cases be enabled.
> Add more safety for the PAE mismatched pmd_low pmd_high case at that time.
>
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>  Documentation/mm/split_page_table_lock.rst | 17 ++++---
>  include/linux/mm.h                         | 27 +++++++----
>  include/linux/pgtable.h                    | 22 ++++++---
>  mm/pgtable-generic.c                       | 56 ++++++++++++++++++++++
>  4 files changed, 101 insertions(+), 21 deletions(-)
LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

--=_MailMate_91AF7087-EA12-41EA-9642-3658CA83BF1F_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmSsrwcPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUrTAQAJAckU7pL89xo4po6h0v4L8b4Ful+TW5w66w
gISthISdVbJJQNrYJjhr3XVLQ617A4a/G5WG5R2u60EZIt3Jtvp0Stdy+YDrENMZ
jlB4Nuluzx+PGmN0BYvzic4A+IEMNXTATx5ZFN9uywDDO0r/5EhTSNBT6F4XupvS
YmNGx7qT/jOGK8wQZbqlHbEs9Um2umqMfFUyYIpxsS07q8aAAM4qHeQ3Bs/bw9n9
Lvu5ayNhUW1Pf4I48cTH8sKsgDAq7B1HiZd9GZeaVsB6tIRSCuhobz+4CZ6NaVWh
4ZaSrf3TpKpkvImtr+Pu8yGqQsd2yueN2yUaiFsdP4SnZ0sS6od+GPCDcZAm/EtE
QHjmMwgBM6mZs6TtfnUQJ7Qj55RMrOBFlXF4F8ukLKwp6M0MTwhGASOTFNwWlc6C
iRicsxcDxM4fsLjVjZvN72ficZkFPNtZOEd30UYnnHT3z5Cq+X97ZVhKhQKwF0Ez
jSXLHCqQlEWwt0UrD1Lg5a8FiHSC7duxIsHZmNqxA6D/wasZpsBo3BFm3wGpDCAu
IHLCC0F5dP728ij+J+kXFFFjl0N1ars6M7toPeknmbu8Q34hRtGW1t/VBb1uHUj9
Ne/goGTbUZKig6jc2ZO/zCoLG4sQ6zDjUKYSVDduiR+WIkhaQN732BPMQKlxwGmf
dEbDsj3w
=kBby
-----END PGP SIGNATURE-----

--=_MailMate_91AF7087-EA12-41EA-9642-3658CA83BF1F_=--
