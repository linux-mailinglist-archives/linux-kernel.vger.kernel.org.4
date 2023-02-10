Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C57669168F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 03:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjBJCOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 21:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjBJCOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 21:14:19 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D763A92
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 18:14:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ajgblgwOQSjcKHo8E+ObnIWJ/M6+xUBsiUuCh9xMkrW0sc/EzjGTJH13P2qKKy4kpriOL/FYKNFYEoLaA4ng9vmrG6N5MPR4L9b6/0VxH+mKOyIKUPF2jKFsBLOmuV72L8Y6XZvtnIGeMx5v+NQzVDRm/6gCtcWEEbaVbwceU9ixCxZQnuzQs/41eoBbxUgnr0N36yJLrQPI5AP3GRfgcwwAdlAhhm1XxGASp3WPsIVa0DaHTs7gW6oxhMwl+r9m/XHOacM6VIs3uHKCPf3ACxVN+Jvz9SWnMFTqGxeNJYHV5KjdDL2L7dma6KBfIV7kXssDdEOoWs8OD5/nAqqxBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TdaWsSMfXN6VQYoPcYXlJQ7nJzzY88eIg+ACrKK0aOM=;
 b=lneNqr9BfLXPv8ttoYcM72JyoG5VCK+VenrPCJByAdBdtcZcX0mkYUBkn8bkptjlWsYNvTu/P2X+SlVRapDMqNzbvQfpXoDfLGMvj0HvWX80w0Q2S60KTKqoiJ1zpEat3EEnUKUDtDCCovqaLLce79e9vUR82Px2dfTdCv+rqT23JzHy9udDjOdwTZ1tIOo7D/EliBbLcn+y8UofuUu9xPBo2kyTJwcseDwOHt9DpFuimHkk3Z8H3CJw5kJRA76AXbeo4IDp6Ek7NSqhgguHbdSzbKiSgv11hVG+SsEHMLZ3f7eNLeRPAac/gsz5h1jXxebIE1yejJcQ+3EeYr7LnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TdaWsSMfXN6VQYoPcYXlJQ7nJzzY88eIg+ACrKK0aOM=;
 b=uaOKssH8SfiqKAO8zyLNrJ1uzfP4GUGCFNoc94SkfF8G3am9VUFCs47rxpJcMOzmgUTUOMzzIu6oKaW1CAVDodUvPBXX7xNfDK6TH6pFhTrqTgy/espLFlgeirPpYefYBGTrYPvTGBORDnDBh//UhohS331A6qemiDS/+gMdYPE+XUBOVIUnoBni3TB7jZrkZ/XBwKtEwGk1V77BZhIpXBPezF7VUB4gKg1JpCU4VqepzNEo48aJ9MJJGatvMhu1PFT3S9X2k8Bb9O3+Ng05H2x2IfySAmYVlsUyL89LiSFwdzLamDACSfVjGIvrRCitA7HZsXq6NlFVYTwHx3V3wA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SJ0PR12MB5488.namprd12.prod.outlook.com (2603:10b6:a03:3ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Fri, 10 Feb
 2023 02:14:12 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::7f2e:5e8:9129:8663]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::7f2e:5e8:9129:8663%4]) with mapi id 15.20.6086.017; Fri, 10 Feb 2023
 02:14:12 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        david@redhat.com, vbabka@suse.cz, rppt@linux.ibm.com,
        osalvador@suse.de, rppt@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/page_alloc: optimize find_suitable_fallback() and
 fallbacks array
Date:   Thu, 09 Feb 2023 21:14:09 -0500
X-Mailer: MailMate (1.14r5937)
Message-ID: <494D9F5D-33A4-48B4-911B-9A75CFC9BC67@nvidia.com>
In-Reply-To: <ddc2d9001ef9d44651b62869ff9575b6@linux.dev>
References: <4C196D76-49A9-4B06-A51F-D8A13109DF3B@nvidia.com>
 <20230209101144.496144-1-yajun.deng@linux.dev>
 <ddc2d9001ef9d44651b62869ff9575b6@linux.dev>
Content-Type: multipart/signed;
 boundary="=_MailMate_756718FA-7414-46DD-ACD6-A18D239FD257_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BLAPR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:208:36e::14) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SJ0PR12MB5488:EE_
