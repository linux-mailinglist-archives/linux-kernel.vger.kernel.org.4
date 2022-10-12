Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2D25FC976
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 18:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiJLQth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 12:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiJLQtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 12:49:35 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681D2D8EE7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 09:49:34 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id y191so1634974pfb.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 09:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g9qrjjBbM1UMLpM0hRZ+Jb2A7nD4HhHAvZYWBR2w6NQ=;
        b=MGKJeoGaIP1TfEtKatCtL7CGrRBpr8cXaEDIm0tSltHxR4/WXZ2+QewbhiBSJgKY6T
         EeA17tzCu6pdoyE1r6g/n5zal01XkVyhx0W2aOjMno9rRgDBsux0dfgGZfkynmz3Efiy
         OMAWi+me6zSvR1RXXtBtPsYiGkhzI1QK2hXoZ1N6oMByI81KNC5nn9W17hFUy5fIY2y8
         lfO2zu/YXQotLlXKDN99jst+06W+22wweOz5pcyO2ULdg2LBGeBWBQUpxnAlkFwdUTPl
         xcePQmC8qQcWwPmy0y6cO8hDq+qUns51SSdB51QlfS+bBKp4FtRQ23OM73Ck9SA4Dpht
         VuyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g9qrjjBbM1UMLpM0hRZ+Jb2A7nD4HhHAvZYWBR2w6NQ=;
        b=ryLx4zSsrTf5Fe27edNZm5NNnKFZvKCNG7c1EkGvKI4I9Il63cEBM99iw+g6hZwoKE
         hW+z+V/ZKCxCG8YjgZuRMW96r+FSS45/bYkNhT8bGWao2lgJbGnRePCF9skOtH0NkCZg
         WS25cU0UJ6O5VmF99W76meBJ/fEArv5gelpYSxxGTJZsr2Tb8wjSCIYxm7KLoKDMamCw
         eHmvp1ajn5Um8NZO60MCsnSLVJ/kAQCubXu3NydxS7FX8wiA6ZAUR4ulN4pQU9U4Df5W
         p53Hh1vGgszGr2srawtbKhg+AMJhPa85j+3IJiJMm9tBwqZr9aTS4yboa2YoLdBnR/1C
         UsUQ==
X-Gm-Message-State: ACrzQf0rQcdm4LS+D8w2UNDZMgy60wwx/sKcVyNSsi0xADAh81hYBv6K
        zs5OSCetTRUNEi24xPD3gDRAjZbdYFWxyw==
X-Google-Smtp-Source: AMsMyM5/JurpmI4uq83Wm77V+7LFNGiIpwFTMQac8uw6EQYJIRkY1mTjiQuAFmtacLol+44RXVjn7g==
X-Received: by 2002:a65:6ccd:0:b0:439:2033:6ee with SMTP id g13-20020a656ccd000000b00439203306eemr26806203pgw.271.1665593373887;
        Wed, 12 Oct 2022 09:49:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w72-20020a627b4b000000b005628a30a500sm109831pfc.41.2022.10.12.09.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 09:49:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 12 Oct 2022 09:49:32 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ajd@linux.ibm.com, aneesh.kumar@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, christophe.leroy@csgroup.eu,
        cuigaosheng1@huawei.com, david@redhat.com, farosas@linux.ibm.com,
        geoff@infradead.org, gustavoars@kernel.org, haren@linux.ibm.com,
        hbathini@linux.ibm.com, joel@jms.id.au, lihuafei1@huawei.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        lukas.bulwahn@gmail.com, mikey@neuling.org, nathan@kernel.org,
        nathanl@linux.ibm.com, nicholas@linux.ibm.com, npiggin@gmail.com,
        pali@kernel.org, paul@paul-moore.com, rmclure@linux.ibm.com,
        ruscur@russell.cc, windhl@126.com,
        wsa+renesas@sang-engineering.com, ye.xingchen@zte.com.cn,
        yuanjilin@cdjrlc.com, zhengyongjun3@huawei.com
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.1-1 tag
Message-ID: <20221012164932.GB2990467@roeck-us.net>
References: <87edvhntv0.fsf@mpe.ellerman.id.au>
 <20221012141827.GA2405914@roeck-us.net>
 <Y0biBtCUtc2mowbQ@zx2c4.com>
 <Y0bvOreqH2BdyVqt@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0bvOreqH2BdyVqt@zx2c4.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 10:45:46AM -0600, Jason A. Donenfeld wrote:
