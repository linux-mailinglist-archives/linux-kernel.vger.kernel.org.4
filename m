Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA4267E63A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 14:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234593AbjA0NLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 08:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234604AbjA0NK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 08:10:59 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F8281B18
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 05:10:11 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id h5so5878330ybj.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 05:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6EaD6W/S0YLPLlO0NOEEWCexFTPhbR2h9AHejGCOWoo=;
        b=KhD6ikkx0sWSznQB77WqYTaJrglBu3sUFfEZJ+1RRBRaL+KZbcpc273+lymeabAqHk
         51VFeos0j+Nybp65jgqDcNlP1ZGg7+Llz5nZY35FKTYRvt1LoOBCe/XGkDAIdAB8KI20
         7HX+56mlyFRhVT/SvweV8u4G5mc9Cv6sapGZ+hFGaX1AbfHFEQK5chPT3HiBULvOAOYW
         D/GnRQOhsKsCDnHWj3vydfBBJTHbTGjFFHvM770SeHliXa8ID4Y9Eoj4nH4WkLV9itEj
         H6hnZm6cYgH3lS3uEVm4oRu0g2d1xbJ31UEt0BOXO3PajLRPQ6h8PUdk7S5wDc242zsQ
         kJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6EaD6W/S0YLPLlO0NOEEWCexFTPhbR2h9AHejGCOWoo=;
        b=J1wRr4nbOw3YX7hRgCF4Y0E5ng9BZ3dG58Gf+OQdyDEpHwvYcru1YJXo5Hv4Cw0NMY
         GOc2uSPpksJUyEkso5mnYeLAMzOsEabX/3xr+DfeS1wvdT/1yT8MXM6+KvmenRB6Aiop
         HxCWBGrVkMTCG+UVR82z95AYTm73BW8LQmH0vnVCk9rY38Hsu5zWKzzOJ5SxMar50XDw
         is6oa7RuyLOIy2C5RZW1rLTqtGHYJxwUTgNYpimvheT/g6SKX19wSRq93ZxCPXENvEU0
         WOSCNF9iMb1KUI/oHwZFPSd2HYGL+IyI3LNAxVLYxCC+MlRHsidoD8M4jvVoYVBekKiK
         YS6A==
X-Gm-Message-State: AO0yUKWlCo8OL1OBsTX+rjxo0PqdUddW44u5aPCYFJ3JerkkdA/e9/dd
        KuIheDVNdg5ewd7T8Qu0qbsu91sGcp7r8ayz07uEtGl2t/NCGg==
X-Google-Smtp-Source: AK7set9bACPaQ7KwH9CqWpmBe+Foqr5ywhnkRqa94E3zNnD8OntZk53huCN7bHn8Wfc+z7ZEyCH/A/uReUmVu7X5DDs=
X-Received: by 2002:a25:d884:0:b0:80b:66c5:9fc5 with SMTP id
 p126-20020a25d884000000b0080b66c59fc5mr1749776ybg.210.1674825009218; Fri, 27
 Jan 2023 05:10:09 -0800 (PST)
MIME-Version: 1.0
References: <20230126132801.2042371-1-arnd@kernel.org> <20230126132801.2042371-6-arnd@kernel.org>
In-Reply-To: <20230126132801.2042371-6-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 27 Jan 2023 14:09:58 +0100
Message-ID: <CACRpkdavhwMGxeHYKVwfvc9+B2sxhCcY=yRwbmik0Lde6OPyig@mail.gmail.com>
Subject: Re: [PATCH 5/8] gpiolib: remove legacy gpio_export
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-gpio@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 2:28 PM Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> There are only a handful of users of gpio_export() and
> related functions.
>
> As these are just wrappers around the modern gpiod_export()
> helper, remove the wrappers and open-code the gpio_to_desc
> in all callers to shrink the legacy API.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
