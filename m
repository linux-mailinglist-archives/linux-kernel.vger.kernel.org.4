Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27756EA5DE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 10:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjDUIaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 04:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjDUIaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 04:30:12 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E9386BC
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 01:30:10 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-b992ed878ebso1208966276.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 01:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682065809; x=1684657809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5klHMq64VIljoSVkOwPJ2cgj8nj1Si169hW4IY+bP4U=;
        b=lrQhs+vo1k2UBUSg8IofSsZ0KVGmRL89oDZ8r7Zsg/81K9QtNTz6+xArvTE25AQkL9
         BP0uHNf/IPGoUxcGQHCgqUORb2Gtr5OsXnQB9uJbd5eqCC/zfA5ZrCnP97clOCzTNa5d
         mdD0NN1a6M7wE2U8hzBjrWffRXQWPMwKTYOh9O23KUEypN98MMGQhVbYBiZPKQwI0Ctw
         pSXb56zGQtocA0R7fJxPCqoruGf80AFomCpYq0IDtzX+1vcZGVGjdTy4JS4OaVnPCD2s
         gGD5i9mwhakqDnYpSsy858vGSBeCSAXzcSwkRjAcYDllLLMjU2Q16vs0pDIsEQwMeRvp
         tEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682065809; x=1684657809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5klHMq64VIljoSVkOwPJ2cgj8nj1Si169hW4IY+bP4U=;
        b=hktCGAPjmFc6ekxmGvA0qyupm4YOzUrnXw7juOmdsRQWpkyUTJcdS3N+Qt3N0Z/Ls/
         yEgBdFCwMFVIWj/OSkAVBh9z/+I5T3fpOY+EPQT5rthP/KyMqM/3+oxBAdKVltUwPzH7
         v7Hx0oXfmEmJDWcgGU60vpgZytWCdD0aj74IrV8/dLeccHm6mnDP09WZ7M1quxRsm/oU
         2JYHTshmAVwWj9DLB3wq6TKft67vXFHxoS5kPfnV4uR2Zr7uwKBGRx3CO47B37TOtz1I
         G7bNrFTXd6SzKIqULbRQiKT1j7VI4/dsKlVeiT8OjfGCMvGYZinq+Gpmu1p8qqXe/Zlk
         MR0Q==
X-Gm-Message-State: AAQBX9eFF8lZDhR952Kk2v9VAsYVx4NKHaTwYP9m+6saL8KnjrJdzSCs
        0OdjieUrwcLJE0S1WRkUDlE3LtkC0NnW5/iLM+W70w==
X-Google-Smtp-Source: AKy350Zns/U+3vpNmpMzNn8WbDce9++folijXpvxedcLeNyjLrhBVN1M2j1Bs3JSk09cKtYRX5696eR1QSUH/+GFEPI=
X-Received: by 2002:a25:46d4:0:b0:b8f:1cea:e064 with SMTP id
 t203-20020a2546d4000000b00b8f1ceae064mr1238150yba.32.1682065809654; Fri, 21
 Apr 2023 01:30:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230414-pmi632-v2-0-98bafa909c36@z3ntu.xyz>
In-Reply-To: <20230414-pmi632-v2-0-98bafa909c36@z3ntu.xyz>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Apr 2023 10:29:58 +0200
Message-ID: <CACRpkdYgDC0QJhH4s1P2ga3W=xXqjovhsNS2i5nikgu_ikenKQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Add PMI632 PMIC and RGB LED on sdm632-fairphone-fp3
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

On Tue, Apr 18, 2023 at 6:43=E2=80=AFPM Luca Weiss <luca@z3ntu.xyz> wrote:

> Add support for the PMI632 PMIC in the spmi-gpio & qcom-lpg driver, add
> the dtsi for the PMIC and enable the notification LED on fairphone-fp3.
>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
(...)
> Luca Weiss (8):
>       dt-bindings: pinctrl: qcom,pmic-gpio: add PMI632
>       pinctrl: qcom: spmi-gpio: Add PMI632 support

Patches 1 & 2 are finished so I applied them to the pinctrl tree so
Luca does not need to keep reiterating these for the next kernel cycle.

Yours,
Linus Walleij
