Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA716378FE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 13:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiKXMjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 07:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiKXMjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 07:39:06 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1923429A2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 04:39:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sweyf1mLHid4fyQBEk4uJuzqpW/gyCFWiAd+HRqAXPdJyTCLN+5+8DipJN85FE8GS1h7Wl1DE8KuYdUJ4RFg5HQNCTRyx8+JqZSeHfEH9bb+Pm3lL1GBlIrGz3OepLs9G+iMvcbWCgnLt68NvQKtTZs+2ldvGj0Q1//bKhcLbzCjdBINMJgasmvy/lbfxZx6734at29oLVJ/kqMvUT8QAbfF1pSRc/xfbLR3PcMeMUgnQeU45/zv0U1MYJEwmEPC7mz4MArgYevE29JErA2SUamFjGlLh1jxN+Dnqt31OLN0GJ9nojhlT2GoUeoojfOD1i2f4qgoIaiKmWD6FoaRdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GrJ3bZLzEVd+DEpdVrkeIXcpUwpBnVbq6t8o4scaA7k=;
 b=FDFJL8hCsptrE7bJfaKH4a+GGo2T+d6igU9CJbxA5m+UAez4aGIn0DB4UOFhl9LJoW1pkLzhnTjme23lMcMA/HC7xKEUzD/3neMSafGWkskwiOL/kAGXAXPXceIGjQx0Cm2C65LrexIOP7fN1oGWKAOWwiNCAo3DbjMd+fv1eE5Xix+8dS1bQmhph9y5iHJQAgpZJITdmJa3IPSNeh5ZwbjahTxzFte5uypNIGXPMX3J2p+uav+EOiGVcQI6N5Gf82DuZP8wMsqeymBXwFaLDoIAx8unnOXXa4U01hxQ5ll5plQmdH1dA6Lf4J5RE05H1kLvFeMZKWIHs3uzs9UzHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrJ3bZLzEVd+DEpdVrkeIXcpUwpBnVbq6t8o4scaA7k=;
 b=cb/jX/ejjhaqtKgHB6kPGLF7atmCYTz88tUMNzdtz8jNdZKiAOLUmNplPS8PtJtWJnlq0POgMdqFwF+J7M0dAnstbpxec4a6qOaj4SZw06pwCTWyZfbKd4ayE0TXjgh7vSCGtSEhXSQwTNp9g1Z4ZW7tMKYL02P0Y6Jj8zPdlEN/aBGgDUKE44isthFWxnSjngnUNR74Fdzj1afqpxCtdiYBy76OMGtOm5lyN8LK5qRvYt4i3M9j8WDRt/cAlUIKCmaPx6SgE9IaQ6F2ez7ia7S4tyd2+di3qZAvr8T38yEzje49z38DRR9RYXiwd4Agz4HMMMstQOrLqXgnmPp/lQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 MN2PR12MB4206.namprd12.prod.outlook.com (2603:10b6:208:1d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Thu, 24 Nov
 2022 12:39:03 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::738e:939b:4b58:9857]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::738e:939b:4b58:9857%4]) with mapi id 15.20.5834.015; Thu, 24 Nov 2022
 12:39:02 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Gavin Shan <gshan@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        william.kucharski@oracle.com, kirill.shutemov@linux.intel.com,
        zhenyzha@redhat.com, apopple@nvidia.com, hughd@google.com,
        willy@infradead.org, shan.gavin@gmail.com,
        Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH v2] mm: migrate: Fix THP's mapcount on isolation
Date:   Thu, 24 Nov 2022 07:38:58 -0500
X-Mailer: MailMate (1.14r5918)
Message-ID: <D3D4DD02-F16F-4E9E-B1F0-65491F5B7207@nvidia.com>
In-Reply-To: <31bda0ab-a185-340d-b96b-b1cfed7c3910@redhat.com>
References: <20221124095523.31061-1-gshan@redhat.com>
 <3c584ce6-dc8c-e0e4-c78f-b59dfff1fc13@redhat.com>
 <22407f18-0406-6ede-ef1e-592f03d3699e@redhat.com>
 <31bda0ab-a185-340d-b96b-b1cfed7c3910@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_42A13E90-6CFB-424A-B4CA-C5EFF4F67114_=";
 micalg=pgp-sha1; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0239.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::34) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|MN2PR12MB4206:EE_
