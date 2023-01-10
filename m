Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A6A6636F2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 02:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjAJBwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 20:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjAJBv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 20:51:58 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2082.outbound.protection.outlook.com [40.107.102.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF381838E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 17:51:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AH6Qr3JSyHvwjc94fnhrl3xBWsDGzNqsNM70Z+5DmPalOFuGtL1bMO7LXMzYW7g8vujjD0NdEqA6OP85hfv/lorVCgZxNknf2SIt1+R1xQ/u0GKj8I20BDmT5O9uIzVYMEmBipt48ZKHAHGeOqk4pGeezPPlyQlPPh77Xyrb6rMdcTe49RhUljpHdKQ7FojAZLuvASMUSt9je1jo14bUrwjZTrJPcvuxXHtR79GQMkdFCPIHKWT6iawvlPZO0J+KKTA2Hit4nt0wYrtWtWQO+h2Dl4X/MEqxtkGeG8qadY0tuAcUsnQTOK896bvaHNshL0Fzbfj6InstPAUa/tSSeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3Ysvb9stt4gbc01S6jPYB5ZQIMty4gS0nIDt78Sl8I=;
 b=FukFWQ09Yan73EvGbpqbsDVEPVRMCqtcLhtm91WfRq6GoO7GlXXVcySP9XU5Z9UUX8m3tIknOA9r/TLNvEWgEQM+b6EtE3TGx0DfMGShAUDTl2ynz1gdcGhO7uw7ckx+8/9y4//yqz9GZjaLAlh8VcBd9qAZ4FpKmoxxPP/osfG7+63OgF/h0u/hhDy2QX94ZXO4OomvqhSk5Xwm6xjQ8eoyg+g6xnSmpnpIw1v6k3LclwjqvAKB7JihpB51smqi3plJWR7hnNom4qO01sMLYrh8mBUBoGG+oXIyLI0WkGGZHxY64EjZQl8iMM/6oEGvGKHHNhZ4EzArzY4uZGL/Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3Ysvb9stt4gbc01S6jPYB5ZQIMty4gS0nIDt78Sl8I=;
 b=Q9lreOywQmW49cowzMhNWQRkvRvHrgAZUWWtHX3J3LJdkgSn7khc/AzaH7Ekd6DjKK6oH5jhh+G8ie7fVls5VIIQADqjjx2+9lNmKL3nM/R9zou+IAD/3Rx0y+4PiVGMK8Nh2Am0nxA9c3HPZbTl2mZwik1sNXN+B6VnWPxtC0Tdo4H9XPnQ3fmjDZZn9sYLhEPwmsgwy+RdRip8/zvWJMsoevwcqKjBoHjp7NxtRMOtPs8Un+zXqk9ucBlDhyksPTMeWpyZUnAgK0f07BfDRG3zWp8e2f42Z5HlD1Yia7WSZcgb2C5swLWa30Kb1Z3YsFOfPUIQMfB+5rHE0Sc9NQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by SJ0PR12MB7475.namprd12.prod.outlook.com (2603:10b6:a03:48d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 01:51:52 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::ecfb:a3ad:3efa:9df8]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::ecfb:a3ad:3efa:9df8%3]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 01:51:51 +0000
References: <20221227002859.27740-1-ying.huang@intel.com>
 <20221227002859.27740-3-ying.huang@intel.com> <87pmbttxmj.fsf@nvidia.com>
 <87pmbtedfp.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <877cy1scg5.fsf@nvidia.com>
 <87k021bfpj.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <87y1qhqv5k.fsf@nvidia.com>
 <87fsck5fzc.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Bharata B Rao <bharata@amd.com>,
        haoxin <xhao@linux.alibaba.com>
Subject: Re: [PATCH 2/8] migrate_pages: separate hugetlb folios migration
Date:   Tue, 10 Jan 2023 12:37:51 +1100
In-reply-to: <87fsck5fzc.fsf@yhuang6-desk2.ccr.corp.intel.com>
Message-ID: <87cz7nnolt.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SY3PR01CA0091.ausprd01.prod.outlook.com
 (2603:10c6:0:19::24) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|SJ0PR12MB7475:EE_
