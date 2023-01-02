Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7098865AD5F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 07:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjABGKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 01:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjABGKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 01:10:16 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE872198
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 22:10:13 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id w1so13373022wrt.8
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jan 2023 22:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rLntJQUG5K/SXDBjzoL4r+ZOXdeQgaB5Nk9W4dsNJnA=;
        b=Q6TeT1N8x17ilJ7Bv14V3FTZmkDVoY5o+yLmyIsN6e/p8K0jy/hIHuO40LwjNvdw9m
         cM+CuFEn8T7wKIBIuKZVKVH5zCFzgPWpi3PsVpSGeY76EbkWZLyoAJvMPIBLurDZk21O
         D/TZL2ChcBVUu9iAUYRjWRtJyZQH4moduuUWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rLntJQUG5K/SXDBjzoL4r+ZOXdeQgaB5Nk9W4dsNJnA=;
        b=sX13rfxIojlKmiY7BiQvrkMqjnOUR8jg5faE3jWWb83a5J43FwWXil4wEJVaZMnvyC
         tLZl93jp2qSMzMmX8E8NqFiLcIctbeH9Twe7yRStpYBC3wZehbk/3944VWrtoeh9D+9J
         aYMGsMuvYFFx444RHVXyUioXF3DnlOJ7D8cXEEWP19mIji8EcJ4BydcS6aSAl+cWVtQA
         epCs2ijL6UF1LATpJGlBVTWNsPWMheJJMwe5URUirg/Xy5sMlQaSfX8HqwSUO5ZdQZtk
         wAq7v41e+jYuJmuP4v0JWtHYMFp1AlRsXwY4qDysu85k/8IYTgNRbGi/EO/iOJxHRc5v
         ESug==
X-Gm-Message-State: AFqh2kr2UHCLNo375QvYpZ62T2VZLHCOP6Pj0YAdkaAZRIkbAHXmGgkg
        8X6l1QxOXZAMveOmpvRGkKVz4JCwvig5ZuCZRXgrzG/t046957ze
X-Google-Smtp-Source: AMrXdXuFXNdIUUHj5L9j+mPoUGn9lTFGMXxA5oJsoaGqMX7VdTP1PTW+YSPi27ETm1AVyzLwdP9RjAscgzIXB/Q+qfA=
X-Received: by 2002:a5d:530e:0:b0:276:4a7f:8ede with SMTP id
 e14-20020a5d530e000000b002764a7f8edemr869594wrv.241.1672639812036; Sun, 01
 Jan 2023 22:10:12 -0800 (PST)
MIME-Version: 1.0
References: <20221215165728.2062984-1-arnd@kernel.org> <CACRpkda3V2Fv9aOxxcuQ5NKv3sWic9-skQU_z7=0S692h_WhnQ@mail.gmail.com>
In-Reply-To: <CACRpkda3V2Fv9aOxxcuQ5NKv3sWic9-skQU_z7=0S692h_WhnQ@mail.gmail.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Mon, 2 Jan 2023 15:10:01 +0900
Message-ID: <CAFr9PXmVXqAX73VUzAt_M2yPN93in9Y_LHyYcEA1Dfj_m_4ZHA@mail.gmail.com>
Subject: Re: [PATCH] usb: fotg210: fix OTG-only build
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Maybe a little unrelated to this patch but this IP is also used on the
MStar/SigmaStar chips (albeit only the host (FUSBH200) part that used
to have its own driver that got removed at some point...) and I
noticed this when rebasing my tree and hitting conflicts with your
recent changes...

For what it's worth I could not get this driver to function correctly
with UVC cameras etc and was fed up with hacking it apart to try to
get it to work when it's mostly a copy/paste of an old copy of the
common EHCI driver.
So I added some extra quirks to the common EHCI driver to allow it to
run this IP too and deleted the custom driver in my tree (hence the
conflicts..).

I'm not sure how using the common EHCI driver works with the OTG part
but if it's possible to make that work maybe my way is a better
solution than trying to maintain this driver?

Cheers,

Daniel
