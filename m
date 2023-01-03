Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1D465BB8A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 09:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbjACIBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 03:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236951AbjACIAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 03:00:54 -0500
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02465CF7
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 00:00:50 -0800 (PST)
Received: by mail-qt1-f180.google.com with SMTP id z12so24028224qtv.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 00:00:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LZUg7BSCdLfb7gu4C1vCLOOqdWzDawUGvWzZumrI/zw=;
        b=hM7wt4k5vKwGl1AgvcjYkEdoeFMbqBFqPqswZVPq8hq6RidVI/mhAolXRhgZLPX5p6
         IW8t8NX5KNuLJUa9iJTw/fiNBpnE1fMJ2GUnGbiPcPYj8Q/TpuHZyQ9rsVIEsEtYj+1s
         8PPp14XLUHCsetlPHX9/aGPMABYVBHrzCCy3Yrz8IPPhSdKd8EKzi2VI/Tsvh6uIz+zP
         L25DhfS7XRRUdpYWqwPD6OWFHpVvbELa9PZue8VxTptdzV8Olv7JCiF1dAs+E3GgM7DI
         /uJSTb5hYqoxUwUNbCmCpBhMXN76BdhDdXhGT6oWkMRHfn5qAMzPK0l0Z5FYPByCejfO
         E6pA==
X-Gm-Message-State: AFqh2kqNdhfkRwraWeLrfQVU6DjiJqd34UVeOmL881OkKKsS7fdGRFqY
        m5UwQjs6C+MrnHR2aLQ8qrF8QloBS4VQvg==
X-Google-Smtp-Source: AMrXdXtx5h0s/uSmEvOhP61J/QK7g77mhJzG4u5rP1xjcamEqRAgtKaRd0ZCTWBWGPEumrQiRZgxow==
X-Received: by 2002:ac8:7601:0:b0:3a8:199b:dcac with SMTP id t1-20020ac87601000000b003a8199bdcacmr56273152qtq.15.1672732849308;
        Tue, 03 Jan 2023 00:00:49 -0800 (PST)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id u5-20020a05620a0c4500b006cfc1d827cbsm21719772qki.9.2023.01.03.00.00.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 00:00:48 -0800 (PST)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-4a0d6cb12c5so97453077b3.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 00:00:48 -0800 (PST)
X-Received: by 2002:a81:17ca:0:b0:46f:bd6:957d with SMTP id
 193-20020a8117ca000000b0046f0bd6957dmr3032644ywx.383.1672732847900; Tue, 03
 Jan 2023 00:00:47 -0800 (PST)
MIME-Version: 1.0
References: <20221229075323.1394010-1-linmq006@gmail.com>
In-Reply-To: <20221229075323.1394010-1-linmq006@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 3 Jan 2023 09:00:36 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWFyKA7nUojivvTwWcmxaiUQifRRB=Kn1q-qzmn20Xkuw@mail.gmail.com>
Message-ID: <CAMuHMdWFyKA7nUojivvTwWcmxaiUQifRRB=Kn1q-qzmn20Xkuw@mail.gmail.com>
Subject: Re: [PATCH] um: vector: Fix memory leak in vector_config
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miaoqian,

On Thu, Dec 29, 2022 at 8:53 AM Miaoqian Lin <linmq006@gmail.com> wrote:
> kstrdup() return newly allocated copy of the string.
> Call kfree() to release the memory when after use.
>
> Fixes: 49da7e64f33e ("High Performance UML Vector Network Driver")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Thanks for your patch!

> --- a/arch/um/drivers/vector_kern.c
> +++ b/arch/um/drivers/vector_kern.c
> @@ -765,6 +765,7 @@ static int vector_config(char *str, char **error_out)
>
>         parsed = uml_parse_vector_ifspec(params);
>
> +       kfree(params);

Are you sure the memory pointed to by "params" is no longer used?
"parsed" seems to contain pointers pointing to (parts of) the string
pointed to by "params", so it cannot be freed.

>         if (parsed == NULL) {
>                 *error_out = "vector_config failed to parse parameters";
>                 return -EINVAL;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
