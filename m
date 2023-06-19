Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42CB734BBD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 08:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjFSG2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 02:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjFSG2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 02:28:34 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2080.outbound.protection.outlook.com [40.107.8.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3E3E42
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 23:28:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bg+ANbdZ4Oi1Ntsw7Ky8G1TDpsNSomRbhjChl8MpGelku+RnnRQAQr9DSvPN1CymQkxJX9EocSJW5h5Gy3bd23SgFL8gEPmrTSitB2QmOyEBoU9ZZd3NMog5MkaCDXIsdMgV+7rKPq3sa84xtOGkVcuVKSyCNvIHEm8m5Rmbx6dCOoPoP6HvWPoyYSReIwDMIgFk2UkvDjb+OI8CyuJ2K5dSRHGMlq/ILeLlxs/aJYPNw/SPCsKQLohogJnl64Mhb0NXG4hdjlSMSWcC6ottEr/lCVgxVjynaOMXMHxsU7V4rKnizzIEisVO7LPv9w5TpiCbSbrtx8xa9GKzziwBhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JVsUhsemtoxxNmFs4nO+/wHXxkvaUBbo6dYYhkNknuQ=;
 b=BoAOd/ywVMqiIKUCXaRP93U/hDphApbV/j8lNPLlXyDkP+HvJULeE9+ai6V9Mp2TlEVoSPjSH7C/2u3YU/AT9OsJeXedDXr0oxQItIa62FY+CpOKNHLnZ/1A2pMAYVbbyn84o4QHTJNcsgtNFGeWCHKhpNIvUEyKR7WO0p2hQ/Fogpva9qoEwVMFRJUwZyuWtUk8Kr5Atevt0VAYwVUlWyDglJygOuxpvCd+v4+MQEkGSMnzWhP+IDDxXSNsSCJXOi0rIbPvbn3lA+bCeDZLX8XHzVBepSPJYMHJXc+wlbX9+ULRL7WEi+t7rUexkk5b4uxPfOx+rLkP4bg1iewNTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVsUhsemtoxxNmFs4nO+/wHXxkvaUBbo6dYYhkNknuQ=;
 b=MW9TM9xPOehNS5NsKEPGbW52AvY/Ygh31gN8VxbwuEEvCXRxCAv9KYqbSQN4oGR2VlU7/u4wSogQAKzn1My9g4L+OEqaKm60o1P9as+FnP49hQUUvQj1/sWa2rWYCT1Wc1uZsrNSWqjQi1gOwRwxPaVxpiqDHJMMhPgXyTpYs1+2/kSK2J7kZe3WkfoGI2vKnsveNZqRvSYFNHI7Vf+S/ma/fy6bX8HfTDOg6sEldKJoLhn3VRYhP7ILicxOYsOPROZY225Se/VHs3lFFDUGCFtuy0qqkj5eU7OSzeT+LJPpzCug3gsDIi8HRnT7/OXAC9MObdppX6j4uyaKPjkn2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by GVXPR04MB10071.eurprd04.prod.outlook.com (2603:10a6:150:11a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Mon, 19 Jun
 2023 06:28:24 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::66a2:8913:a22a:be8d]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::66a2:8913:a22a:be8d%4]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 06:28:24 +0000
Message-ID: <cf24db95-9c91-5d30-fe83-3a1e2cbf0cc1@suse.com>
Date:   Mon, 19 Jun 2023 09:28:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 5/5] x86/entry: Make IA32 syscalls' availability depend
 on ia32_enabled()
To:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com, jslaby@suse.cz
References: <20230616125730.1164989-1-nik.borisov@suse.com>
 <20230616125730.1164989-6-nik.borisov@suse.com> <87mt0wqxkt.ffs@tglx>
