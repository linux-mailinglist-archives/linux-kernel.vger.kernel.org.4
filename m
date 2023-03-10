Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB156B5603
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 00:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbjCJXu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 18:50:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjCJXuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 18:50:25 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CBB12C721
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 15:50:21 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id nn12so6800343pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 15:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678492221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWyYImSF4m0qt3ueUgGNFztvxSwHcqnFDOTOnYZc4d8=;
        b=Zb1mq1ps8eV7fiIOg285n4VDwnQ8IxixllRpKM+wYlYxvrI6LbruQiHGqkLYVmy0iy
         BZwTEuHpg+k7sRmyn25XbDba43HMPHEYo1Jm4kJj+xhe6/TvAw3nqbvIsrqzBglXZYcZ
         OYDwZCd0P6iQlGcA4qFLE57Qm/fyUsA1F7sph6l9sSxVTqGonhsihK7Sx/ULzS6/mehn
         W/hSgQsltum0ZXoUlOzf6+VvTeQknJdOykkkhmRdK/Qok8g6QMCWN5yZqK1/rpcWUSqa
         z2zzGU0WNgG90m//LslE/BIXf4FPhzgLOYtWIoaMSQo8p30zLHnkjhzeFC85uap8dwWY
         JuNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678492221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TWyYImSF4m0qt3ueUgGNFztvxSwHcqnFDOTOnYZc4d8=;
        b=GYd8TnahwVpTIe5iOoq2J1fxsVfXgCWPZyVfWfVlh/ikqA+hFTLZdr/i99yqQmQ9ef
         erpy4C3BDKbj63XdIHQpGzaQKlRn3bRN0Cq5Qi5yFYyxGyJo/236R4FlrXDtjqVa7vDR
         kU7W1w9jQWOu9blusvbxrZLnKd457cTiH7kl6bBUEu2H3ITC1/7fyRB2bk7BiYEHWd2+
         ktP9+j3FALKiQsKBHtlJ6J5xchC6+G9sq6nbk/Nl8sx3cdGPoW94w5ncSZJ6Ni7MQnIU
         ARSByFGO511MCTVPxpXg6u7ZVPDeQb35UnRrSyt6pG/QWWC6Z9coz4gFaMBiibOd96iD
         S/QA==
X-Gm-Message-State: AO0yUKWiKAC++RHz+Y/eXJ697MHFbxqBYeLDNFtckaDzMRoVsGtNI3Fw
        0/GCKi5EUzE4BsFcYltBc95XktbPceLqhEbFWWA=
X-Google-Smtp-Source: AK7set9yPWPLhCJJqju34JnyYz1ou4U8qNzsXMLH19czqyQSsp4MXTFLF7uEiBMUS32lgPHbopd2lbCnGgs/Nw2E/UA=
X-Received: by 2002:a17:90a:bb8d:b0:234:b23:eade with SMTP id
 v13-20020a17090abb8d00b002340b23eademr9946913pjr.9.1678492220849; Fri, 10 Mar
 2023 15:50:20 -0800 (PST)
MIME-Version: 1.0
References: <20230306111322.205724-1-glider@google.com>
In-Reply-To: <20230306111322.205724-1-glider@google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Sat, 11 Mar 2023 00:50:09 +0100
Message-ID: <CA+fCnZfENShgduZuu1xzrmCnNFv+ovHtcavGXKjYumsGA1kX5w@mail.gmail.com>
Subject: Re: [PATCH 1/2] lib/stackdepot: kmsan: mark API outputs as initialized
To:     Alexander Potapenko <glider@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, elver@google.com, dvyukov@google.com,
        kasan-dev@googlegroups.com
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

On Mon, Mar 6, 2023 at 12:13=E2=80=AFPM Alexander Potapenko <glider@google.=
com> wrote:
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
> @@ -306,6 +307,11 @@ depot_alloc_stack(unsigned long *entries, int size, =
u32 hash, void **prealloc)
>         stack->handle.extra =3D 0;
>         memcpy(stack->entries, entries, flex_array_size(stack, entries, s=
ize));
>         pool_offset +=3D required_size;
> +       /*
> +        * Let KMSAN know the stored stack record is initialized. This sh=
all
> +        * prevent false positive reports if instrumented code accesses i=
t.
> +        */
> +       kmsan_unpoison_memory(stack, required_size);
>
>         return stack;
>  }
> @@ -465,6 +471,12 @@ unsigned int stack_depot_fetch(depot_stack_handle_t =
handle,
>         struct stack_record *stack;
>
>         *entries =3D NULL;
> +       /*
> +        * Let KMSAN know *entries is initialized. This shall prevent fal=
se
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

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
