Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17EC86ABE56
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 12:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjCFLhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 06:37:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjCFLhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 06:37:35 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DF0BB94
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 03:37:34 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id i28so12372759lfv.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 03:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678102652;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/EG0K6pekvZn1QIAwUQIbgo3cKkJaQ89TXn04u6/9Ng=;
        b=U5ElntDzu9LrgYApOmcNOOrHnjctbhaF+aSXJvBFgv3DRkX5TbH2byTrO8M9VuB7Np
         st/TS+CDeZ3ea1r120bPap745CDtanb8uWaG7LFlxa8sbuzQCo3ORmjB03FHgj7Vx8a8
         F6RKJhDux6pvmHT2gQ2Qjkzr9YFLqC9IoAKmAXmsptJtO+F7hTbfTf4vfgo1mHMFEiIM
         AHyEGuiDi76eLSnIJzIM1/5/xKs3he251Y0DGFKSmcNf9611Ybe82C7VLFp+SRhd0qdz
         Y4Lm2T3YOjMHtZss1aS7f2DLcbKEtADvJQ3tbzwTB/pAUHfN47b768PF8gDXs43eP5as
         TB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678102652;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/EG0K6pekvZn1QIAwUQIbgo3cKkJaQ89TXn04u6/9Ng=;
        b=OOrJARbBhojgwxhmFH73Ojx0Apz+3z8n7PPE/aPKPTUskPtKV6nlmbk3qCfyxBOLo3
         E6Ed6GeHQ7/HSa/i+NAaAktVslDefPrPpDs1B8gr0/T2oL61VMKYhQ4AXqj9xULOAywj
         3HeuH/15C/f470xfxUaEQ2p1Ii30zm9Q0uKw9v4o6M49Lzp+gk7piot7fPjv9Dmryf0H
         BfvByuXXDEceOs78mfamY7pUXZS5IYFQBFpMJweubZk4/3c/dU7cDTh8qKLrx3dj9y8Z
         yzYN5RzI7kAhLqD6FGKGwcmkO7gTwkece4Ul/qpyrlV1w9nyAZAGuQsvxi3su2miyl0G
         HYrw==
X-Gm-Message-State: AO0yUKUawzqyGaHUhdNz1qlaQFfE7BJFw1BBm9cQ1Lvi+hiEaUSzkNqC
        cQkF06FiaL8GRufAoZvl3WMvDkBwjf1QQvrveK1jb64cyOYBrCmu/34xEA==
X-Google-Smtp-Source: AK7set+B6IJtoMNOimp3MgVLafmLOE4sQ9VC7wE0tgCwFScXOahwx480BdKGU94Scxg1rLI6OwuYyxRydC2nhZFtFmI=
X-Received: by 2002:a19:8c4e:0:b0:4dc:7e56:9839 with SMTP id
 i14-20020a198c4e000000b004dc7e569839mr6502919lfj.5.1678102652464; Mon, 06 Mar
 2023 03:37:32 -0800 (PST)
MIME-Version: 1.0
References: <20230306111322.205724-1-glider@google.com>
In-Reply-To: <20230306111322.205724-1-glider@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 6 Mar 2023 12:37:20 +0100
Message-ID: <CACT4Y+Yzm90bzM5CDyjCCY9Dveysp6h-nh3F2DhhesRLLxhWDQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] lib/stackdepot: kmsan: mark API outputs as initialized
To:     Alexander Potapenko <glider@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, elver@google.com,
        kasan-dev@googlegroups.com, Andrey Konovalov <andreyknvl@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Mar 2023 at 12:13, Alexander Potapenko <glider@google.com> wrote:
>
> KMSAN does not instrument stackdepot and may treat memory allocated by
> it as uninitialized. This is not a problem for KMSAN itself, because its
> functions calling stackdepot API are also not instrumented.
> But other kernel features (e.g. netdev tracker) may access stack depot
> from instrumented code, which will lead to false positives, unless we
> explicitly mark stackdepot outputs as initialized.
>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Marco Elver <elver@google.com>
> Suggested-by: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Alexander Potapenko <glider@google.com>

Add:
Reported-by: syzbot <syzkaller@googlegroups.com>

Otherwise:
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>


> ---
>  lib/stackdepot.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index 036da8e295d19..2f5aa851834eb 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -17,6 +17,7 @@
>  #include <linux/gfp.h>
>  #include <linux/jhash.h>
>  #include <linux/kernel.h>
> +#include <linux/kmsan.h>
>  #include <linux/mm.h>
>  #include <linux/mutex.h>
>  #include <linux/percpu.h>
> @@ -306,6 +307,11 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
>         stack->handle.extra = 0;
>         memcpy(stack->entries, entries, flex_array_size(stack, entries, size));
>         pool_offset += required_size;
> +       /*
> +        * Let KMSAN know the stored stack record is initialized. This shall
> +        * prevent false positive reports if instrumented code accesses it.
> +        */
> +       kmsan_unpoison_memory(stack, required_size);
>
>         return stack;
>  }
> @@ -465,6 +471,12 @@ unsigned int stack_depot_fetch(depot_stack_handle_t handle,
>         struct stack_record *stack;
>
>         *entries = NULL;
> +       /*
> +        * Let KMSAN know *entries is initialized. This shall prevent false
> +        * positive reports if instrumented code accesses it.
> +        */
> +       kmsan_unpoison_memory(entries, sizeof(*entries));
> +
>         if (!handle)
>                 return 0;
>
> --
> 2.40.0.rc0.216.gc4246ad0f0-goog
>
