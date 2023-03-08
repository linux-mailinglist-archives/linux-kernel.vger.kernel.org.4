Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9112A6B0453
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 11:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjCHK3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 05:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjCHK3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 05:29:23 -0500
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEC29310E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 02:28:56 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id x1so10859032uav.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 02:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1678271335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aczIr75cZ4lMAQlCkdBUDOmKKh/88pRo1/9jBKcFvDo=;
        b=Ad+P6eTHQUo2gTKSRTn9Q4N9iyb7BgKCWj0uh7Sdu+iKIxEIwT4vSeXmlYiZuXxZnw
         +CJNujA9+WwwUOANXGnpQ7XPX4Evn9JvB4WKq2fgNuaEtS/kU9XGluayhoF0YIN4D/jM
         sQ2GtrN2DtK8MQh/IkWDMd43wwGtbq2++qDDAy79yAIEgRYoD85/HLLgCOK6IQBFFx4q
         VytkhwqH1JdOmOFfqtUJIL2F2HU2PdLFzU4XrexIo8RTpcqDyNQ9DN5WXdYUUqZP+HJD
         ngzrsOWtVFpvgHdR7Lvy+gOG1ydLu9VyGTMI79eKj6UA4NQARRc8Cv78euvZN7MA5dQJ
         f9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678271335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aczIr75cZ4lMAQlCkdBUDOmKKh/88pRo1/9jBKcFvDo=;
        b=DRnj0JTwcS7yORGRHVQs/AEJxxuoTtYuFyYJmwczEd4CFtyDVcvB4R1KUJjyMyu/wA
         exAmbHvZxY/I+6hpQU5ZXaFW/9W+lI5vKU81IVNbrNmr06rPm4vxbctrmseVt7vkljPY
         g2qvzWKSNx+QBqRgsy13OkXLmcytCYx1HkdSvDXNThDKkVTr5R/Jz0Xy1T8fgJGAVRjw
         y8HaOaZwY0LxJuQD7lUGgkvdWMwS1I9+RZ/cDiCuwuYM1D5m036GZbeBzyYB9oxivPD5
         +j6scIT/ISMdXkLE7odCk1TqivYaG4DRx4BXGLyMqrcvfcxzrH3oAV6bQZAzIXyRiOdi
         j7sw==
X-Gm-Message-State: AO0yUKX3S14CAzVKHsnuO9rXy5ERsmj74LWx9AyJbN24DbFNYMj9Wxmn
        GgnaBaJH/+rZvyJsLghW+i/RYeEZLzH9Q6PdL/WA8A==
X-Google-Smtp-Source: AK7set/Pm0l+nHsTAZz1VotySAdwuOD+3PvAICPik5Hdusspob2pPU7Df9/xqtjmmWKkuBY+stebQNQAoPYftB9q1vA=
X-Received: by 2002:a05:6122:ca1:b0:401:d1f4:bccf with SMTP id
 ba33-20020a0561220ca100b00401d1f4bccfmr18336766vkb.0.1678271335090; Wed, 08
 Mar 2023 02:28:55 -0800 (PST)
MIME-Version: 1.0
References: <20230307165432.25484-1-afd@ti.com> <20230307165432.25484-5-afd@ti.com>
In-Reply-To: <20230307165432.25484-5-afd@ti.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 8 Mar 2023 11:28:44 +0100
Message-ID: <CAMRc=Mehx9Xv=xwd966N0LwEND-mxnPyjEAex8TrbycgbGQrag@mail.gmail.com>
Subject: Re: [PATCH 5/6] gpio: tpic2810: Use devm_gpiochip_add_data() to
 simplify remove path
To:     Andrew Davis <afd@ti.com>
Cc:     Peter Tyser <ptyser@xes-inc.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 7, 2023 at 5:54=E2=80=AFPM Andrew Davis <afd@ti.com> wrote:
>
> Use devm version of gpiochip add function to handle removal for us.
>
> While here update copyright and module author.
>
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  drivers/gpio/gpio-tpic2810.c | 18 ++++--------------
>  1 file changed, 4 insertions(+), 14 deletions(-)

Applied, thanks!

Bart
