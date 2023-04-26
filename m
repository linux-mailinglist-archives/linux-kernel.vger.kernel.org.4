Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2D36EF65C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 16:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241354AbjDZO0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 10:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240010AbjDZO0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 10:26:03 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504054219
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 07:26:02 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-2fa36231b1cso4471579f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 07:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682519161; x=1685111161;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OfmaskdBjQn3V5pOU3nprV90+II0lcnGqRpRtitTHfw=;
        b=ejTmsmGfYQfwJCYh6kZezZgGeKRbb0HzEjKYT/IboF11o/HdoNgxLOpZAZsrm2vC8i
         ia7HvN71f04tSXEL5MQS74Sj/NqB3UZVN+My+uY8NpNR/2NNeFyWPchfQsGGPM0q0buZ
         PVkLzJMvIyL1wg7fKdzDsyuBvSiH+/DkkcLbpEIlAjDxQ8roicZVcMkrcN6FQjge62Zo
         OFkCa2wn8c+SIBktB+C5PVCj2dzNBZBKNQEqz0YBr319hwWwHXOHCLctdzsx4camiqS/
         dZwfnuPLy2GpXpLBsQdyMyOx0dN9Y4lpDqmg/RZG+jjCVPVOaKeRztbWkF/Gai8OskA9
         vKdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682519161; x=1685111161;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OfmaskdBjQn3V5pOU3nprV90+II0lcnGqRpRtitTHfw=;
        b=QUUB0t3xcdsWmdjyNSVfm/p0P8n0ZVl8udJWTN1388N7ynQapJp1YT38X0qvspy1zN
         dRlxTXn5FHWrgghKZ0R7rppD7p871BqpRck9aSyjS3xPaqkyMh4Isxki+9nRiEGW2M07
         4oYyEl79fnV2q5/92MF/tm/gyVm4OY0BLNSMMB6AjLQqih2MuiZ+2FSYyjNFCh79KaeM
         XS8J/DlC1kUjyACpsm4owxpbDqidFeEbnO6Tjq5gdCF4KBxfniOradb0qGdZCTlsmGEP
         p6KITRjtI6XIec0zkCznkk0rJL4MhQNWuUOPjwGV4NhRXc9OKyjjd1k13X3euC48LElm
         nknQ==
X-Gm-Message-State: AAQBX9djZrjL+PWXxPJT1VvIX3LLEZ2wsfu0tYXOjtgHFvyt/kN1Ms/B
        cExwDGkJXDZEy2ey6hxqbRVPgA==
X-Google-Smtp-Source: AKy350azFtxzLU/AHkuy/1AtdTBiM0pSm/amOMmVdp7ABZ+fS+j9uw2EfwnjcnvcZ0si6esLY5S6Ww==
X-Received: by 2002:a5d:6708:0:b0:2f5:8116:6458 with SMTP id o8-20020a5d6708000000b002f581166458mr14728187wru.66.1682519160710;
        Wed, 26 Apr 2023 07:26:00 -0700 (PDT)
Received: from linaro.org ([82.79.186.233])
        by smtp.gmail.com with ESMTPSA id m4-20020adffa04000000b002fe96f0b3acsm15944215wrr.63.2023.04.26.07.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 07:25:59 -0700 (PDT)
Date:   Wed, 26 Apr 2023 17:25:58 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] phy: qcom-qmp-combo: Support orientation switching
Message-ID: <ZEk0dnfoV9IlHlyt@linaro.org>
References: <20230425034010.3789376-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425034010.3789376-1-quic_bjorande@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-04-24 20:40:03, Bjorn Andersson wrote:
> This adds support for USB and DisplayPort orientation switching to the
> QMP combo PHY, as well as updating the sc8280xp devices to include the
> QMP in the SuperSpeed graph.
> 

Tested this entire patchset on my X13s. Therefore:

Tested-by: Abel Vesa <abel.vesa@linaro.org>

> Bjorn Andersson (7):
>   dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp: Add ports and
>     orientation-switch
>   phy: qcom-qmp-combo: Move phy_mutex out of com_init/exit
>   phy: qcom-qmp-combo: Introduce orientation variable
>   phy: qcom-qmp-combo: Introduce orientation switching
>   phy: qcom-qmp-combo: Introduce drm_bridge
>   arm64: dts: qcom: sc8280xp-crd: Add QMP to SuperSpeed graph
>   arm64: dts: qcom: sc8280xp-x13s: Add QMP to SuperSpeed graph
> 
>  .../phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml    |  51 ++++
>  arch/arm64/boot/dts/qcom/sc8280xp-crd.dts     |  28 ++-
>  .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    |  28 ++-
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi        |  34 +++
>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c     | 227 ++++++++++++++----
>  5 files changed, 309 insertions(+), 59 deletions(-)
> 
> -- 
> 2.39.2
> 
