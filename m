Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B0274AFE3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 13:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbjGGLdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 07:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjGGLdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 07:33:38 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFFA123
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 04:33:37 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-c5e76dfcc36so1954285276.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 04:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688729617; x=1691321617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMDmR1AyUqqSLlrR4dAl1mTPWPJqJms7W4GVYjDPIGA=;
        b=xiiQaYZq3bDHw91HWI3fRO9UDkLX7hyAFNYDmTVBWHFjkvIZjxGpJ9Ucr1pqYcfkCy
         mZ8qVZI4gHIQAjBqmvS/E0Lu5McUUZMuarBruPYB3Z5vRsXtxYrhontrBigkgUOWMcTh
         AcX/Q+4iYvqSQQhP4CqYV5lOm749u86MZwzKYr+PWH5I2o2upjOC8iQKoaLsHS4ZmX9i
         wduX5j7NLHNyM6waY5iUjI7MOSAgIh63hRMWL+VCYtcrsbS3S8OPN70xEFgGPBQFGdi1
         qUGifkUwapGATJFhAkRv9er8DG50uEop5Wi7WKN1Ync5B+2EBdQZ+fNxjctFco+oSLIX
         sYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688729617; x=1691321617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RMDmR1AyUqqSLlrR4dAl1mTPWPJqJms7W4GVYjDPIGA=;
        b=S6Y4Iw8/fxLKZsLew9RrmpSmh+eTnO+NqFQyw+3dPekNGJAMVRGYyJgl0seS/2SAea
         1ocsPEf92jDBT7z56FdiFbusz2vokqmBUwCD46/fykOPvK5ctT50pM3BiQG2a6GGGsJx
         dCFrI6HASomLyHpMA5DyAnGO0/3DiYvRLtz+w8B/94sZ3KJeeOmsmG7slC/3ASKY+d3V
         LdY4ou8k+Kdo1Jx2i3RvTKUixXs65TPyuuN9C3P/sOWBdXtyT9NbLYwjlrvCXafYqShp
         w9XY8/aEOTXx/DY1t8hl0ETXWFpqSB/DvNe9qQWbPCFguXLvPg8SJgjkJTG3WACXVMFZ
         OkWA==
X-Gm-Message-State: ABy/qLbD53n22ak6TMVImfDiDH5iRm2xcIlyJUZnc2cA1bNcORshQwR3
        pSj8K1iTGAsy5g1z60+xXfIsJ0dXgnE+oPwJQQT5ZA==
X-Google-Smtp-Source: APBJJlEQSj9eXj+7lnzyovN+ytLh/4DHueGCx30NZ+9pdKgvYoJ0FyPX7RpPM7SVjIqI/EaQCzqVM+GieMin6C25zn0=
X-Received: by 2002:a25:604:0:b0:c5f:d493:c91f with SMTP id
 4-20020a250604000000b00c5fd493c91fmr3740950ybg.61.1688729616893; Fri, 07 Jul
 2023 04:33:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230707095415.1449376-1-arnd@kernel.org> <20230707095415.1449376-3-arnd@kernel.org>
In-Reply-To: <20230707095415.1449376-3-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 7 Jul 2023 13:33:24 +0200
Message-ID: <CACRpkdbiDUomH8HLkk_jyJZYc+mEmRaFL8-JasDmd=ooSB62Qw@mail.gmail.com>
Subject: Re: [PATCH 3/4] dummycon: limit Arm console size hack to footbridge
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        dri-devel@lists.freedesktop.org, Ard Biesheuvel <ardb@kernel.org>,
        Helge Deller <deller@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 7, 2023 at 11:56=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The dummycon default console size used to be determined by architecture,
> but now this is a Kconfig setting on everything except ARM. Tracing this
> back in the historic git trees, this was used to match the size of VGA
> console or VGA framebuffer on early machines, but nowadays that code is
> no longer used, except probably on the old footbridge/netwinder since
> that is the only one that supports vgacon.
>
> On machines with a framebuffer, booting with DT so far results in always
> using the hardcoded 80x30 size in dummycon, while on ATAGS the setting
> can come from a bootloader specific override. Both seem to be worse
> choices than the Kconfig setting, since the actual text size for fbcon
> also depends on the selected font.
>
> Make this work the same way as everywhere else and use the normal
> Kconfig setting, except for the footbridge with vgacon, which keeps
> using the traditional code. If vgacon is disabled, footbridge can
> also ignore the setting. This means the screen_info only has to be
> provided when either vgacon or EFI are enabled now.
>
> To limit the amount of surprises on Arm, change the Kconfig default
> to the previously used 80x30 setting instead of the usual 80x25.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Tested this before and after patch and it looks the same on the NetWinder.
Tested-by: Linus Walleij <linus.walleij@linaro.org>

The legacy in the cyber2000 FB driver supports pseudocolor which
makes it a bit hard to rewrite into a simple DRM driver, which is something
I could otherwise look into, it's not a very big or complex driver
after all.

Yours,
Linus Walleij