X-MS-Office365-Filtering-Correlation-Id: b57757d8-da4e-4536-5c19-08dace18de1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LdcPgLVSbmTiunFgUYC7pyPoMPLDI4zI8W5Guasad8CAOIlUi/oGbMtXGrsrJh9+IpXx79MtMsEI8emN8z74vHpG8xA8OhkyY3XdTFGq40DitWLi22WlJVffk2o/fm+ikqWCO99AgQrOOftpUD1zAoREpCZTRvx7YLq7CHAvxWzgr7R8jbPJSSIUeofIkT9pEM8FAX8Avg9zwu1OW3r4ZixGLU68S9Zy3Ksoh4UVeWcLnFospiipMTimNw76mWsOoLj8/RcqH8ztn8pDpdqh4edx3rhrHqwiF2wAUDL0nlUJVAMoS3l9Gtalco1XuxJp3WXhrQXiYR8j9winzb4LXw0i+dpa1AdjHHoUCVBwcgwYI+YfZq9mIEkJeIViT6zwyT+tiBR0o1nBIZnE68WWdQKa0m5O5+OzKk4BgYon4nBgEgYX47CTkR/O2vk7SH77XXmRwnBxrUR37N9KxugNwGCMsvp3OGpisZATUJuBHiz765cjifbPlQue7IVfMVFoSi1yEysS5Un/0IEqUyeOK+d7lbcRaHYLtqJl+VFIsGioozec/Juk2QFC5D9r8Lidj3tKyrPvYIedK1VLRwKC7U0sTLy8xUXygRgjnzmWKn2bovzYX7NuhmVYLStpSo+dyaSREQz1LIBAiFePZ3sdnBM0P68Ca7OBmr6RL+q8TuztAdgAU5TrgS7dSa3WbD81cik6imy+TQLnlWY1LnaJU/XSQbyE6bxf4axNyUK/ofsjKbEPNtKA0qMjT2oDU5eKo3D9zE7Axq4b8RC7YbpTBqSeIBmfYjoMI6RbdXgIWpw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(366004)(396003)(346002)(39860400002)(451199015)(6512007)(26005)(36756003)(38100700002)(54906003)(966005)(66556008)(8676002)(4326008)(41300700001)(66476007)(33656002)(86362001)(66946007)(2616005)(53546011)(186003)(478600001)(6506007)(6666004)(6486002)(6916009)(316002)(8936002)(83380400001)(2906002)(5660300002)(7416002)(235185007)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jM6QqlnLk34kFg7rLiChc2yCsZ9mJDqlfd5eofec5wTyhvuXa8Hk5rWuhOSx?=
 =?us-ascii?Q?80p2QxgjJJuZAqO47mpXdpPIytoKWra86fIS2Lj3KqNb06MqYuu7v1fql/GZ?=
 =?us-ascii?Q?uvWdxo1+OICdh9FDw6X9gbGrQjopTpCPWYBXZsYtXSsM/UJVKK8A59JRen8k?=
 =?us-ascii?Q?FrplJFHJWahzL1asM6EF1x9ZzFcsMwfAOgmZeAxOinuSQEgiqdaueD/qIqT/?=
 =?us-ascii?Q?7yEzaBXsWS0n9bpFU92cGzYBB4+ubsi8SXiBPjcDr42fLRxx0n2DHVH3cvaz?=
 =?us-ascii?Q?Ko8Ha3moJiBupaJse+QL+nWI5iCYSEAS/wn2CWocPG9CIZHJPyPpqzk+u1U5?=
 =?us-ascii?Q?WrbD15BZL/hpwIqeyBLe2Hb3/CUgV7+7kr3VOKFW2aXqIqkR9A982oWHbbZp?=
 =?us-ascii?Q?t4ZfK4GnbeJ4YZnanA1YbIvfG4OsqfQjER6HPcu6hj9b95zXTHeQ98sSPc8T?=
 =?us-ascii?Q?jnTJbNiqmz6Fqn5vvm1pwZrLgfi3M9UYEHfPT+zDjl0+gBiiA8C/5ATjNmAP?=
 =?us-ascii?Q?e4hgj2vc0RKl8aLwP7HvuqLtxHfvU1WwNq9rlVv2eTo/F2+npn2BOTnmmNVn?=
 =?us-ascii?Q?ynpjG7ILqsoGF5YQXw+Eegho6JgNVSP9iAI/yAivXEwRIWUAwQYuq8ad7NdI?=
 =?us-ascii?Q?AUUZovoYTXBJ79kgrQuF7X69DCwHN7faiSVJqx05sf1t2I9Z6PmicUmZ1RsL?=
 =?us-ascii?Q?J6FWuK/wuF/HaD8WwTDqYOOV/CjL3lXEiAx+FQwgUHgzYHwAn+7AfOiia8Js?=
 =?us-ascii?Q?+T5Ius6ZrnfijzLrwwIAcGfqaQ7OglghNXVHXdHkQbAh/QrOBoZSH0DR8MQ0?=
 =?us-ascii?Q?bfAGU304SkP07wJHtLe3i2Fvq4+8mGiUmhwj9JPRNLCZNF/Kk1lO6ZG6fqPy?=
 =?us-ascii?Q?RoWyYiFPaWYDiqnif6WSLxY9HTgbyv0s4fLvzqXtCTlisE3sDUjTFXHG/Mc/?=
 =?us-ascii?Q?3lF1sO2wZxUGaGKDLCDl9pjfMSWmDR5xQMCi1Rn4kgx+d+h6Hc/So67IkOh7?=
 =?us-ascii?Q?zRh2Ejm3ZOk/bxq66Xzcwy4ZeaI6fq7Hap8DOTb1EgYuGgGN0XqzSIqFOft9?=
 =?us-ascii?Q?R6Wpd/OBm9ZlWnFnpHHdDIEjnBQwGs7fPVCWVS5TjgFIUrwapX+dfrZ9gt/o?=
 =?us-ascii?Q?VRtrrPNp8QM5zurIu5qxPwAejr9LM5kOwIN7sInt6x4CbXYvyTFJHyvCmzof?=
 =?us-ascii?Q?+CbQ71tfuAdVJVP7t/j+y4iKxltSbPz9MxEJesHnWlqQIOJgK9uPRcayFieR?=
 =?us-ascii?Q?2RcVzbEI5w6BVFKDo8WHVkxAzdzNb6CfWpi+r752n2WO9s8Q52TXQnfubiaE?=
 =?us-ascii?Q?YvgbA7CtBymrBGx7GIyViQy4vdueABr51lHp5xLhbUUnBN3nhUwi0D8m3OgH?=
 =?us-ascii?Q?X42xxnG9Ea/PGc4mnNt6hqxPsqcO0x/iy1iPJ09qv6Hc/IApjXKhXoT3jQC9?=
 =?us-ascii?Q?YWraH9ekgMd3LAmxOXxZQ2B2RHbpvucYopyoUZyvNW1sXXEu3MOI3l2HL0/9?=
 =?us-ascii?Q?EAA+SA4OMy9MKKcli0HFT7udKG4alNd+BnOf0UwDfOkMRa3NUGfY29PTHWSY?=
 =?us-ascii?Q?qqdOgDOd/H/WW3XxJlXxK8xYt6j3ofzuQ5ILe+9u?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b57757d8-da4e-4536-5c19-08dace18de1a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 12:39:02.8558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k2X6zG+xo4p4F/LSfGEjRZTWXqpT+044eaqCLaJdCbRRo0Hd5Lc7PYpSNyVnMUsB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4206
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_42A13E90-6CFB-424A-B4CA-C5EFF4F67114_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


