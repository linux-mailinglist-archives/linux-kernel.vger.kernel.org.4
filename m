Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052846A3880
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 03:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbjB0C1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 21:27:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbjB0C1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 21:27:25 -0500
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBC91514F;
        Sun, 26 Feb 2023 18:24:29 -0800 (PST)
X-UUID: 85e3b750df9f43209297f653ba2aad9d-20230227
X-CPASD-INFO: 700016cae62b46399f40cd4f94c963ba@gIBqUF5okZGRVnSug3l-c1mXZGCTkFS
        1e26DaWRjjoGVhH5xTV5nX1V9gnNXZF5dXFV3dnBQYmBhXVJ3i3-XblBgXoZgUZB3hnJqUGFkkw==
X-CLOUD-ID: 700016cae62b46399f40cd4f94c963ba
X-CPASD-SUMMARY: SIP:-1,APTIP:-2.0,KEY:0.0,FROMBLOCK:1,OB:0.0,URL:-5,TVAL:145.
        0,ESV:0.0,ECOM:-5.0,ML:0.0,FD:0.0,CUTS:186.0,IP:-2.0,MAL:-5.0,PHF:-5.0,PHC:-5
        .0,SPF:4.0,EDMS:-5,IPLABEL:4480.0,FROMTO:0,AD:0,FFOB:0.0,CFOB:0.0,SPC:0,SIG:-
        5,AUF:1,DUF:17006,ACD:245,DCD:245,SL:0,EISP:0,AG:0,CFC:0.638,CFSR:0.102,UAT:0
        ,RAF:2,IMG:-5.0,DFA:0,DTA:0,IBL:-2.0,ADI:-5,SBL:0,REDM:0,REIP:0,ESB:0,ATTNUM:
        0,EAF:0,CID:-5.0,VERSION:2.3.17
X-CPASD-ID: 85e3b750df9f43209297f653ba2aad9d-20230227
X-CPASD-BLOCK: 1000
X-CPASD-STAGE: 1
X-UUID: 85e3b750df9f43209297f653ba2aad9d-20230227
X-User: luoxueqin@kylinos.cn
Received: from [172.20.116.208] [(116.128.244.169)] by mailgw
        (envelope-from <luoxueqin@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1391154859; Mon, 27 Feb 2023 10:22:47 +0800
Message-ID: <5b22ef4c-d0a6-5f28-7f71-e4de67d97b87@kylinos.cn>
Date:   Mon, 27 Feb 2023 10:22:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH -next] PM: tools: add "CPU killed" timeline on arm64
 platform
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        todd.e.brandt@linux.intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230223044550.339811-1-luoxueqin@kylinos.cn>
 <CAJZ5v0jyz_dpKW1GhWN=yYpR9-7WG33GbZ65aoGv+B+R9vEpEw@mail.gmail.com>
From:   luoxueqin <luoxueqin@kylinos.cn>
In-Reply-To: <CAJZ5v0jyz_dpKW1GhWN=yYpR9-7WG33GbZ65aoGv+B+R9vEpEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2023/2/24 02:11, Rafael J. Wysocki 写道:
> On Thu, Feb 23, 2023 at 5:46 AM Xueqin Luo <luoxueqin@kylinos.cn> wrote:
>>
>> On the arm64 platform, the core log of cpu offline is as follows:
> 
> Please spell CPU in capitals.

Thanks for pointing out my mistake.

> 
>> [  100.431501] CPU1: shutdown
>> [  100.454820] psci: CPU1 killed (polled 20 ms)
>> [  100.459266] CPU2: shutdown
>> [  100.482575] psci: CPU2 killed (polled 20 ms)
>> [  100.486057] CPU3: shutdown
>> [  100.513974] psci: CPU3 killed (polled 28 ms)
>> [  100.518068] CPU4: shutdown
>> [  100.541481] psci: CPU4 killed (polled 24 ms)
>>
>> 'smpboot: CPU (?P<cpu>[0-9]*) is now offline' cannot be applied
>> to the arm64 platform, which caused the loss of the suspend
>> machine stage in S3.
> 
> I'm not exactly sure what you mean by "loss of the suspend machine stage in S3".

I made a mistake in saying "loss of the suspend machine stage in S3", 
please allow me to correct it. Because the original program only 
recognized the "CPU up" action on the arm64 platform, in output.html, 
"CPU up" was classified as the "suspend machine" stage. Adding this code 
can put "CPU killed" and "CPU up" in the correct position.

> 
>>   Here I added core code to fix this issue.
>>
>> Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
>> ---
>>   tools/power/pm-graph/sleepgraph.py | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/power/pm-graph/sleepgraph.py b/tools/power/pm-graph/sleepgraph.py
>> index 82c09cd25cc2..d816970b0a3d 100755
>> --- a/tools/power/pm-graph/sleepgraph.py
>> +++ b/tools/power/pm-graph/sleepgraph.py
>> @@ -4132,9 +4132,12 @@ def parseKernelLog(data):
>>                          elif(re.match('Enabling non-boot CPUs .*', msg)):
>>                                  # start of first cpu resume
>>                                  cpu_start = ktime
>> -                       elif(re.match('smpboot: CPU (?P<cpu>[0-9]*) is now offline', msg)):
>> +                       elif(re.match('smpboot: CPU (?P<cpu>[0-9]*) is now offline', msg)) \
>> +                               or re.match('psci: CPU(?P<cpu>[0-9]*) killed.*', msg)):
>>                                  # end of a cpu suspend, start of the next
>>                                  m = re.match('smpboot: CPU (?P<cpu>[0-9]*) is now offline', msg)
>> +                               if(not m):
>> +                                       m = re.match('psci: CPU(?P<cpu>[0-9]*) killed.*', msg)
>>                                  cpu = 'CPU'+m.group('cpu')
>>                                  if(cpu not in actions):
>>                                          actions[cpu] = []
>> --
> 
> The changes look reasonable to me, though.
> 
> Todd, any comments?

