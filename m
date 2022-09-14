Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE395B7E1C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 03:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiINBJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 21:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiINBJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 21:09:46 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4515514D2F;
        Tue, 13 Sep 2022 18:09:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ss1uq1yTxI2wzqwL5/CZQb2IrNoQfSTW3kaAhPuYf/zzzLb2qLcE2snwR1Vxd1oiH36ZCrJUM+T1s/OZ2LLRNyjudhrJhGD6BXWJLFWLt14M57aD/imY7gL1rSs+nlU4NVRYkfK6l8Fyqw3Ckjuovj3VdcoJxYtjSmJcTUJXnhyg4FAvUsMt3ChQUOPIuOUOInJKdjX/bXCb+l53PiUXz16pKUQN7MsMRnxvd0Vb2GNrPqO9rnDze3lIalzctVQML1feZteq2TrMnpzX3DkSVEGY2azTzM3RAXcOm2EkFv6bAXYlK+BtaY48hYdKFzUnoBrSLvHHlvgQkgrk2s+hGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2v/TCRcZ/UTFjnI4Zbvw/IAbK4sfnHYDS7H9Kum4LEk=;
 b=ESrRUJoegk9suGYsWdz9Qee9yk9M039vRT+4R9/RbDrsRpoCUTIi8ZIqE82qXb+a6VS/LYkcnUgCbSKZ3RUg8e8P3C0IVFHFk0o9wdBnrhIIenC72oFhQFAxtDiX9GtK3SOXAzal/23E/VNGJHpfN8Mn/JGtsoagBHtz3wXmwVF1R1TMzefQQh+sy0ZuxNpC5CdG7fGkgZB3OAl1ITykUzt+bAiY3Z0nhUUCCtiWuBvoH5TwX9hNnxKC2hxHjowVYn/CCG0uz2U4Kddv0lboZCLkyytK7fcTJhYcWB0y27f/ZtODCpaXlsQQaPyimIS/W/vqucceKjmqHMNukNgw9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2v/TCRcZ/UTFjnI4Zbvw/IAbK4sfnHYDS7H9Kum4LEk=;
 b=AldNPiGotb9KR0Fj/6sXxGG8JjkolBYvub3KBHYFtCyDusseiwPmAC4zdSiEh27xZlOJsJQaoDmgd4YttXS/WajMq6N7SzGBdTlccDAU443A9Qk8neTs6PO0PGHuvxLBBTz6zrbwXT1fTpfR5L7pAW9xCEe3+GGto02YX34EdcEkHk3HxgQU2770tYLeR70eR0OjFY4LqulH8mWusjR+h1HHrr8AbyR8uAbghw4okObfapb4Vrn6iMon126z2iyUBdzdcOxfWtHLZ+xGrGHEE2B9H34VIspYBxWd34dmsCGteUaAHizF1I4hChjIqDYuLjYXmAUWUx9F6v0WPhVxYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 BY5PR12MB4034.namprd12.prod.outlook.com (2603:10b6:a03:205::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.18; Wed, 14 Sep 2022 01:09:39 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::94df:bc2b:6294:8cc6]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::94df:bc2b:6294:8cc6%6]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 01:09:39 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Doug Berger <opendmb@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Rapoport <rppt@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        - <devicetree-spec@vger.kernel.org>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux.dev
Subject: Re: [PATCH 01/21] mm/page_isolation: protect cma from
 isolate_single_pageblock
