Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11A16EA49C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 09:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjDUHXD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 21 Apr 2023 03:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjDUHW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 03:22:58 -0400
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5CF7DA8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 00:22:53 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-b95fb433f59so2255884276.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 00:22:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682061772; x=1684653772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hLEuRPRVqiyPqb5mT4V70+1gAbABfgeYALOY9oNVc/o=;
        b=TItnnwXXha9LHLwCG09Yn1j6OLkaB7YPr6I3iMhxXMEWHdzjY2SAGAF7Qr4SwaIYn2
         N6rtqhASW1vqwiSW5KFhuVMgKFV6cF5UGhHhRcZzznwS+csfXd3uMCI0IjSom01wH3fB
         UsnWfXQWlFzDi1B3aw0OdvtUOpfTFqpEISK1PJu1MBv1wrCDnHqbQevoPUgBLU0Lu0Lv
         Uoy0CUW0R8ZGTmdM8vjtArbzos82BPxxeD75vDYcYu03XEcPCNCPszEYx61JBxQvc2ST
         l7v/8RiBt9YzdfRQx5MFSKWPGXmQrGo5QkFfADpSD9pXX+u+QuCTWLPboea8XD1+3sMb
         Nc8Q==
X-Gm-Message-State: AAQBX9cpNkw+Emnhw+hG8isPft7d0O//8y0tY6r/Nw9hSkEW35U51Ahi
        KCsl0zpeqB9/6MjkQGwWq2t1555S6bT2bOOC
X-Google-Smtp-Source: AKy350Yb+YbPhmJrAmkG4olm1jGUfHyDYnooVu9cYeTyuErc9Ng/R0RxjJpFtnvzEVq5MTxCdbEz/A==
X-Received: by 2002:a25:1683:0:b0:b8f:54a4:9a55 with SMTP id 125-20020a251683000000b00b8f54a49a55mr1125478ybw.65.1682061772443;
        Fri, 21 Apr 2023 00:22:52 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id q189-20020a815cc6000000b00555abc57d5fsm807785ywb.97.2023.04.21.00.22.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 00:22:52 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-54f8af6dfa9so20604817b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 00:22:52 -0700 (PDT)
X-Received: by 2002:a0d:d709:0:b0:54f:b26f:bc8 with SMTP id
 z9-20020a0dd709000000b0054fb26f0bc8mr1129079ywd.26.1682061772045; Fri, 21 Apr
 2023 00:22:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230420073751.1031944-1-yunchuan@nfschina.com>
In-Reply-To: <20230420073751.1031944-1-yunchuan@nfschina.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 21 Apr 2023 09:22:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWRRjo3mEBSeUvDrw1wK9EfzGuohi7zSzh6SZ8bY25FBg@mail.gmail.com>
Message-ID: <CAMuHMdWRRjo3mEBSeUvDrw1wK9EfzGuohi7zSzh6SZ8bY25FBg@mail.gmail.com>
Subject: Re: [PATCH] firmware:Remove unnecessary (void*) conversions
To:     yunchuan <yunchuan@nfschina.com>
Cc:     kabel@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yunchan,

On Thu, Apr 20, 2023 at 9:41 AM yunchuan <yunchuan@nfschina.com> wrote:
> Pointer variables of void * type do not require type cast.
>
> Signed-off-by: yunchuan <yunchuan@nfschina.com>

> --- a/drivers/firmware/turris-mox-rwtm.c
> +++ b/drivers/firmware/turris-mox-rwtm.c
> @@ -283,7 +283,7 @@ static int check_get_random_support(struct mox_rwtm *rwtm)
>
>  static int mox_hwrng_read(struct hwrng *rng, void *data, size_t max, bool wait)
>  {
> -       struct mox_rwtm *rwtm = (struct mox_rwtm *) rng->priv;

hwrng.priv is unsigned long, so the cast is needed.
Please try to (at least) test-compile your changes.

NAKed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> +       struct mox_rwtm *rwtm = rng->priv;
>         struct armada_37xx_rwtm_tx_msg msg;
>         int ret;


Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