On 24 Nov 2022, at 5:43, David Hildenbrand wrote:

> On 24.11.22 11:21, Gavin Shan wrote:
>> On 11/24/22 6:09 PM, David Hildenbrand wrote:
>>> On 24.11.22 10:55, Gavin Shan wrote:
>>>> The issue is reported when removing memory through virtio_mem device=
=2E
>>>> The transparent huge page, experienced copy-on-write fault, is wrong=
ly
>>>> regarded as pinned. The transparent huge page is escaped from being
>>>> isolated in isolate_migratepages_block(). The transparent huge page
>>>> can't be migrated and the corresponding memory block can't be put
>>>> into offline state.
>>>>
>>>> Fix it by replacing page_mapcount() with total_mapcount(). With this=
,
>>>> the transparent huge page can be isolated and migrated, and the memo=
ry
>>>> block can be put into offline state. Besides, The page's refcount is=

>>>> increased a bit earlier to avoid the page is released when the check=

>>>> is executed.
>>>
>>> Did you look into handling pages that are in the swapcache case as we=
ll?
>>>
>>> See is_refcount_suitable() in mm/khugepaged.c.
>>>
>>> Should be easy to reproduce, let me know if you need inspiration.
>>>
>>
>> Nope, I didn't look into the case. Please elaborate the details so tha=
t
>> I can reproduce it firstly.
>
>
> A simple reproducer would be (on a system with ordinary swap (not zram)=
)
>
> 1) mmap a region (MAP_ANON|MAP_PRIVATE) that can hold a THP
>
> 2) Enable THP for that region (MADV_HUGEPAGE)
>
> 3) Populate a THP (e.g., write access)
>
> 4) PTE-map the THP, for example, using MADV_FREE on the last subpage
>
> 5) Trigger swapout of the THP, for example, using MADV_PAGEOUT

