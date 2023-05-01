Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD766F38E8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 21:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbjEAT64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 15:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbjEAT6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 15:58:43 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on20623.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::623])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B54D44B2;
        Mon,  1 May 2023 12:58:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tj4P6M25FGUOtu2hn8KPpPR5mvOqth7NU8dWaMPXQhw9yllLs5hDEOCF4xN/2mybZANUCIYPorgb3jwV3li5xHMYdQDIOyQWt3HtmK/bW6jGTYIaNYyKFeiwdAtU9BAGx/rBqH/A6uaV9+gMpq5ZnsEikVzKexBlK5m1LkDCkYLnUipIfjf19OZOl0bkb4Q7Bxh76O/ccB3Nq/8Trn/G5QkLvcARL8LjomWVWtnt/aco5nHKHmhdfwWyyGhxw/KNhOlEjabiDQ1f0H5zAco7l4Ni6xKFjkLQUCKC2papWQGylWnrk78h9tRFyYiSb05Vl6J1hPuVBrBKbd8QHh6dlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cD8qNcDy6g5/HTHt1IXaQ1gSgHNymZK5zpeAVzsQX2k=;
 b=Rj5idwucx1Ok6vXK2uQwRoZzOX1WSpiX7iOKiuBpWZiSgKz3U8pgRaiDnB28TtxdkoqZhx+kkNWZdKKHAx981QEzABBzTfDcf+avI3McY0FCiMxSXKIlin6zsSMtQEqJABNtxFvdDB74pU178P/k+qTi2qnM8h4HFjJHMqBD4ObSDpNa0yHp1zQtsYeVhHooCIbgSpL0iuXvLm2X6Bj5997Y3wlaxFhGYxI00G0ix0C+v6N+goP8xQFwMWURYEttjuO54hzO6xnDVOhspdPf4Hl8pLh5ipHxWtEWC+tdg9XWHN7xYAbMQDN3OZh8LLwgpPGt4eWbQguB3w99lMFYIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cD8qNcDy6g5/HTHt1IXaQ1gSgHNymZK5zpeAVzsQX2k=;
 b=ZZWGCQQtMCqS2s4d6pTwFVsgQET+0bXOXS+GDLzNON/5y8mRbx7/vy37xli10wiO7zJo+Ll2umhnRWklvKMa8h3sTrNvE3bLuYwokSf66YrZQIOoB7ILrTQ7o1XAEk70DjWy0pn4+ugjxHkb2gezEnkozTOTAu1a5QR/DPRL1NU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB5759.namprd12.prod.outlook.com (2603:10b6:510:1d2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Mon, 1 May
 2023 19:57:15 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5%3]) with mapi id 15.20.6340.030; Mon, 1 May 2023
 19:57:15 +0000
Message-ID: <90b246df-be30-512e-9fdb-d84105efbd51@amd.com>
Date:   Mon, 1 May 2023 14:57:12 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 04/10] crypto: ccp: move setting PSP master to earlier
 in the init
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        John Allen <john.allen@amd.com>
Cc:     David S Miller <davem@davemloft.net>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230428185543.8381-1-mario.limonciello@amd.com>
 <20230428185543.8381-5-mario.limonciello@amd.com>
 <348157d8-f3dc-6894-2bad-6d2a85cf879e@amd.com>
Content-Language: en-US
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <348157d8-f3dc-6894-2bad-6d2a85cf879e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR0102CA0069.prod.exchangelabs.com
 (2603:10b6:208:25::46) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB5759:EE_
