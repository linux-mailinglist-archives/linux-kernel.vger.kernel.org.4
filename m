Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7315B5CDB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 16:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiILO6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 10:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiILO6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 10:58:40 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140049.outbound.protection.outlook.com [40.107.14.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A13D20BD3;
        Mon, 12 Sep 2022 07:58:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RCGY2wyiBAx9SpFrx+IgnYxmmJMdCYAfAdFzGdtks4/9bCQAwoCq/m9xT6RnwB6D8JAkJ4TDSNlTWn3hK+wZpeehxizpfgyHWDYTgfu9hoatS4kvDfaRdix7cFtkFnCRq0NwZ42cuRCZ3zYtPjHEQ92yvCidIbjOqqCZ6xzBn1MfNsXRk4g/yG4MF+t6yh4Ym8FXeLXVpmui+7tCGM4zsG1TuVav2HHQsNJyWFT9COqaGv0aTOzpY5/mT9ln2C+61QL9n/Z9inmJiBenJD2ZSt5lfd3WAKLY46dteXBh2SwKIj/g5X+56d/+zz+ukFyaX76rmEaUmRqvPqgplu/Dqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHCpbzq2OnAcKdMdVERz3uk8jsF4++Nv4V/Gx1RsxC8=;
 b=A4Kw0so7wqtPJbxklRutb47Mdl3PcdFcmWOgAEX1BZ4UUUlRIQGwS7CWLEbze8Q8ZTawgqg8nwdfBmqYLAzOyGKvhMXshAyeAKlk15JiH22x5vDTAdLpd3Htu4wQfRNlX3urZ9folzkmoH1CdKzycPefr2o4XOzLOHpc5Q7lLInJx+6ONhokgO4Sx2bZ56V0xGWUE/z1jgolLsTvlHEeUTWZ5+NuqKljYHwoZM/UP11i1noxdCbGaJaO45Q38Zb/ntPEbdibsfIkCNxi0PCqApjv5qgXTymVQErOLfVDhsBnA8ci1GDmdnt9iV2L+idLjAJn1m72papFdH3NPk1BrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHCpbzq2OnAcKdMdVERz3uk8jsF4++Nv4V/Gx1RsxC8=;
 b=JN5QoXUfYxGVGzZeQJQE3ovlHgfaltcSlOLUMqqtXSuNyRPFtc86pukrGexLpAtwj96QfpALJSaJgIg+MfzCx/IpZSxdRJssKtIJu8hQRyqmKsW5LfuXRs9HtjSrGiv/uyu2kllF6/J21JqpPG275NGimuJNHtQUOv+ZfvYouEkjLvnIsNjm2+Tiqgf6mwl7/Z+WxAM27AUPvbOk3iRuH1Vl2Q8PizkY3QiYRgitZCKYxPBEOanJs+2/j5NFBa7an5rW4x52X8yTTRlKAk94ymKxYzHMi5qE53OB4C+gpu+huatTXVs751TTa3P3/Y2XM5mZbMdB7v0HbvdW4PWBJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16) by AS8PR04MB7509.eurprd04.prod.outlook.com
 (2603:10a6:20b:23e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Mon, 12 Sep
 2022 14:58:34 +0000
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::f486:ee6b:f724:4c94]) by AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::f486:ee6b:f724:4c94%7]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 14:58:34 +0000
Message-ID: <0ccb384f-bbd5-f0fd-3832-c2255df505b2@suse.com>
Date:   Mon, 12 Sep 2022 16:58:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] module: Merge same-name module load requests
Content-Language: en-US
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        mwilck@suse.com, mcgrof@kernel.org
References: <20220905084131.14567-1-petr.pavlu@suse.com>
 <YxYHzp1D315RcA4h@alley>
