Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2491163C0C6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 14:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbiK2NOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 08:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233813AbiK2NOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 08:14:23 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2045.outbound.protection.outlook.com [40.107.20.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6293263158;
        Tue, 29 Nov 2022 05:13:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TuqCdBDB9Hm4ZiD2B5TZU6E60RNJHkhg+d10Yi3JIYqmpSYephi11pmeTQNvXNyURn17RFILrdNSIaWsSd/Oh4K2MUGEIAtlR9gDtmtu9G3ggRnD6REmmsek5y0QYsQnyFjWO+JkTb1Ea/iU+MvndIlEE0reX+ICWJsC/COJroQj3I/8LJCgT4SDbmB+i5HhSOpWf7O+n1YwQLfeVHzR92nM5bnxGdTKuojvsLD5nFfhT7t/8HuKEW9/avGt50r0LbWlJdBl8gmTWGuwfsL0KF739h9l3XAEUTEL4P7MfuMuXU3cOR7M2UM7IB3EUFr6+rJAQTlOlnc+Pe5fvItl0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ddLoPqUlGwN54qz/sZSyEFbmj1Q4v1kwEK4epfP/bo=;
 b=nu43Su27CxJOkIhRgxjSt6MLOyFTVC2XbFzv3Gl0+EVhazm4F/ur/lQgLUAEcuxf6k2Cl0wTKklG1Kl3aupjJe05FK441ufEG7oykyKoDU8zV2iYpAxnXaDTSlnNGTAM+RG3mGnCjrabM8ComizSa3Kq/k/my+T8AOtMzq2KThnERlomqbX2lZr/cQ+DJSTGhyHgXixcpyPU5OU98jitP5HC5H4MLSUByVC0beI2Q7NqF1jITqAQjBezgKEkRucI9TjAjxXr7+m/Ih6BwsxJx5EX5tchgwVY2Zhfo6cQml+VCmMgark4Yw9smV2GTF5vehKfsBKcfQ+E56zuXiXD2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ddLoPqUlGwN54qz/sZSyEFbmj1Q4v1kwEK4epfP/bo=;
 b=ixML41x2FfewdTQnV7SzN913lTdCSR30Uoom3S7HQlxTvJxoAmS2m4r6eMB/HDTdw2qkie/2ca0ky6I63FkC1n0Ays1GnokRvGXF2P6seYKJK+8oXwhJoqORBogSgjDu4cFJ0Ns2LV8XvuBwaCnPp+AzahlVNEqy4/TD4Q8fohOt5m2puQ17zFTh1CPWJDlsj90yH95Jz81ue3j4T7CxWPxNaw0uWi66p6bVgHeBuxRR9egOXhcrXlf7lv0LpxUWxySKrF8jgPFqznVLriIpYGfxs5Z02YCNwTrI9IPim+XYvma+xfxM6pKd5U9hkHgwXRuqtX5eycHGzvtyRswKwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16) by DBBPR04MB7753.eurprd04.prod.outlook.com
 (2603:10a6:10:1e1::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.20; Tue, 29 Nov
 2022 13:13:40 +0000
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::14eb:6506:8510:875f]) by AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::14eb:6506:8510:875f%7]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 13:13:39 +0000
Message-ID: <2ac0b871-60d0-c535-3fe0-bfaa0d9f7685@suse.com>
Date:   Tue, 29 Nov 2022 14:13:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 2/2] module: Merge same-name module load requests
Content-Language: en-US
To:     Prarit Bhargava <prarit@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     pmladek@suse.com, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220919123233.8538-1-petr.pavlu@suse.com>
 <20220919123233.8538-3-petr.pavlu@suse.com>
 <YzdR0gRNQI2BGnJ9@bombadil.infradead.org>
 <aa8d9456-b260-d999-0296-8e6ab876af7a@suse.com>
 <Y07xX2ejlg0oFoEy@bombadil.infradead.org>
 <d0bc50e3-0e42-311b-20ed-7538bb918c5b@suse.com>
 <Y277Jb9i2VeXQoTL@bombadil.infradead.org>
 <e070839f-c224-047b-9411-91143c1d8394@redhat.com>
 <Y3Jg8X7qv2AKPU1J@bombadil.infradead.org>
 <5467e66d-55de-ca8f-c1ae-ffe6efe7290d@redhat.com>
 <94cd5565-1058-2c97-57bb-0ddf12416cd6@redhat.com>
