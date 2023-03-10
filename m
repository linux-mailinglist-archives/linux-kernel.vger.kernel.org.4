Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6ED6B3B14
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 10:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjCJJnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 04:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjCJJnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 04:43:07 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F7D1C5AF
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 01:42:22 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-536b7ffdd34so87254637b3.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 01:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678441339;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5RPb4A7Oehz3TfZh3XBHKc5TBgIrGnLCc3ffP1cCitU=;
        b=MzOOMi0GL5DKa62OrIN7/U4wGQnlbLjfAlGAs/Xs+tOMkEbKA0MmI4L6mzOtMIA/ys
         p6TX67w+sn0XFdhNwBJF+9jKfImTb9ckr6r2HfjXPkDhqkKC0dVG+z7ma3hGhd9rJ69s
         nMs4yt164ThmTdxhp+adSNepWyWaZ19CS3rqGINyYP3K7lKTQcrXK2HOGtu4sahsTslw
         y/v3oAGAPmQymktIaddrrSufOCpHslB/9N33wDDm3Vl6UsI6Fey+AtaXp9lk36D2YKGB
         MtZ2ZmSIAyWXqZJpnarlIAkBQArj3QYqHCPUJ3nHDWNzjVxqtz/DDe4fNDjemCYGFF0y
         2jMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678441339;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5RPb4A7Oehz3TfZh3XBHKc5TBgIrGnLCc3ffP1cCitU=;
        b=P47jUIJRrTlsj9sBDBihYMrliH+pCMZH2l8cTQxrvQwIXbb1221onuWKQ2CBp+yDJj
         oqncZMqOz9CCbwSn48kw8heEahljijBmBxug0fk8dvMCuNX+f5c8fvyWHWpooav85G28
         CDtD/kgbAVgYt+BoKW94vv8/YDNSCX0b1S5OjuvsiTAQ1rfpDgwHI8Grt+MQkJEnw8KP
         A1JeZgdq3O2oXvihNyrv6D6Ty9dJTWikz7V14zJnPn7hP5CdNltM4HeuVfkQ8UGcGA2J
         4vyyrrGZbVw2RVCpXthvtDVnuNoUfJUOi8zMZWrdksdXhsdjRQWxFHdi40SXmLyco9W4
         SNjw==
X-Gm-Message-State: AO0yUKUMtVuc+cjI+rBx8DQQjgn1IH8OYRuNEUjQtgJIRfb33N9b1d3/
        ZTy/Eopf3GceMaxbBFCwbXQ76SZrM7lBkqAz969Wig==
X-Google-Smtp-Source: AK7set9Eri1PaWk76cPuC7cN4Fh3u33L7yyaQ/62+5jggQn2bpqi9YHGkwx5xLBoI4OzTQ8KnM9EyFoGwA0zlu2XEEY=
X-Received: by 2002:a81:ad44:0:b0:52a:92e9:27c1 with SMTP id
 l4-20020a81ad44000000b0052a92e927c1mr16067704ywk.10.1678441339671; Fri, 10
 Mar 2023 01:42:19 -0800 (PST)
MIME-Version: 1.0
References: <20230309185626.84997-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230309185626.84997-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 10 Mar 2023 10:42:08 +0100
Message-ID: <CACRpkdan8+RHDomBQHwHG=Xt3XRwTxXrdksxKKQc-OSY0UdUzQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpiolib: Remove duplicative check in gpiod_find_and_request()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 9, 2023 at 7:56 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> The gpiod_find_by_fwnode() already checks for NULL and returns
> correct error code in case fwnode is invalid. Drop the respective
> check and assignment in the gpiod_find_and_request().
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
