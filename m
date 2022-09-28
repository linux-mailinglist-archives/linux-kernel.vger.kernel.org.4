Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9F15ED332
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 04:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbiI1C5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 22:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiI1C5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 22:57:36 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9775A1C6A61
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 19:57:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TE4MvG6SSkA/2tB8UU+sPotiK2BB4vLtFTp5oGkcK6CV4O2tfl7wshzvj6x223uiMkbnQ3ZtrbCri+Z6debRfwhSRsD686/JMAKq+poXQceVQpH8lAVHlBKDQwm2H5gIr5CUy4r/NSgYS8lBBe50yOa1SWyxnTp3qNKNCO9P1FySPY2FgbBO8W9NzfQPbuT5K1o8TkdxbAp4TcAGFvXlv92+CuATKU2Lf/VoP9fmykIHEehAp84Upad374WzcRBAUpt5N03h1g+ajF826wc9pSTe5HmUzaS/zlot3F535IYCGmHUQ+mcJEEF1Iz4iYmTdh5hl3GkznbOS+q0xGn3CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVzVvj/VlHTJpS1BeB2KyhVMCWKW12jFCsCGHdyqW8Q=;
 b=XTq1xFMaCirdC7AzmXHm2rYa0rZ83+casZ77todtploSMcInW2yxPaP5HKV28WcD2/bv5zWymEe5eUrSpV8OizjOF77xeXKPxK9ladeOgwPI+O6YnoZ5YLke27eBB2LSdoymYjm9SVNneb1Of2FTvUy+4Iyrwj+2AlG8eA5zHrXHMfYaubfyycni0awn/6T+BdGMihZNzQ03MFYgeIke5Gec8Y2iOxDXGwQVv1ksjBzrEGYipuv3pEee4jfw8WES2IxmAe3IBB95J2/DpaONxrLRIG/qbgMT8OCXl550FnRMrmcD7UivQa0P+VBslhjL4I2/t7bPFprM5md13xKKPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVzVvj/VlHTJpS1BeB2KyhVMCWKW12jFCsCGHdyqW8Q=;
 b=YFVRFpKLN64rOLosUqE0iEq5Ie9/pOyxgNGxRMXAHkSxxwlOf6phiDocp3sfp9W/4kEtbGn3zCi4940my8bbzhKoIDjLgqKX8MXMfLUyPhameb0jK1r92aIDgq1/ApsiN/MhxqOWkZAHDTzPrYccx0xk46SHsOQNAtjd5y7yGkAbtp7QjunGAxpZNGvKMaIoSVsT/VVIRAjEabWngbqRuR1PSImrbOEydxBcn+DflJdlotnvggdqtCwWd4TR5mSIi6jS15uCoEaY/AfdgHOHOox1xrGxIh+txNN3PNywo8yJ6FwVpWSN6En8wzENi4pb0DwneJnxXbEUiPewbJ6ctQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by IA1PR12MB7760.namprd12.prod.outlook.com (2603:10b6:208:422::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Wed, 28 Sep
 2022 02:57:32 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::51d9:c02b:e5a1:254b]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::51d9:c02b:e5a1:254b%5]) with mapi id 15.20.5676.017; Wed, 28 Sep 2022
 02:57:32 +0000
Message-ID: <9d72f2ed-9a92-e67b-3af5-79050004a1a4@nvidia.com>
Date:   Tue, 27 Sep 2022 19:57:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC 2/6] mm/migrate_pages: split unmap_and_move() to _unmap()
 and _move()
Content-Language: en-US
To:     Yang Shi <shy828301@gmail.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>
References: <20220921060616.73086-1-ying.huang@intel.com>
 <20220921060616.73086-3-ying.huang@intel.com>
 <87o7v2lbn4.fsf@nvdebian.thelocal>
 <CAHbLzkpPNbggD+AaT7wFQXkKqCS2cXnq=Xv3m4WuHLMBWGTmpQ@mail.gmail.com>
 <87fsgdllmb.fsf@nvdebian.thelocal>
 <87ill937qe.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <46807002-c42c-1232-0938-5b48050171ee@nvidia.com>
 <CAHbLzkqRyav0fZ5gzaKbkTfGBxkQXTpu0NJz-A9j7UaHhVBxEQ@mail.gmail.com>
 <87pmfgjnpj.fsf@nvdebian.thelocal>
 <87czbg2s3b.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <240bbb01-1f26-71ee-233a-ad65313ac358@nvidia.com>
 <CAHbLzkpnCTD_c60QPu25hPymCYwLP6fYRMxp1EWmzX0SBF4g1w@mail.gmail.com>
 <4a44bf59-a984-8ac4-c613-a03d74dc6a5a@nvidia.com>
 <CAHbLzkoEDUauo-H=zYvnDTC8TX4uezPxA4nV=QVQK_qxyZ3wjQ@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CAHbLzkoEDUauo-H=zYvnDTC8TX4uezPxA4nV=QVQK_qxyZ3wjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0053.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::28) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|IA1PR12MB7760:EE_
