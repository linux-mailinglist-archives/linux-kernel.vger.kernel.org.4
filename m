Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CDF72A432
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 22:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjFIUPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 16:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjFIUPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 16:15:43 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174A72D5F
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 13:15:41 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id ada2fe7eead31-43b54597d3cso620728137.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 13:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1686341740; x=1688933740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=raGvAg29sSFwcM9RybsJx6+tqHFKznCftHEYSM8PqQ4=;
        b=pPNHsRh9XiWRLgHB0psr+DFRlrIRviKoHNYjlD3Z2cAP6yYCcNYhAjkk4gy21UwZ5e
         t8KNonsK5yKuN/oy7DksWVDxaBxUsNCI44HBD2rpaVVUxooIdgVaBZrHDpgV+eMLT+qs
         9oy2zhNURd+ECpyD92bcnVa8viSrPWkhYVYzvQTIczSgH8rhBnzfth76pw2wfWL39z+N
         CO92EIGZXp7n9l1uWigMJEUNLCsQa5Ct6RK3slYzQ6kviSoO8JybSKggVuS7Jmji6cGA
         /E5MXZRmswlRVAkRh0doAjJdla9rKLboqyGYeW/WL0OzxLFrhhoGD2zt6zl/MBpyqvL0
         7QVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686341740; x=1688933740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=raGvAg29sSFwcM9RybsJx6+tqHFKznCftHEYSM8PqQ4=;
        b=iloZb4gwEc02EJ7j+bte1RuG73hTJvgo18rmBVOskYxOzPjelUF+PG1/QgHBeURIQn
         4Su2qjca6PyAqA1HuZ5wLBrOn+nWl9TUxO3zWKEgTnsfj9mn9wP/0GAv/Xm7nUjtg0+f
         gOess29HuylCw7IrRK/2KFT4vGh7blaExW2SZf3Jv1hmpFpyDFMsG2jzazmSiLKiQvvp
         JXYF8nQrVWPLLtwQfIOI5aqgLgGnGFJuhZre2XdgmAiVqBYZjtbc72w6aetsl0M0Nul8
         SqyJX6Fxb8xmBtxeSDXgq331FJq86sYpuII7M94rVCQAGyTZbJVGmIMUnkcOxWE8DKlp
         +SUA==
X-Gm-Message-State: AC+VfDyLmCfF/RbJfc9nKIwb54URLMP2vecYYH2xqUqFEYT2ppFS+2Ov
        5WuIpqv9VCKtiP/22DAS1Ejpg6/N76kMi/rdScZuhg==
X-Google-Smtp-Source: ACHHUZ6buQWS9YCWGt3+h3H7ytmFRag705dKxxCwPKDrEa608VLfIidhHQ3FzwOdmHPVkkzqVsIHN/lz359RcfvV0DI=
X-Received: by 2002:a67:f241:0:b0:43b:2551:5172 with SMTP id
 y1-20020a67f241000000b0043b25515172mr1263807vsm.24.1686341740176; Fri, 09 Jun
 2023 13:15:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230609143609.209373-1-brgl@bgdev.pl> <CAL_JsqK77OW3n0PW6zP3FNdmuQHnDp9=wfX4E3ga-VW0_LRHHA@mail.gmail.com>
In-Reply-To: <CAL_JsqK77OW3n0PW6zP3FNdmuQHnDp9=wfX4E3ga-VW0_LRHHA@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 9 Jun 2023 22:15:29 +0200
Message-ID: <CAMRc=Mc7bbaDA1g3gn79XJZL6bTPGf9xZsB3=A4oiMUggzb4kA@mail.gmail.com>
Subject: Re: [PATCH] of: unittest: drop assertions for GPIO hog messages
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 9, 2023 at 7:01=E2=80=AFPM Rob Herring <robh+dt@kernel.org> wro=
te:
>
> On Fri, Jun 9, 2023 at 8:36=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
> >
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > These have now been demoted to debug and are normally hidden. Drop the
> > assertions entirely.
> >
> > Suggested-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  drivers/of/unittest.c | 28 ----------------------------
> >  1 file changed, 28 deletions(-)
>
> Why is this a separate patch? Don't I get at least 5 days to
> review/ack changes in drivers/of/?
>

Sorry, my bad, I queued the previous one through the GPIO tree after
it was reviewed here thinking the unittests bits are trivial. I can
back it out if you insist or you can ack this one and the end effect
is the same? I will pay attention in the future.

Bart