Date:   Tue, 13 Sep 2022 21:09:36 -0400
X-Mailer: MailMate (1.14r5911)
Message-ID: <71D040CB-0E26-4CD3-9121-54D740F24594@nvidia.com>
In-Reply-To: <ff84d89b-6d4f-c739-63be-4c4825b1fd03@gmail.com>
References: <20220913195508.3511038-1-opendmb@gmail.com>
 <20220913195508.3511038-2-opendmb@gmail.com>
 <36E322BF-F052-4A8B-9FA5-4E0AA84E4AAF@nvidia.com>
 <ff84d89b-6d4f-c739-63be-4c4825b1fd03@gmail.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_616185E2-29EC-4B0E-8755-A12BD9249736_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0331.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::6) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|BY5PR12MB4034:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ec16b30-5a3d-4aca-8f49-08da95edcc29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4h4lWOSn2nbintC84jjHb0E+B6dRHbZDpSs1le45MxyMbuBQ8cDSr5Ni24J6V84V4gZ6UFfjWuekUZ7iwtCzrVg2+qlbxATTDLHCDlnUzgQmH5GcoxjRVMTsoNf2FTVZ8bskKJe2+SD41Bu5J+RMutcgRzvRZgs6nf56cmzN3z1kj+BimDjh/ZRbhshwMzlTA8tA6F0h9D7+l5Vdcax1L/l21K/zm2lzcAa6zCJeCD38hRtQr+wLI6dDxdZDAcsYwBFUvvIe3we9iHkEZ+/cT389nN+wPuhcJc3EUskzOQlT1W/BbPz18TQlAMKsyZ7IOzFcNb7NkCADIpcOe1TxSlBk/lKLIvfnD+SXlIFe6TFXUqCMce+d8qKAnSIzxUsyH0VoUiv7/AFmlkTQCuvlNYnG2lEhwCbU7r5qdrQHYrIN4kzU+6L4HZK4QJRLULvffo19qhAacc45uu28Ssd0HxxtJPovos1jyaFwWe9tqlg2uP3c4HhSnWxEditAtujVY/09dt2y4r/iMmrO0Ky08z9IgqExKvHNELLaT7iNgjqbDA9bEW6lW6jiC/cg/D4yYjmWv2KQOFrUX5zAK5YghlePXnifpmZkkuAWu4p6YxcKKpVLtlBfAYGz37BcIzj9G2pQGhucU5yjtnucKr14lLFqECxNOkaRbrNcu3H/WtVKdqkuhBN7qdDRsq1oK2T+2ZkRiNXWR4FeF55yCHCca0C08R0jCTaw7JD5FtCEL1sYx0gKcHcwiDkMkmQgvMgLv/7MIs7Ioza1SEPU//3p1FVQ8zvvytQ1iwX2d6ywojU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199015)(66476007)(8676002)(2906002)(86362001)(41300700001)(53546011)(316002)(186003)(7416002)(30864003)(6486002)(2616005)(6506007)(6512007)(26005)(7406005)(5660300002)(66946007)(54906003)(8936002)(83380400001)(478600001)(36756003)(33656002)(4326008)(66556008)(6666004)(235185007)(38100700002)(6916009)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U0JebXqRrk1zqRxsG8QTFFKxP9kw2MRWhkisbzpNqOBFxE+cbUK4XnZ+iukd?=
 =?us-ascii?Q?daoaBBzH3t2+iMrwbM6FonDGNhtmpBp2UE9SXLnpv+YRjm4rajyRfRG1SVcX?=
 =?us-ascii?Q?E922qnXUbb65UXMTGVVPm765oxZ1MHpe6ArF9/T6o9JVoW8VL3ZdK2mNB8+w?=
 =?us-ascii?Q?yQIKMPvjK+sTHbN/vS10cmnxiT8KZ/DwMaytE6OGEg6BniT17uarMYdogzPn?=
 =?us-ascii?Q?vyZFHNuWJ0ndqIhtIrq+XMV09MuzeeWuIQ04Xzk2RAMYvIl0BLFYgVlXgxtf?=
 =?us-ascii?Q?uJ/v0OtJnJaDgwpXbLxaEboKiUp5bdKpP9LkB675rIjnI6ogzKx6JSkCWL/q?=
 =?us-ascii?Q?mnvqVyQ1yAKe9hV2oSy0uID7Fg6WHQJvd/TIl1xcgP6UIOrDPQZ9yCaxN4rF?=
 =?us-ascii?Q?WJwMh8silJJxoHeERV/sDDOnrcH2BctxgfF5Oc7blml81rT7eHGPjGexDpoe?=
 =?us-ascii?Q?6zoWsoSDqysunpJ2zn3WUumDN1Hn4bl6TCF+JHbqJbaYeg3zaVri/TYtOqxX?=
 =?us-ascii?Q?I/ni3Nh9K/BnYQTR9I7ZmkN0P5qpchkBmyx0C3e5VYOfPki2JdnbyuQUQuv0?=
 =?us-ascii?Q?W0cgYXm/Cci67ayn2XEl/rciHIZQ/GB+zTtyKzjEOigqA4enCDNMRngZrKp8?=
 =?us-ascii?Q?4MmpkfEaVHXLveah4KV/G6Z4VMS6jFOed9LgR2eGvHrB6llK5SbIUg9RUFdE?=
 =?us-ascii?Q?SdAeZgeDgZREmEv1bLTA3u6P2DosLNpSKhUHBXN4X1qGDDKTH0bCPxBbAgj0?=
 =?us-ascii?Q?Qg5mOZYq2DAgxTuo8HzdBkc7qx9XHnfLezMfgTvylLYimzP91vKhKjMajWmV?=
 =?us-ascii?Q?crcPO7u0gNt/Cc3Hhxf2O13FubTrJUuBG2PgKiBOrfLhJwVfDjLvi8CGmXIo?=
 =?us-ascii?Q?dydVzu3N8Msf71N+zpPl/MdKpDxfjyfWETPBuWwb2qdOEUGKPF57O1XErQzM?=
 =?us-ascii?Q?LgGbn+0JqmLp1NdBcPXX3DPewSdWCGmJ2qUY+GigxmLGYYjIR/SSoyHqOIJN?=
 =?us-ascii?Q?uE7uFPXxuu6aEdA9rmypH5RnNDZNSspGUjRV/LR5TIiOmQlyfPSkTL1nlsIE?=
 =?us-ascii?Q?fzeU/O5SiE/ibocYu7jVd106/tMdltFoSseEfcv3yhS6KEO89tww+hRIezjA?=
 =?us-ascii?Q?32yYiXHRVLAni/lenG0Zcf6N9xF5f+eBFzJdqWKFdISvqhSIx95LOAptBqRp?=
 =?us-ascii?Q?0K654rTQMG1kHU+znd2lwYIJqC7FQM/uQ+FNBVS5i4jdPnFe4Fg/gNFCF9J8?=
 =?us-ascii?Q?bV/4Lpzvp3eyGOQ3gxTZVNJjscPHVk70cWT8Aqd+EYAYLFolkjimm0/Ml+M8?=
 =?us-ascii?Q?7iXJYzBl731HbqILSXn5Xv1EfIR4196Bz4qubERuIELTpxgRd+OnxWZLIhFP?=
 =?us-ascii?Q?L35+KLsUvycaKD/PU2rtpuxmXHmtmlTDV7S6dqAaUK3hqucC9gnEy5CIwu0Z?=
 =?us-ascii?Q?xYR3kfPQQbaqow92yZs97xPe2CLdhlBo5DBf2nLTr7FQnuWduM1Mi1SnKHCR?=
 =?us-ascii?Q?1MDTAuXbqRnYWB8IyrlMyPvVq27uTWyFaekvI3tTx0jGRn7KrE2xkM1Dik7h?=
 =?us-ascii?Q?+f0pv3wFYBh1fYpcIMWEdtow97vA8xfXAlCUQfGZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec16b30-5a3d-4aca-8f49-08da95edcc29
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 01:09:39.4079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PxwcqyhOX3bWKeXwERNKljk3E1PYhMppZOa/gB43wnpWLYjS3gbmRyBuBiSFjPmI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4034
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_616185E2-29EC-4B0E-8755-A12BD9249736_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 13 Sep 2022, at 20:59, Doug Berger wrote:

