Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F2066E3E1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 17:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbjAQQnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 11:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbjAQQmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 11:42:54 -0500
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB85742BF7;
        Tue, 17 Jan 2023 08:42:40 -0800 (PST)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1pHp2k-001f9B-4y; Tue, 17 Jan 2023 17:42:38 +0100
Received: from p57bd9464.dip0.t-ipconnect.de ([87.189.148.100] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1pHp2j-002q0C-UX; Tue, 17 Jan 2023 17:42:38 +0100
Message-ID: <3800eaa8-a4da-b2f0-da31-6627176cb92e@physik.fu-berlin.de>
Date:   Tue, 17 Jan 2023 17:42:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Calculating array sizes in C - was: Re: Build
 regressions/improvements in v6.2-rc1
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        linux-xtensa@linux-xtensa.org,
        Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
References: <CAHk-=wgf929uGOVpiWALPyC7pv_9KbwB2EAvQ3C4woshZZ5zqQ@mail.gmail.com>
 <20221227082932.798359-1-geert@linux-m68k.org>
 <alpine.DEB.2.22.394.2212270933530.311423@ramsan.of.borg>
 <c05bee5d-0d69-289b-fe4b-98f4cd31a4f5@physik.fu-berlin.de>
 <CAMuHMdXNJveXHeS=g-aHbnxtyACxq1wCeaTg8LbpYqJTCqk86g@mail.gmail.com>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
In-Reply-To: <CAMuHMdXNJveXHeS=g-aHbnxtyACxq1wCeaTg8LbpYqJTCqk86g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.148.100
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        SUSPICIOUS_RECIPS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert!

On 1/6/23 16:17, Geert Uytterhoeven wrote:
>> I'm not seeing this one, but I am getting this one instead:
>>
>> In file included from ./arch/sh/include/asm/hw_irq.h:6,
>>                    from ./include/linux/irq.h:596,
>>                    from ./include/asm-generic/hardirq.h:17,
>>                    from ./arch/sh/include/asm/hardirq.h:9,
>>                    from ./include/linux/hardirq.h:11,
>>                    from ./include/linux/interrupt.h:11,
>>                    from ./include/linux/serial_core.h:13,
>>                    from ./include/linux/serial_sci.h:6,
>>                    from arch/sh/kernel/cpu/sh2/setup-sh7619.c:11:
>> ./include/linux/sh_intc.h:100:63: error: division 'sizeof (void *) / sizeof (void)' does not compute the number of array elements [-Werror=sizeof-pointer-div]
>>     100 | #define _INTC_ARRAY(a) a, __same_type(a, NULL) ? 0 : sizeof(a)/sizeof(*a)
>>         |                                                               ^
>> ./include/linux/sh_intc.h:105:31: note: in expansion of macro '_INTC_ARRAY'
>>     105 |         _INTC_ARRAY(vectors), _INTC_ARRAY(groups),      \
>>         |                               ^~~~~~~~~~~
> 
> The easiest fix for the latter is to disable CONFIG_WERROR.
> Unfortunately I don't know a simple solution to get rid of the warning.

I did some research and it seems that what the macro _INT_ARRAY() does with "sizeof(a)/sizeof(*a)"
is a commonly used way to calculate array sizes and the kernel has even its own macro for that
called ARRAY_SIZE() which Linus asks people to use here [1].

So, I replaced _INTC_ARRAY() with ARRAY_SIZE() (see below), however the kernel's own ARRAY_SIZE()
macro triggers the same compiler warning. I'm CC'ing Michael Karcher who has more knowledge on
writing proper C code than me and maybe an idea how to fix this warning.

Thanks,
Adrian

> [1] https://lkml.org/lkml/2015/9/3/428

diff --git a/include/linux/sh_intc.h b/include/linux/sh_intc.h
index c255273b0281..07a187686a84 100644
--- a/include/linux/sh_intc.h
+++ b/include/linux/sh_intc.h
@@ -97,14 +97,12 @@ struct intc_hw_desc {
         unsigned int nr_subgroups;
  };
  
-#define _INTC_ARRAY(a) a, __same_type(a, NULL) ? 0 : sizeof(a)/sizeof(*a)
-
  #define INTC_HW_DESC(vectors, groups, mask_regs,       \
                      prio_regs, sense_regs, ack_regs)   \
  {                                                      \
-       _INTC_ARRAY(vectors), _INTC_ARRAY(groups),      \
-       _INTC_ARRAY(mask_regs), _INTC_ARRAY(prio_regs), \
-       _INTC_ARRAY(sense_regs), _INTC_ARRAY(ack_regs), \
+       ARRAY_SIZE(vectors), ARRAY_SIZE(groups),        \
+       ARRAY_SIZE(mask_regs), ARRAY_SIZE(prio_regs),   \
+       ARRAY_SIZE(sense_regs), ARRAY_SIZE(ack_regs),   \
  }
  
  struct intc_desc {

-- 
  .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

