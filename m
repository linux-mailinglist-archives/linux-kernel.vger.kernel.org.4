Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE785FDBB3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 15:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbiJMNy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 09:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiJMNxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 09:53:43 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743CCE09CB;
        Thu, 13 Oct 2022 06:51:30 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oiyaB-00075D-RC; Thu, 13 Oct 2022 15:49:07 +0200
Message-ID: <dcadef9a-0bb7-345f-7ab0-dace5cc4ca50@leemhuis.info>
Date:   Thu, 13 Oct 2022 15:49:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] x86/perf: Fixed kernel panic during boot on Nano
 processor.
Content-Language: en-US, de-DE
To:     Codyyao-oc <Codyyao-oc@zhaoxin.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        shyaololo@163.com, 8vvbbqzo567a@nospam.xutrox.com,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <20210607013109.7870-1-CodyYao-oc@zhaoxin.com>
 <174219f5-c8ab-0ee4-8055-5cfa60c6a0fc@zhaoxin.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <174219f5-c8ab-0ee4-8055-5cfa60c6a0fc@zhaoxin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1665669090;75f23c8f;
X-HE-SMSGID: 1oiyaB-00075D-RC
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi perf maintainers and Codyyao-oc! What happened to below patch, which
was posted many moons ago? It wasn't merged afaics. Did it fall through
the cracks or is there something wrong with it?

I'm asking because a user who reported this regression asked what's up:
https://bugzilla.kernel.org/show_bug.cgi?id=212389

On 30.06.21 06:38, Codyyao-oc wrote:
> 
> Thank you for taking your precious time to read this letter, I am very
> graterful.
> 
> Last month, I fixed the bug that boot failed on Nano processor which
> introduced by
> 
> "Fixes: 3a4ac121c2ca ("x86/perf: Add hardware performance events support
> for Zhaoxin CPU.")"

Just BTW: You want to add that tag to your patch description.

> with Arjan's help and submitted this patch.  But I haven't got back.
> Greatly appreciate if you could kindly
> 
> check it and reply at your convenience.
> 
> Many Thanks!
> 
> Cody
> 
> On 2021/6/7 上午9:31, Cody Yao-oc wrote:
>> From: CodyYao-oc <CodyYao-oc@zhaoxin.com>
>>
>> Nano processor may not fully support rdpmc instruction, it works well
>> for reading general pmc counter, but will lead to GP(general protection)
>> when accessing fixed pmc counter. Futhermore, family/model information
>> is same between Nano processor and ZX-C processor, it leads to zhaoxin
>> pmu driver is wrongly loaded for Nano processor, which resulting boot
>> kernal fail.
>>
>> To solve this problem, stepping information will be checked to
>> distinguish
>> between Nano processor and ZX-C processor.

And this...

>> [https://bugzilla.kernel.org/show_bug.cgi?id=212389]

...should look like this:

Link: https://bugzilla.kernel.org/show_bug.cgi?id=212389

Ohh, and you might want to add this to ensure backporting:

Cc: <stable@vger.kernel.org> # 5.10.x

Guess adding those and submitting it again might be wise and help to
finally get this regression resolved.

Ciao, Thorsten

>> Reported-by: Arjan <8vvbbqzo567a@nospam.xutrox.com>
>> Signed-off-by: CodyYao-oc <CodyYao-oc@zhaoxin.com>
>> ---
>>   arch/x86/events/zhaoxin/core.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/events/zhaoxin/core.c
>> b/arch/x86/events/zhaoxin/core.c
>> index 949d845c922b..cef1de251613 100644
>> --- a/arch/x86/events/zhaoxin/core.c
>> +++ b/arch/x86/events/zhaoxin/core.c
>> @@ -541,7 +541,8 @@ __init int zhaoxin_pmu_init(void)
>>         switch (boot_cpu_data.x86) {
>>       case 0x06:
>> -        if (boot_cpu_data.x86_model == 0x0f ||
>> boot_cpu_data.x86_model == 0x19) {
>> +        if ((boot_cpu_data.x86_model == 0x0f &&
>> boot_cpu_data.x86_stepping >= 0x0e) ||
>> +            boot_cpu_data.x86_model == 0x19) {
>>                 x86_pmu.max_period = x86_pmu.cntval_mask >> 1;
>>   
