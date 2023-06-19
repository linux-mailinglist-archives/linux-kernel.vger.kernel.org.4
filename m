Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02AE0734F1E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 11:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjFSJGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 05:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjFSJG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 05:06:28 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAC5102
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 02:06:26 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-77e2c42de06so91829139f.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 02:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687165585; x=1689757585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73UFP3t8bqb8g7lRxRg12r50WZsfcyr2bTaBvl7g6DI=;
        b=Mn+nKD/wyB3o0mN9yxlPrEFihNKnSHUo62EkRjzNmL3X4A8nrX3j8pirPx03mWoGVd
         U7Th91y2IRLJHrFAM5ocqsuO2zGew8ddd5M3x+bALzSdUju/RHJV406udcHlOSjZ5Mm+
         Jtxl2QSf+7v/OL28dfLjB5KCN/m3UtFelr9+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687165585; x=1689757585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=73UFP3t8bqb8g7lRxRg12r50WZsfcyr2bTaBvl7g6DI=;
        b=NwCupoiIq4vjH1eMmcJHayJfSqAoL+37cY1GaXAnpObN1KZxNLjeiBaQUIAzs4rTQT
         tXVl2CxqC6+ilVifC2VICWx/hAoPMwg2K6piGEA7k/fIFS0yESWYm2E6dFyZsJqWUJle
         tmHF2fz6EEmR2tJrLGVcQGdK4ASuV4u7ZEQwjfrYV8dbHnSjIs3cu/LCiGbLP1YwiBWs
         8AoiI8JoCFHdyC7RG4bHjGQPSG3dSCfYia/GLb0DurF9+kjP5ZilQdOP7BQu7rELLeKY
         2FBHmb0omD9KK96EEO7aaRlH8FjodXe9ETP0B/odTnx2rWYlHIjp6ZnqA1j28/VbHi9E
         wcig==
X-Gm-Message-State: AC+VfDyfuL2IczQ5je/2Lwh5qR68weVIaCOMnJ3X8wQswNtZvwKjfpKA
        8ffoX0/PY6iRw1CFoQIx+2p1ZvRy4WeR8gHfcm369Q==
X-Google-Smtp-Source: ACHHUZ5GRFpgFYkOxWdVKAYkWgaUrohsQNMsjBmGZZTogWOM0VQ0KQzpW36mM6uD0AZ5CJsninGaJA==
X-Received: by 2002:a5e:8505:0:b0:77a:c494:b4bc with SMTP id i5-20020a5e8505000000b0077ac494b4bcmr6751930ioj.20.1687165585642;
        Mon, 19 Jun 2023 02:06:25 -0700 (PDT)
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com. [209.85.166.54])
        by smtp.gmail.com with ESMTPSA id 16-20020a0566380a5000b0041675393f68sm4722516jap.6.2023.06.19.02.06.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 02:06:24 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-77e357f8faeso62237839f.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 02:06:24 -0700 (PDT)
X-Received: by 2002:a05:6602:2013:b0:763:5f1b:2f6f with SMTP id
 y19-20020a056602201300b007635f1b2f6fmr7963281iod.7.1687165584097; Mon, 19 Jun
 2023 02:06:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230619112253.v2.1.I13f060c10549ef181603e921291bdea95f83033c@changeid>
 <35f6212e-69f8-432f-a5c8-99ed5c844f11@moroto.mountain>
In-Reply-To: <35f6212e-69f8-432f-a5c8-99ed5c844f11@moroto.mountain>
From:   Fei Shao <fshao@chromium.org>
Date:   Mon, 19 Jun 2023 17:05:47 +0800
X-Gmail-Original-Message-ID: <CAC=S1njwxLfw7LcnXkgY7pbiFaqvNQVyAzHVhK9+nYJC63d=Zw@mail.gmail.com>
Message-ID: <CAC=S1njwxLfw7LcnXkgY7pbiFaqvNQVyAzHVhK9+nYJC63d=Zw@mail.gmail.com>
Subject: Re: [PATCH v2] clk: Fix memory leak in devm_clk_notifier_register()
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 4:48=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> On Mon, Jun 19, 2023 at 11:22:53AM +0800, Fei Shao wrote:
> > devm_clk_notifier_register() allocates a devres resource for clk
> > notifier but didn't register that to the device, so the notifier didn't
> > get unregistered on device detach and the allocated resource was leaked=
.
> >
> > Fix the issue by registering the resource through devres_add().
> >
> > Fixes: 6d30d50d037d ("clk: add devm variant of clk_notifier_register")
> > Signed-off-by: Fei Shao <fshao@chromium.org>
> > ---
> >
>
> Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
>
> How did you find this bug?
>
> I can think of some ways to find this bug with static analysis.
>

It was actually detected by kmemleak on an unreleased Chromebook device.
I added the trace snippet in the message at first but removed that
before sending this. Maybe I shouldn't have.

I can resend a v3 to add that back if that's preferable. What do you think?

Regards,
Fei


> KTODO: static analysis:  look at unused parameters
>
> Both GCC and Clang have a warning for unused parameters.  I think the
> last time I looked at GCC it had a lot of false positives for functions
> which were called as pointers but hopefully that has been fixed now?
> Smatch does not have a check for this.  If someone were to write it,
> I would probably the check under the --pedantic flag so it would be
> turned off by default.
>
> regards,
> dan carpenter
>
