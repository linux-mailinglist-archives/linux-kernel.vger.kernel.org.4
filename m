Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271D0604E18
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 19:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiJSRHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 13:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiJSRHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 13:07:18 -0400
Received: from smtpcmd02102.aruba.it (smtpcmd02102.aruba.it [62.149.158.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F3A41ABEC6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 10:07:15 -0700 (PDT)
Received: from [192.168.50.220] ([146.241.87.206])
        by Aruba Outgoing Smtp  with ESMTPSA
        id lCXBo6xS8sjaWlCXBoQi2V; Wed, 19 Oct 2022 19:07:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1666199233; bh=YexSPmcIWDgGICMo9hlh0c7y7IkawCpQNtPI3KAt/ew=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=BJ1jz2sH0dokt/8MTTn0F45lP8qYKBBjivASYdd/3O06MZGQfAZuOYX5cqRZORKex
         lWfwnaVnnDOaHsDtIWvlBS8S/fNUdEFg7cvT80wt+PYnbnwNKIsEc8ZmEoyL9W22Gf
         n0kq+kTfFo+XTjm80HMlV/4ls6j+8ivzQAS3cvN8hGjbCxPPL8zZ56G+B7T/NSzNtQ
         Mz5v85/ZVlhKtHzodRofdh3gkfk7+N1/ubwJpbHVPyhXCab2ezhkyzQLBpBR1j+5TN
         b7dstX1NlWAZdgrFgT0gJSkBeR0LiC7NQoADHwX1VlMTdM9saicPUVOz8j4zQT+W1V
         8Lei5mv+/pxxw==
Message-ID: <2a3dac67-d8c5-0c09-38fc-d4bd559c18b7@benettiengineering.com>
Date:   Wed, 19 Oct 2022 19:07:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] ARM: mm: fix no-MMU ZERO_PAGE() implementation
Content-Language: en-US
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Will Deacon <will@kernel.org>
References: <20221017233700.84918-1-giulio.benetti@benettiengineering.com>
 <3fb4afd1-2eea-4a71-a914-f8208b11f9f4@app.fastmail.com>
 <Y0++52o7QSaDvqpM@shell.armlinux.org.uk>
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
In-Reply-To: <Y0++52o7QSaDvqpM@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfDp+3jsEKoP+dX6tU+6WAKgGLRmaDzTMy8p9Q5WIId1V562Hud5aHCtnt4YvwiHy92MPiPCXo9IUVjDlEc1Vr24AdofpU10t+6/bsPLyPJEuCqrpInOG
 cWUG4v4I9n8XF94dCbFyGnXA2ZpbS2aWx0SRGEolfldr6zCF4/gZUn8gifeVRYbX79MBNo49G8YOEFwGco28gIy8CPTMTro1c87qJ28hwHSVJKLqIyRfEBsQ
 VyzKl8TG4gnHZxLPA+ZJI+3CG9E/c69f14IdvJeWBUJH/pjA2r35+mfNZobt4GHMmECUpxeXrQxZH0NBRgHrN+GmuxXruG7CVA0B+JkfMJgEHQqs4cxENsdA
 tT4YpEWeMHtH410VB3GlTbliFWGj1ZNWluJ9biOtBsjcuwp9LTxLB4ivhTgxDtxCThoskYB/JPySb+FiUI4hklrGkJd8LZWd5u0ZU0t9Nem1bDGmCmsbxqr8
 fvX9bJ3Yfs9X6v0F
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Russell, Arnd, All,

On 19/10/22 11:09, Russell King (Oracle) wrote:
> On Tue, Oct 18, 2022 at 09:03:01AM +0200, Arnd Bergmann wrote:
>> In addition to your fix, I see that arm is the only architecture
>> that defines 'empty_zero_page' as a pointer to the page, when
>> everything else just makes it a pointer to the data itself,
>> or an 'extern char empty_zero_page[]' array, which we may want
>> to change for consistency.
> 
> ARM's implementation is the utterly sensible implementation IMHO.
> 
> When the only users in the kernel _were_ ZERO_PAGE() for this, which
> is defined to return a struct page pointer, there was no need to make
> "empty_zero_page" anything but a struct page pointer, rather than a
> runtime translation from an address to a struct page.
> 
> IMHO, we should _not_ be exposing empty_zero_page to devices - we
> certainly do not want the DMA API performing cache maintenance on
> this page since the primary purpose of this page is to fill in
> userspace BSS pages that have not been written.
> 
> ACPI's use is just to have a cookie for invalid handles, and using
> the struct page pointer is good enough.
> 
> The only problem one is the RAID6 code, but that is disabled:
> 
> /* Set to 1 to use kernel-wide empty_zero_page */
> #define RAID6_USE_EMPTY_ZERO_PAGE 0
> 
> #if RAID6_USE_EMPTY_ZERO_PAGE
> # define raid6_empty_zero_page empty_zero_page
> #else
> extern const char raid6_empty_zero_page[PAGE_SIZE];
> #endif

For this I've sent a patch to remove the unused code:
https://lore.kernel.org/all/20221019160407.7550-1-giulio.benetti@benettiengineering.com/

> So, the only one that needs fixing is the SPI usage, which IMHO
> is wrong. ARM being different finds what I consider a driver bug.
> Good for 32-bit ARM. :)

Oh, I've sent a patch for substituting ZERO_PAGE(0) and it's already
been applied to spi's for-next:
https://lore.kernel.org/all/166619141690.565256.8563939546728659746.b4-ty@kernel.org/
So this doesn't break the build but there is still a bug.

Just to understand if I've understood correctly. The correct fix would
be to kzalloc() a dma_dummy_tx buffer and use it in place of
ZERO_PAGE(0), right?

Can you also please point me some link explaining the structure of this
topic? I've already started to read:
https://docs.kernel.org/core-api/index.html#memory-management

Maybe it is enough. I'd appreciate a lot any further links to get into
this if any.

Thank you

Kind regards
-- 
Giulio Benetti
CEO/CTO@Benetti Engineering sas
