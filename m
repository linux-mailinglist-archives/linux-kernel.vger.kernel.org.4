Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF1F640A54
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbiLBQMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233768AbiLBQL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:11:59 -0500
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42AB2ACA6A
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 08:11:58 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id e24so1812064uam.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 08:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TAefJrRL7K4A+RMGngmdLs8YqkmKSbBIjbXCxnKmhbs=;
        b=OTdGscoyyXY4sJr8w9cmCX0xSvhEErZUBMdHPPKX/5+iYfWQdgtRA4jjcNYzRwCGFQ
         rU6lS4qgX5LkqwunFDKXyrFmNIkukP6ir/ILfkqTFuvG0gbbtlUSljSwUxGUOl2HDdET
         SwhUO7sNYmbE+qzpnT3fuzzUzQU/YUivMVuklk0khfLjB7pEbm1EvNDxRMGtRV1KIzC0
         zeEhRu5/xAlTU2/SPZ8ZHZNt+Z3ZT0Wg+Odu6EdGqbdqbwDF2yJz/eh/QzqqDYuXMEDk
         3VHckgxrYQUX1IKG4EAs/X+d4p66OEl+1gbN16LQZjnW4pULS6EOCE0G+0jvhUMmmWVG
         oCEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TAefJrRL7K4A+RMGngmdLs8YqkmKSbBIjbXCxnKmhbs=;
        b=hEwTTWsU9tWrVavnn2H9cYKJ93T4s7gM/pIO2jDFggSjbuVZQ5g9cTo9/tsINSfIQv
         vbeK6jGlwDgpXpw8dbAszr0VGkRGqRmafnDidiKVedEq8BSBywPQTB2gvLwJdW5KA48N
         RElVrPTl2Yz2G2Sva+VuZW0hWngHvcRAGMJtmZLf4JAOe8uKjQyZsqT4DnoRgmK6+EDc
         NlUAkZ6/K0/npAfRTEBY+av4wOurM2yP0SwbGP5lHOHrAB5BpteQMk4fQ/10aAAak/IA
         E1xy4bcY38zCbpZpEd2xQ7ANpOtzD6VmiHooTncpwxZv/VuR0i/qAFvf5F6qhPgthttf
         O4rA==
X-Gm-Message-State: ANoB5pl9VXr4eaDskAjH8IdiAF3h1Y7fJb4UcWtAgukhi69tHVHaum59
        vKHNQNnaZ/z2clih4Nc/sHJcuuWHlU5Vaqv/xADKDA==
X-Google-Smtp-Source: AA0mqf6y8bCMPq1LTVZ8bKCUOnTJ4Vq1GPxxgwR2WlG4b/Lw466vVq5YLikadhKWjms/IOLGdHK46U6YPHGpuihZdkw=
X-Received: by 2002:ab0:734e:0:b0:419:18c7:58d with SMTP id
 k14-20020ab0734e000000b0041918c7058dmr17210680uap.119.1669997517287; Fri, 02
 Dec 2022 08:11:57 -0800 (PST)
MIME-Version: 1.0
References: <20221201123220.7893-1-zhuyinbo@loongson.cn>
In-Reply-To: <20221201123220.7893-1-zhuyinbo@loongson.cn>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 2 Dec 2022 17:11:46 +0100
Message-ID: <CAMRc=MdSfw2-qbcOReEKnhNj4QaTy4mkJL+fH3m7nTBuLhxZaw@mail.gmail.com>
Subject: Re: [PATCH v10 1/2] gpio: loongson: add gpio driver support
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 1, 2022 at 1:33 PM Yinbo Zhu <zhuyinbo@loongson.cn> wrote:
>
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
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Both patches applied.

For the future: please reverse the order of patches and send dt
bindings before the driver code.

Bartosz
