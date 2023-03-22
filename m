Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1873C6C536D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 19:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjCVSPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 14:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjCVSPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 14:15:30 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DFB64241
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 11:15:23 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id m6so12759838qvq.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 11:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679508921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6E9eFLmm6ygcs6kDLNjXTtbQ9rYQAmNSLK7F6Ytjeo=;
        b=m4vSWntEg2ZoxWKxicPTMF/nFx6Xjvf6X97Bazqxn+ZvOrc5xR/nWb1X0yaZXKjnAG
         fbDcYRx6sVzFha5lhgNSyKBQ+jajzSmtjTvh6kQ6Swo5pfAJJs+HBNw47kiOyXIEA0IQ
         XzkxVb/CU2WWreTMWYUUFA6lYn7AwooiD/Iq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679508921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q6E9eFLmm6ygcs6kDLNjXTtbQ9rYQAmNSLK7F6Ytjeo=;
        b=bwpFiOdq5qsHIfNzTPHX1aTkN/SvZI0mor0IcrSrlXCfIpv1AUGxMb868+g0pnoq8l
         XePKbVU8WQQAH31NXnLom4Tiwne37BDhL+55TVd6Aj975Pn8TUQ4s60IUIPX7tbXAQrv
         v1gVejb3QABbzmSKadO9TCG3v/SlekNPOD03bxQv9UvpnP8kV5vvaG79o2Fc6ys8viCJ
         Ut7AsQpBbXIKykNJPWhHTm0EsY0k8OvWI/SzYul2NDy4eF1pQL6vhTI3QyVgj1KGM6wK
         mB3QOgHYMTr537zU7C3b1aVs2oO5A1dVA1TEpSfae8XRAfCxt4+95IvpbHh/HWU6dSPa
         aKqA==
X-Gm-Message-State: AO0yUKXJphLF6vyNu4ZknRColyLQ1SDhNpuuI93+06NVuvbABzTK6Vya
        Oyq8QLH+r+on2/OUR9Y0Ilr0o2sJRWTFVeikWgo=
X-Google-Smtp-Source: AK7set/eDM5A4hTem0yca0THejx8TMaTgafLEqJZRv1Exyutq8+PH+3cqvY5e2CvwANmoNHIbhAb1Q==
X-Received: by 2002:a05:6214:27c9:b0:5ab:e259:b2a9 with SMTP id ge9-20020a05621427c900b005abe259b2a9mr4677147qvb.14.1679508921428;
        Wed, 22 Mar 2023 11:15:21 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id 201-20020a3708d2000000b007456efa7f73sm6987183qki.85.2023.03.22.11.15.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 11:15:20 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id k17so11327740ybm.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 11:15:20 -0700 (PDT)
X-Received: by 2002:a05:6902:124a:b0:b69:fab9:de60 with SMTP id
 t10-20020a056902124a00b00b69fab9de60mr540062ybu.0.1679508920292; Wed, 22 Mar
 2023 11:15:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230217155838.848403-1-krzysztof.kozlowski@linaro.org> <20230217155838.848403-3-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230217155838.848403-3-krzysztof.kozlowski@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 22 Mar 2023 11:15:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X7-abQsE5s6Tbz9B22ZXT_yRFii55cUF2LR81BSVnbVg@mail.gmail.com>
Message-ID: <CAD=FV=X7-abQsE5s6Tbz9B22ZXT_yRFii55cUF2LR81BSVnbVg@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sc7280: align RPMh regulator nodes
 with bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Feb 17, 2023 at 7:58=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Device node names should be generic and bindings expect certain pattern
> for RPMh regulator nodes.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> I was fixing these in other boards, but missed SC7280. Previous
> (applied) set:
> https://lore.kernel.org/r/20230127114347.235963-4-krzysztof.kozlowski@lin=
aro.org
> ---
>  arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts        | 2 +-
>  arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts | 2 +-
>  arch/arm64/boot/dts/qcom/sc7280-idp.dts           | 2 +-
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi          | 4 ++--
>  arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi        | 4 ++--
>  5 files changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
