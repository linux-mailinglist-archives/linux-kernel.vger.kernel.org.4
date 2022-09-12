Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08C95B5F13
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 19:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiILRSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 13:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiILRR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 13:17:58 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCF332ABB
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 10:17:58 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-3454b0b1b6dso109444837b3.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 10:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=+KtF588ZPlxi3VVUd2CaBCEItNHS+QL93SWbYzWuiuM=;
        b=OXLJnC7mayQ65WmxSisAIogqRcQ50y/kjx+5g26ONLzrrq2Q/jiDnXAT1KKWCbb8Jf
         +nuzmKjbrNq/nfKapg0jgxPf9zBCcHv3QqluUL2kRFnfXbKMcES7rrJTLbVLaa35AkI9
         0YeJFc6cXyL3uHLQzu4t1U/kIeslqkMpdO4M20Dk5G7xCGWp+Q0kW53IQTdzSN2XNTaw
         974o1kVfqaCiLZGJih2NzdMoFSFsSSLRiZYb/2/ExqrXspaRyi050tBMEuqFqCq5Itld
         YUO+bw9RTg/N5dbFZhxDIUJLsXFm0T0ueEuWkw2lfrW7hjnMsLlcQ4VHSoudFqN0gP/9
         H4QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=+KtF588ZPlxi3VVUd2CaBCEItNHS+QL93SWbYzWuiuM=;
        b=tcnI3TQjF2CzWFXfJoPsov+6SxHxUr1bq/rgZOSk1psdVVkq0oge/Px1RBuR032NQl
         UfqCi9jAS+HqgHNtPT4aEX3oTujKiCY0mau4zzG/bbUADQXR+luTAbjm0cibwkJYE64V
         G9c8HgB7YacAJu2yj4xdOqCTqYBjtNBZy52O1lXaV0UrziyT048hHfdQhwMrq6WNI1XP
         qmD2KDUSMu7tYil+srIEG2h8vqX2Vw7QNltp3wbt2O87sWkUoTD4cs3aGmkvIK+vfsD0
         aGZEuxvApj7VnJAfmRpi3fX/tUNRU0mZHW7BsUdO6o7OhaQ6NLOqkUQx8lfV/T1jFdQi
         +OBA==
X-Gm-Message-State: ACgBeo20QxKMt/j1p15Wb3zABe+a0JzFEmsb2vL2PDsHsfStgfdvUPDy
        NXTsiWHQFtqRgbR7RWsZJFaC1R5SmAjSZgeTUkULPg==
X-Google-Smtp-Source: AA6agR4D5ASo5SV687PploeOcD7X9IAMGVcRbK0zz96aMG1YV0rcPMcRo8kCdUAPctMbIU9aYVRA6+WzU4spKVB/8ZA=
X-Received: by 2002:a81:9c2:0:b0:345:4830:1943 with SMTP id
 185-20020a8109c2000000b0034548301943mr23749159ywj.86.1663003077193; Mon, 12
 Sep 2022 10:17:57 -0700 (PDT)
MIME-Version: 1.0
References: <fce40f8dbd160972fe01a1ff39d0c426c310e4b7.1662852281.git.andreyknvl@google.com>
In-Reply-To: <fce40f8dbd160972fe01a1ff39d0c426c310e4b7.1662852281.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 12 Sep 2022 19:17:20 +0200
Message-ID: <CANpmjNMmDyjmYLfqCNdrksbN9BndjerzNTfdKLDQS_7etrNXMA@mail.gmail.com>
Subject: Re: [PATCH] kasan: better invalid/double-free report header
To:     andrey.konovalov@linux.dev
Cc:     Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Sept 2022 at 01:25, <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Update the report header for invalid- and double-free bugs to contain
> the address being freed:
>
> BUG: KASAN: invalid-free in kfree+0x280/0x2a8
> Free of addr ffff00000beac001 by task kunit_try_catch/99

It wouldn't hurt showing a full before vs. after report here in the
commit message for ease of reviewing.

> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>

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
