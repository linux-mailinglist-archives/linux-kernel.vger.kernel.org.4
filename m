Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A3864A9BC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 22:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbiLLVtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 16:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233606AbiLLVtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 16:49:24 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D9A19C2D
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 13:49:23 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id fu10so10278908qtb.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 13:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Sdm5LPHSgYM9xIUawQXpRV3gt1/XB5UGwiqZUgZf9G0=;
        b=LbrNyZXHaOXAy+bQv/etbIYZ6VZoVPUi2kRpqwN6E+F/8a9V2FyFOqw87rg8zkpx6A
         KWKB8da+Sp646sBYb4v/MUPjndRmHI+KOjVPKVdtrGt6fRTcp91l2koXjnApcd+mFyEJ
         Xc63/McYW91ONI2KZvYwCGQk+pFyjTkIyGNE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sdm5LPHSgYM9xIUawQXpRV3gt1/XB5UGwiqZUgZf9G0=;
        b=pHGrzxjbP/lDRwNqI83nyBBmfvEoTbleg6fhCMJ1uRTOhKmIMuBLVOR/j6bEH4G4AQ
         xEHBvVc4XwUO4A2aUmYSUrFKescVsyEgIfLYzveBrrwyirNRzgfdrFja8pNDJEEioXKa
         RI0VbrjoJc6mvb37N/NSla/SOKpCI2RJwj8A+f/iUz2ny0h5nWbSUgJZ1+qvMfsdeZ7n
         U9t7zySnpipzadeeGd7n0J5k251khu5+eXAL1mNqlx823FNaVt1pASzR8fr4yQ91lFsX
         UtqHcodroEOYIJIl5f4a5wTvB3cCfRLZiaAAX3w6dBNM5Z864P9M9SLbaUUM++nYIZZy
         xR/Q==
X-Gm-Message-State: ANoB5pl78NYjme9GrCTF6fjHj22oDYRps1VaBKYmyivWFxXVLvdyPPV0
        1kBT3cLZ+oiSnK+K3O0TYSlIK3wd+aN3LHb/
X-Google-Smtp-Source: AA0mqf6GdW0kGm6kqAca3qYePZ//ds7jT0aRetAAnh7/i/ygOq0nlX9REss8/9WY8SdUQUdYufpBPg==
X-Received: by 2002:a05:622a:a19:b0:3a5:25d6:dd90 with SMTP id bv25-20020a05622a0a1900b003a525d6dd90mr24940390qtb.55.1670881762565;
        Mon, 12 Dec 2022 13:49:22 -0800 (PST)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com. [209.85.219.52])
        by smtp.gmail.com with ESMTPSA id x18-20020ac87312000000b003a50c9993e1sm6425141qto.16.2022.12.12.13.49.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 13:49:22 -0800 (PST)
Received: by mail-qv1-f52.google.com with SMTP id pv25so3112759qvb.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 13:49:22 -0800 (PST)
X-Received: by 2002:ad4:4101:0:b0:4b1:856b:4277 with SMTP id
 i1-20020ad44101000000b004b1856b4277mr70612302qvp.129.1670881761832; Mon, 12
 Dec 2022 13:49:21 -0800 (PST)
MIME-Version: 1.0
References: <CAJZ5v0j=CNHAC-H9ci6qpTEeG4R1TD78oQWoKZXALN4TzPZubw@mail.gmail.com>
In-Reply-To: <CAJZ5v0j=CNHAC-H9ci6qpTEeG4R1TD78oQWoKZXALN4TzPZubw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Dec 2022 13:49:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=whBn0PmD0pV5RZnnO=75tMd9XLFVstKfNxH5eM6MCK1-g@mail.gmail.com>
Message-ID: <CAHk-=whBn0PmD0pV5RZnnO=75tMd9XLFVstKfNxH5eM6MCK1-g@mail.gmail.com>
Subject: Re: [GIT PULL] Thermal control updates for v6.2-rc1
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
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

On Mon, Dec 12, 2022 at 9:33 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> I would really appreciate it if you please give me your recommendation
> regarding the extra thermal control material.  Would you like to
> receive a pull request with it later during this merge window, or
> would you prefer it to wait for the 6.3 one?

If you are happy with it, and feel like you can review it and get it
to me in a couple of days, then fine. But I really don't want to deal
with it after that point - I'm on the road over the weekend, and then
the week after that is xmas week. So at that point I'm solidly in the
"it can wait until next release..

            Linus
