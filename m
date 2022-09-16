Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4B85BAEEA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 16:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbiIPOGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 10:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbiIPOFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 10:05:45 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232C027FFD
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 07:05:44 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id s6so24546156lfo.7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 07:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=nPsSPucMBuKtAd8AfZmYJlLAtpXVu8go4ahtDG4VctY=;
        b=UmQ9IXGR6XcCNXRD2DdV5uYcKzvLhdmr2An44e3UEarwwC0ssykFVCSD9XSpivnMJS
         BTCNHB5aEiYWmpQ0B0Ha17T53z8CXBxGc6u0cf6KqNzgqalgKi69MrSZHYHD85ib0qVA
         D43sGYn6lNB3T7DBJ56h64qScbc/4GBc6bHr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=nPsSPucMBuKtAd8AfZmYJlLAtpXVu8go4ahtDG4VctY=;
        b=1BQI8vYIkoeQKClGi5YzItpCAVpU7mLFUU7vW70cO938steN/PaY0pzF1OWLYL2Ynz
         Ic6MmrCR4lbuOSJfoy0D0RLH8YakQffz/yFIGDD/fSmslWQ4IHZSym5bRB6Sib558aQk
         55Y0+LprnajxCMiRFDrn4W0gW56JbSwcwHCxPN5rjmiFIjdh7OOGoVUQgPIlReI7ODjv
         dmWc8Z3WwdE+JiSfyNVe/Xk/FmiQPqHmqwSo0B3UXl/FlXGeNWJEUTNKrkf2f7KY3z/P
         dRkGG6Fx5nsn3Qy9Ds7rhi1JxRGUymUhSkdu2E2ZFuh0TUYE+Vrjtbz5DQarS99pcP91
         HHCw==
X-Gm-Message-State: ACrzQf2h/PU5hbq7qHaRRTvxABWBzMn0bzn/IfkANLqehCS9e88imz73
        002FM1ZncecWiOwaA0jMjuY5/u59P9tV0uZu1l0=
X-Google-Smtp-Source: AMsMyM5dADF7wFp6uiIM32Son1X8Rn1+QFpvB/QVE8snSkAqaWJgsUzvnCXZpvwiQQKgO8ZxqtMfSw==
X-Received: by 2002:a05:6512:1287:b0:49e:f94f:eb72 with SMTP id u7-20020a056512128700b0049ef94feb72mr1898308lfs.376.1663337142151;
        Fri, 16 Sep 2022 07:05:42 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id r23-20020a2e8e37000000b00261e3856abcsm3557232ljk.102.2022.09.16.07.05.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Sep 2022 07:05:41 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id x27so2540598lfu.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 07:05:41 -0700 (PDT)
X-Received: by 2002:a05:6512:31c1:b0:498:fe7:b46 with SMTP id
 j1-20020a05651231c100b004980fe70b46mr1699244lfe.549.1663337140735; Fri, 16
 Sep 2022 07:05:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220916074253.781428-1-brgl@bgdev.pl>
In-Reply-To: <20220916074253.781428-1-brgl@bgdev.pl>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 16 Sep 2022 07:05:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh7XqYTJgDHGF5xYBNJEKtf1wQ7Gg3vjr+onevNN8uHvw@mail.gmail.com>
Message-ID: <CAHk-=wh7XqYTJgDHGF5xYBNJEKtf1wQ7Gg3vjr+onevNN8uHvw@mail.gmail.com>
Subject: Re: [GIT PULL] gpio: fixes for v6.0-rc6
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 12:42 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio-fixes-for-v6.0-rc6

I think you forgot to push the tag, there's no such thing.

I see the branch ("gpio/for-current") that contains that top commit,
but no fixes tag by that name.

              Linus
