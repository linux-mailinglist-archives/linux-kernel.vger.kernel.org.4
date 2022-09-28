Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700285EE68E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 22:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbiI1UUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 16:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234484AbiI1UUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 16:20:17 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261F06E8BC
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 13:20:04 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id j10so8681293qtv.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 13:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=910BBTQr5adgJwQHpSIQOnfPtqGf4FO7r1/P+t7eo0c=;
        b=Y3iaQ2YYlSqa8vkkMsEBi1XYR4rXcL7kLH1dytBT5aEfxTUeDXnY/4m/ZJ3R/dtZMM
         t/pP36VkSaGCSOEPqfRduz8zZmrBVIxVL2uIxK/IXwW0INuVIPsivDbLNCuckpZwYDei
         v00Ap6HOXS2ux8XfCQbsgeuOEFGudjskFTdwOHlWiJnopH+r7zChoyPvzflZjb7n2XU3
         Vxz10jQvQIobj6QcT8IjWAGzTrVOQwvlnsPy6HRFoJXw6sL63oEvoxraFQ+0AsY6T9og
         ASmKOTQ6Dk02W7xh0qmW/amqNBFO4TNQJkqlEAVxpXfUttYq8reca/SrS2niXIr4Df0q
         iVFw==
X-Gm-Message-State: ACrzQf3tMR9g0nxJ7go3klEGrIhlP5Q4ZY79DQ7ETw+Afp8MrTsOflqI
        7MatRLbJcVARDKSg+zz/uRQv/UC8aqzF3w==
X-Google-Smtp-Source: AMsMyM5O/DvuEA937aVBngGLK1kuTy3GpOoHGFsCVE5pqCrYadj36AiGZFQGMW13Roeaum2zvKvBUg==
X-Received: by 2002:ac8:7dc6:0:b0:35c:c9b1:9f98 with SMTP id c6-20020ac87dc6000000b0035cc9b19f98mr29033140qte.170.1664396403151;
        Wed, 28 Sep 2022 13:20:03 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id f8-20020a05620a280800b006b929a56a2bsm3832893qkp.3.2022.09.28.13.20.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 13:20:02 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 63so17338049ybq.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 13:20:02 -0700 (PDT)
X-Received: by 2002:a25:8e84:0:b0:696:466c:baa with SMTP id
 q4-20020a258e84000000b00696466c0baamr30857137ybl.604.1664396402294; Wed, 28
 Sep 2022 13:20:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220927130835.1629806-1-Jason@zx2c4.com> <20220927130835.1629806-2-Jason@zx2c4.com>
In-Reply-To: <20220927130835.1629806-2-Jason@zx2c4.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 28 Sep 2022 22:19:50 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUxQYYRh9oa-Ro791RynVrPZT07u9-HrFLe8RR-+Vj3_A@mail.gmail.com>
Message-ID: <CAMuHMdUxQYYRh9oa-Ro791RynVrPZT07u9-HrFLe8RR-+Vj3_A@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] m68k: rework BI_VIRT_RNG_SEED as BI_RNG_SEED
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Laurent Vivier <laurent@vivier.eu>
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

On Tue, Sep 27, 2022 at 3:09 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> This is useful on !virt platforms for kexec, so change things from
> BI_VIRT_RNG_SEED to be BI_RNG_SEED, and simply remove BI_VIRT_RNG_SEED
> because it only ever lasted one release, and nothing is broken by not
> having it. At the same time, keep a comment noting that it's been
> removed, so that ID isn't reused. In addition, we previously documented
> 2-byte alignment, but 4-byte alignment is actually necessary, so update
> that comment.
>
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Laurent Vivier <laurent@vivier.eu>
> Fixes: a1ee38ab1a75 ("m68k: virt: Use RNG seed from bootinfo block")
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v6.1 branch.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
