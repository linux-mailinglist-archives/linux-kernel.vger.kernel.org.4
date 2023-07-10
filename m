Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26EB74DBA8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 18:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjGJQzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 12:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbjGJQzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 12:55:02 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C689E58
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 09:54:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hmq/83vPYPWcN5iZwyyLP+rr2WSeJYw0COMYvu0jj6Yvqll1j5CLT8RvPRAzZGcQ617oHK9gwjzg7yhvj0MfJVpVrCQBNoHwDd41Hhiq4vMsrMfu5o9jiYcIds+qhCdIoDej0+ltdaK3OwJ3wwyIfaJmV9Ue3TMA1iS8KMklwjuhLQY+vrzvRJcHZV9FQT8ZpIC+iYu3u8CjdkzWbgyFhzkR4cIAT0gtroUIPzD9L9ssYQRuVOcTuxZIbVfnXyp+zncE8zmSd0qoN0YMdVofh+Ckk0CVWPZR4B4RR541yPBgdoZ+2yoYPnOvbDpA1YkS6BktfVe9Z6oq01AlZBm1WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lzj6JWmGezlQEOdya9p+ygIwZcsZWchF/CPxyXZ1fSM=;
 b=RUwCZsH1t/7CPI4t11+KxgTI4cNb/+a6yYw5F60Z/kr41wXOWg4fGPZRJBVRHrf4PQmCpgZx7ckkJBzWn0o8e2bJC6BkeSX7U1JinFPeyAfbq5Gv4shMZ357KkwZn+wiktWf7MwqdUx587PCEwcqBo1uyenUihTnUwAgeqg70Nn4qWhT37kh1g8HyIt88ixTUQ1epLM6spD2os8LDc2FERFUQebSIcSHjN/E2zMnRHRbhZfsLmlkl6W5yU27Ob0U3DbB/ae1wNLW5TuEZyjfseWyOe2Y9yo2kkXibOxGeMBchioy8vsHj012U/V9LACr5rZYSilwlwZWbtcd6ACjSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzj6JWmGezlQEOdya9p+ygIwZcsZWchF/CPxyXZ1fSM=;
 b=JWy2m/4OR0Wzl93Tcq0+IFSSWzZLBSEu+nZj+9jEOGJRKfk7hSk/rtSUACif5FEVGCmcALab+amsWfe4rK1wGptV0xoYF+Ka1tHX1ZtMEV3Udt6I9VXylK8Bl8AQ1Fyj06+bSk0FHA7lQictX6JdNMrXAtoT0rigSqQuYh6AZ0KI/c+xgYQnQ41fyL/MLGwaxqndLu1bHVXnbjvWX7Qc1Wwb6HBlJOm8j/MfzOCp+jPsIOQs9xNgx4KXOHKSNwi21kI8ipsZCt4EgxwujwCdxrEa02PBAc9qtsBeWvObqLiglh6JTyaFw0CGoBqiv7LD1bEzsdWZGTxin0DeTE7WtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 PH7PR12MB5877.namprd12.prod.outlook.com (2603:10b6:510:1d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Mon, 10 Jul
 2023 16:53:37 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::12b7:fbc0:80e1:4b8b]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::12b7:fbc0:80e1:4b8b%3]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 16:53:37 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2 0/5] variable-order, large folios for anonymous memory
Date:   Mon, 10 Jul 2023 12:53:33 -0400
X-Mailer: MailMate (1.14r5964)
Message-ID: <C56EA745-E112-4887-8C22-B74FCB6A14EB@nvidia.com>
In-Reply-To: <bfa13f35-bca9-c4e8-25f3-e8021f85f223@redhat.com>
References: <20230703135330.1865927-1-ryan.roberts@arm.com>
 <78159ed0-a233-9afb-712f-2df1a4858b22@redhat.com>
 <4d4c45a2-0037-71de-b182-f516fee07e67@arm.com>
 <d9cb4563-c622-9660-287b-a2f35121aec7@redhat.com>
 <ZKgPIXSrxqymWrsv@casper.infradead.org>
 <bfa13f35-bca9-c4e8-25f3-e8021f85f223@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_3D248BAE-60AA-46E6-B80D-515FFD38B7CF_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL0PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:208:91::17) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|PH7PR12MB5877:EE_
