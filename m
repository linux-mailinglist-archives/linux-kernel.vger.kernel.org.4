Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139146C33AD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 15:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjCUOF6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 Mar 2023 10:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbjCUOFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 10:05:43 -0400
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909424FF0E;
        Tue, 21 Mar 2023 07:05:14 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id y4so60198566edo.2;
        Tue, 21 Mar 2023 07:05:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679407510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=haBPYj/XDzU0eh284RB5Ofq6oaj5HEMamthlq2TXC24=;
        b=3nPZt0McyJURO2FVcoaahvLVsLx1M94hGMcZk2YVwW/65ieL9F/cXIVALUqqzfo7q4
         7IeJ7AaBqsnJSyYo1bwNt6PihCafwjvHu/4eoUOibN1z70sNqn4M9AGRVjtb3HctS7yE
         Pg2hLDJIcKmnMaNg/APggq0efLdHLVTQRK4OhmfrINPZJb6FBQJ2fmAkahxisT2d/Ea2
         NYZ7Kr9jU+5UWVyV7dn4M7FkuTIlrEMge0SY/4+QWkxzenfp3CiprjULcOGIqnvaUgh4
         leBlheYn0ZwJ42HQnP7/Slu9oeiX0HlCoyRAr09xIYWx9m/wMBrJGg6D0QnexeKXnoSi
         3vhQ==
X-Gm-Message-State: AO0yUKVwDhPuoByF3R5rdcBC9+LXPjsy2ZLWzxiToprPK8fxin8+Prlb
        uzStAIXKuehrZ5QYXNLIJziPBIpoQnLlkcWVi4E=
X-Google-Smtp-Source: AK7set/4Zz6ut7/h8w7nzIGz5caU0PYESQW7O7xQDY0ROd3s/dX3cmcW4UqA9dxlhc4jvY/zE/BzH6OwM3gLCg+5dBM=
X-Received: by 2002:a50:bac7:0:b0:4fb:f19:87f with SMTP id x65-20020a50bac7000000b004fb0f19087fmr1778235ede.3.1679407510501;
 Tue, 21 Mar 2023 07:05:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230316164257.42590-1-roger.pau@citrix.com> <CAJZ5v0jskeE8nJt04vyEkDO3rOwOHp36mcKcV=L9LGXD0HL6Mw@mail.gmail.com>
 <ZBm42pgVCvsv6dzK@Air-de-Roger>
In-Reply-To: <ZBm42pgVCvsv6dzK@Air-de-Roger>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 21 Mar 2023 15:04:59 +0100
Message-ID: <CAJZ5v0hy0DeOp7YPerhbn26Vxpk=uhfE5YcmRLquWk5Hw9Kyzg@mail.gmail.com>
Subject: Re: [PATCH v4] acpi/processor: fix evaluating _PDC method when
 running as Xen dom0
To:     =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        josef@oderland.se, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Len Brown <lenb@kernel.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Alex Chiang <achiang@hp.com>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 3:02 PM Roger Pau Monné <roger.pau@citrix.com> wrote:
>
> On Tue, Mar 21, 2023 at 02:47:46PM +0100, Rafael J. Wysocki wrote:
> > On Thu, Mar 16, 2023 at 5:43 PM Roger Pau Monne <roger.pau@citrix.com> wrote:
> > >
> > > In ACPI systems, the OS can direct power management, as opposed to the
> > > firmware.  This OS-directed Power Management is called OSPM.  Part of
> > > telling the firmware that the OS going to direct power management is
> > > making ACPI "_PDC" (Processor Driver Capabilities) calls.  These _PDC
> > > methods must be evaluated for every processor object.  If these _PDC
> > > calls are not completed for every processor it can lead to
> > > inconsistency and later failures in things like the CPU frequency
> > > driver.
> > >
> > > In a Xen system, the dom0 kernel is responsible for system-wide power
> > > management.  The dom0 kernel is in charge of OSPM.  However, the
> > > number of CPUs available to dom0 can be different than the number of
> > > CPUs physically present on the system.
> > >
> > > This leads to a problem: the dom0 kernel needs to evaluate _PDC for
> > > all the processors, but it can't always see them.
> > >
> > > In dom0 kernels, ignore the existing ACPI method for determining if a
> > > processor is physically present because it might not be accurate.
> > > Instead, ask the hypervisor for this information.
> > >
> > > Fix this by introducing a custom function to use when running as Xen
> > > dom0 in order to check whether a processor object matches a CPU that's
> > > online.  Such checking is done using the existing information fetched
> > > by the Xen pCPU subsystem, extending it to also store the ACPI ID.
> > >
> > > This ensures that _PDC method gets evaluated for all physically online
> > > CPUs, regardless of the number of CPUs made available to dom0.
> > >
> > > Fixes: 5d554a7bb064 ('ACPI: processor: add internal processor_physically_present()')
> > > Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> > > ---
> > > Changes since v3:
> > >  - Protect xen_processor_present() definition with CONFIG_ACPI.
> > >
> > > Changes since v2:
> > >  - Extend and use the existing pcpu functionality.
> > >
> > > Changes since v1:
> > >  - Reword commit message.
> > > ---
> > >  arch/x86/include/asm/xen/hypervisor.h | 10 ++++++++++
> > >  drivers/acpi/processor_pdc.c          | 11 +++++++++++
> > >  drivers/xen/pcpu.c                    | 21 +++++++++++++++++++++
> > >  3 files changed, 42 insertions(+)
> > >
> > > diff --git a/arch/x86/include/asm/xen/hypervisor.h b/arch/x86/include/asm/xen/hypervisor.h
> > > index 5fc35f889cd1..990a1609677e 100644
> > > --- a/arch/x86/include/asm/xen/hypervisor.h
> > > +++ b/arch/x86/include/asm/xen/hypervisor.h
> > > @@ -63,4 +63,14 @@ void __init xen_pvh_init(struct boot_params *boot_params);
> > >  void __init mem_map_via_hcall(struct boot_params *boot_params_p);
> > >  #endif
> > >
> > > +#if defined(CONFIG_XEN_DOM0) && defined(CONFIG_ACPI)
> > > +bool __init xen_processor_present(uint32_t acpi_id);
> > > +#else
> > > +static inline bool xen_processor_present(uint32_t acpi_id)
> > > +{
> > > +       BUG();
> > > +       return false;
> > > +}
> > > +#endif
> > > +
> > >  #endif /* _ASM_X86_XEN_HYPERVISOR_H */
> > > diff --git a/drivers/acpi/processor_pdc.c b/drivers/acpi/processor_pdc.c
> > > index 8c3f82c9fff3..18fb04523f93 100644
> > > --- a/drivers/acpi/processor_pdc.c
> > > +++ b/drivers/acpi/processor_pdc.c
> > > @@ -14,6 +14,8 @@
> > >  #include <linux/acpi.h>
> > >  #include <acpi/processor.h>
> > >
> > > +#include <xen/xen.h>
> >
> > This along with the definition above is evidently insufficient for
> > xen_processor_present() to always be defined.  See
> > https://lore.kernel.org/linux-acpi/64198b60.bO+m9o5w+Hd8hcF3%25lkp@intel.com/T/#u
> > for example.
> >
> > I'm dropping the patch now, please fix and resend.
>
> Hello,
>
> Sorry.  I've sent a followup fix:
>
> https://lore.kernel.org/xen-devel/20230321112522.46806-1-roger.pau@citrix.com/T/#u
>
> Would you be fine with taking such followup, or would rather prefer
> for me to send the original fixed patch as v5?

Please fold the fix into the original patch and resend.
