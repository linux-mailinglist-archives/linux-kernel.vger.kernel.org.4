Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21ED172787C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233629AbjFHHPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234578AbjFHHPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:15:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B329E2D40
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 00:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686208425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6MTFgS0bfVH2nGfESAvkTxktVtVLFoyF8Ahx8mYb1cE=;
        b=IYKb6v1igLN2Hmhg2zNA6NxbBMlgGyshA8qRAD6oqq5C19IKP/aeKeLqPM1V9IFDcPYUFg
        Ga8hfl5Fn9x5KCM8+wk6vTrFKofAwDRwLomm7Ai6j35ZSzPOf79nZI0U6JKJY6SKDiOwQw
        0AEpahyJUG3Ah0rhuO0aA2lSJuetuVc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-3NfhtZzyPACyZ2qLWGyQ_g-1; Thu, 08 Jun 2023 03:13:43 -0400
X-MC-Unique: 3NfhtZzyPACyZ2qLWGyQ_g-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9749b806f81so34814366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 00:13:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686208421; x=1688800421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6MTFgS0bfVH2nGfESAvkTxktVtVLFoyF8Ahx8mYb1cE=;
        b=LVNTej0LZ7zTixIETXllbcLkx/rUIxxsTRFafxYZUevc9yakh0OSXKOlOF95WmsAz3
         l+6HcxjViz977ctOOvyu/f0oZ3lEgA0/IEbOMnrjHNMvx6gZLh4FLpcyKFCKQ1Eb2COV
         sCZaixxxq+Zv3DiPxiCRJM0jBKMh9qC8sBz479N0pmZndkdRqithGMkUv6YX0w9cIVHJ
         49qdeZYZyxVtZFps2sy0Mk3zWYTE/pLYostcXI4Jlap1nxz2p117HSl4HFGbELJe/r/A
         tM8vRaoTpAbGByXVMA1SkNjg7oHks8XIuSEt5xyiiz2jWeauaIrvTGDr4RDhbm2LR94O
         qazg==
X-Gm-Message-State: AC+VfDyZNbBJyq1JRtEB3xP3M5OHfRyT9wGhWw4Fh3apSVf+wwE2xriI
        p6VQnwsC91Fw1uV+rguKWjEfIXlnBrXsz4DQhy1itiTebc+3PLFIkrryENTk/TDVxR4ke7lRHtN
        DkOhn1qk6okynoRFG1tnZslp1/39ZAWJgeJrNm+RN2MyF+nngoqDAVA==
X-Received: by 2002:a17:907:1c9e:b0:974:20bd:6e15 with SMTP id nb30-20020a1709071c9e00b0097420bd6e15mr10496110ejc.4.1686208421464;
        Thu, 08 Jun 2023 00:13:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5jNDz31rw69C6omnMTTnOHrlFLU3xY6l5ZLTlMK0yMtwTDQjWyUHEoaHnIzRr2/PF3ne/dqyv5G8R9NvxRM3U=
X-Received: by 2002:a17:907:1c9e:b0:974:20bd:6e15 with SMTP id
 nb30-20020a1709071c9e00b0097420bd6e15mr10496087ejc.4.1686208421105; Thu, 08
 Jun 2023 00:13:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230601072043.24439-1-ltao@redhat.com> <ZHhTDXpPqFL+3m5h@MiWiFi-R3L-srv>
 <CAO7dBbVXD+3tq_iQMKtX+Vw7csPfzPJdOWVduMENyO6i7p0b0w@mail.gmail.com>
In-Reply-To: <CAO7dBbVXD+3tq_iQMKtX+Vw7csPfzPJdOWVduMENyO6i7p0b0w@mail.gmail.com>
From:   Tao Liu <ltao@redhat.com>
Date:   Thu, 8 Jun 2023 15:13:04 +0800
Message-ID: <CAO7dBbVjD=2=2bqV5LP7PQqDRnw1sfLb-+=6255Gf_6vEx=Zcg@mail.gmail.com>
Subject: Re: [PATCH v2] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
To:     tglx@linutronix.de, Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        hpa@zytor.com, ardb@kernel.org
Cc:     linux-kernel@vger.kernel.org, dyoung@redhat.com,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        Baoquan He <bhe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello maintainers,

Sorry to interrupt. Currently I'm holding a machine which can be used
to reproduce the original issue and test the patch. However I may need
to return the machine in a short time. So if any updating and testing
needed for patch v3, please let me know. Thanks in advance!

Thanks,
Tao Liu

