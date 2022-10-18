Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2476035E8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 00:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiJRWdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 18:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiJRWc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 18:32:58 -0400
Received: from smtpcmd0986.aruba.it (smtpcmd0986.aruba.it [62.149.156.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D65CBB9F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 15:32:56 -0700 (PDT)
Received: from [192.168.50.220] ([146.241.87.206])
        by Aruba Outgoing Smtp  with ESMTPSA
        id kv8oovsDcaWj1kv8ooENmQ; Wed, 19 Oct 2022 00:32:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1666132375; bh=PwkAlvBRJbTSbNHckqJd3KlxkLSx6fedTB8xDPnpVAE=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=gZEGxu3Esg404PHAkA2jcGjqyiKkYfClD1fUJM8NCEI+IxA4tx6TPiTAM5yXSwEgd
         ZCB99cPRt+5nox3ZPfqSp3ajdROeiNmwejATHk0V0E00Ssjhr90hSyE4lTkbqSy3/Z
         EpK4nFeks3RP1CtPOOmnE1894vl7pCiu1BZlxcJbRDgq9CgbFI8hHOrKr70ztzaCQK
         8RZkcK4bnGOQQlqR62t4XT2F1r2nT94EHaWBSbHFNXAbDqZXpFoCjn/RleDqPXspev
         2fmGbBFWBGgekm8GKX0dgWJOWRm9APIWYw1coQaIW4NfAeJ57jpjwjMDNJs/5MKUhz
         CVpZ3/YUW1XVA==
Message-ID: <3fc711c8-4981-26f7-689c-549bdafa40ac@benettiengineering.com>
Date:   Wed, 19 Oct 2022 00:32:54 +0200
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
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
In-Reply-To: <dc5a5c40-8e96-4f91-a3c6-5a1fc8b26ad1@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfFqBkruL1dx6sKKjJmwREg/QP4D1HUm2sfhSlSrJ/7FDJHd7cb4eToQ71MxMvuKLJ6A+oKqW3m6thIUX4UVvmU/AeL/vrbD4y4byHmD4YNV5TyEyqg5A
 P0GjmXT4iYfLgdE4u/DymhKutGRgiVwFtkYuUMDlNQijUpprYDr0mTYb6J9aq7CkwXZ07n0wOpK7gLab7Xlfx3WHNb9T+p6ZeEX8W9DO/xQd8jrbm1DyzcQv
 96nL01rJ+xzd+uQzYxHyopL6h3MXDrpNCK4f1oablr9JjrHIYxFf5dzyvGbwWZ5dt+5F8HSvSp92lyhoz/I0mMBansVAnU+sCu08XHuA9bqocsPGm8vXsZYg
 yZ1kGQ/Uh6zMAlHqi45EBnIN3sNv4fT09PbCTaiWpQc0tN1m3qgWWm8mioTLybfucqPhgsbhMgH2rlbQHTwym1XqVziX21EArHZGZoCQsiqQ7cE6l9ZQi4uo
 Om0mP9bSU4rijal3rpCpF+Na9902hcnRGTN3TVPSw5PpzGg+Ork30dsu0fc=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/10/22 20:35, Arnd Bergmann wrote:
> On Tue, Oct 18, 2022, at 19:44, Giulio Benetti wrote:
>> On 18/10/22 09:03, Arnd Bergmann wrote:
>>> On Tue, Oct 18, 2022, at 1:37 AM, Giulio Benetti wrote:
>>>> Actually in no-MMU SoCs(i.e. i.MXRT) ZERO_PAGE(vaddr) expands to
>>
>>> It looks like we dropped the ball on this when it came up last.
>>> I'm also not sure when we started requiring this, any idea?
>>
>> No to be honest. But in my case I've met ZERO_PAGE() calling in sdhci
>> driver. And as stated on the ML link above:
>> ```
>> But I wonder if it's safe for noMMU architectures to go on without a
>> working ZERO_PAGE(0).  It has uses scattered throughout the tree, in
>> drivers, fs, crypto and more, and it's not at all obvious (to me) that
>> they all depend on CONFIG_MMU.
>> ```
>> And I've found this driver that requires it and probably is not the last
>> since imxrt support is not complete.
>>
>>> I can see that microblaze-nommu used BUG() in ZERO_PAGE(), so at
>>> whenever microblaze last worked, we clearly did not call it.
>>
>> This probably means that microblaze-nommu doesn't use drivers or other
>> subsystems that require ZERO_PAGE().
> 
> To clarify: microblaze-nommu support was removed two years ago,
> and probably was already broken for a while before that.
> 
>>> In addition to your fix, I see that arm is the only architecture
>>> that defines 'empty_zero_page' as a pointer to the page, when
>>> everything else just makes it a pointer to the data itself,
>>> or an 'extern char empty_zero_page[]' array, which we may want
>>> to change for consistency.
>>
>> I was about doing it, but then I tought to move one piece at a time.
> 
> Right, it would definitely be a separate patch, but it
> can be a series of two patches. We probably wouldn't need to
> backport the second patch that turns it into a static allocation.

I've sent the patchset of 2:
https://lore.kernel.org/all/20221018222503.90118-1-giulio.benetti@benettiengineering.com/T/#t

I'm wondering if it makes sense to send a patchset for all those
architectures that have only one zero page. I've seen that for example
loongarch has more than one. But for the others I find the array
approach more linear, with less code all around and a bit faster in term
of code execution(of course really few, but better than nothing) since
that array is in .bss, so it will be zeroed earlier during a long
"memset" where assembly instructions for zeroing 8 bytes at a time are
used. What about this?

>> But yes, I can modify accordingly. That way we also avoid the early
>> allocation in pagint_init() since it would be a .bss array.
> 
>>> There are three references to empty_zero_page in architecture
>>> independent code, and while we don't seem to use any of them
>>> on Arm, they would clearly be wrong if we did:
>>>
>>> drivers/acpi/scan.c:#define INVALID_ACPI_HANDLE ((acpi_handle)empty_zero_page)
>>> drivers/spi/spi-fsl-cpm.c:      mspi->dma_dummy_tx = dma_map_single(dev, empty_zero_page, PAGE_SIZE,
>>> include/linux/raid/pq.h:# define raid6_empty_zero_page empty_zero_page
>>
>> For them I can send patches to substitute with PAGE_ZERO(0) correctly
>> adapted.
>>
>> What do you think?
> 
> That sounds like a good idea as well.

I've just sent a patchset for this:
https://lore.kernel.org/all/20221018215755.33566-1-giulio.benetti@benettiengineering.com/T/#t

Best regards
-- 
Giulio Benetti
CEO/CTO@Benetti Engineering sas
