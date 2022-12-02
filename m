Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D45640ABB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbiLBQ1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:27:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234094AbiLBQ13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:27:29 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CECA5F5A
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 08:27:28 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1p18sn-0004Gn-3W; Fri, 02 Dec 2022 17:27:25 +0100
Message-ID: <395ad6ef-eb54-ec7e-e131-714f23c84d7a@leemhuis.info>
Date:   Fri, 2 Dec 2022 17:27:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] Revert "arm64: dma: Drop cache invalidation from
 arch_dma_prep_coherent()"
Content-Language: en-US, de-DE
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Will Deacon <will@kernel.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>, andersson@kernel.org,
        sumit.semwal@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hch@lst.de
References: <20221118123349.GC3697@willie-the-truck>
 <20221121064224.GB11945@thinkpad>
 <018517b8-0ae0-54f5-f342-dcf1b3330a13@quicinc.com> <Y39blgEueyegkz6C@arm.com>
 <6d637906-e1d5-c481-a73d-2b2b845e223b@leemhuis.info>
 <Y4joR2sQMMjIt+yE@arm.com>
 <CAMi1Hd2wM5MLsjkx0HAWKkswzTDACb0C4tsPymNrRa0ariWsww@mail.gmail.com>
 <f98d163b-3410-9cf7-7d98-0f7640f4aa1f@leemhuis.info>
 <20221202100357.GB29396@willie-the-truck>
 <92a148a3-a8ac-4065-123c-99b72ac3ebeb@leemhuis.info>
 <Y4ojXyXMX2p+RVBR@kroah.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <Y4ojXyXMX2p+RVBR@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1669998448;e46431d0;
X-HE-SMSGID: 1p18sn-0004Gn-3W
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02.12.22 17:10, Greg KH wrote:
> On Fri, Dec 02, 2022 at 11:34:30AM +0100, Thorsten Leemhuis wrote:
>> On 02.12.22 11:03, Will Deacon wrote:
>>> On Fri, Dec 02, 2022 at 09:54:05AM +0100, Thorsten Leemhuis wrote:
>>>> On 02.12.22 09:26, Amit Pundir wrote:
>>>>> On Thu, 1 Dec 2022 at 23:15, Catalin Marinas <catalin.marinas@arm.com> wrote:
>>>>>>
>>>>>> On Thu, Dec 01, 2022 at 10:29:39AM +0100, Thorsten Leemhuis wrote:
>>>>>>> Has any progress been made to fix this regression? It afaics is not a
>>>>>>> release critical issue, but well, it still would be nice to get this
>>>>>>> fixed before 6.1 is released.
>>>>>>
>>>>>> The only (nearly) risk-free "fix" for 6.1 would be to revert the commit
>>>>>> that exposed the driver bug. It doesn't fix the actual bug, it only
>>>>>> makes it less likely to happen.
>>>>>>
>>>>>> I like the original commit removing the cache invalidation as it shows
>>>>>> drivers not behaving properly
>>>>
>>>> Yeah, I understand that, but I guess it's my job to ask at this point:
>>>> "is continuing to live with the old behavior for one or two more cycles"
>>>> that much of a problem"?
>>>
>>> That wouldn't be a problem. The problem is that I haven't see any efforts
>>> from the Qualcomm side to actually fix the drivers [...]
>>
>> Thx for sharing the details. I can fully understand your pain. But well,
>> in the end it looks to me like this commit it intentionally breaking
>> something that used to work -- which to my understanding of the "no
>> regression rule" is not okay, even if things only worked by chance and
>> not flawless.
> 
> "no regressions" for userspace code, this is broken, out-of-tree driver
> code, right?

If so: apologies. But that's not the impression I got, as Amit wrote "I
can reproduce this crash on vanilla v6.1-rc1 as well with no out-of-tree
drivers." here:
https://lore.kernel.org/linux-arm-kernel/CAMi1Hd3H2k1J8hJ6e-Miy5+nVDNzv6qQ3nN-9929B0GbHJkXEg@mail.gmail.com/

>  I do not think any in-kernel drivers have this issue today
> from what I can tell, but if I am wrong here, please let me know.
> 
> We don't keep stable apis, or even functionality, for out-of-tree kernel
> code as that would be impossible for us to do for obvious reasons.

Ciao, Thorsten
