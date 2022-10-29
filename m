Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD55612548
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 22:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiJ2Umb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 16:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJ2Um3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 16:42:29 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C3E233BF
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 13:42:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMkWVkXt9Ra0BvlWjNiBo3hO2IwhDDb3bdlPDcO1n0NcWN+QPdAk8acjAl+4FqtDtjuGzdO91N5Ez1f+m9gAHI9Fd/q/pnfiNbXeCpTNUdCXrrY9+0UdIt/ie8vLDVIhRmksfL05tPc7Ffv3xC86T9oa/8vHBr031HBL/2afu1udHbMQaAt1yNPKUSiQNpZHip5z6sZkyiPWKIqs+t2WlUwj6JFxa+L5tVqsTeqB4jd3PddXsRKf6pCEQCU/YPpJSQUW4Aq5akUdx5kq0n0RS3Vdqo0nlxh6m6YUEyeYAxt15v1vpTsJEgsANb7XBbo4yaxoSY+v5Z9+ADpNkqbmBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4tH8YDr8njvlRThPPAapX5SX4a61MNI+p7RjE7uY51Y=;
 b=WvPb6UJao3bI5tKoGKv6c4TFwXcQBTrv9UEVsXFnG+xFSAlgeo2DIi2Xt/RFxAHRsTnHmbtGRaBFPZs/DipJd9tnGGv8DY6It3MdNeXk9p5FXh8NjlccUgS95LrrPsM23Q1SXADCgJGblPcjw+E34EAeBhbP70ws8RTWQjDa++vp6IpixInM4E/FBXnmombFDSzwAwSDKifEG4EQfgixQ/UP0M9PxgJ1FBuGtY+uzLRQf9+wz1SVp/vRLqwpHOaSkzcGy2Lz5UdUToGJTHxcOurkYSmC1zWLC7cRjVpor97CwENcQ5BXNTFPAYPPtHIaqtAMvpkpRXEGVFX6l78rew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4tH8YDr8njvlRThPPAapX5SX4a61MNI+p7RjE7uY51Y=;
 b=ZIgdOO9pfC54Gqx/lzloLiyrQOVbsqoX9ASofqzpCcWDQZfwuDpXixjsPQFD+WK1Dr6F6ZIWbXZISdbTp7ZQpD7SoYvjBUT6iqkZzbabfBdRcdmLW0UqO1Uxiw9KXpC5JfsvBAaAl53uM5AmuSqoJrJpnTmbjMtFoWUIU/FIHS9Y6s++7QOYIogBOPEwDaEeXaU/VSs3Eyw8kU75NjVMosmDxVxscfdKNFimk5ltV4HVAPULLnrUCyalbVkLiK7yLvKaEe1rqpDT93mnTeNgRFIOT6oUw/tyOmtdEUXZ/dbo8qE4DRLmjRY+mh0viYLGdi68jmEB3miiRPKCAdm5bA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by DS7PR12MB5767.namprd12.prod.outlook.com (2603:10b6:8:76::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Sat, 29 Oct
 2022 20:42:26 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::fbce:3eb5:b646:6e3f]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::fbce:3eb5:b646:6e3f%3]) with mapi id 15.20.5769.016; Sat, 29 Oct 2022
 20:42:26 +0000
Message-ID: <96e49bf1-cd00-318b-c5a5-41279e223f27@nvidia.com>
Date:   Sat, 29 Oct 2022 13:42:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 01/13] mm: Update ptep_get_lockless()s comment
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>, X86 ML <x86@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        jroedel@suse.de, ubizjak@gmail.com,
        Alistair Popple <apopple@nvidia.com>