X-MS-Office365-Filtering-Correlation-Id: 06254226-611b-4d50-9c99-08daf2ad3e6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J/poW//etzuxbqeC8nTfsjFoOsljqlQmNNvVKItQsM4X83AZ1mEaUjyvHB1Ct/cqKouKOxLsoZwCYsMLmvTvqE6rpfYa34HgO/Y6k4TTr7yGEpVUHUf2ImfEoN88sjZdbvJd9l0XH7Z92DKrZS+PpcJdGyf93F2nlqM8BRvlX16phpWtdgsj12isVOBu+wNXghGzQNiloF4BpiA7Z4z8fKu5PNmzsa4L8Jd/8hjcVeFjG3SRIBrvA5sqFsXYFWIalobvfMrjy/wKG1JR1smMBYgoZxHc1mLGL8YyUJbDA1NjPOetHNW2/lNRat93kq66MBt8WVUdxS7gAItNXqhc5fAcBihAuHApQcVOETplFn4mhinCLFYtTg0saJJdUgC4NcGq2jHOJzvtyl5ALTcYxqCjhcggSjM05gHzYyHx202ypiDAWclSziwG20H7P6hcSDSAEDAkWRzIJjOFQDvGjiPV7iixt9pHZhpE+FF8toH5QfARYL3LuULvA7OAKs83Zt10Y3CT9FeM+XtrBkLh+p/fleKSYRGgoV0Ui/LVVFq6I8aJXnFnK6d0ymvFukop/H6iGxoNRgPOZXi6fsSyb8Uj/WhF8t7lUrP4wjVj7cmBrY3c7QwMq6aF4okTysoCEbZVYEBRYoTaiSUcU8676A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(376002)(39860400002)(346002)(396003)(451199015)(2906002)(2616005)(38100700002)(86362001)(7416002)(5660300002)(6512007)(36756003)(8936002)(186003)(26005)(41300700001)(54906003)(316002)(478600001)(6486002)(6506007)(66556008)(4326008)(66476007)(6916009)(8676002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X3nPVnZMPXSopvgFAk/v1e/pXg2zSsGzQP3JwnqyyoLhrIeL3OoZXhvcwBld?=
 =?us-ascii?Q?ovrjip0wSUyWHarWnWw9BEC3F7WDyb6ag2b4I5+luYrEUoYu00ZIfdC3gIzk?=
 =?us-ascii?Q?H9/9mIlENHupUjZOabdDT/05Yq/xNHUPTKuwDmtENwLpB1wHafUrNe7Bpvce?=
 =?us-ascii?Q?swoTwJ522lWNZod0WLLKBCh+ZbyphM9C9bznClV82Taq+Waei9pLRfU3uGjL?=
 =?us-ascii?Q?PwzzbQgC/gHa9LO77XczGT2Ha6drlIY4iZ5ICgY3qaQFA1I10vYpEIFSU/rG?=
 =?us-ascii?Q?NppKklbw6yH8KlecqkJlmsRLKQdhuwAfQX5c6lOBFmBNSN7mvChwXLfIZu4f?=
 =?us-ascii?Q?9RS+HG4l6BChiOYbTmTTIZNhtZLvoN+8oG1HJ60cwbmSh13ZsZkM5MK9nrwH?=
 =?us-ascii?Q?SakdPWTn3k/EfNw/wSniYL3+hrncn3YN/v+hS6BhK94+OQk6xDVn9wOB4sA4?=
 =?us-ascii?Q?NhM0Xn7A33MnvOGMnxzt44/m7HpS58jUPsWGudcREfDsC1ftKNu/6PLuY9t4?=
 =?us-ascii?Q?1J8kDRJR3NGHUxJpAyif3dBwGwu9RtcjFpMl+zUrA0XnUW42jG5wOjVMR6zr?=
 =?us-ascii?Q?V+hBO52DcueGFk4bBYnvnK5/WAr00TiiTXAy9HBmTGzt30vV6ycE/f2cKYwb?=
 =?us-ascii?Q?/CBrekf/CTF41rejFEOQoWrTttqaLhUAaDCzwnNCSTv14+/k1VrvW9ckFtLV?=
 =?us-ascii?Q?INH85wstuq5TlwncuX7QxGCraxoETnHQ3BJM/dE5WTh3QAIml+78nNlThduN?=
 =?us-ascii?Q?iuPHCpMhuYb0LjVr+bje+gEZUkgG37USanFsSnPLOaPoKgeYsVuRNZcwZ3JT?=
 =?us-ascii?Q?1nEelgRP1XHP6oM3Z09cE+jGOJNeVOs2TrJBsoyMhrBD1KbNQBN2wZMSJfW9?=
 =?us-ascii?Q?d0cGYN/+q6TXNAdOGbpQxEVXItcnmwYAYkxW7yWo84yJkPu+RrfCKKMHEjC8?=
 =?us-ascii?Q?c7uHGZbUvyiHmB9qXadgDurg5QC+TOEqxO04DNLQh8rF3zsATjF/TVSdpmcZ?=
 =?us-ascii?Q?6C4yPP7ub0l0jVBr/J7qYI4G9tSgBAGCtP2LoTsu6LRlklFbyGlkhCjyoGSb?=
 =?us-ascii?Q?yDV765BGpPIRb8x/FzljzUEGScJDIeHuRK15ANRBPew1Xx/wRUBqDQdpODuT?=
 =?us-ascii?Q?YTWn5f89MkQd/9hnXsfr7bKRcw7sY4wKCDzTIhQKSP+O1ul8Led5fxNu0dm0?=
 =?us-ascii?Q?B5lFo1wenHZLCMVF2iXk+gdDNuKe1zJgBhawZZSEQzd/ov0JpvaTqf+JR7Eh?=
 =?us-ascii?Q?LEiEVH08YEv4fTuNBoD0Rbf0jj9HVhxTW9slNh1sIKY/ulBuiboCHRTK4rGJ?=
 =?us-ascii?Q?j/5PP6KJIzlSmLFX7mWOWkeoFmxtgc1iYWj62hNzAHnb6p6DkEm4xRhsSyD1?=
 =?us-ascii?Q?Q2fgON1RysqmtBfZE85RChqJ7FWgwaqeimeyucAH66N7O+k5FNcElaBaFTVm?=
 =?us-ascii?Q?rpotxM2GlcypvzSeh8gTqujkSZWtPSs0c7xE5sx7OZNJOcjX9ifLeHOelqGt?=
 =?us-ascii?Q?2+87q5x9Asi0RVlyuKEUDsov1zKmE4CxzKyqCzh45WN2OEbhSDFvdUwX9vFy?=
 =?us-ascii?Q?h71Qz4VEM/jgLpgFjwVrxg22oZb+fwrEs/mgXIRV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06254226-611b-4d50-9c99-08daf2ad3e6e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 01:51:51.7984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hsb4RTWicrzija7sBQrAI5Gfj3wr1DeS8CHzn4QWXCAReAAY7PTsDamgZ9W5OJtVOm+M9YULGiFji1pmsKmO8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7475
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


