Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C39A68F6B6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 19:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjBHSOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 13:14:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBHSOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 13:14:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29E620693
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 10:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675880013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oV3LhQWLhZOpmoUA/gu9hDqx3ud2jZxwbGD8NOUQGqQ=;
        b=PdlgtLhXwdlRJVtMoh+PXKT4mx/vyBGIzYYa+t3NVdkhi/Tn5OfRMTQNMngw3i+VVlf1yx
        z/BoKAtb7Vz4EFOAquQtiyyGJmty/EpA/7E3m0gI0Hz/gBmBz02lRmcvGN7VYtn2uLBF32
        tyRoBCdCrOEfpfT37oypQOl/4uwt5C8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-604-YxhGpQJzM82GwYykTSzSxg-1; Wed, 08 Feb 2023 13:13:31 -0500
X-MC-Unique: YxhGpQJzM82GwYykTSzSxg-1
Received: by mail-ej1-f69.google.com with SMTP id i11-20020a1709061ccb00b008aadd9cb12fso1955814ejh.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 10:13:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oV3LhQWLhZOpmoUA/gu9hDqx3ud2jZxwbGD8NOUQGqQ=;
        b=At+KPLH1S/FgEm7V6NAsQ2xHHjmaQt742Z+cICnZcb41faJyh70sHMRGpK2813jhkW
         X3BECgBw7KW09f/qqTHtKL6E89j4m73dsNb1BD9qeS8H/mBbfs4JgR3Q+hwj6a2ddB2N
         vjmj2rTBJ8Tia0V/Mz3y9llXIj5yeNZiZ0gjklCpfEzJ5do96AkVlOWhFpv3HGXiBO9v
         T+hzF8YBxNqZ3oQ1DyAC0oah3gwZAZIiZ73pP5bq/mcTyIQUzgUr/38NeAzoR3IJ6RQW
         VYSxjWDKQ1xk7hA6rjj/R7BOBooz7CeAK3/yTKsR0h9aJNuFPI7WLYQogPkNLYOah7pr
         VYrA==
X-Gm-Message-State: AO0yUKUO1kPH2KRkb7NUfcasmaSyUoWfiFOOF373Yrs22Gq6krT1KIDT
        ihE9cqjCF735pJ5jxLw+qPY0w9gYWlhcJy9RqfSYEorVPJEyQn2mW3G2pHvtQ1Hij1aPZYBdEm5
        GoemSraI6a8xWDVDsSYX4sHCH
X-Received: by 2002:a50:d74e:0:b0:4aa:a0ed:e373 with SMTP id i14-20020a50d74e000000b004aaa0ede373mr8450152edj.7.1675880010290;
        Wed, 08 Feb 2023 10:13:30 -0800 (PST)
X-Google-Smtp-Source: AK7set+/arhac+UYUxiPqq4ZW4JLXty4MWjPbcojQU/KUpY4QUlatlIbnhawTr4frviDTPnY+etMdA==
X-Received: by 2002:a50:d74e:0:b0:4aa:a0ed:e373 with SMTP id i14-20020a50d74e000000b004aaa0ede373mr8450124edj.7.1675880010051;
        Wed, 08 Feb 2023 10:13:30 -0800 (PST)
Received: from redhat.com ([2.52.132.212])
        by smtp.gmail.com with ESMTPSA id p21-20020a50cd95000000b004ab0e9e396bsm1035144edi.87.2023.02.08.10.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 10:13:29 -0800 (PST)
Date:   Wed, 8 Feb 2023 13:13:25 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     qemu-devel@nongnu.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Dov Murik <dovmurik@linux.ibm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH] x86: temporarily remove all attempts to provide
 setup_data
