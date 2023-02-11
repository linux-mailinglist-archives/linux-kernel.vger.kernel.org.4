Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFE1693127
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 13:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjBKM6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 07:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjBKM6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 07:58:54 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE911A48F
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 04:58:52 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-52bed2ce9bdso104225977b3.13
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 04:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7oxEd1K/3tH5d1vSYLhdbwVCPjkzBT7bQLdYVnXoZaA=;
        b=cBg27ycOOJeuWuoAVI1AJJzur8NoIRr6UwCnVVlmgeptv+Qv3TEv/fKqIBSqtgs04O
         MWHfhHp4h4F3EHjwpHG1d0qNc76RES8Nkqu22ZvdBTzWbDMK2l04Xfd+GvUhic6l/rGv
         PWNTwtiZLEtRIzLrUSR3NGMfvxQCTJU/k2htKE2afrt72+g77MemVbmfR1HSZlhwzjPN
         RXVujJr4ihmBRQqN3glS0Sztj+mL5lYEKQWGbdPjl9Y7aTi8mfC1hS/rIShKrHKDFwI6
         +Fh+0iNrBiGHfKpubSTo9Wifa/q0RMwL0UPM3L/hb/KHAMifn3YlsTyGsEZYH0dqDf/G
         ENFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7oxEd1K/3tH5d1vSYLhdbwVCPjkzBT7bQLdYVnXoZaA=;
        b=QUrXqsBfW49LJEDVltmfHn5u+6Tf91STqjyudsxckWs3OOAK2IXdnJqroEzwYcBqi1
         7J6iFk+JaW7uJfZELkGxcNpGX7KbXIC4rCYGca5N6s+gmQXsPwDGJtOFrAz9bz23LFv3
         qA+rG9ZmTs4A4rGtJOffLNX6tZjdxGeStElmDdVlfjwbSYHBAM7AtjhJgn+cEvLedwvc
         Hce6F9Y5pXr8wQWepOjtDcy/cZeC3/7rp6QkyI47ds8TJbFVxFpJK0mL59GBMsmt52PF
         WUJhg+yARLaSua2sueMWe7pESBOcewRJeh7xp5lXyJYlhLrwOOStLQzR8r+36fG0mtn2
         /G8A==
X-Gm-Message-State: AO0yUKWtQPfQbq4ayEmtewi/hAXtyM+rWUKRR+izBHT5djD/3Vb9xkwK
        StLQTOCMLZFZ9082ienpzDf0PLqOTZtuX14KIOigwA==
X-Google-Smtp-Source: AK7set9yACRtdjGaGofhNB7gIyufNGuFMD4TJQRcDQBFzwgflNqKCO+F2eG8HZZXxgxpcL+efHGFEgZ9hlWpxj5dToU=
X-Received: by 2002:a81:71c5:0:b0:527:3e8:5a94 with SMTP id
 m188-20020a8171c5000000b0052703e85a94mr1761151ywc.68.1676120331277; Sat, 11
 Feb 2023 04:58:51 -0800 (PST)
MIME-Version: 1.0
References: <20230206-topic-sm8450-upstream-dp-controller-v3-0-636ef9e99932@linaro.org>
 <20230206-topic-sm8450-upstream-dp-controller-v3-1-636ef9e99932@linaro.org>
 <226aeac5-d1b1-2a99-5c17-c26a8458c5ea@linaro.org> <b16921bb-409e-3591-d5fb-69212ef4e192@linaro.org>
 <bde0a2fd-b1e4-61bd-2cca-a1d1c60570bd@linaro.org>
In-Reply-To: <bde0a2fd-b1e4-61bd-2cca-a1d1c60570bd@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 11 Feb 2023 14:58:40 +0200
Message-ID: <CAA8EJpo3HbuxeJjdWimwHwKwTsPnzKvm20yQE-8no4A3AqcmHg@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] dt-bindings: display: msm: dp-controller: document
 SM8450 compatible
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     neil.armstrong@linaro.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 11 Feb 2023 at 13:38, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 10/02/2023 16:27, Neil Armstrong wrote:
> > On 10/02/2023 16:16, Dmitry Baryshkov wrote:
> >> On 10/02/2023 16:44, Neil Armstrong wrote:
> >>> The SM8450 & SM350 shares the same DT TX IP version, use the
> >>> SM8350 compatible as fallback for SM8450.
> >>>
> >>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> >>> ---
> >>>   .../bindings/display/msm/dp-controller.yaml        | 25 +++++++++++=
++---------
> >>>   1 file changed, 15 insertions(+), 10 deletions(-)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/display/msm/dp-control=
ler.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> >>> index 0e8d8df686dc..f0c2237d5f82 100644
> >>> --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yam=
l
> >>> +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yam=
l
> >>> @@ -15,16 +15,21 @@ description: |
> >>>   properties:
> >>>     compatible:
> >>> -    enum:
> >>> -      - qcom,sc7180-dp
> >>> -      - qcom,sc7280-dp
> >>> -      - qcom,sc7280-edp
> >>> -      - qcom,sc8180x-dp
> >>> -      - qcom,sc8180x-edp
> >>> -      - qcom,sc8280xp-dp
> >>> -      - qcom,sc8280xp-edp
> >>> -      - qcom,sdm845-dp
> >>> -      - qcom,sm8350-dp
> >>> +    oneOf:
> >>> +      - enum:
> >>> +          - qcom,sc7180-dp
> >>> +          - qcom,sc7280-dp
> >>> +          - qcom,sc7280-edp
> >>> +          - qcom,sc8180x-dp
> >>> +          - qcom,sc8180x-edp
> >>> +          - qcom,sc8280xp-dp
> >>> +          - qcom,sc8280xp-edp
> >>> +          - qcom,sdm845-dp
> >>> +          - qcom,sm8350-dp
> >>> +      - items:
> >>> +          - enum:
> >>> +              - qcom,sm8450-dp
> >>> +          - const: qcom,sm8350-dp
> >>
> >> Neil, Krzysztof, I'm not convinced that this is worth all the troubles=
. I think it would be easier to have a flat list of compatibles and handle =
all the differences inside the driver. For example, for sdm845 we simply re=
used sc7180 config internally, while keeping separate compatible strings.
> >
> > Sure, but the doc reports the SM8350, SM8450 and SM550 has the exact sa=
me IP version, isn't fallback for that cat ?
>
> Exactly.
>
> What's the trouble with the list Neil created?

No troubles. I felt that it fell out of the line, but no other issues.


--=20
With best wishes
Dmitry
