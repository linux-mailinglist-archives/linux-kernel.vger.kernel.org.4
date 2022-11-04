Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7492561A2B4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 21:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiKDUvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 16:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiKDUv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 16:51:28 -0400
Received: from smtpcmd04131.aruba.it (smtpcmd04131.aruba.it [62.149.158.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BFF6D49B4B
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 13:51:26 -0700 (PDT)
Received: from [192.168.50.220] ([146.241.83.94])
        by Aruba Outgoing Smtp  with ESMTPSA
        id r3euoxKyZMWOir3euoK1gE; Fri, 04 Nov 2022 21:51:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1667595085; bh=Gn8zRrn+SxXIzEldL6GF6fbvpG2PrrQi5SiCoDCbpBE=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=m54ddM1hllq+0+5SI+TZJ9rciQimZW2pwizc13IIGRor7FVE4zqp3U78vqyKVm453
         bP6MbPSYUUrzQbjvP3jSRxMVB36PBWn3u8FyDraBCAhqmF/5pn2fpuhWE45xWzV+Y4
         tIe18NaJmG6EwgCsyqm6tZKSbk0Xb+HTuBDctr72S/12D/wEv9AZrreSBT7XgmFAzX
         4rsk6XTTgqk8pKrsOs0fXnNXFrTboeDaTMKxvCDFsPhczHTxhddg5rHNAV6cHY2Qu/
         jY06qXzzrc3gcLzA6orcZ79mFJRSqMs4fQJA2Q6jxRhJEd6NdH91u4J4tSfI03o4Eo
         eexs6mNR4eYKQ==
Message-ID: <c951adae-73f3-070a-6aa7-20bd91dd371c@benettiengineering.com>
Date:   Fri, 4 Nov 2022 21:51:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/2] ARM: mm: fix no-MMU ZERO_PAGE() implementation
To:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Will Deacon <will@kernel.org>
References: <20221018222503.90118-1-giulio.benetti@benettiengineering.com>
 <64e16669-8bcc-a05e-0eb1-9ae644431d95@benettiengineering.com>
 <8a40c9da-041e-4d3d-90e4-22dbb93eb9ab@app.fastmail.com>
Content-Language: en-US
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
In-Reply-To: <8a40c9da-041e-4d3d-90e4-22dbb93eb9ab@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfA5J7fX6ft4aHEaGERS0oHomm/EUtMtILglgfjbdCSyzGdhlA6dSc23/j7COoTRNMg4T2HcDLr+5xmRwsh74kAZKNVwzbvdCKNvjGury2wpLeSa+3QlM
 G4gyWVCzbILrnh4RInjWP50hKo9JM5ROqOdn01uZDroOBpbQgu61chU6eUkZCbRLxfajnI6v6mbEDSWbYgMeg+GmeatVeL5fb8aQy83+J4UXIefCmvfMDPOW
 quERXKkCY7xhwWp57/BmYt7zk9eJ2lJvtaJQgPLgJP5DSgisnJT3ibtTgzJQKEEVwcJn0h58ma7CpR5IiJkYbYZUEzKUiPYV/tMu7UsaMSOXs/7a21iY2PbD
 0Ha9J0EXjo/lrr+Mb1eHenBVzvAbtDDgWkEBokdfYdvq+EXgNc7AVEzAdaK6k+eRIkKQwm2/QpuTWeCTf9ltCCohkKC6kfwuirxWaGi3G7/0zOsVm2HN5ARA
 9Pn2dXujDUqROJKL8Dl/eNKrYlgV1pwHn5+7F7+d3qYxGb3cSeZATuoiIP8=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 04/11/22 21:28, Arnd Bergmann wrote:
> On Fri, Nov 4, 2022, at 21:07, Giulio Benetti wrote:
>> Hello Arnd, Russell, All,
>>
>> is this patch ok or has it some changes to do?
> 
> Looks ok to me, please add it to Russell's patch
> tracker at:
> https://www.arm.linux.org.uk/developer/patches/

I've submitted it with your Reviewed-by:
https://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=9266/1

> The patch description could be improved a little ("Link:"
> tag for the URL, avoiding the wikitext  markup, etc), 

Oh, I was not aware of "Link:" and avoiding wikitext markup. Next
time I won't use it and I will use Link instead. I'll grep some other
commit log to find out a correct way.

> but
> it's more important to actually get the bug fixed.

Thank you for guiding me
Best regards
-- 
Giulio Benetti
CEO/CTO@Benetti Engineering sas
