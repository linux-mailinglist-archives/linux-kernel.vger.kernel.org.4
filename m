Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0B65ED2D5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 03:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbiI1B4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 21:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbiI1B43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 21:56:29 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2051.outbound.protection.outlook.com [40.107.100.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43585140A
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 18:56:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BFAmNWr7BYUXzruMwjEvQiAqOMPuQ1o9s6oz5JjoTQADJzWekNbRpOKmU15IepXvY3CxzZujoFzv6OoJ3IniPuy/bvuHeocJkhNHejYft9rNZtXC8YdEoAW+F3Rm15dA/MnmlXHPFjhbZB5ds0iXie/YD8uaPducn7V5MbGI/rsPgfqZAxc7PaPF098uUahSPneP0DZaVzUQCkvyka1XL6jZqB2S8pcgtHzJbPfMX1GqQDmvLHZsvdGYWs9+GhmgR/jWhWesrEyY3KenqqvwhP6bX9SxFb/IGz3RjRymP5k0t0GXS81NhQnfy1ULoFn+aY4OwWt03J+pMPTBwe8msQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lkme0sDcEj8C2PD6IEhnmTVlvvc2vImiZzZaN/B+wGM=;
 b=S9niABhaTDxKipphyhdBfsUppn/97OCJLFkJoD3qaanqZln7ksyOW+k2uAD3kM1NEEnS3JzBbeshWgU0u+zL8OWNqrhOxqBBmf/uyVY8R8THZxzQMApn7CCz1Jjc5svyoqQsl3vPplFBBNeoMIIfqRmdXuNEH017f5sBmG+ULxLIsBcjCHYbrGTVOl/qnf15orREsA75monZePWKiBGYmMycef+zkbQtmtrutkihlzR00LIHPRjALrWuizlAPd4SfHPsEW5+61W4LOfG9YrBP/v9teTqG5f3Ujlsaev+3c6AB3FZGnJiQQvoEWmoVjZx771HxgEExrPHoOLznLNzYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lkme0sDcEj8C2PD6IEhnmTVlvvc2vImiZzZaN/B+wGM=;
 b=jjeGyjShySQir14otheNE8gPTKwdq5m1UTh4c1fCi/QlSeyTeGSaf/q+0UybJkpiiuso72pMQK3oylWgTOjJeHEHCMd0C0w5o6VfivH2ob0yk5ZmTgbV/vMa01Oo894DQStusDof/YL90g94S+9jCcKePahzkaGRIma1gB1203JcGAhUv887ZErY7dhVxtUdGh/m9SEKBvfQGE84OVQ3PeF7TQl6SK9WxEaSHovlFV7VreIM9B8sL6iN3h9paid2fm0+161XmLrhcBYclvsAwASsfwdAmMGVhP4L5wHNdVhSMzjBVS7C6L34bvd+fRldUEjh3s3paPGHb0Jg62RBHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by SA1PR12MB7317.namprd12.prod.outlook.com (2603:10b6:806:2ba::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Wed, 28 Sep
 2022 01:56:25 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::51d9:c02b:e5a1:254b]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::51d9:c02b:e5a1:254b%5]) with mapi id 15.20.5676.017; Wed, 28 Sep 2022
 01:56:25 +0000
Message-ID: <4a44bf59-a984-8ac4-c613-a03d74dc6a5a@nvidia.com>
Date:   Tue, 27 Sep 2022 18:56:23 -0700
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
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CAHbLzkpnCTD_c60QPu25hPymCYwLP6fYRMxp1EWmzX0SBF4g1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0020.namprd10.prod.outlook.com
 (2603:10b6:a03:255::25) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|SA1PR12MB7317:EE_