References: <20221022111403.531902164@infradead.org>
 <CAG48ez3VE+3dVdUMK+Pg_942gR+h_TCcSaFxGwCbNfh3W+mfOA@mail.gmail.com>
 <Y1f7YvKuwOl1XEwU@hirez.programming.kicks-ass.net>
 <CAG48ez05gBiB2w7bL_3O_OUoBWazmHnRwMiuni_wQyXBUcaxbQ@mail.gmail.com>
 <Y1oub9MvqwGBlHkq@hirez.programming.kicks-ass.net>
 <CAHk-=wihPdOtXgJ32pLB6Xd-UvnaZW9YvOOjM24JGYRjNHeykA@mail.gmail.com>
 <6C548A9A-3AF3-4EC1-B1E5-47A7FFBEB761@gmail.com>
 <CAHk-=wh8oi0qQtYDFTfm7d1s5C8mG7ig=NfzGWt4zbjXMzcdqQ@mail.gmail.com>
 <F9E42822-DA1D-4192-8410-3BAE42E9E4A9@gmail.com>
 <B88D3073-440A-41C7-95F4-895D3F657EF2@gmail.com>
 <CAHk-=wgzT1QsSCF-zN+eS06WGVTBg4sf=6oTMg95+AEq7QrSCQ@mail.gmail.com>
 <47678198-C502-47E1-B7C8-8A12352CDA95@gmail.com>
 <CAHk-=wjzngbbwHw4nAsqo_RpyOtUDk5G+Wus=O0w0A6goHvBWA@mail.gmail.com>
 <3a57cfc5-5db4-bdc9-1ddf-5305a37ffa62@nvidia.com>
 <CAHk-=wj6EJvTtTeYQvkX3aOw6Q1SRYRV6xJP1+uHNvfAocO1hw@mail.gmail.com>
 <CAHk-=wj2MFUfh0juVEeBkZ6hBjp=X_UC3jR5edmZ08mV5bztyg@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CAHk-=wj2MFUfh0juVEeBkZ6hBjp=X_UC3jR5edmZ08mV5bztyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0038.namprd02.prod.outlook.com
 (2603:10b6:a03:54::15) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|DS7PR12MB5767:EE_
