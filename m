Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E86D68F8FE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 21:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbjBHUob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 15:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbjBHUo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 15:44:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE243A596
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 12:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675889003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=emGeiQXQP/2SS79K9e6Eur/OYbfrPfLtjJjY96I7LIg=;
        b=eZSJTv4GqezBvGgAkQsizHxyhpekS28LVnQj3YveF9CioVRKzyA7dIuIKhZyc6y32XSn95
        okCb/sjX+u55Es2of6GW+sIhD0jOnSBogUH9kpFKw16r2cZsK8J4Qnpmo6X7I/Ykr/XlL3
        MqjXNCKGI+QRe8Qa358vfVWcPGGOfP8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-227-6bv6C3_6Nv2MJh-tA5z-kA-1; Wed, 08 Feb 2023 15:43:21 -0500
X-MC-Unique: 6bv6C3_6Nv2MJh-tA5z-kA-1
Received: by mail-ej1-f72.google.com with SMTP id i7-20020a17090685c700b008ab19875638so95753ejy.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 12:43:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=emGeiQXQP/2SS79K9e6Eur/OYbfrPfLtjJjY96I7LIg=;
        b=7p96NqfZv602ZX1frPdWe2YO8oM/FL9YEJehZTi+kpZ+oYMEvTlFNozj/+NDt/3Cio
         TzHZpbn01JHEgOg/nPs+c6JwF0JUZp/2Y1ZujvtSYsPD0QG9ueSMcZryl/TBBNRbHGAi
         EZE3p9DTz4NuSjwZaw6eiVEa1j0Kqxx12cNDbmC1LpKkyXjZ2soaniaEsh8nkLnVf9W1
         i/rENYb8SII7LW33WkEL4dnXHa8fLq5cV3kBGjymEVU0qLIjC1tkKbcfbT+7LgQHtLB3
         099mJKsqVrQbGplrz0irhGkVHW/uMJvp8XQQu9PVceyt96qBSSzDe8pmww4AEms5Xqar
         Rubg==
X-Gm-Message-State: AO0yUKWpaZguud2B3DDQ2GlVTXublcLKxXKAA6fzu3ju9tYXRdiVsySR
        2TKek/DX+O7B2M0TJ0I0sM5RbTCjL8NDsoaLA6dWVTOQM/d34iDFxz199hDWOVcfUzM6bRU8B5F
        O2Ak+uYWLwzSXf4SR62LoVEt3
X-Received: by 2002:a17:907:1dd9:b0:894:ad38:aafb with SMTP id og25-20020a1709071dd900b00894ad38aafbmr9956815ejc.18.1675889000423;
        Wed, 08 Feb 2023 12:43:20 -0800 (PST)
X-Google-Smtp-Source: AK7set8clM0796i+jt6/uEmYq7LdFlC0oaZFY01VpUhsAu5vAIHUtl8O0J9+u+cAHiAtREa97z5rJw==
X-Received: by 2002:a17:907:1dd9:b0:894:ad38:aafb with SMTP id og25-20020a1709071dd900b00894ad38aafbmr9956797ejc.18.1675889000191;
        Wed, 08 Feb 2023 12:43:20 -0800 (PST)
Received: from redhat.com ([2.52.132.212])
        by smtp.gmail.com with ESMTPSA id s13-20020a170906c30d00b0088842b00241sm8717467ejz.114.2023.02.08.12.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 12:43:19 -0800 (PST)
Date:   Wed, 8 Feb 2023 15:43:14 -0500
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
Message-ID: <20230208151813-mutt-send-email-mst@kernel.org>
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

So I think we have:

Fixes: 67f7e426e5 ("hw/i386: pass RNG seed via setup_data entry")
Fixes: eac7a7791b ("x86: don't let decompressed kernel image clobber setup_data")
Fixes: 14b29fea74 ("x86: do not re-randomize RNG seed on snapshot load")
Fixes: cc63374a5a ("x86: re-initialize RNG seed when selecting kernel")
Fixes: 763a2828bf ("x86: reinitialize RNG seed on system reboot")
Fixes: eebb38a563 ("x86: use typedef for SetupData struct")
Fixes: e935b73508 ("x86: return modified setup_data only if read as memory, not as file")



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

