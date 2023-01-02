Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014F765B3DB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 16:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236308AbjABPIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 10:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236283AbjABPIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 10:08:04 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A7C95AB
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 07:07:58 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id 18so6631718pfx.7
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 07:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=32Padg+6hCGNbUOr+i7YKPADHH8ODZ6PAm/7FSi080w=;
        b=o3kDDhSg/4BKw0h3LN7nnLkP5n88azR2T4lMg++jOkvPcpSodWFNVySeZn/di7Am3V
         bqtdiloyy3vTewr7iJBrM6xBwS5XXAH2591syXmn+EhDHVviuhjY6IIA/Ds1XbPRbgC4
         s3RtRmJAESNNku6+O0hM7I0wQtGJ9S51lfufmw1xxtCYMvjBbQ+fBDl6JPTSvjGg98x1
         OyNFxauuEy/Tvo2N3R6gn1d8R7t+YfbbQW9ukSSYbDYYWW4sE7b6J9hwHJy+xS/f8ER8
         9gIt1RIivbqyypaNKHlN2gqu7/JiwPoGpzlfrtZeJgQqATh/aFNzXc3Fdx0yMeBj5yxn
         yAJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=32Padg+6hCGNbUOr+i7YKPADHH8ODZ6PAm/7FSi080w=;
        b=6MLXpFLqna5zlMXmD4Od/fMS+z8qN0NbNgvDCDdXDrnaIsUTpMJ3DrWu/JgoRpvJI7
         ky5rc4sDHtuXgzy+4hbKg0f25payas/BJsjMb2wPW3Kp/+hIKdr2s8k47k6apJVh6sV5
         2xkGINl0aA+YvhRKcyOqOnw3b9nC55jnMapnwQqfomly2OVN++UCe63HFSOVfkie4dbk
         CZ8049VoXuP6YiPEq5CgrfeJZEy8lcmb+1Ro7eG4r1/cQp6Dm8j6ei0UiLU0yb4UgIJk
         WT5vJ024QqiscwaEzVLzVJEHARGnnAbKsFoOrS9YxAUXMOJ2OE0wPicKcKQPT84wGNpO
         kjdg==
X-Gm-Message-State: AFqh2ko5fQ4zalnA9eCR6dzKm+Fbz/6QsjbcpIdM3Z8HbB8ASB4Fw0vW
        L1ouw+vgnesXrIWH6IpongjNOMxA74cgYSwR5xO+RQ==
X-Google-Smtp-Source: AMrXdXvlgdZ1EhWM9+BrEgG6jEOHpwPMS0nCd80DKfupgv9iB+pTOd4h4gP1SRBOJ+HG1yaubXmSSDuGkMJKN2+wG9I=
X-Received: by 2002:a63:5841:0:b0:477:b650:494b with SMTP id
 i1-20020a635841000000b00477b650494bmr2406813pgm.434.1672672077956; Mon, 02
 Jan 2023 07:07:57 -0800 (PST)
MIME-Version: 1.0
References: <20220810022509.43743-1-samuel@sholland.org> <CAPDyKFqg0BUbpQwKvZxuMrqoiwBKzZxbgP-e=50yLpKRhQ+zPw@mail.gmail.com>
 <5a6a65c6-6df3-0d24-b28a-324b28fd4756@sholland.org>
In-Reply-To: <5a6a65c6-6df3-0d24-b28a-324b28fd4756@sholland.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 2 Jan 2023 16:07:21 +0100
Message-ID: <CAPDyKFpiuWY+vC1cY8xLozFucsTA0vMHVk_KTpzCfOcXntcBZg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sunxi-mmc: Fix clock refcount imbalance during unbind
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Maxime Ripard <maxime@cerno.tech>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-sunxi@lists.linux.dev
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

On Sun, 1 Jan 2023 at 20:25, Samuel Holland <samuel@sholland.org> wrote:
>
> On 8/15/22 05:11, Ulf Hansson wrote:
> > On Wed, 10 Aug 2022 at 04:25, Samuel Holland <samuel@sholland.org> wrote:
> >>
> >> If the controller is suspended by runtime PM, the clock is already
> >> disabled, so do not try to disable it again during removal. Use
> >> pm_runtime_disable() to flush any pending runtime PM transitions.
> >>
> >> Fixes: 9a8e1e8cc2c0 ("mmc: sunxi: Add runtime_pm support")
> >> Signed-off-by: Samuel Holland <samuel@sholland.org>
> >> ---
> >>
> >>  drivers/mmc/host/sunxi-mmc.c | 8 +++++---
> >>  1 file changed, 5 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> >> index b16e12e62e72..3db9f32d6a7b 100644
> >> --- a/drivers/mmc/host/sunxi-mmc.c
> >> +++ b/drivers/mmc/host/sunxi-mmc.c
> >> @@ -1492,9 +1492,11 @@ static int sunxi_mmc_remove(struct platform_device *pdev)
> >>         struct sunxi_mmc_host *host = mmc_priv(mmc);
> >>
> >>         mmc_remove_host(mmc);
> >> -       pm_runtime_force_suspend(&pdev->dev);
> >> -       disable_irq(host->irq);
> >> -       sunxi_mmc_disable(host);
> >
> > Perhaps a better option than the below, would just be to drop the
> > above calls to disable_irq() and sunxi_mmc_disable(), as that is
> > already managed through the call to pm_runtime_force_suspend().
>
> I like the idea, but it will not work for !CONFIG_PM builds, which this
> driver currently supports.

Good point! I have applied the patch for fixes and added a stable tag
to it, thanks!

[...]

Kind regards
Uffe
