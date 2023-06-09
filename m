Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3821E72A06E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 18:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjFIQoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 12:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjFIQoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 12:44:03 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB743AAB
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 09:43:57 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51475e981f0so3426470a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 09:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686329035; x=1688921035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bU7ZExiYZGpXxtSGpQ49waf+c1eFY7AbxM1kuBi0fpQ=;
        b=YrnXySk3YXh/YlYz6ObsTiPCZR45zJXxRZ/715/SlhIvFmmND24w4AGX7Mwp8N2RTn
         CSHfipaLqA2Y6Rto31jSd84jtyxj8p7izlY5VKEhvdbM8hlg2/NmZtsTjc6iaLy6zKf2
         ih3thb5Bh+oWfvscRZcy7ttxCfhyweYsWyEu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686329035; x=1688921035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bU7ZExiYZGpXxtSGpQ49waf+c1eFY7AbxM1kuBi0fpQ=;
        b=TJtmZ2LYv5Q4+RueR94MAUOXLgxxzKtk2kWaFLgiiKS/bcxEHVqkMs73oipy0g4QV5
         El5aviOrtHrC1Qhr3piXodydPEvzIWiKQaPGOsUSJ3eqAEAelOz35uXttkgjZ/xvULY3
         PBtPG2qk/4CCL7/QasNaZeId5/Qf4L5BNxV4ZqLGifBi71EoOCcBO7tvmDtSQSJ0x//8
         Td1ci/IOntI47LbCTPRWrQaC8sxrJxN9+dAgzL4I89QEuPeDShDRhaVsXUYpquOv+rnF
         +T82IEUhtygJ1t0gz0lJecpBt1S06j31Y0IaWJXG45lu6LJWkpeI4zSdWQa2bByEk2XS
         KzDA==
X-Gm-Message-State: AC+VfDwKwUSxgiKvJotzMFozsKTozpD+qoNIo2XyTIHYrMZU94w6L0hW
        t040lAPaQP7zTpVvpJxe6oXHWfWzCPAqnNjeb1+21+FV
X-Google-Smtp-Source: ACHHUZ5w/lA+8dZeCKjaWYjC9n5jomQi8br7OMIetL4J75dsbeM6oA/7VwiESPshh4KMMZmuILnCYg==
X-Received: by 2002:a17:907:5ce:b0:978:6e73:e837 with SMTP id wg14-20020a17090705ce00b009786e73e837mr2396711ejb.4.1686329035243;
        Fri, 09 Jun 2023 09:43:55 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a12-20020a17090680cc00b0096f7105b3a6sm1478920ejx.189.2023.06.09.09.43.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 09:43:54 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5149b63151aso3423358a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 09:43:54 -0700 (PDT)
X-Received: by 2002:a17:907:70a:b0:96f:a935:8997 with SMTP id
 xb10-20020a170907070a00b0096fa9358997mr2422134ejb.12.1686329034229; Fri, 09
 Jun 2023 09:43:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230609144613.210272-1-brgl@bgdev.pl> <168632880867.22652.10987437416013616928.pr-tracker-bot@kernel.org>
In-Reply-To: <168632880867.22652.10987437416013616928.pr-tracker-bot@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 9 Jun 2023 09:43:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=whVcTX2hJ9VrpooL1ft34oB5kyrRsziM7cH94d8RGA_7g@mail.gmail.com>
Message-ID: <CAHk-=whVcTX2hJ9VrpooL1ft34oB5kyrRsziM7cH94d8RGA_7g@mail.gmail.com>
Subject: Re: [GIT PULL] gpio: fixes for v6.4-rc6
To:     pr-tracker-bot@kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm. I have no idea why you got duplicate replies from the
pr-tracker-bot for the same pull request.

Konstantin?

               Linus

On Fri, Jun 9, 2023 at 9:40=E2=80=AFAM <pr-tracker-bot@kernel.org> wrote:
>
> The pull request you sent on Fri,  9 Jun 2023 16:46:13 +0200:
>
> > git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-=
fixes-for-v6.4-rc6
>
> has been merged into torvalds/linux.git:
