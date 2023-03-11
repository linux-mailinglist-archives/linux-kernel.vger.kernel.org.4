Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81EC6B611C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 22:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjCKVrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 16:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjCKVrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 16:47:00 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4BD64848
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 13:46:59 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5416698e889so48221517b3.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 13:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678571219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3BGxsLL0P2xeumMB7bEdeq9RgCc5RJW60xab3JcWmM=;
        b=kwcJYojGXc7i5Cw4eiPmBcGY3cxrIlbNQQuF6G9c99eUWkl5qqoYCwNnSqw0mqLRBI
         E/DVYL9cPcBC0CNafj1hr4JbY7lTGwoD9B42QqaNhXpCiryP9MJitp6OT5ytjBg4C1aI
         8Zu53YMGAzAcEjN6by7I88ZsMxSGApOOH1tsSPOib8iyg8YpURdD2zNKNspwyKDqe06w
         cVavHO/PktwawT7QB/Oztvt1lGhdQewMchl1Afz8uTrmOCaUOJvY30mTiPYc4VaRtT2a
         R69AbyqOPKwkwNNoFVg4GosB4ks5HTaG4jb8AlEsmG2yW/2IW1zgk92UjVyo9EY4fiN6
         s3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678571219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j3BGxsLL0P2xeumMB7bEdeq9RgCc5RJW60xab3JcWmM=;
        b=cepYQVBzf+8XBrlnc+PBaVzNHrZtaTznMZqwwLu38kQHjcVliKZDwcQGN1Qh6/ykiR
         Qg5/DVcnL7pQIPhqUOlRcl1ojhrIx5OyD6M0trey1YeyuX759q9t1obmigH7w/UcvzHc
         edZLG02XpPMC5zf59isO1AL3XOlk9vmH+yrCHiCKoz9oAvbYCVnVe+ByahCWQOrxucr5
         tMf5faExnVOiBmF08NmXv2aktoPzkp8+yzYOlhFJKTfBGht7tlX28q5Y+AQkmXqg4D2a
         cEuDtDADRsnFmrP7tKgzeMZ0rxzKYOqlB7qG0iPpmyL/f032Pi8rNOeSwuBKUVPuor/V
         MQ3A==
X-Gm-Message-State: AO0yUKWf0SMCYtVFiIuRNDlrh0pslMGyX40Ugeh5djQ5vn/vJtI8cZ11
        8EU14gwukd38WMUcKvGXcK3hTFRXlRVrKVe4/xsviw==
X-Google-Smtp-Source: AK7set/ivVF6AzD/O9ePnVc9AKWYerfOeZb4FLMTiJT/IwrTK7biY9sqp7oNVh/B77dfc4ZuIA+xnYP7wi7zrZS3v3I=
X-Received: by 2002:a81:ae61:0:b0:541:822f:af40 with SMTP id
 g33-20020a81ae61000000b00541822faf40mr964887ywk.10.1678571218976; Sat, 11 Mar
 2023 13:46:58 -0800 (PST)
MIME-Version: 1.0
References: <20230311111307.251123-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230311111307.251123-1-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 11 Mar 2023 22:46:48 +0100
Message-ID: <CACRpkdav4Uas6UKOyz6iV9hzgSELvU+224Ewyy+o0w8tYCoaJA@mail.gmail.com>
Subject: Re: [PATCH 1/8] gpio: ftgpio010: drop of_match_ptr for ID table
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Mun Yew Tham <mun.yew.tham@intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Nandor Han <nandor.han@ge.com>,
        Semi Malinen <semi.malinen@ge.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2023 at 12:13=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> The driver can match only via the DT table so the table should be always
> used and the of_match_ptr does not have any sense (this also allows ACPI
> matching via PRP0001, even though it might not be relevant here).
>
>   drivers/gpio/gpio-ftgpio010.c:336:34: error: =E2=80=98ftgpio_gpio_of_ma=
tch=E2=80=99 defined but not used [-Werror=3Dunused-const-variable=3D]
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
