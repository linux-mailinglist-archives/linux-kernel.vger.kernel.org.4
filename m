Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8742573366D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjFPQsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345411AbjFPQsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:48:09 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E7A3A89
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:48:05 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-977e0fbd742so126390466b.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686934082; x=1689526082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e16upKjJABhKcoxJWL82G3CWyoX8UGnrl2PWs2fRuIo=;
        b=jjBZg1+GpudykS92bk6Szs5QJqH18eEIibrB/9Wq+dOJV7tgt2Vg1ZrOjG3F7c43cv
         LS33cL3d3C77HCi0sgafJtcc4kL5o1rEbuw7e5zCxWBU6D+sp5SKySc3b/AikCSQNjE5
         YbjdkF0BIAFm9Zy0FozQ8eC0Zpc66KUlx7IW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686934082; x=1689526082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e16upKjJABhKcoxJWL82G3CWyoX8UGnrl2PWs2fRuIo=;
        b=UdeS/R4bl4cGZykTAnLSGrCdt3M//ciPXVvoSj//L+ggZY2m5skRmiiQgwwx2u4PPN
         zZfYB/xS8wZ21uYlfw84ZEAu3U2zakO6XuA7sIIb8xvgEq91DYeucme+ZHAzByl9nlj0
         XmFxTTFRfMRuNUun7b6sfR8sFJWGLzEV4UW5BqV56BgLrXpq8MK7Jg0+HkvE8PVSVSbN
         VJWz4N9XZvaph75pJGv4e03WnOKCnHgAKD5BVOJr9h42zweoA/q6WToZyfbcPNJuMwej
         ydg+PaG58bVeoJNRptW+iEbIhGzSFUBjqV/oouTHWwzK2gTXruWfd7lhRImeMudAl992
         HoaQ==
X-Gm-Message-State: AC+VfDzxBz0HthWcwZ9FwiTWltHSWjd3LZOJ1ARLMK8LMtY08qxxIlkL
        P1VNYOLTJgDJN9bJnn4ULaUWH/6zcl6MGqq9M5ki42Ls
X-Google-Smtp-Source: ACHHUZ5Z+3zJFietsVb9QY98rpPLNmZibwIOwP9H3mePwsUunz7rKAWz13i3v6HWlSCB1uaObEIxjw==
X-Received: by 2002:a17:907:3f17:b0:978:8f29:8c85 with SMTP id hq23-20020a1709073f1700b009788f298c85mr2261085ejc.32.1686934082484;
        Fri, 16 Jun 2023 09:48:02 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id g19-20020a17090613d300b0097889c33582sm11019335ejc.215.2023.06.16.09.47.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 09:48:00 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-3f81b83b8d5so925e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:47:59 -0700 (PDT)
X-Received: by 2002:a05:600c:444e:b0:3f4:2736:b5eb with SMTP id
 v14-20020a05600c444e00b003f42736b5ebmr415495wmn.1.1686934079227; Fri, 16 Jun
 2023 09:47:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230616150618.6073-1-pmladek@suse.com> <20230616150618.6073-3-pmladek@suse.com>
In-Reply-To: <20230616150618.6073-3-pmladek@suse.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 16 Jun 2023 09:47:47 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VPhpZyJO=U3NGy1RZbmAQS_xEoDs-K2HawJYb=UHaUww@mail.gmail.com>
Message-ID: <CAD=FV=VPhpZyJO=U3NGy1RZbmAQS_xEoDs-K2HawJYb=UHaUww@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] watchdog/hardlockup: Make the config checks more straightforward
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        sparclinux@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 16, 2023 at 8:07=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> There are four possible variants of hardlockup detectors:
>
>   + buddy: available when SMP is set.
>
>   + perf: available when HAVE_HARDLOCKUP_DETECTOR_PERF is set.
>
>   + arch-specific: available when HAVE_HARDLOCKUP_DETECTOR_ARCH is set.
>
>   + sparc64 special variant: available when HAVE_NMI_WATCHDOG is set
>         and HAVE_HARDLOCKUP_DETECTOR_ARCH is not set.
>
> The check for the sparc64 variant is more complicated because
> HAVE_NMI_WATCHDOG is used to #ifdef code used by both arch-specific
> and sparc64 specific variant. Therefore it is automatically
> selected with HAVE_HARDLOCKUP_DETECTOR_ARCH.
>
> This complexity is partly hidden in HAVE_HARDLOCKUP_DETECTOR_NON_ARCH.
> It reduces the size of some checks but it makes them harder to follow.
>
> Finally, the other temporary variable HARDLOCKUP_DETECTOR_NON_ARCH
> is used to re-compute HARDLOCKUP_DETECTOR_PERF/BUDDY when the global
> HARDLOCKUP_DETECTOR switch is enabled/disabled.
>
> Make the logic more straightforward by the following changes:
>
>   + Better explain the role of HAVE_HARDLOCKUP_DETECTOR_ARCH and
>     HAVE_NMI_WATCHDOG in comments.
>
>   + Add HAVE_HARDLOCKUP_DETECTOR_BUDDY so that there is separate
>     HAVE_* for all four hardlockup detector variants.
>
>     Use it in the other conditions instead of SMP. It makes it
>     clear that it is about the buddy detector.
>
>   + Open code HAVE_HARDLOCKUP_DETECTOR_NON_ARCH in HARDLOCKUP_DETECTOR
>     and HARDLOCKUP_DETECTOR_PREFER_BUDDY. It helps to understand
>     the conditions between the four hardlockup detector variants.
>
>   + Define the exact conditions when HARDLOCKUP_DETECTOR_PERF/BUDDY
>     can be enabled. It explains the dependency on the other
>     hardlockup detector variants.
>
>     Also it allows to remove HARDLOCKUP_DETECTOR_NON_ARCH by using "imply=
".
>     It triggers re-evaluating HARDLOCKUP_DETECTOR_PERF/BUDDY when
>     the global HARDLOCKUP_DETECTOR switch is changed.
>
>   + Add dependency on HARDLOCKUP_DETECTOR so that the affected variables
>     disappear when the hardlockup detectors are disabled.
>
>     Another nice side effect is that HARDLOCKUP_DETECTOR_PREFER_BUDDY
>     value is not preserved when the global switch is disabled.
>     The user has to make the decision again when it gets re-enabled.
>
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  arch/Kconfig      | 23 +++++++++++++-----
>  lib/Kconfig.debug | 62 +++++++++++++++++++++++++++--------------------
>  2 files changed, 53 insertions(+), 32 deletions(-)

While I'd still paint the bikeshed a different color and organize the
dependencies a little differently, as discussed in your v1 post, this
is still OK w/ me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
