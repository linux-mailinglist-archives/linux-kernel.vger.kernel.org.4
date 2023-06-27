Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8268873FE75
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 16:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbjF0OkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 10:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbjF0Oj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 10:39:59 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2513AA8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 07:39:23 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6687446eaccso4206662b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 07:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687876760; x=1690468760;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4nJWDV0jywhxf0OMEHmO3nQx+Dc6iDsFe4yCSR+nmZo=;
        b=kdgHbqxy6l7gE3SPWR0nWqtUAV597wHSuY6o8Fl9p27nal0aM6gMTEz7xLENW+Jws1
         hlOTruXn7Hs+MgPpcR/2juT+bELpD8YS1/5TYD/dLrGMaxIXqiAVmRvDrhs1xlHx2gCZ
         3trw24snpKKKFkqDv3nqUZvIlDAwhJKH7s5PaNzGxfmYwx/YvwjUHMearGW6Al66I0Fs
         DHUyBty4p/VQVOaVpsMCyxEQvcaYpZk8ySM3DKXyDfV2UKjXmUesPxAY9/anaWKYu264
         VqJWhFlMhXMdu9SaoisStiOEt0WEI+99CfhgAKs+fl16xhhX3bbp+O8UPpT9B6jN0NC0
         kd6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687876760; x=1690468760;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4nJWDV0jywhxf0OMEHmO3nQx+Dc6iDsFe4yCSR+nmZo=;
        b=YltX+hWbI1ztCNC5fsxn69czrj09oohbwZwhMYLCRCxZTC9TeM3z09PUOkY6IwC+kT
         R2uRzyPm0pRKZWglHG5RWXjVnwoWgbMTHCg0NReF5t2Vz61CPJZTlqpAntSF7QUVu4Hp
         j6PfQD9adTIH5wP208biNeU8ha7x0xJyzIndcLRYZatm78wDe5BlkM6jLuzyc0ZQJdVy
         JBsq0x+q0o2mAB7MGTUE0mABjMy3psgskKHwHHvyAWtqXzk1VYGE/MdJZzGECRePNRf2
         /xoWDoaxGO8qmLyoKisESCWf1TESVE/zqY6tDy13aT8Hc48tOuCM8P9ij23G00MkrdeM
         FHnA==
X-Gm-Message-State: AC+VfDxN0/Je3YtMRoMNwh527F9Bc2iL9GjFCX+JyN585f0qnP02J01G
        8TX5pm09x03FsejTv7EYamaP
X-Google-Smtp-Source: ACHHUZ5q4MSqBMad/7CU3n0bTQr5IyeSnkozHYAD/trBnbhPd2KNQd92dY2h/ORvdIT1OeC1SxnDzw==
X-Received: by 2002:a05:6a20:549a:b0:123:2c2a:ee62 with SMTP id i26-20020a056a20549a00b001232c2aee62mr22355330pzk.14.1687876760443;
        Tue, 27 Jun 2023 07:39:20 -0700 (PDT)
Received: from thinkpad ([117.217.176.90])
        by smtp.gmail.com with ESMTPSA id o6-20020a63e346000000b00553b9e0510esm5820482pgj.60.2023.06.27.07.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 07:39:20 -0700 (PDT)
Date:   Tue, 27 Jun 2023 20:09:12 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        krzysztof.kozlowski@linaro.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 2/3] arm: dts: qcom: sdx65: Add interconnect path
Message-ID: <20230627143912.GG5490@thinkpad>
References: <1687827692-6181-1-git-send-email-quic_krichai@quicinc.com>
 <1687827692-6181-3-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1687827692-6181-3-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 06:31:30AM +0530, Krishna chaitanya chundru wrote:
> Add pcie-mem interconnect path to sdx65 target.
> 

"target" is meaningless in upstream. Call it "SoC or platform".

Also the subject should mention PCIe interconnect.

> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>

With both changes above,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  arch/arm/boot/dts/qcom/qcom-sdx65.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
> index 1a35830..77fa97c 100644
> --- a/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
> +++ b/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
> @@ -332,6 +332,9 @@
>  				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names = "global", "doorbell";
>  
> +			interconnects = <&system_noc MASTER_PCIE_0 &mc_virt SLAVE_EBI1>;
> +			interconnect-names = "pcie-mem";
> +
>  			resets = <&gcc GCC_PCIE_BCR>;
>  			reset-names = "core";
>  
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
