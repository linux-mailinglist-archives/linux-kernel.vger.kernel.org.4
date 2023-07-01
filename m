Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02B07446CD
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 07:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjGAFqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 01:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjGAFqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 01:46:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C774204
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 22:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=gsaHjVQr2zvDdc7XvtO8GxLsgjI16sNGgoHw1T72M/A=; b=un+mTFpRvO+UwoZDlT4yNO1tZX
        EpDj2XElOeymR+dihhi1ZMsWTZGqDVrYrVJhmYui4wSi7MLYs17pTBwGG8PncOTTy2z9WiZu3dUHU
        MyyTf6ReN2UjHNZ0XTUzyCEFtZelN9mJi/UkIT/64J8tqojlt4dGQKn9Qtv9pE8d1SLXVsn1r/g13
        gcbL/P7drLVh0cW73KUO5X2QyBUoRPYgJk+kuJBTGeCl2jb7tJADcdv/BMIU2tDpjpnLhffGv8sjL
        siUoaghAaFSxzEzTUXk9UqQOrJuwuKMj4Ha36ekw7MG7PGSMkSDIVTgamdwm4pMPhnHgLy94JnGn9
        DdaHWgMA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qFTR1-005E3i-0E;
        Sat, 01 Jul 2023 05:46:15 +0000
Message-ID: <a80acd62-69d2-f3dc-410f-8d9722980e74@infradead.org>
Date:   Fri, 30 Jun 2023 22:46:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] powerpc: allow PPC_EARLY_DEBUG_CPM only when SERIAL_CPM=y
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Kumar Gala <galak@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
References: <20230516152854.22465-1-rdunlap@infradead.org>
 <20230516185400.urjy6y3kh4grbagt@pali>
 <a259b113-6547-4323-c69d-5d04d7cf3a75@infradead.org>
Content-Language: en-US
In-Reply-To: <a259b113-6547-4323-c69d-5d04d7cf3a75@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/9/23 20:11, Randy Dunlap wrote:
> Hi--
> 
> On 5/16/23 11:54, Pali Rohár wrote:
>> On Tuesday 16 May 2023 08:28:54 Randy Dunlap wrote:
>>> In a randconfig with CONFIG_SERIAL_CPM=m and
>>> CONFIG_PPC_EARLY_DEBUG_CPM=y, there is a build error:
>>> ERROR: modpost: "udbg_putc" [drivers/tty/serial/cpm_uart/cpm_uart.ko] undefined!
>>>
>>> Prevent the build error by allowing PPC_EARLY_DEBUG_CPM only when
>>> SERIAL_CPM=y.
>>>
>>> Fixes: c374e00e17f1 ("[POWERPC] Add early debug console for CPM serial ports.")
>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>> Cc: Scott Wood <scottwood@freescale.com>
>>> Cc: Kumar Gala <galak@kernel.crashing.org>
>>> Cc: "Pali Rohár" <pali@kernel.org>
>>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>>> Cc: Nicholas Piggin <npiggin@gmail.com>
>>> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
>>> Cc: linuxppc-dev@lists.ozlabs.org
>>
>> Looks good,
>>
>> Reviewed-by: Pali Rohár <pali@kernel.org>
> 
> I'm still seeing this build error in linux-next even with other (PPC) CPM
> patches applied.
> 

Patchwork shows status as Superseded:

http://patchwork.ozlabs.org/project/linuxppc-dev/patch/20230516152854.22465-1-rdunlap@infradead.org/

but I don't understand why or by what.

I'm going to resubmit the patch now.


>>
>>> ---
>>>  arch/powerpc/Kconfig.debug |    2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff -- a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
>>> --- a/arch/powerpc/Kconfig.debug
>>> +++ b/arch/powerpc/Kconfig.debug
>>> @@ -240,7 +240,7 @@ config PPC_EARLY_DEBUG_40x
>>>  
>>>  config PPC_EARLY_DEBUG_CPM
>>>  	bool "Early serial debugging for Freescale CPM-based serial ports"
>>> -	depends on SERIAL_CPM
>>> +	depends on SERIAL_CPM=y
>>>  	help
>>>  	  Select this to enable early debugging for Freescale chips
>>>  	  using a CPM-based serial port.  This assumes that the bootwrapper
> 

-- 
~Randy
