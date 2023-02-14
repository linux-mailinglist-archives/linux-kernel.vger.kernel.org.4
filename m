Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E32696C41
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 19:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbjBNSEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 13:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbjBNSEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 13:04:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F286728E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 10:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676397791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pk+rybXC93Z4eTHXgf/csi8RxyrYRV6ya5SlO3fQzmA=;
        b=a9Zm/OdfKZqcKkxsC3L/Xd9j0svaZYiEy4nqkIbNdvU1xikxcxha8jNOyX87uX2BXfnygX
        wlK9SpH9sE2IVQ+Wu2cycGYO+Z/HhK5aR26P+sKFEZUry2xY9/yd+BZsUeCFjqHPpNHkpA
        zatW0SeCZLHp3efqZwC3l9gWMbWwTfo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-172-wOhgV4PHOt2Q-cAOutFJFg-1; Tue, 14 Feb 2023 13:03:09 -0500
X-MC-Unique: wOhgV4PHOt2Q-cAOutFJFg-1
Received: by mail-wm1-f70.google.com with SMTP id p14-20020a05600c468e00b003e0107732f4so8132849wmo.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 10:03:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pk+rybXC93Z4eTHXgf/csi8RxyrYRV6ya5SlO3fQzmA=;
        b=M1Pz8Q4eFBYt8EuJmIXc56kQdrJE/AeJ5GpJ5LjWtWIzfXcN+gWzDYh7nCwHPX1s2m
         HSZrdci9iIk+cChI8947gL4vfsr58NESZlmjs1oX11oJS1nQpO8yGLufrAvEVedM2Xz5
         llAeLu0J05No8w/GtMOqvoed5ZRWjF6UImhiiSCJHodANaLMxH6GWZju4G0AtrsYLMXE
         LfJgSrKXxkgCCpR5iGpaf6bLH2dsWIz8WhHSIOtXwgBGEWDACp9wYWjiML4kkwmLGCI+
         VAOWOxn3p9BbFKd2/mNkKerOmW/eJS9HbfMcPojZ4kscP5HDi7hwh4qsao1tbJAwtWa6
         i2CA==
X-Gm-Message-State: AO0yUKXVrKghFl1VdEOHFiHFf9t/DPT8PEcmYTgOSSeTHkxK86kLfCdy
        LKkmQW5iSLKOKcT06vZg7CPphLqvpLZazEPYV75B2C35RmnxiPm2GrPqDiC7Q3cjBuybXogd0yg
        BLIWB8ua0DqkpX7M0D9ytBoBs
X-Received: by 2002:a05:600c:13ca:b0:3df:50eb:7cd9 with SMTP id e10-20020a05600c13ca00b003df50eb7cd9mr2721685wmg.14.1676397788257;
        Tue, 14 Feb 2023 10:03:08 -0800 (PST)
X-Google-Smtp-Source: AK7set+g9ZtYe0bFWSxYlBT5onmt+0Hx0JIN2jW9+Y+vVPbuv7kIA8P4HTm9CQolr8Icsyxscr15RA==
X-Received: by 2002:a05:600c:13ca:b0:3df:50eb:7cd9 with SMTP id e10-20020a05600c13ca00b003df50eb7cd9mr2721653wmg.14.1676397787873;
        Tue, 14 Feb 2023 10:03:07 -0800 (PST)
Received: from redhat.com ([2.52.5.34])
        by smtp.gmail.com with ESMTPSA id a3-20020a05600c224300b003db01178b62sm20985367wmm.40.2023.02.14.10.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 10:03:06 -0800 (PST)
Date:   Tue, 14 Feb 2023 13:03:02 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc:     qemu-devel@nongnu.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Eric Biggers <ebiggers@kernel.org>,
        Sergio Lopez <slp@redhat.com>,
        Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
        Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH RFC 7/7] Revert "hw/i386: pass RNG seed via setup_data
 entry"
Message-ID: <20230214124923-mutt-send-email-mst@kernel.org>
References: <20230208211212.41951-1-mst@redhat.com>
 <20230208211212.41951-8-mst@redhat.com>
 <Y+u6xd9aDmGjm9fg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y+u6xd9aDmGjm9fg@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 04:45:57PM +0000, Daniel P. Berrangé wrote:
