Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B916A758D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 21:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjCAUqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 15:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCAUqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 15:46:09 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7794838655
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 12:46:05 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id m20-20020a17090ab79400b00239d8e182efso536142pjr.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 12:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677703565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X9BoC0/A76+y2upt8Z7xd1pPLeDEjjRKQePPrJY8K6A=;
        b=GBZ/bvvR+IIljM8PA91ubanXCRvXQF2JxVhOAECYNlq9AjYdNNQUE9i4+BDjWfkWh2
         RzmZwz4JFT5fWKf4WzeaNavuCtUaLN85QzZ02FZoLVAEYz3Ke5Ma8flyK1CBVWB/VZWC
         zbE2MgX3DrSp1DDZPKKvLxpapXn+EdHv3obBdz/6EZqhKywz+voFXekEGHfjJGCvX/tQ
         BskjJ7fVI8WpCweMTDIpVeSddJAp+oXukEYt6XG6SSrmQVCsx8DjzawGOnktrnnZxKSo
         twOaxACRA/3waYXYwq0AhgR1j3ebMMR6diHtYFVOYkaBCdHijor+zr1M9Jt469I0a3x1
         XPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677703565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X9BoC0/A76+y2upt8Z7xd1pPLeDEjjRKQePPrJY8K6A=;
        b=ojkD/Yc7SakGmBdXt4YuJUVO9qTSpniO7tBByS1ihovZvC/BVhZwMK7IebYsuM6aEW
         TqvRK4+4zu+GqfMDPVxne4XeWxI0w+NpTvT3isMz60d0eO5w0jK9xJEWze/8Gf+l9PbJ
         4ncM88p14hlltytOybmxqR2zIDGwiJG8yCl0nHt9zfDhiBAstBOgiBDkdrkLO/yqpcc2
         ITkOI1DPtmfhmuFVUO4DUE/2Joet+2OyW3Rorn//UZxBgqsRzIgznIGQG3wYSoDnD+cp
         Kh2/0BtZSIeBk+KzueO5lwuZKXfIPHvVEPInHObVcff+y9Ltbt4VtZYm5rJDJMk6aMTr
         qkEA==
X-Gm-Message-State: AO0yUKVXvvC+MCmX1N7lqK4feV0kQn/noMjzEL13oEztdqEX+qyWj39w
        zrgaXfYnjC12UQqdcE0yf0smBrdrurGzrt0NFeR18Q==
X-Google-Smtp-Source: AK7set+yTRmSTyauRufVb1tyAauc6gMRa8tEFWWYf06xoxgmZVXEEcgftQSIvTkiPsSBjqHC+tzLG30n4oA9Rvwt1DM=
X-Received: by 2002:a17:90a:174a:b0:234:b29d:3319 with SMTP id
 10-20020a17090a174a00b00234b29d3319mr3089625pjm.8.1677703564622; Wed, 01 Mar
 2023 12:46:04 -0800 (PST)
MIME-Version: 1.0
References: <20230301012506.1401883-1-saravanak@google.com> <31ae9957edf319416d4551f14eba2071.sboyd@kernel.org>
In-Reply-To: <31ae9957edf319416d4551f14eba2071.sboyd@kernel.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 1 Mar 2023 12:45:27 -0800
Message-ID: <CAGETcx-t=SHPtNifpF35XTMEZk9b0gySr+J9AfcgHvVfBEEWtw@mail.gmail.com>
Subject: Re: [PATCH v1] clk: Mark a fwnode as initialized when using
 CLK_OF_DECLARE* macros
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel-team@android.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 1, 2023 at 12:40=E2=80=AFPM Stephen Boyd <sboyd@kernel.org> wro=
te:
>
> Quoting Saravana Kannan (2023-02-28 17:25:06)
> > The CLK_OF_DECLARE macros sometimes prevent the creation of struct
> > devices for the device node being handled. It does this by
> > setting/clearing OF_POPULATED flag. This can block the probing of some
> > devices because fw_devlink will block the consumers of this node till a
> > struct device is created and probed.
>
> Why can't you use CLK_OF_DECLARE_DRIVER()?

Not sure if you looked at the patch. This is a fix for the macros, not
this specific user of CLK_OF_DECLARE(). Even if Linus fixes his
specific case, this change is still needed for other users of
CLK_OF_DECLARE().

Honestly, a ton of existing CLK_OF_DECLARE() users should really be
switching to CLK_OF_DECLARE_DRIVER() or better yet, implement them as
normal platform drivers when the specific clock control doesn't
provide any early clocks.

-Saravana
