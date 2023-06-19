Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58196735084
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 11:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbjFSJjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 05:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjFSJji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 05:39:38 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF92D187
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 02:39:36 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-77acb944bdfso195518039f.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 02:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687167575; x=1689759575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3S6m5Y25scP8HALvcaSJM0xoSq4jCZByGKuGX9HF7A=;
        b=bzhTNPKpiKBORfUH4L2aNV+I6EG+irZxbEbrZ84zKg+0ncfkN2VfRYcsUNesROadDo
         iEmndaBC/YZaQBMtJAmBOLpqjs9Wkwn0a75wMPa2NLJyoGpI9QIt0zVBvcDzqiE8IIjV
         iwmVk0t1Qqf4NylMzM6xr+df+FokJUO/1h8dM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687167575; x=1689759575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T3S6m5Y25scP8HALvcaSJM0xoSq4jCZByGKuGX9HF7A=;
        b=gpz/F3rRwDH9UbsoWYSbxPK6B5Gd1g6LwullhwH5KC887fgb8QwRv78nbYWHSRMKoa
         BWyDELnwbupURa9O++EGJtan7S565aO0RHZgxVGuK5bfNicJ3lkTfa9xWILld/r+sJJC
         XeSFkSeu1ddZhaZx+Sja/uIrS5sgHTTUonc1HzujPRGeHp2YSBauZbQrE7tspyUbDGeP
         n4yGnUovnKxOWKmsqqNcSgzzZdwkNv2spstyhKT+CCiQAk2N6zjwLSSL66IFCEtvzLzG
         r2tubcB8fEciHKZF6NC25UZJ1LixNCH9PNpfLd/LmV5Lc/P5NOvt28oIFFt7u8qrqwnd
         ir3A==
X-Gm-Message-State: AC+VfDxmN3e09lxSCv6jjfUHi2lnrSjXQkQBdYTg3tsj+7lzIVFZ4Yxc
        qiGR0UWktZUsm33W6Y2sBcQzi6z+2MyopNr/nMm1rg==
X-Google-Smtp-Source: ACHHUZ4tEq5eADpbRMuhULGhejLFgX7ROzDdd972tKSAjJEeMl8cnCzPyTQbTGgN+1LR52ojOgsRjg==
X-Received: by 2002:a5e:8516:0:b0:774:8786:1b59 with SMTP id i22-20020a5e8516000000b0077487861b59mr7618808ioj.11.1687167575730;
        Mon, 19 Jun 2023 02:39:35 -0700 (PDT)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com. [209.85.166.48])
        by smtp.gmail.com with ESMTPSA id b4-20020a02c984000000b004265e176da1sm1368540jap.76.2023.06.19.02.39.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 02:39:35 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-77acb944bdfso195517739f.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 02:39:35 -0700 (PDT)
X-Received: by 2002:a5e:d915:0:b0:74c:c6ed:6de with SMTP id
 n21-20020a5ed915000000b0074cc6ed06demr7033957iop.12.1687167574993; Mon, 19
 Jun 2023 02:39:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230619112253.v2.1.I13f060c10549ef181603e921291bdea95f83033c@changeid>
 <35f6212e-69f8-432f-a5c8-99ed5c844f11@moroto.mountain> <CAC=S1njwxLfw7LcnXkgY7pbiFaqvNQVyAzHVhK9+nYJC63d=Zw@mail.gmail.com>
 <32fa8c0e-26f4-4ee4-889a-4037530c128d@kadam.mountain>
In-Reply-To: <32fa8c0e-26f4-4ee4-889a-4037530c128d@kadam.mountain>
From:   Fei Shao <fshao@chromium.org>
Date:   Mon, 19 Jun 2023 17:38:58 +0800
X-Gmail-Original-Message-ID: <CAC=S1nhVZtmc=gz9umg2k83P3GiJWa1A4K-hUhJN7LM8qjTo6Q@mail.gmail.com>
Message-ID: <CAC=S1nhVZtmc=gz9umg2k83P3GiJWa1A4K-hUhJN7LM8qjTo6Q@mail.gmail.com>
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

On Mon, Jun 19, 2023 at 5:24=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> On Mon, Jun 19, 2023 at 05:05:47PM +0800, Fei Shao wrote:
> > On Mon, Jun 19, 2023 at 4:48=E2=80=AFPM Dan Carpenter <dan.carpenter@li=
naro.org> wrote:
> > >
> > > On Mon, Jun 19, 2023 at 11:22:53AM +0800, Fei Shao wrote:
> > > > devm_clk_notifier_register() allocates a devres resource for clk
> > > > notifier but didn't register that to the device, so the notifier di=
dn't
> > > > get unregistered on device detach and the allocated resource was le=
aked.
> > > >
> > > > Fix the issue by registering the resource through devres_add().
> > > >
> > > > Fixes: 6d30d50d037d ("clk: add devm variant of clk_notifier_registe=
r")
> > > > Signed-off-by: Fei Shao <fshao@chromium.org>
> > > > ---
> > > >
> > >
> > > Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
> > >
> > > How did you find this bug?
> > >
> > > I can think of some ways to find this bug with static analysis.
> > >
> >
> > It was actually detected by kmemleak on an unreleased Chromebook device=
.
> > I added the trace snippet in the message at first but removed that
> > before sending this. Maybe I shouldn't have.
> >
> > I can resend a v3 to add that back if that's preferable. What do you th=
ink?
>
> I'm not a clk maintainer, but let's not go overboard resending patches,
> especially when they're as straight forward as this one.
>
> This is good information though so I would include that kind of stuff in
> future patches.  I don't really need to see the kmemleak warning itself
> because I know what those look like already.  But to me it says a lot
> that actually this was detected at runtime.  It says good things about
> your test infrastructure and makes me feel more confident that your
> patch is correct.  So maybe just a comment that "This leak was detected
> by kmemleak".

That makes sense. Acknowledged and noted.

Thanks,
Fei

>
> regards,
> dan carpenter
>
