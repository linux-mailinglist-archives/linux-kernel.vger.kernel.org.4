Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5461D62B78B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbiKPKR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:17:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbiKPKRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:17:12 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2010BB489;
        Wed, 16 Nov 2022 02:17:11 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id p8so28733384lfu.11;
        Wed, 16 Nov 2022 02:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z54lkZe3bQ/PhyhfV3DmxnA1bQoJasraIDSUiodRqqU=;
        b=Q9RdCaP9Lcy0bUJ3bUq2sAkw6BoDo0oLGY0o5F3Lopojj16jAU8y+2Fral6T4nm4se
         vmfLsuIPUcw0pbo1e23+SJ+at/gf5rCqFZo5iDEEyKQvjsLEBXrcRMzxmQHHl5pVIcEf
         y6Ms6DugmsIcZh2yp4g3WemkaqbnpmhOS40fisevIIaTedu3oj0Xh8chMiPHSt2d6R/z
         wzLLQFrDLPvlW7Y7rjMTb5XxbbXDMQE8qODAGekUm6osxKYPglbAdO93ia3DkfxDoN9l
         e9QjY22W39ic8B58JU6qFPzWtgqXyIjuNDr1GbC54YC12L4FXKG5vM2o4iMtIqxqboJY
         SVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z54lkZe3bQ/PhyhfV3DmxnA1bQoJasraIDSUiodRqqU=;
        b=NbKqgwMBCkdiVNA35McOsIVdHTjKXXgwAoZfJVojNQyqbrS62xha7CLnJDhQF+1brJ
         aiTDq+eOcYEXGDrGX1L/IVGFt/W8JjnFrBuABHt15RjkRQo/YTwB2BlSPvDtHYB8lGMm
         ykaI5eCACXIPNTUuXhxuMY3rhBBoDcYtIEvcsHFd/auHPBH5ZYm1XcXdrTknllV46fWI
         6IxbV4RJ6+1zvxO7JEtmuKCpPH6ZAanPb0B26PYa4Yvuc1PJslqy6m0jGk32IqVK+wPY
         QRu0Y81Y3O82N/r8kXy1fHsBoo786BATfHZCYiYZC2kw+lV7jaRhfpd5QHuozlK7UgJ9
         EmuA==
X-Gm-Message-State: ANoB5pk4GIA2Zm394bLOyVHf4Fy+6NmaOwF/R8GHslNMQExYaw/eG1RY
        QYtJtVhXg+qFo1EDyClRBa6tUrmis/EHzo7pUoA=
X-Google-Smtp-Source: AA0mqf4h9Qg9MqhCY9VuEOPUMlBiJzqI9bIG9pR0FF0T9xfosq9DlT373cl41zhdQbP6THl+wdppnASeWMKC+6NI0Pc=
X-Received: by 2002:a05:6512:759:b0:4b0:65c6:11fc with SMTP id
 c25-20020a056512075900b004b065c611fcmr8122095lfs.193.1668593829196; Wed, 16
 Nov 2022 02:17:09 -0800 (PST)
MIME-Version: 1.0
References: <20221115161627.4169428-1-kristen@linux.intel.com>
In-Reply-To: <20221115161627.4169428-1-kristen@linux.intel.com>
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Date:   Wed, 16 Nov 2022 11:16:52 +0100
Message-ID: <CAPj211ugzBFJHgDNtSgR2zB7ZcGa_EqOAQGhFSu938718u+yMQ@mail.gmail.com>
Subject: Re: [PATCH v2] x86/sgx: Replace kmap/kunmap_atomic calls
To:     jarkko@kernel.org, ira.weiny@intel.com,
        dave.hansen@linux.intel.com, linux-sgx@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On marted=C3=AC 15 novembre 2022 17:16:26 CET Kristen Carlson Accardi wrote=
:
> kmap_local_page() is the preferred way to create temporary mappings
> when it is feasible, because the mappings are thread-local and
> CPU-local.

The atomic mappings are thread and CPU local too.

Instead, please note that the most important difference is that
kmap_local_page() won't ever disable (1) pagefaults and (2) (depending on
PREEMPT_RT) preemption.

To make it clearer: I think that your conversions are correct and welcome. =
I'm
only asking for clarifications about how you show the reasons why they are
good.

> kmap_local_page() uses per-task maps rather than per-CPU
> maps. This in effect removes the need to preemption in the
> local CPU while kmap is active, and thus vastly reduces overall
> system latency.

I'm also experiencing difficulties with the paragraph above. What do you me=
an
by "This in effect removes the need to preemption in the local CPU while km=
ap
is active"? I understand that for me, being a non native English speaker, s=
ome
sentences may appear weird even in cases where they are perfectly fine.

I can't see why you are expressing the way you are, since kmap_local_page()
does not ever disable preemption.

Let's focus to the call sites you are converting: you know that the code
between kmap_atomic() and kunmap_atomic() can run in non atomic context, th=
us
there are no real reason to rely on any kmap_atomic() side effects (please
look above again, if necessary).

Therefore, the real good reason for converting are (1) avoid unnecessary
disabling of page faults and (2) avoid the probable disabling of preemption=
.

> local CPU while kmap is active

> It is also valid to take pagefaults.
>
> The use of kmap_atomic() in the SGX code was not an explicit design
> choice to disable page faults or preemption, and there is no compelling
> design reason to using kmap_atomic() vs. kmap_local_page().

