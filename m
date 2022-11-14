Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C81627A01
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 11:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236412AbiKNKGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 05:06:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237085AbiKNKFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 05:05:11 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FFF1F2FF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 02:03:58 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id f27so27038708eje.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 02:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Tw2TSoxduqvT66w93xc8UWmcmuUUlq9gxf6HonIkGKw=;
        b=BKM+sVxV2GFduTzn+KTJimVnXwFwkgmyUX9+A/8mvPOn75N4wi2XzkOnHzn9p8PkNC
         yNPY4h+2OPaMJYveexe0bfrBO8PjIgowJqGBhXDvFtENQXtiQwyW/FEW5md71oDrajF9
         j7V6vb77JkzcIiPF37FG7QxEBAGaVNcgKLNBZFXaIMJNA2COl/72fMKxpBilx6zni2U8
         bfJMQNfgmVsp2+Baxy6Zn2FuvXTziDDd/J5aqFu/XYOCTySSk4WxkCcMaX3+niNl4Lyc
         1eIZpM05yIQmwZ/mKtJINZqNhBUraeTIQRmA3xTFddeqxVg7aA8RCEnlRu/6nSJuTmMx
         I9PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tw2TSoxduqvT66w93xc8UWmcmuUUlq9gxf6HonIkGKw=;
        b=KuhMKSf9iIIRE+NIbAnl2O2ALEjAP1G10uEcMx47jyWS2D8d+tPdR33jDb783yF+BG
         8eHwYmiDPCQEBDaD4v6UDyhcvCJKQdOvcyhYTQXEN7LXkrtXV6LLEulgZ8OlqBCp2KcK
         mJVE3uVb/JrxsKVUpK4ZORrhXMSEp/DwGie1bVKOgpppABxHVkWAcq8bHK43YC3tYUQR
         vTQSV+154C2qJXvOadQkE9j0wwIEQ8K1Cqo57J2bsR2rWMLNyM9yEjrawuqiqI61G88t
         eKWg+gWMQB2KVzEl5KZJhPgyn4Nyv0bCPsiJexcdDIq5wyE+o6G9sJM51qm55DLKco1f
         RADw==
X-Gm-Message-State: ANoB5pk6K0ip7Gc/8UUSu46bCxc5v7Sd1V1ULBNc/T1nPMyqfzT7ZJl4
        ZVPE6Kg9A3vwzoU2hGshU/kqjPFtr80SnUyzJMMK/7/IodU=
X-Google-Smtp-Source: AA0mqf5th7Wlbfzie6KS/qPeXMZvjkHZEceKIgagqGSiBZ7DycRZoqwTDNOGMaKzSFBzR/hZXNyGhc80UGDLjYzeiPM=
X-Received: by 2002:a17:906:a14:b0:7ad:90dc:eaf2 with SMTP id
 w20-20020a1709060a1400b007ad90dceaf2mr9946581ejf.526.1668420237168; Mon, 14
 Nov 2022 02:03:57 -0800 (PST)
MIME-Version: 1.0
References: <20221112152928.42204-1-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20221112152928.42204-1-aidanmacdonald.0x0@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 14 Nov 2022 11:03:45 +0100
Message-ID: <CACRpkdbr7Jm4DNEpZ-Ykh76xWKWTeL4UkxJDTAii8sz7yx99=Q@mail.gmail.com>
Subject: Re: [PATCH] gpio: sl28cpld: Replace irqchip mask_invert with unmask_base
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     michael@walle.cc, brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>
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

On Sat, Nov 12, 2022 at 4:29 PM Aidan MacDonald
<aidanmacdonald.0x0@gmail.com> wrote:

> Remove use of the deprecated mask_invert flag. Inverted mask
> registers (where a '1' bit enables an IRQ) can be described more
> directly as an unmask register.
>
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>

Makes sense
Acked-by: Linus Walleij <linus.walleij@linaro.org>

I expected to see Maz on CC for this kind of patches so added him.

Yours,
Linus Walleij
