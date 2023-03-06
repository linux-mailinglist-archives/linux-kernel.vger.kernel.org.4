Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0DBA6AC1FE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 14:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjCFN5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 08:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjCFN5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 08:57:09 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FF4302BF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 05:57:03 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id x12so8134754ybt.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 05:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678111022;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dUgO+q0sb8w1SQGSE4XdX+Ia16CeO2S3iJExrE8dgtU=;
        b=hTNzRIwBNgO8+NFsz2/pRCfL3AXwdTQoTSjviVMDMqihIe6xBc3ljlylODG9FZy5hh
         et8vIsKHoQU1eVtohMujmcc/VVVoObKwDfEIVX/EZaLMtGEiDrmgK23AblflcJYfcLoi
         zuGDENLv8cGwyu5mCs5f3DtAHdV6jqzi69iJXTWrLXRPtw8RHJSUoMtJIiz8EzBf22y9
         PTUxGUvr56H3H+EK+snCiCw4/O4py2pTIF+PAqjn2YOfLvagb4Vfebeask/9FRqCc4FJ
         ju4i7Ql8xECWiRQZZUc9SLZeaHZrDKMP2OO/Bjj6N1QNaTLFHsD5Y4TDsTuZJBr2X677
         bpFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678111022;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dUgO+q0sb8w1SQGSE4XdX+Ia16CeO2S3iJExrE8dgtU=;
        b=GpqsQDclau3458t2OpOWhDXQV8Zt2cn8SnFAOJEY02lDsYHQ7JeN216ow/x4Xy1s2m
         4JHHKUwQf2r/LMMtypLRZgU6oFYbZdcJCPmoC0QLQM34doJqgoK2MkhAQy+F8IDoOTwn
         rJZFAi1hvhoN9aJRxS5F51S6ZQ/krhUujFp8zQUWp3/avbYhb/GNT5+lK/3UmaOOdiEc
         eiVS+PhaRaKe4sLHysINop+qXgqQMc/QDAmDgoe6vIbikoMm1iWVkvnhw5neGviKPyEl
         7OpcXLI5cSv48svB/fSwR9Wy+CtA+dE0bCvV6+AQ3CyL+eFPD/rwDo37qKlNed5TtZLE
         DJtA==
X-Gm-Message-State: AO0yUKWP5le6V+YjdTyhuL10WDL0m+qrAYMAA8uzDXQWvqS5TKvRYjBz
        TJZmjcPX0FGW31ZhfeypSLaFIP8nFxHWpsd3VlCRZQ==
X-Google-Smtp-Source: AK7set+pxV8onzfG/3QGuW8SgsYVA7eLoKyzM1g/WEl7tIDHsfh7Soj7YELyD5iE43y8Iaxx3QOgCjvsZPNuFB9PuYg=
X-Received: by 2002:a05:6902:4c2:b0:ab8:1ed9:cfd6 with SMTP id
 v2-20020a05690204c200b00ab81ed9cfd6mr6324543ybs.5.1678111022385; Mon, 06 Mar
 2023 05:57:02 -0800 (PST)
MIME-Version: 1.0
References: <20230224130828.27985-1-johan+linaro@kernel.org>
In-Reply-To: <20230224130828.27985-1-johan+linaro@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 6 Mar 2023 14:56:51 +0100
Message-ID: <CACRpkdaGPZ6_Gat77tS2AvrrZdqMnnt0JnJig12ht0wzidnehQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: at91-pio4: fix domain name assignment
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
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

On Fri, Feb 24, 2023 at 2:09 PM Johan Hovold <johan+linaro@kernel.org> wrote:

> Since commit d59f6617eef0 ("genirq: Allow fwnode to carry name
> information only") an IRQ domain is always given a name during
> allocation (e.g. used for the debugfs entry).
>
> Drop the no longer valid name assignment, which would lead to an attempt
> to free a string constant when removing the domain on late probe
> failures (e.g. probe deferral).
>
> Fixes: d59f6617eef0 ("genirq: Allow fwnode to carry name information only")
> Cc: stable@vger.kernel.org      # 4.13
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Thanks Johan, patch applied for fixes.

Yours,
Linus Walleij
