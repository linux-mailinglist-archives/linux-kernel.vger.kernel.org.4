Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A36F6F6AF6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 14:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjEDMNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 08:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjEDMNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 08:13:45 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5A35FCE
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 05:13:44 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-b9d8b2e1576so557943276.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 05:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683202424; x=1685794424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Nz4N7dBdEb2mhhYgRb5Ac4u0WnwPfPfvIfQEz/oEYw=;
        b=qXqX6HaLiyrnJBChHeBKAzAM0vEPq7TbgRHZmOwkhPcM1GakZW/ItPgWR/1Oxue1sq
         cIQu/c6Te65Z6dExIcbTmK56lU8phMg7PhezCdVW01BBBZHUgp1ZKWGGn5qeH6nnbuup
         WaQrY9cQ0IxucKvfSKHdn582Lw1aATNnMQbM5p8jhmClkRAxphauBfnB2jbMtqG/Mbdg
         nYRvSlUJHZQ1KCee/9iJU0aTK9Ocu7E14ijm767M5v5YStjfGynNY7RKqbh7V9aCwG7/
         R8XTpaRviX4SAFpYAgJ/n8CxrUgqgUL5QY598WnmHCY6w2dSR5iihskgnaRLQOXn+zJQ
         JnyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683202424; x=1685794424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Nz4N7dBdEb2mhhYgRb5Ac4u0WnwPfPfvIfQEz/oEYw=;
        b=f/jmQIWzQ1uI6LERDJ6DpMo80MwY1PSe+GLrQ8++NTwg0tqvWgC4Rsf0SuNJM6b/LX
         7vaUdLEwQA6ObKWPf0hFFAYAJ6cXa+2jTlU+62Ad5OoZAOL3LXkHee1DPLvDvuNN3cki
         LzxgL/KK84E0SdrCDYrqSD5y1kJtlCJKkunRp+SS8GaReTIe5uGQ2f41CUrP8jp6GcVx
         i5TkxmK5hduYUhdRjyVw/O1t2CEczfAVjoMyaTzb5HX2vUsiLsUsQHZyfE2iHzbY0lfi
         s6JoSNG68CQ+k/O2nsIPiYwksA9/9i3tJDdCIurnbINPT2agduwLER3/uVUm4oEQcYcJ
         IeIQ==
X-Gm-Message-State: AC+VfDy86tpw4z6ZVzizZZ5XNVsfnyRoKpRBOnENu2bJCnjdyRu2ViCT
        I5g7xpJFMHXg/pfY+i0APMGa7e+7YkFOb40m2LgHLJ/kk6cMWSnA8EI=
X-Google-Smtp-Source: ACHHUZ7tC86v2dmQ/+32Ze+s5HIZkFWybkq5UTok2Fe2Q+hGI7uuxQK7pXSEjtNakF83A5FXhyVV12KWSUK8lqUIixE=
X-Received: by 2002:a25:41ca:0:b0:b97:e31e:47b with SMTP id
 o193-20020a2541ca000000b00b97e31e047bmr21780417yba.62.1683202423837; Thu, 04
 May 2023 05:13:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230425173241.GF444508@darkstar.musicnaut.iki.fi>
 <20230425201117.457f224c@aktux> <20230425183857.GG444508@darkstar.musicnaut.iki.fi>
 <20230425212040.5a4d5b09@aktux> <20230425193637.GH444508@darkstar.musicnaut.iki.fi>
 <20230425215848.247a936a@aktux> <20230426071910.GE14287@atomide.com> <20230504055156.GO14287@atomide.com>
In-Reply-To: <20230504055156.GO14287@atomide.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 4 May 2023 14:13:32 +0200
Message-ID: <CACRpkdY9ShRATHa776KyzeArmQdKxdwGxJC11YnmhWiCdSGzEA@mail.gmail.com>
Subject: Re: [BISECTED REGRESSION] OMAP1 GPIO breakage
To:     Tony Lindgren <tony@atomide.com>
Cc:     Andreas Kemnade <andreas@kemnade.info>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 4, 2023 at 7:52=E2=80=AFAM Tony Lindgren <tony@atomide.com> wro=
te:
> * Tony Lindgren <tony@atomide.com> [230426 07:20]:
> > Seems that we should just revert this patch for now and try again after
> > the issues have been fixed.
>
> Looking at the proposed fixes being posted seems like they are quite
> intrusive.. How about we partially revert this patch so omap1 still
> uses static assigment of gpios?

I think Andreas patch (commit 92bf78b33b0b463b00c6b0203b49aea845daecc8)
kind of describes the problem with that: the probe order is now unpredictab=
le,
so if we revert the patch then that problem returns, but I don't know how
serious that problem is.

It's one of the reasons why we can't have static GPIO bases anymore FWIW.
The only fix that would actually fix the problem would be to undo deferred
probe and the ongoing work to determine probe order from the device
tree resource tree, and it is way too late for that, it's just not possible=
.

Yours,
Linus Walleij
