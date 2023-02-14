Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE97696A2F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 17:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbjBNQr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 11:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjBNQr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 11:47:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBFC2D172
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 08:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676393167;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8OyJN/BcSYiP7KMSzBsYyGWwDmggivd16jpBIpILDug=;
        b=hlhF81phVRVQjiyUgvm6lNsKL0S4jNkAjNkXOQPhGNmmAkO2b6FoqukApPcG72ml0+4Aev
        zv7sWT5P29k/f66K0yrPCYKwQoDhW7nib+y9ycBjNRQu9+smKwt6i5yf4PvgIyPgecYeEx
        tFVeEpXSOVcM761DUbMjkvASL4/eEH4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-oQfVN5AIPH6KRNJCn6GW5Q-1; Tue, 14 Feb 2023 11:46:04 -0500
X-MC-Unique: oQfVN5AIPH6KRNJCn6GW5Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E3809100F901;
        Tue, 14 Feb 2023 16:46:02 +0000 (UTC)
Received: from redhat.com (unknown [10.33.36.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A2F902166B26;
        Tue, 14 Feb 2023 16:45:59 +0000 (UTC)
Date:   Tue, 14 Feb 2023 16:45:57 +0000
From:   Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     qemu-devel@nongnu.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Eric Biggers <ebiggers@kernel.org>,
        Sergio Lopez <slp@redhat.com>,
        Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
        Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH RFC 7/7] Revert "hw/i386: pass RNG seed via setup_data
 entry"
Message-ID: <Y+u6xd9aDmGjm9fg@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20230208211212.41951-1-mst@redhat.com>
 <20230208211212.41951-8-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230208211212.41951-8-mst@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 04:12:56PM -0500, Michael S. Tsirkin wrote:
> This reverts commit 67f7e426e53833a5db75b0d813e8d537b8a75bd2.
> 
> Fixes: 67f7e426e5 ("hw/i386: pass RNG seed via setup_data entry")
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/hw/i386/pc.h  |  3 ---
>  include/hw/i386/x86.h |  3 +--
>  hw/i386/microvm.c     |  2 +-
>  hw/i386/pc.c          |  4 ++--
>  hw/i386/pc_piix.c     |  2 --
>  hw/i386/pc_q35.c      |  2 --
>  hw/i386/x86.c         | 26 ++++----------------------
>  7 files changed, 8 insertions(+), 34 deletions(-)

All the patches prior to this were clean reverts. This one though
does not look clean, rather it looks like reverting a combination
of 3 commits

commit ffe2d2382e5f1aae1abc4081af407905ef380311
Author: Jason A. Donenfeld <Jason@zx2c4.com>
Date:   Wed Sep 21 11:31:34 2022 +0200

    x86: re-enable rng seeding via SetupData

commit 3824e25db1a84fadc50b88dfbe27047aa2f7f85d
Author: Gerd Hoffmann <kraxel@redhat.com>
Date:   Wed Aug 17 10:39:40 2022 +0200

    x86: disable rng seeding via setup_data
    
commit 67f7e426e53833a5db75b0d813e8d537b8a75bd2
Author: Jason A. Donenfeld <Jason@zx2c4.com>
Date:   Thu Jul 21 14:56:36 2022 +0200

    hw/i386: pass RNG seed via setup_data entry
    


though, even taking the individual commits isn't a perfectly
clean revert due to other unrelated changes in machine
type versioning.

I'm not too fussed if this last one isn't a clean revert,
but lets just call out in the commit message that we're
just manually resolving conflicts and skipping those
two intermediate commits for simplicity.

Assuming an improve commit message:

  Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>



> 
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 66e3d059ef..44b08554fa 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -127,9 +127,6 @@ struct PCMachineClass {
>  
>      /* create kvmclock device even when KVM PV features are not exposed */
>      bool kvmclock_create_always;
> -
> -    /* skip passing an rng seed for legacy machines */
> -    bool legacy_no_rng_seed;
>  };
>  
>  #define TYPE_PC_MACHINE "generic-pc-machine"
> diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
> index 62fa5774f8..df82c5fd42 100644
> --- a/include/hw/i386/x86.h
> +++ b/include/hw/i386/x86.h
> @@ -126,8 +126,7 @@ void x86_bios_rom_init(MachineState *ms, const char *default_firmware,
>  void x86_load_linux(X86MachineState *x86ms,
>                      FWCfgState *fw_cfg,
>                      int acpi_data_size,
> -                    bool pvh_enabled,
> -                    bool legacy_no_rng_seed);
> +                    bool pvh_enabled);
>  
>  bool x86_machine_is_smm_enabled(const X86MachineState *x86ms);
>  bool x86_machine_is_acpi_enabled(const X86MachineState *x86ms);
> diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
> index 170a331e3f..b231ceda9a 100644
> --- a/hw/i386/microvm.c
> +++ b/hw/i386/microvm.c
> @@ -330,7 +330,7 @@ static void microvm_memory_init(MicrovmMachineState *mms)
>      rom_set_fw(fw_cfg);
>  
>      if (machine->kernel_filename != NULL) {
> -        x86_load_linux(x86ms, fw_cfg, 0, true, false);
> +        x86_load_linux(x86ms, fw_cfg, 0, true);
>      }
>  
>      if (mms->option_roms) {
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 6e592bd969..2c5f675ba4 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -804,7 +804,7 @@ void xen_load_linux(PCMachineState *pcms)
>      rom_set_fw(fw_cfg);
>  
>      x86_load_linux(x86ms, fw_cfg, pcmc->acpi_data_size,
> -                   pcmc->pvh_enabled, pcmc->legacy_no_rng_seed);
> +                   pcmc->pvh_enabled);
>      for (i = 0; i < nb_option_roms; i++) {
>          assert(!strcmp(option_rom[i].name, "linuxboot.bin") ||
>                 !strcmp(option_rom[i].name, "linuxboot_dma.bin") ||
> @@ -1124,7 +1124,7 @@ void pc_memory_init(PCMachineState *pcms,
>  
>      if (linux_boot) {
>          x86_load_linux(x86ms, fw_cfg, pcmc->acpi_data_size,
> -                       pcmc->pvh_enabled, pcmc->legacy_no_rng_seed);
> +                       pcmc->pvh_enabled);
>      }
>  
>      for (i = 0; i < nb_option_roms; i++) {
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index df64dd8dcc..839bd65df5 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -476,9 +476,7 @@ DEFINE_I440FX_MACHINE(v7_2, "pc-i440fx-7.2", NULL,
>  
>  static void pc_i440fx_7_1_machine_options(MachineClass *m)
>  {
> -    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
>      pc_i440fx_7_2_machine_options(m);
> -    pcmc->legacy_no_rng_seed = true;
>      compat_props_add(m->compat_props, hw_compat_7_1, hw_compat_7_1_len);
>      compat_props_add(m->compat_props, pc_compat_7_1, pc_compat_7_1_len);
>  }
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 66cd718b70..e6e3966262 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -395,9 +395,7 @@ DEFINE_Q35_MACHINE(v7_2, "pc-q35-7.2", NULL,
>  
>  static void pc_q35_7_1_machine_options(MachineClass *m)
>  {
> -    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
>      pc_q35_7_2_machine_options(m);
> -    pcmc->legacy_no_rng_seed = true;
>      compat_props_add(m->compat_props, hw_compat_7_1, hw_compat_7_1_len);
>      compat_props_add(m->compat_props, pc_compat_7_1, pc_compat_7_1_len);
>  }
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index 4831193c86..80be3032cc 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -26,7 +26,6 @@
>  #include "qemu/cutils.h"
>  #include "qemu/units.h"
>  #include "qemu/datadir.h"
> -#include "qemu/guest-random.h"
>  #include "qapi/error.h"
>  #include "qapi/qmp/qerror.h"
>  #include "qapi/qapi-visit-common.h"
> @@ -771,8 +770,7 @@ static bool load_elfboot(const char *kernel_filename,
>  void x86_load_linux(X86MachineState *x86ms,
>                      FWCfgState *fw_cfg,
>                      int acpi_data_size,
> -                    bool pvh_enabled,
> -                    bool legacy_no_rng_seed)
> +                    bool pvh_enabled)
>  {
>      bool linuxboot_dma_enabled = X86_MACHINE_GET_CLASS(x86ms)->fwcfg_dma_enabled;
>      uint16_t protocol;
> @@ -780,7 +778,7 @@ void x86_load_linux(X86MachineState *x86ms,
>      int dtb_size, setup_data_offset;
>      uint32_t initrd_max;
>      uint8_t header[8192], *setup, *kernel;
> -    hwaddr real_addr, prot_addr, cmdline_addr, initrd_addr = 0, first_setup_data = 0;
> +    hwaddr real_addr, prot_addr, cmdline_addr, initrd_addr = 0;
>      FILE *f;
>      char *vmode;
>      MachineState *machine = MACHINE(x86ms);
> @@ -790,7 +788,6 @@ void x86_load_linux(X86MachineState *x86ms,
>      const char *dtb_filename = machine->dtb;
>      const char *kernel_cmdline = machine->kernel_cmdline;
>      SevKernelLoaderContext sev_load_ctx = {};
> -    enum { RNG_SEED_LENGTH = 32 };
>  
>      /* Align to 16 bytes as a paranoia measure */
>      cmdline_size = (strlen(kernel_cmdline) + 16) & ~15;
> @@ -1070,31 +1067,16 @@ void x86_load_linux(X86MachineState *x86ms,
>          kernel_size = setup_data_offset + sizeof(struct setup_data) + dtb_size;
>          kernel = g_realloc(kernel, kernel_size);
>  
> +        stq_p(header + 0x250, prot_addr + setup_data_offset);
>  
>          setup_data = (struct setup_data *)(kernel + setup_data_offset);
> -        setup_data->next = cpu_to_le64(first_setup_data);
> -        first_setup_data = prot_addr + setup_data_offset;
> +        setup_data->next = 0;
>          setup_data->type = cpu_to_le32(SETUP_DTB);
>          setup_data->len = cpu_to_le32(dtb_size);
>  
>          load_image_size(dtb_filename, setup_data->data, dtb_size);
>      }
>  
> -    if (!legacy_no_rng_seed) {
> -        setup_data_offset = QEMU_ALIGN_UP(kernel_size, 16);
> -        kernel_size = setup_data_offset + sizeof(struct setup_data) + RNG_SEED_LENGTH;
> -        kernel = g_realloc(kernel, kernel_size);
> -        setup_data = (struct setup_data *)(kernel + setup_data_offset);
> -        setup_data->next = cpu_to_le64(first_setup_data);
> -        first_setup_data = prot_addr + setup_data_offset;
> -        setup_data->type = cpu_to_le32(SETUP_RNG_SEED);
> -        setup_data->len = cpu_to_le32(RNG_SEED_LENGTH);
> -        qemu_guest_getrandom_nofail(setup_data->data, RNG_SEED_LENGTH);
> -    }
> -
> -    /* Offset 0x250 is a pointer to the first setup_data link. */
> -    stq_p(header + 0x250, first_setup_data);
> -
>      /*
>       * If we're starting an encrypted VM, it will be OVMF based, which uses the
>       * efi stub for booting and doesn't require any values to be placed in the
> -- 
> MST
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

