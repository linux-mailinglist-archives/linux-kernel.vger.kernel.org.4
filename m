Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8F267A1A5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 19:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbjAXSpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 13:45:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233927AbjAXSor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 13:44:47 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2AE18A92
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 10:44:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UDtYHQ7vnws6s94NKip1icPb+AxtajAwLE6QBuIwOWKNY/VDekhe6sH5n5I57pGVSkPXUizOFen+sHv+q4NW4WK4zTWVV4A7dBVzyUntwTcbkphorR0tiKG0lEcsKHuhB8EOL7yB0LWt6c3v9NQtT2e/8TOBP3QKtShQb3VAwQpyUVyzprMRXpZurQLqBFdhY93R7JMMMQd5X+EYqwg9TZrnouHJ8u5xfvCgD3vNYkyF1058//EyamaL/t7zflMSXVAlWWnK2WWpa5/b3iMRI2LeR9psqCWecQo6MiwxST9L8d+24O87toVRx10MnzVS/5FAfagdVwBMwglKn0eUsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7CboyaZ8rsoVnjSaZ0IQ1mL5Z65IzNIVaByJsAYxkks=;
 b=kmGa7cTNuWi6PdBuJMGSSCKH6ZiWSyL2VwYyzvV/of3696ecVelXaimVNy0tBD5XQeqw54yWC20WYRkfRc+o2quNTpmzlDgWAbQKq/+XuVwY2hdc7sytycytYvLTwkaunCpOKxyjPcO9tcYK2NVLcGWOKpm9UPYMmDYWdRkJ2iYGxvgQ5VEuVqeB53j+6JmyZXm+g4vFHp0jiNWiOG8jDjOkUIhvW6dlIjeUDvzt5en+1Z4q0SEI6epzFgADaNNOvJH8Eujf6ueUvnSp4htLF2utLwldDfV9k445h4zbki1vX05LyS9obYYiyq7jm45dMjkA8/8fACE6WPYQyLjd6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7CboyaZ8rsoVnjSaZ0IQ1mL5Z65IzNIVaByJsAYxkks=;
 b=Xuj1+04sJoT35Rx3RfbaMgC1j5CwxWrKoCfZaDc9+dte4U3H5bMUhEuo68fDaiynq0HTIxVaXoEvVEop59EvP30qX3MzvHOljqqUTngwhJ+xv+TNMPPYgoMn6KCH7kpWYDrBXka0DCxvSfhL+dwWMQFen9XMRkG214WEJLqNEnk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA1PR12MB6161.namprd12.prod.outlook.com (2603:10b6:208:3eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 18:44:10 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::790c:da77:2d05:6098%9]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 18:44:10 +0000
Message-ID: <8537e27a-b565-2618-43d0-b70a1a4390e4@amd.com>
Date:   Tue, 24 Jan 2023 12:44:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH] x86/resctrl: Fix a silly -Wunused-but-set-variable
 warning
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        x86@kernel.org, Reinette Chatre <reinette.chatre@intel.com>
References: <202301242015.kbzkVteJ-lkp@intel.com> <Y8/XoT23HVXHSY73@zn.tnic>
 <Y9AftBkWXcFflHbm@zn.tnic>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <Y9AftBkWXcFflHbm@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0104.namprd03.prod.outlook.com
 (2603:10b6:610:cd::19) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA1PR12MB6161:EE_
