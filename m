Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2EB6CC0C8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbjC1N30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232730AbjC1N3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:29:20 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67EBAD3F
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 06:29:18 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id y5so15033035ybu.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 06:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680010158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F69SKgebFV84m8b23l8cJMcbeFPsZV429gPHHrsF92w=;
        b=tHiKJUDXZjWTg2DUFiPoyD0e+7+Bl327jN3xM18gp7431wDhEHFklKY8sHh9iIe5/2
         rxXEHYjWdTOoOC0DDnEA+Z58Usi64SaYTRagObJVvefExp10qkFepQO82B0FudG83Ba2
         J44esto2WDHBS9g7JEqSwoRYKZn3EwaXFI7W+z2cQgAccy8zr7R98kqpeuxC8VjAggjy
         MSHmTP7/SZmGkph6x1CPntk9ZjsVqu0NMRBiZX19sdTRnFA4T71Og0J+rGkf5Zs704lK
         Frc87G5TItfjkkKXPgkcsH+Mi+/Hnn/llqkoWKxEVHFB5yLd4ofWEuC7w8VzCP28K5Ek
         HVLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680010158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F69SKgebFV84m8b23l8cJMcbeFPsZV429gPHHrsF92w=;
        b=D8na6v8dnrj4Hjs7A1y2JjDMZ7Vs4a78ZrewVMrXolXrXWj7kEOfm7/h7jAxNicPUn
         U15AoEfantpYhHQmF/pBntTiaRrNC18J5hQODaE9CrziR8AfNbwjzx7jF9aGDGeXlSA1
         wd1xtQuVhdoVYLcFlRCOoZs5w0//4be9HcHCR74U+Zonivm254U0a+Z06VMa9W51amNl
         BU36mg/DS+Tk1hU6b2Bt5ewoHJtlUpEWnVCLwmC4I+nhMpx+TZZi3D9dlGVSpZlvwTtU
         9TA+oGJ2PCRAH/qXTQ1CPk7YDG3w+LLW+i0ar4SowFdgXDVd38skhtM3Veke9m/t4d7D
         E13g==
X-Gm-Message-State: AAQBX9c9WbsU9mGJ+9g3f9shUYH6UHXOg6pk2pE6UZ2xxGD8zLZYvjW2
        ELIEP00+VmqDl3UqpjfaIlQLjGTxYxutwq9Y+44Vaw==
X-Google-Smtp-Source: AKy350buCWEIi2PkGNpeTUBOh1IR2rSY7S/IC7sNpB1Y7lELd92laB/CFj3jRTSo8OKdOuNP9Xy1qlYJHOIAM9dKlZs=
X-Received: by 2002:a05:6902:1006:b0:b78:4b00:775f with SMTP id
 w6-20020a056902100600b00b784b00775fmr6378684ybt.4.1680010157966; Tue, 28 Mar
 2023 06:29:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230323122910.991148-1-d-gole@ti.com>
In-Reply-To: <20230323122910.991148-1-d-gole@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Mar 2023 15:29:06 +0200
Message-ID: <CACRpkdY_rhe69Y4AbEp8iws1fpL0bUkP5iBMN68EB+wxhFyHTw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] gpio: davinci: Do not clear the bank intr enable
 bit in save_context
To:     Dhruva Gole <d-gole@ti.com>
Cc:     Keerthy <j-keerthy@ti.com>, Vibhore Vardhan <vibhore@ti.com>,
        Tony Lindgren <tony@atomide.com>, Vignesh <vigneshr@ti.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Devarsh Thakkar <devarsht@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 1:29=E2=80=AFPM Dhruva Gole <d-gole@ti.com> wrote:

> The interrupt enable bits might be set if we want to use the GPIO as
> wakeup source. Clearing this will mean disabling of interrupts in the GPI=
O
> banks that we may want to wakeup from.
> Thus remove the line that was clearing this bit from the driver's save
> context function.
>
> Fixes: 0651a730924b ("gpio: davinci: Add support for system suspend/resum=
e PM")
> Cc: Devarsh Thakkar <devarsht@ti.com>
> Signed-off-by: Dhruva Gole <d-gole@ti.com>

Looks like the right solution to me.
I'm a bit surprised given how long we have had this driver.
I suppose people have used out-of-tree patches for suspend/resume. :(

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
