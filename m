Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386DB63241C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 14:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbiKUNnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 08:43:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbiKUNnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 08:43:08 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF9BC1F71
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 05:42:43 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 205so13593531ybe.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 05:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7fsoSstP+kTMnlGCyhKQpRZRy1Cn2GgHrvraYINr6P0=;
        b=tLc3HmTvsLWQ82lR6B6iR76sR+Rdyf6gUKpUNsZ4d59KxO6FQLRT9iCtd+a7WXb/Kv
         WxIy74c5i6veiZgMD1pSc7PMCo81tbqvtigJWx+oeTbCTVMgkCJtnB4IVQWgXi8c4dYV
         doqWeCsxIsTxu8Gg/k4eOLy9THzp+WH4k9RifTHJeQCYHlnqAucBFaPIG0r8dcNlR1NE
         wYwtslCMbW//KKggTSyDwe5TWzUhJ/1BrVdA3bg9o4czJ3x24VM4Mm3Xe3HEftKb6Jz9
         Na4BT06OHWdus37ULNZ1BQ7JoySXCk3w0OAoPqyMtruwirxUhZ2fiv7Fj7XfrsRItaJZ
         unrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7fsoSstP+kTMnlGCyhKQpRZRy1Cn2GgHrvraYINr6P0=;
        b=X19PMHRoFkfFeg0MrmzjMUKw8EoGmErhpA/uEhAvzJJPqHgeoRTo8ZyRI0Mv6pKuIX
         qpMwxK9p6ZwMQ37zXL2tMo4/bRYH7bMSXhyyKJYyMnHY5p/spaPjwovbMqmN1OAGWkyE
         PifkYzK4pHhAfRsuBXRDGCO9utKXe7ERbwD2mdgtq/FTZj/0VXUXWTZzuky3hAgp8XJM
         mPwgZKHx2TeuSoKd9CMSSpLhstgdAjkWZs0m4RzTD7bReKzKfAakVJtKRuFU3IdxlqzU
         bMB3D51ESuSSNC7mwiQWcYjtDVu1aZXtrdCg5Xef+ExOS5Q/Ilw5ttx4aY3vurqu9NEB
         plkw==
X-Gm-Message-State: ANoB5plj/ubbhbmP9H9Ou8zif6esET/FKRnOizqKcd42uAalb7ev3Jsd
        xBdEnx5AWFEymcT8MG6YGhGP1YX4yPx8A4QZdcEapQ==
X-Google-Smtp-Source: AA0mqf7D6nlXUukeFyw5JeCgOvxcdvH2H+0keXaRw1neBKuVwJvQY/4CuSboWYoyyNJkNwfRd/CnZz9h11UwJNgMk/M=
X-Received: by 2002:a25:acd1:0:b0:6b4:b9e3:c64b with SMTP id
 x17-20020a25acd1000000b006b4b9e3c64bmr17664071ybd.238.1669038162430; Mon, 21
 Nov 2022 05:42:42 -0800 (PST)
MIME-Version: 1.0
References: <20221117123034.27383-1-korotkov.maxim.s@gmail.com>
In-Reply-To: <20221117123034.27383-1-korotkov.maxim.s@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 21 Nov 2022 14:42:31 +0100
Message-ID: <CACRpkdY09f+VUn+F3smfNksUr0r5+xMhTn8kb3LAd0ot+8gpMg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: single: Fix potential division by zero
To:     Maxim Korotkov <korotkov.maxim.s@gmail.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        "Manjunathappa, Prakash" <prakash.pm@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 1:32 PM Maxim Korotkov
<korotkov.maxim.s@gmail.com> wrote:

> There is a possibility of dividing by zero due to the pcs->bits_per_pin
> if pcs->fmask() also has a value of zero and called fls
> from asm-generic/bitops/builtin-fls.h or arch/x86/include/asm/bitops.h.
> The function pcs_probe() has the branch that assigned to fmask 0 before
> pcs_allocate_pin_table() was called
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 4e7e8017a80e ("pinctrl: pinctrl-single: enhance to configure multiple pins of different modules")
> Signed-off-by: Maxim Korotkov <korotkov.maxim.s@gmail.com>

Patch applied for fixes.

Yours,
Linus Walleij
