Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633E95B7EB8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 03:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiINByM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 21:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiINByF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 21:54:05 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2061b.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8d::61b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445B56F25C;
        Tue, 13 Sep 2022 18:54:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ktnXNhUpXSnDGUjfpw5jhy7dg/nTGwJyDqu4Dlhn1/3i3/kTqdxXB/Rt4q6Q46FpC04teHfhgtAGjidiKjKGdcuT7M58P+zMEUL0QEFDI7T6x5I88I2QVx0IEUPZRNAH6TZ4Tiy095y0WxZIrenih6Nc2v0lzBOlCF03DGDsukhZ+NwNcl+pjb9GVl05gMcqb4zHChuOMSCcGaFy9CWEspFR37hz6MNuOQ/ozJ4EobJta8lQanuIV5a7IaqOivKMTpVCeuPWuoIbnjGHej87ev1omkvtwE47MoldqGwABx17M7tqmLYhbsCy4byKTfk0r7m9vwpV0aidNjtakJhiMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0qe4taQolvH4WmzSpeRyKWWHW9BkVcg+3kiaK0LuwY=;
 b=VJLcuz+QbzWskdSMIBX5aeEISEN7ZKgHI6bZU2qEMxx2P3yB4cmm6Dmicz0bTkE2/wnnKAzlmsh50gX+mdHJHP/hlZjO3SzSad22RHDrXZy7+xyD5MiLE5I0e0mRaXLUpLgxdSD6a17fxDsqUrUf3zsqZ/h+04pxJhEcEggYC04JfVd36NY8d57A1iSugX2GbFNnuA7k9UByji/+Ms3zUZmpqw3jHtm+kRiKmGj6+eW7QL2bZNXBxGgjuSgAL/+i1DYH9coJR7fhk7mPkYWAcBvdBDI9rQRxcoRHLRh8bevp8rzQ/cIIyGUW5lk48u6IZEHMHWCOyYO8c+39C0BIVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0qe4taQolvH4WmzSpeRyKWWHW9BkVcg+3kiaK0LuwY=;
 b=sfsfr2KznhaqqL/9B005aRww6v0mqKMzUSQen/p5yq0pK2LDHwFPkfjMhctySLxG9Bb3uDw92Epv9kXoSQql8avMP0AyTaUegXHb4L/JCiceEa3XjiUpfiSkLae6ENpazQwOxV1Fq7pjiNMsaZlwkkTBX0lBT88ElwMYT0jgCHq0jnWMu4JXal6/LNf2yHyTsSK5lajB/4U2z2254zCve2wopU6p02HqkKNioVxzJaJC16cAbtzgiOZ//VFFGN3e3Cl8G4Y2KC4zCZ5PdLXsh7VyqcWW/zPFC6INxceolSGYvROUYmELtERaIB9XvjwgQpwdMGmEDFgFMvw+Qj22dQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 CH3PR12MB7570.namprd12.prod.outlook.com (2603:10b6:610:149::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 14 Sep
 2022 01:53:58 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::94df:bc2b:6294:8cc6]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::94df:bc2b:6294:8cc6%6]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 01:53:58 +0000
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
Date:   Tue, 13 Sep 2022 21:53:55 -0400
X-Mailer: MailMate (1.14r5911)
Message-ID: <819CB6CD-0112-4B07-BDFE-84611470070F@nvidia.com>
In-Reply-To: <6b465dd1-f5b1-cb6c-cee0-5461b66f6031@gmail.com>
References: <20220913195508.3511038-1-opendmb@gmail.com>
 <20220913195508.3511038-2-opendmb@gmail.com>
 <36E322BF-F052-4A8B-9FA5-4E0AA84E4AAF@nvidia.com>
 <ff84d89b-6d4f-c739-63be-4c4825b1fd03@gmail.com>
 <71D040CB-0E26-4CD3-9121-54D740F24594@nvidia.com>
 <6b465dd1-f5b1-cb6c-cee0-5461b66f6031@gmail.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_C6DE2338-5CD5-4849-A7E4-C38AAC38E815_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR01CA0038.prod.exchangelabs.com (2603:10b6:208:23f::7)
 To DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|CH3PR12MB7570:EE_
