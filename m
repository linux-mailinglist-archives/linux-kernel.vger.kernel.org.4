Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6DF729141
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238228AbjFIHfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238928AbjFIHeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:34:37 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29143AAE
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 00:34:07 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-ba8374001abso1466709276.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 00:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686296013; x=1688888013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXDVR/m7ghYi1sGCZSZPAynsOrIqpAxJnytq4LBC/ng=;
        b=pBPKnZtREmeexFVVkDaPCwzWpI3Y3aV5LLcRVTWvPKGJzLReiRcPTmVQ9UAI1VxSY9
         v1LeQ/DpxIggF3nHIg8P05mh9ZHoN5h5cIUnT6W155NZhIhfsw5WqOlR2GVMkoFFnnzJ
         ap/uAMR5v6xL3x2TGClYrx+m9dv/AzagdYJaOCAzm8NVs3ioNuqj/2Vmp1c4Nmj3SJh/
         8DHwLBroNZz21uhNpG/rthEr3d0YPHdymmeRGI4RncKVUHYES15r3wo3rnUq7cJNklk8
         xO1Wa2pMS0r7yCVNxmQwyI8WTwSOC0I/yr/2Hi7YOexIyjMhEBdWbhN7Q3mhknTCl0Vy
         giOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686296013; x=1688888013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FXDVR/m7ghYi1sGCZSZPAynsOrIqpAxJnytq4LBC/ng=;
        b=Us3W4BaqaoRCCZKChFT1cy7ZQ6wQgy+CckCW39ZQ5TNiJjsZ2idrzffgFaEh+rJm2z
         oXj/+FGr9pTkW06jfmwwQvHUxFdeeV76/sREcx8r4p9mFF8+2SFndPd/PgWQMRjZ783h
         dT8iGKUw5ugBdGRAV1YEcEaqCIB5WaE0uwqDxWzKKTgedjOhoHqyN3TE+0wldjWvkE6e
         GhekeNMCHGW7YvI1NCgzfd+/Gu/iziA+GNjc8tqvZslbZmzj+sQm5WSfDEYJSbtGkrmQ
         5ABPYBL2kA0CyCFNdaRI6RFBqn2pLM1WBAXHctsR6wdzaqtxv8n17sBOyZb/HRo8l50r
         EQAw==
X-Gm-Message-State: AC+VfDyw1huVllqNZJPN0ImiQV1qEC3ISybCS6ENmGLm6apCHHUGXTtM
        8GYLq4EmiHgSJ/KV7dvkYu/ukDT9hE1kq3IMFtDEuw==
X-Google-Smtp-Source: ACHHUZ6jgWPorkmy93uP+LrZbKWCGp3r8xYGc1KFEsMG89qwqkB4AC9ZiecD6YH9cv8wJh6C0cjDeMb+RG1VWM8Cf1I=
X-Received: by 2002:a25:f40c:0:b0:bab:9ead:ae2b with SMTP id
 q12-20020a25f40c000000b00bab9eadae2bmr378433ybd.51.1686296013183; Fri, 09 Jun
 2023 00:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230605125248.279921-1-brgl@bgdev.pl>
In-Reply-To: <20230605125248.279921-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 9 Jun 2023 09:33:22 +0200
Message-ID: <CACRpkdYJYFNQfb15uD2_8kEUTiMcc5-9AfNnfa0kne4OD0zkVw@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: demote the hogging log messages to debug
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Kent Gibson <warthog618@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 5, 2023 at 2:53=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Drivers should be silent when they work correctly. There's no reason to
> emit info messages when GPIO lines are hogged. Demote the message to
> debug.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Suggested-by: Kent Gibson <warthog618@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
