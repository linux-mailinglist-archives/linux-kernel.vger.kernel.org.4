Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740D163B377
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 21:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbiK1UkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 15:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbiK1UkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 15:40:21 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC2A26C0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 12:40:19 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-3b5d9050e48so115886587b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 12:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=op85UqNDqqhgXPMT/OztrzjGize6Ei8/DsgSNPRSCmo=;
        b=qbSO/OrmasG6lZEdP1Oog/0qXiVsGH1Q0tIr4+Cd7Vo81RNBg23uaKLEAV/uOOvdZg
         0oDPp2HMMAdSmmGuk2xXUO0r8v6WSEepC5/ZgM5aWsFrCn1fCpDVoY0OAUbkCwDKsC/r
         HWux8ZaXqWX/dFJyyGfXNhdyLIDz6QMU/vkxVcSwtO79JoYBf7VgFR6xkeCskJJsZQwR
         gGS5LvjE9Ow+RmlwFGI9MZ363QCAXpANX3dVNcI5AWZd1hG4afVrdWMTMev0CoQ0gk6A
         o9Wu7pIfPDbEueUeK3pFpu2tt6JMWCkjQxzAQaDU+wi+50TvQDj0ZrElxEgJECgo1Hmx
         UcPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=op85UqNDqqhgXPMT/OztrzjGize6Ei8/DsgSNPRSCmo=;
        b=xzf3S9F/nDRbCzN30NPJxOo8HRW0+z3/jWU1/u0dKTddYvYaqzWQKeJNW7LnpMm7dr
         rbDj+CcgshA+DnBiI10yl4TR2OrDbWyiBB1Mldtw630wow4uQYoQ2qcMVBRGU/qUp7i0
         XP9ZdWRnTPab8pKnbHNfUc/UVNSvvVppC5aOjYUQEwur1dB5KRIlWGGGPXG31Gy4ZIsR
         W1sLlCsjYZrQYfB5UCPYdeR5R6vCmku6RU2ClkRAoD5PldIaHL8TU7rgxURkHrXQxnnd
         MZPCpQxRdVfx+bDH+Nbtrp6i/AzP9wLtxjM2qW6DYhTPoaoPP5BT7ersazHpL+39fSSY
         Bpmg==
X-Gm-Message-State: ANoB5pmSVlRv7C5MyPWUtjswNz2Nly1HR+XYkfBCFUH91wKm5Q7riKMW
        0ldXxq/bf2VH+ncE3rw+x55jEeeHi8UJt7NZ5jvVQA==
X-Google-Smtp-Source: AA0mqf6JfsCkbSGr9tJ8T2eyfoQ+ES4RRKRycWV86sboEeJs+mS8JErCkbvNzAH42lS2REB8eWzig3+tz7HDPacXsKQ=
X-Received: by 2002:a0d:d711:0:b0:3c3:dc9f:d24f with SMTP id
 z17-20020a0dd711000000b003c3dc9fd24fmr8756155ywd.343.1669668018805; Mon, 28
 Nov 2022 12:40:18 -0800 (PST)
MIME-Version: 1.0
References: <20221128190055.6350-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20221128190055.6350-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 28 Nov 2022 21:40:07 +0100
Message-ID: <CACRpkdYmwNHvA8fzkQjKPfvYx3RgAQUU2DqzgFFE+hKGpn0oRw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] gpiolib: Provide to_gpio_device() helper
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Mon, Nov 28, 2022 at 8:00 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Provide to_gpio_device() helper which can be utilized in the existing
> and future code.
>
> While at it, make sure it becomes no-op at compilation time.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Looks helpful.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