"Huang, Ying" <ying.huang@intel.com> writes:

> Alistair Popple <apopple@nvidia.com> writes:
>
>> "Huang, Ying" <ying.huang@intel.com> writes:
>>
>>> [snip]
>>>
>>>>
>>>>>>> @@ -1462,30 +1549,28 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>>>>>>  		nr_retry_pages = 0;
>>>>>>>  
>>>>>>>  		list_for_each_entry_safe(folio, folio2, from, lru) {
>>>>>>> +			if (folio_test_hugetlb(folio)) {
>>>>>>
>>>>>> How do we hit this case? Shouldn't migrate_hugetlbs() have already moved
>>>>>> any hugetlb folios off the from list?
>>>>>
>>>>> Retried hugetlb folios will be kept in from list.
>>>>
>>>> Couldn't migrate_hugetlbs() remove the failing retried pages from the
>>>> list on the final pass? That seems cleaner to me.
>>>
>>> To do that, we need to go through the folio list again to remove all
>>> hugetlb pages.  It could be time-consuming in some cases.  So I think
>>> that it's better to keep this.
>>
>> Why? Couldn't we test pass == 9 and remove it from the list if it fails
>> the final retry in migrate_hugetlbs()? In any case if it's on the list
>> due to failed retries we have already passed over it 10 times, so the
>> extra loop hardly seems like a problem.
>
> Yes.  That's possible.  But "test pass == 9" looks more tricky than the
> current code.
>
> Feel free to change the code as you suggested on top this series.  If no
> others object, I'm OK with that.  OK?

Sure. Part of my problem when reviewing this series is that everytime I
look at migrate_pages(), and in particular the number of conditionals
that are sufficiently non-obvious to require extensive comments, I can't
help but think it all needs some refactoring before making it any more
complicated. However perhaps I am alone in that.

Either way this kind of refactoring has been on my TODO list for a while
- I have a WIP series to converge some of the migrate_device.c code
which I will need to rebase on this anyway so as you suggest I could
make a lot of my suggested changes on top of this series.

Regards,

Alistair

> Best Regards,
> Huang, Ying
>
>>>
>>>>>>> +				list_move_tail(&folio->lru, &ret_folios);
>>>>>>> +				continue;
>>>>>>> +			}
>>>>>>> +
>>>>>>>  			/*
>>>>>>>  			 * Large folio statistics is based on the source large
>>>>>>>  			 * folio. Capture required information that might get
>>>>>>>  			 * lost during migration.
>>>>>>>  			 */
>>>>>>> -			is_large = folio_test_large(folio) && !folio_test_hugetlb(folio);
>>>>>>> +			is_large = folio_test_large(folio);
>>>>>>>  			is_thp = is_large && folio_test_pmd_mappable(folio);
>>>>>>>  			nr_pages = folio_nr_pages(folio);
>>>>>>> +
>>>>>>>  			cond_resched();
>>>>>>>  
>>>>>>> -			if (folio_test_hugetlb(folio))
>>>>>>> -				rc = unmap_and_move_huge_page(get_new_page,
>>>>>>> -						put_new_page, private,
>>>>>>> -						&folio->page, pass > 2, mode,
>>>>>>> -						reason,
>>>>>>> -						&ret_folios);
>>>>>>> -			else
>>>>>>> -				rc = unmap_and_move(get_new_page, put_new_page,
>>>>>>> -						private, folio, pass > 2, mode,
>>>>>>> -						reason, &ret_folios);
>>>>>>> +			rc = unmap_and_move(get_new_page, put_new_page,
>>>>>>> +					    private, folio, pass > 2, mode,
>>>>>>> +					    reason, &ret_folios);
>>>>>>>  			/*
>>>>>>>  			 * The rules are:
>>>>>>> -			 *	Success: non hugetlb folio will be freed, hugetlb
>>>>>>> -			 *		 folio will be put back
>>>>>>> +			 *	Success: folio will be freed
>>>>>>>  			 *	-EAGAIN: stay on the from list
>>>>>>>  			 *	-ENOMEM: stay on the from list
>>>>>>>  			 *	-ENOSYS: stay on the from list
>>>>>>> @@ -1512,7 +1597,6 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>>>>>>  						stats.nr_thp_split += is_thp;
>>>>>>>  						break;
>>>>>>>  					}
>>>>>>> -				/* Hugetlb migration is unsupported */
>>>>>>>  				} else if (!no_split_folio_counting) {
>>>>>>>  					nr_failed++;
>>>>>>>  				}

