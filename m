Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABE1640289
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 09:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbiLBIyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 03:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbiLBIyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 03:54:12 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764302AC48
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 00:54:11 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1p11o5-0007R7-NO; Fri, 02 Dec 2022 09:54:05 +0100
Message-ID: <f98d163b-3410-9cf7-7d98-0f7640f4aa1f@leemhuis.info>
Date:   Fri, 2 Dec 2022 09:54:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] Revert "arm64: dma: Drop cache invalidation from
 arch_dma_prep_coherent()"
Content-Language: en-US, de-DE
To:     Amit Pundir <amit.pundir@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Sibi Sankar <quic_sibis@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, andersson@kernel.org,
        sumit.semwal@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221114110329.68413-1-manivannan.sadhasivam@linaro.org>
 <20221114141109.GG30263@willie-the-truck>
 <1659929b-1372-cea6-5840-c58369a4252d@arm.com> <Y3J8+O7Y3f3onH0P@arm.com>
 <20221118105402.GA184726@thinkpad> <20221118123349.GC3697@willie-the-truck>
 <20221121064224.GB11945@thinkpad>
 <018517b8-0ae0-54f5-f342-dcf1b3330a13@quicinc.com> <Y39blgEueyegkz6C@arm.com>
 <6d637906-e1d5-c481-a73d-2b2b845e223b@leemhuis.info>
 <Y4joR2sQMMjIt+yE@arm.com>
 <CAMi1Hd2wM5MLsjkx0HAWKkswzTDACb0C4tsPymNrRa0ariWsww@mail.gmail.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <CAMi1Hd2wM5MLsjkx0HAWKkswzTDACb0C4tsPymNrRa0ariWsww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1669971251;fce1174f;
X-HE-SMSGID: 1p11o5-0007R7-NO
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.12.22 09:26, Amit Pundir wrote:
> On Thu, 1 Dec 2022 at 23:15, Catalin Marinas <catalin.marinas@arm.com> wrote:
>>
>> On Thu, Dec 01, 2022 at 10:29:39AM +0100, Thorsten Leemhuis wrote:
>>> Has any progress been made to fix this regression? It afaics is not a
>>> release critical issue, but well, it still would be nice to get this
>>> fixed before 6.1 is released.
>>
>> The only (nearly) risk-free "fix" for 6.1 would be to revert the commit
>> that exposed the driver bug. It doesn't fix the actual bug, it only
>> makes it less likely to happen.
>>
>> I like the original commit removing the cache invalidation as it shows
>> drivers not behaving properly

Yeah, I understand that, but I guess it's my job to ask at this point:
"is continuing to live with the old behavior for one or two more cycles"
that much of a problem"?

>> but, as a workaround, we could add a
>> command line option to force back the old behaviour (defaulting to the
>> new one) until the driver is fixed.

Well, sometimes that approach is fine to fix a regression, but I'm not
sure this is one of those situations, as this...

> We use DB845c extensively for mainline and android-mainline[1] testing
> with AOSP, and it is broken for weeks now. So be it a temporary
> workaround or a proper driver fix in place, we'd really appreciate a
> quick fix here.

...doesn't sound like we are not talking about some odd corner case
here. But in the end that would be up to Linus to decide.

I'll point him to this thread once more in my weekly report anyway.
Maybe I'll even suggest to revert this change, not sure yet.

> [...]

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
