Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7617F66DDDC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 13:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236805AbjAQMkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 07:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236792AbjAQMkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 07:40:25 -0500
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3562536FE5;
        Tue, 17 Jan 2023 04:40:16 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id m21so44855938edc.3;
        Tue, 17 Jan 2023 04:40:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vu78cM95kexk6ryuE7ZnUIj1w3auUCahcwZeUIrd3MI=;
        b=pGggSkKFoSEU0Ep8Mt55ZfAyCwh3FkkVFZJQgZgDBcDjk1N671eeT7R+8jcC5GzH1O
         jx06MdMCeX6V4TK37wx3kHOzJFgxm9GzWpdrKv6yIsZP4C80cEv+pz92UqTv8FCNgk+w
         Vf5WBpz7lvvf23wDBsrWiyR7KnyLBIRocWRKVvkLG16H+bMDoxeq1ihUdv5zH2VBC09y
         xnV0Ot0oAWdHTYGuh+ummeafnu1ZCV8dXfYbHm9tGHX8gToJ1pdFjkr6d36MOe20kOeH
         5elyc6uKNSdp3VCj2YgIKn14a2lvNNQAxDlHaQ31leR8VG+F+VyrhPLVBG6KjZvaJlv6
         HaxA==
X-Gm-Message-State: AFqh2kpWO03QbKLexKZvZFyxswXPhm/2KBwC5D7tHvnBJJTqcgSi5iax
        MmTxKQ3qV3nq6Q7ckppjE4LP+IxJD1cucnBxgN4=
X-Google-Smtp-Source: AMrXdXuV2s94Y5dfm0VLSa4CwRj8li77wTg4q3sXUWxWIZ46JI5N9odmdrb2km73TX88AA/+lnFRPguSqsfuV9D+nfg=
X-Received: by 2002:aa7:c3cb:0:b0:499:c651:625d with SMTP id
 l11-20020aa7c3cb000000b00499c651625dmr332014edr.413.1673959214750; Tue, 17
 Jan 2023 04:40:14 -0800 (PST)
MIME-Version: 1.0
References: <20230116162522.4072-1-ubizjak@gmail.com>
In-Reply-To: <20230116162522.4072-1-ubizjak@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 17 Jan 2023 13:39:58 +0100
Message-ID: <CAJZ5v0j7i0FG_ivX1xhTPutJOXb8nZEv7kq+TTOCjynts9049w@mail.gmail.com>
Subject: Re: [PATCH] x86/ACPI/boot: use try_cmpxchg in __acpi_{acquire,release}_global_lock
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     linux-pm@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 5:25 PM Uros Bizjak <ubizjak@gmail.com> wrote:
>
> Use try_cmpxchg instead of cmpxchg (*ptr, old, new) == old in
> __acpi_{acquire,release}_global_lock.  x86 CMPXCHG instruction returns
> success in ZF flag, so this change saves a compare after cmpxchg
> (and related move instruction in front of cmpxchg).
>
> Also, try_cmpxchg implicitly assigns old *ptr value to "old" when cmpxchg
> fails. There is no need to re-read the value in the loop.
>
> Note that the value from *ptr should be read using READ_ONCE to prevent
> the compiler from merging, refetching or reordering the read.
>
> No functional change intended.
>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

but please CC linux-acpi on all ACPI-related changes in the future.

> ---
>  arch/x86/kernel/acpi/boot.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index 907cc98b1938..4177577c173b 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -1840,23 +1840,23 @@ early_param("acpi_sci", setup_acpi_sci);
>
>  int __acpi_acquire_global_lock(unsigned int *lock)
>  {
> -       unsigned int old, new, val;
> +       unsigned int old, new;
> +
> +       old = READ_ONCE(*lock);
>         do {
> -               old = *lock;
>                 new = (((old & ~0x3) + 2) + ((old >> 1) & 0x1));
> -               val = cmpxchg(lock, old, new);
> -       } while (unlikely (val != old));
> +       } while (!try_cmpxchg(lock, &old, new));
>         return ((new & 0x3) < 3) ? -1 : 0;
>  }
>
>  int __acpi_release_global_lock(unsigned int *lock)
>  {
> -       unsigned int old, new, val;
> +       unsigned int old, new;
> +
> +       old = READ_ONCE(*lock);
>         do {
> -               old = *lock;
>                 new = old & ~0x3;
> -               val = cmpxchg(lock, old, new);
> -       } while (unlikely (val != old));
> +       } while (!try_cmpxchg(lock, &old, new));
>         return old & 0x1;
>  }
>
> --
> 2.39.0
>
