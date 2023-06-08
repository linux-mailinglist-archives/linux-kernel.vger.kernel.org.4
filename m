Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06275728543
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236144AbjFHQjS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 8 Jun 2023 12:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235213AbjFHQjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:39:04 -0400
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EBA2727
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 09:38:43 -0700 (PDT)
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-784205f0058so310737241.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 09:38:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686242304; x=1688834304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=maYgySw253aQp+1qS+G3fizKuN5LyFWhl5CeH3Pd1Rc=;
        b=cfsJ0vm8LLWvUwwfSbMruvpkpnE8dDQAOFjgtdcDEyHe7kiiOF1WhR4689qNWPxBjH
         6YQUimtrpNAGzTxFmdouROhdNyEs4D6EwCaonPBZkw32P5xJhi70rd4VtYp9zD7A8A20
         Ht6p7iUbyamRWu7F+0cu7LMBhi7zCFUBIGB2v6GZLROQNVJkR4KLaS8y85DPBg6vhHM3
         kYOw0B2DF+AG5t4tMb1UJTZV01wN+TZJHq3j9BoS29uCgnqvDwQ2WEXn04NU7OwVgNzk
         wn3fzj8NJFkW0Q+CmbBgzN1MHsl5rFP2JGQ73rjmHOEK32MqfkYdkzfoPvdJTmDhUuQI
         L0Tw==
X-Gm-Message-State: AC+VfDyZrUPzPaE378trflvWHo/DMwsbATeJ8P+N817QCumPWB+8tlhk
        H/3f38Y4SR/jvSLLxIXLgfY59w+aPP/V1Ujmxcg=
X-Google-Smtp-Source: ACHHUZ5OuS4967TKEwaba2HW4aCd+g3iM/cEQnhv0qE6rpTWD8+Kx3Y4nbhBskp4M2bmvvjQskRJR9egBehwEfbyMAY=
X-Received: by 2002:a67:fb11:0:b0:437:e49d:634a with SMTP id
 d17-20020a67fb11000000b00437e49d634amr1996709vsr.35.1686242302273; Thu, 08
 Jun 2023 09:38:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230605102840.1521549-1-ross.lagerwall@citrix.com>
In-Reply-To: <20230605102840.1521549-1-ross.lagerwall@citrix.com>
Reply-To: konrad@darnok.org
From:   Konrad Rzeszutek Wilk <konrad@darnok.org>
Date:   Thu, 8 Jun 2023 12:38:11 -0400
Message-ID: <CAPbh3rsnBgeZJCvzg3Bh_VRxiYEOe0vgQkpyeyDeCBirBLhLiQ@mail.gmail.com>
Subject: Re: [PATCH v3] iscsi_ibft: Fix finding the iBFT under Xen Dom 0
To:     Ross Lagerwall <ross.lagerwall@citrix.com>
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        Jan Beulich <jbeulich@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Peter Jones <pjones@redhat.com>,
        Konrad Rzeszutek Wilk <konrad@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It looks fine to me, but could I ask you to triple check that on
non-Xen it still detects the iBFT?

Thx!

