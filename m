Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1B6665F37
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 16:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjAKPe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 10:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbjAKPep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 10:34:45 -0500
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD071A04B;
        Wed, 11 Jan 2023 07:34:42 -0800 (PST)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-4c15c4fc8ccso199939697b3.4;
        Wed, 11 Jan 2023 07:34:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rOo/Lmiv+PrggJC7eKLu3qYU4SlvkGK8bJUxeIQkTLk=;
        b=XHbRkojEqzE0i/pNGgbCpY24YQxXgkq2EJ67yCAhIVwkfeL053+FL++ksbmimLYm29
         z9Hl/2j16Cx7AuQk95zScRSzbUFYqiRXtjmua3Ib98Pdknu08Xgtp2+KqS8mcVqhzL+V
         2lzo0cTslVZfG7hccQJVEI8NW7BC8uMUYI1ydJ4EzaiqI7MEa4bwH8ciAlstC+7Gv4XJ
         PVHaIPzC68m8aJ6ykjdi9UIRT/SVWwZmMSuHvlVCcOKYOs/NZJSzkzBNdN2yjIfJarmX
         azfCENLBP9J3z9w92l6PkrE44Gmpv00i2awWkdrIcU7Y9bgGgq1FtNMaY9Bs3MSgB3LY
         6n+g==
X-Gm-Message-State: AFqh2koSa/jNcU45678h7kZLlgbwN2mh0bk730VjLpLecnYZlAErfiqN
        LW1Iou4waseubGf1wYbGWmNodsRQnaSjMg==
X-Google-Smtp-Source: AMrXdXvqv6Btl368LdzS+dSq6y/i+LAvR56JiHAs7hAP70x1cJMPSjE9LEu3IfZ3zYrGoW/Egp3s2A==
X-Received: by 2002:a05:7500:3f91:b0:ef:ac4c:77db with SMTP id lo17-20020a0575003f9100b000efac4c77dbmr228970gab.20.1673451281906;
        Wed, 11 Jan 2023 07:34:41 -0800 (PST)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id y27-20020a05620a0e1b00b006bb2cd2f6d1sm9061570qkm.127.2023.01.11.07.34.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 07:34:41 -0800 (PST)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-4d13cb4bbffso79393547b3.3;
        Wed, 11 Jan 2023 07:34:41 -0800 (PST)
X-Received: by 2002:a05:690c:313:b0:37e:6806:a5f9 with SMTP id
 bg19-20020a05690c031300b0037e6806a5f9mr2693101ywb.47.1673451281019; Wed, 11
 Jan 2023 07:34:41 -0800 (PST)
MIME-Version: 1.0
References: <CAMuHMdXehA_n78nLXCwBdKV=So=6Vzjt5eye7ZE4bS_BvHnzEA@mail.gmail.com>
 <1671806417-32623-1-git-send-email-khoroshilov@ispras.ru>
In-Reply-To: <1671806417-32623-1-git-send-email-khoroshilov@ispras.ru>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 11 Jan 2023 16:34:28 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVnh6_7sTuvVNsu=4chCH4L3OfJ7qKKSCSv-9RyCjyG7Q@mail.gmail.com>
Message-ID: <CAMuHMdVnh6_7sTuvVNsu=4chCH4L3OfJ7qKKSCSv-9RyCjyG7Q@mail.gmail.com>
Subject: Re: [PATCH v2] clk: renesas: cpg-mssr: Fix use after free if
 cpg_mssr_common_init() failed
To:     Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc:     Chris Brandt <chris.brandt@renesas.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 3:40 PM Alexey Khoroshilov
<khoroshilov@ispras.ru> wrote:
> If cpg_mssr_common_init() fails after assigning priv to global variable
> cpg_mssr_priv, it deallocates priv, but cpg_mssr_priv keeps dangling
> pointer that potentially can be used later.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 1f7db7bbf031 ("clk: renesas: cpg-mssr: Add early clock support")
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> ---
> v2: Move cpg_mssr_priv assignment just before return 0; instead of
> clearing it as Geert Uytterhoeven <geert@linux-m68k.org> suggested.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk-for-v6.3.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
