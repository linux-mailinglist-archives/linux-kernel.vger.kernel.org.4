Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48FB674F374
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbjGKPau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbjGKPar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:30:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 640AC10DF
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 08:30:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D996D1FB;
        Tue, 11 Jul 2023 08:31:27 -0700 (PDT)
Received: from [10.1.37.54] (C02Z41KALVDN.cambridge.arm.com [10.1.37.54])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 341713F740;
        Tue, 11 Jul 2023 08:30:45 -0700 (PDT)
Message-ID: <6fa76b99-24b3-9410-66c4-d765ef8f4c52@arm.com>
Date:   Tue, 11 Jul 2023 16:30:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v4 18/49] mlock: Convert mlock to vma iterator
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org
References: <20230120162650.984577-1-Liam.Howlett@oracle.com>
 <20230120162650.984577-19-Liam.Howlett@oracle.com>
 <50341ca1-d582-b33a-e3d0-acb08a65166f@arm.com>
 <20230711152734.hith252qxjbnz4bt@revolver>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20230711152734.hith252qxjbnz4bt@revolver>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2023 16:27, Liam R. Howlett wrote:
> * Ryan Roberts <ryan.roberts@arm.com> [230711 10:09]:
>> On 20/01/2023 16:26, Liam R. Howlett wrote:
>>> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>>>
>>> Use the vma iterator so that the iterator can be invalidated or updated
>>> to avoid each caller doing so.
>>
>> Hi,
> 
> 
> Hello!
> 
>>
>> I've bisected 2 mm selftest regressions back to this patch, so hoping someone can help debug and fix? The failures are reproducible on x86_64 and arm64.
> 
> Thanks!  That is a big help.  Where did you start your bisection?  I
> assume 6.4?

Yes, I'm working to get all the mm selftests running (and ideally passing!) on
arm64. I working on v6.4 and it was broken there. I went arbitrarily back to
v5.10 and it was working there, so bisected between them.

> 
>>
>>
>> mlock-random-test:
>>
>> $ ./run_kselftest.sh -t mm:mlock-random-test
>> TAP version 13
>> 1..1
>> # selftests: mm: mlock-random-test
>> mlock() failure at |0xaaaaaaab52d0(131072)| mlock:|0xaaaaaaacc65d(26551)|
>> not ok 1 selftests: mm: mlock-random-test # exit=255
>>
>> This mallocs a buffer then loops 100 times, trying to mlock random parts of it. After this patch, the test fails after a variable number of iterations; mlock() returns ENOMEM. If I explicitly munlock at the end of each loop, it works.
>>
>>
>> mlock2-tests:
>>
>> $ ./run_kselftest.sh -t mm:mlock2-tests
>> TAP version 13
>> 1..1
>> # selftests: mm: mlock2-tests
>> munlock(): Cannot allocate memory
>> munlock(): Cannot allocate memory
>> not ok 1 selftests: mm: mlock2-tests # exit=2
>>
>> Here, a 3 page buffer is mlock2()ed, then the middle page is munlocked. Finally the whole 3 page range is munlocked, and after this patch it fails with ENOMEM. If I modify the test to split the final munlock into 2, one for the first page and one for the last, the test passes.
>>
>>
>> Immediately prior to this patch (2286a6914c77 "mm: change mprotect_fixup to vma iterator"), both tests pass.
>>
>> From a quick scan of the man page, I don't think it explicitly says that its ok to call mlock/munlock on already locked/unlocked pages, but it's certainly a change of behavior and the tests notice, so I'm guessing this wasn't intentional?
>>
>> I'm not familiar with this code so it's not obvious to me exactly what the problem is, but I'm hoping someone can help debug?
> 
> I think I see the issue and I'm working on a fix. I appreciate the
> analysis and report, it really helps narrow things down.

You're welcome!

> 
> Regards,
> Liam

