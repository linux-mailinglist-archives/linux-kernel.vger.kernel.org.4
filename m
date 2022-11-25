Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB3F638221
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 02:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiKYBnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 20:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiKYBn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 20:43:29 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4777FAC8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 17:43:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eVAtFmsh4/5kEPwefcEtE3fq0+mgyIM23kGQQDgtpAWMLoA5tGc2FihycmDfuOGT8lOopJMJeET4D7WTRXxM0wj+l8G7pgE4Z/ETjFrbShvCdIUumMBa6CfvPNOG6GkPpuAS8/GDX3SkNRv7p0fLn/H1IGNYsjAUEhEzsVLH+vgL0ncb/V8ntWoZ9X/3ijTPxBQfsNlVCHw9zr9QO2YRD+Y5DfPlgJ8QiGxIAV/E5GzbomSd8kk9iHYRABX0NAu1duaE9X+6HoOanrmNzlsDhecXOTEYIS9stLtvg6rayOCsQPLkiZkzgKo/clwRLa0KsxNEbUHfUX3M69Rar62gXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gSVOJdhJnIzmYo3eVOPyCzsc/StYGwLhwS6kqTPoQk=;
 b=HNx9uAanL1ySfHkZasAGr2acZv3LD8JK4wfdBaQ0jz+3QW2EOqBdis2Xy9Q36jEjYKJR9RswkFgGQyGpiDJ3ZfiJcVVYH0W2v3GgGhl6qdHtsVwYmuS78hzIqvmyO/v1CgRjkOlA0v+oP9EUK2sITPL9aSNh1XBZmuQvCU7t4W88QuEljhFsvTKtepyQgjIoQ+z304KiKCibbCmpboBrvLbDr4TurpyzboG25EvAwX4jt2We0S8AskGoEYxxTduNMNHu1G72IczBqMjpkDRudFBHIHqMNz45+0CRy7OdU+CQRCWUfFjWNS0rjdrdD9AMPsBgOwKke6Ha/8ENPE07cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gSVOJdhJnIzmYo3eVOPyCzsc/StYGwLhwS6kqTPoQk=;
 b=nsAgLBbtdC+72Sd2dKkVlxa72VCldWUz25lM6QtZ4VMtyT+KjgEv0CW3LTDCMfDP8L0in9htnOGBKoM2zf5f5ridyqHXjd/xRApViqVMRuQNAOfdmfyiJagonfJlfBq2okhSCP3Uc4znZLjdPZHty9teLQPlUFjJNg3l6uuhfdA9GzaIKdku2sb/oZY1qe64t6Hu/8m8hOLEIDIwr6OdxDKmNbOgeaGoDIniQW37bCjDFSfvkpj+vJSRiY5b55twvKUqUXIdx0MRfacBZxMZrSiMnICTvHacpzxgf65NIURAJz8qCww/BbX+4/2YQ4IMB2LfJtDwr7qx3c3KTEft/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by PH8PR12MB7135.namprd12.prod.outlook.com (2603:10b6:510:22c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Fri, 25 Nov
 2022 01:43:25 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::ecfb:a3ad:3efa:9df8]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::ecfb:a3ad:3efa:9df8%3]) with mapi id 15.20.5834.015; Fri, 25 Nov 2022
 01:43:25 +0000
References: <20221123005752.161003-1-gshan@redhat.com>
 <e8a64b11-98f9-b571-dce9-a60df98e3e5@google.com>
 <c61612f7-b861-39cf-3e73-dbe4d134eec0@redhat.com>
 <871qptrvsw.fsf@nvidia.com> <Y37mC1+LQscJaOk4@casper.infradead.org>
 <51ffd399-7fa3-b2f2-b6e5-61a8b609e350@redhat.com>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>, Gavin Shan <gshan@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, william.kucharski@oracle.com,
        ziy@nvidia.com, kirill.shutemov@linux.intel.com,
        zhenyzha@redhat.com, shan.gavin@gmail.com, riel@surriel.com
Subject: Re: [PATCH] mm: migrate: Fix THP's mapcount on isolation
Date:   Fri, 25 Nov 2022 11:58:46 +1100
In-reply-to: <51ffd399-7fa3-b2f2-b6e5-61a8b609e350@redhat.com>
Message-ID: <87o7svreq0.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SYCPR01CA0012.ausprd01.prod.outlook.com
 (2603:10c6:10:31::24) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|PH8PR12MB7135:EE_
