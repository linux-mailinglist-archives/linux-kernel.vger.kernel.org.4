Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3736F8248
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 13:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbjEELsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 07:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjEELsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 07:48:06 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A854D1A4BD
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 04:47:57 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-b9a6eec8611so13490415276.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 04:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683287277; x=1685879277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XTrDr578NC/gUs+uP2wmO3lmiMTZbf+ExeszdD3Ie64=;
        b=gdjOFWB0rJQtDfWkQ/m+bJPGSIdfpovnQm1hHddyO2JAsTJ2k8JmeBWkZMNxtOreo5
         yz2dmkc+q+kKpJSEP3FxkGsDUjh/ro156mjPJld9fACXkc+QKuDG/JuzUtYhW8xnF/cK
         w4D8BhNkWBn6BU9Et/ZU4XN8j1UqAsOuasuc7h7lselpLuPIP4+2ExCGr+SpyLwmUPj6
         kurfgnsQ1cCggIdN7p8euF8x38gurW9VcvZ/oHVquUJ0oOjxB2zB0O3zWyXm2wg43Bka
         sI7Ft7XSmPedDkRkdjJrXptolUmU5hHOnBkmK6TQu4I1ACOIK7FfX71Eb4S9nONdlsf2
         nvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683287277; x=1685879277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XTrDr578NC/gUs+uP2wmO3lmiMTZbf+ExeszdD3Ie64=;
        b=B5YBjtcYRki1/f2w5F+ke3h+UTOV1Xy4tju2sl3Hjy3D4OjsEhWVio6OT9n7YiUUs3
         uaqpVoL81cyjHHygmJrOr+2iD6gkQkiDMTHC5FIU6w1vNk3TzMMEkDznY96g2nm4RXbC
         Uy2qB243ZUpgVwli61ZAHPgzzJaSevZnkXlZwlFdGdEZWVNOvAzQrGMk5Kv25F7pYFUC
         rGFACVDMgz6mT03i0ZI3YxApLVSDKqbAzH8YUcwvvm9Bxesi5TrTk5ER/x9W5pSsVjvh
         sMztDs6dBn5cbhAm/7OMHAgcXjjikUL07VwgM5WvWdTJRdVBSpFC8X34BAgsO+tstGB+
         3KGg==
X-Gm-Message-State: AC+VfDxSJ8NM8j66MlQRat8PdfYHT0Pv10G5Zaq8T51Qk08cu5WINKlS
        mBdTFwCDI9O5IqRa5VvGSGzcDMeWRBLKstrmZqNkiQ==
X-Google-Smtp-Source: ACHHUZ6qLucPfOToq2ZiafgJxgEH2Or1H88xpEit426pg7gmpbrD7FsAXIVqXhMYKCgcXL+Y5Knwm/tvbtkRVbglMvQ=
X-Received: by 2002:a81:4895:0:b0:54e:ac2b:8a8c with SMTP id
 v143-20020a814895000000b0054eac2b8a8cmr1202981ywa.24.1683287276846; Fri, 05
 May 2023 04:47:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230421-pm8953-gpio-v1-0-3d33e2de47e3@z3ntu.xyz>
In-Reply-To: <20230421-pm8953-gpio-v1-0-3d33e2de47e3@z3ntu.xyz>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 5 May 2023 13:47:45 +0200
Message-ID: <CACRpkdbSFgGOXUUWw5m0SM48uNispuYUckiF5Fvuije6pAtX1A@mail.gmail.com>
Subject: Re: [PATCH 0/3] Add GPIO support to PM8953 PMIC
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 11:56=E2=80=AFPM Luca Weiss <luca@z3ntu.xyz> wrote:

> Add support for the 8 GPIOs found on the PM8953 PMIC used with msm8953
> SoC.
>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
(...)
> Luca Weiss (3):
>       dt-bindings: pinctrl: qcom,pmic-gpio: add PM8953
>       pinctrl: qcom: spmi-gpio: Add PM8953 support

I applied these two to the pinctrl tree for the v6.5 kernel cycle.

>       arm64: dts: qcom: pm8953: add GPIOs

Please funnel this one through the qcom SoC tree (I think Bjorn
will pick it up else poke him).

Yours,
Linus Walleij
