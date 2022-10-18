Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335C46030A7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 18:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbiJRQSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 12:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbiJRQSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 12:18:15 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CB3BA92D
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 09:18:10 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id w3so9950468qtv.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 09:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mz8n0nULnXUq1UCVs2wcXkpsnocCU9N11569El+Afoc=;
        b=Hc8SCWziT1iXhYnLRoggO4/WW5dX/pI6+yej08xkT1pU8ICLz15uWW/j3uMzp7Qexk
         yvmJqXViTrF76A70E2OF6ElMaKsh5O1a/0VTPWx6xmykoYCJnvuSXtbDv9YXG1dY/aRi
         tFjjlt5Y198P5O/cSHuk9/rvMfvlfQDFtwqh73eR8CH4/5PenN/zutGDo6uzF6fyND5i
         5IMO5k/KESDqCg/lRnxKYwF/FzMa4NhXL24Hrrfkki1syPafI4HuBviePfJ2jIyoeavE
         VOjnTH/yPUmpTuZC18XXYoa6wUg+lmxqyxCHQe2j9TTN9leXsypuTY6GGz8vDOu/5V6H
         hDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mz8n0nULnXUq1UCVs2wcXkpsnocCU9N11569El+Afoc=;
        b=iihhb4pSXTWj512N8FkHXnpvs6w6LcpTZdLw4uppQPWPs5JIk97dxwyDOTu3zCJRrQ
         dSGn3muHMl/EsMhFRs9yqxLXnujjF+cV1zusakUJ415kGY7D4vReW5yfgGck2+RhJnrU
         7Il3mzSacAbq+ch7xD7mVHLCxbJqcvZNk+ETyV53GoSUGzWzyOwvap9kRX0gCjDOQTNM
         GAjWqLePwA/ikVzV40JN8EBHqHQQyWILiplJ/IDrA7EV1PSz0LjwE99vYKU96gnl6H7L
         6lEQyLQ7I02klbo9HNwQtwUv2xA30WbWDiKWu77L8J0ewts6nbR/JDnz4sZebmXEdwEw
         Qdzw==
X-Gm-Message-State: ACrzQf2SGEuqrs/2ECXlbVtgcbpf+Wjn6H8rMWFFMrDzuwsF8l8vpgTw
        yTSbYsESg7SkgcUMKQR+yF+FMA==
X-Google-Smtp-Source: AMsMyM4SMAabsvAM2AilDWSmKwY2QNp2RDPnJHax5dmRLyjFbjRB+jhKlLbGZtBfsLtAiBxfcot96A==
X-Received: by 2002:a05:622a:144e:b0:39c:f9a0:c93b with SMTP id v14-20020a05622a144e00b0039cf9a0c93bmr963165qtx.672.1666109888611;
        Tue, 18 Oct 2022 09:18:08 -0700 (PDT)
Received: from krzk-bin.MSRM (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id r28-20020ae9d61c000000b006ed30a8fb21sm2636342qkk.76.2022.10.18.09.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 09:18:07 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/33] pinctrl/arm64: qcom: continued - fix Qualcomm TLMM pinctrl schema warnings (5th set)
Date:   Tue, 18 Oct 2022 12:18:03 -0400
Message-Id: <166610987889.55974.15245001765390019579.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221017230012.47878-1-krzysztof.kozlowski@linaro.org>
References: <20221017230012.47878-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Oct 2022 18:59:39 -0400, Krzysztof Kozlowski wrote:
> Patches are organized not by file, but rather type of change
> 1. First patches is for common TLMM schema and dropping unneeded refs.
> 2. Last patches are pure cleanups without functional impact.
> 
> Changes since v2
> ================
> 1. Patch #6 "dt-bindings: pinctrl: qcom,sm6115: use common TLMM schema":
>    Drop drive-strength.
> 2. Move "qcom,sc7280: drop checks used in common TLMM" to previous series
>    (patchset #4 from list below).
> 
> [...]

Applied, thanks!

[01/33] dt-bindings: pinctrl: qcom,mdm9607: drop ref to pinctrl.yaml
        https://git.kernel.org/krzk/linux-dt/c/e04f0761325a1d9abbf5b91ae7fd5decac489d5f
[02/33] dt-bindings: pinctrl: qcom,sc8180x: drop ref to pinctrl.yaml
        https://git.kernel.org/krzk/linux-dt/c/251446a3b032a95512facd97e5f0d5588757f0de
[03/33] dt-bindings: pinctrl: qcom,sc8180x: drop checks used in common TLMM
        https://git.kernel.org/krzk/linux-dt/c/776b76e048cc2a4d21bb209d0c3e4eb63efbaac9
[04/33] dt-bindings: pinctrl: qcom,sc8280xp: drop checks used in common TLMM
        https://git.kernel.org/krzk/linux-dt/c/4412a0e5ed7aaa81d2c25010f06b4ebb84b95f69
[05/33] dt-bindings: pinctrl: qcom,sm6115: use common TLMM schema
        https://git.kernel.org/krzk/linux-dt/c/3c84d8c243b84dc49bba365cd5d2d7f63c8cf38c
[06/33] dt-bindings: pinctrl: qcom,sm6125: drop checks used in common TLMM
        https://git.kernel.org/krzk/linux-dt/c/423e46e66010849e9c817960b24493948885d623
[07/33] dt-bindings: pinctrl: qcom,sm6125: drop ref to pinctrl.yaml
        https://git.kernel.org/krzk/linux-dt/c/58d4fe9ca487bad0f3d2695f3052e9b0f4fe4dd0
[08/33] dt-bindings: pinctrl: qcom,sm6350: drop ref to pinctrl.yaml
        https://git.kernel.org/krzk/linux-dt/c/661a3fb1f02edd0a1e36e85fc6546810623eb22b
[09/33] dt-bindings: pinctrl: qcom,sm6350: drop checks used in common TLMM
        https://git.kernel.org/krzk/linux-dt/c/4d947acc060cf8b11a174b11e38dfaa51d00d9cd
[10/33] dt-bindings: pinctrl: qcom,sm6375-tlmm: drop ref to pinctrl.yaml
        https://git.kernel.org/krzk/linux-dt/c/8870dce580cbc6d813de139d3f13ea332a71f30f
[11/33] dt-bindings: pinctrl: qcom,sm6375-tlmm: drop checks used in common TLMM
        https://git.kernel.org/krzk/linux-dt/c/b71b285a0fe760f550bc81f070acaecef0556277
[12/33] dt-bindings: pinctrl: qcom,sm8250: use common TLMM schema
        https://git.kernel.org/krzk/linux-dt/c/b8d64ea6520cf835940958004f1c7e30af733b29
[13/33] dt-bindings: pinctrl: qcom,sm8350: drop ref to pinctrl.yaml
        https://git.kernel.org/krzk/linux-dt/c/c915a9ef30068bee41411cf7fdfb98df213ec18f
[14/33] dt-bindings: pinctrl: qcom,sm8350: drop checks used in common TLMM
        https://git.kernel.org/krzk/linux-dt/c/e10be82893354ec5e35ee40d2cf7a68c8f423023
[15/33] dt-bindings: pinctrl: qcom,sm8450: drop checks used in common TLMM
        https://git.kernel.org/krzk/linux-dt/c/ca1941f8ed433f4418c811b0d33dcd1b71e7fbdf
[16/33] dt-bindings: pinctrl: qcom,mdm9607-tlmm: minor style cleanups
        https://git.kernel.org/krzk/linux-dt/c/73966aa6adc11dac733088b9ff40935cecaed857
[17/33] dt-bindings: pinctrl: qcom,msm8909-tlmm: minor style cleanups
        https://git.kernel.org/krzk/linux-dt/c/7612c2f17f9ea97f737042aea470eb34677003c4
[18/33] dt-bindings: pinctrl: qcom,qcm2290-tlmm: minor style cleanups
        https://git.kernel.org/krzk/linux-dt/c/a869153b2440dc0cce7dc59ffbfe755624221e1a
[19/33] dt-bindings: pinctrl: qcom,sdx65-tlmm: minor style cleanups
        https://git.kernel.org/krzk/linux-dt/c/222ca103b87737eebf9b1a124b3391a8d3747ba8
[20/33] dt-bindings: pinctrl: qcom,sc8180x-tlmm: minor style cleanups
        https://git.kernel.org/krzk/linux-dt/c/e1a31f9897abea87011338a07d66b3bc7af9bf7a
[21/33] dt-bindings: pinctrl: qcom,sc8280xp-tlmm: minor style cleanups
        https://git.kernel.org/krzk/linux-dt/c/7703f13a83f8c45d571baa8907baf42d84d0643d
[22/33] dt-bindings: pinctrl: qcom,sm6115-tlmm: minor style cleanups
        https://git.kernel.org/krzk/linux-dt/c/a095c7e0f0abc052399064ffa5b84d9ac09d68b9
[23/33] dt-bindings: pinctrl: qcom,sm6125-tlmm: minor style cleanups
        https://git.kernel.org/krzk/linux-dt/c/f8c76af267faf6ba890055f49ae686403f80ba25
[24/33] dt-bindings: pinctrl: qcom,sm6350-tlmm: minor style cleanups
        https://git.kernel.org/krzk/linux-dt/c/cf0a3d3106087689b0722490f152c1a92cbbecb1
[25/33] dt-bindings: pinctrl: qcom,sm6375-tlmm: minor style cleanups
        https://git.kernel.org/krzk/linux-dt/c/fb45ee0a77474b289be8e32750dfa48f1d563a2f
[26/33] dt-bindings: pinctrl: qcom,sm8250: minor style cleanups
        https://git.kernel.org/krzk/linux-dt/c/4a0c5fb38e6f0dc1197c6258143fe5e5401d33ca
[27/33] dt-bindings: pinctrl: qcom,sm8350-tlmm: minor style cleanups
        https://git.kernel.org/krzk/linux-dt/c/16dc56ebb069c5e8c31a0aee7a8a1a36d21eeee8
[28/33] dt-bindings: pinctrl: qcom,sm8450-tlmm: minor style cleanups
        https://git.kernel.org/krzk/linux-dt/c/7ddfbb41820907b6d1d3b52ee506353c4f2d208f
[29/33] dt-bindings: pinctrl: qcom,sc7280-lpass-lpi: minor style cleanups
        https://git.kernel.org/krzk/linux-dt/c/aad11c7938e49282ae34cbf39692abd207800fce
[30/33] dt-bindings: pinctrl: qcom,sc8280xp-lpass-lpi: minor style cleanups
        https://git.kernel.org/krzk/linux-dt/c/e1c3624793397bb97b8bedc67de2a438767337db
[31/33] dt-bindings: pinctrl: qcom,sm8250-lpass-lpi: minor style cleanups
        https://git.kernel.org/krzk/linux-dt/c/2740420374119100b0304e41b1b509528fea27df
[32/33] dt-bindings: pinctrl: qcom,sm8450-lpass-lpi: minor style cleanups
        https://git.kernel.org/krzk/linux-dt/c/fc371f6075cfa4f62496ce03afb8c8dbaac40235
[33/33] dt-bindings: pinctrl: qcom: adjust description
        https://git.kernel.org/krzk/linux-dt/c/09f537065c064826a6a892fa0fdfd6521e5bf82a

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
