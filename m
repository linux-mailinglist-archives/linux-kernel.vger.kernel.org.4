Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD1968E808
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 07:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjBHGIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 01:08:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjBHGIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 01:08:11 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71263D901
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 22:08:09 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id 16so2654379pfo.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 22:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Iec23gsP+sSms2hV+HR+Vp0eFbhDQHdA6maO2iZiIVw=;
        b=LKUOLxjmnNMz9gvLHLLDkZ417tWU/oPLRPjDnHjj+O56WlbzroFIcAgNxOAnou09Td
         fq6PJ2vMNs6bzz2LqZas4kJwN6TIQKwcHleK2D0VS0yp1g1Tj3ko9+aMvpMYT0LXJjY6
         LADxqQdVRhECEjv9q0Inr1hNMEdOPXAlN9mfhhNUu50/oZHECDvUdIBMpwc1zksr3d99
         /hRoAJB9YcOQ9qYJ09bPJm/pQ9JaQidxeio6QRZw/k5SLWbNZWF5gCnC9J0rH+vn1DjD
         DhjLYhCq2b8LxHR/KhLuYaZgMjT3ydhbrTT5sD2S4KnTPD27vOGWf8yaTQGcmhJmqh21
         soUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iec23gsP+sSms2hV+HR+Vp0eFbhDQHdA6maO2iZiIVw=;
        b=8ES8cEUqkBjYc48qYchFSgktUppOFffN6y4cpyPXGAy1s/NlwWtbMaosEBJB21tIsX
         X7nqdh47Tjeht6oUU/GihUIKqc5Yq3j9qK5H9kfi82Zdbst73YJnq4FJSApJ9LezSKlH
         oht2MFkRkgAMQ/Tvh4mCaaaY0rGx2RN0n5YP0jyqtak8NnasSP1WdMYhShhaJJg6ffn3
         N7UnkpIlujskQk56L8tUepuFpqvXJqlBUDPfOL3Cckwk0stX/EyviR6S+MOHNIbUlwdA
         Awrw0TPSg+ze/qd2UvoFul1YEPWt8Dk6G1DrNf0sDehNc3xA3kbVg9LhySWSk/o6i4d7
         vQ4g==
X-Gm-Message-State: AO0yUKWaGe8ubVjkyEZ5euLGzPqW+aasazStoo2dw65qJRQOH2OMeeS8
        eXQqo1F4msl3l9KnZp6WROtLqum0/elnyACg+kM4Pw==
X-Google-Smtp-Source: AK7set9VK9sGir420UmhyaPvxF5uQawzrlEDIpDo9OvveQC0SfMGXXRUKk/qqxnI3hWKpv94NGRSPK5OJiOWw65QFas=
X-Received: by 2002:a62:cf06:0:b0:5a8:1929:f482 with SMTP id
 b6-20020a62cf06000000b005a81929f482mr388781pfg.49.1675836489152; Tue, 07 Feb
 2023 22:08:09 -0800 (PST)
MIME-Version: 1.0
References: <20230203060924.8257-1-semen.protsenko@linaro.org>
 <20230203060924.8257-7-semen.protsenko@linaro.org> <59ff815b-baad-02c5-67df-e4d65f63afa3@linaro.org>
In-Reply-To: <59ff815b-baad-02c5-67df-e4d65f63afa3@linaro.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Wed, 8 Feb 2023 00:08:18 -0600
Message-ID: <CAPLW+4mXJ8Gmb-OWabdN6EyaUrCUQuFAGyGh09TDgikmL5gjAg@mail.gmail.com>
Subject: Re: [PATCH 6/6] clk: samsung: exynos5433: Extract PM support to
 common ARM64 layer
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Feb 2023 at 03:18, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 03/02/2023 07:09, Sam Protsenko wrote:
> > Exynos5433 clock driver implements PM support internally, which might be
> > also useful for other Exynos clock drivers. Extract all PM related code
> > from clk-exynos5433 to common ARM64 functions.
> >
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > ---
>
>
> >
> >       if (IS_ERR(parent_clk)) {
> >               pr_err("%s: could not find bus clock %s; err = %ld\n",
> > @@ -91,6 +112,46 @@ static int __init exynos_arm64_enable_bus_clk(struct device *dev,
> >       return 0;
> >  }
> >
> > +static int __init exynos_arm64_cmu_prepare_pm(struct device *dev,
> > +             const struct samsung_cmu_info *cmu)
>
> Align the arguments.
>

The same issue here as in my previous answer, unfortunately: when I
try to align the `cmu' argument to match the open parentheses, it
doesn't fit 80 characters limit, which doesn't look nice to me. Do you
mind if I leave it as is?

> Rest looks good to me.
>
> Best regards,
> Krzysztof
>
