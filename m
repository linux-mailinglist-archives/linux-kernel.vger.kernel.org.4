Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21EAA605F26
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 13:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbiJTLoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 07:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJTLoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 07:44:14 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14801DDC34
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:44:13 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id h25so8785040uao.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SgkVAHFYBzf7xeOTCAVuEnoDAv9oQxRnYlVtkTlACqw=;
        b=adkWWjuBVJKWz+k29lkHpJZgLvsE8Unbi89248gPAsGG+Q1WrPz8aHa7KSXTZB9Ybo
         XUBs+EDDpB1Yf54vr2axcGH5pvrRAPAMqRCtHtMYGfvmMEXNFpCYv0xoiYHO4p9bhIpI
         Pi1XwEvVAg/DzG3e2TFQZ+2f1x67lvNywKraCr7ctek3W6ta0lz7zaijz93ciR44sJzB
         e/fDnOZU5o5wK1IMW5aVsiKptKlhYl58AlztWcKDa5g3fRZeT2vYOvz0H3GJcSYismQR
         y2DPoimdeDBHQVsBXoYSIqbEmPqPLL7ndZvfLgjPUFSa6nf262WrpcrDCZ1DIEUxkROC
         E+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SgkVAHFYBzf7xeOTCAVuEnoDAv9oQxRnYlVtkTlACqw=;
        b=vgEp1v/RqbQE5W8DJuVECSf+ORZvkg02WB/fuvec9ZX0m+JG3s2G3IpcH3byQQFzmU
         uXbm669P/l8VQ4oqBylJaJz4jadS31pK2RvFfA6s5LFBI1eNtEXYDhYqsuUSqDFlKHa+
         1ZXVgodLDgPgw8T/IEZqnR7fea0aOZ/eKzfH8zFrfv0HyxtcV1gloTH3axu/UjhS5jDp
         ncisJmqpSheshyNbDSMpaGdr1Pe5m9oelxX/SkB/uBp5Etd9lbzJf6KO975/0GzQBRVt
         ujg7S1nKxvG2vpedj/8mYr9Io6e2qxUWBt9LjgKTy4kqtN+ij5nPHrvcaHRKem8B+cz6
         YNNg==
X-Gm-Message-State: ACrzQf1/ygdeZSPrZUxwjyjxW8/OCfmsHM01wX1MFzGfJ7/VH62hSeS3
        14RB8jB0Y8qqonCJqhV3pgUe+LQjV1rj1PH66s88MA==
X-Google-Smtp-Source: AMsMyM5WbN+kP6upXD8BHZ2+7x8HSWM2dMtfPxkn6tsEadd4FVsVXgAbowFoG8e54aQRPlNENRIf1Asn7rsJtTUXMjA=
X-Received: by 2002:a67:ab46:0:b0:3a7:d2b6:121b with SMTP id
 k6-20020a67ab46000000b003a7d2b6121bmr6269919vsh.16.1666266252494; Thu, 20 Oct
 2022 04:44:12 -0700 (PDT)
MIME-Version: 1.0
References: <20221019152947.3857217-1-arnd@kernel.org> <20221019152947.3857217-5-arnd@kernel.org>
In-Reply-To: <20221019152947.3857217-5-arnd@kernel.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 20 Oct 2022 13:44:01 +0200
Message-ID: <CAMRc=Mc4AjNiyaw2rQeb6_SrtHNZMXe=ipFyUUwyYvTcT+9zwA@mail.gmail.com>
Subject: Re: [PATCH 04/14] clk: remove davinci dm3xx drivers
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Sekhar Nori <nsekhar@ti.com>, linux-arm-kernel@lists.infradead.org,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 5:33 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The davinci dm3xx machines are all removed, so the clk driver
> is no longer needed. The da8xx platforms are now using DT
> exclusively, so those drivers remain untouched.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
