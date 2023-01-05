Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C01665F03C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 16:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbjAEPiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 10:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbjAEPiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 10:38:01 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2058.outbound.protection.outlook.com [40.107.100.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC37D33D60;
        Thu,  5 Jan 2023 07:38:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OTCbC4gCA/4x0W7FjuW+V6H9bvysU/nSbzSrY4Tt960uAwNKSsegYLs1iooW1vmlqzPQ5MjxfTmmpwe7/a0wI24FyVNVy8BnZhxcI6SRO3EUYiEpJYdUcAhaeJcnuXfvL54SfUrkCjAgVEChHA5iwvGvpVqXOyO/h48Yjy0yagMCFwGFtXdC0omfhWOtdBYvuHjfXByK2VyRgkgfMmpvbGNVzsll9+AHwzGtZ1jCkGm3UKxSbdiPTgFimhoEYpunSB5zyMwUdNCKli7F+0dZgFb5blQcwKOWc8OZnQGhrvFEJsESX5GCx3XpoLO11WMqymqTlZLDbH+TWzXb/Cfb6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WuY1CjRjG6T7Yw2j1DYOrYFHnxdxhlk2ciWIv7e1fv8=;
 b=jBCcoCZs/jV6YjtBOgqmgX3Cpf/trMNq2lyzpjGv3CkTxQq5PW77yKXFX0YU4rwBtraKwgPqMaOdQ21/Q7QKJ7vSdF6yw8vzc0cStk9QYKHvJokrkdGo7s0kVcsEit9EPCme401irOM0a/6JWwsX9Ray4tlDqB4x3uAe0/aC8af1NC1wzwjQ3trvRFR0v4g20TeOu7Mj6Y62uB0Z/HIrCYIFkpXLbLvDl3QA4z9kBQHo6+aopVXxn+76VKED5doc2VdFswvHOJPMZkrYFVAx4Tb2hyd5L/q1RgWQ74W2rYurki/fLf1cB4Ph9VQ64bMXXukKvdj24PqDlw49eWHiAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WuY1CjRjG6T7Yw2j1DYOrYFHnxdxhlk2ciWIv7e1fv8=;
 b=hYhjcDFHGFBN0pRrXreh/gJG9+sMByU5ITyGVJDr8L5kgrMmdAqr0cs/3a5RkPep8SXBkTyBPUSUshYnPs4biVIEcj4uZrYfCUBvq1DzISx3IFZMhNDm+hXSR/F0jBR0AGJXUoxET39506Wic31d9UAWswt0+kJiWlJoSg4fFk4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 15:37:58 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::8200:4042:8db4:63d7]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::8200:4042:8db4:63d7%3]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 15:37:58 +0000
Message-ID: <0b515701-7d2d-077b-a0e9-c825d4736f8f@amd.com>
Date:   Thu, 5 Jan 2023 09:37:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [patch] crypto: ccp - Avoid page allocation failure warning for
 SEV_GET_ID2
Content-Language: en-US
To:     David Rientjes <rientjes@google.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Gonda <pgonda@google.com>,
        Andy Nguyen <theflow@google.com>, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, John Allen <john.allen@amd.com>
References: <20221214202046.719598-1-pgonda@google.com>
 <Y5rxd6ZVBqFCBOUT@gondor.apana.org.au>
 <762d33dc-b5fd-d1ef-848c-7de3a6695557@google.com>
 <Y6wDJd3hfztLoCp1@gondor.apana.org.au>
 <826b3dda-5b48-2d42-96b8-c49ccebfdfed@google.com>
 <833b4dd0-7f85-b336-0786-965f3f573f74@google.com>
 <1000d0c8-bd8c-8958-d54f-7e1924fd433d@amd.com>
 <06de8454-2b29-f3b6-7cf2-c037c2735b6d@google.com>
 <260364a5-f467-f83b-b180-583576ce70ee@amd.com>
 <271fc4e5-c4cb-a086-fb7f-8b9389570af4@google.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <271fc4e5-c4cb-a086-fb7f-8b9389570af4@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0315.namprd03.prod.outlook.com
 (2603:10b6:610:118::15) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|DS0PR12MB6413:EE_
