Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED622732B38
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbjFPJP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344120AbjFPJPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:15:22 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF86199D
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 02:15:20 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-46e71b39143so146102e0c.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 02:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1686906920; x=1689498920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8rTrcJmVo8/odo0YNKJ0kqA9w+6Lxfc+GT+B/xhBCn0=;
        b=0a41RlEDxqzhARVY8DZt8r6BDYlhjL5wzuIs50zDqo6xd1PwUIfjqrvLAczKKsb5ml
         fkKs5VSX2cvqi5Kx1tWcakxpma1RBZjji6s68ST6kmMER50sfW2xrlxZjrY8t6x6OfRj
         GOVmIbCw3Cl7fqzYY2o06iSEz0MvBTex7o/szm1mwqkZhfubu+T3K2R4eGsEPa4tf1Bk
         kRLBVq7wOCQk6lB6hyds/xYhOUuSSCUNfBbFqTItBgrfnP/pRI+ye7kzepCRgMeBNjs4
         s41oCw+wC0Voib7/ggCMVX22SdlYQZEtxQppbETSMRP9IOAy+bcbXWavnsi7/OwKBGuh
         ts4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686906920; x=1689498920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8rTrcJmVo8/odo0YNKJ0kqA9w+6Lxfc+GT+B/xhBCn0=;
        b=Y+zmFT85m9JxLUb5nOwdwY6zLUd+VGN+y77VoDkOqNZBK20KcFtpwdbG5XLUCGS9Br
         M+9LFvq6QzGsmdcgwcC5ebZsJea+TdxYly4gYBJZGQgnL6je3RGAJs5I62jbfV1E3dZD
         KtM2twNYykhzATVoKJ6q1Bn3sCS07L5lYQnOUxjPvLl4MyZD+qftN3oi1aD6H/7EF0mT
         8DEIeEDCIqZNLZEnqH3rqLKWcAa8bt06OTRvAXPa7NCgLwfU5drf6yX/2OZsKRQf3WPD
         UO+2+MOKy1/Ogffd/Vb4EFZkXAd0SqmA596h7ZKLrh0L78cCq2/UMS4kWQeZIufdq3ER
         7Epw==
X-Gm-Message-State: AC+VfDwJYDT0hG1ixIkHPtJtJAfV5cGgt00cvNzKulfC6PSV2JGPNs9m
        WpVKt5g6mM3JAVqt2cFXd6oNFnTaf04pLR/tJUznZQ==
X-Google-Smtp-Source: ACHHUZ47TvG6l7pdc7ZI/Lk7WDurYw1i5RynV1Z17ir9PMwtvXWYmm/x4Rg9EWDru7Y31rSzG5Js8uwjqK6WBb51hHU=
X-Received: by 2002:a1f:bf43:0:b0:465:fa30:d633 with SMTP id
 p64-20020a1fbf43000000b00465fa30d633mr1477681vkf.0.1686906918373; Fri, 16 Jun
 2023 02:15:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230424123522.18302-1-nikita.shubin@maquefel.me> <20230601054549.10843-15-nikita.shubin@maquefel.me>
In-Reply-To: <20230601054549.10843-15-nikita.shubin@maquefel.me>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 16 Jun 2023 11:15:07 +0200
Message-ID: <CAMRc=Mf6mt0wGqUU1PS+YqJJBV9Dy2nAyAASWg8BvJ6UDUvVXA@mail.gmail.com>
Subject: Re: [PATCH v1 33/43] dt-bindings: gpio: Add Cirrus EP93xx
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Peters <mpeters@embeddedts.com>,
        Kris Bahnsen <kris@embeddedts.com>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 1, 2023 at 7:46=E2=80=AFAM Nikita Shubin <nikita.shubin@maquefe=
l.me> wrote:
>
> Add YAML bindings for ep93xx SoC gpio controller.
>
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---

Applied, thanks!

Bart