On Thu, Jun 1, 2023 at 4:25=E2=80=AFPM Tao Liu <ltao@redhat.com> wrote:
>
> Hi Baoquan,
>
> On Thu, Jun 1, 2023 at 4:13=E2=80=AFPM Baoquan He <bhe@redhat.com> wrote:
> >
> > On 06/01/23 at 03:20pm, Tao Liu wrote:
> > > A kexec kernel bootup hang is observed on Intel Atom cpu due to unmap=
ped
> > > EFI config table.
> > >
> > > Currently EFI system table is identity-mapped for the kexec kernel, b=
ut EFI
> > > config table is not mapped explicitly:
> > >
> > >     commit 6bbeb276b71f ("x86/kexec: Add the EFI system tables and AC=
PI
> > >                           tables to the ident map")
> > >
> > > Later in the following 2 commits, EFI config table will be accessed w=
hen
> > > enabling sev at kernel startup. This may result in a page fault due t=
o EFI
> > > config table's unmapped address. Since the page fault occurs at an ea=
rly
> > > stage, it is unrecoverable and kernel hangs.
> > >
> > >     commit ec1c66af3a30 ("x86/compressed/64: Detect/setup SEV/SME fea=
tures
> > >                           earlier during boot")
> > >     commit c01fce9cef84 ("x86/compressed: Add SEV-SNP feature
> > >                           detection/setup")
> > >
> > > In addition, the issue doesn't appear on all systems, because the kex=
ec
> > > kernel uses Page Size Extension (PSE) for identity mapping. In most c=
ases,
> > > EFI config table can end up to be mapped into due to 1 GB page size.
> > > However if nogbpages is set, or cpu doesn't support pdpe1gb feature
> > > (e.g Intel Atom x6425RE cpu), EFI config table may not be mapped into
> > > due to 2 MB page size, thus a page fault hang is more likely to happe=
n.
> > >
> > > This patch will make sure the EFI config table is always mapped.
> > >
> > > Signed-off-by: Tao Liu <ltao@redhat.com>
> > > ---
> > > Changes in v2:
> > > - Rephrase the change log based on Baoquan's suggestion.
> > > - Rename map_efi_sys_cfg_tab() to map_efi_tables().
> > > - Link to v1: https://lore.kernel.org/kexec/20230525094914.23420-1-lt=
ao@redhat.com/
> > > ---
> > >  arch/x86/kernel/machine_kexec_64.c | 35 ++++++++++++++++++++++++++--=
--
> > >  1 file changed, 31 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/mac=
hine_kexec_64.c
> > > index 1a3e2c05a8a5..664aefa6e896 100644
> > > --- a/arch/x86/kernel/machine_kexec_64.c
> > > +++ b/arch/x86/kernel/machine_kexec_64.c
> > > @@ -28,6 +28,7 @@
> > >  #include <asm/setup.h>
> > >  #include <asm/set_memory.h>
> > >  #include <asm/cpu.h>
> > > +#include <asm/efi.h>
> > >
> > >  #ifdef CONFIG_ACPI
> > >  /*
> > > @@ -86,10 +87,12 @@ const struct kexec_file_ops * const kexec_file_lo=
aders[] =3D {
> > >  #endif
> > >
> > >  static int
> > > -map_efi_systab(struct x86_mapping_info *info, pgd_t *level4p)
> > > +map_efi_tables(struct x86_mapping_info *info, pgd_t *level4p)
> > >  {
> > >  #ifdef CONFIG_EFI
> > >       unsigned long mstart, mend;
> > > +     void *kaddr;
> > > +     int ret;
> > >
> > >       if (!efi_enabled(EFI_BOOT))
> > >               return 0;
> > > @@ -105,6 +108,30 @@ map_efi_systab(struct x86_mapping_info *info, pg=
d_t *level4p)
> > >       if (!mstart)
> > >               return 0;
> > >
> > > +     ret =3D kernel_ident_mapping_init(info, level4p, mstart, mend);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     kaddr =3D memremap(mstart, mend - mstart, MEMREMAP_WB);
> > > +     if (!kaddr) {
> > > +             pr_err("Could not map UEFI system table\n");
> > > +             return -ENOMEM;
> > > +     }
> > > +
> > > +     mstart =3D efi_config_table;
> > > +
> > > +     if (efi_enabled(EFI_64BIT)) {
> > > +             efi_system_table_64_t *stbl =3D (efi_system_table_64_t =
*)kaddr;
> > > +
> > > +             mend =3D mstart + sizeof(efi_config_table_64_t) * stbl-=
>nr_tables;
> > > +     } else {
> > > +             efi_system_table_32_t *stbl =3D (efi_system_table_32_t =
*)kaddr;
> > > +
> > > +             mend =3D mstart + sizeof(efi_config_table_32_t) * stbl-=
>nr_tables;
> > > +     }
> > > +
> > > +     memunmap(kaddr);
> > > +
> > >       return kernel_ident_mapping_init(info, level4p, mstart, mend);
> > >  #endif
> > >       return 0;
> > > @@ -244,10 +271,10 @@ static int init_pgtable(struct kimage *image, u=
nsigned long start_pgtable)
> > >       }
> > >
> > >       /*
> > > -      * Prepare EFI systab and ACPI tables for kexec kernel since th=
ey are
> > > -      * not covered by pfn_mapped.
> > > +      * Prepare EFI systab, config table and ACPI tables for kexec k=
ernel
> >
> > The code comment need be updated too?
> >
> >          * Prepare EFI tables and ACPI tables for kexec kernel since th=
ey are
> >          * not covered by pfn_mapped.
> >
> > Other than this nit, this patch looks good to me, thanks.
> >
>
> Thanks for the patch review! I'm OK with the comment update, but I
> prefer to leave it as it is. Since the comment provides more details:
> there are systab and config tables mapped instead of all efi tables.
>
> Thanks,
> Tao Liu
>
> > Acked-by: Baoquan He <bhe@redhat.com>
> >
> >
> > > +      * since they are not covered by pfn_mapped.
> > >        */
> > > -     result =3D map_efi_systab(&info, level4p);
> > > +     result =3D map_efi_tables(&info, level4p);
> > >       if (result)
> > >               return result;
> > >
> > > --
> > > 2.33.1
> > >
> >