X-MS-Office365-Filtering-Correlation-Id: ffd87509-7394-4d73-86cf-08db4a7e42e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PQjywBz3vJtW4HaEE50fQn2hm/m80yDBUj8Z88/BEF95NK/Vo0h82+FiY+WymBouCRzFmghCOoEdPVYr0lFUaPwbqPKXqMsJLMmPDxyRSKBra7DaUxYL/uhbgDJwzwAS3giglxrXr3xTNOL7PDxbZwpH8yQve0EPWj6g6SFWsMeupJA7VfzNVnCkUixBlN5qVGrVNTWc8/IEr7uztd7CGV2cTKKvcbWqRjcCZTFm9IYz9pcUqJ0qLq8tGMtbU6WxzSyaSN8kFdh3UTLl7tf69RYuEWoI0SGrI0sYx/BA2ArWdAi6ZisZeFsS0xoqgg2C1m/Izx5hbV4Lon45qydS6PWl36/PRK3SR41uT+DI0MHIKb6P8IB9X6wKuFalKFeTuk57vPJvE1wtwfZCAhhLmR7R2w9bzZDeMgqib23J6THUOgrzYN4vzBKYoBOfWHEv0MrR4xjXlqfQx5oV879pkKKHgfiB0zc2i6tzPKVp2+1RHOx+zFLW2Vhyao2MccBGpNHy/m6DBMuUKxZcqr/QgPCJ0VJDUYYjA20ZeTjfRr83+WgRzksk1JFuPpXU1z/NMhkfZSu7Il8T1o//JkimcJqDdAXW66QOStXgXgTlPDmDz818kuKNWzx0qPF/5nsMX2qwn8RaQCAs4jNA5ZG00w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(39860400002)(366004)(451199021)(53546011)(316002)(6512007)(6506007)(26005)(2616005)(41300700001)(83380400001)(110136005)(186003)(478600001)(66476007)(66946007)(66556008)(6486002)(4326008)(38100700002)(6666004)(6636002)(2906002)(36756003)(31696002)(86362001)(5660300002)(8936002)(8676002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlFLY0NYRmo1NWVKNWpqZEo2MjdFTkZJcjJZQW9YcDl5SHBlRnVtd3hDbE1B?=
 =?utf-8?B?amVuNGtJUXQ4bDR6V1B6RGVvYTVmQzU3aWs3VFBUNUlQZEx1cjlscUVnazRP?=
 =?utf-8?B?Mml1eHhoWDVBNVl1RnFKWU4vbVpsMm5ndkY4anJNdlBINUR4RnhOSWxrYWlH?=
 =?utf-8?B?RU9PYzk4MDRMUGlXTk8xaU1uZFBJbFltTW5IWWFIOFdPY0NQNGI0aHozdmJR?=
 =?utf-8?B?Y1lEcG9jeUZRc3IvdlQ2Umx4T2VwZTR5TGszdVhyTXZmQ0lxeVBQNmlMTmZJ?=
 =?utf-8?B?L3h3SlBiQ2lkWkFwdnJ2SjlQTGs5d3B2VHduQjVjdFBSMUNRaktjMGJmc0Ri?=
 =?utf-8?B?M053UTQwYStMb0dIcnNzaEVWR0U0UllTM3FsczBxSGcvbW8vUnZ4U2psV3Jn?=
 =?utf-8?B?b0VteVNjMVlRY0RlTW9mb1F3RmJyelVmUExMb0FtMUZjYmNpdWJzUU0xTXQ5?=
 =?utf-8?B?dHA4N2txTlFyY3Q1MUovS0J2Qm5LdldKUk8veWZqd3ZCK25VWEVFSHdKTlRO?=
 =?utf-8?B?Skk0S2xXcDBDWHdmNTdlVFFJbDNIWklBUFRIcXZtbXQvRUxIQlZqazIweW81?=
 =?utf-8?B?NW5aQ2kyYUhkNlhqY0gydlNGNmRjVHlhbGdiMzZtM2Q3ZkVUVjgxa0gyQjZs?=
 =?utf-8?B?cFdlSzlmK1UrQzRtT0tCeUE0MS9jd3lYQlJVK25tRjJFc0lsL0FJeGVTUzZU?=
 =?utf-8?B?VWNIN2xRN1BsaloyWDV3YnVqaXovOFp4d0JNb1Nmb1E4aFdhNUVxM1o1Umxu?=
 =?utf-8?B?WUQxc0FpdXJFUUhyTk1KS1RXVms2N3pjWFgxeXNoYTBIVHg5cmJpVU1LcEdm?=
 =?utf-8?B?UzNXOEpqczNMVUtLNVQvVTFKVnNqNmhBM3JnTXZGTmFpaEtncGxsZ3R4R2g3?=
 =?utf-8?B?WG93RndnOVFHMkJ4bFFXTDRGQjlXdmllTkpYQno1NiszTG1iMGhlZ3dlamRh?=
 =?utf-8?B?S3pUUlVXVm9waGxsY2ZQTEdNQnRwWk1PQmpQZTZZTXhTYVh6eWRucGt0VVBh?=
 =?utf-8?B?T0QyRWcyei9zU2I5UmdVQXpBNHZTUXpYdEhuaDVNUnJVVmlNWmdMNzhVSHJQ?=
 =?utf-8?B?QVlla3IvSDA5YUZrMXlLb1VIa3QrbGtaQ0I3UjRPdGdSQ3NHdTNWZ29KbENY?=
 =?utf-8?B?RkJYZTFFSGEzSGQ4bFFkYWJtMXA4R1ZBbS8zMWJ2U2pCdzlQeSt2SDZid1ds?=
 =?utf-8?B?K1VYUEEwN3FNajBVWjRoL29zekFWUkVqQkVhV2paRUxUVTN2eTZwRzVGZkZl?=
 =?utf-8?B?ZWd3d3p1ZmxNUFRYRTlZU0tvNlozd2xFT3dPQkxrWmUvZCtGYmo5czFLZlgy?=
 =?utf-8?B?NEtDTWRLeWxqS1QzdFRtQzlRTU02WWFyL2ZDWFRPMjZ2WHJSdGxqUWlZdWdh?=
 =?utf-8?B?NjVmcGlvUnZ6b1J6bmpPc1N1bXIrVzFmeEwvYlgyUERmamo2dFZmMmp5dVM2?=
 =?utf-8?B?Y2ZOWW1jWkhEa2xocldNVndHMXBKNXk1czBNek1FUXJDRTlwakhrd2tYZm5k?=
 =?utf-8?B?d1cwOVJENnBvZnZkZVlnVEZtTFoxek9TeldNeFlQOWlKNE5rVldaRENnUHgv?=
 =?utf-8?B?RVYvWWVubXozYXRiaUJKcnI0Y1psV3JJTmxXTVFES2V3NGh1MzYvMEZ5M3FT?=
 =?utf-8?B?NmtZZTEwOTFCMmk0SGF0VmRYcXRBUXN3blhlY1ppL3VUQmhaRUxLV05icEU2?=
 =?utf-8?B?THdJQmJ6NVAyU0xZV1VlNFEreW4xc2hhQTErbGppNm5WZFgwMENPdWlBRTRw?=
 =?utf-8?B?OEZOUEh3akNjTW9vc0JxZ3ViZ0JFNmJPQ2ZuVlBTOWtIWThkVFZoeG0rdzhM?=
 =?utf-8?B?UERvNWRNd0YwWldMT0hWbkgzK3lsVyt6N2JQTzR5WnRiN2Z6UXc0cjJFTXhp?=
 =?utf-8?B?elIveCttdmpIS25XZXVHSFBFR1dYRzNvaDVMN2U4YWZTWFhMOTdzY0VSOXZk?=
 =?utf-8?B?RXhQVGNQb2RUK1hxNzBubXRxZGFWcTZzY0J0WUpHMHNoZmJlWnJ2cjlZbCtT?=
 =?utf-8?B?NlRVTHlGSUJvblJnOVdoUHVNQk5qRGtlcnNrbnlmMFF4c1FDYnhkNU5nZWlo?=
 =?utf-8?B?Y1cwSjl0elJvTjlIRlAvRHR4ZXZHMDVqcGpReWpDdTdWdXc3QkF2V3ZCMVNM?=
 =?utf-8?Q?2YKmTxoji2hHapY+6r8Z3p0HO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffd87509-7394-4d73-86cf-08db4a7e42e4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2023 19:57:15.3790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MMZ2YJQGCkdcgcJi1TWFPrpBaDo7o5cp0WaHY/riqV4luLJNhrlMK9Qw335Me8L/kQFYrYuWrexx0K8NI0jYJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5759
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/1/2023 13:47, Tom Lendacky wrote:
> On 4/28/23 13:55, Mario Limonciello wrote:
>> Dynamic boost control needs to use platform access symbols
>> that look for the PSP master as part of initialization.
>>
>> So move the PSP master before psp_init() so that dynamic boost
>> control can be initialized properly.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/crypto/ccp/psp-dev.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/crypto/ccp/psp-dev.c b/drivers/crypto/ccp/psp-dev.c
>> index e3d6955d3265..e9136e398174 100644
>> --- a/drivers/crypto/ccp/psp-dev.c
>> +++ b/drivers/crypto/ccp/psp-dev.c
>> @@ -173,13 +173,14 @@ int psp_dev_init(struct sp_device *sp)
>>           goto e_err;
>>       }
>> +    /* master device must be set for platform access */
>> +    if (psp->sp->set_psp_master_device)
>> +        psp->sp->set_psp_master_device(psp->sp);
>> +
>>       ret = psp_init(psp);
>>       if (ret)
>>           goto e_irq;
> 
> If psp_init() fails, should we check for and call 
> clear_psp_master_device now?
> 

Yes; that's reasonable, thanks.  I will change accordingly.

> Thanks,
> Tom
> 
>> -    if (sp->set_psp_master_device)
>> -        sp->set_psp_master_device(sp);
>> -
>>       /* Enable interrupt */
>>       iowrite32(-1, psp->io_regs + psp->vdata->inten_reg);

