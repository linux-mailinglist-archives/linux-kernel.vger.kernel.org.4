Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F7674CA95
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 05:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjGJDdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 23:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbjGJDcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 23:32:55 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2139.outbound.protection.outlook.com [40.107.215.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A604193
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 20:32:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYULPrV7f8tn6S8Pq6hHhz86hwCCZtvSrO8b00TRy5hApRWuor9XHCiDhMasKqBd33S5N3W/VFyFusRzUXQP0BXq2jvTMH5AGgtXDUtjkoVVuLtI7MHd5ZdvWMIuNphYmRpaJ3vfx5/rCcWK8w0IoHLf0UkH/49ChaSiKofNn8j5fU5HjiOUThGCkgBWeUztnSxAxLQux9VP65/q3lQlOr3c+V5fqLGr8s7qSwaP2HOi2R9SofWYbMMJy19/tSRWF9gABJyx/4v+wmsErbXfYr+gBG6A94i9ZEtIZcBbW+mtVFkvPwaXtUMf53DhxldGsxgPt+YBjDBYvsQe8N/8sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iA00jrrQRrjZp3cdsCKU37BexD4BKzjAxvcHFf0n1xg=;
 b=HuAhAPZAZiRrSSYFZsCWCSiL/7QaJpWJUT7gx1CwjZMe/tfrAF6mjxGuaTGPPv9kIHfp7YeCCAb3pWFeHLsPwT9NOvSqIAW6g/fLiif2UVSb8pf1Xfc75vbon/sDjwHFOAhDbeqDeyMhXC+XbJX8+m4lRr9S2iyUiw7RIe/0QnX0IH3K+MN0cz97drtERZ2I6FnqXFUZ/GhdnTwcXjBq4vfE6/86dZEvYiNA8pLv4u9GVVsun+sZWs4cu5rB3rF7Nd/4r2b/Rbp5YhsgTgPVbp3Lve16aobe2NJfc/DtTHBvgQiuCKfDrTC/tLoHvbXOSGWzapLZqhTryQBljqMy9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iA00jrrQRrjZp3cdsCKU37BexD4BKzjAxvcHFf0n1xg=;
 b=pqe/q8R0kfTYzh/vUmcHbF7BdFxrOHPgW4zhiIdPOGGddhVvC8+ClpgnPtoYmmVDOcQbw8SJmQWL1Nzrb0M/VHTvtgac2SUZW/mhddlDlz5lZ7j0VIRbyykfB5FhBS6c+QB24ucM0PKgQIDQUyxpOhATE2vs37Hdj2be5ZyFjx58x+bTkhIG6v9qO/AAO4QFuJwb9fTxVpktnwzDC3sdyC1AGsg/q25rHgl9/qx1fVmdQiDJqqIhRiuCnP9nGzSb1lJfyCNuX0uc/nrHb4GAV5rcHxzlBJFvmqaDPNgal8DOdS/ZirZjN0YEeykz/tCPeh4x67aPbnCTR6KQPaZMqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3338.apcprd06.prod.outlook.com (2603:1096:4:97::23) by
 TY0PR06MB5127.apcprd06.prod.outlook.com (2603:1096:400:1b2::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.30; Mon, 10 Jul 2023 03:32:48 +0000
Received: from SG2PR06MB3338.apcprd06.prod.outlook.com
 ([fe80::a05b:2f8b:fba5:50fb]) by SG2PR06MB3338.apcprd06.prod.outlook.com
 ([fe80::a05b:2f8b:fba5:50fb%7]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 03:32:47 +0000
Message-ID: <d6ee4571-64d6-ebd2-4adb-83f33e5e608d@vivo.com>
Date:   Mon, 10 Jul 2023 11:32:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH] erofs: fix two loop issues when read page beyond EOF
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        "xiang@kernel.org" <xiang@kernel.org>,
        "chao@kernel.org" <chao@kernel.org>
Cc:     "huyue2@coolpad.com" <huyue2@coolpad.com>,
        "jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>,
        "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230708062432.67344-1-guochunhai@vivo.com>
 <97875049-8df9-e041-61ca-d90723ba6e82@linux.alibaba.com>
From:   Chunhai Guo <guochunhai@vivo.com>
In-Reply-To: <97875049-8df9-e041-61ca-d90723ba6e82@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To SG2PR06MB3338.apcprd06.prod.outlook.com
 (2603:1096:4:97::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3338:EE_|TY0PR06MB5127:EE_
X-MS-Office365-Filtering-Correlation-Id: 927b516e-f471-42c2-d2d3-08db80f654d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HXVkvZNSWezrKWUyGJX620aLTeM+iIu0eRslySPfE6ekx0PNOkX1GodpUkOcxMJPg+3OrnBidjFox2j/lyhF+FV4sfGFPUNV/6ooYWJn5ejC5P7YkRjjO7xg96bwjuYEf1CZJL1xKWUKg1YH7AYPPlS7iCCeAO36u7JMa+nCYSESmXW72m/71auRnl+NSw9a3c4aRIe34DP9O2p4dvibRT4XxOpfhNzwZRJWtVHoCABf5bQwa8FNNAwsHcJmhanjCOKQeU2+p1Fkr2/Q8IDuON+i3N8HJn/w3Bz+i5pc6n+cZAetFKaqQQ1JlQhuFP5ufSppyUwnTQWDW32YWKYUZ+CAMJZtzpo6suhCXjE584stM4vFHaelPBs8QAncgbnK17KfwO6xyZIHnufw3RBEIfAgQOSyqN6iWVk82WakFIBUO/xCjWZ19nuiSmXN07lsgyO4W3cHTb3C3NEomgUwakcUUqyKooJwL1zUxyIZf51eTZJFj9ge2ohUmcg5VPdWXnXh/lRGen/GixGbYmjfs7rO2jafZcKB4QShC2C8/LH1gnA8nDmez/oIMGV0DNZJpH7W3osu+b5NOLZ6iy0SjgHG3UB41oeb+MU6dQpzVCDflpxJZcB7YpzN/aSsU52KDVp76Dzkax8VBzrDNyxGUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3338.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(451199021)(36756003)(2616005)(83380400001)(53546011)(6506007)(26005)(86362001)(186003)(31696002)(31686004)(38100700002)(6512007)(6486002)(6666004)(54906003)(8936002)(8676002)(41300700001)(5660300002)(316002)(4326008)(110136005)(478600001)(2906002)(66476007)(66556008)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3QwbXZpRG53Q3RzdExndy8wOXk3bloyemZWSEpja1dyOXNHZHdJZTMzYVJ4?=
 =?utf-8?B?N0RHc1JYbTZ1dmgxUnpvZEFhdy85aXVIZ0pVVTdvMG5OMVRVYTY4QVpJSGVp?=
 =?utf-8?B?N1R0ZzlVekdrZkdDUEowQisvMXNCM0VxR2s3ZmZ0TGJ4aldBNGRjTVlQZkdV?=
 =?utf-8?B?TVhpYWt4TkZiaVhTR1FuK1hCeDA2aEVERGVveUFFK2dsVytmTjNMaW9uQ0xO?=
 =?utf-8?B?aC9qb1lOMEZadHBxWVpBUUg5bi93TEJUaVAycEZaVmdmNVFnTzhQa3djbWEw?=
 =?utf-8?B?MThheEF4alJaT3ZpZCtvRFl2MnZKQkt3TnVzNDZEZ1djc3Z0MS9Ncyt2ajg3?=
 =?utf-8?B?a2NPcmJvWWYxaldKQkxlYUVFNzFwYmVGR20yMldNb3UrSHpPZU1hcFg3ZXZQ?=
 =?utf-8?B?UHdFRHZSNmJSUDliUWZWUHFQcUEzSWd1d1RrTEhhWGdvUGU1ZVFtOVdmUVhP?=
 =?utf-8?B?SjdEdUpvakhBaDZlbU9LY0NpSVVuazFDOVF4YWYzN1dhcGxWSEVheDRSdGJv?=
 =?utf-8?B?aGk3M2lscUlPTXNNOFRhdHFsMUJmU2FOM09uZVp5MG1sTUVUL0dpaHN4UW80?=
 =?utf-8?B?MHBRc0Z0Y1pJSmFtY0ZvcncyN0ZaK2ptRnVkMWNodG5BVWN1cEdNVDgyTXA5?=
 =?utf-8?B?djQ3aGEyclNVUG1ETTZmU1FTQnp3YkZ1bEZZcFpVeG01Y1EyNFBuaFZWQndL?=
 =?utf-8?B?RkFBczJSalNRNHI1dU1yN0RXSXBWa3U3WkEyYk55UDY5a2toSzBrdnBKaUdx?=
 =?utf-8?B?TGtQeDQxNnUxTHJsUThrYVEwdElIRkRGMWNmOERxdmFPUjVhUkw3Y1h3Tko1?=
 =?utf-8?B?alhHY3hUcTgyWUZIeFJFSyt2ak9xNnRRZWxPY1NZOGx2S0xRQ3A5TjdrRVd5?=
 =?utf-8?B?eEozK0daYkVteFNBTzY0VkJrK0pudytFczUyMy9CTHNnL0d4UVpMMkRNVEhN?=
 =?utf-8?B?ZDRhajJYV1BiZS9HMVNwSUM5RjhQR1dlaWErVmRwWXl1RGZHRlNvbGdldXhG?=
 =?utf-8?B?YWlXOEY5MzV6QjNSdFBzVlZZRHVqVDNab2kvQWw3NjNqWHRiNlRnOGZ2cm96?=
 =?utf-8?B?WlZtU295bUlpVlQ0b3VEaitQUmRHNU51bzFsdXh6L3NublRpKy96VDEvb0px?=
 =?utf-8?B?b1RRK0R6RS9JeUF6L0xyWkVlZG5YKzREc01XOFl2UkxBc1ZsVHF6cHI1dDFI?=
 =?utf-8?B?bk54ZmM3RVdNWEJSVjJmd0VUWEVLTXVTclIwS1hDOXg2cXc5eE96d2daaXJM?=
 =?utf-8?B?REpaTG9kWE82SVhVc2VlMUFUcjFpZnVCempIS3RxNDF5V0FJR2Njb3M1aTdp?=
 =?utf-8?B?VThVZS90eG5pQ0l4QUs2NUZmNGx1YW1NZlE4S0k1TCtqOE9OTGIrT0N4Z2Fj?=
 =?utf-8?B?dlJOOFRqUGFjM2Q1VXJqRFFoWjBFdW9CZm4rcHRMbDUrbFVkQ082Y0pWVkFB?=
 =?utf-8?B?N2t3N1lSbkF5OXpmQXJPays5c0lZZG1tNkR5NGtzM20zMXp5dnltQ0tqUzFs?=
 =?utf-8?B?dW9rT2d0di93MkNHYXdqeTBHajkxazcreUczbTYvOTB4bE9NSHRXWUN3TEY2?=
 =?utf-8?B?UjR3L0Z1M3NrcXpyaU9PWjY4VXllWWE4TkVHOFUzc2hiZnB4ZW5GbnRwVXA5?=
 =?utf-8?B?ZE5HZzFmNy9DZ0dRZk1RYk5GeFNvM20vMkpKNUZrVWdMWlR0aWVyenU5RHhh?=
 =?utf-8?B?elN0RU1qUi92b1V2dDVKdXhucEpqeXFDV09vbFhaNVo1dHZiSnVNZmd3WWIw?=
 =?utf-8?B?V05Pdnc2Q2xSK3EzSlBXMTV5K29MVm5kSW4xUFpoVGsrTUYrY04xRWE2NlZt?=
 =?utf-8?B?cTQ1UHdQZUZaNmdNS2E2TVpqdS8rR2tFaXNWY0Z0WnRSZFArb0R2bG9ack8w?=
 =?utf-8?B?T2NFSC9EVStlQ2RjMlVGMEVod3ZJN3RRV1BtMDZIM1JIbjBac2wzYys0bVRZ?=
 =?utf-8?B?U2x2Y1JMNVBDMXg5TWJNbXJSZGJHamtSS0FOUmhQNHlWOUZFdS9zdjBHVDE2?=
 =?utf-8?B?R0F4ZERkekJtT3FDejl4UW4yOVY0ak1sNVZ0LzdlYlZnT0l2bkZZNkJEWi9I?=
 =?utf-8?B?bWEzOTlSZ2M5VHlSanVya2oxMVkyZXFkT0VYZlZLcnY5RXJTa2pVblo1RDlI?=
 =?utf-8?Q?V8QiqC8092nfkXoo29VCz/0KJ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 927b516e-f471-42c2-d2d3-08db80f654d9
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3338.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 03:32:47.8664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oIonD3z5ysPwK7BhhwAMzT+z0NC1Gbge1DxFjJaWn9ewt4gksR5X/3Vd5Og2ycyFPGzmrdwtbIFZhgxyisEYLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5127
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiang,

On 2023/7/8 17:00, Gao Xiang wrote:
> Hi Chunhai,
> 
> On 2023/7/8 14:24, Chunhai Guo wrote:
>> When z_erofs_read_folio() reads a page with an offset far beyond EOF, two
>> issues may occur:
>> - z_erofs_pcluster_readmore() may take a long time to loop when the offset
>>     is big enough, which is unnecessary.
>>       - For example, it will loop 4691368 times and take about 27 seconds
>>         with following case.
>>           - offset = 19217289215
>>           - inode_size = 1442672
>> - z_erofs_do_read_page() may loop infinitely due to the inappropriate
>>     truncation in the below statement. Since the offset is 64 bits and
>> min_t() truncates the result to 32 bits. The solution is to replace
>> unsigned int with another 64-bit type, such as erofs_off_t.
>>       cur = end - min_t(unsigned int, offset + end - map->m_la, end);
>>       - For example:
>>           - offset = 0x400160000
>>           - end = 0x370
>>           - map->m_la = 0x160370
>>           - offset + end - map->m_la = 0x400000000
>>           - offset + end - map->m_la = 0x00000000 (truncated as unsigned int)
> 
> Thanks for the catch!
> 
> Could you split these two into two patches?
> 
> how about using:
> cur = end - min_t(erofs_off_t, offend + end - map->m_la, end)
> for this?
> 
> since cur and end are all [0, PAGE_SIZE - 1] for now, and
> folio_size() later.

OK. I will split the patch.

Sorry that I can not understand what is 'offend' refer to and what do 
you mean. Could you please describe it more clearly?

>>       - Expected result:
>>           - cur = 0
>>       - Actual result:
>>           - cur = 0x370
>>
>> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
>> ---
>>    fs/erofs/zdata.c | 13 ++++++++++---
>>    1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
>> index 5f1890e309c6..6abbd4510076 100644
>> --- a/fs/erofs/zdata.c
>> +++ b/fs/erofs/zdata.c
>> @@ -972,7 +972,8 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
>>    	struct erofs_map_blocks *const map = &fe->map;
>>    	const loff_t offset = page_offset(page);
>>    	bool tight = true, exclusive;
>> -	unsigned int cur, end, spiltted;
>> +	erofs_off_t cur, end;
>> +	unsigned int spiltted;
>>    	int err = 0;
>>    
>>    	/* register locked file pages as online pages in pack */
>> @@ -1035,7 +1036,7 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
>>    	 */
>>    	tight &= (fe->mode > Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE);
>>    
>> -	cur = end - min_t(unsigned int, offset + end - map->m_la, end);
>> +	cur = end - min_t(erofs_off_t, offset + end - map->m_la, end);
>>    	if (!(map->m_flags & EROFS_MAP_MAPPED)) {
>>    		zero_user_segment(page, cur, end);
>>    		goto next_part;
>> @@ -1841,7 +1842,7 @@ static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
>>    	}
>>    
>>    	cur = map->m_la + map->m_llen - 1;
>> -	while (cur >= end) {
>> +	while ((cur >= end) && (cur < i_size_read(inode))) {
>>    		pgoff_t index = cur >> PAGE_SHIFT;
>>    		struct page *page;
>>    
>> @@ -1876,6 +1877,12 @@ static int z_erofs_read_folio(struct file *file, struct folio *folio)
>>    	trace_erofs_readpage(page, false);
>>    	f.headoffset = (erofs_off_t)page->index << PAGE_SHIFT;
>>    
>> +	/* when trying to read beyond EOF, return zero page directly */
>> +	if (f.headoffset >= i_size_read(inode)) {
>> +		zero_user_segment(page, 0, PAGE_SIZE);
>> +		return 0;
>> +	}
> Do we really need to optimize this rare case?
> I guess the follow readmore fix is enough, thoughts? >
> Thanks,
> Gao Xiang

Since the code is constantly being updated and someone may encounter 
this bug again, I think we had better fix it if possible.

Thanks.
Guo Chunhai
