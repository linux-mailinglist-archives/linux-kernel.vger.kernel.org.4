Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87B8636FBD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 02:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbiKXBWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 20:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiKXBWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 20:22:15 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5A2102E76
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 17:22:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYO7Wz5hXIrELaWYK2O70PFeTkztHRy4pP3/cHRVew00FZJTYG5IOf1zibi94R4d8bYjZ2R5k11bxl6ut5ICEGtDvy5v0Mh8Ddwxa4020usDag4NB30bK5l+SXRa5GvUx+p87IffNrG0+mg+jaa2o0ruqTkVLWbl+PNDuGSOw3zFmBzFGnBvNpDZ4YE460piZulAxtLNlQwogZGOiiYgd/ksR6pNRq0AjgOgpqQX9wEOB3HtceEUCJlht0SIjLFNPM/LvL2fhm1vIiOLuDSCEAKRBnpfo6RJmEf2DxG/f5CkubV6FcI2R2IijMlFm6PdzaLQP6N7t9yj+jM36jxElg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bxgX1EAXeW7pAZzqCdHzrs4mVrjZO+wtOPih7XsSHGc=;
 b=XXDksVC8yqPvd6rGjWS/oup5XuOeIi6SmyaOsGkJBmm2n5dIbiw0lnVArhz90ER3PVO3jrNsrr6pZ6nwUoOE2d7iQzlkHR6bmerMlR6RDIppUjr70Hhdwn1mj0/dkO/te1nJn/OnqGk8r92Cadsd9Yqa29U9F/gMUOnw/EJFImcu5Yfp9UGRvMCS854q3ZG8cq+f8THMaiZ3D0cTIHEAg8To1nGKwKMJeYy3WZqu6jy4NV6b+g6NclvNzy3drxxejXCIpBXn7hrnoAD02BkYOsOV+7aED43DQmV8vQb2vfhDOxTfu/SXe91umRUEjdxahEPAHx+jh3Tyg+TW8x0UzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxgX1EAXeW7pAZzqCdHzrs4mVrjZO+wtOPih7XsSHGc=;
 b=usSTOV8H/2S7Wq1Lc90X34mgI1Fu3RlQulx6XBeO2ztS1LgYaVangUuozenCCMLr3nDXf3K17DqJQel7RhD+lhC8+pT99lzicOztq9Tc2Au51IY5bl/kBWRb1w7lRarZcgci1tIKZAABU4ULA1+Ssss+iz2D1F77qIokX0NkSttfDVRabMXfe3UqrELREXZqpYu9ig4lJtMvLiviSbG/7M5zCWDWdbtK4z3mhvotQ0CXX4bJ8lnJli66JbQ0hRRTI+NT6334hAMkxfWSgCtZYUyoUc7U9Rvo2S/qvf2nAegJX4l7o7vFaGybWLmn81iuC0ImNrDBCvi/rz0ttWtHQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by DS7PR12MB6285.namprd12.prod.outlook.com (2603:10b6:8:96::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.18; Thu, 24 Nov 2022 01:22:11 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::ecfb:a3ad:3efa:9df8]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::ecfb:a3ad:3efa:9df8%3]) with mapi id 15.20.5834.015; Thu, 24 Nov 2022
 01:22:10 +0000
References: <20221123005752.161003-1-gshan@redhat.com>
 <e8a64b11-98f9-b571-dce9-a60df98e3e5@google.com>
 <c61612f7-b861-39cf-3e73-dbe4d134eec0@redhat.com>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Hugh Dickins <hughd@google.com>, Gavin Shan <gshan@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, william.kucharski@oracle.com,
        ziy@nvidia.com, kirill.shutemov@linux.intel.com,
        zhenyzha@redhat.com, shan.gavin@gmail.com, riel@surriel.com,
        willy@infradead.org
