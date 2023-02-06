Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CDC68C9C4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 23:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjBFWsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 17:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjBFWr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 17:47:57 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8A6FF1C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 14:47:52 -0800 (PST)
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4502D41AE7
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 22:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1675723670;
        bh=VjsfREu60pLZr44v0XyMe9ovUs6l2w2CeUG5BdUJPho=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=TsGHYHpXCgbYmIR8YDCwkU0SCYNRKh63eNSPbBDn8Y2lqV8wmuZGOrKhDXhDQTZSk
         ohTmV7CONpoftvWB2tm18eiK71B9VxxKW8wR9a+7iVwdE8xGVDQrjuTP1we2fxIN65
         C7yu7gf/qRTycOiKq17m8qn0TnjkbHgmZ7NJU+Q51Wf+Vdf+aMDFyRD5w2bBVeqrjv
         lbkG7RCcld02vYeo2+Bob4uVazlM0YkU6VB+suK7dtO2iTNgZWCOWjVatps4rQM8Jz
         AUhdPG56J0ahg0WPTKUV0A3o08xzUsixVhHAnqX4cL6507rZaR7GJipRt7b5txorj1
         DmjqFlYryh+fQ==
Received: by mail-lj1-f197.google.com with SMTP id r12-20020a2e80cc000000b002904f4b5fd2so3146967ljg.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 14:47:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VjsfREu60pLZr44v0XyMe9ovUs6l2w2CeUG5BdUJPho=;
        b=0n6NEd1c8YjQRaCUbIotNSjpnv/ujuvgCEWfrZK/jzci3ZIHqFu4B4dl2uhwHkULmm
         +yYhKMJSiFN1Yozb88IVs8Qphix2ENsyEpdtRKDc0qr1oRFs09aK7Qpg83NBGYkSrS8O
         2Vn01gZmA1PjvCHs5+BHTVYHmEjYgZnzTxZYVSloPejg+GpBa4E+xrcd1HxQELHv/ZKk
         KQ0Hw1gAJkzQaDd7RVdmdvArHP6x/aCmFEj6K5xU5bIsGek4G0gJfDgL61oUh+AsJPPq
         +jjS20y+FYKf7FyFMC0agfT48sxNRwQ7yghuadwptdKyAkNrV8PXVDQW46IC6PFeD/sx
         /Q5w==
X-Gm-Message-State: AO0yUKVVF//uyBif1NQTjgS7qWvi07ZXuondqkWt3rfXxqIhdBGp+Rvn
        BksAdTBTsYGfMH31Cn269l9pLUME3mZoKTotz62LqcUMAYctQAHuDxNDo/cJeLMc9eNLEeZfuBG
        jvv+XLGf0QxJnHpgu3/1How1iHQZonch0iiM3clMs3w==
X-Received: by 2002:a05:600c:13c8:b0:3da:28a9:a900 with SMTP id e8-20020a05600c13c800b003da28a9a900mr1079128wmg.41.1675723658698;
        Mon, 06 Feb 2023 14:47:38 -0800 (PST)
X-Google-Smtp-Source: AK7set9KRf5TMwnWQSrwLboAv4ZBKRqxffZC1AlZvTLHy48L5l3G8wf2kaChO6RGlC9xmflDOxLzFQ==
X-Received: by 2002:a05:600c:13c8:b0:3da:28a9:a900 with SMTP id e8-20020a05600c13c800b003da28a9a900mr1079114wmg.41.1675723658250;
        Mon, 06 Feb 2023 14:47:38 -0800 (PST)
Received: from [192.168.123.94] (ip-088-152-145-137.um26.pools.vodafone-ip.de. [88.152.145.137])
        by smtp.gmail.com with ESMTPSA id l16-20020a1c7910000000b003dc1d668866sm16727320wme.10.2023.02.06.14.47.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 14:47:37 -0800 (PST)