X-MS-Office365-Filtering-Correlation-Id: 43301e02-5b9a-4490-ec1b-08db0b0c801c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MSv6DmfY7U31LBLzDKrc1t2VSmT9Dk2dn1QjgqYvWEKqtRk7W108pbPp19LAKs94Ip4aV1S9GlDhDiNRjk9QQ6c3ujsdH7j7H5CkuDAYcencalLrkeEQhqzKd4jdzm+Ax2y0nK5Bu15rhze/wKN2i0QyRC9dEUpRjINA89A4R/tIcv4lPUxNjcbqUHA2AL71GsJ788rWJEa0CV3v02KBJ6vMHuhRZlJG7ccj67x+Z64oamS9Q2bDz4ToBBC4MfAX63oWHIxmrRlmuef5gJi0XnlEMc+De5da24OIG5cUjJIlpVXaQNajoDZOF0iFj/U+mgE179y9nK4cA2pAV0ay0L/qOFvcv5K95X/B/1fD6QQVFdfX4AwjDW/Xs60tTGItwp6XTregJQGgNCDScL+NIQikBNxHqI8MFZr+UrlUkDig2ksCVu/zmr1Xl14ZLLyRanqH1pqTP2gQn3uE6MsL6ovgXyUnhP7Y/V8RzYsy3DM4IHg72KKLXJ24rhNfgBRWKFMW2iUKC3+wH2wzZuUR1ZgqzFKNOBVmkF5gC0aJlRu6PyoYXQYjb7PEOSn2faZ+LKBvLvb2dVziW75SckY+PmYAxNa95+z2Gb96VdNidQk6ITxMqtYxvFe69PV/yef2UhEStNmMfWNX1noEph7XqbAVvo1PVih4+OoHCEa1b65eWi3o7TQS87TQgdBvynHQ+KUHwPFNl6RzR2UOHQcq2UOB9Lv4CouDgPHlfca0pb+pU/g6ZNTUtB17UeOXnWg/s06B0qIN0DMMLcgYRepHQWSyZZdUvHsVjn8FhAT0xrQib+i1RFheUFKGxJwLYUv4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(451199018)(2906002)(7416002)(6916009)(235185007)(8936002)(36756003)(5660300002)(33656002)(41300700001)(83380400001)(2616005)(66946007)(66556008)(66476007)(4326008)(6512007)(186003)(86362001)(6506007)(26005)(53546011)(966005)(38100700002)(6486002)(478600001)(8676002)(316002)(6666004)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6U8sWvg92NZ2vLCH8l+cRT86JNJ96ej+FyU1/1gFbGTe5sO4DfhWAJTPTRc1?=
 =?us-ascii?Q?I5nwJVjh9IfUNruufxoNvCL3caZgIHJRTrf6sCJzdqLDUtDe7EDxYXjEfOnS?=
 =?us-ascii?Q?l+UlRv2pNHJGvKnYP8/4Kz1l549zUdfR/REk9UcFrneMSpVTaDvqSHQlNDQz?=
 =?us-ascii?Q?Jf4g+jxPQt4H7kuoQxavJe7dpWAk9EB5c73grNwD7Y8ryZuii252E3Svaw9L?=
 =?us-ascii?Q?17G2mJsWqYz+9r5JScdUpVmDcVVNqd5Exkp76G4WslHSPpg9QnDSWPmhnIeG?=
 =?us-ascii?Q?cFz/1qO1mK8XANpozxI8uOuuu95zTprx89AUGR4T/kzLpp8L5rUKC497qYK7?=
 =?us-ascii?Q?Okh+/On4x3na4u3JfwC/s5njwVR7BJlu9dJnJVUHtgaUTHZHE8ul2DF+7Yq1?=
 =?us-ascii?Q?u0/J4w2mDn7yuGZ+OXcH0HSjgqv/Ip/hZmMe2L2PB7L54UhgiJ55SB/aoMXn?=
 =?us-ascii?Q?z4GWpQDJGj7bmLXS5CTOwWSPOWfCiJDBqW59ONyyUJRoYxp4DiicTs7MOGYo?=
 =?us-ascii?Q?memBUAKel2GXXbQDztBmuzpmBh3zctppfE4yg/iYHF/WbrcI9eT3fJC8afa7?=
 =?us-ascii?Q?4+pqCvNxcJwEybotsB8Z5oEE0fizlxShwr2s3Thm8IUGJ7taESzN6OmYr8ba?=
 =?us-ascii?Q?Zlh+SeDAtvkKYfFE0tITGiTEe27pgKiTy6jEXdMw3BsVsraK9e8u87ZOJwEq?=
 =?us-ascii?Q?YxDYfgxri0qMc0JfTp4pBwbEC1sutOzB9u1lsxNvW+JcJpbCMQ72QfmaU+s+?=
 =?us-ascii?Q?IRYU4K5K5cQHTtk69g/5FthtXQMF4jMq2EsqbdHYfqOq9J/MRAZbNu6zrih7?=
 =?us-ascii?Q?g95kwQ575GVjQrxhifTfaCiyOLlo9xyqZrtnxuJow/YvWTcrr6ZC/lVAOFML?=
 =?us-ascii?Q?DfHjBwbJrVjVpbxw4hbPgsul1HuxNELuCymzvPAtIYBHvRQF/8BRCLj+wTBq?=
 =?us-ascii?Q?+5TQObofZAhuA3kdICG6bCyxKcLTst+oapFYoxVzSf2316dUafhYEDR0xDn2?=
 =?us-ascii?Q?b0Tsgz/t/mUk9OYJmSxMUMp9T8A9XL/QPoqpElyuFo0o4kcG5pw67Tm4v08D?=
 =?us-ascii?Q?ykiShIbce2jzGKpSPM/uR8UcpMIqtJHANfPdzVTBCqJTUgsXoTDBF7FhXbx2?=
 =?us-ascii?Q?WZD0qvsI7PGz8hNKRCaDiV0CBHJ2cdfAXxFB6N5s85lrRtK0/989J5E3tqdj?=
 =?us-ascii?Q?sMh2QSncMdKyAQTfzYxIOPs0FhTofHwGDIb1xUvg5cKNWhV6E3vuKsmUN0dJ?=
 =?us-ascii?Q?dLq6UPgc/C6w9geE5CdjvOhaMtmEY03qS2dSq0F7oGx/9z9fcetENxhulfqi?=
 =?us-ascii?Q?c9BVVPozqX8YL81nJ0liOL149Jz+qvKvZM3kofQX/3LVwSbiEWfn+uE81dAc?=
 =?us-ascii?Q?pxlFnr+6xJ4nkZuLNCQ2DDW/I/2DFU99ZhfJ29LZz676A09UwA5Fe9UAEIRX?=
 =?us-ascii?Q?fs+BwUOp3QBElkPCPJVbs4Yi55AInuq4/IsFU0SvyqGCJsyMBGcXpHc7MMev?=
 =?us-ascii?Q?PE0hQrrBZ44AG4LK8LWaqOJxrjAMWeLIeR3/k66UJxMaQQSWeynOU9ME011g?=
 =?us-ascii?Q?+4WbCFCFGDyRdLuyvIIFiDbFX+GhXuCT6P09QHAk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43301e02-5b9a-4490-ec1b-08db0b0c801c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 02:14:12.1667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vNTGLwJd4SnqtLhOiI2hyfhfICQ5Yhrz6iTV+iDZ8hIFbOgPO74vI6VJ/R5c/Yd7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5488
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_756718FA-7414-46DD-ACD6-A18D239FD257_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 9 Feb 2023, at 20:57, Yajun Deng wrote:

> February 9, 2023 11:50 PM, "Zi Yan" <ziy@nvidia.com> wrote:
>
>> On 9 Feb 2023, at 5:11, Yajun Deng wrote:
>>
>>> There is no need to execute the next loop if it not return in the fir=
st
>>> loop. So add a break at the end of the loop.
>>
>> Can you explain why? If it is the case, MIGRATE_UNMOVABLE cannot fall =
back
>> to MIGRATE_MOVABLE? And MIGRATE_MOVABLE cannot fall back to MIGRATE_UN=
MOVABLE?
>> And MIGRATE_RECLAIMABLE cannot fall back to MIGRATE_MOVABLE?
>>
>
> The return in the loop is only related to 'order', 'migratetype' and 'o=
nly_stealable'
> variables. Even if it execute the next loop, it can't change the result=
=2E So the loop
> can be broken if the first loop can't return.

OK. Got it. Would the code below look better?

        for (i =3D 0; i < MIGRATE_PCPTYPES - 1 ; i++) {
                fallback_mt =3D fallbacks[migratetype][i];
                if (free_area_empty(area, fallback_mt))
                        continue;
        }

        if (can_steal_fallback(order, migratetype))
                *can_steal =3D true;

        if (!only_stealable || *can_steal)
                return fallback_mt;

        return -1;

>
>>> At the same time, add !migratetype_is_mergeable() before the loop and=

>>> reduce the first index size from MIGRATE_TYPES to MIGRATE_PCPTYPES in=

>>> fallbacks array.
>>
>> You sent a patch: https://lore.kernel.org/all/20230203100132.1627787-1=
-yajun.deng@linux.dev/T/#u,
>> why not squash this one into that? Why do
>> we need two separate small patches working on the same code?
>>
>
> Yes, this is better, but I overlooked this one when I sent the first pa=
tch. It is already merged.
>
> As Vlastimil Babka said, reduce the first index from MIGRATE_TYPES to M=
IGRATE_PCPTYPES may be
> cause out of bounds access of the shrinked fallbacks array If we don't =
judge the range of
> migratetype. But this doesn't happen with the second index.
>
>> Thanks.
>>
>>> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
>>> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>>> ---
>>> include/linux/mmzone.h | 2 +-
>>> mm/page_alloc.c | 11 +++++------
>>> 2 files changed, 6 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>>> index ab94985ee7d9..0a817b8c7fb2 100644
>>> --- a/include/linux/mmzone.h
>>> +++ b/include/linux/mmzone.h
>>> @@ -85,7 +85,7 @@ static inline bool is_migrate_movable(int mt)
>>> * Check whether a migratetype can be merged with another migratetype.=

