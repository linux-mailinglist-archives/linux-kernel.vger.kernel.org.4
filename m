Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3CC36B6121
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 22:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjCKVrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 16:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjCKVr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 16:47:29 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4DC6A1CB
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 13:47:17 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5418c2b8ef2so1954497b3.5
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 13:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678571237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J6Mw0ypF+8k7PLrY/7XQrGegOH0i0vAAhAg3d54HVCs=;
        b=F1dKTj5WejEHbCAqSmkG0MtDRsafkJzlKuv7Blx5gzzjMJoWDtTuJYNCEvgPDPOZvb
         crh7vTUcNgrZF5QmstwHiyQp+rOnLrZpcZyjxYVDzhwHevFX41PPFOq7zxcH0w4eQSxX
         3i3c9azeyCeScysourVSzlPP3Xk6Jaitc/Zk21n6pLdsotwLVIkXl9yHolrExYnCLW6w
         L+xfSEKlr4ApGzlwduG0FM7VNqiNX5NJS7KdIrl7AiYjnG3T7QxUnhb/QIxzuYTX9JUf
         RoyJWnWW/ElU/8SXQ5IOeIX3jU/N+0nV/W4pjg8qly9QE78i1Hn+lTc4rRbT3Zf+VbqZ
         6b8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678571237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J6Mw0ypF+8k7PLrY/7XQrGegOH0i0vAAhAg3d54HVCs=;
        b=Nesz1qRrzlnpeyC8/fSIn09a4lQQBBeMiYmMCgLe9brwIkZPvl3xFe3tS4BJ8TWxa9
         68T4p4XBKeFlf7HDBzDJmgrlHhW2F18WTDeDY174KPV/o+Qti4qxykHyCMILHzOqjivx
         Nm1UgNPSYntatwt4I5XZP/b6N1Ap6QHRfK1gkwuMSZeHWv/KjPXW6NnEDxfI+CECgCk0
         k9wPypzAal5+75Rcs6vKeb8QKvbEEm8OIBW13As6+dYzF/+2LJFO9jcWhPt3Fmk/aFT7
         u+90tH/frgs7iKSjT8zx6s1LN+Tbi0fD1iSmo/x7Mcy0m2iwSCL4rL2YC4WFFNcOS/67
         C5KQ==
X-Gm-Message-State: AO0yUKW00bqTC3pK2zO7LnrfSsEFO68xw1x3dgvvdED4aaZ7mTXPoaMF
        wHNHNbT0UHg2kvvpvxiUFS/27Sqpup/k9vUGyxlUYw==
X-Google-Smtp-Source: AK7set+wqGujzuEzqpe0yUtH0QryUw6iAwkO3ZlCcQUkRUb09qFyUtqFnBmFWknIwDMk5oPEudc8Sc+vNQAvx0IRP08=
X-Received: by 2002:a81:b665:0:b0:541:8285:b25 with SMTP id
 h37-20020a81b665000000b0054182850b25mr902617ywk.10.1678571236874; Sat, 11 Mar
 2023 13:47:16 -0800 (PST)
MIME-Version: 1.0
References: <20230311111307.251123-1-krzysztof.kozlowski@linaro.org> <20230311111307.251123-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230311111307.251123-2-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 11 Mar 2023 22:47:05 +0100
Message-ID: <CACRpkdYfmApW0m_2yCK8QLR+opdRvzi6a-ULTL_k5WG3bXqqpA@mail.gmail.com>
Subject: Re: [PATCH 2/8] gpio: altera: drop of_match_ptr for ID table
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Mun Yew Tham <mun.yew.tham@intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Nandor Han <nandor.han@ge.com>,
        Semi Malinen <semi.malinen@ge.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2023 at 12:13=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> The driver can match only via the DT table so the table should be always
> used and the of_match_ptr does not have any sense (this also allows ACPI
> matching via PRP0001, even though it might not be relevant here).
>
>   drivers/gpio/gpio-altera.c:324:34: error: =E2=80=98altera_gpio_of_match=
=E2=80=99 defined but not used [-Werror=3Dunused-const-variable=3D]
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
