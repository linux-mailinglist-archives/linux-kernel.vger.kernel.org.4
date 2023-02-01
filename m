Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27FC6862B2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 10:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjBAJS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 04:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjBAJSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 04:18:53 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE843B64B;
        Wed,  1 Feb 2023 01:18:50 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id t18so16657186wro.1;
        Wed, 01 Feb 2023 01:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/7sUhcehRG2qL92Fgan+Uw368Mzjr9ZRfCcL5b1Kc7M=;
        b=nXslvq1NokiWQ3hVJIcUolrM8HpCD+IXrFghKk2u2+RxX40O/F9iBiHJlEAXYuypoh
         UcDfbas3NPY7Z56EWBacNHKYcNh2FJaJuQP+kqaaj3M3ONeimauBQqLYlfh4fK1ge1G9
         jjOWQH85aHPgGvJTO36YkRd5m41tA4bGBIOB7VjVELs9P0RF60pSSW5GJsFvS2H2KhAZ
         MrnQb1XROlIu15s5PoOhPAe5VLweblshkxbXjLJaQiPRQO5CIUnceS3BG3WQLOsRWq9B
         /sPlhYVlx+7yddJzDeUDptM6QIy7Yi4u/B6mur9NQkMg2bxu4oX8TusV+7WhRLd28nav
         vmyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/7sUhcehRG2qL92Fgan+Uw368Mzjr9ZRfCcL5b1Kc7M=;
        b=3ZhOP1NgoPORtCl/vt4EiBdU/dpA7gqbMb0tVN7MBtT9SvLds4z3MBzc3dac0jJrIz
         Zm8LLKDVfdKOe7YWQT83V1c+FaePmovCSdCVxFpy7SJzWt1ZguS3ihMnW7FLyWA8VrJ/
         aXoUBCL0yOXMD4V46Pk7FLrroG1WakTgTxtfwTV9UyBhv8ZC31MTpSnUOgUo3v1idDRY
         MCwnRvNgJ/hCyAwr/DPdctubf+XhBLt9QEu8Oq+LG99TqMQoqAb4TA06Sc9oCjvytAH6
         lB3MVcar2efwSOc/cqYYtfiRGGiKL2ytpynMa42AwH39gt+unEd/tTHbutn3Pptv+ccj
         d/0w==
X-Gm-Message-State: AO0yUKXgDZ7DxGBljdieOZj0B5TMHX0TJrHBlUo32kbj0w3np8uiYt0V
        pIMrnBqlpTxbWH+9XqWiOog=
X-Google-Smtp-Source: AK7set9xyDG5g0hr3NVptBh0L0rI7k9Zb1ZuEgzdtcML082q5d40qvqygd+7qdbW+h5jXkK/eQ6Mkw==
X-Received: by 2002:a05:6000:982:b0:2be:34fb:673 with SMTP id by2-20020a056000098200b002be34fb0673mr2013278wrb.52.1675243128819;
        Wed, 01 Feb 2023 01:18:48 -0800 (PST)
Received: from giga-mm.home ([2a02:1210:8629:800:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id q3-20020adff503000000b002bfae1398bbsm17352340wro.42.2023.02.01.01.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 01:18:48 -0800 (PST)
Message-ID: <15f7dcbcdaf6fdb05bfc1d5bee1bb2e1bf3c43fc.camel@gmail.com>
Subject: Re: [PATCH v2] gpio: ep93xx: split device in multiple
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     Nikita Shubin <nikita.shubin@maquefel.me>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Russell King <linux@armlinux.org.uk>,
        Lukasz Majewski <lukma@denx.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Date:   Wed, 01 Feb 2023 10:18:47 +0100
In-Reply-To: <20230201091021.7090-1-nikita.shubin@maquefel.me>
References: <CAMRc=MciMOfCo_fS_Um0xaQT2H=QSRgEUA5iTwxmpXqo2k2NJg@mail.gmail.com>
         <20230201091021.7090-1-nikita.shubin@maquefel.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Nikita,

On Wed, 2023-02-01 at 12:10 +0300, Nikita Shubin wrote:
> This prepares ep93xx SOC gpio to convert into device tree driver:
> - dropped banks and legacy defines
> - split AB IRQ and make it shared
>=20
> We are relying on IRQ number information A, B ports have single shared
> IRQ, while F port have dedicated IRQ for each line.
>=20
> Also we had to split single ep93xx platform_device into multiple, one
> for each port, without this we can't do a full working transition from
> legacy platform code into device tree capable. All GPIO_LOOKUP were
> change to match new chip namings.
>=20
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Bart, i've rebased on the top of gpio/for-next (there were issues
> indeed), but this patch still won't apply. That's becouse it's dependant=
=20
> on Linus patch:
> https://lore.kernel.org/linux-arm-kernel/20230111132210.134478-1-linus.wa=
lleij@linaro.org/T/
>=20
> Alexander can we have Linus patch somehow applied to ep93xx ?=20

in contrast to me Linus and Bartosz do maintain their GPIO tree,
from my side I've performed a quick test, so it's OK from my PoV to apply,
but I cannot really assist here more.

--=20
Alexander Sverdlin.