X-MS-Office365-Filtering-Correlation-Id: 021efb63-1d2d-4bf4-7337-08daa0fd2fca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z4IJDsGv5fBXV2tS99VI2VLJnl2v7X9vFVq6mNwsQZ8PMer3+4kEdT1OeIneKgvj7QOu9wFvBMnSH5ZOj2khOyzHURzZLXCB7CfupE2UDPMXtFPvmwSRK+/yfz4XM4Xy5iwuIG5v0Pl/6W0PzlGbCsEuxQSfR7RnTuvtimYxNj/DTD4I8sSRHizP/uq1Q1KsvSSN74SFLKJBELFVOwsOYMdwsQDD+uFGqOBYmrXacPlD0XZBS/D0UL08VCULjmdDQc992T/6MKTems4aA68G7oLqS+/6Bc6ExG6mF0tNtSeXt8XTwWtFyrabt9yFVu+p7o4oFgk5zleDTgc46lbszN9BEhrCxUfXEPrH1tZia9hKhdFL4x6Hnunmw79+ZIUPxqM6RPj39PqbTh0+o42WQ1auH6N3DUOHj8bRhs9dQujnDD7h4vR86OeJwbheNldhdqKXx39Q4Fu9GSk43qEM3DVN8Q18e21Z3N3RYSlfVqb5Zp4Xe2ZI3RPGsxlF15YOXJdtXGG44JYfiaPLrAuk7G/1hSilTCG0SOmQEhCrEs+eU21L/OUO4BeXtXa5kI4yQzrPosXBo8en5QsMUS9Eoed/qduKnQcB3csEDzOBsQYo2rK/UkSo4KAgQwVt16Rt0q9Als7rASSPw/ghCeVONpxgHk/NG16sRS047/CFge6OhqmCnx/XN1r4d1nw/oaYIlj1Le2Zv6ELpw/i4SqCSxMCQ/NLmnJD9wz8aipIhMX2QM1Op9o2dEJPCg9hdMNO5qnmoe5B3V3c87fhg1dAcqit+lFYmlk1fZ8cK4DKAGo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199015)(478600001)(6486002)(36756003)(31686004)(6916009)(186003)(2616005)(31696002)(5660300002)(38100700002)(86362001)(41300700001)(66556008)(6506007)(6512007)(6666004)(54906003)(26005)(316002)(53546011)(66946007)(66476007)(4326008)(2906002)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGdQNUVHT2FPclZIUGxlUEkxSWhsWnVTOGU3ZGR6T21Xd3ljTWVQbXVjdVJU?=
 =?utf-8?B?MUlSWW1GdG5meGNTcms1Um9nUW1jWXF5QUdVWGFKZHp1cHQrekNKVEttQUtW?=
 =?utf-8?B?S1dXZllCZmNKck9udEUwVnVIZHlxWmFvRnFJb1ZmSmJNTW4vNENoamcrdTU3?=
 =?utf-8?B?cklxVWlIbnhXMHVBczNPd0N0Nmw0RklJUHJHRVIrNHp0aWJSTHp5YzZueFY5?=
 =?utf-8?B?Y24vM2kwTDhPQWRnOFBuV1R3RjhSMnhoeGhjWHRFWlBYRDhDc1gyeEFsWXpl?=
 =?utf-8?B?QmY2TXMwc2YwNTZUVEo4Q1ZJMS95Mm5sK3RYWXlFK3hwdDdlWmpxVkQ5NWVD?=
 =?utf-8?B?OU9INEJCOXZ1enZyNlBQZm1wTE9uTUVvWUZhTWo2VHJMZzEwWTVSZFhLM1Z0?=
 =?utf-8?B?UWhta2dXNExUTlhtMlFDUE8xb0t5MWgzd1c1NFlwZXlGbnpYZlVLZlE0NjIr?=
 =?utf-8?B?enF6RVcrTk1kM0JhMEx2NU9sRXFxRTNkM25tS2V6ZkNtSEVzZXcyQzdoSEFJ?=
 =?utf-8?B?SUpMeUFpYU15TWFuYnhpVjBNM1cwZC9UZHBhTlg5MzI5eEd1NlUvQWhZc3Fw?=
 =?utf-8?B?M2hnY2FWOE5GUTExOU5zSEVpS2xKNmg2bHhKNXZzT2NyK0YzNEpZRnlZM1hI?=
 =?utf-8?B?OFZidzF5Y3Vpam43bFlUUEpjbE1kMUFTT0RsbDBhYldmeUtSOElGN1Bsdjlz?=
 =?utf-8?B?eGJrbkRkMUczejBGSkxnai82NHZ4SHZwbGsvbU1oVEdlQ2EvUGFINGthTkUv?=
 =?utf-8?B?VkNwZ1dDUVZQR2l4d1JpUituVy9TWXB1alh5aUxieXdSUW1tQjFFRkh4KzRn?=
 =?utf-8?B?dTc4LzFZZGd0UnNnY2hoWnlGRXN4dVpKeXdSdVZWc2NhSSs2Vm5wZm1pZUdm?=
 =?utf-8?B?eWtNcW5hMHcreUREQjZxTVZGano5TmVKZ0RxWk9LYkJ2NmtVTXY5ektibEUz?=
 =?utf-8?B?KzlHYmpsS0ZzS29tdUNsTnBQUWVVU01SSHAvak5BaE5EUmdJZ0w4RW03WkEz?=
 =?utf-8?B?M3lZUGhiVEU4RmVkNVRQNVJVSUp3dDRURUpJcGxONkJiMVBETEtPQUVINktX?=
 =?utf-8?B?aThPa2xRZW4vTXdQcGR0Nkk2ckJmOHJzM2ZJM2dRUC80OTVQYWtRUTFmaXBJ?=
 =?utf-8?B?VjBDUG11RTVOQklFeFFPUTRrbzMzZ3RtRGlsc2x1dXlaYXNQTnBFeWtvcWV6?=
 =?utf-8?B?ZEVWbDg2ZHAvcHo2amd4Ri81eUNNMVU5aTh2WDNTOUJFbWlkS0I3VjV6TzV4?=
 =?utf-8?B?UDNJZENxU1F4c0V1eG1VWk9PZVFiQkVnTVBCK1p0V3hSWllIcXNKMzNnTy9K?=
 =?utf-8?B?N0hFVVE1RFdkVFVTbmhkOGdCc3lhTXpMYWNOcjVQUFBtd2ZNT3Yra0pjeFp3?=
 =?utf-8?B?RE00Mmp2V1BLcGtnbkp3VHRQeXQwZjljdHBRZnlpaXBvMDlGWnNCRzJhTjIv?=
 =?utf-8?B?VFFCc2pnRU1lVFhRYjlaQWNZTWRtSUs5NUpVd08rV3lmUXhra3dIaXp2dHRp?=
 =?utf-8?B?dGhSQUVzY1ZZb2NLT0s3WlJLK0MrcEpWUTU1VWxUOHYrY0xxWjVscE1mN1ZR?=
 =?utf-8?B?enMydWxZYXQrNlpMZDZoNHhrY1JpY254VEFLQ0VyUGl4eHoxTHJ0VGxYSHl3?=
 =?utf-8?B?M1FMMnk2RUcyTXFpMWhxbUxzdGdVa08yNGovMmFhcDlkTXFJWWdGQTFkNldu?=
 =?utf-8?B?V3VwYm1LS1owbTRYaW5abDRiRkNUTGFyWjdZYUpKamJKQ0FWOTRmS01FRTU3?=
 =?utf-8?B?eTdhek5id3IxOVI3TWQrUkdzY0doNytLZHg5eWVERk5GYUR5M1FqU3VuUjd6?=
 =?utf-8?B?aGVWMFYwcEhhQzFMWXduS1A2NFJac1gvYmJpTVQ5U3FOa0hxODg5ZzNqckc0?=
 =?utf-8?B?SzZGZUQwajVRQy90NGJaNFA2azNTNFZXSE1DOWt0SGE0WnBwVUhrWHhzNUFw?=
 =?utf-8?B?MGdraWFYNUdSYlM0TjljQWZzZ2Raekw2M2lEQ1M3QlF6S0htKzkxUzFQMzIr?=
 =?utf-8?B?eWtzYW1EMFhsQ2Z4NmZPbFRGZ0JpYjdoNUUzYk1YNDZOeUhlcXJ2QnFrZCtH?=
 =?utf-8?B?bTdZaTlkZWNCWXA0ODlhTzZBcW5OTWN4R1duYWhONEJhQ1Y3Ynpxbms3V3g2?=
 =?utf-8?Q?39o8UMSwn/+0hZbjbPT99sekC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 021efb63-1d2d-4bf4-7337-08daa0fd2fca
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 02:57:31.9375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AiaFkVPerqGQVVWS2qYaYroo9H10GmzXWswv3IDF423D7qmV4BVm8ZujACyPUR5vIZXlUaabYLEG24BWgl1uFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7760
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/22 19:14, Yang Shi wrote:
> IIRC, the writeback may not call generic_writepages. On my ext4
> filesystem, the writeback call stack looks like:
> 
> @[
>     ext4_writepages+1
>     do_writepages+191
>     __writeback_single_inode+65
>     writeback_sb_inodes+477
>     __writeback_inodes_wb+76
>     wb_writeback+457
>     wb_workfn+680
>     process_one_work+485
>     worker_thread+80
>     kthread+231
>     ret_from_fork+34
> ]: 2
> 

Sure, that's fine for ext4, in that particular case, but

a) not all filesystems have .writepages hooked up. That's why
do_writepages() checks for .writepages(), and falls back to
.writepage():

	if (mapping->a_ops->writepages)
		ret = mapping->a_ops->writepages(mapping, wbc);
	else
		ret = generic_writepages(mapping, wbc);

, and

b) there are also a lot of places and ways to invoke writebacks. There
are periodic writebacks, and there are data integrity (WB_SYNC_ALL)
writebacks, and other places where a page needs to be cleaned--so, a lot
of call sites. Some of which will land on a .writepage() sometimes, even
now.

For just one example, I see migrate.c's writeout() function directly
calling writepage():

	rc = mapping->a_ops->writepage(&folio->page, &wbc);


thanks,

-- 
John Hubbard
NVIDIA