X-MS-Office365-Filtering-Correlation-Id: 80fb7ba9-32e4-454f-b354-08daef32d24e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YdlCfHsGBJs+K8Tm3RR6m/eg2sNdZ4A3+G/zqkUs6aYKpZ4uJWmA7yLxOEIfAlvcwZpcXGOtV/GTRQmSbpGD9oP8s9ijTKzbFH/J0rsRR12iEvxi7Vmenb4Vj3MaIbHXu5s4c6o5E2E8iPCiIKoYz4WxZ5v2Ct0ZiI1hu5HKYhtYyh7ofBLJajL9MA+Jz4pHNsxY3l+1aDWhJoF2wJxW4/zbLeQDqyIZN5J3Ze8bKihfVetUbtneGH/Hjavs8xjQvjWTl//BA3gNxW3mgtSVaFupZEQ9aOyk6wyyKdSg/se53gJGWqi9DG28KUH3JBkty56Od7XRDfyCeVXIzkfYBIKHOxFfSNUjdv4QJnWXITb6iOcFOfNGPoGFuBECWjNj4ImqSNrJ6pEtJmtNIwJX+2JFk6XQ7fHeQ5dy5flihqcQATiLgYl2KpAyQTAcQmpPjmuxnqD/y3l99RyoklHyi2m+sLjaKvT+vgKLcZlfbFbVWQAd7ThaudWw5xLZgVD0QopUYs9Nx++VOWYSDiYZk7pJrekWysR9cOHi1Tg4flm3M0pISY5Vx1tzGLlJhJnvNcuEtp+lH9+M1rmCPnftgvGcA56zrc/0Q3Zh1GPQ+DQ/qr2CDvouEjb2OILiXkX4fVeTzpQL9wDH7mY6Z19JxWr6K/Wv+UXElp+gLFWCj6kpxZlv6CJElf3aJykRwROeRwl65piR6uTi462qvwjkWl0O6bo8mH5HiUgFBjbZ3Ns=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(451199015)(36756003)(86362001)(31696002)(6506007)(38100700002)(6916009)(53546011)(66946007)(66556008)(66476007)(6486002)(2616005)(6512007)(478600001)(186003)(26005)(31686004)(54906003)(316002)(4326008)(2906002)(8676002)(8936002)(83380400001)(41300700001)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1pSOE1XMG8xakFGQUh3R2o5dWFvMTRMYVoxNWlyblVzYm1BRHJ1cmRrSHBM?=
 =?utf-8?B?NmE1RENXOVNkQW9yUXI4ejdYTy9ZUmF0b2p4VjVhM25BYkxTRjRBQTZEelQr?=
 =?utf-8?B?aE0xTVFCbmVBSDJKMVVmRzdGMit0OXdvN0cyc3ZpQlVYRVo4bDlCT09xZTZR?=
 =?utf-8?B?Ym9YdWN5VjZXQkdxaWRCTEdqODhoNWYwOFN3RkZZUnBHUGFsVk05dEF5M1VX?=
 =?utf-8?B?c0xoUXM3MXU3ZGhqd0lJYnI1N0lFWDVEcTZaOGpaaGVLQUJvNVJUclNyRzB1?=
 =?utf-8?B?WG16M0RFODVQZUw2amNkTG52M21STTJxV1ZQSzdyZjFhUnc4QmlIeU0wczBB?=
 =?utf-8?B?cXE0SHNsY2lnYUlhWVBtVGhSdUNiZ0YvMVVOMVVkWFg5OFdOSElQa3RVeDBF?=
 =?utf-8?B?R3YwNlYyMnY1WkhCWis1Rk40MXVVV1lUZGZZTWlwUUtIa2ZhVmo0STVlclQ2?=
 =?utf-8?B?N3NyWnF4QWx0djBIWnJZVGdjR2wvMHBjY3o2Z1VjRXZQWE1ta05lT05TR01C?=
 =?utf-8?B?MitBOFBJSTZkR003VE0xUVRxc1BOTlhmNTZTQmhwMzdJZmJyZ056UnJvbTh5?=
 =?utf-8?B?dVZnUzlUckszdHNpWFJ3VGxUVGdTcUo4aGt0c25XSXVHVXlac1FPNGQ1ZVg5?=
 =?utf-8?B?c1FieUdaNjlVYTRkeHhRUkJBeWk0R0xkSkhHaURZOGVSeXRvVWdTalpIY1Ji?=
 =?utf-8?B?SS8wWjk0bEtsQzRiR0tZaEtxRmE3K1czWGt3YzdCVmF3SllGNEhOeUJpTDl6?=
 =?utf-8?B?blU5OEcyY2FxRVl0ajVIU2dpK2ZXU2FBcmNXNFdXM3pHdHA3cGxiazZUZzRE?=
 =?utf-8?B?Y2FCem0rVTJibWNDd1hDbjY0U1FJN2YvbGQ1TFFVVG5NVisvSi9YTmxrdTUx?=
 =?utf-8?B?WXQwanFUTEJYdkM5MG9hSWFTQVljUmEyNGhJQWF0OTMvUXR5VlRTcHpzMlpX?=
 =?utf-8?B?NklQU0h0L0w5UE9TUXJicUFNTS9WMmFZYjgvakZ4ZWNtSWdRVGdrWFdRZkt4?=
 =?utf-8?B?WG5zbjBhbmRqOGp4dVRFMVM3eTNJR1l1T2pYcmJkYlhDUDAwdktxUTd6cEY4?=
 =?utf-8?B?MnU2TCtaVVlBL0tFUkJrQ2RYQmpETEtIZ1RWQU0vUVR6UW5WNlpUV0tnT3V3?=
 =?utf-8?B?dSswYTlPY01MOHRlOUdnVHRWVjAyRFpzR3o3TVpkN0JMdVByQjdhVWVpN0Ey?=
 =?utf-8?B?bnZNb01USUNZT1lyQzhCY0d3YlFBZ0RtWEFHQmFkSlFqVVBrVEZyQnRJck1G?=
 =?utf-8?B?NDdvMXN4emhBekpqZXlEZnB4cDBvS3l0eWVhNUlXOTgzSlZha2VwN29YeEY1?=
 =?utf-8?B?N1poYUtOZHhySFNZbGRta2lRcjIzaXlSaGJ5YjFIbEVVNGJ0c0ZrdjFuZFBW?=
 =?utf-8?B?U2srem9zM05zaWFtZDFUUEtVZEt3OW1rRmVIMGptQXJIaDVtZm0zT1dMdDQx?=
 =?utf-8?B?dmhEU0pCQVdYL3dKd21OR0xzdGo0dlNycmsrS3Y3eGFCZ2ZsRkNSL1NVd0ly?=
 =?utf-8?B?VnVaYzBWcXRza0tCT2ZuK2FSMy9BMHJmVXJvd1FMVWhOTW0rbjhGdWxCejdY?=
 =?utf-8?B?Z2pkSVAxT2RpSy8rWC8xZEZSVDl4MzA4WGIxam5NZkVjVS90dDZsVHcrU0tw?=
 =?utf-8?B?UzA5WUZBYXgrVGpicERqU0tXVWw5dHlJVy84b1pJMXFsSlJkT043bnVHclNm?=
 =?utf-8?B?eFN1bGtMeXRjWGZsalBLWlNnN3pPMnowK2ZiVnFEQWRQSmdZcWw4TjlQeEkx?=
 =?utf-8?B?NFphT2dNK1JNdWFCS0ljaHRiWW5PZHpFVHQ0ZFFNcitCaUowNlJxVTcxWVhN?=
 =?utf-8?B?dFhKSEVXdDBiaHJsTWNRak1zUmorM0ZaajVjVU82SE1BSS9HcDgxWlNpSzM4?=
 =?utf-8?B?ZEhoNDFNSnYzMkJRbURyNWFJNm5oWnJRVHBQZlpESkdMYy9tZDlGTzJ3dU13?=
 =?utf-8?B?VXpCVjRsU3hjWlZweGQ2SkZOWk5veEFXRmo3VlM5QUJhNnNtSEFuUTdxNFFy?=
 =?utf-8?B?aG84MUk5eDBQWDczOGRIa0Z0QXJ2TWF0TlhUbHQvSXJIaWMvN3hZTm1TVEFt?=
 =?utf-8?B?VWNoNmNLRUlLVHVXTmVObkdWZE01OGdxYXNUVis2RzMxMHEycnpsamVNQlly?=
 =?utf-8?Q?XabomwW6ekW2W+0DZ/sfzrDfL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80fb7ba9-32e4-454f-b354-08daef32d24e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 15:37:58.5403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mGJM6Go/uGxg+LpfQZko+L5ach6P55Xn0EhEYZ09qUUs5sJshwLwPKsYZJ8s+NM6cWAkIGQgyuM9XAQif5I2uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6413
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/23 19:49, David Rientjes wrote:
> On Wed, 4 Jan 2023, Tom Lendacky wrote:
> 
>>>>> For SEV_GET_ID2, the user provided length does not have a specified
>>>>> limitation because the length of the ID may change in the future.  The
>>>>> kernel memory allocation, however, is implicitly limited to 4MB on x86
>>>>> by
>>>>> the page allocator, otherwise the kzalloc() will fail.
>>>>>
>>>>> When this happens, it is best not to spam the kernel log with the
>>>>> warning.
>>>>> Simply fail the allocation and return ENOMEM to the user.
>>>>>
>>>>> Fixes: d6112ea0cb34 ("crypto: ccp - introduce SEV_GET_ID2 command")
>>>>> Reported-by: Andy Nguyen <theflow@google.com>
>>>>> Reported-by: Peter Gonda <pgonda@google.com>
>>>>> Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
>>>>> Signed-off-by: David Rientjes <rientjes@google.com>
>>>>> ---
>>>>>     drivers/crypto/ccp/sev-dev.c | 9 ++++++++-
>>>>>     1 file changed, 8 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
>>>>> --- a/drivers/crypto/ccp/sev-dev.c
>>>>> +++ b/drivers/crypto/ccp/sev-dev.c
>>>>> @@ -881,7 +881,14 @@ static int sev_ioctl_do_get_id2(struct
>>>>> sev_issue_cmd
>>>>> *argp)
>>>>>     	input_address = (void __user *)input.address;
>>>>>       	if (input.address && input.length) {
>>>>> -		id_blob = kzalloc(input.length, GFP_KERNEL);
>>>>> +		/*
>>>>> +		 * The length of the ID shouldn't be assumed by software since
>>>>> +		 * it may change in the future.  The allocation size is
>>>>> limited
>>>>> +		 * to 1 << (PAGE_SHIFT + MAX_ORDER - 1) by the page allocator.
>>>>> +		 * If the allocation fails, simply return ENOMEM rather than
>>>>> +		 * warning in the kernel log.
>>>>> +		 */
>>>>> +		id_blob = kzalloc(input.length, GFP_KERNEL | __GFP_NOWARN);
>>>>
>>>> We could do this or we could have the driver invoke the API with a zero
>>>> length
>>>> to get the minimum buffer size needed for the call. The driver could then
>>>> perform some validation checks comparing the supplied input.length to the
>>>> returned length. If the driver can proceed, then if input.length is
>>>> exactly 2x
>>>> the minimum length, then kzalloc the 2 * minimum length, otherwise kzalloc
>>>> the
>>>> minimum length. This is a bit more complicated, though, compared to this
>>>> fix.
>>>>
>>>
>>> Thanks Tom.  IIUC, this could be useful to identify situations where
>>> input.length != min_length and input.length != min_length*2 and, in those
>>> cases, return EINVAL?  Or are there situations where this is actually a
>>> valid input.length?
>>>
>>> I was assuming that the user was always doing its own SEV_GET_ID2 first to
>>> determine the length and then use it for input.length, but perhaps that's
>>> not the case and they are passing a bogus value.
>>
>> Except that if the user was always doing that, then we wouldn't be worried
>> about this case then. But, I think my method is overkill and the simple
>> approach of this patch is the way to go.
>>
> 
> Makes sense, thanks for the clarification.  Does that translate into an
> acked-by? :)

Ah, yeah, forgot about that!

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
