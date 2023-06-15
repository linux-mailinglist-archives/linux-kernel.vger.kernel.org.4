Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B71731156
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 09:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245171AbjFOHua convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 15 Jun 2023 03:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245183AbjFOHtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 03:49:35 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6CD2954;
        Thu, 15 Jun 2023 00:49:34 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-57012b2973eso14145757b3.2;
        Thu, 15 Jun 2023 00:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686815373; x=1689407373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/N4HOxpe3R7VAEziPmXAoAz30kELqVayFCH7HmO2Xwk=;
        b=NZqL0F9TFVdvJPgQBsEG6x6CgsegOATZ1OlWROtGHDpZZJTBOAFDhWZuw1y/P+qZ3Y
         wAg+YERqCKbsJ0N51gf7ZGx9HlXvPbeUK3wWGXhuYhRvXLAOKOjRG7/xQhlMFkmr2zkO
         qXHiSueQr8ukd4BwdZfAbGFaygxWvwjpEdjPNOvDKCyz6ZtLQjN/Xg81uQ66xlOO3Etr
         obSXioIziL2D41VKu9Waz15vs62OJmiv5Vxtnt5yllkh8ygoMToYwX3i9T+lueyhTQqI
         81LGf1qz1nUStmpuD8AlF/2PaocOywiFrZuzmszX2/a4nf60V2Qc9r2b5Ts0ereGVYNF
         wfZw==
X-Gm-Message-State: AC+VfDzBK9GVaMJisLXzgu215ATAiDzl0HDenRNOiXt8h2vh6PfYPCTn
        ZFoKH1htYcYDCFH9SjJj6gpIeeqSd9eaOA==
X-Google-Smtp-Source: ACHHUZ41bK/SZX/CyFN5kmtRVxde2Pqwcagc6GaWDlKKg3n/b0gpPrujOJTl24hiHwnvKcGrI8F2dQ==
X-Received: by 2002:a81:6f02:0:b0:56d:540b:ed07 with SMTP id k2-20020a816f02000000b0056d540bed07mr3900560ywc.48.1686815373667;
        Thu, 15 Jun 2023 00:49:33 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id t7-20020a815f07000000b0054f9e7fed7asm4319097ywb.137.2023.06.15.00.49.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 00:49:33 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-bc40d4145feso1380068276.1;
        Thu, 15 Jun 2023 00:49:33 -0700 (PDT)
X-Received: by 2002:a25:9343:0:b0:ba8:2403:bced with SMTP id
 g3-20020a259343000000b00ba82403bcedmr3414326ybo.2.1686815373278; Thu, 15 Jun
 2023 00:49:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230614231446.3687-1-andriy.shevchenko@linux.intel.com> <20230614231446.3687-5-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230614231446.3687-5-andriy.shevchenko@linux.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 15 Jun 2023 09:49:20 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWF9kUQ3JmN45JR8MCToOh5iOx-fPegtb91jn6ydz8b=A@mail.gmail.com>
Message-ID: <CAMuHMdWF9kUQ3JmN45JR8MCToOh5iOx-fPegtb91jn6ydz8b=A@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] gpio: delay: Remove duplicative functionality
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 1:14 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> Now that GPIO aggregator supports a delay line, drop the duplicative
> functionality, i.e. the entire gpio-delay driver.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
