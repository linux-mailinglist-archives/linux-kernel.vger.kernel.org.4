Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5A75F3D61
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 09:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiJDHiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 03:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiJDHiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 03:38:12 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639C44D253
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 00:38:11 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-3321c2a8d4cso127999157b3.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 00:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=OSMuFVsbci918WMEsC7sFXDY5UEKrP97lF7jwpn3ZKY=;
        b=YUpCQLVh/ZbPEIM6MRSoBRL5dBKPIbED6Jc5x3rLs3i0ZeY74CIthfaKS89OvtzUbJ
         evJX0WkzNNEHZKx3NZthh7TCtRjKGZfSCXYj572FYJmnWLCNNPeQeE7e7OMHfDMBQgMH
         iFueADEecwzMszu4qHBUBbfJwnohw3RLekyz+y05PGT8cwVRuNJ9RE/n6ESVgncDkj34
         DQO7u+mzUTZEUzIypv9gUmKkzpMj+idrKkuLP9Z9/oo7YL2mVu2y1liXo7JWBPzSYBmb
         gV9oF+WusRD8KAjKLq5izmywBwapiXXrtq5jWYdQlfQRWuaGUB7LLR2d9yAN1L9IEckJ
         AeJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=OSMuFVsbci918WMEsC7sFXDY5UEKrP97lF7jwpn3ZKY=;
        b=GVh2eaVQnsUiJJsKZVGBm84rLd7FXfC/I8vOQ4NwR/XIwtdB7onWbJ5Wcrhz/4Mg77
         xVyIgdIs+LCV4IBa15XeFr6h4L0bKUKT9TJQLqzf5yKQw1PRUrHafckDe4YmU5luMdva
         i+2PMPEzdtGMzmKDFo+ZS+HIDKm9h4w1SQsobDjhOzsuM4c2VdThu1SsAK1kHWn8hhmq
         oZRepMmvLk5k35lzQjunEqFPDy+eQOrxFsjQghbw8thNGGDeKQdJo414w10L1Ru9W7EJ
         bylNdL2tXEh6C0tQK+JlADHZFeQ685ROEinVqO+HiWGrNNp4bWDlStBZs1U82zFDEQ9n
         P2Ww==
X-Gm-Message-State: ACrzQf1CieUK+3fnilgCf383Qg4OwuNKXN3bjGDILkgyKe+SaSV1xErP
        40CphyKJIEXi3HLRCz9GqWhE8ElGc1p9/hgQ55aUEw==
X-Google-Smtp-Source: AMsMyM5j+XEoX2xOKukGTbIUyxbRXejrMOAtr1bbMRrNN55E8u5O5TLP8bVa8lmMZpIgATy9l002URxzu/ufb7quNyI=
X-Received: by 2002:a0d:f685:0:b0:343:bd3d:80b2 with SMTP id
 g127-20020a0df685000000b00343bd3d80b2mr23377204ywf.485.1664869090657; Tue, 04
 Oct 2022 00:38:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220925112103.148836-1-krzysztof.kozlowski@linaro.org>
 <08E290AD-C842-4BF2-9C57-2CE59A4C5D88@linaro.org> <441153f6-26ee-cbb2-fe42-101de91952c5@linaro.org>
In-Reply-To: <441153f6-26ee-cbb2-fe42-101de91952c5@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 4 Oct 2022 10:37:59 +0300
Message-ID: <CAA8EJpouyuCn5Kz-3RgRJPd+K1sWwtidz1L_mXY_U2AFQq8oOg@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: qcom: restrict drivers per ARM/ARM64
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Sun, 25 Sept 2022 at 14:54, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 25/09/2022 13:43, Dmitry Baryshkov wrote:
> >
> >
> > On 25 September 2022 14:21:03 GMT+03:00, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> >> There is no point to allow selecting pin-controller drivers for Qualcomm
> >> ARMv7 SoCs when building ARM64 kernel, and vice versa.  This makes
> >> kernel configuration more difficult as many do not remember the Qualcomm
> >> SoCs.  There won't be a single image for ARMv7 and ARMv8/9 SoCs, so no
> >> features/options are lost.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >
> > I haven't checked which restrictions apply to msm8916 at this moment, but it might be worth adding 'depends on ARM || ARM64 || COMPILE_TEST'
>
> This is limited by ARCH_QCOM (top-level if in the file), so I am not
> sure what would be benefits.

I thought that it might be added to represent the fact that this is
not an omission, but a special case which can be used by both 32-bit
and 64-bit archs.

-- 
With best wishes
Dmitry
