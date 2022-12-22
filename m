Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F1465462F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 19:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235577AbiLVSxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 13:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235510AbiLVSx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 13:53:28 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BCA2EFBC
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 10:52:33 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id e13so4166315edj.7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 10:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wv5r7o6DzTqSnIpCAKgG7SesTpoF9G2sHu8yiB5cAqQ=;
        b=mSfrS/J8VO5tRvI4ypr7qpNfnF83I4UW4EOsuJRte7oJb3nlCbheVYTcvXQaLYQY/D
         mZ3a1yMbIuPZpRRD+rZIyshMQj/e5SwoAOSeLTBjeW0K/mmPSjCm78S6ZU4DiydPBtUa
         f5cuFbWVbca71QSlKUVjm57bFQnNbBgicqmHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wv5r7o6DzTqSnIpCAKgG7SesTpoF9G2sHu8yiB5cAqQ=;
        b=SxBGxa+EhKzY/I4yK9t8PH1E6LTZopcpVKY8YAtPxyyuN9do/451+WdO4woba2V1PU
         84UnvLMSXGo5937m+B2hEvPn2H/PVHa/2YUywMmjNV9/BvrfiojL6P7Soz5uTkxqB6Ek
         1ugsb5eeY2iIqf2AvN2VM+K2cFDWwoiUmTDToJL4zrBH646kA/yszU9BDD8H0yNZWKAP
         BEGBYEkuQqUEclVAaQU93zCmhxWM9ujUVE0wzkSkWTl+Rfa3I499VkVthXFtrI5u4F/U
         UruDUuXT8xBcWCyxVwTf2C4aprtZPDFC5GwtZPh2Mh9nZEb5xcAbjJbyO3XXv7p0cPDW
         6JSw==
X-Gm-Message-State: AFqh2kp8Gx961U7NrqGWGCsN+rSPjN0xdnl8avZRc3Lwdq9iOCJRI2lm
        anJDuCRspOqy2oJyBZlEvo3rlV8WYPEZzow8RWo=
X-Google-Smtp-Source: AMrXdXtsZdhdoRdn8MVgIR24LOQexCRZcwfJ3VXoNu5hJGlTk/+GFo4bMqojq9F7PbsmMjQ5ArCTYg==
X-Received: by 2002:a05:6402:1f09:b0:478:8375:5dd5 with SMTP id b9-20020a0564021f0900b0047883755dd5mr5470202edb.24.1671735151166;
        Thu, 22 Dec 2022 10:52:31 -0800 (PST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id j18-20020aa7c412000000b0046bc2f432dasm651158edq.22.2022.12.22.10.52.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 10:52:30 -0800 (PST)
Received: by mail-wr1-f52.google.com with SMTP id h16so2528819wrz.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 10:52:29 -0800 (PST)
X-Received: by 2002:a5d:6449:0:b0:242:1f80:6cd9 with SMTP id
 d9-20020a5d6449000000b002421f806cd9mr273405wrw.405.1671735148968; Thu, 22 Dec
 2022 10:52:28 -0800 (PST)
MIME-Version: 1.0
References: <20221222151319.122398-1-krzysztof.kozlowski@linaro.org> <20221222151319.122398-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221222151319.122398-2-krzysztof.kozlowski@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 22 Dec 2022 10:52:16 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XsDznyCcrv=DKt6DyPHRg7uJUa6GF-A8h3hRa6cAwa-A@mail.gmail.com>
Message-ID: <CAD=FV=XsDznyCcrv=DKt6DyPHRg7uJUa6GF-A8h3hRa6cAwa-A@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] arm64: dts: qcom: sdm845-xiaomi-beryllium: fix
 audio codec interrupt pin name
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
> The pin config entry should have a string, not number, for the GPIO used
> as WCD9340 audio codec interrupt.
>
> Fixes: dd6459a0890a ("arm64: dts: qcom: split beryllium dts into common dtsi and tianma dts")
> Reported-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> Cc: Doug Anderson <dianders@chromium.org>
>
> Changes since v3:
> 1. New patch.
> ---
>  arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
