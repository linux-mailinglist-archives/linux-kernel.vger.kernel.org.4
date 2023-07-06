Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB0374A10F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 17:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbjGFPdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 11:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbjGFPdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:33:00 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429C7CE
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 08:32:57 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b8b4748fe4so4177085ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 08:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1688657577; x=1691249577;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N6lyMxeS+e0pJhp55nKpC5eOBkYAdHTHBoBzIRWQdFs=;
        b=VqVvafUF4uyzKUnepHzzdvLSq8nLzqJFtyy7PTpxtTAz5mE0rtdNyiWNzeLhV6jlN4
         u16pRu5RqU8Mo18KWRjMxLsjtme8/pitktdq3cqvGHtx5RUx3T9FoKNafcet/DixbSqU
         9bUAt0F+quMY3Q8AcjyayzdoI8CovHm4mmb+jn/465pVcoxKqK7Y66hkOgRsWZWS1qob
         3q+lMSsavZjvRufHL5gCZr8w4SrpmvCgj7MHoRha2yoZW4jHsRFPHrZaWHDh5OBq0I9P
         C2dnqK6OJzHEtwdJ8ML7GC5zbKNCbVmoko2ULK+/mpUWaI7hT7cI79c+Z5qUYzbX1E4h
         ifHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688657577; x=1691249577;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6lyMxeS+e0pJhp55nKpC5eOBkYAdHTHBoBzIRWQdFs=;
        b=ka7bbAwP0klWb/nZtblAk2eZnLeBG6qODCy6Q10a3TkJXibXCu4JYsSPZDWtECEclA
         LUtQTwYGluTBFWJStLqXwEGVPgdKpL9qZz9qNhIJ3oCwpklY54U/LSIpuOSMESdqNd6M
         CYVhgt4IDuE57gtrbVS7uWYcPwZOa2ox3cUTfLysebU7ggh/fkZHKlVE7/fLcoMwOLtb
         sisk1wNQfqWUYcn0cDQlCrKG+WSUsAEP7RlVlJ1/skkiXrONCAzjr9Mnv5cRSAl/M2VQ
         DxVLai0/agq7Z7BN5obHodP/tSdP9qwutL21U6w59EHW5G+DE13rGWYDeEAyUfwIJxGs
         Oj8A==
X-Gm-Message-State: ABy/qLZ+NNHjw65mXZ1j4XUUZvibxZEqTBCTZB3eO6j2GD/bWLhKC9kI
        Xt2wPj/EOhZ5KXKqOhjZOcKwPQ==
X-Google-Smtp-Source: APBJJlE3L43X6wT1gzNh6aJgVM0UkrizFZZiSxvmjHfMz2wnXLi9GFvxIVkGAerZPK8rBxvD4vwX8A==
X-Received: by 2002:a17:903:2281:b0:1b8:a684:f73f with SMTP id b1-20020a170903228100b001b8a684f73fmr1843015plh.68.1688657576443;
        Thu, 06 Jul 2023 08:32:56 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id a12-20020a170902eccc00b001b8b73da7b1sm1567446plh.227.2023.07.06.08.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 08:32:55 -0700 (PDT)
Date:   Thu, 06 Jul 2023 08:32:55 -0700 (PDT)
X-Google-Original-Date: Thu, 06 Jul 2023 08:32:08 PDT (-0700)
Subject:     Re: [External] Re: [PATCH v3 0/4] Obtain SMBIOS and ACPI entry from FFI
In-Reply-To: <CAMj1kXFZren0Q19DimwQaETCLz64D4bZQC5B2N=i3SAWHygkTQ@mail.gmail.com>
CC:     cuiyunhui@bytedance.com, jrtc27@jrtc27.com, kernel@esmil.dk,
        Conor Dooley <conor@kernel.org>, sunilvl@ventanamicro.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        rminnich@gmail.com, Mark Rutland <mark.rutland@arm.com>,
        lpieralisi@kernel.org, rafael@kernel.org, lenb@kernel.org,
        jdelvare@suse.com, yc.hung@mediatek.com,
        angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, geshijian@bytedance.com,
        weidong.wd@bytedance.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Message-ID: <mhng-b66b085a-eb15-4c9b-b2aa-93ddf16ec7aa@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Jul 2023 01:53:47 PDT (-0700), Ard Biesheuvel wrote:
