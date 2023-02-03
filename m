Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02980688DC6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 04:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbjBCDMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 22:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbjBCDMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 22:12:52 -0500
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D787316300
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 19:12:45 -0800 (PST)
X-ASG-Debug-ID: 1675393959-1eb14e797d4b450001-xx1T2L
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx2.zhaoxin.com with ESMTP id 3zDDlOXPcncYZjAu (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Fri, 03 Feb 2023 11:12:39 +0800 (CST)
X-Barracuda-Envelope-From: SilviaZhao-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXBJMBX02.zhaoxin.com (10.29.252.6) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Fri, 3 Feb
 2023 11:12:39 +0800
Received: from [10.29.8.47] (10.29.8.47) by ZXBJMBX02.zhaoxin.com
 (10.29.252.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Fri, 3 Feb
 2023 11:12:37 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Message-ID: <f2439f4d-9077-131d-b9fa-68d88a8b7697@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.8.47
Date:   Fri, 3 Feb 2023 11:12:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   silviazhaooc <silviazhao-oc@zhaoxin.com>
Subject: Re: [PATCH] x86/perf/zhaoxin: Add stepping check for ZX-C
To:     Kevin Brace <kevinbrace@gmx.com>
X-ASG-Orig-Subj: Re: [PATCH] x86/perf/zhaoxin: Add stepping check for ZX-C
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <tglx@linutronix.de>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <hpa@zytor.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <cobechen@zhaoxin.com>,
        <louisqi@zhaoxin.com>, <silviazhao@zhaoxin.com>,
        <tonywwang@zhaoxin.com>, <8vvbbqzo567a@nospam.xutrox.com>
References: <20230202091738.5947-1-silviazhao-oc@zhaoxin.com>
 <trinity-6c33de04-f4d5-475e-a3f7-dd4e858fc187-1675382037529@3c-app-mailcom-bs03>
Content-Language: en-US
In-Reply-To: <trinity-6c33de04-f4d5-475e-a3f7-dd4e858fc187-1675382037529@3c-app-mailcom-bs03>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.29.8.47]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 ZXBJMBX02.zhaoxin.com (10.29.252.6)
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1675393959
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 5122
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5000 1.0000 0.0000
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=MAILTO_TO_SPAM_ADDR
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.104247
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.00 MAILTO_TO_SPAM_ADDR    Includes a link to a likely spammer email
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

	Thanks for your kindly reply.

	Since VIA Nano 1000/2000/3000 series are really very old CPU, and we 
can't find related mainboard for full verification. We suggest not to 
support all Nano series for PMC driver.

On 2023/2/3 07:53, Kevin Brace wrote:
> Hi Silvia,
> 
> Thank you very much for resending the VIA / Zhaoxin PMU patch and for keeping me in the loop.
> I observed this bug on ECS (Elitegroup Computer Systems) VX900-I mainboard.
> The mainboard contains one VIA Nano L2007 processor (1.6 GHz) soldered on the PCB.
> Although I have not independently verified it, CPUID steppings for VIA Nano 1000 / 2000 series (Centaur Technology code name: CNA) are supposedly 2 and 3.
> CPUID stepppings for VIA Nano 3000 series (Centaur Technology code name: CNB) is 8.
> CPUID stepppings for VIA Nano x2 (Centaur Technology code name: CNC) is 10.
> 
> https://www.reddit.com/r/VIA/comments/dy71bn/via_centaurs_new_cpu_is_a_8core_x86_cpu_with_an/
> 
> I have not checked the actual CPUID steppings, but I have confirmed that the current code without the fix works okay with Nano 3000 series and Nano x2, but definitely not Nano 2000 series.
> For Nano 3000 series test, I used VIA Embedded EPIA M830 mainboard.
> For Nano x2 test, I used HP T510 thin client.
> Based on my observations, it appears that Centaur CNA contains a bug reading some performance counters, so not to cause inconveniences with users of Nano 1000 / 2000 series processors, the patch should limit / prevent reading performance counters on these processors.
> I think the code for the fix should reflect this the following way.
> 
> _______________________________________________________________
>   	switch (boot_cpu_data.x86) {
>   	case 0x06:
> -		if (boot_cpu_data.x86_model == 0x0f || boot_cpu_data.x86_model == 0x19) {
> +		if ((boot_cpu_data.x86_model == 0x0f && boot_cpu_data.x86_stepping >= 0x08) ||
> +			boot_cpu_data.x86_model == 0x19) {
> 
>   			x86_pmu.max_period = x86_pmu.cntval_mask >> 1;
> 
> _______________________________________________________________
> 
> The above code should exclude Nano 1000 / 2000 series processors properly.
> I lost easy access to ECS VX900-I mainboard for now (I need to look around for it. I do own another copy of it.), so I cannot confirm if the fix is properly working.
> I still have easy access to EPIA M830 mainboard.
>      I welcome anyone's feedback on this issue.
> This fix should go into the current kernel in development since it is a show stopper for users of Nano 1000 / 2000 series processors.
> If the fix is adopted, please backport it to previous releases of the kernel.
> I wasted about 2 weeks on this issue, and this fix should have never been ignored for such a long time.
> 
> Regards,
> 
> Kevin Brace
> Brace Computer Laboratory blog
> https://bracecomputerlab.com
> 
> 
>> Sent: Thursday, February 02, 2023 at 3:17 AM
>> From: "silviazhao-oc" <silviazhao-oc@zhaoxin.com>
>> To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
>> Cc: cobechen@zhaoxin.com, louisqi@zhaoxin.com, silviazhao@zhaoxin.com, tonywwang@zhaoxin.com, kevinbrace@gmx.com, 8vvbbqzo567a@nospam.xutrox.com
>> Subject: [PATCH] x86/perf/zhaoxin: Add stepping check for ZX-C
>>
>> Nano processor may not fully support rdpmc instruction, it works well
>> for reading general pmc counter, but will lead GP(general protection)
>> when accessing fixed pmc counter. Furthermore, family/mode information
>> is same between Nano processor and ZX-C processor, it leads to zhaoxin
>> pmu driver is wrongly loaded for Nano processor, which resulting boot
>> kernal fail.
>>
>> To solve this problem, stepping information will be checked to distinguish
>> between Nano processor and ZX-C processor.
>>
>> Fixes: 3a4ac121c2ca (“x86/perf: Add hardware performance events support for Zhaoxin CPU”)
>> Reported-by: Arjan <8vvbbqzo567a@nospam.xutrox.com>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=212389
>> Reported-by: Kevin Brace <kevinbrace@gmx.com>
>>
>> Signed-off-by: silviazhao-oc <silviazhao-oc@zhaoxin.com>
>> ---
>>   arch/x86/events/zhaoxin/core.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/events/zhaoxin/core.c b/arch/x86/events/zhaoxin/core.c
>> index 949d845c922b..cef1de251613 100644
>> --- a/arch/x86/events/zhaoxin/core.c
>> +++ b/arch/x86/events/zhaoxin/core.c
>> @@ -541,7 +541,8 @@ __init int zhaoxin_pmu_init(void)
>>   
>>   	switch (boot_cpu_data.x86) {
>>   	case 0x06:
>> -		if (boot_cpu_data.x86_model == 0x0f || boot_cpu_data.x86_model == 0x19) {
>> +		if ((boot_cpu_data.x86_model == 0x0f && boot_cpu_data.x86_stepping >= 0x0e) ||
>> +			boot_cpu_data.x86_model == 0x19) {
>>   
>>   			x86_pmu.max_period = x86_pmu.cntval_mask >> 1;
>>   
>> -- 
>> 2.17.1
>>
>>
