Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E876770951D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 12:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbjESKfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 06:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbjESKf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 06:35:29 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9581BD4
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 03:35:06 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3094871953bso1262624f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 03:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684492505; x=1687084505;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kgtk9QjAFcm8bGOS+Euv76czaSdooZrFQsFvOBEa6w8=;
        b=AsOgffUMUzEpsgw5DBeAgbvbHsLem6PXPnqIfe+Rh+tOi+kfnOksgYA1yjfJwxqAWD
         hLIkLw75CNsNBshpgwr/UcstQO5mDE86in1tJXb+1DnjKRiJf24EqhQ57otgMZn6Fyyu
         gDj9KVrbFxZZMkiQWQvxPdVBoj/gcxdxdSu8jUbMF61D9mtCVrgF2ZIHRCnJ7nyEVJzr
         zSmDCJ2K1J+tAsG8shWdQSEedSO/AfFe15yp8l50gWPGYNXWL8iJp1PPtxC112jUX2Cc
         kRIGjRsLtzAExQKXwVafT+QZL7vsXDiqgW2TkW4PEhtESEmj9sCCvbhTdtXwL8dO9bUZ
         VjvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684492505; x=1687084505;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kgtk9QjAFcm8bGOS+Euv76czaSdooZrFQsFvOBEa6w8=;
        b=cCHB9/B9SbN4fDM0OJa0yqgpLzkkNqUF7ZjxWjji4hwA8PvRwcBGoWoBiWXdZGVNEF
         Q1Bjn7LYP4Uhsy/X0n8xHWvt5JKQMhkhu97AcBthinpN57pUz9Rt4Etx5WQ5/FlcfwtD
         cpu/T5L97IcOeX4Kx/CzBuqf++olPv2dCCCh2GMAiwu8jGhHnK3xBNgidvYZTicfcbJ/
         t3s6yH3eJHl+L+vTXUs1kGTrLKEP52TBFNf/0XfyjG8/wa6x95PFyasF1Qiw7jRuBCs+
         I90a8eWGzn39UOfWSJrzE70iP3C9VNNb4ZTGg51qAuxR4YMmWek5+s5Y1K7kBFLIoANy
         dGRA==
X-Gm-Message-State: AC+VfDxVJxZvTZTJijfttlRnH/UjItjZANuw1DiyXWtLDgNu6nkx+drX
        1qa0v6E7K1ZpVvIJAnwsPu/iQxynbEVSUmzJpS9OPw==
X-Google-Smtp-Source: ACHHUZ5W3yDJ8lPgYu4QIOosFTi8qbzFRCKl8E+s0hkZ3PSKuO4Qjz8uZFNvx4I9sI7CuAIOAGLR11ZPmK72RwmgreI=
X-Received: by 2002:adf:d0cc:0:b0:309:46a4:6378 with SMTP id
 z12-20020adfd0cc000000b0030946a46378mr1407237wrh.12.1684492505006; Fri, 19
 May 2023 03:35:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230405072836.1690248-1-bhupesh.sharma@linaro.org>
 <20230405072836.1690248-10-bhupesh.sharma@linaro.org> <af22628c-e54b-f7e1-16a6-6534f4526cd5@linaro.org>
In-Reply-To: <af22628c-e54b-f7e1-16a6-6534f4526cd5@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Fri, 19 May 2023 16:04:53 +0530
Message-ID: <CAH=2NtyiQ5C9zSgZcHnvvXK42+g4+Ua4h1pcBCPCAtZhnpkyNg@mail.gmail.com>
Subject: Re: [PATCH v6 09/11] arm64: dts: qcom: sm8250: Add Crypto Engine support
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.linux@gmail.com, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org, neil.armstrong@linaro.org, djakov@kernel.org
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

On Thu, 6 Apr 2023 at 19:29, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> On 5.04.2023 09:28, Bhupesh Sharma wrote:
> > Add crypto engine (CE) and CE BAM related nodes and definitions to
> > 'sm8250.dtsi'.
> >
> > Co-developed-by and Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sm8250.dtsi | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> > index 7b78761f2041..2f6b8d4a2d41 100644
> > --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> > @@ -2222,6 +2222,28 @@ ufs_mem_phy_lanes: phy@1d87400 {
> >                       };
> >               };
> >
> > +             cryptobam: dma-controller@1dc4000 {
> > +                     compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
> > +                     reg = <0 0x01dc4000 0 0x24000>;
> > +                     interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
> > +                     #dma-cells = <1>;
> > +                     qcom,ee = <0>;
> > +                     qcom,controlled-remotely;
> > +                     iommus = <&apps_smmu 0x594 0x0011>,
> > +                              <&apps_smmu 0x596 0x0011>;
> > +             };
> > +
> > +             crypto: crypto@1dfa000 {
> > +                     compatible = "qcom,sm8250-qce", "qcom,sm8150-qce", "qcom,qce";
> > +                     reg = <0 0x01dfa000 0 0x6000>;
> > +                     dmas = <&cryptobam 4>, <&cryptobam 5>;
> > +                     dma-names = "rx", "tx";
> > +                     iommus = <&apps_smmu 0x594 0x0011>,
> > +                              <&apps_smmu 0x596 0x0011>;
> > +                     interconnects = <&aggre2_noc MASTER_CRYPTO_CORE_0 &mc_virt SLAVE_EBI_CH0>;
> > +                     interconnect-names = "memory";
> Shouldn't we also attach the contexts from qcom_cedev_ns_cb{}?

Sure, I have fixed this in v7. Will share it shortly.

Thanks.
