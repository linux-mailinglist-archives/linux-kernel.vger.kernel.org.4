Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FCD654636
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 19:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235476AbiLVSyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 13:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235510AbiLVSyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 13:54:14 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCD9275DD
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 10:53:30 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id fc4so6935859ejc.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 10:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZcsqGPg6FZAoLHqSnlhY2ZqAO977IJDvTdbEOzXS1SA=;
        b=AamEj6mQ2MbxRL2eTQGNKqmtoyHbk3rHDzkRcFN6JuRLM98nQ/XJwAS2oV1KzfiTG3
         KASKWAosayh8tChJjITyM7qtpCbQmvCZoGsUz6zA82x+iqbXvIjaRSr/hoBQRO7TVY2g
         ahPYr09u+OlpS6QVItdO9QwhJ3xF09lfs9xGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZcsqGPg6FZAoLHqSnlhY2ZqAO977IJDvTdbEOzXS1SA=;
        b=bE3UQB53yaGp2hxXvF9Ee+T4M3sxT3YvAPRrF4/BZxFjQ03uhSxd/g5PaUzzXM/nXy
         u99jQgs3ArlktcGfS3U34k+HFBVgYd/EezvOpV7ZftyAJ6kwq8a7hxgnoTjM2XLc4Fqy
         l0SHMdL+20UenvF55I5+2gGXml126M+rOHaohVmzGETEpJ7UlOoKuKDpF1/gJFOQAbZc
         li5eT8iPERJK2kRezOpSdC2/l5NqQptxwpvsJ+ajCwX2LQJojFdiQ1+UNLaGtZndFC7I
         V12BU6HIvOLjqpV8hx7ySoOf5Ioww+1mh/m3bxZkZXKyKorAsjOWW6eGFYg0SqqXhDY6
         eUFQ==
X-Gm-Message-State: AFqh2kquth1NnXyecyOKx5lUQC7kJ4+ncCqc2YnlvlfYC0DP+dvWXCXB
        CCj8uqI48ib1DKcmuO11Oy/83l8Ne3JHorG0QaI=
X-Google-Smtp-Source: AMrXdXt3qASk7D+BiElA55plLkckN4JexTQ7PzPf7I7GKu7MdDy46RF9PgB/ua7eYhH8Y0HksKe8Og==
X-Received: by 2002:a17:907:6f17:b0:7c1:5019:50c6 with SMTP id sy23-20020a1709076f1700b007c1501950c6mr7293358ejc.72.1671735209450;
        Thu, 22 Dec 2022 10:53:29 -0800 (PST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id p10-20020a170906614a00b007812ba2a360sm525608ejl.149.2022.12.22.10.53.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 10:53:28 -0800 (PST)
Received: by mail-wm1-f44.google.com with SMTP id i82-20020a1c3b55000000b003d1e906ca23so1871794wma.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 10:53:27 -0800 (PST)
X-Received: by 2002:a05:600c:4aa8:b0:3d0:69f4:d3d0 with SMTP id
 b40-20020a05600c4aa800b003d069f4d3d0mr298494wmp.93.1671735207659; Thu, 22 Dec
 2022 10:53:27 -0800 (PST)
MIME-Version: 1.0
References: <20221222151319.122398-1-krzysztof.kozlowski@linaro.org> <20221222151319.122398-3-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221222151319.122398-3-krzysztof.kozlowski@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 22 Dec 2022 10:53:15 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WWPe9bBP2z6Q3GOaGr-5U9conGq4d8obwVCxQtZ7rAUw@mail.gmail.com>
Message-ID: <CAD=FV=WWPe9bBP2z6Q3GOaGr-5U9conGq4d8obwVCxQtZ7rAUw@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] arm64: dts: qcom: sdm845: align TLMM pin
 configuration with DT schema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Joel Selvaraj <joelselvaraj.oss@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Caleb Connolly <caleb@connolly.tech>,
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

On Thu, Dec 22, 2022 at 7:13 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> DT schema expects TLMM pin configuration nodes to be named with
> '-state' suffix and their optional children with '-pins' suffix.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> Cc: Doug Anderson <dianders@chromium.org>
>
> Tested on Qualcomm RB3. Please kndly test a bit more on other devices.
> This should not have an functional impact.
>
> Changes since v3:
> 1. db845c: drop qup_uart3_default override and use qup_uart3_4pin
>    (Doug).
>
> Changes since v2:
> 1. Bring back UART6 4-pin bias/drive strength to DTSI.
>
> Changes since v1:
> 1. Address comments and implement conclusion with Doug.  Drop
>    default-pins/pinmux/mux/config nodes but instead add subnodes for
>    specific pins for UARTs.  This should match approach used for SC7180.
>
> v1: https://lore.kernel.org/linux-kernel/1b9dcca8-1abd-99a3-da12-a8763bf77f12@linaro.org/
> ---
>  arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi    | 397 ++++------
>  arch/arm64/boot/dts/qcom/sdm845-db845c.dts    |  93 +--
>  .../arm64/boot/dts/qcom/sdm845-lg-common.dtsi |  60 +-
>  arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts |   2 +-
>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts       |  77 +-
>  .../boot/dts/qcom/sdm845-oneplus-common.dtsi  | 101 +--
>  .../boot/dts/qcom/sdm845-shift-axolotl.dts    | 150 ++--
>  .../dts/qcom/sdm845-sony-xperia-tama.dtsi     |   6 +-
>  .../qcom/sdm845-xiaomi-beryllium-common.dtsi  |  12 +-
>  .../boot/dts/qcom/sdm845-xiaomi-polaris.dts   |  21 +-
>  arch/arm64/boot/dts/qcom/sdm845.dtsi          | 689 ++++++++----------
>  .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts |  53 +-
>  .../boot/dts/qcom/sdm850-samsung-w737.dts     | 121 +--
>  13 files changed, 701 insertions(+), 1081 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
