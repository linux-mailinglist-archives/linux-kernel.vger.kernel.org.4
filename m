Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402FE659719
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 11:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234837AbiL3KBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 05:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234534AbiL3KA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 05:00:56 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77E219282
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 02:00:54 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pBCC4-000086-SX; Fri, 30 Dec 2022 11:00:52 +0100
Message-ID: <1c8b2b1b-d6bd-91f4-fec5-47ad3619205e@leemhuis.info>
Date:   Fri, 30 Dec 2022 11:00:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] Revert "ASoC: soc-pcm: Don't zero TDM masks in
 __soc_pcm_open()"
Content-Language: en-US, de-DE
To:     nickel@altlinux.org
Cc:     linux-kernel@vger.kernel.org, Oleg Obidin <obidinog@basealt.ru>,
        Greg KH <gregkh@linuxfoundation.org>
References: <20221230093454.468857-1-nickel@altlinux.org>
 <20221230093454.468857-2-nickel@altlinux.org> <Y661FSRlfUFeXB26@kroah.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <Y661FSRlfUFeXB26@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1672394454;95d74a0b;
X-HE-SMSGID: 1pBCC4-000086-SX
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.12.22 10:53, Greg KH wrote:
> On Fri, Dec 30, 2022 at 12:30:53PM +0300, nickel@altlinux.org wrote:
>> From: Nikolai Kostrigin <nickel@altlinux.org>
>>
>> This reverts commit c34db0d6b88b1da95e7ab3353e674f4f574cccee.
>>
>> Sudden sound disappearance was reported for some laptops, e.g.
>> Acer Swift 3 SF314-59-78UR 11th Gen Intel(R) Core(TM) i7-1165G7 @ 2.80GHz
>>
>> lspci
>> 0000:00:1f.3 Multimedia audio controller: Intel Corporation Tiger Lake-LP Smart Sound Technology Audio Controller (rev 20)
>>         Subsystem: Acer Incorporated [ALI] Device 148c
>>         Flags: bus master, fast devsel, latency 32, IRQ 197, IOMMU group 12
>>         Memory at 601f270000 (64-bit, non-prefetchable) [size=16K]
>>         Memory at 601f000000 (64-bit, non-prefetchable) [size=1M]
>>         Capabilities: [50] Power Management version 3
>>         Capabilities: [80] Vendor Specific Information: Len=14 <?>
>>         Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
>>         Kernel driver in use: sof-audio-pci
>>
>> Bisection revealed the commit being reverted.
>>
>> Reported-by: Oleg Obidin <obidinog@basealt.ru>
>> Link: https://bugzilla.altlinux.org/44690
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216861
>> Signed-off-by: Nikolai Kostrigin <nickel@altlinux.org>
>> ---
>>  sound/soc/soc-pcm.c | 5 +++++
>>  1 file changed, 5 insertions(+)
> 
> <formletter>
> 
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
> 
> </formletter>

Also FWIW & FYI: I earlier today brought the regression in question to
the attention of the people that are responsible to fix this issue:
https://lore.kernel.org/all/bebd692d-7d21-6648-6b7a-c91063bb51c2@leemhuis.info/

With a bit of luck they will soon look into this and fix it, but given
the time of year it might take a day or two longer than usual...

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
