Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7186A7494D0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 07:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbjGFFCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 01:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjGFFCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 01:02:50 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774991BD9;
        Wed,  5 Jul 2023 22:02:48 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 2D58C60171;
        Thu,  6 Jul 2023 07:02:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1688619755; bh=x+TliPLqS2k/24Fs2irqgh/j+t+Qk21Wb7pLn+QCGj4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=1tscRhauMmSuk4ljitKrOhDn1XJXmMU4sdOn4Heu8jYvATLNW1n29UvEsuDduYMLr
         rMuLAjWisOVw/9dx+p4+aQZ628rxU4dBBx39MNPDJ87XG/lH3kFtVzJjU+WDxXSXjr
         fBaGOKWqk31dgt21db5jAG8Lbs2/MlAUtP++1ZCrKghqQf1U9WAe/EkxdfcoyRTaR1
         TBtfXuTl6vhiU1pLGi/xawCxCV9H30NmW4CdgSagkmE93N7OfI22SHq7i7+IVTTF+h
         1ZDqZ6XGbdSh4uOWjZIOY8y92btNGTwQTBAw7S5rLVPyAiFCP6A9aYZuUHuG9z5Ur9
         QKZlBA8EVQK1w==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9kGYQNc82_0p; Thu,  6 Jul 2023 07:02:33 +0200 (CEST)
Received: from [192.168.1.6] (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id E61326016E;
        Thu,  6 Jul 2023 07:02:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1688619753; bh=x+TliPLqS2k/24Fs2irqgh/j+t+Qk21Wb7pLn+QCGj4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=B9/8kyiw6ezkyKM+F9IPFO898PSbHHlSWE0n2B6RqWo1Ot/OZvqcKrwyR4yriMElg
         UbrYZRCeOBz+bQ+1qiZ2juhWI+AI5CA2AaxcvsXm01kJU09iRF2X2NnRv2wVkwJ6KX
         wYNUiBlhXF6z25hrmAbYEoEA5yDsGCbYaYWPoPXrDgK9YVS9+jFZqTLAolJZ5DNJbC
         Vq4ssmnysgU9mb1wH15pLKWO1Wo+G+51KOT9demKQQxk5zVjGIwAI57G4SsKbPtpnL
         vlaQMrcBEB4IgE1c8qYdjW5yL0pc2zrRMlxiASuzxFRDv+DMP2aa1amIiSxXviT6ky
         682ZxRHfegnrw==
Message-ID: <f189719f-c7b9-e247-9251-8a336e41141d@alu.unizg.hr>
Date:   Thu, 6 Jul 2023 07:02:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [CRASH][BISECTED] 6.4.1 crash in boot
To:     Kees Cook <kees@kernel.org>, Kees Cook <keescook@chromium.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux LLVM <llvm@lists.linux.dev>,
        linux-kbuild@vger.kernel.org,
        Linux Regressions <regressions@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-hardening@vger.kernel.org
References: <9a8e34ad-8a8b-3830-4878-3c2c82e69dd9@alu.unizg.hr>
 <ZKIoBVzrjZ+Ybxy9@debian.me> <202307022018.B26F5795@keescook>
 <625e951e-9922-d15d-5520-e8cd5eba1995@roeck-us.net>
 <4fa56264-f188-46f9-cc77-117b469b3328@roeck-us.net>
 <2b1a4f49-ba18-0246-af09-4e4133814411@alu.unizg.hr>
 <202307022230.6121D6896@keescook>
 <ed3e4315-b149-2f9e-70d4-45d7f83b9922@alu.unizg.hr>
 <202307031149.823F9A3@keescook> <202307031606.3FD9D0D@keescook>
 <fbf4103b-6471-1f06-34a8-4aa227f5e091@alu.unizg.hr>
 <3CDD1188-7B2A-4D53-9B8F-C07BC39844E9@kernel.org>
 <19d0e63c-db47-8f02-2f79-0923f675898c@alu.unizg.hr>
 <DA3FEB08-DF39-406B-89CC-9076CFCF597A@kernel.org>
Content-Language: en-US
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <DA3FEB08-DF39-406B-89CC-9076CFCF597A@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/23 04:09, Kees Cook wrote:
>>>
>>> Hmm, is CONFIG_UBSAN_TRAP set?
>>
>> marvin@defiant:~/linux/kernel/linux_torvalds$ grep CONFIG_UBSAN_TRAP .config
>> CONFIG_UBSAN_TRAP=y
> 
> Ah-ha! Turn that off please. With it off you will get much more useful reports from USBAN.

Done that. And it appears to work.

Great job.

There should be a way to store the earliest kernel messages while in the initrd phase, but
I can't think of any either ...

Have a nice day!

Best regards,
Mirsad Todorovac
