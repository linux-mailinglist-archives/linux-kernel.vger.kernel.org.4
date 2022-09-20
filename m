Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0B35BEE90
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 22:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiITU3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 16:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiITU3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 16:29:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A50E0EF;
        Tue, 20 Sep 2022 13:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=4GkFAM9ta15G5fu8V8P3u7MnkTCMjeq28zxKCugAOm0=; b=x1KlwbOFXZpW4WLiH/g/4ugBbM
        VpxvKqvSX0+exHvXpLROOQgkxfIUQhdBxOFAmsQTQcSladGovbtc/dw6D4+62xFCnZIrrClYuVcGI
        OtTAfLnmYnRwNyBkwqDDRJK/7FbqIVFtKxobtZLeQNSvLd/gLSpmcL5s43m61y1IUcy/KtnduNatO
        UjLVELQ13XHs+QvC4V4/3uZCpD6Ka+Ld6u5+soyoAko4gXTMvEfFrFmjhRwF0jlZq4gPFKcF3ezrX
        wYPkFpc/hJzm0RC6bG6vnzrz865bre7snxVGgrVfuv2XTXxaGaGaVBGq8H901eMMPol0uxQyFiLZ6
        iXD/ol0A==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oajs8-006Iaw-WF; Tue, 20 Sep 2022 20:29:37 +0000
Message-ID: <d54e7e26-7797-bedb-142a-2101a4e497de@infradead.org>
Date:   Tue, 20 Sep 2022 13:29:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: Build regressions/improvements in v6.0-rc5
Content-Language: en-US
To:     Helge Deller <deller@gmx.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-parisc@vger.kernel.org
References: <CAHk-=wjG0js0MpsoH3-yvp05u_gXHu+uhkvqdAZDVb=9xUmX=g@mail.gmail.com>
 <20220912091325.1780524-1-geert@linux-m68k.org>
 <alpine.DEB.2.22.394.2209121120590.1176514@ramsan.of.borg>
 <647e2197-8f89-f5a0-a60b-476aff2fd134@gmx.de>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <647e2197-8f89-f5a0-a60b-476aff2fd134@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/20/22 13:23, Helge Deller wrote:
> On 9/12/22 11:22, Geert Uytterhoeven wrote:
>> On Mon, 12 Sep 2022, Geert Uytterhoeven wrote:
>>> JFYI, when comparing v6.0-rc5[1] to v6.0-rc4[3], the summaries are:
>>>  - build errors: +16/-1
>>
>>    + /kisskb/src/arch/parisc/kernel/vdso32/restart_syscall.S: Error: .cfi_endproc without corresponding .cfi_startproc:  => 32
>>    + /kisskb/src/arch/parisc/kernel/vdso32/restart_syscall.S: Error: bad or irreducible absolute expression:  => 16
>>    + /kisskb/src/arch/parisc/kernel/vdso32/restart_syscall.S: Error: junk at end of line, first unrecognized character is `:':  => 16
>>    + /kisskb/src/arch/parisc/kernel/vdso32/restart_syscall.S: Error: no such instruction: `be 0x100(%sr2,%r0)':  => 29
>>    + /kisskb/src/arch/parisc/kernel/vdso32/restart_syscall.S: Error: no such instruction: `ldi 0,%r20':  => 30
>>    + /kisskb/src/arch/parisc/kernel/vdso32/restart_syscall.S: Error: no such instruction: `ldw 0(%sp),%r31':  => 26
>>    + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Error: no such instruction: `ble 0x100(%sr2,%r0)':  => 46, 51
>>    + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Error: no such instruction: `ldi 0,%r25':  => 44
>>    + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Error: no such instruction: `ldi 1,%r25':  => 49
>>    + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Error: no such instruction: `ldi 173,%r20':  => 45, 50
>>    + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Error: unknown pseudo-op: `.callinfo':  => 40
>>    + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Error: unknown pseudo-op: `.entry':  => 41
>>    + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Error: unknown pseudo-op: `.exit':  => 54
>>    + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Error: unknown pseudo-op: `.proc':  => 39
>>    + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Error: unknown pseudo-op: `.procend':  => 55
>>    + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Error: unknown pseudo-op: `.stringz':  => 76
>>
>> parisc-gcc8/generic-32bit_defconfig
>>
>>> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/80e78fcce86de0288793a0ef0f6acf37656ee4cf/ (all 135 configs)
>>> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/7e18e42e4b280c85b76967a9106a13ca61c16179/ (all 135 configs)
> 
> I see those errors on the kiss website, but I'm unable to reproduce them.
> Downloaded that .config, used same compiler (from https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/8.5.0/)....
> Not sure how to get this fixed.
> If someone has an idea or can reproduce, please let me know.

Hi,
I can reproduce it using the (x86_64 hosted) crosstool gcc-12.1.0 from kernel.org that Arnd builds/provides.
https://mirrors.edge.kernel.org/pub/tools/crosstool/


I expect it's a matter of gcc not being built for the right target, but that's just a guess
on my part. I know nothing about configuring gcc for arch. targets.


-- 
~Randy
