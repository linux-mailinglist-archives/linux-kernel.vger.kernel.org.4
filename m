Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74B460D8AA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 03:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiJZBBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 21:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJZBBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 21:01:08 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C648574E14
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 18:01:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gykPRY81/61CmOv8w8O/iAUbQw9X89f3qa83e143Fwpge2Bg0qjPMOTHM6GR+JPWgRolKrNrOSKLgQx8FJu69sgH0Zz/Lf4kAaGnk8BblByxMbV1n9JiNGdUA0zsGZIMEf/5S8QrvAzLMo1wXTclLTH2mfBttTmov4p1KAtZwRYeyudHNN2lsoG0UYjlw8nLcbjgeC3MXdIhYQYgkY/lHWmHTygXutF9DkkYhUQ+l8oLD2qIQsun/LDfH8/qLeOArFBJ1xQ2V5qpkzN+FUNJaQwDkaKp7tSkSM3yD7NfivhQv2Vj281crL3kuHDNxQQ9iiFMRJ0MirLP4vcO6dNivg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BoVLCYciw/SZooF8GDPidbfBUROSa3GCQBk4bJR4Ets=;
 b=QNnnVr89zgFcSZUYPQQjva/pGelEBOs54OHNJnPfvB4x6QpvX42H2BYQwcBH4DxGDGNjCPcL/NlEw3qDgFKLLu+5ieu62SQEMtvY4Jcgki9QgpRAm4dFuaHND06pVHjEzCQLCTGQ+2gMH7950Y5a6Br86nqO9SSgExS2WmnPjpgg/f4HUuItqNIv3sjXm2wh4/4xqyXPKYwcvNiA5V6JbgO2+jEyYKkDORga7To523nJLUPZgEd0TVGqPVS/7a1y1uqXN8qkM75qTY3b1Gj9TIOP7g7HwlO22qJRRbA00hlfTMTwkTArMoWIIkmZeqcDgwhQg7d4NLUkFm6sED+s+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BoVLCYciw/SZooF8GDPidbfBUROSa3GCQBk4bJR4Ets=;
 b=d0D5x2Io7525TpWid9Gcul7gMk3hIp8rKnHIjlAzInDujDvuzRrOi9e1AioU+7R+jcs4J1b5RUef43PcuQpRgEDmP1XOg0mmL85BV+PU0SVEBHlH/501skcqKkOinqOtxQARavB8/SmH5mGGPlfX19Ke+81ow+GM/imgjT5bE/V5tmlw15A23saNoiQ0tcYB15Pl7J1PrBc0eo62b4xKOV2AD9eshIK5MPBzYkBH7KZHFVwT6gWzgEDXk9GemiBFIDsb2WKPLSLXzt35Or7hiBsqUhiA//6uqqmg/Up6H+gUYSHh+2DS1ZGsXVfOsU30CiTraEICrHxx0GjT55jvRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by MN2PR12MB4127.namprd12.prod.outlook.com (2603:10b6:208:1d1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 26 Oct
 2022 01:00:42 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::6ed5:b1a6:b935:a4d8]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::6ed5:b1a6:b935:a4d8%7]) with mapi id 15.20.5723.034; Wed, 26 Oct 2022
 01:00:42 +0000
References: <20221022111403.531902164@infradead.org>
 <20221022114424.515572025@infradead.org>
 <2c800ed1-d17a-def4-39e1-09281ee78d05@nvidia.com>
 <Y1ZGNwUEdm15W6Xz@hirez.programming.kicks-ass.net>
 <CAG48ez3fG=WnvbiE5mJaD66_gJj_hohnV8CqBG9eNdjd7pJW3A@mail.gmail.com>
 <CAHk-=wjoGnHVVp5pcb69C6HtnJ_avqQo_b5NK-X9bgoDDw_XbA@mail.gmail.com>
 <CAG48ez3KMuM2aLpc8SvGiqZvv1KFc7E2DBZ4CLzxQeFhrMN_-w@mail.gmail.com>
 <Y1dWQ+YQyiz3V9Sp@casper.infradead.org> <87fsfcuxu6.fsf@nvidia.com>
 <CAG48ez1Cw6cpjMW+Hq02nHTbW58qJ6TJY2CptMneRN5gmHGyiw@mail.gmail.com>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     Jann Horn <jannh@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>, x86@kernel.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, aarcange@redhat.com,
        kirill.shutemov@linux.intel.com, jroedel@suse.de, ubizjak@gmail.com