Added the original THP swapout code author, Ying.

At this step, the THP will be split, right?

https://elixir.bootlin.com/linux/latest/source/mm/vmscan.c#L1786

Even if a THP has PMD mapping, IIRC, it is split in the add_to_swap()
then swapped out. But I cannot find that split code now.


>
> 6) Read-access to some subpages to fault them in from the swapcache
>
>
> Now you'd have a THP, which
>
> 1) Is partially PTE-mapped into the page table
> 2) Is in the swapcache (each subpage should have one reference from the=
 swapache)
>
>
> Now we could test, if alloc_contig_range() will still succeed (e.g., us=
ing virtio-mem).
>
> -- =

> Thanks,
>
> David / dhildenb

--
Best Regards,
Yan Zi

--=_MailMate_42A13E90-6CFB-424A-B4CA-C5EFF4F67114_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBAgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmN/ZeIPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKAEAQAKJkzpES3ErPEOZmGntHBHU4Y2Vbky1mQVNt
Vd7lvoHAkCbIYlYYdOhtr57p1PmgRAAQmtOitV3QOPgM5Mt95TMdPx4NjcLCOMGi
UvCeo75tWHG92e7BQpaC/Acn4tO35MoPRbUtqHVV4y7i/wEASAL1p3lls0GAcc56
aV7/EjJp7e8dT2ev1t72Lb42GGWsM8pqXevblegInVIwK3FS88NHA1PgPXQyjpbn
hMB8kzAipwTpYkDksHi2wz0wD9DATsZ0RDO/IKBwcKkL9qIngw2qiiZPKhD6F4DJ
Lrbmjpx19CPGqbdquH2nFEW2uGDqCSwgatKffbD85mgfN6xfOcCImyc8O/CVM8CE
5MQv1snUv9h9xjlNCeca6AWfdlo2GRl5yApFWHbaKk8fD+g6tRQWPBQHgLUokorg
YFLbI12XA/113RvP1B519v641vWRLe8fvKnTlKOUgX4qROCMvV+1TsQZL8CLiIst
ppL0iAMorbtJbBtUssdA8ulmRMmkj5DoumNtik8zjKbJn2zLrqlX0KWrUD/vJ2Ni
NhGbZsbNHnppVL4K0stSb8UUyltop2XnUiX/KzDX3azwSSeynCn3pkhnWLnk8aI1
GYdYYvB9iVL6M5UaW8Its4eWcpveCTV00QJSim73dDkTEOR7nabr4SaRJWwRBkHI
UQvx5vId
=YefA
-----END PGP SIGNATURE-----

--=_MailMate_42A13E90-6CFB-424A-B4CA-C5EFF4F67114_=--
