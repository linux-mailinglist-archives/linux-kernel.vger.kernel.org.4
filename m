Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC2D5E57AD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 02:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiIVA5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 20:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiIVA5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 20:57:38 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB429A698
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 17:57:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mPFtRbpogs+zIdf51bWXibeEq6tkh41w0JE8bAIpSGCnU+Tb8Pk/XEKFWXSTN9lk8gnQqLSLJfMgvfUNenysvKPD9OGkGg7crzwfqNUxCX8j6n4NgUD7/jdoVnnzYzl2GSqkN4KXqsDTeUrgchcApctFA6dbc+M2F8g0+SkBkkW2QuDbVE0jNaY11DZ3AF2FNTZaJ+xDNW6hrMuBvnH91j0/JsmME9yiJVS9LLj2NCW607+oC4cBCsGhyuidXUrc6r1Avxx01eDOadKpYMLHfDPURpTXo3YA0RMrLDJNvvYEdWNVtzHPuPk8XJuIH2dqQ7FLXkbYmpSD1o798a4BCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uacXZwjzh9o77Lxj4X8FEq0SUaV2h0IAO07lXUi1v2A=;
 b=DNSyjpCK3vVZG0umqPxQ0qofdaPJM867F5Ic+299f5wbUY6wsWqTnr8WKaPs80lcWCNzFXi6bI1AbI3YpLQ928wTOq5JqMVfuVxOZAlqzhzu90RKDPK7PIHYEJ3cEzHudJzQ9caDd5ShvGHTT9zdYevJa4V6zunpZpoThb5ETRD5ECsYwZg2Vk36Snw+MHgX8s/30BhkbfjiJ7WRCwRvfjybrNrm1WSw5JcMB7URT2/6BGlOqvzP6dt2ZPRXbyZceDXamKrhP8J1KgJ1mLHIDkErbGvzSXs7SuumPusz5vqlIJAc5A4EtPAutqECCaYISxcgREL5PdFYx0Ug0RPCng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uacXZwjzh9o77Lxj4X8FEq0SUaV2h0IAO07lXUi1v2A=;
 b=XBfdwNGx8p1HiQ1jdy2dajbXlgD2hr5ZUG4MKdlzRr/5BPvRbkHhVipsVDAdc1QWQEg02KM81plTrlh7WFpFpZDOMlzJrgwTcAdMOcnoCam9scMLbD61Fg7YIMDgmjaSWPBN9qFzISao2+cPtSuMb2ZwWHqC5twS00N2F8FmiP2bZCwTeL0csoPszj6NHceFm4RjAad0JogqED24l3Rfq0+f54BSgA5K3CDY8tZ89h298cIMsnLkEYGhxgIw3xAvnTHr4DGurcNGVhml2eS8CezyOV9NWqXjQHkykMWiea4f8OY9+Hvg28vrl4mbHRurOQqZEIZVQeguzoliix2sYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13)
 by SJ1PR12MB6313.namprd12.prod.outlook.com (2603:10b6:a03:458::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Thu, 22 Sep
 2022 00:57:29 +0000
Received: from DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::e0c5:bb15:a743:7ddb]) by DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::e0c5:bb15:a743:7ddb%3]) with mapi id 15.20.5654.017; Thu, 22 Sep 2022
 00:57:29 +0000
