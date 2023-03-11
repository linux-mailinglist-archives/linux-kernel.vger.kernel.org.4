Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63246B6123
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 22:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjCKVsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 16:48:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjCKVsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 16:48:09 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B46810406
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 13:48:03 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-536bbef1c5eso169399287b3.9
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 13:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678571282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGcFJ5ZxlDi9b/UdZuLc5OKiysEmLsLLWteNS6EE4s8=;
        b=slvilrR7hL2U+x5tjSLa8nfAo4reE3kTOTus1wS3FCOIF51shwNRrueWrFqCO2sfQp
         y3ay+nZQTaboeL4nzyyx2zUHRkxrbOthRtbNASa9nFaYDv9O6q0GGBZE67CYn2vX5tKT
         rBOg5+rhD3wCrI+vhRg7bt3ar5tJyU5Bnn1bUFshqNAsz5442iG82RC/Vy10EliokxKD
         LtzvXMqHAOlRFleox9BSlZr5OpeU/OKtREjvs8Cyq9CAHtSPldFxGZBSRWp2iacjsN/i
         Qm6Fyfz55wA3murhe8oaS5jG5mq37BhDPTuz3cy4ia+qNX1GrYqDMIExz6iRZj1OEMfA
         l0wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678571282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mGcFJ5ZxlDi9b/UdZuLc5OKiysEmLsLLWteNS6EE4s8=;
        b=4SjA+RUzeStD7FFsQviZ5smmrOHxlXmxMz2dTo8IIP52TO18Qhso67nox7n9qbBujf
         1NBtGMnS6EaFuRFsjwFPsadABPTe23gdpXCweAN7RDwmc4itoynHrJVR3Kj3oVe8F/ZE
         +H/ICSwGlT5Pdca4V+TG99BmSxMkRfAY+tGRAcf91RXrZUnZjVfFbWcvAYVIRJ9mUwu6
         ia3yMPyt6m/YD5Ru4tnIanr0IzcMvxPcCSTm01d26QtTJhpGYfga/YoJr5yKCg4JUM+H
         pt8ZWWiufrKfHTOzoX2rI2GNpoEcpxv4nVn9s82RgtaRHknGBCdpxxBhXXs2jItB7CoG
         erIQ==
X-Gm-Message-State: AO0yUKXY8i/VVgLEtJd8sA7Hn0zI+9ppM+8cSPYmRWT/qu3/2A2wOBSI
        TRmz0QGI6p4Ys3KTdRY2k7HCnuAiWHbxCRY4g4R7RA==
X-Google-Smtp-Source: AK7set+YWOvwKMA1dPUxLsgUB6Fr01943IW1At9zwSR197k6yZtnzlsy0wbTdNADDF+fKXrTt/C9WEZ0kzk2Zcjd2Vk=
X-Received: by 2002:a81:ae61:0:b0:541:822f:af40 with SMTP id
 g33-20020a81ae61000000b00541822faf40mr966072ywk.10.1678571282495; Sat, 11 Mar
 2023 13:48:02 -0800 (PST)
MIME-Version: 1.0
References: <20230311111307.251123-1-krzysztof.kozlowski@linaro.org> <20230311111307.251123-3-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230311111307.251123-3-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 11 Mar 2023 22:47:51 +0100
Message-ID: <CACRpkdacHi7J1rjaFyxK7uNkKGmVpno71pVmPrAkrCvDc5_KFQ@mail.gmail.com>
Subject: Re: [PATCH 3/8] gpio: rcar: drop of_match_ptr for ID table
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
>   drivers/gpio/gpio-rcar.c:435:34: error: =E2=80=98gpio_rcar_of_table=E2=
=80=99 defined but not used [-Werror=3Dunused-const-variable=3D]
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
