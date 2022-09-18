Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D255BBE8E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 17:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiIRPAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 11:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiIRO77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 10:59:59 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E7A10FF6
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 07:59:58 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id e18so37868595edj.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 07:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=a7Psv9/SuPmGZBTyHTWK7DLwcV88pvhrenmZK8MN++E=;
        b=FdbG1djpGXA6Q54OfB5wYSzJYI9AG/sPZ/8BaaH6dWrNIpUu7tdh6rCn8niYRsO07R
         woOqEU5SKwup7ZV8liry7RtE8ZgMb/hkxJDxSanUhNaibVom31QZ+NCu1ZyFUxxpQ69D
         X5k7Nnl9szPVRwTwzjQNlqdMnVZ9+Xkd0yRLV7SpsQyrcBrcfiBeTo/SLnDjjOTHeSMf
         wJ3tvAGrfaSsp2k25PSJNqdHNNa96ZYU5KwOLweCCi1H9uWBmsVjU9oRzm2k5ZAd5N3P
         8KL9WZ6oLBF9QiLhtBIHb9Fohm4YUV6biJlwSsPjM/JgUA8gEatSXatJZS7IbmSLCkrf
         skLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=a7Psv9/SuPmGZBTyHTWK7DLwcV88pvhrenmZK8MN++E=;
        b=sA6ZIQy20lTVOXX5/WgIheP5Vj80ELLaBfgE4Vxkq/szDgWNtIw/eAVew3lND8l0CC
         h4Z/JdzjD5HtAFgH0Y4175yJIjWbby0C31iIEv3Hvawegjs0emmkQmZqf/jiFr76Rw9m
         s1C/w5SHewCWpykkjbzGXP2I7d0HfLx7oo3Tzx7rB+aqKSmAXKFCQFS9lspnzH8phUwY
         vQHrpFIX5RLffPVGYbAra73uMKc8KXZ32snkzUO+pbIb2+u7B0TqsPhP16e4WQQrRIW5
         LWChR8n8VM7e5LDLxsv90VUgXV8wo6cK20lTWmEQiZSFnsc/1bhmhpMunTdtDJpCDj4a
         pSBw==
X-Gm-Message-State: ACrzQf0/Zk1cJsmeroaW2AtiZXfXJzMw9Pszy55bBBvDQ1j6Fu6QQYyx
        /936JCUzvJRYYXkr0H2vbuRsN5xVw5ZFZwvpn90mdpxh+kE=
X-Google-Smtp-Source: AMsMyM76pCHSYNIZ5I7NndFZgidF0N8qsxgwejoczQtSswzo2pDKyxyUodIjYJ+JouUJmcN5OXiaNTo+obR3dC0nQOw=
X-Received: by 2002:a05:6402:2690:b0:452:3a85:8b28 with SMTP id
 w16-20020a056402269000b004523a858b28mr11514467edd.158.1663513196838; Sun, 18
 Sep 2022 07:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220917041403.4191780-1-benwolsieffer@gmail.com>
In-Reply-To: <20220917041403.4191780-1-benwolsieffer@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 18 Sep 2022 16:59:45 +0200
Message-ID: <CACRpkdac+qzpMhA3HtJ3w+dTk5Zp+OZyjpxH6QFhRmGk5h5_0w@mail.gmail.com>
Subject: Re: [PATCH RESEND 0/2] ARM: v7m: handle faults and enable debugging
To:     Ben Wolsieffer <benwolsieffer@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 17, 2022 at 6:14 AM Ben Wolsieffer <benwolsieffer@gmail.com> wrote:

> This series enables real exception handlers on no-MMU systems,
> increasing robustness in the face of buggy user- or kernel-space
> software. Previously, any fault would trigger the invalid exception
> handler, which would hang the system. With this series, faults only
> kill the offending process and allow the rest of the system to
> continue operating.
>
> The second patch in this series adds support for undefined instruction
> hooks, enabling software breakpoints through ptrace. Using this
> functionality currently requires a patch to gdb.
>
> This series has been tested on an STM32F746 (Cortex-M7).
>
> I would appreciate feedback in particular on the following questions:
> * Is the fault table formatting acceptable? Or should the lines be
>   wrapped/shortened?
> * Does my chosen mapping between faults and signals make sense?

Very few people use NOMMU so I would seek review from the
STM32 community.

The kernel looks better after than before the patches so:
Acked-by: Linus Walleij <linus.walleij@linaro.org>
but I do not fully understand this code, so my review is
a bit superficial.

Yours,
Linus Walleij
