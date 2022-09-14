Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA005B8958
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 15:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiINNns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 09:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiINNnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 09:43:45 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2DA326F8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 06:43:43 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id gh9so34844196ejc.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 06:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=UbxIwKxI44ZUYFrzXMEVDS7APV6/keTlYAsbV46sQRQ=;
        b=DXBjEqme/sm5yIDza0gnUSLZabm3SfQTBmD9ru674awSy2Oll33xPvY+FCF15TUTlQ
         mWaK7jh64Yo/nqbeL+C7f5Qm0nMZoBA+NTURgcXItBzhhmZXK9QdrRt/kCJs36E+dR4+
         CoKCosfTlVKjnnkexE4qDuO83oM7ReGNxKhypiaXzgf58sZePAXrrAZUW/Du0qRewE/r
         mj0cLV0km9O65xnmftS2dlHD45jwDHSNXMcpsf9WAhpDPj7zIqpQngRaQ4bWj54pYuKg
         xN6Y1WZM1HUT6UYHvIY+s9OtBXZIYSkaLTmNu6PTAFUxXehhLE4sYEevhA0ahsvTr9Yh
         a6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=UbxIwKxI44ZUYFrzXMEVDS7APV6/keTlYAsbV46sQRQ=;
        b=baiedzKYmRyGH+y7X15muvlHDGj4FspntuznPt6yt8dw7GhFoRcR2dw32Z9nPXBvru
         E8rAJMW/pAs+QZ4ysqzdl0ykZHpfeBtUdNFrt8bRuYqrK88vI4H1cGHYlJTVYjGMfxxa
         Tnn/3jLtUexHy48k5cirISuaklmtL02Q5Z7kHDiWU7G/ugvlzoAh7YuqxyAzNvEfourJ
         mesZgHTeLt9k0dPaG9BGLvUZQXPqaOlFAD7lITijCtdCrtoUprp9GB0YMYC+LRMZW0Cj
         t/bSDZlWJxfOjXXvlVpvYu7dTf/j9piJMBO8aJOpmg57BKXmSiM9ReKq8HCAXSUuX1/Y
         12OQ==
X-Gm-Message-State: ACgBeo1i71ahKmHZjTkvJJPP0z0qD+RcUyX6NSDltF1jsD0wryd1fzqD
        af9N/TFBEc9PwHmUOptTdHV3rCBlBIIowlhkYy52Og==
X-Google-Smtp-Source: AA6agR4Pwbd8M242EgeY2yL21U+ksFTwSMStaJSUSxC+/NOxWXnGiV2skls/5rlLP99gGsIcM4/4qvFuKls1brp+aQk=
X-Received: by 2002:a17:906:8a5c:b0:77c:9d8:6fbc with SMTP id
 gx28-20020a1709068a5c00b0077c09d86fbcmr12751012ejc.500.1663163022147; Wed, 14
 Sep 2022 06:43:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220914122110.7246-1-pshete@nvidia.com>
In-Reply-To: <20220914122110.7246-1-pshete@nvidia.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 14 Sep 2022 15:43:31 +0200
Message-ID: <CACRpkdZu_6=ZPrNbWVC9wBH5nZvAXcZmWjGb4FtjVZi6fAW1DA@mail.gmail.com>
Subject: Re: [PATCH] gpio: tegra186: Check GPIO pin permission before access.
To:     Prathamesh Shete <pshete@nvidia.com>
Cc:     bgolaszewski@baylibre.com, linux-gpio@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        jonathanh@nvidia.com, thierry.reding@gmail.com,
        smangipudi@nvidia.com, kyarlagadda@nvidia.com,
        Manish Bhardwaj <mbhardwaj@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 2:21 PM Prathamesh Shete <pshete@nvidia.com> wrote:

> This change checks if we have the necessary permission to
> access the GPIO. For devices that have support for virtualisation
> we need to check both the TEGRA186_GPIO_VM_REG and the
> TEGRA186_GPIO_SCR_REG registers. For device that do not have
> virtualisation support for GPIOs we only need to check the
> TEGRA186_GPIO_SCR_REG register.
>
> Signed-off-by: Manish Bhardwaj <mbhardwaj@nvidia.com>
> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>

Instead of doing this check in each and every single gpio callback,
set up the .init_valid_mask on struct gpio_chip, add a for-loop
looping over all GPIOs and fill in the .valid_mask.

This way the gpiolib core will do the check for you.

git grep init_valid_mask for a bunch of examples on how to use this.

Oh I see Thierry already said the same while I was typing :)

Yours,
Linus Walleij
