Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C757063B357
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 21:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234159AbiK1UgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 15:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234158AbiK1UgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 15:36:10 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37692BB12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 12:36:08 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id y83so14865904yby.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 12:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ffVK8yqAhUy/OhUiWpfwiQeRb9vfkg2xW2w/cRvgmp4=;
        b=nu3s1s0tkqgG/V6gfUUR0jDBHO241Z2Q02/3bsAJgUH9hyDxN8+Wmwv5hSoESD2hwE
         mbAzn7ZXAq7nElQ8hXp3zX4HQrsN/dTCnfpNSSuqC61K4Wz7vm1Hou2VlYXsT7rILsMK
         2e5MMc3Wc12gqhOx+ObgrKNXadDAg6HNg2x1ZCgPLGt4aUupga/UyzM/z54RmxsBih30
         2vhm3OwFvRX7H6vu85Kz9wwCCqOCWnxz/CkjDI00qR6F8WJMAZnsL+78qCN4Wlo3UG7j
         rVITfThiY0FU/FnrBMzabKitY9erhvExF4Iu32yS7EoQvr7jVCjoMPxK/5b70XxODCk9
         elHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ffVK8yqAhUy/OhUiWpfwiQeRb9vfkg2xW2w/cRvgmp4=;
        b=S3sxEf9M3KsdF0LWhjyf/GI1KORfNcP1JxyTT8ktXSSsnGF7adopiw4R6e7HXFBRAh
         8Hp64X6qBY0RdbnvRn8FvgTqffUmKX23sttalU41NM470EeefdFJNWKngYqq78pa4cIu
         KEUq/Px7NuO/4M4DUnRjJHBXl9pzPDAPKHzIApW5jgSG044FAH7BeY9U6wT6bv08znoP
         RYSWv1Qd3I1IMFMCAkuiK3Et6IIsCVd7O1nti8kxN0YuRutxre70krQi7iSo+yDZhmsc
         iYYsykHN4ywTIVKlwoKJueOhMoc00GbTFgRnceShvCiNvflnHTPOabrNhZw0btHFFDf7
         y7Sg==
X-Gm-Message-State: ANoB5pks5tA1bk9/PAS29bxgH1bmXh2w8HgRKmEj3g8GTkKwQP7FmxuB
        ymkJ+15/ApsD5Ky9EtChtUY2SdcInL6vUFKnf5AVZw==
X-Google-Smtp-Source: AA0mqf4CS52Hau/+WD0GVr3Atq6ZuHXn54OHpA8BjNuCq5Qb6+eIDNPSWbaHzJSKIECaXQPMyGcq4UuR2YB9ZaGuAG8=
X-Received: by 2002:a25:a241:0:b0:6ee:e865:c2e2 with SMTP id
 b59-20020a25a241000000b006eee865c2e2mr29663269ybi.206.1669667768154; Mon, 28
 Nov 2022 12:36:08 -0800 (PST)
MIME-Version: 1.0
References: <20221128064300.12021-1-zhuyinbo@loongson.cn>
In-Reply-To: <20221128064300.12021-1-zhuyinbo@loongson.cn>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 28 Nov 2022 21:35:56 +0100
Message-ID: <CACRpkdZoD8v6pPStaKLf14houZk5e89ZBz5wZJVQJxJ1Xq37Ug@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] gpio: loongson: add gpio driver support
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Juxin Gao <gaojuxin@loongson.cn>,
        Bibo Mao <maobibo@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        Arnaud Patard <apatard@mandriva.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Hongchen Zhang <zhanghongchen@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>
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

On Mon, Nov 28, 2022 at 7:43 AM Yinbo Zhu <zhuyinbo@loongson.cn> wrote:

> The Loongson platforms GPIO controller contains 60 GPIO pins in total,
> 4 of which are dedicated GPIO pins, and the remaining 56 are reused
> with other functions. Each GPIO can set input/output and has the
> interrupt capability.
>
> This driver added support for Loongson GPIO controller and support to
> use DTS or ACPI to descibe GPIO device resources.
>
> Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
> Signed-off-by: Liu Peibao <liupeibao@loongson.cn>
> Signed-off-by: Juxin Gao <gaojuxin@loongson.cn>
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>

v8 looks really nice.

> +static int loongson_gpio_to_irq(
> +                       struct gpio_chip *chip, unsigned int offset)
> +{
> +       struct platform_device *pdev =
> +               container_of(chip->parent, struct platform_device, dev);
> +
> +       if (offset >= chip->ngpio)
> +               return -EINVAL;

You forgot to drop this.

With this fixed (and Bartosz requested fix):
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
