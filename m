Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB548716019
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbjE3Mle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 08:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbjE3Ml2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:41:28 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35A3A1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 05:41:03 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-568bb833462so12782267b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 05:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685450407; x=1688042407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOtUrb1jXt1YTc92Nx2K8yaF1tV0C2PLHIJDBXMJ1e8=;
        b=Xzaug7RhDfquxOwHHHTAUcmTCtkuzS5zRcWlYeEfobpHfoMjVlAS/CwdmhocJy+96e
         GWYVY+IToJWNf9RtM9CIM/4PkuKAlXjNuQvcsVuWPFSx3X7+/JzWNPUl91BQ2ra5ZCl9
         WONJg0uWUzsOzjrDyIK0shIC3ZgS5EfKxfg2hGcKlFIk5QoOXa0c6mbUMYZXh+tuhlZT
         /PitNi3wMZcN5EZ+MZKSUEOGbHJh1N3Gc9VcsdvFdffGhb2KSAG9ISFWbZVIgAazwWrD
         CTGPKjvp6w9IHZGE8jnBotfig/8ctvxCSmFJUU35tgunJYFbWHAKP83CjH6vJNj44Vm2
         b5MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685450407; x=1688042407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KOtUrb1jXt1YTc92Nx2K8yaF1tV0C2PLHIJDBXMJ1e8=;
        b=ditQG17YR81pbG/AMQpyV8ci04kI3k8W5qnciOvMK+m80msJ3fvBFec2bP63lLpgKw
         EVChqjDOLL1cwOmEF+1Si0LddqJNMBN8FedO5RtBBfyATrQGQZVAoYKlw2zjt1fxoeyf
         gY5+Fvh31P2wc6K/FtsljeTnTl0tNbx2V+msIZ+ySxvMsgrTMVDit1p5klRgsYwSoQTE
         uPIARktRexpjKRIQQmvfvjzqoq/Vesm0l/aMW6A4Yxk6Mv0neVg/wtrJeXltaqsZHHWt
         7Lo3RFzk36ztEV9XcFj6bTXLmhfFWXIWAzriZ/FTJxALceungwfIRZh9Skpe4F+LGyqf
         Yzzg==
X-Gm-Message-State: AC+VfDzb8h1klbeFkTG65PJqUXRyMuutcCRhA3mPBN/NOr9+ralbF9uK
        5L/eew5+RbjhPA04aVSjcPYvY2aiAmRcUzmdkoCvqw==
X-Google-Smtp-Source: ACHHUZ5IRGVEGgUUERDvrDWcgtVuSj/SsOzSJ38VVusLz/5pCio/b35QywJsy1pwoBoZoBBFa8YeImTExOj4H4CgVzs=
X-Received: by 2002:a81:83d6:0:b0:566:a76a:fcc2 with SMTP id
 t205-20020a8183d6000000b00566a76afcc2mr2345411ywf.4.1685450407354; Tue, 30
 May 2023 05:40:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230529162034.20481-1-alexandre.torgue@foss.st.com>
In-Reply-To: <20230529162034.20481-1-alexandre.torgue@foss.st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 30 May 2023 14:39:56 +0200
Message-ID: <CACRpkdboHeg-=thHvZrQXcx_HnecwmuBJskJTPjxFOB9z9R0gw@mail.gmail.com>
Subject: Re: [PATCH 00/11] Add STM32MP25 support
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 6:20=E2=80=AFPM Alexandre Torgue
<alexandre.torgue@foss.st.com> wrote:

> Alexandre Torgue (10):
>   dt-bindings: pinctrl: stm32: support for stm32mp257 and additional
>     packages
>   pinctrl: stm32: add stm32mp257 pinctrl support

Can patch 1 & 2 be applied to the pinctrl tree separately?

Yours,
Linus Walleij
