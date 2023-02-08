Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271FC68F603
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 18:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjBHRra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 12:47:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjBHRrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 12:47:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DB7518EA
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 09:46:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EDB761784
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 17:45:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37DA8C433EF;
        Wed,  8 Feb 2023 17:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675878357;
        bh=gogWXBxQ/Xj8rp0vi+mwWK5HExxZssEICbV9WWmXlyk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bbro9Ri/QDvApTyXlIn0yGbB1ESDPlxtMSX6yQDa+lp2y6E6Ar1EbEZgmhZt9FhnD
         ArB7wnNphTEFkTrQ1PJ5bHl6INKRmhDQ11tTZWExT85w05RtxSZwgbksDHZuoXpjqo
         E+b0iwfzNMLOrjT+/FTLkfIyPDs9finIzp8hZRuyj2OH75HyeR/bcqY4lGftxMA+Ki
         HORgi1Uz7QMtY0hAHHMBTYY89UEeIvxUkZ78d75wphZHNIG6bafX0k0vNmuo4qFhKz
         r2/wIMJ/u0++BGNuu2Ly/vs0dXzGRsXcW2YpZlc0UjOn1ifcBZHpTB+nLbyjY8nsgu
         02+5/uKEaiLlw==
Date:   Wed, 8 Feb 2023 10:45:54 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     pbonzini@redhat.com, ebiggers@kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
        ardb@kernel.org, kraxel@redhat.com, hpa@zytor.com, bp@alien8.de,
        philmd@linaro.org
Subject: Re: [PATCH qemu v3] x86: don't let decompressed kernel image clobber
 setup_data
Message-ID: <Y+Pf0q6LmQKN+FHo@dev-arch.thelio-3990X>
References: <Y69fUstLKNv/RLd7@zx2c4.com>
 <20221230220725.618763-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221230220725.618763-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Fri, Dec 30, 2022 at 11:07:25PM +0100, Jason A. Donenfeld wrote:
> The setup_data links are appended to the compressed kernel image. Since
> the kernel image is typically loaded at 0x100000, setup_data lives at
> `0x100000 + compressed_size`, which does not get relocated during the
> kernel's boot process.
> 
> The kernel typically decompresses the image starting at address
> 0x1000000 (note: there's one more zero there than the compressed image
> above). This usually is fine for most kernels.
> 
> However, if the compressed image is actually quite large, then
> setup_data will live at a `0x100000 + compressed_size` that extends into
> the decompressed zone at 0x1000000. In other words, if compressed_size
> is larger than `0x1000000 - 0x100000`, then the decompression step will
> clobber setup_data, resulting in crashes.
> 
> Visually, what happens now is that QEMU appends setup_data to the kernel
> image:
> 
>           kernel image            setup_data
>    |--------------------------||----------------|
> 0x100000                  0x100000+l1     0x100000+l1+l2
> 
> The problem is that this decompresses to 0x1000000 (one more zero). So
> if l1 is > (0x1000000-0x100000), then this winds up looking like:
> 
>           kernel image            setup_data
>    |--------------------------||----------------|
> 0x100000                  0x100000+l1     0x100000+l1+l2
> 
>                                  d e c o m p r e s s e d   k e r n e l
>                      |-------------------------------------------------------------|
>                 0x1000000                                                     0x1000000+l3
> 
> The decompressed kernel seemingly overwriting the compressed kernel
> image isn't a problem, because that gets relocated to a higher address
> early on in the boot process, at the end of startup_64. setup_data,
> however, stays in the same place, since those links are self referential
> and nothing fixes them up.  So the decompressed kernel clobbers it.
> 
> Fix this by appending setup_data to the cmdline blob rather than the
> kernel image blob, which remains at a lower address that won't get
> clobbered.
> 
> This could have been done by overwriting the initrd blob instead, but
> that poses big difficulties, such as no longer being able to use memory
> mapped files for initrd, hurting performance, and, more importantly, the
> initrd address calculation is hard coded in qboot, and it always grows
> down rather than up, which means lots of brittle semantics would have to
> be changed around, incurring more complexity. In contrast, using cmdline
> is simple and doesn't interfere with anything.
> 
> The microvm machine has a gross hack where it fiddles with fw_cfg data
> after the fact. So this hack is updated to account for this appending,
> by reserving some bytes.
> 
> Cc: x86@kernel.org
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

I apologize if this has already been reported/fixed already (I did a
brief search on lore.kernel.org) or if my terminology is not as precise
as it could be, I am a little out of my element here :)