From:   Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <YxYHzp1D315RcA4h@alley>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0124.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::15) To AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3395:EE_|AS8PR04MB7509:EE_
X-MS-Office365-Filtering-Correlation-Id: 6675b782-b0f3-4485-4602-08da94cf43e7
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o9B3DeRUZtbSamnq2jXQiQjndxIzPM69Q0RPJ4nwVpG9E6y9l6zZiYl2Jml5FuBpp7RxxEse0cMhRkhv+e9NEhPfBiD7b6nTSvdWfJU6mT5ZW/HoRc3Cz2Ixl+UKxbNl8zbnOwWq37culfccYznWjtSyLDzHIvm8Kpb4JnVObvfXSe3nCflbhSviEUEIp1NwwaLzrcBxM41hcVrf4Gf1wwQK5m0BrRioo4vwVjc5DQKI+qT7k3udCsr1XNXcBaPucVAlCTnx+jdO1pFDqtM6GliP0HW/LmNmDPTWv/aAK3J5aVs9/NzhDhsTQpAPSLLONFmuAXblCbg9vP1J/9pC7wSBSufWPT9/71ymeITpgbPS+Y+akLew4VGnjThyieatIxqtgtBzuR2BcDT6m9PF8hONHpPFL9BMpdha3r47bi0JnTD17GLCQDBWym51HHPgKm3BGGf4015cXfAPcVLkXOAMXdirdGcPxlwUk8RLK2otNKzy1LRQ67HlS4lTtkWlUYWj7dvu+Zo4hwjsNLE8CYxhSy9kL8qztqW74vgMWh2pXGIlpzDwgvtcLr8XVfNFs9rARfHBqcR5zwaQKJeNk3etDchwg+m9/n3hdST/lJjCD+5od8v8T7x44mgiFWaTfpPF3c/z7KAbmnY+qjx4apGEe3TWU5jdNFq1aX7axoGY9ua3MFZ+e07lUJOU907Uic2/Yp9aQmtUJ8BGzGpjIvMNkqQK3NcT18PnJgsZqGucgNooIVRFsvifXDAO5nWeLjVX4bOXOT+E0aApxFUKkRcxGSJOVSt+dtyYNFSl3aQl62tR2xaYNbRRT0laG1gFuankdTS1hFIPTlOrPH8gXImu6IKpZtVo/jaxlYwJl6Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3395.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(376002)(39860400002)(136003)(366004)(86362001)(31696002)(38100700002)(66476007)(66556008)(66946007)(5660300002)(4326008)(6862004)(8676002)(8936002)(41300700001)(966005)(37006003)(478600001)(6486002)(6636002)(316002)(31686004)(83380400001)(30864003)(55236004)(6506007)(6512007)(26005)(44832011)(2906002)(2616005)(186003)(53546011)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0kwdnlOVHpTcFl4VG9kckgrV1lsVWNLRVU1Yzhqc2QzR2hwY2F6YVY2ZjhN?=
 =?utf-8?B?enVUNVFqajZvb09rZ0l2TUFsQ2x3VHloWHVZUmhJTXJYcVcxeDFZNWRndmln?=
 =?utf-8?B?ZEhDSUFFSitaeWYzdkFJbHpScmo4U3BadGVvVW0xM1k3NGJ3a3JRU1JIbmNq?=
 =?utf-8?B?U25MTXB5TE4vUTNDdnZiTjNkQzZWS09jdmVMamRIei9aajJIQVZxUThaa2d5?=
 =?utf-8?B?Q2NCSDlHUExHeWREbTV3UnhyZmNoZjFHNTNFL0tOZzRQZThyTGp2UnNwNHhB?=
 =?utf-8?B?VGZRMmpyNGFUdDlkK0lzMkMvWFBhZjVjUnVYNXBsUHJ5TGQzL0RRQmlnY3Q0?=
 =?utf-8?B?YXByVFdEY2VtRVIxeklBV2FzTXg2UmtJbG5NZDVxQjlpSUlab2JITkFIQlhQ?=
 =?utf-8?B?MmMvVjc1b0x2VTBHT1lycmtXQTQyNHdyNVM5NVFmOUxRc1FaSGJEY3R4NFF3?=
 =?utf-8?B?LzN5L3E3YVpPeGZyL1Z3YlJPR2xSc3NkWjIweEhLaXlpWWlGR29MUjBGd2x1?=
 =?utf-8?B?WVNJMDdxS3BLbGcyb1YzbjV6Tmoxb0w0NTRETFk2aTUyTURlMnhTYWVVbFU4?=
 =?utf-8?B?VkNYcmlibElJK3J6dUpPK1dLODVGZDZxQU8rWWtUekt1M3AzbHhGVHZXZFV5?=
 =?utf-8?B?Z3MyMGs2VVU1SXlManNrczRiN0E5emlrUklYSjh1NnVzRnJmSXdZOUliMytC?=
 =?utf-8?B?enAyaUlTOExZVHF6Tm5odVpoR0ZSNHJtQTJNV2VpYTBXSVJCdmkrYVM1bUNJ?=
 =?utf-8?B?MXBReDhpcFg0bjQwb0dEZ3NVdy9rWUVtd0FobHZnTXNKbEVET0g3bzFhbXg0?=
 =?utf-8?B?OC96S1hzZUpJOHZLMkd3djNSeWoyZ2ptVWlvbjBUeExRSzNDRGtsanFOS3lG?=
 =?utf-8?B?blNhQ3RNcGozQ05JNW5GNU16SUUxYWJycUI5RUZLSWEza1IzRFFNZjNKNmpY?=
 =?utf-8?B?WC9raS9uL0lXOXlvOENUdGU4azRRQXd6YVNpTTR4dkJRVmI2STRuYVc1N2dr?=
 =?utf-8?B?NEpMTG1hSUdISm13TkxEOGN4ZUwrL0dsTmRhOXhQY015SHlFSTk3Q1gvMVVl?=
 =?utf-8?B?Um55KzBuWnY5VUxnWEE3aFVRa09KZEgyTXhvd3VSY0dRc0FhL24zQ3YxVEdM?=
 =?utf-8?B?eTkyaGVjRGZtRnRPOTZhYjJ3SDd6ZUROZWUrTzViMnBEWHF4dGp3SjBQN2Vm?=
 =?utf-8?B?QlNxcEtQcCtkWDFtR3I2ZGNUaTIrSHBRbTRCTW9xbkVZM2xEbmIvRnN5ZmlV?=
 =?utf-8?B?M3lidzdhb0w4eUEwSHE0TWp5UWVMZHZMU1NaMFE2VUg4ZTVkVlNHLzl6Smc5?=
 =?utf-8?B?Nmo0R0llZWtsMnNWL3h1dkh1Y1hERENDWVlFUVVXR1B1cXBjTnVrL0pOLzZx?=
 =?utf-8?B?dUN3TzhoUDF1VXhQaUNhS0pCK3E4VXRodzl1SlFMKzA5RVVHRmJraEViUkg2?=
 =?utf-8?B?NVZoUnY0aWVOcVJVK3gveUVVck8vMmZjWnl0MHZIVHdqMmVkd21nUk42K0FS?=
 =?utf-8?B?ZG5SdVBvQzh4UVpoV28vZ3RuNmwweDZobGpvVWVabWlZdXRScUZreFNweE9w?=
 =?utf-8?B?UXRMbTRJODF2MjBPMTdhdlFIZVdRN3hBd3RQeU5XZXNzUHNJWlJKb3hlTFhm?=
 =?utf-8?B?cVF4cnB2Wmp4bW5uMjZNR21IQnByb0owVW9tSy9hUERWTzVkQXFIc3QraXY5?=
 =?utf-8?B?RWxaTTJac3lvT0dYSTQ0VkZ1cGVYRS9lTjlRbDhVS2ZlOUJOSitjMmVDM0xv?=
 =?utf-8?B?enptbW9pLzhLVjJ4TzV5a2RlVjB4MVpIK1JYSkdyRjU0SnI0dWtmZEFZL3Z6?=
 =?utf-8?B?cTVQWnNOWjR6NUltQ1pBalZoMElmT2sxSmI0czFyQ1JRNkRTbHBSSEJsZWVI?=
 =?utf-8?B?eWpiN25lYkZGT0lzSnFZZmlvMmdvZkpid01GQzkyKzBaNFp1THRPd2VoQVNh?=
 =?utf-8?B?M20vZERPTDBqZUVQb1kxaElva1psNWdxWE41dXhTQWhvM1p2SjZwcW1pZlhB?=
 =?utf-8?B?L0paYVpTN3RBUWZoamdiaVB6UmkyNnJVZkJqV3ROR3hPZkpqQ3E2Zk9oejMy?=
 =?utf-8?B?UnZiZXQrdkJSUFZWU25RR2tScTE1Sml1WTJTSUNkT0xrcHpoZ1BabTB6RHg3?=
 =?utf-8?Q?X6WfiGGA/gdjEOTjXPpa3ZcVq?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6675b782-b0f3-4485-4602-08da94cf43e7
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3395.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 14:58:34.6123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FIxA3HCgJejCL71CeEIlyVswGgLBLJmD/0DaGU6upfUU9GcbgVnkDjfSW7i7fj+AdeMZhhGjTYMgLafW3J84JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7509
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/22 16:29, Petr Mladek wrote:
> On Mon 2022-09-05 10:41:31, Petr Pavlu wrote:
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
> 
> Is it just an optimization or does it fix any real problem?
> It would be nice to provide some more details here.
> Otherwise, we do not know if the behavior change is worth it.

