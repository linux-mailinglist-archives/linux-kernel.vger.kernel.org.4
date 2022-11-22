Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA51633744
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 09:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbiKVIgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 03:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiKVIgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 03:36:44 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4BE2AC56
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 00:36:43 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-36cbcda2157so137023317b3.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 00:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lUUgD95//RU7QNfaqwzY3u2n51Gl06HD4BZ0NZiwqZk=;
        b=fdRi8jqB82MbdhC/mDQxvLI8IL1vLHj3nLqB63J4wlOVnjP3ErEnflvFv9n97fXATT
         VUYbeAdL+jb70TEKLjHPdTIn/t/zzAtNVw/jC7TU++lst6wYGGTLVHf23xD7QbySOvXA
         ZgUeGiiKiwak+sployhEZFifSSodamyizVnaE23Kd91vtW5Zglol3Mjwi4Suv85XK5rC
         kNC4wULi6a1NIHPI6Pcz5WaSyyWrXuM2qSAzjJ9sjk7n0GEUEqzYtdE5ZSgye/Bz3NfD
         +dNT0MF8PPOUcTPHHWue7J2XsLbNGxQX/1QaqiQDqpeGZx8A2gZyE9gVlX9gV75oYSJx
         DEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lUUgD95//RU7QNfaqwzY3u2n51Gl06HD4BZ0NZiwqZk=;
        b=ikJxvE/IKbwGTdiyRS1/9+EvHNTs+mh6YcOJ4g9JR9TWeGeG/ub2cr0m1tZFolzBs6
         Fy1ct64DBaXXKQPyAsP5r6+HSbSfPl2x1cC//3fwMrrIQW7KKHh1fUoXeiTNujeD0YkT
         I+1h6+qoleJJotDMgcu2taJjclFcGlnS01pqfpVX00rnJmcuYHA42EHuG6fZHTN0Otx6
         HHXPpGGyWxbusOLay9p74qirlmV3GXySMxTbQRvLKNTPHcxX7W0rkCXR0KX0+ZW63GNn
         YR82XBQ3bPftcOR1jdPQ2r+Py73LtmKLE0athDJmL+CqJHLY8Dnl6WsvEX91UZNvvIt1
         LlEw==
X-Gm-Message-State: ANoB5pndzln+sMbVgsMjoj/nxFZQ7XzA2zPlc9T2XdPdYt4wZ5mS+wRT
        VjfiXyeDFrfz937OgaulNMCwmClSOj6mFgtPoiGPZw==
X-Google-Smtp-Source: AA0mqf7gJGL8BNHxmjcbLv085HdAVJ2BC5W4/LeM3apSj6BBZi4iDOLuIfjo/uIeUd18Uxg0LBYyqp0bf8dqjoK6b8g=
X-Received: by 2002:a0d:fdc7:0:b0:37a:e8f:3cd3 with SMTP id
 n190-20020a0dfdc7000000b0037a0e8f3cd3mr20960901ywf.187.1669106203169; Tue, 22
 Nov 2022 00:36:43 -0800 (PST)
MIME-Version: 1.0
References: <20221122075853.2496680-1-zhangpeng362@huawei.com>
In-Reply-To: <20221122075853.2496680-1-zhangpeng362@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 22 Nov 2022 09:36:32 +0100
Message-ID: <CACRpkdbj56x+HwxrRzmR+wUQmYuViqu4JCuUGn6p9sCitTanyw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: call of_node_put() when breaking out of for_each_available_child_of_node()
To:     Peng Zhang <zhangpeng362@huawei.com>
Cc:     damien.lemoal@wdc.com, seanga2@gmail.com, palmerdabbelt@google.com,
        linux-riscv@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, sunnanyong@huawei.com,
        wangkefeng.wang@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 8:34 AM Peng Zhang <zhangpeng362@huawei.com> wrote:

> From: ZhangPeng <zhangpeng362@huawei.com>
>
> Since for_each_available_child_of_node() will increase the refcount of
> node, we need to call of_node_put() manually when breaking out of the
> iteration.
>
> Fixes: d4c34d09ab03 ("pinctrl: Add RISC-V Canaan Kendryte K210 FPIOA driver")
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>

Patch applied.

Yours,
Linus Walleij