>>> *
>>> * It is only mergeable when it can fall back to other migratetypes fo=
r
>>> - * allocation. See fallbacks[MIGRATE_TYPES][3] in page_alloc.c.
>>> + * allocation. See fallbacks[][] array in page_alloc.c.
>>> */
>>> static inline bool migratetype_is_mergeable(int mt)
>>> {
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index 1113483fa6c5..536e8d838fb5 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -2603,7 +2603,7 @@ struct page *__rmqueue_smallest(struct zone *zo=
ne, unsigned int order,
>>> *
>>> * The other migratetypes do not have fallbacks.
>>> */
>>> -static int fallbacks[MIGRATE_TYPES][MIGRATE_PCPTYPES - 1] =3D {
>>> +static int fallbacks[MIGRATE_PCPTYPES][MIGRATE_PCPTYPES - 1] =3D {
>>> [MIGRATE_UNMOVABLE] =3D { MIGRATE_RECLAIMABLE, MIGRATE_MOVABLE },
>>> [MIGRATE_MOVABLE] =3D { MIGRATE_RECLAIMABLE, MIGRATE_UNMOVABLE },
>>> [MIGRATE_RECLAIMABLE] =3D { MIGRATE_UNMOVABLE, MIGRATE_MOVABLE },
>>> @@ -2861,7 +2861,7 @@ int find_suitable_fallback(struct free_area *ar=
ea, unsigned int order,
>>> int i;
>>> int fallback_mt;
>>>
>>> - if (area->nr_free =3D=3D 0)
>>> + if (area->nr_free =3D=3D 0 || !migratetype_is_mergeable(migratetype=
))
>>> return -1;
>>>
>>> *can_steal =3D false;
>>> @@ -2873,11 +2873,10 @@ int find_suitable_fallback(struct free_area *=
area, unsigned int order,
>>> if (can_steal_fallback(order, migratetype))
>>> *can_steal =3D true;
>>>
>>> - if (!only_stealable)
>>> - return fallback_mt;
>>> -
>>> - if (*can_steal)
>>> + if (!only_stealable || *can_steal)
>>> return fallback_mt;
>>> + else
>>> + break;
>>> }
>>>
>>> return -1;
>>> --
>>> 2.25.1
>>
>> --
>> Best Regards,
>> Yan, Zi


--
Best Regards,
Yan, Zi

--=_MailMate_756718FA-7414-46DD-ACD6-A18D239FD257_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmPlqHEPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUzPIP+wVwHFRDWDP9rArIRi0FE2AF/8xp+RZ0plmI
mEoh7eSOFbBvKTI6XWvmyHBw6giaouUrHry9XH0ozuk/HzSkxfTh2KWEdxQn2QPO
L+rn1dFuhgXsLb1HB2vUH72PUjSPIZHmsJuLJ83NBORV217bSedVCFru7pQ/HI7w
UwIjbia1yRuwn7hdzrsH1hbOFhXwipm+B2U9ZDePCnv4rV+wwUN6TeOXxtF/E9VT
68in0z2ITD/um6hikvU6Y+hz33XdAL1ttSBs+mccEayq8Rf50wyUBwX0TsoBAPHo
yYpLzOA21z34ri1QpilRol5ObVEazyTL0SnMXk14lbMzcwktwK/muBNNTvFWdzji
nlPDXgOKCDpp+CRhptnSEV1Gq6HfYrw4p78GPsGvn9wipbA6Jwl5ujimItv6rZaW
3NL96W7hbYa6/rY0ZfTUsQh4F6hFBLRxC1+76f2HgdnZxCQWJxx0zyoMdeImhbsf
8fDX1KN5NMcgP6jdVV4TbnKs3bbjusoyiuQUi/PeBuYwlGcPaScWtmFsc3tHweRV
xQbHXNbZ0+TUliil1z7VOK/yPqJDcdTmU0EWjLHg8cRSopHfE45hbpTB9Qy4hLZ0
J0f+Tl4rkk353I9E8EjqmdMjJh5QqTb7IthksfE8GhTNqC61t7sphnP4CQY7sEQy
ReECHawm
=GA7p
-----END PGP SIGNATURE-----

--=_MailMate_756718FA-7414-46DD-ACD6-A18D239FD257_=--