This is at the core of the reasons why you are converting, that is to avoid
the potential overhead (in 32 bit architectures) of switching in atomic
context where it is not required.

> Link: https://lore.kernel.org/linux-sgx/Y0biN3%2FJsZMa0yUr@kernel.org/
>
> For more information on the use of kmap_local_page() vs.
> kmap_atomic(), please see Documentation/mm/highmem.rst
>
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> ---
> Changes since V1:
>
> - Reword commit message to make it more clear why it is preferred
>   to use kmap_local_page() vs. kmap_atomic().
>
>  arch/x86/kernel/cpu/sgx/encl.c  | 12 ++++++------
>  arch/x86/kernel/cpu/sgx/ioctl.c |  4 ++--
>  arch/x86/kernel/cpu/sgx/main.c  |  8 ++++----
>  3 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/enc=
l.c
> index 2c258255a629..68f8b18d2278 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.c
> +++ b/arch/x86/kernel/cpu/sgx/encl.c
> @@ -160,8 +160,8 @@ static int __sgx_encl_eldu(struct sgx_encl_page
> *encl_page, return ret;
>
>       pginfo.addr =3D encl_page->desc & PAGE_MASK;
> -     pginfo.contents =3D (unsigned long)kmap_atomic(b.contents);
> -     pcmd_page =3D kmap_atomic(b.pcmd);
> +     pginfo.contents =3D (unsigned long)kmap_local_page(b.contents);
> +     pcmd_page =3D kmap_local_page(b.pcmd);
>       pginfo.metadata =3D (unsigned long)pcmd_page + b.pcmd_offset;
>
>       if (secs_page)
> @@ -187,8 +187,8 @@ static int __sgx_encl_eldu(struct sgx_encl_page
> *encl_page, */
>       pcmd_page_empty =3D !memchr_inv(pcmd_page, 0, PAGE_SIZE);
>
> -     kunmap_atomic(pcmd_page);
> -     kunmap_atomic((void *)(unsigned long)pginfo.contents);
> +     kunmap_local(pcmd_page);
> +     kunmap_local((void *)(unsigned long)pginfo.contents);
>
>       get_page(b.pcmd);
>       sgx_encl_put_backing(&b);
> @@ -197,10 +197,10 @@ static int __sgx_encl_eldu(struct sgx_encl_page
> *encl_page,
>
>       if (pcmd_page_empty && !reclaimer_writing_to_pcmd(encl,
pcmd_first_page)) {
>               sgx_encl_truncate_backing_page(encl,
PFN_DOWN(page_pcmd_off));
> -             pcmd_page =3D kmap_atomic(b.pcmd);
> +             pcmd_page =3D kmap_local_page(b.pcmd);
>               if (memchr_inv(pcmd_page, 0, PAGE_SIZE))
>                       pr_warn("PCMD page not empty after truncate.
\n");
> -             kunmap_atomic(pcmd_page);
> +             kunmap_local(pcmd_page);
>       }
>
>       put_page(b.pcmd);
> diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/
ioctl.c
> index ef874828fa6b..03c50f11ad75 100644
> --- a/arch/x86/kernel/cpu/sgx/ioctl.c
> +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
> @@ -221,11 +221,11 @@ static int __sgx_encl_add_page(struct sgx_encl *enc=
l,
>       pginfo.secs =3D (unsigned long)sgx_get_epc_virt_addr(encl-
>secs.epc_page);
>       pginfo.addr =3D encl_page->desc & PAGE_MASK;
>       pginfo.metadata =3D (unsigned long)secinfo;
> -     pginfo.contents =3D (unsigned long)kmap_atomic(src_page);
> +     pginfo.contents =3D (unsigned long)kmap_local_page(src_page);
>
>       ret =3D __eadd(&pginfo, sgx_get_epc_virt_addr(epc_page));
>
> -     kunmap_atomic((void *)pginfo.contents);
> +     kunmap_local((void *)pginfo.contents);
>       put_page(src_page);
>
>       return ret ? -EIO : 0;
> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/mai=
n.c
> index 0aad028f04d4..e5a37b6e9aa5 100644
> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -165,17 +165,17 @@ static int __sgx_encl_ewb(struct sgx_epc_page
*epc_page,
> void *va_slot, pginfo.addr =3D 0;
>       pginfo.secs =3D 0;
>
> -     pginfo.contents =3D (unsigned long)kmap_atomic(backing->contents);
> -     pginfo.metadata =3D (unsigned long)kmap_atomic(backing->pcmd) +
> +     pginfo.contents =3D (unsigned long)kmap_local_page(backing->content=
s);
> +     pginfo.metadata =3D (unsigned long)kmap_local_page(backing->pcmd) +
>                         backing->pcmd_offset;
>
>       ret =3D __ewb(&pginfo, sgx_get_epc_virt_addr(epc_page), va_slot);
>       set_page_dirty(backing->pcmd);
>       set_page_dirty(backing->contents);
>
> -     kunmap_atomic((void *)(unsigned long)(pginfo.metadata -
> +     kunmap_local((void *)(unsigned long)(pginfo.metadata -
>                                             backing-
>pcmd_offset));

> -     kunmap_atomic((void *)(unsigned long)pginfo.contents);
> +     kunmap_local((void *)(unsigned long)pginfo.contents);
>
>       return ret;
>  }
> --
> 2.38.1
