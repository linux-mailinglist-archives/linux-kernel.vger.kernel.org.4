Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD895FFF20
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 14:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiJPM0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 08:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiJPMZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 08:25:59 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140048.outbound.protection.outlook.com [40.107.14.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5743609D;
        Sun, 16 Oct 2022 05:25:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CPw/mcFzbwY1yjk+nFVIRdquEmSjdPCS5WG8RBzePAennb5Kc4puQjb4RaJgHmTd5ebxflANf10VgvWiuzQdrJUQlwAcln9hWD3NZidWls9u6pMJBZdSvRYt+ARIcsY58ieLtKKVtYAB7QFDvhnjhAknYV2ERIBvGJJqZCfZfrQLfAGYyh6ew3qQ4xKZhCO7OBlRLeGRpHAEVt3/N7B0e5Kamw5PQAk2oesS7yKWrhLzfRr03Ahh0JiiscI7JOGHKO3l6zo4PbDKhrFBdHCl/aD31V1CTV78Cgw16InQvovBJXLz6xkBVMKsjyw63zpULeKLN8PJZXCLy6s+nWLiZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0mNds2GXMyFas6AZBxkt/B+W4y4HUi1UeQL3/GoDNI=;
 b=N+qFjbuJnVRucOh9JJ2PFnAteweAe6KfNiepX/8PjIwX/R3Q41HT5pCDk7jGcfZq+ekCwDnfVeAFmcOmrn0ezFtyEG/srzwrEJasNSsHSvYODhnvrTj0acjzXKRAyTG7SwApKJHFtiusPHiQAHhrq2zgRFotKDa/T/qiHCyJCMsjxzrO0kqseH0VatZddPWq+/kt0rDsMQK4C9ug6anhbNmsI+UxzxGrxdyX1ab+SDZZ3ZE2tClooIh7itSUE4dAF1ZwM8grPMCrZy7/VgKkWNSDEJG9mY8WpFTgQzfMu08sJWQ503PNcyloGEuWaj8LuErtgaLB+ADo47mwUZTLmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0mNds2GXMyFas6AZBxkt/B+W4y4HUi1UeQL3/GoDNI=;
 b=RCHpzgHnF0qYqR3uT+uo4Fx52gyjpMbEHFTDaYWyvy1C6HXghJ247Wto9EuOAapSC9QlPaL0q8bVxVF+mW6QHgQdT+HS4ySxRbCpQSF5NuuWllQMiWPw9mKWTgBe2tmz/ryKbmyLRTPdi3zjvx9rCWZajFDAl82+Hz2Cmp3rcnjnjT7Mmi4aLZL5IQvdpOMIKY0rUEQHfQmZNzOc6I5fmUfix5Bjj6M+f8so0jA/32b4e2z7C3vUmW5pWunGU4A+MOhxtL90Ko5XsCodee16Nk/hjNFIeFsIhC2ZVVfo7hMPne0uQPXuu/ekv5M0PZXogUlDcBcYa02E0caiVuqwrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16) by DU0PR04MB9249.eurprd04.prod.outlook.com
 (2603:10a6:10:350::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Sun, 16 Oct
 2022 12:25:52 +0000
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::7f81:2760:2539:7115]) by AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::7f81:2760:2539:7115%2]) with mapi id 15.20.5723.030; Sun, 16 Oct 2022
 12:25:52 +0000
Message-ID: <18d511a3-cff3-49ce-ed26-f1854a07b3c9@suse.com>
Date:   Sun, 16 Oct 2022 14:25:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 2/2] module: Merge same-name module load requests
Content-Language: en-US
To:     Petr Mladek <pmladek@suse.com>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220919123233.8538-1-petr.pavlu@suse.com>
 <20220919123233.8538-3-petr.pavlu@suse.com> <Y0lpn/TJOamfvBaZ@alley>