X-MS-Office365-Filtering-Correlation-Id: abb0b48c-d7c2-467a-bcef-08dafe3afb4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kard3BuMuOn1By29ZaiEMPjr0eK+nDJoib8Ha1mQoeh6So/CqZJv2WBexRrl3JzAt7jwh5mI4QX5/tsX52aftLAjh6N9NJcqBLYlquauRaTgSjBbcK2bXc+k2G7zwO1wVYoiNHzcVI+3aGUhTEV7BaOgoyWbWORVe7Nw5hbS8vy8Mc+F51Mr+6ntFPkRtVk52lICBkqm78D/YOgkd7wnpFIjeMIG/6aD+GrI3dIFcjVRoY/lhrZg7Dyg9BbipXV9QHnvuGJZ7rE/roZUI7YhMQhEygx61qvrVUeXtuPdDaKa//Rt9AI7Vk0oufHInnDLCf19AAPEjjNbjDjJ6XarSUFYflJU5YwQiWxrYqEvOtzymqG66OYmzXI9SaA/NZRTpwRnnbkJVARK4XxSjfGkGSrP9YChm2ZYPGEOvZlrxBsNlXBDBnXJjbEWkcu7Rfn4dGXJDuaMhT06gTJg9o+fi6zaoJYpclWNDLvVQws1s3hbqtEJ6v0zS0BQWRdxQHKogz3ZFOjkZ+6H9tNKDiqFBTdj8G60vWPAnwS04Otn3V0sZEVphhnMHFxI0QoWDHBSKe5u+cN21i4dNeB4ZGKd7xH9TaUHWpwXI4OR6NzU/6RZvE6Z93GVQRoR6PvP3BqZschm8Q1/PYrILyNTZaU8E29+asr9fEUwQlrLp1BH/4LJHzRvcyAzwKTm+W+73ksa2ReCXt5rTRTNNr7kzUd3XtNHzH4mP4cGFPfXoRN/Kl40LUy2QiS3IYCD0PjrfkNvOUJ+WhNStNk1kUO9azzXig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230024)(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(451199017)(31686004)(2616005)(3450700001)(2906002)(31696002)(38100700002)(8936002)(5660300002)(6486002)(54906003)(4326008)(8676002)(66476007)(66556008)(41300700001)(966005)(86362001)(6916009)(316002)(26005)(6512007)(186003)(53546011)(83380400001)(66946007)(36756003)(6506007)(478600001)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2JrSGN3Y0ViWEk3aHRvdVpjdW1ISFh2azE1aUozRW5hR2ljaC9WQlljeXJP?=
 =?utf-8?B?eDZNT3Qwc0NuTVpBc0p0dmFqa1YrcHE5dU5hQ2FjelIxRGRrNlFxaElHS2tV?=
 =?utf-8?B?WVNwYTMyWS94UVMwOTZDeUxHRllMbko2SlIwaEJBWXRDUkdpblJrckwrU2hS?=
 =?utf-8?B?VlE5M3RPbmJKenBYb2NyZCtyMHF5OVBWWk5xTXo4Y1JmV05GeTNQMXJ1a2FS?=
 =?utf-8?B?ZExrRFYrSlQ0eEhzc2lSRnE0TmhtZjNtNkJ5Vm1Va0YraVRBY2tGZk5JNTl2?=
 =?utf-8?B?d1VnZWVJZWUrNVgyL0p5N29KNnRFbCs3Q1ZDR01LanQzS09YWkVnK0UwNzB2?=
 =?utf-8?B?Rm9WNGhBaGQ0emxLUUdrNUVvOUFaQkRjVmtMd1JSWk1MQS81ai9BM3Rhc3FO?=
 =?utf-8?B?VDBCcEdYVTBkWDU3QmF4M2RXUlBaOWFralk4N2U3dGFjVy9HazVwVWxab0pM?=
 =?utf-8?B?OTY1K2gvcnlmMVZOZVFvUlVnZXRkSHU5U3hvZjNiUzFueWxFTWRFWGZ4R25s?=
 =?utf-8?B?a0Rwd045SnNlV1VtWmE4bkRvb3hOTEVlUzduenJ4cFlWK2Y2UkVBYndyWDZK?=
 =?utf-8?B?MWJlUHRUL29xZk15ZTdQeTRKZlovZHYwTzZueXRvaGRBcXZRd0pzVmxLTFdk?=
 =?utf-8?B?bXJ2QUh2MGM5V1U4dHljT3JpUWVHdTIrYXVHTUJHSHNtSjhOZUx0OTJVWkgr?=
 =?utf-8?B?M3RHc1dZT005Si8xbGsxUjlpNURjMEZIdVYyc0kvbW45V0tmZFJxOXI2NUZL?=
 =?utf-8?B?Q2IvU1FSd3lNdnc3eEZRTlpDd3YwanhYUS90REh4V0s2dFhjVFVyaldDZ0Jy?=
 =?utf-8?B?QlNGUUhpb0p6c2NIdWJ5N2FjRzRVWHd2M0VObmxVdittMG1JRVFYbGZrT2xv?=
 =?utf-8?B?Tk9rQzFqL3VNbzlRL0czNHdKSzBENUtVOWplbkYrTWk3QVZ3bXBWN3k1NGcx?=
 =?utf-8?B?dXYrMGNBTDZNMDF0a0NOUGpCZzRQRjhFUk5CWVZQYmJlSWwyUm9ub25xdFhM?=
 =?utf-8?B?cUs4RVNMM2s4UE9ibkxZNktHMExJTmZZa3NlTUV1R3FXdGhZUVlvL3pVMXNl?=
 =?utf-8?B?Mm56ZjB4UUNaMDVndlkwVHhRTGI3WFJpNnRGZGU2UDJuZ2EzcCszbHMvcGRx?=
 =?utf-8?B?K3R0aTkvTkR5QzRZVUc5RUZPbTlXVE5xdVk1eWNMWmxPNnVrb2E1ZTFGbElD?=
 =?utf-8?B?Tzk1Q2RmZGxqSFczL2dBU1JpQndGVXBoWHdTcUlWOVFyb0RZa3NVTFhCNk9t?=
 =?utf-8?B?bVhYWmVzRFNvRWMyaW9hMWJjLzUyNVJ1bSs0SndOYWtVTnVoUFB2OWpEZ0dC?=
 =?utf-8?B?M0ZUYmdhemNZMlhnL1VEdjF3MHRpSWxqbDVXOWdOL0wzaHBYc2JVNmtraGRl?=
 =?utf-8?B?Vk44T29KYWZNWWRJQUVXaGY1ZWxxemk2QkpGandVTnM1V3lGKzVHdjlESnln?=
 =?utf-8?B?WGg5bDNyZVpqRFhCdXNlOVJEVFNvWkpzaWZvUmYzbjQ2dDJWTkQwbzMwWkxR?=
 =?utf-8?B?ZXdFK1JrRHhHbVRPNVR3N09QazFkc2lBclhJRHdPamdhdmJCWWFPOHBoMCtZ?=
 =?utf-8?B?ZGFuTjBVYkdlcDV1eUdRcmJMRjkrMjBiQy9HaXVzQmExb2NEMFlIemowT3lm?=
 =?utf-8?B?bENpb3pGZzlSMlJnYzNNK0h2VkRaTkRCSk83WnJFM2VGWXVGVi9CYzdJVUND?=
 =?utf-8?B?VTIyRVUzc0JCQVloUzltZXlkUldYLzlpVG5uRVVSQVMrRWw4SHpycTcxTFJT?=
 =?utf-8?B?VWJKZ0V4Nll2MmttYjk0R1VheVY0Sy9FUWZYRVF3eEdGeDhxbVBCeXd6b0lU?=
 =?utf-8?B?S1duMUNDQ09FMGpRSm1zb21lcjdXZ3JaeG9oQ0FkSHRMdGVvTHJaZFpFOENI?=
 =?utf-8?B?SUZ2VHN4VjF1bzJiR1I4ODZEMFYydGRvcW92SW95MnpDTGVzcjNyZEx4dEhU?=
 =?utf-8?B?YUZhdUtLdjRpYURWb1FiVHhRR3g2c256LzRJRjFObHF0ZXEzaFBuampJU0R0?=
 =?utf-8?B?dEtZZmNlMXd3YUVjWXBVR1EwaDZVL09SNFgrcHFFM0FKU1pmTGdycmIxMk00?=
 =?utf-8?B?bDE3YXRhemw1ekswcS9nang1WHpHVCtuV3BiVFd2REFySEsyalRFOEl4RXlH?=
 =?utf-8?Q?Gt25PO4V9R1+6vT6Vu8WuJxx4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abb0b48c-d7c2-467a-bcef-08dafe3afb4a
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 18:44:10.5914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rnkhg16GIKPXC1yoJtzGALPScdMjsNH9Yb/VuY1oxrLsh8GFqjdvDvYRx4be0PPh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6161
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boris, Thanks for the fix.