Message-ID: <f48ba16b-0c2c-fa93-c8e0-e6c2adf913aa@nvidia.com>
Date:   Wed, 21 Sep 2022 17:57:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] mm: hugetlb: fix UAF in hugetlb_handle_userfault
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Liu Shixin <liushixin2@huawei.com>
Cc:     Liu Zixian <liuzixian4@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>
References: <20220921083440.1267903-1-liushixin2@huawei.com>
 <YytOYH1MSo5cNoB6@monkey> <Yyuk83B4VHh+pbFp@monkey>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <Yyuk83B4VHh+pbFp@monkey>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0056.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::31) To DM6PR12MB4140.namprd12.prod.outlook.com
 (2603:10b6:5:221::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4140:EE_|SJ1PR12MB6313:EE_
X-MS-Office365-Filtering-Correlation-Id: ee76cf79-8b8b-4aa3-439f-08da9c356caf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pMpHj8tivE2dSqJnKuA46VCWTJI18Q9v7RL4IN3o+2cXTsWl5Ktr1Ajzrqw6y8kJGBTWzJ/bj5qqqJ0mchgCkJqkUEKHcPcMcOuLKnHhp9zCiblUUJ1rWtlSq0q4fD00CL73N3I8LaZXNRvabhjE0F5apWOQkRXkEg9qt5TpWGS1CLjx3wjTWFc68rx53qXLuCF/xq+Wkv5hdB/rMIrTiIN83oo6FDTU4YSvXJhfUrpsIN/DSJAPYTUJnz7k71ffYs/r1lPHgNcN8lkbGG27ONtfN8An891lQS7OOSNFf86p6IsZ/pS/DBMCgmpCR8Hcwj8Etn1NReMcQJ5hMgygqOs/jMoWQ+fgKNQSOSsbJybjeqb/kU9Jo+D2Gh/pGXxOxZidWbvLRNgCjDiEyS4rXBx/7WjyGTqLK4saiD9qvuMaMZ/gdSsBpN+n9060DJ34s6fr96oqe2e2VIZgugkejb9NjUKUFW6r/6jMaEoOUg65nlfQQon11Lh3tL7qMXjED9/JHoiC63gZyql79nNu0aSk4d3hQ4xlwyH4zHb758NYFwpD+sYaDGsmz1W6b05Cb1NLdsuDXfiNtktTUhAN9zuKPCzZZ5peyfPv2QMsKK+b7uWY7qcQPni45UYouLFAI9q1FvyETXkA0Is/G1QDELes34q9GN5bAQ4SWwlUQpFcRXrgCjDmhZO1zWBrkatTyk16FW599dBkRpNohSDZqnn6zZStDzyNead0T87wovZK7y0ew/upV7zhjuwtZen/noKN3dGZWWT4M5Ax42RxkDOzAJ/q6Dwhgh2Q7/jOpVA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4140.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199015)(7416002)(2906002)(8936002)(5660300002)(36756003)(4326008)(8676002)(66476007)(66556008)(66946007)(66899012)(41300700001)(54906003)(6486002)(478600001)(26005)(6512007)(53546011)(6666004)(316002)(110136005)(6506007)(86362001)(31686004)(38100700002)(2616005)(31696002)(83380400001)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bE5ETmpWbURpQkRiNHhuVk9PRWpGODNpTW12T3BiRkxETHhlc0xmdGNoMDQ5?=
 =?utf-8?B?cVdWQmU3SUxtclMvSGtvVE5XdHZxNVNnQlFwc2puVERzVkswb3ZiL01kdFhr?=
 =?utf-8?B?L3RhdlJyK0RTZGlmV0kvRzlUeE5ZWjVIWjRIbTBjaStPQjhvcW0vbk0vVDVu?=
 =?utf-8?B?M01lTVRDMlBiZXZKcFozLytzT3pOQk1YS3dHSGI0c0dxUnYzWGJYT0JkUnpY?=
 =?utf-8?B?RFdraDdGZU5CT3BaU1R6c3pxdEVYY2E2dUhjZHB6aDRhUGRiQVZOYTRuWklo?=
 =?utf-8?B?QVJyclBvMkpNcXg4Tm52SjlhU2tZdWUvbEJWc3dZVFI2ck9JMzlDaWNIUTAy?=
 =?utf-8?B?enJESlNYN2phenYxYnNtZlYzaEJiRE5ibHNSdldLR2xabWk3VFhSTDJvUng2?=
 =?utf-8?B?TFRnNFM0UWNhTUFJbEdqdVdCWGZNQnRQUTJ5Vk5mRnpmNWZHSXowSlhwampp?=
 =?utf-8?B?bDFmbWNMQXVDUmVxV2ZkaWpLQXpXZW02WDI3L3pLUzIxSHZaSzVlZStwNW5Y?=
 =?utf-8?B?QmdNYWxJVVBuWjdocHlBYVpNQjlxam5qTERScnd2TG5USTdnYzNwWHpCYmJy?=
 =?utf-8?B?V0lUOE1GdnNqMm5WdE5ST04zMi83dzBwdlV4ajB6WHdUWXBGOEN6YnBZdVVy?=
 =?utf-8?B?SXhINjVNYmx3OXFLOHRRL0lIQ2FSd1k0TDVla2JHSitRM2QzRjh4YU1FQjBW?=
 =?utf-8?B?R05BTlBXWkc5MDVybU1FbEtoS09tTkxnemg4cDNHaFpvc1RVZTIzTkRpR21N?=
 =?utf-8?B?MFZ2RVFGT21jNUhWRTlMMG5pbFBRUWdUZE9RTUtEMTJvT0xxVytTMmNEb0Fr?=
 =?utf-8?B?T25nRkoxOGlOTkNFYVdWb0hCWnJqbEVNSGRwbXBmR1pRTXFWblhKbG1KUlEr?=
 =?utf-8?B?MUZnSW9UR3piYVYyMmxHYlVjUVV4TU5kQjRzTlV1NUlNT016YWhtYWxoTTdL?=
 =?utf-8?B?Q2o3ZEU4d3ErdkRpYjU4WGhKUStSZkhEK1haQU1CdVdrVStzUC9kVVhMalFR?=
 =?utf-8?B?VjlnMWI4T09DVk1KNGZudnZIQmsrVnVVU2ZjNFhzR28xVkp5NDRJYmEwMTNE?=
 =?utf-8?B?OHNsVnorQWZlcFZrMmhHTjFsQmZhVXQrYkdDTFpVVkNjSnVEQ2laRU9Kcnd3?=
 =?utf-8?B?VEY1V3pybmIrbHVPcVdWY1lkelhrc1VaWjZDS1VFNU5raHdMV2tTVGkwSlRw?=
 =?utf-8?B?QmF4OE5WSFVQTmUyNkcvOFRwMHlMZHhOd1RlenpUSWxvZW9PNWhlSDBDUFVG?=
 =?utf-8?B?aTY4VWlzUkl0S0NUK2ZiSTlsWnJ2M3JocnhwNHFCSklQVkwzM09uQnVmVnRD?=
 =?utf-8?B?azhSSS9YeWRWREVQTFhseTU3VjdsdGh5WVdoYklvQnlUOEwydkZGQThVOGFp?=
 =?utf-8?B?NmxBUm4rcGlhSmZjVVRiU0xUSEs1Z3ZCRGQvM04wUHJPTTNDWWtEcGxqZzRO?=
 =?utf-8?B?QXJ4eEtYTWFweTBNZCtEQll6cC9TcnB4SHJkMWpZU0cxRkRPbnBzVkZjcm1v?=
 =?utf-8?B?U2k2VFIzOHZNYWwwM3V6UHlSYmZzZkpqaDdrNFcyb2xScmFaaFYvd1dlNTBq?=
 =?utf-8?B?blg5cEN5S2JMOU5BMHhaR0VuY2VZZm15bDFCVUNiQXd3YXJPdGRhV3dnbFhE?=
 =?utf-8?B?Q0ZFOUlIR1NaQkdrWFlpMWx3SzZjK2ROWHgxZng2S0FRR0VDQm0xWWJMK3RH?=
 =?utf-8?B?V0k2eFRFQm1rYnVWZFBEWVoxQ1lERU5uQnZSeHdpTGNPV1pxemphN3ZBdnR6?=
 =?utf-8?B?SmNFcFhhZUhKejYxZ0pIN0VCL1MvQ3JvUElyZlNUOHF6Rk94TDVGRHNOaVNB?=
 =?utf-8?B?RXhsYTdDVjFQNTB5cUZrcjd2WTZObS9LemRnUnhyNEpRSStkcHZxMmdFSzRI?=
 =?utf-8?B?Q2FzazZZVDU3T0t0Y0hQOFZXN3ZLY0NLa1hHcHNyd0ZBUHQ1M3NNc2Z4dThz?=
 =?utf-8?B?OEdNSkxIWm9hZWFKTWJWaTcrOEwzdWlSaDYrSjJmd0Zia1NTWlJaZ3ZQVHd1?=
 =?utf-8?B?cHZvUVBQY3pSMHg2RkpoeTdKOWIvR25sa3Z5L3lEWmhxSzhGTGNKSHZBVlFO?=
 =?utf-8?B?QnlzNFlmeDgrSVIvZkhoWEhIeXd2WVptNHJyRUdPNlppV1hTb1Nwbkw5enBp?=
 =?utf-8?Q?OqGEzUmVrd3Pw3i3WL2MKQvzT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee76cf79-8b8b-4aa3-439f-08da9c356caf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4140.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 00:57:29.8533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0y5i02wbL80KKiUhPTavwcFfR4Rr3ynJ0oYWzZJG9zOKEpw3gupLPZGmyp9hj9omnPjpy8+IslmetrW9w2A3cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6313
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/22 16:57, Mike Kravetz wrote:
> On 09/21/22 10:48, Mike Kravetz wrote:
>> On 09/21/22 16:34, Liu Shixin wrote:
>>> The vma_lock and hugetlb_fault_mutex are dropped before handling
>>> userfault and reacquire them again after handle_userfault(), but
>>> reacquire the vma_lock could lead to UAF[1] due to the following
>>> race,
>>>
>>> hugetlb_fault
>>>   hugetlb_no_page
>>>     /*unlock vma_lock */
>>>     hugetlb_handle_userfault
>>>       handle_userfault
>>>         /* unlock mm->mmap_lock*/
>>>                                            vm_mmap_pgoff
>>>                                              do_mmap
>>>                                                mmap_region
>>>                                                  munmap_vma_range
>>>                                                    /* clean old vma */
>>>         /* lock vma_lock again  <--- UAF */
>>>     /* unlock vma_lock */
>>>
>>> Since the vma_lock will unlock immediately after hugetlb_handle_userfault(),
>>> let's drop the unneeded lock and unlock in hugetlb_handle_userfault() to fix
>>> the issue.
>>
>> Thank you very much!
>>
>> When I saw this report, the obvious fix was to do something like what you have
>> done below.  That looks fine with a few minor comments.
>>
>> One question I have not yet answered is, "Does this same issue apply to
>> follow_hugetlb_page()?".  I believe it does.  follow_hugetlb_page calls
>> hugetlb_fault which could result in the fault being processed by userfaultfd.
>> If we experience the race above, then the associated vma could no longer be
>> valid when returning from hugetlb_fault.  follow_hugetlb_page and callers
>> have a flag (locked) to deal with dropping mmap lock.  However, I am not sure
>> if it is handled correctly WRT userfaultfd.  I think this needs to be answered
>> before fixing.  And, if the follow_hugetlb_page code needs to be fixed it
>> should be done at the same time.
>>
> 
> To at least verify this code path, I added userfaultfd handling to the gup_test
> program in kernel selftests.  When doing basic gup test on a hugetlb page in

Just for those of us who are easily confused by userfaultfd cases, can you show
what that patch is? It would help me understand this a little faster.

Actually I'm expecting that Peter can easily answer this whole thing. :)

thanks,

-- 
John Hubbard
NVIDIA
