Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47465BAC24
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 13:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiIPLQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 07:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiIPLQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 07:16:04 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C489D4D243
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 04:16:02 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id f20so26528448edf.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 04:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=CtLmBvSGF9G/cTvO/YKOaNGaTkKUBZ/GK1jqCp97+g8=;
        b=dANW5krWzq/RisUGlhFvV8rQy2eqvqAxU6Klg4ngeTPRUo2is7byRaVn7wBx0wlU2i
         2xulGMS3vdBKTF7r1sXh1/DfUdY+AcZKThTs4p5wDS0nrdhWuEiq9IGYJUbKIUQAzg5n
         OFw8TTAZARbWtuj71UL2iO76QIxMeAAgw0fckUQDgf56tTKUIsKITST76l9Hop2WXeEP
         gnUo+9921iZvgN12ftErl0mFlskWj3YEtgDiviU+JSiOIXYHjpP2/mYZhaLyVGlqVkvQ
         IqbkXeBONW3ivp1IYCvr1a/UWax9iHHaVesvtYXnDjZQ7Om831OnI1XDdNInrctEEdZp
         4e9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=CtLmBvSGF9G/cTvO/YKOaNGaTkKUBZ/GK1jqCp97+g8=;
        b=G2MUuQAvOnq1lGYzK4jpvVak250yScu8uPMS0MYpqEUX+Vrz+ZhhGy2LvD+WMXetHW
         odAgOwDYtjaUFeabq3GhD9PP9D+u9cGvJRwYGnTSPqs/24xvCrRG2sKgF2qsLgvovL3i
         h6NY216Ts3Ol+KnVWQI9c9POFEzVPtmpGTdBVMvYdmbNd9CqzxDoAhi9Tcl4Gi5Ctbeo
         UMjauF6ZpcmstN1UQL5lstX2z/yrEDO1iMKb6HYEUQE5TiMTeJFJTUD58fQb0sBdslOz
         1/yb9Wwi4UBM2FFk933LSBsb4gYLzXa2OpZblImkY0sgdvKVaHs92E0UoHOm8zoGRF+3
         eFag==
X-Gm-Message-State: ACrzQf3cIz9W/mrsOqAMh19nnc6Eq/OdHiQdjrC7zl2ZJLPegybCMw04
        qng94NANsL7EOZfAGYUde/oW1rEQBj8lUu4WF4nuRA==
X-Google-Smtp-Source: AMsMyM7xbpcidruWPNfmRr9SYh76gCBUmw46pm0QVUEVrlRhRkDwhYFUwov7WKGgZW6ATKSiY3EKHqEwGRLbD1Ab0nA=
X-Received: by 2002:a05:6402:f07:b0:450:bf95:59e9 with SMTP id
 i7-20020a0564020f0700b00450bf9559e9mr3579258eda.46.1663326961409; Fri, 16 Sep
 2022 04:16:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220706163135.53874-1-alexander.sverdlin@nokia.com>
In-Reply-To: <20220706163135.53874-1-alexander.sverdlin@nokia.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 16 Sep 2022 13:15:50 +0200
Message-ID: <CACRpkdbpnT3G4EY_cgQ0dj93F6E6Kr5hW4yKD0vOpS7Zb8fUxA@mail.gmail.com>
Subject: Re: [PATCH] ARM: module: Teach unwinder about PLTs
To:     Alexander A Sverdlin <alexander.sverdlin@nokia.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        florian.fainelli@broadcom.com,
        Kursad Oney <kursad.oney@broadcom.com>,
        Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 6, 2022 at 6:33 PM Alexander A Sverdlin
<alexander.sverdlin@nokia.com> wrote:

> From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
>
> "unwind: Index not found eef26358" warnings keep popping up on
> CONFIG_ARM_MODULE_PLTS-enabled systems if the PC points to a PLT veneer.
> Teach the unwinder how to deal with them, taking into account they don't
> change state of the stack or register file except loading PC.
>
> Tested-by: Kursad Oney <kursad.oney@broadcom.com>
> Link: https://lore.kernel.org/linux-arm-kernel/20200402153845.30985-1-kursad.oney@broadcom.com/
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>

This looks correct to me.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Please add this to Russell's patch tracker.

Yours,
Linus Walleij