From:   Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <94cd5565-1058-2c97-57bb-0ddf12416cd6@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0173.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::8) To AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3395:EE_|DBBPR04MB7753:EE_
X-MS-Office365-Filtering-Correlation-Id: a0314f4f-10d6-4b21-fc22-08dad20b8803
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EySiwnHeGvQYZmpc1twdhv7RrR7fujvNjhNczVJLAJP5jiGhwjBxbCbiyNGAFR9PclHEmBlgPvFFaZP+RFyrYo34Trn1LWV+ZrbYX6DKfQ0oi17+uwqrxHqXKh7/07zwqkOe7sbj+EhQXpwlwRn1/HvE6V5iYKDlArgrQ8/OplcFB4BFRBPWaB8+pIIUADVhFsqPD8h1Z76lkISsbOll1RFV3beooY1TtWURbrsZBCbc6L7jfG1OkFm0j2UegNxZxu+nM26D627DdUiohILkMpH5Br03C8QxvIjeBBGkos3JdD/9+leeJOZydSd0ieEeVSaYmFAOyINM5NUd877Pmq6PfEB/wGS99bTKvfwNLQM+N0GkTfxjAXiISy0AhVqB1L9+jST+hArZ2DC/iD2SkdG+Sl+yA9u2ZDaz15O1qIZetWQuJ3RN9PfEm2/EzphqnSu6k3j3x3Zjx7cbzsmj+Am5lMmVNHQViWpPFxnq1Ed7Vi2HbNDL9WN6/9yZxmEKDzaQfoZeG2wuAVzuI6BzAXewcLomvl9UuisTwC36Q263tuatjfG7dNOP4FfjifT46gjHBEAGgiU7I9CoZ6ZVKmt7NI+tJmJWEezxsQbb7F8HoyEJ1VyUzrX3t859F3+NGdp/6drU7Agal+hnXErmt9K82lXbAnFwxum7oG1clWx0azexlCPp4XyOV5g6tLl1es20MaJ5no7e6Kib/BJcTCNOJCV0XY+WGgiLlHJd8bQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3395.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(366004)(376002)(39860400002)(346002)(451199015)(6486002)(186003)(41300700001)(31686004)(478600001)(2616005)(36756003)(110136005)(38100700002)(6506007)(316002)(26005)(6512007)(55236004)(66946007)(86362001)(31696002)(66476007)(4326008)(66556008)(8676002)(8936002)(5660300002)(53546011)(2906002)(83380400001)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1l1WW5MTTlnbXdiQmZlaDR1Y2dBc0ljWlVmclMxcGMyVjYvZ3VJSDJKQUYw?=
 =?utf-8?B?azJNeGRRdTVEZzE3WVJkOTRmN0pFVE50NHA0TlJ1a3RXS3pxc3lNaTBLOTY4?=
 =?utf-8?B?d1F3WnU4cUMvM25sNzF4anBPMWlrMVNzUCt2dG5kU2FRSm1wWWhVY2ZkemdL?=
 =?utf-8?B?N2E3elVEWDN3Ni93VXhaRGhtWDdYZHZScVE5ZDZIUGdmZ2lreUhlSDBwZUcx?=
 =?utf-8?B?TjdzWlVLNmhRM1cveS9ZMVR3d0tJS3NmVVlCMnNhdWVzUDBreEgzRm5ycWlT?=
 =?utf-8?B?TDU1eVpsdjEvMnZybjZRYjNZWmZaNTdrNk5CVlVJbXI5Rkcwa0pZendPbkV6?=
 =?utf-8?B?TjZkSit2VlZuTGVOdTgvSjI2bG1KaVVabEZqa1RucXNLQ1FSMzJyblFyUmYr?=
 =?utf-8?B?bWd1L25XL1lmZ29NNjduTEFWZTBhZisrREFMY0JLZHgzcUZOY3E4QVlja0Ur?=
 =?utf-8?B?eG42KzIyM3U5aXluTGFrSG5ZV21yVW5JbW8xbHRwV1NzNEF4SU9LRHFwck1F?=
 =?utf-8?B?M3Jac3V5dTN3VERnMlZFRmNFcjJWMlJiNnY2V0JWYU83R210Y0NkYWR5WEhS?=
 =?utf-8?B?YXl2bG82cmpncWo1T2JXZmhkZC9CZDRmUjcwaVdnK3ZkMUpoZVNnTk0zbGJO?=
 =?utf-8?B?cFZwcnEzc0x2c1JMTjVLTmJ6UDZId3B6VmZGR3Rsdlk0NVE2SmJlN29XQjhX?=
 =?utf-8?B?UkJxeXZSYVE4eXloSWdyTGpTZmEva0pWejJ2V3FJcldmN1o3dDdkS2pjalBH?=
 =?utf-8?B?eWFGd0pGakROR25SZDlyeUlRTERiV0dYbFVibnNlVnB4d2JHeFN1ZnJDQSts?=
 =?utf-8?B?dnZEWjVpWnNHWkp4ZE1yL3podEhYb0hadEd1eGdrdGVIKzY0bno3blVCNkZn?=
 =?utf-8?B?WWJSeElmMDJ4VFljZUUycDhpRU1kaEFETTF2SnZoMTJ4Nmp6ZVA1MVVzaHdR?=
 =?utf-8?B?VjBvSlRaaVlEL21ocHAyakk1cmxSczZiL1FLbXJzMTltcGhkVFczcGxuZ1BY?=
 =?utf-8?B?bG5EMjhYeDlZaHRHQllLTnVSME1HbEVlSXdjUmo4emZ6eHVzc2E4c3A0Yyth?=
 =?utf-8?B?NTZlWmloMnl5QWc4OFRyMEx4aEorRmNQZEEydXEzSjhQQ3pzK3ZBejc5ck5E?=
 =?utf-8?B?cnBTV0orMlp2WTE0ZjdadzdEUlZObElzZi92dXBNQmxLYmNNNlpQVzNUcHU3?=
 =?utf-8?B?Z0tYZ3BZbjgzYktDQlJ1Z2VFS21UVFdUS3FKNXg3RCtJZEF0K0Vqa3JuWW9U?=
 =?utf-8?B?dCs0OEgzcmV4VUh4aHNVNGNma0FvUnA2MGw5U0xGVzRBTzlSYVdyMFN4UWNO?=
 =?utf-8?B?QU1tUUNSSllKejl1aUhuMlcyWVZ4T2FDbXlmaUZWaDhnWE94Z3Q4RjZxVUVM?=
 =?utf-8?B?Qloybm9ZQzQxUWhFTmFyMnRXWmcxYjFNNnM3WlU0M0dyNzVGdVA5a0VzNmR1?=
 =?utf-8?B?MElOMExuU0hsaDVMSVVWc29uRUxzUG5wNHZTWUxsMVd1YnhUVXBLWldISUYv?=
 =?utf-8?B?bStWcVJHamd2MVV5NmU5OCtjNnpCeEtDNDlxR0paSHdvRVRpK1hOWEwrNk50?=
 =?utf-8?B?YU9xdXQwT1BBcWQ3a0NlcVkrNUExQ3VVN0R6ZGRBTDRodFdYdkp1RHdTMHdu?=
 =?utf-8?B?cjlOcEdPK3cyZk5qWlZzRGdqZ1lSWmhNUTJvVzBkU0F5SXZrd2pmV2JzYnNp?=
 =?utf-8?B?R3h6L1AwdmJpMW1mcXExM0RJNEJxejVLdEJJeHZPTVcwY2s3b0NYQ1BHYUJm?=
 =?utf-8?B?WVZwNjlQUUFCQ01ldXVEeHo4V1pSbk5taE1EYVdmUVVXTDZCMzRhaFdncUNG?=
 =?utf-8?B?aFFmaVIvTGduczFPRFlUbmtINFRUaURSaXJ6a2lHS0hNWmpMT1kycHlCcnVa?=
 =?utf-8?B?Skw5UzFwTkltQW16MDl6MmplOUlBZWMxaWJBdkM4UkF1Sytva1Q5NU9lNjZG?=
 =?utf-8?B?aUZjd0RzUHNrcFg5TXU5RG41MmFaWjY5LzFHY1J6eUI2bytXc00yRlEzb0JI?=
 =?utf-8?B?UDNJdTllS3M5VlFYdytMbkY3OHMxM3UwNlB6V0hVZitKMDh6bkVTMFN6Njhh?=
 =?utf-8?B?SXpzZlhucThDMTZjeEtHajBRYUNLSVBWM0ZuR0NJTmkrQTJ3d2JzVkMvQnc0?=
 =?utf-8?Q?FHU09h/fGX+MNjGlwQVe+1J4M?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0314f4f-10d6-4b21-fc22-08dad20b8803
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3395.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 13:13:39.8219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: imr0k1sRjjv0sTVQdmqoQeq/ENR0A0t4AXGk42bIqpUbWOiGgwZS2E2JxcNr0BdAAZ03N4qMD0rmLpe9WF80KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7753
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/22 17:29, Prarit Bhargava wrote:
> On 11/14/22 10:45, David Hildenbrand wrote:
>> On 14.11.22 16:38, Luis Chamberlain wrote:
>>> On Mon, Nov 14, 2022 at 09:57:56AM +0100, David Hildenbrand wrote:
>>>> On 12.11.22 02:47, Luis Chamberlain wrote:
>>>>> On Wed, Oct 19, 2022 at 02:00:55PM +0200, Petr Pavlu wrote:
>>>>>> On 10/18/22 20:33, Luis Chamberlain wrote:
>>>>>>> On Sat, Oct 15, 2022 at 11:27:10AM +0200, Petr Pavlu wrote:
>>>>>>>> The patch does address a regression observed after commit 
>>>>>>>> 6e6de3dee51a
>>>>>>>> ("kernel/module.c: Only return -EEXIST for modules that have 
>>>>>>>> finished
>>>>>>>> loading"). I guess it can have a Fixes tag added to the patch.
>>>>>>>>
>>>>>>>> I think it is hard to split this patch into parts because the 
>>>>>>>> implemented
>>>>>>>> "optimization" is the fix.
>>>>>>>
>>>>>>> git describe --contains 6e6de3dee51a
>>>>>>> v5.3-rc1~38^2~6
>>>>>>>
>>>>>>> I'm a bit torn about this situation. Reverting 6e6de3dee51a would 
>>>>>>> be the
>>>>>>> right thing to do, but without it, it still leaves the issue reported
>>>>>>> by Prarit Bhargava. We need a way to resolve the issue on stable and
>>>>>>> then your optimizations can be applied on top.
>>>>>>
>>>>>> Simpler could be to do the following:
>>>>>>
>>>>>> diff --git a/kernel/module/main.c b/kernel/module/main.c
>>>>>> index d02d39c7174e..0302ac387e93 100644
>>>>>> --- a/kernel/module/main.c
>>>>>> +++ b/kernel/module/main.c
>>>>>> @@ -2386,7 +2386,8 @@ static bool finished_loading(const char *name)
>>>>>>        sched_annotate_sleep();
>>>>>>        mutex_lock(&module_mutex);
>>>>>>        mod = find_module_all(name, strlen(name), true);
>>>>>> -    ret = !mod || mod->state == MODULE_STATE_LIVE;
>>>>>> +    ret = !mod || mod->state == MODULE_STATE_LIVE
>>>>>> +        || mod->state == MODULE_STATE_GOING;
>>>>>>        mutex_unlock(&module_mutex);
>>>>>>        return ret;
>>>>>> @@ -2566,7 +2567,8 @@ static int add_unformed_module(struct module 
>>>>>> *mod)
>>>>>>        mutex_lock(&module_mutex);
>>>>>>        old = find_module_all(mod->name, strlen(mod->name), true);
>>>>>>        if (old != NULL) {
>>>>>> -        if (old->state != MODULE_STATE_LIVE) {
>>>>>> +        if (old->state == MODULE_STATE_COMING
>>>>>> +            || old->state == MODULE_STATE_UNFORMED) {
>>>>>>                /* Wait in case it fails to load. */
>>>>>>                mutex_unlock(&module_mutex);
>>>>>>                err = wait_event_interruptible(module_wq,
>>>>>> @@ -2575,7 +2577,7 @@ static int add_unformed_module(struct module 
>>>>>> *mod)
>>>>>>                    goto out_unlocked;
>>>>>>                goto again;
>>>>>>            }
>>>>>> -        err = -EEXIST;
>>>>>> +        err = old->state != MODULE_STATE_LIVE ? -EBUSY : -EEXIST;
>>>>>>            goto out;
>>>>>>        }
>>>>>>        mod_update_bounds(mod);
>>>>>
>>>>>
>>>>> Prarit, can you verify this still does not break the issue you 
>>>>> reported?
>>>>> David, does this also fix your issue?
>>>>
>>>> I didn't try, but from a quick glimpse I assume no. Allocating module 
>>>> space
>>>> happens before handling eventual duplicates right now, before a 
>>>> module even
>>>> is "alive" and in the MODULE_STATE_UNFORMED state.
>>>
>>> The first two hunks are a revert of commit 6e6de3dee51a and I'm under
>>> the impression that cauased your issues as *more* modules states are
>>> allowed through.
>>>
>>> The last hunk tries to fix what 6e6de3dee51a wanted to do.
>>>
>>
>> Note that I don't think the issue I raised is due to 6e6de3dee51a.
>>
>>>> But maybe I am missing something important.
>>>
>>> Please do test if you can.
>>
>> I don't have the machine at hand right now. But, again, I doubt this 
>> will fix it.
>>
>>
>> The flow is in load_module():
>>
>>      mod = layout_and_allocate(info, flags);
>>      if (IS_ERR(mod)) {
>>          ...
>>      }
>>
>>      audit_log_kern_module(mod->name);
>>
>>      /* Reserve our place in the list. */
>>      err = add_unformed_module(mod);
>>      if (err)
>>          goto free_module;
>>
>>
>> You can have 400 threads in layout_and_allocate() loading the same 
>> module at the same time and running out of module space. Any changes to 
>> add_unformed_module() and finished_loading() won't change that, because 
>> they are not involved before the module space allocations happened.
>>
> 
> I'd like to see a refreshed patch but I tested the latest version and 
> see that the boot time is LONGER with the change
> 
> Before:
> 
> [11:17 AM root@intel-eaglestream-spr-15 kernel-ark]# systemd-analyze
> Startup finished in 55.418s (firmware) + 22.766s (loader) + 35.856s 
> (kernel) + 5.830s (initrd) + 15.671s (userspace) = 2min 15.542s
> multi-user.target reached after 15.606s in userspace.
> 
> After:
> 
> Startup finished in 55.314s (firmware) + 23.033s (loader) + 35.331s 
> (kernel) + 5.176s (initrd) + 23.465s (userspace) = 2min 22.320s
> multi-user.target reached after 23.093s in userspace.
> 
> Subsequent reboots also indicate that userspace boot time is longer 
> after the change.

Thanks for testing this patch, that is an interesting result.

I see the following dependency chain on my system (openSUSE Tumbleweed):
multi-user.target -> basic.target -> sysinit.target -> systemd-udev-trigger.service.

My understanding is that the udev trigger service only performs the trigger
operation but does not actually wait on all devices to be processed by udevd.
In other words, handling of the forced udev events can still be in progress
after multi-user.target is reached.

The current serialization of same-name module loads can result in many udev
workers sleeping in add_unformed_module() and hence creating at that point
less pressure on the CPU time from udevd. I wonder if this then maybe allows
other work needed to reach multi-user.target to proceed faster.

Could you please boot the machine with 'udev.log_level=debug' and provide me
logs ('journalctl -b -o short-monotonic') from a run with the vanilla kernel
and with the discussed patch?

Thanks,
Petr