Subject: Re: [PATCH] mm: migrate: Fix THP's mapcount on isolation
Date:   Thu, 24 Nov 2022 12:06:56 +1100
In-reply-to: <c61612f7-b861-39cf-3e73-dbe4d134eec0@redhat.com>
Message-ID: <871qptrvsw.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0233.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::28) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|DS7PR12MB6285:EE_
X-MS-Office365-Filtering-Correlation-Id: f7400370-1065-4c1b-76c3-08dacdba4f5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CFpegJ68uF34chHv4xXe2aXmBcBZEL/ZjucvxkD9DZjFsQ1P0Azf6XydbH3lC/OlrFS2Me++bA4AQwbMpnTO8sP9hIwXKY9PdR2CXCABuknkblUbWadYVvhgxG683LhrV6TSeBoVpvgeMbTDhiIc1dKPr+oADAARxGRrlhEJ2wHIrYwJfQehREeu1BwkIY4EL2tdno3C+bjm8aqjPXXgnhdKtiBavC1mMzvv490M2d9wzNrR97x8drG2cOV3wFlwxb/jKHGmtmrJrsWEouswnL5TxQOkJnv/iC23ZQ7aQxNERKKNynr0k+JGVhI6T8pnVoTYRyWaC8ZEQ5cEDvxrC0Zw1IvGwIz2+w2aEAAW04umNiN4ijsZhRinR2B9+O5W/xBHL2sIsjHub21Mv3pWehRY6gVQITqAvEfVPNPIoIChyFe/TGVXMBdkQ3dNt/e6DHVfiZgsaIWNpAzOdBlXmLcZCxsSvMXvwVr5zvrqUnOyPh/bW9qtalRUgb/Jj/Urq5V++nwU9dU+6FreTPg3OAavquCMde2wewvepcXkynMWG4Ru++NXTOyK076YRK2RTqy8EDy5e0hUl0oEuU93eS4YzEb4ebRWxxXGVHy94aTIios8wu4pxot/WKTZe/UewUXd5QCewev39Zxfuu4ksA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(451199015)(478600001)(6506007)(53546011)(6666004)(6486002)(66899015)(4326008)(8676002)(6916009)(26005)(66556008)(6512007)(66946007)(66476007)(41300700001)(2616005)(7416002)(8936002)(5660300002)(186003)(316002)(36756003)(54906003)(83380400001)(2906002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jV2dL3DFoXVYeSdgYJB16VpkWUXOkTBTiXKKnpsScomE9Yc76UH3/e7j8k8g?=
 =?us-ascii?Q?iAFgiMEC05+WDLF1iw3hF+MHsoG2jD7pD66A0pFbIKFoxHTWqm14mZ7NBSWX?=
 =?us-ascii?Q?7EyL96EWECcrVf0qbFUIgMxBTMRiz6EZsQTn5lF8+/CcZbtPibWuGPPGK6fd?=
 =?us-ascii?Q?huySxdY7pIcXyzdabdmm7HWOfk+yGvbkLnD6nyKp8iIPTbsxpbWR5khou5Ry?=
 =?us-ascii?Q?2sDWN0eyd3Rkr2Kgqu5Ktf25IHJdstLT50kznPhNb3hT3vdfqQ8PMOApCb2F?=
 =?us-ascii?Q?eTp9wILJtIAJHp6ST3WNVNAh+B58tKaMEsN48sTJ/Zmz5MgXLzOdckF6RTQ3?=
 =?us-ascii?Q?k2KAqjcu3rTWdbgWFVqrTcm3JBoQ93moe/nX1caANo+o1xs9ZhZUFlMJMMHN?=
 =?us-ascii?Q?ISoe0zjbEVUVex3cANhrCr5LH03jbGDxz1F1W64UdbjS3uZ1CUDLQz6eDBQI?=
 =?us-ascii?Q?VGXN/4t9ZQ0msPHOnQAxnsaEiZmVh6OJ8kkPxJ3yo4lU3PuP4c9Shovyb/c+?=
 =?us-ascii?Q?kM9VBvdagMnULD6LNxIGX/AVsll74vjEO47bSVBjZJXvWuJxE+I1FUzwhs2M?=
 =?us-ascii?Q?+97I7MvDAW9UsCsLMz5ktxsUeBlHSjmwh01NbHRLtbj//mD0t5JJoYkcDn58?=
 =?us-ascii?Q?lDLwgYg6h1sYTHfCt6YVw7kJLErf10ASUqD9bqDmqhm2I2xkRCt3iTRWhv7C?=
 =?us-ascii?Q?QAF8dUkAh0XN52tL68HQLEkX0zc51U7brnhTIUtnbBGVM4+rd+p1+PG/eLk5?=
 =?us-ascii?Q?i4iM3trG9UOEu0s5awWXCViDhAwTML6NFRE27tgsqYOnB8g1iKAP/xt3OA3z?=
 =?us-ascii?Q?/msl3vGFxfgty71iOdEhfXtmrPxQHwiSezb7cH8muu96fBXPiOx0Ut/KyyMv?=
 =?us-ascii?Q?Rp9TNYMGQwWbv6F+fq4RPwN3nNMDbQyT30LWZvjMDs9TfXAR/ERZJMhxGHk4?=
 =?us-ascii?Q?oFry2mYtDxe+pnTkYzkv8XGsBhzWjOErcate+JC+ZBdIV7uRC+N5VLDueA78?=
 =?us-ascii?Q?dHOsZXKUU9j5++lj+mR5Meso9kkpsyBWJvoQTu8r6U07fmn045u7+T9kgIgP?=
 =?us-ascii?Q?0lg2XvQtpSsjaG/DAWxPnL5wO64b/qxyOsqG4IwYjK1FwRK0hzzMWuPwQ1g/?=
 =?us-ascii?Q?YlWGYiPjz/xMjBC74HjI3H7NPLOJRBMa39eaA00+RLxv50H6K/tC5TQnN4fM?=
 =?us-ascii?Q?UAm9iM81UUrt/hJTI7VGAlsVVvbFnfmnZ/lyXdxj9vDpR+mK5XHBc9MKlrdU?=
 =?us-ascii?Q?LI8NMogGLUE1Cj0C856hHReXrw2nGOL5H24MKbgv0DJnNhainxTILPieLvux?=
 =?us-ascii?Q?j4wKwiPZPwhCDNlAqtFnhoUTSKiHz8ezvNnAGYghz1P0HG31MKoBslnZbwBM?=
 =?us-ascii?Q?nsdpMlQHzZ59OKQU86umEOzbG0IzvAUPnXUNs8cTvSAsVJVKRroMoi3wR5Zz?=
 =?us-ascii?Q?dFmbE3FMCSh6RYOqI/4YFYzwxPG3+QYQIHaqvbDY24JmjifDqy0Zw5aH0eLa?=
 =?us-ascii?Q?4kFHOTVoY0wuhehsCqhA9dE01rcILgHe8ajVU9OWJv0Ty+9MZs9BaaMfQW9a?=
 =?us-ascii?Q?EtsinJL92qPVbI5SqUIJJSAwblrp7ZY9C68zYx0t?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7400370-1065-4c1b-76c3-08dacdba4f5d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 01:22:10.6576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mZV/B5m9ghsvH5mn7HSrvyeOZK3dY0SiIe2xFGQFVNQc2o/8v4KzGfk94jTay0+a0/tmbfhHmuwtEuZT4OrsEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6285
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


David Hildenbrand <david@redhat.com> writes:

> On 23.11.22 06:14, Hugh Dickins wrote:
>> On Wed, 23 Nov 2022, Gavin Shan wrote:
>> 
>>> The issue is reported when removing memory through virtio_mem device.
>>> The transparent huge page, experienced copy-on-write fault, is wrongly
>>> regarded as pinned. The transparent huge page is escaped from being
>>> isolated in isolate_migratepages_block(). The transparent huge page
>>> can't be migrated and the corresponding memory block can't be put
>>> into offline state.
>>>
>>> Fix it by replacing page_mapcount() with total_mapcount(). With this,
>>> the transparent huge page can be isolated and migrated, and the memory
>>> block can be put into offline state.
>>>
>>> Fixes: 3917c80280c9 ("thp: change CoW semantics for anon-THP")
>>> Cc: stable@vger.kernel.org   # v5.8+
>>> Reported-by: Zhenyu Zhang <zhenyzha@redhat.com>
>>> Suggested-by: David Hildenbrand <david@redhat.com>
>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> Interesting, good catch, looked right to me: except for the Fixes
>> line
>> and mention of v5.8.  That CoW change may have added a case which easily
>> demonstrates the problem, but it would have been the wrong test on a THP
>> for long before then - but only in v5.7 were compound pages allowed
>> through at all to reach that test, so I think it should be
>> Fixes: 1da2f328fa64 ("mm,thp,compaction,cma: allow THP migration for
>> CMA allocations")
>> Cc: stable@vger.kernel.org   # v5.7+
>> Oh, no, stop: this is not so easy, even in the latest tree.
>> Because at the time of that "admittedly racy check", we have no hold
>> at all on the page in question: and if it's PageLRU or PageCompound
>> at one instant, it may be different the next instant.  Which leaves it
>> vulnerable to whatever BUG_ON()s there may be in the total_mapcount()
>> path - needs research.  *Perhaps* there are no more BUG_ON()s in the
>> total_mapcount() path than in the existing page_mapcount() path.
>> I suspect that for this to be safe (before your patch and more so
>> after),
>> it will be necessary to shift the "admittedly racy check" down after the
>> get_page_unless_zero() (and check the sequence of operations when a
>> compound page is initialized).
>
> Grabbing a reference first sounds like the right approach to me.

I think you're right. Without a page reference I don't think it is even
safe to look at struct page, at least not without synchronisation
against memory hot unplug which could remove the struct page. From a
quick glance I didn't see anything here that obviously did that though.

>> The races I'm talking about are much much rarer than the condition
>> you
>> are trying to avoid, so it's frustrating; but such races are real,
>> and increasing stable's exposure to them is not so good.
>
> Such checks are always racy and the code has to be able to deal with
> false negatives/postives (we're not even holding the page lock); as
> you state, we just don't want to trigger undefined behavior/BUG.
>
>
> I'm also curious how that migration code handles a THP that's in the
> swapcache. It better should handle such pages correctly, for example,
> by removing them from the swapcache first, otherwise that could block
> migration.
>
>
> For example, in mm/ksm.c:write_protect_page() we have
>
> "page_mapcount(page) + 1 + swapped != page_count(page)"
>
> page_mapcount() and "swapped==0/1" makes sense to me, because KSM only
> cares about order-0 pages, so no need for THP games.
>
>
> But we do have an even better helper in place already:
> mm/huge_memory.c:can_split_folio()
>
> Which cares about
>
> a) Swapcache for THP: each subpage could be in the swapcache
> b) Requires the caller to hold one reference to be safe
>
> But I am a bit confused about the "extra_pins" for !anon. Where do the
> folio_nr_pages() references come from?
>
> So *maybe* it makes sense to factor out can_split_folio() and call it
> something like: "folio_maybe_additionally_referenced"  [to clearly
> distinguish it from "folio_maybe_dma_pinned" that cares about actual
> page pinning (read/write page content)].
>
> Such a function could return false positives/negatives due to races
> and the caller would have to hold one reference and be able to deal
> with the semantics.

