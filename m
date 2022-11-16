Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F99462CDFF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 23:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239078AbiKPWqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 17:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239127AbiKPWqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 17:46:13 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C216EB44;
        Wed, 16 Nov 2022 14:45:44 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id a29so31954735lfj.9;
        Wed, 16 Nov 2022 14:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NOzbRqoexIerjFudiptz/V+WQ2iY16Vv0uUoLUqoblE=;
        b=bgGCBqR25eYw9/KiYTU5oUEAsuMXPX0r6nD+Ci8t+TOFDf4svb4zTiiHBeDXL52pMg
         +CJIM/6pRJWJE1tBMrsX7yC8BScgiDNK10gCe8IgG0A1YTS0gByzmaFwDnnHoZxQipvj
         hQrrFsT14vCW9Z5VgVWCgqbSwkEngUtrJLVSlTQWRnZG0X14iJ5i0uV2gCMByzlgibvL
         kx+EBfm/MJQ7zWq33QDaj8qOOAk4Vq0B5gwiHr7d85mcsP2EVjAdSJBiC3LxzmaLr5mr
         oA9tzmrcMYrbO/7JJfl7QNgs6FeCxJEMJ0WyQbpXQLY3IBBlrjZc221RApETlDzjfBDx
         PNUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NOzbRqoexIerjFudiptz/V+WQ2iY16Vv0uUoLUqoblE=;
        b=vvU3V+P/BE29NG+00wMMzNytx0JANzv4a1W2BcT1JhfztNrkOf75uysGCqCWt+v/t5
         8ybqyBRqUQ7kYOHLzqRsIYmi3+KwZbkBswZ32Cn3Pcfoyr9O/XC6NLZ/9m+zd5/exnyV
         dI0wyVJMn0IiwEgWw9bMGP4mIj3GY0SLCYsgfjePEd+xVGXXg9qJMgQzI/PgqdysX2HS
         6rmRPyKjhbhkXWin+LsZk4RdxjrlnNOb9LyXqgJi4zELIhacIYYX2Nr92LXrylfV+XOX
         FmmioeYG+jc8dTPYs+DM4CH0IcjGG2Kpyeb0qUIUzVCWuXFMa8Q9IIkuE8OuJLkQD0HQ
         AefQ==
X-Gm-Message-State: ANoB5plHmgIMFOV64RaUdBV2SDu+XPQcr0xlAifbgoBmKNnbxj9+M6M/
        tr0B5G/r4J+VPxRD7Rn0R6uAaXThUxtBP1sBeFY=
X-Google-Smtp-Source: AA0mqf6wR4mNOabyl/sxE7AcNGGXeFsnh0UvWoVfxYgt5WAeqaCrUBJEXu9QLWTr430tFFVHUucv3vTughwrkV0wMQc=
X-Received: by 2002:a05:6512:3982:b0:4b4:210d:7d2e with SMTP id
 j2-20020a056512398200b004b4210d7d2emr55130lfu.450.1668638742859; Wed, 16 Nov
 2022 14:45:42 -0800 (PST)
MIME-Version: 1.0
References: <20221115161627.4169428-1-kristen@linux.intel.com>
In-Reply-To: <20221115161627.4169428-1-kristen@linux.intel.com>
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Date:   Wed, 16 Nov 2022 23:45:26 +0100
Message-ID: <CAPj211stX5Tja_wjiYnSDGq-vtgFgntT9Wir1dM9HcqyVNk68w@mail.gmail.com>
Subject: Re: [PATCH v2] x86/sgx: Replace kmap/kunmap_atomic calls
To:     jarkko@kernel.org, ira.weiny@intel.com,
        dave.hansen@linux.intel.com, linux-sgx@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
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
> CPU-local. kmap_local_page() uses per-task maps rather than per-CPU
> maps. This in effect removes the need to preemption in the
> local CPU while kmap is active, and thus vastly reduces overall
> system latency. It is also valid to take pagefaults.
>
> The use of kmap_atomic() in the SGX code was not an explicit design
> choice to disable page faults or preemption, and there is no compelling
> design reason to using kmap_atomic() vs. kmap_local_page().
>
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

Despite my tendency to focus attention on details of little importance for =
the
task at hand, I think that your conversions are good and that your analysis
proves them safe because there is no need to explicitly disable page faults
and/or preemption along with the conversions.

Reviewed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Thanks,

Fabio
