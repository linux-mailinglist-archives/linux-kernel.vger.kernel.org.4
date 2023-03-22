Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D306C53B0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 19:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjCVSZH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 22 Mar 2023 14:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjCVSZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 14:25:04 -0400
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C395F2B629;
        Wed, 22 Mar 2023 11:25:01 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id eg48so76524238edb.13;
        Wed, 22 Mar 2023 11:25:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679509500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FKffiRDbjDTeXJ2hTXuTV+MxI1Yz3INi1cXAJiYPuRc=;
        b=jktupxJB/B3eCyJBQWYPnoTKiO52yFzne1qmiqaPSg2mS5UYY5JCPQBF7MeaWFQk65
         NDivHrqdFSiKbb+fgTby81o8Aadt9eT82Tnb02ediKD5yyA9InfN5Ofzn1aUI/XenZyj
         bFruOHdSm0aBMtjRhwtM2YOSWzfSMSwKngIYIEEhLKCi1VjO6YswZgU4gzuJm1YJh3Ez
         XFtrSH/FPk5mcltLEczmEIKTEVqEj+miScpi4y4YizoEux73qpRNo5+tIEpT/OP5dRsF
         KuiB/AGFd6lsaA9xXRZ61JKbtmNrsX/khZfKgqXrpMg3TCI8MLwsQP485CrBmIcjtvYq
         6SHA==
X-Gm-Message-State: AO0yUKWbwG7geZMWLtAmufRscc3NMIf45Ql33AN3ioSqzoF2qmHX0bHt
        s0Cz5+EG4czpKRVLxbauRoBCw1q2LhyN5ul8O2TS/2ySCyE=
X-Google-Smtp-Source: AK7set8RkIt2HWBfp8QlXVvUBaz2eC+3KitJ37RePlr79OOyxMulJ2zRbwMPimuaGjIKkH4FILuAQyoL58SmueIZ3Kc=
X-Received: by 2002:a50:c3cf:0:b0:4fb:2593:846 with SMTP id
 i15-20020a50c3cf000000b004fb25930846mr3902985edf.3.1679509500165; Wed, 22 Mar
 2023 11:25:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230320212012.12704-1-ubizjak@gmail.com>
In-Reply-To: <20230320212012.12704-1-ubizjak@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 22 Mar 2023 19:24:49 +0100
Message-ID: <CAJZ5v0jAysMPb180tMMmoGBEewENKn-fW7bwzGyMVv4wUrX=LA@mail.gmail.com>
Subject: Re: [PATCH v2] x86/ACPI/boot: Improve __acpi_acquire_global_lock
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     x86@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 10:20 PM Uros Bizjak <ubizjak@gmail.com> wrote:
>
> Improve __acpi_acquire_global_lock by using a temporary variable.
> This enables compiler to perform if-conversion and improves generated
> code from:
>
>  ...
>  72a:   d1 ea                   shr    %edx
>  72c:   83 e1 fc                and    $0xfffffffc,%ecx
>  72f:   83 e2 01                and    $0x1,%edx
>  732:   09 ca                   or     %ecx,%edx
>  734:   83 c2 02                add    $0x2,%edx
>  737:   f0 0f b1 17             lock cmpxchg %edx,(%rdi)
>  73b:   75 e9                   jne    726 <__acpi_acquire_global_lock+0x6>
>  73d:   83 e2 03                and    $0x3,%edx
>  740:   31 c0                   xor    %eax,%eax
>  742:   83 fa 03                cmp    $0x3,%edx
>  745:   0f 95 c0                setne  %al
>  748:   f7 d8                   neg    %eax
>
> to:
>
>  ...
>  72a:   d1 e9                   shr    %ecx
>  72c:   83 e2 fc                and    $0xfffffffc,%edx
>  72f:   83 e1 01                and    $0x1,%ecx
>  732:   09 ca                   or     %ecx,%edx
>  734:   83 c2 02                add    $0x2,%edx
>  737:   f0 0f b1 17             lock cmpxchg %edx,(%rdi)
>  73b:   75 e9                   jne    726 <__acpi_acquire_global_lock+0x6>
>  73d:   8d 41 ff                lea    -0x1(%rcx),%eax
>
> BTW: the compiler could generate:
>
>         lea 0x2(%rcx,%rdx,1),%edx
>
> instead of:
>
>         or     %ecx,%edx
>         add    $0x2,%edx
>
> but unwated conversion from add to or when bits are known to be zero
> prevents this improvement. This is GCC PR108477.
>
> No functional change intended.
>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> ---
> v2: Expand return statement.

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

or please let me know if you want me to pick this up (in which case it
will require an ACK from one of the x86 maintainers).

> ---
>  arch/x86/kernel/acpi/boot.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index 1c38174b5f01..a08a4a7a03f8 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -1853,13 +1853,18 @@ early_param("acpi_sci", setup_acpi_sci);
>
>  int __acpi_acquire_global_lock(unsigned int *lock)
>  {
> -       unsigned int old, new;
> +       unsigned int old, new, val;
>
>         old = READ_ONCE(*lock);
>         do {
> -               new = (((old & ~0x3) + 2) + ((old >> 1) & 0x1));
> +               val = (old >> 1) & 0x1;
> +               new = (old & ~0x3) + 2 + val;
>         } while (!try_cmpxchg(lock, &old, new));
> -       return ((new & 0x3) < 3) ? -1 : 0;
> +
> +       if (val)
> +               return 0;
> +
> +       return -1;
>  }
>
>  int __acpi_release_global_lock(unsigned int *lock)
> --
> 2.39.2
>