X-MS-Office365-Filtering-Correlation-Id: 52143d58-68c3-493d-ad31-08daa0f4a694
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tV4TyFb/4JtEAMynZQj6eNFPJDQN15QnLHUcyGToot5SU+PuGAaNbyOI8AbVZ3zeWcsK7s7QYrLsmFDiZPnRDXNep7A9uzINYBj/n4atevJx7nd/ztmvbQ8djAHJ+UVs20s25zuH4P0dfFgDo8nJmxfAQS/eM7UWfbRoKgATA8wYy8KDlNfVBj92tA806BUtFmQS7dzrVa6eF+jogWukscl0jk3bYO+hTkNlVRFYLY02wkoX0G5Fi2BnELfYj7fBWqK1tc+er9bdJUnrRNQDNAYn5Op9/ZKxXPLhioKGziXgyxaN+UTGgOvE2WkQqxkMHD731K5m03rKzTAiWFxji/dbZ6YCs2luFxItB8TLy82NCeQEhr7q6i2A2ut3RhpBXZxMKd4oV2kzdIOZCE/BjV6lU5CspSTRVAub6rXY3fa6HQoMWB5DkVfGfoEzkkIO2nwTsLzn0aCq4TQncDudEMIz1iyxpwNWozKsKj38Tw5oHuUm/QsYkWTxNLd82AQwexpnBYmbabNRNT5FakrsBK09nRtSgD3c7/d9RMyS03TzbpLhsRycaNuDV8DRFbRtq1y4p8B4azc6GagNvJtm6dZKrcyOpp4v8MxGuh7/po+eDzerTIGfPtDkmFXuZC3ud78BUTHoiCji+bcxhznagguARIE1IlNDszWlCwNFcfpStmj1FXKuFvFanKqS7S16ppoIxe67Vp0nYFH/9o/YZ68a+DuFH5KxiVhLi5tWbGxjOBsVtP3r+5YDGq9b4e4Pf+JQiEx8RoSNLZfKu+T9IYkpz7EoKHIRXBu3N2Foe2weD88DCIC2D/5drE8iXRQYMjGhiU4WIku0XcX7bf+INUZ363DRMB7vP7mvxvBXJWIWS4+hq0AxocBisZCGfDIH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(366004)(396003)(136003)(376002)(451199015)(31686004)(5660300002)(36756003)(2616005)(31696002)(186003)(2906002)(8936002)(66476007)(66556008)(41300700001)(4326008)(66946007)(86362001)(26005)(8676002)(6512007)(316002)(54906003)(83380400001)(6506007)(6916009)(53546011)(478600001)(38100700002)(6486002)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2NCdng4Mzd5dk1tM2JBYTYwMzFwQ3NSVFZIYTc4dWVCUHY5NUxvTVplVVFk?=
 =?utf-8?B?SmVCZ0x3WkprU3B4ems1OVluZi81UTl6RjJxNEFuTkRnZjArV1BFYmF4L2hT?=
 =?utf-8?B?U29kVFR0RGFpQ2Jid0h5RmRRTTArQlFZVWxWYlVONjV4VklaYjZRTVZFRGhZ?=
 =?utf-8?B?bmtxUlVJeGl4NG5YaVVQL3lJa2w0ZHhDS3RrVTBkR2dSRHlqZ1RDRk5zS1hr?=
 =?utf-8?B?RVMrK09SWU5pbERWcHk0ajc0dUNtVExrbG5vZjAxMENNeitKSlhyNFJsTEJM?=
 =?utf-8?B?OTVJY25nZWE2ZGtYZGYyem9ucmtWeEtFS0pZRTNvZ1BzL0lpQklucGx2M0cx?=
 =?utf-8?B?TWQxMjN5cGlXN2V2anBlWjZsREVMTkNxQXpQc3JhckxyMWg1elo3YXdIemd0?=
 =?utf-8?B?TnoxUDcwOGRrSnAveXIxNGVPSHU0VW0rT0xJeE9TMlJBR09KU2Z4ZTBBdnlx?=
 =?utf-8?B?R2xxSEc3VlJNbGhaMjhhMUhkV014T3VzajRzcTM2M0ljNnEwcHFRUDB5RFZO?=
 =?utf-8?B?dHF5cTVuNTJSMWRNM0R4bXhtMEZwYktrY2JBT050MUd4U2lNVWwxMTdaYXRx?=
 =?utf-8?B?czA5MEFmcGZ2SEZkVzJPOGVUZitnekhzVXFrMzJIUlkvWEdjV01BNHJnbzNC?=
 =?utf-8?B?TWxVOGlYRW9oSGVnS1ptQzluODVkamUxNnNQV3h5R1VxdHJHa0tHYmR4cmdI?=
 =?utf-8?B?RTZNajhYUkUyU1E4NHNYTCs2T0RSbno1THJSMzd2cWIvcXVvQkJlNkNNWUlp?=
 =?utf-8?B?R0J6RFFLQ3pXYTBxUWtlYXloa2pkNjVWOGhJdTV1UURRSEZ0SFhrK2xlNWZ6?=
 =?utf-8?B?YWs4Z1hiUTVKOU9VQk81ZzdjK1NvOVBtWEVuVlcydlhwcnVqRm1pTlZ6OFlF?=
 =?utf-8?B?STNnMERpMjlsMThJaXQ0YnBUSUlCK3NIZkVxKzlxWEdPUkdyYnVtdjVFT2lC?=
 =?utf-8?B?SEM5ZmFNZy94TXhtaWpseElvbEVFOFlId3krdi9mL2hyL3JQcFh2RHdoMkxJ?=
 =?utf-8?B?SUJCUGxBYWsxSlJkck5WaHR0Znc3QlFKKzQxWjJFUzZMK3VkZzhJSS8rdTJp?=
 =?utf-8?B?aUtScWFPcFJqZjZTOFN6M25GZjhScWdhakErdG40WElWQU5HK2prS1hIOHhE?=
 =?utf-8?B?VTlrTTdoMDk5U1MvaXIwWlZNWnNsTDZMZzhTQUpKNmVpMEREYTZtalpNeGdN?=
 =?utf-8?B?MzMrV2pXSDFCV3ZtdVNtMk1nbE9mV2ZNOUdySkFUbzBGQ1BuNmtvWlY4Y0R2?=
 =?utf-8?B?TDd4L245Q0YzUDdKYllFUlY3WXR6U0tEeHNjanJWWVBXUElqYkxzMWY1UDJk?=
 =?utf-8?B?ZC9XNnM3bmR3ZkM1ZGVOS3lhdjV4NG5hVCsyU2toY3pVanVJOTFQRnFGNm1z?=
 =?utf-8?B?a2dmUytDRVMzRWxpcHNuWFM2REZia3pIUGN4MkNsUFVxdXYvOTJCZ25ESlJI?=
 =?utf-8?B?aFdodURmSkNubnJrdWozYmhXdlA5QVZhTThaUy9iak00SmNweEIwSlpYakJh?=
 =?utf-8?B?SGw1Q3Jia2xVSERwaGFoUGgySWFySkV4cmZUb2MvQjBrTEtmUUkzc2syOG4r?=
 =?utf-8?B?akxTUlk3elRtNE9kUS90ZTdibjhpT3V0ZkR4Z3NHOW5KYy9KSXl1aHBiSzhG?=
 =?utf-8?B?K0pZZWpVcTBMQ21ITjZzY1I5cDVmRGNIUnhaMmQ0WWJsci8rZWk1ME4xZEhR?=
 =?utf-8?B?bWQxQktqVEd5eExZMG5aNWkyRjNsWkUyWWRCMElockovLzlsZ1gzbVFWdDZT?=
 =?utf-8?B?bTBVZWVCYUtYWmlKWTY5cHpZN01FLzVtbE1ZL0xWUFBUM2E5VG1rQm9BeGdn?=
 =?utf-8?B?aHlWUy9uRzl0OTRGRDR0WitYbURvSlpWRjRiK05rQkFLUXVzWlNBSDlFaHlr?=
 =?utf-8?B?YWJKMkorZW9yV1F1Wm1LVW1YVTJHWEpVeXZtbUE5amtjQjJ1NUdXYUM2alZJ?=
 =?utf-8?B?UlFlY211Z0VCcHhTTGRkTmhQa1g4RWsyU0pGUm5Xd25yK2EyZlVwRlpwUXlz?=
 =?utf-8?B?UFl5UnpySFRKVHBBT2E2K3NXSVY2S01vOEp5SzQ3R3YyWXlaNk41bjhzblRQ?=
 =?utf-8?B?RUh5a3Q2c1RCRmNITGlEbFlaUzdqYjh3RDN0a2RhTnh2NE1GUkFDTk9PYS8w?=
 =?utf-8?Q?1ikfRXQI3TZPBTtTVF2AEm/pK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52143d58-68c3-493d-ad31-08daa0f4a694
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 01:56:25.5134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YX3uFN0SMf3pYHo0U8061+Fp2O+QkqgFRC1ZBxPaxVUy+Xu6uLEjas+ufuBF5YgWauALLWIg+Cy/5ja2leFmhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7317
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/22 18:49, Yang Shi wrote:
> On Tue, Sep 27, 2022 at 6:45 PM John Hubbard <jhubbard@nvidia.com> wrote:
>>
>> On 9/27/22 18:41, Huang, Ying wrote:
>>>>>> I also agree that we cannot make any rules such as "do not lock > 1 page
>>>>>> at the same time, elsewhere in the kernel", because it is already
>>>>>> happening, for example in page-writeback.c, which locks PAGEVEC_SIZE
>>>>>> (15) pages per batch [1].
>>>>
>>>> That's not really the case though. The inner loop of write_cache_page()
>>>> only ever locks one page at a time, either directly via the
>>>> unlock_page() on L2338 (those goto's are amazing) or indirectly via
>>>> (*writepage)() on L2359.
>>>>
>>>> So there's no deadlock potential there because unlocking any previously
>>>> locked page(s) doesn't depend on obtaining the lock for another page.
>>>> Unless I've missed something?
>>>
>>> Yes.  This is my understanding too after checking ext4_writepage().
>>>
>>
>> Yes, I missed the ".writepage() shall unlock the page" design point. Now
>> it seems much more reasonable and safer. :)
> 
> .writepage is deprecated (see
> https://lore.kernel.org/linux-fsdevel/20220719041311.709250-1-hch@lst.de/),
> write back actually uses .writepages.

write_cache_pages() seems to directly call it, though:

generic_writepages()
  write_cache_pages(__writepage)
    __writepage()
      mapping->a_ops->writepage(page, wbc)

So it seems like it's still alive and well. And in any case, it is definitely
passing one page at a time from write_cache_pages(), right?


 thanks,

-- 
John Hubbard
NVIDIA