> On Wed, Feb 08, 2023 at 04:12:56PM -0500, Michael S. Tsirkin wrote:
> > This reverts commit 67f7e426e53833a5db75b0d813e8d537b8a75bd2.
> > 
> > Fixes: 67f7e426e5 ("hw/i386: pass RNG seed via setup_data entry")
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  include/hw/i386/pc.h  |  3 ---
> >  include/hw/i386/x86.h |  3 +--
> >  hw/i386/microvm.c     |  2 +-
> >  hw/i386/pc.c          |  4 ++--
> >  hw/i386/pc_piix.c     |  2 --
> >  hw/i386/pc_q35.c      |  2 --
> >  hw/i386/x86.c         | 26 ++++----------------------
> >  7 files changed, 8 insertions(+), 34 deletions(-)
> 
> All the patches prior to this were clean reverts. This one though
> does not look clean, rather it looks like reverting a combination
> of 3 commits
> 
> commit ffe2d2382e5f1aae1abc4081af407905ef380311
> Author: Jason A. Donenfeld <Jason@zx2c4.com>
> Date:   Wed Sep 21 11:31:34 2022 +0200
> 
>     x86: re-enable rng seeding via SetupData
> 
> commit 3824e25db1a84fadc50b88dfbe27047aa2f7f85d
> Author: Gerd Hoffmann <kraxel@redhat.com>
> Date:   Wed Aug 17 10:39:40 2022 +0200
> 
>     x86: disable rng seeding via setup_data
>     
> commit 67f7e426e53833a5db75b0d813e8d537b8a75bd2
> Author: Jason A. Donenfeld <Jason@zx2c4.com>
> Date:   Thu Jul 21 14:56:36 2022 +0200
> 
>     hw/i386: pass RNG seed via setup_data entry
>     
> 
> 
> though, even taking the individual commits isn't a perfectly
> clean revert due to other unrelated changes in machine
> type versioning.
> 
> I'm not too fussed if this last one isn't a clean revert,
> but lets just call out in the commit message that we're
> just manually resolving conflicts and skipping those
> two intermediate commits for simplicity.
> 
> Assuming an improve commit message:
> 
>   Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

Yes - what I did as part of revert is drop all mentions of
legacy_no_rng_seed manually.
I will clarify that, thanks!

