Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D7A6C216E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 20:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjCTTat convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 20 Mar 2023 15:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjCTTaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 15:30:21 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4211FE2;
        Mon, 20 Mar 2023 12:22:58 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id r5so14496614qtp.4;
        Mon, 20 Mar 2023 12:22:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679340154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6bxy6jak+CYjLwKU8J3n9G3U7V2ce11/kSzIzYsPin0=;
        b=O9l9C1ETPqpz0G7UsIMx8EHRCo8P1s7hts91Dv/pTku+KvxeNjA75at2xAyN0SEvIl
         rWbtcctM+I0ULH+9z151JKAlLcflvWA7cPZlPNjec1BaOmZ3ODBVLx6FeMQ26PCOgcwl
         BjRJ9APvqEAIKfRf+G6E1kPPxR3U54tMzE0qRO3KbNgKvr59pR3/NLWyT8QiMsZG7+tC
         0qK6A37T2elMOrHR+YbNqeBq+E3z9TOCF1pP1Ts19XGtnvdeXEAmcCxcXE7AeI7NVhmB
         xsDVzuK6DbzagvMISSgj40cF36aFBILf25NiXByXeJhe4WYrwfHbFMtxjMsSy2fHwZ/g
         e3dQ==
X-Gm-Message-State: AO0yUKUz2eWx1BlrRu/nvQMxZWzRlqwOLS7654lttpXXUH+kSwaZWVWh
        yS70SLH1OYmfucUjBPtH9lBo5WtzPK7rQA==
X-Google-Smtp-Source: AK7set9HebjIvSW6w2G1+Fu1btAjpR2bVNLuw87W2HoPu7s5oUKv0f608lMBeJo+oGGsmNATidN4TQ==
X-Received: by 2002:a05:622a:15c2:b0:3d6:90e6:61f5 with SMTP id d2-20020a05622a15c200b003d690e661f5mr395692qty.36.1679340153865;
        Mon, 20 Mar 2023 12:22:33 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id o5-20020a375a05000000b007464fcca543sm7892296qkb.50.2023.03.20.12.22.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 12:22:33 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5447d217bc6so241794837b3.7;
        Mon, 20 Mar 2023 12:22:33 -0700 (PDT)
X-Received: by 2002:a81:e508:0:b0:544:5fc7:f01f with SMTP id
 s8-20020a81e508000000b005445fc7f01fmr10167487ywl.4.1679340152888; Mon, 20 Mar
 2023 12:22:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230319150027.66475-1-robh@kernel.org>
In-Reply-To: <20230319150027.66475-1-robh@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 20 Mar 2023 20:22:21 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXPOJZJXPKbbTb9rnQ=8e1Tmj2_GCVHwSPJHrE=9+Hqhw@mail.gmail.com>
Message-ID: <CAMuHMdXPOJZJXPKbbTb9rnQ=8e1Tmj2_GCVHwSPJHrE=9+Hqhw@mail.gmail.com>
Subject: Re: [PATCH] ARM: sh-mobile: Use of_cpu_node_to_id() to read CPU node 'reg'
To:     Rob Herring <robh@kernel.org>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Sun, Mar 19, 2023 at 4:00 PM Rob Herring <robh@kernel.org> wrote:
> Replace open coded CPU nodes reading of "reg" and translation to logical
> ID with of_cpu_node_to_id().
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Thanks for your patch!

> --- a/arch/arm/mach-shmobile/platsmp-apmu.c
> +++ b/arch/arm/mach-shmobile/platsmp-apmu.c
> @@ -10,6 +10,7 @@
>  #include <linux/init.h>
>  #include <linux/io.h>
>  #include <linux/ioport.h>
> +#include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/smp.h>
>  #include <linux/suspend.h>
> @@ -210,7 +211,6 @@ static void apmu_parse_dt(void (*fn)(struct resource *res, int cpu, int bit))
>         struct device_node *np_apmu, *np_cpu;
>         struct resource res;
>         int bit, index;
> -       u32 id;
>
>         for_each_matching_node(np_apmu, apmu_ids) {
>                 /* only enable the cluster that includes the boot CPU */
> @@ -218,33 +218,27 @@ static void apmu_parse_dt(void (*fn)(struct resource *res, int cpu, int bit))
>
>                 for (bit = 0; bit < CONFIG_NR_CPUS; bit++) {

This loops over all CPUs....

>                         np_cpu = of_parse_phandle(np_apmu, "cpus", bit);
> -                       if (np_cpu) {
> -                               if (!of_property_read_u32(np_cpu, "reg", &id)) {
> -                                       if (id == cpu_logical_map(0)) {
> -                                               is_allowed = true;
> -                                               of_node_put(np_cpu);
> -                                               break;
> -                                       }
> -
> -                               }
> +                       if (np_cpu && of_cpu_node_to_id(np_cpu) == 0) {

As of_cpu_node_to_id() uses for_each_possible_cpu(), you're
converting an O(n) operation to O(n²).  I'm sure this can be done
more efficiently, using for_each_possible_cpu() as the outer loop?

Meh, cpu_logical_map() also loops over all CPUs, so it was already
O(n²)... Still, we should do better...

> +                               is_allowed = true;
>                                 of_node_put(np_cpu);
> +                               break;
>                         }
> +                       of_node_put(np_cpu);
>                 }
>                 if (!is_allowed)
>                         continue;
>
>                 for (bit = 0; bit < CONFIG_NR_CPUS; bit++) {
>                         np_cpu = of_parse_phandle(np_apmu, "cpus", bit);
> -                       if (np_cpu) {
> -                               if (!of_property_read_u32(np_cpu, "reg", &id)) {
> -                                       index = get_logical_index(id);
> -                                       if ((index >= 0) &&
> -                                           !of_address_to_resource(np_apmu,
> -                                                                   0, &res))
> -                                               fn(&res, index, bit);
> -                               }
> -                               of_node_put(np_cpu);
> -                       }
> +                       if (!np_cpu)
> +                               continue;
> +
> +                       index = of_cpu_node_to_id(np_cpu);

Likewise.

> +                       if ((index >= 0) &&
> +                           !of_address_to_resource(np_apmu, 0, &res))
> +                               fn(&res, index, bit);
> +
> +                       of_node_put(np_cpu);
>                 }
>         }
>  }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
