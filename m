Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E052A601647
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 20:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbiJQS3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 14:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiJQS25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 14:28:57 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E29F748E3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 11:28:57 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1321a1e94b3so14248389fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 11:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=garS2H7hrtCQgK+3svjO+YNXLY2IJ6zIG7NN3iNx5P0=;
        b=FeT1M+Qd/AoRCTrToYB7hJdUTfTTHiVUYZhKijeJahSM0R08gh0hRomyuwFINfwEeo
         xJ2/UXU0xXlOF2dWc2tRkQuWW5V7u8gzUueG/IBZJaIR5/7Hy1kQt6Y9jdfdgJ6hj+G5
         5AdVpN9NGV1YcMjtQ2KBkop+ynLBu9+CQsOR2YHW6PdNhGrWtqQTCokLbhGcfxIPJCPC
         +/2eWRhsy8lINhXd/FUPT4huKY8iBQzb97CIGoFyvFH7e3rEskHm6QhOkGOjn/GlVWcg
         LL5sOtHIOm5K23xNy0ksEJLfCn1rDN2LH5ITRMJJpDcUEkFfrsB3fTBIRJO+Nkp3c61h
         LH/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=garS2H7hrtCQgK+3svjO+YNXLY2IJ6zIG7NN3iNx5P0=;
        b=svpuOIQjYHmwvdr/7vsiqbba5tZrWgOpoTaeyIGrZoIovLb60WngC4/xcJjFJeBWa0
         EwOhS08IImRXhTPPNFJj4tkv0ULbjvYOqtk/A/nxkZY4gy4x0YNiCZuayWCTChHt3xtf
         wGDA/mxbM+rHA6vL8ykIo9JeOMdkytIQ4ctWn09jl1VhvyAEnWOazTZLOuxGEG5VjUdB
         wAXj9RT/Szj5ok7fABPKjiUsVelPmTBfQTwyy8H2VkFMBbVMaw8O9n4ZvIgdAY1+EMVa
         zMJ9gje34L0oBKrTl3g0xaV30tdqK3/aXsYfyNWZvBMtGo05qiwGAZQCtA3ADFFR7Ix7
         OzBQ==
X-Gm-Message-State: ACrzQf1pY48QNaeyHvY96xwXQ7B1Yrs8TXTAKTh4M9AJvVlPPhmNYg0Z
        6q+BKUNzsOndEAk0Q8G0ZlQ=
X-Google-Smtp-Source: AMsMyM7HAzSiVBoNXsEJBL4cUJSrWCREmwBnaySyn1XwbBr7+08F3TOF6/e6nPvsdMfLLFnpyv2crw==
X-Received: by 2002:a05:6870:fb8f:b0:132:8c58:39eb with SMTP id kv15-20020a056870fb8f00b001328c5839ebmr16467413oab.88.1666031336196;
        Mon, 17 Oct 2022 11:28:56 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v81-20020aca6154000000b0034fc91dbd7bsm4550961oib.58.2022.10.17.11.28.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 11:28:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7e5e4c7d-07f4-6ccd-6796-cd6f021f222e@roeck-us.net>
Date:   Mon, 17 Oct 2022 11:28:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        Hector Martin <marcan@marcan.st>,
        Arnd Bergmann <arnd@arndb.de>,
        Lee Jones <lee.jones@linaro.org>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Guo Ren <guoren@linux.alibaba.com>,
        Jakub Kicinski <kuba@kernel.org>
References: <CAHk-=wj6y5fipM2A5kEuOO9qm5PBzUY=-m9viEahhtxT09KR_g@mail.gmail.com>
 <20221017123434.GA1062543@roeck-us.net>
 <CAHk-=wh9o1x43Me0kRZAwN-DmZzUgJzUhA2_v+Uo0Aq04hB_=A@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: Linux 6.1-rc1
In-Reply-To: <CAHk-=wh9o1x43Me0kRZAwN-DmZzUgJzUhA2_v+Uo0Aq04hB_=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/22 10:39, Linus Torvalds wrote:
> On Mon, Oct 17, 2022 at 5:35 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> Build results:
>>          total: 152 pass: 152 fail: 0
>> Qemu test results:
>>          total: 490 pass: 420 fail: 70
> 
> Strange. You claim zero build failures, but then:
> 
>> Build failures
>>
>> Building riscv:defconfig ... failed
> 
> so I think your stats may be wrong somehow ;)
> 

Puzzled ... the logs show that the builds for riscv[32/64] succeeded
with no error, but a manual build test still shows the failure.

Ah .... the build fails with gcc 11.3.0 / binutils 2.38, but passes
with gcc 11.3.0 / binutils 2.39. I had switched my builders to the
latter last night to fix a problem with powerpc builds. At the same time,
the manual test I just ran still used binutils 2.38.

That is interesting; I didn't expect that the binutils version would
make a difference, but apparently it does. Comparing defconfig:

10c10
< CONFIG_AS_VERSION=23900
---
 > CONFIG_AS_VERSION=23800
12c12
< CONFIG_LD_VERSION=23900
---
 > CONFIG_LD_VERSION=23800
260d259
< CONFIG_RISCV_DMA_NONCOHERENT=y
297,298d295
< CONFIG_CC_HAS_ZICBOM=y
< CONFIG_RISCV_ISA_ZICBOM=y
4134,4137d4130
< CONFIG_ARCH_HAS_SETUP_DMA_OPS=y
< CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE=y
< CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU=y
< CONFIG_ARCH_HAS_DMA_PREP_COHERENT=y
4140,4142d4132
< CONFIG_DMA_NONCOHERENT_MMAP=y
< CONFIG_DMA_COHERENT_POOL=y
< CONFIG_DMA_DIRECT_REMAP=y

The build failure is only seen with CONFIG_RISCV_ISA_ZICBOM=n,
or in other words with binutils 2.38 or earlier.

>> mips, sparc64
>> -------------
>>
>> All big endian mips tests fail to reset after boot. The problem is
>> caused by commit 72a95859728a ("mfd: syscon: Remove repetition of the
>> regmap_get_val_endian()").
> 
> Bah. I had already archived that whole thread as "sorted out", but
> yeah, the revert clearly never made it to me for rc1.
> 

Yes, I saw a note along that line. The original reboot failure affected
sparc64 boot tests as well, which is gone now. Maybe some other fix for
the mips problem is in the works ?

> But it should be in the regmap queue (Lee/Andy?), so it is hopefully
> just a temporary thing.
> 
> In fact, it looks like all the failures have known fixes. So here's
> hoping that your list will be a whole lot cleaner by rc2.
> 
Hopefully yes.

Thanks,
Guenter

