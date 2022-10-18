Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7AA76031BD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 19:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiJRRoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 13:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiJRRoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 13:44:14 -0400
Received: from smtpcmd0987.aruba.it (smtpcmd0987.aruba.it [62.149.156.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 98BA7BD043
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 10:44:13 -0700 (PDT)
Received: from [192.168.50.220] ([146.241.87.206])
        by Aruba Outgoing Smtp  with ESMTPSA
        id kqdPos7NKaWj1kqdPoCiGi; Tue, 18 Oct 2022 19:44:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1666115052; bh=EpI0ycdh8Ig95P/hY3/+K/iwa0CUCWGqrcTlTVhGMVQ=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=PmfUbG7S9OTwnKSQPitcE1z8b38QfgTfE5lG3wBDVaGzZd0LBZwGsU7oJnmXE/FYR
         KhBr81niyjpjCqiqZp6WoLhDs+/ULX1WNOuxYkRb1h0s/IPDKXWZyFfHyTLUnN+UWx
         pdatAnnftksmWlAv8kxGktL9fCNDMU3x2j2PY7lNq1m6E4Ri2JWY47BTIFcMCa24qG
         KniLSSWczXk9Jhwwkfu9sursK8R7CwLQ2zb+/kQjNRlQpnVGVQ5uU1Uqm1nwHdRweI
         nDSsEivQ6M8KXkLNBHpi/m+yLnv30kACMOiqCKnwqX5Fcs9serNI8hCcpMmRMPgATz
         Zm4rnQ3O+YIqg==
Message-ID: <972a3be7-4522-b4f0-adfa-6b42be56c52f@benettiengineering.com>
Date:   Tue, 18 Oct 2022 19:44:11 +0200
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
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
In-Reply-To: <3fb4afd1-2eea-4a71-a914-f8208b11f9f4@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfGXXZoTJNft61coI9sV7MyMRJ4QVPzXaGpDzP2umrcTBDjbrNbAnVRENaaZaU00qf9Zb+PZAhmd2iC/anlqxwXddVPXCzWSqY1Vh06fI3v41a3DN9yTZ
 bUQcsMxqyg8RcOm79RGyoLwl8GLXX74iGVuBkQDZUSrnBBuA+gXDxACsXlrpxYYs37MTO8QnCcYTthz1p2vaLNTXEjCBG2JeuYPkk1pdIjYuwm1xevT1q6Vs
 kKSnLdnRqZ44yeSh2l4PmRTC1vPh42vs4djB8qCP6Adg+DmkC9B+/3tYhFaYXNgMiR7tjLNpQ8YnL4YaxAu1yjIS8RP4uy9A82tUgOpY0EmP1l98wjI0ldKt
 RdaqUMcUZ3tlRdL0XgvcE1fbBghoX+D08LbmfIYCkQXvBfi/pQeq4ZC9mmCFfku/dzO5eUjYI55o9mO5/CUCpWNFqpg8BzQeHtWFNzCHFzXf2stlC2Zz2pn4
 K73LFXe+YKmHSLTP0yeXjhG5cnQ7GD/DmFjIdy3++XhPTEvxSBWzX5qhKgs=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 18/10/22 09:03, Arnd Bergmann wrote:
> On Tue, Oct 18, 2022, at 1:37 AM, Giulio Benetti wrote:
>> Actually in no-MMU SoCs(i.e. i.MXRT) ZERO_PAGE(vaddr) expands to
>> ```
>> virt_to_page(0)
>> ```
>> that in order expands to:
>> ```
>> pfn_to_page(virt_to_pfn(0))
>> ```
>> and then virt_to_pfn(0) to:
>> ```
>> #define virt_to_pfn(0) \
>> 	((((unsigned long)(0) - PAGE_OFFSET) >> PAGE_SHIFT) + \
>> 	 PHYS_PFN_OFFSET)
>> ```
>> where PAGE_OFFSET and PHYS_PFN_OFFSET are the DRAM offset(0x80000000) and
>> PAGE_SHIFT is 12. This way we obtain 16MB(0x01000000) summed to the base of
>> DRAM(0x80000000).
>> When ZERO_PAGE(0) is then used, for example in bio_add_page(), the page
>> gets an address that is out of DRAM bounds.
>> So instead of using fake virtual page 0 let's allocate a dedicated
>> zero_page during paging_init() and assign it to a global 'struct page *
>> empty_zero_page' the same way mmu.c does. Then let's move ZERO_PAGE()
>> definition to the top of pgtable.h to be in common between mmu.c and
>> nommu.c.
>>
>> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
> 
> Maybe mention commit dc068f462179 ("m68knommu: set ZERO_PAGE() to the
> allocated zeroed page") for the commit that fixed this first,
> as well as the previous discussion at
> https://lore.kernel.org/linux-m68k/2a462b23-5b8e-bbf4-ec7d-778434a3b9d7@google.com/T/#m1266ceb63ad140743174d6b3070364d3c9a5179b

Thanks for poiting, I was unaware of this. I'll point it for sure.

> It looks like we dropped the ball on this when it came up last.
> I'm also not sure when we started requiring this, any idea?

No to be honest. But in my case I've met ZERO_PAGE() calling in sdhci
driver. And as stated on the ML link above:
```
But I wonder if it's safe for noMMU architectures to go on without a
working ZERO_PAGE(0).  It has uses scattered throughout the tree, in
drivers, fs, crypto and more, and it's not at all obvious (to me) that
they all depend on CONFIG_MMU.
```
And I've found this driver that requires it and probably is not the last
since imxrt support is not complete.

> I can see that microblaze-nommu used BUG() in ZERO_PAGE(), so at
> whenever microblaze last worked, we clearly did not call it.

This probably means that microblaze-nommu doesn't use drivers or other
subsystems that require ZERO_PAGE().

> 
>> +#ifndef __ASSEMBLY__
>> +/*
>> + * ZERO_PAGE is a global shared page that is always zero: used
>> + * for zero-mapped memory areas etc..
>> + */
>> +extern struct page *empty_zero_page;
>> +#define ZERO_PAGE(vaddr)	(empty_zero_page)
>> +#endif
> 
> In addition to your fix, I see that arm is the only architecture
> that defines 'empty_zero_page' as a pointer to the page, when
> everything else just makes it a pointer to the data itself,
> or an 'extern char empty_zero_page[]' array, which we may want
> to change for consistency.

I was about doing it, but then I tought to move one piece at a time.
But yes, I can modify accordingly. That way we also avoid the early
allocation in pagint_init() since it would be a .bss array.

> There are three references to empty_zero_page in architecture
> independent code, and while we don't seem to use any of them
> on Arm, they would clearly be wrong if we did:
> 
> drivers/acpi/scan.c:#define INVALID_ACPI_HANDLE ((acpi_handle)empty_zero_page)
> drivers/spi/spi-fsl-cpm.c:      mspi->dma_dummy_tx = dma_map_single(dev, empty_zero_page, PAGE_SIZE,
> include/linux/raid/pq.h:# define raid6_empty_zero_page empty_zero_page

For them I can send patches to substitute with PAGE_ZERO(0) correctly 
adapted.

What do you think?

Thanks for reviewing.

Best regards
-- 
Giulio Benetti
CEO/CTO@Benetti Engineering sas