X-MS-Office365-Filtering-Correlation-Id: 95576a0b-a9d7-4166-3e9a-08da95f3fd3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KX8ZIVIH+qXcS3V/OPiVcFVq1VaBu4o6t5q66EPIRqr3XdZTkzNmPHOF29YDIIQsi0qxK3v5sb9Fub1fya2le+gilpv3+W7AcTjKmOlNxRwtC9dpU6IvTcEaHSiAZQHnOdmt3tGLvQtEVDSvfGp9Wv5sZIWOFqyafjmrsJqzk7i2xrJboyJL8co+u9DMpotW06gDa3pd0VDuZ4cTgD10/MfiNtk2BlbP3VvlZ/PrzXsGbybBNrheC9jQsuMYEL0KdjDrRaTptUw2cEeg3rincDCgl1Cw01aPo5FdPxubLiIE/tsCLmIjdZRdmrHWGNF9Cb0MwICutgUbK2z751o1CaIGlCAJrKPwP1GCVgEb5jtsKjPopTsvQHq51IbB/JpY2dHAsWDqfauzznGutPXyuWmBF+PJXsO53xdfFCaJh9reacXVYte4ePh0YTk+Fiv/JEmlHhDsfn2eZHxlXWEp871V5ljzfSsXWNS0AOzzCyW+c9ru+ElmbQIhlhVviJgcizzpBXZqRqHtqzXt1T0uwmVij0rMQrLjkq+/NwjaY1kad5+W4uZwMAPzeAcgXYlJSYi2Edtf66Ev95QvVJss4OmVlP+8Ie31G27/RbQiS6y+AkSEh/0HcphyzYF+CuZjmpuKIMGUjDcWPutKpZqylj4ZXxc2GeVPbjZA6X78q//6vsG+fpTHwYUpKd+HCuZRA0J5KJgREfB1QDNMY87aRf0N5P52AwKrjtfTh1gWpkj0KndQZfDVnIvB22XJSCyyPB+Gvk6QW5XqyOQgo2oBguc5gXlKznrVvlol8MXn8To=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(346002)(366004)(396003)(451199015)(54906003)(36756003)(41300700001)(26005)(66946007)(66556008)(86362001)(8676002)(66476007)(6486002)(186003)(316002)(6666004)(7416002)(5660300002)(2906002)(38100700002)(4326008)(30864003)(6916009)(235185007)(6506007)(478600001)(8936002)(7406005)(6512007)(53546011)(83380400001)(33656002)(2616005)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C5VU95s739BGgWcdp8lnlI1liYFIwFiJ7OyqHN2vvrghm53+FtozIc7xG1ZD?=
 =?us-ascii?Q?XztGcKIkNtGZLdNDNQPgVJs5RWMHVmDSasKs4DD3TGR+CJvIFhOCtADCBGWz?=
 =?us-ascii?Q?cmViV32s589p6pECNS+WNrPyKHnI1WvkBZphhcVKeDzRNv0Ff88wDluBn/2D?=
 =?us-ascii?Q?0nY/xvyw7p2QhQ7oaA3CzANsw7R3wneSXPqfuSX/5O1u0/Mv7ikWhu97dAO4?=
 =?us-ascii?Q?W9RG0zliKGlKNVPzFa6X6dM/V24A/3kV1Q+sBcMIiG3YYEEnK2nMMb68s4Wl?=
 =?us-ascii?Q?+vPS/9rTKOmocx4NAYLkfmUDsGU1yKAYbVBQVNEUGzi/8RctmpfBty/xc6Wq?=
 =?us-ascii?Q?4ux2NSJy3aRIK9S/pPl7TDZ5oZADarkh5+97EYSHDnXqLzETqKGC9fMLH0UN?=
 =?us-ascii?Q?6wurVCZ3uINdQAz4KBhrSYVs9li8eUK6rtq1tShocv16hDbR1Go0lG5YsXQN?=
 =?us-ascii?Q?4OQNntGG/sd1SDrZfbe5KG6gljT/mWTRVSsLpWEk/CKy+1CBpQ+orCm3BZu5?=
 =?us-ascii?Q?kC1Ls/q08ext6j5W2ulsx9DwdnCpYD5OUMuCJuQBzf17N5UNGOw0hHAM5cPT?=
 =?us-ascii?Q?jHGLQ7VD2UXLN/2lcj9RSSAA06uhNs4egvEMRleDrJRnrBBlIJXhC9h3FPeo?=
 =?us-ascii?Q?S80Gt7x1GOnakWWzx7nPy+7l2mhBb9I/5Zd91yNU6OYSd/V/J0gFt7YBHXnv?=
 =?us-ascii?Q?hm33mCB7w4MbELdYyhym2M22B80DoY6qtAriLNWdvKXTrb72ZHqenWRvz6sa?=
 =?us-ascii?Q?mNUF8hqUzAuhNyX6F71+F3yMEfftYHLKMKF7UhnLEoQrDjaecjE5Gjr43N42?=
 =?us-ascii?Q?Lvb+ZJ68kTUUQ2ykKOgx9xGc6+TV+NTJq2nWZAVTzdc9BxV3f0HfBvYz3+qo?=
 =?us-ascii?Q?EMlkfEi+6R6B6/BMzPm6NKXlaW/vsfjsO2rPGCG7yDD8PKpM3acJZPDaY5tM?=
 =?us-ascii?Q?TfGVBtcfe6pfZYstks5i/6SxHrkXlk7wbsnEtIh/UdSed+5sP18McT3Gl8tM?=
 =?us-ascii?Q?rpLpJmrmCB2KR1kTpePw9+Ztu150QIAgYtLYrnND21oFx2fr67yD6K2CYWe/?=
 =?us-ascii?Q?UijpXA52kSSguvMHRqFGOgD8uJIaRBtncCa4Dt/1huhAV9hmwUUr8TMc3Cfm?=
 =?us-ascii?Q?jQakzE+W8mxZy6FfQZn7Gh/VLUzfluKocy64dGU+RjFszE30sRIpsKwTPPuP?=
 =?us-ascii?Q?UrPj3blsULnnicDOk2Ll2JAI5BqskbQ+05sxIk/w9i6FeIfldFBtSDuAzDwr?=
 =?us-ascii?Q?dk+3M0CEQleIQ456LU2BtKUvvF6Pqg3SGI1g2hJ0eBqGM54cUjFXkbsjoC6l?=
 =?us-ascii?Q?vQsFMK0mcNvlk4tXGqggkfm/C/OkLdrngKvOD5SDlF7SBlBpwFBBwHGttTyC?=
 =?us-ascii?Q?ID77ZJGje5n/B1wDSOHot1+3XYTLSnxM5qNk77+l90NibM2fZbPHm1f81QxO?=
 =?us-ascii?Q?jgiX+mCXtJCzIX8ZC2C0/rCfZT2i6HGquj5n3qB571z7W0t82xP+lh3Jw7z3?=
 =?us-ascii?Q?8Q9W8tVmoN+NerSioVH4HBKMkA/XC026FTWwiUu5dhuy9DLbaNSgOX4nvnGx?=
 =?us-ascii?Q?FhBHZcs/fVwIfdm8A1u+GODPerPEEXlwjuJHXj0W?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95576a0b-a9d7-4166-3e9a-08da95f3fd3a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 01:53:58.6578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ctj7p5wxHpnUSuzT4k/HDQMdqio8CEuYojMiqyt7iEW7RQKXgx1G1dZwf8SjH96E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7570
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_C6DE2338-5CD5-4849-A7E4-C38AAC38E815_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 13 Sep 2022, at 21:47, Doug Berger wrote:

