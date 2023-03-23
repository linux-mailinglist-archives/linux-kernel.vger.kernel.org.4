Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5026C617C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 09:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjCWITB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 04:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjCWITA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 04:19:00 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22DB21961
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 01:18:59 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id j7so23843411ybg.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 01:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679559539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vkv5VdVcKoH0lEtU7ovkoGNklSMRmsrrWrNv42U6G7c=;
        b=Cc/yPVEY4QAUF/ywhzOPmHsUxVasaxgi5unp7BcQpz7kFgSFSOsOc6stK+M67F0EMs
         Mcp0CSBvGnuUHIwrPlRXKJXBWahsOncIq2vZ62c/2dJedabv/HL0SEOrKzFhh6GKCQMg
         iwmZlmx4B14vLsSraUmgiVjXItf5QhKpl9qTGkyUfEqLWfejnCCp+lW8egZVssfmhQCi
         R1a/rP+NYKbcoUJ7BA72vrkkc+Iak69iNjix/ATGO85qcFszNaYcl2CorBqs8BaUoH/U
         MpvmGhF+DaBvLjKbaxw1HwRg3OWh3tFIdZ+E2Yuh4Vryx6Hg8d29Z+n2XEwUk9h5cdJ0
         HH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679559539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vkv5VdVcKoH0lEtU7ovkoGNklSMRmsrrWrNv42U6G7c=;
        b=e1JvTazxhnQLZRUf9FaDEHLTMHmLbTpWJi/bbV9KHNOz8MD1OYiwjMzlnS4ePrrwTa
         CPbMRXFmGWDWXhF4uo1f3Ob8PUNuVcGr0JYOrvxBrOmhNh4pS1kshwrtNhuEJl8YQ8WA
         tbtNtl3uP7AshavnDnX7A50dI8kCkzq+4+ZhnbtASZz/RLwUS8ebDQr13g2zEr8NNZoz
         K8wGt3Fc390CqUVrVgtcJGeyRtlu8YCwiERBrbbVhq5lhn1MgR5ZsP/kChRDPtOkbNl9
         PM4eov52DEC9GDPkvL+JKOE1d+3CeBc63kyfJ6OmcyitmPb/Pwt+k80KUA5QdtmPQgzN
         axZw==
X-Gm-Message-State: AAQBX9cpl/6RaxXcKYX+PfpLQxQyWfvirJNtwIxGG2T1d6PWBqSJyoOB
        AohsgdfEOIU7aVyGT3lBDfEcTOUM4VlgZ2377VJmnuUSxg8ayA68
X-Google-Smtp-Source: AKy350ZLjXimPRHI6+yc14ua1fcJNf6TG9LroRTyO0u5TDtff6repGmXTQ0oSPcWRJp5dKk1DBj5utR/QLM4AQPxnF8=
X-Received: by 2002:a25:8712:0:b0:b74:3236:2fac with SMTP id
 a18-20020a258712000000b00b7432362facmr1730213ybl.4.1679559539253; Thu, 23 Mar
 2023 01:18:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230321135412.73240-1-andriy.shevchenko@linux.intel.com> <20230321135412.73240-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230321135412.73240-2-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 23 Mar 2023 09:18:48 +0100
Message-ID: <CACRpkda1fmm0uCwdUxo5bs14u50WR4C1B7XK1vmWdh5ECnaPSg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] gpiolib: Check array_info for NULL only once in gpiod_get_array()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 2:53=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> gpiod_get_array() has a long if-else-if branching where each of them
> tests for the same variable to be not NULL. Instead, check for NULL
> before even going to that flow.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

It's way more readable like this.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
