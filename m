Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723CC6CC0AE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbjC1NZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233013AbjC1NZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:25:15 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC48FBDD1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 06:25:08 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5456249756bso229338147b3.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 06:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680009907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPIvMwQpvOjU0BzBAGW2h0thFK/pO6HC4FGgXVqASMQ=;
        b=cDQVnzf6NXWmQ+kFhJ/YNhytjxBtvv4Dx4494nooPMxlO4+/8/vueiJ227kXanpWpO
         zcoY1DOWsahAqtPOYxYFmXVQ+t9TpzYpzsuUIU941AMtP+egIu2QVMXSnql/jEh5jwIu
         kmBywYjNOqm0WzRBpH0kRRrpHa4eyDu5DctCtwV1FNBC3iQUWEIuPGEjBQNOn+D1JvAt
         ZX4On00rG2xB/yt/q0o8bciOUFrLoVBErkMmcCxMVes/8uQe5JbYSf8DohHytdjm9LZs
         9BlftRKvOjpYYcEA8FFWMi7EZP+sYynHZskrecbMVJyullUEKf4aCUTZUMmNqnFH9lTe
         1YVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680009907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZPIvMwQpvOjU0BzBAGW2h0thFK/pO6HC4FGgXVqASMQ=;
        b=WCwwFhkybEF09Z1BBfU3YCWxC2HuQZ66y1xbcQ0HcTc65GncAfRJVIV1fBxFAS7hUk
         xvmw3hhBghWwKSgFvq4nFyXKS/KC0FB3OSsR8do6RoK9R3L/sm7Iez6Ka0qmw/FmXYDJ
         XQpL2AtyxpPP4KE77AYr8MzXNUYgIpvi5Qh8HHL53o8Hn4SZfSHZVqrMOuvXNJ5e9LcS
         o5gZAT1k6L0rfkNwHNHSCR9jtDqrF/AVY/vANO7grggS3EUc6PlWoCZsiaYTv4SbFJ/P
         GWwWPeIjXNj2z0gVB2+IaBodd5LSrO2qu43enRoLobl4I/EhXx0nyL0cFmMs1BmHZ44w
         rfNg==
X-Gm-Message-State: AAQBX9f6/3J5fztumm/UVTgmnWYqPZMu5UhMBWhjT9UADmPF76JBG2gj
        z6asS2mD5fAoMBWg3lEN5oZOKA6EkpgleJZPBB5Kfw==
X-Google-Smtp-Source: AKy350ZgakwSzT0dqfqow65sOYhYdGm7e9tpKXHZr3eLhydwhlJV66Ug1YTOW0hOOhaksKirRdOvhIwCHukpr7tOpYw=
X-Received: by 2002:a81:d007:0:b0:546:81f:a89e with SMTP id
 v7-20020a81d007000000b00546081fa89emr1631145ywi.9.1680009907719; Tue, 28 Mar
 2023 06:25:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230327125316.210812-1-brgl@bgdev.pl> <20230327125316.210812-14-brgl@bgdev.pl>
In-Reply-To: <20230327125316.210812-14-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Mar 2023 15:24:56 +0200
Message-ID: <CACRpkdYUq5qvaWQFjb3NCoS4J5x=NVUKCM_ia4vqFA1HSuHbfw@mail.gmail.com>
Subject: Re: [PATCH v3 13/18] pinctrl: qcom: spmi-gpio: add support for pmm8654au-gpio
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 2:53=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Add support for the GPIO controller present on the pmm8654au PMIC.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