X-MS-Office365-Filtering-Correlation-Id: 4252c60f-db4c-49d2-b471-08dace867175
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BeRJTCYZwTlzRqTzlmgn6KjJBzjqlv08U+0PBzzOf6n/JY9cVJkgYWAJoua0rhhELvdpAVh6HM7pdM1Nvp/Er2g4KDpFacXM6HNhLpkqCwj4jbnxfLdHhiMSmQXRDtUfx3VsPIzrhVZ/vv+EcsK+5dj6cIhH0lMGIxrzgwm5dQsdtJpXDRpjGd5sGKDdaQd1nns85ue6hIURP2TdUupFVL+0nRa8C+ZxKvzuDz7KLqZdP8bEiGzmXfUtoMHJ0tG9Hm9e4obe8zoVK1fUUAi8/kCIa4yO+VRGYS4tPD3/M2n34wH7/mqoK2DNa9p5TwnftkyaW/i94qghWLn6kT4x1F+p0ureSMY6Gp8q39XXiH5gk2jkYO324P+AUyDYO47xXhSWYdoYhwrT6VwNXDoYos8fWKbF/Jy0uy7CNrJ4nbDYPUZKXg0qh1cXdqIcNzetL2KKY9M5N4yduCVamBlnt908OUebvGJjU25TXIdC0RieKNOyOpvlA8PxlXDewH/nDBMuIaliQ4tchr7E8ZSuy2fGSuSnD8yDYRXyv9ZUFgJSYKDXHGy7cElA6px3B5VHq867NZC7eLI9n42yEJuLKLi3iYpg+ZkYUNcf5WwkMMnJ9xT/WvB2ynAG3ySpzMcXQ+ZgVTHr+nh5gs5EbK3g8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(376002)(366004)(136003)(451199015)(2906002)(83380400001)(36756003)(8936002)(26005)(41300700001)(7416002)(6916009)(54906003)(316002)(86362001)(186003)(2616005)(6666004)(6506007)(5660300002)(53546011)(6512007)(478600001)(38100700002)(66899015)(8676002)(66556008)(6486002)(66476007)(4326008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xFlMdknn0yzwVbWkgT9di+Jy5XA8cw/oYJtIl5qN9FGHiJfL9/TOaIU8wUm8?=
 =?us-ascii?Q?o3enmn0rksp0O7Ko92q+zJshe2GDJp3iq2rt28exJ3CCn1bmCM2X6oBz1qDv?=
 =?us-ascii?Q?WmZQ2YInR+NZn3bBFmsY/MYExkzZ2vYuKhN+YbVVRo2HeSbVFQp3yQZ8afaF?=
 =?us-ascii?Q?u01z9RF5+OCkpoyI2xkW/nUGAz051Norsu+0qkGOLiMt63Hyx0hdlVyMu6QG?=
 =?us-ascii?Q?9ahIJtzEVO3JhqwKyn/Cbf5TrjEc8aIt762A7LSJmjOQkm02he8hSmMz3nmv?=
 =?us-ascii?Q?RdjJJcqu3gPwnV3kiCWo3qoY4kCSdfngpOzO6RPCB6OZxG9AhbeaUOYRADBi?=
 =?us-ascii?Q?8Nu3IO4Fkon8T6kwAGVTYdyOOeGbrNKQeI/BPjSwt9OJNZjFOV85881J2k3h?=
 =?us-ascii?Q?J24wNzUUUHC8jzDcPcEQjgZSYmUPfiG8LYgARM1Z7mJehDru2hOM8oHAA+Ux?=
 =?us-ascii?Q?49DTUjiTciT4zGHFKHZ1Qwam6yWdcHgFnWUYKDH2Sw7xxCMPkEj6ZInHdmNd?=
 =?us-ascii?Q?TJfKw/H5dhbS9XaxhhuGIrzEdeb0IlHwe/jRWs71S4HsuJoAnnHFHZ51nYdM?=
 =?us-ascii?Q?8VDo5xvYE7o7M17mjUwIBWtVJUNctEpsVIlqiLjJPOr3RVn0lkupe8Hdh7bp?=
 =?us-ascii?Q?/ZJWneQoGu9iDgVWbG6/4kHaSEj4IHg7+tqVPlfhDs0HQN+VorT9iPW/k/kV?=
 =?us-ascii?Q?OF4O8KbxGk0Q9W6K8dbxs79lp/abwJ6JcB5qtM4t0RxWIYQyeyPhpfSa5h23?=
 =?us-ascii?Q?1x0mT8z0pSLmP7rZBZ/0xe4e4rnxumS+mKIO+gtW2ciLWQ+hojsYR0ZzFZfz?=
 =?us-ascii?Q?AoSseZYEJHPn+khl/njT9wjhNGhbLHr0LFbkNvlT5+F8mlO+/qJWmlRjM8Da?=
 =?us-ascii?Q?0bWZT7fonzrwwlCjB2kp/8QccDu4SHs4cFfs7AqDJpumzIGJRQVVR8mM0IRp?=
 =?us-ascii?Q?6jYVcs9QOgX7h+7j2gauhS7ZJA/V8FRParNPM1qwNwUtplPIkPdksyPKPFZq?=
 =?us-ascii?Q?u6vPl2kapcKADMtS8lSvxzFzdX5qPfs98lq4wmA07++GH9VmXx2ZQIfkzRcL?=
 =?us-ascii?Q?C4pbvJ5oZGh9DHjqvQ2C3lfedhqNk8hOHc2UIgkMPXTROdrHw9xKlIIMY0Kg?=
 =?us-ascii?Q?DVzND58lRwYmkJFPhhvPbrBHxuldjwYCJqRm79yH7CtHip15b55P2g35e25I?=
 =?us-ascii?Q?gE5ATfm4Qvyr/UA7U4PkmvEE/sz6YgeGvACOhi5o2t7WRLCqxXZf+13aEJsV?=
 =?us-ascii?Q?n39QFSifqOOArg4eimbnGeWguPzSGzO0AZISZMANXiP2igK7WspNI0GVmXZ1?=
 =?us-ascii?Q?bJa6hVH/Y/jpY1huIyHquhsMd6+tHOjJ0B+ckj7gCYh/utoF+n/fGwnVrOzH?=
 =?us-ascii?Q?Rq6CppyaOjL2sBLD9FiIlP+y2Pkmqrc18VQFhCHyT12wPkuZngRi4MBZBhdQ?=
 =?us-ascii?Q?KNXwvnZLZL8Xj3IaRyMuF9ANJJP4WmgGbPwC+LjIRcTGCZp4ML4UGWYw2Nlj?=
 =?us-ascii?Q?64ubVyl042BZJSCBOdvQH5pUNG1NLXBaehs6wfWTP7CAkGHEb4MZN0ha5E93?=
 =?us-ascii?Q?B98elqbtP2L2DxGJxwPenh4UC5gTjytD6+F0gWFp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4252c60f-db4c-49d2-b471-08dace867175
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2022 01:43:25.2387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AxpUMveNCiespr+w3eNIvRag5eJaaEuTXRkZqGnk6alYz5Ol4GWG34gISWnk+B5sSBBEBa46n/GS/VTzI73dFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7135
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

> On 24.11.22 04:33, Matthew Wilcox wrote:
>> On Thu, Nov 24, 2022 at 12:06:56PM +1100, Alistair Popple wrote:
>>>
>>> David Hildenbrand <david@redhat.com> writes:
>>>
>>>> On 23.11.22 06:14, Hugh Dickins wrote:
>>>>> On Wed, 23 Nov 2022, Gavin Shan wrote:
>>>>>
>>>>>> The issue is reported when removing memory through virtio_mem device.
>>>>>> The transparent huge page, experienced copy-on-write fault, is wrongly
>>>>>> regarded as pinned. The transparent huge page is escaped from being
>>>>>> isolated in isolate_migratepages_block(). The transparent huge page
>>>>>> can't be migrated and the corresponding memory block can't be put
>>>>>> into offline state.
>>>>>>
>>>>>> Fix it by replacing page_mapcount() with total_mapcount(). With this,
>>>>>> the transparent huge page can be isolated and migrated, and the memory
>>>>>> block can be put into offline state.
>>>>>>
>>>>>> Fixes: 3917c80280c9 ("thp: change CoW semantics for anon-THP")
>>>>>> Cc: stable@vger.kernel.org   # v5.8+
>>>>>> Reported-by: Zhenyu Zhang <zhenyzha@redhat.com>
>>>>>> Suggested-by: David Hildenbrand <david@redhat.com>
>>>>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>>>> Interesting, good catch, looked right to me: except for the Fixes
>>>>> line
>>>>> and mention of v5.8.  That CoW change may have added a case which easily
>>>>> demonstrates the problem, but it would have been the wrong test on a THP
>>>>> for long before then - but only in v5.7 were compound pages allowed
>>>>> through at all to reach that test, so I think it should be
>>>>> Fixes: 1da2f328fa64 ("mm,thp,compaction,cma: allow THP migration for
>>>>> CMA allocations")
>>>>> Cc: stable@vger.kernel.org   # v5.7+
>>>>> Oh, no, stop: this is not so easy, even in the latest tree.
>>>>> Because at the time of that "admittedly racy check", we have no hold
>>>>> at all on the page in question: and if it's PageLRU or PageCompound
>>>>> at one instant, it may be different the next instant.  Which leaves it
>>>>> vulnerable to whatever BUG_ON()s there may be in the total_mapcount()
>>>>> path - needs research.  *Perhaps* there are no more BUG_ON()s in the
>>>>> total_mapcount() path than in the existing page_mapcount() path.
>>>>> I suspect that for this to be safe (before your patch and more so
>>>>> after),
>>>>> it will be necessary to shift the "admittedly racy check" down after the
>>>>> get_page_unless_zero() (and check the sequence of operations when a
>>>>> compound page is initialized).
>>>>
>>>> Grabbing a reference first sounds like the right approach to me.
>>>
>>> I think you're right. Without a page reference I don't think it is even
>>> safe to look at struct page, at least not without synchronisation
>>> against memory hot unplug which could remove the struct page. From a
>>> quick glance I didn't see anything here that obviously did that though.
>> Memory hotplug is the offending party here.  It has to make sure
>> that
>> everything else is definitely quiescent before removing the struct pages.
>> Otherwise you can't even try_get a refcount.

Sure, I might be missing something but how can memory hotplug possibly
synchronise against some process (eg. try_to_compact_pages) doing
try_get(pfn_to_page(random_pfn)) without that process either informing
memory hotplug that it needs pages to remain valid long enough to get a
reference or detecting that memory hotplug is in the process of
offlining pages?

> At least alloc_contig_range() and memory offlining are mutually
> exclusive due to MIGRATE_ISOLTAE. I recall that ordinary memory
> compaction similarly deals with isolated pageblocks (or some other
> mechanism I forgot) to not race with memory offlining. Wouldn't worry
> about that for now.

Sorry, agree - to be clear this discussion isn't relevant for this patch
but reviewing it got me thinking about how this works. I still don't see
how alloc_contig_range() is totally safe against memory offlining
though. From what I can see we have the following call path to set
MIGRATE_ISOLATE:

alloc_contig_range(pfn) -> start_isolate_page_range(pfn) ->
isolate_single_pageblock(pfn) -> page_zone(pfn_to_page(pfn))

There's nothing in that call stack that prevent offlining of the page,
hence the struct page may be freed by this point. Am I missing something
else here?

try_to_compact_pages() has a similar issue which is what I noticed
reviewing this patch:

try_to_compact_pages() -> compact_zone_order() -> compact_zone() ->
isolate_migratepages() -> isolate_migratepages_block() ->
PageHuge(pfn_to_page(pfn))

Again I couldn't see anything in that path that would hold the page
stable long enough to safely perform the pfn_to_page() and get a
reference. And after a bit of fiddling I was able to trigger the below
oops running the compaction_test selftest whilst offlining memory so I
don't think it is safe:

Entering kdb (current=0xffff8882452fb6c0, pid 5646) on processor 1 Oops: (null)
due to oops @ 0xffffffff81af6486
CPU: 1 PID: 5646 Comm: compaction_test Not tainted 6.0.0-01424-gf3ec7e734795 #110
Hardware name: Gigabyte Technology Co., Ltd. B150M-D3H/B150M-D3H-CF, BIOS F24 04/11/2018
RIP: 0010:PageHuge+0xa6/0x180
Code: 00 0f 85 d0 00 00 00 48 8b 43 08 a8 01 0f 85 97 00 00 00 66 90 48 b8 00 00 00 00 00 fc ff df 48 8d 7b 50 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 02 7e 7f 31 c0 80 7b 50 02 0f 94 c0 5b 41 5c
RSP: 0000:ffffc9001252efa8 EFLAGS: 00010207
RAX: dffffc0000000000 RBX: fffffffffffffffe RCX: ffffffff81af63f9
RDX: 0000000000000009 RSI: 0000000000000008 RDI: 000000000000004e
RBP: ffffc9001252efb8 R08: 0000000000000000 R09: ffffea000f690007
R10: fffff94001ed2000 R11: 0000000000000001 R12: ffffea000f690008
R13: 0000000000000ab3 R14: ffffea000f690000 R15: 00000000003da400
FS:  00007f83e08b7740(0000) GS:ffff88823bc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb6e1cbb3e0 CR3: 0000000344044003 CR4: 00000000003706e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 isolate_migratepages_block+0x43c/0x3dc0
 ? reclaim_throttle+0x7a0/0x7a0
 ? __reset_isolation_suitable+0x350/0x350
 compact_zone+0xb73/0x31f0
 ? compaction_suitable+0x1e0/0x1e0
 compact_zone_order+0x127/0x240
 ? compact_zone+0x31f0/0x31f0
 ? __this_cpu_preempt_check+0x13/0x20
 ? cpuusage_write+0x380/0x380
 ? __kasan_check_read+0x11/0x20
 try_to_compact_pages+0x23b/0x770
 ? psi_task_change+0x201/0x300
 __alloc_pages_direct_compact+0x15d/0x650
 ? get_page_from_freelist+0x3fa0/0x3fa0
 ? psi_task_change+0x201/0x300
 ? _raw_spin_unlock+0x19/0x40
 __alloc_pages_slowpath.constprop.0+0x9e1/0x2260
 ? warn_alloc+0x1a0/0x1a0
 ? __zone_watermark_ok+0x430/0x430
 ? prepare_alloc_pages+0x40b/0x620
 __alloc_pages+0x42f/0x540
 ? __alloc_pages_slowpath.constprop.0+0x2260/0x2260
 alloc_buddy_huge_page.isra.0+0x7c/0x130
 alloc_fresh_huge_page+0x1f1/0x4e0
 alloc_pool_huge_page+0xab/0x2d0
 __nr_hugepages_store_common+0x37a/0xed0
 ? return_unused_surplus_pages+0x330/0x330
 ? __kasan_check_write+0x14/0x20
 ? _raw_spin_lock_irqsave+0x99/0x100
 ? proc_doulongvec_minmax+0x54/0x80
 hugetlb_sysctl_handler_common+0x247/0x320
 ? nr_hugepages_store+0xf0/0xf0
 ? alloc_huge_page+0xbf0/0xbf0
 hugetlb_sysctl_handler+0x20/0x30
 proc_sys_call_handler+0x451/0x650
 ? unregister_sysctl_table+0x1c0/0x1c0
 ? apparmor_file_permission+0x124/0x280
 ? security_file_permission+0x72/0x90
 proc_sys_write+0x13/0x20
 vfs_write+0x7ca/0xd80
 ? kernel_write+0x4d0/0x4d0
 ? do_sys_openat2+0x114/0x450
 ? __kasan_check_write+0x14/0x20
 ? down_write+0xb4/0x130
 ksys_write+0x116/0x220
 ? __kasan_check_write+0x14/0x20
 ? __ia32_sys_read+0xb0/0xb0
 ? debug_smp_processor_id+0x17/0x20
 ? fpregs_assert_state_consistent+0x52/0xc0
 __x64_sys_write+0x73/0xb0
 ? syscall_exit_to_user_mode+0x26/0x50
 do_syscall_64+0x38/0x90
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f83e09b2190
Code: 40 00 48 8b 15 71 9c 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d 51 24 0e 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
RSP: 002b:00007ffe4c08e478 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007ffe4c08e648 RCX: 00007f83e09b2190
RDX: 0000000000000006 RSI: 000055d7575611f8 RDI: 0000000000000003
RBP: 00007ffe4c08e4c0 R08: 00007f83e0a8cc60 R09: 0000000000000000
R10: 00007f83e08d40b8 R11: 0000000000000202 R12: 0000000000000000
R13: 00007ffe4c08e658 R14: 000055d757562df0 R15: 00007f83e0adc020
 </TASK>

