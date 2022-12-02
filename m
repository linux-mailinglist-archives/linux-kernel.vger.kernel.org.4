Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887BD640275
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 09:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbiLBIq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 03:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232514AbiLBIq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 03:46:56 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BAF975D5
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 00:46:54 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1p11h3-0005H4-2F; Fri, 02 Dec 2022 09:46:49 +0100
Message-ID: <f792d1d3-7181-8a17-5cf6-1ea13e84bb9b@leemhuis.info>
Date:   Fri, 2 Dec 2022 09:46:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [mm] f35b5d7d67: will-it-scale.per_process_ops -95.5% regression
Content-Language: en-US, de-DE
To:     Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>
Cc:     Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        kernel test robot <yujie.liu@intel.com>, lkp@lists.01.org,
        lkp@intel.com, Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        feng.tang@intel.com, zhengjun.xing@linux.intel.com,
        fengwei.yin@intel.com, Nathan Chancellor <nathan@kernel.org>
References: <202210181535.7144dd15-yujie.liu@intel.com>
 <87edv4r2ip.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Y1DNQaoPWxE+rGce@dev-arch.thelio-3990X>
 <871qr3nkw2.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <366045a27a96e01d0526d63fd78d4f3c5d1f530b.camel@surriel.com>
 <Y1GCYXGtEVZbcv/5@dev-arch.thelio-3990X>
 <Y4RX+JZLddDHrLuQ@dev-arch.thelio-3990X>
 <e919e5a3-1118-043e-8bbd-5ee35f2ab411@leemhuis.info>
 <07adee081a70c2b4b44d9bf93a0ad3142e091086.camel@surriel.com>
 <20221201132237.c55c4bd07ba44463b146882e@linux-foundation.org>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <20221201132237.c55c4bd07ba44463b146882e@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1669970814;30bfae5c;
X-HE-SMSGID: 1p11h3-0005H4-2F
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.12.22 22:22, Andrew Morton wrote:
> On Thu, 01 Dec 2022 15:29:41 -0500 Rik van Riel <riel@surriel.com> wrote:
>> On Thu, 2022-12-01 at 19:33 +0100, Thorsten Leemhuis wrote:
>>> On 28.11.22 07:40, Nathan Chancellor wrote:
>>> I wonder what we should do about below performance regression. Is
>>> reverting the culprit now and reapplying it later together with a fix
>>> a
>>> viable option? Or was anything done/is anybody doing something
>>> already
>>> to address the problem and I just missed it?
>>
>> The changeset in question speeds up kernel compiles with
>> GCC, as well as the runtime speed of other programs, due
>> to being able to use THPs more. However, it slows down kernel
>> compiles with clang, due to ... something clang does.
>>
>> I have not figured out what that something is yet.
>>
>> I don't know if I have the wrong version of clang here,
>> but I have not seen any smoking gun at all when tracing
>> clang system calls. I see predominantly small mmap and
>> unmap calls, and nothing that even triggers 2MB alignment.
> 
> 2.8% speedup for gcc is nice.  Massive slowdown in the malloc banchmark
> and in LLVM/clang is very bad - we don't know what other userspace will
> be so affected.
> 
> So I think we revert until this is fully understood.

Andrew, many thx for taking care of this. While at it let me please get
a small process issue of my chest:

What beverage of choice do I have to offer you to make you in the future
include 'Link:' tags linking to the report(s) when you add reverts like
the one for this issue?

My regression tracking bot heavily relies on them, that's why I care.
And our documentation (see [1]) also says that they should be used. But
the main reason why I ask in this particular case is different:

They in cases like afaics are especially helpful, as they make life a
whole lot easier for future code archeologists. And I guess that's not
something theoretical in this case, as I assume the patch that triggered
the issue will come back sooner or later -- and then those links will
help a lot to find this thread. Which is also why Linus really wants to
see them:
https://lore.kernel.org/all/CAHk-=wjMmSZzMJ3Xnskdg4+GGz=5p5p+GSYyFBTh0f-DgvdBWg@mail.gmail.com/
https://lore.kernel.org/all/CAHk-=wgs38ZrfPvy=nOwVkVzjpM3VFU1zobP37Fwd_h9iAD5JQ@mail.gmail.com/
https://lore.kernel.org/all/CAHk-=wjxzafG-=J8oT30s7upn4RhBs6TX-uVFZ5rME+L5_DoJA@mail.gmail.com/

Ciao, Thorsten

[1] see Documentation/process/submitting-patches.rst
(http://docs.kernel.org/process/submitting-patches.html) and
Documentation/process/5.Posting.rst
(https://docs.kernel.org/process/5.Posting.html)