Subject: Re: [PATCH 01/13] mm: Update ptep_get_lockless()s comment
Date:   Wed, 26 Oct 2022 11:45:49 +1100
In-reply-to: <CAG48ez1Cw6cpjMW+Hq02nHTbW58qJ6TJY2CptMneRN5gmHGyiw@mail.gmail.com>
Message-ID: <877d0nv1or.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0037.ausprd01.prod.outlook.com
 (2603:10c6:10:1f8::8) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|MN2PR12MB4127:EE_
X-MS-Office365-Filtering-Correlation-Id: 80576b91-0f15-4f36-54f4-08dab6ed8196
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CYws/WxD+9wa/KGHwlDzOYMnRckdsgRK0B0wi6QoZBQg4Xr/DudkYLcJ7hBmD4lc8ShP4AhRkA9XpPQDpH9h/mtDKIdHghkUOs1YDoMJB3Fn3FYWpHSbMyo+yEogZjNnJ4TnqdvtvzOWzSGIXAqaED8rAOscqUh/nRlDHFx/cD8X1B0O6JIYIOF551G0i/5Qn+MrTKZPWbCBLwlaRwbcBsJh2qSoJ+AMQN/JPKYUqtjnllvD+58ebQMtH0ZU4oF6VTKCYC3YHQ/7H7NcybdRvapWdKyHX/qzpZ+k7y3pecI8BjQ+PBVtsggG20Fk6cKYYTcsaZydin3fe0sZ/qS+i2vPAY3cRKM0XlFlTQkSy22StcA5B8HSriJBKkolI5kDUw6qswifguO5EUQCvnNZIeUj9OO1guyLy/+mBHqUCCnId5ExrT6+zgNaFLMUvc8Dl7Iwcb18hErnmplywQ8WopCLMsU/R6WTaDSVFIYIMFJBuENL/XdVxgvfhZBlrNuCaJhlHabNThJ8Yvf98G9XsxlVn8H4xoG55AigY2p+HM2xrHNCIYsbjl4yWAtz5/jkrrO/4HCoShTtrkHU6hdc7nAYHt9a0MoYQxUTnEmcGHw3FWqPdZKmQQvDXLfFElLhg7Ys5aIfHbsOTO8BBVt2UqI1+WfXyFNGBmXV2Ceku/HASQo/Otz/2f0t/sV+c6M5RZVpbBq+m2bULNMdA5C5sg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(451199015)(83380400001)(86362001)(6486002)(4326008)(41300700001)(8676002)(5660300002)(66946007)(7416002)(316002)(66556008)(6916009)(54906003)(66476007)(6506007)(26005)(6512007)(53546011)(186003)(2616005)(2906002)(8936002)(478600001)(38100700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wluwHkAzDMQHsnnPo+lP6BBAGtSz0/e+zv1fFUc+vPi2tXd8FsP6TwtKt9ul?=
 =?us-ascii?Q?h9zBEwwNEpo4h6TCSpxHqh6hQc5CBH2wFGc/zkQLsy6QXSfQMet5iX48fquL?=
 =?us-ascii?Q?WPciziMetTxCIkFUC8qZCmsBQShXnhdNaXcje43klZ+R/cacNXk2slPUE3ub?=
 =?us-ascii?Q?UdoGHR2fkyqDKRq1V40cfij4sV1jv+9FBHclruyqdbm7Saju5fil1Zdz3A9z?=
 =?us-ascii?Q?dufGn6zo2CZkX8mE9sn4XYREBIQg+CJ/NK8O7M9JNZLRx2b2wOlfS39Sq4YQ?=
 =?us-ascii?Q?e0ibOqp6RC6B4FXj1z7cty+7ajjgSuzUdq9DTkKlCgQ3sWHy6SUWncnfOcvS?=
 =?us-ascii?Q?vYe90rqvX10EMge79uS6MGUUk4QagfnGeNokNUoP1XkEDrqdExNjweu85LIM?=
 =?us-ascii?Q?PYsxYkmtFGGw9vJJjo7GQdrN05acsIjUXiC94UuJoUms+Qhd9N0j+TN4btX1?=
 =?us-ascii?Q?2UH4o2XBSY+/hdhs4AaFFc6r4Uq5iNevuNqETZqxwMIAjSq58PIaZsBD0ebi?=
 =?us-ascii?Q?XzpiReXXoCNzQBgwmV3I353otIuc0PMHcEJ0bYNv7iqjdhxZLr0zxQidIR+q?=
 =?us-ascii?Q?Q2NAR6tqlHaEgd8SooBa+wNvoTda8VEWNsQeZ9eDWhK5T3rCoHo7L/hrLNF3?=
 =?us-ascii?Q?rjyKzyOczavAt67L17roXw1CqyNj1obbj+lmgNX5ZqmY5K55RIVM+xCQtNKd?=
 =?us-ascii?Q?nr0lBrd0n2FEEZpEADax6MVoNGmwrjaClH+fu+A7PCVbkvfx3tcUq66PtfI5?=
 =?us-ascii?Q?JryzzK/o5vycctwRbcQttu1vQESGmIy16zmCwI7MeAoTxVL8Y+Q9VUnpyZDl?=
 =?us-ascii?Q?CPMgBstm4rlyhBxLQ2dbkk451H8B+MBdHwrmLL9oJEWn/Mj8+ztAEM+7/dyT?=
 =?us-ascii?Q?u9GCxWDql4DalvO4aw9QCYWo1rPjTXeGV6q0mutgJK6G/elpO3Png59hy8q7?=
 =?us-ascii?Q?LKo+laHKoKRZ9AKv8Wv/dh4SUa/crkz4+mFWjoK0IxqRgmk62cq6epJ/wt36?=
 =?us-ascii?Q?+3x5W0xsX51YA1Itij2Nf4muvfj+jt/qpSyw3Gi1nZZH4IbSBC/rJ8Xmze0U?=
 =?us-ascii?Q?h8VTUxW8kB/UTa0W1XxR234iexO4Ml9jExH1Qg9zSDPJ9S/gdM0YEQSdk+Dp?=
 =?us-ascii?Q?etygrkKRwxLaq2lUkXxMsG48RMOuYfbHBnzVh38LHpgML82YQEDZA+NhSbIv?=
 =?us-ascii?Q?MQP+ImmOsUakqSTKXLQGUGzEojfkQWKn+V5TjsGUuhsW2OnJ2sVFHaTdrccw?=
 =?us-ascii?Q?CEghFc5X0fqw4A6sLsGgE9h7K51rhM3cTQPVOxwdhsQerhfsKfjgC2ZjBxmt?=
 =?us-ascii?Q?qcSuxJkjmtnDA6bCmMKuQ0h4A/VRtppc1TMZd6db/YjZr8Za2rc3yZzbIpKI?=
 =?us-ascii?Q?E3c11egVcjyUjfQpXQSz+9izIcqgC39lyd8drltLTz2N8QU98QBPtyuZFFWL?=
 =?us-ascii?Q?+6P9gIKszxNAKD/f8GN9jdVRvrRlo36BkBZf90DnW2bHuLsVU3g8tfMCfsI9?=
 =?us-ascii?Q?pmMcKUmOwYEQJfATyclhMVRVLdRAjyK+X3IVOiMWbX18d9xGM+kNH5xM4Rs0?=
 =?us-ascii?Q?9F6/+bxZYK1LodO3CH4GCLh/4wItV1Mkuwr6ZB5K?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80576b91-0f15-4f36-54f4-08dab6ed8196
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 01:00:42.5994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hRd9/DhaPAL97sSkVgIzGX7AQq+0WTMaeMEdRWRF7mAy26Vu5eMc1bqaUATJBuzglF3nTWDdHAB0ul8B79Egtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4127
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jann Horn <jannh@google.com> writes:

> On Tue, Oct 25, 2022 at 10:11 AM Alistair Popple <apopple@nvidia.com> wrote:
>>
>>
>> Matthew Wilcox <willy@infradead.org> writes:
>>
>> > On Mon, Oct 24, 2022 at 10:23:51PM +0200, Jann Horn wrote:
>> >> """
>> >> This guarantees that the page tables that are being walked
>> >> aren't freed concurrently, but at the end of the walk, we
>> >> have to grab a stable reference to the referenced page.
>> >> For this we use the grab-reference-and-revalidate trick
>> >> from above again:
>> >> First we (locklessly) load the page
>> >> table entry, then we grab a reference to the page that it
>> >> points to (which can fail if the refcount is zero, in that
>> >> case we bail), then we recheck that the page table entry
>> >> is still the same, and if it changed in between, we drop the
>> >> page reference and bail.
>> >> This can, again, grab a reference to a page after it has
>> >> already been freed and reallocated. The reason why this is
>> >> fine is that the metadata structure that holds this refcount,
>> >> `struct folio` (or `struct page`, depending on which kernel
>> >> version you're looking at; in current kernels it's `folio`
>> >> but `struct page` and `struct folio` are actually aliases for
>> >> the same memory, basically, though that is supposed to maybe
>> >> change at some point) is never freed; even when a page is
>> >> freed and reallocated, the corresponding `struct folio`
>> >> stays. This does have the fun consequence that whenever a
>> >> page/folio has a non-zero refcount, the refcount can
>> >> spuriously go up and then back down for a little bit.
>> >> (Also it's technically not as simple as I just described it,
>> >> because the `struct page` that the PTE points to might be
>> >> a "tail page" of a `struct folio`.
>> >> So actually we first read the PTE, the PTE gives us the
>> >> `page*`, then from that we go to the `folio*`, then we
>> >> try to grab a reference to the `folio`, then if that worked
>> >> we check that the `page` still points to the same `folio`,
>> >> and then we recheck that the PTE is still the same.)
>> >> """
>> >
>> > Nngh.  In trying to make this description fit all kernels (with
>> > both pages and folios), you've complicated it maximally.  Let's
>> > try a more simple explanation:
>> >
>> > First we (locklessly) load the page table entry, then we grab a
>> > reference to the folio that contains it (which can fail if the
>> > refcount is zero, in that case we bail), then we recheck that the
>> > page table entry is still the same, and if it changed in between,
>> > we drop the folio reference and bail.
>> > This can, again, grab a reference to a folio after it has
>> > already been freed and reallocated. The reason why this is
>> > fine is that the metadata structure that holds this refcount,
>> > `struct folio` is never freed; even when a folio is
>> > freed and reallocated, the corresponding `struct folio`
>> > stays.
>
> Oh, thanks. You're right, trying to talk about kernels with folios
> made it unnecessarily complicated...
>
>> I'm probably missing something obvious but how is that synchronised
>> against memory hotplug? AFAICT if it isn't couldn't the pages be freed
>> and memory removed? In that case the above would no longer hold because
>> (I think) the metadata structure could have been freed.
>
> Hm... that's this codepath?
>
> arch_remove_memory -> __remove_pages -> __remove_section ->
> sparse_remove_section -> section_deactivate ->
> depopulate_section_memmap -> vmemmap_free -> remove_pagetable
> which then walks down the page tables and ends up freeing individual
> pages in remove_pte_table() using the confusingly-named
> free_pagetable()?

Right. section_deactivate() will also clear SECTION_HAS_MEM_MAP which
would trigger VM_BUG_ON(!pfn_valid(pte_pfn(pte))) in gup_pte_range().

> I'm not sure what the synchronization against hotplug is - GUP-fast is
> running with IRQs disabled, but other codepaths might not, like
> get_ksm_page()? I don't know if that's holding something else for protection...

I was thinking about this from the ZONE_DEVICE perspective (ie.
memunmap_pages -> pageunmap_range -> arch_remove_memory -> ...). That
runs with IRQs enabled, and I couldn't see any other synchronization.
pageunmap_range() does call mem_hotplug_begin() which takes hotplug
locks but GUP-fast doesn't take those locks. So based on Peter's
response I think I need to add a rcu_synchronize() call to
pageunmap_range() right after calling mem_hotplug_begin().

I could just add it to mem_hotplug_begin() but offline_pages() calls
that too early (before pages have been isolated) so will need a separate
change.
