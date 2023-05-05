Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED546F823C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 13:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjEELn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 07:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbjEELn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 07:43:57 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410DEAD2A
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 04:43:56 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-55aa1da9d4aso28535567b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 04:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683287035; x=1685879035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujLLumrKh4q+bshtlIQ6r54rkrCQR8hj9C2xEoyLMFo=;
        b=TfNrY4h1C7phIcd7lcuwhAN5y160ShZqKhwyHQ0csa1IwEkQrcnzG2A+sxNyRSAWHw
         XlKH+c68P1CICMVnAevc/iAhJ2lfGjq1GDMdzcnEPSyVwlMOmkwMyGDOO2h4sz9RFm0f
         QWGrEDJ23O839qREbS8t6pbhg8FdQA5Ofc6rkeXQpmeRPo3xFkArAicHRJJvQ9gnsfTg
         PXwvfj6ev/NUVV683ez8bn8iZZQfPkhnK9lmuLWOhuML89t734fxfhVZTpda9wgNgUYd
         f3xIMPe4Z0+Ukfvv3BoiGgL+IFeJkvlX1zEZVB6IDKKEwBDec4XeSeGgXPk0nZpfCHkU
         TL4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683287035; x=1685879035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ujLLumrKh4q+bshtlIQ6r54rkrCQR8hj9C2xEoyLMFo=;
        b=KVT+7BvIDE2dfxM1Ak3nSKXN4M1q4q6ZIESxBuub37CJYMS4EoqZqbtN2GoR+vpfeb
         eADuvSw94KKWOw0wdnNavUh9YrbsjtVb/Rgif8opBhdMeRp9g6aKpHPB297dW0edUdcQ
         IDKfyzsmvnB+Ly36rUeRxZ79Sjz78dmSFsdLBS/S2eQ+iwv+puWsHqUVsaJ+2IOoocgE
         kcdGQi3aB6J0uyN6oivVhld1WKQAiwPOdBd2cNiS4Ua2mHTpq7tWYpqKczLw0LYFpoC2
         9Ma1+DMwoQjt1E9EG/VdOj8dcs+SFlgnqF39lIr7hgBdrCUEHVap7lOXfGM7X4+Qb0jj
         TUjA==
X-Gm-Message-State: AC+VfDx3Y6T/IoDsd56subndmdDqUs9WX1uVjqR8RWcnBedz8Mt4oAYD
        /E+Ch7a2XQ5cwt8yBkx/BxK5Jf53f7xAVHQla/UwgA==
X-Google-Smtp-Source: ACHHUZ4F3IOG9rWuMS12gMDvukRJKxCG9ar8cI2zgHLUwfCzu6OzvjZWooJ1qnSYuUIqY97pc17fpBuJTGp8jhMZ2KI=
X-Received: by 2002:a81:6dcc:0:b0:55a:1c79:8eab with SMTP id
 i195-20020a816dcc000000b0055a1c798eabmr1036671ywc.32.1683287035463; Fri, 05
 May 2023 04:43:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230421120625.3366-1-mario.limonciello@amd.com>
In-Reply-To: <20230421120625.3366-1-mario.limonciello@amd.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 5 May 2023 13:43:43 +0200
Message-ID: <CACRpkda6zyvQ6a4ycEyyi=k5dTZo2Ecm6t6w_9e8hf3gih3qGA@mail.gmail.com>
Subject: Re: [PATCH 0/4] pinctrl: amd: Adjust handling for firmware misconfigurations
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     linux-gpio@vger.kernel.org, nakato@nakato.io, korneld@chromium.org,
        richard.gong@amd.com, Shyam-sundar.S-k@amd.com,
        Basavaraj.Natikar@amd.com, linux-kernel@vger.kernel.org
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

On Fri, Apr 21, 2023 at 2:06=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:

> commit 4e5a04be88fe ("pinctrl: amd: disable and mask interrupts on probe"=
)
> had intended to work around firmware problems on a Microsoft Surface
> device but actually masked other real bugs in firmware and the driver.
>
> Before this commit, "wake on lid" doesn't work properly on a number of
> systems, but this is because debounce handling was improperly configured
> in the driver and due to a bug in this commit it gets configured a
> different way.
>
> commit b26cd9325be4 ("pinctrl: amd: Disable and mask interrupts on
> resume") attempted to build on top of this to mask issues on resume, but
> it happened to "fix" the bug in commit 4e5a04be88fe ("pinctrl: amd:
> disable and mask interrupts on probe") which "broke" wake on lid since
> the debounce handling was programmed differently.
>
> This was reverted in commit 534e465845eb ("Revert "pinctrl: amd: Disable
> and mask interrupts on resume"") which fixed the wake on lid.
>
> To fix this series of unfortunate events and prevent them in the future
> this series corrects the GPIO0 debounce handling and reverts commit
> 4e5a04be88fe ("pinctrl: amd: disable and mask interrupts on probe"). A ne=
w
> patch that is safer is included that will fix spurious interrupt handling
> and is expected to fix the issues that both
> commit 4e5a04be88fe ("pinctrl: amd: disable and mask interrupts on probe"=
)
> and
> commit b26cd9325be4 ("pinctrl: amd: Disable and mask interrupts on
> resume") attempted to fix in a more scalable way.

I applied the series for the next kernel cycle (becoming v6.5).

If it gets urgent to get this in we can move it into the fixes (for v6.4 an=
d
stable) but at least this way we get some rotation in linux-next and wide
testing of the patches.

I will push it once v6.4-rc1 is out.

Yours,
Linus Walleij