> On Wed, Oct 12, 2022 at 09:49:26AM -0600, Jason A. Donenfeld wrote:
> > On Wed, Oct 12, 2022 at 07:18:27AM -0700, Guenter Roeck wrote:
> > > NIP [c000000000031630] .replay_soft_interrupts+0x60/0x300
> > > LR [c000000000031964] .arch_local_irq_restore+0x94/0x1c0
> > > Call Trace:
> > > [c000000007df3870] [c000000000031964] .arch_local_irq_restore+0x94/0x1c0 (unreliable)
> > > [c000000007df38f0] [c000000000f8a444] .__schedule+0x664/0xa50
> > > [c000000007df39d0] [c000000000f8a8b0] .schedule+0x80/0x140
> > > [c000000007df3a50] [c00000000092f0dc] .try_to_generate_entropy+0x118/0x174
> > > [c000000007df3b40] [c00000000092e2e4] .urandom_read_iter+0x74/0x140
> > > [c000000007df3bc0] [c0000000003b0044] .vfs_read+0x284/0x2d0
> > > [c000000007df3cd0] [c0000000003b0d2c] .ksys_read+0xdc/0x130
> > > [c000000007df3d80] [c00000000002a88c] .system_call_exception+0x19c/0x330
> > > [c000000007df3e10] [c00000000000c1d4] system_call_common+0xf4/0x258
> > 
> > Obviously the first couple lines of this concern me a bit. But I think
> > actually this might just be a catalyst for another bug. You could view
> > that function as basically just:
> > 
> >     while (something)
> >     	schedule();
> > 
> > And I guess in the process of calling the scheduler a lot, which toggles
> > interrupts a lot, something got wedged.
> > 
> > Curious, though, I did try to reproduce this, to no avail. My .config is
> > https://xn--4db.cc/rBvHWfDZ . What's yours?
> 
> I also just tried using your github linux-build-test scripts as a guide
> for construction a config -- https://xn--4db.cc/B0HpEQDQ -- and loaded
> up your rootfs over sdhci and such, and still couldn't manage to
> reproduce. I tried commenting out the line "if (!bits)" in
> _credit_init_bits(), so that the rng would never initialize, so that the
> schedule() loop would just keep on running indefinitely, but still no
> dice.
> 
> But also, I'm running Linus' tree. From your log, I see
> "6.0.0-rc2-00163-ga5edf9815dd7". So maybe these bugs got fixed
> elsewhere?
> 

Blame me for not attaching the latest crash report.

Guenter

