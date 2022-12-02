Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F50640A4D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbiLBQJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:09:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbiLBQJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:09:03 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2149ACA6B
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 08:09:02 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id b2so12606330eja.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 08:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9Lv5UzsGC5MNuyMX51lzq8lQHZSD5qCFW0KbPV3N8yA=;
        b=dHkIQtDWVxEzkcR9PWkORdgWl8wQJYfleFiUtDlLhO2HldA84X5tRjuMoTlAAEsMGo
         Qulu3evExmDVuVSuIYaMi5eDn18ElcfYbcklsiHd1mLy48yHzoBKd4YfJgIutpRBcYz4
         L2xut/t837fa812aTvn25G+M4SLiEhL47Vxhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Lv5UzsGC5MNuyMX51lzq8lQHZSD5qCFW0KbPV3N8yA=;
        b=11X0gWDcIWKHP8IwYNU4rNLVpUFpJsuty419dA95Sh5lVFE/ft+5u9D2WppciwlRCK
         AgqjoFDo5e+l35rEhJr8Us5/eE/rqHl1KjgHMXrtIJhKRCBtsyqVy7j4V6o9k//ezEhX
         sshiO2oACc/ci0szKw68QtZDJlbpk5yYPfsGN6bhlNYRaOr5Ly0ulzsyhAvAL0hTawRa
         M7kUwMhzNGKL7QvAIOUysjO9ukcL7fRd59vEBEVyRHa5qG7bqqJzn2FQXbx6LqH/NauX
         lZz55wYXFTI65rTml92Yj+/TKjFH2NHeZv4VmEX4iX/lclu6QWOTfGOV+3ywpzfJgdPF
         Cp3Q==
X-Gm-Message-State: ANoB5pmGX2uX2uPVgHyZh6Qj8d4TYEScvmm4rfDlziSfvDhDaABEKXtK
        5Q+JhEgHemCVZSmpQkiTcKvs+GoKi2OUxg9azyg=
X-Google-Smtp-Source: AA0mqf5rGuR6A19R+4UMtmBLU7egZTeVEig5R6C5FGeR/tVNROQ2OS1ljq8l0rbKNLm7IXSFP8AFlQ==
X-Received: by 2002:a17:906:6809:b0:7c0:cd95:bbaf with SMTP id k9-20020a170906680900b007c0cd95bbafmr1538563ejr.460.1669997341317;
        Fri, 02 Dec 2022 08:09:01 -0800 (PST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id d13-20020a17090694cd00b007c0b28b85c5sm1976895ejy.138.2022.12.02.08.08.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 08:08:59 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id o30so3860901wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 08:08:59 -0800 (PST)
X-Received: by 2002:a1c:cc04:0:b0:3cf:7716:8954 with SMTP id
 h4-20020a1ccc04000000b003cf77168954mr52698641wmb.57.1669997339063; Fri, 02
 Dec 2022 08:08:59 -0800 (PST)
MIME-Version: 1.0
References: <20221202155738.383301-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221202155738.383301-1-krzysztof.kozlowski@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 2 Dec 2022 08:08:46 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U86PyVQP4wbhwEkzYprJxz2-S3ooniuYKJBNQOudx2uA@mail.gmail.com>
Message-ID: <CAD=FV=U86PyVQP4wbhwEkzYprJxz2-S3ooniuYKJBNQOudx2uA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] arm64: dts: qcom: sdm845-db845c: fix audio codec
 interrupt pin name
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Dec 2, 2022 at 7:57 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The pin config entry should have a string, not number, for the GPIO used
> as WCD9340 audio codec interrupt.
>
> Reported-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> Cc: Doug Anderson <dianders@chromium.org>
>
> Changes since v2:
> 1. New patch.
> ---
>  arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Presumably should have a "Fixes" tag since this is likely a true bug.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
