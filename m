Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC83C74E3C8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 03:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjGKB46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 21:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjGKB45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 21:56:57 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5D598
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 18:56:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dsn/nD1dbNfqjCRZ4t2EFrvKh+S3AfgIy3RvtTvGyOTW8Eode3aLWNILEH71f09j3YVrCfbsYu2EOO8CNjNW96shfLr0rWzJfWEhC3GXzXHN89c15P9QcVINmQgm0T8GKJIi8IWS0QvOjRfblWF7xpR2pUIxA5U2ez/BOlqwfn7h2MNj9BIgpLfJyUp3gRYU/EutOnl0iVOpQiGEdRb6uYlf210txeSWunQhb5/OubC2E3WqRnSk1Gli9/oNpmcK4yFuPJPmp6DWiXSNpqp3Lf8JNJQaOsO+GX1BRpBvO1JFLsiwcNQm6I1T8f8xt6SGwmT7rjKoyyhn9HfAcm09iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z6cxWLCGAcp+IUvRsJm1uzUc3zLcU5m2k2KDFcNUQ0s=;
 b=Jdxc0DawrjJoF+65XiA2JA5i79EjIloCRLbrDdjxEeqR7okOnrpJqI8Ma30Vg8bDKRckziD+TWG2A8Lv1J2RPB6sMMsfucPRDHv6JkG5tMz9/PX+B/6lJLZsD6mmCxdJZhqbX8VDITBxNcEvqypJ6T+qkCuIQqUhWna2ULmPd20bwoUFy5Phtrq3Oqk3XHPY+JBWthcYaNHsVvTcIIrr3lgKD8uHVj4mE2JZsHjJdMyOZpmBX81xWRsuGcn+UmHGGu1Rb7GhRg5kMG/C9FG5wblbjWkamQd0H8sYFY0/UzisfJoQYKddcn58mS3NY16GxpXeVhJifHoOQ4TUBQsdDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6cxWLCGAcp+IUvRsJm1uzUc3zLcU5m2k2KDFcNUQ0s=;
 b=WXskHni+tSuhI4rI19AjKWt4Ibvj9dDUuJRPMiLPtKxhJuyzfbCe6GqnaatukHXeAMReKcee1pnEi89jVO5UUl21ZQK9ioho2UiPtDQ2t3ptCdKCKhUh3b/Zazs65wxPVC86RRNfiWM/f3K1UerSB2ax0zRgXqxzK/SOzKHghVhN7Abn3bU6gm43vAs+diiiOiARO5OX6+AzTEX1UhsNxloHHW5VtkGdPMRLC7/k1+VF4nl+YFapCaPFcoVLG6efbut6UFrmHE5y5UvC/IbmamcI9JMSPo0bl8EWdefEWVz74vaXVsPZcpRB4sYhjuA1Sj5FsM2Vy5TfUmPSX7Q0VA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SN7PR12MB7788.namprd12.prod.outlook.com (2603:10b6:806:345::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.30; Tue, 11 Jul 2023 01:56:53 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::12b7:fbc0:80e1:4b8b]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::12b7:fbc0:80e1:4b8b%3]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 01:56:53 +0000
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
Subject: Re: [PATCH v2 07/32] mm/page_vma_mapped: reformat map_pte() with less
 indentation
Date:   Mon, 10 Jul 2023 21:56:49 -0400
X-Mailer: MailMate (1.14r5964)
Message-ID: <04F5CA21-1E02-4D15-AB8B-BB89D6409484@nvidia.com>
In-Reply-To: <bf723f59-e3fc-6839-1cc3-c0631ee248bc@google.com>
References: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
 <bf723f59-e3fc-6839-1cc3-c0631ee248bc@google.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_4D666C7D-C05C-4184-BADA-BBC0698D6306_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL0PR02CA0033.namprd02.prod.outlook.com
 (2603:10b6:207:3c::46) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SN7PR12MB7788:EE_
