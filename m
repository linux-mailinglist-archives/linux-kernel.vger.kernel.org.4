Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135DD7181EB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbjEaNcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236585AbjEaNbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:31:42 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA851FC6
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 06:30:16 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-bab8f66d3a2so8047454276.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 06:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685539797; x=1688131797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=itMAWlEVGbKwEk4rvkPhIkKoGJ+D+wP/v3giQWPxtxE=;
        b=TKCUTBNhaMHi5eEwlnd8h2q+kD82oaJbKs2k83VnkFN/LAlkS5QIqyaEEiuaw+aq6u
         LixoStQwyq04QLXTSmPDys2uR2TCA3/U4ubZVeqo0+ffYdGszIF/JuiUF8pvgOVMF504
         bucgsWzvisZPfQVRXgJJ/DepOGZ6EOyDovqUQumwdIltz0mDRkPY6TgbikvaFwRc9IC/
         xCRJ2taW6FATuHjTWctppSmYAU9kftlV3iq07JDkueaa5A1JhNnNBQe+iPBqWZakSHB1
         Ph7q8ACJfKXxN/XM0vHaWmI1DM0bldtPVV09gEvgJYJzcWe2ZHKnKqm53Qg+5kuWdYqU
         2xFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685539797; x=1688131797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=itMAWlEVGbKwEk4rvkPhIkKoGJ+D+wP/v3giQWPxtxE=;
        b=AI05ThiRPnKI+muV7STGMJPLr9Fc39Iww9MqA19YG3hhOt6+TCq3drxSDczD0vs7hi
         ZSS3OGgZFf5oYm3dNyaQBSvilJMv16GFVOtM5AvHvZIEOfCU1XPp7ynXY/u9Bg0KOYbi
         rQSdZl2J22n2gFE8zuWN883hzsn7IQPM9yx7hvNCbcvOZnU/IK+M3WFk/VTPyPsW1In4
         NRMcRh4BzVlZ+dhhH0CFY73H2MbUHBC/pcISxNVMZhWlhY0Z7OETDLUKExw6smM4qOeW
         ZpId87j91W1cYuF6/uWcrAu9DM2RzESfzPLd+rtc1prp0GFLacAmuvstwWvOBfkmqFIb
         sHsA==
X-Gm-Message-State: AC+VfDyftEknPSSSCB6dxai/7pF1lPJmUbcZoB9NlEMThT6HKtT+GffQ
        mx1ChPXGG2/SlHvwUasJzh8QOp+Pv7ffQpk16zI7Ow==
X-Google-Smtp-Source: ACHHUZ4Py4Uo3YiGtvPZ/kUjXKdiyOhcEX0VVb0BTsQkmbteSEWWazQWYqFQhh8JSeV3efIYepXV/ugoOYAZMdYFtLI=
X-Received: by 2002:a25:addc:0:b0:ba8:4bc6:7918 with SMTP id
 d28-20020a25addc000000b00ba84bc67918mr6555542ybe.32.1685539796988; Wed, 31
 May 2023 06:29:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230530155501.222213-1-azeemshaikh38@gmail.com>
In-Reply-To: <20230530155501.222213-1-azeemshaikh38@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 31 May 2023 15:29:46 +0200
Message-ID: <CACRpkdbf_biFPFC62uF1byXrMnK=0XbbBiZpJwT=GVnx5ZpP=g@mail.gmail.com>
Subject: Re: [PATCH] ARM: Replace all non-returning strlcpy with strscpy
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
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

On Tue, May 30, 2023 at 5:55=E2=80=AFPM Azeem Shaikh <azeemshaikh38@gmail.c=
om> wrote:

> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
>
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcp=
y
> [2] https://github.com/KSPP/linux/issues/89
>
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Please put this into Russell's patch tracker:
https://www.arm.linux.org.uk/developer/patches/

Yours,
Linus Walleij
