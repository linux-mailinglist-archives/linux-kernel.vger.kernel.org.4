Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB3E68C119
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 16:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjBFPM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 10:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjBFPMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 10:12:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADDA8A53;
        Mon,  6 Feb 2023 07:12:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7D2960F26;
        Mon,  6 Feb 2023 15:12:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D965C4339B;
        Mon,  6 Feb 2023 15:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675696367;
        bh=ZqLJT5SfiBfc31yhgIBIO3Irq/dos9LliKNSkJkTj8Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cj5QSnuIODTrRBZgH+8VztKUuVZ2Z2H/BlGUUAE0IH5Nf63aekgmeoC9q9GS3tPA3
         inyxXEPKO9QTNmPKvJoqqy0BthUsZUiffI4k/MM8khu2o9sZ726ZXCOT01wMrttoke
         8XYWSHkCMy3vxRV8jeqxjI19BUm9qN3era+RJaFd1VOAr6KoqHIJt9Xn8IVcz16WMk
         d/ACwMAL9lJIXHEDzjZg+yHUwo9zS0BeX+9nT7b7EDawLQC18IBescZdxvQMLdMy8Y
         LYMylwqMn++iItjwfJK1Y/MIDcyyWKhBHcw3ZNsSROLTS7QKsG4vD7haXDuitSZ/9w
         e6+4Rg6E6MntQ==
Received: by mail-vs1-f42.google.com with SMTP id y8so13022057vsq.0;
        Mon, 06 Feb 2023 07:12:47 -0800 (PST)
X-Gm-Message-State: AO0yUKXGasX5uDeL8euA4olqpe/x0/Tw+9OKAT0yolsw6TFd+5Fbaf50
        MyZTr75tN7buxiT/Ajeo5IcQ2+ZcOmXhWlmSRg==
X-Google-Smtp-Source: AK7set+IN3B/wYjy2A/2/SsAUqRFr2LusmEFrX3r44Nfnnsb8X0cCINbAHELkCmTyVojUCWhTe6ykgLW5/AF23ou3Jw=
X-Received: by 2002:a05:6102:54aa:b0:3f5:f5f4:893c with SMTP id
 bk42-20020a05610254aa00b003f5f5f4893cmr3363362vsb.85.1675696366033; Mon, 06
 Feb 2023 07:12:46 -0800 (PST)
MIME-Version: 1.0
References: <20230206142714.4151047-1-liumartin@google.com>
In-Reply-To: <20230206142714.4151047-1-liumartin@google.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 6 Feb 2023 09:12:34 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKA8pBess-zLA_2n0p8q=NBuY0EGA7qALKabwJA8ZRwrA@mail.gmail.com>
Message-ID: <CAL_JsqKA8pBess-zLA_2n0p8q=NBuY0EGA7qALKabwJA8ZRwrA@mail.gmail.com>
Subject: Re: [PATCH] of: reserved-mem: expose reserved-mem details via debugfs
To:     Martin Liu <liumartin@google.com>
Cc:     frowand.list@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, surenb@google.com,
        minchan@kernel.org, tkjos@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 6, 2023 at 8:27 AM Martin Liu <liumartin@google.com> wrote:
>
> It's important to know reserved-mem information in mobile world
> since reserved memory via device tree keeps increased in platform
> (e.g., 45% in our platform). Therefore, it's crucial to know the
> reserved memory sizes breakdown for the memory accounting.
>
> This patch shows the reserved memory breakdown under debugfs to
> make them visible.
>
> Below is an example output:
> cat $debugfs/reserved_mem/show
> 0x00000009fc400000..0x00000009ffffffff (   61440 KB )   map     reusable test1
> 0x00000009f9000000..0x00000009fc3fffff (   53248 KB )   map     reusable test2
> 0x00000000ffdf0000..0x00000000ffffffff (    2112 KB )   map non-reusable test3
> 0x00000009f6000000..0x00000009f8ffffff (   49152 KB )   map     reusable test4
> ...
> 0x00000000fd902000..0x00000000fd909fff (      32 KB ) nomap non-reusable test38
> 0x00000000fd90a000..0x00000000fd90bfff (       8 KB ) nomap non-reusable test39
> Total 39 regions, 1446140 KB

This information is pretty much static, why not just print it during
boot? It's also just spitting out information that's straight from the
DT which is also available to userspace (flattened and unflattened).

Is there not something in memblock that provides the same info in a
firmware agnostic way?


> Signed-off-by: Martin Liu <liumartin@google.com>
> ---
>  drivers/of/of_reserved_mem.c | 39 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>
> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index 65f3b02a0e4e..a73228e07c8c 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -23,6 +23,7 @@
>  #include <linux/memblock.h>
>  #include <linux/kmemleak.h>
>  #include <linux/cma.h>
> +#include <linux/debugfs.h>
>
>  #include "of_private.h"
>
> @@ -446,3 +447,41 @@ struct reserved_mem *of_reserved_mem_lookup(struct device_node *np)
>         return NULL;
>  }
>  EXPORT_SYMBOL_GPL(of_reserved_mem_lookup);
> +
> +#if defined(CONFIG_DEBUG_FS)
> +static int of_reserved_mem_debug_show(struct seq_file *m, void *private)
> +{
> +       unsigned int i;
> +       size_t sum = 0;
> +
> +       for (i = 0; i < reserved_mem_count; i++) {
> +               const struct reserved_mem *rmem = &reserved_mem[i];
> +               unsigned long node = rmem->fdt_node;
> +               phys_addr_t end = rmem->base + rmem->size - 1;
> +               bool nomap = (of_get_flat_dt_prop(node, "no-map", NULL)) != NULL;
> +               bool reusable = (of_get_flat_dt_prop(node, "reusable", NULL)) != NULL;

There is no reason to read the flat DT at this point in time after we
have an unflattened tree.

> +
> +               sum += rmem->size;
> +               seq_printf(m, "%pa..%pa ( %7lu KB ) %5s %12s %s\n", &rmem->base,
> +                          &end, rmem->size / 1024,
> +                          nomap ? "nomap" : "map",
> +                          reusable ? "reusable" : "non-reusable",
> +                          rmem->name ? rmem->name : "unknown");
> +       }
> +       seq_printf(m, "Total %d regions, %zu KB\n",
> +                  reserved_mem_count,
> +                  sum / 1024);
> +       return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(of_reserved_mem_debug);
> +
> +static int __init of_reserved_mem_init_debugfs(void)
> +{
> +       struct dentry *root = debugfs_create_dir("reserved_mem", NULL);
> +
> +       debugfs_create_file("show", 0444, root,
> +                           NULL, &of_reserved_mem_debug_fops);
> +       return 0;
> +}
> +device_initcall(of_reserved_mem_init_debugfs);

We already have a DT init hook, don't add another random one. Plus,
why does this need to be an early device_initcall?

Rob