After this change as commit eac7a7791b ("x86: don't let decompressed
kernel image clobber setup_data") in QEMU master, I am no longer able to
boot a kernel directly through OVMF using '-append' + '-initrd' +
'-kernel'. Instead, systemd-boot tries to start the distribution's
kernel, which fails with:

  Error registering initrd: Already started

This can be reproduced with just a defconfig Linux kernel (I used
6.2-rc7), the simple buildroot images that ClangBuiltLinux uses for
boot testing [1], and OVMF. Prior to this change, the kernel would start
up but after, I am dumped into the UEFI shell (as there is no
bootloader).

The QEMU command I used was:

$ qemu-system-x86_64 \
    -kernel arch/x86_64/boot/bzImage \
    -append "console=ttyS0 earlycon=uart8250,io,0x3f8" \
    -drive if=pflash,format=raw,file=/usr/share/edk2/x64/OVMF_CODE.fd,readonly=on
    -drive if=pflash,format=raw,file=../boot-utils/images/x86_64/OVMF_VARS.fd \
    -object rng-random,filename=/dev/urandom,id=rng0 \
    -device virtio-rng-pci \
    -cpu host \
    -enable-kvm \
    -smp 8 \
    -display none \
    -initrd .../boot-utils/images/x86_64/rootfs.cpio \
    -m 512m \
    -nodefaults \
    -no-reboot \
    -serial mon:stdio

Not sure if the OVMF version will matter but just in case:

$ pacman -Q edk2-ovmf
edk2-ovmf 202211-3

I did see a few fixes on qemu-devel for this patch such as [2] but none
I found fixed the issue for me.

If there is any additional information I can provide or patches I can
test, please let me know.

[1]: https://github.com/ClangBuiltLinux/boot-utils/blob/fec03ef13519e26ac1f226e404e1620a142d0e40/images/x86_64/rootfs.cpio.zst
[2]: https://lore.kernel.org/20230207224847.94429-1-Jason@zx2c4.com/

Cheers,
Nathan

# bad: [969d09c3a6186c0a4bc8a41db0c1aba1c76081fc] Merge tag 'pull-aspeed-20230207' of https://github.com/legoater/qemu into staging
# good: [b67b00e6b4c7831a3f5bc684bc0df7a9bfd1bd56] Update VERSION for v7.2.0
git bisect start '969d09c3a6186c0a4bc8a41db0c1aba1c76081fc' 'b67b00e6b4c7831a3f5bc684bc0df7a9bfd1bd56'
# good: [38cb336fe9d47507da5177c3d349532d0af6885e] hw/arm/gumstix: Use the IEC binary prefix definitions
git bisect good 38cb336fe9d47507da5177c3d349532d0af6885e
# bad: [864a3fa439276148b6d7abcf2d43ee8dbe4c4062] monitor: Rename misc.c to hmp-target.c
git bisect bad 864a3fa439276148b6d7abcf2d43ee8dbe4c4062
# good: [e471a8c9850f1af0c1bc5768ca28285348cdd6c5] target/riscv: Trap on writes to stimecmp from VS when hvictl.VTI=1
git bisect good e471a8c9850f1af0c1bc5768ca28285348cdd6c5
# bad: [c1a9ac9bdeea213162a76f7b9e2f876c89a50a94] tests: acpi: cleanup use_uefi argument usage
git bisect bad c1a9ac9bdeea213162a76f7b9e2f876c89a50a94
# good: [dc575b5e0300a7a375b4e4501a17ada21e9a6d10] hw/i2c/bitbang_i2c: Change state calling bitbang_i2c_set_state() helper
git bisect good dc575b5e0300a7a375b4e4501a17ada21e9a6d10
# good: [3b07a936d3bfe97b07ddffcfbb532985a88033dd] target/arm: Look up ARMCPRegInfo at runtime
git bisect good 3b07a936d3bfe97b07ddffcfbb532985a88033dd
# good: [d395b18dce82855d03d934e30a515caf5a10a885] hw/acpi/acpi_dev_interface: Remove unused parameter from AcpiDeviceIfClass::madt_cpu
git bisect good d395b18dce82855d03d934e30a515caf5a10a885
# bad: [eac7a7791bb6d719233deed750034042318ffd56] x86: don't let decompressed kernel image clobber setup_data
git bisect bad eac7a7791bb6d719233deed750034042318ffd56
# good: [8a8c9c3a747f77e664fa2288735b45a9d750be75] hw/pci-host: Use register definitions from PCI standard
git bisect good 8a8c9c3a747f77e664fa2288735b45a9d750be75
# good: [8a7c606016d283a1716290c657f6f45bc7c4d817] intel-iommu: Document iova_tree
git bisect good 8a7c606016d283a1716290c657f6f45bc7c4d817
# first bad commit: [eac7a7791bb6d719233deed750034042318ffd56] x86: don't let decompressed kernel image clobber setup_data