> On Thu, 6 Jul 2023 at 04:04, 运辉崔 <cuiyunhui@bytedance.com> wrote:
>>
>> Hi Palmer,
>>
>> On Wed, Jul 5, 2023 at 10:17 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>> >
>> > On Wed, 05 Jul 2023 04:42:47 PDT (-0700), cuiyunhui@bytedance.com wrote:
>> > > Here's version 3 of patch series.
>> > >
>> > > V1: The FFI (FDT FIRMWARE INTERFACE) scheme has reached a
>> > > consensus with the Maintainers.
>> > > Please refer to:
>> > > https://patches.linaro.org/project/linux-acpi/patch/20230426034001.16-1-cuiyunhui@bytedance.com/
>> >
>> > From looking at that thread it seems that the consensus is this is a bad
>> > idea?  Sorry if I'm just missing something...
>> >
>>
>> First of all, Coreboot does not support EFI, Ron has expressed, as follows:
>> "I am wondering if we can focus on risc-v here, and not drag in ARM,
>> b/c the ARM ACPI+UEFI ship has sailed. I had that discussion in 2013
>> ;-) and it's clear we don't want to redo it.
>> In general, in my world, because of the many problems that come with
>> UEFI (security, code quality, performance), we'd like to avoid
>> requiring a dependency on UEFI just to get ACPI on RISC-V. It also
>> seems, from other discussions I'm having, that there is some belief
>> that ACPI will be wanted on RISC-V. It would be nice to separate those
>> pieces on RISC-V; certainly they were separate for a very long time in
>> the x86 world (we had ACPI+SMM on coreboot laptops without UEFI for
>> example)."
>>
>
> There appears to be a bit of cargo cult going on here.
>
> I agree that the traditional BIOS vendors did a terrible job pivoting
> to (U)EFI when it became a requirement for booting Windows on x86 PCs,
> and coreboot did an excellent job providing a retrofit alternative
> that was more secure and robust.
>
> However, it makes sense to distinguish between
> a) the UEFI specification
> b) the UEFI reference implementation (edk2)
> c) commercial implementations created by BIOS vendors for x86 PC OEMs
> that do not perform any testing beyond booting Windows.
>
> coreboot decided not to implement EFI at all, which on x86 means
> booting in a mode that is similar to BIOS boot. Given how the ACPI and
> DMTF (for SMBIOS) specifications were already under development when
> UEFI was being rolled out on x86, those specs contain provisions
> defining how to obtain the ACPI and SMBIOS tables by scanning regions
> of memory and looking for magic strings. But this is only defined for

In theory we have that in RISC-V as well: on boot we don't actually have 
a DT pointer, but instead a "config string" pointer.  That's a bit of a 
retcon from when we were planning on adding our own firmware probing 
interface, but in order to appear to have never made a mistake we just 
said that config strings can be anything and have magic numbers to 
differentiate between the flavors.

IIUC we don't take advantage of that in Linux, though, so maybe let's 
just pretend it doesn't exist?

> x86, and only works on x86 because all x86 machines are essentially
> PCs with a highly uniform system topology.
>
> The ARM case is very different, and while I am no expect on RISC-V,
> the following probably applies to it as well:
> - there is no need to work around buggy proprietary firmware that can
> boot Windows but not Linux
> - there is no 'prior art' when it comes to pre-EFI boot interfaces
> except for embedded style bare metal boot where all initialization is
> done by the kernel (e.g., PCI enumeration and resource assignment
> etc), and this is fundamentally arch specific
> - ACPI is a rich firmware interface, and the ACPI specification layers
> it on top of UEFI so the OS can make certain assumptions about the
> extent to which the platform has been initialized by the time it hands
> over.
>
> This is why the maintainers of the arm64 and RISC-V ports appear to
> agree that ACPI will only be supported when booting from firmware that

Yes, we're basically in the same spot as arm64 is here -- or at least 
we're aiming to be, we've yet to even release a kernel that boots with 
ACPI so we have no legacy compatibility yet.

> implements the EFI specification. Note that this does not impose any
> requirement at all regarding which EFI implementation is going to be
> used: suggestions have been made on the thread to use a) a coreboot
> specific minimal EFI shim that describes the firmware tables and the
> EFI memory map, b) the UPL payload for coreboot, and c) U-Boot's EFI
> implementation.
>
> I will also note that booting according to the EFI spec is not
> fundamentally  more secure or faster: I have done some experiments on
> arm64 comparing bare metal boot with EFI boot using a minimal
> implementation in Rust, for booting virtual machines under KVM. Due to
> cache maintenance overhead and execution with the MMU disabled, bare
> metal boot is actually slightly slower. And due to the fact that the
> minimal EFI firmware enables the MMU and caches straight out of reset,
> it is also arguably more secure, given that all memory permission
> based protections and other page table based hardening measures (e.g.,
> BTI) are always enabled.
>
> In summary, I think it may be time to stop extrapolating from bad
> experiences with buggy proprietary x86 PC firmware created by
> traditional BIOS vendors for booting Windows (and nothing else) 15+
> years ago. The situation is very different for non-x86 Linux
> architectures, where we are trying hard to beat some sense into the
> fragmented embedded ecosystem, where every SoC vendor used to have its
> own fork of u-boot that booted in a slightly different manner,
> requiring a lot of effort on the part of the distros to track all
> those moving targets.

That's roughly where we're trying to go in RISC-V land, at least for 
most software people.  Everyone gets their own ISA, which obviously 
causes a ton of fragmentation, but not really anything we can do about 
that.  At least we can avoid adding additional sources of fragmentation 
from the software side of things, though.

>> Then, a consensus was reached with Ard, that FFI can be applied to RISC-V.
>>
>
> For the record, I would not characterize this as consensus. What I said was
> - SMBIOS has very little significance to the kernel itself or impact
> on its internal operation, and so it can be exposed via DT in a
> generic manner;
> - ACPI without UEFI on non-x86 is a) a bad idea, and b) fundamentally
> broken on arm64. So b) is out of the question, but it is not up to me
> to decide whether or not the RISC-V maintainers should entertain bad
> ideas.

IMO we have enough bad ideas in RISC-V already and thus should avoid 
adding more.