> On 9/13/2022 6:09 PM, Zi Yan wrote:
>> On 13 Sep 2022, at 20:59, Doug Berger wrote:
>>
>>> On 9/13/2022 5:02 PM, Zi Yan wrote:
>>>> On 13 Sep 2022, at 15:54, Doug Berger wrote:
>>>>
>>>>> The function set_migratetype_isolate() has special handling for
>>>>> pageblocks of MIGRATE_CMA type that protects them from being
>>>>> isolated for MIGRATE_MOVABLE requests.
>>>>>
>>>>> Since isolate_single_pageblock() doesn't receive the migratetype
>>>>> argument of start_isolate_page_range() it used the migratetype
>>>>> of the pageblock instead of the requested migratetype which
>>>>> defeats this MIGRATE_CMA check.
>>>>>
>>>>> This allows an attempt to create a gigantic page within a CMA
>>>>> region to change the migratetype of the first and last pageblocks
>>>>> from MIGRATE_CMA to MIGRATE_MOVABLE when they are restored after
>>>>> failure, which corrupts the CMA region.
>>>>>
>>>>> The calls to (un)set_migratetype_isolate() for the first and last
>>>>> pageblocks of the start_isolate_page_range() are moved back into
>>>>> that function to allow access to its migratetype argument and make
>>>>> it easier to see how all of the pageblocks in the range are
>>>>> isolated.
>>>>>
>>>>> Fixes: b2c9e2fbba32 ("mm: make alloc_contig_range work at pageblock=
 granularity")
>>>>> Signed-off-by: Doug Berger <opendmb@gmail.com>
>>>>> ---
>>>>>    mm/page_isolation.c | 75 +++++++++++++++++++++------------------=
------
>>>>>    1 file changed, 35 insertions(+), 40 deletions(-)
>>>>
>>>> Thanks for the fix.
>>> Thanks for the review.
>>>
>>>>
>>>> Why not just pass migratetype into isolate_single_pageblock() and us=
e
>>>> it when set_migratetype_isolate() is used? That would have much
>>>> fewer changes. What is the reason of pulling skip isolation logic ou=
t?
>>> I found the skip_isolation logic confusing and thought that setting a=
nd restoring the migratetype within the same function and consolidating t=
he error recovery paths also within that function was easier to understan=
d and less prone to accidental breakage.
>>>
>>> In particular, setting MIGRATE_ISOLATE in isolate_single_pageblock() =
and having to remember to unset it in start_isolate_page_range() differen=
tly on different error paths was troublesome for me.
>>
>> Wouldn't this work as well?
>>
>> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
>> index c1307d1bea81..a312cabd0d95 100644
>> --- a/mm/page_isolation.c
>> +++ b/mm/page_isolation.c
>> @@ -288,6 +288,7 @@ __first_valid_page(unsigned long pfn, unsigned lon=
g nr_pages)
>>    * @isolate_before:    isolate the pageblock before the boundary_pfn=

>>    * @skip_isolation:    the flag to skip the pageblock isolation in s=
econd
>>    *                     isolate_single_pageblock()
>> + * @migratetype:       Migrate type to set in error recovery.
>>    *
>>    * Free and in-use pages can be as big as MAX_ORDER and contain more=
 than one
>>    * pageblock. When not all pageblocks within a page are isolated at =
the same
>> @@ -302,9 +303,9 @@ __first_valid_page(unsigned long pfn, unsigned lon=
g nr_pages)
>>    * the in-use page then splitting the free page.
>>    */
>>   static int isolate_single_pageblock(unsigned long boundary_pfn, int =
flags,
>> -                       gfp_t gfp_flags, bool isolate_before, bool ski=
p_isolation)
>> +                       gfp_t gfp_flags, bool isolate_before, bool ski=
p_isolation,
>> +                       int migratetype)
>>   {
>> -       unsigned char saved_mt;
>>          unsigned long start_pfn;
>>          unsigned long isolate_pageblock;
>>          unsigned long pfn;
>> @@ -328,12 +329,10 @@ static int isolate_single_pageblock(unsigned lon=
g boundary_pfn, int flags,
>>          start_pfn  =3D max(ALIGN_DOWN(isolate_pageblock, MAX_ORDER_NR=
_PAGES),
>>                                        zone->zone_start_pfn);
>>
>> -       saved_mt =3D get_pageblock_migratetype(pfn_to_page(isolate_pag=
eblock));
>> -
>>          if (skip_isolation)
>> -               VM_BUG_ON(!is_migrate_isolate(saved_mt));
>> +               VM_BUG_ON(!is_migrate_isolate(get_pageblock_migratetyp=
e(pfn_to_page(isolate_pageblock))));
>>          else {
>> -               ret =3D set_migratetype_isolate(pfn_to_page(isolate_pa=
geblock), saved_mt, flags,
>> +               ret =3D set_migratetype_isolate(pfn_to_page(isolate_pa=
geblock), migratetype, flags,
>>                                  isolate_pageblock, isolate_pageblock =
+ pageblock_nr_pages);
>>
>>                  if (ret)
>> @@ -475,7 +474,7 @@ static int isolate_single_pageblock(unsigned long =
boundary_pfn, int flags,
>>   failed:
>>          /* restore the original migratetype */
>>          if (!skip_isolation)
>> -               unset_migratetype_isolate(pfn_to_page(isolate_pagebloc=
k), saved_mt);
>> +               unset_migratetype_isolate(pfn_to_page(isolate_pagebloc=
k), migratetype);
>>          return -EBUSY;
>>   }
>>
>> @@ -537,7 +536,8 @@ int start_isolate_page_range(unsigned long start_p=
fn, unsigned long end_pfn,
>>          bool skip_isolation =3D false;
>>
>>          /* isolate [isolate_start, isolate_start + pageblock_nr_pages=
) pageblock */
>> -       ret =3D isolate_single_pageblock(isolate_start, flags, gfp_fla=
gs, false, skip_isolation);
>> +       ret =3D isolate_single_pageblock(isolate_start, flags, gfp_fla=
gs, false,
>> +                               skip_isolation, migratetype);
>>          if (ret)
>>                  return ret;
>>
>> @@ -545,7 +545,8 @@ int start_isolate_page_range(unsigned long start_p=
fn, unsigned long end_pfn,
>>                  skip_isolation =3D true;
>>
>>          /* isolate [isolate_end - pageblock_nr_pages, isolate_end) pa=
geblock */
>> -       ret =3D isolate_single_pageblock(isolate_end, flags, gfp_flags=
, true, skip_isolation);
>> +       ret =3D isolate_single_pageblock(isolate_end, flags, gfp_flags=
, true,
>> +                               skip_isolation, migratetype);
>>          if (ret) {
>>                  unset_migratetype_isolate(pfn_to_page(isolate_start),=
 migratetype);
>>                  return ret;
>>
> I would expect this to work as well, but it is not my preference.
>
>>>
>>> It could certainly be done differently, but this was my preference.
>>
>> A smaller patch can make review easier, right?
> It certainly can. Especially when it is for code that you are familiar =
with ;).
>
> I am happy to have you submit a patch to fix this issue and submit it t=
o stable for backporting. Fixing the issue is what's important to me.
>

I can submit the above as a patch. Is there a visible userspace issue, so=
 that we need to
backport it? Thanks.

>>
>>>>
>>>> Ultimately, I would like to make MIGRATE_ISOLATE a separate bit,
>>>> so that migratetype will not be overwritten during page isolation.
>>>> Then, set_migratetype_isolate() and start_isolate_page_range()
>>>> will not have migratetype to set in error recovery any more.
>>>> That is on my TODO.
>>>>
>>>>>
>>>>> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
>>>>> index 9d73dc38e3d7..8e16aa22cb61 100644
>>>>> --- a/mm/page_isolation.c
>>>>> +++ b/mm/page_isolation.c
>>>>> @@ -286,8 +286,6 @@ __first_valid_page(unsigned long pfn, unsigned =
long nr_pages)
>>>>>     * @flags:			isolation flags
>>>>>     * @gfp_flags:			GFP flags used for migrating pages
>>>>>     * @isolate_before:	isolate the pageblock before the boundary_pf=
n
>>>>> - * @skip_isolation:	the flag to skip the pageblock isolation in se=
cond
>>>>> - *			isolate_single_pageblock()
>>>>>     *
>>>>>     * Free and in-use pages can be as big as MAX_ORDER-1 and contai=
n more than one
>>>>>     * pageblock. When not all pageblocks within a page are isolated=
 at the same
>>>>> @@ -302,9 +300,8 @@ __first_valid_page(unsigned long pfn, unsigned =
long nr_pages)
>>>>>     * the in-use page then splitting the free page.
>>>>>     */
>>>>>    static int isolate_single_pageblock(unsigned long boundary_pfn, =
int flags,
>>>>> -			gfp_t gfp_flags, bool isolate_before, bool skip_isolation)
>>>>> +			gfp_t gfp_flags, bool isolate_before)
>>>>>    {
>>>>> -	unsigned char saved_mt;
>>>>>    	unsigned long start_pfn;
>>>>>    	unsigned long isolate_pageblock;
>>>>>    	unsigned long pfn;
>>>>> @@ -328,18 +325,6 @@ static int isolate_single_pageblock(unsigned l=
ong boundary_pfn, int flags,
>>>>>    	start_pfn  =3D max(ALIGN_DOWN(isolate_pageblock, MAX_ORDER_NR_P=
AGES),
>>>>>    				      zone->zone_start_pfn);
>>>>>
>>>>> -	saved_mt =3D get_pageblock_migratetype(pfn_to_page(isolate_pagebl=
ock));
>>>>> -
>>>>> -	if (skip_isolation)
>>>>> -		VM_BUG_ON(!is_migrate_isolate(saved_mt));
>>>>> -	else {
>>>>> -		ret =3D set_migratetype_isolate(pfn_to_page(isolate_pageblock), =
saved_mt, flags,
>>>>> -				isolate_pageblock, isolate_pageblock + pageblock_nr_pages);
>>>>> -
>>>>> -		if (ret)
>>>>> -			return ret;
>>>>> -	}
>>>>> -
>>>>>    	/*
>>>>>    	 * Bail out early when the to-be-isolated pageblock does not fo=
rm
>>>>>    	 * a free or in-use page across boundary_pfn:
>>>>> @@ -428,7 +413,7 @@ static int isolate_single_pageblock(unsigned lo=
ng boundary_pfn, int flags,
>>>>>    					ret =3D set_migratetype_isolate(page, page_mt,
>>>>>    						flags, head_pfn, head_pfn + nr_pages);
>>>>>    					if (ret)
>>>>> -						goto failed;
>>>>> +						return ret;
>>>>>    				}
>>>>>
>>>>>    				ret =3D __alloc_contig_migrate_range(&cc, head_pfn,
>>>>> @@ -443,7 +428,7 @@ static int isolate_single_pageblock(unsigned lo=
ng boundary_pfn, int flags,
>>>>>    					unset_migratetype_isolate(page, page_mt);
>>>>>
>>>>>    				if (ret)
>>>>> -					goto failed;
>>>>> +					return -EBUSY;
>>>>>    				/*
>>>>>    				 * reset pfn to the head of the free page, so
>>>>>    				 * that the free page handling code above can split
>>>>> @@ -459,24 +444,19 @@ static int isolate_single_pageblock(unsigned =
long boundary_pfn, int flags,
>>>>>    				while (!PageBuddy(pfn_to_page(outer_pfn))) {
>>>>>    					/* stop if we cannot find the free page */
>>>>>    					if (++order >=3D MAX_ORDER)
>>>>> -						goto failed;
>>>>> +						return -EBUSY;
>>>>>    					outer_pfn &=3D ~0UL << order;
>>>>>    				}
>>>>>    				pfn =3D outer_pfn;
>>>>>    				continue;
>>>>>    			} else
>>>>>    #endif
>>>>> -				goto failed;
>>>>> +				return -EBUSY;
>>>>>    		}
>>>>>
>>>>>    		pfn++;
>>>>>    	}
>>>>>    	return 0;
>>>>> -failed:
>>>>> -	/* restore the original migratetype */
>>>>> -	if (!skip_isolation)
>>>>> -		unset_migratetype_isolate(pfn_to_page(isolate_pageblock), saved_=
mt);
>>>>> -	return -EBUSY;
>>>>>    }
>>>>>
>>>>>    /**
>>>>> @@ -534,21 +514,30 @@ int start_isolate_page_range(unsigned long st=
art_pfn, unsigned long end_pfn,
>>>>>    	unsigned long isolate_start =3D ALIGN_DOWN(start_pfn, pageblock=
_nr_pages);
>>>>>    	unsigned long isolate_end =3D ALIGN(end_pfn, pageblock_nr_pages=
);
>>>>>    	int ret;
>>>>> -	bool skip_isolation =3D false;
>>>>>
>>>>>    	/* isolate [isolate_start, isolate_start + pageblock_nr_pages) =
pageblock */
>>>>> -	ret =3D isolate_single_pageblock(isolate_start, flags, gfp_flags,=
 false, skip_isolation);
>>>>> +	ret =3D set_migratetype_isolate(pfn_to_page(isolate_start), migra=
tetype,
>>>>> +			flags, isolate_start, isolate_start + pageblock_nr_pages);
>>>>>    	if (ret)
>>>>>    		return ret;
>>>>> -
>>>>> -	if (isolate_start =3D=3D isolate_end - pageblock_nr_pages)
>>>>> -		skip_isolation =3D true;
>>>>> +	ret =3D isolate_single_pageblock(isolate_start, flags, gfp_flags,=
 false);
>>>>> +	if (ret)
>>>>> +		goto unset_start_block;
>>>>>
>>>>>    	/* isolate [isolate_end - pageblock_nr_pages, isolate_end) page=
block */
>>>>> -	ret =3D isolate_single_pageblock(isolate_end, flags, gfp_flags, t=
rue, skip_isolation);
>>>>> +	pfn =3D isolate_end - pageblock_nr_pages;
>>>>> +	if (isolate_start !=3D pfn) {
>>>>> +		ret =3D set_migratetype_isolate(pfn_to_page(pfn), migratetype,
>>>>> +				flags, pfn, pfn + pageblock_nr_pages);
>>>>> +		if (ret)
>>>>> +			goto unset_start_block;
>>>>> +	}
>>>>> +	ret =3D isolate_single_pageblock(isolate_end, flags, gfp_flags, t=
rue);
>>>>>    	if (ret) {
>>>>> -		unset_migratetype_isolate(pfn_to_page(isolate_start), migratetyp=
e);
>>>>> -		return ret;
>>>>> +		if (isolate_start !=3D pfn)
>>>>> +			goto unset_end_block;
>>>>> +		else
>>>>> +			goto unset_start_block;
>>>>>    	}
>>>>>
>>>>>    	/* skip isolated pageblocks at the beginning and end */
>>>>> @@ -557,15 +546,21 @@ int start_isolate_page_range(unsigned long st=
art_pfn, unsigned long end_pfn,
>>>>>    	     pfn +=3D pageblock_nr_pages) {
>>>>>    		page =3D __first_valid_page(pfn, pageblock_nr_pages);
>>>>>    		if (page && set_migratetype_isolate(page, migratetype, flags,
>>>>> -					start_pfn, end_pfn)) {
>>>>> -			undo_isolate_page_range(isolate_start, pfn, migratetype);
>>>>> -			unset_migratetype_isolate(
>>>>> -				pfn_to_page(isolate_end - pageblock_nr_pages),
>>>>> -				migratetype);
>>>>> -			return -EBUSY;
>>>>> -		}
>>>>> +					start_pfn, end_pfn))
>>>>> +			goto unset_isolated_blocks;
>>>>>    	}
>>>>>    	return 0;
>>>>> +
>>>>> +unset_isolated_blocks:
>>>>> +	ret =3D -EBUSY;
>>>>> +	undo_isolate_page_range(isolate_start + pageblock_nr_pages, pfn,
>>>>> +				migratetype);
>>>>> +unset_end_block:
>>>>> +	unset_migratetype_isolate(pfn_to_page(isolate_end - pageblock_nr_=
pages),
>>>>> +				  migratetype);
>>>>> +unset_start_block:
>>>>> +	unset_migratetype_isolate(pfn_to_page(isolate_start), migratetype=
);
>>>>> +	return ret;
>>>>>    }
>>>>>
>>>>>    /*
>>>>> -- =

>>>>> 2.25.1
>>>>
>>>>
>>>> --
>>>> Best Regards,
>>>> Yan, Zi
>>
>>
>> --
>> Best Regards,
>> Yan, Zi
> Thanks for your efforts to get alloc_contig_range to work at pageblock =
granularity!
> -Doug


--
Best Regards,
Yan, Zi

--=_MailMate_C6DE2338-5CD5-4849-A7E4-C38AAC38E815_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmMhNDMPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUvMcP/3LJarsc944yqsbgAI6mdi0zV8ixR994eW0h
Mj2JerrB2wAJb4JA1iWXhbD9TLmMYbXKObBtxw/JK0LfqRYSKy+vKvaLQ1X7Iwrs
4eDg6W5+7x2RbbaZq1lZ7psHsn7AL942gDJiixYmGd0oHpnYrNi2f7nnacJk5qSr
I60QgyrGzDhw+Q5svjGg7rsEOpXaQRZ1MdeC7xARBNW6JEv6/b8fpkKTvtrF+wvj
OmEcMW6LXWvHk/1hu13ooH2gQZdxpu3nE6oTvoBKr1U9AgOY9370URJF2EERqtIR
Nbm0lVNDoo6VxBC5IJJYvPQaZSjEYc9c15Xd73X4djarfc1Y9fQ+MP/zc+Q9rqcO
h2H6CWgQb9JBvmizZgnxIXnDoaIvNtO0Ze78f1MtHKXZONsLBFhtmrM9iFWF6dSo
SAXrFCf0X6rb1GjXoXCWrsLNxKrFoWpMNHh4A3cCZ17VSs49+9ptkKuMT2E7XDPd
/T2QAIDlkWCsIWALjBSYOvNaC6eOJGIQc6yeKpNDmNM2KCYk4mD0HedVQOBPjV3h
YV8kscrzGx2+BZvNm+eZ34SETrD/d4GiCarlzmr9ft9kfGOb9n8yhE7U4GnKMGyV
BGIiNHOlDSikUfe56tfulGsLS7/2vb40O3XHCWawNDzUVnhyviz5yptNOkzMODnv
3I9gssUh
=L0uX
-----END PGP SIGNATURE-----

--=_MailMate_C6DE2338-5CD5-4849-A7E4-C38AAC38E815_=--
