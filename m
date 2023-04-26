Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E928B6EFBCF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 22:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239878AbjDZUkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 16:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239833AbjDZUkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 16:40:52 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B561268A
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 13:40:51 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-555c8a12b26so88274117b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 13:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682541651; x=1685133651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSAxYnu4OJU6KORxEIh30y1ZGZ7eewEpRTcExLN+JlQ=;
        b=dUGFmACLmJro7KZMEYLMdqrZoXkrE4/XVPnyDR8KRnwyHGEzjOBoiSEyzvCpo/fl/9
         3+jHfxXrTFFo75L0XQk+8M5O6Q87s8AOxTypwtL9QW8f5t5nP/MVZvAUZSJ96VLVmJ82
         wkHKl/QsDVg+l6i8gpc4406JoPwjZ7IDO9EWoLmoYcHzkVeqcOrlaMGPEK8ymSFouyAH
         xtH5OiP9ZN3gDaQdtEJFFMg12hgJy4nUgDwJEJX9uZvcfowta1xu8T7MhmF57upcoyOM
         a9d2VTFXuGOayhpTH1B0NPCk7cegBvvdyngYMIKGb2QeIwEMKJ8JrkS83Wl0TrBHRnZf
         oq4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682541651; x=1685133651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QSAxYnu4OJU6KORxEIh30y1ZGZ7eewEpRTcExLN+JlQ=;
        b=OKvAL4Bx1c/CzYV6N68G0oYKKCrglx8kUFD7lxuBKJDq3xIbeq0xrX3mS1CJn2s3K6
         pYrHRMOlk1FDvbQJW4DK7gWhL8OdRl8RZ7hXKynpKVtzUF27lYt9tFCQca/NI+K3JJf0
         4k+xX7T4wtkJTUyDfOsJ7n1yU0U2TVp1k2skrhsZ/qOXAWtN/9GvWh4OK+6Cpl0nzvIk
         41DzA3WhEud7kFzEFQaGVuufpCuanCGqKqAi5/havGeIgUuJNPEC6kVJx09Ojp0ZFF8n
         aPB5Opei8jh4+cJlE6rLK1Q7yjpQMN36/ms9j7SErGRDeTIxgtU+yhuWv7y0Po/f7eyW
         gEuQ==
X-Gm-Message-State: AAQBX9dgzQryTdeZDDfLzg+89Pc54442PuVsjlpa6R30pXmEPNcwKePl
        H0u2EzD6Jnc2OWdDKKDly5iT1pKA0lo93Hhy+MligQ==
X-Google-Smtp-Source: AKy350bIdZJ1yYiKHbuatCwOQmqv8L7D+imEJNQfbPg+0SnhjrxkDQLAGYipxRd2j9f+lEfNAyHtuBIw/4eZTurfz0M=
X-Received: by 2002:a81:ab46:0:b0:54f:ba86:9fb with SMTP id
 d6-20020a81ab46000000b0054fba8609fbmr13858072ywk.24.1682541650855; Wed, 26
 Apr 2023 13:40:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230424123522.18302-1-nikita.shubin@maquefel.me> <20230424123522.18302-7-nikita.shubin@maquefel.me>
In-Reply-To: <20230424123522.18302-7-nikita.shubin@maquefel.me>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 26 Apr 2023 22:40:39 +0200
Message-ID: <CACRpkdbbym0JhSPZOTquwd9NqKjKTmExNYm3dg4j22Wx7B2r3A@mail.gmail.com>
Subject: Re: [PATCH 06/43] clocksource: ep93xx: Add driver for Cirrus Logic EP93xx
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 11:35=E2=80=AFAM Nikita Shubin
<nikita.shubin@maquefel.me> wrote:

> This us a rewrite of EP93xx timer driver in
> arch/arm/mach-ep93xx/timer-ep93xx.c trying to do everything
> the device tree way:
>
> - Make every IO-access relative to a base address and dynamic
>   so we can do a dynamic ioremap and get going.
> - Find register range and interrupt from the device tree.
>
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>

That's a fine clocksource driver!
If EP93xx didn't have the sched_clock callback before, it will
likely also speed up boot.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
