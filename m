Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AECE562D5DA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 10:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239592AbiKQJGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 04:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239391AbiKQJGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 04:06:35 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D433F5A6D9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:06:34 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id m22so3389125eji.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GUIHx0FPCP5jR/LHWUfo70UQ3DBjjMXeYhmpJNoLXUk=;
        b=B607JUrWmzu97O71uzkNWPOBJkdpP3cipJkAG7IT3mrsLOKaukWj3bxTmhEjmn3+fA
         mWBqBrERXRNQ8khFV0UGf5jQ69X3/bJp+iiq5+mDF9hKjO1e+idd3FTm91Elsip//i4T
         +Jjf+eZgEL2xM6pL7v9e9YTqhC9PMyj3d7JzAB7Vyb6HyV7atkn3xnHrsI2jsIIbjWXJ
         UKE1hdWP1ejpzDwPHdNTxZq9Xk3Hque7MRsMGjrPh3BZUSeIYC7M6ATlNtkyAj6rjA4v
         IIUFXi0O9OASZZIS/a2v8581ruH7uPnTaLvQSP3xifG4mFVPFd1Cn7et7w2HS1p6ryUz
         AWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GUIHx0FPCP5jR/LHWUfo70UQ3DBjjMXeYhmpJNoLXUk=;
        b=v25USLzSWdhffXK1hsJ62qoUbj3YbxfbfVM1HnXz2ACHMdl82BjnFNkFCPHt8ujt5h
         frp5PipRKH/715vVlsMhFep8prPG9Aay9y7hqcJZBN9cdZerxCXgBmOkbUPDHnSEp4EG
         UkngtSXcInG/+suQmXCtyMJVXMMDUbOw8Ff7IKjBsx0H3+XXJ1I+WNxDYUsGqR+iYsk8
         b1sPqP6f3r/ZCpp8xGKlkd+c2YEPJLi1cnZo3Qj5AG/G+Ai6y13hyvQZzBIFxGjn8h3C
         gZ5U8mVaCmLK6cSy4xrzbaF/WDNeaWUmlTSrcTwEX0nhn54n8QZtlbqMSWDjjRhUnM7l
         1q/A==
X-Gm-Message-State: ANoB5pmdmAp8zb3EZVxY4693DQXIDv+NpYuungz44SmvP62cj97HlnI6
        CvqXtGYRzE07CCFM4eZXuJ9rMsAj18Ohl5bsWNQaEw==
X-Google-Smtp-Source: AA0mqf4rhAyRYJ1YhUZfSZ1LtJ1gZDA/eg1Ro0uNpfoVTGEIXFaU8XJy52TgD5R3G0GRY4ehjVY3PISsNsS3ceWUUQM=
X-Received: by 2002:a17:906:ce35:b0:7ae:215:2dd5 with SMTP id
 sd21-20020a170906ce3500b007ae02152dd5mr1387029ejb.208.1668675993476; Thu, 17
 Nov 2022 01:06:33 -0800 (PST)
MIME-Version: 1.0
References: <20221115221145.2550572-1-dmitry.torokhov@gmail.com> <20221115221145.2550572-4-dmitry.torokhov@gmail.com>
In-Reply-To: <20221115221145.2550572-4-dmitry.torokhov@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 17 Nov 2022 10:06:21 +0100
Message-ID: <CACRpkdbARhDuqSiOZM6GZynHsQWau8JhsEa2zcpsPZSLuD07Kg@mail.gmail.com>
Subject: Re: [PATCH 4/4] media: i2c: s5c73m3: switch to using gpiod API
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 11:11 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> This patch switches the driver away from legacy gpio/of_gpio API to
> gpiod API, and removes use of of_get_named_gpio_flags() which I want to
> make private to gpiolib.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
