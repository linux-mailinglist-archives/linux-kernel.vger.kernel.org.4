Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6186DB082
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 18:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjDGQXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 12:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjDGQXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 12:23:46 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CABFA5CE
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 09:23:35 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5416698e889so804540517b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 09:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680884612; x=1683476612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJp208lv00D7h0nGYhObPES5W3aLK5inh/QuulhqHSo=;
        b=KXPuCrN3qLP37oQZUwnZxQOZPjSl+xxbylG99+fKTPfzq8gttzLYI5jQf22Mw2pOov
         msF+fYDPzT8t7wb0QWJ2ZouTYa12ObSBlCe3ZRYZ6okMySB28pU9Eyxk5utTnSxFKWKu
         18diuatyF99IRcFaSUxw7I32VSyCkgIXxfM6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680884612; x=1683476612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJp208lv00D7h0nGYhObPES5W3aLK5inh/QuulhqHSo=;
        b=MuQkgk5rLMx3vM8NXG8HVGaXG5hQoFnt1xvxgm2CqFSpH8LxDKO3sIEs0cmHpkFGO1
         5dLdUBtfIO2KrGM+wtFXSh+GkhIGndZmd+mFfm8MgFsH2YsVmMmkYZnwNJiNBq4QL1zI
         xNqusb9J1KfLbWOh2ar6WFiniPQZKWFzbT2tQRAaca7juRHG+hoMaPv1Yd4ercexr25y
         0xJAcCpjx2/mc/wRcJoxsjjzz32FoHeVDHIDRUyE/tdyLT8jG6GtVd+SjH1Avab252PI
         OgbwPqyhi41DfRdT5NyqUOphEW3LjbEy7otzfHld7Bs9Gha+rsyVb3c1uTeoho3JM2Tk
         IHpA==
X-Gm-Message-State: AAQBX9cE7vrODtqPpiwhNd/CdXDUYUfjEv4ZEShCagDBxmn2TcAqbxmY
        kUBjRVQz5k7pEu3Tf49PULgBG0cYHWqHt/ptb4A=
X-Google-Smtp-Source: AKy350bM+yxqKXW0r6DA0qhpfLedtwtaUpgqG7DHKQA7NFE8OcHakLWaJlAL0TFAvBBqZjPL3kNTPQ==
X-Received: by 2002:a0d:ef07:0:b0:540:cb3f:b34a with SMTP id y7-20020a0def07000000b00540cb3fb34amr2563014ywe.32.1680884612695;
        Fri, 07 Apr 2023 09:23:32 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id bg27-20020a05690c031b00b005460251b0d9sm865184ywb.82.2023.04.07.09.23.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 09:23:31 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-54c0dd7e2f3so97817767b3.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 09:23:30 -0700 (PDT)
X-Received: by 2002:a05:690c:1:b0:544:bbd2:74be with SMTP id
 bc1-20020a05690c000100b00544bbd274bemr1783389ywb.4.1680884610543; Fri, 07 Apr
 2023 09:23:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230407151423.59993-1-nikita@trvn.ru> <20230407151423.59993-4-nikita@trvn.ru>
In-Reply-To: <20230407151423.59993-4-nikita@trvn.ru>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 7 Apr 2023 09:23:18 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VQKS1J42qx-Zk9JKwRUeX1evQjZzs_RMAMFby-gaNDXw@mail.gmail.com>
Message-ID: <CAD=FV=VQKS1J42qx-Zk9JKwRUeX1evQjZzs_RMAMFby-gaNDXw@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] dt-bindings: arm: qcom: Add Acer Aspire 1
To:     Nikita Travkin <nikita@trvn.ru>
Cc:     agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org,
        quic_srivasam@quicinc.com, judyhsiao@chromium.org,
        mka@chromium.org, cros-qcom-dts-watchers@chromium.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Apr 7, 2023 at 8:14=E2=80=AFAM Nikita Travkin <nikita@trvn.ru> wrot=
e:
>
> Acer Aspire 1 is a laptop based on sc7180. Document it's compatible.
>
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> Changes in v2:
>  - Merge with IDP (Krzysztof)
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentat=
ion/devicetree/bindings/arm/qcom.yaml
> index f8d29b65f28b..db97a61e8ccb 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -367,9 +367,9 @@ properties:
>                - qcom,qru1000-idp
>            - const: qcom,qru1000
>
> -      - description: Qualcomm Technologies, Inc. SC7180 IDP
> -        items:
> +      - items:
>            - enum:
> +              - acer,aspire1
>                - qcom,sc7180-idp
>            - const: qcom,sc7180

If Krzysztof is happy then I have no real objections here. That being
said, I personally would have updated the description to be more
generic and not say "IDP" anymore. Something like "Non-Chromebook
sc7180 boards".


-Doug
