Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA85070649F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 11:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjEQJw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 05:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjEQJwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 05:52:55 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0E4A6
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 02:52:54 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-44fd6524c36so234005e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 02:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1684317173; x=1686909173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5hlnwLqa+RxtRx+qxf8dxbPXjY3l2J33vfW0LrGz3k=;
        b=qd+Sqt0ZY5TEVY3gCHm4vTv4eB78xhKmiL+2z067YTJrRJO3+9dGoObBMM7G1s6fm7
         Olh3OvjoWVPYEgQ8HfQxZpqwS9pG3ilpNuJGQqjL8EVKEPndpBrFk25Ro92g45DEykaD
         U+Zhwi04UjT9HDHuI3/fbLEL7ChajlcyEI8TSd2KJ6WvTOCTOMrSUKEpNnl5sxJhGWzl
         4goJwXMud1aK6Pqswk+whQ5UR+9zYHQ5kHEi8PP/zWquVaVXSFDrmpLEhEdmcB7SOTZi
         DVflwSUuhEWaObMLL0UtYt9NeipgnKGvnWxwmnFEiDMZ1JbZuqrP96eHRwZ7u1sQ+ztK
         bHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684317173; x=1686909173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k5hlnwLqa+RxtRx+qxf8dxbPXjY3l2J33vfW0LrGz3k=;
        b=l9W2VFvPIGeRrWQE+b/IO61RK9Lq6zZlMOa5QZemK0xCCp3I0dmA1F4EhDajF/ATO7
         ZD8vOTbjpycH7XK+6Lc+4dyn/qY20v7lrWgVeh9P8x3oOpUbEopWgzPxAh7pFKMBBpIF
         uIrG0URDhJnlVAfeSIc9z4/NwlutEYGEEZMZEX4AUwWD9CQhNAeQJQdcTrxhOt7Oe5dg
         OSm46nNhG4VDnA/QwoUAHv35ij4azsANSnEJDAcgmqJgBL6OFXjGwTPCEddhgQVxCRps
         /lF386o3LA5xIaWdItdW/XW8gmJx9+LuSlltYfPBEvjthMqeMUNo0JT3GMGeqB+GaYZV
         LIWg==
X-Gm-Message-State: AC+VfDz4j38vSIyvOgtIdMFfrdbZVgX+1KRcfne314rcAynuf4L0IKun
        WO7BoFzDS6bb1j9s1FWAo1DDX8/g0gPx5+/mONc0EA==
X-Google-Smtp-Source: ACHHUZ5Uev8QQXWxUXGCNQNQStfE4cqCpqtVTvU1K3cQKIdzH1SS6fmSjzeYUKQbA2oeS0DhXbhVg06/E3c+Oixd+5w=
X-Received: by 2002:a1f:dfc1:0:b0:435:e8a8:29f7 with SMTP id
 w184-20020a1fdfc1000000b00435e8a829f7mr14120468vkg.4.1684317173330; Wed, 17
 May 2023 02:52:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230515174224.494631-1-afd@ti.com>
In-Reply-To: <20230515174224.494631-1-afd@ti.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 17 May 2023 11:52:42 +0200
Message-ID: <CAMRc=Mc2A_7_Yy1Jd62xnpaiAV_RAw5eF8DkTr3sdKXBZgLunw@mail.gmail.com>
Subject: Re: [PATCH v3] gpio: sch311x: Use devm_gpiochip_add_data() to
 simplify remove path
To:     Andrew Davis <afd@ti.com>
Cc:     Peter Tyser <ptyser@xes-inc.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 7:42=E2=80=AFPM Andrew Davis <afd@ti.com> wrote:
>
> Use devm version of gpiochip add function to handle removal for us.
>
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---

Applied, thanks!

Bart