Message-ID: <de7fec14-7c43-6584-db72-b4c3a9f1423a@canonical.com>
Date:   Mon, 6 Feb 2023 23:47:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 0/6] RISC-V Hardware Probing User Interface
Content-Language: en-US
To:     Evan Green <evan@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>, linux-doc@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        Tsukasa OI <research_trasio@irq.a4lg.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        Andrew Jones <ajones@ventanamicro.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Vineet Gupta <vineetg@rivosinc.com>,
        Mark Brown <broonie@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Ruizhe Pan <c141028@gmail.com>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-kselftest@vger.kernel.org, slewis@rivosinc.com,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Conor Dooley <conor@kernel.org>, dram <dramforever@live.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Guo Ren <guoren@kernel.org>, Dao Lu <daolu@rivosinc.com>,
        Jessica Clarke <jrtc27@jrtc27.com>
References: <20230206201455.1790329-1-evan@rivosinc.com>
 <212CC1BD-31FF-4B8B-B05D-89C5245EE8A7@jrtc27.com>
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <212CC1BD-31FF-4B8B-B05D-89C5245EE8A7@jrtc27.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/23 22:11, Jessica Clarke wrote:
> On 6 Feb 2023, at 20:14, Evan Green <evan@rivosinc.com> wrote:
>>
>>
>> These are very much up for discussion, as it's a pretty big new user
>> interface and it's quite a bit different from how we've historically
>> done things: this isn't just providing an ISA string to userspace, this
>> has its own format for providing information to userspace.
>>
>> There's been a bunch of off-list discussions about this, including at
>> Plumbers.  The original plan was to do something involving providing an
>> ISA string to userspace, but ISA strings just aren't sufficient for a
>> stable ABI any more: in order to parse an ISA string users need the
>> version of the specifications that the string is written to, the version
>> of each extension (sometimes at a finer granularity than the RISC-V
>> releases/versions encode), and the expected use case for the ISA string
>> (ie, is it a U-mode or M-mode string).  That's a lot of complexity to
>> try and keep ABI compatible and it's probably going to continue to grow,
>> as even if there's no more complexity in the specifications we'll have
>> to deal with the various ISA string parsing oddities that end up all
>> over userspace.
>>
>> Instead this patch set takes a very different approach and provides a set
>> of key/value pairs that encode various bits about the system.  The big
>> advantage here is that we can clearly define what these mean so we can
>> ensure ABI stability, but it also allows us to encode information that's
>> unlikely to ever appear in an ISA string (see the misaligned access
>> performance, for example).  The resulting interface looks a lot like
>> what arm64 and x86 do, and will hopefully fit well into something like
>> ACPI in the future.
>>
>> The actual user interface is a syscall.  I'm not really sure that's the
>> right way to go about this, but it makes for flexible prototying.
>> Various other approaches have been talked about like making HWCAP2 a
>> pointer, having a VDSO routine, or exposing this via sysfs.  Those seem
>> like generally reasonable approaches, but I've yet to figure out a way
>> to get the general case working without a syscall as that's the only way
>> I've come up with to deal with the heterogenous CPU case.  Happy to hear
>> if someone has a better idea, though, as I don't really want to add a
>> syscall if we can avoid it.

Operating systems tend to reschedule threads moving them between harts. 
New threads may be created by processes at any time.

It is not clear to me what information the syscall shall convey in the 
heterogeneous case. I see the following alternatives:

* The syscall describes the current hart.
* The syscall provides individual properties of all harts.
* The syscall provides a set of properties that is valid for any hart on 
which the thread might be scheduled.
* The syscall provides a set of properties that is valid for any hart 
that any thread of the current process might be scheduled to.

Describing only the current hart would not be helpful as the thread 
might be rescheduled to a hart with a smaller set of available extensions.

Describing the properties of all harts would not be helpful if the 
thread has no control to which hart it is scheduled.

Processes that don't control scheduling would most benefit from a 
guaranteed set of properties valid for all threads of the process.

Processes that take control of scheduling would probably want 
information about all harts.

Best regards

Heinrich

