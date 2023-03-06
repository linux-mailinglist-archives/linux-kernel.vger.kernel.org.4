Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE63B6AC321
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjCFOXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjCFOXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:23:31 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824C936681
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 06:22:18 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id f20so6542853uam.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 06:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678112459;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vHCoqws6nzCwLWKubM4RZxyDqCdsgMa8R2vUKk4gvJw=;
        b=DgaZ5MegoGgHQnAnSbVTT0nQ2PGmLKJcUSSeRlgU6ccw8HPMNLL60XBDy1p2d5lDX5
         e40MnOMkCHk96y75IEXeHd11pWQRhDRWXtmGHBIq9/gvNIyQP22uKQaT/sFWQdvU5yNB
         2p/GcAjcGKFjmRAaeZOXdZP6CEbLNH2AdvvOoMZAYRDOUOs/IkG2gtx6dTCVUYs0TxKq
         4C2uJH/8Stjw3NGNLXNpojvUZBN/c+PCHzpfK3PfrSnMplQG6qkFq2hV7HeYqYNpLvAK
         muiqB7S8q21z6Xxpk1vvnB4gfRxmjCLj9mO6/IisT3P7Tv7W83IYxx1wU1L9CFYBZS+9
         5hKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678112459;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vHCoqws6nzCwLWKubM4RZxyDqCdsgMa8R2vUKk4gvJw=;
        b=A6xjbp7T0hx6te6MPymOHuXZNGHVK+jokyd01d0TrmVae7X9eZsMGLhUZc3MYLprYT
         sLP33rfPGGvddrHMbt4jN6yyU4hWEzy02glUkVuE/WrW1l8Y9Q6or7vGDY1OphQju94I
         GmHcMtLAgW0PbWis6HB33C81wVAq3fVRTXP+uM6pORAHX/jy+sHaeye0Yy47GkYKscZp
         lLk3lSe3QFavpjqLBbVdMOYqgwxyuLfEBqJFXUrVyk/Psy+vFvVHOxHkCe7IEubWdALh
         W+3x1DW1JHX7HYcpUGV6jb1AKANzBEizRLT1ltQM8Qhy7PUrvEf3h0hfdRqa2NLagFUk
         vf3g==
X-Gm-Message-State: AO0yUKVItSjsUfNPoddEW3mHdH54d6JFUkN/MyoGxpjKMFCiX2tQQNrd
        5RW7etfV+WOq95oOYwO6LYu3KX7MgK2MnCvxsL/aXvpSPSQmNKzd
X-Google-Smtp-Source: AK7set/St9kZ5LRoOkmLszQTz/sb64Pi3//k5vU4LxkcQwJNZMnCqiqjT/Yiky4obv8UCmxEUiW0O/BaB4kC8/5bkSs=
X-Received: by 2002:a81:b61a:0:b0:52e:c79a:cda with SMTP id
 u26-20020a81b61a000000b0052ec79a0cdamr6878682ywh.10.1678111987291; Mon, 06
 Mar 2023 06:13:07 -0800 (PST)
MIME-Version: 1.0
References: <cover.1677515341.git.william.gray@linaro.org>
In-Reply-To: <cover.1677515341.git.william.gray@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 6 Mar 2023 15:12:56 +0100
Message-ID: <CACRpkdbAMQ0OAMnxuyf6gMFu8qJakmT=WvRzBTXavXFmnJ9ObA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Migrate IDIO-16 GPIO drivers to regmap API
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     brgl@bgdev.pl, broonie@kernel.org,
        andriy.shevchenko@linux.intel.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 5:54 PM William Breathitt Gray
<william.gray@linaro.org> wrote:

This looks good to me.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Bartosz, of you merge this you can drop the corresponding
patches to immutable irqchip conversion for these chips
that I will be posting shortly (currently on the build servers).

Yours,
Linus Walleij