X-MS-Office365-Filtering-Correlation-Id: eadceeb5-86fe-43f2-890a-08db81663444
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KU9Cm1z8reaX5347tSaoVgGsXbcib4Y8vSOYn0abJlCT1wZqO95uz9Vor0d/he4GzJZ6RO7sloOehu6wUD3wmFLn0GgPjNBSBlmeyy+u4tmPwNyNxZ5a6up2NMHV9aNFMBSl+Ar1k2r8R3J+j6JJHDWtj0ATiIdMMeB2pukzxaRfaUtGj0XUdx5x4r1juVyNmt30FLNMgEF5eTDCM7UMhdWNpvWemzz42Ows48dVRXBWjZSbyx9drf3gutHAAwgComkjQRyTevVIZN6RpqfFUW8qeyEG0UhXayHnySfj4GqcjmNzXRvs+Z4tsiA0EWU42NXT8WcCPef60vOwiBMwVA3PCt+KfQjcy/EvQS3B5YViNWU1g1+PfHOvJm+acWIDhIUDfc6cVmNzLq4hdbyjC7GmdXHvbct8He8cK/gSkjuNT4NfWbR4oaiQJKsOpB25lsddelL3LLjAhBxIazQoCEJ6CJbBOX1Ddc9Y1gNmXg8A6MQcDHY66YrV3FE1tp9G8S8v1hCUWbKakjFTt72/Duvc8npZBxnGW38DFELW19NsTMGnSYM3U9DihVGEdpvFhFHbgs/5Pbb2ccn4FZZqiolxVjvTeraB7eqgRCvedbtPFRH7NpxucqRuMydiFrFcwCPKRp0hU5zO9Xf3g9txYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199021)(36756003)(33656002)(86362001)(38100700002)(478600001)(6666004)(54906003)(6486002)(6512007)(8936002)(8676002)(5660300002)(235185007)(7416002)(316002)(2906002)(6916009)(4326008)(66946007)(66556008)(66476007)(41300700001)(2616005)(26005)(53546011)(6506007)(83380400001)(186003)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2VFYneL+LKduAiEgqAgLiva2EwQlD3V0xGFpkbFVqrAVZex7zAp3/BxJsOEW?=
 =?us-ascii?Q?YzgQ4kXyD3ZOwu4ALpPYki2mr2g9v4/NQyakSTl0q5T75oIsyxP+lOPB4Jdt?=
 =?us-ascii?Q?UhNHJjjpvVJursh/BaCPvMa8ad0Nc6fFZ4BfoZYKaGpzF83HF0MQQDBZYQO/?=
 =?us-ascii?Q?eC20QlDqDtqDHWi7r8OPGOGDFKyjjS2yBRtKYq8V0o/Zm9aeYCXN+ClXWay8?=
 =?us-ascii?Q?7s1fIwVtVBw21gvUjGm3/TAxgFuGOJmpsps3T2F9sMSzzbp6Q4FocrInijn+?=
 =?us-ascii?Q?8qQOJpcIKtxMSU3ImI4jZ206lI4bMlUl5ID3jeSk02wYjcUO0U23nPOgksaX?=
 =?us-ascii?Q?EIG92O4gDWtP/1+zgWaD3mx7l1qJSP9EA5Io3E+rCjOtqwT2qMFNE4RkmYPG?=
 =?us-ascii?Q?DmHIHVIo5B6lAy+aTH1Db/qDb+98KdWtSdhXxe0CZUZFwYiwQk6K8YskY2T0?=
 =?us-ascii?Q?dxOZSX8YMR0e/B5UgARUiRG+Hx5Ilx1mChUtwt5xFL1N/vmal+apN95ZBWfn?=
 =?us-ascii?Q?RcCfC3GnepBRGeMDNagG5rs+wCgQlZHE8B9olcbP8Pj1NZ80Nsk/vCuIVg2O?=
 =?us-ascii?Q?LKIqsUt+Px0cqqGlL6IkN0ThbrxZ+drNQ9Vmh3/GFvN/8+BAMQplseObvlko?=
 =?us-ascii?Q?y0eK5j0rSZpjRq/hE0OcopGoRY9/nLjZHQkpK86Bv2En68E3esSyX0TwRj3H?=
 =?us-ascii?Q?L8qDX6hMcSCdO8Dk4EzFIR+FqbHrOeEp92+IeXBuwaEny9X8Bmrw4QuCGD6t?=
 =?us-ascii?Q?esTl7V6pDPeUyAG257/IQJyufxNMN4/HAuK0aohE8oR82Ii94kAXMkNjGuBa?=
 =?us-ascii?Q?uB327tJlNmejhcKmEvGcFCaAINIB0p5Vi+NXdxUlepWQ224Rb2w2/H6niGAg?=
 =?us-ascii?Q?WbPs6bqx1kr3Kw/Fk52O/EuG/+kLkc4ZReOLHQXzeOc8wugeszo1J5U+7mi2?=
 =?us-ascii?Q?f279NOg6dLRVm6yxngKl9F31DtNNkxW0FqtDtn7JMb/AG9M4jpFa0Ih72gIm?=
 =?us-ascii?Q?dZIBQtR5WH6+6qPyQ0A4zKs8W1ummhnpapIrEmZFWXDTPjASwtgNqm4fnwBG?=
 =?us-ascii?Q?/cNE3Qhj84KcLeQp7Ng4bO+DdgNngeZO4tJRd9HhESORmyfKGs8mXmHua6nQ?=
 =?us-ascii?Q?sexMJ0JIa7Np6z2IrnEkhM5AQqDT9ZfvJ00t7dj8COnLF/1c+QpauBSwi0cK?=
 =?us-ascii?Q?E9p3lyxr6zSooKqLGw+AatbZS2zj9l3FCc7qOdLxgPlvkWmeHl6LgjiVA/pb?=
 =?us-ascii?Q?98nZGEsy7g32JMBYlxadPJgSDKF7wfSWx/2eQ3FUNTi3J3JspF5IswagCpAq?=
 =?us-ascii?Q?rk40z8GdA7de9siiUm1NxMtBVSZYSojFIM6IpJWIPOIq7yU7nBW0lZOhR7uW?=
 =?us-ascii?Q?YpnqcFqe8cY+uKXdvm+qKrFpPd+X+WiilwuLL0NGk2+8ILWpT7iHkxSy6B9n?=
 =?us-ascii?Q?I4Bs17BVn+FWBsDNX6K4HLxPzaCBoOoHPM7MBWsntaGAsIzvaQaPmFAOAc2a?=
 =?us-ascii?Q?s8kp0wJ6b8fDuyAAOaBjbmVCVRZDmogsLSDBAC7dla0MjsiSedVMWSC6MA52?=
 =?us-ascii?Q?HCjkKsD+yJ+XOrDfAJM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eadceeb5-86fe-43f2-890a-08db81663444
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 16:53:36.9387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +sjSAx/A4Biz7FvsaoVtD+sC2V3CuzQqiWA43Iv9McZxMndjeBJEbsi+43E11Au1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5877
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_3D248BAE-60AA-46E6-B80D-515FFD38B7CF_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 7 Jul 2023, at 9:24, David Hildenbrand wrote:

> On 07.07.23 15:12, Matthew Wilcox wrote:
>> On Fri, Jul 07, 2023 at 01:40:53PM +0200, David Hildenbrand wrote:
>>> On 06.07.23 10:02, Ryan Roberts wrote:
>>> But can you comment on the page migration part (IOW did you try it al=
ready)?
>>>
>>> For example, memory hotunplug, CMA, MCE handling, compaction all rely=
 on
>>> page migration of something that was allocated using GFP_MOVABLE to a=
ctually
>>> work.
>>>
>>> Compaction seems to skip any higher-order folios, but the question is=
 if the
>>> udnerlying migration itself works.
>>>
>>> If it already works: great! If not, this really has to be tackled ear=
ly,
>>> because otherwise we'll be breaking the GFP_MOVABLE semantics.
>>
>> I have looked at this a bit.  _Migration_ should be fine.  _Compaction=
_
>> is not.
>
> Thanks! Very nice if at least ordinary migration works.
>
>>
>> If you look at a function like folio_migrate_mapping(), it all seems
>> appropriately folio-ised.  There might be something in there that is
>> slightly wrong, but that would just be a bug to fix, not a huge
>> architectural problem.
>>
>> The problem comes in the callers of migrate_pages().  They pass a
>> new_folio_t callback.  alloc_migration_target() is the usual one passe=
d
>> and as far as I can tell is fine.  I've seen no problems reported with=
 it.
