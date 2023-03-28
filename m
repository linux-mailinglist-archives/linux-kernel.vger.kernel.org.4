Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA216CC8F6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 19:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjC1RQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 13:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjC1RP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 13:15:59 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8DA9750;
        Tue, 28 Mar 2023 10:15:58 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id m16so9607471qvi.12;
        Tue, 28 Mar 2023 10:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680023757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SgQ1uDWJ12zSyFLa1KL/uO5pZA8CWTbblaTqGRUiRdo=;
        b=kMK0ic7Qlbdr8IiQGvB14KNwUzwnLDcN3k5kZYiVrk866xZWXej5yNhbPmlwS8pUFT
         qDQ0KvDTlJzkVHZdYJZrjh6rLIbvg55Ur9P4jzY3UiwOCsiJj9MZRRmBRxNq56TCsAa8
         GC12vX8Lu7XVDOTxGNCyyTh3VhxsPFLGJFINGm5Gox3apZWsrHKWfpKNiZeIGBqtiQwD
         7UQlL7vVwYGHzJD1gGQFjC52QMT/Ow6Mm1QwNLW8pCEpGl4c7BGxiAptB9WiqbmAKdQQ
         2jh0tASRTnTpnjcz49IBZtriyiqEZLlAxLVZfGxYV+IoRCAP3iD78SHJ2C9EHlVK7GjW
         IzUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680023757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SgQ1uDWJ12zSyFLa1KL/uO5pZA8CWTbblaTqGRUiRdo=;
        b=GZXayN/UMzAYNx8O4DyQ2tnBFB85bjXwCeTaVA9x8DyQQvNhYg3XVxuJu4Gwl8UiRg
         lQ/oyGRJrKsqyUTDwo19259Cyu4Hqof51QcJ/pfIzhGHixDY9Cja8JJa/CvW0lfkoEOq
         vZkc3EviSpOxCWnxzaYe/ORMQ2gsw7wfRYTaQuVGLBNSXaRwQw7wuyYOzUmbeEBiNxCE
         HJUvGIp2JMwkPlmln++Xrn8OvZBEQrYv6NOv175rNM38n64+w2gNxsNSwzaVMqhD+mrx
         7XRANl7D3qRuCrygLbfxxHlCNzvnJTB1eOEwKEBsUvfHPZGkw8JjsprSCzw3hsUkWz48
         hhcA==
X-Gm-Message-State: AAQBX9foY73wNBigAqDGWzBpxI9eE2CfEOMuBclOElvVn6ZRQ8UJciGg
        Bhu/kxszD8wIEgmDqyLZ9iRzGmkIpUBLFp0mjrXWxMvtCyo=
X-Google-Smtp-Source: AKy350Yybe1XfMVymzn0L1frzoB2YLldHl07lvc360cxEIjLyu4hhU6Szpt8mwrXe8EYLZA7nkl3R289Xr/YU0DVGJ8=
X-Received: by 2002:ad4:4a6d:0:b0:56f:6925:eb2c with SMTP id
 cn13-20020ad44a6d000000b0056f6925eb2cmr2803163qvb.10.1680023757607; Tue, 28
 Mar 2023 10:15:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230328161541.599463-1-jjhiblot@traphandler.com> <20230328161541.599463-5-jjhiblot@traphandler.com>
In-Reply-To: <20230328161541.599463-5-jjhiblot@traphandler.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 28 Mar 2023 20:15:21 +0300
Message-ID: <CAHp75Ve_=Gzpg9GO=2dqTKWuyU-Podezv_YSwHLqFPHXk1DUxg@mail.gmail.com>
Subject: Re: [PATCH v8 4/6] leds: class: store the color index in struct led_classdev
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     lee.jones@linaro.org, pavel@ucw.cz, robh+dt@kernel.org,
        sven.schwermer@disruptive-technologies.com,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        marijn.suijten@somainline.org, jacek.anaszewski@gmail.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 7:15=E2=80=AFPM Jean-Jacques Hiblot
<jjhiblot@traphandler.com> wrote:
>
> This information might be useful for more than only deriving the led's
> name. And since we have this information, we can expose it in the sysfs.

...

> +Date:          March 2023
> +KernelVersion: 6.3

Outdated version.

...

> +               Color of the led.
> +
> +               This is a read-only file. Reading this file returns the c=
olor
> +               of the led as a string (ex: "red", "green").

There are no strict rules about colour and I don't think it's a good
idea. Why in such a case is it different to label? My proposal here at
least documenting that the colour must follow one of the existing
naming standards (like RGB in hex, HTML, or name in accordance with
chosen standard).

Yet, it won't technically prevent abusing that, but at least will show
the intention and allow pointing out to the bugs or develop user space
tooling based on existing parsers (if any).

--=20
With Best Regards,
Andy Shevchenko
