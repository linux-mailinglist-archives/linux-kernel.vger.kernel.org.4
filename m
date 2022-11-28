Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABEAA63B36E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 21:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbiK1UiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 15:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234307AbiK1Uh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 15:37:57 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36728E92
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 12:37:31 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-3a7081e3b95so118417147b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 12:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Be9fcRFb+iBXtwrEt2w+xItkZ62HJRwPRVzp0QrUGXs=;
        b=MkXQB5OgJq8mcUlg1oxBB/+/M1OdRykLerdCz/RALQ7YP98YD5Hp95vOvkH7PMmrQn
         rSaaDU29SiwDCUB2QgelBIP75pHs7ittRdmNjf/DAfkaSuqtEdm4k4c6YFm84aS/yqsE
         bbN/xg44PhNQDVqdm8TZxXM5Aif9KJAFQKp5vpxiI9CFOXE5ZNvcKte7bVpHX4oQ1R9S
         2+b2pLM+kBawV5Lb1rrXheTpK0QL/jkR3lSMwz0x3CxGa+41/162ZHxOWdzvxayj9OSl
         P+bc41WXLZwEwoWjfJkBgzmNl1yVEv1MftxFlqYOFDMGw80mKiSGC4wCQ/imCnAs6yrC
         XRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Be9fcRFb+iBXtwrEt2w+xItkZ62HJRwPRVzp0QrUGXs=;
        b=g1qBVv7NmE9rmRxHJD5exXddv0gGnTsyt1rHWkEoBJh8y5wRldEWDiatn9YZKFfGfu
         8U9/xt7A8uvYGXuUvwY9BoVRjNiE6Qs1EaPbeLLDs2edQeI3cDJAAAOgF0QSWiOQgUIe
         xIu/dNPigPnv4VJZ9ux87F0Z5FyVa9vCFy7ywAxuN2DMharPM2kRv9QwaPwOj6duws0m
         a0eV3PZ8b1FIGeWyM69tGTDa5nGuQHOTtSNDgx1hzqtgLBR3R6P95zhMGp0GwuSsi+ug
         yRez7Foh/d1zdEgUywbHTOaAO/74LiaDeAd3HXdHIpcoacw2wslT1DbUQ3xoamaxXo/1
         9Cng==
X-Gm-Message-State: ANoB5pl1GZBKEXVDJQ46KNNt368VfdLQb364rLjo4W1yW4B6wZCfBwzg
        BReOEebYNBuAz+ZNR3O80OrodYULRBJsnjWAEnQ8yQ==
X-Google-Smtp-Source: AA0mqf4aBg2mwDM8RJm0Cjg/v7cTvSlnBRa9Z2/ZVsQUyCqFE6E6HBJlcn8f1czkYtVuaDfYqb2WId3bsK/c3teKXLI=
X-Received: by 2002:a0d:fdc7:0:b0:37a:e8f:3cd3 with SMTP id
 n190-20020a0dfdc7000000b0037a0e8f3cd3mr49928758ywf.187.1669667851150; Mon, 28
 Nov 2022 12:37:31 -0800 (PST)
MIME-Version: 1.0
References: <20221128175214.602612-1-brgl@bgdev.pl>
In-Reply-To: <20221128175214.602612-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 28 Nov 2022 21:37:20 +0100
Message-ID: <CACRpkdb+C64AF_N3goRz206k_YfoHn3_kietet6yvz=FrbuUWw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] gpiolib: don't allow user-space to crash the
 kernel with hot-unplugs
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 6:52 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> This is a second iteration of the changes that aim at fixing the situation
> in which the user-space can provoke a NULL-pointer derefence in the kernel
> when a GPIO device that's in use by user-space is removed.
>
> v1 -> v2:
> - add missing gdev->chip checks in patch 1/2
> - add a second patch that protects the structures that can be accessed
>   by user-space calls against concurrent removal

Thanks for looking into this.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
for the series.

Yours,
Linus Walleij
