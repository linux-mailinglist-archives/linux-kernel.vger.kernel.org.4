Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D546C1D99
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbjCTRTE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 20 Mar 2023 13:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbjCTRSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:18:42 -0400
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CD2BBA4;
        Mon, 20 Mar 2023 10:14:45 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id r11so49611602edd.5;
        Mon, 20 Mar 2023 10:14:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679332394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S16zTRwoZXkN9+bZyJ89V3qixVwuL0q5+gYPJZLWwVY=;
        b=BGKpQz89h7ZEoSog0Cwaeex2/PzAk0tP4oFpaZrSK0H2EahpP6crPyhtepcvcTyP7y
         Kh+qstEJzXAeZQ5JZ+k2I4JnW4UZsgLczwNJZvabLtRPvxnwWMYuYwKfijJ51Kvd1nPt
         LiVIXAeLDW+uu0OaQb3wsJVK371cPcCh4YaYg+AJE6SA69YUF37Z0J9MqL8k9EU0S2JS
         DhmBIzT8f/WqpYK0A1IpHXY1X2T69gZWXjvMz4h+mI/CAIau6nWGO+Kk2t6aMBJNaJD1
         2rbJPdt8qGnhCMN9FdtGjJQG7Z64Jo5o1P92WYJhAeuwbEVll3O/qUzCAijEdKmV0fQq
         C28w==
X-Gm-Message-State: AO0yUKWS8xPtOtsNGG0Fpg+NoMjATTbMcH1ZfQJlyM7YED/1ic12HiDn
        EXgA9jq6TYkVL7fgQApuaZQ2VldtmJWWS+MhWBs=
X-Google-Smtp-Source: AK7set9Wo3Far/HsR7S80tPon9ufBhPDVDwG/rz/jbTV52ZLi7OawD3lb0cKBN7KLhR+d3RtFSzu1YlT8p81PfWnDlU=
X-Received: by 2002:a17:906:1b4e:b0:930:310:abcf with SMTP id
 p14-20020a1709061b4e00b009300310abcfmr4666996ejg.2.1679332394230; Mon, 20 Mar
 2023 10:13:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230227164745.339269-1-ubizjak@gmail.com>
In-Reply-To: <20230227164745.339269-1-ubizjak@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 20 Mar 2023 18:12:43 +0100
Message-ID: <CAJZ5v0gCk2WtL6+zE9q8KMB+p=bywT=2uZM8VCtmTzWo8MoGdQ@mail.gmail.com>
Subject: Re: [PATCH] x86/ACPI/boot: Improve __acpi_acquire_global_lock
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
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 5:48 PM Uros Bizjak <ubizjak@gmail.com> wrote:
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
>  arch/x86/kernel/acpi/boot.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index 1c38174b5f01..577403c69983 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -1853,13 +1853,14 @@ early_param("acpi_sci", setup_acpi_sci);
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
> +       return val ? 0 : -1;

I would prefer

if (val)
        return -1;

return 0;

>  }
>
>  int __acpi_release_global_lock(unsigned int *lock)
> --

Otherwise I agree that this change would be an improvement.

>
