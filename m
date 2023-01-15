Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2F966AF45
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 05:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjAOELX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 23:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjAOELQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 23:11:16 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F17D44BE
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 20:11:15 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id v23so26124557pju.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 20:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TUsBOWy5UhAp6xbtUsJklT0rm4uS/PjlVjvwS2k1vhM=;
        b=Dzk0wkd85xOIYqkdj9F5B3jGt7WyjeYBbeLNDtQxVMited8KnFCsWXXuWfpLk+to4w
         d9OvAObapEUD/jCOC55y56boBHkRR8diez+KxCk5zjS/cGyEX2/LT/auz5Xy7PAyUUcL
         x2TxCsUPTKsv/6Ce/tuxIAb/zYFOjab99D5Cb+/F29xlWYcSTc1Dh1o32TVVYw+AWa2e
         jN1FK1spq5/fnt7IgjkHKaTg+bvBnSP43Dx3kx63HadrBMegyYtTrq/qd/MPqtQbBaDk
         iUiG7ewyAP2xZrrlDCTbU7LOzS7Bx7PyOx7W+JUDuEAjE3WC9SlUZO2j45IRMav4MBWQ
         hmaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TUsBOWy5UhAp6xbtUsJklT0rm4uS/PjlVjvwS2k1vhM=;
        b=EEDvtoddYMADS0DZHwnEfr7q2famut0V2DeS3Zt03AxkDfObIPXaNDGPfVG2EDGFGo
         xoimfuAogMGr3bEhoUP10P8raymsLxwgYdU+GENUDVaW2Xi1Gqz7tgM2IeiV6czobiHp
         q0VkR+81a7D2k/vvYFICUhU+NYa8sq2zpbFdmG6CzvPwqL/w9qk/XWrPTIY3EtSq1oBh
         GtFhxNGzWGk5GSyXNO0TqXbow5q4UuCj7cLVLML35feM+OwFWwDREkPt3mGkeDkBNr8j
         FmGjhV+k/vy4nX2kI+ifZor4+ytUw8u47gnAPdY8A134CWi1LBC9nixL4GEyKqPY4L+7
         vQgA==
X-Gm-Message-State: AFqh2kpeFQKlWYCYmUL7sPa7QVgop3qT+NHwXu6NGbUcW9arBz4ueobS
        h7GzfMz6FYbumwbimnqIcB1z
X-Google-Smtp-Source: AMrXdXsA3fJe2SPgDEtu9fgDT3kXG4YnvJbnAd/7UZy+gQv4RJpihOeO7IzDYN13SQVotVY5fGaDQA==
X-Received: by 2002:a17:902:f0d1:b0:192:8c85:54fa with SMTP id v17-20020a170902f0d100b001928c8554famr14363437pla.31.1673755874753;
        Sat, 14 Jan 2023 20:11:14 -0800 (PST)
Received: from thinkpad ([220.158.159.143])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902714200b00178143a728esm16605379plm.275.2023.01.14.20.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jan 2023 20:11:13 -0800 (PST)
Date:   Sun, 15 Jan 2023 09:41:08 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: Define CMA region for CRD
 and X13s
Message-ID: <20230115041108.GC6568@thinkpad>
References: <20230113041025.4188910-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230113041025.4188910-1-quic_bjorande@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 08:10:25PM -0800, Bjorn Andersson wrote:
> Booting the CRD needs roughly 64MB CMA, rather than relying on people
> adding boot parameters etc define a region for this, to remove the
> allocation errors from e.g. NVME.
> 
> While fixing the CRD define the same region for the X13s.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  arch/arm64/boot/dts/qcom/sc8280xp-crd.dts                | 9 +++++++++
>  .../boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts      | 9 +++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> index b29c02307839..e30a37c73b90 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> @@ -128,6 +128,15 @@ vreg_wwan: regulator-wwan {
>  
>  		regulator-boot-on;
>  	};
> +
> +	reserved-memory {
> +		linux,cma {
> +			compatible = "shared-dma-pool";
> +			size = <0x0 0x8000000>;
> +			reusable;
> +			linux,cma-default;
> +		};
> +	};
>  };
>  
>  &apps_rsc {
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> index 78e61a8184c5..5bfd1f0b2a24 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> @@ -153,6 +153,15 @@ vreg_wwan: regulator-wwan {
>  		regulator-boot-on;
>  	};
>  
> +	reserved-memory {
> +		linux,cma {
> +			compatible = "shared-dma-pool";
> +			size = <0x0 0x8000000>;
> +			reusable;
> +			linux,cma-default;
> +		};
> +	};
> +
>  	thermal-zones {
>  		skin-temp-thermal {
>  			polling-delay-passive = <250>;
> -- 
> 2.37.3
> 

-- 
மணிவண்ணன் சதாசிவம்
