Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066F25B4E8E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 13:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbiIKLs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 07:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiIKLs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 07:48:57 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D7C22BF5
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 04:48:56 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id y2so4417109qtv.5
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 04:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=f3KWsKgAEFkYsTG0akgEuS+HAh1aYxDAn4WpE5Ns8zA=;
        b=GQyUfzr0qn9l1B1gRLnzR/F5Sfuss4HGg93KeBu84RPSKCiIyCcVDuQRbpIOqnHRNa
         7hgdkmoeEqbUWdIz19LnGbiwUqIt5BI8W7agKxfK6pGYJA4M2xknml4+zgLGRbTxWhfu
         I75iEIyLleW5WuRS85vFNXDOXvhbSTaF39AT7/TTp2Iox1+mSecUjqqWGWcK9D8Eo89I
         SA/CAl+LOC1QCQKhguDtWN9jv4y4PVo4SXclU+OgpAJaMpQHl6Pim9gbso+mO5zH28nS
         jLAKvVWrmi82/Sirnrnz78R6NuhwbhVA999GWRscIaHu/mol4/GPc7A9UyrNzsE0O8JZ
         mmPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=f3KWsKgAEFkYsTG0akgEuS+HAh1aYxDAn4WpE5Ns8zA=;
        b=Vf7XkpOp2pmcpN7I1FowkOdzpMJqg2jmFbIVIVocANXNPGl6A4Y0KHVrNXhWhZCBaE
         O2K9XnbcnL5BfLAxa6QNx1Dsox9FHuwoJV7nV1Fk0fsGfK59wtkWUL/Ha1R8cij9O/Sm
         MvN4p2dU2e9+Is53V1L2+yIH4ruyxslU0wIljGM2oKCtyyvQucKiiySueob0seeORvbQ
         zujJ3RJqhXA1PDaftsaDZnwsJYrGjlcIWdTy1WPa7eCcDXhEICK15hja74v+MmBm6h8m
         ZtNq9B1AxdGV1z0cxaWoa7bKn0ACksNtDqS0+LcTrSShlzf5stz8/cwR+RRYXAWOyfUl
         B6mw==
X-Gm-Message-State: ACgBeo0EcCCoterBEtxQPDShl34kULXz+jgDAj8HsB16SNR2zUVC3/Xd
        mBy6dDrMixzkkEcpnhbtzwwowVH0Khk/t8+yxfg=
X-Google-Smtp-Source: AA6agR56gHjB5ue3TrbJmvLzBB5HQbmuzY2YMQEVmbx75ESdHCJ96FI7V9cH/K3X3JyvKI8dZbDxhztVacQte/+lngU=
X-Received: by 2002:ac8:7d85:0:b0:35b:acfc:f3a1 with SMTP id
 c5-20020ac87d85000000b0035bacfcf3a1mr4031933qtd.106.1662896935625; Sun, 11
 Sep 2022 04:48:55 -0700 (PDT)
MIME-Version: 1.0
References: <fce40f8dbd160972fe01a1ff39d0c426c310e4b7.1662852281.git.andreyknvl@google.com>
In-Reply-To: <fce40f8dbd160972fe01a1ff39d0c426c310e4b7.1662852281.git.andreyknvl@google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Sun, 11 Sep 2022 13:48:45 +0200
Message-ID: <CA+fCnZfgwjT+Yzxpz-pesqVhitq13Z5aypaXjFodZyCDLr9d6Q@mail.gmail.com>
Subject: Re: [PATCH] kasan: better invalid/double-free report header
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 11, 2022 at 1:25 AM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Update the report header for invalid- and double-free bugs to contain
> the address being freed:
>
> BUG: KASAN: invalid-free in kfree+0x280/0x2a8
> Free of addr ffff00000beac001 by task kunit_try_catch/99
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Forgot to mention: this goes on top of the "kasan: switch tag-based
modes to stack ring from per-object metadata" series.

> ---
>  mm/kasan/report.c         | 23 ++++++++++++++++-------
>  mm/kasan/report_generic.c |  3 ++-
>  mm/kasan/report_tags.c    |  2 +-
>  3 files changed, 19 insertions(+), 9 deletions(-)
>
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 39e8e5a80b82..df3602062bfd 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -175,17 +175,14 @@ static void end_report(unsigned long *flags, void *addr)
>
>  static void print_error_description(struct kasan_report_info *info)
>  {
> -       if (info->type == KASAN_REPORT_INVALID_FREE) {
> -               pr_err("BUG: KASAN: invalid-free in %pS\n", (void *)info->ip);
> -               return;
> -       }
> +       pr_err("BUG: KASAN: %s in %pS\n", info->bug_type, (void *)info->ip);
>
> -       if (info->type == KASAN_REPORT_DOUBLE_FREE) {
> -               pr_err("BUG: KASAN: double-free in %pS\n", (void *)info->ip);
> +       if (info->type != KASAN_REPORT_ACCESS) {
> +               pr_err("Free of addr %px by task %s/%d\n",
> +                       info->access_addr, current->comm, task_pid_nr(current));
>                 return;
>         }
>
> -       pr_err("BUG: KASAN: %s in %pS\n", info->bug_type, (void *)info->ip);
>         if (info->access_size)
>                 pr_err("%s of size %zu at addr %px by task %s/%d\n",
>                         info->is_write ? "Write" : "Read", info->access_size,
> @@ -420,6 +417,18 @@ static void complete_report_info(struct kasan_report_info *info)
>         } else
>                 info->cache = info->object = NULL;
>
> +       switch (info->type) {
> +       case KASAN_REPORT_INVALID_FREE:
> +               info->bug_type = "invalid-free";
> +               break;
> +       case KASAN_REPORT_DOUBLE_FREE:
> +               info->bug_type = "double-free";
> +               break;
> +       default:
> +               /* bug_type filled in by kasan_complete_mode_report_info. */
> +               break;
> +       }
> +
>         /* Fill in mode-specific report info fields. */
>         kasan_complete_mode_report_info(info);
>  }
> diff --git a/mm/kasan/report_generic.c b/mm/kasan/report_generic.c
> index 087c1d8c8145..043c94b04605 100644
> --- a/mm/kasan/report_generic.c
> +++ b/mm/kasan/report_generic.c
> @@ -132,7 +132,8 @@ void kasan_complete_mode_report_info(struct kasan_report_info *info)
>         struct kasan_alloc_meta *alloc_meta;
>         struct kasan_free_meta *free_meta;
>
> -       info->bug_type = get_bug_type(info);
> +       if (!info->bug_type)
> +               info->bug_type = get_bug_type(info);
>
>         if (!info->cache || !info->object)
>                 return;
> diff --git a/mm/kasan/report_tags.c b/mm/kasan/report_tags.c
> index d3510424d29b..ecede06ef374 100644
> --- a/mm/kasan/report_tags.c
> +++ b/mm/kasan/report_tags.c
> @@ -37,7 +37,7 @@ void kasan_complete_mode_report_info(struct kasan_report_info *info)
>         bool is_free;
>         bool alloc_found = false, free_found = false;
>
> -       if (!info->cache || !info->object) {
> +       if ((!info->cache || !info->object) && !info->bug_type) {
>                 info->bug_type = get_common_bug_type(info);
>                 return;
>         }
> --
> 2.25.1
>