Tested-by: Babu Moger <babu.moger@amd.com>


On 1/24/23 12:13, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
>
> clang correctly complains
>
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c:1456:6: warning: variable \
>      'h' set but not used [-Wunused-but-set-variable]
>           u32 h;
>               ^
>
> but it can't know whether this use is innocuous or really a problem.
> There's a reason why those warning switches are behind a W=1 and not
> enabled by default - yes, one needs to do:
>
>   make W=1 CC=clang HOSTCC=clang arch/x86/kernel/cpu/resctrl/
>
> with clang 14 in order to trigger it.
>
> I would normally not take a silly fix like that but this one is simple
> and doesn't make the code uglier so...
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Link: https://lore.kernel.org/r/202301242015.kbzkVteJ-lkp@intel.com
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 5990589f8a21..e2c1599d1b37 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1453,17 +1453,17 @@ static void mon_event_config_read(void *info)
>  {
>  	struct mon_config_info *mon_info = info;
>  	unsigned int index;
> -	u32 h;
> +	u64 msrval;
>  
>  	index = mon_event_config_index_get(mon_info->evtid);
>  	if (index == INVALID_CONFIG_INDEX) {
>  		pr_warn_once("Invalid event id %d\n", mon_info->evtid);
>  		return;
>  	}
> -	rdmsr(MSR_IA32_EVT_CFG_BASE + index, mon_info->mon_config, h);
> +	rdmsrl(MSR_IA32_EVT_CFG_BASE + index, msrval);
>  
>  	/* Report only the valid event configuration bits */
> -	mon_info->mon_config &= MAX_EVT_CONFIG_BITS;
> +	mon_info->mon_config = msrval & MAX_EVT_CONFIG_BITS;
>  }
>  
>  static void mondata_config_read(struct rdt_domain *d, struct mon_config_info *mon_info)

-- 
Thanks
Babu Moger