---
BUG: soft lockup - CPU#0 stuck for 23s! [dd:111]
Modules linked in:
CPU: 0 PID: 111 Comm: dd Not tainted 6.0.0-11414-g49da07006239 #1
Hardware name: PowerMac3,1 PPC970FX 0x3c0301 PowerMac
NIP:  c000000000031630 LR: c000000000031964 CTR: 0000000000000000
REGS: c000000007d5b6a8 TRAP: 0900   Not tainted  (6.0.0-11414-g49da07006239)
MSR:  8000000000009032 <SF,EE,ME,IR,DR,RI>  CR: 28002228  XER: 00000000
IRQMASK: 0
GPR00: c000000000031964 c000000007d5b870 c0000000013e5500 c000000007d5b6a8
GPR04: c00000000125e1c0 0000000000000000 c000000007d5b814 c00000000291d018
GPR08: c000000002d4bbb8 0000000000000000 c000000007356400 c000000002d21098
GPR12: 0000000028002222 c000000002e20000 00000000100d32e0 00000000100d32b4
GPR16: 00000000100d3301 00000000100d32b9 00000000100d3358 00000000100d32bf
GPR20: 0000000000002000 00000000100d3372 00000000100d331e c000000007356c18
GPR24: 0000000000000000 0000000000000e60 0000000000000900 0000000000000500
GPR28: 0000000000000a00 0000000000000f00 0000000000000002 0000000000000003
NIP [c000000000031630] .replay_soft_interrupts+0x60/0x300
LR [c000000000031964] .arch_local_irq_restore+0x94/0x1c0
Call Trace:
[c000000007d5b870] [c000000000031964] .arch_local_irq_restore+0x94/0x1c0 (unreliable)
[c000000007d5b8f0] [c000000000f8bac4] .__schedule+0x664/0xa50
[c000000007d5b9d0] [c000000000f8bf30] .schedule+0x80/0x140
[c000000007d5ba50] [c00000000093085c] .try_to_generate_entropy+0x118/0x174
[c000000007d5bb40] [c00000000092fa64] .urandom_read_iter+0x74/0x140
[c000000007d5bbc0] [c0000000003b0044] .vfs_read+0x284/0x2d0
[c000000007d5bcd0] [c0000000003b0d2c] .ksys_read+0xdc/0x130
[c000000007d5bd80] [c00000000002a88c] .system_call_exception+0x19c/0x330
[c000000007d5be10] [c00000000000c1d4] system_call_common+0xf4/0x258
--- interrupt: c00 at 0x7fffb5c9d49c
NIP:  00007fffb5c9d49c LR: 000000001000da90 CTR: 0000000000000000
REGS: c000000007d5be80 TRAP: 0c00   Not tainted  (6.0.0-11414-g49da07006239)
MSR:  800000000000f032 <SF,EE,PR,FP,ME,IR,DR,RI>  CR: 22002422  XER: 00000000
IRQMASK: 0
GPR00: 0000000000000003 00007ffff6dcc220 00007fffb5d97300 0000000000000000
GPR04: 00000000101102a0 0000000000000020 0000000000000000 0000000000000000
GPR08: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
GPR12: 0000000000000000 00007fffb5e6aac0 00000000100d32e0 00000000100d32b4
GPR16: 00000000100d3301 00000000100d32b9 00000000100d3358 00000000100d32bf
GPR20: 0000000000002000 00000000100d3372 00000000100d331e 0000000000000000
GPR24: 7fffffffffffffff 00000000100b3a9c 00000000101102a0 0000000000000020
GPR28: 00000000101025c0 0000000000000020 0000000000000000 0000000000000000
NIP [00007fffb5c9d49c] 0x7fffb5c9d49c
LR [000000001000da90] 0x1000da90
--- interrupt: c00
Instruction dump:
3b600500 3b800a00 3ba00f00 f8010010 f821fdc1 60000000 60000000 38610078
e92d0af8 f92101f8 39200000 48039745 <60000000> 39000000 e9410180 892d0933
Kernel panic - not syncing: softlockup: hung tasks
CPU: 0 PID: 111 Comm: dd Tainted: G             L     6.0.0-11414-g49da07006239 #1
Hardware name: PowerMac3,1 PPC970FX 0x3c0301 PowerMac
Call Trace:
[c000000007d5b180] [c000000000f59b40] .dump_stack_lvl+0x7c/0xc4 (unreliable)
[c000000007d5b210] [c0000000000d5b58] .panic+0x174/0x42c
[c000000007d5b2c0] [c000000000231054] .watchdog_timer_fn+0x3a4/0x3e0
[c000000007d5b380] [c0000000001cc65c] .__hrtimer_run_queues+0x1fc/0x650
[c000000007d5b490] [c0000000001cd5cc] .hrtimer_interrupt+0x11c/0x320
[c000000007d5b550] [c000000000021f5c] .timer_interrupt+0x1cc/0x600
[c000000007d5b630] [c0000000000316c8] .replay_soft_interrupts+0xf8/0x300
[c000000007d5b870] [c000000000031964] .arch_local_irq_restore+0x94/0x1c0
[c000000007d5b8f0] [c000000000f8bac4] .__schedule+0x664/0xa50
[c000000007d5b9d0] [c000000000f8bf30] .schedule+0x80/0x140
[c000000007d5ba50] [c00000000093085c] .try_to_generate_entropy+0x118/0x174
[c000000007d5bb40] [c00000000092fa64] .urandom_read_iter+0x74/0x140
[c000000007d5bbc0] [c0000000003b0044] .vfs_read+0x284/0x2d0
[c000000007d5bcd0] [c0000000003b0d2c] .ksys_read+0xdc/0x130
[c000000007d5bd80] [c00000000002a88c] .system_call_exception+0x19c/0x330
[c000000007d5be10] [c00000000000c1d4] system_call_common+0xf4/0x258
--- interrupt: c00 at 0x7fffb5c9d49c
NIP:  00007fffb5c9d49c LR: 000000001000da90 CTR: 0000000000000000
REGS: c000000007d5be80 TRAP: 0c00   Tainted: G             L      (6.0.0-11414-g49da07006239)
MSR:  800000000000f032 <SF,EE,PR,FP,ME,IR,DR,RI>  CR: 22002422  XER: 00000000
IRQMASK: 0
GPR00: 0000000000000003 00007ffff6dcc220 00007fffb5d97300 0000000000000000
GPR04: 00000000101102a0 0000000000000020 0000000000000000 0000000000000000
GPR08: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
GPR12: 0000000000000000 00007fffb5e6aac0 00000000100d32e0 00000000100d32b4
GPR16: 00000000100d3301 00000000100d32b9 00000000100d3358 00000000100d32bf
GPR20: 0000000000002000 00000000100d3372 00000000100d331e 0000000000000000
GPR24: 7fffffffffffffff 00000000100b3a9c 00000000101102a0 0000000000000020
GPR28: 00000000101025c0 0000000000000020 0000000000000000 0000000000000000
NIP [00007fffb5c9d49c] 0x7fffb5c9d49c
LR [000000001000da90] 0x1000da90
--- interrupt: c00

