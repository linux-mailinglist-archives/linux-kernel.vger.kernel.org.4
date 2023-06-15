Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C9C731112
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 09:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243061AbjFOHnQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 15 Jun 2023 03:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243616AbjFOHnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 03:43:13 -0400
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A3BC7;
        Thu, 15 Jun 2023 00:43:10 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-bcd0226607bso774808276.1;
        Thu, 15 Jun 2023 00:43:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686814989; x=1689406989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=177lHBIsC10let9ZIn43z1ulzQ4KlS1gYZFsJnXrgOA=;
        b=S5LETFWiE1qSMRh8wLneZcEl3+bVylv7Ot1Y1Y3VfvB0ve9El7ZoWF7ZjtXN4fGTg+
         nJ8Dl+iFyiG83/2SsGQgHpvCRFTxPXFX4suPld9YiDrcSGw/Eq101nDxFrhn1TE0TrgE
         jxfENM3I5BB9roHXKOKrS8lV5FHvIsJB3kStCe5OXPx5wKLBmU00LJET4yDR830IETu2
         SnIxqVQMF7ATbvN8RvgAcQv7xY6dcyLMgS01mjNX1oh+MMKdwahWkCSM2S4CcwACMivH
         ey4E3B9xSMfR2muxyVmiBBQVflkt+m7ZDg75ii0A8E/0OVqaPkha8t6oeaW8RgE6P6ZG
         yfAA==
X-Gm-Message-State: AC+VfDzWoDkmvfOv1oftwv6Eid2g4h+9yXt1/cYSmKJuil9lmO49X4/l
        4xFI33Xp/s6SXmT/+aU+MdFOHRj+tSvblw==
X-Google-Smtp-Source: ACHHUZ78UHNS0DTJx6FfPrQBUJ9f6ZQwiK+MNNFrWXhgthja2I0koq/pfW1PZtlnSUfTCx2d093jmA==
X-Received: by 2002:a25:588:0:b0:b8f:3990:636d with SMTP id 130-20020a250588000000b00b8f3990636dmr4655265ybf.23.1686814989101;
        Thu, 15 Jun 2023 00:43:09 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id s7-20020a5b0447000000b00bd232859d10sm1185086ybp.33.2023.06.15.00.43.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 00:43:08 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-bc43a73ab22so815613276.0;
        Thu, 15 Jun 2023 00:43:08 -0700 (PDT)
X-Received: by 2002:a25:abaf:0:b0:bc4:4d17:75e1 with SMTP id
 v44-20020a25abaf000000b00bc44d1775e1mr4967743ybi.8.1686814988667; Thu, 15 Jun
 2023 00:43:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230614231446.3687-1-andriy.shevchenko@linux.intel.com> <20230614231446.3687-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230614231446.3687-3-andriy.shevchenko@linux.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 15 Jun 2023 09:42:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXOcQhK9KAwm-oSWvzD2axpwz+rcbSPDe-yrC=u+=Zz0w@mail.gmail.com>
Message-ID: <CAMuHMdXOcQhK9KAwm-oSWvzD2axpwz+rcbSPDe-yrC=u+=Zz0w@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] gpio: aggregator: Support delay for setting up
 individual GPIOs
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 1:14 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> In some cases the GPIO may require an additional delay after setting
> its value. Add support for that into the GPIO forwarder code.
>
> This will be fully enabled for use in the following changes.
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
