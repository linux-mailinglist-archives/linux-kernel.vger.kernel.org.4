Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3AF072145C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 05:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjFDDB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 23:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjFDDBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 23:01:49 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26CF1AD
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 20:01:47 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f505aace48so4585789e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 03 Jun 2023 20:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685847706; x=1688439706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bwdXG6TznS6YsdZeNc+jVXR47t5rcv+aXMQckTFPgWg=;
        b=hUItQ2HUrJfQHD/w1Vh+fWuxshHXW3x8Em4GmH5Hj/N8KfT63vPtQjI8tf9O6P9UcE
         /6UpGrnL4fwsv1NPwcwcuXObDAsdQLktfqm8MIrw0RKDaO3nzKUvjP2HCdk6zUn3ImU9
         oRzqhmL0fTjlpJViDr2L+yRsvw9J54t3OAsc/+8F0auPwjB9uyM0VtZ6osBhN3iwTg8+
         EK9a7pHNVT2B4bbgJBakF5T+0KQsMI1weiKD9y+Ti8gzmub4CnWviO134DpgycJWlR4t
         z8xC++6Af1HU1FgeAgwZHfDmqKAmg69OlbvdeD0d9gR6WIvx/19TWYKaBOgkivbEQJQe
         P6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685847706; x=1688439706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bwdXG6TznS6YsdZeNc+jVXR47t5rcv+aXMQckTFPgWg=;
        b=T+JZm33XvznVnVnpp1ECQblbbVFCi6sCyefApOSM7l0xq4TbXcm56fUZtbAd2x66tt
         JrfjDZ99jbzDf6EneAQ13/ND0nKA/97bDz/QJLiDgTEgYb9q+xqsjEbWfPtqFxB9Ry1a
         xBl3vKlLIZPh5dKvgf8hwt+Ndb6/fXaO6pF3vrISF35nZ82dgRlZIZ7nqBbWWAWxg0Tm
         e+zrUfVULe2+RPNWtL2k95AtAtgfSuUISIQU35aIbuefC0wkKf8GLb/lkO9IZ7y5wXP3
         mmWozOdpToI9W8IGck4J8ee7S1rTgmB2KY7Inng74htJqEHOFpW3XIv2mts/y/lObQ/J
         /mew==
X-Gm-Message-State: AC+VfDxlXjA5OgSIYWtftm16ETv3RQ1vB97Wn/0m0YIzWHHYg/x8Shab
        X4pfnsobVYa8qfj7wvHfVeiBrQ==
X-Google-Smtp-Source: ACHHUZ4eJeV67ZtXqpRqs9jL9lgSaKyZUHm7qTxGW709QMtSD6UlDTJblh8Y+ZXxAsDs0+MaxbcAIw==
X-Received: by 2002:a19:ee13:0:b0:4ed:b329:5d85 with SMTP id g19-20020a19ee13000000b004edb3295d85mr3405592lfb.15.1685847706163;
        Sat, 03 Jun 2023 20:01:46 -0700 (PDT)
Received: from eriador.lan (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id d15-20020ac24c8f000000b004eb4357122bsm653181lfl.259.2023.06.03.20.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jun 2023 20:01:45 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 0/3] arm64: dts: qcom: add DP Controller to SM8550 DTS
Date:   Sun,  4 Jun 2023 06:01:34 +0300
Message-Id: <168584750425.890410.17653839132037298856.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230601-topic-sm8550-upstream-dp-v2-0-e8778109c757@linaro.org>
References: <20230601-topic-sm8550-upstream-dp-v2-0-e8778109c757@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 01 Jun 2023 12:09:46 +0200, Neil Armstrong wrote:
> The DP output is shared with the USB3 SuperSpeed lanes and is
> usually connected to an USB-C port which Altmode is controlled
> by the PMIC Glink infrastructure.
> 
> DT changes tying the DP controller to the USB-C port on the QRD
> board will be sent later.
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: display: msm: dp-controller: document SM8550 compatible
      https://gitlab.freedesktop.org/lumag/msm/-/commit/76015b9e573e

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