Content-Language: en-US
From:   Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <87mt0wqxkt.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0240.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::15) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|GVXPR04MB10071:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d6d6da0-766f-429c-5482-08db708e6219
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xArxoxBk1vZg6Nq5B5ZiuZdR52p03vsjgurjPoH2uXK3JEzvDK927GAaS54FTzDG6zc8yg6xfKhEZZkaU7mXDdjR2hz/YvXdT5akJyPSHePxwPb3d+pXyi5TbBn0aFO4OPVtkZSyJeT9Rw7Mp3Br5zU/38GCtnsl9MuaCRicT1g3e8+ZmKD4coHFobMbBo1v2rngVLtWCd660HJfTDHRteeLJBzS1zx4O6LFsNyfJ09Uw1KWf4xYOPBP8+L+odrCiIfeYK9T2q+voJ/OaunQCC/eOsTg+1AtK+jbkS35wY8qQDUgVP6WmVf40XLG+8F6pvruhMDgQH6yZPZMJt8DiyDq2uV990c15pnFsHjfxiLLk4vczQ+b6ZOwFmKxLeDJwcGxKgM5IYGd0c1hrRv/sOI+12o482upYnYXR3eDYGe1tT1pKJxBWxapbpf3w2tW3DEMG+YHAUVeSBsrdamtX7rYfAJ2+c0mA/yk30TDGgE1StFOOeelPGmiOR3muVVjM11KsPT9XroatSyATbFoLMYXi1JXBH4EDlL8yTS8i1ryeE9ZhfelEo2bpOSpxx1sBzvkw28XFcRRZKnxbuwr8fJDH5DkjhXUTkISBY+8AszWqJPygkHxk7L8kC3hkbLSesh6lbl/YMOVYAgF1DoMRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(396003)(346002)(376002)(136003)(451199021)(186003)(8936002)(66946007)(8676002)(66476007)(66556008)(5660300002)(66899021)(6486002)(316002)(38100700002)(478600001)(41300700001)(36756003)(6512007)(6506007)(4326008)(2906002)(31696002)(86362001)(31686004)(83380400001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjQxTjhFekZXQ0QrcU53Uk95YXYvRUdWOFJkOGd3NG9ndmVZeHhsWUU1Ukl4?=
 =?utf-8?B?TldhWDBjUzRYUEJrN0R1NzB3S3VQTHFYYUZFcTkvaFVhMnJUQjVXR1JuRGZi?=
 =?utf-8?B?MjYwOUdCK0N2NGNmWTFJcStyNDJPaWYvTDhpM0xhclR5SnRuZkgwUkI5bE8z?=
 =?utf-8?B?R0ZFeDZ3dnVUUjdlR21Ua2pVU0pwWk5oL2t3RG1scHdlN25ZYm8zcTRjZmRw?=
 =?utf-8?B?anIzeWdVYlhtSTZJSld2UE9ZaENpUloyU2kxUTVVV1dKb09mMXNrOG9kV3RL?=
 =?utf-8?B?K3p3blVwVURmRUluR0RQNGpaR2ZWeENJcUJ6eWZyaHk5NzJnV0hPMDI1SllV?=
 =?utf-8?B?QzE4Yk9yV0FzZHM1anFxMGcwZzhkLzFnN3pYQTVSMndpeXl5RUJOZDZCKzZw?=
 =?utf-8?B?Tkl2Y3J6Y2VRMzlBbDlGdVk1YWZZdEthK2dYMUtTOEUxVTg0M1BSRnAyQUdJ?=
 =?utf-8?B?TXorU1gyOG02WithRkpMbzhScmxKUUxIZCtMUm1iMElzVHlRb05YY2RyUXJz?=
 =?utf-8?B?ZEVLLzA5ZXZnbVhOcFZhZnhueEJVSkFkZExIaklweGY2cThkbDBFbGRwTU9E?=
 =?utf-8?B?QlpYVW1LK0VHYVZrc094dDcvcEp1bWVCejBTZjQ3TFNTbjlkSjBkZk5nREh0?=
 =?utf-8?B?Uk82M2sxQWV6dU5nSE54SC9Pd2FPSWFFRlRWQWhHWUtDajhkYVM4MlRvbm15?=
 =?utf-8?B?YUlMLzZwRmszY2xyNERVVnlGejZBLzhmbUlJdC9meUtmMnkzNUZUcGtBMElj?=
 =?utf-8?B?cUtLVllFRGRlcVVhVFd0NU52UTN0TTFES1lEL2xOVlE2UW53MXJ2K2JSYXEw?=
 =?utf-8?B?Uzdqc1MwSDR1WktudVQxZCtKZkhtbnRsVnAvQUEvRHZxcUwvaHRlOEhXdHQ3?=
 =?utf-8?B?VnR2Wnl3SE04M2gwTVo2dTBwUHdCVjNhWXpuOXdEcFN6RGNGUVdvcXJtbGxJ?=
 =?utf-8?B?b3lrQ0l2Z0tQbzR6c05RWEdWeDFMZ281RUpJK3BkcWZYTnN5empPM0JNc0s4?=
 =?utf-8?B?c3NwUWg1czByN2xUWVRXaS8wR2dMcU5iU3QvSkZETmovZlZVSjZGeXpMWG94?=
 =?utf-8?B?bmNmVVg1dUNKRDcvSklXK3QwZkkrVHRoRnhiTnZRN3dNWlBYU285cUJPZkQ5?=
 =?utf-8?B?TEswRy9lN09Xc05qc0prajhEOVBpaXhhcmxTdWZncVBSVGxmdGU1NThXMkEz?=
 =?utf-8?B?WklVSEJDYVZYeGhXUkN0NDFsdTdTaHV2STR1QUp1Mm02SnVISFJOckh6bDY2?=
 =?utf-8?B?K2pMMzBKR05KODFCdmEvcysrdGdyY1RUZVpHSVhVSkpMZVhtc3JMRFpjTnV4?=
 =?utf-8?B?UDl0bEZwNUlrYW0xYndyUXFGTGx2QjdlQWtGVWZOa1kzS2ZFM0FySnZ5aDBU?=
 =?utf-8?B?N3JHTFpBajNEbmhFRm1QcEhubkJhaDl4R3NNamVkY1N1elJLMlFhYWVhTVg3?=
 =?utf-8?B?Qi96ZHE2YWxGWHJ5VUlJUk0zSGg2NGkzVUFZbGNsVk12QkE0YUhaTm9kb3Zz?=
 =?utf-8?B?R3VtUnI2eE1QS3VzUlppZERNV0xGSXJ3eE5UVHlwem85SmNJa0Nwc1VLY3hi?=
 =?utf-8?B?cnNWbXU3dnM1S3FRUm0xRkU0VGhpMHhnMHUwMDdicVRpRU9WTWE5Wnh0V08z?=
 =?utf-8?B?N09yZ0I0eEF2QXNWQWZYMUpRNHdDMitTSS82czNIMk9UbXN1TndEenJad2VW?=
 =?utf-8?B?dTl0bFk4aHE4b2ZKejIrZTBXRWFueUdCTFluYWlZNjRJUVplalJDdWovcWdo?=
 =?utf-8?B?dy9mTGRLNzU5YUswdTRKZVozVWVCR2k2bExIeWJteHFwdWxZWTVjN3ZKbXRj?=
 =?utf-8?B?b1VBbzZaZGhPUjBkNWhoL2M5MmF3dFArRDVtMGRsOWtYVzEzOXV2VWZkckRm?=
 =?utf-8?B?WlVWYVNSRVhDUHdhZmUwMWRldStGOWxxVXcxek11dnY5MmhCKzNqSi9CeTAr?=
 =?utf-8?B?L2JGTm1NSmFma0pzU1JrRUNyMGJIYkdTWTFHZ1g0TVozcFdPU3dwbjliOEww?=
 =?utf-8?B?cUpna1BaWmtQTnpaZnk0bUU1L2p3U1VhMithenJROW9mWnFqUUVHMk84aVpn?=
 =?utf-8?B?N3FtcXFTTHpBZVd2TzRkR1RqME9ad2ZYWkRDMCtlb2xORjZKZGJIQmZIQXRo?=
 =?utf-8?B?VkNLUm40MWJWRFpBZUJEM1hhQlJseXdWVnJ5aXc5MUdxQUNDeWxpM3ZueitJ?=
 =?utf-8?Q?gls5FyeRQVo0bFrhGggD2VWxSawlC3xZSCQqxq/luQ5h?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d6d6da0-766f-429c-5482-08db708e6219
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 06:28:23.8489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RgQW/rINvl7yh2e8A0D4gnN+hWOWb7b7QuUCVZGJD78exN5+sL8PPwn5qo7vAmEkEo4W1cD0nPUrLE1bxFHBhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10071
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19.06.23 г. 0:17 ч., Thomas Gleixner wrote:
> On Fri, Jun 16 2023 at 15:57, Nikolay Borisov wrote:
>> Another major aspect of supporting running of 32bit processes is the
>> ability to access 32bit syscalls. Such syscalls are invoked either by
>> using the legacy int 0x80 call gate interface or via the newer sysenter
>> instruction.
>>
>> Ensure that if ia32 emulation is disabled (either at compile time or
>> runtime) then those 2 syscall mechanisms are also disabled.
> 
> AFAICT there are _three_ mechanisms for 32bit syscalls, no?

int 0x80 and sysenter make it 2? Which one is the 3rd one - the "native 
64bit syscall" used in for X32 ABI ? This patch specifically deals with 
the first 2?
> 
>>   void __init idt_setup_traps(void)
>>   {
>>   	idt_setup_from_table(idt_table, def_idts, ARRAY_SIZE(def_idts), true);
>> +
>> +	if (ia32_enabled()) {
>> +		idt_setup_from_table(idt_table, ia32_idt, ARRAY_SIZE(ia32_idt),
>> +				     true);
> 
> Just let it stick out. The 80 character limit is history.
> 
> Thanks,
> 
>          tglx
