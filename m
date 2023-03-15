Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A336BB0C7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 13:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbjCOMVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 08:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbjCOMUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 08:20:37 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE84D86DD3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 05:20:14 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id o2so16744861vss.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 05:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1678882814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7ECRY0Te14ADf7d1i4el7TwH1rvkn6nOgcFPiWQeeE=;
        b=qfV7NVpQG2DvX+Cj58PBVyZL6NOvhyh3tUT4nWftgX1LcK7MVqiP1AWrrKOEcNa6Sd
         2mObvmjze4rBW3GbOX7GdaQMcaHGETycNH5CuXEYX0TApmcVW34vXSnJylFSWo79niya
         oyq7D7qYpmLgkEoMm8zgpW4CuCzA4FKVRHlY54Q5WP480NhFbZJFydD7l3aqwRc8h6e0
         bFp5knWRl73B+XFEowhf6qCH3nCy8yO9gafgGNc9IYzNxob1jw9Ry5uYghSuJ8kYhP35
         9ht3aN7i4WBoHFQLZkCGGOW4pSHkGa5Z4YHtGsL4688cPfZXe74oEqJ4oYIZK4hUIfc9
         gX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678882814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T7ECRY0Te14ADf7d1i4el7TwH1rvkn6nOgcFPiWQeeE=;
        b=ieE/lzVvxaTIDv4W4YksPGwDq9cfzUboreIvCFfA4AUqZWH5KWs7k5SDepg61Hgliw
         gKLvN7Qe/4W6cIldQGbtaGNG3WePXpISp9g3W3+R2zPVC9O/w5rz14bJWiZ2upzEzjnF
         E6S/wSEwMZOE05a8yTXCumdtBLOS4YaeW06uKDp2mOdSyOFYTKU5ZF8AZP8hG90VLq+a
         VhyKSb0zI85jFVgh5byvMKW0ljLK26VCHfGdfq8aPJzhfDuIbqZS+0M/3LbdaKPaNBgA
         iSOk3nabN8291CG19y3G5+s8N0KjkSVJ5xZM/nsmyUcw5fLYVwUojxU+/rYMbKuL1ByA
         C7ig==
X-Gm-Message-State: AO0yUKXJMxPFG26menNapT4dV0GqqlUzSt2zaPlGPezHu3d/scKZ+EAL
        pPwPI3oXMvcGW2ig5t3N05DSt1lbEgpR5zdV5buu5g==
X-Google-Smtp-Source: AK7set8xf9erliFQjg7b8zKj5RwEcJ2NN9wMH4S6n+20ZmGyEH+og3UG9ei8Qjt+sSDngPD1/GcLB+pn3QA5m4E3CK8=
X-Received: by 2002:a67:f254:0:b0:425:b61a:9c13 with SMTP id
 y20-20020a67f254000000b00425b61a9c13mr2414569vsm.0.1678882813726; Wed, 15 Mar
 2023 05:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230312190435.3568212-1-xiang.ye@intel.com> <20230312190435.3568212-3-xiang.ye@intel.com>
In-Reply-To: <20230312190435.3568212-3-xiang.ye@intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 15 Mar 2023 13:20:02 +0100
Message-ID: <CAMRc=Mfynj1STC54v7SBKZxBk2rJ6VTW+XV56hZ896rOCpKd1Q@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] gpio: Add support for Intel LJCA USB GPIO driver
To:     Ye Xiang <xiang.ye@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Matthias Kaehlcke <mka@chromium.org>,
        Lee Jones <lee@kernel.org>, Wolfram Sang <wsa@kernel.org>,
        Tyrone Ting <kfting@nuvoton.com>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-usb@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-gpio@vger.kernel.org, srinivas.pandruvada@intel.com,
        heikki.krogerus@linux.intel.com, andriy.shevchenko@linux.intel.com,
        sakari.ailus@linux.intel.com, zhifeng.wang@intel.com,
        wentong.wu@intel.com, lixu.zhang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 12, 2023 at 8:05=E2=80=AFPM Ye Xiang <xiang.ye@intel.com> wrote=
:
>
> This patch implements the GPIO function of Intel USB-I2C/GPIO/SPI adapter
> device named "La Jolla Cove Adapter" (LJCA). It communicate with LJCA
> GPIO module with specific protocol through interfaces exported by LJCA US=
B
> driver.
>
> Signed-off-by: Ye Xiang <xiang.ye@intel.com>
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