Message-ID: <20230208131125-mutt-send-email-mst@kernel.org>
References: <20230208180835.234638-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230208180835.234638-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 03:08:35PM -0300, Jason A. Donenfeld wrote:
> All attempts at providing setup_data have been made as an iteration on
> whatever was there before, stretching back to the original
> implementation used for DTBs that [mis]used the kernel image itself.
> We've now had a dozen rounds of bugs and hacks, and the result is
> turning into a pile of unmaintainable and increasingly brittle hacks.
> 
> Let's just rip out all the madness and start over. We can re-architect
> this based on having a separate standalone setup_data file, which is how
> it should have been done in the first place. This is a larger project
> with a few things to coordinate, but we can't really begin thinking
> about that while trying to play whack-a-mole with the current buggy
> implementation.
> 
> So this commit removes the setup_data setting from x86_load_linux(),
> while leaving intact the infrastructure we'll need in the future to try
> again.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Dov Murik <dovmurik@linux.ibm.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Daniel P. Berrangé <berrange@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

I think I'll be happier if this is just a revert of
the relevant commits in reverse order to make life easier
for backporters.
Unless that's too much work as we made other changes around
this code?

Failing that list the affected commits so people at least
know what to revert?



> ---
>  hw/i386/microvm.c |  15 ++----
>  hw/i386/x86.c     | 120 +++++-----------------------------------------
>  2 files changed, 17 insertions(+), 118 deletions(-)
> 
> diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
> index 29f30dd6d3..170a331e3f 100644
> --- a/hw/i386/microvm.c
> +++ b/hw/i386/microvm.c
> @@ -378,8 +378,7 @@ static void microvm_fix_kernel_cmdline(MachineState *machine)
>      MicrovmMachineState *mms = MICROVM_MACHINE(machine);
>      BusState *bus;
>      BusChild *kid;
> -    char *cmdline, *existing_cmdline;
> -    size_t len;
> +    char *cmdline;
>  
>      /*
>       * Find MMIO transports with attached devices, and add them to the kernel
> @@ -388,8 +387,7 @@ static void microvm_fix_kernel_cmdline(MachineState *machine)
>       * Yes, this is a hack, but one that heavily improves the UX without
>       * introducing any significant issues.
>       */
> -    existing_cmdline = fw_cfg_read_bytes_ptr(x86ms->fw_cfg, FW_CFG_CMDLINE_DATA);
> -    cmdline = g_strdup(existing_cmdline);
> +    cmdline = g_strdup(machine->kernel_cmdline);
>      bus = sysbus_get_default();
>      QTAILQ_FOREACH(kid, &bus->children, sibling) {
>          DeviceState *dev = kid->child;
> @@ -413,12 +411,9 @@ static void microvm_fix_kernel_cmdline(MachineState *machine)
>          }
>      }
>  
> -    len = strlen(cmdline);
> -    if (len > VIRTIO_CMDLINE_TOTAL_MAX_LEN + strlen(existing_cmdline)) {
> -        fprintf(stderr, "qemu: virtio mmio cmdline too large, skipping\n");
> -    } else {
> -        memcpy(existing_cmdline, cmdline, len + 1);
> -    }
> +    fw_cfg_modify_i32(x86ms->fw_cfg, FW_CFG_CMDLINE_SIZE, strlen(cmdline) + 1);
> +    fw_cfg_modify_string(x86ms->fw_cfg, FW_CFG_CMDLINE_DATA, cmdline);
> +
>      g_free(cmdline);
>  }
>  
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index eaff4227bd..6cfdca9acd 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -50,7 +50,6 @@
>  #include "hw/intc/i8259.h"
>  #include "hw/rtc/mc146818rtc.h"
>  #include "target/i386/sev.h"
> -#include "hw/i386/microvm.h"
>  
>  #include "hw/acpi/cpu_hotplug.h"
>  #include "hw/irq.h"
> @@ -770,30 +769,6 @@ static bool load_elfboot(const char *kernel_filename,
>      return true;
>  }
>  
> -typedef struct SetupDataFixup {
> -    void *pos;
> -    hwaddr orig_val, new_val;
> -    uint32_t addr;
> -} SetupDataFixup;
> -
> -static void fixup_setup_data(void *opaque)
> -{
> -    SetupDataFixup *fixup = opaque;
> -    stq_p(fixup->pos, fixup->new_val);
> -}
> -
> -static void reset_setup_data(void *opaque)
> -{
> -    SetupDataFixup *fixup = opaque;
> -    stq_p(fixup->pos, fixup->orig_val);
> -}
> -
> -static void reset_rng_seed(void *opaque)
> -{
> -    SetupData *setup_data = opaque;
> -    qemu_guest_getrandom_nofail(setup_data->data, le32_to_cpu(setup_data->len));
> -}
> -
>  void x86_load_linux(X86MachineState *x86ms,
>                      FWCfgState *fw_cfg,
>                      int acpi_data_size,
> @@ -803,29 +778,20 @@ void x86_load_linux(X86MachineState *x86ms,
>      bool linuxboot_dma_enabled = X86_MACHINE_GET_CLASS(x86ms)->fwcfg_dma_enabled;
>      uint16_t protocol;
>      int setup_size, kernel_size, cmdline_size;
> -    int dtb_size, setup_data_offset;
>      uint32_t initrd_max;
>      uint8_t header[8192], *setup, *kernel;
> -    hwaddr real_addr, prot_addr, cmdline_addr, initrd_addr = 0, first_setup_data = 0;
> +    hwaddr real_addr, prot_addr, cmdline_addr, initrd_addr = 0;
>      FILE *f;
>      char *vmode;
>      MachineState *machine = MACHINE(x86ms);
> -    SetupData *setup_data;
>      const char *kernel_filename = machine->kernel_filename;
>      const char *initrd_filename = machine->initrd_filename;
> -    const char *dtb_filename = machine->dtb;
> -    char *kernel_cmdline;
> +    const char *kernel_cmdline = machine->kernel_cmdline;
>      SevKernelLoaderContext sev_load_ctx = {};
>      enum { RNG_SEED_LENGTH = 32 };
>  
> -    /*
> -     * Add the NUL terminator, some padding for the microvm cmdline fiddling
> -     * hack, and then align to 16 bytes as a paranoia measure
> -     */
> -    cmdline_size = (strlen(machine->kernel_cmdline) + 1 +
> -                    VIRTIO_CMDLINE_TOTAL_MAX_LEN + 16) & ~15;
> -    /* Make a copy, since we might append arbitrary bytes to it later. */
> -    kernel_cmdline = g_strndup(machine->kernel_cmdline, cmdline_size);
> +    /* Align to 16 bytes as a paranoia measure */
> +    cmdline_size = (strlen(kernel_cmdline) + 16) & ~15;
>  
>      /* load the kernel header */
>      f = fopen(kernel_filename, "rb");
> @@ -966,6 +932,12 @@ void x86_load_linux(X86MachineState *x86ms,
>          initrd_max = x86ms->below_4g_mem_size - acpi_data_size - 1;
>      }
>  
> +    fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_ADDR, cmdline_addr);
> +    fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_SIZE, strlen(kernel_cmdline) + 1);
> +    fw_cfg_add_string(fw_cfg, FW_CFG_CMDLINE_DATA, kernel_cmdline);
> +    sev_load_ctx.cmdline_data = (char *)kernel_cmdline;
> +    sev_load_ctx.cmdline_size = strlen(kernel_cmdline) + 1;
> +
>      if (protocol >= 0x202) {
>          stl_p(header + 0x228, cmdline_addr);
>      } else {
> @@ -1078,81 +1050,13 @@ void x86_load_linux(X86MachineState *x86ms,
>      }
>      fclose(f);
>  
> -    /* append dtb to kernel */
> -    if (dtb_filename) {
> -        if (protocol < 0x209) {
> -            fprintf(stderr, "qemu: Linux kernel too old to load a dtb\n");
> -            exit(1);
> -        }
> -
> -        dtb_size = get_image_size(dtb_filename);
> -        if (dtb_size <= 0) {
> -            fprintf(stderr, "qemu: error reading dtb %s: %s\n",
> -                    dtb_filename, strerror(errno));
> -            exit(1);
> -        }
> -
> -        setup_data_offset = cmdline_size;
> -        cmdline_size += sizeof(SetupData) + dtb_size;
> -        kernel_cmdline = g_realloc(kernel_cmdline, cmdline_size);
> -        setup_data = (void *)kernel_cmdline + setup_data_offset;
> -        setup_data->next = cpu_to_le64(first_setup_data);
> -        first_setup_data = cmdline_addr + setup_data_offset;
> -        setup_data->type = cpu_to_le32(SETUP_DTB);
> -        setup_data->len = cpu_to_le32(dtb_size);
> -        load_image_size(dtb_filename, setup_data->data, dtb_size);
> -    }
> -
> -    if (!legacy_no_rng_seed && protocol >= 0x209) {
> -        setup_data_offset = cmdline_size;
> -        cmdline_size += sizeof(SetupData) + RNG_SEED_LENGTH;
> -        kernel_cmdline = g_realloc(kernel_cmdline, cmdline_size);
> -        setup_data = (void *)kernel_cmdline + setup_data_offset;
> -        setup_data->next = cpu_to_le64(first_setup_data);
> -        first_setup_data = cmdline_addr + setup_data_offset;
> -        setup_data->type = cpu_to_le32(SETUP_RNG_SEED);
> -        setup_data->len = cpu_to_le32(RNG_SEED_LENGTH);
> -        qemu_guest_getrandom_nofail(setup_data->data, RNG_SEED_LENGTH);
> -        qemu_register_reset_nosnapshotload(reset_rng_seed, setup_data);
> -        fw_cfg_add_bytes_callback(fw_cfg, FW_CFG_KERNEL_DATA, reset_rng_seed, NULL,
> -                                  setup_data, kernel, kernel_size, true);
> -    } else {
> -        fw_cfg_add_bytes(fw_cfg, FW_CFG_KERNEL_DATA, kernel, kernel_size);
> -    }
> -
> -    fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_ADDR, cmdline_addr);
> -    fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_SIZE, cmdline_size);
> -    fw_cfg_add_bytes(fw_cfg, FW_CFG_CMDLINE_DATA, kernel_cmdline, cmdline_size);
> -    sev_load_ctx.cmdline_data = (char *)kernel_cmdline;
> -    sev_load_ctx.cmdline_size = cmdline_size;
> -
> +    fw_cfg_add_bytes(fw_cfg, FW_CFG_KERNEL_DATA, kernel, kernel_size);
>      fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ADDR, prot_addr);
>      fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_SIZE, kernel_size);
>      sev_load_ctx.kernel_data = (char *)kernel;
>      sev_load_ctx.kernel_size = kernel_size;
>  
> -    /*
> -     * If we're starting an encrypted VM, it will be OVMF based, which uses the
> -     * efi stub for booting and doesn't require any values to be placed in the
> -     * kernel header.  We therefore don't update the header so the hash of the
> -     * kernel on the other side of the fw_cfg interface matches the hash of the
> -     * file the user passed in.
> -     */
> -    if (!sev_enabled() && first_setup_data) {
> -        SetupDataFixup *fixup = g_malloc(sizeof(*fixup));
> -
> -        memcpy(setup, header, MIN(sizeof(header), setup_size));
> -        /* Offset 0x250 is a pointer to the first setup_data link. */
> -        fixup->pos = setup + 0x250;
> -        fixup->orig_val = ldq_p(fixup->pos);
> -        fixup->new_val = first_setup_data;
> -        fixup->addr = cpu_to_le32(real_addr);
> -        fw_cfg_add_bytes_callback(fw_cfg, FW_CFG_SETUP_ADDR, fixup_setup_data, NULL,
> -                                  fixup, &fixup->addr, sizeof(fixup->addr), true);
> -        qemu_register_reset(reset_setup_data, fixup);
> -    } else {
> -        fw_cfg_add_i32(fw_cfg, FW_CFG_SETUP_ADDR, real_addr);
> -    }
> +    fw_cfg_add_i32(fw_cfg, FW_CFG_SETUP_ADDR, real_addr);
>      fw_cfg_add_i32(fw_cfg, FW_CFG_SETUP_SIZE, setup_size);
>      fw_cfg_add_bytes(fw_cfg, FW_CFG_SETUP_DATA, setup, setup_size);
>      sev_load_ctx.setup_data = (char *)setup;
> -- 
> 2.39.1