X-MS-Office365-Filtering-Correlation-Id: ea3ae204-10d0-42f9-40ad-08db81b218ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DdyKyhc9/2LBdOdUqKAqMPWrgmKUDSje+1CikLO++CABEsx97PB77G9H6RGIDnq1PsezjJzGxP+68RCFxTWPcLQU1d7yVFBuIz5MGS5n71THBULvyXwQMUUPAdXU5jBJZvXxvmsidB/MQ+g7CaNI1h1C+BeELbO6SZWVkqEeChjYf/2Yrz/itK0YM7bfXL85+Gk3UeyChC2cQHPjnwdkDcKG23VD55CLXazWCgoIMXhhcriJFnudFxnv5Cbfa95s3Cg5zmk91rEYqCGT32ebL/JsNXWKrU0gDNTt2NiQ98kAqWGSLSvdIblvlwDVgVOUggFwyyNCiB5rB7A3yt5DXNrLy4url6sdSFXCaICYDdnj/JDPwncF60N3+vAB5cG/5p98JnplxqotocCUKuNJnF6/30EXvEJXJOxzx7N39zLoDtLSxr5J+05mmwPm7WOvN+UTzWySujxDphFOcherpcntrQ3+bYyf+CEMpBo39m0d6qIzTD59scGwkQRO9GI8Xv8PuzqhpI7oOfFl56trLsh7RMoOU3iWVV1juHsV92fQ4MUlYZ/e4GGicCAbgVxHVes4gyfgnoqgoo0WpFsX9/wVoHzKkk6Vc5/oC3ytkKvrMM8iBYMWgp7ODdnt+96cp8hv4Z2Cv7rN0PFM2/HRbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(451199021)(6666004)(6486002)(478600001)(54906003)(83380400001)(33656002)(36756003)(86362001)(2616005)(2906002)(66946007)(186003)(6506007)(26005)(53546011)(6512007)(38100700002)(8676002)(6916009)(5660300002)(4326008)(316002)(66476007)(41300700001)(8936002)(66556008)(235185007)(7416002)(7406005)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L2keRPB/q8dDgC67HiQoCFPSxgQE6ExXmFfMBh/tgrwJ1k7nOYW7+yKkSXZl?=
 =?us-ascii?Q?m8IDEheU2fR1Ic2HgeFdShtnzNsZ6PMPGBAfbaVj9S4hXYW2hphT37oOha2y?=
 =?us-ascii?Q?io9VjMeRbMLT8Vsc6GA+SAU8gMKR7+BbMmoeMZPf+WbMDbXh4IaIKhK/yyZO?=
 =?us-ascii?Q?2v1mJ92tvyMnZPh78EnuJ/ALMzb05B1N8T3R/3KDjc8Yoc9KV895OzVPGhAO?=
 =?us-ascii?Q?KbF915SKqf7AeSYqTLlZHpW9FDgyRrs1788guWr7kQYAKm9wRvvcXADlD0qj?=
 =?us-ascii?Q?ZVTyNNbJSwYVLZSbE9LOZGnHo5QOrXJcD5hzzP4oHPmDrOS+JXu2fNBweCMS?=
 =?us-ascii?Q?ZDqdaliAx582eEPRrJMIAl1AM9h5EQRtDhFldj8JgsvvCxULs2y2RRzuiCKQ?=
 =?us-ascii?Q?a6XRz+EZjdQGF7iUSOh5HLlt9O8kRhyPvzD5/Zx6JG7IdGzBaNm9/74WHA60?=
 =?us-ascii?Q?mHt9TZ7qzPqVS6xGpuaxHSEWotkH8JeYRQJXum0xivEM5miQY+Z+YzR5GauI?=
 =?us-ascii?Q?lfA5uckII25fLaAbekOnLMC3mUJmMbYwUVJyii8g0NYrNgBqqqrnE2ehb6YJ?=
 =?us-ascii?Q?uAQ6TVPfWA3ivqIjiU6fZvbgQ0HcWhedNxDFW8cLmGlZhpkNZWsvUBUZ96zL?=
 =?us-ascii?Q?JLWVQa5jBjom8i8YrztKxQ2KM4QeZTkWgVkIUDBF9rJK0/2rhYtXenyDtr2A?=
 =?us-ascii?Q?qdPQTXCBRguQSaWlNw0qUfgRqmeH/7HNvPDyPpgmqcLGDipMRxyUWBWPzm0t?=
 =?us-ascii?Q?jH6/nt9qFudIbgm7WqCYrOVc76dtrED8I9Gjxv6GCkpV8QLCf5RlcqElCcQY?=
 =?us-ascii?Q?C6kGC3L9ZGf1eQiwOvD7/gyZ4tGEljtz+pwyHMjbpwPV2Fay1/sFLLTMHbIw?=
 =?us-ascii?Q?YGiKDK9BIu/lLh6TcZZa6zB4PXEvX+cGJJq/iF4ztW5B8Hhd532rfTmjEa/I?=
 =?us-ascii?Q?ybtwPn5f1Rf992zi7sLObxPdViR9c/ttOa3HmCHN/PxRH80DDEytg4TXUy9S?=
 =?us-ascii?Q?hbD6SppMtG9Bu4s1ZEbGQqkr2iV4DqIM7lMX5/1gsdpTGZZMQJyuebNnP3Eh?=
 =?us-ascii?Q?2T+SuvuKvaj5SipIPNoBKX5Zr2WIeO/u5EceKlxqhtfJx6EBLcAN2SHqwvg1?=
 =?us-ascii?Q?FZPDjHZtE+/pRl0eMt8DAsRWQITfwO1sOzNDIoWOHGlTdwOzD/oM01UpJOVf?=
 =?us-ascii?Q?+y4DM8v2BO+DPSSmux3X3OBIpSsBUBNnvgSkJYlZd9LvyoVitIZf9gSZzcFA?=
 =?us-ascii?Q?o83SXlZ6e/6NNqh9jsN2qC7WJOvRL8BQ77DDzbgRHChf8yUslXpoYdwFtRHD?=
 =?us-ascii?Q?9MlE9iVLlI9ZgqqfOKG6CsKJnsCPGTN515oqn/AQofl/vko7LsHHLrRbBTDv?=
 =?us-ascii?Q?M2ANsyw+1zJS+eEjHtS/1/MiVvXsw8ZY+DHOEwzN7HmvNSetru2GH+axByQ5?=
 =?us-ascii?Q?kA1zJkE1hbgi4l+4jsCY8gfmydF62bmfEDMGZ2U+7IqwZt8XAkceRq189nJP?=
 =?us-ascii?Q?ijwDwRXh08iqFH91dJXSFvx7sBwGXe6g6memmatp+Y8ZAxSKBFWflBUQmNMa?=
 =?us-ascii?Q?ps1tIv5sf4EJBomul3g=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea3ae204-10d0-42f9-40ad-08db81b218ab
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 01:56:52.3204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PXvv8y653Bs98hekG6IIzNxHxNsOGvnVSO7F7aZ2/J1I8cHVHPedlP3LQZ6fAuSU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7788
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

