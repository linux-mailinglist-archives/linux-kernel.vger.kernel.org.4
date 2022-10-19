Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8524D604C42
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbiJSPxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbiJSPw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:52:59 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBCE10253C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 08:49:55 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id 13so40881045ejn.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 08:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GYZSbQZP6Xh4e4kFk7TUEEgkZvZ475vyRePbBKOiGu4=;
        b=VmvNLbu6AaNr25QIZqpnPieIkLgzWqhpfhsSj1S4bSEMKws3PWsuB3ORl1S0qUY/zX
         uaGp4SwY4L27LJ5A/6B59RK6hnxpjt4dfu6oxy9X+7+eDAa8XX3fnpU+x3KzAEeJ74It
         HZ+aU/PotiS94Pvu5mCCWKXWZd1BqnBnjD6xM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GYZSbQZP6Xh4e4kFk7TUEEgkZvZ475vyRePbBKOiGu4=;
        b=EGHK0Sdgc9NxKtg2T372oG7S0rhG7F+6v36rIHN/+92ou1eZZdXL4XEn9J0sx86wWs
         paQ7fMKURpPWNTPC7xztYt+YU3JdUDqhaRwu+7Oly/twXJTDsQ6x2csq7avtzn7dJvD2
         Em6XTfY54HS34sUDUXZreb4z79vshw99aTs8tkTQsRThmyFH0XUAv7PoR+bjn5V/MS4e
         JrShqQJyP5bOuncfgMTLjeXiQilADm4HS0PV66V11SvUfRRW3OSPEROGG8EkIytGKLCc
         ZAmXvqTG+n+QqomyGX105SY7zV83bdQzI5/WfDPDIGGjXwc4W7z1fmX8gSLP41oDWS8O
         4wrA==
X-Gm-Message-State: ACrzQf1iCZFZ0/2lvL5VFgWzqbChHarmi6PJuhd5ef2fLo3qOZmnJeeK
        xGVZGFRMnHG/BSTgSvqV/9M24CG+ijqOOS3w
X-Google-Smtp-Source: AMsMyM6bS+J6vm04K06GWFDYdE9zHR4sdi6SuUJfKk3vGRI281JpbV0WnIz1+GKnFSCNDmUa606vJw==
X-Received: by 2002:a17:906:db05:b0:741:5730:270e with SMTP id xj5-20020a170906db0500b007415730270emr7048965ejb.609.1666194506690;
        Wed, 19 Oct 2022 08:48:26 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id k10-20020a170906578a00b007306a4ecc9dsm9235503ejq.18.2022.10.19.08.48.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 08:48:25 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id w18so29816780wro.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 08:48:25 -0700 (PDT)
X-Received: by 2002:adf:9d8a:0:b0:230:5212:d358 with SMTP id
 p10-20020adf9d8a000000b002305212d358mr5692508wre.405.1666194505138; Wed, 19
 Oct 2022 08:48:25 -0700 (PDT)
MIME-Version: 1.0
References: <20221019001351.1630089-1-krzysztof.kozlowski@linaro.org> <20221019001351.1630089-5-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221019001351.1630089-5-krzysztof.kozlowski@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 19 Oct 2022 08:48:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U0WR-a7d4p5eoCFMRer5yhX8AcEPdUaJag4KpGB9kp+A@mail.gmail.com>
Message-ID: <CAD=FV=U0WR-a7d4p5eoCFMRer5yhX8AcEPdUaJag4KpGB9kp+A@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] dt-bindings: pinctrl: qcom,sc7180: convert to dtschema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 18, 2022 at 5:14 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Convert Qualcomm SC7180 pin controller bindings to DT schema.  Keep the
> parsing of pin configuration subnodes consistent with other Qualcomm
> schemas (children named with '-state' suffix, their children with
> '-pins').
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
>
> ---
>
> Changes since v2:
> 1. Drop entire drive-strength (not needed, brought by common TLMM
>    schema).
>
> Changes since v1:
> 1. Drop default:2 for drive strength
> 2. Add Rb tag.
>
> Cc: Doug Anderson <dianders@chromium.org>
> ---
>  .../bindings/pinctrl/qcom,sc7180-pinctrl.txt  | 187 ------------------
>  .../bindings/pinctrl/qcom,sc7180-pinctrl.yaml | 158 +++++++++++++++
>  2 files changed, 158 insertions(+), 187 deletions(-)

Looks great now.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Will you also send out separate patches to fix up the "drive strength"
for all the other Qualcomm boards. They all have the same problem. The
drive strength never defaults to 2 and always gets left at whatever
the BIOS leaves it at unless it's specified.