Motivation for this patch is to fix an issue observed on larger machines with
many CPUs where it can take a significant amount of time during boot to run
systemd-udev-trigger.service. An x86-64 system can have already intel_pstate
active but as its CPUs can match also acpi_cpufreq and pcc_cpufreq, udev will
attempt to load these modules too. The operation will eventually fail in the
init function of a respective module where it gets recognized that another
cpufreq driver is already loaded and -EEXIST is returned. However, one uevent
is triggered for each CPU and so multiple loads of these modules will be
present. The current code then processes all such loads individually and
serializes them with the barrier in add_unformed_module().

This can create a significant delay of several minutes. It prevents loading
drivers for other devices and might cause timeouts of services waiting on
them.

The issue was also observed with EDAC drivers which are similarly exclusive.

The problem was introduced with 6e6de3dee51a ("kernel/module.c: Only return
-EEXIST for modules that have finished loading") but arguably the previous
behavior was not well defined.

>> This patch improves the behavior as follows:
>> * A check whether a module load matches an already loaded module is
>>   moved right after a module name is determined.
>> * A new reference-counted shared_load_info structure is introduced to
>>   keep track of duplicate load requests. Two loads are considered
>>   equivalent if their module name matches. In case a load duplicates
>>   another running insert, the code waits for its completion and then
>>   returns -EEXIST or -ENODEV depending on whether it succeeded.
> 
> -ENODEV is strange, see https://www.gnu.org/software/libc/manual/html_node/Error-Codes.html
> 
>    Macro: int ENODEV
> 
>        “No such device.” The wrong type of device was given
>        to a function that expects a particular sort of device.
> 
> IMHO, it does not fit here. What about -EBUSY?
> 
>    Macro: int EBUSY
> 
>        “Device or resource busy.” A system resource that can’t
>        be shared is already in use. For example, if you try
>        to delete a file that is the root of a currently mounted
>        filesystem, you get this error.

Ok, makes sense.

>> Note that prior to 6e6de3dee51a ("kernel/module.c: Only return -EEXIST
>> for modules that have finished loading"), the kernel already did merge
>> some of same load requests but it was more by accident and relied on
>> specific timing. The patch brings this behavior back in a more explicit
>> form.
>>
>> ---
>>  kernel/module/main.c | 207 ++++++++++++++++++++++++++++++-------------
>>  1 file changed, 144 insertions(+), 63 deletions(-)
>>
>> diff --git a/kernel/module/main.c b/kernel/module/main.c
>> index a4e4d84b6f4e..24d0777c48e3 100644
>> --- a/kernel/module/main.c
>> +++ b/kernel/module/main.c
>> @@ -2552,43 +2539,129 @@ static int may_init_module(void)
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
>> + * Check that the module load is unique and make it visible to others. The code
>> + * looks for parallel running inserts and already loaded modules. Two inserts
>> + * are considered equivalent if their module name matches. In case this load
>> + * duplicates another running insert, the code waits for its completion and
>> + * then returns -EEXIST or -ENODEV depending on whether it succeeded.
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
>> +
>>  			err = wait_event_interruptible(module_wq,
>> -					       finished_loading(mod->name));
>> -			if (err)
>> -				goto out_unlocked;
>> -			goto again;
>> +						       shared_info->err != 0);
>> +			if (!err)
>> +				err = shared_info->err;
> 
> The logic around shared_info->err is a bit tricky. The value 0
> means that the parallel load is still in progress. Any error
> value means that it has finished. Where -EEXIST means that
> the load actually succeeded.
> 
> Such optimizations might make sense when they might safe a lot
> of memory. And even in these situations we should do out best
> to keep the logic straightforward.
> 
> I suggest to set shared_info->err to the really returned value.

Ok.

> And use another logic to check if the load finished. Either
> add a boolean. Or we might actually use shared_info->list.
> 
> struct shared_info is removed from @running_loads list when
> the load finished. We could do in finalize_running_load():
> 
> 	list_del_init(&shared_info->list);
> 
> and here:
> 
> 			err = wait_event_interruptible(module_wq,
> 						       list_empty(&shared_info->list);
> 
> 			/*
> 			 * Do not retry the module load when the parallel one
> 			 * failed. But do not return the exact error code
> 			 * because the parallel load might have used another
> 			 * module parameters. Instead return -EBUSY.
> 			 */
> 			if (!err) {
> 				err = shared_info->err ? -EBUSY : -EEXIST;
> [...]

Noted, discussed below.

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
>> +		shared_info = ERR_PTR(-EAGAIN);
> 
> I would return -EBUSY here to avoid too many variants. The load failed because
> the same module was being loaded or unloaded.
> 
> Anyway, it should be described in the commit message.

Ack, I'll change this error to -EBUSY too.

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
>> +/* Complete the running load and inform other duplicate inserts about it. */
>> +static void finalize_running_load(struct shared_load_info *shared_info, int err)
>> +{
>> +	mutex_lock(&module_mutex);
>> +	list_del(&shared_info->list);
>> +	shared_info->err = err == 0 ? -EEXIST : -ENODEV;
> 
> As explained above, I suggest to use:
> 
> 	list_del_init(&shared_info->list);
> 	shared_info->err = err;
> 
>> +	mutex_unlock(&module_mutex);
>> +
>> +	wake_up_all(&module_wq);
> 
> Heh, this should be wake_up_interruptible() to match
> the wait_event_interruptible().
> 
> The _all() variant is used when there exclusive waiters. I have
> recently learned about it, see
> https://lore.kernel.org/all/CAHk-=wgC47n_7E6UtFx_agkJtLmWOXGsjdFjybBFYNA1AheQLQ@mail.gmail.com/
> 
> But it should be fixed in a separate patch because the same mistake
> was there even before.

I'll add a separate patch to the series to correct it.

> Also it would make sense to add the wait queue head into struct
> shared_info to reduce spurious wakeups. The head is small,
> the struct is allocated anyway, and the lifecycle is the same.

Considering this and your previous comment about waiting on shared_info->err,
it looks best to me to use a per-shared_load_info completion.

>> +	shared_load_info_put(shared_info);
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
> Otherwise, the patch looks good to me.

Thank you for the review. I will prepare v2 of the patch.

Petr