> 
> 
> > 
> > diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> > index 66e3d059ef..44b08554fa 100644
> > --- a/include/hw/i386/pc.h
> > +++ b/include/hw/i386/pc.h
> > @@ -127,9 +127,6 @@ struct PCMachineClass {
> >  
> >      /* create kvmclock device even when KVM PV features are not exposed */
> >      bool kvmclock_create_always;
> > -
> > -    /* skip passing an rng seed for legacy machines */
> > -    bool legacy_no_rng_seed;
> >  };
> >  
> >  #define TYPE_PC_MACHINE "generic-pc-machine"
> > diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
> > index 62fa5774f8..df82c5fd42 100644
> > --- a/include/hw/i386/x86.h
> > +++ b/include/hw/i386/x86.h
> > @@ -126,8 +126,7 @@ void x86_bios_rom_init(MachineState *ms, const char *default_firmware,
> >  void x86_load_linux(X86MachineState *x86ms,
> >                      FWCfgState *fw_cfg,
> >                      int acpi_data_size,
> > -                    bool pvh_enabled,
> > -                    bool legacy_no_rng_seed);
> > +                    bool pvh_enabled);
> >  
> >  bool x86_machine_is_smm_enabled(const X86MachineState *x86ms);
> >  bool x86_machine_is_acpi_enabled(const X86MachineState *x86ms);
> > diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
> > index 170a331e3f..b231ceda9a 100644
> > --- a/hw/i386/microvm.c
> > +++ b/hw/i386/microvm.c
> > @@ -330,7 +330,7 @@ static void microvm_memory_init(MicrovmMachineState *mms)
> >      rom_set_fw(fw_cfg);
> >  
> >      if (machine->kernel_filename != NULL) {
> > -        x86_load_linux(x86ms, fw_cfg, 0, true, false);
> > +        x86_load_linux(x86ms, fw_cfg, 0, true);
> >      }
> >  
> >      if (mms->option_roms) {
> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > index 6e592bd969..2c5f675ba4 100644
> > --- a/hw/i386/pc.c
> > +++ b/hw/i386/pc.c
> > @@ -804,7 +804,7 @@ void xen_load_linux(PCMachineState *pcms)
> >      rom_set_fw(fw_cfg);
> >  
> >      x86_load_linux(x86ms, fw_cfg, pcmc->acpi_data_size,
> > -                   pcmc->pvh_enabled, pcmc->legacy_no_rng_seed);
> > +                   pcmc->pvh_enabled);
> >      for (i = 0; i < nb_option_roms; i++) {
> >          assert(!strcmp(option_rom[i].name, "linuxboot.bin") ||
> >                 !strcmp(option_rom[i].name, "linuxboot_dma.bin") ||
> > @@ -1124,7 +1124,7 @@ void pc_memory_init(PCMachineState *pcms,
> >  
> >      if (linux_boot) {
> >          x86_load_linux(x86ms, fw_cfg, pcmc->acpi_data_size,
> > -                       pcmc->pvh_enabled, pcmc->legacy_no_rng_seed);
> > +                       pcmc->pvh_enabled);
> >      }
> >  
> >      for (i = 0; i < nb_option_roms; i++) {
> > diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> > index df64dd8dcc..839bd65df5 100644
> > --- a/hw/i386/pc_piix.c
> > +++ b/hw/i386/pc_piix.c
> > @@ -476,9 +476,7 @@ DEFINE_I440FX_MACHINE(v7_2, "pc-i440fx-7.2", NULL,
> >  
> >  static void pc_i440fx_7_1_machine_options(MachineClass *m)
> >  {
> > -    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
> >      pc_i440fx_7_2_machine_options(m);
> > -    pcmc->legacy_no_rng_seed = true;
> >      compat_props_add(m->compat_props, hw_compat_7_1, hw_compat_7_1_len);
> >      compat_props_add(m->compat_props, pc_compat_7_1, pc_compat_7_1_len);
> >  }
> > diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> > index 66cd718b70..e6e3966262 100644
> > --- a/hw/i386/pc_q35.c
> > +++ b/hw/i386/pc_q35.c
> > @@ -395,9 +395,7 @@ DEFINE_Q35_MACHINE(v7_2, "pc-q35-7.2", NULL,
> >  
> >  static void pc_q35_7_1_machine_options(MachineClass *m)
> >  {
> > -    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
> >      pc_q35_7_2_machine_options(m);
> > -    pcmc->legacy_no_rng_seed = true;
> >      compat_props_add(m->compat_props, hw_compat_7_1, hw_compat_7_1_len);
> >      compat_props_add(m->compat_props, pc_compat_7_1, pc_compat_7_1_len);
> >  }
> > diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> > index 4831193c86..80be3032cc 100644
> > --- a/hw/i386/x86.c
> > +++ b/hw/i386/x86.c
> > @@ -26,7 +26,6 @@
> >  #include "qemu/cutils.h"
> >  #include "qemu/units.h"
> >  #include "qemu/datadir.h"
> > -#include "qemu/guest-random.h"
> >  #include "qapi/error.h"
> >  #include "qapi/qmp/qerror.h"
> >  #include "qapi/qapi-visit-common.h"
> > @@ -771,8 +770,7 @@ static bool load_elfboot(const char *kernel_filename,
> >  void x86_load_linux(X86MachineState *x86ms,
> >                      FWCfgState *fw_cfg,
> >                      int acpi_data_size,
> > -                    bool pvh_enabled,
> > -                    bool legacy_no_rng_seed)
> > +                    bool pvh_enabled)
> >  {
> >      bool linuxboot_dma_enabled = X86_MACHINE_GET_CLASS(x86ms)->fwcfg_dma_enabled;
> >      uint16_t protocol;
> > @@ -780,7 +778,7 @@ void x86_load_linux(X86MachineState *x86ms,
> >      int dtb_size, setup_data_offset;
> >      uint32_t initrd_max;
> >      uint8_t header[8192], *setup, *kernel;
> > -    hwaddr real_addr, prot_addr, cmdline_addr, initrd_addr = 0, first_setup_data = 0;
> > +    hwaddr real_addr, prot_addr, cmdline_addr, initrd_addr = 0;
> >      FILE *f;
> >      char *vmode;
> >      MachineState *machine = MACHINE(x86ms);
> > @@ -790,7 +788,6 @@ void x86_load_linux(X86MachineState *x86ms,
> >      const char *dtb_filename = machine->dtb;
> >      const char *kernel_cmdline = machine->kernel_cmdline;
> >      SevKernelLoaderContext sev_load_ctx = {};
> > -    enum { RNG_SEED_LENGTH = 32 };
> >  
> >      /* Align to 16 bytes as a paranoia measure */
> >      cmdline_size = (strlen(kernel_cmdline) + 16) & ~15;
> > @@ -1070,31 +1067,16 @@ void x86_load_linux(X86MachineState *x86ms,
> >          kernel_size = setup_data_offset + sizeof(struct setup_data) + dtb_size;
> >          kernel = g_realloc(kernel, kernel_size);
> >  
> > +        stq_p(header + 0x250, prot_addr + setup_data_offset);
> >  
> >          setup_data = (struct setup_data *)(kernel + setup_data_offset);
> > -        setup_data->next = cpu_to_le64(first_setup_data);
> > -        first_setup_data = prot_addr + setup_data_offset;
> > +        setup_data->next = 0;
> >          setup_data->type = cpu_to_le32(SETUP_DTB);
> >          setup_data->len = cpu_to_le32(dtb_size);
> >  
> >          load_image_size(dtb_filename, setup_data->data, dtb_size);
> >      }
> >  
> > -    if (!legacy_no_rng_seed) {
> > -        setup_data_offset = QEMU_ALIGN_UP(kernel_size, 16);
> > -        kernel_size = setup_data_offset + sizeof(struct setup_data) + RNG_SEED_LENGTH;
> > -        kernel = g_realloc(kernel, kernel_size);
> > -        setup_data = (struct setup_data *)(kernel + setup_data_offset);
> > -        setup_data->next = cpu_to_le64(first_setup_data);
> > -        first_setup_data = prot_addr + setup_data_offset;
> > -        setup_data->type = cpu_to_le32(SETUP_RNG_SEED);
> > -        setup_data->len = cpu_to_le32(RNG_SEED_LENGTH);
> > -        qemu_guest_getrandom_nofail(setup_data->data, RNG_SEED_LENGTH);
> > -    }
> > -
> > -    /* Offset 0x250 is a pointer to the first setup_data link. */
> > -    stq_p(header + 0x250, first_setup_data);
> > -
> >      /*
> >       * If we're starting an encrypted VM, it will be OVMF based, which uses the
> >       * efi stub for booting and doesn't require any values to be placed in the
> > -- 
> > MST
> > 
> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