> On 9/13/2022 5:02 PM, Zi Yan wrote:
>> On 13 Sep 2022, at 15:54, Doug Berger wrote:
>>
>>> The function set_migratetype_isolate() has special handling for
>>> pageblocks of MIGRATE_CMA type that protects them from being
>>> isolated for MIGRATE_MOVABLE requests.
>>>
>>> Since isolate_single_pageblock() doesn't receive the migratetype
>>> argument of start_isolate_page_range() it used the migratetype
>>> of the pageblock instead of the requested migratetype which
>>> defeats this MIGRATE_CMA check.
>>>
>>> This allows an attempt to create a gigantic page within a CMA
>>> region to change the migratetype of the first and last pageblocks
>>> from MIGRATE_CMA to MIGRATE_MOVABLE when they are restored after
>>> failure, which corrupts the CMA region.
>>>
>>> The calls to (un)set_migratetype_isolate() for the first and last
>>> pageblocks of the start_isolate_page_range() are moved back into
>>> that function to allow access to its migratetype argument and make
>>> it easier to see how all of the pageblocks in the range are
>>> isolated.
>>>
>>> Fixes: b2c9e2fbba32 ("mm: make alloc_contig_range work at pageblock g=
ranularity")
>>> Signed-off-by: Doug Berger <opendmb@gmail.com>
>>> ---
>>>   mm/page_isolation.c | 75 +++++++++++++++++++++---------------------=
---
>>>   1 file changed, 35 insertions(+), 40 deletions(-)
>>
>> Thanks for the fix.
> Thanks for the review.
>
>>
>> Why not just pass migratetype into isolate_single_pageblock() and use
>> it when set_migratetype_isolate() is used? That would have much
>> fewer changes. What is the reason of pulling skip isolation logic out?=

> I found the skip_isolation logic confusing and thought that setting and=
 restoring the migratetype within the same function and consolidating the=
 error recovery paths also within that function was easier to understand =
and less prone to accidental breakage.
>
> In particular, setting MIGRATE_ISOLATE in isolate_single_pageblock() an=
d having to remember to unset it in start_isolate_page_range() differentl=
y on different error paths was troublesome for me.

Wouldn't this work as well?

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index c1307d1bea81..a312cabd0d95 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -288,6 +288,7 @@ __first_valid_page(unsigned long pfn, unsigned long n=
r_pages)
  * @isolate_before:    isolate the pageblock before the boundary_pfn
  * @skip_isolation:    the flag to skip the pageblock isolation in secon=
d
  *                     isolate_single_pageblock()
+ * @migratetype:       Migrate type to set in error recovery.
  *
  * Free and in-use pages can be as big as MAX_ORDER and contain more tha=
n one
  * pageblock. When not all pageblocks within a page are isolated at the =
same
@@ -302,9 +303,9 @@ __first_valid_page(unsigned long pfn, unsigned long n=
r_pages)
  * the in-use page then splitting the free page.
  */
 static int isolate_single_pageblock(unsigned long boundary_pfn, int flag=
s,
-                       gfp_t gfp_flags, bool isolate_before, bool skip_i=
solation)
+                       gfp_t gfp_flags, bool isolate_before, bool skip_i=
solation,
+                       int migratetype)
 {
-       unsigned char saved_mt;
        unsigned long start_pfn;
        unsigned long isolate_pageblock;
        unsigned long pfn;
@@ -328,12 +329,10 @@ static int isolate_single_pageblock(unsigned long b=
oundary_pfn, int flags,
        start_pfn  =3D max(ALIGN_DOWN(isolate_pageblock, MAX_ORDER_NR_PAG=
ES),
                                      zone->zone_start_pfn);

-       saved_mt =3D get_pageblock_migratetype(pfn_to_page(isolate_pagebl=
ock));
-
        if (skip_isolation)
-               VM_BUG_ON(!is_migrate_isolate(saved_mt));
+               VM_BUG_ON(!is_migrate_isolate(get_pageblock_migratetype(p=
fn_to_page(isolate_pageblock))));
        else {
-               ret =3D set_migratetype_isolate(pfn_to_page(isolate_pageb=
lock), saved_mt, flags,
+               ret =3D set_migratetype_isolate(pfn_to_page(isolate_pageb=
lock), migratetype, flags,
                                isolate_pageblock, isolate_pageblock + pa=
geblock_nr_pages);

                if (ret)
@@ -475,7 +474,7 @@ static int isolate_single_pageblock(unsigned long bou=
ndary_pfn, int flags,
 failed:
        /* restore the original migratetype */
        if (!skip_isolation)
-               unset_migratetype_isolate(pfn_to_page(isolate_pageblock),=
 saved_mt);
+               unset_migratetype_isolate(pfn_to_page(isolate_pageblock),=
 migratetype);
        return -EBUSY;
 }

@@ -537,7 +536,8 @@ int start_isolate_page_range(unsigned long start_pfn,=
 unsigned long end_pfn,
        bool skip_isolation =3D false;

        /* isolate [isolate_start, isolate_start + pageblock_nr_pages) pa=
geblock */
-       ret =3D isolate_single_pageblock(isolate_start, flags, gfp_flags,=
 false, skip_isolation);
+       ret =3D isolate_single_pageblock(isolate_start, flags, gfp_flags,=
 false,
+                               skip_isolation, migratetype);
        if (ret)
                return ret;

@@ -545,7 +545,8 @@ int start_isolate_page_range(unsigned long start_pfn,=
 unsigned long end_pfn,
                skip_isolation =3D true;

        /* isolate [isolate_end - pageblock_nr_pages, isolate_end) pagebl=
ock */
-       ret =3D isolate_single_pageblock(isolate_end, flags, gfp_flags, t=
rue, skip_isolation);
+       ret =3D isolate_single_pageblock(isolate_end, flags, gfp_flags, t=
rue,
+                               skip_isolation, migratetype);
        if (ret) {
                unset_migratetype_isolate(pfn_to_page(isolate_start), mig=
ratetype);
                return ret;

>
> It could certainly be done differently, but this was my preference.

A smaller patch can make review easier, right?

>>
>> Ultimately, I would like to make MIGRATE_ISOLATE a separate bit,
>> so that migratetype will not be overwritten during page isolation.
>> Then, set_migratetype_isolate() and start_isolate_page_range()
>> will not have migratetype to set in error recovery any more.
>> That is on my TODO.
>>
>>>
>>> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
>>> index 9d73dc38e3d7..8e16aa22cb61 100644
>>> --- a/mm/page_isolation.c
>>> +++ b/mm/page_isolation.c
>>> @@ -286,8 +286,6 @@ __first_valid_page(unsigned long pfn, unsigned lo=
ng nr_pages)
>>>    * @flags:			isolation flags
>>>    * @gfp_flags:			GFP flags used for migrating pages
>>>    * @isolate_before:	isolate the pageblock before the boundary_pfn
>>> - * @skip_isolation:	the flag to skip the pageblock isolation in seco=
nd
>>> - *			isolate_single_pageblock()
>>>    *
>>>    * Free and in-use pages can be as big as MAX_ORDER-1 and contain m=
ore than one
>>>    * pageblock. When not all pageblocks within a page are isolated at=
 the same
>>> @@ -302,9 +300,8 @@ __first_valid_page(unsigned long pfn, unsigned lo=
ng nr_pages)
>>>    * the in-use page then splitting the free page.
>>>    */
>>>   static int isolate_single_pageblock(unsigned long boundary_pfn, int=
 flags,
>>> -			gfp_t gfp_flags, bool isolate_before, bool skip_isolation)
>>> +			gfp_t gfp_flags, bool isolate_before)
>>>   {
>>> -	unsigned char saved_mt;
>>>   	unsigned long start_pfn;
>>>   	unsigned long isolate_pageblock;
>>>   	unsigned long pfn;
>>> @@ -328,18 +325,6 @@ static int isolate_single_pageblock(unsigned lon=
g boundary_pfn, int flags,
>>>   	start_pfn  =3D max(ALIGN_DOWN(isolate_pageblock, MAX_ORDER_NR_PAGE=
S),
>>>   				      zone->zone_start_pfn);
>>>
>>> -	saved_mt =3D get_pageblock_migratetype(pfn_to_page(isolate_pagebloc=
k));
>>> -
>>> -	if (skip_isolation)
>>> -		VM_BUG_ON(!is_migrate_isolate(saved_mt));
>>> -	else {
>>> -		ret =3D set_migratetype_isolate(pfn_to_page(isolate_pageblock), sa=
ved_mt, flags,
>>> -				isolate_pageblock, isolate_pageblock + pageblock_nr_pages);
>>> -
>>> -		if (ret)
>>> -			return ret;
>>> -	}
>>> -
>>>   	/*
>>>   	 * Bail out early when the to-be-isolated pageblock does not form
>>>   	 * a free or in-use page across boundary_pfn:
>>> @@ -428,7 +413,7 @@ static int isolate_single_pageblock(unsigned long=
 boundary_pfn, int flags,
>>>   					ret =3D set_migratetype_isolate(page, page_mt,
>>>   						flags, head_pfn, head_pfn + nr_pages);
>>>   					if (ret)
>>> -						goto failed;
>>> +						return ret;
>>>   				}
>>>
>>>   				ret =3D __alloc_contig_migrate_range(&cc, head_pfn,
>>> @@ -443,7 +428,7 @@ static int isolate_single_pageblock(unsigned long=
 boundary_pfn, int flags,
>>>   					unset_migratetype_isolate(page, page_mt);
>>>
>>>   				if (ret)
>>> -					goto failed;
>>> +					return -EBUSY;
>>>   				/*
>>>   				 * reset pfn to the head of the free page, so
>>>   				 * that the free page handling code above can split
>>> @@ -459,24 +444,19 @@ static int isolate_single_pageblock(unsigned lo=
ng boundary_pfn, int flags,
>>>   				while (!PageBuddy(pfn_to_page(outer_pfn))) {
>>>   					/* stop if we cannot find the free page */
>>>   					if (++order >=3D MAX_ORDER)
>>> -						goto failed;
>>> +						return -EBUSY;
>>>   					outer_pfn &=3D ~0UL << order;
>>>   				}
>>>   				pfn =3D outer_pfn;
>>>   				continue;
>>>   			} else
>>>   #endif
>>> -				goto failed;
>>> +				return -EBUSY;
>>>   		}
>>>
>>>   		pfn++;
>>>   	}
>>>   	return 0;
>>> -failed:
>>> -	/* restore the original migratetype */
>>> -	if (!skip_isolation)
>>> -		unset_migratetype_isolate(pfn_to_page(isolate_pageblock), saved_mt=
);
>>> -	return -EBUSY;
>>>   }
>>>
>>>   /**
>>> @@ -534,21 +514,30 @@ int start_isolate_page_range(unsigned long star=
t_pfn, unsigned long end_pfn,
>>>   	unsigned long isolate_start =3D ALIGN_DOWN(start_pfn, pageblock_nr=
_pages);
>>>   	unsigned long isolate_end =3D ALIGN(end_pfn, pageblock_nr_pages);
>>>   	int ret;
>>> -	bool skip_isolation =3D false;
>>>
>>>   	/* isolate [isolate_start, isolate_start + pageblock_nr_pages) pag=
eblock */
>>> -	ret =3D isolate_single_pageblock(isolate_start, flags, gfp_flags, f=
alse, skip_isolation);
>>> +	ret =3D set_migratetype_isolate(pfn_to_page(isolate_start), migrate=
type,
>>> +			flags, isolate_start, isolate_start + pageblock_nr_pages);
>>>   	if (ret)
>>>   		return ret;
>>> -
>>> -	if (isolate_start =3D=3D isolate_end - pageblock_nr_pages)
>>> -		skip_isolation =3D true;
>>> +	ret =3D isolate_single_pageblock(isolate_start, flags, gfp_flags, f=
alse);
>>> +	if (ret)
>>> +		goto unset_start_block;
>>>
>>>   	/* isolate [isolate_end - pageblock_nr_pages, isolate_end) pageblo=
ck */
>>> -	ret =3D isolate_single_pageblock(isolate_end, flags, gfp_flags, tru=
e, skip_isolation);
>>> +	pfn =3D isolate_end - pageblock_nr_pages;
>>> +	if (isolate_start !=3D pfn) {
>>> +		ret =3D set_migratetype_isolate(pfn_to_page(pfn), migratetype,
>>> +				flags, pfn, pfn + pageblock_nr_pages);
>>> +		if (ret)
>>> +			goto unset_start_block;
>>> +	}
>>> +	ret =3D isolate_single_pageblock(isolate_end, flags, gfp_flags, tru=
e);
>>>   	if (ret) {
>>> -		unset_migratetype_isolate(pfn_to_page(isolate_start), migratetype)=
;
>>> -		return ret;
>>> +		if (isolate_start !=3D pfn)
>>> +			goto unset_end_block;
>>> +		else
>>> +			goto unset_start_block;
>>>   	}
>>>
>>>   	/* skip isolated pageblocks at the beginning and end */
>>> @@ -557,15 +546,21 @@ int start_isolate_page_range(unsigned long star=
t_pfn, unsigned long end_pfn,
>>>   	     pfn +=3D pageblock_nr_pages) {
>>>   		page =3D __first_valid_page(pfn, pageblock_nr_pages);
>>>   		if (page && set_migratetype_isolate(page, migratetype, flags,
>>> -					start_pfn, end_pfn)) {
>>> -			undo_isolate_page_range(isolate_start, pfn, migratetype);
>>> -			unset_migratetype_isolate(
>>> -				pfn_to_page(isolate_end - pageblock_nr_pages),
>>> -				migratetype);
>>> -			return -EBUSY;
>>> -		}
>>> +					start_pfn, end_pfn))
>>> +			goto unset_isolated_blocks;
>>>   	}
>>>   	return 0;
>>> +
>>> +unset_isolated_blocks:
>>> +	ret =3D -EBUSY;
>>> +	undo_isolate_page_range(isolate_start + pageblock_nr_pages, pfn,
>>> +				migratetype);
>>> +unset_end_block:
>>> +	unset_migratetype_isolate(pfn_to_page(isolate_end - pageblock_nr_pa=
ges),
>>> +				  migratetype);
>>> +unset_start_block:
>>> +	unset_migratetype_isolate(pfn_to_page(isolate_start), migratetype);=

>>> +	return ret;
>>>   }
>>>
>>>   /*
>>> -- =

>>> 2.25.1
>>
>>
>> --
>> Best Regards,
>> Yan, Zi


--
Best Regards,
Yan, Zi

--=_MailMate_616185E2-29EC-4B0E-8755-A12BD9249736_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmMhKdAPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU4G0P/0E4O0Cg41Szq2Fc+4Izzn2CFvZWxau6lI7X
ff2eB/+eopoZzo/hq4V/Nzh36jUxeCeWIyhfQPPOqkvt1tAeGUC4LGwtikyj1Ifw
+h4o5hglAVsBBSobMbZYDNme9ewg9syLZ+X+dvRQnFS2Shi8t0l+yE3MMYKfWRnN
nQ11gPeeFCz75p8U6bi7EN3ALoYHs/duxL6q9+9+Xzo/cmaufGWBQgjDTT839EXA
OD8zpEDFluyi8WtR3TS8Fk1O0fLpMLhAuVdwneI1Tb7HyGzWjLjqqhSGz+uWiOHA
Q6Vk/p880S+1nmhm2UiLZV12+JzzBeHtXRrvWQjnUlwV/fjIH2i+jot6pConPh4j
bTKcEWMT6lsagQkZev0gCAMHxs2UF8Atx5HMrqVIwbAi3tOcgilogmAbeVzVk7bB
fW0Cxmosv1oBlfcuHLVzDtMcLs4Jp6IoEmgkVxDOWGNJMFo94vfd+DG3/XJDAcm3
TfJLCwqOeeQ3yUowSxdlyZqsOv0mWq07PgdhJq7hOeObA86RQb9xX2VLfn0bAoAE
9KABUvkrZYjCCbpLtc9OPWesZyzQbw8HGwR5Qol46r7RKZarFhZyjZL3XG9Udvjv
U4OggIcIKdrGGEdLXn6IEzg3nhUIuAxeBQDbc/jn6MMfUQzYIKewdMfcd0GVDsRi
sUSyKCKM
=Ek6s
-----END PGP SIGNATURE-----

--=_MailMate_616185E2-29EC-4B0E-8755-A12BD9249736_=--
