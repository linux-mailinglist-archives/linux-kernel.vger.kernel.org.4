Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C988602790
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 10:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiJRIwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 04:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiJRIwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 04:52:36 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2070.outbound.protection.outlook.com [40.107.21.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8861D318;
        Tue, 18 Oct 2022 01:52:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KtC9B0a2QeVcVTBVcXcbqdqClZYDvAGOW6CSWSStgbriElQFdLd0hTibb7HMx0HhH35AbJMEYu7pr41HQlemlOtg/XTQwAzjcFUYssqGFJP4HBpos2obAs/xM89Im1WcbZMfWZYxIt/PaCmXy8VCvPyDv5Emj/512zkrulqg+t2F+konNJmdPYH0aQvb9D4bvRkhdb7h0Dk04bU5mknWWJ+shtgB2PDpc95vcU9+TEaeSWAYU3njS75w8DCrKK3xG/SWWTkSipcTY4Jsg5UAJYJyz/CCkeQi32uys9inC1o7yHceR9+dAf3xQjM3QHqa3Vam/uf4aKSqDe7i82a66A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GMj+hvV5i0LhwojKDczSIeTvpfRzui9xArJtdUU2g/E=;
 b=bmgLRuIlUiUGCq91wABjniuw43YO37wvm8BqAqqUNiDCqnvjyIN2vf1F+FlBQA4u53WkGHKr17syVSbtj0BrBuHd61ta42yfr+ZBwn/8YAW5TkhYO/1YguSyLd1IJG1SkjgLl65rgpucfYvBf7zlsc5d4b0vwAgZ6NfMJU5ThVvuyP+2I/KY4LZ4MkC21TfVWuEGCbyvBkG8SZvyqF1TuXmsjcE9n+HKQNWf5LGQbQehXOIP5Vdi1UIJa+BN1UO5fKJkaWng4quyDtil2hxwrf8W8LzG3//CymZuPSLgBUB4lRdhsa1UwRuBVZ/FP2dqxi+rTftc8qIhKlPb0bN8UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMj+hvV5i0LhwojKDczSIeTvpfRzui9xArJtdUU2g/E=;
 b=szRTqwRCyETNldqTVowak6ZoVV4q5jjslmA8y9leAB2Rc32Xgz40ccrMHujn8oVl1mbqfIvFHCWubuQAqSuswoN27HeezetuBwYZYSZvGT2IBj3kxVYidRIOgGBZT4PsuxrPUdk6BbMaDiCUmvxBntvuH55x0OZYeDyKrIWv/Zz1yQaSxSD7C6jpfWR8I23eUvpRf9rYl7ql5mrAa7wGreVtroQ8LBbMNaqzWt1v0h+ZuzV5ovOEWZNVxS9vhZsA2FUoPHi/6Ck+2bxVLn/RfSlV3vfV2mdN3eWIhF3qUdqQ7KmORUYfQrrDb/2EyZQW/0K9YWPYc2YFijXEpTyVVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16) by DU0PR04MB9420.eurprd04.prod.outlook.com
 (2603:10a6:10:35b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Tue, 18 Oct
 2022 08:52:31 +0000
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::7f81:2760:2539:7115]) by AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::7f81:2760:2539:7115%2]) with mapi id 15.20.5723.030; Tue, 18 Oct 2022
 08:52:31 +0000
Message-ID: <86ed1568-52ce-b030-0fb0-1b902cb222d1@suse.com>
Date:   Tue, 18 Oct 2022 10:52:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 3/4] module: Merge same-name module load requests
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>, mcgrof@kernel.org
Cc:     pmladek@suse.com, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221016123031.3963-1-petr.pavlu@suse.com>
 <20221016123031.3963-4-petr.pavlu@suse.com>
 <d6e6abc4-84ae-0ddf-eb02-9f0537d4bed1@redhat.com>