>>
>> compaction_alloc() is a disaster, and I don't know how to fix it.
>> The compaction code has its own allocator which is populated with orde=
r-0
>> folios.  How it populates that freelist is awful ... see split_map_pag=
es()
>
> Yeah, all that code was written under the assumption that we're moving =
order-0 pages (which is what the anon+pagecache pages part).
>
> From what I recall, we're allocating order-0 pages from the high memory=
 addresses, so we can migrate from low memory addresses, effectively free=
ing up low memory addresses and filling high memory addresses.
>
> Adjusting that will be ... interesting. Instead of allocating order-0 p=
ages from high addresses, we might want to allocate "as large as possible=
" ("grab what we can") from high addresses and then have our own kind of =
buddy for allocating from that pool a compaction destination page, depend=
ing on our source page. Nasty.

We probably do not need a pool, since before migration, we have isolated =
folios to
be migrated and can come up with a stats on how many folios there are at =
each order.
Then, we can isolate free pages based on the stats and do not split free =
pages
all the way down to order-0. We can sort the source folios based on their=
 orders
and isolate free pages from largest order to smallest order. That could a=
void
a free page pool.

--
Best Regards,
Yan, Zi

--=_MailMate_3D248BAE-60AA-46E6-B80D-515FFD38B7CF_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmSsN44PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU4HkP/2eqrpsuhW5eSauD0tKhtXtsn8/juJr03m1u
UwxvfrM3tZXCp9FqPmMs3XKSeec/3/EZJKLr2arXy9fHm/U8AY9F5K7TUtZ6q1V0
fF4xIXa/FLMv069x5A0sX8RgkNWeUoxODWMdIEBCPAmCdDuNa2tlXDx7QYl0JcJb
leujrshinZXi0+77MuFUCoOuqzjiggkSOrX70dFAl8CQffYsaHx9RnXreNRC9AIa
9Nc5deqP+Zx7HtDrC2MSEh2unEhz8RuIavM00at96/iFKRqVWlhVkttc8e0rY6f1
/3QtCBmudHAYFUvZ8DD7ouFTmyWEZ+Vpc4H/7kJYap05aS9AzX5D4yIehCNBtLOT
BsWPcivTbwtundDHMhuUqICjh1L76quVtyD62puo6nu4KnZSCh0lpK3ZiumSFpa7
Tk+o5B7fIOaK6GycRswF5+9sr72x5IXR//tcE7Pf4id3AcoXWzhXQpnbZZHH6p9f
YWDd5riXzVXziCy5KGvPRoFdBE3t5jK/IRCGfNfi1Wo0DqUDvJ6TeVISi/Wf3C7O
0mrXD0AjqsVb1/v936OvCUi/1WIUzM6nWTHIumR/lo7pqO+xto6KfDhLGpYlUA/Y
jn2J7yEjR6S05Jw+uo1Nz3HW3GvzAj8exg0pRFiNO5Kyq6K8eM+kl68IlUuBRjSF
9pE8FQKC
=Y9or
-----END PGP SIGNATURE-----

--=_MailMate_3D248BAE-60AA-46E6-B80D-515FFD38B7CF_=--
