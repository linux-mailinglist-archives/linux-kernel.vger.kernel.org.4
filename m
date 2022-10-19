Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4662B604D83
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 18:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiJSQiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 12:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiJSQiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 12:38:02 -0400
Received: from smtpcmd02101.aruba.it (smtpcmd02101.aruba.it [62.149.158.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2600E1C5E18
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 09:38:00 -0700 (PDT)
Received: from [192.168.50.220] ([146.241.87.206])
        by Aruba Outgoing Smtp  with ESMTPSA
        id lC4to6TxSsjaWlC4toQVdx; Wed, 19 Oct 2022 18:38:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1666197480; bh=PjzBW01Pfqx6vSWcAzYHsfr9+pt/IXr4Y/Ech4/ISQg=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=JLEWXlPblFGyGYiLUfs4TrJ+S/U4td8MhFZV8Mza9YOq9cvcbcusXK6y5DB1Vw4Jx
         yjL9fDJPrwTnJag/oNJvfBiBaBPds+xd5VK002ii+2qqK/wEp1HhOOFTOxB5FqErv3
         rftr/blMr9FtXzszKSFYfnUdm6mBk9OqdIBihfNZ8r+9lEVtzApt78qh3EiR22esx8
         t89o9o1TCQSyKGxCU0Stqw0yDBy7H4XPFc3NX9vuT1UVf3gYkhmlsWnGsOzDDPJMRT
         M6a7rswgLLUQXPhy8EmppbetNkF3z6RJ5OJeHeP6087YRR8e0VzIUWsnlCuXN+Wsq3
         OX4frmjv6Dpvw==
Message-ID: <a84e2199-a2b9-e489-f75d-ea57d227a6b5@benettiengineering.com>
Date:   Wed, 19 Oct 2022 18:37:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] ARM: mm: fix no-MMU ZERO_PAGE() implementation
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Will Deacon <will@kernel.org>
References: <20221017233700.84918-1-giulio.benetti@benettiengineering.com>
 <3fb4afd1-2eea-4a71-a914-f8208b11f9f4@app.fastmail.com>
 <972a3be7-4522-b4f0-adfa-6b42be56c52f@benettiengineering.com>
 <dc5a5c40-8e96-4f91-a3c6-5a1fc8b26ad1@app.fastmail.com>
 <3fc711c8-4981-26f7-689c-549bdafa40ac@benettiengineering.com>
 <e98b0727-5a5b-4f1d-bbf6-1194e6df299a@app.fastmail.com>
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
In-Reply-To: <e98b0727-5a5b-4f1d-bbf6-1194e6df299a@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfBkyHrlHAhQzoqTkhc9cScYJzGi1YJvc5lWIkW6xo9b2lf7R3QuaRUQJBNGdEji+GU6IxpKvra27/vcydNFqhVGZmYritvrURqZ/A3LljyLpISpJkXZI
 rJ5PJSuZ5YMrkZY14ycPtWt/07afiyRgeVuhOtiHmJdMuCkF5ZhJlCu0VGO0z+HUOOAFeOa6/+LCudDMbdJnwH0IwfLHmjEOdVQ09zn0t2akagckOuI7L2Ox
 eRzsKVDSls3QoO3nRuiEQ+WCnj1GZXfAegQRpzFjKK7eK4zBinXJMXr/Cb6dg4iJ+IUsgXScQmTO21f51obT0B2Wj3rzozhFygGbM4bdyDEX6EzvcTXLeEvA
 QbslCDrVdgOLDZLHDqngTj2sMNwDwzJGBAmzFX3jzXTTu+Ap5Wa4Mmzs9K6EcUELux7oLw11mC7WkMqSFq5xcVP+6BPX+DHd1D9V3cKK6ENxsP5xPQpu50dr
 xSdWwah9LOvsai8Mgzrond1meaoW/Kswz+AaPNoN3w256wfdub1zPofr0Pk=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/22 09:00, Arnd Bergmann wrote:
> On Wed, Oct 19, 2022, at 00:32, Giulio Benetti wrote:
>> On 18/10/22 20:35, Arnd Bergmann wrote:
>>> On Tue, Oct 18, 2022, at 19:44, Giulio Benetti wrote:
>>>> On 18/10/22 09:03, Arnd Bergmann wrote:
>>>>> In addition to your fix, I see that arm is the only architecture
>>>>> that defines 'empty_zero_page' as a pointer to the page, when
>>>>> everything else just makes it a pointer to the data itself,
>>>>> or an 'extern char empty_zero_page[]' array, which we may want
>>>>> to change for consistency.
>>>>
>>>> I was about doing it, but then I tought to move one piece at a time.
>>>
>>> Right, it would definitely be a separate patch, but it
>>> can be a series of two patches. We probably wouldn't need to
>>> backport the second patch that turns it into a static allocation.
>>
>> I've sent the patchset of 2:
>> https://lore.kernel.org/all/20221018222503.90118-1-giulio.benetti@benettiengineering.com/T/#t
>>
>> I'm wondering if it makes sense to send a patchset for all those
>> architectures that have only one zero page. I've seen that for example
>> loongarch has more than one. But for the others I find the array
>> approach more linear, with less code all around and a bit faster in term
>> of code execution(of course really few, but better than nothing) since
>> that array is in .bss, so it will be zeroed earlier during a long
>> "memset" where assembly instructions for zeroing 8 bytes at a time are
>> used. What about this?
> 
> The initial zeroing should not matter at all in terms of performance,
> I think the only question is whether one wants a single zero page
> to be used everywhere or one per NUMA node to give better locality
> for a cache miss.
> 
> My guess is that for a system with 4KB pages, all the data
> in the zero page are typically available in a CPU cache already,
> so it doesn't matter, but it's possible that some machines benefit
> from having per-node pages when the page size isn't tiny compared
> to the typical cache sizes.
> 
> We should probably not touch this for any of the other architectures.

Ok, thanks for the explanation!

Best regards
-- 
Giulio Benetti
CEO/CTO@Benetti Engineering sas