From:   Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <d6e6abc4-84ae-0ddf-eb02-9f0537d4bed1@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::19) To AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3395:EE_|DU0PR04MB9420:EE_
X-MS-Office365-Filtering-Correlation-Id: b22219f0-a8a5-4bc5-27d5-08dab0e61783
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yGg6ermhAIJs4JJfsLxdDUp/vY7rvEcqMbQeRYJBWucryHmAPPJDbnhjyAT82eQnM4DE2MJl9IRgj+2kZYfe2YJMlc6Z13hdLgopQmW6lDR8OyoW7YNQV89PhPyKkDBdrYswuU0CJn4+7CNLEGBvtcd4u4Uy44DX1iMHsXaCu5iL0ngAEhzAR2zObBgfmOgypLToHCZENAaBc7zTYA2tK8dAquWQsBQlddSHev19icppbaIkuBaUWrKyrCLYIhK6TU2mQH+9mbMYOCJChIow9nKCnfl5yRqUeNQeN3Wvx88NK/b8BWC01yLml9khF310sczozJpLGddgmAxxYj7WhvBmSdqmWFFW087qRJStKyGSx5Mtp9tzdhw/1Dy6I9z5SIvzqOBEaNCqUWYCE842nCqq1g2Y08Oc+L7cm+m2+8dE18T6ZJBntHSkr5jxib8/8Lp/Dljo8ElXsh91DcFmlWZGMf3G454UIksofvXSKSX8JlyHUlYOP77TRDeneygO/C1bb1e0VVQM6SCawbQlGiDZoIjK5V6+f7Yhjfd1VbrlLumI6Yw4YPgtEkbmNf0YZbB8GrvbzgHyBZNuSVlx1VSkZ3inebM9Yc/uxmXDI2xQfy3QSGj+XtntKClS3SL3HhXcRyBdSE1kbewwiyWqZpAe67vNCuMznTzwKDwpT1WwjNmMyxnRFi6lNh8xzkxVz4ljHFVNNCU62N3/4MxI0tRwLtzSbvxqRQe0mWcxAlNqqzuJb0xb6RbffldHHyK6IfqIeO9ModLLmn0g19+Vy7h5JB5b/ov9YfzzgSyAbq0otzHnNVGq0Oqx+YzF+iR/VmoWMdMJp/0qdP4MyUnYt6aaoRl97c1lMt5ZIeOpSwo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3395.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(346002)(39860400002)(396003)(136003)(451199015)(31686004)(44832011)(30864003)(66476007)(316002)(55236004)(41300700001)(6506007)(66899015)(4326008)(8676002)(6512007)(478600001)(66556008)(26005)(53546011)(186003)(2906002)(6486002)(966005)(5660300002)(2616005)(8936002)(36756003)(83380400001)(38100700002)(66946007)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVFaZjYvZmMxY1ZMRXFXVVpyMWg1S0Y2MllKTHlBeWV0SFV0bUIwL1BYY1hV?=
 =?utf-8?B?U3hLZUdxK0U3Q3p2M0RjVE5CaWFqKy9KZUJFb2RLRmNWRk8xMS9ORlM4d0hk?=
 =?utf-8?B?ZTZGSThWa3NTUU56UHZIWHlXNEVucU1xQit6QU9JMFdRT09GRk9NL0ZXSzlL?=
 =?utf-8?B?cGRUUWk0UEFWQVpUVkFqQzAxNXNhY1QrL09wSHFaRlNwandyTndHa1k1WXNy?=
 =?utf-8?B?aEM2LzBpVUxnMVZHREltbGFMZUUwMTZHR0tHVU1GcHhxb0FEWFEyVTVPcS9L?=
 =?utf-8?B?Tmd5cTJZRW5HQXV6ZVc0amJWdjVHc1IwdzlKOU1XdTFqa0JmY283SkVXTmpo?=
 =?utf-8?B?MG56aWdkK2VwNlpuS3YxTVZRUVlmRU5hcDA4V0VEWmJqclNLOEQ3NlVVaTVz?=
 =?utf-8?B?Z29SdXhoYWJMeVBBRW1reXlSSUxrZFNtdlhCY3JSRlBvajIzRCt5MVExYjd5?=
 =?utf-8?B?VzkxNTdwbmZHMDM1S1dSQ0o3NkJTY3k5WVgwNVQ4V0FpS1VtOVYzdjY0SDdy?=
 =?utf-8?B?S213RWhadUtOQVk5U0ZZN2Z0SmhGZ0haajlrZkZiTnBuMk1YQkNSWkp4K3N1?=
 =?utf-8?B?Nk9xRlZpeTRxbTliVnkzVHhJemNkMkdjYTAvL3FRKzdxcXA1WHNvRmJDc2Yw?=
 =?utf-8?B?aldqR29LOExpcWFFTHRXeXV6anBiYjl1em82MzhwTk5DQmJaTzlFUkQxZndo?=
 =?utf-8?B?R3lSaHloaUFONGNPRFV2S2FFTk9aZ0VHYU01Vm9McTNpVm5SbXR4RFBpa1Qr?=
 =?utf-8?B?V3Z4UGp2VDdlam82Z3ZqOVB0YlRBQ2xzS0lsc29NalBTMTgwYXhmUHk3NzUv?=
 =?utf-8?B?eUQ5OXhiVDdBcWJHeXpQVXV3ZnR6dHFHK2FVYzdDV0hxYWRaT3lsYmdJVnlK?=
 =?utf-8?B?eE1zajVaSjVqSWF0OHBwUUF5VHNOMHRmdE5XVXNQMlZzRm1VaFY3dkM3S0NE?=
 =?utf-8?B?NHR0dFNCeHkvenRlVFNhZGdadytpK25WVVdiaEtHRGJUY0EzdUpGWE4xUith?=
 =?utf-8?B?RWdjQjlwVDFVaUdMenlEYTBpNU4xWXEzczNYQlEzOUNQN3c5bVJ5S2gyeDVv?=
 =?utf-8?B?cEFQbEF2TnZSUkFHblJlMkYwQlIva1BOYWFkVGxjVEVNUVNHQ3pJQUM3ckhF?=
 =?utf-8?B?a0xoQ1lIQ2ZyRVZscGpWcWVkWms4VHBhMnNCRk1aQXN2anVFQXFXV1ZRVWtn?=
 =?utf-8?B?cks5RzlDWHBiSThJQ3Q1RExrMlVaUjc5cmJDM0Yzb3MxZzI5UWRHRlh0SHpI?=
 =?utf-8?B?VGkzdFlhUGVaZXB1aDFZYUhmTHhmUVhRaE5LZzRnc3c4ckxheVozT0ZoSHlL?=
 =?utf-8?B?ZVEybm5LNU5Xd2xUeEJBV2VjSUZ5cFFjdm9hNGg1U0FPOGtSaW56QXZiVERw?=
 =?utf-8?B?MkVJQmlqS05aSXpDei8yVlhFNG0xMFUxRTdDTnNmUXNhRXJyZGRtcCtyV3Fk?=
 =?utf-8?B?Q2JaeVd3Q2pHSy9rNCtESkJQbncwWWppTkNjTnVYSnRKbmlxbmFlN1pRTWJL?=
 =?utf-8?B?Tld2NDg1M0tkN1BON3dYcVUrSHc1TUw4eWI0dzJZVE4vSk8zQmpEem5sd2ZW?=
 =?utf-8?B?Rmc3VktKZitQdTdYZmI5bDVKbkppWGJHSWJSNzMvcVRLYllqa1hiQjVwc1lk?=
 =?utf-8?B?TENud2xFVm9KWjlCUUpGRHYyTXBmUXZOWWpGZ05jL1k0QURaOWlSQVRrMDlL?=
 =?utf-8?B?RGh0Tk5mY3NlQUlsMHVDUjEzZXdIZjZxVDFCSTlXSXdTZ21FSmJoOVFxbXRB?=
 =?utf-8?B?MGZsS3h5M1A5dml6cWdXU0YrVmZmNXRId1FtRCtjUEtCZWRXbGVqdnJkNVRw?=
 =?utf-8?B?Q1FLYndsYW1Kc0lweGFybGs3TS9kQmt4aGZmTFlkWmNtMkdGUE5idytiRFp2?=
 =?utf-8?B?WVhFYmNNOTJyRlpjTFQxbGJrR2FJc05wT2duTkc4dDdoencrd0JTdWlkT1JO?=
 =?utf-8?B?SWhFMGRncG5wK2Viem1TN2ZNMUs0TERVNmdiZ3RxTlB0Y1FEd01yR1FFQkV2?=
 =?utf-8?B?S3pYNExheVNvZTJvbGRBT2RJdU9MWkxiSU1QaUFSMW1uRmtXY1pBT2N6Qmxo?=
 =?utf-8?B?VStEVG04K1NuSEM2SjE1NXN0ZzVEMSt6RmFGRnBNdmZObVZrS1VJSkhPdTlw?=
 =?utf-8?Q?iqlpfFipiSuhplBYy81vXcMp8?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b22219f0-a8a5-4bc5-27d5-08dab0e61783
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3395.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 08:52:31.1190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ENGPbMih15gRa4bz3LRbkpAC7Ostq8cfF75bxEnpdv4UGwTp04ANr0cT9CopfWpAZyumyvanjkHB3qnISiitbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9420
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/22 09:43, David Hildenbrand wrote:
> On 16.10.22 14:30, Petr Pavlu wrote:
>> During a system boot, it can happen that the kernel receives a burst of
>> requests to insert the same module but loading it eventually fails
>> during its init call. For instance, udev can make a request to insert
>> a frequency module for each individual CPU when another frequency module
>> is already loaded which causes the init function of the new module to
>> return an error.
>>
>> The module loader currently serializes all such requests, with the
>> barrier in add_unformed_module(). This creates a lot of unnecessary work
>> and delays the boot. It can prevent udev from loading drivers for other
>> devices and might cause timeouts of services waiting on them and
>> subsequently a failed boot.
>>
>> The mentioned serialization was introduced as a side-effect of commit
>> 6e6de3dee51a. The kernel before that merged some of same load requests
>> although it was more by accident and relied on specific timing. The
>> patch brings this behavior back in a more explicit form.
>>
>> The logic is improved as follows:
>> * A check whether a module load matches an already loaded module is
>>    moved right after a module name is determined. -EEXIST continues to be
>>    returned if the module exists and is live, -EBUSY is returned if
>>    a same-name module is going.
> 
> Can you clarify why the EBUSY change is needed? Why not simply return 
> EEXIST?
> 
> If you have thread 0 loading the module and thread 1 unloading the 
> module concurrently, then it's pretty much unpredictable what the 
> outcome will be either way, no?
> 
> Add a random sleep to thread 1 (such that the module is *not* going yet) 
> and the result will be EEXIST.
> 
> I suggest avoiding a EBUSY change unless there is real reason to do so.
> 
> User space that concurrently loads and unloads the same module is shaky 
> already, no?

