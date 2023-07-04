Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43385746CEE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 11:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjGDJL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 05:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbjGDJLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 05:11:55 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2FF136
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 02:11:53 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-c4d1b491095so3256636276.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 02:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688461912; x=1691053912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r37X64MkxE2953+nhgmVZSnQSf+m5XeSlLa0brc2dAY=;
        b=Hx/g88ElX/Kct0Oy36/KaEGVCIotyUj5L99gcUNRYKqofPwIM/ZB3QyqfIedV8lmTN
         9VIMiYDxyl3wItImuVqVYe50uvNifb3GFAhHQVxLRzhhCuF4piMZcOf+Cl4yNPtbgvH5
         fd14FkfdxvtboKKfxvb847yLg7XVjEgDxQkXtUKEDILN6C0h6m/IE3+YW5Ay2RNOSGPS
         W88L0EcYBrbztf6U4cnYynpha8DrFW9NAJ3IwOXyNCSwu7evkKx7p4cr4ou88xeZ0+OD
         pme3S+xJ8B7l7ZXZG4j5hWZaVF4Go1xTiKv456+GGbefInmn5U1gVgcXBNIJrYMLUqOq
         ZDdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688461912; x=1691053912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r37X64MkxE2953+nhgmVZSnQSf+m5XeSlLa0brc2dAY=;
        b=MBNcyPglGYXwMANgZWS6R+EBHRjbIbZgFFRBPdsQORuqbgjPwzWnl6NlvdtWVlByHk
         jbscpRbBcAd6l8SQ8WvJTWbqp6RT9mB8uxmmljiBU8GnmANvHUL0dDFU+cMAZ/wTD7k4
         aquXbBsg57d6o3ktdT8A3SdaGew5bcfB+/lvcjM3qF7ncfkIMrpEWaCXW630rXvOFW0U
         WyQu/UHJWT7la3MQux7jUbWy3JS7RG3CfA+NQnHzCzH1dPSGCWAo2n/HNPQ8s/MT7ZKS
         LRD/9xO8SjS/MOWIfD/AAwA2FAtfXA781VpMXjqqf+XC+ZC2CFPzMLnWfgRZ7GYp3w0r
         BuzQ==
X-Gm-Message-State: ABy/qLYrKsm7JWziv7/a2TxMD1+wqfVmMZ4Df3gfLScYl5pdFB7B4cDr
        xkXlK6nsldm2smqi6qZhhQ+vHi97kqY2IntP50QnpvLNvG6sF1QF
X-Google-Smtp-Source: APBJJlHcnv/nKMQJPCeCeIg0yBEb03QMd6LqU0leNGr8Zuxowp+WgPrAEmz1kAOu4naw9cbKn17JcmpvnO2n2/NJGxU=
X-Received: by 2002:a25:fc15:0:b0:ba8:2e05:3e9c with SMTP id
 v21-20020a25fc15000000b00ba82e053e9cmr11654496ybd.24.1688461912722; Tue, 04
 Jul 2023 02:11:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230703142308.5772-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230703142308.5772-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 4 Jul 2023 11:11:41 +0200
Message-ID: <CACRpkdat-z3K4GxGXYMYtv1NAWbGY2K3DvutY+y1V5Bkyy7=UA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] gpiolib: Avoid modifying GPIO chip fwnode
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
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

On Mon, Jul 3, 2023 at 4:23=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Ideally the GPIO chip data structure has to be constant.
> In real life it's not true, but we can make it closer to
> that. Hence the series.

The series looks completely reasonable to me:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