From:   Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <Y0lpn/TJOamfvBaZ@alley>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0017.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::20) To AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3395:EE_|DU0PR04MB9249:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ba11806-3e83-4810-b864-08daaf719083
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hS79FlsSxw5lI71ir8RTCAT2/VHOqJ8EdW8rgjycHOaQH/T9SAm1yLCDDEvQVC9mM+4J4ZxNdtY4obrzRFgc4jG8yUG7BDZ9MFbffjSD5E8M0DOIgH4HLWyrrL2VoGfrX7AbsdyPdO3/ZBaKJ91Dj4dl7zjNZ3CtOL4xxudC91VaDmIb2gsiBgziw92m1aFJc8RqEzzfVMjRp6MiCJ8UE9Pm5zOz/dvLZYh7hv9rv8y64OP6QX24hiFBOHP358FG3KDs7N9GVK1hx3n10XgDcBnIRdn/LXoaF7Sa3omHysWGwMwMzUkkB9h6dqGb6yZXWos25Nut3O10xxVTqaCklNn9vzjqUDjqyTFeiayH/qenvQnDdEgkvc4feyONTpXkBvNElUIryPyO3DqZim5Z42B3PTMoFGukxutQ9ArShx/yVqdBoONS+7RRbLpKIBWd56kpg5Zwe+6HTe1sLkrexm8uoo+0hey8NVewOMzk8GG3NGWJMNjJIhWPzl7pBYr2GjtGIvPVY+lUcmvRvpY2FXQUReod5HNQfR/s2Tp6YIQJFFbE2KxyYWzpVOYePfb8gqowPrfdlSNNWVEHqvY+b2XfD1n7rhVjBJSQBaaCFodD9I9sBfMw80RD9lpcqdaUM/cpCBpOCl2Srh8gX3djn8JCQOd+zE+aPxcYeVKVuvZLqWr8fJ2B/PTx/3aZtImZfHqB9R+YpksJUd3sqWA0eD06o9kMLT5iUGctsybERgvZthbeMlvC3K7eDscYknsFfKvAWctwnA64HlhLWoYDFnyp9Tkub5eRFXDUOqRRKMw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3395.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(366004)(396003)(39850400004)(346002)(451199015)(6636002)(37006003)(6486002)(478600001)(8936002)(6862004)(41300700001)(5660300002)(30864003)(44832011)(316002)(8676002)(4326008)(66556008)(36756003)(66476007)(66946007)(38100700002)(6512007)(86362001)(53546011)(55236004)(26005)(31696002)(6506007)(83380400001)(186003)(2616005)(31686004)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUNSRU5JVkFIOHVNa05UVVRTOUkrSXRKUldEcGlnY3pObkcrd25rVGh1Q29I?=
 =?utf-8?B?YUNheXF1YSs3Y2VDdUhKdG4wQ3ZqZkhKc0d1M1NqbWRJb2oyY2p2SUJSZG50?=
 =?utf-8?B?TXF5WE1aNXpjUDYzT0RGNS9aSStYTU9iVkJidThWNHRNdWZDZ2xkRTF6YmxV?=
 =?utf-8?B?REpiMjdxWjAxeHpxU2FHUEVPdWQwSnd2aUtuL2NoNlF6QzBWNGV4cU5iQ2Ix?=
 =?utf-8?B?M2NvV2tYNzRZSG9KYitzRWlKWkhrdk4vQWpscE9Id3RmdEs2YkdWMDN2RkIw?=
 =?utf-8?B?bG9HYjhJOUFwNStCM2dmd1VRNlRpTGVuY0c2NGFDODJ2bytTSjVhOElmZDk4?=
 =?utf-8?B?NFYyWEpsWkt6UG0vZHB6VzRGaDJmMU9Ld0JTcEJNazFBSmVKVWF5d1JXL0RJ?=
 =?utf-8?B?L1RmRC92dXU2QXV2eDBqd0hEeWlnaFRnV0JOT1JUUkFtdktTTmlHWVRrMEtt?=
 =?utf-8?B?QytoNThxVFd0QWlPdnlob2dqMUU2dVJjcFJwMlJlbytCNlVSd2duS3RoNkcv?=
 =?utf-8?B?M2czaEF5S25CZXJLTm9uRkZUVFo1ejQvdXJaOGtHaXBsTWFSVUZLKzhtREth?=
 =?utf-8?B?SDFDRktmRFJBTDVKSlFGVTVpM0NLY3cxcHJoVlZSRUJZdXMwWXVaVzNTTGNE?=
 =?utf-8?B?WU9KT0txVzZOODlZTElCY0RFOEY5T29ndGp2RnJlQjVYY2JCMmIrd2dkSnVK?=
 =?utf-8?B?WGZrQklvNnZUVUxYdmU3aGY1Tmk1UVBqa3A1a3pzeWZ6TkhNQWxhcjczdGda?=
 =?utf-8?B?YkhBVTNrYThBZHhzSzJLcWtDdU4yckdTTkY0Y0h5V3pHeWNYWjRtS2JyRW5U?=
 =?utf-8?B?WEtFbHFZUTROTkZOQmVkd2hNaVNRMUJnOTFmS0UxQUdaZmlUU1ArY05BZHdV?=
 =?utf-8?B?RjBiZ1dseVN2a1FpVGpoM01sY2ZzOEpsb1BCeGdCRE8yUzlqNmlaZkJ5S1By?=
 =?utf-8?B?cTFLNThOd1dwMFdRcnA3KzhWQXM2SFZYRGVVV2VaN3U5MTcxYmFhalFUelNx?=
 =?utf-8?B?Z0cwWVJzd014aGFEQ1d0OE9oMFYwU3JOV3A1bmIxNkdWOUp1WW5zTWVNQWIy?=
 =?utf-8?B?MHlhSWF6cVdmYlRUN09ZUEpKSzIxV1RWOEUrb1JyczNIUFNGalZyWUlkNUJU?=
 =?utf-8?B?MVRZMFFzRWxIM2RZWURvakVMc0F1bFR3aGJGZ0ZOMGpGanljdDRCN1ZsSGZD?=
 =?utf-8?B?eVczVUtDNmx0K3g2d3A0ak1ESzBmWDlTeVI0aUpkZmxGQVBmVTY0a21OUXRU?=
 =?utf-8?B?ZmtHZHNOWFkxdkYxc2NiZDV3c2lYM1EwN1c5akNEZXJsMm4rNkl5VzU2R1hl?=
 =?utf-8?B?dy9QV1pNcFBodkhVQnVLNHE5WFpuc0tPWlhTVkpRTnFQOWkrMGpnUUdveGxU?=
 =?utf-8?B?aFlYU1JXLzdyQlNJQUREQ2ZVcEQvYjZ2YS9vL0QwbWJDV0hXeDNNZlFhS1Uw?=
 =?utf-8?B?bUNBeGZqMSs1WFVRWnpWckRJOWFwdG9QQ3Z2Q0hwUUZXZm53OXJ2MWNnOS90?=
 =?utf-8?B?RFRHY2Vkcko2NW45elJPbU12bGtaNThxSGpsTzk4WGdzdmJhVE12aE5wR2lF?=
 =?utf-8?B?NGFOaWFaeEI1eDRMVVYvcnhBTHpOWWJ2TWdTZnRQdkpKdkkyQ2pLSDI0Q015?=
 =?utf-8?B?bkN3VG9rN2dxME5kU2lBdHo0SUtWQWQ2akpQc25pQVVCOG43K05QWnRTZXB0?=
 =?utf-8?B?aFNvbGZ5cm1sNE9uS29yZHBlTG9wY1djVk1wSmdMUUdiRXYybDRjemtyaWpC?=
 =?utf-8?B?TDBTSXNmQ3h1MU0zWVU3dktaamZKcFRGblFwVTM5NjltcFNzbE8rRHJqcFlz?=
 =?utf-8?B?ZVV3cnZUT0V2MkVWTzNvbkdCc2pZVHRRVnNEeUREaEErQk9KQklDeGRHMVdK?=
 =?utf-8?B?UGxPajE1MWU0dW13TFZpOUNweVZkMC9rVXBKbVdVTVc5MVc3cCtjb2c2TEY5?=
 =?utf-8?B?VkdLSXcrVXcvZk9heDNwMXJhYWVXSGJGclROTWpkcklJVnZGNkkvWXJVbHM1?=
 =?utf-8?B?aWhUNVNzNUxUWm5QRUZBWDJRSldrWC9IcUM3dkc4WHV4L2V1dzNUZ2NSek1n?=
 =?utf-8?B?RjROdXh6Yi9renFkaUlTSHY0L0ZVaEFxVGJ6b2lBRGNxRzc2Q2NSdVdWWkh2?=
 =?utf-8?Q?yAgBCzoBgSBBNq4JHIa29DPQ2?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ba11806-3e83-4810-b864-08daaf719083
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3395.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2022 12:25:52.0500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: awLRU3nCGIbzTef3M8UDt5wvOdlMW7fOua3NFxQuyG71DIOOYT0IutdD1KEfYm5PtB6nJ9qGhEkB9VNC5r0S8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9249
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/22 15:52, Petr Mladek wrote:
> On Mon 2022-09-19 14:32:33, Petr Pavlu wrote:
>> During a system boot, it can happen that the kernel receives a burst of
>> requests to insert the same module but loading it eventually fails
>> during its init call. For instance, udev can make a request to insert
>> a frequency module for each individual CPU when another frequency module
>> is already loaded which causes the init function of the new module to
>> return an error.
>>
>> The module loader currently serializes all such requests, with the
>> barrier in add_unformed_module(). This creates a lot of unnecessary work
>> and delays the boot.
>>
>> This patch improves the behavior as follows:
>> * A check whether a module load matches an already loaded module is
>>   moved right after a module name is determined. -EEXIST continues to be
>>   returned if the module exists and is live, -EBUSY is returned if
>>   a same-name module is going.
>> * A new reference-counted shared_load_info structure is introduced to
>>   keep track of duplicate load requests. Two loads are considered
>>   equivalent if their module name matches. In case a load duplicates
>>   another running insert, the code waits for its completion and then
>>   returns -EEXIST or -EBUSY depending on whether it succeeded.
>>
>> Note that prior to 6e6de3dee51a ("kernel/module.c: Only return -EEXIST
>> for modules that have finished loading"), the kernel already did merge
>> some of same load requests but it was more by accident and relied on
>> specific timing. The patch brings this behavior back in a more explicit
>> form.
> 
>> --- a/kernel/module/main.c
>> +++ b/kernel/module/main.c
>> @@ -61,14 +61,29 @@
>>  
>>  /*
>>   * Mutex protects:
>> - * 1) List of modules (also safely readable with preempt_disable),
>> + * 1) list of modules (also safely readable with preempt_disable, delete and add
>> + *    uses RCU list operations).
>>   * 2) module_use links,
>> - * 3) mod_tree.addr_min/mod_tree.addr_max.
>> - * (delete and add uses RCU list operations).
>> + * 3) mod_tree.addr_min/mod_tree.addr_max,
>> + * 4) list of unloaded_tainted_modules.
> 
> This is unrelated and should be done in separate patch. It minimizes
> the size of the patch and simplifies review. More importantly, these
> unrelated changes will not get lost when the patch gets reverted for
> some reason.

Ok.

>> + * 5) list of running_loads.
>>   */
>>  DEFINE_MUTEX(module_mutex);
>>  LIST_HEAD(modules);
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
>> +/* Waiting for a module to finish loading? */
>> +static DECLARE_WAIT_QUEUE_HEAD(module_wq);
> 
> It is not obvious why this is actually needed. One would expect
> that using the completion in struct shared_load_info would
> be enough.
> 
> It is need because the user, resolve_symbol_wait(), does
> not know the exact name of the module that it is waiting for.
> 
> It would deserve a comment and maybe even renaming, for example:
> 
> /*
>  * Waiting for a module load when the exact module name is not known,
>  * for example, when resolving symbols from another modules.
>  */
> static DECLARE_WAIT_QUEUE_HEAD(any_module_load_wq);

I will adjust the comment.

>> +
>>  /* Work queue for freeing init sections in success case */
>>  static void do_free_init(struct work_struct *w);
>>  static DECLARE_WORK(init_free_wq, do_free_init);
>> @@ -762,8 +774,6 @@ SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
>>  	strscpy(last_unloaded_module.taints, module_flags(mod, buf, false), sizeof(last_unloaded_module.taints));
>>  
>>  	free_module(mod);
>> -	/* someone could wait for the module in add_unformed_module() */
>> -	wake_up_interruptible(&module_wq);
> 
> The new code does not longer wakes module_wq when the module is
> removed. I wondered if it is correct. It is a bit tricky.
> module_wq used to have two purposes. It was used to wake up:
> 
>    1. parallel loads of the same module.
> 
>    2. resolving symbols in a module using symbols from
>       another module.
> 
> 
> Ad 1. The new code handles the parallel load using struct shared_load_info.
>       Also the new code does not wait when the same module
>       is being removed. So the wake up is not needed here.
> 
> 
> Ad 2. The module_wq is typically used when the other module is
>       loaded automatically because of module dependencies.
>       In this case, only the wake up in load_module() is important.
> 
>       But what about module removal? IMHO, the is small race window:
> 
> 
> The problem is the module operations are asynchronous. And A takes
> the reference on B only after it resolves a symbol, see ref_module()
> called in resolve_symbol().
> 
> Let's have two modules A and B when the module A uses a symbol
> from module B.
> 
> 
> CPU 0:			CPU 1			CPU 3
> 
> modprobe A
>   // see dependency on B
>   // and call modprobe B
>   // in separate thread
> 
> 			modprobe B
> 			  return -EEXIST
> 
> 						rmmod B
> 						  // finished
> 
> 
>       resolve_symbol_wait(sym_from_B)
> 
> It has to wait until the timeout 30s because module B is gone
> and it is not beeing loaded.
> 
> IMHO, the new code makes the race window slightly bigger because
> modprobe B retuns immediately even when rmmod B is already in
> progress.
> 
> IMHO, this is acceptable because the race was there anyway. And
> it is not much realistic scenario.

I'm not sure if I understand this scenario. My reading is that modprobe of A
would wait in resolve_symbol_wait() only if module B is in the coming state,
and then would get later woken up from finalize_running_load(). In all other
cases, resolve_symbol_wait() should not sleep:
* If B is not loaded at all or is in the unformed state then resolve_symbol()
  -> find_symbol() detects that a needed symbol is missing. NULL is then
  returned from resolve_symbol() and subsequently from resolve_symbol_wait().
* If B is live then resolve_symbol() should successfully resolve the symbol
  and a refcount is increased on this module.
* If B is going then resolve_symbol() -> ref_module() ->
  strong_try_module_get() -> try_module_get() should fail. This then gets
  propagated as -ENODEV from resolve_symbol() and resolve_symbol_wait().

>>  	return 0;
>>  out:
>>  	mutex_unlock(&module_mutex);
>> @@ -2552,43 +2540,133 @@ static int may_init_module(void)
>>  	return 0;
>>  }
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
>>  /*
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
>>   * memory exhaustion.
>> + *
>> + * Merging same load requests then primarily helps during the boot process. It
>> + * can happen that the kernel receives a burst of requests to load the same
>> + * module (for example, a same module for each individual CPU) and loading it
>> + * eventually fails during its init call. Merging the requests allows that only
>> + * one full attempt to load the module is made.
>> + *
>> + * On a non-error return, it is guaranteed that this load is unique.
>>   */
>> -static int add_unformed_module(struct module *mod)
>> +static struct shared_load_info *add_running_load(const struct load_info *info)
>>  {
>> -	int err;
>>  	struct module *old;
>> +	struct shared_load_info *shared_info;
>>  
>> -	mod->state = MODULE_STATE_UNFORMED;
>> -
>> -again:
>>  	mutex_lock(&module_mutex);
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
>>  			mutex_unlock(&module_mutex);
>> -			err = wait_event_interruptible(module_wq,
>> -					       finished_loading(mod->name));
>> -			if (err)
>> -				goto out_unlocked;
>> -			goto again;
>> +
>> +			err = wait_for_completion_interruptible(
>> +				&shared_info->done);
> 
> This would deserve a comment, for examle:
> 
> 			/*
> 			 * Return -EBUSY when the parallel load failed
> 			 * from any reason. This load might end up
> 			 * another way but we are not going to try.
> 			 */

Ok.

>> +			if (!err)
>> +				err = shared_info->err ? -EBUSY : -EEXIST;
>> +			shared_load_info_put(shared_info);
>> +			shared_info = ERR_PTR(err);
>> +			goto out_unlocked;
>>  		}
>> -		err = -EEXIST;
>> +
>> +	/* Search if there is a live module with the given name already. */
>> +	old = find_module_all(info->name, strlen(info->name), true);
>> +	if (old != NULL) {
>> +		if (old->state == MODULE_STATE_LIVE) {
>> +			shared_info = ERR_PTR(-EEXIST);
>> +			goto out;
>> +		}
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
>>  		goto out;
>>  	}
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
>>  out:
>>  	mutex_unlock(&module_mutex);
>>  out_unlocked:
>> -	return err;
>> +	return shared_info;
>> +}
>> +
>> +static void finalize_running_load(struct shared_load_info *shared_info, int err)
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
>> +static void add_unformed_module(struct module *mod)
>> +{
>> +	mod->state = MODULE_STATE_UNFORMED;
>> +
>> +	mutex_lock(&module_mutex);
>> +	mod_update_bounds(mod);
>> +	list_add_rcu(&mod->list, &modules);
>> +	mod_tree_insert(mod);
>> +	mutex_unlock(&module_mutex);
>>  }
>>  
>>  static int complete_formation(struct module *mod, struct load_info *info)
> 
> The comments are more or less about cosmetic problems. I do not see
> any real functional problem. I am sorry that I did not mention
> them when reviewing v1.
> 
> Feel free to use:
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>

Thanks,
Petr