I cannot quite think of a scenario where it would practically matter how this
corner case is handled. Prior to 6e6de3dee51a ("kernel/module.c: Only return
-EEXIST for modules that have finished loading"), an init_module() call would
have returned EEXIST in this case. After the mentioned commit, the loader
waits for the old module to be gone and then proceeds with the load. Finally,
this patch changes init_module() to immediately return EBUSY.

With the proposed changes, EEXIST and EBUSY is used as follows:
* EEXIST is returned from init_module() if a given module is already loaded or
  becomes live by a parallel load.
* EBUSY is returned if a concurrent operation is detected on a module with the
  same name and the module is not live. This applies to both init_module() and
  delete_module().

I think it is generally a good idea to return EEXIST from init_module() only
if a given module is fully operational. Userspace (udev) typically handles
EEXIST as "success" and so there is some potential for confusion otherwise.

However, I don't feel strongly about this particular case.

>> * A new reference-counted shared_load_info structure is introduced to
>>    keep track of duplicate load requests. Two loads are considered
>>    equivalent if their module name matches. In case a load duplicates
>>    another running insert, the code waits for its completion and then
>>    returns -EEXIST or -EBUSY depending on whether it succeeded.
>>
>> Moving the check for same-name module loads earlier has also a positive
>> effect on reducing memory pressure. For instance, David Hildenbrand and
>> Lin Liu reported [1] that when KASAN_INLINE is enabled (resulting in
>> large module size), with plenty of devices that udev wants to probe and
>> with plenty of CPUs that can carry out that probing concurrently, the
>> system can actually run out of module vmap space and trigger vmap
>> allocation errors. This is fixed by the patch too as it avoids duplicate
>> layout_and_allocate() work.
> 
> It might we reasonable to add the kernel messages here. Can you also add 
> the Reported-by?

Ok, I avoided adding the Reported-by tag because I was not sure how to
properly record that it applies only to the vmap allocation issue. I suspect
it can be clarified after the tag in a "[...]" note.

My plan is to add the following:

[  165.842123] vmap allocation for size 2498560 failed: use vmalloc=<size> to increase size
[  165.843359] vmap allocation for size 2498560 failed: use vmalloc=<size> to increase size
[  165.844894] vmap allocation for size 2498560 failed: use vmalloc=<size> to increase size
[  165.847028] CPU: 253 PID: 4995 Comm: systemd-udevd Not tainted 5.19.0 #2
[  165.935689] Hardware name: Lenovo ThinkSystem SR950 -[7X12ABC1WW]-/-[7X12ABC1WW]-, BIOS -[PSE130O-1.81]- 05/20/2020
[  165.947343] Call Trace:
[  165.950075]  <TASK>
[  165.952425]  dump_stack_lvl+0x57/0x81
[  165.956532]  warn_alloc.cold+0x95/0x18a
[  165.981219]  __vmalloc_node_range+0x291/0x560
[  166.003741]  module_alloc+0xe7/0x170
[  166.011840]  move_module+0x4c/0x630
[  166.015751]  layout_and_allocate+0x32c/0x560
[  166.020519]  load_module+0x8e0/0x25c0
[  166.053854]  __do_sys_finit_module+0x11a/0x1c0
[  166.068494]  do_syscall_64+0x59/0x90
[  166.095855]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  165.818200] vmap allocation for size 2498560 failed: use vmalloc=<size> to increase size

