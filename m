Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64F95F3D51
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 09:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiJDHeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 03:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiJDHe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 03:34:28 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9C44D148
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 00:34:26 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id hy2so26956995ejc.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 00:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=PB8GJk//RqejjOnpATRYeyDuPsbXbNB+nSYv7IkV3dY=;
        b=uUwDwLTCDuc6k11DNLdxKvouWouNrX5htEl6budcfGy+KnBLcSwfza7E4uk7TLzJnx
         P5bxfDbnb0CMlTFfQA4LxKReVwR76SFkmPkIRgj0oJbBdCUpAPiwUSqTuGhTRZir8IWm
         mOZWLNW/+GF7YeCI4/rPmANUebw6iKIMM3S0Hy6+vhGamhcy3upGINgybT/8xPszgjZM
         4uBBc1hUwPRzVCnd4xVU77itt/X4xWYUwbkVYZ0/r5pdgWWb+K8H0oeB4Erj+uFKhIvD
         4O3wiwPkC1JxBdOjcFem6UKauuxuIAPBS7oqdd5ZiBeY/w3Wm8OtrnG7ACuyCYkBF3Ws
         FCDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=PB8GJk//RqejjOnpATRYeyDuPsbXbNB+nSYv7IkV3dY=;
        b=lOAWPUVSoME5eGChRQm6GsGobAATwDzioyaDGZ2hAlz+FLDOJaCz2EWVhIBhK0qWu9
         LHQUYo9jVO3Gs05z58mX36ubr2fueUjpVZ/MSzAITimEMD4ZgOntSt023FdfZohRRR8o
         tyWj5aCcLZtRs+oNYgTuTLaOD3x2fsAo+SnSCsYH+YMnlvWbQkUQXF225VcBi2ERlpSp
         UhGx2jU0qqqpmVg2Bd6nRvkb+hy+/+gHovuX7vIdL0RpngAnWrz2H7hIN5I7QeE7ab7Y
         C6paDTPCOR2B9p74fAH8BIDkBq7lN5EJ6vRe8Kf3fpVd0yVDztnSwAzKMNFPTfm5Tpf7
         wo4Q==
X-Gm-Message-State: ACrzQf2tvEP8mEYYFycZMlLgzh2bxK4qYS6B3h+T3EF0ErqsM9UMo6RP
        SpQ545dPmUBPs5UDqMqT2C7+tzp4qSfIekJIqMxong==
X-Google-Smtp-Source: AMsMyM4u5QfJ8I4XjmQQ8y27SrW4rIzRwTXevnfaj3eYh/net7YfV7Hustl0WtRIAAw7Cl7QwSDaDDl0rofndt5II+U=
X-Received: by 2002:a17:906:8a46:b0:781:71fc:d23f with SMTP id
 gx6-20020a1709068a4600b0078171fcd23fmr18431943ejc.500.1664868865231; Tue, 04
 Oct 2022 00:34:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220925112103.148836-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220925112103.148836-1-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 4 Oct 2022 09:34:13 +0200
Message-ID: <CACRpkdb81Vh1zZDeHArOU4chmT4_5YyEXza5Vvp_n2fHJ_YBew@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: qcom: restrict drivers per ARM/ARM64
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
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

On Sun, Sep 25, 2022 at 1:21 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> There is no point to allow selecting pin-controller drivers for Qualcomm
> ARMv7 SoCs when building ARM64 kernel, and vice versa.  This makes
> kernel configuration more difficult as many do not remember the Qualcomm
> SoCs.  There won't be a single image for ARMv7 and ARMv8/9 SoCs, so no
> features/options are lost.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> Changes since v1:
> 1. Restrict MSM8976 to ARM64.

This v2 patch applied, because nice.

Yours,
Linus Walleij
