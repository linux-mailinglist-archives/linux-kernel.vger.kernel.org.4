Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4282701F7C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 22:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbjENUNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 16:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjENUNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 16:13:42 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C18172D
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 13:13:22 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-55a00da4e53so211465557b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 13:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684095198; x=1686687198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8TPYEQ9TAkX1MnYcsd09aP3FGjE1mv/XKLN4T7USucQ=;
        b=k9z3ua6lszBlvolHZ6gBOrU3sDG+RPeRjr4HEArZ/sN72AgCOKsO3WpuvrjCMGeqrZ
         8EqgF/EUBdu62tdFd6tgjCl9JOWBKofuAxGMu7rsUD3gKCyWv+FlAX8n8qmP0LXz+th6
         p7YJS+6E6pL/lex/uGN4n39mU4pwFbELOfPrBaCR9uyWAoHrkEPAd44GWwws4mgvHRf+
         ZxkoMZ3o806qqUNsgF42a4+v/NaOYKUYPiqfn16IIp9ND+WnR5Gj7zhOp4/Zm0V3qGf0
         f+lrGNi75F8nof+4DM6keT1R1upz6WXzrJ4Rna7auzESp7e1iHA52DoxCh8h1zwYmtCc
         mrkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684095198; x=1686687198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8TPYEQ9TAkX1MnYcsd09aP3FGjE1mv/XKLN4T7USucQ=;
        b=HZw89UhEHIcR/UoC+TLZYXtLa6EE6pKODYCQZLYPxQ7vAcnlj+ZBZ7sMqv9HHPn+bA
         VlomGlqDv6dwP1EV2RX1C5mbH/TEZRpmbhi6MapoZ9Y4NxwlvQRXluCqApqJjhf7HUqZ
         hSqZC1AC7BMzrl9+Qg2qHcZ6H2jWL/aUI26TflWmcYmEdzheu+hA3VoSIOL96z7x+oWp
         s3wL05XSA7UI8hiqz4K699sZKvayUMVWAZnijtUahjOwrbFpCBZPYMkhbmwaG1gMWZ99
         X76C5FP+3k/TOwqmjc38rWFhj3N/K5mBD8TQlQPECPDWxrfEiB0i0jYfvvtCor+dIrPR
         W9LQ==
X-Gm-Message-State: AC+VfDzKVCyzoLNL8Ch1zQxolaj5ijwSm+joKnTzyWUEbqMK1VxkZuFh
        g4L1NbM+5X1rJBV1qMJ9FMQf+ra9OGnXKECecCSVsA==
X-Google-Smtp-Source: ACHHUZ5OIXN0WGeumgNJlpZvuq7DaUAHQQb/qGe1Q0egbYlWIeRSBCxsotbVWXEzEgRSCH+TSk9MU5GzlRvEU90CSmU=
X-Received: by 2002:a81:a055:0:b0:55c:9348:2b71 with SMTP id
 x82-20020a81a055000000b0055c93482b71mr28597778ywg.16.1684095198175; Sun, 14
 May 2023 13:13:18 -0700 (PDT)
MIME-Version: 1.0
References: <ZFs6DNgzBHNarr6D@euler> <f2176adc-cc2f-4752-2c7e-102b73b55696@leemhuis.info>
In-Reply-To: <f2176adc-cc2f-4752-2c7e-102b73b55696@leemhuis.info>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 14 May 2023 22:13:06 +0200
Message-ID: <CACRpkdbQBTaoU6FNc12t49V=4zHLMbjmGoOZ70a=YC4shqwLgw@mail.gmail.com>
Subject: Re: Kernel 6.4-rc1 ARM boot fails
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Colin Foster <colin.foster@in-advantage.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 14, 2023 at 3:15=E2=80=AFPM Linux regression tracking #adding
(Thorsten Leemhuis) <regressions@leemhuis.info> wrote:

> This isn't a regression? This issue or a fix for it are already
> discussed somewhere else? It was fixed already?

It was fixed already.

> You want to clarify when
> the regression started to happen? Or point out I got the title or
> something else totally wrong? Then just reply and tell me -- ideally
> while also telling regzbot about it, as explained by the page listed in
> the footer of this mail.
>
> Developers: When fixing the issue, remember to add 'Link:' tags pointing
> to the report (the parent of this mail). See page linked in footer for
> details.

Syzbot also ran into this regression:
https://lore.kernel.org/all/000000000000da2a8505fb71d81b@google.com/

Anything using FP instructions in userspace init will crash like that,
I happened to use softfloat in all my userspaces and didn't face it.

Yours,
Linus Walleij
