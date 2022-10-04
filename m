Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2F05F423A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 13:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiJDLqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 07:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJDLqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 07:46:22 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18354A81F
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 04:46:21 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a2so8160376ejx.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 04:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=oORNADYw2Hs6SXVF89SHeppIwMC8xyCVRPn/dcMDta8=;
        b=wZWjblKQl0aEUQB+vsRy3d/uRWWMj87UVamfoB8EIP1aQgI2xKg4PcftQkrG0xBw55
         3m5310nYhRkYhBm+1K+XqA9RLDCtm+4gXWbglf78SWX4z/0AgiIK3cvTNlPHINt8RkXy
         6TOStrr2gGBaIAo5w/UDRMc4USsUm1ygbSnY9byqcb6SJBVK+i62NNhfV276hJl+Exzm
         XzvgEyn6ekFYzmoO4jfu8QNcrZLD9MbO+g7jg+SfjQejp/p7v8Er31pJ19hTt9aY0d84
         YOd/OCCoWDwbZ4keWrC2tGNMy4ufJdh5w7NZ5nbEun0ddCh0aMPaGF8GZeiuM2jL4jMv
         ajAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=oORNADYw2Hs6SXVF89SHeppIwMC8xyCVRPn/dcMDta8=;
        b=z0mnkVulis20K9OmgETCej2ElFqMJlpyirGM2vAWicrFO+REe1sslznJKGpRyW8O4b
         hntVV07rhWe44S7J7umNv436Bflklwy98RdN1r4pY2xR0Gy6miFKojgMN1jR2FY572Dr
         gDF5U1QXA6l2a49KcvV4gvD1FvdxFKrmEwV+IyhYMxelrvyWd7vUpcjW2au0dz/vJZqx
         gSKd9XcHTGnx1MBSEa7cIoWrPTH+p3AB5dAQjTLax78weJHDJscRgEgHwAAlfiIxzYSe
         ouGbLIaVCpaqpcHYqJPodwB4CpSUWiyBRpA6d9Uno97lBeQCBYuqJW6MzouzUfaU3KZB
         quwQ==
X-Gm-Message-State: ACrzQf2MtqHgLijuUkEU8AdqVv5nUzAKFl+FLQad3zEn3b2wmqSPztQ6
        EhR8oKwNa57D6QX1hafQu8Dm7zfiz1I00NQnvM4GjA==
X-Google-Smtp-Source: AMsMyM6Rl8AvED4hTgT4ckn9RdP7PY+Ahr8aGamCW4ge3WsJ6i9dOd1oT50zsTn5swY3Q+E9I7UEGLnLchLwdXv5+sU=
X-Received: by 2002:a17:907:2d0b:b0:782:76dc:e557 with SMTP id
 gs11-20020a1709072d0b00b0078276dce557mr18020112ejc.690.1664883980452; Tue, 04
 Oct 2022 04:46:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220925021258.1492905-1-yangyingliang@huawei.com>
In-Reply-To: <20220925021258.1492905-1-yangyingliang@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 4 Oct 2022 13:46:08 +0200
Message-ID: <CACRpkdZijkQAT84mfP06SgxBjHmrqSbWwctBBA0pvb_1xYzGvA@mail.gmail.com>
Subject: Re: [PATCH -next v3] pinctrl: ocelot: add missing destroy_workqueue()
 in error path in ocelot_pinctrl_probe()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, horatiu.vultur@microchip.com,
        andy.shevchenko@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 25, 2022 at 4:06 AM Yang Yingliang <yangyingliang@huawei.com> wrote:

> Using devm_add_action_or_reset() to make workqueue device-managed, so it can be
> destroy whenever the driver is unbound.
>
> Fixes: c297561bc98a ("pinctrl: ocelot: Fix interrupt controller")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
> v3:
>   Using devm_add_action_or_reset().

Patch applied, after deleting the hunks removing .remove because
that was already gone upstream.

Yours,
Linus Walleij
