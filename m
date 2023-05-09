Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30DC6FC77E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 15:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235263AbjEINIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 09:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235365AbjEINIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 09:08:07 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA2E30DE
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 06:08:05 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-ba5ebdc4156so849209276.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 06:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683637684; x=1686229684;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=alSD/LYUTqJfX0eULQ7Dos6x9QJDjuDbku/vaMMg2mM=;
        b=eSRY/H9cGw+xOv99Rkt9fVU+GIk/nTmztiI7WoSbsTTf/eDvBNBdRblaLuHP9Dumis
         CnqmkXrk83jWJIezxiE3JuCtLIokdpZnOdKkqTsCDSFr/huG19nMF7ZqCW2UIS3F7Ejy
         Fq9cpUtgkD6BJnLlFt6aCCM0ik1dikFPhdzOnsixORrJsEyUqewgnoyy51Pa1A3UXggW
         9EVrEJHHBIXbp0A5YLcOQcb7Vnnzgmx9U7uPTAPZbCUVLT51BTvRRll2zJ7n/gEBP3go
         MxNccG06M8zNnVZfqVyzOr6J7+TJQASrDX6ZsO3lJT4yhvtcqKaENJq7ozY+w1URHyf2
         RRGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683637684; x=1686229684;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=alSD/LYUTqJfX0eULQ7Dos6x9QJDjuDbku/vaMMg2mM=;
        b=QS4gcz5S+mvp3RZBCcQqPR4lnxzUWtpE4YAZSFoRwzVYn06qwELgFCOmnRmQKWUJII
         4i8EOfRGjRqLhofQQ9qzAi4dPPl8sQlW6Hr7Z9ipmohtW67V2rn8why6kM4aEjDq9do2
         0p6nNXFmkQ6Hl3AT0zeSZGXn2V/CqNsy086A8GIoo83uih7TupDy5zql2tiUK09NC/Te
         R0kIGz9adWxkuzR8UdhIiE2i0amwVRROA+RzCRXwf9oEaWA+6QwGcE/VpAOvA/tckjP4
         1QE8OUaPIrFv2btRdgfhND6S4Rkz0Qd1mcKfsiENrg1kTMgvxKouuQHNtctRQVbKq2kv
         X64g==
X-Gm-Message-State: AC+VfDzcyxy+FL3gAmIbVYV8lVHBXFskaC5/0//buHVoV2xG/ztbEoGp
        EyydQ942P6KiJ1vfcffNQXMsuIcQYN0zf0LdCl0qnw==
X-Google-Smtp-Source: ACHHUZ7eHh7oUs55p4PsRymZEwkOfiBBPgxu/ifd0C50xzBovPjQu9PPhdwLcNa1wVqEsXJ8GAAB1RYUv4jPFo6R1HI=
X-Received: by 2002:a25:6943:0:b0:b9d:853e:5cef with SMTP id
 e64-20020a256943000000b00b9d853e5cefmr17476795ybc.37.1683637684177; Tue, 09
 May 2023 06:08:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1683630932.git.quic_varada@quicinc.com> <1691872a83758cb65053dce7001e96e88dbeed2a.1683630932.git.quic_varada@quicinc.com>
In-Reply-To: <1691872a83758cb65053dce7001e96e88dbeed2a.1683630932.git.quic_varada@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 9 May 2023 16:07:53 +0300
Message-ID: <CAA8EJppDtY=Q5oOvXG+pE_+KAk59TPauabUav1f0=eggmLULYA@mail.gmail.com>
Subject: Re: [PATCH v11 9/9] arm64: dts: qcom: ipq9574: Enable USB
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, mturquette@baylibre.com,
        sboyd@kernel.org, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 May 2023 at 14:56, Varadarajan Narayanan
<quic_varada@quicinc.com> wrote:
>
> Turn on USB related nodes
> Provide vdd info
>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  Changes in v11:
>         - Rename dwc_0 -> usb_0_dwc3
>         - Maintain sorted order for the usb nodes
>
>  Changes in v10:
>         - Provide vdd info
>
>  Changes in v5:
>         - Move "host" mode specification to board dts
>         - Due to dependency with earlier patches board dts
>           filename changed ipq9574-al02-c7.dts -> ipq9574-rdp433.dts
>
>  Changes in v2:
>         - Fix node placement and coding style
>         - "ok" -> "okay"
> ---
>  arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