--=_MailMate_4D666C7D-C05C-4184-BADA-BBC0698D6306_=
Content-Type: text/plain

On 8 Jun 2023, at 21:14, Hugh Dickins wrote:

> No functional change here, but adjust the format of map_pte() so that the
> following commit will be easier to read: separate out the PVMW_SYNC case
> first, and remove two levels of indentation from the ZONE_DEVICE case.
>
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>  mm/page_vma_mapped.c | 65 +++++++++++++++++++++++---------------------
>  1 file changed, 34 insertions(+), 31 deletions(-)
>
LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

--=_MailMate_4D666C7D-C05C-4184-BADA-BBC0698D6306_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmSstuEPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUH20QAId3NCPLc50csb3AzRbmJeuKEKDOj+A9DrUO
Cmx4iiWDuT6fI+x70XosgLywf6PgQMjjtFeq3fhYTRk0HG8F/FUvydO3duB/Tvvz
iHeQUaBQbv4teCMknlQy8Y79I1yRqbp8w83E5GZUeBNvuP+OH4ILnWoZvIHLciQ5
i0eMwEBTh6/usSfhZiNNSrpqomfBbfiy+s7lanStYtCqMPveFI9wuwA36NoWuSVa
MqeIUhc2mzf0xNVSauEX8roR55kVp9FoBCwBWOAPa4irfFCBYBoVcGeINMqVp0lu
1yfXK3D3Q1dq3vn7bdT8QdqW6hK0zis/pgFh6TG7sDZzRFgKZ8SK42c+C96FRW/Y
wRlPz+xCzux+W7QwPxpEGgx4E8/O5l78prSh5KikViM2XDBTZ0Bj/XPx+z6GxpPi
CtuYGtwDBUFH/16hGYEX9vazMjTWA7ipzVctN+KayETep9yUYZnCTZxTjndgBcaM
NwhGB7Q9ULI0bG9S4SbQ6sWDSMeoLYGUz2L08Ybs2JiR9HSwvqYQyrWfqWv2q4bQ
P6YcNrDXpBsdPdoBRcsxONuyEpigRHnqfK1IMbKiXs4F0qKw8QmpKldl92lKzk2H
/gD5xH0sKw6LTQE2raTdk3SrGB/fhLLv+Ku0mOeOJVM2VpCAbkSGtnEghKEvLqqa
K3G149qe
=5o6x
-----END PGP SIGNATURE-----

--=_MailMate_4D666C7D-C05C-4184-BADA-BBC0698D6306_=--
