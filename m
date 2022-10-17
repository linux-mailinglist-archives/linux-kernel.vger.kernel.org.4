Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD315600858
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 10:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiJQIHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 04:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiJQIG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 04:06:59 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4748C5973A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 01:06:58 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id z6so4077892uaq.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 01:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n7z2zqfikD651OG+4PqNGLgjVdCisNAlofdRvbyLWcg=;
        b=NdMPhGP7re2rsdLDqwAO5pjkZ0WmwEnl/DutqM++yjkYM88jbyO8FHEhHaZQp50N0r
         WVzoYtJNARRDgvkzHe7QH6BvS661UZA+eCMnFPCTZeAjmjXS/AQa5sZ43SKPR/2SKXKT
         tVA8CHHDUqavWd1yFVCtOIWJGE4WdG1i8J/L3ZGFcbYI0TT96h5G7KDCkSPbaBUCwoUf
         h3kETGy921lChCp0TPBw9sWiPlalFvv60qauMv0Pa2oDzZcBwwxSQBJ4wSU19SXUAgOg
         rWXF1t50JurYxXikU5zaZl20VQIFIE9bgyN69IaakYLI4yMrRmj9ZHsJ3RoQM8vamluo
         TAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n7z2zqfikD651OG+4PqNGLgjVdCisNAlofdRvbyLWcg=;
        b=5hs+Qbcn0SToXQ2QmNyFhEXJKBTWQ8H4OsjQr209zXN5IYjgxXTeeoUTWw6jxtJwts
         RLhMxfau2dwh5NbxQApKobmFglTjPD6+dNenxPlDrKpTwDL7Ijg5h5D9stmIU8fSM5T8
         QGGEdOuL4yezKOJ7eaYrq8uD5QL5lkh7ZYepGkxI+HV8XhREvUCLPoV2CdJWFUyIauDD
         wfUXroc+Iy0+2w/m1jrgT0xcoL2MsoRvZhb8dWOjA9CiOB7B+SubMBcMcdKd+P+U+5XO
         dSS15fuKYCVsODV9tvzgsM/Wg8oX8wsXoo8ZIET1mhVlNM1Yh3NRydc5AtIObVOPYKyj
         Dtnw==
X-Gm-Message-State: ACrzQf0nt8llEsxih/C76Uxk9IlRK4o3SEqdPVK/xuWXaxY0KIcu54Oi
        q5zgCxJcGkxfvjdZyyPL41f1OmBt1ikyLn1Vss367Q==
X-Google-Smtp-Source: AMsMyM5zKGzq/HLcG+oVMJ1IuRtu+Ts3/HzgbGWj/9vgLKcOz67M0wCJQ+LbJp5ikNVBUPZUSTKaAsCMTG02LhSp4C8=
X-Received: by 2002:ab0:2155:0:b0:3e2:bdc:cfa5 with SMTP id
 t21-20020ab02155000000b003e20bdccfa5mr3781207ual.119.1665994017309; Mon, 17
 Oct 2022 01:06:57 -0700 (PDT)
MIME-Version: 1.0
References: <20221015172602.84855-1-clamor95@gmail.com> <20221015172602.84855-2-clamor95@gmail.com>
In-Reply-To: <20221015172602.84855-2-clamor95@gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 17 Oct 2022 10:06:46 +0200
Message-ID: <CAMRc=MfR50MnQo9LpBJQXojEzVn8oAzjLXHC=om=-HwkN+NOuQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] gpio: tegra: Convert to immutable irq chip
To:     Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>, linux-gpio@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 15, 2022 at 7:26 PM Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> Update the driver to use an immutable IRQ chip to fix this warning:
>
>     "not an immutable chip, please consider fixing it!"
>
> Preserve per-chip labels by adding an ->irq_print_chip() callback.
>
> Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # TF201 T30
> Tested-by: Robert Eckelmann <longnoserob@gmail.com> # TF101 T20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> ---

Applied, thanks!

Bart
