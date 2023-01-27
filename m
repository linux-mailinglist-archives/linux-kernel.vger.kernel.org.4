Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0798F67EA1F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 16:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbjA0P6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 10:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbjA0P6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 10:58:47 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134D78663D
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 07:58:41 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id g9so3552748pfo.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 07:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qLM9fJV2OakKqd36YJxxEJYAlIbXLOshTjOPLX8PU4c=;
        b=VpL/jhAfmgxTZiKa9pK4rSG5AUZUiNfO1qMX9Z/MFlW2cTsUwk2IEUji//2c37ACVW
         87jg3kuYQscpybE7Xk5XWJYixUvz5AG71KBllyuo+hG4t4zbJxmHwf5wKGr33bwFkaH/
         WFbRWD62OenZYXyv0FR4CUzsbm8md7tTo4KcRO+9EXs4tKFYmfp4N4tHIJCblBU8RgeL
         YaxSWz8q6b0wDDTTUQ8fkc2qu1OkgEvB4q2m+fSnILZF72EviUkk2xIkUtkzcvdXWmZB
         o6nHG1ZcHPU4T0Ea3StcApx/ZFhaBTUCVSwMN0yTNrYWTinH5K7MuFDaKA9GThTtc2Wp
         Gsww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qLM9fJV2OakKqd36YJxxEJYAlIbXLOshTjOPLX8PU4c=;
        b=rQUvJ8eN/xgxLXDWbrIR1QVJgiuxw0fDdExBdul5oqa8wRRRJ0qEMdPQ/tCJQizpzX
         qj1xJQNdX5zbKaEbF5eFbuD3Jtf0Mj6xeQErbZ/IjEKA1EriRqzwm4MuLpzUvWNHSD9p
         if2gjb/zYshjlIBYOtE//S8E79RP4oiSvgM7jHAdHiIDxJYFKOlulSjTMZTT/6ykGMDK
         0qTrB3mH3OUlh7YIONpUepX2a6G6WTDjY51WWQtQ1DFpnXTFFmUo2Ex7huDSeE1UDbU4
         xYy0kN40CMOI3HESe0rOXsiGg+dI/Ia/QSYB+3xpO67Xp3+4zXNpTM1pAcxs9FpXBugl
         dvpA==
X-Gm-Message-State: AO0yUKX1IdwqNT2VjXlCaQxYsmCfY26072m9+ZvBQIfHnHFxY1t6z+hs
        z629T0k6HgR+3/lbpWUVT+qhHcXVKnuSvNUTutsGcg==
X-Google-Smtp-Source: AK7set8Lvh1ZvALlREZDK1x12Ja5QDTTn/XlXrMHn/IHabRBY+Ekk/B6e9azuI+e7w5Vjk85sHbngcoBtygXHUBUmbQ=
X-Received: by 2002:a62:1a4c:0:b0:592:5cbf:c71f with SMTP id
 a73-20020a621a4c000000b005925cbfc71fmr700905pfa.29.1674835120584; Fri, 27 Jan
 2023 07:58:40 -0800 (PST)
MIME-Version: 1.0
References: <20230127154339.157460-1-ulf.hansson@linaro.org> <5743fb1b-eb4b-d169-a467-ee618bcd75f5@kernel.dk>
In-Reply-To: <5743fb1b-eb4b-d169-a467-ee618bcd75f5@kernel.dk>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 27 Jan 2023 16:58:04 +0100
Message-ID: <CAPDyKFqFrB4h21F0901nBp-mpiP70nObOrCpRA0ZRfOD_kD5ug@mail.gmail.com>
Subject: Re: [PATCH] block: Default to build the BFQ I/O scheduler
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jan 2023 at 16:48, Jens Axboe <axboe@kernel.dk> wrote:
>
> On 1/27/23 8:43=E2=80=AFAM, Ulf Hansson wrote:
> > Today BFQ is widely used and it's also the default choice for some of t=
he
> > single-queue-based storage devices. Therefore, let's make it more
> > convenient to build it as default, along with the other I/O schedulers.
> >
> > Let's also build the cgroup support for BFQ as default, as it's likely =
that
> > it's wanted too, assuming CONFIG_BLK_CGROUP is also set, of course.
>
> This won't make much of a difference, when the symbols are already in
> the .config. So let's please not. It may be a 'y' for you by default,
> but for lots of others it is not. Don't impose it on folks.

This isn't about folkz, but HW. :-)

I was thinking that it makes sense for the similar reason to why kyber
and deadline are being built as default. Or are there any particular
other reasons to why we build those in as default, but not BFQ?

Kind regards
Uffe