Reported-by: Lin Liu <linl@redhat.com>
Reported-by: David Hildenbrand <david@redhat.com>
[the vmap allocation issue]

>>
>> [1] https://lore.kernel.org/all/20221013180518.217405-1-david@redhat.com/
>>
>> Fixes: 6e6de3dee51a ("kernel/module.c: Only return -EEXIST for modules that have finished loading")
>> Reviewed-by: Petr Mladek <pmladek@suse.com>
>> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
>> ---
>>   kernel/module/main.c | 217 ++++++++++++++++++++++++++++++-------------
>>   1 file changed, 155 insertions(+), 62 deletions(-)
>>
>> diff --git a/kernel/module/main.c b/kernel/module/main.c
>> index 5288843ca40f..2228c0f725e7 100644
>> --- a/kernel/module/main.c
>> +++ b/kernel/module/main.c
>> @@ -66,11 +66,28 @@
>>    *    uses RCU list operations).
>>    * 2) module_use links,
>>    * 3) mod_tree.addr_min/mod_tree.addr_max,
>> - * 4) list of unloaded_tainted_modules.
>> + * 4) list of unloaded_tainted_modules,
>> + * 5) list of running_loads.
>>    */
>>   DEFINE_MUTEX(module_mutex);
>>   LIST_HEAD(modules);
>>   
>> +/* Shared information to track duplicate module loads. */
>> +struct shared_load_info {
>> +	char name[MODULE_NAME_LEN];
>> +	refcount_t refcnt;
>> +	struct list_head list;
>> +	struct completion done;
>> +	int err;
>> +};
>> +static LIST_HEAD(running_loads);
>> +
>> +/*
>> + * Waiting for a module load when the exact module name is not known, for
>> + * example, when resolving symbols from another modules.
>> + */
>> +static DECLARE_WAIT_QUEUE_HEAD(module_wq);
>> +
>>   /* Work queue for freeing init sections in success case */
>>   static void do_free_init(struct work_struct *w);
>>   static DECLARE_WORK(init_free_wq, do_free_init);
>> @@ -124,9 +141,6 @@ static void mod_update_bounds(struct module *mod)
>>   int modules_disabled;
>>   core_param(nomodule, modules_disabled, bint, 0);
>>   
>> -/* Waiting for a module to finish initializing? */
>> -static DECLARE_WAIT_QUEUE_HEAD(module_wq);
>> -
>>   static BLOCKING_NOTIFIER_HEAD(module_notify_list);
>>   
>>   int register_module_notifier(struct notifier_block *nb)
>> @@ -764,8 +778,6 @@ SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
>>   	strscpy(last_unloaded_module.taints, module_flags(mod, buf, false), sizeof(last_unloaded_module.taints));
>>   
>>   	free_module(mod);
>> -	/* someone could wait for the module in add_unformed_module() */
>> -	wake_up_interruptible(&module_wq);
>>   	return 0;
>>   out:
>>   	mutex_unlock(&module_mutex);
>> @@ -2373,26 +2385,6 @@ static int post_relocation(struct module *mod, const struct load_info *info)
>>   	return module_finalize(info->hdr, info->sechdrs, mod);
>>   }
>>   
>> -/* Is this module of this name done loading?  No locks held. */
>> -static bool finished_loading(const char *name)
>> -{
>> -	struct module *mod;
>> -	bool ret;
>> -
>> -	/*
>> -	 * The module_mutex should not be a heavily contended lock;
>> -	 * if we get the occasional sleep here, we'll go an extra iteration
>> -	 * in the wait_event_interruptible(), which is harmless.
>> -	 */
>> -	sched_annotate_sleep();
>> -	mutex_lock(&module_mutex);
>> -	mod = find_module_all(name, strlen(name), true);
>> -	ret = !mod || mod->state == MODULE_STATE_LIVE;
>> -	mutex_unlock(&module_mutex);
>> -
>> -	return ret;
>> -}
>> -
>>   /* Call module constructors. */
>>   static void do_mod_ctors(struct module *mod)
>>   {
>> @@ -2523,7 +2515,6 @@ static noinline int do_init_module(struct module *mod)
>>   		schedule_work(&init_free_wq);
>>   
>>   	mutex_unlock(&module_mutex);
>> -	wake_up_interruptible(&module_wq);
>>   
>>   	return 0;
>>   
>> @@ -2539,7 +2530,6 @@ static noinline int do_init_module(struct module *mod)
>>   	klp_module_going(mod);
>>   	ftrace_release_mod(mod);
>>   	free_module(mod);
>> -	wake_up_interruptible(&module_wq);
>>   	return ret;
>>   }
>>   
>> @@ -2551,43 +2541,138 @@ static int may_init_module(void)
>>   	return 0;
>>   }
>>   
>> +static struct shared_load_info *
>> +shared_load_info_alloc(const struct load_info *info)
>> +{
>> +	struct shared_load_info *shared_info =
>> +		kzalloc(sizeof(*shared_info), GFP_KERNEL);
>> +	if (shared_info == NULL)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	strscpy(shared_info->name, info->name, sizeof(shared_info->name));
>> +	refcount_set(&shared_info->refcnt, 1);
>> +	INIT_LIST_HEAD(&shared_info->list);
>> +	init_completion(&shared_info->done);
>> +	return shared_info;
>> +}
>> +
>> +static void shared_load_info_get(struct shared_load_info *shared_info)
>> +{
>> +	refcount_inc(&shared_info->refcnt);
>> +}
>> +
>> +static void shared_load_info_put(struct shared_load_info *shared_info)
>> +{
>> +	if (refcount_dec_and_test(&shared_info->refcnt))
>> +		kfree(shared_info);
>> +}
>> +
>>   /*
>> - * We try to place it in the list now to make sure it's unique before
>> - * we dedicate too many resources.  In particular, temporary percpu
>> + * Check that a module load is unique and make it visible to others. The code
>> + * looks for parallel running inserts and already loaded modules. Two inserts
>> + * are considered equivalent if their module name matches. In case this load
>> + * duplicates another running insert, the code waits for its completion and
>> + * then returns -EEXIST or -EBUSY depending on whether it succeeded.
>> + *
>> + * Detecting early that a load is unique avoids dedicating too many cycles and
>> + * resources to bring up the module. In particular, it prevents temporary percpu
>>    * memory exhaustion.
>> + *
>> + * Merging same load requests then primarily helps during the boot process. It
>> + * can happen that the kernel receives a burst of requests to load the same
>> + * module (for example, a same module for each individual CPU) and loading it
>> + * eventually fails during its init call. Merging the requests allows that only
>> + * one full attempt to load the module is made.
>> + *
>> + * On a non-error return, it is guaranteed that this load is unique.
>>    */
>> -static int add_unformed_module(struct module *mod)
>> +static struct shared_load_info *add_running_load(const struct load_info *info)
>>   {
>> -	int err;
>>   	struct module *old;
>> +	struct shared_load_info *shared_info;
>>   
>> -	mod->state = MODULE_STATE_UNFORMED;
>> -
>> -again:
>>   	mutex_lock(&module_mutex);
>> -	old = find_module_all(mod->name, strlen(mod->name), true);
>> -	if (old != NULL) {
>> -		if (old->state != MODULE_STATE_LIVE) {
>> -			/* Wait in case it fails to load. */
>> +
>> +	/* Search if there is a running load of a module with the same name. */
>> +	list_for_each_entry(shared_info, &running_loads, list)
>> +		if (strcmp(shared_info->name, info->name) == 0) {
>> +			int err;
>> +
>> +			shared_load_info_get(shared_info);
>>   			mutex_unlock(&module_mutex);
>> -			err = wait_event_interruptible(module_wq,
>> -					       finished_loading(mod->name));
>> -			if (err)
>> -				goto out_unlocked;
>> -			goto again;
>> +
>> +			err = wait_for_completion_interruptible(
>> +				&shared_info->done);
>> +			/*
>> +			 * Return -EBUSY when the parallel load failed for any
>> +			 * reason. This load might end up another way but we are
>> +			 * not going to try.
> 
> Why not? Usually "-EAGAIN" signals that user space should retry. But I 
> hope that we can avoid EBUSY altogether and simply retry here.
> 
> I'd suggest shared_load_info_put()+retry.
> 
> No need to optimize for corner cases (concurrent load failing so we 
> don't retry ourselves).

Avoiding a retry in this case is actually the main motivation for this patch.
It looks I'm still failing to explain this in the commit message, but please
see my replies on previous versions of the patch where I provided more details
about the observed issue [1, 2].

Worth noting is that both your scenario and my case are situations where
a same module is attempted to be loaded multiple times, once per each CPU.
Even if only one attempt is eventually fully processed, the decision that
other parallel loads are not needed happens quite late. In particular, udev
(libkmod) still has to load and decompress a given module binary multiple
times. Ideally, I think this should be prevented altogether by improving other
parts of the whole process. Udev could be made smarter to avoid duplicate
loads or the kernel could model uevents related to CPUs differently. This is
something that I was also considering but eventually settled on trying to fix
only the immediate kernel regression.

>> +			 */
>> +			if (!err)
>> +				err = shared_info->err ? -EBUSY : -EEXIST;
>> +			shared_load_info_put(shared_info);
>> +			shared_info = ERR_PTR(err);
>> +			goto out_unlocked;
>> +		}
>> +
>> +	/* Search if there is a live module with the given name already. */
>> +	old = find_module_all(info->name, strlen(info->name), true);
>> +	if (old != NULL) {
>> +		if (old->state == MODULE_STATE_LIVE) {
>> +			shared_info = ERR_PTR(-EEXIST);
>> +			goto out;
>>   		}
>> -		err = -EEXIST;
>> +
>> +		/*
>> +		 * Any active load always has its record in running_loads and so
>> +		 * would be found above. This applies independent whether such
>> +		 * a module is currently in MODULE_STATE_UNFORMED,
>> +		 * MODULE_STATE_COMING, or even in MODULE_STATE_GOING if its
>> +		 * initialization failed. It therefore means this must be an
>> +		 * older going module and the caller should try later once it is
>> +		 * gone.
>> +		 */
>> +		WARN_ON(old->state != MODULE_STATE_GOING);
>> +		shared_info = ERR_PTR(-EBUSY);
> 
> As raised above, why not EEXIST? Concurrent loading+unloading is racy 
> either way.

Discussed above.

>>   		goto out;
>>   	}
>> -	mod_update_bounds(mod);
>> -	list_add_rcu(&mod->list, &modules);
>> -	mod_tree_insert(mod);
>> -	err = 0;
>> +
>> +	/* The load is unique, make it visible to others. */
>> +	shared_info = shared_load_info_alloc(info);
>> +	if (IS_ERR(shared_info))
>> +		goto out;
>> +	list_add(&shared_info->list, &running_loads);
>>   
>>   out:
>>   	mutex_unlock(&module_mutex);
>>   out_unlocked:
>> -	return err;
>> +	return shared_info;
>> +}
>> +
>> +static void finalize_running_load(struct shared_load_info *shared_info, int err)
> 
> s/finalize/release? It would be nice if the name could correspond to an 
> opposite action of "add_running_load".
> 

Ok, I can change this.

Note though that functions add_running_load() and finalize_running_load() are
not exactly opposite actions. I tried to avoid using "release" because it
typically suggests to me a simple free of resources while
finalize_running_load() still does some important work.

>> +{
>> +	/* Inform other duplicate inserts that the load finished. */
>> +	mutex_lock(&module_mutex);
>> +	list_del(&shared_info->list);
>> +	shared_info->err = err;
>> +	mutex_unlock(&module_mutex);
>> +
>> +	complete_all(&shared_info->done);
>> +	shared_load_info_put(shared_info);
>> +
>> +	/* Tell other modules waiting on this one that it completed loading. */
>> +	wake_up_interruptible(&module_wq);
>> +}
>> +
> 
> 
> [...]
> 
>>    sysfs_cleanup:
>>   	mod_sysfs_teardown(mod);
>> @@ -2880,15 +2973,15 @@ static int load_module(struct load_info *info, const char __user *uargs,
>>   	/* Unlink carefully: kallsyms could be walking list. */
>>   	list_del_rcu(&mod->list);
>>   	mod_tree_remove(mod);
>> -	wake_up_interruptible(&module_wq);
>>   	/* Wait for RCU-sched synchronizing before releasing mod->list. */
>>   	synchronize_rcu();
>>   	mutex_unlock(&module_mutex);
>> - free_module:
>>   	/* Free lock-classes; relies on the preceding sync_rcu() */
>>   	lockdep_free_key_range(mod->data_layout.base, mod->data_layout.size);
>>   
>>   	module_deallocate(mod, info);
>> + free_shared:
> 
> Ideally, the label matches what's actually being done. So maybe 
> "release_shared" if you go with "release_..."

Ok.

[1] https://lore.kernel.org/linux-modules/0ccb384f-bbd5-f0fd-3832-c2255df505b2@suse.com/
[2] https://lore.kernel.org/linux-modules/aa8d9456-b260-d999-0296-8e6ab876af7a@suse.com/

Thanks,
Petr
