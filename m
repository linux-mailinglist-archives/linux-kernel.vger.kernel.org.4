Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22F068B794
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 09:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjBFImY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 03:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjBFImN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 03:42:13 -0500
X-Greylist: delayed 920 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 06 Feb 2023 00:41:56 PST
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7090D1A963
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 00:41:56 -0800 (PST)
X-ASG-Debug-ID: 1675671989-086e23046400640001-xx1T2L
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx1.zhaoxin.com with ESMTP id zsk6nZcjvyU21bBm (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Mon, 06 Feb 2023 16:26:29 +0800 (CST)
X-Barracuda-Envelope-From: SilviaZhao-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ZXBJMBX02.zhaoxin.com (10.29.252.6) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Mon, 6 Feb
 2023 16:26:28 +0800
Received: from [10.29.8.47] (10.29.8.47) by ZXBJMBX02.zhaoxin.com
 (10.29.252.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Mon, 6 Feb
 2023 16:26:26 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Message-ID: <51ab21ee-403b-f4ce-9a7e-2580ab7e8118@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.8.47
Date:   Mon, 6 Feb 2023 16:26:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] x86/perf/zhaoxin: Add stepping check for ZX-C
To:     Borislav Petkov <bp@alien8.de>
X-ASG-Orig-Subj: Re: [PATCH] x86/perf/zhaoxin: Add stepping check for ZX-C
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <tglx@linutronix.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <cobechen@zhaoxin.com>, <louisqi@zhaoxin.com>,
        <silviazhao@zhaoxin.com>, <tonywwang@zhaoxin.com>,
        <kevinbrace@gmx.com>, <8vvbbqzo567a@nospam.xutrox.com>
References: <20230202091738.5947-1-silviazhao-oc@zhaoxin.com>
 <Y95hWVFyw7TM1WSB@zn.tnic>
Content-Language: en-US
From:   silviazhaooc <silviazhao-oc@zhaoxin.com>
In-Reply-To: <Y95hWVFyw7TM1WSB@zn.tnic>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.29.8.47]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 ZXBJMBX02.zhaoxin.com (10.29.252.6)
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1675671989
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 3192
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5000 1.0000 0.0000
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.104392
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/4 21:44, Borislav Petkov wrote:
> On Thu, Feb 02, 2023 at 05:17:38PM +0800, silviazhao-oc wrote:
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
> 
> Please use your proper name in the Signed-off-by.
> 
Due to our company’s email policy, email address with oc suffix is used 
for sending email without confidentiality statement at the end of the 
mail body.

I will remove –oc from my name later.

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
> 
> Last time we talked:
> 
> https://lore.kernel.org/r/3c7da7fd-402f-c74f-c96c-0e88828eab58@zhaoxin.com
> 
> you said that Nano #GPs when trying to RDPMC the fixed counters. Which
> sounds like an erratum.
> 
> We do those by adding a X86_BUG flag, set that flag for Nano and then
> test it where needed. Grep the source tree for examples.
> 
> Please do that above too unstead of testing steppings.
> 
Nano series CPUs are too old, we have not fully verified their PMC 
functions, furthermore our original development plan is to support PMC 
from ZXC, not including Nano series.

In that way, I think it’s better to exclude Nano series CPU in the PMC 
driver.

> Also, I'd like to know why do steppings < 0xe mean Nano and why isn't
> there a more reliable way to detect it?
> 

Generally, CPUs are identified by FMS(Family/Model/Stepping) information.

As you said, it is not a good practice to use stepping information to 
distinguish different CPU series.

But due to some unknown historical reasons, the FMS of Nano and ZXC are 
only different in stepping.

I have considered about using the “Model name string” to distinguish 
them, but it doesn't seem to be a common way in Linux kernel.

> Thx.
> 