> 
> Please work with https://github.com/riscv-non-isa/riscv-c-api-doc as
> it’s crucial we have a portable standard interface for applications to
> query this information that works on OSes other than Linux. This can be
> backed by whatever you want, whether a syscall, magic VDSO thing,
> sysfs, etc, but it’s key that the exposed interface outside of libc is
> not Linux-specific otherwise we’re going to get fragmentation in this
> space.
> 
> I would encourage figuring out the right shape for the exposed
> interface first before continuing to refine details of how that
> information gets communicated between the kernel and libc.
> 
> Jess
> 
>> An example series in glibc exposing this syscall and using it in an
>> ifunc selector for memcpy can be found at [1].
>>
>> [1] https://public-inbox.org/libc-alpha/20230206194819.1679472-1-evan@rivosinc.com/T/#t
>>
>> Changes in v2:
>> - Changed the interface to look more like poll(). Rather than supplying
>>    key_offset and getting back an array of values with numerically
>>    contiguous keys, have the user pre-fill the key members of the array,
>>    and the kernel will fill in the corresponding values. For any key it
>>    doesn't recognize, it will set the key of that element to -1. This
>>    allows usermode to quickly ask for exactly the elements it cares
>>    about, and not get bogged down in a back and forth about newer keys
>>    that older kernels might not recognize. In other words, the kernel
>>    can communicate that it doesn't recognize some of the keys while
>>    still providing the data for the keys it does know.
>> - Added a shortcut to the cpuset parameters that if a size of 0 and
>>    NULL is provided for the CPU set, the kernel will use a cpu mask of
>>    all online CPUs. This is convenient because I suspect most callers
>>    will only want to act on a feature if it's supported on all CPUs, and
>>    it's a headache to dynamically allocate an array of all 1s, not to
>>    mention a waste to have the kernel loop over all of the offline bits.
>> - Fixed logic error in if(of_property_read_string...) that caused crash
>> - Include cpufeature.h in cpufeature.h to avoid undeclared variable
>>    warning.
>> - Added a _MASK define
>> - Fix random checkpatch complaints
>> - Updated the selftests to the new API and added some more.
>> - Fixed indentation, comments in .S, and general checkpatch complaints.
>>
>> Evan Green (4):
>>   RISC-V: Move struct riscv_cpuinfo to new header
>>   RISC-V: Add a syscall for HW probing
>>   RISC-V: hwprobe: Support probing of misaligned access performance
>>   selftests: Test the new RISC-V hwprobe interface
>>
>> Palmer Dabbelt (2):
>>   RISC-V: hwprobe: Add support for RISCV_HWPROBE_BASE_BEHAVIOR_IMA
>>   dt-bindings: Add RISC-V misaligned access performance
>>
>> .../devicetree/bindings/riscv/cpus.yaml       |  15 ++
>> Documentation/riscv/hwprobe.rst               |  66 ++++++
>> Documentation/riscv/index.rst                 |   1 +
>> arch/riscv/include/asm/cpufeature.h           |  23 +++
>> arch/riscv/include/asm/hwprobe.h              |  13 ++
>> arch/riscv/include/asm/smp.h                  |   9 +
>> arch/riscv/include/asm/syscall.h              |   3 +
>> arch/riscv/include/uapi/asm/hwprobe.h         |  35 ++++
>> arch/riscv/include/uapi/asm/unistd.h          |   8 +
>> arch/riscv/kernel/cpu.c                       |  11 +-
>> arch/riscv/kernel/cpufeature.c                |  31 ++-
>> arch/riscv/kernel/sys_riscv.c                 | 192 +++++++++++++++++-
>> tools/testing/selftests/Makefile              |   1 +
>> tools/testing/selftests/riscv/Makefile        |  58 ++++++
>> .../testing/selftests/riscv/hwprobe/Makefile  |  10 +
>> .../testing/selftests/riscv/hwprobe/hwprobe.c |  89 ++++++++
>> .../selftests/riscv/hwprobe/sys_hwprobe.S     |  12 ++
>> tools/testing/selftests/riscv/libc.S          |  46 +++++
>> 18 files changed, 613 insertions(+), 10 deletions(-)
>> create mode 100644 Documentation/riscv/hwprobe.rst
>> create mode 100644 arch/riscv/include/asm/cpufeature.h
>> create mode 100644 arch/riscv/include/asm/hwprobe.h
>> create mode 100644 arch/riscv/include/uapi/asm/hwprobe.h
>> create mode 100644 tools/testing/selftests/riscv/Makefile
>> create mode 100644 tools/testing/selftests/riscv/hwprobe/Makefile
>> create mode 100644 tools/testing/selftests/riscv/hwprobe/hwprobe.c
>> create mode 100644 tools/testing/selftests/riscv/hwprobe/sys_hwprobe.S
>> create mode 100644 tools/testing/selftests/riscv/libc.S
>>
>> -- 
>> 2.25.1
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
