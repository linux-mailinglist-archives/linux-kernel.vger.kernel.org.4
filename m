Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D77C73108B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 09:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243502AbjFOH2f convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 15 Jun 2023 03:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244871AbjFOH2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 03:28:23 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE2F2103;
        Thu, 15 Jun 2023 00:28:19 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-56fff21c2ebso16985527b3.3;
        Thu, 15 Jun 2023 00:28:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686814099; x=1689406099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6aCgTd1AzVYLSiaL/ArGFi9KO5j9jyzv9oqgVd3/+u8=;
        b=aQUnwV8sOf/n7KJmsbvAqfL4no9hE0k50BO9py1v4RnZ8z3hN1/tgeyKo9o5n6E6hV
         oL1cHnN+Ese6NBZa76+bja84ft/2ZlwkrjPswHzoPbxNjmydiGtFUzBdkTDaOfhehGnU
         SQOfCYTROD/oFrXNeYm/gB3ttkkLDbVRWY19XfY+RXChr902zqdS1HbTjerIN429nBYh
         Hewk8ED9WouwcQ6lg5/crpGNQ70S3Iouiky0x20yfxvpPwxJ2D9CuMmwcDRDZCBH9QFA
         6tjtxYkoYHdDY/H6xxCuL9AwkaP9nZouc7bOoPsr+ra9E/M+dGXUmv9L28Z4P06umMLs
         NHcw==
X-Gm-Message-State: AC+VfDxNKDXm8rjvj6xrpXqVm/xpMujKI3/p10kxrb31f6/XBVAlIDo6
        7m6vRucuKzREIZ1h/xkvDmNLjMunAwBQIg==
X-Google-Smtp-Source: ACHHUZ5Htnp4g0kXIRRG3EoKEriLEYU3UJZFEVXz/nUjtoyJevKiU1mfY5BYZbV1QMGUq9ktdAfs5g==
X-Received: by 2002:a81:6b87:0:b0:569:82b1:2ba5 with SMTP id g129-20020a816b87000000b0056982b12ba5mr4596677ywc.20.1686814098919;
        Thu, 15 Jun 2023 00:28:18 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id z22-20020a0dd716000000b00568c1c919d2sm3088825ywd.29.2023.06.15.00.28.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 00:28:18 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-bc4e41b7bc9so1432686276.2;
        Thu, 15 Jun 2023 00:28:18 -0700 (PDT)
X-Received: by 2002:a25:664a:0:b0:bc1:dfa5:83a4 with SMTP id
 z10-20020a25664a000000b00bc1dfa583a4mr4026240ybm.13.1686814098492; Thu, 15
 Jun 2023 00:28:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230614231446.3687-1-andriy.shevchenko@linux.intel.com> <20230614231446.3687-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230614231446.3687-2-andriy.shevchenko@linux.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 15 Jun 2023 09:28:05 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVo=fm6LSPODQVLTOZORD3BGpzR6_+mDEm-U5H8jsfDpw@mail.gmail.com>
Message-ID: <CAMuHMdVo=fm6LSPODQVLTOZORD3BGpzR6_+mDEm-U5H8jsfDpw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] gpio: aggregator: Remove CONFIG_OF and
 of_match_ptr() protections
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
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
> They stop the driver being used with ACPI PRP0001 and are something
> I want to avoid being cut and paste into new drivers. Also include
> mod_devicetable.h as we struct of_device_id is defined in there.
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