On Mon, Jun 5, 2023 at 6:28 AM Ross Lagerwall <ross.lagerwall@citrix.com> wrote:
>
> To facilitate diskless iSCSI boot, the firmware can place a table of
> configuration details in memory called the iBFT. The presence of this
> table is not specified, nor is the precise location (and it's not in the
> E820) so the kernel has to search for a magic marker to find it.
>
> When running under Xen, Dom 0 does not have access to the entire host's
> memory, only certain regions which are identity-mapped which means that
> the pseudo-physical address in Dom0 == real host physical address.
> Add the iBFT search bounds as a reserved region which causes it to be
> identity-mapped in xen_set_identity_and_remap_chunk() which allows Dom0
> access to the specific physical memory to correctly search for the iBFT
> magic marker (and later access the full table).
>
> This necessitates moving the call to reserve_ibft_region() somewhat
> later so that it is called after e820__memory_setup() which is when the
> Xen identity mapping adjustments are applied. The precise location of
> the call is not too important so I've put it alongside dmi_setup() which
> does similar scanning of memory for configuration tables.
>
> Finally in the iBFT find code, instead of using isa_bus_to_virt() which
> doesn't do the right thing under Xen, use early_memremap() like the
> dmi_setup() code does.
>
> The result of these changes is that it is possible to boot a diskless
> Xen + Dom0 running off an iSCSI disk whereas previously it would fail to
> find the iBFT and consequently, the iSCSI root disk.
>
> Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
> ---
>
> In v3:
> * Expanded commit message.
> * Used IBFT_ constants.
>
>  arch/x86/kernel/setup.c            |  2 +-
>  arch/x86/xen/setup.c               | 28 +++++++++++++++++++---------
>  drivers/firmware/iscsi_ibft_find.c | 26 +++++++++++++++++---------
>  include/linux/iscsi_ibft.h         | 10 +++++++++-
>  4 files changed, 46 insertions(+), 20 deletions(-)
>
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 16babff771bd..616b80507abd 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -796,7 +796,6 @@ static void __init early_reserve_memory(void)
>
>         memblock_x86_reserve_range_setup_data();
>
> -       reserve_ibft_region();
>         reserve_bios_regions();
>         trim_snb_memory();
>  }
> @@ -1032,6 +1031,7 @@ void __init setup_arch(char **cmdline_p)
>         if (efi_enabled(EFI_BOOT))
>                 efi_init();
>
> +       reserve_ibft_region();
>         dmi_setup();
>
>         /*
> diff --git a/arch/x86/xen/setup.c b/arch/x86/xen/setup.c
> index c2be3efb2ba0..8b5cf7bb1f47 100644
> --- a/arch/x86/xen/setup.c
> +++ b/arch/x86/xen/setup.c
> @@ -6,6 +6,7 @@
>   */
>
>  #include <linux/init.h>
> +#include <linux/iscsi_ibft.h>
>  #include <linux/sched.h>
>  #include <linux/kstrtox.h>
>  #include <linux/mm.h>
> @@ -764,17 +765,26 @@ char * __init xen_memory_setup(void)
>         BUG_ON(memmap.nr_entries == 0);
>         xen_e820_table.nr_entries = memmap.nr_entries;
>
> -       /*
> -        * Xen won't allow a 1:1 mapping to be created to UNUSABLE
> -        * regions, so if we're using the machine memory map leave the
> -        * region as RAM as it is in the pseudo-physical map.
> -        *
> -        * UNUSABLE regions in domUs are not handled and will need
> -        * a patch in the future.
> -        */
> -       if (xen_initial_domain())
> +       if (xen_initial_domain()) {
> +               /*
> +                * Xen won't allow a 1:1 mapping to be created to UNUSABLE
> +                * regions, so if we're using the machine memory map leave the
> +                * region as RAM as it is in the pseudo-physical map.
> +                *
> +                * UNUSABLE regions in domUs are not handled and will need
> +                * a patch in the future.
> +                */
>                 xen_ignore_unusable();
>
> +#ifdef CONFIG_ISCSI_IBFT_FIND
> +               /* Reserve 0.5 MiB to 1 MiB region so iBFT can be found */
> +               xen_e820_table.entries[xen_e820_table.nr_entries].addr = IBFT_START;
> +               xen_e820_table.entries[xen_e820_table.nr_entries].size = IBFT_END - IBFT_START;
> +               xen_e820_table.entries[xen_e820_table.nr_entries].type = E820_TYPE_RESERVED;
> +               xen_e820_table.nr_entries++;
> +#endif
> +       }
> +
>         /* Make sure the Xen-supplied memory map is well-ordered. */
>         e820__update_table(&xen_e820_table);
>
> diff --git a/drivers/firmware/iscsi_ibft_find.c b/drivers/firmware/iscsi_ibft_find.c
> index 94b49ccd23ac..71f51303c2ba 100644
> --- a/drivers/firmware/iscsi_ibft_find.c
> +++ b/drivers/firmware/iscsi_ibft_find.c
> @@ -42,8 +42,6 @@ static const struct {
>  };
>
>  #define IBFT_SIGN_LEN 4
> -#define IBFT_START 0x80000 /* 512kB */
> -#define IBFT_END 0x100000 /* 1MB */
>  #define VGA_MEM 0xA0000 /* VGA buffer */
>  #define VGA_SIZE 0x20000 /* 128kB */
>
> @@ -52,9 +50,9 @@ static const struct {
>   */
>  void __init reserve_ibft_region(void)
>  {
> -       unsigned long pos;
> +       unsigned long pos, virt_pos = 0;
>         unsigned int len = 0;
> -       void *virt;
> +       void *virt = NULL;
>         int i;
>
>         ibft_phys_addr = 0;
> @@ -70,13 +68,20 @@ void __init reserve_ibft_region(void)
>                  * so skip that area */
>                 if (pos == VGA_MEM)
>                         pos += VGA_SIZE;
> -               virt = isa_bus_to_virt(pos);
> +
> +               /* Map page by page */
> +               if (offset_in_page(pos) == 0) {
> +                       if (virt)
> +                               early_memunmap(virt, PAGE_SIZE);
> +                       virt = early_memremap_ro(pos, PAGE_SIZE);
> +                       virt_pos = pos;
> +               }
>
>                 for (i = 0; i < ARRAY_SIZE(ibft_signs); i++) {
> -                       if (memcmp(virt, ibft_signs[i].sign, IBFT_SIGN_LEN) ==
> -                           0) {
> +                       if (memcmp(virt + (pos - virt_pos), ibft_signs[i].sign,
> +                                  IBFT_SIGN_LEN) == 0) {
>                                 unsigned long *addr =
> -                                   (unsigned long *)isa_bus_to_virt(pos + 4);
> +                                   (unsigned long *)(virt + pos - virt_pos + 4);
>                                 len = *addr;
>                                 /* if the length of the table extends past 1M,
>                                  * the table cannot be valid. */
> @@ -84,9 +89,12 @@ void __init reserve_ibft_region(void)
>                                         ibft_phys_addr = pos;
>                                         memblock_reserve(ibft_phys_addr, PAGE_ALIGN(len));
>                                         pr_info("iBFT found at %pa.\n", &ibft_phys_addr);
> -                                       return;
> +                                       goto out;
>                                 }
>                         }
>                 }
>         }
> +
> +out:
> +       early_memunmap(virt, PAGE_SIZE);
>  }
> diff --git a/include/linux/iscsi_ibft.h b/include/linux/iscsi_ibft.h
> index 790e7fcfc1a6..e2742748104d 100644
> --- a/include/linux/iscsi_ibft.h
> +++ b/include/linux/iscsi_ibft.h
> @@ -21,12 +21,20 @@
>   */
>  extern phys_addr_t ibft_phys_addr;
>
> +#ifdef CONFIG_ISCSI_IBFT_FIND
> +
>  /*
>   * Routine used to find and reserve the iSCSI Boot Format Table. The
>   * physical address is set in the ibft_phys_addr variable.
>   */
> -#ifdef CONFIG_ISCSI_IBFT_FIND
>  void reserve_ibft_region(void);
> +
> +/*
> + * Physical bounds to search for the iSCSI Boot Format Table.
> + */
> +#define IBFT_START 0x80000 /* 512kB */
> +#define IBFT_END 0x100000 /* 1MB */
> +
>  #else
>  static inline void reserve_ibft_region(void) {}
>  #endif
> --
> 2.31.1
>