X-MS-Office365-Filtering-Correlation-Id: b6b4e8ef-851a-4a0d-fc3b-08dab9ee169d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TrtH+bSZe4bXrwkPZgOESMYBu/RnoNejm/xR5mQ19qrSw9gtw2+NTrNeYBKpzpmMTbF22gE7BngkFadEmeFqXhrs4hkQuC3YTpTvd2EAqq54uQc2gvhTwiuIN6t8lImLIhTzdwAdaAQkI4Fcakq/Im6aonD2bBrZ28DgZ0wuLXjbDCQUFe+9lU4JoAesubG8B+MT15vlHGOnWxE5OMKILGZNnXOeJUoJX+NAguzJb2EDRowRv1hp4X2nP0iZZXabcGib7eXAY5KVcKMSQGC2tYJTNBko0nIDOwUVPcKiUFD2Au8UxoowiCmWu2EVdk5CSnk4jFDxLNc+P9YhpCV37RvZOLS+XpgkjIAM69VxtcDR37CGadqPFg+CLI4rgwYDpo+X8KI0unI7PiDT48KR6hY9n6jMzmy64PqYBqFbeiYZ5U5ZOMLMt84jry42Oi0oTSZ1OjJZm583Ta/633ARjyLhFGB60VKYgS8gu4G5nbpWC9ge/9NHr8RLV9Ez9DO9bKqDVUzgdLsk5l7q42wkfbOJgPzK3R7rwoQlbaKANGykxaFPvHw3QrjFf+r79taxuiItvobvI/rl8CpTWtOGyS3IJks47ZH+MCVmMlbyhcL8dtUZBZvbZ2/QFcmCRvKcagqWuopnc1uOxC9kRSBwTaQVCaF46kf0+yxd3bR6O+WKY5OXTDjq0OnWv5R63eERDqEgAaIEWUJEUmWLhkmQ+euqL1DNyf2sKh5SDXDDt+NfHacJMA4rQSQ4YJG2tO99tWmA9wg/Er0m5nCj4s38jOC50YGoeRmBB1hE3p1jiOo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(451199015)(6486002)(66899015)(478600001)(54906003)(6666004)(316002)(6916009)(4326008)(6506007)(107886003)(86362001)(31696002)(8676002)(53546011)(66946007)(66476007)(66556008)(2906002)(186003)(26005)(6512007)(41300700001)(5660300002)(2616005)(7416002)(31686004)(36756003)(38100700002)(8936002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlhlV284Q2pZTzNPTmcxSzNWLzkzWDA2eTN5ZTU5TUpqdFBrUXZRQkhNbVlD?=
 =?utf-8?B?bnZzdjl5b3V6WjNNckcrbXpjUXB4MGNXUGNrYU54NDBlaTdUSmt5ZXhwRXVZ?=
 =?utf-8?B?VHlRVVFtNkY4NEl0NDJCcWF0bUxSbVNXVkFnY0xldlJ1T21seTdxMlRHc1d6?=
 =?utf-8?B?YVQwYmRoNlpWR0tHckRzWHRLamZaSU1ibFljcEV4dUVOa21DR1ZPZDhRVmsv?=
 =?utf-8?B?WndRSmlTM2sxOHllZ3JVV2thZ0MvYTVVR0ZGWmEvcVBpMTZBcVd3VFRsUDY5?=
 =?utf-8?B?VC82ME9yUHJOSDB0OHlwOGNMYTRtT3FqOVVKQnRTNGFBakd0UHEraHBJbzlt?=
 =?utf-8?B?MTRrcTFJN205emR5bHpvKytHbG5JQ0ZicHBTM2p1aXBOMDUzdFFBRkVlblBz?=
 =?utf-8?B?eXhqeGIxdFBaaFdiRmJPZE02ZCt0NFpqTEtWclN3OVBGcHpRQVljNEtJUTYz?=
 =?utf-8?B?RmZEVnVDditDRjRyZ05WNmxwN3U5YXZzWDhjeW5BOXdPSWd5QnFrdTN5RHBw?=
 =?utf-8?B?Y21ySExqMDdod3VFNCtjRXpQYkIrZHYrN0FKQ3cyUnE5N1BSVGFSY0h0RmNp?=
 =?utf-8?B?Y0FKRzN6K1dKQ0ZIakVoVk9TSDBJQ2VCZVYvTVZ4KzN5d0lJV1AwVnkrdjZW?=
 =?utf-8?B?S1lmSlFOK2JlV1BFRGVwTE9HZWdrWUFCdXBtNHRxdGNWVk9PL2k0dVBDRkpo?=
 =?utf-8?B?dG1WV0RDZVkvWkZ2OC95TGt0UDVxdFJCa2xoN0JBTVB0RG0yY01BNmFWTXVN?=
 =?utf-8?B?cjRqakdTc2R0MmRvVitZTFhQZnJObnU0V2tyZGpkZWN1Q2ZmOWtmbHJqWXVp?=
 =?utf-8?B?VGV2dGwrN3NGY0pQcTM1WDBaV3RLc010MGpOU1QvZGIybXVUT040Qk9aTDE2?=
 =?utf-8?B?aFVObUE5K3B3dU1qVHdkcVZCb3B6WGFlNlVuL1czdmZZaUtGQ2J2ZVE0NFd1?=
 =?utf-8?B?WU9CNERRMmlZczJQMTZDTUNQMUgxdWg2RUVFYmF2eEtvMlNGZTMwV0M2YWZa?=
 =?utf-8?B?QTNaTXNYUzJSVWIzZFVWNnZDNVk5Nzl0YUlIMXYwWWZGc2I3SGJ2RjhxRGNu?=
 =?utf-8?B?M0tPV1lYcm9FTnBZTDBHVHVjaGU5dFBwMi9OUWt6OHZYcUdUaitMMVcyTXg5?=
 =?utf-8?B?QVBBalRLUU93OFBYejBKeVFrUnhiTU5Hbld2QnFlbTFmY202ZUVWc0dROWM1?=
 =?utf-8?B?TFE0SDRXbVFMWUFBQ012L3o1WENQSGV3Y1R5WlQ1ZHRJTGdDemZnMTQxN2hH?=
 =?utf-8?B?MFFTQmNObWM2TmJDeFdaM3IxVm5FNitOamhRc3pwdmVLTnFJNHVHaXlnQ2dB?=
 =?utf-8?B?VDZPOW1xZUJZRWpPN3pmZld6K2NqOGNSV2NQeDFTd0dHMnpHWk1pSGJOWUlS?=
 =?utf-8?B?Qlo4NGZta1pyWUZuWDgyWmNtd0k2NHM1aDA4UktFU3JPRXV0Wi9Cd2V0NE5j?=
 =?utf-8?B?WE5JenFoQ1crblhxTmsyZGJpU2lZR1ZJRlMzRmRYTjRyZmJUUmY5SWtVSWFt?=
 =?utf-8?B?QWQ2NmF6RVR4akxWRmpCQnk0K081WjlRZ202Sm9wZzBRZTFFcEp0Sk5mRER0?=
 =?utf-8?B?a2FzNEZLTEpZTENlLzFnOGI5TnJoTkVLemF4TmdmZmp6QTlva2dPZTl2N24z?=
 =?utf-8?B?aXYwWFNlUWo4cW9YR3ZSdlVrTklmVFNYVDcyZ0thTFozUGZNaHE2Ym12d1J1?=
 =?utf-8?B?TzJQYnB2cGpXSVVBWmd5SlJhNmxDL3E3UWxJSG8yalQwM0paeDJiTjJGQlhC?=
 =?utf-8?B?S1lncHhPNmZEcnRDVUNFZmgzZGZtVFRpL0RqOWtzVCtaR1phM21UNEkra3Bj?=
 =?utf-8?B?a1J1UmdYczlSSFNBZ3FqeFVRZkhtNnpQeGh1eUV1Umd3Q3RWdnJOZG5qcWNu?=
 =?utf-8?B?aTR0M243b0VxTUFHNmpxSGNseEhWWEJwYVJhZGl1LzErbjY4aW1LT1hwNVFl?=
 =?utf-8?B?RVptVE1CVzJMTXlFTU5JZ0xUN3QvcE9oZEhNVXZiMFJHdFRYMEplZTVmY2oy?=
 =?utf-8?B?OXhuc1VzWlEwT1F0UWZsQTIrczI0MmlUQ0pnUzRmNXZzZW5pdml4WGJPaVR2?=
 =?utf-8?B?dXNFMzJNYVUwYkpCSlNJMzQxWUNyWHFCRS9hUHQ4UXBIVnlpTE1RNFVpNTVi?=
 =?utf-8?Q?LJIjrYKOS+9cJZuzLRyR2jlyL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b4e8ef-851a-4a0d-fc3b-08dab9ee169d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2022 20:42:26.0403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9zRxYtPaUSgecM+6O6vdxBgNgXmC04wNjxUQvKcsRInQApcaHLNeEm7nQPcnOcGj+QBPFBmYxfUwlT2XZseIvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5767
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/22 13:30, Linus Torvalds wrote:
>> I can think of three options:
>>
>>  (a) filesystems just deal with it
>>
>>  (b) we could move the "page_remove_rmap()" into the "flush-and-free" path too
>>
>>  (c) we could actually add a spinlock (hashed on the page?) for this
>>
>> I think (a) is basically our current expectation.
> 
> Side note: anybody doing gup + set_page_dirty() won't be fixed by b/c
> anyway, so I think (a) is basically the only thing.
> 
> And that's true even if you do a page pinning gup, since the source of
> the gup may be actively unmapped after the gup.

I was just now writing a response that favored (c) over (b), precisely
because of that, yes. :)

> 
> So a filesystem that thinks that only write, or a rmap-accessible mmap
> can turn the page dirty really seems to be fundamentally broken.
> 
> And I think that has always been the case, it's just that filesystem
> writers may not have been happy with it, and may not have had
> test-cases for it.
> 
> It's not surprising that the filesystem people then try to blame users.
> 
>           Linus

Yes, lots of unhappy debates about this over the years.

However, I remain intrigued by (c), because if we had a "dirty page lock"
that is looked up by page (much like looking up the ptl), it seems like
a building block that would potentially help solve the whole thing.

The above points about "file system needs to coordinate with mm about
what's allowed to be dirtied, including gup/dma cases", those are still
true and not yet solved, yes. But having a solid point of synchronization
for this, definitely looks interesting.

Of course, without working through this more thoroughly, it's not fair
to impose this constraint on the current discussion, understood. :)

thanks,
-- 
John Hubbard
NVIDIA

